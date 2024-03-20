//===-- pi_cnrt.hpp - CNRT Plugin -----------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

/// \defgroup sycl_pi_cnrt CNRT Plugin
/// \ingroup sycl_pi

/// \file pi_cnrt.hpp
/// Declarations for CNRT Plugin. It is the interface between the
/// device-agnostic SYCL runtime layer and underlying CNRT runtime.
///
/// \ingroup sycl_pi_cnrt

#ifndef PI_CNRT_HPP
#define PI_CNRT_HPP


#include "CL/sycl/detail/pi.h"
#include <algorithm>
#include <array>
#include <atomic>
#include <cassert>
#include <cstring>
#include <cnrt.h>
#include <cn_api.h>
#include <functional>
#include <limits>
#include <memory>
#include <mutex>
#include <numeric>
#include <stdint.h>
#include <string>
#include <unordered_map>
#include <vector>

extern "C" {

/// \cond IGNORE_BLOCK_IN_DOXYGEN
pi_result cnrt_piContextRetain(pi_context);
pi_result cnrt_piContextRelease(pi_context);
pi_result cnrt_piDeviceRelease(pi_device);
pi_result cnrt_piDeviceRetain(pi_device);
pi_result cnrt_piProgramRetain(pi_program);
pi_result cnrt_piProgramRelease(pi_program);
pi_result cnrt_piQueueRelease(pi_queue);
pi_result cnrt_piQueueRetain(pi_queue);
pi_result cnrt_piMemRetain(pi_mem);
pi_result cnrt_piMemRelease(pi_mem);
pi_result cnrt_piKernelRetain(pi_kernel);
pi_result cnrt_piKernelRelease(pi_kernel);
/// \endcond
}

// using _pi_queue_guard = std::unique_lock<std::mutex>;

/// A PI platform stores all known PI devices,
///  in the CNRT plugin this is just a vector of
///  available devices since initialization is done
///  when devices are used.
///
struct _pi_platform {
  static CNnotifier evBase_; // CNRT event used as base counter
  std::vector<std::unique_ptr<_pi_device>> devices_;
};

/// PI device mapping to a CNdev.
/// Includes an observer pointer to the platform,
/// and implements the reference counting semantics since
/// CNRT objects are not refcounted.
///
struct _pi_device {
private:
  using native_type = CNdev;

  native_type cnDevice_;
  std::atomic_uint32_t refCount_;
  pi_platform platform_;

  static constexpr pi_uint32 max_work_item_dimensions = 3u;
  size_t max_work_item_sizes[max_work_item_dimensions];
  int max_work_group_size;

public:
  _pi_device(native_type cnDevice, pi_platform platform)
      : cnDevice_(cnDevice), refCount_{1}, platform_(platform) {}

  native_type get() const noexcept { return cnDevice_; };

  pi_uint32 get_reference_count() const noexcept { return refCount_; }

  pi_platform get_platform() const noexcept { return platform_; };

  void save_max_work_item_sizes(size_t size,
                                size_t *save_max_work_item_sizes) noexcept {
    memcpy(max_work_item_sizes, save_max_work_item_sizes, size);
  };

  void save_max_work_group_size(int value) noexcept {
    max_work_group_size = value;
  };

  void get_max_work_item_sizes(size_t ret_size,
                               size_t *ret_max_work_item_sizes) const noexcept {
    memcpy(ret_max_work_item_sizes, max_work_item_sizes, ret_size);
  };

  int get_max_work_group_size() const noexcept { return max_work_group_size; };
};

/// PI context mapping to a CNRT context object.
///
/// There is no direct mapping between a CNRT context and a PI context,
/// main differences described below:
///
/// <b> CNRT context vs PI context </b>
///
/// One of the main differences between the PI API and the CNRT driver API is
/// that the second modifies the state of the threads by assigning
/// `CNcontext` objects to threads. `CNcontext` objects store data associated
/// with a given device and control access to said device from the user side.
/// PI API context are objects that are passed to functions, and not bound
/// to threads.
/// The _pi_context object doesn't implement this behavior, only holds the
/// CNRT context data. The RAII object \ref ScopedContext implements the active
/// context behavior.
///
/// <b> Primary vs User-defined context </b>
///
/// CNRT has two different types of context, the Primary context,
/// which is usable by all threads on a given process for a given device, and
/// the aforementioned custom contexts.
/// CNRT documentation, and performance analysis, indicates it is recommended
/// to use Primary context whenever possible.
/// Primary context is used as well by the CNRT Runtime API.
/// For PI applications to interop with CNRT Runtime API, they have to use
/// the primary context - and make that active in the thread.
/// The `_pi_context` object can be constructed with a `kind` parameter
/// that allows to construct a Primary or `user-defined` context, so that
/// the PI object interface is always the same.
///
///  <b> Destructor callback </b>
///
///  Required to implement CP023, SYCL Extended Context Destruction,
///  the PI Context can store a number of callback functions that will be
///  called upon destruction of the PI Context.
///  See proposal for details.
///
struct _pi_context {

  struct deleter_data {
    pi_context_extended_deleter function;
    void *user_data;

    void operator()() { function(user_data); }
  };

  using native_type = CNcontext;

  enum class kind { primary, user_defined } kind_;
  native_type cnContext_;
  _pi_device *deviceId_;
  std::atomic_uint32_t refCount_;

  _pi_context(kind k, CNcontext ctxt, _pi_device *devId,
              bool backend_owns = true)
      : kind_{k}, cnContext_{ctxt}, deviceId_{devId}, refCount_{1},
        has_ownership{backend_owns} {
    cnrt_piDeviceRetain(deviceId_);
  };

  ~_pi_context() { cnrt_piDeviceRelease(deviceId_); }

  void invoke_extended_deleters() {
    std::lock_guard<std::mutex> guard(mutex_);
    for (auto &deleter : extended_deleters_) {
      deleter();
    }
  }

  void set_extended_deleter(pi_context_extended_deleter function,
                            void *user_data) {
    std::lock_guard<std::mutex> guard(mutex_);
    extended_deleters_.emplace_back(deleter_data{function, user_data});
  }

  pi_device get_device() const noexcept { return deviceId_; }

  native_type get() const noexcept { return cnContext_; }

  bool is_primary() const noexcept { return kind_ == kind::primary; }

  pi_uint32 increment_reference_count() noexcept { return ++refCount_; }

  pi_uint32 decrement_reference_count() noexcept { return --refCount_; }

  pi_uint32 get_reference_count() const noexcept { return refCount_; }

  bool backend_has_ownership() const noexcept { return has_ownership; }

private:
  std::mutex mutex_;
  std::vector<deleter_data> extended_deleters_;
  const bool has_ownership;
};

/// PI Mem mapping to CNRT memory allocations, both data and texture/surface.
/// \brief Represents non-SVM allocations on the CNRT backend.
/// Keeps tracks of all mapped regions used for Map/Unmap calls.
/// Only one region can be active at the same time per allocation.
struct _pi_mem {

  // TODO: Move as much shared data up as possible
  using pi_context = _pi_context *;

  // Context where the memory object is accessibles
  pi_context context_;

  /// Reference counting of the handler
  std::atomic_uint32_t refCount_;
  enum class mem_type { buffer, surface } mem_type_;

  /// A PI Memory object represents either plain memory allocations ("Buffers"
  /// in OpenCL) or typed allocations ("Images" in OpenCL).
  /// In CNRT their API handlers are different. Whereas "Buffers" are allocated
  /// as pointer-like structs, "Images" are stored in Textures or Surfaces
  /// This union allows implementation to use either from the same handler.
  union mem_ {
    // Handler for plain, pointer-based CNRT allocations
    struct buffer_mem_ {
      using native_type = CNaddr;

      // If this allocation is a sub-buffer (i.e., a view on an existing
      // allocation), this is the pointer to the parent handler structure
      pi_mem parent_;
      // CNRT handler for the pointer
      native_type ptr_;

      /// Pointer associated with this device on the host
      void *hostPtr_;
      /// Size of the allocation in bytes
      size_t size_;
      /// Offset of the active mapped region.
      size_t mapOffset_;
      /// Pointer to the active mapped region, if any
      void *mapPtr_;
      /// Original flags for the mapped region
      pi_map_flags mapFlags_;

      /** alloc_mode
       * classic: Just a normal buffer allocated on the device via cnrt malloc
       * use_host_ptr: Use an address on the host for the device
       * copy_in: The data for the device comes from the host but the host
       pointer is not available later for re-use
       * alloc_host_ptr: Uses pinned-memory allocation
      */
      enum class alloc_mode {
        classic,
        use_host_ptr,
        copy_in,
        alloc_host_ptr
      } allocMode_;

      native_type get() const noexcept { return ptr_; }

      size_t get_size() const noexcept { return size_; }

      void *get_map_ptr() const noexcept { return mapPtr_; }

      size_t get_map_offset(void *) const noexcept { return mapOffset_; }

      /// Returns a pointer to data visible on the host that contains
      /// the data on the device associated with this allocation.
      /// The offset is used to index into the CNRT allocation.
      ///
      void *map_to_ptr(size_t offset, pi_map_flags flags) noexcept {
        assert(mapPtr_ == nullptr);
        mapOffset_ = offset;
        mapFlags_ = flags;
        if (hostPtr_) {
          mapPtr_ = static_cast<char *>(hostPtr_) + offset;
        } else {
          // TODO: Allocate only what is needed based on the offset
          mapPtr_ = static_cast<void *>(malloc(this->get_size()));
        }
        return mapPtr_;
      }

      /// Detach the allocation from the host memory.
      void unmap(void *) noexcept {
        assert(mapPtr_ != nullptr);

        if (mapPtr_ != hostPtr_) {
          free(mapPtr_);
        }
        mapPtr_ = nullptr;
        mapOffset_ = 0;
      }

      pi_map_flags get_map_flags() const noexcept {
        assert(mapPtr_ != nullptr);
        return mapFlags_;
      }
    } buffer_mem_;

    // Handler data for surface object (i.e. Images)
    // struct surface_mem_ {
    //   CUarray array_;
    //   CUsurfObject surfObj_;
    //   pi_mem_type imageType_;

    //   CUarray get_array() const noexcept { return array_; }

    //   CUsurfObject get_surface() const noexcept { return surfObj_; }

    //   pi_mem_type get_image_type() const noexcept { return imageType_; }
    // } surface_mem_;
  } mem_;

  /// Constructs the PI MEM handler for a non-typed allocation ("buffer")
  _pi_mem(pi_context ctxt, pi_mem parent, mem_::buffer_mem_::alloc_mode mode,
          CNaddr ptr, void *host_ptr, size_t size)
      : context_{ctxt}, refCount_{1}, mem_type_{mem_type::buffer} {
    mem_.buffer_mem_.ptr_ = ptr;
    mem_.buffer_mem_.parent_ = parent;
    mem_.buffer_mem_.hostPtr_ = host_ptr;
    mem_.buffer_mem_.size_ = size;
    mem_.buffer_mem_.mapOffset_ = 0;
    mem_.buffer_mem_.mapPtr_ = nullptr;
    mem_.buffer_mem_.mapFlags_ = PI_MAP_WRITE;
    mem_.buffer_mem_.allocMode_ = mode;
    if (is_sub_buffer()) {
      cnrt_piMemRetain(mem_.buffer_mem_.parent_);
    } else {
      cnrt_piContextRetain(context_);
    }
  };

  /// Constructs the PI allocation for an Image object (surface in CNRT)
//   _pi_mem(pi_context ctxt, CUarray array, CUsurfObject surf,
//           pi_mem_type image_type, void *host_ptr)
//       : context_{ctxt}, refCount_{1}, mem_type_{mem_type::surface} {
//     // Ignore unused parameter
//     (void)host_ptr;

//     mem_.surface_mem_.array_ = array;
//     mem_.surface_mem_.surfObj_ = surf;
//     mem_.surface_mem_.imageType_ = image_type;
//     cnrt_piContextRetain(context_);
//   }

  ~_pi_mem() {
    if (mem_type_ == mem_type::buffer) {
      if (is_sub_buffer()) {
        cnrt_piMemRelease(mem_.buffer_mem_.parent_);
        return;
      }
    }
    cnrt_piContextRelease(context_);
  }

  // TODO: Move as many shared funcs up as possible
  bool is_buffer() const noexcept { return mem_type_ == mem_type::buffer; }

  bool is_sub_buffer() const noexcept {
    return (is_buffer() && (mem_.buffer_mem_.parent_ != nullptr));
  }

  bool is_image() const noexcept { return mem_type_ == mem_type::surface; }

  pi_context get_context() const noexcept { return context_; }

  pi_uint32 increment_reference_count() noexcept { return ++refCount_; }

  pi_uint32 decrement_reference_count() noexcept { return --refCount_; }

  pi_uint32 get_reference_count() const noexcept { return refCount_; }
};

/// PI queue mapping on to CNqueue objects.
///
struct _pi_queue {
  using native_type = CNqueue;
  static constexpr int default_num_compute_queues = 128;
  static constexpr int default_num_transfer_queues = 64;
  std::vector<native_type> compute_queues_;
  std::vector<native_type> transfer_queues_;
  // delay_compute_ keeps track of which queues have been recently reused and
  // their next use should be delayed. If a queue has been recently reused it
  // will be skipped the next time it would be selected round-robin style. When
  // skipped, its delay flag is cleared.
  // keep track of which queues have applied barrier
  _pi_context *context_;
  _pi_device *device_;
  pi_queue_properties properties_;
  std::atomic_uint32_t refCount_;
  std::atomic_uint32_t eventCount_;
  std::atomic_uint32_t compute_queue_idx_;
  std::atomic_uint32_t transfer_queue_idx_;
  unsigned int num_compute_queues_;
  unsigned int num_transfer_queues_;
  unsigned int last_sync_compute_queues_;
  unsigned int last_sync_transfer_queues_;
  unsigned int flags_;
  std::mutex compute_queue_mutex_;
  std::mutex transfer_queue_mutex_;
  // When compute_queue_sync_mutex_ and compute_queue_mutex_ both need to be
  // locked at the same time, compute_queue_sync_mutex_ should be locked first
  // to avoid deadlocks

  _pi_queue(std::vector<CNqueue> &&compute_queues,
            std::vector<CNqueue> &&transfer_queues,_pi_context *context,
            _pi_device *device, pi_queue_properties properties,
            unsigned int flags)
      : compute_queues_{std::move(compute_queues)},
        transfer_queues_{std::move(transfer_queues)}, context_{context},
        device_{device}, properties_{properties}, refCount_{1}, eventCount_{0},
        compute_queue_idx_{0}, transfer_queue_idx_{0},
        num_compute_queues_{0}, num_transfer_queues_{0},
        last_sync_compute_queues_{0}, last_sync_transfer_queues_{0},
        flags_(flags) {
    cnrt_piContextRetain(context_);
    cnrt_piDeviceRetain(device_);
  }

  ~_pi_queue() {
    cnrt_piContextRelease(context_);
    cnrt_piDeviceRelease(device_);
  }

  // get_next_compute/transfer_queue() functions return queues from
  // appropriate pools in round-robin fashion
  native_type get_next_compute_queue();
  native_type get_next_transfer_queue();
  native_type get() { return get_next_compute_queue(); };

  template <typename T> void for_each_queue(T &&f) {
    {
      std::lock_guard<std::mutex> compute_guard(compute_queue_mutex_);
      unsigned int end =
          std::min(static_cast<unsigned int>(compute_queues_.size()),
                   num_compute_queues_);
      for (unsigned int i = 0; i < end; i++) {
        f(compute_queues_[i]);
      }
    }
    {
      std::lock_guard<std::mutex> transfer_guard(transfer_queue_mutex_);
      unsigned int end =
          std::min(static_cast<unsigned int>(transfer_queues_.size()),
                   num_transfer_queues_);
      for (unsigned int i = 0; i < end; i++) {
        f(transfer_queues_[i]);
      }
    }
  }

  template <typename T> void sync_queues(T &&f) {
    auto sync = [&f](const std::vector<CNqueue> &queues, unsigned int start,
                     unsigned int stop) {
      for (unsigned int i = start; i < stop; i++) {
        f(queues[i]);
      }
    };
    {
      unsigned int size = static_cast<unsigned int>(compute_queues_.size());
      std::lock_guard<std::mutex> compute_guard(compute_queue_mutex_);
      unsigned int start = last_sync_compute_queues_;
      unsigned int end = num_compute_queues_ < size
                             ? num_compute_queues_
                             : compute_queue_idx_.load();
      last_sync_compute_queues_ = end;
      if (end - start >= size) {
        sync(compute_queues_, 0, size);
      } else {
        start %= size;
        end %= size;
        if (start < end) {
          sync(compute_queues_, start, end);
        } else {
          sync(compute_queues_, start, size);
          sync(compute_queues_, 0, end);
        }
      }
    }
    {
      unsigned int size = static_cast<unsigned int>(transfer_queues_.size());
      if (size > 0) {
        std::lock_guard<std::mutex> transfer_guard(transfer_queue_mutex_);
        unsigned int start = last_sync_transfer_queues_;
        unsigned int end = num_transfer_queues_ < size
                               ? num_transfer_queues_
                               : transfer_queue_idx_.load();
        last_sync_transfer_queues_ = end;
        if (end - start >= size) {
          sync(transfer_queues_, 0, size);
        } else {
          start %= size;
          end %= size;
          if (start < end) {
            sync(transfer_queues_, start, end);
          } else {
            sync(transfer_queues_, start, size);
            sync(transfer_queues_, 0, end);
          }
        }
      }
    }
  }

  _pi_context *get_context() const { return context_; };

  _pi_device *get_device() const { return device_; };

  pi_uint32 increment_reference_count() noexcept { return ++refCount_; }

  pi_uint32 decrement_reference_count() noexcept { return --refCount_; }

  pi_uint32 get_reference_count() const noexcept { return refCount_; }

  pi_uint32 get_next_event_id() noexcept { return ++eventCount_; }

};

typedef void (*pfn_notify)(pi_event event, pi_int32 eventCommandStatus,
                           void *userData);
/// PI Event mapping to CNnotifier
///
struct _pi_event {
public:
  using native_type = CNnotifier;

  pi_result record();

  pi_result wait();

  pi_result start();

  native_type get() const noexcept { return evEnd_; };

  pi_queue get_queue() const noexcept { return queue_; }

  CNqueue get_native_queue() const noexcept { return native_queue_; }

  pi_uint32 get_compute_queue_token() const noexcept { return queueToken_; }

  pi_command_type get_command_type() const noexcept { return commandType_; }

  pi_uint32 get_reference_count() const noexcept { return refCount_; }

  bool is_recorded() const noexcept { return isRecorded_; }

  bool is_started() const noexcept { return isStarted_; }

  bool is_completed() const noexcept;

  pi_int32 get_execution_status() const noexcept {

    if (!is_recorded()) {
      return PI_EVENT_SUBMITTED;
    }

    if (!is_completed()) {
      return PI_EVENT_RUNNING;
    }
    return PI_EVENT_COMPLETE;
  }

  pi_context get_context() const noexcept { return context_; };

  pi_uint32 increment_reference_count() { return ++refCount_; }

  pi_uint32 decrement_reference_count() { return --refCount_; }

  pi_uint32 get_event_id() const noexcept { return eventId_; }

  bool backend_has_ownership() const noexcept { return has_ownership_; }

  // Returns the counter time when the associated command(s) were enqueued
  //
  pi_uint64 get_queued_time() const;

  // Returns the counter time when the associated command(s) started execution
  //
  pi_uint64 get_start_time() const;

  // Returns the counter time when the associated command(s) completed
  //
  pi_uint64 get_end_time() const;

  // construct a native CNRT. This maps closely to the underlying CNRT event.
  static pi_event
  make_native(pi_command_type type, pi_queue queue) {
    return new _pi_event(type, queue->get_context(), queue);
  }

  static pi_event make_with_native(pi_context context, CNnotifier eventNative) {
    return new _pi_event(context, eventNative);
  }

  pi_result release();

  ~_pi_event();

private:
  // This constructor is private to force programmers to use the make_native /
  // make_user static members in order to create a pi_event for CNRT.
  _pi_event(pi_command_type type, pi_context context, pi_queue queue);

  // This constructor is private to force programmers to use the
  // make_with_native for event introp
  _pi_event(pi_context context, CNnotifier eventNative);

  pi_command_type commandType_; // The type of command associated with event.

  std::atomic_uint32_t refCount_; // Event reference count.

  bool has_ownership_; // Signifies if event owns the native type.

  bool hasBeenWaitedOn_; // Signifies whether the event has been waited
                         // on through a call to wait(), which implies
                         // that it has completed.

  bool isRecorded_; // Signifies wether a native CNRT event has been recorded
                    // yet.
  bool isStarted_;  // Signifies wether the operation associated with the
                    // PI event has started or not
                    //

  pi_uint32 queueToken_;
  pi_uint32 eventId_; // Queue identifier of the event.

  native_type evEnd_; // CNRT event handle. If this _pi_event represents a user
                      // event, this will be nullptr.

  native_type evStart_; // CNRT event handle associated with the start

  native_type evQueued_; // CNRT event handle associated with the time
                         // the command was enqueued
  pi_queue queue_;

  CNqueue native_queue_; // pi_queue associated with the event. If this is a user
                   // event, this will be nullptr.

  pi_context context_; // pi_context associated with the event. If this is a
                       // native event, this will be the same context associated
                       // with the queue_ member.
};

/// Implementation of PI Program on CNRT Module object
///
struct _pi_program {
  using native_type = CNmodule;
  native_type module_;
  const char *binary_;
  size_t binarySizeInBytes_;
  std::atomic_uint32_t refCount_;
  _pi_context *context_;

  // Metadata
  std::unordered_map<std::string, std::tuple<uint32_t, uint32_t, uint32_t>>
      kernelReqdWorkGroupSizeMD_;

  constexpr static size_t MAX_LOG_SIZE = 8192u;

  char errorLog_[MAX_LOG_SIZE], infoLog_[MAX_LOG_SIZE];
  std::string buildOptions_;
  pi_program_build_status buildStatus_ = PI_PROGRAM_BUILD_STATUS_NONE;

  _pi_program(pi_context ctxt);
  ~_pi_program();

  pi_result set_metadata(const pi_device_binary_property *metadata,
                         size_t length);

  pi_result set_binary(const char *binary, size_t binarySizeInBytes);

  pi_result build_program(const char *build_options);

  pi_context get_context() const { return context_; };

  native_type get() const noexcept { return module_; };

  pi_uint32 increment_reference_count() noexcept { return ++refCount_; }

  pi_uint32 decrement_reference_count() noexcept { return --refCount_; }

  pi_uint32 get_reference_count() const noexcept { return refCount_; }
};

/// Implementation of a PI Kernel for CNRT
///
/// PI Kernels are used to set kernel arguments,
/// creating a state on the Kernel object for a given
/// invocation. This is not the case of CUFunction objects,
/// which are simply passed together with the arguments on the invocation.
/// The PI Kernel implementation for CNRT stores the list of arguments,
/// argument sizes and offsets to emulate the interface of PI Kernel,
/// saving the arguments for the later dispatch.
/// Note that in PI API, the Local memory is specified as a size per
/// individual argument, but in CNRT only the total usage of shared
/// memory is required since it is not passed as a parameter.
/// A compiler pass converts the PI API local memory model into the
/// CNRT shared model. This object simply calculates the total of
/// shared memory, and the initial offsets of each parameter.
///
struct _pi_kernel {
  using native_type = CNkernel;

  native_type function_;
  native_type functionWithOffsetParam_;
  std::string name_;
  pi_context context_;
  pi_program program_;
  std::atomic_uint32_t refCount_;
  CNaddr *kernel_params_;

  static constexpr pi_uint32 REQD_THREADS_PER_BLOCK_DIMENSIONS = 3u;
  size_t reqdThreadsPerBlock_[REQD_THREADS_PER_BLOCK_DIMENSIONS];

  /// Structure that holds the arguments to the kernel.
  /// Note earch argument size is known, since it comes
  /// from the kernel signature.
  /// This is not something can be queried from the CNRT API
  /// so there is a hard-coded size (\ref MAX_PARAM_BYTES)
  /// and a storage.
  ///
  struct arguments {
    static constexpr size_t MAX_PARAM_BYTES = 4000u;
    using args_t = std::array<char, MAX_PARAM_BYTES>;
    using args_size_t = std::vector<size_t>;
    using args_index_t = std::vector<void *>;
    args_t storage_;
    args_size_t paramSizes_;
    args_index_t indices_;
    args_size_t offsetPerIndex_;

    std::uint32_t implicitOffsetArgs_[3] = {0, 0, 0};

    arguments() {
      // Place the implicit offset index at the end of the indicies collection
      indices_.emplace_back(&implicitOffsetArgs_);
    }

    /// Adds an argument to the kernel.
    /// If the argument existed before, it is replaced.
    /// Otherwise, it is added.
    /// Gaps are filled with empty arguments.
    /// Implicit offset argument is kept at the back of the indices collection.
    void add_arg(size_t index, size_t size, const void *arg,
                 size_t localSize = 0) {
      if (index + 2 > indices_.size()) {
        // Move implicit offset argument index with the end
        indices_.resize(index + 2, indices_.back());
        // Ensure enough space for the new argument
        paramSizes_.resize(index + 1);
        offsetPerIndex_.resize(index + 1);
      }
      paramSizes_[index] = size;
      // calculate the insertion point on the array
      size_t insertPos = std::accumulate(std::begin(paramSizes_),
                                         std::begin(paramSizes_) + index, 0);
      // Update the stored value for the argument
      std::memcpy(&storage_[insertPos], arg, size);
      indices_[index] = &storage_[insertPos];
      offsetPerIndex_[index] = localSize;
    }

    void add_local_arg(size_t index, size_t size) {
      size_t localOffset = this->get_local_size();

      // maximum required alignment is the size of the largest vector type
      const size_t max_alignment = sizeof(double) * 16;

      // for arguments smaller than the maximum alignment simply align to the
      // size of the argument
      const size_t alignment = std::min(max_alignment, size);

      // align the argument
      size_t alignedLocalOffset = localOffset;
      if (localOffset % alignment != 0) {
        alignedLocalOffset += alignment - (localOffset % alignment);
      }

      add_arg(index, sizeof(size_t), (const void *)&(alignedLocalOffset),
              size + (alignedLocalOffset - localOffset));
    }

    void set_implicit_offset(size_t size, std::uint32_t *implicitOffset) {
      assert(size == sizeof(std::uint32_t) * 3);
      std::memcpy(implicitOffsetArgs_, implicitOffset, size);
    }

    void clear_local_size() {
      std::fill(std::begin(offsetPerIndex_), std::end(offsetPerIndex_), 0);
    }

    const args_index_t &get_indices() const noexcept { return indices_; }

    pi_uint32 get_local_size() const {
      return std::accumulate(std::begin(offsetPerIndex_),
                             std::end(offsetPerIndex_), 0);
    }
  } args_;

  _pi_kernel(CNkernel func, CNkernel funcWithOffsetParam, const char *name,
             pi_program program, pi_context ctxt)
      : function_{func}, functionWithOffsetParam_{funcWithOffsetParam},
        name_{name}, context_{ctxt}, program_{program}, refCount_{1},
        kernel_params_{nullptr} {
    cnrt_piProgramRetain(program_);
    cnrt_piContextRetain(context_);
    /// Note: this code assumes that there is only one device per context
    // pi_result retError = cnrt_piKernelGetGroupInfo(
    //     this, ctxt->get_device(), PI_KERNEL_GROUP_INFO_COMPILE_WORK_GROUP_SIZE,
    //     sizeof(reqdThreadsPerBlock_), reqdThreadsPerBlock_, nullptr);
    // (void)retError;
    // assert(retError == PI_SUCCESS);
  }

  ~_pi_kernel() {
    cnrt_piProgramRelease(program_);
    cnrt_piContextRelease(context_);
  }

  pi_program get_program() const noexcept { return program_; }

  pi_uint32 increment_reference_count() noexcept { return ++refCount_; }

  pi_uint32 decrement_reference_count() noexcept { return --refCount_; }

  pi_uint32 get_reference_count() const noexcept { return refCount_; }

  native_type get() const noexcept { return function_; };

  native_type get_with_offset_parameter() const noexcept {
    return functionWithOffsetParam_;
  };

  bool has_with_offset_parameter() const noexcept {
    return functionWithOffsetParam_ != nullptr;
  }

  pi_context get_context() const noexcept { return context_; };

  const char *get_name() const noexcept { return name_.c_str(); }

  /// Returns the number of arguments, excluding the implicit global offset.
  /// Note this only returns the current known number of arguments, not the
  /// real one required by the kernel, since this cannot be queried from
  /// the CNRT Driver API
  pi_uint32 get_num_args() const noexcept { return args_.indices_.size() - 1; }

  void set_kernel_arg(int index, size_t size, const void *arg) {
    args_.add_arg(index, size, arg);
  }

  void set_kernel_local_arg(int index, size_t size) {
    args_.add_local_arg(index, size);
  }

  void set_implicit_offset_arg(size_t size, std::uint32_t *implicitOffset) {
    args_.set_implicit_offset(size, implicitOffset);
  }

  const arguments::args_index_t &get_arg_indices() const {
    return args_.get_indices();
  }

  void create_kernel_params() {
    kernel_params_ = (CNaddr *)malloc(get_num_args() * sizeof(CNaddr));
    auto argIndices = get_arg_indices();
    const pi_uint32 MemStep = 4;
    for (pi_uint32 i = 0; i < get_num_args(); i++) {
      if (i % MemStep == 0) {
        kernel_params_[i] = *(CNaddr *)(argIndices[i]);
      } else {
        kernel_params_[i] = *(int *)(argIndices[i]);
      }
      //std::cout<<"arg: "<<kernel_params_[i]<<std::endl;
    }
  }

  CNaddr *get_kernel_params() {
    if (kernel_params_ == nullptr) {
      create_kernel_params();
    }
    return kernel_params_;
  }

  void free_kernel_params() {
    assert(kernel_params_ != nullptr);
    free(kernel_params_);
    kernel_params_ = nullptr;
  }

  pi_uint32 get_local_size() const noexcept { return args_.get_local_size(); }

  void clear_local_size() { args_.clear_local_size(); }
};

/// Implementation of samplers for CNRT
///
/// Sampler property layout:
/// | 31 30 ... 6 5 |      4 3 2      |     1      |         0        |
/// |      N/A      | addressing mode | fiter mode | normalize coords |
struct _pi_sampler {
  std::atomic_uint32_t refCount_;
  pi_uint32 props_;
  pi_context context_;

  _pi_sampler(pi_context context)
      : refCount_(1), props_(0), context_(context) {}

  pi_uint32 increment_reference_count() noexcept { return ++refCount_; }

  pi_uint32 decrement_reference_count() noexcept { return --refCount_; }

  pi_uint32 get_reference_count() const noexcept { return refCount_; }
};

// -------------------------------------------------------------
// Helper types and functions
//

#endif // PI_CNRT_HPP
