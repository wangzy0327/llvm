//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include <spirv/spirv.h>

#include "../../include/libdevice.h"
#include <clcmacro.h>

#define __CLC_SINCOSPI_IMPL(ADDRSPACE, BUILTIN, FP_TYPE, ARG_TYPE)               \
  _CLC_OVERLOAD _CLC_DEF ARG_TYPE __spirv_ocl_sincospi(                          \
      ARG_TYPE x, ADDRSPACE ARG_TYPE *cosval_ptr) {                            \
    FP_TYPE sinval;                                                            \
    FP_TYPE cosval;                                                            \
    BUILTIN(x, &sinval, &cosval);                                              \
    *cosval_ptr = cosval;                                                      \
    return sinval;                                                             \
  }

#define __CLC_SINCOSPI(BUILTIN, FP_TYPE, ARG_TYPE)                               \
  __CLC_SINCOSPI_IMPL(global, BUILTIN, FP_TYPE, ARG_TYPE)                        \
  __CLC_SINCOSPI_IMPL(local, BUILTIN, FP_TYPE, ARG_TYPE)                         \
  __CLC_SINCOSPI_IMPL(private, BUILTIN, FP_TYPE, ARG_TYPE)

__CLC_SINCOSPI(__nv_sincospif, float, float)

_CLC_V_V_VP_VECTORIZE(_CLC_OVERLOAD _CLC_DEF, float, __spirv_ocl_sincospi, float,
                      private, float)
_CLC_V_V_VP_VECTORIZE(_CLC_OVERLOAD _CLC_DEF, float, __spirv_ocl_sincospi, float,
                      local, float)
_CLC_V_V_VP_VECTORIZE(_CLC_OVERLOAD _CLC_DEF, float, __spirv_ocl_sincospi, float,
                      global, float)

#ifdef cl_khr_fp64
__CLC_SINCOS(__nv_sincospi, double, double)

_CLC_V_V_VP_VECTORIZE(_CLC_OVERLOAD _CLC_DEF, double, __spirv_ocl_sincospi,
                      double, private, double)
_CLC_V_V_VP_VECTORIZE(_CLC_OVERLOAD _CLC_DEF, double, __spirv_ocl_sincospi,
                      double, local, double)
_CLC_V_V_VP_VECTORIZE(_CLC_OVERLOAD _CLC_DEF, double, __spirv_ocl_sincospi,
                      double, global, double)
#endif

#ifdef cl_khr_fp16
__CLC_SINCOS(__nv_sincospif, half, half)

_CLC_V_V_VP_VECTORIZE(_CLC_OVERLOAD _CLC_DEF, half, __spirv_ocl_sincospi, half,
                      private, half)
_CLC_V_V_VP_VECTORIZE(_CLC_OVERLOAD _CLC_DEF, half, __spirv_ocl_sincospi, half,
                      local, half)
_CLC_V_V_VP_VECTORIZE(_CLC_OVERLOAD _CLC_DEF, half, __spirv_ocl_sincospi, half,
                      global, half)
#endif
