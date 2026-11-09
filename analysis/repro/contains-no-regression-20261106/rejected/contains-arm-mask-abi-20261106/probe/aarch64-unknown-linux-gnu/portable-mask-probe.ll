; ModuleID = 'portable_mask_probe.7707f75c3b3477a0-cgu.0'
source_filename = "portable_mask_probe.7707f75c3b3477a0-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "aarch64-unknown-linux-gnu"

; portable_mask_probe::contains_match
; Function Attrs: nofree norecurse nosync nounwind memory(argmem: read, inaccessiblemem: write) uwtable
define noundef range(i64 0, 2) i64 @_RNvCsadBbONxITBY_19portable_mask_probe14contains_match(i8 noundef %needle, ptr noalias nofree noundef nonnull readonly captures(none) %bytes.0, i64 noundef range(i64 0, -9223372036854775808) %bytes.1) unnamed_addr #0 !guid !4 {
start:
  %_3 = icmp samesign ugt i64 %bytes.1, 15
  tail call void @llvm.assume(i1 %_3)
  %_6 = load i8, ptr %bytes.0, align 1, !noundef !5
  %_5 = icmp eq i8 %_6, %needle
  br i1 %_5, label %bb21, label %bb3

bb3:                                              ; preds = %start
  %0 = insertelement <16 x i8> poison, i8 %needle, i64 0
  %n = shufflevector <16 x i8> %0, <16 x i8> poison, <16 x i32> zeroinitializer
  %fst_len.i = and i64 %bytes.1, 9223372036854775744
  %data.i.i = getelementptr inbounds nuw i8, ptr %bytes.0, i64 %fst_len.i
  %_38.not29 = icmp eq i64 %fst_len.i, 0
  br i1 %_38.not29, label %bb24, label %bb52

bb4:                                              ; preds = %bb52
  %_43 = getelementptr inbounds nuw i8, ptr %chunks.sroa.0.031, i64 64
  %_44 = add nsw i64 %chunks.sroa.6.030, -64
  %_38.not = icmp eq i64 %_44, 0
  br i1 %_38.not, label %bb24, label %bb52

bb24:                                             ; preds = %bb4, %bb3
  %rem.i12 = and i64 %bytes.1, 15
  %fst_len.i13 = and i64 %bytes.1, 48
  %_107.not32 = icmp eq i64 %fst_len.i13, 0
  br i1 %_107.not32, label %bb66, label %_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe.exit

bb12:                                             ; preds = %_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe.exit
  %_113 = add nsw i64 %tail.sroa.6.034, -16
  %_112 = getelementptr inbounds nuw i8, ptr %tail.sroa.0.033, i64 16
  %_107.not = icmp eq i64 %_113, 0
  br i1 %_107.not, label %bb66, label %_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe.exit

bb66:                                             ; preds = %bb12, %bb24
  %_30 = icmp eq i64 %rem.i12, 0
  br i1 %_30, label %bb21, label %bb76

_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe.exit: ; preds = %bb24, %bb12
  %tail.sroa.6.034 = phi i64 [ %_113, %bb12 ], [ %fst_len.i13, %bb24 ]
  %tail.sroa.0.033 = phi ptr [ %_112, %bb12 ], [ %data.i.i, %bb24 ]
  %tmp.sroa.0.0.copyload.i = load <16 x i8>, ptr %tail.sroa.0.033, align 1, !alias.scope !6, !noalias !9
  %1 = icmp eq <16 x i8> %tmp.sroa.0.0.copyload.i, %n
  %2 = bitcast <16 x i1> %1 to i16
  %_27.not = icmp eq i16 %2, 0
  br i1 %_27.not, label %bb12, label %bb21

bb76:                                             ; preds = %bb66
  %3 = getelementptr i8, ptr %bytes.0, i64 %bytes.1
  %_131 = getelementptr i8, ptr %3, i64 -16
  %tmp.sroa.0.0.copyload.i15 = load <16 x i8>, ptr %_131, align 1, !alias.scope !12, !noalias !15
  %4 = icmp eq <16 x i8> %tmp.sroa.0.0.copyload.i15, %n
  %5 = bitcast <16 x i1> %4 to i16
  %6 = icmp ne i16 %5, 0
  %7 = zext i1 %6 to i64
  br label %bb21

bb21:                                             ; preds = %bb52, %_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe.exit, %bb76, %bb66, %start
  %_0.sroa.0.0 = phi i64 [ 1, %start ], [ 0, %bb66 ], [ %7, %bb76 ], [ 1, %_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe.exit ], [ 1, %bb52 ]
  ret i64 %_0.sroa.0.0

bb52:                                             ; preds = %bb3, %bb4
  %chunks.sroa.0.031 = phi ptr [ %_43, %bb4 ], [ %bytes.0, %bb3 ]
  %chunks.sroa.6.030 = phi i64 [ %_44, %bb4 ], [ %fst_len.i, %bb3 ]
  %tmp.sroa.0.0.copyload.i16 = load <16 x i8>, ptr %chunks.sroa.0.031, align 1, !alias.scope !18, !noalias !21
  %8 = icmp eq <16 x i8> %tmp.sroa.0.0.copyload.i16, %n
  %_67 = getelementptr inbounds nuw i8, ptr %chunks.sroa.0.031, i64 16
  %tmp.sroa.0.0.copyload.i17 = load <16 x i8>, ptr %_67, align 1, !alias.scope !24, !noalias !27
  %9 = icmp eq <16 x i8> %tmp.sroa.0.0.copyload.i17, %n
  %_80 = getelementptr inbounds nuw i8, ptr %chunks.sroa.0.031, i64 32
  %tmp.sroa.0.0.copyload.i18 = load <16 x i8>, ptr %_80, align 1, !alias.scope !30, !noalias !33
  %10 = icmp eq <16 x i8> %tmp.sroa.0.0.copyload.i18, %n
  %_93 = getelementptr inbounds nuw i8, ptr %chunks.sroa.0.031, i64 48
  %tmp.sroa.0.0.copyload.i19 = load <16 x i8>, ptr %_93, align 1, !alias.scope !36, !noalias !39
  %11 = icmp eq <16 x i8> %tmp.sroa.0.0.copyload.i19, %n
  %_1019 = or <16 x i1> %8, %9
  %_10210 = or <16 x i1> %_1019, %10
  %_10311 = or <16 x i1> %_10210, %11
  %12 = bitcast <16 x i1> %_10311 to i16
  %_21.not = icmp eq i16 %12, 0
  br i1 %_21.not, label %bb4, label %bb21
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #1

attributes #0 = { nofree norecurse nosync nounwind memory(argmem: read, inaccessiblemem: write) uwtable "frame-pointer"="non-leaf" "probe-stack"="inline-asm" "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 8, !"PIC Level", i32 2}
!1 = !{i32 7, !"uwtable", i32 2}
!2 = !{i32 7, !"frame-pointer", i32 1}
!3 = !{!"rustc version 1.99.0-dev"}
!4 = !{i64 5814596873331678530}
!5 = !{}
!6 = !{!7}
!7 = distinct !{!7, !8, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe: %slice.0"}
!8 = distinct !{!8, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe"}
!9 = !{!10, !11}
!10 = distinct !{!10, !8, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe: %_0"}
!11 = distinct !{!11, !8, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe: argument 2"}
!12 = !{!13}
!13 = distinct !{!13, !14, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe: %slice.0"}
!14 = distinct !{!14, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe"}
!15 = !{!16, !17}
!16 = distinct !{!16, !14, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe: %_0"}
!17 = distinct !{!17, !14, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe: argument 2"}
!18 = !{!19}
!19 = distinct !{!19, !20, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe: %slice.0"}
!20 = distinct !{!20, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe"}
!21 = !{!22, !23}
!22 = distinct !{!22, !20, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe: %_0"}
!23 = distinct !{!23, !20, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe: argument 2"}
!24 = !{!25}
!25 = distinct !{!25, !26, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe: %slice.0"}
!26 = distinct !{!26, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe"}
!27 = !{!28, !29}
!28 = distinct !{!28, !26, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe: %_0"}
!29 = distinct !{!29, !26, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe: argument 2"}
!30 = !{!31}
!31 = distinct !{!31, !32, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe: %slice.0"}
!32 = distinct !{!32, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe"}
!33 = !{!34, !35}
!34 = distinct !{!34, !32, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe: %_0"}
!35 = distinct !{!35, !32, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe: argument 2"}
!36 = !{!37}
!37 = distinct !{!37, !38, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe: %slice.0"}
!38 = distinct !{!38, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe"}
!39 = !{!40, !41}
!40 = distinct !{!40, !38, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe: %_0"}
!41 = distinct !{!41, !38, !"_RNvMNtNtCshp6Wxz1DwXO_4core9core_simd6vectorINtB2_4SimdhKj10_E10from_sliceCsadBbONxITBY_19portable_mask_probe: argument 2"}
