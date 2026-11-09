; ModuleID = 'diagnostic_wide32.93350778e58b103f-cgu.0'
source_filename = "diagnostic_wide32.93350778e58b103f-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "aarch64-unknown-linux-gnu"

@alloc_a57caa216b7f7cdbaccf41839ba4d102 = private unnamed_addr constant [8 x i8] c"@\00\00\00\00\00\00\00", align 8, !guid !0
@alloc_d050b2a2588321a0f7bb60270933294f = private unnamed_addr constant [58 x i8] c"/tmp/contains-portable-simd-20261105/diagnostic_wide32.rs\00", align 1, !guid !1
@alloc_dd74007490276935de2d5471e23a8d4d = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_d050b2a2588321a0f7bb60270933294f, [16 x i8] c"9\00\00\00\00\00\00\00\02\00\00\00k\00\00\00" }>, align 8, !guid !2

; diagnostic_wide32::contains_byte_64
; Function Attrs: uwtable
define noundef zeroext i1 @_RNvCscDzYd9feO7z_17diagnostic_wide3216contains_byte_64(ptr noalias nofree noundef nonnull readonly captures(none) %c.0, i64 noundef range(i64 0, -9223372036854775808) %c.1, i8 noundef %needle) unnamed_addr #0 !guid !7 {
start:
  %_4 = alloca [8 x i8], align 8
  store i64 %c.1, ptr %_4, align 8
  %0 = icmp eq i64 %c.1, 64
  br i1 %0, label %bb6, label %bb2, !prof !8

bb2:                                              ; preds = %start
; call core::panicking::assert_failed::<usize, usize>
  call void @_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedjjEB4_(i8 noundef 0, ptr noalias nofree noundef nonnull readonly align 8 captures(address, read_provenance) dereferenceable(8) %_4, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(8) @alloc_a57caa216b7f7cdbaccf41839ba4d102, ptr noundef null, ptr undef, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) @alloc_dd74007490276935de2d5471e23a8d4d) #2
  unreachable

bb6:                                              ; preds = %start
  %c.0.val = load <32 x i8>, ptr %c.0, align 1
  %1 = insertelement <32 x i8> poison, i8 %needle, i64 0
  %n = shufflevector <32 x i8> %1, <32 x i8> poison, <32 x i32> zeroinitializer
  %2 = icmp eq <32 x i8> %c.0.val, %n
  %_30 = getelementptr inbounds nuw i8, ptr %c.0, i64 32
  %_30.val = load <32 x i8>, ptr %_30, align 1
  %3 = icmp eq <32 x i8> %_30.val, %n
  %_383 = or <32 x i1> %2, %3
  %4 = bitcast <32 x i1> %_383 to i32
  %_0 = icmp ne i32 %4, 0
  ret i1 %_0
}

; core::panicking::assert_failed::<usize, usize>
; Function Attrs: cold minsize noinline noreturn optsize uwtable
declare void @_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedjjEB4_(i8 noundef range(i8 0, 3), ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(8), ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(8), ptr noundef, ptr, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24)) unnamed_addr #1

attributes #0 = { uwtable "frame-pointer"="non-leaf" "probe-stack"="inline-asm" "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #1 = { cold minsize noinline noreturn optsize uwtable "frame-pointer"="non-leaf" "probe-stack"="inline-asm" "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #2 = { noinline noreturn }

!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = !{i64 8194701494434282880}
!1 = !{i64 7820135415880460408}
!2 = !{i64 -436188171938414725}
!3 = !{i32 8, !"PIC Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 2}
!5 = !{i32 7, !"frame-pointer", i32 1}
!6 = !{!"rustc version 1.99.0-dev"}
!7 = !{i64 7012114834865308770}
!8 = !{!"branch_weights", !"expected", i32 2000, i32 1}
