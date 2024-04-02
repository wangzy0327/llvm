; ModuleID = 'samples/add/add.cpp'
source_filename = "samples/add/add.cpp"
target datalayout = "e-p:64:64:64-i64:64-v16:16-v32:32-n16:32:64"
target triple = "mlisa-cambricon-bang"

%"class.cl::sycl::range" = type { %"class.cl::sycl::detail::array" }
%"class.cl::sycl::detail::array" = type { [1 x i64] }
%"class.cl::sycl::id" = type { %"class.cl::sycl::detail::array" }

$_ZTSN2cl4sycl6detail18RoundedRangeKernelINS0_4itemILi1ELb1EEELi1EZZ4mainENKUlRNS0_7handlerEE_clES6_EUlNS0_2idILi1EEEE_EE = comdat any

$_ZTSZZ4mainENKUlRN2cl4sycl7handlerEE_clES2_EUlNS0_2idILi1EEEE_ = comdat any

; Function Attrs: convergent noinline norecurse
define weak_odr dso_local void @_ZTSN2cl4sycl6detail18RoundedRangeKernelINS0_4itemILi1ELb1EEELi1EZZ4mainENKUlRNS0_7handlerEE_clES6_EUlNS0_2idILi1EEEE_EE(%"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_NumWorkItems, i32 addrspace(101)* noundef align 4 %_arg_localAccA, %"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_localAccA1, %"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_localAccA2, %"class.cl::sycl::id"* noundef byval(%"class.cl::sycl::id") align 8 %_arg_localAccA3, float addrspace(1)* noundef readonly align 4 %_arg_aA, %"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_aA4, %"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_aA5, %"class.cl::sycl::id"* noundef byval(%"class.cl::sycl::id") align 8 %_arg_aA6, i32 addrspace(101)* noundef align 4 %_arg_localAccB, %"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_localAccB7, %"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_localAccB8, %"class.cl::sycl::id"* noundef byval(%"class.cl::sycl::id") align 8 %_arg_localAccB9, float addrspace(1)* noundef readonly align 4 %_arg_aB, %"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_aB10, %"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_aB11, %"class.cl::sycl::id"* noundef byval(%"class.cl::sycl::id") align 8 %_arg_aB12, float addrspace(1)* noundef align 4 %_arg_aC, %"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_aC13, %"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_aC14, %"class.cl::sycl::id"* noundef byval(%"class.cl::sycl::id") align 8 %_arg_aC15) local_unnamed_addr #0 comdat !kernel_arg_buffer_location !9 !kernel_arg_runtime_aligned !10 !kernel_arg_exclusive_ptr !10 {
entry:
  %0 = getelementptr inbounds %"class.cl::sycl::range", %"class.cl::sycl::range"* %_arg_NumWorkItems, i64 0, i32 0, i32 0, i64 0
  %1 = load i64, i64* %0, align 8
  %2 = getelementptr inbounds %"class.cl::sycl::id", %"class.cl::sycl::id"* %_arg_aA6, i64 0, i32 0, i32 0, i64 0
  %3 = load i64, i64* %2, align 8
  %add.ptr.i = getelementptr inbounds float, float addrspace(1)* %_arg_aA, i64 %3
  %4 = getelementptr inbounds %"class.cl::sycl::id", %"class.cl::sycl::id"* %_arg_aB12, i64 0, i32 0, i32 0, i64 0
  %5 = load i64, i64* %4, align 8
  %add.ptr.i67 = getelementptr inbounds float, float addrspace(1)* %_arg_aB, i64 %5
  %6 = getelementptr inbounds %"class.cl::sycl::id", %"class.cl::sycl::id"* %_arg_aC15, i64 0, i32 0, i32 0, i64 0
  %7 = load i64, i64* %6, align 8
  %add.ptr.i78 = getelementptr inbounds float, float addrspace(1)* %_arg_aC, i64 %7
  %8 = tail call i32 @llvm.mlvm.read.mlu.sreg.taskidx() #5
  %conv.i.i.i.i.i.i = sext i32 %8 to i64
  %call.i.i.i.i.i.i = tail call i64 @_Z23__spirv_NumWorkgroups_xv() #6
  %call1.i.i.i.i.i.i = tail call i64 @_Z23__spirv_WorkgroupSize_xv() #6
  %call.i.i.i.i.i = tail call noundef i64 @_Z22__spirv_GlobalOffset_xv() #7
  %cmp.i.i = icmp sgt i32 %8, -1
  tail call void @llvm.assume(i1 %cmp.i.i) #5
  %cmp.not.i = icmp ugt i64 %1, %conv.i.i.i.i.i.i
  br i1 %cmp.not.i, label %for.body.i.i, label %_ZNK2cl4sycl6detail18RoundedRangeKernelINS0_4itemILi1ELb1EEELi1EZZ4mainENKUlRNS0_7handlerEE_clES6_EUlNS0_2idILi1EEEE_EclES4_.exit

for.body.i.i:                                     ; preds = %entry, %for.body.i.i
  %indvars.iv.i.i = phi i64 [ %indvars.iv.next.i.i, %for.body.i.i ], [ 0, %entry ]
  %arrayidx.i.i6.i = getelementptr inbounds float, float addrspace(1)* %add.ptr.i, i64 %indvars.iv.i.i
  %arrayidx.ascast.i.i.i = addrspacecast float addrspace(1)* %arrayidx.i.i6.i to float*
  %9 = load float, float* %arrayidx.ascast.i.i.i, align 4, !tbaa !11
  %conv2.i.i = fptosi float %9 to i32
  %arrayidx.i3.i.i = getelementptr inbounds i32, i32 addrspace(101)* %_arg_localAccA, i64 %indvars.iv.i.i
  %arrayidx.ascast.i4.i.i = addrspacecast i32 addrspace(101)* %arrayidx.i3.i.i to i32*
  store i32 %conv2.i.i, i32* %arrayidx.ascast.i4.i.i, align 4, !tbaa !15
  %arrayidx.i8.i.i = getelementptr inbounds float, float addrspace(1)* %add.ptr.i67, i64 %indvars.iv.i.i
  %arrayidx.ascast.i9.i.i = addrspacecast float addrspace(1)* %arrayidx.i8.i.i to float*
  %10 = load float, float* %arrayidx.ascast.i9.i.i, align 4, !tbaa !11
  %conv8.i.i = fptosi float %10 to i32
  %arrayidx.i11.i.i = getelementptr inbounds i32, i32 addrspace(101)* %_arg_localAccB, i64 %indvars.iv.i.i
  %arrayidx.ascast.i12.i.i = addrspacecast i32 addrspace(101)* %arrayidx.i11.i.i to i32*
  store i32 %conv8.i.i, i32* %arrayidx.ascast.i12.i.i, align 4, !tbaa !15
  %11 = load i32, i32* %arrayidx.ascast.i4.i.i, align 4, !tbaa !15
  %add.i.i = add nsw i32 %11, %conv8.i.i
  %conv17.i.i = sitofp i32 %add.i.i to float
  %arrayidx.i22.i.i = getelementptr inbounds float, float addrspace(1)* %add.ptr.i78, i64 %indvars.iv.i.i
  %arrayidx.ascast.i23.i.i = addrspacecast float addrspace(1)* %arrayidx.i22.i.i to float*
  store float %conv17.i.i, float* %arrayidx.ascast.i23.i.i, align 4, !tbaa !11
  %indvars.iv.next.i.i = add nuw nsw i64 %indvars.iv.i.i, 1
  %exitcond.not.i.i = icmp eq i64 %indvars.iv.next.i.i, 256
  br i1 %exitcond.not.i.i, label %_ZNK2cl4sycl6detail18RoundedRangeKernelINS0_4itemILi1ELb1EEELi1EZZ4mainENKUlRNS0_7handlerEE_clES6_EUlNS0_2idILi1EEEE_EclES4_.exit, label %for.body.i.i, !llvm.loop !17

_ZNK2cl4sycl6detail18RoundedRangeKernelINS0_4itemILi1ELb1EEELi1EZZ4mainENKUlRNS0_7handlerEE_clES6_EUlNS0_2idILi1EEEE_EclES4_.exit: ; preds = %for.body.i.i, %entry
  ret void

; uselistorder directives
  uselistorder label %for.body.i.i, { 1, 0 }
  uselistorder i64 %indvars.iv.next.i.i, { 1, 0 }
}

; Function Attrs: inaccessiblememonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.assume(i1 noundef) #1

; Function Attrs: convergent
declare dso_local noundef i64 @_Z22__spirv_GlobalOffset_xv() local_unnamed_addr #2

; Function Attrs: convergent noinline norecurse
define weak_odr dso_local void @_ZTSZZ4mainENKUlRN2cl4sycl7handlerEE_clES2_EUlNS0_2idILi1EEEE_(i32 addrspace(101)* noundef align 4 %_arg_localAccA, %"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_localAccA1, %"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_localAccA2, %"class.cl::sycl::id"* noundef byval(%"class.cl::sycl::id") align 8 %_arg_localAccA3, float addrspace(1)* noundef readonly align 4 %_arg_aA, %"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_aA4, %"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_aA5, %"class.cl::sycl::id"* noundef byval(%"class.cl::sycl::id") align 8 %_arg_aA6, i32 addrspace(101)* noundef align 4 %_arg_localAccB, %"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_localAccB7, %"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_localAccB8, %"class.cl::sycl::id"* noundef byval(%"class.cl::sycl::id") align 8 %_arg_localAccB9, float addrspace(1)* noundef readonly align 4 %_arg_aB, %"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_aB10, %"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_aB11, %"class.cl::sycl::id"* noundef byval(%"class.cl::sycl::id") align 8 %_arg_aB12, float addrspace(1)* noundef align 4 %_arg_aC, %"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_aC13, %"class.cl::sycl::range"* noundef byval(%"class.cl::sycl::range") align 8 %_arg_aC14, %"class.cl::sycl::id"* noundef byval(%"class.cl::sycl::id") align 8 %_arg_aC15) local_unnamed_addr #0 comdat !kernel_arg_buffer_location !19 !kernel_arg_runtime_aligned !20 !kernel_arg_exclusive_ptr !20 {
entry:
  %0 = getelementptr inbounds %"class.cl::sycl::id", %"class.cl::sycl::id"* %_arg_aA6, i64 0, i32 0, i32 0, i64 0
  %1 = load i64, i64* %0, align 8
  %add.ptr.i = getelementptr inbounds float, float addrspace(1)* %_arg_aA, i64 %1
  %2 = getelementptr inbounds %"class.cl::sycl::id", %"class.cl::sycl::id"* %_arg_aB12, i64 0, i32 0, i32 0, i64 0
  %3 = load i64, i64* %2, align 8
  %add.ptr.i62 = getelementptr inbounds float, float addrspace(1)* %_arg_aB, i64 %3
  %4 = getelementptr inbounds %"class.cl::sycl::id", %"class.cl::sycl::id"* %_arg_aC15, i64 0, i32 0, i32 0, i64 0
  %5 = load i64, i64* %4, align 8
  %add.ptr.i73 = getelementptr inbounds float, float addrspace(1)* %_arg_aC, i64 %5
  %6 = tail call i32 @llvm.mlvm.read.mlu.sreg.taskidx() #5
  %call.i.i.i.i.i.i = tail call i64 @_Z23__spirv_NumWorkgroups_xv() #6
  %call1.i.i.i.i.i.i = tail call i64 @_Z23__spirv_WorkgroupSize_xv() #6
  %call.i.i.i.i.i = tail call noundef i64 @_Z22__spirv_GlobalOffset_xv() #7
  %cmp.i.i = icmp sgt i32 %6, -1
  tail call void @llvm.assume(i1 %cmp.i.i) #5
  br label %for.body.i

for.body.i:                                       ; preds = %for.body.i, %entry
  %indvars.iv.i = phi i64 [ 0, %entry ], [ %indvars.iv.next.i, %for.body.i ]
  %arrayidx.i.i74 = getelementptr inbounds float, float addrspace(1)* %add.ptr.i, i64 %indvars.iv.i
  %arrayidx.ascast.i.i = addrspacecast float addrspace(1)* %arrayidx.i.i74 to float*
  %7 = load float, float* %arrayidx.ascast.i.i, align 4, !tbaa !11
  %conv2.i = fptosi float %7 to i32
  %arrayidx.i3.i = getelementptr inbounds i32, i32 addrspace(101)* %_arg_localAccA, i64 %indvars.iv.i
  %arrayidx.ascast.i4.i = addrspacecast i32 addrspace(101)* %arrayidx.i3.i to i32*
  store i32 %conv2.i, i32* %arrayidx.ascast.i4.i, align 4, !tbaa !15
  %arrayidx.i8.i75 = getelementptr inbounds float, float addrspace(1)* %add.ptr.i62, i64 %indvars.iv.i
  %arrayidx.ascast.i9.i = addrspacecast float addrspace(1)* %arrayidx.i8.i75 to float*
  %8 = load float, float* %arrayidx.ascast.i9.i, align 4, !tbaa !11
  %conv8.i = fptosi float %8 to i32
  %arrayidx.i11.i = getelementptr inbounds i32, i32 addrspace(101)* %_arg_localAccB, i64 %indvars.iv.i
  %arrayidx.ascast.i12.i = addrspacecast i32 addrspace(101)* %arrayidx.i11.i to i32*
  store i32 %conv8.i, i32* %arrayidx.ascast.i12.i, align 4, !tbaa !15
  %9 = load i32, i32* %arrayidx.ascast.i4.i, align 4, !tbaa !15
  %add.i = add nsw i32 %9, %conv8.i
  %conv17.i = sitofp i32 %add.i to float
  %arrayidx.i22.i76 = getelementptr inbounds float, float addrspace(1)* %add.ptr.i73, i64 %indvars.iv.i
  %arrayidx.ascast.i23.i = addrspacecast float addrspace(1)* %arrayidx.i22.i76 to float*
  store float %conv17.i, float* %arrayidx.ascast.i23.i, align 4, !tbaa !11
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i, 1
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, 256
  br i1 %exitcond.not.i, label %_ZZZ4mainENKUlRN2cl4sycl7handlerEE_clES2_ENKUlNS0_2idILi1EEEE_clES5_.exit, label %for.body.i, !llvm.loop !17

_ZZZ4mainENKUlRN2cl4sycl7handlerEE_clES2_ENKUlNS0_2idILi1EEEE_clES5_.exit: ; preds = %for.body.i
  ret void

; uselistorder directives
  uselistorder i64 %indvars.iv.next.i, { 1, 0 }
}

; Function Attrs: nofree nosync nounwind readnone
declare i32 @llvm.mlvm.read.mlu.sreg.taskidx() #3

; Function Attrs: convergent
declare dso_local i64 @_Z23__spirv_NumWorkgroups_xv() local_unnamed_addr #4

; Function Attrs: convergent
declare dso_local i64 @_Z23__spirv_WorkgroupSize_xv() local_unnamed_addr #4

declare dso_local spir_func i32 @_Z18__spirv_ocl_printfPU3AS2Kcz(i8 addrspace(2)*, ...)

; uselistorder directives
uselistorder i64 0, { 1, 2, 3, 4, 5, 6, 7, 0, 8, 9, 10, 11, 12, 13, 14, 15 }
uselistorder i32 ()* @llvm.mlvm.read.mlu.sreg.taskidx, { 1, 0 }
uselistorder i64 ()* @_Z23__spirv_NumWorkgroups_xv, { 1, 0 }
uselistorder i64 ()* @_Z23__spirv_WorkgroupSize_xv, { 1, 0 }

attributes #0 = { convergent noinline norecurse "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "sycl-module-id"="samples/add/add.cpp" "target-cpu"="mtp_372" "uniform-work-group-size"="true" }
attributes #1 = { inaccessiblememonly mustprogress nocallback nofree nosync nounwind willreturn }
attributes #2 = { convergent "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="mtp_372" }
attributes #3 = { nofree nosync nounwind readnone }
attributes #4 = { convergent "frame-pointer"="all" "no-builtins" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #5 = { nounwind }
attributes #6 = { convergent nobuiltin nounwind "no-builtins" }
attributes #7 = { convergent }

!mlvm.annotations = !{!0, !1}
!llvm.module.flags = !{!2, !3}
!opencl.spir.version = !{!4}
!spirv.Source = !{!5}
!llvm.ident = !{!6, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !7, !8}

!0 = !{void (%"class.cl::sycl::range"*, i32 addrspace(101)*, %"class.cl::sycl::range"*, %"class.cl::sycl::range"*, %"class.cl::sycl::id"*, float addrspace(1)*, %"class.cl::sycl::range"*, %"class.cl::sycl::range"*, %"class.cl::sycl::id"*, i32 addrspace(101)*, %"class.cl::sycl::range"*, %"class.cl::sycl::range"*, %"class.cl::sycl::id"*, float addrspace(1)*, %"class.cl::sycl::range"*, %"class.cl::sycl::range"*, %"class.cl::sycl::id"*, float addrspace(1)*, %"class.cl::sycl::range"*, %"class.cl::sycl::range"*, %"class.cl::sycl::id"*)* @_ZTSN2cl4sycl6detail18RoundedRangeKernelINS0_4itemILi1ELb1EEELi1EZZ4mainENKUlRNS0_7handlerEE_clES6_EUlNS0_2idILi1EEEE_EE, !"kernel", i32 1}
!1 = !{void (i32 addrspace(101)*, %"class.cl::sycl::range"*, %"class.cl::sycl::range"*, %"class.cl::sycl::id"*, float addrspace(1)*, %"class.cl::sycl::range"*, %"class.cl::sycl::range"*, %"class.cl::sycl::id"*, i32 addrspace(101)*, %"class.cl::sycl::range"*, %"class.cl::sycl::range"*, %"class.cl::sycl::id"*, float addrspace(1)*, %"class.cl::sycl::range"*, %"class.cl::sycl::range"*, %"class.cl::sycl::id"*, float addrspace(1)*, %"class.cl::sycl::range"*, %"class.cl::sycl::range"*, %"class.cl::sycl::id"*)* @_ZTSZZ4mainENKUlRN2cl4sycl7handlerEE_clES2_EUlNS0_2idILi1EEEE_, !"kernel", i32 1}
!2 = !{i32 1, !"wchar_size", i32 4}
!3 = !{i32 7, !"frame-pointer", i32 2}
!4 = !{i32 1, i32 2}
!5 = !{i32 4, i32 100000}
!6 = !{!"clang version 15.0.0 (git@github.com:wangzy0327/llvm.git 6a880ed1fb4502df3f8bd1da01cb0c7cb168215e)"}
!7 = !{!"clang version 15.0.0 (git@github.com:wangzy0327/llvm.git 3e3802768ec13091741d73386b6019b6fe9617f4)"}
!8 = !{!"cncc v4.5.1 clang version 11.1.0"}
!9 = !{i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1}
!10 = !{i1 false, i1 true, i1 false, i1 false, i1 false, i1 true, i1 false, i1 false, i1 false, i1 true, i1 false, i1 false, i1 false, i1 true, i1 false, i1 false, i1 false, i1 true, i1 false, i1 false, i1 false}
!11 = !{!12, !12, i64 0}
!12 = !{!"float", !13, i64 0}
!13 = !{!"omnipotent char", !14, i64 0}
!14 = !{!"Simple C++ TBAA"}
!15 = !{!16, !16, i64 0}
!16 = !{!"int", !13, i64 0}
!17 = distinct !{!17, !18}
!18 = !{!"llvm.loop.mustprogress"}
!19 = !{i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1, i32 -1}
!20 = !{i1 true, i1 false, i1 false, i1 false, i1 true, i1 false, i1 false, i1 false, i1 true, i1 false, i1 false, i1 false, i1 true, i1 false, i1 false, i1 false, i1 true, i1 false, i1 false, i1 false}
