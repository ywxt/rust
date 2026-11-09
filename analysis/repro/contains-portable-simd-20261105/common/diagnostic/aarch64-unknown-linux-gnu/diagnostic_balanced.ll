; ModuleID = 'diagnostic_balanced.3bb9082a5fcb6617-cgu.0'
source_filename = "diagnostic_balanced.3bb9082a5fcb6617-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "aarch64-unknown-linux-gnu"

@alloc_a57caa216b7f7cdbaccf41839ba4d102 = private unnamed_addr constant [8 x i8] c"@\00\00\00\00\00\00\00", align 8, !guid !0
@alloc_75b00c4edc320aa90cfa1ccf03de6437 = private unnamed_addr constant [60 x i8] c"/tmp/contains-portable-simd-20261105/diagnostic_balanced.rs\00", align 1, !guid !1
@alloc_8f956b387f2c9609db43f1fe5913ac99 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_75b00c4edc320aa90cfa1ccf03de6437, [16 x i8] c";\00\00\00\00\00\00\00\0A\00\00\00\05\00\00\00" }>, align 8, !guid !2

; diagnostic_balanced::contains_byte_64
; Function Attrs: uwtable
define noundef zeroext i1 @_RNvCs57TYYTPWn9b_19diagnostic_balanced16contains_byte_64(ptr noalias nofree noundef nonnull readonly captures(none) %c.0, i64 noundef range(i64 0, -9223372036854775808) %c.1, i8 noundef %needle) unnamed_addr #0 !guid !7 {
start:
  %_4 = alloca [8 x i8], align 8
  store i64 %c.1, ptr %_4, align 8
  %0 = icmp eq i64 %c.1, 64
  br i1 %0, label %bb8, label %bb2, !prof !8

bb2:                                              ; preds = %start
; call core::panicking::assert_failed::<usize, usize>
  call void @_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedjjEB4_(i8 noundef 0, ptr noalias nofree noundef nonnull readonly align 8 captures(address, read_provenance) dereferenceable(8) %_4, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(8) @alloc_a57caa216b7f7cdbaccf41839ba4d102, ptr noundef null, ptr undef, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) @alloc_8f956b387f2c9609db43f1fe5913ac99) #2
  unreachable

bb8:                                              ; preds = %start
  %c.0.val = load <16 x i8>, ptr %c.0, align 1
  %_33 = getelementptr inbounds nuw i8, ptr %c.0, i64 16
  %_33.val = load <16 x i8>, ptr %_33, align 1
  %_46 = getelementptr inbounds nuw i8, ptr %c.0, i64 32
  %_46.val = load <16 x i8>, ptr %_46, align 1
  %1 = insertelement <16 x i8> poison, i8 %needle, i64 0
  %n = shufflevector <16 x i8> %1, <16 x i8> poison, <16 x i32> zeroinitializer
  %2 = icmp eq <16 x i8> %_46.val, %n
  %3 = icmp eq <16 x i8> %_33.val, %n
  %4 = icmp eq <16 x i8> %c.0.val, %n
  %_59 = getelementptr inbounds nuw i8, ptr %c.0, i64 48
  %_59.val = load <16 x i8>, ptr %_59, align 1
  %5 = icmp eq <16 x i8> %_59.val, %n
  %_675 = or <16 x i1> %4, %3
  %_686 = or <16 x i1> %2, %5
  %_697 = or <16 x i1> %_675, %_686
  %6 = bitcast <16 x i1> %_697 to i16
  %_0 = icmp ne i16 %6, 0
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

!0 = !{i64 2571479851136278669}
!1 = !{i64 -894940174643267450}
!2 = !{i64 700684744313757292}
!3 = !{i32 8, !"PIC Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 2}
!5 = !{i32 7, !"frame-pointer", i32 1}
!6 = !{!"rustc version 1.99.0-dev"}
!7 = !{i64 2421285338396545119}
!8 = !{!"branch_weights", !"expected", i32 2000, i32 1}
