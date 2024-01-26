//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include <spirv/spirv.h>

_CLC_DEF _CLC_OVERLOAD size_t __spirv_GlobalInvocationId_x() {
  return __mlvm_read_mlu_sreg_taskidx();
         
}

_CLC_DEF _CLC_OVERLOAD size_t __spirv_GlobalInvocationId_y() {
  return __mlvm_read_mlu_sreg_taskidy();
         
}

_CLC_DEF _CLC_OVERLOAD size_t __spirv_GlobalInvocationId_z() {
  return __mlvm_read_mlu_sreg_taskidz();
         
}