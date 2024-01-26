//===--- MLISA.h - Declare MLISA target feature support ---------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file declares MLISA TargetInfo objects.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_CLANG_LIB_BASIC_TARGETS_MLISA_H
#define LLVM_CLANG_LIB_BASIC_TARGETS_MLISA_H

#include "clang/Basic/Bang.h"
#include "clang/Basic/Cuda.h"
#include "clang/Basic/TargetInfo.h"
#include "clang/Basic/TargetOptions.h"
#include "llvm/ADT/Triple.h"
#include "llvm/Support/Compiler.h"

namespace clang {
namespace targets {

static const unsigned MLISAAddrSpaceMap[] = {
    0, // Default
    1, // opencl_global
    3, // opencl_local
    4, // opencl_constant
    0, // opencl_private
    // FIXME: generic has to be added to the target
    0, // opencl_generic
    1, // opencl_global_device
    1, // opencl_global_host
    1, // bang_device
    4, // bang_constant
    3, // bang_shared
    1, // sycl_global
    1, // sycl_global_device
    1, // sycl_global_host
    101, // sycl_local
    102, //sycl_wram
    0, // sycl_private
    0, // ptr32_sptr
    0, // ptr32_uptr
    0  // ptr64
};

/// The DWARF address class. Taken from
/// https://docs.nvidia.com/bang/archive/10.0/ptx-writers-guide-to-interoperability/index.html#bang-specific-dwarf
static const int MLISADWARFAddrSpaceMap[] = {
    -1, // Default, opencl_private or opencl_generic - not defined
    5,  // opencl_global
    -1,
    8,  // opencl_local or bang_shared
    4,  // opencl_constant or bang_constant
};

class MLISATargetInfo : public TargetInfo {
  static const char *const GCCRegNames[];
  static const Builtin::Info BuiltinInfo[];
  CudaArch MLU;
  std::unique_ptr<TargetInfo> HostTarget;

public:
  MLISATargetInfo(const llvm::Triple &Triple, const TargetOptions &Opts,
                  unsigned TargetPointerWidth);

  void getTargetDefines(const LangOptions &Opts,
                        MacroBuilder &Builder) const override;

  

  ArrayRef<Builtin::Info> getTargetBuiltins() const override;

  bool
  initFeatureMap(llvm::StringMap<bool> &Features, DiagnosticsEngine &Diags,
                 StringRef CPU,
                 const std::vector<std::string> &FeaturesVec) const override;

  // Target feature map see: llvm/lib/Target/MLISA/MLISA.td
  bool hasFeature(StringRef Feature) const override;

  // bool hasExtIntType() const { return true; }

  ArrayRef<const char *> getGCCRegNames() const override;
  ArrayRef<TargetInfo::GCCRegAlias> getGCCRegAliases() const override {
    // No aliases.
    return None;
  }

  bool validateAsmConstraint(const char *&Name,
                             TargetInfo::ConstraintInfo &Info) const override {
    switch (*Name) {
    default:
      return false;
    case 'c':
    case 'h':
    case 'r':
    case 'l':
    case 'f':
    case 'd':
      Info.setAllowsRegister();
      return true;
    }
  }
  
  const char *getClobbers() const override {
    // FIXME: Is this really right?
    return "";
  }
  
  BuiltinVaListKind getBuiltinVaListKind() const override {
    // FIXME: implement
    return TargetInfo::CharPtrBuiltinVaList;
  }

  bool isValidCPUName(StringRef Name) const override {
    return StringToCudaArch(Name) != CudaArch::UNKNOWN;
  }

  bool setCPU(const std::string &Name) override {
    MLU = StringToCudaArch(Name.c_str());
    return MLU != CudaArch::UNKNOWN;
  }

  void setSupportedOpenCLOpts() override {
    auto &Opts = getSupportedOpenCLOpts();
    Opts["cl_clang_storage_class_specifiers"] = true;
    Opts["cl_khr_gl_sharing"] = true;
    Opts["cl_khr_icd"] = true;

    Opts["cl_khr_fp64"] = true;
    Opts["cl_khr_byte_addressable_store"] = true;
    Opts["cl_khr_global_int32_base_atomics"] = true;
    Opts["cl_khr_global_int32_extended_atomics"] = true;
    Opts["cl_khr_local_int32_base_atomics"] = true;
    Opts["cl_khr_local_int32_extended_atomics"] = true;
  }

  CallingConvCheckResult checkCallingConvention(CallingConv CC) const override {
    // BANG compilations support all of the host's calling conventions.
    //
    // TODO: We should warn if you apply a non-default CC to anything other than
    // a host function.
    if (HostTarget)
      return HostTarget->checkCallingConvention(CC);
    return CCCR_Warning;
  }

};

} // namespace targets
} // namespace clang
#endif // LLVM_CLANG_LIB_BASIC_TARGETS_MLISA_H
