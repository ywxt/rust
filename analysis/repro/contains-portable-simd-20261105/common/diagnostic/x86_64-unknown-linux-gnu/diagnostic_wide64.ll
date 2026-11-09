; ModuleID = 'diagnostic_wide64.ab3cbf6978ba1b1a-cgu.0'
source_filename = "diagnostic_wide64.ab3cbf6978ba1b1a-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@alloc_a57caa216b7f7cdbaccf41839ba4d102 = private unnamed_addr constant [8 x i8] c"@\00\00\00\00\00\00\00", align 8, !guid !0
@alloc_0b5855b030ad37d29eeb66e295429bf8 = private unnamed_addr constant [58 x i8] c"/tmp/contains-portable-simd-20261105/diagnostic_wide64.rs\00", align 1, !guid !1
@alloc_fde261dc87a31883afec70062fd7fe56 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_0b5855b030ad37d29eeb66e295429bf8, [16 x i8] c"9\00\00\00\00\00\00\00\02\00\00\00k\00\00\00" }>, align 8, !guid !2

; diagnostic_wide64::contains_byte_64
; Function Attrs: nonlazybind uwtable
define noundef zeroext i1 @_RNvCseHuvESv4PMs_17diagnostic_wide6416contains_byte_64(ptr noalias nofree noundef nonnull readonly captures(none) %c.0, i64 noundef range(i64 0, -9223372036854775808) %c.1, i8 noundef %needle) unnamed_addr #0 !guid !7 {
start:
  %_4 = alloca [8 x i8], align 8
  store i64 %c.1, ptr %_4, align 8
  %0 = icmp eq i64 %c.1, 64
  br i1 %0, label %bb5, label %bb2, !prof !8

bb2:                                              ; preds = %start
; call core::panicking::assert_failed::<usize, usize>
  call void @_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedjjEB4_(i8 noundef 0, ptr noalias nofree noundef nonnull readonly align 8 captures(address, read_provenance) dereferenceable(8) %_4, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(8) @alloc_a57caa216b7f7cdbaccf41839ba4d102, ptr noundef null, ptr undef, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) @alloc_fde261dc87a31883afec70062fd7fe56) #2
  unreachable

bb5:                                              ; preds = %start
  %1 = insertelement <64 x i8> poison, i8 %needle, i64 0
  %n = shufflevector <64 x i8> %1, <64 x i8> poison, <64 x i32> zeroinitializer
  %c.0.val = load <64 x i8>, ptr %c.0, align 1
  %2 = icmp eq <64 x i8> %c.0.val, %n
  %3 = bitcast <64 x i1> %2 to i64
  %_0 = icmp ne i64 %3, 0
  ret i1 %_0
}

; core::panicking::assert_failed::<usize, usize>
; Function Attrs: cold minsize noinline noreturn nonlazybind optsize uwtable
declare void @_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedjjEB4_(i8 noundef range(i8 0, 3), ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(8), ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(8), ptr noundef, ptr, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24)) unnamed_addr #1

attributes #0 = { nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #1 = { cold minsize noinline noreturn nonlazybind optsize uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #2 = { noinline noreturn }

!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = !{i64 -2798965367155492959}
!1 = !{i64 -2317985301599011406}
!2 = !{i64 -5889274936956981130}
!3 = !{i32 8, !"PIC Level", i32 2}
!4 = !{i32 2, !"RtLibUseGOT", i32 1}
!5 = !{i32 7, !"uwtable", i32 2}
!6 = !{!"rustc version 1.99.0-dev"}
!7 = !{i64 -2537845965181822062}
!8 = !{!"branch_weights", !"expected", i32 2000, i32 1}
