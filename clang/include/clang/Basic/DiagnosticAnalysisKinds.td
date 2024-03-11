//==--- DiagnosticAnalysisKinds.td - libanalysis diagnostics --------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

let Component = "Analysis" in {
def err_drv_bang_bad_gpu_arch : Error<"unsupported MLU gpu architecture: %0">;
def err_drv_no_bang_installation : Error<
  "cannot find BANG installation; provide its path via '--bang-path', or pass "
  "'-nocudainc' to build without BANG includes">;
def err_drv_no_bang_libdevice : Error<
  "cannot find libdevice for %0; provide path to different BANG installation "
  "via '--bang-path', or pass '-nobanglib' to build without linking with "
  "libdevice">;
def err_drv_sycl_missing_mlisa_arch : Error<
  "missing MLISA architecture for SYCL offloading; specify it with '-Xsycl-target-backend --offload-arch'">; 
}
