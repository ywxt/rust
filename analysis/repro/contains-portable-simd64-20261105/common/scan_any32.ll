; ModuleID = 'scan_any32.6ada41dfc67d16a9-cgu.0'
source_filename = "scan_any32.6ada41dfc67d16a9-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "aarch64-unknown-linux-gnu"

@alloc_f0358faafa39968ada1cefbee9890ba0 = private unnamed_addr constant [53 x i8] c"/tmp/contains-portable-simd64-20261105/scan_any32.rs\00", align 1, !guid !0
@alloc_dae5cfecc0a1b8226ceeede9af5f605d = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_f0358faafa39968ada1cefbee9890ba0, [16 x i8] c"4\00\00\00\00\00\00\00\04\00\00\00\08\00\00\00" }>, align 8, !guid !1
@alloc_77945901fbe37cc7bf4378199e357b4e = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_f0358faafa39968ada1cefbee9890ba0, [16 x i8] c"4\00\00\00\00\00\00\00\11\00\00\00>\00\00\00" }>, align 8, !guid !2

; scan_any32::contains_byte_simd
; Function Attrs: uwtable
define noundef zeroext i1 @_RNvCs9aLY8Qa7pT9_10scan_any3218contains_byte_simd(ptr noalias nofree noundef nonnull readonly captures(address, read_provenance) %bytes.0, i64 noundef range(i64 0, -9223372036854775808) %bytes.1, i8 noundef %needle) unnamed_addr #0 !guid !7 {
start:
  %_6.not = icmp eq i64 %bytes.1, 0
  br i1 %_6.not, label %panic, label %bb1

bb1:                                              ; preds = %start
  %_4 = load i8, ptr %bytes.0, align 1, !noundef !8
  %_3 = icmp eq i8 %_4, %needle
  br i1 %_3, label %bb23, label %bb3

panic:                                            ; preds = %start
; call core::panicking::panic_bounds_check
  tail call void @_RNvNtCshp6Wxz1DwXO_4core9panicking18panic_bounds_check(i64 noundef 0, i64 noundef 0, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) @alloc_dae5cfecc0a1b8226ceeede9af5f605d) #4
  unreachable

bb3:                                              ; preds = %bb1
  %_8 = icmp samesign ugt i64 %bytes.1, 127
  br i1 %_8, label %bb4, label %bb27

bb4:                                              ; preds = %bb3
  %addr.i.i = ptrtoint ptr %bytes.0 to i64
  %_9.i.i = add i64 %addr.i.i, 63
  %aligned_address.i.i = and i64 %_9.i.i, -64
  %byte_offset.i.i = sub i64 %aligned_address.i.i, %addr.i.i
  %_12.i.i = icmp ult i64 %byte_offset.i.i, 64
  tail call void @llvm.assume(i1 %_12.i.i)
  %_10.not = icmp eq i64 %byte_offset.i.i, 0
  br i1 %_10.not, label %bb27, label %bb24

bb24:                                             ; preds = %bb4
  %c.0.val.i = load <32 x i8>, ptr %bytes.0, align 1, !alias.scope !9
  %0 = insertelement <32 x i8> poison, i8 %needle, i64 0
  %n.i = shufflevector <32 x i8> %0, <32 x i8> poison, <32 x i32> zeroinitializer
  %1 = icmp eq <32 x i8> %c.0.val.i, %n.i
  %_29.i = getelementptr inbounds nuw i8, ptr %bytes.0, i64 32
  %_29.val.i = load <32 x i8>, ptr %_29.i, align 1, !alias.scope !9
  %2 = icmp eq <32 x i8> %_29.val.i, %n.i
  %_373.i = or <32 x i1> %1, %2
  %3 = bitcast <32 x i1> %_373.i to i32
  %_0.i.not = icmp eq i32 %3, 0
  br i1 %_0.i.not, label %bb27, label %bb23

bb27:                                             ; preds = %bb24, %bb3, %bb4
  %prefix.sroa.0.022 = phi i64 [ 0, %bb3 ], [ 0, %bb4 ], [ %byte_offset.i.i, %bb24 ]
  %_32 = sub nuw nsw i64 %bytes.1, %prefix.sroa.0.022
  %fst_len.i = and i64 %_32, 9223372036854775744
  %len.i.i = and i64 %_32, 63
  %4 = insertelement <32 x i8> poison, i8 %needle, i64 0
  %n.i8 = shufflevector <32 x i8> %4, <32 x i8> poison, <32 x i32> zeroinitializer
  %_40.not23 = icmp eq i64 %fst_len.i, 0
  br i1 %_40.not23, label %bb29, label %_RNvCs9aLY8Qa7pT9_10scan_any3216contains_byte_64.exit.lr.ph

_RNvCs9aLY8Qa7pT9_10scan_any3216contains_byte_64.exit.lr.ph: ; preds = %bb27
  %_36 = getelementptr inbounds nuw i8, ptr %bytes.0, i64 %prefix.sroa.0.022
  br label %_RNvCs9aLY8Qa7pT9_10scan_any3216contains_byte_64.exit

bb14:                                             ; preds = %_RNvCs9aLY8Qa7pT9_10scan_any3216contains_byte_64.exit
  %_45 = getelementptr inbounds nuw i8, ptr %chunks.sroa.0.025, i64 64
  %_46 = add nsw i64 %chunks.sroa.6.024, -64
  %_40.not = icmp eq i64 %_46, 0
  br i1 %_40.not, label %bb29, label %_RNvCs9aLY8Qa7pT9_10scan_any3216contains_byte_64.exit

bb29:                                             ; preds = %bb14, %bb27
  %_20 = icmp eq i64 %len.i.i, 0
  br i1 %_20, label %bb23, label %bb19

_RNvCs9aLY8Qa7pT9_10scan_any3216contains_byte_64.exit: ; preds = %_RNvCs9aLY8Qa7pT9_10scan_any3216contains_byte_64.exit.lr.ph, %bb14
  %chunks.sroa.0.025 = phi ptr [ %_36, %_RNvCs9aLY8Qa7pT9_10scan_any3216contains_byte_64.exit.lr.ph ], [ %_45, %bb14 ]
  %chunks.sroa.6.024 = phi i64 [ %fst_len.i, %_RNvCs9aLY8Qa7pT9_10scan_any3216contains_byte_64.exit.lr.ph ], [ %_46, %bb14 ]
  %c.0.val.i7 = load <32 x i8>, ptr %chunks.sroa.0.025, align 1, !alias.scope !12
  %5 = icmp eq <32 x i8> %c.0.val.i7, %n.i8
  %_29.i9 = getelementptr inbounds nuw i8, ptr %chunks.sroa.0.025, i64 32
  %_29.val.i10 = load <32 x i8>, ptr %_29.i9, align 1, !alias.scope !12
  %6 = icmp eq <32 x i8> %_29.val.i10, %n.i8
  %_373.i11 = or <32 x i1> %5, %6
  %7 = bitcast <32 x i1> %_373.i11 to i32
  %_0.i12.not = icmp eq i32 %7, 0
  br i1 %_0.i12.not, label %bb14, label %bb23

bb19:                                             ; preds = %bb29
  %_23 = add nsw i64 %bytes.1, -64
  %_51 = icmp samesign ult i64 %bytes.1, 64
  br i1 %_51, label %bb30, label %bb31, !prof !15

bb31:                                             ; preds = %bb19
  %_57 = getelementptr inbounds nuw i8, ptr %bytes.0, i64 %_23
  %c.0.val.i14 = load <32 x i8>, ptr %_57, align 1, !alias.scope !16
  %8 = icmp eq <32 x i8> %c.0.val.i14, %n.i8
  %_29.i16 = getelementptr inbounds nuw i8, ptr %_57, i64 32
  %_29.val.i17 = load <32 x i8>, ptr %_29.i16, align 1, !alias.scope !16
  %9 = icmp eq <32 x i8> %_29.val.i17, %n.i8
  %_373.i18 = or <32 x i1> %8, %9
  %10 = bitcast <32 x i1> %_373.i18 to i32
  %_0.i19 = icmp ne i32 %10, 0
  br label %bb23

bb30:                                             ; preds = %bb19
; call core::slice::index::slice_index_fail
  tail call void @_RNvNtNtCshp6Wxz1DwXO_4core5slice5index16slice_index_fail(i64 noundef %_23, i64 noundef %bytes.1, i64 noundef %bytes.1, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) @alloc_77945901fbe37cc7bf4378199e357b4e) #4
  unreachable

bb23:                                             ; preds = %_RNvCs9aLY8Qa7pT9_10scan_any3216contains_byte_64.exit, %bb31, %bb29, %bb24, %bb1
  %_0.sroa.0.1.off0 = phi i1 [ true, %bb24 ], [ true, %bb1 ], [ false, %bb29 ], [ %_0.i19, %bb31 ], [ true, %_RNvCs9aLY8Qa7pT9_10scan_any3216contains_byte_64.exit ]
  ret i1 %_0.sroa.0.1.off0
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #1

; core::slice::index::slice_index_fail
; Function Attrs: cold noinline noreturn uwtable
declare void @_RNvNtNtCshp6Wxz1DwXO_4core5slice5index16slice_index_fail(i64 noundef, i64 noundef, i64 noundef, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24)) unnamed_addr #2

; core::panicking::panic_bounds_check
; Function Attrs: cold minsize noinline noreturn optsize uwtable
declare void @_RNvNtCshp6Wxz1DwXO_4core9panicking18panic_bounds_check(i64 noundef, i64 noundef, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24)) unnamed_addr #3

attributes #0 = { uwtable "frame-pointer"="non-leaf" "probe-stack"="inline-asm" "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }
attributes #2 = { cold noinline noreturn uwtable "frame-pointer"="non-leaf" "probe-stack"="inline-asm" "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #3 = { cold minsize noinline noreturn optsize uwtable "frame-pointer"="non-leaf" "probe-stack"="inline-asm" "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #4 = { noinline noreturn }

!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = !{i64 -6453203611722602652}
!1 = !{i64 -4428199866137707560}
!2 = !{i64 2194810497339472037}
!3 = !{i32 8, !"PIC Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 2}
!5 = !{i32 7, !"frame-pointer", i32 1}
!6 = !{!"rustc version 1.99.0-dev"}
!7 = !{i64 2515547322972023630}
!8 = !{}
!9 = !{!10}
!10 = distinct !{!10, !11, !"_RNvCs9aLY8Qa7pT9_10scan_any3216contains_byte_64: %c.0"}
!11 = distinct !{!11, !"_RNvCs9aLY8Qa7pT9_10scan_any3216contains_byte_64"}
!12 = !{!13}
!13 = distinct !{!13, !14, !"_RNvCs9aLY8Qa7pT9_10scan_any3216contains_byte_64: %c.0"}
!14 = distinct !{!14, !"_RNvCs9aLY8Qa7pT9_10scan_any3216contains_byte_64"}
!15 = !{!"branch_weights", !"expected", i32 1, i32 2000}
!16 = !{!17}
!17 = distinct !{!17, !18, !"_RNvCs9aLY8Qa7pT9_10scan_any3216contains_byte_64: %c.0"}
!18 = distinct !{!18, !"_RNvCs9aLY8Qa7pT9_10scan_any3216contains_byte_64"}
