// TODO: Enable half precision when sin/cos is implemented
#if __CLC_FPSIZE > 16
#define __CLC_DECLARE_SINCOSPI(ADDRSPACE, TYPE) \
  _CLC_OVERLOAD _CLC_DEF TYPE sincospi (TYPE x, ADDRSPACE TYPE * cosval) { \
    return __spirv_ocl_sincospi(x, cosval); \
  }

__CLC_DECLARE_SINCOSPI(global, __CLC_GENTYPE)
__CLC_DECLARE_SINCOSPI(local, __CLC_GENTYPE)
__CLC_DECLARE_SINCOSPI(private, __CLC_GENTYPE)

#undef __CLC_DECLARE_SINCOSPI
#endif
