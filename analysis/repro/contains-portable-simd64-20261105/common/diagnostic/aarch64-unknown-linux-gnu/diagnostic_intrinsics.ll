; ModuleID = 'diagnostic_intrinsics.23360e6d95804-cgu.0'
source_filename = "diagnostic_intrinsics.23360e6d95804-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "aarch64-unknown-linux-gnu"

@alloc_a57caa216b7f7cdbaccf41839ba4d102 = private unnamed_addr constant [8 x i8] c"@\00\00\00\00\00\00\00", align 8, !guid !0
@alloc_638052b9373210eb684a53fc33558e2a = private unnamed_addr constant [62 x i8] c"/tmp/contains-portable-simd-20261105/diagnostic_intrinsics.rs\00", align 1, !guid !1
@alloc_ca2b6211611a4628359d86f3bc890604 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_638052b9373210eb684a53fc33558e2a, [16 x i8] c"=\00\00\00\00\00\00\00\05\00\00\00\05\00\00\00" }>, align 8, !guid !2

; diagnostic_intrinsics::contains_byte_64
; Function Attrs: uwtable
define noundef zeroext i1 @_RNvCs2PTBQ8hxw_21diagnostic_intrinsics16contains_byte_64(ptr noalias nofree noundef nonnull readonly captures(none) %c.0, i64 noundef range(i64 0, -9223372036854775808) %c.1, i8 noundef %needle) unnamed_addr #0 !guid !7 {
start:
  %_4 = alloca [8 x i8], align 8
  call void @llvm.lifetime.start.p0(ptr nonnull %_4)
  store i64 %c.1, ptr %_4, align 8
  %0 = icmp eq i64 %c.1, 64
  br i1 %0, label %bb1, label %bb2, !prof !8

bb1:                                              ; preds = %start
  call void @llvm.lifetime.end.p0(ptr nonnull %_4)
  %1 = insertelement <16 x i8> poison, i8 %needle, i64 0
  %2 = shufflevector <16 x i8> %1, <16 x i8> poison, <16 x i32> zeroinitializer
  %.sroa.01.0.copyload = load <16 x i8>, ptr %c.0, align 1
  %3 = icmp eq <16 x i8> %.sroa.01.0.copyload, %2
  %_12 = getelementptr inbounds nuw i8, ptr %c.0, i64 16
  %.sroa.05.0.copyload = load <16 x i8>, ptr %_12, align 1
  %4 = icmp eq <16 x i8> %.sroa.05.0.copyload, %2
  %_15 = getelementptr inbounds nuw i8, ptr %c.0, i64 32
  %.sroa.09.0.copyload = load <16 x i8>, ptr %_15, align 1
  %5 = icmp eq <16 x i8> %.sroa.09.0.copyload, %2
  %_18 = getelementptr inbounds nuw i8, ptr %c.0, i64 48
  %.sroa.013.0.copyload = load <16 x i8>, ptr %_18, align 1
  %6 = icmp eq <16 x i8> %.sroa.013.0.copyload, %2
  %7 = or <16 x i1> %3, %4
  %8 = or <16 x i1> %5, %6
  %9 = or <16 x i1> %7, %8
  %10 = bitcast <16 x i1> %9 to i16
  %11 = icmp ne i16 %10, 0
  ret i1 %11

bb2:                                              ; preds = %start
; call core::panicking::assert_failed::<usize, usize>
  call void @_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedjjEB4_(i8 noundef 0, ptr noalias nofree noundef nonnull readonly align 8 captures(address, read_provenance) dereferenceable(8) %_4, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(8) @alloc_a57caa216b7f7cdbaccf41839ba4d102, ptr noundef null, ptr undef, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) @alloc_ca2b6211611a4628359d86f3bc890604) #3
  unreachable
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #1

; core::panicking::assert_failed::<usize, usize>
; Function Attrs: cold minsize noinline noreturn optsize uwtable
declare void @_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedjjEB4_(i8 noundef range(i8 0, 3), ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(8), ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(8), ptr noundef, ptr, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24)) unnamed_addr #2

attributes #0 = { uwtable "frame-pointer"="non-leaf" "probe-stack"="inline-asm" "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { cold minsize noinline noreturn optsize uwtable "frame-pointer"="non-leaf" "probe-stack"="inline-asm" "target-cpu"="generic" "target-features"="+v8a,+outline-atomics" }
attributes #3 = { noinline noreturn }

!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = !{i64 458762871160025922}
!1 = !{i64 -6127823619097077210}
!2 = !{i64 6445335532725688430}
!3 = !{i32 8, !"PIC Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 2}
!5 = !{i32 7, !"frame-pointer", i32 1}
!6 = !{!"rustc version 1.99.0-dev"}
!7 = !{i64 6909776326263719459}
!8 = !{!"branch_weights", !"expected", i32 2000, i32 1}
