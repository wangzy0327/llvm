//===------- backend_traits_cnrt.hpp - Backend traits for CNRT ---*-C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines the specializations of the sycl::detail::interop,
// sycl::detail::BackendInput and sycl::detail::BackendReturn class templates
// for the CNRT backend but there is no sycl::detail::InteropFeatureSupportMap
// specialization for the CNRT backend.
//===----------------------------------------------------------------------===//

#pragma once

#include <sycl/accessor.hpp>
#include <sycl/context.hpp>
#include <sycl/detail/backend_traits.hpp>
#include <sycl/device.hpp>
#include <sycl/event.hpp>
#include <sycl/kernel_bundle.hpp>
#include <sycl/queue.hpp>

typedef int CNdev;
typedef struct CNcontext_st *CNcontext;
typedef struct CNqueue_st *CNqueue;
typedef struct CNnotifier_st *CNnotifier;
typedef struct CNmodule_st *CNmodule;

typedef unsigned int CNaddr;

namespace sycl {
__SYCL_INLINE_VER_NAMESPACE(_V1) {
namespace detail {

// TODO the interops for context, device, event, platform and program
// may be removed after removing the deprecated 'get_native()' methods
// from the corresponding classes. The interop<backend, queue> specialization
// is also used in the get_queue() method of the deprecated class
// interop_handler and also can be removed after API cleanup.
template <> struct interop<backend::ext_oneapi_cnrt, context> {
  using type = CNcontext;
};

template <> struct interop<backend::ext_oneapi_cnrt, device> {
  using type = CNdev;
};

template <> struct interop<backend::ext_oneapi_cnrt, event> {
  using type = CNnotifier;
};

template <> struct interop<backend::ext_oneapi_cnrt, queue> {
  using type = CNqueue;
};

// TODO the interops for accessor is used in the already deprecated class
// interop_handler and can be removed after API cleanup.
template <typename DataT, int Dimensions, access::mode AccessMode>
struct interop<backend::ext_oneapi_cnrt,
               accessor<DataT, Dimensions, AccessMode, access::target::device,
                        access::placeholder::false_t>> {
  using type = CNaddr;
};

template <typename DataT, int Dimensions, access::mode AccessMode>
struct interop<
    backend::ext_oneapi_cnrt,
    accessor<DataT, Dimensions, AccessMode, access::target::constant_buffer,
             access::placeholder::false_t>> {
  using type = CNaddr;
};

template <typename DataT, int Dimensions, typename AllocatorT>
struct BackendInput<backend::ext_oneapi_cnrt,
                    buffer<DataT, Dimensions, AllocatorT>> {
  using type = CNaddr;
};

template <typename DataT, int Dimensions, typename AllocatorT>
struct BackendReturn<backend::ext_oneapi_cnrt,
                     buffer<DataT, Dimensions, AllocatorT>> {
  using type = CNaddr;
};

template <> struct BackendInput<backend::ext_oneapi_cnrt, context> {
  using type = CNcontext;
};

template <> struct BackendReturn<backend::ext_oneapi_cnrt, context> {
  using type = CNcontext;
};

template <> struct BackendInput<backend::ext_oneapi_cnrt, device> {
  using type = CNdev;
};

template <> struct BackendReturn<backend::ext_oneapi_cnrt, device> {
  using type = CNdev;
};

template <> struct BackendInput<backend::ext_oneapi_cnrt, event> {
  using type = CNnotifier;
};

template <> struct BackendReturn<backend::ext_oneapi_cnrt, event> {
  using type = CNnotifier;
};

template <> struct BackendInput<backend::ext_oneapi_cnrt, queue> {
  using type = CNqueue;
};

template <> struct BackendReturn<backend::ext_oneapi_cnrt, queue> {
  using type = CNqueue;
};

} // namespace detail
} // __SYCL_INLINE_VER_NAMESPACE(_V1)
} // namespace sycl
