//===- IntrinsicsMLVM.td - Defines MLVM intrinsics ---------*- tablegen -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file defines all of the MLVM-specific intrinsics for use with MLISA.
//
//===----------------------------------------------------------------------===//

let TargetPrefix = "mlvm" in {
// Convert
multiclass MLUConvertIntToFloat<string name, LLVMType fp_ty, LLVMType int_ty> {
  def _tz : Intrinsic<[fp_ty], [int_ty], [IntrNoMem]>,
    ClangBuiltin<!strconcat("__mlvm_scalar_cvt", name, "_tz")>;
  def _oz : Intrinsic<[fp_ty], [int_ty], [IntrNoMem]>,
    ClangBuiltin<!strconcat("__mlvm_scalar_cvt", name, "_oz")>;
  def _up : Intrinsic<[fp_ty], [int_ty], [IntrNoMem]>,
    ClangBuiltin<!strconcat("__mlvm_scalar_cvt", name, "_up")>;
  def _dn : Intrinsic<[fp_ty], [int_ty], [IntrNoMem]>,
    ClangBuiltin<!strconcat("__mlvm_scalar_cvt", name, "_dn")>;
  def _rd : Intrinsic<[fp_ty], [int_ty], [IntrNoMem]>,
    ClangBuiltin<!strconcat("__mlvm_scalar_cvt", name, "_rd")>;
  def _rn : Intrinsic<[fp_ty], [int_ty], [IntrNoMem]>,
    ClangBuiltin<!strconcat("__mlvm_scalar_cvt", name, "_rn")>;
}

defm int_mlvm_scalar_cvtf16_s16 :
  MLUConvertIntToFloat<"f16_s16", llvm_half_ty, llvm_i16_ty>;
defm int_mlvm_scalar_cvtf16_s32 :
  MLUConvertIntToFloat<"f16_s32", llvm_half_ty, llvm_i32_ty>;
defm int_mlvm_scalar_cvtf32_s16 :
  MLUConvertIntToFloat<"f32_s16", llvm_float_ty, llvm_i16_ty>;
defm int_mlvm_scalar_cvtf32_s32 :
  MLUConvertIntToFloat<"f32_s32", llvm_float_ty, llvm_i32_ty>;

defm int_mlvm_scalar_cvtf16_u16 :
  MLUConvertIntToFloat<"f16_u16", llvm_half_ty, llvm_i16_ty>;
defm int_mlvm_scalar_cvtf16_u32 :
  MLUConvertIntToFloat<"f16_u32", llvm_half_ty, llvm_i32_ty>;
defm int_mlvm_scalar_cvtf32_u16 :
  MLUConvertIntToFloat<"f32_u16", llvm_float_ty, llvm_i16_ty>;
defm int_mlvm_scalar_cvtf32_u32 :
  MLUConvertIntToFloat<"f32_u32", llvm_float_ty, llvm_i32_ty>;

multiclass MLUConvertFloatToInt<string name, LLVMType fp_ty, LLVMType int_ty> {
  def _tz : Intrinsic<[int_ty], [fp_ty], [IntrNoMem]>,
    ClangBuiltin<!strconcat("__mlvm_scalar_cvt", name, "_tz")>;
  def _oz : Intrinsic<[int_ty], [fp_ty], [IntrNoMem]>,
    ClangBuiltin<!strconcat("__mlvm_scalar_cvt", name, "_oz")>;
  def _up : Intrinsic<[int_ty], [fp_ty], [IntrNoMem]>,
    ClangBuiltin<!strconcat("__mlvm_scalar_cvt", name, "_up")>;
  def _dn : Intrinsic<[int_ty], [fp_ty], [IntrNoMem]>,
    ClangBuiltin<!strconcat("__mlvm_scalar_cvt", name, "_dn")>;
  def _rd : Intrinsic<[int_ty], [fp_ty], [IntrNoMem]>,
    ClangBuiltin<!strconcat("__mlvm_scalar_cvt", name, "_rd")>;
  def _rn : Intrinsic<[int_ty], [fp_ty], [IntrNoMem]>,
    ClangBuiltin<!strconcat("__mlvm_scalar_cvt", name, "_rn")>;
}

defm int_mlvm_scalar_cvti16_f16 :
  MLUConvertFloatToInt<"i16_f16", llvm_half_ty, llvm_i16_ty>;
defm int_mlvm_scalar_cvti16_f32 :
  MLUConvertFloatToInt<"i16_f32", llvm_float_ty, llvm_i16_ty>;
defm int_mlvm_scalar_cvti32_f16 :
  MLUConvertFloatToInt<"i32_f16", llvm_half_ty, llvm_i32_ty>;
defm int_mlvm_scalar_cvti32_f32 :
  MLUConvertFloatToInt<"i32_f32", llvm_float_ty, llvm_i32_ty>;

class MLUConvertHalfToFloat<string name, LLVMType fp32_ty, LLVMType fp16_ty>
  : Intrinsic<[fp32_ty], [fp16_ty], [IntrNoMem]>,
    ClangBuiltin<"__mlvm_scalar_cvt" # name>;

def int_mlvm_scalar_cvtf32_f16 :
  MLUConvertHalfToFloat<"f32_f16", llvm_float_ty, llvm_half_ty>;

multiclass MLUConvertFloatToHalf<string name, LLVMType fp16_ty, LLVMType fp32_ty> {
  def _tz : Intrinsic<[fp16_ty], [fp32_ty], [IntrNoMem]>,
    ClangBuiltin<!strconcat("__mlvm_scalar_cvt", name, "_tz")>;
  def _oz : Intrinsic<[fp16_ty], [fp32_ty], [IntrNoMem]>,
    ClangBuiltin<!strconcat("__mlvm_scalar_cvt", name, "_oz")>;
  def _up : Intrinsic<[fp16_ty], [fp32_ty], [IntrNoMem]>,
    ClangBuiltin<!strconcat("__mlvm_scalar_cvt", name, "_up")>;
  def _dn : Intrinsic<[fp16_ty], [fp32_ty], [IntrNoMem]>,
    ClangBuiltin<!strconcat("__mlvm_scalar_cvt", name, "_dn")>;
  def _rd : Intrinsic<[fp16_ty], [fp32_ty], [IntrNoMem]>,
    ClangBuiltin<!strconcat("__mlvm_scalar_cvt", name, "_rd")>;
  def _rn : Intrinsic<[fp16_ty], [fp32_ty], [IntrNoMem]>,
    ClangBuiltin<!strconcat("__mlvm_scalar_cvt", name, "_rn")>;
}

defm int_mlvm_scalar_cvtf16_f32 :
  MLUConvertFloatToHalf<"f16_f32", llvm_half_ty, llvm_float_ty>;

// Accessing special registers.
class MLUReadSRegIntrinsic_i32<string name>
  : Intrinsic<[llvm_i32_ty], [], [IntrNoMem]>,
    ClangBuiltin<"__mlvm_read_mlu_sreg_" # name>;

class MLUReadGridSRegIntrinsic_i32<string name>
  : Intrinsic<[llvm_i32_ty], [], [IntrReadMem]>,
    ClangBuiltin<"__mlvm_read_mlu_grid_sreg_" # name>;

class MLUReadSRegIntrinsic_r32<string name>
  : Intrinsic<[llvm_i32_ty], [], [IntrNoMem]>,
    ClangBuiltin<"__mlvm_read_mlu_sreg_" # name>;

class MLUReadSRegIntrinsic_r64<string name>
  : Intrinsic<[llvm_i64_ty], [], [IntrNoMem]>,
    ClangBuiltin<"__mlvm_read_mlu_sreg_" # name>;

def int_mlvm_read_mlu_sreg_taskidx : MLUReadSRegIntrinsic_i32<"taskidx">;
def int_mlvm_read_mlu_sreg_taskidy : MLUReadSRegIntrinsic_i32<"taskidy">;
def int_mlvm_read_mlu_sreg_taskidz : MLUReadSRegIntrinsic_i32<"taskidz">;
def int_mlvm_read_mlu_sreg_taskid : MLUReadSRegIntrinsic_i32<"taskid">;
def int_mlvm_read_mlu_sreg_taskdimx : MLUReadSRegIntrinsic_i32<"taskdimx">;
def int_mlvm_read_mlu_sreg_taskdimy : MLUReadSRegIntrinsic_i32<"taskdimy">;
def int_mlvm_read_mlu_sreg_taskdimz : MLUReadSRegIntrinsic_i32<"taskdimz">;
def int_mlvm_read_mlu_sreg_taskdim : MLUReadSRegIntrinsic_i32<"taskdim">;
def int_mlvm_read_mlu_sreg_coreid : MLUReadSRegIntrinsic_i32<"coreid">;
def int_mlvm_read_mlu_sreg_coredim : MLUReadSRegIntrinsic_i32<"coredim">;
def int_mlvm_read_mlu_sreg_clusterid : MLUReadSRegIntrinsic_i32<"clusterid">;
def int_mlvm_read_mlu_sreg_clusterdim : MLUReadSRegIntrinsic_i32<"clusterdim">;

def int_mlvm_read_mlu_grid_sreg_griddim : MLUReadGridSRegIntrinsic_i32<"griddim">;
def int_mlvm_read_mlu_grid_sreg_griddimx : MLUReadGridSRegIntrinsic_i32<"griddimx">;
def int_mlvm_read_mlu_grid_sreg_griddimy : MLUReadGridSRegIntrinsic_i32<"griddimy">;
def int_mlvm_read_mlu_grid_sreg_griddimz : MLUReadGridSRegIntrinsic_i32<"griddimz">;

def int_mlvm_read_mlu_grid_sreg_blockid : MLUReadGridSRegIntrinsic_i32<"blockid">;
def int_mlvm_read_mlu_grid_sreg_blockidx : MLUReadGridSRegIntrinsic_i32<"blockidx">;
def int_mlvm_read_mlu_grid_sreg_blockidy : MLUReadGridSRegIntrinsic_i32<"blockidy">;
def int_mlvm_read_mlu_grid_sreg_blockidz : MLUReadGridSRegIntrinsic_i32<"blockidz">;

def int_mlvm_read_mlu_grid_sreg_blockdim : MLUReadGridSRegIntrinsic_i32<"blockdim">;
def int_mlvm_read_mlu_grid_sreg_blockdimx : MLUReadGridSRegIntrinsic_i32<"blockdimx">;
def int_mlvm_read_mlu_grid_sreg_blockdimy : MLUReadGridSRegIntrinsic_i32<"blockdimy">;

class MLUWriteGridSRegIntrinsic_i32<string name>
  : Intrinsic<[], [llvm_i32_ty], [IntrWriteMem]>,
    ClangBuiltin<"__mlvm_write_mlu_grid_sreg_" # name>;

def int_mlvm_write_mlu_grid_sreg_griddim : MLUWriteGridSRegIntrinsic_i32<"griddim">;
def int_mlvm_write_mlu_grid_sreg_griddimx : MLUWriteGridSRegIntrinsic_i32<"griddimx">;
def int_mlvm_write_mlu_grid_sreg_griddimy : MLUWriteGridSRegIntrinsic_i32<"griddimy">;
def int_mlvm_write_mlu_grid_sreg_griddimz : MLUWriteGridSRegIntrinsic_i32<"griddimz">;

def int_mlvm_write_mlu_grid_sreg_blockid : MLUWriteGridSRegIntrinsic_i32<"blockid">;
def int_mlvm_write_mlu_grid_sreg_blockidx : MLUWriteGridSRegIntrinsic_i32<"blockidx">;
def int_mlvm_write_mlu_grid_sreg_blockidy : MLUWriteGridSRegIntrinsic_i32<"blockidy">;
def int_mlvm_write_mlu_grid_sreg_blockidz : MLUWriteGridSRegIntrinsic_i32<"blockidz">;

//===----------------------------------------------------------------------===//
//
// This following lines define all of the MLVM-specific intrinsics for use with MLISA.
//
//===----------------------------------------------------------------------===//

  //===--------------------------------------------------------------------===//
  // atomic scalar
  //===--------------------------------------------------------------------===//
  class MLUScalarAtomBinary<string name, LLVMType ptr_ty, LLVMType int_ty>
    : Intrinsic<[], [ptr_ty, ptr_ty, int_ty], []>,
      ClangBuiltin<"__mlvm_scalar_atom_" # name>;
  class MLUScalarAtomTernary<string name, LLVMType ptr_ty, LLVMType int_ty>
    : Intrinsic<[], [ptr_ty, ptr_ty, int_ty, int_ty], []>,
      ClangBuiltin<"__mlvm_scalar_atom_" # name>;

  // Atomic scalar add
  def int_mlvm_scalar_atom_add_u16 :
      MLUScalarAtomBinary<"add_u16", llvm_ptr_ty, llvm_i16_ty>;
  def int_mlvm_scalar_atom_add_s16 :
      MLUScalarAtomBinary<"add_s16", llvm_ptr_ty, llvm_i16_ty>;
  def int_mlvm_scalar_atom_add_u32 :
      MLUScalarAtomBinary<"add_u32", llvm_ptr_ty, llvm_i32_ty>;
  def int_mlvm_scalar_atom_add_s32 :
      MLUScalarAtomBinary<"add_s32", llvm_ptr_ty, llvm_i32_ty>;
  def int_mlvm_scalar_atom_add_f16 :
      MLUScalarAtomBinary<"add_f16", llvm_ptr_ty, llvm_half_ty>;
  def int_mlvm_scalar_atom_add_f32 :
      MLUScalarAtomBinary<"add_f32", llvm_ptr_ty, llvm_float_ty>;

  // Atomic scalar inc
  def int_mlvm_scalar_atom_inc_u16 :
      MLUScalarAtomBinary<"inc_u16", llvm_ptr_ty, llvm_i16_ty>;
  def int_mlvm_scalar_atom_inc_s16 :
      MLUScalarAtomBinary<"inc_s16", llvm_ptr_ty, llvm_i16_ty>;
  def int_mlvm_scalar_atom_inc_u32 :
      MLUScalarAtomBinary<"inc_u32", llvm_ptr_ty, llvm_i32_ty>;
  def int_mlvm_scalar_atom_inc_s32 :
      MLUScalarAtomBinary<"inc_s32", llvm_ptr_ty, llvm_i32_ty>;
  def int_mlvm_scalar_atom_inc_f16 :
      MLUScalarAtomBinary<"inc_f16", llvm_ptr_ty, llvm_half_ty>;
  def int_mlvm_scalar_atom_inc_f32 :
      MLUScalarAtomBinary<"inc_f32", llvm_ptr_ty, llvm_float_ty>;

  // Atomic scalar dec
  def int_mlvm_scalar_atom_dec_u16 :
      MLUScalarAtomBinary<"dec_u16", llvm_ptr_ty, llvm_i16_ty>;
  def int_mlvm_scalar_atom_dec_s16 :
      MLUScalarAtomBinary<"dec_s16", llvm_ptr_ty, llvm_i16_ty>;
  def int_mlvm_scalar_atom_dec_u32 :
      MLUScalarAtomBinary<"dec_u32", llvm_ptr_ty, llvm_i32_ty>;
  def int_mlvm_scalar_atom_dec_s32 :
      MLUScalarAtomBinary<"dec_s32", llvm_ptr_ty, llvm_i32_ty>;
  def int_mlvm_scalar_atom_dec_f16 :
      MLUScalarAtomBinary<"dec_f16", llvm_ptr_ty, llvm_half_ty>;
  def int_mlvm_scalar_atom_dec_f32 :
      MLUScalarAtomBinary<"dec_f32", llvm_ptr_ty, llvm_float_ty>;

  // Atomic scalar max
  def int_mlvm_scalar_atom_max_u16 :
      MLUScalarAtomBinary<"max_u16", llvm_ptr_ty, llvm_i16_ty>;
  def int_mlvm_scalar_atom_max_s16 :
      MLUScalarAtomBinary<"max_s16", llvm_ptr_ty, llvm_i16_ty>;
  def int_mlvm_scalar_atom_max_u32 :
      MLUScalarAtomBinary<"max_u32", llvm_ptr_ty, llvm_i32_ty>;
  def int_mlvm_scalar_atom_max_s32 :
      MLUScalarAtomBinary<"max_s32", llvm_ptr_ty, llvm_i32_ty>;
  def int_mlvm_scalar_atom_max_f16 :
      MLUScalarAtomBinary<"max_f16", llvm_ptr_ty, llvm_half_ty>;
  def int_mlvm_scalar_atom_max_f32 :
      MLUScalarAtomBinary<"max_f32", llvm_ptr_ty, llvm_float_ty>;

  // Atomic scalar min
  def int_mlvm_scalar_atom_min_u16 :
      MLUScalarAtomBinary<"min_u16", llvm_ptr_ty, llvm_i16_ty>;
  def int_mlvm_scalar_atom_min_s16 :
      MLUScalarAtomBinary<"min_s16", llvm_ptr_ty, llvm_i16_ty>;
  def int_mlvm_scalar_atom_min_u32 :
      MLUScalarAtomBinary<"min_u32", llvm_ptr_ty, llvm_i32_ty>;
  def int_mlvm_scalar_atom_min_s32 :
      MLUScalarAtomBinary<"min_s32", llvm_ptr_ty, llvm_i32_ty>;
  def int_mlvm_scalar_atom_min_f16 :
      MLUScalarAtomBinary<"min_f16", llvm_ptr_ty, llvm_half_ty>;
  def int_mlvm_scalar_atom_min_f32 :
      MLUScalarAtomBinary<"min_f32", llvm_ptr_ty, llvm_float_ty>;

  // Atomic scalar and
  def int_mlvm_scalar_atom_and_u16 :
      MLUScalarAtomBinary<"and_u16", llvm_ptr_ty, llvm_i16_ty>;
  def int_mlvm_scalar_atom_and_s16 :
      MLUScalarAtomBinary<"and_s16", llvm_ptr_ty, llvm_i16_ty>;
  def int_mlvm_scalar_atom_and_u32 :
      MLUScalarAtomBinary<"and_u32", llvm_ptr_ty, llvm_i32_ty>;
  def int_mlvm_scalar_atom_and_s32 :
      MLUScalarAtomBinary<"and_s32", llvm_ptr_ty, llvm_i32_ty>;
  def int_mlvm_scalar_atom_and_f16 :
      MLUScalarAtomBinary<"and_f16", llvm_ptr_ty, llvm_half_ty>;
  def int_mlvm_scalar_atom_and_f32 :
      MLUScalarAtomBinary<"and_f32", llvm_ptr_ty, llvm_float_ty>;

  // Atomic scalar or
  def int_mlvm_scalar_atom_or_u16 :
      MLUScalarAtomBinary<"or_u16", llvm_ptr_ty, llvm_i16_ty>;
  def int_mlvm_scalar_atom_or_s16 :
      MLUScalarAtomBinary<"or_s16", llvm_ptr_ty, llvm_i16_ty>;
  def int_mlvm_scalar_atom_or_u32 :
      MLUScalarAtomBinary<"or_u32", llvm_ptr_ty, llvm_i32_ty>;
  def int_mlvm_scalar_atom_or_s32 :
      MLUScalarAtomBinary<"or_s32", llvm_ptr_ty, llvm_i32_ty>;
  def int_mlvm_scalar_atom_or_f16 :
      MLUScalarAtomBinary<"or_f16", llvm_ptr_ty, llvm_half_ty>;
  def int_mlvm_scalar_atom_or_f32 :
      MLUScalarAtomBinary<"or_f32", llvm_ptr_ty, llvm_float_ty>;

  // Atomic scalar xor
  def int_mlvm_scalar_atom_xor_u16 :
      MLUScalarAtomBinary<"xor_u16", llvm_ptr_ty, llvm_i16_ty>;
  def int_mlvm_scalar_atom_xor_s16 :
      MLUScalarAtomBinary<"xor_s16", llvm_ptr_ty, llvm_i16_ty>;
  def int_mlvm_scalar_atom_xor_u32 :
      MLUScalarAtomBinary<"xor_u32", llvm_ptr_ty, llvm_i32_ty>;
  def int_mlvm_scalar_atom_xor_s32 :
      MLUScalarAtomBinary<"xor_s32", llvm_ptr_ty, llvm_i32_ty>;
  def int_mlvm_scalar_atom_xor_f16 :
      MLUScalarAtomBinary<"xor_f16", llvm_ptr_ty, llvm_half_ty>;
  def int_mlvm_scalar_atom_xor_f32 :
      MLUScalarAtomBinary<"xor_f32", llvm_ptr_ty, llvm_float_ty>;

  // Atomic scalar cas
  def int_mlvm_scalar_atom_cas_u16 :
      MLUScalarAtomTernary<"cas_u16", llvm_ptr_ty, llvm_i16_ty>;
  def int_mlvm_scalar_atom_cas_s16 :
      MLUScalarAtomTernary<"cas_s16", llvm_ptr_ty, llvm_i16_ty>;
  def int_mlvm_scalar_atom_cas_u32 :
      MLUScalarAtomTernary<"cas_u32", llvm_ptr_ty, llvm_i32_ty>;
  def int_mlvm_scalar_atom_cas_s32 :
      MLUScalarAtomTernary<"cas_s32", llvm_ptr_ty, llvm_i32_ty>;
  def int_mlvm_scalar_atom_cas_f16 :
      MLUScalarAtomTernary<"cas_f16", llvm_ptr_ty, llvm_half_ty>;
  def int_mlvm_scalar_atom_cas_f32 :
      MLUScalarAtomTernary<"cas_f32", llvm_ptr_ty, llvm_float_ty>;

  // Atomic scalar exch
  def int_mlvm_scalar_atom_exch_u16 :
      MLUScalarAtomBinary<"exch_u16", llvm_ptr_ty, llvm_i16_ty>;
  def int_mlvm_scalar_atom_exch_s16 :
      MLUScalarAtomBinary<"exch_s16", llvm_ptr_ty, llvm_i16_ty>;
  def int_mlvm_scalar_atom_exch_u32 :
      MLUScalarAtomBinary<"exch_u32", llvm_ptr_ty, llvm_i32_ty>;
  def int_mlvm_scalar_atom_exch_s32 :
      MLUScalarAtomBinary<"exch_s32", llvm_ptr_ty, llvm_i32_ty>;
  def int_mlvm_scalar_atom_exch_f16 :
      MLUScalarAtomBinary<"exch_f16", llvm_ptr_ty, llvm_half_ty>;
  def int_mlvm_scalar_atom_exch_f32 :
      MLUScalarAtomBinary<"exch_f32", llvm_ptr_ty, llvm_float_ty>;

  //===--------------------------------------------------------------------===//
  // atomic stream
  //===--------------------------------------------------------------------===//
  class MLUStreamAtomBinary<string name, LLVMType ptr_ty>
    : ClangBuiltin<"__mlvm_stream_atom_" # name>,
      Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
                []>;
  class MLUStreamAtomTernary<string name, LLVMType ptr_ty>
    : ClangBuiltin<"__mlvm_stream_atom_" # name>,
      Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
                []>;

  // Atomic stream add
  def int_mlvm_stream_atom_add_u16 :
      MLUStreamAtomBinary<"add_u16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_add_u32 :
      MLUStreamAtomBinary<"add_u32", llvm_ptr_ty>;
  def int_mlvm_stream_atom_add_s16 :
      MLUStreamAtomBinary<"add_s16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_add_s32 :
      MLUStreamAtomBinary<"add_s32", llvm_ptr_ty>;
  def int_mlvm_stream_atom_add_f16 :
      MLUStreamAtomBinary<"add_f16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_add_f32 :
      MLUStreamAtomBinary<"add_f32", llvm_ptr_ty>;

  // Atomic stream inc
  def int_mlvm_stream_atom_inc_u16 :
      MLUStreamAtomBinary<"inc_u16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_inc_u32 :
      MLUStreamAtomBinary<"inc_u32", llvm_ptr_ty>;
  def int_mlvm_stream_atom_inc_s16 :
      MLUStreamAtomBinary<"inc_s16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_inc_s32 :
      MLUStreamAtomBinary<"inc_s32", llvm_ptr_ty>;
  def int_mlvm_stream_atom_inc_f16 :
      MLUStreamAtomBinary<"inc_f16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_inc_f32 :
      MLUStreamAtomBinary<"inc_f32", llvm_ptr_ty>;

  // Atomic stream dec
  def int_mlvm_stream_atom_dec_u16 :
      MLUStreamAtomBinary<"dec_u16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_dec_u32 :
      MLUStreamAtomBinary<"dec_u32", llvm_ptr_ty>;
  def int_mlvm_stream_atom_dec_s16 :
      MLUStreamAtomBinary<"dec_s16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_dec_s32 :
      MLUStreamAtomBinary<"dec_s32", llvm_ptr_ty>;
  def int_mlvm_stream_atom_dec_f16 :
      MLUStreamAtomBinary<"dec_f16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_dec_f32 :
      MLUStreamAtomBinary<"dec_f32", llvm_ptr_ty>;

  // Atomic stream max
  def int_mlvm_stream_atom_max_u16 :
      MLUStreamAtomBinary<"max_u16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_max_u32 :
      MLUStreamAtomBinary<"max_u32", llvm_ptr_ty>;
  def int_mlvm_stream_atom_max_s16 :
      MLUStreamAtomBinary<"max_s16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_max_s32 :
      MLUStreamAtomBinary<"max_s32", llvm_ptr_ty>;
  def int_mlvm_stream_atom_max_f16 :
      MLUStreamAtomBinary<"max_f16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_max_f32 :
      MLUStreamAtomBinary<"max_f32", llvm_ptr_ty>;

  // Atomic stream min
  def int_mlvm_stream_atom_min_u16 :
      MLUStreamAtomBinary<"min_u16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_min_u32 :
      MLUStreamAtomBinary<"min_u32", llvm_ptr_ty>;
  def int_mlvm_stream_atom_min_s16 :
      MLUStreamAtomBinary<"min_s16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_min_s32 :
      MLUStreamAtomBinary<"min_s32", llvm_ptr_ty>;
  def int_mlvm_stream_atom_min_f16 :
      MLUStreamAtomBinary<"min_f16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_min_f32 :
      MLUStreamAtomBinary<"min_f32", llvm_ptr_ty>;

  // Atomic stream and
  def int_mlvm_stream_atom_and_u16 :
      MLUStreamAtomBinary<"and_u16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_and_u32 :
      MLUStreamAtomBinary<"and_u32", llvm_ptr_ty>;
  def int_mlvm_stream_atom_and_s16 :
      MLUStreamAtomBinary<"and_s16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_and_s32 :
      MLUStreamAtomBinary<"and_s32", llvm_ptr_ty>;
  def int_mlvm_stream_atom_and_f16 :
      MLUStreamAtomBinary<"and_f16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_and_f32 :
      MLUStreamAtomBinary<"and_f32", llvm_ptr_ty>;

  // Atomic stream or
  def int_mlvm_stream_atom_or_u16 :
      MLUStreamAtomBinary<"or_u16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_or_u32 :
      MLUStreamAtomBinary<"or_u32", llvm_ptr_ty>;
  def int_mlvm_stream_atom_or_s16 :
      MLUStreamAtomBinary<"or_s16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_or_s32 :
      MLUStreamAtomBinary<"or_s32", llvm_ptr_ty>;
  def int_mlvm_stream_atom_or_f16 :
      MLUStreamAtomBinary<"or_f16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_or_f32 :
      MLUStreamAtomBinary<"or_f32", llvm_ptr_ty>;

  // Atomic stream xor
  def int_mlvm_stream_atom_xor_u16 :
      MLUStreamAtomBinary<"xor_u16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_xor_u32 :
      MLUStreamAtomBinary<"xor_u32", llvm_ptr_ty>;
  def int_mlvm_stream_atom_xor_s16 :
      MLUStreamAtomBinary<"xor_s16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_xor_s32 :
      MLUStreamAtomBinary<"xor_s32", llvm_ptr_ty>;
  def int_mlvm_stream_atom_xor_f16 :
      MLUStreamAtomBinary<"xor_f16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_xor_f32 :
      MLUStreamAtomBinary<"xor_f32", llvm_ptr_ty>;

  // Atomic stream exch
  def int_mlvm_stream_atom_exch_u16 :
      MLUStreamAtomBinary<"exch_u16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_exch_u32 :
      MLUStreamAtomBinary<"exch_u32", llvm_ptr_ty>;
  def int_mlvm_stream_atom_exch_s16 :
      MLUStreamAtomBinary<"exch_s16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_exch_s32 :
      MLUStreamAtomBinary<"exch_s32", llvm_ptr_ty>;
  def int_mlvm_stream_atom_exch_f16 :
      MLUStreamAtomBinary<"exch_f16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_exch_f32 :
      MLUStreamAtomBinary<"exch_f32", llvm_ptr_ty>;

  // Atomic stream cas
  def int_mlvm_stream_atom_cas_u16 :
      MLUStreamAtomTernary<"cas_u16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_cas_u32 :
      MLUStreamAtomTernary<"cas_u32", llvm_ptr_ty>;
  def int_mlvm_stream_atom_cas_s16 :
      MLUStreamAtomTernary<"cas_s16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_cas_s32 :
      MLUStreamAtomTernary<"cas_s32", llvm_ptr_ty>;
  def int_mlvm_stream_atom_cas_f16 :
      MLUStreamAtomTernary<"cas_f16", llvm_ptr_ty>;
  def int_mlvm_stream_atom_cas_f32 :
      MLUStreamAtomTernary<"cas_f32", llvm_ptr_ty>;

  //===--------------------------------------------------------------------===//
  // scalar
  //===--------------------------------------------------------------------===//
  def int_mlvm_scalar_abs_s16 :
    ClangBuiltin<"__mlvm_scalar_abs_s16">,
    Intrinsic<[llvm_i16_ty], [llvm_i16_ty], []>;

  def int_mlvm_scalar_abs_s32 :
    ClangBuiltin<"__mlvm_scalar_abs_s32">,
    Intrinsic<[llvm_i32_ty], [llvm_i32_ty], []>;

  def int_mlvm_scalar_abs_f16 :
    ClangBuiltin<"__mlvm_scalar_abs_f16">,
    Intrinsic<[llvm_half_ty], [llvm_half_ty], []>;

  def int_mlvm_scalar_abs_f32 :
    ClangBuiltin<"__mlvm_scalar_abs_f32">,
    Intrinsic<[llvm_float_ty], [llvm_float_ty], []>;

  def int_mlvm_scalar_sin_f32 :
    ClangBuiltin<"__mlvm_scalar_sin_f32">,
    Intrinsic<[llvm_float_ty], [llvm_float_ty], []>;

  def int_mlvm_scalar_cos_f32 :
    ClangBuiltin<"__mlvm_scalar_cos_f32">,
    Intrinsic<[llvm_float_ty], [llvm_float_ty], []>;

  def int_mlvm_scalar_recip_f32 :
    ClangBuiltin<"__mlvm_scalar_recip_f32">,
    Intrinsic<[llvm_float_ty], [llvm_float_ty], []>;

  def int_mlvm_scalar_sqrt_f32 :
    ClangBuiltin<"__mlvm_scalar_sqrt_f32">,
    Intrinsic<[llvm_float_ty], [llvm_float_ty], []>;

  def int_mlvm_scalar_rsqrt_f32 :
    ClangBuiltin<"__mlvm_scalar_rsqrt_f32">,
    Intrinsic<[llvm_float_ty], [llvm_float_ty], []>;

  def int_mlvm_scalar_pow2_f32 :
    ClangBuiltin<"__mlvm_scalar_pow2_f32">,
    Intrinsic<[llvm_float_ty], [llvm_float_ty], []>;

  def int_mlvm_scalar_log2_f32 :
    ClangBuiltin<"__mlvm_scalar_log2_f32">,
    Intrinsic<[llvm_float_ty], [llvm_float_ty], []>;

  def int_mlvm_scalar_findfirst1_u16 :
    ClangBuiltin<"__mlvm_scalar_findfirst1_u16">,
    Intrinsic<[llvm_i16_ty], [llvm_i16_ty], []>;

  def int_mlvm_scalar_findfirst1_u32 :
    ClangBuiltin<"__mlvm_scalar_findfirst1_u32">,
    Intrinsic<[llvm_i32_ty], [llvm_i32_ty], []>;

  def int_mlvm_scalar_findfirst1_s16 :
    ClangBuiltin<"__mlvm_scalar_findfirst1_s16">,
    Intrinsic<[llvm_i16_ty], [llvm_i16_ty], []>;

  def int_mlvm_scalar_findfirst1_s32 :
    ClangBuiltin<"__mlvm_scalar_findfirst1_s32">,
    Intrinsic<[llvm_i32_ty], [llvm_i32_ty], []>;

  def int_mlvm_scalar_findfirst1_f16 :
    ClangBuiltin<"__mlvm_scalar_findfirst1_f16">,
    Intrinsic<[llvm_i16_ty], [llvm_half_ty], []>;

  def int_mlvm_scalar_findfirst1_f32 :
    ClangBuiltin<"__mlvm_scalar_findfirst1_f32">,
    Intrinsic<[llvm_i32_ty], [llvm_float_ty], []>;

  def int_mlvm_scalar_findlast1_u16 :
    ClangBuiltin<"__mlvm_scalar_findlast1_u16">,
    Intrinsic<[llvm_i16_ty], [llvm_i16_ty], []>;

  def int_mlvm_scalar_findlast1_u32 :
    ClangBuiltin<"__mlvm_scalar_findlast1_u32">,
    Intrinsic<[llvm_i32_ty], [llvm_i32_ty], []>;

  def int_mlvm_scalar_findlast1_s16 :
    ClangBuiltin<"__mlvm_scalar_findlast1_s16">,
    Intrinsic<[llvm_i16_ty], [llvm_i16_ty], []>;

  def int_mlvm_scalar_findlast1_s32 :
    ClangBuiltin<"__mlvm_scalar_findlast1_s32">,
    Intrinsic<[llvm_i32_ty], [llvm_i32_ty], []>;

  def int_mlvm_scalar_findlast1_f16 :
    ClangBuiltin<"__mlvm_scalar_findlast1_f16">,
    Intrinsic<[llvm_i16_ty], [llvm_half_ty], []>;

  def int_mlvm_scalar_findlast1_f32 :
    ClangBuiltin<"__mlvm_scalar_findlast1_f32">,
    Intrinsic<[llvm_i32_ty], [llvm_float_ty], []>;

  def int_mlvm_scalar_cvtf32 :
    ClangBuiltin<"__mlvm_scalar_cvtf32">,
    Intrinsic<[llvm_half_ty], [llvm_i32_ty], []>;

  def int_mlvm_scalar_cvtint :
    ClangBuiltin<"__mlvm_scalar_cvtint">,
    Intrinsic<[llvm_i32_ty], [llvm_half_ty], []>;

  def int_mlvm_scalar_mulh_u16 :
    ClangBuiltin<"__mlvm_scalar_mulh_u16">,
    Intrinsic<[llvm_i16_ty], [llvm_i16_ty, llvm_i16_ty], []>;

  def int_mlvm_scalar_mulh_u32 :
    ClangBuiltin<"__mlvm_scalar_mulh_u32">,
    Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty], []>;

  def int_mlvm_scalar_mulh_s16 :
    ClangBuiltin<"__mlvm_scalar_mulh_s16">,
    Intrinsic<[llvm_i16_ty], [llvm_i16_ty, llvm_i16_ty], []>;

  def int_mlvm_scalar_mulh_s32 :
    ClangBuiltin<"__mlvm_scalar_mulh_s32">,
    Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty], []>;

  def int_mlvm_scalar_max_u16 :
    ClangBuiltin<"__mlvm_scalar_max_u16">,
    Intrinsic<[llvm_i16_ty], [llvm_i16_ty, llvm_i16_ty], []>;

  def int_mlvm_scalar_max_u32 :
    ClangBuiltin<"__mlvm_scalar_max_u32">,
    Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty], []>;

  def int_mlvm_scalar_max_s16 :
    ClangBuiltin<"__mlvm_scalar_max_s16">,
    Intrinsic<[llvm_i16_ty], [llvm_i16_ty, llvm_i16_ty], []>;

  def int_mlvm_scalar_max_s32 :
    ClangBuiltin<"__mlvm_scalar_max_s32">,
    Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty], []>;

  def int_mlvm_scalar_max_f16 :
    ClangBuiltin<"__mlvm_scalar_max_f16">,
    Intrinsic<[llvm_half_ty], [llvm_half_ty, llvm_half_ty], []>;

  def int_mlvm_scalar_max_f32 :
    ClangBuiltin<"__mlvm_scalar_max_f32">,
    Intrinsic<[llvm_float_ty], [llvm_float_ty, llvm_float_ty], []>;

  def int_mlvm_scalar_min_u16 :
    ClangBuiltin<"__mlvm_scalar_min_u16">,
    Intrinsic<[llvm_i16_ty], [llvm_i16_ty, llvm_i16_ty], []>;

  def int_mlvm_scalar_min_u32 :
    ClangBuiltin<"__mlvm_scalar_min_u32">,
    Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty], []>;

  def int_mlvm_scalar_min_s16 :
    ClangBuiltin<"__mlvm_scalar_min_s16">,
    Intrinsic<[llvm_i16_ty], [llvm_i16_ty, llvm_i16_ty], []>;

  def int_mlvm_scalar_min_s32 :
    ClangBuiltin<"__mlvm_scalar_min_s32">,
    Intrinsic<[llvm_i32_ty], [llvm_i32_ty, llvm_i32_ty], []>;

  def int_mlvm_scalar_min_f16 :
    ClangBuiltin<"__mlvm_scalar_min_f16">,
    Intrinsic<[llvm_half_ty], [llvm_half_ty, llvm_half_ty], []>;

  def int_mlvm_scalar_min_f32 :
    ClangBuiltin<"__mlvm_scalar_min_f32">,
    Intrinsic<[llvm_float_ty], [llvm_float_ty, llvm_float_ty], []>;

  def int_mlvm_scalar_fsgnj_f16 :
    ClangBuiltin<"__mlvm_scalar_fsgnj_f16">,
    Intrinsic<[llvm_half_ty], [llvm_half_ty, llvm_half_ty], []>;

  def int_mlvm_scalar_fsgnj_f32 :
    ClangBuiltin<"__mlvm_scalar_fsgnj_f32">,
    Intrinsic<[llvm_float_ty], [llvm_float_ty, llvm_float_ty], []>;

  def int_mlvm_scalar_fsgnjn_f16 :
    ClangBuiltin<"__mlvm_scalar_fsgnjn_f16">,
    Intrinsic<[llvm_half_ty], [llvm_half_ty, llvm_half_ty], []>;

  def int_mlvm_scalar_fsgnjn_f32 :
    ClangBuiltin<"__mlvm_scalar_fsgnjn_f32">,
    Intrinsic<[llvm_float_ty], [llvm_float_ty, llvm_float_ty], []>;

  def int_mlvm_scalar_fsgnjx_f16 :
    ClangBuiltin<"__mlvm_scalar_fsgnjx_f16">,
    Intrinsic<[llvm_half_ty], [llvm_half_ty, llvm_half_ty], []>;

  def int_mlvm_scalar_fsgnjx_f32 :
    ClangBuiltin<"__mlvm_scalar_fsgnjx_f32">,
    Intrinsic<[llvm_float_ty], [llvm_float_ty, llvm_float_ty], []>;


  //===--------------------------------------------------------------------===//
  // dtype convert
  //===--------------------------------------------------------------------===//
  def int_mlvm_stream_cvtfix8_f16_dn:
    ClangBuiltin<"__mlvm_stream_cvtfix8_f16_dn">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix8_f16_tz:
    ClangBuiltin<"__mlvm_stream_cvtfix8_f16_tz">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix8_f16_oz:
    ClangBuiltin<"__mlvm_stream_cvtfix8_f16_oz">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix8_f16_up:
    ClangBuiltin<"__mlvm_stream_cvtfix8_f16_up">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix8_f16_rd:
    ClangBuiltin<"__mlvm_stream_cvtfix8_f16_rd">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix8_f16_rm:
    ClangBuiltin<"__mlvm_stream_cvtfix8_f16_rm">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix8_f16_rn:
    ClangBuiltin<"__mlvm_stream_cvtfix8_f16_rn">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtf16_fix8:
    ClangBuiltin<"__mlvm_stream_cvtf16_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix8_f32_dn:
    ClangBuiltin<"__mlvm_stream_cvtfix8_f32_dn">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix8_f32_tz:
    ClangBuiltin<"__mlvm_stream_cvtfix8_f32_tz">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix8_f32_oz:
    ClangBuiltin<"__mlvm_stream_cvtfix8_f32_oz">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix8_f32_up:
    ClangBuiltin<"__mlvm_stream_cvtfix8_f32_up">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix8_f32_rd:
    ClangBuiltin<"__mlvm_stream_cvtfix8_f32_rd">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix8_f32_rm:
    ClangBuiltin<"__mlvm_stream_cvtfix8_f32_rm">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix8_f32_rn:
    ClangBuiltin<"__mlvm_stream_cvtfix8_f32_rn">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtf32_fix8:
    ClangBuiltin<"__mlvm_stream_cvtf32_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix16_f32_dn:
    ClangBuiltin<"__mlvm_stream_cvtfix16_f32_dn">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix16_f32_tz:
    ClangBuiltin<"__mlvm_stream_cvtfix16_f32_tz">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix16_f32_oz:
    ClangBuiltin<"__mlvm_stream_cvtfix16_f32_oz">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix16_f32_up:
    ClangBuiltin<"__mlvm_stream_cvtfix16_f32_up">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix16_f32_rd:
    ClangBuiltin<"__mlvm_stream_cvtfix16_f32_rd">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix16_f32_rm:
    ClangBuiltin<"__mlvm_stream_cvtfix16_f32_rm">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix16_f32_rn:
    ClangBuiltin<"__mlvm_stream_cvtfix16_f32_rn">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtf32_fix16:
    ClangBuiltin<"__mlvm_stream_cvtf32_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix32_f32_dn:
    ClangBuiltin<"__mlvm_stream_cvtfix32_f32_dn">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix32_f32_tz:
    ClangBuiltin<"__mlvm_stream_cvtfix32_f32_tz">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix32_f32_oz:
    ClangBuiltin<"__mlvm_stream_cvtfix32_f32_oz">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix32_f32_up:
    ClangBuiltin<"__mlvm_stream_cvtfix32_f32_up">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix32_f32_rd:
    ClangBuiltin<"__mlvm_stream_cvtfix32_f32_rd">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix32_f32_rm:
    ClangBuiltin<"__mlvm_stream_cvtfix32_f32_rm">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix32_f32_rn:
    ClangBuiltin<"__mlvm_stream_cvtfix32_f32_rn">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtf32_fix32:
    ClangBuiltin<"__mlvm_stream_cvtf32_fix32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix16_f16_dn:
    ClangBuiltin<"__mlvm_stream_cvtfix16_f16_dn">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix16_f16_tz:
    ClangBuiltin<"__mlvm_stream_cvtfix16_f16_tz">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix16_f16_oz:
    ClangBuiltin<"__mlvm_stream_cvtfix16_f16_oz">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix16_f16_up:
    ClangBuiltin<"__mlvm_stream_cvtfix16_f16_up">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix16_f16_rd:
    ClangBuiltin<"__mlvm_stream_cvtfix16_f16_rd">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix16_f16_rm:
    ClangBuiltin<"__mlvm_stream_cvtfix16_f16_rm">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix16_f16_rn:
    ClangBuiltin<"__mlvm_stream_cvtfix16_f16_rn">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtf16_fix16:
    ClangBuiltin<"__mlvm_stream_cvtf16_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtf16_i16:
    ClangBuiltin<"__mlvm_stream_cvtf16_i16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtf16_u8:
    ClangBuiltin<"__mlvm_stream_cvtf16_u8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvti16_f16_dn:
    ClangBuiltin<"__mlvm_stream_cvti16_f16_dn">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvti16_f16_tz:
    ClangBuiltin<"__mlvm_stream_cvti16_f16_tz">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvti16_f16_oz:
    ClangBuiltin<"__mlvm_stream_cvti16_f16_oz">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvti16_f16_up:
    ClangBuiltin<"__mlvm_stream_cvti16_f16_up">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvti16_f16_rd:
    ClangBuiltin<"__mlvm_stream_cvti16_f16_rd">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvti16_f16_rm:
    ClangBuiltin<"__mlvm_stream_cvti16_f16_rm">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvti16_f16_rn:
    ClangBuiltin<"__mlvm_stream_cvti16_f16_rn">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtint8_int16:
    ClangBuiltin<"__mlvm_stream_cvtint8_int16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtint8_int32:
    ClangBuiltin<"__mlvm_stream_cvtint8_int32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtint16_int8:
    ClangBuiltin<"__mlvm_stream_cvtint16_int8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtint16_int32:
    ClangBuiltin<"__mlvm_stream_cvtint16_int32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtint32_int8:
    ClangBuiltin<"__mlvm_stream_cvtint32_int8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtint32_int16:
    ClangBuiltin<"__mlvm_stream_cvtint32_int16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix8_f16_dn_stride:
    ClangBuiltin<"__mlvm_stream_cvtfix8_f16_dn_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;
  def int_mlvm_stream_cvtfix8_f16_tz_stride:
    ClangBuiltin<"__mlvm_stream_cvtfix8_f16_tz_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix8_f16_oz_stride:
    ClangBuiltin<"__mlvm_stream_cvtfix8_f16_oz_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix8_f16_up_stride:
    ClangBuiltin<"__mlvm_stream_cvtfix8_f16_up_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtfix8_f16_rd_stride:
    ClangBuiltin<"__mlvm_stream_cvtfix8_f16_rd_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtf16_fix8_stride:
    ClangBuiltin<"__mlvm_stream_cvtf16_fix8_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtf16_i16_stride:
    ClangBuiltin<"__mlvm_stream_cvtf16_i16_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtf16_u8_stride:
    ClangBuiltin<"__mlvm_stream_cvtf16_u8_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvti16_f16_dn_stride:
    ClangBuiltin<"__mlvm_stream_cvti16_f16_dn_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvti16_f16_tz_stride:
    ClangBuiltin<"__mlvm_stream_cvti16_f16_tz_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvti16_f16_oz_stride:
    ClangBuiltin<"__mlvm_stream_cvti16_f16_oz_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvti16_f16_up_stride:
    ClangBuiltin<"__mlvm_stream_cvti16_f16_up_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvti16_f16_rd_stride:
    ClangBuiltin<"__mlvm_stream_cvti16_f16_rd_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtf32_f16_stride :
    ClangBuiltin<"__mlvm_cvtf32_f16_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtf16_f32_tz_stride :
    ClangBuiltin<"__mlvm_cvtf16_f32_stride_tz">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtf16_f32_dn_stride :
    ClangBuiltin<"__mlvm_cvtf16_f32_stride_dn">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtf16_f32_oz_stride :
    ClangBuiltin<"__mlvm_cvtf16_f32_stride_oz">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtf16_f32_up_stride :
    ClangBuiltin<"__mlvm_cvtf16_f32_stride_up">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtf16_f32_rd_stride :
    ClangBuiltin<"__mlvm_cvtf16_f32_stride_rd">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_breduce_fix8 :
    ClangBuiltin<"__mlvm_stream_breduce_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_breduce_fix16 :
    ClangBuiltin<"__mlvm_stream_breduce_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_breduce_fix32 :
    ClangBuiltin<"__mlvm_stream_breduce_fix32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_bexpand_fix8 :
    ClangBuiltin<"__mlvm_stream_bexpand_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_bexpand_fix16 :
    ClangBuiltin<"__mlvm_stream_bexpand_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_bexpand_fix32 :
    ClangBuiltin<"__mlvm_stream_bexpand_fix32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  //===--------------------------------------------------------------------===//
  // machine learning
  //===--------------------------------------------------------------------===//
  def int_mlvm_stream_conv_f32_bf16_f32 :
    ClangBuiltin<"__mlvm_stream_conv_f32_bf16_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f32_f32_bf16 :
    ClangBuiltin<"__mlvm_stream_conv_f32_f32_bf16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f32_bf16_bf16 :
    ClangBuiltin<"__mlvm_stream_conv_f32_bf16_bf16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f32_f32_f32 :
    ClangBuiltin<"__mlvm_stream_conv_f32_f32_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f32_f16_f16 :
    ClangBuiltin<"__mlvm_stream_conv_f32_f16_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f32_f32_f16 :
    ClangBuiltin<"__mlvm_stream_conv_f32_f32_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f32_f16_f32 :
    ClangBuiltin<"__mlvm_stream_conv_f32_f16_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_dilation_f32_bf16_f32 :
    ClangBuiltin<"__mlvm_stream_conv_dilation_f32_bf16_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_dilation_f32_f32_bf16 :
    ClangBuiltin<"__mlvm_stream_conv_dilation_f32_f32_bf16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_dilation_f32_bf16_bf16 :
    ClangBuiltin<"__mlvm_stream_conv_dilation_f32_bf16_bf16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_dilation_f32_f32_f32 :
    ClangBuiltin<"__mlvm_stream_conv_dilation_f32_f32_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_dilation_f32_f16_f16 :
    ClangBuiltin<"__mlvm_stream_conv_dilation_f32_f16_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_dilation_f32_f32_f16 :
    ClangBuiltin<"__mlvm_stream_conv_dilation_f32_f32_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_dilation_f32_f16_f32 :
    ClangBuiltin<"__mlvm_stream_conv_dilation_f32_f16_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f16_f16_f16 :
    ClangBuiltin<"__mlvm_stream_conv_f16_f16_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f16_fix8_fix8 :
    ClangBuiltin<"__mlvm_stream_conv_f16_fix8_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f16_fix16_fix16 :
    ClangBuiltin<"__mlvm_stream_conv_f16_fix16_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f16_fix16_fix8 :
    ClangBuiltin<"__mlvm_stream_conv_f16_fix16_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f32_fix8_fix8 :
    ClangBuiltin<"__mlvm_stream_conv_f32_fix8_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f32_fix16_fix8 :
    ClangBuiltin<"__mlvm_stream_conv_f32_fix16_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f32_fix16_fix16 :
    ClangBuiltin<"__mlvm_stream_conv_f32_fix16_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_fix16_fix8_fix8 :
    ClangBuiltin<"__mlvm_stream_conv_fix16_fix8_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_fix16_fix16_fix8 :
    ClangBuiltin<"__mlvm_stream_conv_fix16_fix16_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_fix16_fix16_fix16 :
    ClangBuiltin<"__mlvm_stream_conv_fix16_fix16_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f16_fix8_fix8_f16 :
    ClangBuiltin<"__mlvm_stream_conv_f16_fix8_fix8_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f16_fix16_fix16_f16 :
    ClangBuiltin<"__mlvm_stream_conv_f16_fix16_fix16_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f16_fix16_fix8_f16 :
    ClangBuiltin<"__mlvm_stream_conv_f16_fix16_fix8_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f32_fix8_fix8_f32 :
    ClangBuiltin<"__mlvm_stream_conv_f32_fix8_fix8_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f32_fix16_fix8_f32 :
    ClangBuiltin<"__mlvm_stream_conv_f32_fix16_fix8_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f32_fix16_fix16_f32 :
    ClangBuiltin<"__mlvm_stream_conv_f32_fix16_fix16_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_fix16_fix8_fix8_fix16 :
    ClangBuiltin<"__mlvm_stream_conv_fix16_fix8_fix8_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_fix16_fix16_fix8_fix16 :
    ClangBuiltin<"__mlvm_stream_conv_fix16_fix16_fix8_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_fix16_fix16_fix16_fix16 :
    ClangBuiltin<"__mlvm_stream_conv_fix16_fix16_fix16_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  // conv with dilation
  def int_mlvm_stream_conv_f16_fix8_fix8_dilation :
    ClangBuiltin<"__mlvm_stream_conv_f16_fix8_fix8_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f16_fix16_fix16_dilation :
    ClangBuiltin<"__mlvm_stream_conv_f16_fix16_fix16_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f16_fix16_fix8_dilation :
    ClangBuiltin<"__mlvm_stream_conv_f16_fix16_fix8_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f32_fix8_fix8_dilation :
    ClangBuiltin<"__mlvm_stream_conv_f32_fix8_fix8_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f32_fix16_fix8_dilation :
    ClangBuiltin<"__mlvm_stream_conv_f32_fix16_fix8_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f32_fix16_fix16_dilation :
    ClangBuiltin<"__mlvm_stream_conv_f32_fix16_fix16_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_fix16_fix8_fix8_dilation :
    ClangBuiltin<"__mlvm_stream_conv_fix16_fix8_fix8_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_fix16_fix16_fix8_dilation :
    ClangBuiltin<"__mlvm_stream_conv_fix16_fix16_fix8_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_fix16_fix16_fix16_dilation :
    ClangBuiltin<"__mlvm_stream_conv_fix16_fix16_fix16_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f16_fix8_fix8_f16_dilation :
    ClangBuiltin<"__mlvm_stream_conv_f16_fix8_fix8_f16_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f16_fix16_fix16_f16_dilation :
    ClangBuiltin<"__mlvm_stream_conv_f16_fix16_fix16_f16_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f16_fix16_fix8_f16_dilation :
    ClangBuiltin<"__mlvm_stream_conv_f16_fix16_fix8_f16_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f32_fix8_fix8_f32_dilation :
    ClangBuiltin<"__mlvm_stream_conv_f32_fix8_fix8_f32_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f32_fix16_fix8_f32_dilation :
    ClangBuiltin<"__mlvm_stream_conv_f32_fix16_fix8_f32_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_f32_fix16_fix16_f32_dilation :
    ClangBuiltin<"__mlvm_stream_conv_f32_fix16_fix16_f32_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_fix16_fix8_fix8_fix16_dilation :
    ClangBuiltin<"__mlvm_stream_conv_fix16_fix8_fix8_fix16_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_fix16_fix16_fix8_fix16_dilation :
    ClangBuiltin<"__mlvm_stream_conv_fix16_fix16_fix8_fix16_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_fix16_fix16_fix16_fix16_dilation :
    ClangBuiltin<"__mlvm_stream_conv_fix16_fix16_fix16_fix16_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_f16_fix8_fix8_f16 :
    ClangBuiltin<"__mlvm_stream_conv_partial_f16_fix8_fix8_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_f16_fix16_fix8_f16 :
    ClangBuiltin<"__mlvm_stream_conv_partial_f16_fix16_fix8_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_f16_fix16_fix16_f16 :
    ClangBuiltin<"__mlvm_stream_conv_partial_f16_fix16_fix16_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_f32_fix8_fix8_f32 :
    ClangBuiltin<"__mlvm_stream_conv_partial_f32_fix8_fix8_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_f32_fix16_fix8_f32 :
    ClangBuiltin<"__mlvm_stream_conv_partial_f32_fix16_fix8_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_f32_fix16_fix16_f32 :
    ClangBuiltin<"__mlvm_stream_conv_partial_f32_fix16_fix16_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  // conv partial with dilation
  def int_mlvm_stream_conv_partial_f16_int8_int8_f16_dilation :
    ClangBuiltin<"__mlvm_stream_conv_partial_f16_int8_int8_f16_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_f16_int16_int8_f16_dilation :
    ClangBuiltin<"__mlvm_stream_conv_partial_f16_int16_int8_f16_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_f16_int16_int16_f16_dilation :
    ClangBuiltin<"__mlvm_stream_conv_partial_f16_int16_int16_f16_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_f32_int8_int8_f32_dilation :
    ClangBuiltin<"__mlvm_stream_conv_partial_f32_int8_int8_f32_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_f32_int16_int8_f32_dilation :
    ClangBuiltin<"__mlvm_stream_conv_partial_f32_int16_int8_f32_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_f32_int16_int16_f32_dilation :
    ClangBuiltin<"__mlvm_stream_conv_partial_f32_int16_int16_f32_dilation">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_f32_f16_f16_f32 :
    ClangBuiltin<"__mlvm_stream_conv_partial_f32_f16_f16_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_f32_f16_f32_f32 :
    ClangBuiltin<"__mlvm_stream_conv_partial_f32_f16_f32_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_f32_f32_f16_f32 :
    ClangBuiltin<"__mlvm_stream_conv_partial_f32_f32_f16_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_f32_f32_f32_f32 :
    ClangBuiltin<"__mlvm_stream_conv_partial_f32_f32_f32_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_f32_bf16_bf16_f32 :
    ClangBuiltin<"__mlvm_stream_conv_partial_f32_bf16_bf16_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_f32_bf16_f32_f32 :
    ClangBuiltin<"__mlvm_stream_conv_partial_f32_bf16_f32_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_f32_f32_bf16_f32 :
    ClangBuiltin<"__mlvm_stream_conv_partial_f32_f32_bf16_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_dilation_f32_f16_f16_f32 :
    ClangBuiltin<"__mlvm_stream_conv_partial_dilation_f32_f16_f16_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_dilation_f32_f16_f32_f32 :
    ClangBuiltin<"__mlvm_stream_conv_partial_dilation_f32_f16_f32_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_dilation_f32_f32_f16_f32 :
    ClangBuiltin<"__mlvm_stream_conv_partial_dilation_f32_f32_f16_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_dilation_f32_f32_f32_f32 :
    ClangBuiltin<"__mlvm_stream_conv_partial_dilation_f32_f32_f32_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_dilation_f32_bf16_bf16_f32 :
    ClangBuiltin<"__mlvm_stream_conv_partial_dilation_f32_bf16_bf16_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_dilation_f32_bf16_f32_f32 :
    ClangBuiltin<"__mlvm_stream_conv_partial_dilation_f32_bf16_f32_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_conv_partial_dilation_f32_f32_bf16_f32 :
    ClangBuiltin<"__mlvm_stream_conv_partial_dilation_f32_f32_bf16_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_histogram_f16_fix8_fix8 :
    ClangBuiltin<"__mlvm_stream_histogram_f16_fix8_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_histogram_f32_fix8_fix8 :
    ClangBuiltin<"__mlvm_stream_histogram_f32_fix8_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_histogram_s16_fix8_fix8 :
    ClangBuiltin<"__mlvm_stream_histogram_s16_fix8_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_histogram_s32_fix8_fix8 :
    ClangBuiltin<"__mlvm_stream_histogram_s32_fix8_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_histogram_f16_fix16_fix16 :
    ClangBuiltin<"__mlvm_stream_histogram_f16_fix16_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_histogram_f32_fix16_fix16 :
    ClangBuiltin<"__mlvm_stream_histogram_f32_fix16_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_histogram_s16_fix16_fix16 :
    ClangBuiltin<"__mlvm_stream_histogram_s16_fix16_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_histogram_s32_fix16_fix16 :
    ClangBuiltin<"__mlvm_stream_histogram_s32_fix16_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_histogram_f32_f16_f16 :
    ClangBuiltin<"__mlvm_stream_histogram_f32_f16_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_histogram_f32_bf16_bf16 :
    ClangBuiltin<"__mlvm_stream_histogram_f32_bf16_bf16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_integral_s32_s16_s16 :
    ClangBuiltin<"__mlvm_stream_integral_s32_s16_s16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_integral_s16_s16_s16 :
    ClangBuiltin<"__mlvm_stream_integral_s16_s16_s16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_integral_f32_fix16_fix16 :
    ClangBuiltin<"__mlvm_stream_integral_f32_fix16_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_integral_f16_fix16_fix16 :
    ClangBuiltin<"__mlvm_stream_integral_f16_fix16_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_integral_s32_s8_s8 :
    ClangBuiltin<"__mlvm_stream_integral_s32_s8_s8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_integral_s16_s8_s8 :
    ClangBuiltin<"__mlvm_stream_integral_s16_s8_s8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_integral_f32_fix8_fix8 :
    ClangBuiltin<"__mlvm_stream_integral_f32_fix8_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty,  llvm_i32_ty],
              []>;

  def int_mlvm_stream_integral_f16_fix8_fix8 :
    ClangBuiltin<"__mlvm_stream_integral_f16_fix8_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_integral_f32_f32_f32 :
    ClangBuiltin<"__mlvm_stream_integral_f32_f32_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_integral_f32_f16_f16 :
    ClangBuiltin<"__mlvm_stream_integral_f32_f16_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_f16 :
    ClangBuiltin<"__mlvm_stream_active_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_f32 :
    ClangBuiltin<"__mlvm_stream_active_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_relu_f16 :
    ClangBuiltin<"__mlvm_stream_active_relu_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_relu_f32 :
    ClangBuiltin<"__mlvm_stream_active_relu_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_pow2_f16 :
    ClangBuiltin<"__mlvm_stream_active_pow2_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_pow2_f32 :
    ClangBuiltin<"__mlvm_stream_active_pow2_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_gelu_f16 :
    ClangBuiltin<"__mlvm_stream_active_gelu_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_gelu_f32 :
    ClangBuiltin<"__mlvm_stream_active_gelu_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;
  def int_mlvm_stream_active_gelup_f16 :
    ClangBuiltin<"__mlvm_stream_active_gelup_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_gelup_f32 :
    ClangBuiltin<"__mlvm_stream_active_gelup_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_sigmoid_f16 :
    ClangBuiltin<"__mlvm_stream_active_sigmoid_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_sigmoid_hp_f16 :
    ClangBuiltin<"__mlvm_stream_active_sigmoid_hp_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_sigmoid_hp_f32 :
    ClangBuiltin<"__mlvm_stream_active_sigmoid_hp_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_taylor4_sin_f16 :
    ClangBuiltin<"__mlvm_stream_taylor4_sin_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_taylor4_sin_f32 :
    ClangBuiltin<"__mlvm_stream_taylor4_sin_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_taylor3_sin_f16 :
    ClangBuiltin<"__mlvm_stream_taylor3_sin_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_taylor3_sin_f32 :
    ClangBuiltin<"__mlvm_stream_taylor3_sin_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_taylor4_cos_f16 :
    ClangBuiltin<"__mlvm_stream_taylor4_cos_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_taylor4_cos_f32 :
    ClangBuiltin<"__mlvm_stream_taylor4_cos_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_taylor3_cos_f16 :
    ClangBuiltin<"__mlvm_stream_taylor3_cos_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_taylor3_cos_f32 :
    ClangBuiltin<"__mlvm_stream_taylor3_cos_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_taylor4_sigmoid_f16 :
    ClangBuiltin<"__mlvm_stream_taylor4_sigmoid_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_taylor4_sigmoid_f32 :
    ClangBuiltin<"__mlvm_stream_taylor4_sigmoid_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_taylor3_sigmoid_f16 :
    ClangBuiltin<"__mlvm_stream_taylor3_sigmoid_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_taylor3_sigmoid_f32 :
    ClangBuiltin<"__mlvm_stream_taylor3_sigmoid_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_taylor4_softplus_f16 :
    ClangBuiltin<"__mlvm_stream_taylor4_softplus_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_taylor4_softplus_f32 :
    ClangBuiltin<"__mlvm_stream_taylor4_softplus_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_taylor3_softplus_f16 :
    ClangBuiltin<"__mlvm_stream_taylor3_softplus_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_taylor3_softplus_f32 :
    ClangBuiltin<"__mlvm_stream_taylor3_softplus_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_taylor4_tanh_f16 :
    ClangBuiltin<"__mlvm_stream_taylor4_tanh_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_taylor4_tanh_f32 :
    ClangBuiltin<"__mlvm_stream_taylor4_tanh_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_taylor3_tanh_f16 :
    ClangBuiltin<"__mlvm_stream_taylor3_tanh_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_taylor3_tanh_f32 :
    ClangBuiltin<"__mlvm_stream_taylor3_tanh_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_sigmoid_f32 :
    ClangBuiltin<"__mlvm_stream_active_sigmoid_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_tanh_f16 :
    ClangBuiltin<"__mlvm_stream_active_tanh_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_tanh_f32 :
    ClangBuiltin<"__mlvm_stream_active_tanh_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_abs_f16 :
    ClangBuiltin<"__mlvm_stream_active_abs_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_abs_f32 :
    ClangBuiltin<"__mlvm_stream_active_abs_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_exp_f16 :
    ClangBuiltin<"__mlvm_stream_active_exp_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_exp_f32 :
    ClangBuiltin<"__mlvm_stream_active_exp_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_exphp_f16 :
    ClangBuiltin<"__mlvm_stream_active_exphp_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_exphp_f32 :
    ClangBuiltin<"__mlvm_stream_active_exphp_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_explt0_f16 :
    ClangBuiltin<"__mlvm_stream_active_explt0_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_explt0_f32 :
    ClangBuiltin<"__mlvm_stream_active_explt0_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_sqrt_f16 :
    ClangBuiltin<"__mlvm_stream_active_sqrt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_sqrt_f32 :
    ClangBuiltin<"__mlvm_stream_active_sqrt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_sqrthp_f16 :
    ClangBuiltin<"__mlvm_stream_active_sqrthp_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_sqrthp_f32 :
    ClangBuiltin<"__mlvm_stream_active_sqrthp_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_rsqrt_f16 :
    ClangBuiltin<"__mlvm_stream_active_rsqrt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_rsqrt_f32 :
    ClangBuiltin<"__mlvm_stream_active_rsqrt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_rsqrthp_f16 :
    ClangBuiltin<"__mlvm_stream_active_rsqrthp_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_rsqrthp_f32 :
    ClangBuiltin<"__mlvm_stream_active_rsqrthp_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_recip_f16 :
    ClangBuiltin<"__mlvm_stream_active_recip_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_recip_f32 :
    ClangBuiltin<"__mlvm_stream_active_recip_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_reciphp_f16 :
    ClangBuiltin<"__mlvm_stream_active_reciphp_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_reciphp_f32 :
    ClangBuiltin<"__mlvm_stream_active_reciphp_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_recipgt1_f16 :
    ClangBuiltin<"__mlvm_stream_active_recipgt1_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_recipgt1_f32 :
    ClangBuiltin<"__mlvm_stream_active_recipgt1_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_sin_f16 :
    ClangBuiltin<"__mlvm_stream_active_sin_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_sin_f32 :
    ClangBuiltin<"__mlvm_stream_active_sin_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_cos_f16 :
    ClangBuiltin<"__mlvm_stream_active_cos_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_cos_f32 :
    ClangBuiltin<"__mlvm_stream_active_cos_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_log_f16 :
    ClangBuiltin<"__mlvm_stream_active_log_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_log_f32 :
    ClangBuiltin<"__mlvm_stream_active_log_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_loghp_f16 :
    ClangBuiltin<"__mlvm_stream_active_loghp_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_loghp_f32 :
    ClangBuiltin<"__mlvm_stream_active_loghp_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_sign_f16 :
    ClangBuiltin<"__mlvm_stream_active_sign_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_active_sign_f32 :
    ClangBuiltin<"__mlvm_stream_active_sign_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_sin_f32 :
    ClangBuiltin<"__mlvm_stream_sin_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cos_f32 :
    ClangBuiltin<"__mlvm_stream_cos_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_log_f32 :
    ClangBuiltin<"__mlvm_stream_log_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pow2_f32 :
    ClangBuiltin<"__mlvm_stream_pow2_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_sqrt_f32 :
    ClangBuiltin<"__mlvm_stream_sqrt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_recip_f32 :
    ClangBuiltin<"__mlvm_stream_recip_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_rsqrt_f32 :
    ClangBuiltin<"__mlvm_stream_rsqrt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_div_f16 :
    ClangBuiltin<"__mlvm_stream_div_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_div_f32 :
    ClangBuiltin<"__mlvm_stream_div_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_div_s16 :
    ClangBuiltin<"__mlvm_stream_div_s16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_div_s32 :
    ClangBuiltin<"__mlvm_stream_div_s32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_div_u16 :
    ClangBuiltin<"__mlvm_stream_div_u16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_div_u32 :
    ClangBuiltin<"__mlvm_stream_div_u32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_rem_s16 :
    ClangBuiltin<"__mlvm_stream_rem_s16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_rem_s32 :
    ClangBuiltin<"__mlvm_stream_rem_s32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_rem_u16 :
    ClangBuiltin<"__mlvm_stream_rem_u16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_rem_u32 :
    ClangBuiltin<"__mlvm_stream_rem_u32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_div_scalar_f16 :
    ClangBuiltin<"__mlvm_stream_div_scalar_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_div_scalar_f32 :
    ClangBuiltin<"__mlvm_stream_div_scalar_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_div_scalar_s16 :
    ClangBuiltin<"__mlvm_stream_div_scalar_s16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i16_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_div_scalar_s32 :
    ClangBuiltin<"__mlvm_stream_div_scalar_s32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_div_scalar_u16 :
    ClangBuiltin<"__mlvm_stream_div_scalar_u16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i16_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_div_scalar_u32 :
    ClangBuiltin<"__mlvm_stream_div_scalar_u32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_rem_scalar_s16 :
    ClangBuiltin<"__mlvm_stream_rem_scalar_s16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i16_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_rem_scalar_s32 :
    ClangBuiltin<"__mlvm_stream_rem_scalar_s32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_rem_scalar_u16 :
    ClangBuiltin<"__mlvm_stream_rem_scalar_u16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i16_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_rem_scalar_u32 :
    ClangBuiltin<"__mlvm_stream_rem_scalar_u32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_lut_s16 :
    ClangBuiltin<"__mlvm_stream_lut_s16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_lut_s32 :
    ClangBuiltin<"__mlvm_stream_lut_s32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;


  def int_mlvm_stream_rand_s16 :
    ClangBuiltin<"__mlvm_stream_rand_16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem, IntrArgMemOnly]>;

  def int_mlvm_stream_maxpool_f16 :
    ClangBuiltin<"__mlvm_stream_maxpool_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_max_f16 :
    ClangBuiltin<"__mlvm_stream_pool_max_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_max_f32 :
    ClangBuiltin<"__mlvm_stream_pool_max_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_min_f16 :
    ClangBuiltin<"__mlvm_stream_pool_min_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_min_f32 :
    ClangBuiltin<"__mlvm_stream_pool_min_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_avg_f16 :
    ClangBuiltin<"__mlvm_stream_pool_avg_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_avg_f32 :
    ClangBuiltin<"__mlvm_stream_pool_avg_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_sum_f32 :
    ClangBuiltin<"__mlvm_stream_pool_sum_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_avg_bp_f16 :
    ClangBuiltin<"__mlvm_stream_pool_avg_bp_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_avg_bp_f32 :
    ClangBuiltin<"__mlvm_stream_pool_avg_bp_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_avg_bp_cover_f16 :
    ClangBuiltin<"__mlvm_stream_pool_avg_bp_cover_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_avg_bp_cover_f32 :
    ClangBuiltin<"__mlvm_stream_pool_avg_bp_cover_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_max_bp_f16 :
    ClangBuiltin<"__mlvm_stream_pool_max_bp_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_max_bp_f32 :
    ClangBuiltin<"__mlvm_stream_pool_max_bp_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_max_bp_cover_f16 :
    ClangBuiltin<"__mlvm_stream_pool_max_bp_cover_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_max_bp_cover_f32 :
    ClangBuiltin<"__mlvm_stream_pool_max_bp_cover_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_sum_f16 :
    ClangBuiltin<"__mlvm_stream_pool_sum_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_max_index_f16 :
    ClangBuiltin<"__mlvm_stream_pool_max_index_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_max_index_f32 :
    ClangBuiltin<"__mlvm_stream_pool_max_index_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_max_value_index_f16 :
    ClangBuiltin<"__mlvm_stream_pool_max_value_index_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_max_value_index_f32 :
    ClangBuiltin<"__mlvm_stream_pool_max_value_index_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_min_index_f16 :
    ClangBuiltin<"__mlvm_stream_pool_min_index_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_min_index_f32 :
    ClangBuiltin<"__mlvm_stream_pool_min_index_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_min_value_index_f16 :
    ClangBuiltin<"__mlvm_stream_pool_min_value_index_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_pool_min_value_index_f32 :
    ClangBuiltin<"__mlvm_stream_pool_min_value_index_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

 def int_mlvm_stream_minpool_f16 :
    ClangBuiltin<"__mlvm_stream_minpool_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

 def int_mlvm_stream_maximum_f16 :
    ClangBuiltin<"__mlvm_stream_maximum_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

 def int_mlvm_stream_avgpool_f16 :
    ClangBuiltin<"__mlvm_stream_avgpool_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_maxpool_index_f16 :
    ClangBuiltin<"__mlvm_stream_maxpool_index_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_minpool_index_f16 :
    ClangBuiltin<"__mlvm_stream_minpool_index_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_unpool_f16 :
    ClangBuiltin<"__mlvm_stream_unpool_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_unpool_f32 :
    ClangBuiltin<"__mlvm_stream_unpool_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_mlp_f16_fix8_fix8 :
    ClangBuiltin<"__mlvm_stream_mlp_f16_fix8_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_mlp_f16_fix16_fix8 :
    ClangBuiltin<"__mlvm_stream_mlp_f16_fix16_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_mlp_f16_fix16_fix16 :
    ClangBuiltin<"__mlvm_stream_mlp_f16_fix16_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_mlp_f32_fix8_fix8 :
    ClangBuiltin<"__mlvm_stream_mlp_f32_fix8_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_mlp_f32_fix16_fix8 :
    ClangBuiltin<"__mlvm_stream_mlp_f32_fix16_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_mlp_f32_fix16_fix16 :
    ClangBuiltin<"__mlvm_stream_mlp_f32_fix16_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_mlp_fix16_fix8_fix8 :
    ClangBuiltin<"__mlvm_stream_mlp_fix16_fix8_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_mlp_fix16_fix16_fix8 :
    ClangBuiltin<"__mlvm_stream_mlp_fix16_fix16_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_mlp_fix16_fix16_fix16 :
    ClangBuiltin<"__mlvm_stream_mlp_fix16_fix16_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_mlp_f16_f16_f16_f16 :
    ClangBuiltin<"__mlvm_stream_mlp_f16_f16_f16_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_mlp_f16_fix8_f16_fix8 :
    ClangBuiltin<"__mlvm_stream_mlp_f16_fix8_f16_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_mlp_f16_fix16_f16_fix8 :
    ClangBuiltin<"__mlvm_stream_mlp_f16_fix16_f16_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_mlp_f16_fix16_f16_fix16 :
    ClangBuiltin<"__mlvm_stream_mlp_f16_fix16_f16_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_mlp_f32_fix8_f32_fix8 :
    ClangBuiltin<"__mlvm_stream_mlp_f32_fix8_f32_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_mlp_f32_fix16_f32_fix8 :
    ClangBuiltin<"__mlvm_stream_mlp_f32_fix16_f32_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_mlp_f32_fix16_f32_fix16 :
    ClangBuiltin<"__mlvm_stream_mlp_f32_fix16_f32_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_mlp_fix16_fix8_fix16_fix8 :
    ClangBuiltin<"__mlvm_stream_mlp_fix16_fix8_fix16_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_mlp_fix16_fix16_fix16_fix8 :
    ClangBuiltin<"__mlvm_stream_mlp_fix16_fix16_fix16_fix8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_mlp_fix16_fix16_fix16_fix16 :
    ClangBuiltin<"__mlvm_stream_mlp_fix16_fix16_fix16_fix16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_pad_b8 :
    ClangBuiltin<"__mlvm_stream_pad_b8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_pad_b16 :
    ClangBuiltin<"__mlvm_stream_pad_b16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_pad_b32 :
    ClangBuiltin<"__mlvm_stream_pad_b32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_trans_b8 :
    ClangBuiltin<"__mlvm_stream_trans_b8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_trans_b16 :
    ClangBuiltin<"__mlvm_stream_trans_b16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_trans_b32 :
    ClangBuiltin<"__mlvm_stream_trans_b32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_rotate1pi_b16 :
    ClangBuiltin<"__mlvm_stream_rotate1pi_b16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_rotate1pi_b8 :
    ClangBuiltin<"__mlvm_stream_rotate1pi_b8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_rotate1pi_b32 :
    ClangBuiltin<"__mlvm_stream_rotate1pi_b32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_rotate2pi_b16 :
    ClangBuiltin<"__mlvm_stream_rotate2pi_b16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_rotate2pi_b8 :
    ClangBuiltin<"__mlvm_stream_rotate2pi_b8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_rotate2pi_b32 :
    ClangBuiltin<"__mlvm_stream_rotate2pi_b32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_rotate3pi_b16 :
    ClangBuiltin<"__mlvm_stream_rotate3pi_b16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_rotate3pi_b8 :
    ClangBuiltin<"__mlvm_stream_rotate3pi_b8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_rotate3pi_b32 :
    ClangBuiltin<"__mlvm_stream_rotate3pi_b32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_tiling_2d_b8 :
    ClangBuiltin<"__mlvm_stream_tiling_2d_b8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_tiling_2d_b16 :
    ClangBuiltin<"__mlvm_stream_tiling_2d_b16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_tiling_2d_b32 :
    ClangBuiltin<"__mlvm_stream_tiling_2d_b32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_tiling_2d_b64 :
    ClangBuiltin<"__mlvm_stream_tiling_2d_b64">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_tiling_2d_b128 :
    ClangBuiltin<"__mlvm_stream_tiling_2d_b128">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_tiling_2d_b256 :
    ClangBuiltin<"__mlvm_stream_tiling_2d_b256">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_trans_tiling_b8 :
    ClangBuiltin<"__mlvm_stream_trans_tiling_b8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_trans_tiling_b16 :
    ClangBuiltin<"__mlvm_stream_trans_tiling_b16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_trans_tiling_b32 :
    ClangBuiltin<"__mlvm_stream_trans_tiling_b32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_trans_tiling_b64 :
    ClangBuiltin<"__mlvm_stream_trans_tiling_b64">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_trans_tiling_b128 :
    ClangBuiltin<"__mlvm_stream_trans_tiling_b128">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_trans_tiling_b256 :
    ClangBuiltin<"__mlvm_stream_trans_tiling_b256">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_tiling_3d_b1024 :
    ClangBuiltin<"__mlvm_stream_tiling_3d_b1024">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
            []>;

  def int_mlvm_stream_mirror_b8 :
    ClangBuiltin<"__mlvm_stream_mirror_b8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_mirror_b16 :
    ClangBuiltin<"__mlvm_stream_mirror_b16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_mirror_b32 :
    ClangBuiltin<"__mlvm_stream_mirror_b32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_reshape_filter_b8 :
    ClangBuiltin<"__mlvm_stream_reshape_filter_b8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_reshape_filter_b16 :
    ClangBuiltin<"__mlvm_stream_reshape_filter_b16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_reshape_filter_b32 :
    ClangBuiltin<"__mlvm_stream_reshape_filter_b32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_reshape_nhwc2nchw_b8 :
    ClangBuiltin<"__mlvm_stream_reshape_nhwc2nchw_b8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_reshape_nhwc2nchw_b16 :
    ClangBuiltin<"__mlvm_stream_reshape_nhwc2nchw_b16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_reshape_nhwc2nchw_b32 :
    ClangBuiltin<"__mlvm_stream_reshape_nhwc2nchw_b32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_reshape_nchw2nhwc_b8 :
    ClangBuiltin<"__mlvm_stream_reshape_nchw2nhwc_b8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_reshape_nchw2nhwc_b16 :
    ClangBuiltin<"__mlvm_stream_reshape_nchw2nhwc_b16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_stream_reshape_nchw2nhwc_b32 :
    ClangBuiltin<"__mlvm_stream_reshape_nchw2nhwc_b32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty],
            []>;

  def int_mlvm_trc_memcpy_sram_to_sram :
    ClangBuiltin<"__mlvm_trc_memcpy_sram_to_sram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  //===--------------------------------------------------------------------===//
  // memset
  //===--------------------------------------------------------------------===//
  def int_mlvm_memset_nram_s8 :
    ClangBuiltin<"__mlvm_memset_nram_s8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i8_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_nram_f16 :
    ClangBuiltin<"__mlvm_memset_nram_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_half_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_nram_s16 :
    ClangBuiltin<"__mlvm_memset_nram_s16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i16_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_nram_u16 :
    ClangBuiltin<"__mlvm_memset_nram_u16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i16_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_nram_f32 :
    ClangBuiltin<"__mlvm_memset_nram_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_float_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_nram_s32 :
    ClangBuiltin<"__mlvm_memset_nram_s32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_nram_u32 :
    ClangBuiltin<"__mlvm_memset_nram_u32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_nram_stream_s8 :
    ClangBuiltin<"__mlvm_memset_nram_stream_s8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i8_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_nram_stream_f16 :
    ClangBuiltin<"__mlvm_memset_nram_stream_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_half_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_nram_stream_s16 :
    ClangBuiltin<"__mlvm_memset_nram_stream_s16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i16_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_nram_stream_u16 :
    ClangBuiltin<"__mlvm_memset_nram_stream_u16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i16_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_nram_stream_f32 :
    ClangBuiltin<"__mlvm_memset_nram_stream_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_float_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_nram_stream_s32 :
    ClangBuiltin<"__mlvm_memset_nram_stream_s32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_nram_stream_u32 :
    ClangBuiltin<"__mlvm_memset_nram_stream_u32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset3d_nram_stream_s8 :
    ClangBuiltin<"__mlvm_memset3d_nram_stream_s8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i8_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_memset3d_nram_stream_f16 :
    ClangBuiltin<"__mlvm_memset3d_nram_stream_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_half_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_memset3d_nram_stream_s16 :
    ClangBuiltin<"__mlvm_memset3d_nram_stream_s16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i16_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_memset3d_nram_stream_u16 :
    ClangBuiltin<"__mlvm_memset3d_nram_stream_u16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i16_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_memset3d_nram_stream_f32 :
    ClangBuiltin<"__mlvm_memset3d_nram_stream_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_float_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_memset3d_nram_stream_s32 :
    ClangBuiltin<"__mlvm_memset3d_nram_stream_s32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_memset3d_nram_stream_u32 :
    ClangBuiltin<"__mlvm_memset3d_nram_stream_u32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_memset_gdram_s8 :
    ClangBuiltin<"__mlvm_memset_gdram_s8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i8_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_gdram_f16 :
    ClangBuiltin<"__mlvm_memset_gdram_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_half_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_gdram_s16 :
    ClangBuiltin<"__mlvm_memset_gdram_s16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i16_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_gdram_u16 :
    ClangBuiltin<"__mlvm_memset_gdram_u16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i16_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_gdram_f32 :
    ClangBuiltin<"__mlvm_memset_gdram_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_float_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_gdram_s32 :
    ClangBuiltin<"__mlvm_memset_gdram_s32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_gdram_u32 :
    ClangBuiltin<"__mlvm_memset_gdram_u32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_sram_s8 :
    ClangBuiltin<"__mlvm_memset_sram_s8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i8_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_sram_f16 :
    ClangBuiltin<"__mlvm_memset_sram_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_half_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_sram_s16 :
    ClangBuiltin<"__mlvm_memset_sram_s16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i16_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_sram_u16 :
    ClangBuiltin<"__mlvm_memset_sram_u16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i16_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_sram_f32 :
    ClangBuiltin<"__mlvm_memset_sram_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_float_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_sram_s32 :
    ClangBuiltin<"__mlvm_memset_sram_s32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_sram_u32 :
    ClangBuiltin<"__mlvm_memset_sram_u32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_ldram_s8 :
    ClangBuiltin<"__mlvm_memset_ldram_s8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i8_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_ldram_f16 :
    ClangBuiltin<"__mlvm_memset_ldram_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_half_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_ldram_s16 :
    ClangBuiltin<"__mlvm_memset_ldram_s16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i16_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_ldram_u16 :
    ClangBuiltin<"__mlvm_memset_ldram_u16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i16_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_ldram_f32 :
    ClangBuiltin<"__mlvm_memset_ldram_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_float_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_ldram_s32 :
    ClangBuiltin<"__mlvm_memset_ldram_s32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
            [IntrWriteMem]>;

  def int_mlvm_memset_ldram_u32 :
    ClangBuiltin<"__mlvm_memset_ldram_u32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
            [IntrWriteMem]>;

  //===--------------------------------------------------------------------===//
  // stream compute
  //===--------------------------------------------------------------------===//
  def int_mlvm_stream_add_f16 :
    ClangBuiltin<"__mlvm_stream_add_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_add_f32 :
    ClangBuiltin<"__mlvm_stream_add_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_sub_f16 :
    ClangBuiltin<"__mlvm_stream_sub_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_sub_f32 :
    ClangBuiltin<"__mlvm_stream_sub_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_mul_f16 :
    ClangBuiltin<"__mlvm_stream_mul_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_mul_f32 :
    ClangBuiltin<"__mlvm_stream_mul_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_mulh_s16 :
    ClangBuiltin<"__mlvm_stream_mulh_s16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_mulh_s32 :
    ClangBuiltin<"__mlvm_stream_mulh_s32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_eq_f16 :
    ClangBuiltin<"__mlvm_stream_eq_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_ne_f16 :
    ClangBuiltin<"__mlvm_stream_ne_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_lt_f16 :
    ClangBuiltin<"__mlvm_stream_lt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_ge_f16 :
    ClangBuiltin<"__mlvm_stream_ge_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_gt_f16 :
    ClangBuiltin<"__mlvm_stream_gt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_le_f16 :
    ClangBuiltin<"__mlvm_stream_le_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_eq_bitindex_f16 :
    ClangBuiltin<"__mlvm_stream_eq_bitindex_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_ne_bitindex_f16 :
    ClangBuiltin<"__mlvm_stream_ne_bitindex_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_lt_bitindex_f16 :
    ClangBuiltin<"__mlvm_stream_lt_bitindex_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_ge_bitindex_f16 :
    ClangBuiltin<"__mlvm_stream_ge_bitindex_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_gt_bitindex_f16 :
    ClangBuiltin<"__mlvm_stream_gt_bitindex_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_le_bitindex_f16 :
    ClangBuiltin<"__mlvm_stream_le_bitindex_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_eq_f32 :
    ClangBuiltin<"__mlvm_stream_eq_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_ne_f32 :
    ClangBuiltin<"__mlvm_stream_ne_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_lt_f32 :
    ClangBuiltin<"__mlvm_stream_lt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_ge_f32 :
    ClangBuiltin<"__mlvm_stream_ge_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_gt_f32 :
    ClangBuiltin<"__mlvm_stream_gt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_le_f32 :
    ClangBuiltin<"__mlvm_stream_le_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_eq_bitindex_f32 :
    ClangBuiltin<"__mlvm_stream_eq_bitindex_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_ne_bitindex_f32 :
    ClangBuiltin<"__mlvm_stream_ne_bitindex_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_lt_bitindex_f32 :
    ClangBuiltin<"__mlvm_stream_lt_bitindex_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_ge_bitindex_f32 :
    ClangBuiltin<"__mlvm_stream_ge_bitindex_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_gt_bitindex_f32 :
    ClangBuiltin<"__mlvm_stream_gt_bitindex_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_le_bitindex_f32 :
    ClangBuiltin<"__mlvm_stream_le_bitindex_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fabsmax_f16 :
    ClangBuiltin<"__mlvm_stream_fabsmax_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fabsmax_f32 :
    ClangBuiltin<"__mlvm_stream_fabsmax_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fabsmin_f16 :
    ClangBuiltin<"__mlvm_stream_fabsmin_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fabsmin_f32 :
    ClangBuiltin<"__mlvm_stream_fabsmin_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_eq_vec_vec_f16 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_eq_vec_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_eq_vec_flt_f16 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_eq_vec_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_eq_vec_vec_f32 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_eq_vec_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_eq_vec_flt_f32 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_eq_vec_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_ne_vec_vec_f16 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_ne_vec_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_ne_vec_flt_f16 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_ne_vec_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_ne_vec_vec_f32 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_ne_vec_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_ne_vec_flt_f32 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_ne_vec_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_lt_vec_vec_f16 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_lt_vec_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_lt_vec_flt_f16 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_lt_vec_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_lt_vec_vec_f32 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_lt_vec_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_lt_vec_flt_f32 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_lt_vec_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_le_vec_vec_f16 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_le_vec_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_le_vec_flt_f16 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_le_vec_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_le_vec_vec_f32 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_le_vec_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_le_vec_flt_f32 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_le_vec_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_gt_vec_vec_f16 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_gt_vec_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_gt_vec_flt_f16 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_gt_vec_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_gt_vec_vec_f32 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_gt_vec_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_gt_vec_flt_f32 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_gt_vec_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_ge_vec_vec_f16 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_ge_vec_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_ge_vec_flt_f16 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_ge_vec_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_ge_vec_vec_f32 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_ge_vec_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fcmpfilter_ge_vec_flt_f32 :
    ClangBuiltin<"__mlvm_stream_fcmpfilter_ge_vec_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_minequal_f16 :
    ClangBuiltin<"__mlvm_stream_minequal_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_maxequal_f16 :
    ClangBuiltin<"__mlvm_stream_maxequal_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_minequal_f32 :
    ClangBuiltin<"__mlvm_stream_minequal_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_maxequal_f32 :
    ClangBuiltin<"__mlvm_stream_maxequal_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_and_f16 :
    ClangBuiltin<"__mlvm_stream_and_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_or_f16 :
    ClangBuiltin<"__mlvm_stream_or_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_xor_f16:
    ClangBuiltin<"__mlvm_stream_xor_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_and_f32 :
    ClangBuiltin<"__mlvm_stream_and_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_or_f32 :
    ClangBuiltin<"__mlvm_stream_or_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_xor_f32 :
    ClangBuiltin<"__mlvm_stream_xor_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_band_b8 :
    ClangBuiltin<"__mlvm_stream_band_b8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_bor_b8 :
    ClangBuiltin<"__mlvm_stream_bor_b8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_bxor_b8 :
    ClangBuiltin<"__mlvm_stream_bxor_b8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_bnot_b8 :
    ClangBuiltin<"__mlvm_stream_bnot_b8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_max_f16 :
    ClangBuiltin<"__mlvm_stream_max_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_min_f16 :
    ClangBuiltin<"__mlvm_stream_min_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_max_f32 :
    ClangBuiltin<"__mlvm_stream_max_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_min_f32 :
    ClangBuiltin<"__mlvm_stream_min_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_argmax_f16 :
    ClangBuiltin<"__mlvm_stream_argmax_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_argmax_f32 :
    ClangBuiltin<"__mlvm_stream_argmax_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_argmin_f16 :
    ClangBuiltin<"__mlvm_stream_argmin_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_argmin_f32 :
    ClangBuiltin<"__mlvm_stream_argmin_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_select_f16 :
    ClangBuiltin<"__mlvm_stream_select_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_select_f32 :
    ClangBuiltin<"__mlvm_stream_select_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_select_bitindex_f16 :
    ClangBuiltin<"__mlvm_stream_select_bitindex_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_select_bitindex_f32 :
    ClangBuiltin<"__mlvm_stream_select_bitindex_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_maskmove_f16 :
    ClangBuiltin<"__mlvm_stream_maskmove_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_maskmove_f32 :
    ClangBuiltin<"__mlvm_stream_maskmove_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_collect_f16 :
    ClangBuiltin<"__mlvm_stream_collect_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_collect_f32 :
    ClangBuiltin<"__mlvm_stream_collect_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_collect_bitindex_f16 :
    ClangBuiltin<"__mlvm_stream_collect_bitindex_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_collect_bitindex_f32 :
    ClangBuiltin<"__mlvm_stream_collect_bitindex_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_add_const_f16 :
    ClangBuiltin<"__mlvm_stream_add_const_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_add_const_f32 :
    ClangBuiltin<"__mlvm_stream_add_const_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_sub_const_f16 :
    ClangBuiltin<"__mlvm_stream_sub_const_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_sub_const_f32 :
    ClangBuiltin<"__mlvm_stream_sub_const_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_mul_const_f16 :
    ClangBuiltin<"__mlvm_stream_mul_const_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_mul_const_f32 :
    ClangBuiltin<"__mlvm_stream_mul_const_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_maxeq_scalar_f16 :
    ClangBuiltin<"__mlvm_stream_maxeq_scalar_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_maxeq_scalar_f32 :
    ClangBuiltin<"__mlvm_stream_maxeq_scalar_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_mineq_scalar_f16 :
    ClangBuiltin<"__mlvm_stream_mineq_scalar_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_mineq_scalar_f32 :
    ClangBuiltin<"__mlvm_stream_mineq_scalar_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_eq_scalar_f16 :
    ClangBuiltin<"__mlvm_stream_eq_scalar_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_eq_scalar_f32 :
    ClangBuiltin<"__mlvm_stream_eq_scalar_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_ne_scalar_f16 :
    ClangBuiltin<"__mlvm_stream_ne_scalar_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_ne_scalar_f32 :
    ClangBuiltin<"__mlvm_stream_ne_scalar_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_lt_scalar_f16 :
    ClangBuiltin<"__mlvm_stream_lt_scalar_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_lt_scalar_f32 :
    ClangBuiltin<"__mlvm_stream_lt_scalar_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_le_scalar_f16 :
    ClangBuiltin<"__mlvm_stream_le_scalar_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_le_scalar_f32 :
    ClangBuiltin<"__mlvm_stream_le_scalar_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_gt_scalar_f16 :
    ClangBuiltin<"__mlvm_stream_gt_scalar_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_gt_scalar_f32 :
    ClangBuiltin<"__mlvm_stream_gt_scalar_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_and_scalar_f16 :
    ClangBuiltin<"__mlvm_stream_and_scalar_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_and_scalar_f32 :
    ClangBuiltin<"__mlvm_stream_and_scalar_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_or_scalar_f16 :
    ClangBuiltin<"__mlvm_stream_or_scalar_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_or_scalar_f32 :
    ClangBuiltin<"__mlvm_stream_or_scalar_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_xor_scalar_f16 :
    ClangBuiltin<"__mlvm_stream_xor_scalar_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_xor_scalar_f32 :
    ClangBuiltin<"__mlvm_stream_xor_scalar_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_band_scalar_f16 :
    ClangBuiltin<"__mlvm_stream_band_scalar_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_band_scalar_f32 :
    ClangBuiltin<"__mlvm_stream_band_scalar_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_bor_scalar_f16 :
    ClangBuiltin<"__mlvm_stream_bor_scalar_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_bor_scalar_f32 :
    ClangBuiltin<"__mlvm_stream_bor_scalar_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_bxor_scalar_f16 :
    ClangBuiltin<"__mlvm_stream_bxor_scalar_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_bxor_scalar_f32 :
    ClangBuiltin<"__mlvm_stream_bxor_scalar_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fma_vec_vec_vec_f32 :
    ClangBuiltin<"__mlvm_stream_fma_vec_vec_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fma_vec_vec_flt_f32 :
    ClangBuiltin<"__mlvm_stream_fma_vec_vec_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fma_vec_flt_vec_f32 :
    ClangBuiltin<"__mlvm_stream_fma_vec_flt_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fma_vec_flt_flt_f32 :
    ClangBuiltin<"__mlvm_stream_fma_vec_flt_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_float_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_fma_vec_vec_vec_f16 :
    ClangBuiltin<"__mlvm_stream_fma_vec_vec_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fma_vec_vec_flt_f16 :
    ClangBuiltin<"__mlvm_stream_fma_vec_vec_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fma_vec_flt_vec_f16 :
    ClangBuiltin<"__mlvm_stream_fma_vec_flt_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fma_vec_flt_flt_f16 :
    ClangBuiltin<"__mlvm_stream_fma_vec_flt_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_half_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_fms_vec_vec_vec_f32 :
    ClangBuiltin<"__mlvm_stream_fms_vec_vec_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fms_vec_vec_flt_f32 :
    ClangBuiltin<"__mlvm_stream_fms_vec_vec_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fms_vec_flt_vec_f32 :
    ClangBuiltin<"__mlvm_stream_fms_vec_flt_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fms_vec_flt_flt_f32 :
    ClangBuiltin<"__mlvm_stream_fms_vec_flt_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_float_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_fms_vec_vec_vec_f16 :
    ClangBuiltin<"__mlvm_stream_fms_vec_vec_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fms_vec_vec_flt_f16 :
    ClangBuiltin<"__mlvm_stream_fms_vec_vec_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fms_vec_flt_vec_f16 :
    ClangBuiltin<"__mlvm_stream_fms_vec_flt_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fms_vec_flt_flt_f16 :
    ClangBuiltin<"__mlvm_stream_fms_vec_flt_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_half_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_fam_vec_vec_vec_f32 :
    ClangBuiltin<"__mlvm_stream_fam_vec_vec_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fam_vec_vec_flt_f32 :
    ClangBuiltin<"__mlvm_stream_fam_vec_vec_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fam_vec_flt_vec_f32 :
    ClangBuiltin<"__mlvm_stream_fam_vec_flt_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fam_vec_flt_flt_f32 :
    ClangBuiltin<"__mlvm_stream_fam_vec_flt_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_float_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_fam_vec_vec_vec_f16 :
    ClangBuiltin<"__mlvm_stream_fam_vec_vec_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fam_vec_vec_flt_f16 :
    ClangBuiltin<"__mlvm_stream_fam_vec_vec_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fam_vec_flt_vec_f16 :
    ClangBuiltin<"__mlvm_stream_fam_vec_flt_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fam_vec_flt_flt_f16 :
    ClangBuiltin<"__mlvm_stream_fam_vec_flt_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_half_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_fsm_vec_vec_vec_f32 :
    ClangBuiltin<"__mlvm_stream_fsm_vec_vec_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fsm_vec_vec_flt_f32 :
    ClangBuiltin<"__mlvm_stream_fsm_vec_vec_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fsm_vec_flt_vec_f32 :
    ClangBuiltin<"__mlvm_stream_fsm_vec_flt_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fsm_vec_flt_flt_f32 :
    ClangBuiltin<"__mlvm_stream_fsm_vec_flt_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_float_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_fsm_vec_vec_vec_f16 :
    ClangBuiltin<"__mlvm_stream_fsm_vec_vec_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fsm_vec_vec_flt_f16 :
    ClangBuiltin<"__mlvm_stream_fsm_vec_vec_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fsm_vec_flt_vec_f16 :
    ClangBuiltin<"__mlvm_stream_fsm_vec_flt_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fsm_vec_flt_flt_f16 :
    ClangBuiltin<"__mlvm_stream_fsm_vec_flt_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_half_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_faa_vec_vec_vec_f32 :
    ClangBuiltin<"__mlvm_stream_faa_vec_vec_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_faa_vec_vec_flt_f32 :
    ClangBuiltin<"__mlvm_stream_faa_vec_vec_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_faa_vec_flt_vec_f32 :
    ClangBuiltin<"__mlvm_stream_faa_vec_flt_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_faa_vec_flt_flt_f32 :
    ClangBuiltin<"__mlvm_stream_faa_vec_flt_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_float_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_faa_vec_vec_vec_f16 :
    ClangBuiltin<"__mlvm_stream_faa_vec_vec_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_faa_vec_vec_flt_f16 :
    ClangBuiltin<"__mlvm_stream_faa_vec_vec_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_faa_vec_flt_vec_f16 :
    ClangBuiltin<"__mlvm_stream_faa_vec_flt_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_faa_vec_flt_flt_f16 :
    ClangBuiltin<"__mlvm_stream_faa_vec_flt_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_half_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_fas_vec_vec_vec_f32 :
    ClangBuiltin<"__mlvm_stream_fas_vec_vec_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fas_vec_vec_flt_f32 :
    ClangBuiltin<"__mlvm_stream_fas_vec_vec_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fas_vec_flt_vec_f32 :
    ClangBuiltin<"__mlvm_stream_fas_vec_flt_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fas_vec_flt_flt_f32 :
    ClangBuiltin<"__mlvm_stream_fas_vec_flt_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_float_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_fas_vec_vec_vec_f16 :
    ClangBuiltin<"__mlvm_stream_fas_vec_vec_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fas_vec_vec_flt_f16 :
    ClangBuiltin<"__mlvm_stream_fas_vec_vec_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fas_vec_flt_vec_f16 :
    ClangBuiltin<"__mlvm_stream_fas_vec_flt_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fas_vec_flt_flt_f16 :
    ClangBuiltin<"__mlvm_stream_fas_vec_flt_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_half_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_fss_vec_vec_vec_f32 :
    ClangBuiltin<"__mlvm_stream_fss_vec_vec_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fss_vec_vec_flt_f32 :
    ClangBuiltin<"__mlvm_stream_fss_vec_vec_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fss_vec_flt_vec_f32 :
    ClangBuiltin<"__mlvm_stream_fss_vec_flt_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fss_vec_flt_flt_f32 :
    ClangBuiltin<"__mlvm_stream_fss_vec_flt_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_float_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_fss_vec_vec_vec_f16 :
    ClangBuiltin<"__mlvm_stream_fss_vec_vec_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fss_vec_vec_flt_f16 :
    ClangBuiltin<"__mlvm_stream_fss_vec_vec_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fss_vec_flt_vec_f16 :
    ClangBuiltin<"__mlvm_stream_fss_vec_flt_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fss_vec_flt_flt_f16 :
    ClangBuiltin<"__mlvm_stream_fss_vec_flt_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_half_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_fsa_vec_vec_vec_f32 :
    ClangBuiltin<"__mlvm_stream_fsa_vec_vec_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fsa_vec_vec_flt_f32 :
    ClangBuiltin<"__mlvm_stream_fsa_vec_vec_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fsa_vec_flt_vec_f32 :
    ClangBuiltin<"__mlvm_stream_fsa_vec_flt_vec_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fsa_vec_flt_flt_f32 :
    ClangBuiltin<"__mlvm_stream_fsa_vec_flt_flt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_float_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_fsa_vec_vec_vec_f16 :
    ClangBuiltin<"__mlvm_stream_fsa_vec_vec_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fsa_vec_vec_flt_f16 :
    ClangBuiltin<"__mlvm_stream_fsa_vec_vec_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fsa_vec_flt_vec_f16 :
    ClangBuiltin<"__mlvm_stream_fsa_vec_flt_vec_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_fsa_vec_flt_flt_f16 :
    ClangBuiltin<"__mlvm_stream_fsa_vec_flt_flt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_half_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_add_f16 :
    ClangBuiltin<"__mlvm_stream_cycle_add_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_add_f32 :
    ClangBuiltin<"__mlvm_stream_cycle_add_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_add_s32 :
    ClangBuiltin<"__mlvm_stream_cycle_add_s32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_add_s16 :
    ClangBuiltin<"__mlvm_stream_cycle_add_s16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_sub_f16 :
    ClangBuiltin<"__mlvm_stream_cycle_sub_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_sub_f32 :
    ClangBuiltin<"__mlvm_stream_cycle_sub_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_maxequal_f16 :
    ClangBuiltin<"__mlvm_stream_cycle_maxequal_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_maxequal_f32 :
    ClangBuiltin<"__mlvm_stream_cycle_maxequal_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_minequal_f16 :
    ClangBuiltin<"__mlvm_stream_cycle_minequal_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_minequal_f32 :
    ClangBuiltin<"__mlvm_stream_cycle_minequal_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_mul_f16 :
    ClangBuiltin<"__mlvm_stream_cycle_mul_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_mul_f32 :
    ClangBuiltin<"__mlvm_stream_cycle_mul_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_mul_s32 :
    ClangBuiltin<"__mlvm_stream_cycle_mul_s32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_mul_s16 :
    ClangBuiltin<"__mlvm_stream_cycle_mul_s16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_mulh_s32 :
    ClangBuiltin<"__mlvm_stream_cycle_mulh_s32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_mulh_s16 :
    ClangBuiltin<"__mlvm_stream_cycle_mulh_s16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_eq_f16 :
    ClangBuiltin<"__mlvm_stream_cycle_eq">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_eq_f32 :
    ClangBuiltin<"__mlvm_stream_cycle_eq_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_ne_f16 :
    ClangBuiltin<"___mlvm_stream_cycle_ne_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_ne_f32 :
    ClangBuiltin<"___mlvm_stream_cycle_ne_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_lt_f16 :
    ClangBuiltin<"__mlvm_stream_cycle_lt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_lt_f32 :
    ClangBuiltin<"__mlvm_stream_cycle_lt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_ge_f16 :
    ClangBuiltin<"__mlvm_stream_cycle_ge_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_ge_f32 :
    ClangBuiltin<"__mlvm_stream_cycle_ge_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_gt_f16 :
    ClangBuiltin<"__mlvm_stream_cycle_gt_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_gt_f32 :
    ClangBuiltin<"__mlvm_stream_cycle_gt_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_le_f16 :
    ClangBuiltin<"__mlvm_stream_cycle_le_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_le_f32 :
    ClangBuiltin<"__mlvm_stream_cycle_le_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_band_b8 :
    ClangBuiltin<"__mlvm_stream_cycle_band_b8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_bor_b8 :
    ClangBuiltin<"__mlvm_stream_cycle_bor_b8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

 def int_mlvm_stream_cycle_bxor_b8 :
    ClangBuiltin<"__mlvm_stream_cycle_bxor_b8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_and_f16 :
    ClangBuiltin<"__mlvm_stream_cycle_and_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_and_f32 :
    ClangBuiltin<"__mlvm_stream_cycle_and_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_or_f16 :
    ClangBuiltin<"__mlvm_stream_cycle_or_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_or_f32 :
    ClangBuiltin<"__mlvm_stream_cycle_or_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_xor_f16 :
    ClangBuiltin<"__mlvm_stream_cycle_xor_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cycle_xor_f32 :
    ClangBuiltin<"__mlvm_stream_cycle_xor_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty],
              []>;

  // def int_mlvm_stream_active :
  //   ClangBuiltin<"__mlvm_stream_active">,
  //   Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty, llvm_ptr_ty,
  //                  llvm_i32_ty],
  //             []>;

  def int_mlvm_stream_not_f16 :
    ClangBuiltin<"__mlvm_stream_not_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_not_f32 :
    ClangBuiltin<"__mlvm_stream_not_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_count_f16 :
    ClangBuiltin<"__mlvm_stream_count_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_count_f32 :
    ClangBuiltin<"__mlvm_stream_count_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_count_bitindex_f16 :
    ClangBuiltin<"__mlvm_stream_count_bitindex_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_count_bitindex_f32 :
    ClangBuiltin<"__mlvm_stream_count_bitindex_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_square_f16 :
    ClangBuiltin<"__mlvm_stream_square_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_square_f32 :
    ClangBuiltin<"__mlvm_stream_square_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_findfirst1_f16 :
    ClangBuiltin<"__mlvm_stream_findfirst1_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_findfirst1_f32 :
    ClangBuiltin<"__mlvm_stream_findfirst1_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_findlast1_f16 :
    ClangBuiltin<"__mlvm_stream_findlast1_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_findlast1_f32 :
    ClangBuiltin<"__mlvm_stream_findlast1_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_reduce_sum_f16 :
    ClangBuiltin<"__mlvm_stream_reduce_sum_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_reduce_sum_f32 :
    ClangBuiltin<"__mlvm_stream_reduce_sum_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_relu_f16 :
    ClangBuiltin<"__mlvm_stream_relu_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_relu_f32 :
    ClangBuiltin<"__mlvm_stream_relu_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_relun_f16 :
    ClangBuiltin<"__mlvm_stream_relun_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_half_ty],
              []>;

  def int_mlvm_stream_relun_f32 :
    ClangBuiltin<"__mlvm_stream_relun_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_float_ty],
              []>;

  def int_mlvm_stream_write_zero_f16 :
    ClangBuiltin<"__mlvm_stream_write_zero_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_write_zero_f32 :
    ClangBuiltin<"__mlvm_stream_write_zero_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_cvtf32_f16 :
    ClangBuiltin<"__mlvm_stream_cvtf32_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_cvtf16_f32_tz :
    ClangBuiltin<"__mlvm_stream_cvtf16_f32_tz">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_cvtf16_f32_dn :
    ClangBuiltin<"__mlvm_stream_cvtf16_f32_dn">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_cvtf16_f32_oz :
    ClangBuiltin<"__mlvm_stream_cvtf16_f32_oz">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_cvtf16_f32_up :
    ClangBuiltin<"__mlvm_stream_cvtf16_f32_up">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_cvtf16_f32_rd :
    ClangBuiltin<"__mlvm_stream_cvtf16_f32_rd">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_cvtf16_f32_rm :
    ClangBuiltin<"__mlvm_stream_cvtf16_f32_rm">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtf16_f32_rn :
    ClangBuiltin<"__mlvm_stream_cvtf16_f32_rn">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_cvtf32_bf16_rm :
    ClangBuiltin<"__mlvm_stream_cvtf32_bf16_rm">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_cvtf32_bf16_rn :
    ClangBuiltin<"__mlvm_stream_cvtf32_bf16_rn">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_cvtf32_bf16_rd :
    ClangBuiltin<"__mlvm_stream_cvtf32_bf16_rd">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_cvtf32_bf16_up :
    ClangBuiltin<"__mlvm_stream_cvtf32_bf16_up">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_cvtf32_bf16_oz :
    ClangBuiltin<"__mlvm_stream_cvtf32_bf16_oz">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_cvtf32_bf16_dn :
    ClangBuiltin<"__mlvm_stream_cvtf32_bf16_dn">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_cvtf32_bf16_tz :
    ClangBuiltin<"__mlvm_stream_cvtf32_bf16_tz">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_cvtbf16_f32_tz :
    ClangBuiltin<"__mlvm_stream_cvtbf16_f32_tz">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_cvtbf16_f32_dn :
    ClangBuiltin<"__mlvm_stream_cvtbf16_f32_dn">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_cvtbf16_f32_oz :
    ClangBuiltin<"__mlvm_stream_cvtbf16_f32_oz">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_cvtbf16_f32_up :
    ClangBuiltin<"__mlvm_stream_cvtbf16_f32_up">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_cvtbf16_f32_rd :
    ClangBuiltin<"__mlvm_stream_cvtbf16_f32_rd">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_cvtbf16_f32_rm :
    ClangBuiltin<"__mlvm_stream_cvtbf16_f32_rm">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  def int_mlvm_stream_cvtbf16_f32_rn :
    ClangBuiltin<"__mlvm_stream_cvtbf16_f32_rn">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              [IntrWriteMem]>;

  //===--------------------------------------------------------------------===//
  // accelerated memcpy nram<->nram with stride
  //===--------------------------------------------------------------------===//
  def int_mlvm_memcpy_nram_to_nram_stride_fast :
    ClangBuiltin<"__mlvm_memcpy_nram_to_nram_stride_fast">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  //===--------------------------------------------------------------------===//
  // memcpy
  //===--------------------------------------------------------------------===//
  def int_mlvm_nram_to_nram:
	  ClangBuiltin<"__mlvm_nram_to_nram">,
		Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
		          []>;

  def int_mlvm_nram_to_nram_async:
	  ClangBuiltin<"__mlvm_nram_to_nram_async">,
		Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
		          []>;

  def int_mlvm_nram_to_wram:
	  ClangBuiltin<"__mlvm_nram_to_wram">,
		Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
		          []>;

  def int_mlvm_nram_to_wram_async:
	  ClangBuiltin<"__mlvm_nram_to_wram_async">,
		Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
		          []>;

  def int_mlvm_nram_to_sram:
	  ClangBuiltin<"__mlvm_nram_to_sram">,
		Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
		          []>;

  def int_mlvm_nram_to_sram_async:
	  ClangBuiltin<"__mlvm_nram_to_sram_async">,
		Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
		          []>;

  def int_mlvm_nram_to_sram_stride:
	  ClangBuiltin<"__mlvm_nram_to_sram_stride">,
		Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
		          []>;

  def int_mlvm_nram_to_sram_stride_async:
	  ClangBuiltin<"__mlvm_nram_to_sram_stride_async">,
		Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
		          []>;

  def int_mlvm_nram_to_ldram :
    ClangBuiltin<"__mlvm_nram_to_ldram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_nram_to_ldram_async :
    ClangBuiltin<"__mlvm_nram_to_ldram_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_nram_to_ldram_stride :
    ClangBuiltin<"__mlvm_nram_to_ldram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_nram_to_ldram_stride_async :
    ClangBuiltin<"__mlvm_nram_to_ldram_stride_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_gdram :
    ClangBuiltin<"__mlvm_gdram_to_gdram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_ldram :
    ClangBuiltin<"__mlvm_gdram_to_ldram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_gdram :
    ClangBuiltin<"__mlvm_ldram_to_gdram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_nram_to_gdram :
    ClangBuiltin<"__mlvm_nram_to_gdram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_nram_to_gdram_async :
    ClangBuiltin<"__mlvm_nram_to_gdram_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_nram_to_gdram_stride:
    ClangBuiltin<"__mlvm_nram_to_gdram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_nram_to_gdram_stride_async:
    ClangBuiltin<"__mlvm_nram_to_gdram_stride_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_wram_to_nram:
	  ClangBuiltin<"__mlvm_wram_to_nram">,
		Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
		          []>;

  def int_mlvm_wram_to_nram_async:
	  ClangBuiltin<"__mlvm_wram_to_nram_async">,
		Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
		          []>;

  def int_mlvm_wram_to_sram:
	  ClangBuiltin<"__mlvm_wram_to_sram">,
		Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
		          []>;

  def int_mlvm_wram_to_sram_async:
	  ClangBuiltin<"__mlvm_wram_to_sram_async">,
		Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
		          []>;

  def int_mlvm_wram_to_ldram :
    ClangBuiltin<"__mlvm_wram_to_ldram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_wram_to_ldram_stride :
    ClangBuiltin<"__mlvm_wram_to_ldram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_wram_to_ldram_stride_async :
    ClangBuiltin<"__mlvm_wram_to_ldram_stride_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_wram_to_gdram :
    ClangBuiltin<"__mlvm_wram_to_gdram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_wram_to_gdram_stride :
    ClangBuiltin<"__mlvm_wram_to_gdram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_wram_to_gdram_stride_async :
    ClangBuiltin<"__mlvm_wram_to_gdram_stride_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_nram:
    ClangBuiltin<"__mlvm_sram_to_nram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_nram_async:
    ClangBuiltin<"__mlvm_sram_to_nram_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_nram_stride:
    ClangBuiltin<"__mlvm_sram_to_nram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
              llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_nram_stride_async:
    ClangBuiltin<"__mlvm_sram_to_nram_stride_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_wram:
    ClangBuiltin<"__mlvm_sram_to_wram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_wram_async:
    ClangBuiltin<"__mlvm_sram_to_wram_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_wram_stride :
    ClangBuiltin<"__mlvm_sram_to_wram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_sram:
    ClangBuiltin<"__mlvm_sram_to_sram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_sram_stride:
    ClangBuiltin<"__mlvm_sram_to_sram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
	      []>;

  def int_mlvm_sram_to_ldram:
    ClangBuiltin<"__mlvm_sram_to_ldram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_ldram_stride :
    ClangBuiltin<"__mlvm_sram_to_ldram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_gdram:
    ClangBuiltin<"__mlvm_sram_to_gdram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_gdram_async:
    ClangBuiltin<"__mlvm_sram_to_gdram_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_gdram_stride :
    ClangBuiltin<"__mlvm_sram_to_gdram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_nram :
    ClangBuiltin<"__mlvm_ldram_to_nram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_nram_async :
    ClangBuiltin<"__mlvm_ldram_to_nram_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_nram_stride :
    ClangBuiltin<"__mlvm_ldram_to_nram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_nram_stride_async :
    ClangBuiltin<"__mlvm_ldram_to_nram_stride_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_const_to_nram :
    ClangBuiltin<"__mlvm_const_to_nram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_wram :
    ClangBuiltin<"__mlvm_ldram_to_wram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_wram_async :
    ClangBuiltin<"__mlvm_ldram_to_wram_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_wram_stride :
    ClangBuiltin<"__mlvm_ldram_to_wram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_wram_stride_async :
    ClangBuiltin<"__mlvm_ldram_to_wram_stride_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_const_to_sram :
    ClangBuiltin<"__mlvm_const_to_sram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_const_to_wram :
    ClangBuiltin<"__mlvm_const_to_wram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_sram :
    ClangBuiltin<"__mlvm_ldram_to_sram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_sram_async :
    ClangBuiltin<"__mlvm_ldram_to_sram_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_sram_stride :
    ClangBuiltin<"__mlvm_ldram_to_sram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_nram :
    ClangBuiltin<"__mlvm_gdram_to_nram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_nram_stride :
    ClangBuiltin<"__mlvm_gdram_to_nram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_nram_stride_async :
    ClangBuiltin<"__mlvm_gdram_to_nram_stride_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_sram_stride_async :
    ClangBuiltin<"__mlvm_gdram_to_sram_stride_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_gdram_stride_async :
    ClangBuiltin<"__mlvm_sram_to_gdram_stride_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_nram_async :
    ClangBuiltin<"__mlvm_gdram_to_nram_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_nram_to_nram_stride :
    ClangBuiltin<"__mlvm_nram_to_nram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_nram_to_nram_stride_async :
    ClangBuiltin<"__mlvm_nram_to_nram_stride_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_nram_to_wram_stride :
    ClangBuiltin<"__mlvm_nram_to_wram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_nram_to_wram_stride_async :
    ClangBuiltin<"__mlvm_nram_to_wram_stride_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_const_to_gdram :
    ClangBuiltin<"__mlvm_const_to_gdram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_const_to_ldram :
    ClangBuiltin<"__mlvm_const_to_ldram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_wram :
    ClangBuiltin<"__mlvm_gdram_to_wram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_wram_async :
    ClangBuiltin<"__mlvm_gdram_to_wram_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_wram_stride :
    ClangBuiltin<"__mlvm_gdram_to_wram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_wram_stride_async :
    ClangBuiltin<"__mlvm_gdram_to_wram_stride_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_wram_stride_async :
    ClangBuiltin<"__mlvm_sram_to_wram_stride_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_sram :
    ClangBuiltin<"__mlvm_gdram_to_sram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_sram_async :
    ClangBuiltin<"__mlvm_gdram_to_sram_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_sram_stride :
    ClangBuiltin<"__mlvm_gdram_to_sram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_ldram_stride :
    ClangBuiltin<"__mlvm_gdram_to_ldram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_gdram_stride :
    ClangBuiltin<"__mlvm_ldram_to_gdram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_gdram_stride :
    ClangBuiltin<"__mlvm_gdram_to_gdram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_ldram :
    ClangBuiltin<"__mlvm_ldram_to_ldram">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_ldram_stride :
    ClangBuiltin<"__mlvm_ldram_to_ldram_stride">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  // memcpy in the three dimension
  // move
  def int_mlvm_nram_to_nram_3D :
    ClangBuiltin<"__mlvm_nram_to_nram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_sram_3D :
    ClangBuiltin<"__mlvm_sram_to_sram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_ldram_3D :
    ClangBuiltin<"__mlvm_ldram_to_ldram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_gdram_3D :
    ClangBuiltin<"__mlvm_gdram_to_gdram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_wram_to_nram_3D :
    ClangBuiltin<"__mlvm_wram_to_nram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_nram_to_wram_3D :
    ClangBuiltin<"__mlvm_nram_to_wram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_gdram_3D :
    ClangBuiltin<"__mlvm_ldram_to_gdram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_ldram_3D :
    ClangBuiltin<"__mlvm_gdram_to_ldram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  // load
  def int_mlvm_gdram_to_nram_3D :
    ClangBuiltin<"__mlvm_gdram_to_nram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_nram_3D :
    ClangBuiltin<"__mlvm_ldram_to_nram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_nram_3D :
    ClangBuiltin<"__mlvm_sram_to_nram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_wram_3D :
    ClangBuiltin<"__mlvm_gdram_to_wram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_wram_3D :
    ClangBuiltin<"__mlvm_ldram_to_wram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_wram_3D :
    ClangBuiltin<"__mlvm_sram_to_wram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_sram_3D :
    ClangBuiltin<"__mlvm_gdram_to_sram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_sram_3D :
    ClangBuiltin<"__mlvm_ldram_to_sram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  // store
  def int_mlvm_nram_to_gdram_3D :
    ClangBuiltin<"__mlvm_nram_to_gdram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_wram_to_gdram_3D :
    ClangBuiltin<"__mlvm_wram_to_gdram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_gdram_3D :
    ClangBuiltin<"__mlvm_sram_to_gdram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_nram_to_ldram_3D :
    ClangBuiltin<"__mlvm_nram_to_ldram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_wram_to_ldram_3D :
    ClangBuiltin<"__mlvm_wram_to_ldram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_ldram_3D :
    ClangBuiltin<"__mlvm_sram_to_ldram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_nram_to_sram_3D :
    ClangBuiltin<"__mlvm_nram_to_sram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_wram_to_sram_3D :
    ClangBuiltin<"__mlvm_wram_to_sram_3D">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  // memcpy async in the three dimension
  // move
  def int_mlvm_nram_to_nram_3D_async :
    ClangBuiltin<"__mlvm_nram_to_nram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_sram_3D_async :
    ClangBuiltin<"__mlvm_sram_to_sram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_ldram_3D_async :
    ClangBuiltin<"__mlvm_ldram_to_ldram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_gdram_3D_async :
    ClangBuiltin<"__mlvm_gdram_to_gdram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_wram_to_nram_3D_async :
    ClangBuiltin<"__mlvm_wram_to_nram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_nram_to_wram_3D_async :
    ClangBuiltin<"__mlvm_nram_to_wram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_gdram_3D_async :
    ClangBuiltin<"__mlvm_ldram_to_gdram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_ldram_3D_async :
    ClangBuiltin<"__mlvm_gdram_to_ldram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  // load
  def int_mlvm_gdram_to_nram_3D_async :
    ClangBuiltin<"__mlvm_gdram_to_nram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_nram_3D_async :
    ClangBuiltin<"__mlvm_ldram_to_nram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_nram_3D_async :
    ClangBuiltin<"__mlvm_sram_to_nram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_wram_3D_async :
    ClangBuiltin<"__mlvm_gdram_to_wram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_wram_3D_async :
    ClangBuiltin<"__mlvm_ldram_to_wram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_wram_3D_async :
    ClangBuiltin<"__mlvm_sram_to_wram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_gdram_to_sram_3D_async :
    ClangBuiltin<"__mlvm_gdram_to_sram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_ldram_to_sram_3D_async :
    ClangBuiltin<"__mlvm_ldram_to_sram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  // store
  def int_mlvm_nram_to_gdram_3D_async :
    ClangBuiltin<"__mlvm_nram_to_gdram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_wram_to_gdram_3D_async :
    ClangBuiltin<"__mlvm_wram_to_gdram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_gdram_3D_async :
    ClangBuiltin<"__mlvm_sram_to_gdram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_nram_to_ldram_3D_async :
    ClangBuiltin<"__mlvm_nram_to_ldram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_wram_to_ldram_3D_async :
    ClangBuiltin<"__mlvm_wram_to_ldram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_sram_to_ldram_3D_async :
    ClangBuiltin<"__mlvm_sram_to_ldram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_nram_to_sram_3D_async :
    ClangBuiltin<"__mlvm_nram_to_sram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_wram_to_sram_3D_async :
    ClangBuiltin<"__mlvm_wram_to_sram_3D_async">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                  llvm_i32_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  //===--------------------------------------------------------------------===//
  // debug and misc
  //===--------------------------------------------------------------------===//
  def int_mlvm_sync :
    ClangBuiltin<"__mlvm_sync">,
    Intrinsic<[], [], []>;

  def int_mlvm_stream_breakdump_nram :
    ClangBuiltin<"__mlvm_stream_breakdump_nram">,
    Intrinsic<[], [llvm_ptr_ty,  llvm_i32_ty],
              []>;

  def int_mlvm_debug_vprintf_arg0 :
    ClangBuiltin<"__mlvm_debug_vprintf_arg0">,
    Intrinsic<[], [llvm_ptr_ty],
              [IntrHasSideEffects, IntrConvergent]>;

  def int_mlvm_debug_vprintf_arg1 :
    ClangBuiltin<"__mlvm_debug_vprintf_arg1">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i64_ty],
              [IntrHasSideEffects, IntrConvergent]>;

  def int_mlvm_debug_vprintf_arg2 :
    ClangBuiltin<"__mlvm_debug_vprintf_arg2">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i64_ty, llvm_i64_ty],
              [IntrHasSideEffects, IntrConvergent]>;

  def int_mlvm_debug_vprintf_arg3 :
    ClangBuiltin<"__mlvm_debug_vprintf_arg3">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty],
              [IntrHasSideEffects, IntrConvergent]>;

  def int_mlvm_debug_vprintf_arg4 :
    ClangBuiltin<"__mlvm_debug_vprintf_arg4">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty],
              [IntrHasSideEffects, IntrConvergent]>;

  def int_mlvm_debug_vprintf_arg5 :
    ClangBuiltin<"__mlvm_debug_vprintf_arg5">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty],
              [IntrHasSideEffects, IntrConvergent]>;

  def int_mlvm_debug_vprintf_arg6 :
    ClangBuiltin<"__mlvm_debug_vprintf_arg6">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty],
              [IntrHasSideEffects, IntrConvergent]>;

  def int_mlvm_debug_vprintf_arg7 :
    ClangBuiltin<"__mlvm_debug_vprintf_arg7">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty],
              [IntrHasSideEffects, IntrConvergent]>;

  def int_mlvm_debug_vprintf_arg8 :
    ClangBuiltin<"__mlvm_debug_vprintf_arg8">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty],
              [IntrHasSideEffects, IntrConvergent]>;

  def int_mlvm_debug_vprintf_arg9 :
    ClangBuiltin<"__mlvm_debug_vprintf_arg9">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty],
              [IntrHasSideEffects, IntrConvergent]>;

  def int_mlvm_debug_vprintf_arg10 :
    ClangBuiltin<"__mlvm_debug_vprintf_arg10">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty],
              [IntrHasSideEffects, IntrConvergent]>;

  def int_mlvm_debug_vprintf_arg11 :
    ClangBuiltin<"__mlvm_debug_vprintf_arg11">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty],
              [IntrHasSideEffects, IntrConvergent]>;

  def int_mlvm_debug_vprintf_arg12 :
    ClangBuiltin<"__mlvm_debug_vprintf_arg12">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty],
              [IntrHasSideEffects, IntrConvergent]>;

  def int_mlvm_debug_vprintf_arg13 :
    ClangBuiltin<"__mlvm_debug_vprintf_arg13">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty],
              [IntrHasSideEffects, IntrConvergent]>;

  def int_mlvm_debug_vprintf_arg14 :
    ClangBuiltin<"__mlvm_debug_vprintf_arg14">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty],
              [IntrHasSideEffects, IntrConvergent]>;

  def int_mlvm_debug_vprintf_arg15 :
    ClangBuiltin<"__mlvm_debug_vprintf_arg15">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty],
              [IntrHasSideEffects, IntrConvergent]>;

  def int_mlvm_debug_vprintf_arg16 :
    ClangBuiltin<"__mlvm_debug_vprintf_arg16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty, llvm_i64_ty, llvm_i64_ty, llvm_i64_ty,
                   llvm_i64_ty],
              [IntrHasSideEffects, IntrConvergent]>;

  def int_mlvm_readperf_begin :
    ClangBuiltin<"__mlvm_readperf_begin">,
    Intrinsic<[], [llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_readperf_end :
    ClangBuiltin<"__mlvm_readperf_end">,
    Intrinsic<[], [llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_ge_const_f16 :
    ClangBuiltin<"__mlvm_stream_ge_const_f16">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_half_ty, llvm_i32_ty],
              []>;

  def int_mlvm_stream_ge_const_f32 :
    ClangBuiltin<"__mlvm_stream_ge_const_f32">,
    Intrinsic<[], [llvm_ptr_ty, llvm_ptr_ty, llvm_float_ty, llvm_i32_ty],
              []>;


//===----------------------------------------------------------------------===//
// Grid intrinsics.
//===----------------------------------------------------------------------===//

// Grid load.
class MLUGridLoad<string type, LLVMType vty>
  : Intrinsic<[vty], [llvm_ptr_ty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>,
    ClangBuiltin<"__mlvm_grid_load_" # type>;

  def int_mlvm_grid_load_f32x1    : MLUGridLoad<"f32x1", llvm_v1f32_ty>;
  def int_mlvm_grid_load_f16x2    : MLUGridLoad<"f16x2", llvm_v2f16_ty>;
  def int_mlvm_grid_load_s32x1    : MLUGridLoad<"s32x1", llvm_v1i32_ty>;
  def int_mlvm_grid_load_s16x2    : MLUGridLoad<"s16x2", llvm_v2i16_ty>;
  def int_mlvm_grid_load_s8x4     : MLUGridLoad<"s8x4", llvm_v4i8_ty>;
  def int_mlvm_grid_load_u32x1    : MLUGridLoad<"u32x1", llvm_v1i32_ty>;
  def int_mlvm_grid_load_u16x2    : MLUGridLoad<"u16x2", llvm_v2i16_ty>;
  def int_mlvm_grid_load_u8x4     : MLUGridLoad<"u8x4", llvm_v4i8_ty>;
  def int_mlvm_grid_load_f16x1    : MLUGridLoad<"f16x1", llvm_v2f16_ty>;
  def int_mlvm_grid_load_s16x1    : MLUGridLoad<"s16x1", llvm_v2i16_ty>;
  def int_mlvm_grid_load_s8x1     : MLUGridLoad<"s8x1", llvm_v4i8_ty>;
  def int_mlvm_grid_load_u16x1    : MLUGridLoad<"u16x1", llvm_v2i16_ty>;
  def int_mlvm_grid_load_u8x1     : MLUGridLoad<"u8x1", llvm_v4i8_ty>;

// Grid store.
class MLUGridStore<string type, LLVMType vty>
  : Intrinsic<[], [llvm_ptr_ty, vty, llvm_i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>,
    ClangBuiltin<"__mlvm_grid_store_" # type>;

  def int_mlvm_grid_store_f32x1    : MLUGridStore<"f32x1", llvm_v1f32_ty>;
  def int_mlvm_grid_store_f16x2    : MLUGridStore<"f16x2", llvm_v2f16_ty>;
  def int_mlvm_grid_store_s32x1    : MLUGridStore<"s32x1", llvm_v1i32_ty>;
  def int_mlvm_grid_store_s16x2    : MLUGridStore<"s16x2", llvm_v2i16_ty>;
  def int_mlvm_grid_store_s8x4     : MLUGridStore<"i8x4", llvm_v4i8_ty>;
  def int_mlvm_grid_store_u32x1    : MLUGridStore<"u32x1", llvm_v1i32_ty>;
  def int_mlvm_grid_store_u16x2    : MLUGridStore<"u16x2", llvm_v2i16_ty>;
  def int_mlvm_grid_store_u8x4     : MLUGridStore<"u8x4", llvm_v4i8_ty>;
  def int_mlvm_grid_store_f16x1    : MLUGridStore<"f16x1", llvm_v2f16_ty>;
  def int_mlvm_grid_store_s16x1    : MLUGridStore<"s16x1", llvm_v2i16_ty>;
  def int_mlvm_grid_store_s8x1     : MLUGridStore<"s8x1", llvm_v4i8_ty>;
  def int_mlvm_grid_store_u16x1    : MLUGridStore<"u16x1", llvm_v2i16_ty>;
  def int_mlvm_grid_store_u8x1     : MLUGridStore<"u8x1", llvm_v4i8_ty>;

// Grid move.
class MLUGridMove<string name_type, LLVMType dst_ty, LLVMType src_ty>
  : Intrinsic<[dst_ty], [src_ty],
              []>,
    ClangBuiltin<"__mlvm_grid_" # name_type>;

  def int_mlvm_grid_move_f32x1_f32x1       : MLUGridMove<"move_f32x1_f32x1", llvm_v1f32_ty, llvm_v1f32_ty>;
  def int_mlvm_grid_move_f16x2_f16x2       : MLUGridMove<"move_f16x2_f16x2", llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_move_s32x1_s32x1       : MLUGridMove<"move_s32x1_s32x1", llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_move_s16x2_s16x2       : MLUGridMove<"move_s16x2_s16x2", llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_move_s8x4_s8x4         : MLUGridMove<"move_s8x4_s8x4", llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_move_u32x1_u32x1       : MLUGridMove<"move_u32x1_u32x1", llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_move_u16x2_u16x2       : MLUGridMove<"move_u16x2_u16x2", llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_move_u8x4_u8x4         : MLUGridMove<"move_u8x4_u8x4", llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_move_f16x1_f16x1       : MLUGridMove<"move_f16x1_f16x1", llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_move_s16x1_s16x1       : MLUGridMove<"move_s16x1_s16x1", llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_move_s8x1_s8x1         : MLUGridMove<"move_s8x1_s8x1", llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_move_u16x1_u16x1       : MLUGridMove<"move_u16x1_u16x1", llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_move_u8x1_u8x1         : MLUGridMove<"move_u8x1_u8x1", llvm_v4i8_ty, llvm_v4i8_ty>;

  def int_mlvm_grid_move_f32x1_scalar    : MLUGridMove<"move_f32x1_scalar", llvm_v1f32_ty, llvm_float_ty>;
  def int_mlvm_grid_move_f16x2_scalar    : MLUGridMove<"move_f16x2_scalar", llvm_v2f16_ty, llvm_half_ty>;
  def int_mlvm_grid_move_s32x1_scalar    : MLUGridMove<"move_s32x1_scalar", llvm_v1i32_ty, llvm_i32_ty>;
  def int_mlvm_grid_move_s16x2_scalar    : MLUGridMove<"move_s16x2_scalar", llvm_v2i16_ty, llvm_i16_ty>;
  def int_mlvm_grid_move_s8x4_scalar     : MLUGridMove<"move_s8x4_scalar", llvm_v4i8_ty, llvm_i8_ty>;
  def int_mlvm_grid_move_u32x1_scalar    : MLUGridMove<"move_u32x1_scalar", llvm_v1i32_ty, llvm_i32_ty>;
  def int_mlvm_grid_move_u16x2_scalar    : MLUGridMove<"move_u16x2_scalar", llvm_v2i16_ty, llvm_i16_ty>;
  def int_mlvm_grid_move_u8x4_scalar     : MLUGridMove<"move_u8x4_scalar", llvm_v4i8_ty, llvm_i8_ty>;
  def int_mlvm_grid_move_f16x1_scalar    : MLUGridMove<"move_f16x1_scalar", llvm_v2f16_ty, llvm_half_ty>;
  def int_mlvm_grid_move_s16x1_scalar    : MLUGridMove<"move_s16x1_scalar", llvm_v2i16_ty, llvm_i16_ty>;
  def int_mlvm_grid_move_s8x1_scalar     : MLUGridMove<"move_s8x1_scalar", llvm_v4i8_ty, llvm_i8_ty>;
  def int_mlvm_grid_move_u16x1_scalar    : MLUGridMove<"move_u16x1_scalar", llvm_v2i16_ty, llvm_i16_ty>;
  def int_mlvm_grid_move_u8x1_scalar     : MLUGridMove<"move_u8x1_scalar", llvm_v4i8_ty, llvm_i8_ty>;

// Grid binary computation.
class MLUGridBinary<string name_type, LLVMType dst_ty, LLVMType src0_ty, LLVMType src1_ty>
  : Intrinsic<[dst_ty], [src0_ty, src1_ty],
              []>,
    ClangBuiltin<"__mlvm_grid_" # name_type>;

  // add
  def int_mlvm_grid_add_f32x1    : MLUGridBinary<"add_f32x1", llvm_v1f32_ty, llvm_v1f32_ty, llvm_v1f32_ty>;
  def int_mlvm_grid_add_f16x2    : MLUGridBinary<"add_f16x2", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_add_s32x1    : MLUGridBinary<"add_s32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_add_s16x2    : MLUGridBinary<"add_s16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_add_s8x4     : MLUGridBinary<"add_s8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_add_u32x1    : MLUGridBinary<"add_u32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_add_u16x2    : MLUGridBinary<"add_u16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_add_u8x4     : MLUGridBinary<"add_u8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_add_f16x1    : MLUGridBinary<"add_f16x1", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_add_s16x1    : MLUGridBinary<"add_s16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_add_s8x1     : MLUGridBinary<"add_s8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_add_u16x1    : MLUGridBinary<"add_u16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_add_u8x1     : MLUGridBinary<"add_u8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;

  // sub
  def int_mlvm_grid_sub_f32x1    : MLUGridBinary<"sub_f32x1", llvm_v1f32_ty, llvm_v1f32_ty, llvm_v1f32_ty>;
  def int_mlvm_grid_sub_f16x2    : MLUGridBinary<"sub_f16x2", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_sub_s32x1    : MLUGridBinary<"sub_s32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_sub_s16x2    : MLUGridBinary<"sub_s16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_sub_s8x4     : MLUGridBinary<"sub_s8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_sub_u32x1    : MLUGridBinary<"sub_u32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_sub_u16x2    : MLUGridBinary<"sub_u16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_sub_u8x4     : MLUGridBinary<"sub_u8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_sub_f16x1    : MLUGridBinary<"sub_f16x1", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_sub_s16x1    : MLUGridBinary<"sub_s16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_sub_s8x1     : MLUGridBinary<"sub_s8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_sub_u16x1    : MLUGridBinary<"sub_u16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_sub_u8x1     : MLUGridBinary<"sub_u8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;

  // mul
  def int_mlvm_grid_mul_f32x1    : MLUGridBinary<"mul_f32x1", llvm_v1f32_ty, llvm_v1f32_ty, llvm_v1f32_ty>;
  def int_mlvm_grid_mul_f16x2    : MLUGridBinary<"mul_f16x2", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_mul_s32x1    : MLUGridBinary<"mul_s32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_mul_s16x2    : MLUGridBinary<"mul_s16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_mul_s8x4     : MLUGridBinary<"mul_s8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_mul_u32x1    : MLUGridBinary<"mul_u32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_mul_u16x2    : MLUGridBinary<"mul_u16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_mul_u8x4     : MLUGridBinary<"mul_u8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_mul_f16x1    : MLUGridBinary<"mul_f16x1", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_mul_s16x1    : MLUGridBinary<"mul_s16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_mul_s8x1     : MLUGridBinary<"mul_s8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_mul_u16x1    : MLUGridBinary<"mul_u16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_mul_u8x1     : MLUGridBinary<"mul_u8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;

  // mulh
  def int_mlvm_grid_mulh_s32x1    : MLUGridBinary<"mulh_s32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_mulh_s16x2    : MLUGridBinary<"mulh_s16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_mulh_s8x4     : MLUGridBinary<"mulh_s8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_mulh_u32x1    : MLUGridBinary<"mulh_u32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_mulh_u16x2    : MLUGridBinary<"mulh_u16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_mulh_u8x4     : MLUGridBinary<"mulh_u8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_mulh_s16x1    : MLUGridBinary<"mulh_s16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_mulh_s8x1     : MLUGridBinary<"mulh_s8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_mulh_u16x1    : MLUGridBinary<"mulh_u16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_mulh_u8x1     : MLUGridBinary<"mulh_u8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;

  // eq
  def int_mlvm_grid_eq_f32x1    : MLUGridBinary<"eq_f32x1", llvm_v1f32_ty, llvm_v1f32_ty, llvm_v1f32_ty>;
  def int_mlvm_grid_eq_f16x2    : MLUGridBinary<"eq_f16x2", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_eq_s32x1    : MLUGridBinary<"eq_s32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_eq_s16x2    : MLUGridBinary<"eq_s16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_eq_s8x4     : MLUGridBinary<"eq_s8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_eq_u32x1    : MLUGridBinary<"eq_u32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_eq_u16x2    : MLUGridBinary<"eq_u16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_eq_u8x4     : MLUGridBinary<"eq_u8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_eq_f16x1    : MLUGridBinary<"eq_f16x1", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_eq_s16x1    : MLUGridBinary<"eq_s16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_eq_s8x1     : MLUGridBinary<"eq_s8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_eq_u16x1    : MLUGridBinary<"eq_u16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_eq_u8x1     : MLUGridBinary<"eq_u8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;

  // ne
  def int_mlvm_grid_ne_f32x1    : MLUGridBinary<"ne_f32x1", llvm_v1f32_ty, llvm_v1f32_ty, llvm_v1f32_ty>;
  def int_mlvm_grid_ne_f16x2    : MLUGridBinary<"ne_f16x2", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_ne_s32x1    : MLUGridBinary<"ne_s32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_ne_s16x2    : MLUGridBinary<"ne_s16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_ne_s8x4     : MLUGridBinary<"ne_s8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_ne_u32x1    : MLUGridBinary<"ne_u32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_ne_u16x2    : MLUGridBinary<"ne_u16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_ne_u8x4     : MLUGridBinary<"ne_u8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_ne_f16x1    : MLUGridBinary<"ne_f16x1", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_ne_s16x1    : MLUGridBinary<"ne_s16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_ne_s8x1     : MLUGridBinary<"ne_s8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_ne_u16x1    : MLUGridBinary<"ne_u16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_ne_u8x1     : MLUGridBinary<"ne_u8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;

  // lt
  def int_mlvm_grid_lt_f32x1    : MLUGridBinary<"lt_f32x1", llvm_v1f32_ty, llvm_v1f32_ty, llvm_v1f32_ty>;
  def int_mlvm_grid_lt_f16x2    : MLUGridBinary<"lt_f16x2", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_lt_s32x1    : MLUGridBinary<"lt_s32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_lt_s16x2    : MLUGridBinary<"lt_s16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_lt_s8x4     : MLUGridBinary<"lt_s8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_lt_u32x1    : MLUGridBinary<"lt_u32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_lt_u16x2    : MLUGridBinary<"lt_u16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_lt_u8x4     : MLUGridBinary<"lt_u8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_lt_f16x1    : MLUGridBinary<"lt_f16x1", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_lt_s16x1    : MLUGridBinary<"lt_s16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_lt_s8x1     : MLUGridBinary<"lt_s8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_lt_u16x1    : MLUGridBinary<"lt_u16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_lt_u8x1     : MLUGridBinary<"lt_u8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;

  // ge
  def int_mlvm_grid_ge_f32x1    : MLUGridBinary<"ge_f32x1", llvm_v1f32_ty, llvm_v1f32_ty, llvm_v1f32_ty>;
  def int_mlvm_grid_ge_f16x2    : MLUGridBinary<"ge_f16x2", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_ge_s32x1    : MLUGridBinary<"ge_s32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_ge_s16x2    : MLUGridBinary<"ge_s16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_ge_s8x4     : MLUGridBinary<"ge_s8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_ge_u32x1    : MLUGridBinary<"ge_u32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_ge_u16x2    : MLUGridBinary<"ge_u16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_ge_u8x4     : MLUGridBinary<"ge_u8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_ge_f16x1    : MLUGridBinary<"ge_f16x1", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_ge_s16x1    : MLUGridBinary<"ge_s16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_ge_s8x1     : MLUGridBinary<"ge_s8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_ge_u16x1    : MLUGridBinary<"ge_u16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_ge_u8x1     : MLUGridBinary<"ge_u8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;

  // and
  def int_mlvm_grid_and_s32x1    : MLUGridBinary<"and_s32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_and_s16x2    : MLUGridBinary<"and_s16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_and_s8x4     : MLUGridBinary<"and_s8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_and_u32x1    : MLUGridBinary<"and_u32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_and_u16x2    : MLUGridBinary<"and_u16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_and_u8x4     : MLUGridBinary<"and_u8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_and_s16x1    : MLUGridBinary<"and_s16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_and_s8x1     : MLUGridBinary<"and_s8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_and_u16x1    : MLUGridBinary<"and_u16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_and_u8x1     : MLUGridBinary<"and_u8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;

  // or
  def int_mlvm_grid_or_s32x1    : MLUGridBinary<"or_s32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_or_s16x2    : MLUGridBinary<"or_s16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_or_s8x4     : MLUGridBinary<"or_s8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_or_u32x1    : MLUGridBinary<"or_u32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_or_u16x2    : MLUGridBinary<"or_u16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_or_u8x4     : MLUGridBinary<"or_u8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_or_s16x1    : MLUGridBinary<"or_s16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_or_s8x1     : MLUGridBinary<"or_s8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_or_u16x1    : MLUGridBinary<"or_u16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_or_u8x1     : MLUGridBinary<"or_u8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;

  // xor
  def int_mlvm_grid_xor_s32x1    : MLUGridBinary<"xor_s32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_xor_s16x2    : MLUGridBinary<"xor_s16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_xor_s8x4     : MLUGridBinary<"xor_s8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_xor_u32x1    : MLUGridBinary<"xor_u32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_xor_u16x2    : MLUGridBinary<"xor_u16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_xor_u8x4     : MLUGridBinary<"xor_u8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_xor_s16x1    : MLUGridBinary<"xor_s16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_xor_s8x1     : MLUGridBinary<"xor_s8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_xor_u16x1    : MLUGridBinary<"xor_u16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_xor_u8x1     : MLUGridBinary<"xor_u8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;

  // max
  def int_mlvm_grid_max_f32x1    : MLUGridBinary<"max_f32x1", llvm_v1f32_ty, llvm_v1f32_ty, llvm_v1f32_ty>;
  def int_mlvm_grid_max_f16x2    : MLUGridBinary<"max_f16x2", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_max_s32x1    : MLUGridBinary<"max_s32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_max_s16x2    : MLUGridBinary<"max_s16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_max_s8x4     : MLUGridBinary<"max_s8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_max_u32x1    : MLUGridBinary<"max_u32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_max_u16x2    : MLUGridBinary<"max_u16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_max_u8x4     : MLUGridBinary<"max_u8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_max_f16x1    : MLUGridBinary<"max_f16x1", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_max_s16x1    : MLUGridBinary<"max_s16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_max_s8x1     : MLUGridBinary<"max_s8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_max_u16x1    : MLUGridBinary<"max_u16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_max_u8x1     : MLUGridBinary<"max_u8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;

  // min
  def int_mlvm_grid_min_f32x1    : MLUGridBinary<"min_f32x1", llvm_v1f32_ty, llvm_v1f32_ty, llvm_v1f32_ty>;
  def int_mlvm_grid_min_f16x2    : MLUGridBinary<"min_f16x2", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_min_s32x1    : MLUGridBinary<"min_s32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_min_s16x2    : MLUGridBinary<"min_s16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_min_s8x4     : MLUGridBinary<"min_s8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_min_u32x1    : MLUGridBinary<"min_u32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_min_u16x2    : MLUGridBinary<"min_u16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_min_u8x4     : MLUGridBinary<"min_u8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_min_f16x1    : MLUGridBinary<"min_f16x1", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_min_s16x1    : MLUGridBinary<"min_s16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_min_s8x1     : MLUGridBinary<"min_s8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_min_u16x1    : MLUGridBinary<"min_u16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_min_u8x1     : MLUGridBinary<"min_u8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;

  // land
  def int_mlvm_grid_land_f32x1    : MLUGridBinary<"land_f32x1", llvm_v1f32_ty, llvm_v1f32_ty, llvm_v1f32_ty>;
  def int_mlvm_grid_land_f16x2    : MLUGridBinary<"land_f16x2", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_land_s32x1    : MLUGridBinary<"land_s32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_land_s16x2    : MLUGridBinary<"land_s16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_land_s8x4     : MLUGridBinary<"land_s8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_land_u32x1    : MLUGridBinary<"land_u32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_land_u16x2    : MLUGridBinary<"land_u16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_land_u8x4     : MLUGridBinary<"land_u8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_land_f16x1    : MLUGridBinary<"land_f16x1", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_land_s16x1    : MLUGridBinary<"land_s16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_land_s8x1     : MLUGridBinary<"land_s8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_land_u16x1    : MLUGridBinary<"land_u16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_land_u8x1     : MLUGridBinary<"land_u8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;

  // lor
  def int_mlvm_grid_lor_f32x1    : MLUGridBinary<"lor_f32x1", llvm_v1f32_ty, llvm_v1f32_ty, llvm_v1f32_ty>;
  def int_mlvm_grid_lor_f16x2    : MLUGridBinary<"lor_f16x2", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_lor_s32x1    : MLUGridBinary<"lor_s32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_lor_s16x2    : MLUGridBinary<"lor_s16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_lor_s8x4     : MLUGridBinary<"lor_s8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_lor_u32x1    : MLUGridBinary<"lor_u32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_lor_u16x2    : MLUGridBinary<"lor_u16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_lor_u8x4     : MLUGridBinary<"lor_u8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_lor_f16x1    : MLUGridBinary<"lor_f16x1", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_lor_s16x1    : MLUGridBinary<"lor_s16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_lor_s8x1     : MLUGridBinary<"lor_s8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_lor_u16x1    : MLUGridBinary<"lor_u16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_lor_u8x1     : MLUGridBinary<"lor_u8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;

  // lxor
  def int_mlvm_grid_lxor_f32x1    : MLUGridBinary<"lxor_f32x1", llvm_v1f32_ty, llvm_v1f32_ty, llvm_v1f32_ty>;
  def int_mlvm_grid_lxor_f16x2    : MLUGridBinary<"lxor_f16x2", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_lxor_s32x1    : MLUGridBinary<"lxor_s32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_lxor_s16x2    : MLUGridBinary<"lxor_s16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_lxor_s8x4     : MLUGridBinary<"lxor_s8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_lxor_u32x1    : MLUGridBinary<"lxor_u32x1", llvm_v1i32_ty, llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_lxor_u16x2    : MLUGridBinary<"lxor_u16x2", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_lxor_u8x4     : MLUGridBinary<"lxor_u8x4", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_lxor_f16x1    : MLUGridBinary<"lxor_f16x1", llvm_v2f16_ty, llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_lxor_s16x1    : MLUGridBinary<"lxor_s16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_lxor_s8x1     : MLUGridBinary<"lxor_s8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_lxor_u16x1    : MLUGridBinary<"lxor_u16x1", llvm_v2i16_ty, llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_lxor_u8x1     : MLUGridBinary<"lxor_u8x1", llvm_v4i8_ty, llvm_v4i8_ty, llvm_v4i8_ty>;

  // sll
  def int_mlvm_grid_sll_s32x1_scalar    : MLUGridBinary<"sll_s32x1_scalar", llvm_v1i32_ty, llvm_v1i32_ty, llvm_i32_ty>;
  def int_mlvm_grid_sll_s16x2_scalar    : MLUGridBinary<"sll_s16x2_scalar", llvm_v2i16_ty, llvm_v2i16_ty, llvm_i32_ty>;
  def int_mlvm_grid_sll_s8x4_scalar     : MLUGridBinary<"sll_s8x4_scalar", llvm_v4i8_ty, llvm_v4i8_ty, llvm_i32_ty>;
  def int_mlvm_grid_sll_u32x1_scalar    : MLUGridBinary<"sll_u32x1_scalar", llvm_v1i32_ty, llvm_v1i32_ty, llvm_i32_ty>;
  def int_mlvm_grid_sll_u16x2_scalar    : MLUGridBinary<"sll_u16x2_scalar", llvm_v2i16_ty, llvm_v2i16_ty, llvm_i32_ty>;
  def int_mlvm_grid_sll_u8x4_scalar     : MLUGridBinary<"sll_u8x4_scalar", llvm_v4i8_ty, llvm_v4i8_ty, llvm_i32_ty>;
  def int_mlvm_grid_sll_s16x1_scalar    : MLUGridBinary<"sll_s16x1_scalar", llvm_v2i16_ty, llvm_v2i16_ty, llvm_i32_ty>;
  def int_mlvm_grid_sll_s8x1_scalar     : MLUGridBinary<"sll_s8x1_scalar", llvm_v4i8_ty, llvm_v4i8_ty, llvm_i32_ty>;
  def int_mlvm_grid_sll_u16x1_scalar    : MLUGridBinary<"sll_u16x1_scalar", llvm_v2i16_ty, llvm_v2i16_ty, llvm_i32_ty>;
  def int_mlvm_grid_sll_u8x1_scalar     : MLUGridBinary<"sll_u8x1_scalar", llvm_v4i8_ty, llvm_v4i8_ty, llvm_i32_ty>;

  // srl
  def int_mlvm_grid_srl_u32x1_scalar    : MLUGridBinary<"srl_u32x1_scalar", llvm_v1i32_ty, llvm_v1i32_ty, llvm_i32_ty>;
  def int_mlvm_grid_srl_u16x2_scalar    : MLUGridBinary<"srl_u16x2_scalar", llvm_v2i16_ty, llvm_v2i16_ty, llvm_i32_ty>;
  def int_mlvm_grid_srl_u8x4_scalar     : MLUGridBinary<"srl_u8x4_scalar", llvm_v4i8_ty, llvm_v4i8_ty, llvm_i32_ty>;
  def int_mlvm_grid_srl_u16x1_scalar    : MLUGridBinary<"srl_u16x1_scalar", llvm_v2i16_ty, llvm_v2i16_ty, llvm_i32_ty>;
  def int_mlvm_grid_srl_u8x1_scalar     : MLUGridBinary<"srl_u8x1_scalar", llvm_v4i8_ty, llvm_v4i8_ty, llvm_i32_ty>;

  // sra
  def int_mlvm_grid_sra_s32x1_scalar    : MLUGridBinary<"sra_s32x1_scalar", llvm_v1i32_ty, llvm_v1i32_ty, llvm_i32_ty>;
  def int_mlvm_grid_sra_s16x2_scalar    : MLUGridBinary<"sra_s16x2_scalar", llvm_v2i16_ty, llvm_v2i16_ty, llvm_i32_ty>;
  def int_mlvm_grid_sra_s8x4_scalar     : MLUGridBinary<"sra_s8x4_scalar", llvm_v4i8_ty, llvm_v4i8_ty, llvm_i32_ty>;
  def int_mlvm_grid_sra_s16x1_scalar    : MLUGridBinary<"sra_s16x1_scalar", llvm_v2i16_ty, llvm_v2i16_ty, llvm_i32_ty>;
  def int_mlvm_grid_sra_s8x1_scalar     : MLUGridBinary<"sra_s8x1_scalar", llvm_v4i8_ty, llvm_v4i8_ty, llvm_i32_ty>;

  // relun
  def int_mlvm_grid_relun_f32x1_scalar    : MLUGridBinary<"relun_f32x1_scalar", llvm_v1f32_ty, llvm_v1f32_ty, llvm_float_ty>;
  def int_mlvm_grid_relun_f16x2_scalar    : MLUGridBinary<"relun_f16x2_scalar", llvm_v2f16_ty, llvm_v2f16_ty, llvm_half_ty>;
  def int_mlvm_grid_relun_s32x1_scalar    : MLUGridBinary<"relun_s32x1_scalar", llvm_v1i32_ty, llvm_v1i32_ty, llvm_i32_ty>;
  def int_mlvm_grid_relun_s16x2_scalar    : MLUGridBinary<"relun_s16x2_scalar", llvm_v2i16_ty, llvm_v2i16_ty, llvm_i16_ty>;
  def int_mlvm_grid_relun_s8x4_scalar     : MLUGridBinary<"relun_s8x4_scalar", llvm_v4i8_ty, llvm_v4i8_ty, llvm_i8_ty>;
  def int_mlvm_grid_relun_f16x1_scalar    : MLUGridBinary<"relun_f16x1_scalar", llvm_v2f16_ty, llvm_v2f16_ty, llvm_half_ty>;
  def int_mlvm_grid_relun_s16x1_scalar    : MLUGridBinary<"relun_s16x1_scalar", llvm_v2i16_ty, llvm_v2i16_ty, llvm_i16_ty>;
  def int_mlvm_grid_relun_s8x1_scalar     : MLUGridBinary<"relun_s8x1_scalar", llvm_v4i8_ty, llvm_v4i8_ty, llvm_i8_ty>;

// Grid unary computation.
class MLUGridUnary<string name_type, LLVMType dst_ty, LLVMType src_ty>
  : Intrinsic<[dst_ty], [src_ty],
              []>,
    ClangBuiltin<"__mlvm_grid_" # name_type>;

  // not
  def int_mlvm_grid_not_s32x1    : MLUGridUnary<"not_s32x1", llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_not_s16x2    : MLUGridUnary<"not_s16x2", llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_not_s8x4     : MLUGridUnary<"not_s8x4", llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_not_u32x1    : MLUGridUnary<"not_u32x1", llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_not_u16x2    : MLUGridUnary<"not_u16x2", llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_not_u8x4     : MLUGridUnary<"not_u8x4", llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_not_s16x1    : MLUGridUnary<"not_s16x1", llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_not_s8x1     : MLUGridUnary<"not_s8x1", llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_not_u16x1    : MLUGridUnary<"not_u16x1", llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_not_u8x1     : MLUGridUnary<"not_u8x1", llvm_v4i8_ty, llvm_v4i8_ty>;

  // lnot
  def int_mlvm_grid_lnot_f32x1    : MLUGridUnary<"lnot_f32x1", llvm_v1f32_ty, llvm_v1f32_ty>;
  def int_mlvm_grid_lnot_f16x2    : MLUGridUnary<"lnot_f16x2", llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_lnot_s32x1    : MLUGridUnary<"lnot_s32x1", llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_lnot_s16x2    : MLUGridUnary<"lnot_s16x2", llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_lnot_s8x4     : MLUGridUnary<"lnot_s8x4", llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_lnot_u32x1    : MLUGridUnary<"lnot_u32x1", llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_lnot_u16x2    : MLUGridUnary<"lnot_u16x2", llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_lnot_u8x4     : MLUGridUnary<"lnot_u8x4", llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_lnot_f16x1    : MLUGridUnary<"lnot_f16x1", llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_lnot_s16x1    : MLUGridUnary<"lnot_s16x1", llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_lnot_s8x1     : MLUGridUnary<"lnot_s8x1", llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_lnot_u16x1    : MLUGridUnary<"lnot_u16x1", llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_lnot_u8x1     : MLUGridUnary<"lnot_u8x1", llvm_v4i8_ty, llvm_v4i8_ty>;

  // abs
  def int_mlvm_grid_abs_f32x1    : MLUGridUnary<"abs_f32x1", llvm_v1f32_ty, llvm_v1f32_ty>;
  def int_mlvm_grid_abs_f16x2    : MLUGridUnary<"abs_f16x2", llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_abs_s32x1    : MLUGridUnary<"abs_s32x1", llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_abs_s16x2    : MLUGridUnary<"abs_s16x2", llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_abs_s8x4     : MLUGridUnary<"abs_s8x4", llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_abs_f16x1    : MLUGridUnary<"abs_f16x1", llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_abs_s16x1    : MLUGridUnary<"abs_s16x1", llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_abs_s8x1     : MLUGridUnary<"abs_s8x1", llvm_v4i8_ty, llvm_v4i8_ty>;

  // relu
  def int_mlvm_grid_relu_f32x1    : MLUGridUnary<"relu_f32x1", llvm_v1f32_ty, llvm_v1f32_ty>;
  def int_mlvm_grid_relu_f16x2    : MLUGridUnary<"relu_f16x2", llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_relu_s32x1    : MLUGridUnary<"relu_s32x1", llvm_v1i32_ty, llvm_v1i32_ty>;
  def int_mlvm_grid_relu_s16x2    : MLUGridUnary<"relu_s16x2", llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_relu_s8x4     : MLUGridUnary<"relu_s8x4", llvm_v4i8_ty, llvm_v4i8_ty>;
  def int_mlvm_grid_relu_f16x1    : MLUGridUnary<"relu_f16x1", llvm_v2f16_ty, llvm_v2f16_ty>;
  def int_mlvm_grid_relu_s16x1    : MLUGridUnary<"relu_s16x1", llvm_v2i16_ty, llvm_v2i16_ty>;
  def int_mlvm_grid_relu_s8x1     : MLUGridUnary<"relu_s8x1", llvm_v4i8_ty, llvm_v4i8_ty>;

// Grid shift.
class MLUGridShift<string dir_type, LLVMType vty>
  : Intrinsic<[vty], [vty],
              []>,
    ClangBuiltin<"__mlvm_grid_shift_" # dir_type>;

  def int_mlvm_grid_shift_up_f32x1 : MLUGridShift<"up_f32x1", llvm_v1f32_ty>;
  def int_mlvm_grid_shift_up_f16x2 : MLUGridShift<"up_f16x2", llvm_v2f16_ty>;
  def int_mlvm_grid_shift_up_i32x1 : MLUGridShift<"up_i32x1", llvm_v1i32_ty>;
  def int_mlvm_grid_shift_up_i16x2 : MLUGridShift<"up_i16x2", llvm_v2i16_ty>;
  def int_mlvm_grid_shift_up_i8x4  : MLUGridShift<"up_i8x4", llvm_v4i8_ty>;
  def int_mlvm_grid_shift_down_f32x1 : MLUGridShift<"down_f32x1", llvm_v1f32_ty>;
  def int_mlvm_grid_shift_down_f16x2 : MLUGridShift<"down_f16x2", llvm_v2f16_ty>;
  def int_mlvm_grid_shift_down_i32x1 : MLUGridShift<"down_i32x1", llvm_v1i32_ty>;
  def int_mlvm_grid_shift_down_i16x2 : MLUGridShift<"down_i16x2", llvm_v2i16_ty>;
  def int_mlvm_grid_shift_down_i8x4  : MLUGridShift<"down_i8x4", llvm_v4i8_ty>;
  def int_mlvm_grid_shift_left_f32x1 : MLUGridShift<"left_f32x1", llvm_v1f32_ty>;
  def int_mlvm_grid_shift_left_f16x2 : MLUGridShift<"left_f16x2", llvm_v2f16_ty>;
  def int_mlvm_grid_shift_left_i32x1 : MLUGridShift<"left_i32x1", llvm_v1i32_ty>;
  def int_mlvm_grid_shift_left_i16x2 : MLUGridShift<"left_i16x2", llvm_v2i16_ty>;
  def int_mlvm_grid_shift_left_i8x4  : MLUGridShift<"left_i8x4", llvm_v4i8_ty>;
  def int_mlvm_grid_shift_right_f32x1 : MLUGridShift<"right_f32x1", llvm_v1f32_ty>;
  def int_mlvm_grid_shift_right_f16x2 : MLUGridShift<"right_f16x2", llvm_v2f16_ty>;
  def int_mlvm_grid_shift_right_i32x1 : MLUGridShift<"right_i32x1", llvm_v1i32_ty>;
  def int_mlvm_grid_shift_right_i16x2 : MLUGridShift<"right_i16x2", llvm_v2i16_ty>;
  def int_mlvm_grid_shift_right_i8x4  : MLUGridShift<"right_i8x4", llvm_v4i8_ty>;

// -----------------------------------------------------------------------------
// TRC intrinsics
// -----------------------------------------------------------------------------
  def int_mlvm_trc_slice :
    ClangBuiltin<"__mlvm_trc_slice">,
    Intrinsic<[llvm_v8i32_ty], [llvm_v8i32_ty,
               llvm_i32_ty, llvm_i32_ty, llvm_i16_ty,
               llvm_i16_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_create :
    ClangBuiltin<"__mlvm_trc_create">,
    Intrinsic<[llvm_v8i32_ty], [llvm_ptr_ty,
                   llvm_i32_ty, llvm_i32_ty, llvm_i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  //===--------------------------------------------------------------------===//
  // memcpy
  //===--------------------------------------------------------------------===//
  def int_mlvm_trc_memcpy_nram_to_gdram :
    ClangBuiltin<"__mlvm_trc_memcpy_nram_to_gdram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_gdram_to_nram :
    ClangBuiltin<"__mlvm_trc_memcpy_gdram_to_nram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_wram_to_gdram :
    ClangBuiltin<"__mlvm_trc_memcpy_wram_to_gdram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_gdram_to_wram :
    ClangBuiltin<"__mlvm_trc_memcpy_gdram_to_wram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_sram_to_gdram :
    ClangBuiltin<"__mlvm_trc_memcpy_sram_to_gdram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_gdram_to_sram :
    ClangBuiltin<"__mlvm_trc_memcpy_gdram_to_sram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_gdram_to_gdram :
    ClangBuiltin<"__mlvm_trc_memcpy_gdram_to_gdram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_ldram_to_gdram :
    ClangBuiltin<"__mlvm_trc_memcpy_ldram_to_gdram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_gdram_to_ldram :
    ClangBuiltin<"__mlvm_trc_memcpy_gdram_to_ldram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_nram_to_ldram :
    ClangBuiltin<"__mlvm_trc_memcpy_nram_to_ldram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_ldram_to_nram :
    ClangBuiltin<"__mlvm_trc_memcpy_ldram_to_nram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_wram_to_ldram :
    ClangBuiltin<"__mlvm_trc_memcpy_wram_to_ldram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_ldram_to_wram :
    ClangBuiltin<"__mlvm_trc_memcpy_ldram_to_wram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_sram_to_ldram :
    ClangBuiltin<"__mlvm_trc_memcpy_sram_to_ldram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_ldram_to_sram :
    ClangBuiltin<"__mlvm_trc_memcpy_ldram_to_sram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_nram_to_sram :
    ClangBuiltin<"__mlvm_trc_memcpy_nram_to_sram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_sram_to_nram :
    ClangBuiltin<"__mlvm_trc_memcpy_sram_to_nram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_wram_to_sram :
    ClangBuiltin<"__mlvm_trc_memcpy_wram_to_sram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_sram_to_wram :
    ClangBuiltin<"__mlvm_trc_memcpy_sram_to_wram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_nram_to_nram :
    ClangBuiltin<"__mlvm_trc_memcpy_nram_to_nram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_wram_to_nram :
    ClangBuiltin<"__mlvm_trc_memcpy_wram_to_nram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_memcpy_nram_to_wram :
    ClangBuiltin<"__mlvm_trc_memcpy_nram_to_wram">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  //===--------------------------------------------------------------------===//
  // memset
  //===--------------------------------------------------------------------===//
  def int_mlvm_trc_memset_nram_s8 :
    ClangBuiltin<"__mlvm_trc_memset_nram_s8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_i8_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_nram_f16 :
    ClangBuiltin<"__mlvm_trc_memset_nram_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_half_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_nram_s16 :
    ClangBuiltin<"__mlvm_trc_memset_nram_s16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_i16_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_nram_u16 :
    ClangBuiltin<"__mlvm_trc_memset_nram_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_i16_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_nram_f32 :
    ClangBuiltin<"__mlvm_trc_memset_nram_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_float_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_nram_s32 :
    ClangBuiltin<"__mlvm_trc_memset_nram_s32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_i32_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_nram_u32 :
    ClangBuiltin<"__mlvm_trc_memset_nram_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_i32_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_gdram_s8 :
    ClangBuiltin<"__mlvm_trc_memset_gdram_s8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_i8_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_gdram_f16 :
    ClangBuiltin<"__mlvm_trc_memset_gdram_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_half_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_gdram_s16 :
    ClangBuiltin<"__mlvm_trc_memset_gdram_s16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_i16_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_gdram_u16 :
    ClangBuiltin<"__mlvm_trc_memset_gdram_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_i16_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_gdram_f32 :
    ClangBuiltin<"__mlvm_trc_memset_gdram_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_float_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_gdram_s32 :
    ClangBuiltin<"__mlvm_trc_memset_gdram_s32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_i32_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_gdram_u32 :
    ClangBuiltin<"__mlvm_trc_memset_gdram_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_i32_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_sram_s8 :
    ClangBuiltin<"__mlvm_trc_memset_sram_s8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_i8_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_sram_f16 :
    ClangBuiltin<"__mlvm_trc_memset_sram_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_half_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_sram_s16 :
    ClangBuiltin<"__mlvm_trc_memset_sram_s16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_i16_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_sram_u16 :
    ClangBuiltin<"__mlvm_trc_memset_sram_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_i16_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_sram_f32 :
    ClangBuiltin<"__mlvm_trc_memset_sram_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_float_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_sram_s32 :
    ClangBuiltin<"__mlvm_trc_memset_sram_s32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_i32_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_sram_u32 :
    ClangBuiltin<"__mlvm_trc_memset_sram_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_i32_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_ldram_s8 :
    ClangBuiltin<"__mlvm_trc_memset_ldram_s8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_i8_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_ldram_f16 :
    ClangBuiltin<"__mlvm_trc_memset_ldram_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_half_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_ldram_s16 :
    ClangBuiltin<"__mlvm_trc_memset_ldram_s16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_i16_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_ldram_u16 :
    ClangBuiltin<"__mlvm_trc_memset_ldram_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_i16_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_ldram_f32 :
    ClangBuiltin<"__mlvm_trc_memset_ldram_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_float_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_ldram_s32 :
    ClangBuiltin<"__mlvm_trc_memset_ldram_s32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_i32_ty],
            [IntrWriteMem]>;

  def int_mlvm_trc_memset_ldram_u32 :
    ClangBuiltin<"__mlvm_trc_memset_ldram_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_i32_ty],
            [IntrWriteMem]>;


  def int_mlvm_trc_active_sigmoid_f32 :
    ClangBuiltin<"__mlvm_trc_active_sigmoid_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_sigmoid_f16 :
    ClangBuiltin<"__mlvm_trc_active_sigmoid_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_cos_f32 :
    ClangBuiltin<"__mlvm_trc_active_cos_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_cos_f16 :
    ClangBuiltin<"__mlvm_trc_active_cos_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_exp_f32 :
    ClangBuiltin<"__mlvm_trc_active_exp_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_exp_f16 :
    ClangBuiltin<"__mlvm_trc_active_exp_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_sqrt_f32 :
    ClangBuiltin<"__mlvm_trc_active_sqrt_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_sqrt_f16 :
    ClangBuiltin<"__mlvm_trc_active_sqrt_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_sin_f32 :
    ClangBuiltin<"__mlvm_trc_active_sin_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_sin_f16 :
    ClangBuiltin<"__mlvm_trc_active_sin_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_tanh_f32 :
    ClangBuiltin<"__mlvm_trc_active_tanh_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_tanh_f16 :
    ClangBuiltin<"__mlvm_trc_active_tanh_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_sign_f32 :
    ClangBuiltin<"__mlvm_trc_active_sign_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_sign_f16 :
    ClangBuiltin<"__mlvm_trc_active_sign_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_pow2_f32 :
    ClangBuiltin<"__mlvm_trc_active_pow2_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_pow2_f16 :
    ClangBuiltin<"__mlvm_trc_active_pow2_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_gelu_f32 :
    ClangBuiltin<"__mlvm_trc_active_gelu_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_gelu_f16 :
    ClangBuiltin<"__mlvm_trc_active_gelu_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_exphp_f32 :
    ClangBuiltin<"__mlvm_trc_active_exphp_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_exphp_f16 :
    ClangBuiltin<"__mlvm_trc_active_exphp_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_explt0_f32 :
    ClangBuiltin<"__mlvm_trc_active_explt0_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_explt0_f16 :
    ClangBuiltin<"__mlvm_trc_active_explt0_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_sqrthp_f32 :
    ClangBuiltin<"__mlvm_trc_active_sqrthp_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_sqrthp_f16 :
    ClangBuiltin<"__mlvm_trc_active_sqrthp_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_rsqrt_f32 :
    ClangBuiltin<"__mlvm_trc_active_rsqrt_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_rsqrt_f16 :
    ClangBuiltin<"__mlvm_trc_active_rsqrt_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_rsqrthp_f32 :
    ClangBuiltin<"__mlvm_trc_active_rsqrthp_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_rsqrthp_f16 :
    ClangBuiltin<"__mlvm_trc_active_rsqrthp_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_reciprocal_f32 :
    ClangBuiltin<"__mlvm_trc_active_reciprocal_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_reciprocal_f16 :
    ClangBuiltin<"__mlvm_trc_active_reciprocal_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_reciprocalhp_f32 :
    ClangBuiltin<"__mlvm_trc_active_reciprocalhp_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_reciprocalhp_f16 :
    ClangBuiltin<"__mlvm_trc_active_reciprocalhp_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_recipgt1_f32 :
    ClangBuiltin<"__mlvm_trc_active_recipgt1_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_recipgt1_f16 :
    ClangBuiltin<"__mlvm_trc_active_recipgt1_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_log_f32 :
    ClangBuiltin<"__mlvm_trc_active_log_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_log_f16 :
    ClangBuiltin<"__mlvm_trc_active_log_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_loghp_f32 :
    ClangBuiltin<"__mlvm_trc_active_loghp_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_loghp_f16 :
    ClangBuiltin<"__mlvm_trc_active_loghp_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_geluhp_f32 :
    ClangBuiltin<"__mlvm_trc_active_geluhp_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_active_geluhp_f16 :
    ClangBuiltin<"__mlvm_trc_active_geluhp_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_maskmove :
    ClangBuiltin<"__mlvm_trc_maskmove">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_move_b8 :
    ClangBuiltin<"__mlvm_trc_move_b8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_move_b16 :
    ClangBuiltin<"__mlvm_trc_move_b16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_move_b32 :
    ClangBuiltin<"__mlvm_trc_move_b32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_add_f32 :
    ClangBuiltin<"__mlvm_trc_add_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_add_f16 :
    ClangBuiltin<"__mlvm_trc_add_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_sub_f32 :
    ClangBuiltin<"__mlvm_trc_sub_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_sub_f16 :
    ClangBuiltin<"__mlvm_trc_sub_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_mult_f32 :
    ClangBuiltin<"__mlvm_trc_mult_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_mult_f16 :
    ClangBuiltin<"__mlvm_trc_mult_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_maxequal_f32 :
    ClangBuiltin<"__mlvm_trc_maxequal_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_maxequal_f16 :
    ClangBuiltin<"__mlvm_trc_maxequal_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_minequal_f32 :
    ClangBuiltin<"__mlvm_trc_minequal_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_minequal_f16 :
    ClangBuiltin<"__mlvm_trc_minequal_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_pad :
    ClangBuiltin<"__mlvm_trc_pad">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_pad_inplace :
    ClangBuiltin<"__mlvm_trc_pad_inplace">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_add_scalar_f32 :
    ClangBuiltin<"__mlvm_trc_add_scalar_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_float_ty],
              []>;

  def int_mlvm_trc_add_scalar_f16 :
    ClangBuiltin<"__mlvm_trc_add_scalar_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_half_ty],
              []>;

  def int_mlvm_trc_sub_scalar_f32 :
    ClangBuiltin<"__mlvm_trc_sub_scalar_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_float_ty],
              []>;

  def int_mlvm_trc_sub_scalar_f16 :
    ClangBuiltin<"__mlvm_trc_sub_scalar_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_half_ty],
              []>;

  def int_mlvm_trc_mult_scalar_f32 :
    ClangBuiltin<"__mlvm_trc_mult_scalar_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_float_ty],
              []>;

  def int_mlvm_trc_mult_scalar_f16 :
    ClangBuiltin<"__mlvm_trc_mult_scalar_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_half_ty],
              []>;

  def int_mlvm_trc_maxequal_scalar_f32 :
    ClangBuiltin<"__mlvm_trc_maxequal_scalar_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_float_ty],
              []>;

  def int_mlvm_trc_maxequal_scalar_f16 :
    ClangBuiltin<"__mlvm_trc_maxequal_scalar_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_half_ty],
              []>;

  def int_mlvm_trc_minequal_scalar_f32 :
    ClangBuiltin<"__mlvm_trc_minequal_scalar_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_float_ty],
              []>;

  def int_mlvm_trc_minequal_scalar_f16 :
    ClangBuiltin<"__mlvm_trc_minequal_scalar_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_half_ty],
              []>;

  def int_mlvm_trc_and_f32 :
    ClangBuiltin<"__mlvm_trc_and_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_and_f16 :
    ClangBuiltin<"__mlvm_trc_and_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_or_f32 :
    ClangBuiltin<"__mlvm_trc_or_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_or_f16 :
    ClangBuiltin<"__mlvm_trc_or_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_xor_f32 :
    ClangBuiltin<"__mlvm_trc_xor_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_xor_f16 :
    ClangBuiltin<"__mlvm_trc_xor_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_not_f32 :
    ClangBuiltin<"__mlvm_trc_not_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_not_f16 :
    ClangBuiltin<"__mlvm_trc_not_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_eq_f32 :
    ClangBuiltin<"__mlvm_trc_eq_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_eq_f16 :
    ClangBuiltin<"__mlvm_trc_eq_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_ne_f32 :
    ClangBuiltin<"__mlvm_trc_ne_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_ne_f16 :
    ClangBuiltin<"__mlvm_trc_ne_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_gt_f32 :
    ClangBuiltin<"__mlvm_trc_gt_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_gt_f16 :
    ClangBuiltin<"__mlvm_trc_gt_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_lt_f32 :
    ClangBuiltin<"__mlvm_trc_lt_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_lt_f16 :
    ClangBuiltin<"__mlvm_trc_lt_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_ge_f32 :
    ClangBuiltin<"__mlvm_trc_ge_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_ge_f16 :
    ClangBuiltin<"__mlvm_trc_ge_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_le_f32 :
    ClangBuiltin<"__mlvm_trc_le_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_le_f16 :
    ClangBuiltin<"__mlvm_trc_le_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

 def int_mlvm_trc_band_f32 :
    ClangBuiltin<"__mlvm_trc_band_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_band_f16 :
    ClangBuiltin<"__mlvm_trc_band_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_bor_f32 :
    ClangBuiltin<"__mlvm_trc_bor_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_bor_f16 :
    ClangBuiltin<"__mlvm_trc_bor_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_bxor_f32 :
    ClangBuiltin<"__mlvm_trc_bxor_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_bxor_f16 :
    ClangBuiltin<"__mlvm_trc_bxor_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_bnot_f32 :
    ClangBuiltin<"__mlvm_trc_bnot_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_bnot_f16 :
    ClangBuiltin<"__mlvm_trc_bnot_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_eq_bitindex_f32 :
    ClangBuiltin<"__mlvm_trc_eq_bitindex_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_eq_bitindex_f16 :
    ClangBuiltin<"__mlvm_trc_eq_bitindex_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_ne_bitindex_f32 :
    ClangBuiltin<"__mlvm_trc_ne_bitindex_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_ne_bitindex_f16 :
    ClangBuiltin<"__mlvm_trc_ne_bitindex_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_gt_bitindex_f32 :
    ClangBuiltin<"__mlvm_trc_gt_bitindex_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_gt_bitindex_f16 :
    ClangBuiltin<"__mlvm_trc_gt_bitindex_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_ge_bitindex_f32 :
    ClangBuiltin<"__mlvm_trc_ge_bitindex_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_ge_bitindex_f16 :
    ClangBuiltin<"__mlvm_trc_ge_bitindex_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_lt_bitindex_f32 :
    ClangBuiltin<"__mlvm_trc_lt_bitindex_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_lt_bitindex_f16 :
    ClangBuiltin<"__mlvm_trc_lt_bitindex_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_le_bitindex_f32 :
    ClangBuiltin<"__mlvm_trc_le_bitindex_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_le_bitindex_f16 :
    ClangBuiltin<"__mlvm_trc_le_bitindex_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_abs_f32 :
    ClangBuiltin<"__mlvm_trc_abs_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_abs_f16 :
    ClangBuiltin<"__mlvm_trc_abs_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_square_f32 :
    ClangBuiltin<"__mlvm_trc_square_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_square_f16 :
    ClangBuiltin<"__mlvm_trc_square_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_accsum_f32 :
    ClangBuiltin<"__mlvm_trc_accsum_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_accsum_f16 :
    ClangBuiltin<"__mlvm_trc_accsum_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_accsum_hp_f16 :
    ClangBuiltin<"__mlvm_trc_accsum_hp_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_relu_f32 :
    ClangBuiltin<"__mlvm_trc_relu_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_relu_f16 :
    ClangBuiltin<"__mlvm_trc_relu_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_relun_f32 :
    ClangBuiltin<"__mlvm_trc_relun_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_float_ty],
              []>;

  def int_mlvm_trc_relun_f16 :
    ClangBuiltin<"__mlvm_trc_relun_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_half_ty],
              []>;

  def int_mlvm_trc_conv_f32_int16_int16 :
    ClangBuiltin<"__mlvm_trc_conv_f32_int16_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_f32_int16_int8 :
    ClangBuiltin<"__mlvm_trc_conv_f32_int16_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_f32_int8_int16 :
    ClangBuiltin<"__mlvm_trc_conv_f32_int8_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_f32_int8_int8 :
    ClangBuiltin<"__mlvm_trc_conv_f32_int8_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_f16_int16_int16 :
    ClangBuiltin<"__mlvm_trc_conv_f16_int16_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_f16_int16_int8 :
    ClangBuiltin<"__mlvm_trc_conv_f16_int16_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_f16_int8_int16 :
    ClangBuiltin<"__mlvm_trc_conv_f16_int8_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_f16_int8_int8 :
    ClangBuiltin<"__mlvm_trc_conv_f16_int8_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_f32_f32_f32 :
    ClangBuiltin<"__mlvm_trc_conv_f32_f32_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_f32_f32_f16 :
    ClangBuiltin<"__mlvm_trc_conv_f32_f32_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_f32_f16_f32 :
    ClangBuiltin<"__mlvm_trc_conv_f32_f16_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_f32_f16_f16 :
    ClangBuiltin<"__mlvm_trc_conv_f32_f16_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_f32_int16_int16 :
    ClangBuiltin<"__mlvm_trc_conv_bias_f32_int16_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_f32_int16_int8 :
    ClangBuiltin<"__mlvm_trc_conv_bias_f32_int16_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_f32_int8_int16 :
    ClangBuiltin<"__mlvm_trc_conv_bias_f32_int8_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_f32_int8_int8 :
    ClangBuiltin<"__mlvm_trc_conv_bias_f32_int8_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_f16_int16_int16 :
    ClangBuiltin<"__mlvm_trc_conv_bias_f16_int16_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_f16_int16_int8 :
    ClangBuiltin<"__mlvm_trc_conv_bias_f16_int16_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_f16_int8_int16 :
    ClangBuiltin<"__mlvm_trc_conv_bias_f16_int8_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_f16_int8_int8 :
    ClangBuiltin<"__mlvm_trc_conv_bias_f16_int8_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_f32_f32_f32 :
    ClangBuiltin<"__mlvm_trc_conv_bias_f32_f32_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_f32_f32_f16 :
    ClangBuiltin<"__mlvm_trc_conv_bias_f32_f32_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_f32_f16_f32 :
    ClangBuiltin<"__mlvm_trc_conv_bias_f32_f16_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_f32_f16_f16 :
    ClangBuiltin<"__mlvm_trc_conv_bias_f32_f16_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_dilation_f32_int16_int16 :
    ClangBuiltin<"__mlvm_trc_conv_dilation_f32_int16_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_dilation_f32_int16_int8 :
    ClangBuiltin<"__mlvm_trc_conv_dilation_f32_int16_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_dilation_f32_int8_int16 :
    ClangBuiltin<"__mlvm_trc_conv_dilation_f32_int8_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_dilation_f32_int8_int8 :
    ClangBuiltin<"__mlvm_trc_conv_dilation_f32_int8_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_dilation_f16_int16_int16 :
    ClangBuiltin<"__mlvm_trc_conv_dilation_f16_int16_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_dilation_f16_int16_int8 :
    ClangBuiltin<"__mlvm_trc_conv_dilation_f16_int16_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_dilation_f16_int8_int16 :
    ClangBuiltin<"__mlvm_trc_conv_dilation_f16_int8_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_dilation_f16_int8_int8 :
    ClangBuiltin<"__mlvm_trc_conv_dilation_f16_int8_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_dilation_f32_f32_f32 :
    ClangBuiltin<"__mlvm_trc_conv_dilation_f32_f32_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_dilation_f32_f32_f16 :
    ClangBuiltin<"__mlvm_trc_conv_dilation_f32_f32_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_dilation_f32_f16_f32 :
    ClangBuiltin<"__mlvm_trc_conv_dilation_f32_f16_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_dilation_f32_f16_f16 :
    ClangBuiltin<"__mlvm_trc_conv_dilation_f32_f16_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_dilation_f32_int16_int16 :
    ClangBuiltin<"__mlvm_trc_conv_bias_dilation_f32_int16_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_dilation_f32_int16_int8 :
    ClangBuiltin<"__mlvm_trc_conv_bias_dilation_f32_int16_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_dilation_f32_int8_int16 :
    ClangBuiltin<"__mlvm_trc_conv_bias_dilation_f32_int8_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_dilation_f32_int8_int8 :
    ClangBuiltin<"__mlvm_trc_conv_bias_dilation_f32_int8_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_dilation_f16_int16_int16 :
    ClangBuiltin<"__mlvm_trc_conv_bias_dilation_f16_int16_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_dilation_f16_int16_int8 :
    ClangBuiltin<"__mlvm_trc_conv_bias_dilation_f16_int16_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_dilation_f16_int8_int16 :
    ClangBuiltin<"__mlvm_trc_conv_bias_dilation_f16_int8_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_dilation_f16_int8_int8 :
    ClangBuiltin<"__mlvm_trc_conv_bias_dilation_f16_int8_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_dilation_f32_f32_f32 :
    ClangBuiltin<"__mlvm_trc_conv_bias_dilation_f32_f32_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_dilation_f32_f32_f16 :
    ClangBuiltin<"__mlvm_trc_conv_bias_dilation_f32_f32_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_dilation_f32_f16_f32 :
    ClangBuiltin<"__mlvm_trc_conv_bias_dilation_f32_f16_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_conv_bias_dilation_f32_f16_f16 :
    ClangBuiltin<"__mlvm_trc_conv_bias_dilation_f32_f16_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_select_f16 :
    ClangBuiltin<"__mlvm_trc_select_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_select_f32 :
    ClangBuiltin<"__mlvm_trc_select_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_select_bitindex_f16 :
    ClangBuiltin<"__mlvm_trc_select_bitindex_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_select_bitindex_f32 :
    ClangBuiltin<"__mlvm_trc_select_bitindex_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_select1d_f16 :
    ClangBuiltin<"__mlvm_trc_select1d_f16">,
    Intrinsic<[llvm_i32_ty], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_select1d_f32 :
    ClangBuiltin<"__mlvm_trc_select1d_f32">,
    Intrinsic<[llvm_i32_ty], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_count_f16 :
    ClangBuiltin<"__mlvm_trc_count_f16">,
    Intrinsic<[llvm_i32_ty], [llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_count_f32 :
    ClangBuiltin<"__mlvm_trc_count_f32">,
    Intrinsic<[llvm_i32_ty], [llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_count_bitindex_f16 :
    ClangBuiltin<"__mlvm_trc_count_bitindex_f16">,
    Intrinsic<[llvm_i32_ty], [llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_count_bitindex_f32 :
    ClangBuiltin<"__mlvm_trc_count_bitindex_f32">,
    Intrinsic<[llvm_i32_ty], [llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_findfirst1_f16 :
    ClangBuiltin<"__mlvm_trc_findfirst1_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_findfirst1_f32 :
    ClangBuiltin<"__mlvm_trc_findfirst1_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_findlast1_f16 :
    ClangBuiltin<"__mlvm_trc_findlast1_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_findlast1_f32 :
    ClangBuiltin<"__mlvm_trc_findlast1_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_findfirst1d_f16 :
    ClangBuiltin<"__mlvm_trc_findfirst1d_f16">,
    Intrinsic<[llvm_i32_ty], [llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_findfirst1d_f32 :
    ClangBuiltin<"__mlvm_trc_findfirst1d_f32">,
    Intrinsic<[llvm_i32_ty], [llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_findlast1d_f16 :
    ClangBuiltin<"__mlvm_trc_findlast1d_f16">,
    Intrinsic<[llvm_i32_ty], [llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_findlast1d_f32 :
    ClangBuiltin<"__mlvm_trc_findlast1d_f32">,
    Intrinsic<[llvm_i32_ty], [llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_faa_f16 :
    ClangBuiltin<"__mlvm_trc_faa_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_faa_f32 :
    ClangBuiltin<"__mlvm_trc_faa_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_fas_f16 :
    ClangBuiltin<"__mlvm_trc_fas_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_fas_f32 :
    ClangBuiltin<"__mlvm_trc_fas_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_fam_f16 :
    ClangBuiltin<"__mlvm_trc_fam_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_fam_f32 :
    ClangBuiltin<"__mlvm_trc_fam_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_fma_f16 :
    ClangBuiltin<"__mlvm_trc_fma_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_fma_f32 :
    ClangBuiltin<"__mlvm_trc_fma_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_fms_f16 :
    ClangBuiltin<"__mlvm_trc_fms_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_fms_f32 :
    ClangBuiltin<"__mlvm_trc_fms_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_fsa_f16 :
    ClangBuiltin<"__mlvm_trc_fsa_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_fsa_f32 :
    ClangBuiltin<"__mlvm_trc_fsa_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_fsm_f16 :
    ClangBuiltin<"__mlvm_trc_fsm_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_fsm_f32 :
    ClangBuiltin<"__mlvm_trc_fsm_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_fss_f16 :
    ClangBuiltin<"__mlvm_trc_fss_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_fss_f32 :
    ClangBuiltin<"__mlvm_trc_fss_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_writezero :
    ClangBuiltin<"__mlvm_trc_writezero">,
    Intrinsic<[], [llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_avgpool_f32 :
    ClangBuiltin<"__mlvm_trc_avgpool_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_avgpool_f16 :
    ClangBuiltin<"__mlvm_trc_avgpool_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_maxpool_f32 :
    ClangBuiltin<"__mlvm_trc_maxpool_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_maxpool_f16 :
    ClangBuiltin<"__mlvm_trc_maxpool_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_maxpool_index_f32 :
    ClangBuiltin<"__mlvm_trc_maxpool_index_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_maxpool_index_f16 :
    ClangBuiltin<"__mlvm_trc_maxpool_index_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_maxpool_value_index_f32 :
    ClangBuiltin<"__mlvm_trc_maxpool_value_index_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty],
              []>;

  def int_mlvm_trc_maxpool_value_index_f16 :
    ClangBuiltin<"__mlvm_trc_maxpool_value_index_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_minpool_f32 :
    ClangBuiltin<"__mlvm_trc_minpool_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_minpool_f16 :
    ClangBuiltin<"__mlvm_trc_minpool_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_minpool_index_f32 :
    ClangBuiltin<"__mlvm_trc_minpool_index_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_minpool_index_f16 :
    ClangBuiltin<"__mlvm_trc_minpool_index_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_minpool_value_index_f32 :
    ClangBuiltin<"__mlvm_trc_minpool_value_index_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_minpool_value_index_f16 :
    ClangBuiltin<"__mlvm_trc_minpool_value_index_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty],
              []>;

  def int_mlvm_trc_avgpool_dilation_f16 :
    ClangBuiltin<"__mlvm_trc_avgpool_dilation_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_avgpool_dilation_f32 :
    ClangBuiltin<"__mlvm_trc_avgpool_dilation_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_maxpool_dilation_f16 :
    ClangBuiltin<"__mlvm_trc_maxpool_dilation_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_maxpool_dilation_f32 :
    ClangBuiltin<"__mlvm_trc_maxpool_dilation_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_maxpool_dilation_index_f16 :
    ClangBuiltin<"__mlvm_trc_maxpool_dilation_index_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_maxpool_dilation_index_f32 :
    ClangBuiltin<"__mlvm_trc_maxpool_dilation_index_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_maxpool_dilation_value_index_f16 :
    ClangBuiltin<"__mlvm_trc_maxpool_dilation_value_index_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_maxpool_dilation_value_index_f32 :
    ClangBuiltin<"__mlvm_trc_maxpool_dilation_value_index_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_minpool_dilation_f16 :
    ClangBuiltin<"__mlvm_trc_minpool_dilation_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_minpool_dilation_f32 :
    ClangBuiltin<"__mlvm_trc_minpool_dilation_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_minpool_dilation_index_f16 :
    ClangBuiltin<"__mlvm_trc_minpool_dilation_index_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_minpool_dilation_index_f32 :
    ClangBuiltin<"__mlvm_trc_minpool_dilation_index_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_minpool_dilation_value_index_f16 :
    ClangBuiltin<"__mlvm_trc_minpool_dilation_value_index_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_minpool_dilation_value_index_f32 :
    ClangBuiltin<"__mlvm_trc_minpool_dilation_value_index_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_avgpool_bp_f16 :
    ClangBuiltin<"__mlvm_trc_avgpool_bp_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_avgpool_bp_f32 :
    ClangBuiltin<"__mlvm_trc_avgpool_bp_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_avgpool_bp_dilation_f16 :
    ClangBuiltin<"__mlvm_trc_avgpool_bp_dilation_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_avgpool_bp_dilation_f32 :
    ClangBuiltin<"__mlvm_trc_avgpool_bp_dilation_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_maxpool_bp_f16 :
    ClangBuiltin<"__mlvm_trc_maxpool_bp_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_maxpool_bp_f32 :
    ClangBuiltin<"__mlvm_trc_maxpool_bp_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_maxpool_bp_dilation_f16 :
    ClangBuiltin<"__mlvm_trc_maxpool_bp_dilation_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_maxpool_bp_dilation_f32 :
    ClangBuiltin<"__mlvm_trc_maxpool_bp_dilation_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_unpool_bp_f16 :
    ClangBuiltin<"__mlvm_trc_unpool_bp_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_unpool_bp_f32 :
    ClangBuiltin<"__mlvm_trc_unpool_bp_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_unpool_bp_dilation_f16 :
    ClangBuiltin<"__mlvm_trc_unpool_bp_dilation_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_unpool_bp_dilation_f32 :
    ClangBuiltin<"__mlvm_trc_unpool_bp_dilation_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_cvtf16_f32 :
    ClangBuiltin<"__mlvm_trc_cvtf16_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf16_f32_tz :
    ClangBuiltin<"__mlvm_trc_cvtf16_f32_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf16_f32_oz :
    ClangBuiltin<"__mlvm_trc_cvtf16_f32_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf16_f32_up :
    ClangBuiltin<"__mlvm_trc_cvtf16_f32_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf16_f32_dn :
    ClangBuiltin<"__mlvm_trc_cvtf16_f32_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf16_f32_rd :
    ClangBuiltin<"__mlvm_trc_cvtf16_f32_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf16_f32_rn :
    ClangBuiltin<"__mlvm_trc_cvtf16_f32_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf16_f32_rm :
    ClangBuiltin<"__mlvm_trc_cvtf16_f32_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf16_int8 :
    ClangBuiltin<"__mlvm_trc_cvtf16_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int8_tz :
    ClangBuiltin<"__mlvm_trc_cvtf16_int8_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int8_oz :
    ClangBuiltin<"__mlvm_trc_cvtf16_int8_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int8_up :
    ClangBuiltin<"__mlvm_trc_cvtf16_int8_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int8_dn :
    ClangBuiltin<"__mlvm_trc_cvtf16_int8_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int8_rd :
    ClangBuiltin<"__mlvm_trc_cvtf16_int8_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int8_rn :
    ClangBuiltin<"__mlvm_trc_cvtf16_int8_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int8_rm :
    ClangBuiltin<"__mlvm_trc_cvtf16_int8_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int16 :
    ClangBuiltin<"__mlvm_trc_cvtf16_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int16_tz :
    ClangBuiltin<"__mlvm_trc_cvtf16_int16_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int16_oz :
    ClangBuiltin<"__mlvm_trc_cvtf16_int16_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int16_up :
    ClangBuiltin<"__mlvm_trc_cvtf16_int16_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int16_dn :
    ClangBuiltin<"__mlvm_trc_cvtf16_int16_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int16_rd :
    ClangBuiltin<"__mlvm_trc_cvtf16_int16_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int16_rn :
    ClangBuiltin<"__mlvm_trc_cvtf16_int16_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int16_rm :
    ClangBuiltin<"__mlvm_trc_cvtf16_int16_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int32 :
    ClangBuiltin<"__mlvm_trc_cvtf16_int32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int32_tz :
    ClangBuiltin<"__mlvm_trc_cvtf16_int32_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int32_oz :
    ClangBuiltin<"__mlvm_trc_cvtf16_int32_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int32_up :
    ClangBuiltin<"__mlvm_trc_cvtf16_int32_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int32_dn :
    ClangBuiltin<"__mlvm_trc_cvtf16_int32_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int32_rd :
    ClangBuiltin<"__mlvm_trc_cvtf16_int32_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int32_rn :
    ClangBuiltin<"__mlvm_trc_cvtf16_int32_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_int32_rm :
    ClangBuiltin<"__mlvm_trc_cvtf16_int32_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf16_u8 :
    ClangBuiltin<"__mlvm_trc_cvtf16_u8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf16_u8_tz :
    ClangBuiltin<"__mlvm_trc_cvtf16_u8_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf16_u8_oz :
    ClangBuiltin<"__mlvm_trc_cvtf16_u8_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf16_u8_up :
    ClangBuiltin<"__mlvm_trc_cvtf16_u8_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf16_u8_dn :
    ClangBuiltin<"__mlvm_trc_cvtf16_u8_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf16_u8_rd :
    ClangBuiltin<"__mlvm_trc_cvtf16_u8_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf16_u8_rn :
    ClangBuiltin<"__mlvm_trc_cvtf16_u8_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf16_u8_rm :
    ClangBuiltin<"__mlvm_trc_cvtf16_u8_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf32_f16 :
    ClangBuiltin<"__mlvm_trc_cvtf32_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf32_f16_tz :
    ClangBuiltin<"__mlvm_trc_cvtf32_f16_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf32_f16_oz :
    ClangBuiltin<"__mlvm_trc_cvtf32_f16_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf32_f16_up :
    ClangBuiltin<"__mlvm_trc_cvtf32_f16_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf32_f16_dn :
    ClangBuiltin<"__mlvm_trc_cvtf32_f16_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf32_f16_rd :
    ClangBuiltin<"__mlvm_trc_cvtf32_f16_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf32_f16_rn :
    ClangBuiltin<"__mlvm_trc_cvtf32_f16_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf32_f16_rm :
    ClangBuiltin<"__mlvm_trc_cvtf32_f16_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf32_int8 :
    ClangBuiltin<"__mlvm_trc_cvtf32_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int8_tz :
    ClangBuiltin<"__mlvm_trc_cvtf32_int8_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int8_oz :
    ClangBuiltin<"__mlvm_trc_cvtf32_int8_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int8_up :
    ClangBuiltin<"__mlvm_trc_cvtf32_int8_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int8_dn :
    ClangBuiltin<"__mlvm_trc_cvtf32_int8_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int8_rd :
    ClangBuiltin<"__mlvm_trc_cvtf32_int8_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int8_rn :
    ClangBuiltin<"__mlvm_trc_cvtf32_int8_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int8_rm :
    ClangBuiltin<"__mlvm_trc_cvtf32_int8_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int16 :
    ClangBuiltin<"__mlvm_trc_cvtf32_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int16_tz :
    ClangBuiltin<"__mlvm_trc_cvtf32_int16_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int16_oz :
    ClangBuiltin<"__mlvm_trc_cvtf32_int16_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int16_up :
    ClangBuiltin<"__mlvm_trc_cvtf32_int16_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int16_dn :
    ClangBuiltin<"__mlvm_trc_cvtf32_int16_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int16_rd :
    ClangBuiltin<"__mlvm_trc_cvtf32_int16_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int16_rn :
    ClangBuiltin<"__mlvm_trc_cvtf32_int16_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int16_rm :
    ClangBuiltin<"__mlvm_trc_cvtf32_int16_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int32 :
    ClangBuiltin<"__mlvm_trc_cvtf32_int32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int32_tz :
    ClangBuiltin<"__mlvm_trc_cvtf32_int32_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int32_oz :
    ClangBuiltin<"__mlvm_trc_cvtf32_int32_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int32_up :
    ClangBuiltin<"__mlvm_trc_cvtf32_int32_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int32_dn :
    ClangBuiltin<"__mlvm_trc_cvtf32_int32_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int32_rd :
    ClangBuiltin<"__mlvm_trc_cvtf32_int32_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int32_rn :
    ClangBuiltin<"__mlvm_trc_cvtf32_int32_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_int32_rm :
    ClangBuiltin<"__mlvm_trc_cvtf32_int32_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtf32_u8 :
    ClangBuiltin<"__mlvm_trc_cvtf32_u8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf32_u8_tz :
    ClangBuiltin<"__mlvm_trc_cvtf32_u8_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf32_u8_oz :
    ClangBuiltin<"__mlvm_trc_cvtf32_u8_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf32_u8_up :
    ClangBuiltin<"__mlvm_trc_cvtf32_u8_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf32_u8_dn :
    ClangBuiltin<"__mlvm_trc_cvtf32_u8_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf32_u8_rd :
    ClangBuiltin<"__mlvm_trc_cvtf32_u8_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf32_u8_rn :
    ClangBuiltin<"__mlvm_trc_cvtf32_u8_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtf32_u8_rm :
    ClangBuiltin<"__mlvm_trc_cvtf32_u8_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtint8_f16 :
    ClangBuiltin<"__mlvm_trc_cvtint8_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_f16_tz :
    ClangBuiltin<"__mlvm_trc_cvtint8_f16_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_f16_oz :
    ClangBuiltin<"__mlvm_trc_cvtint8_f16_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_f16_up :
    ClangBuiltin<"__mlvm_trc_cvtint8_f16_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_f16_dn :
    ClangBuiltin<"__mlvm_trc_cvtint8_f16_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_f16_rd :
    ClangBuiltin<"__mlvm_trc_cvtint8_f16_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_f16_rn :
    ClangBuiltin<"__mlvm_trc_cvtint8_f16_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_f16_rm :
    ClangBuiltin<"__mlvm_trc_cvtint8_f16_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_f32 :
    ClangBuiltin<"__mlvm_trc_cvtint8_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_f32_tz :
    ClangBuiltin<"__mlvm_trc_cvtint8_f32_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_f32_oz :
    ClangBuiltin<"__mlvm_trc_cvtint8_f32_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_f32_up :
    ClangBuiltin<"__mlvm_trc_cvtint8_f32_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_f32_dn :
    ClangBuiltin<"__mlvm_trc_cvtint8_f32_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_f32_rd :
    ClangBuiltin<"__mlvm_trc_cvtint8_f32_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_f32_rn :
    ClangBuiltin<"__mlvm_trc_cvtint8_f32_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_f32_rm :
    ClangBuiltin<"__mlvm_trc_cvtint8_f32_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_int16 :
    ClangBuiltin<"__mlvm_trc_cvtint8_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_int16_tz :
    ClangBuiltin<"__mlvm_trc_cvtint8_int16_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_int16_oz :
    ClangBuiltin<"__mlvm_trc_cvtint8_int16_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_int16_up :
    ClangBuiltin<"__mlvm_trc_cvtint8_int16_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_int16_dn :
    ClangBuiltin<"__mlvm_trc_cvtint8_int16_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_int16_rd :
    ClangBuiltin<"__mlvm_trc_cvtint8_int16_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_int16_rn :
    ClangBuiltin<"__mlvm_trc_cvtint8_int16_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_int16_rm :
    ClangBuiltin<"__mlvm_trc_cvtint8_int16_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_int32 :
    ClangBuiltin<"__mlvm_trc_cvtint8_int32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_int32_tz :
    ClangBuiltin<"__mlvm_trc_cvtint8_int32_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_int32_oz :
    ClangBuiltin<"__mlvm_trc_cvtint8_int32_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_int32_up :
    ClangBuiltin<"__mlvm_trc_cvtint8_int32_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_int32_dn :
    ClangBuiltin<"__mlvm_trc_cvtint8_int32_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_int32_rd :
    ClangBuiltin<"__mlvm_trc_cvtint8_int32_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_int32_rn :
    ClangBuiltin<"__mlvm_trc_cvtint8_int32_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_int32_rm :
    ClangBuiltin<"__mlvm_trc_cvtint8_int32_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_u8 :
    ClangBuiltin<"__mlvm_trc_cvtint8_u8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_u8_tz :
    ClangBuiltin<"__mlvm_trc_cvtint8_u8_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_u8_oz :
    ClangBuiltin<"__mlvm_trc_cvtint8_u8_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_u8_up :
    ClangBuiltin<"__mlvm_trc_cvtint8_u8_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_u8_dn :
    ClangBuiltin<"__mlvm_trc_cvtint8_u8_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_u8_rd :
    ClangBuiltin<"__mlvm_trc_cvtint8_u8_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_u8_rn :
    ClangBuiltin<"__mlvm_trc_cvtint8_u8_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint8_u8_rm :
    ClangBuiltin<"__mlvm_trc_cvtint8_u8_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_f16 :
    ClangBuiltin<"__mlvm_trc_cvtint16_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_f16_tz :
    ClangBuiltin<"__mlvm_trc_cvtint16_f16_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_f16_oz :
    ClangBuiltin<"__mlvm_trc_cvtint16_f16_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_f16_up :
    ClangBuiltin<"__mlvm_trc_cvtint16_f16_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_f16_dn :
    ClangBuiltin<"__mlvm_trc_cvtint16_f16_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_f16_rd :
    ClangBuiltin<"__mlvm_trc_cvtint16_f16_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_f16_rn :
    ClangBuiltin<"__mlvm_trc_cvtint16_f16_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_f16_rm :
    ClangBuiltin<"__mlvm_trc_cvtint16_f16_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_f32 :
    ClangBuiltin<"__mlvm_trc_cvtint16_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_f32_tz :
    ClangBuiltin<"__mlvm_trc_cvtint16_f32_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_f32_oz :
    ClangBuiltin<"__mlvm_trc_cvtint16_f32_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_f32_up :
    ClangBuiltin<"__mlvm_trc_cvtint16_f32_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_f32_dn :
    ClangBuiltin<"__mlvm_trc_cvtint16_f32_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_f32_rd :
    ClangBuiltin<"__mlvm_trc_cvtint16_f32_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_f32_rn :
    ClangBuiltin<"__mlvm_trc_cvtint16_f32_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_f32_rm :
    ClangBuiltin<"__mlvm_trc_cvtint16_f32_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_int8 :
    ClangBuiltin<"__mlvm_trc_cvtint16_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_int8_tz :
    ClangBuiltin<"__mlvm_trc_cvtint16_int8_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_int8_oz :
    ClangBuiltin<"__mlvm_trc_cvtint16_int8_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_int8_up :
    ClangBuiltin<"__mlvm_trc_cvtint16_int8_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_int8_dn :
    ClangBuiltin<"__mlvm_trc_cvtint16_int8_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_int8_rd :
    ClangBuiltin<"__mlvm_trc_cvtint16_int8_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_int8_rn :
    ClangBuiltin<"__mlvm_trc_cvtint16_int8_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_int8_rm :
    ClangBuiltin<"__mlvm_trc_cvtint16_int8_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_int32 :
    ClangBuiltin<"__mlvm_trc_cvtint16_int32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_int32_tz :
    ClangBuiltin<"__mlvm_trc_cvtint16_int32_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_int32_oz :
    ClangBuiltin<"__mlvm_trc_cvtint16_int32_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_int32_up :
    ClangBuiltin<"__mlvm_trc_cvtint16_int32_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_int32_dn :
    ClangBuiltin<"__mlvm_trc_cvtint16_int32_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_int32_rd :
    ClangBuiltin<"__mlvm_trc_cvtint16_int32_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_int32_rn :
    ClangBuiltin<"__mlvm_trc_cvtint16_int32_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_int32_rm :
    ClangBuiltin<"__mlvm_trc_cvtint16_int32_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_u8 :
    ClangBuiltin<"__mlvm_trc_cvtint16_u8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_u8_tz :
    ClangBuiltin<"__mlvm_trc_cvtint16_u8_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_u8_oz :
    ClangBuiltin<"__mlvm_trc_cvtint16_u8_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_u8_up :
    ClangBuiltin<"__mlvm_trc_cvtint16_u8_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_u8_dn :
    ClangBuiltin<"__mlvm_trc_cvtint16_u8_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_u8_rd :
    ClangBuiltin<"__mlvm_trc_cvtint16_u8_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_u8_rn :
    ClangBuiltin<"__mlvm_trc_cvtint16_u8_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint16_u8_rm :
    ClangBuiltin<"__mlvm_trc_cvtint16_u8_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_f16 :
    ClangBuiltin<"__mlvm_trc_cvtint32_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_f16_tz :
    ClangBuiltin<"__mlvm_trc_cvtint32_f16_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_f16_oz :
    ClangBuiltin<"__mlvm_trc_cvtint32_f16_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_f16_up :
    ClangBuiltin<"__mlvm_trc_cvtint32_f16_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_f16_dn :
    ClangBuiltin<"__mlvm_trc_cvtint32_f16_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_f16_rd :
    ClangBuiltin<"__mlvm_trc_cvtint32_f16_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_f16_rn :
    ClangBuiltin<"__mlvm_trc_cvtint32_f16_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_f16_rm :
    ClangBuiltin<"__mlvm_trc_cvtint32_f16_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_f32 :
    ClangBuiltin<"__mlvm_trc_cvtint32_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_f32_tz :
    ClangBuiltin<"__mlvm_trc_cvtint32_f32_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_f32_oz :
    ClangBuiltin<"__mlvm_trc_cvtint32_f32_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_f32_up :
    ClangBuiltin<"__mlvm_trc_cvtint32_f32_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_f32_dn :
    ClangBuiltin<"__mlvm_trc_cvtint32_f32_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_f32_rd :
    ClangBuiltin<"__mlvm_trc_cvtint32_f32_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_f32_rn :
    ClangBuiltin<"__mlvm_trc_cvtint32_f32_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_f32_rm :
    ClangBuiltin<"__mlvm_trc_cvtint32_f32_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_int8 :
    ClangBuiltin<"__mlvm_trc_cvtint32_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_int8_tz :
    ClangBuiltin<"__mlvm_trc_cvtint32_int8_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_int8_oz :
    ClangBuiltin<"__mlvm_trc_cvtint32_int8_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_int8_up :
    ClangBuiltin<"__mlvm_trc_cvtint32_int8_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_int8_dn :
    ClangBuiltin<"__mlvm_trc_cvtint32_int8_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_int8_rd :
    ClangBuiltin<"__mlvm_trc_cvtint32_int8_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_int8_rn :
    ClangBuiltin<"__mlvm_trc_cvtint32_int8_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_int8_rm :
    ClangBuiltin<"__mlvm_trc_cvtint32_int8_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_int16 :
    ClangBuiltin<"__mlvm_trc_cvtint32_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_int16_tz :
    ClangBuiltin<"__mlvm_trc_cvtint32_int16_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_int16_oz :
    ClangBuiltin<"__mlvm_trc_cvtint32_int16_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_int16_up :
    ClangBuiltin<"__mlvm_trc_cvtint32_int16_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_int16_dn :
    ClangBuiltin<"__mlvm_trc_cvtint32_int16_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_int16_rd :
    ClangBuiltin<"__mlvm_trc_cvtint32_int16_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_int16_rn :
    ClangBuiltin<"__mlvm_trc_cvtint32_int16_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_int16_rm :
    ClangBuiltin<"__mlvm_trc_cvtint32_int16_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty, llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_u8 :
    ClangBuiltin<"__mlvm_trc_cvtint32_u8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_u8_tz :
    ClangBuiltin<"__mlvm_trc_cvtint32_u8_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_u8_oz :
    ClangBuiltin<"__mlvm_trc_cvtint32_u8_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_u8_up :
    ClangBuiltin<"__mlvm_trc_cvtint32_u8_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_u8_dn :
    ClangBuiltin<"__mlvm_trc_cvtint32_u8_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_u8_rd :
    ClangBuiltin<"__mlvm_trc_cvtint32_u8_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_u8_rn :
    ClangBuiltin<"__mlvm_trc_cvtint32_u8_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtint32_u8_rm :
    ClangBuiltin<"__mlvm_trc_cvtint32_u8_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_f16 :
    ClangBuiltin<"__mlvm_trc_cvtu8_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtu8_f16_tz :
    ClangBuiltin<"__mlvm_trc_cvtu8_f16_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtu8_f16_oz :
    ClangBuiltin<"__mlvm_trc_cvtu8_f16_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtu8_f16_up :
    ClangBuiltin<"__mlvm_trc_cvtu8_f16_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtu8_f16_dn :
    ClangBuiltin<"__mlvm_trc_cvtu8_f16_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtu8_f16_rd :
    ClangBuiltin<"__mlvm_trc_cvtu8_f16_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtu8_f16_rn :
    ClangBuiltin<"__mlvm_trc_cvtu8_f16_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtu8_f16_rm :
    ClangBuiltin<"__mlvm_trc_cvtu8_f16_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtu8_f32 :
    ClangBuiltin<"__mlvm_trc_cvtu8_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtu8_f32_tz :
    ClangBuiltin<"__mlvm_trc_cvtu8_f32_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtu8_f32_oz :
    ClangBuiltin<"__mlvm_trc_cvtu8_f32_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtu8_f32_up :
    ClangBuiltin<"__mlvm_trc_cvtu8_f32_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtu8_f32_dn :
    ClangBuiltin<"__mlvm_trc_cvtu8_f32_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtu8_f32_rd :
    ClangBuiltin<"__mlvm_trc_cvtu8_f32_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtu8_f32_rn :
    ClangBuiltin<"__mlvm_trc_cvtu8_f32_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtu8_f32_rm :
    ClangBuiltin<"__mlvm_trc_cvtu8_f32_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_cvtu8_int8 :
    ClangBuiltin<"__mlvm_trc_cvtu8_int8">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int8_tz :
    ClangBuiltin<"__mlvm_trc_cvtu8_int8_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int8_oz :
    ClangBuiltin<"__mlvm_trc_cvtu8_int8_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int8_up :
    ClangBuiltin<"__mlvm_trc_cvtu8_int8_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int8_dn :
    ClangBuiltin<"__mlvm_trc_cvtu8_int8_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int8_rd :
    ClangBuiltin<"__mlvm_trc_cvtu8_int8_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int8_rn :
    ClangBuiltin<"__mlvm_trc_cvtu8_int8_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int8_rm :
    ClangBuiltin<"__mlvm_trc_cvtu8_int8_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int16 :
    ClangBuiltin<"__mlvm_trc_cvtu8_int16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int16_tz :
    ClangBuiltin<"__mlvm_trc_cvtu8_int16_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int16_oz :
    ClangBuiltin<"__mlvm_trc_cvtu8_int16_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int16_up :
    ClangBuiltin<"__mlvm_trc_cvtu8_int16_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int16_dn :
    ClangBuiltin<"__mlvm_trc_cvtu8_int16_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int16_rd :
    ClangBuiltin<"__mlvm_trc_cvtu8_int16_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int16_rn :
    ClangBuiltin<"__mlvm_trc_cvtu8_int16_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int16_rm :
    ClangBuiltin<"__mlvm_trc_cvtu8_int16_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int32 :
    ClangBuiltin<"__mlvm_trc_cvtu8_int32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int32_tz :
    ClangBuiltin<"__mlvm_trc_cvtu8_int32_tz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int32_oz :
    ClangBuiltin<"__mlvm_trc_cvtu8_int32_oz">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int32_up :
    ClangBuiltin<"__mlvm_trc_cvtu8_int32_up">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int32_dn :
    ClangBuiltin<"__mlvm_trc_cvtu8_int32_dn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int32_rd :
    ClangBuiltin<"__mlvm_trc_cvtu8_int32_rd">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int32_rn :
    ClangBuiltin<"__mlvm_trc_cvtu8_int32_rn">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;
  def int_mlvm_trc_cvtu8_int32_rm :
    ClangBuiltin<"__mlvm_trc_cvtu8_int32_rm">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty,
                   llvm_i16_ty],
              []>;

  def int_mlvm_trc_select1d_bitindex_f16 :
    ClangBuiltin<"__mlvm_trc_select1d_bitindex_f16">,
    Intrinsic<[llvm_i32_ty], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;
  def int_mlvm_trc_select1d_bitindex_f32 :
    ClangBuiltin<"__mlvm_trc_select1d_bitindex_f32">,
    Intrinsic<[llvm_i32_ty], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_argmax_f16 :
    ClangBuiltin<"__mlvm_trc_argmax_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_argmax_f32 :
    ClangBuiltin<"__mlvm_trc_argmax_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_argmaxabs_f16 :
    ClangBuiltin<"__mlvm_trc_argmaxabs_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_argmaxabs_f32 :
    ClangBuiltin<"__mlvm_trc_argmaxabs_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_argmin_f16 :
    ClangBuiltin<"__mlvm_trc_argmin_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_argmin_f32 :
    ClangBuiltin<"__mlvm_trc_argmin_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_argminabs_f16 :
    ClangBuiltin<"__mlvm_trc_argminabs_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_argminabs_f32 :
    ClangBuiltin<"__mlvm_trc_argminabs_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  // ===
  // tensor atomic
  // ===
  // tensor atomic add
  def int_mlvm_trc_atom_add_u16 :
    ClangBuiltin<"__mlvm_trc_atom_add_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_add_u32 :
    ClangBuiltin<"__mlvm_trc_atom_add_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_add_s16 :
    ClangBuiltin<"__mlvm_trc_atom_add_s16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_add_s32 :
    ClangBuiltin<"__mlvm_trc_atom_add_s32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_add_f16 :
    ClangBuiltin<"__mlvm_trc_atom_add_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_add_f32 :
    ClangBuiltin<"__mlvm_trc_atom_add_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_add_scalar_u16 :
    ClangBuiltin<"__mlvm_trc_atom_add_scalar_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_atom_add_scalar_u32 :
    ClangBuiltin<"__mlvm_trc_atom_add_scalar_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_trc_atom_add_scalar_s16 :
    ClangBuiltin<"__mlvm_trc_atom_add_scalar_s16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_atom_add_scalar_s32 :
    ClangBuiltin<"__mlvm_trc_atom_add_scalar_s32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_trc_atom_add_scalar_f16 :
    ClangBuiltin<"__mlvm_trc_atom_add_scalar_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_half_ty],
              []>;

  def int_mlvm_trc_atom_add_scalar_f32 :
    ClangBuiltin<"__mlvm_trc_atom_add_scalar_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_float_ty],
              []>;

// tensor atomic max
def int_mlvm_trc_atom_max_u16 :
    ClangBuiltin<"__mlvm_trc_atom_max_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_max_u32 :
    ClangBuiltin<"__mlvm_trc_atom_max_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_max_f16 :
    ClangBuiltin<"__mlvm_trc_atom_max_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_max_f32 :
    ClangBuiltin<"__mlvm_trc_atom_max_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_max_scalar_u16 :
    ClangBuiltin<"__mlvm_trc_atom_max_scalar_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_atom_max_scalar_u32 :
    ClangBuiltin<"__mlvm_trc_atom_max_scalar_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_trc_atom_max_scalar_f16 :
    ClangBuiltin<"__mlvm_trc_atom_max_scalar_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_half_ty],
              []>;

  def int_mlvm_trc_atom_max_scalar_f32 :
    ClangBuiltin<"__mlvm_trc_atom_max_scalar_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_float_ty],
              []>;

// tensor atomic min
def int_mlvm_trc_atom_min_u16 :
    ClangBuiltin<"__mlvm_trc_atom_min_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_min_u32 :
    ClangBuiltin<"__mlvm_trc_atom_min_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_min_f16 :
    ClangBuiltin<"__mlvm_trc_atom_min_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_min_f32 :
    ClangBuiltin<"__mlvm_trc_atom_min_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_min_scalar_u16 :
    ClangBuiltin<"__mlvm_trc_atom_min_scalar_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_atom_min_scalar_u32 :
    ClangBuiltin<"__mlvm_trc_atom_min_scalar_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_trc_atom_min_scalar_f16 :
    ClangBuiltin<"__mlvm_trc_atom_min_scalar_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_half_ty],
              []>;

  def int_mlvm_trc_atom_min_scalar_f32 :
    ClangBuiltin<"__mlvm_trc_atom_min_scalar_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_float_ty],
              []>;

// tensor atomic exch
def int_mlvm_trc_atom_exch_u16 :
    ClangBuiltin<"__mlvm_trc_atom_exch_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_exch_u32 :
    ClangBuiltin<"__mlvm_trc_atom_exch_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_exch_s16 :
    ClangBuiltin<"__mlvm_trc_atom_exch_s16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_exch_s32 :
    ClangBuiltin<"__mlvm_trc_atom_exch_s32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_exch_f16 :
    ClangBuiltin<"__mlvm_trc_atom_exch_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_exch_f32 :
    ClangBuiltin<"__mlvm_trc_atom_exch_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_exch_scalar_u16 :
    ClangBuiltin<"__mlvm_trc_atom_exch_scalar_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_atom_exch_scalar_u32 :
    ClangBuiltin<"__mlvm_trc_atom_exch_scalar_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_trc_atom_exch_scalar_s16 :
    ClangBuiltin<"__mlvm_trc_atom_exch_scalar_s16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_atom_exch_scalar_s32 :
    ClangBuiltin<"__mlvm_trc_atom_exch_scalar_s32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_trc_atom_exch_scalar_f16 :
    ClangBuiltin<"__mlvm_trc_atom_exch_scalar_f16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_half_ty],
              []>;

  def int_mlvm_trc_atom_exch_scalar_f32 :
    ClangBuiltin<"__mlvm_trc_atom_exch_scalar_f32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_float_ty],
              []>;

// tensor atomic inc
def int_mlvm_trc_atom_inc_u16 :
    ClangBuiltin<"__mlvm_trc_atom_inc_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_inc_u32 :
    ClangBuiltin<"__mlvm_trc_atom_inc_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_inc_scalar_u16 :
    ClangBuiltin<"__mlvm_trc_atom_inc_scalar_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_atom_inc_scalar_u32 :
    ClangBuiltin<"__mlvm_trc_atom_inc_scalar_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i32_ty],
              []>;

// tensor atomic dec
def int_mlvm_trc_atom_dec_u16 :
    ClangBuiltin<"__mlvm_trc_atom_dec_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_dec_u32 :
    ClangBuiltin<"__mlvm_trc_atom_dec_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_dec_scalar_u16 :
    ClangBuiltin<"__mlvm_trc_atom_dec_scalar_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_atom_dec_scalar_u32 :
    ClangBuiltin<"__mlvm_trc_atom_dec_scalar_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i32_ty],
              []>;

// tensor atomic and
def int_mlvm_trc_atom_and_u16 :
    ClangBuiltin<"__mlvm_trc_atom_and_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_and_u32 :
    ClangBuiltin<"__mlvm_trc_atom_and_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_and_s16 :
    ClangBuiltin<"__mlvm_trc_atom_and_s16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_and_s32 :
    ClangBuiltin<"__mlvm_trc_atom_and_s32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_and_scalar_u16 :
    ClangBuiltin<"__mlvm_trc_atom_and_scalar_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_atom_and_scalar_u32 :
    ClangBuiltin<"__mlvm_trc_atom_and_scalar_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_trc_atom_and_scalar_s16 :
    ClangBuiltin<"__mlvm_trc_atom_and_scalar_s16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_atom_and_scalar_s32 :
    ClangBuiltin<"__mlvm_trc_atom_and_scalar_s32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i32_ty],
              []>;

// tensor atomic or
def int_mlvm_trc_atom_or_u16 :
    ClangBuiltin<"__mlvm_trc_atom_or_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_or_u32 :
    ClangBuiltin<"__mlvm_trc_atom_or_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_or_s16 :
    ClangBuiltin<"__mlvm_trc_atom_or_s16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_or_s32 :
    ClangBuiltin<"__mlvm_trc_atom_or_s32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_or_scalar_u16 :
    ClangBuiltin<"__mlvm_trc_atom_or_scalar_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_atom_or_scalar_u32 :
    ClangBuiltin<"__mlvm_trc_atom_or_scalar_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_trc_atom_or_scalar_s16 :
    ClangBuiltin<"__mlvm_trc_atom_or_scalar_s16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_atom_or_scalar_s32 :
    ClangBuiltin<"__mlvm_trc_atom_or_scalar_s32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i32_ty],
              []>;

// tensor atomic xor
def int_mlvm_trc_atom_xor_u16 :
    ClangBuiltin<"__mlvm_trc_atom_xor_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_xor_u32 :
    ClangBuiltin<"__mlvm_trc_atom_xor_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_xor_s16 :
    ClangBuiltin<"__mlvm_trc_atom_xor_s16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_xor_s32 :
    ClangBuiltin<"__mlvm_trc_atom_xor_s32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_v8i32_ty],
              []>;

  def int_mlvm_trc_atom_xor_scalar_u16 :
    ClangBuiltin<"__mlvm_trc_atom_xor_scalar_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_atom_xor_scalar_u32 :
    ClangBuiltin<"__mlvm_trc_atom_xor_scalar_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_trc_atom_xor_scalar_s16 :
    ClangBuiltin<"__mlvm_trc_atom_xor_scalar_s16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_atom_xor_scalar_s32 :
    ClangBuiltin<"__mlvm_trc_atom_xor_scalar_s32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i32_ty],
              []>;

// tensor atomic cas
  def int_mlvm_trc_atom_cas_scalar_u16 :
    ClangBuiltin<"__mlvm_trc_atom_cas_scalar_u16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_atom_cas_scalar_u32 :
    ClangBuiltin<"__mlvm_trc_atom_cas_scalar_u32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;

  def int_mlvm_trc_atom_cas_scalar_s16 :
    ClangBuiltin<"__mlvm_trc_atom_cas_scalar_s16">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i16_ty, llvm_i16_ty],
              []>;

  def int_mlvm_trc_atom_cas_scalar_s32 :
    ClangBuiltin<"__mlvm_trc_atom_cas_scalar_s32">,
    Intrinsic<[], [llvm_v8i32_ty, llvm_v8i32_ty, llvm_i32_ty, llvm_i32_ty],
              []>;
}