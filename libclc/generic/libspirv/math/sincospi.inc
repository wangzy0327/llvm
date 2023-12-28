//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#define __CLC_DECLARE_SINCOSPI(ADDRSPACE, TYPE) \
  _CLC_OVERLOAD _CLC_DEF TYPE __spirv_ocl_sincospi (TYPE x, ADDRSPACE TYPE * cosval) { \
    *cosval = __spirv_ocl_cospi(x); \
    return __spirv_ocl_sinpi(x); \
  }

__CLC_DECLARE_SINCOSPI(global, __CLC_GENTYPE)
__CLC_DECLARE_SINCOSPI(local, __CLC_GENTYPE)
__CLC_DECLARE_SINCOSPI(private, __CLC_GENTYPE)

#undef __CLC_DECLARE_SINCOSPI
