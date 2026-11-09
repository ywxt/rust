; ModuleID = 'minimal.17726a61271bdaf4-cgu.0'
source_filename = "minimal.17726a61271bdaf4-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "aarch64-unknown-linux-gnu"

; Function Attrs: uwtable
define void @collect_from_slice(ptr dead_on_unwind noalias nofree noundef writable writeonly sret([24 x i8]) align 8 captures(none) dereferenceable(24) %_0, ptr noalias nofree noundef nonnull readonly align 8 captures(none) %src.0, i64 noundef range(i64 0, 1152921504606846976) %src.1) unnamed_addr #0 personality ptr @rust_eh_personality !guid !4 {
start:
  tail call void @llvm.experimental.noalias.scope.decl(metadata !5)
  %_8.idx = shl nuw nsw i64 %src.1, 3
  %0 = icmp eq i64 %src.1, 0
  br i1 %0, label %_RNvXs_NtNtCs6sh1iPzjxYC_5alloc3vec21spec_from_iter_nestedINtB6_3VecjEINtB4_18SpecFromIterNestedjINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB1F_5slice4iter4IterjEEE9from_iterCs20O3Z9S2EXo_7minimal.exit, label %_RNvXs_NtCs6sh1iPzjxYC_5alloc5allocNtB4_6GlobalNtNtCshp6Wxz1DwXO_4core5alloc9Allocator8allocate.exit.i.i.i

_RNvXs_NtCs6sh1iPzjxYC_5alloc5allocNtB4_6GlobalNtNtCshp6Wxz1DwXO_4core5alloc9Allocator8allocate.exit.i.i.i: ; preds = %start
; call __rustc::__rust_no_alloc_shim_is_unstable_v2
  tail call void @_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2() #6, !noalias !8
; call __rustc::__rust_alloc
  %1 = tail call noundef align 8 ptr @_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc(i64 noundef range(i64 0, 9223372036854775801) %_8.idx, i64 noundef 8) #6, !noalias !8
  %2 = icmp eq ptr %1, null
  br i1 %2, label %bb3.i.i, label %bb27.i.i.i.i.i.i.preheader

bb27.i.i.i.i.i.i.preheader:                       ; preds = %_RNvXs_NtCs6sh1iPzjxYC_5alloc5allocNtB4_6GlobalNtNtCshp6Wxz1DwXO_4core5alloc9Allocator8allocate.exit.i.i.i
  tail call void @llvm.memcpy.p0.p0.i64(ptr nonnull align 8 %1, ptr nonnull align 8 %src.0, i64 %_8.idx, i1 false), !noalias !11
  br label %_RNvXs_NtNtCs6sh1iPzjxYC_5alloc3vec21spec_from_iter_nestedINtB6_3VecjEINtB4_18SpecFromIterNestedjINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB1F_5slice4iter4IterjEEE9from_iterCs20O3Z9S2EXo_7minimal.exit

bb3.i.i:                                          ; preds = %_RNvXs_NtCs6sh1iPzjxYC_5alloc5allocNtB4_6GlobalNtNtCshp6Wxz1DwXO_4core5alloc9Allocator8allocate.exit.i.i.i
; call alloc::raw_vec::handle_error
  tail call void @_RNvNtCs6sh1iPzjxYC_5alloc7raw_vec12handle_error(i64 noundef 8, i64 %_8.idx) #7, !noalias !5
  unreachable

_RNvXs_NtNtCs6sh1iPzjxYC_5alloc3vec21spec_from_iter_nestedINtB6_3VecjEINtB4_18SpecFromIterNestedjINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB1F_5slice4iter4IterjEEE9from_iterCs20O3Z9S2EXo_7minimal.exit: ; preds = %bb27.i.i.i.i.i.i.preheader, %start
  %3 = phi ptr [ inttoptr (i64 8 to ptr), %start ], [ %1, %bb27.i.i.i.i.i.i.preheader ]
  store i64 %src.1, ptr %_0, align 8, !alias.scope !5
  %vector.sroa.4.0._0.sroa_idx.i = getelementptr inbounds nuw i8, ptr %_0, i64 8
  store ptr %3, ptr %vector.sroa.4.0._0.sroa_idx.i, align 8, !alias.scope !5
  %vector.sroa.5.0._0.sroa_idx.i = getelementptr inbounds nuw i8, ptr %_0, i64 16
  store i64 %src.1, ptr %vector.sroa.5.0._0.sroa_idx.i, align 8, !alias.scope !5
  ret void
}

; Function Attrs: uwtable
define void @collect_from_vec(ptr dead_on_unwind noalias nofree noundef writable writeonly sret([24 x i8]) align 8 captures(none) dereferenceable(24) %_0, ptr noalias nofree noundef readonly align 8 captures(none) dereferenceable(24) %src) unnamed_addr #0 personality ptr @rust_eh_personality !guid !22 {
start:
  %0 = getelementptr inbounds nuw i8, ptr %src, i64 8
  %_7 = load ptr, ptr %0, align 8, !nonnull !23, !noundef !23
  %_72 = ptrtoaddr ptr %_7 to i64
  %1 = getelementptr inbounds nuw i8, ptr %src, i64 16
  %_6 = load i64, ptr %1, align 8, !noundef !23
  tail call void @llvm.experimental.noalias.scope.decl(metadata !24)
  %_11.idx = shl nuw nsw i64 %_6, 3
  %2 = icmp eq i64 %_6, 0
  br i1 %2, label %_RNvXs_NtNtCs6sh1iPzjxYC_5alloc3vec21spec_from_iter_nestedINtB6_3VecjEINtB4_18SpecFromIterNestedjINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB1F_5slice4iter4IterjEEE9from_iterCs20O3Z9S2EXo_7minimal.exit, label %_RNvXs_NtCs6sh1iPzjxYC_5alloc5allocNtB4_6GlobalNtNtCshp6Wxz1DwXO_4core5alloc9Allocator8allocate.exit.i.i.i

_RNvXs_NtCs6sh1iPzjxYC_5alloc5allocNtB4_6GlobalNtNtCshp6Wxz1DwXO_4core5alloc9Allocator8allocate.exit.i.i.i: ; preds = %start
; call __rustc::__rust_no_alloc_shim_is_unstable_v2
  tail call void @_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2() #6, !noalias !27
; call __rustc::__rust_alloc
  %3 = tail call noundef align 8 ptr @_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc(i64 noundef range(i64 0, 9223372036854775801) %_11.idx, i64 noundef 8) #6, !noalias !27
  %4 = icmp eq ptr %3, null
  br i1 %4, label %bb3.i.i, label %bb27.i.i.i.i.i.i.preheader

bb27.i.i.i.i.i.i.preheader:                       ; preds = %_RNvXs_NtCs6sh1iPzjxYC_5alloc5allocNtB4_6GlobalNtNtCshp6Wxz1DwXO_4core5alloc9Allocator8allocate.exit.i.i.i
  %5 = ptrtoaddr ptr %3 to i64
  %min.iters.check = icmp ult i64 %_6, 6
  %6 = sub i64 %_72, %5
  %diff.check = icmp ugt i64 %6, -32
  %or.cond = or i1 %min.iters.check, %diff.check
  br i1 %or.cond, label %bb27.i.i.i.i.i.i.preheader4, label %vector.ph

vector.ph:                                        ; preds = %bb27.i.i.i.i.i.i.preheader
  %n.vec = and i64 %_6, -4
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i64 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %7 = getelementptr inbounds nuw [8 x i8], ptr %_7, i64 %index
  %8 = getelementptr inbounds nuw i8, ptr %7, i64 16
  %wide.load = load <2 x i64>, ptr %7, align 8, !alias.scope !30, !noalias !33
  %wide.load3 = load <2 x i64>, ptr %8, align 8, !alias.scope !30, !noalias !33
  %9 = getelementptr inbounds nuw [8 x i8], ptr %3, i64 %index
  %10 = getelementptr inbounds nuw i8, ptr %9, i64 16
  store <2 x i64> %wide.load, ptr %9, align 8, !noalias !44
  store <2 x i64> %wide.load3, ptr %10, align 8, !noalias !44
  %index.next = add nuw i64 %index, 4
  %11 = icmp eq i64 %index.next, %n.vec
  br i1 %11, label %middle.block, label %vector.body, !llvm.loop !51

middle.block:                                     ; preds = %vector.body
  %cmp.n = icmp eq i64 %_6, %n.vec
  br i1 %cmp.n, label %_RNvXs_NtNtCs6sh1iPzjxYC_5alloc3vec21spec_from_iter_nestedINtB6_3VecjEINtB4_18SpecFromIterNestedjINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB1F_5slice4iter4IterjEEE9from_iterCs20O3Z9S2EXo_7minimal.exit, label %bb27.i.i.i.i.i.i.preheader4

bb27.i.i.i.i.i.i.preheader4:                      ; preds = %bb27.i.i.i.i.i.i.preheader, %middle.block
  %.ph = phi i64 [ 0, %bb27.i.i.i.i.i.i.preheader ], [ %n.vec, %middle.block ]
  br label %bb27.i.i.i.i.i.i

bb3.i.i:                                          ; preds = %_RNvXs_NtCs6sh1iPzjxYC_5alloc5allocNtB4_6GlobalNtNtCshp6Wxz1DwXO_4core5alloc9Allocator8allocate.exit.i.i.i
; call alloc::raw_vec::handle_error
  tail call void @_RNvNtCs6sh1iPzjxYC_5alloc7raw_vec12handle_error(i64 noundef 8, i64 %_11.idx) #7, !noalias !24
  unreachable

bb27.i.i.i.i.i.i:                                 ; preds = %bb27.i.i.i.i.i.i.preheader4, %bb27.i.i.i.i.i.i
  %12 = phi i64 [ %13, %bb27.i.i.i.i.i.i ], [ %.ph, %bb27.i.i.i.i.i.i.preheader4 ]
  %_45.i.i.i.i.i.i = getelementptr inbounds nuw [8 x i8], ptr %_7, i64 %12
  %_45.val.i.i.i.i.i.i = load i64, ptr %_45.i.i.i.i.i.i, align 8, !alias.scope !30, !noalias !33, !noundef !23
  %_3.i.i.i.i.i.i.i.i.i = getelementptr inbounds nuw [8 x i8], ptr %3, i64 %12
  store i64 %_45.val.i.i.i.i.i.i, ptr %_3.i.i.i.i.i.i.i.i.i, align 8, !noalias !44
  %13 = add nuw i64 %12, 1
  %_28.i.i.i.i.i.i = icmp eq i64 %13, %_6
  br i1 %_28.i.i.i.i.i.i, label %_RNvXs_NtNtCs6sh1iPzjxYC_5alloc3vec21spec_from_iter_nestedINtB6_3VecjEINtB4_18SpecFromIterNestedjINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB1F_5slice4iter4IterjEEE9from_iterCs20O3Z9S2EXo_7minimal.exit, label %bb27.i.i.i.i.i.i, !llvm.loop !54

_RNvXs_NtNtCs6sh1iPzjxYC_5alloc3vec21spec_from_iter_nestedINtB6_3VecjEINtB4_18SpecFromIterNestedjINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB1F_5slice4iter4IterjEEE9from_iterCs20O3Z9S2EXo_7minimal.exit: ; preds = %bb27.i.i.i.i.i.i, %middle.block, %start
  %14 = phi ptr [ inttoptr (i64 8 to ptr), %start ], [ %3, %middle.block ], [ %3, %bb27.i.i.i.i.i.i ]
  store i64 %_6, ptr %_0, align 8, !alias.scope !24
  %vector.sroa.4.0._0.sroa_idx.i = getelementptr inbounds nuw i8, ptr %_0, i64 8
  store ptr %14, ptr %vector.sroa.4.0._0.sroa_idx.i, align 8, !alias.scope !24
  %vector.sroa.5.0._0.sroa_idx.i = getelementptr inbounds nuw i8, ptr %_0, i64 16
  store i64 %_6, ptr %vector.sroa.5.0._0.sroa_idx.i, align 8, !alias.scope !24
  ret void
}

; Function Attrs: uwtable
define void @slice_to_vec(ptr dead_on_unwind noalias nofree noundef writable writeonly sret([24 x i8]) align 8 captures(none) dereferenceable(24) %_0, ptr noalias nofree noundef nonnull readonly align 8 captures(none) %src.0, i64 noundef range(i64 0, 1152921504606846976) %src.1) unnamed_addr #0 personality ptr @rust_eh_personality !guid !55 {
start:
  %_34.0.i = shl nuw nsw i64 %src.1, 3
  %0 = icmp eq i64 %src.1, 0
  br i1 %0, label %bb6.thread, label %_RNvXs_NtCs6sh1iPzjxYC_5alloc5allocNtB4_6GlobalNtNtCshp6Wxz1DwXO_4core5alloc9Allocator8allocate.exit.i

bb6.thread:                                       ; preds = %start
  store i64 0, ptr %_0, align 8
  %1 = getelementptr inbounds nuw i8, ptr %_0, i64 8
  store ptr inttoptr (i64 8 to ptr), ptr %1, align 8
  %2 = getelementptr inbounds nuw i8, ptr %_0, i64 16
  store i64 0, ptr %2, align 8
  br label %bb2

_RNvXs_NtCs6sh1iPzjxYC_5alloc5allocNtB4_6GlobalNtNtCshp6Wxz1DwXO_4core5alloc9Allocator8allocate.exit.i: ; preds = %start
; call __rustc::__rust_no_alloc_shim_is_unstable_v2
  tail call void @_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2() #6, !noalias !56
; call __rustc::__rust_alloc
  %3 = tail call noundef align 8 ptr @_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc(i64 noundef range(i64 0, 9223372036854775801) %_34.0.i, i64 noundef 8) #6, !noalias !56
  %4 = icmp eq ptr %3, null
  br i1 %4, label %bb5, label %bb1

bb5:                                              ; preds = %_RNvXs_NtCs6sh1iPzjxYC_5alloc5allocNtB4_6GlobalNtNtCshp6Wxz1DwXO_4core5alloc9Allocator8allocate.exit.i
; call alloc::raw_vec::handle_error
  tail call void @_RNvNtCs6sh1iPzjxYC_5alloc7raw_vec12handle_error(i64 noundef 8, i64 %_34.0.i) #7
  unreachable

bb2:                                              ; preds = %bb6.thread, %bb1
  ret void

bb1:                                              ; preds = %_RNvXs_NtCs6sh1iPzjxYC_5alloc5allocNtB4_6GlobalNtNtCshp6Wxz1DwXO_4core5alloc9Allocator8allocate.exit.i
  store i64 %src.1, ptr %_0, align 8
  %5 = getelementptr inbounds nuw i8, ptr %_0, i64 8
  store ptr %3, ptr %5, align 8
  %6 = getelementptr inbounds nuw i8, ptr %_0, i64 16
  tail call void @llvm.memcpy.p0.p0.i64(ptr nonnull align 8 %3, ptr nonnull align 8 %src.0, i64 %_34.0.i, i1 false)
  store i64 %src.1, ptr %6, align 8
  br label %bb2
}

; Function Attrs: nounwind uwtable
declare noundef range(i32 0, 10) i32 @rust_eh_personality(i32 noundef, i32 noundef, i64 noundef, ptr noundef, ptr noundef) unnamed_addr #1

; alloc::raw_vec::handle_error
; Function Attrs: cold minsize noreturn optsize uwtable
declare void @_RNvNtCs6sh1iPzjxYC_5alloc7raw_vec12handle_error(i64 noundef range(i64 0, -9223372036854775807), i64) unnamed_addr #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #3

; __rustc::__rust_no_alloc_shim_is_unstable_v2
; Function Attrs: nounwind uwtable
declare void @_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2() unnamed_addr #1

; __rustc::__rust_alloc
; Function Attrs: nounwind allockind("alloc,uninitialized,aligned") allocsize(0) uwtable
declare noalias noundef ptr @_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc(i64 noundef, i64 allocalign noundef range(i64 1, -9223372036854775807)) unnamed_addr #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.experimental.noalias.scope.decl(metadata) #5

attributes #0 = { uwtable "frame-pointer"="non-leaf" "probe-stack"="inline-asm" "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #1 = { nounwind uwtable "frame-pointer"="non-leaf" "probe-stack"="inline-asm" "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #2 = { cold minsize noreturn optsize uwtable "frame-pointer"="non-leaf" "probe-stack"="inline-asm" "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #3 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #4 = { nounwind allockind("alloc,uninitialized,aligned") allocsize(0) uwtable "alloc-family"="__rust_alloc" "alloc-variant-zeroed"="_RNvCshVjSbrpHdcL_7___rustc19___rust_alloc_zeroed" "frame-pointer"="non-leaf" "probe-stack"="inline-asm" "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #5 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
attributes #6 = { nounwind }
attributes #7 = { noreturn }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 8, !"PIC Level", i32 2}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{i32 7, !"frame-pointer", i32 1}
!3 = !{!"rustc version 1.99.0-dev"}
!4 = !{i64 8242622168005446084}
!5 = !{!6}
!6 = distinct !{!6, !7, !"_RNvXs_NtNtCs6sh1iPzjxYC_5alloc3vec21spec_from_iter_nestedINtB6_3VecjEINtB4_18SpecFromIterNestedjINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB1F_5slice4iter4IterjEEE9from_iterCs20O3Z9S2EXo_7minimal: %_0"}
!7 = distinct !{!7, !"_RNvXs_NtNtCs6sh1iPzjxYC_5alloc3vec21spec_from_iter_nestedINtB6_3VecjEINtB4_18SpecFromIterNestedjINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB1F_5slice4iter4IterjEEE9from_iterCs20O3Z9S2EXo_7minimal"}
!8 = !{!9, !6}
!9 = distinct !{!9, !10, !"_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner15try_allocate_inCs20O3Z9S2EXo_7minimal: %_0"}
!10 = distinct !{!10, !"_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner15try_allocate_inCs20O3Z9S2EXo_7minimal"}
!11 = !{!12, !14, !16, !18, !20, !6}
!12 = distinct !{!12, !13, !"_RINvXs2J_NtNtCshp6Wxz1DwXO_4core5slice4iterINtB7_4IterjENtNtNtNtBb_4iter6traits8iterator8Iterator4folduNCINvNtNtBY_8adapters3map8map_foldRjjuNvYjNtNtBb_5clone5Clone5cloneNCINvNvBS_8for_each4calljNCINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB3g_3VecjE14extend_trustedINtNtB1K_6cloned6ClonedBF_EE0E0E0ECs20O3Z9S2EXo_7minimal: %f"}
!13 = distinct !{!13, !"_RINvXs2J_NtNtCshp6Wxz1DwXO_4core5slice4iterINtB7_4IterjENtNtNtNtBb_4iter6traits8iterator8Iterator4folduNCINvNtNtBY_8adapters3map8map_foldRjjuNvYjNtNtBb_5clone5Clone5cloneNCINvNvBS_8for_each4calljNCINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB3g_3VecjE14extend_trustedINtNtB1K_6cloned6ClonedBF_EE0E0E0ECs20O3Z9S2EXo_7minimal"}
!14 = distinct !{!14, !15, !"_RINvXs_NtNtNtCshp6Wxz1DwXO_4core4iter8adapters6clonedINtB5_6ClonedINtNtNtBb_5slice4iter4IterjEENtNtNtB9_6traits8iterator8Iterator4folduNCINvNvB1v_8for_each4calljNCINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB2I_3VecjE14extend_trustedBP_E0E0ECs20O3Z9S2EXo_7minimal: %f"}
!15 = distinct !{!15, !"_RINvXs_NtNtNtCshp6Wxz1DwXO_4core4iter8adapters6clonedINtB5_6ClonedINtNtNtBb_5slice4iter4IterjEENtNtNtB9_6traits8iterator8Iterator4folduNCINvNvB1v_8for_each4calljNCINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB2I_3VecjE14extend_trustedBP_E0E0ECs20O3Z9S2EXo_7minimal"}
!16 = distinct !{!16, !17, !"_RINvYINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtBc_5slice4iter4IterjEENtNtNtBa_6traits8iterator8Iterator8for_eachNCINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB2g_3VecjE14extend_trustedB3_E0ECs20O3Z9S2EXo_7minimal: %f"}
!17 = distinct !{!17, !"_RINvYINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtBc_5slice4iter4IterjEENtNtNtBa_6traits8iterator8Iterator8for_eachNCINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB2g_3VecjE14extend_trustedB3_E0ECs20O3Z9S2EXo_7minimal"}
!18 = distinct !{!18, !19, !"_RINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB6_3VecjE14extend_trustedINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB17_5slice4iter4IterjEEECs20O3Z9S2EXo_7minimal: %self"}
!19 = distinct !{!19, !"_RINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB6_3VecjE14extend_trustedINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB17_5slice4iter4IterjEEECs20O3Z9S2EXo_7minimal"}
!20 = distinct !{!20, !21, !"_RNvXs_NtNtCs6sh1iPzjxYC_5alloc3vec11spec_extendINtB6_3VecjEINtB4_10SpecExtendjINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB1n_5slice4iter4IterjEEE11spec_extendCs20O3Z9S2EXo_7minimal: %self"}
!21 = distinct !{!21, !"_RNvXs_NtNtCs6sh1iPzjxYC_5alloc3vec11spec_extendINtB6_3VecjEINtB4_10SpecExtendjINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB1n_5slice4iter4IterjEEE11spec_extendCs20O3Z9S2EXo_7minimal"}
!22 = !{i64 -6432904009126911000}
!23 = !{}
!24 = !{!25}
!25 = distinct !{!25, !26, !"_RNvXs_NtNtCs6sh1iPzjxYC_5alloc3vec21spec_from_iter_nestedINtB6_3VecjEINtB4_18SpecFromIterNestedjINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB1F_5slice4iter4IterjEEE9from_iterCs20O3Z9S2EXo_7minimal: %_0"}
!26 = distinct !{!26, !"_RNvXs_NtNtCs6sh1iPzjxYC_5alloc3vec21spec_from_iter_nestedINtB6_3VecjEINtB4_18SpecFromIterNestedjINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB1F_5slice4iter4IterjEEE9from_iterCs20O3Z9S2EXo_7minimal"}
!27 = !{!28, !25}
!28 = distinct !{!28, !29, !"_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner15try_allocate_inCs20O3Z9S2EXo_7minimal: %_0"}
!29 = distinct !{!29, !"_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner15try_allocate_inCs20O3Z9S2EXo_7minimal"}
!30 = !{!31}
!31 = distinct !{!31, !32, !"_RNvXs8_NtNtCshp6Wxz1DwXO_4core5clone5implsjNtB7_5Clone5clone: %self"}
!32 = distinct !{!32, !"_RNvXs8_NtNtCshp6Wxz1DwXO_4core5clone5implsjNtB7_5Clone5clone"}
!33 = !{!34, !36, !38, !40, !42, !25}
!34 = distinct !{!34, !35, !"_RINvXs2J_NtNtCshp6Wxz1DwXO_4core5slice4iterINtB7_4IterjENtNtNtNtBb_4iter6traits8iterator8Iterator4folduNCINvNtNtBY_8adapters3map8map_foldRjjuNvYjNtNtBb_5clone5Clone5cloneNCINvNvBS_8for_each4calljNCINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB3g_3VecjE14extend_trustedINtNtB1K_6cloned6ClonedBF_EE0E0E0ECs20O3Z9S2EXo_7minimal: %f"}
!35 = distinct !{!35, !"_RINvXs2J_NtNtCshp6Wxz1DwXO_4core5slice4iterINtB7_4IterjENtNtNtNtBb_4iter6traits8iterator8Iterator4folduNCINvNtNtBY_8adapters3map8map_foldRjjuNvYjNtNtBb_5clone5Clone5cloneNCINvNvBS_8for_each4calljNCINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB3g_3VecjE14extend_trustedINtNtB1K_6cloned6ClonedBF_EE0E0E0ECs20O3Z9S2EXo_7minimal"}
!36 = distinct !{!36, !37, !"_RINvXs_NtNtNtCshp6Wxz1DwXO_4core4iter8adapters6clonedINtB5_6ClonedINtNtNtBb_5slice4iter4IterjEENtNtNtB9_6traits8iterator8Iterator4folduNCINvNvB1v_8for_each4calljNCINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB2I_3VecjE14extend_trustedBP_E0E0ECs20O3Z9S2EXo_7minimal: %f"}
!37 = distinct !{!37, !"_RINvXs_NtNtNtCshp6Wxz1DwXO_4core4iter8adapters6clonedINtB5_6ClonedINtNtNtBb_5slice4iter4IterjEENtNtNtB9_6traits8iterator8Iterator4folduNCINvNvB1v_8for_each4calljNCINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB2I_3VecjE14extend_trustedBP_E0E0ECs20O3Z9S2EXo_7minimal"}
!38 = distinct !{!38, !39, !"_RINvYINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtBc_5slice4iter4IterjEENtNtNtBa_6traits8iterator8Iterator8for_eachNCINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB2g_3VecjE14extend_trustedB3_E0ECs20O3Z9S2EXo_7minimal: %f"}
!39 = distinct !{!39, !"_RINvYINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtBc_5slice4iter4IterjEENtNtNtBa_6traits8iterator8Iterator8for_eachNCINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB2g_3VecjE14extend_trustedB3_E0ECs20O3Z9S2EXo_7minimal"}
!40 = distinct !{!40, !41, !"_RINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB6_3VecjE14extend_trustedINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB17_5slice4iter4IterjEEECs20O3Z9S2EXo_7minimal: %self"}
!41 = distinct !{!41, !"_RINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB6_3VecjE14extend_trustedINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB17_5slice4iter4IterjEEECs20O3Z9S2EXo_7minimal"}
!42 = distinct !{!42, !43, !"_RNvXs_NtNtCs6sh1iPzjxYC_5alloc3vec11spec_extendINtB6_3VecjEINtB4_10SpecExtendjINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB1n_5slice4iter4IterjEEE11spec_extendCs20O3Z9S2EXo_7minimal: %self"}
!43 = distinct !{!43, !"_RNvXs_NtNtCs6sh1iPzjxYC_5alloc3vec11spec_extendINtB6_3VecjEINtB4_10SpecExtendjINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB1n_5slice4iter4IterjEEE11spec_extendCs20O3Z9S2EXo_7minimal"}
!44 = !{!45, !47, !49, !34, !36, !38, !40, !42, !25}
!45 = distinct !{!45, !46, !"_RNCINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB8_3VecjE14extend_trustedINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB19_5slice4iter4IterjEEE0Cs20O3Z9S2EXo_7minimal: %_1"}
!46 = distinct !{!46, !"_RNCINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB8_3VecjE14extend_trustedINtNtNtNtCshp6Wxz1DwXO_4core4iter8adapters6cloned6ClonedINtNtNtB19_5slice4iter4IterjEEE0Cs20O3Z9S2EXo_7minimal"}
!47 = distinct !{!47, !48, !"_RNCINvNvNtNtNtNtCshp6Wxz1DwXO_4core4iter6traits8iterator8Iterator8for_each4calljNCINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB1p_3VecjE14extend_trustedINtNtNtBc_8adapters6cloned6ClonedINtNtNtBe_5slice4iter4IterjEEE0E0Cs20O3Z9S2EXo_7minimal: %_1"}
!48 = distinct !{!48, !"_RNCINvNvNtNtNtNtCshp6Wxz1DwXO_4core4iter6traits8iterator8Iterator8for_each4calljNCINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB1p_3VecjE14extend_trustedINtNtNtBc_8adapters6cloned6ClonedINtNtNtBe_5slice4iter4IterjEEE0E0Cs20O3Z9S2EXo_7minimal"}
!49 = distinct !{!49, !50, !"_RNCINvNtNtNtCshp6Wxz1DwXO_4core4iter8adapters3map8map_foldRjjuNvYjNtNtBa_5clone5Clone5cloneNCINvNvNtNtNtB8_6traits8iterator8Iterator8for_each4calljNCINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB2u_3VecjE14extend_trustedINtNtB6_6cloned6ClonedINtNtNtBa_5slice4iter4IterjEEE0E0E0Cs20O3Z9S2EXo_7minimal: %_1"}
!50 = distinct !{!50, !"_RNCINvNtNtNtCshp6Wxz1DwXO_4core4iter8adapters3map8map_foldRjjuNvYjNtNtBa_5clone5Clone5cloneNCINvNvNtNtNtB8_6traits8iterator8Iterator8for_each4calljNCINvMsk_NtCs6sh1iPzjxYC_5alloc3vecINtB2u_3VecjE14extend_trustedINtNtB6_6cloned6ClonedINtNtNtBa_5slice4iter4IterjEEE0E0E0Cs20O3Z9S2EXo_7minimal"}
!51 = distinct !{!51, !52, !53}
!52 = !{!"llvm.loop.isvectorized", i32 1}
!53 = !{!"llvm.loop.unroll.runtime.disable"}
!54 = distinct !{!54, !52}
!55 = !{i64 -7546536845166850786}
!56 = !{!57}
!57 = distinct !{!57, !58, !"_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner15try_allocate_inCs20O3Z9S2EXo_7minimal: %_0"}
!58 = distinct !{!58, !"_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner15try_allocate_inCs20O3Z9S2EXo_7minimal"}
