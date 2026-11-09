; ModuleID = 'diagnostic_intrinsics.23360e6d95804-cgu.0'
source_filename = "diagnostic_intrinsics.23360e6d95804-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@alloc_a57caa216b7f7cdbaccf41839ba4d102 = private unnamed_addr constant [8 x i8] c"@\00\00\00\00\00\00\00", align 8, !guid !0
@alloc_638052b9373210eb684a53fc33558e2a = private unnamed_addr constant [62 x i8] c"/tmp/contains-portable-simd-20261105/diagnostic_intrinsics.rs\00", align 1, !guid !1
@alloc_73f3cca889ccc2d04c0c06d7ddd51f96 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_638052b9373210eb684a53fc33558e2a, [16 x i8] c"=\00\00\00\00\00\00\00\13\00\00\00\05\00\00\00" }>, align 8, !guid !2

; diagnostic_intrinsics::contains_byte_64
; Function Attrs: nonlazybind uwtable
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
  %dst.sroa.0.0.copyload.i52 = load <16 x i8>, ptr %c.0, align 1, !noalias !9
  %3 = icmp eq <16 x i8> %dst.sroa.0.0.copyload.i52, %2
  %_13 = getelementptr inbounds nuw i8, ptr %c.0, i64 16
  %dst.sroa.0.0.copyload.i1553 = load <16 x i8>, ptr %_13, align 1, !noalias !12
  %4 = icmp eq <16 x i8> %dst.sroa.0.0.copyload.i1553, %2
  %_16 = getelementptr inbounds nuw i8, ptr %c.0, i64 32
  %dst.sroa.0.0.copyload.i1754 = load <16 x i8>, ptr %_16, align 1, !noalias !15
  %5 = icmp eq <16 x i8> %dst.sroa.0.0.copyload.i1754, %2
  %_19 = getelementptr inbounds nuw i8, ptr %c.0, i64 48
  %dst.sroa.0.0.copyload.i1955 = load <16 x i8>, ptr %_19, align 1, !noalias !18
  %6 = icmp eq <16 x i8> %dst.sroa.0.0.copyload.i1955, %2
  %7 = or <16 x i1> %3, %4
  %8 = or <16 x i1> %5, %6
  %9 = or <16 x i1> %7, %8
  %_5.i = bitcast <16 x i1> %9 to i16
  %_0 = icmp ne i16 %_5.i, 0
  ret i1 %_0

bb2:                                              ; preds = %start
; call core::panicking::assert_failed::<usize, usize>
  call void @_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedjjEB4_(i8 noundef 0, ptr noalias nofree noundef nonnull readonly align 8 captures(address, read_provenance) dereferenceable(8) %_4, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(8) @alloc_a57caa216b7f7cdbaccf41839ba4d102, ptr noundef null, ptr undef, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) @alloc_73f3cca889ccc2d04c0c06d7ddd51f96) #3
  unreachable
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #1

; core::panicking::assert_failed::<usize, usize>
; Function Attrs: cold minsize noinline noreturn nonlazybind optsize uwtable
declare void @_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedjjEB4_(i8 noundef range(i8 0, 3), ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(8), ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(8), ptr noundef, ptr, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24)) unnamed_addr #2

attributes #0 = { nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { cold minsize noinline noreturn nonlazybind optsize uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #3 = { noinline noreturn }

!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = !{i64 458762871160025922}
!1 = !{i64 -6127823619097077210}
!2 = !{i64 -8470856045796912379}
!3 = !{i32 8, !"PIC Level", i32 2}
!4 = !{i32 2, !"RtLibUseGOT", i32 1}
!5 = !{i32 7, !"uwtable", i32 2}
!6 = !{!"rustc version 1.99.0-dev"}
!7 = !{i64 6909776326263719459}
!8 = !{!"branch_weights", !"expected", i32 2000, i32 1}
!9 = !{!10}
!10 = distinct !{!10, !11, !"_RNvNtNtNtCsc9NCSoc2doQ_4core9core_arch3x864sse215__mm_loadu_si128: %_0"}
!11 = distinct !{!11, !"_RNvNtNtNtCsc9NCSoc2doQ_4core9core_arch3x864sse215__mm_loadu_si128"}
!12 = !{!13}
!13 = distinct !{!13, !14, !"_RNvNtNtNtCsc9NCSoc2doQ_4core9core_arch3x864sse215__mm_loadu_si128: %_0"}
!14 = distinct !{!14, !"_RNvNtNtNtCsc9NCSoc2doQ_4core9core_arch3x864sse215__mm_loadu_si128"}
!15 = !{!16}
!16 = distinct !{!16, !17, !"_RNvNtNtNtCsc9NCSoc2doQ_4core9core_arch3x864sse215__mm_loadu_si128: %_0"}
!17 = distinct !{!17, !"_RNvNtNtNtCsc9NCSoc2doQ_4core9core_arch3x864sse215__mm_loadu_si128"}
!18 = !{!19}
!19 = distinct !{!19, !20, !"_RNvNtNtNtCsc9NCSoc2doQ_4core9core_arch3x864sse215__mm_loadu_si128: %_0"}
!20 = distinct !{!20, !"_RNvNtNtNtCsc9NCSoc2doQ_4core9core_arch3x864sse215__mm_loadu_si128"}
