; ModuleID = 'driver.15e1a5ac6b98e495-cgu.0'
source_filename = "driver.15e1a5ac6b98e495-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"core::sync::atomic::Atomic<*mut ()>" = type { %"core::cell::UnsafeCell<core::sync::atomic::private::Align8<*mut ()>>" }
%"core::cell::UnsafeCell<core::sync::atomic::private::Align8<*mut ()>>" = type { %"core::sync::atomic::private::Align8<*mut ()>" }
%"core::sync::atomic::private::Align8<*mut ()>" = type { ptr }

@vtable.0 = private unnamed_addr constant <{ [24 x i8], ptr, ptr, ptr }> <{ [24 x i8] c"\00\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCs1StpruGFt5h_6driver, ptr @_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cs1StpruGFt5h_6driver, ptr @_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cs1StpruGFt5h_6driver }>, align 8, !guid !0
@alloc_8e81dfbcb5e45a532aa30c8331b0b47e = private unnamed_addr constant <{ [8 x i8], [8 x i8] }> <{ [8 x i8] zeroinitializer, [8 x i8] undef }>, align 8, !guid !1
@_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw2FN = external local_unnamed_addr global %"core::sync::atomic::Atomic<*mut ()>"
@alloc_b2b1f45faefdb6cfee69b54794ef8140 = private unnamed_addr constant [41 x i8] c"/tmp/memchr-std-crate-20261109/driver.rs\00", align 1, !guid !2
@alloc_76cbd47331a82c9bea1da249cd622be9 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\00\16\00\00\00\0C\00\00\00" }>, align 8, !guid !3
@alloc_476509aa7047bd805d630c6546685797 = private unnamed_addr constant [14 x i8] c"explicit panic", align 1, !guid !4
@alloc_1cd847217f7fad949c219121493e6692 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\00.\00\00\00o\00\00\00" }>, align 8, !guid !5
@alloc_97f20d6aba9b53792d2804ec8a9b80db = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\00/\00\00\00\17\00\00\00" }>, align 8, !guid !6
@alloc_0466fbcb6efd6e27b2f9ddb5c8bd67bf = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\00/\00\00\00#\00\00\00" }>, align 8, !guid !7
@alloc_91bb3c8e2e46ccbc16597808f0bab401 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\00/\00\00\00>\00\00\00" }>, align 8, !guid !8
@alloc_5c213bcbaef43ebb221d4146a2acfd23 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\00/\00\00\00J\00\00\00" }>, align 8, !guid !9
@alloc_430a626d7ad8fa09ca7e11f1cb9a43c6 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\00/\00\00\00c\00\00\00" }>, align 8, !guid !10
@alloc_e2a94c7f70cdaf98936bf1e119b31d15 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\00/\00\00\00o\00\00\00" }>, align 8, !guid !11
@alloc_a9a7dce65c6d1c57d540b735479f6251 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\002\00\00\00q\00\00\00" }>, align 8, !guid !12
@alloc_fee2473f5ebd52e53d5ac249e1622a16 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\003\00\00\00\18\00\00\00" }>, align 8, !guid !13
@alloc_e606c281df34283ee24a24505deb5779 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\004\00\00\00!\00\00\00" }>, align 8, !guid !14
@alloc_33f467d265e61babc7c5951f1b7a303c = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\005\00\00\00\05\00\00\00" }>, align 8, !guid !15
@alloc_c14e8c434fcc3b92ba63da8be42f0c60 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\009\00\00\00\05\00\00\00" }>, align 8, !guid !16
@alloc_ea7a11d758a5a3d2649481fea54771bb = private unnamed_addr constant [14 x i8] c"\02n=\C0\05 sum=\C0\01\0A\00", align 1, !guid !17
@alloc_62b520d5cd86147517119ea4db494764 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\004\00\00\00\12\00\00\00" }>, align 8, !guid !18
@alloc_5563914751c9051696d34dc682afe217 = private unnamed_addr constant [54 x i8] c"\07passed \C0+ cases per implementation, all 256 needles\0A\00", align 1, !guid !19
@alloc_018282178791e8a09b18fbb1ed888779 = private unnamed_addr constant [16 x i8] c"\01\00\00\00\00\00\00\00\01\00\00\00\00\00\00\00", align 8, !guid !20
@alloc_9a88f186c58a52ebd3ead6ae60a6ebb4 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\00&\00\00\00\19\00\00\00" }>, align 8, !guid !21
@alloc_7e7ae35d6636461e2066d261a89d0d5e = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\00&\00\00\00@\00\00\00" }>, align 8, !guid !22
@alloc_f6eff4434d88d939ba74cb3c7aa163d7 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\00!\00\00\00\19\00\00\00" }>, align 8, !guid !23
@alloc_5cb5418a67bcd818f2b2b52e16b6c0ca = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\00!\00\00\00B\00\00\00" }>, align 8, !guid !24
@alloc_63fa703696994748cc44a0c124173934 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\00\1D\00\00\009\00\00\00" }>, align 8, !guid !25
@alloc_9e293b1cd83d8f2c3d64145f659adffa = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\00\1D\00\00\00\15\00\00\00" }>, align 8, !guid !26
@alloc_f2adc74b1f56daa88b0b65f22487c555 = private unnamed_addr constant <{ ptr, [16 x i8] }> <{ ptr @alloc_b2b1f45faefdb6cfee69b54794ef8140, [16 x i8] c"(\00\00\00\00\00\00\00\1C\00\00\00$\00\00\00" }>, align 8, !guid !27
@vtable.1 = private unnamed_addr constant <{ [24 x i8], ptr }> <{ [24 x i8] c"\00\00\00\00\00\00\00\00\01\00\00\00\00\00\00\00\01\00\00\00\00\00\00\00", ptr @_RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt }>, align 8, !guid !28
@alloc_00ae4b301f7fab8ac9617c03fcbd7274 = private unnamed_addr constant [43 x i8] c"called `Result::unwrap()` on an `Err` value", align 1, !guid !29
@vtable.2 = private unnamed_addr constant <{ [24 x i8], ptr }> <{ [24 x i8] c"\00\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver }>, align 8, !guid !30
@alloc_f62df14955f7d78bca139b0a7668683d = private unnamed_addr constant [13 x i8] c"ParseIntError", align 1, !guid !31
@alloc_a5d866b1768ad3f826bccdb004a1a8ae = private unnamed_addr constant [4 x i8] c"kind", align 1, !guid !32
@alloc_59ba7b9f7211443cd55a366616eef46a = private unnamed_addr constant [5 x i8] c"Empty", align 1, !guid !33
@alloc_00315c78e51d29fe6b3102a4c1ecf6ef = private unnamed_addr constant [12 x i8] c"InvalidDigit", align 1, !guid !34
@alloc_bd3a3f3879e0d5f64554753e977f58d4 = private unnamed_addr constant [11 x i8] c"PosOverflow", align 1, !guid !35
@alloc_0964bb2a4870637395c77a018495bd5c = private unnamed_addr constant [11 x i8] c"NegOverflow", align 1, !guid !36
@alloc_6566120a3a17f930e960a0863fcbd591 = private unnamed_addr constant [4 x i8] c"Zero", align 1, !guid !37
@alloc_6c17bac0c71cba42380f8445f4dcbd16 = private unnamed_addr constant [14 x i8] c"NotAPowerOfTwo", align 1, !guid !38
@switch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver = private unnamed_addr constant [6 x i8] c"\05\0C\0B\0B\04\0E", align 8, !guid !39
@switch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.36.rel = private unnamed_addr constant [6 x i32] [i32 trunc (i64 sub (i64 ptrtoint (ptr @alloc_59ba7b9f7211443cd55a366616eef46a to i64), i64 ptrtoint (ptr @switch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.36.rel to i64)) to i32), i32 trunc (i64 sub (i64 ptrtoint (ptr @alloc_00315c78e51d29fe6b3102a4c1ecf6ef to i64), i64 ptrtoint (ptr @switch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.36.rel to i64)) to i32), i32 trunc (i64 sub (i64 ptrtoint (ptr @alloc_bd3a3f3879e0d5f64554753e977f58d4 to i64), i64 ptrtoint (ptr @switch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.36.rel to i64)) to i32), i32 trunc (i64 sub (i64 ptrtoint (ptr @alloc_0964bb2a4870637395c77a018495bd5c to i64), i64 ptrtoint (ptr @switch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.36.rel to i64)) to i32), i32 trunc (i64 sub (i64 ptrtoint (ptr @alloc_6566120a3a17f930e960a0863fcbd591 to i64), i64 ptrtoint (ptr @switch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.36.rel to i64)) to i32), i32 trunc (i64 sub (i64 ptrtoint (ptr @alloc_6c17bac0c71cba42380f8445f4dcbd16 to i64), i64 ptrtoint (ptr @switch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.36.rel to i64)) to i32)], align 4, !guid !40

; std::rt::lang_start::<()>
; Function Attrs: nonlazybind uwtable
define hidden noundef i64 @_RINvNtCs341anU20NIK_3std2rt10lang_startuECs1StpruGFt5h_6driver(ptr noundef nonnull %main, i64 noundef %argc, ptr noundef %argv, i8 noundef %sigpipe) unnamed_addr #0 !guid !46 {
start:
  %_7 = alloca [8 x i8], align 8
  call void @llvm.lifetime.start.p0(ptr nonnull %_7)
  store ptr %main, ptr %_7, align 8
; call std::rt::lang_start_internal
  %_0 = call noundef i64 @_RNvNtCs341anU20NIK_3std2rt19lang_start_internal(ptr noundef nonnull %_7, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(48) @vtable.0, i64 noundef %argc, ptr noundef %argv, i8 noundef %sigpipe)
  call void @llvm.lifetime.end.p0(ptr nonnull %_7)
  ret i64 %_0
}

; core::ptr::drop_glue::<alloc::vec::Vec<alloc::string::String>>
; Function Attrs: nounwind nonlazybind uwtable
define internal fastcc void @_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver(ptr noalias nofree noundef nonnull readonly align 8 captures(none) dereferenceable(24) %_1) unnamed_addr #1 personality ptr @rust_eh_personality !guid !47 {
start:
  %0 = getelementptr inbounds nuw i8, ptr %_1, i64 8
  %_1.val = load ptr, ptr %0, align 8, !nonnull !48, !noundef !48
  %1 = getelementptr inbounds nuw i8, ptr %_1, i64 16
  %_1.val1 = load i64, ptr %1, align 8, !noundef !48
  tail call void @llvm.experimental.noalias.scope.decl(metadata !49)
  %_710.i.i = icmp eq i64 %_1.val1, 0
  br i1 %_710.i.i, label %bb4, label %bb5.i.i

bb5.i.i:                                          ; preds = %start, %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver.exit.i.i
  %_3.sroa.0.011.i.i = phi i64 [ %2, %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver.exit.i.i ], [ 0, %start ]
  %_6.i.i = getelementptr inbounds nuw [24 x i8], ptr %_1.val, i64 %_3.sroa.0.011.i.i
  %2 = add nuw nsw i64 %_3.sroa.0.011.i.i, 1
  %_6.val.i.i = load i64, ptr %_6.i.i, align 8, !alias.scope !49
  %3 = icmp eq i64 %_6.val.i.i, 0
  br i1 %3, label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver.exit.i.i, label %bb2.i.i.i4.i.i.i.i

bb2.i.i.i4.i.i.i.i:                               ; preds = %bb5.i.i
  %4 = getelementptr i8, ptr %_6.i.i, i64 8
  %_6.val7.i.i = load ptr, ptr %4, align 8, !alias.scope !49, !nonnull !48, !noundef !48
; call __rustc::__rust_dealloc
  tail call void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr noundef nonnull %_6.val7.i.i, i64 noundef %_6.val.i.i, i64 noundef range(i64 1, -9223372036854775807) 1) #21, !noalias !49
  br label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver.exit.i.i

_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver.exit.i.i: ; preds = %bb2.i.i.i4.i.i.i.i, %bb5.i.i
  %_7.i.i = icmp eq i64 %2, %_1.val1
  br i1 %_7.i.i, label %bb4, label %bb5.i.i

bb4:                                              ; preds = %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver.exit.i.i, %start
  %_1.val4 = load i64, ptr %_1, align 8, !range !52, !noundef !48
  %5 = icmp eq i64 %_1.val4, 0
  br i1 %5, label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc7raw_vec6RawVecNtNtBG_6string6StringEECs1StpruGFt5h_6driver.exit8, label %bb2.i.i.i6

bb2.i.i.i6:                                       ; preds = %bb4
  %alloc_size.i.i.i.i7 = mul nuw i64 %_1.val4, 24
; call __rustc::__rust_dealloc
  tail call void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr noundef nonnull %_1.val, i64 noundef %alloc_size.i.i.i.i7, i64 noundef range(i64 1, -9223372036854775807) 8) #21
  br label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc7raw_vec6RawVecNtNtBG_6string6StringEECs1StpruGFt5h_6driver.exit8

_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc7raw_vec6RawVecNtNtBG_6string6StringEECs1StpruGFt5h_6driver.exit8: ; preds = %bb4, %bb2.i.i.i6
  ret void
}

; core::ptr::drop_glue::<std::env::Args>
; Function Attrs: nounwind nonlazybind uwtable
define internal fastcc void @_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECs1StpruGFt5h_6driver(ptr noalias nofree noundef nonnull readonly align 8 captures(none) dereferenceable(32) %_1) unnamed_addr #1 personality ptr @rust_eh_personality !guid !53 {
start:
  tail call void @llvm.experimental.noalias.scope.decl(metadata !54)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !57)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !60)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !63)
  %0 = getelementptr inbounds nuw i8, ptr %_1, i64 8
  %self.val.i.i.i.i = load ptr, ptr %0, align 8, !alias.scope !66, !nonnull !48, !noundef !48
  %1 = getelementptr inbounds nuw i8, ptr %_1, i64 24
  %self.val1.i.i.i.i = load ptr, ptr %1, align 8, !alias.scope !66, !nonnull !48, !noundef !48
  %2 = ptrtoint ptr %self.val1.i.i.i.i to i64
  %3 = ptrtoint ptr %self.val.i.i.i.i to i64
  %4 = sub nuw i64 %2, %3
  %5 = udiv exact i64 %4, 24
  tail call void @llvm.experimental.noalias.scope.decl(metadata !67)
  %_710.i.i.i.i.i = icmp eq ptr %self.val1.i.i.i.i, %self.val.i.i.i.i
  br i1 %_710.i.i.i.i.i, label %bb5.i.i.i.i, label %bb5.i.i.i.i.i

bb5.i.i.i.i.i:                                    ; preds = %start, %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i
  %_3.sroa.0.011.i.i.i.i.i = phi i64 [ %6, %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i ], [ 0, %start ]
  %_6.i.i.i.i.i = getelementptr inbounds nuw [24 x i8], ptr %self.val.i.i.i.i, i64 %_3.sroa.0.011.i.i.i.i.i
  %6 = add nuw nsw i64 %_3.sroa.0.011.i.i.i.i.i, 1
  %_6.val.i.i.i.i.i = load i64, ptr %_6.i.i.i.i.i, align 8, !alias.scope !67, !noalias !66
  %7 = icmp eq i64 %_6.val.i.i.i.i.i, 0
  br i1 %7, label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i, label %bb2.i.i.i4.i.i.i.i.i.i.i.i

bb2.i.i.i4.i.i.i.i.i.i.i.i:                       ; preds = %bb5.i.i.i.i.i
  %8 = getelementptr i8, ptr %_6.i.i.i.i.i, i64 8
  %_6.val7.i.i.i.i.i = load ptr, ptr %8, align 8, !alias.scope !67, !noalias !66, !nonnull !48, !noundef !48
; call __rustc::__rust_dealloc
  tail call void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr noundef nonnull %_6.val7.i.i.i.i.i, i64 noundef %_6.val.i.i.i.i.i, i64 noundef range(i64 1, -9223372036854775807) 1) #21, !noalias !70
  br label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i

_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i: ; preds = %bb2.i.i.i4.i.i.i.i.i.i.i.i, %bb5.i.i.i.i.i
  %_7.i.i.i.i.i = icmp eq i64 %6, %5
  br i1 %_7.i.i.i.i.i, label %bb5.i.i.i.i, label %bb5.i.i.i.i.i

bb5.i.i.i.i:                                      ; preds = %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i, %start
  %9 = getelementptr inbounds nuw i8, ptr %_1, i64 16
  %capacity2.i.i3.i.i.i.i = load i64, ptr %9, align 8, !alias.scope !66, !noundef !48
  %10 = icmp eq i64 %capacity2.i.i3.i.i.i.i, 0
  br i1 %10, label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env6ArgsOsECs1StpruGFt5h_6driver.exit, label %bb2.i.i.i.i.i4.i.i.i.i

bb2.i.i.i.i.i4.i.i.i.i:                           ; preds = %bb5.i.i.i.i
  %ptr.i.i5.i.i.i.i = load ptr, ptr %_1, align 8, !alias.scope !66, !nonnull !48, !noundef !48
  %alloc_size.i.i.i.i.i.i6.i.i.i.i = mul nuw i64 %capacity2.i.i3.i.i.i.i, 24
; call __rustc::__rust_dealloc
  tail call void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr noundef nonnull %ptr.i.i5.i.i.i.i, i64 noundef %alloc_size.i.i.i.i.i.i6.i.i.i.i, i64 noundef range(i64 1, -9223372036854775807) 8) #21, !noalias !66
  br label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env6ArgsOsECs1StpruGFt5h_6driver.exit

_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env6ArgsOsECs1StpruGFt5h_6driver.exit: ; preds = %bb5.i.i.i.i, %bb2.i.i.i.i.i4.i.i.i.i
  ret void
}

; std::sys::backtrace::__rust_begin_short_backtrace::<fn(), ()>
; Function Attrs: noinline nonlazybind uwtable
define internal fastcc void @_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs1StpruGFt5h_6driver(ptr nofree noundef nonnull readonly captures(none) %f) unnamed_addr #2 !guid !71 {
start:
  tail call void %f(), !inline_history !72
  tail call void asm sideeffect "", "~{memory}"() #21, !srcloc !73
  ret void
}

; <alloc::raw_vec::RawVecInner<_>>::reserve::do_reserve_and_handle::<alloc::alloc::Global>
; Function Attrs: cold nonlazybind uwtable
define internal fastcc void @_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs1StpruGFt5h_6driver(ptr noalias nofree noundef nonnull align 8 captures(none) dereferenceable(16) %slf, i64 noundef %len, i64 noundef range(i64 1, 0) %additional) unnamed_addr #3 personality ptr @rust_eh_personality !guid !74 {
start:
  %self3.i = alloca [24 x i8], align 8
  tail call void @llvm.experimental.noalias.scope.decl(metadata !75)
  %_25.0.i = add i64 %additional, %len
  %_25.1.i = icmp ult i64 %_25.0.i, %len
  br i1 %_25.1.i, label %bb2, label %bb9.i

bb9.i:                                            ; preds = %start
  %self5.i = load i64, ptr %slf, align 8, !range !52, !alias.scope !75, !noundef !48
  %v16.i = shl nuw i64 %self5.i, 1
  %..i.i = tail call noundef i64 @llvm.umax.i64(i64 %_25.0.i, i64 range(i64 0, -1) %v16.i)
  %..i16.i = tail call noundef i64 @llvm.umax.i64(i64 %..i.i, i64 4)
  call void @llvm.lifetime.start.p0(ptr nonnull %self3.i), !noalias !75
  %0 = getelementptr inbounds nuw i8, ptr %slf, i64 8
  %self.val15.i = load ptr, ptr %0, align 8, !alias.scope !75
; call <alloc::raw_vec::RawVecInner>::finish_grow
  call fastcc void @_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs1StpruGFt5h_6driver(ptr noalias nofree noundef align 8 captures(none) dereferenceable(24) %self3.i, i64 %self5.i, ptr %self.val15.i, i64 noundef %..i16.i)
  %_37.i = load i64, ptr %self3.i, align 8, !range !78, !noalias !75, !noundef !48
  %1 = trunc nuw i64 %_37.i to i1
  %2 = getelementptr inbounds nuw i8, ptr %self3.i, i64 8
  br i1 %1, label %bb18.i, label %bb3

bb18.i:                                           ; preds = %bb9.i
  %e.0.i = load i64, ptr %2, align 8, !range !79, !noalias !75, !noundef !48
  %3 = getelementptr inbounds nuw i8, ptr %self3.i, i64 16
  %e.1.i = load i64, ptr %3, align 8, !noalias !75
  call void @llvm.lifetime.end.p0(ptr nonnull %self3.i), !noalias !75
  br label %bb2

bb2:                                              ; preds = %bb18.i, %start
  %_0.sroa.5.0.i.ph = phi i64 [ undef, %start ], [ %e.1.i, %bb18.i ]
  %_0.sroa.0.0.i.ph = phi i64 [ 0, %start ], [ %e.0.i, %bb18.i ]
; call alloc::raw_vec::handle_error
  tail call void @_RNvNtCs3v2GDSbr0UZ_5alloc7raw_vec12handle_error(i64 noundef %_0.sroa.0.0.i.ph, i64 %_0.sroa.5.0.i.ph) #22
  unreachable

bb3:                                              ; preds = %bb9.i
  %v.0.i = load ptr, ptr %2, align 8, !noalias !75, !nonnull !48, !noundef !48
  call void @llvm.lifetime.end.p0(ptr nonnull %self3.i), !noalias !75
  store ptr %v.0.i, ptr %0, align 8, !alias.scope !75
  %4 = icmp sgt i64 %..i16.i, -1
  tail call void @llvm.assume(i1 %4)
  store i64 %..i16.i, ptr %slf, align 8, !alias.scope !75
  ret void
}

; std::rt::lang_start::<()>::{closure#0}
; Function Attrs: inlinehint nonlazybind uwtable
define internal noundef i32 @_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cs1StpruGFt5h_6driver(ptr noalias nofree noundef readonly align 8 captures(none) dereferenceable(8) %_1) unnamed_addr #4 !guid !80 {
start:
  %_4 = load ptr, ptr %_1, align 8, !nonnull !48, !noundef !48
; call std::sys::backtrace::__rust_begin_short_backtrace::<fn(), ()>
  tail call fastcc void @_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs1StpruGFt5h_6driver(ptr noundef nonnull %_4) #23
  ret i32 0
}

; <std::rt::lang_start<()>::{closure#0} as core::ops::function::FnOnce<()>>::call_once::{shim:vtable#0}
; Function Attrs: inlinehint nonlazybind uwtable
define internal noundef i32 @_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCs1StpruGFt5h_6driver(ptr nofree noundef readonly captures(none) %_1) unnamed_addr #4 personality ptr @rust_eh_personality !guid !81 {
start:
  %0 = load ptr, ptr %_1, align 8, !nonnull !48, !noundef !48
; call std::sys::backtrace::__rust_begin_short_backtrace::<fn(), ()>
  tail call fastcc void @_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs1StpruGFt5h_6driver(ptr noundef nonnull readonly %0) #23, !noalias !82
  ret i32 0
}

; driver::crate_find
; Function Attrs: nonlazybind uwtable
define internal { i64, i64 } @_RNvCs1StpruGFt5h_6driver10crate_find(i8 noundef %x, ptr noalias nofree noundef nonnull readonly captures(address, read_provenance) %s.0, i64 noundef range(i64 0, -9223372036854775808) %s.1) unnamed_addr #0 personality ptr @rust_eh_personality !guid !85 {
start:
  %end.i = getelementptr inbounds nuw i8, ptr %s.0, i64 %s.1
  %0 = load atomic ptr, ptr @_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw2FN monotonic, align 8, !noalias !86, !nonnull !48, !noundef !48
  %1 = tail call { i64, ptr } %0(i8 noundef %x, ptr noundef nonnull readonly %s.0, ptr noundef nonnull readonly %end.i), !noalias !86, !inline_history !89
  %2 = extractvalue { i64, ptr } %1, 0
  %3 = trunc nuw i64 %2 to i1
  br i1 %3, label %bb8.i, label %_RINvNtNtNtCs8jZOguSIGf0_6memchr4arch7generic6memchr21search_slice_with_rawNCNvNtB8_6memchr6memchr0ECs1StpruGFt5h_6driver.exit

bb8.i:                                            ; preds = %start
  %4 = extractvalue { i64, ptr } %1, 1
  %5 = ptrtoint ptr %4 to i64
  %6 = ptrtoint ptr %s.0 to i64
  %7 = sub i64 %5, %6
  %_13.not.i = icmp ult i64 %7, %s.1
  tail call void @llvm.assume(i1 %_13.not.i)
  br label %_RINvNtNtNtCs8jZOguSIGf0_6memchr4arch7generic6memchr21search_slice_with_rawNCNvNtB8_6memchr6memchr0ECs1StpruGFt5h_6driver.exit

_RINvNtNtNtCs8jZOguSIGf0_6memchr4arch7generic6memchr21search_slice_with_rawNCNvNtB8_6memchr6memchr0ECs1StpruGFt5h_6driver.exit: ; preds = %start, %bb8.i
  %_0.sroa.3.0.i = phi i64 [ %7, %bb8.i ], [ undef, %start ]
  %_0.sroa.0.0.i = phi i64 [ 1, %bb8.i ], [ 0, %start ]
  %8 = insertvalue { i64, i64 } poison, i64 %_0.sroa.0.0.i, 0
  %9 = insertvalue { i64, i64 } %8, i64 %_0.sroa.3.0.i, 1
  ret { i64, i64 } %9
}

; driver::main
; Function Attrs: nonlazybind uwtable
define hidden void @_RNvCs1StpruGFt5h_6driver4main() unnamed_addr #0 personality ptr @rust_eh_personality !guid !90 {
start:
  %_3.i.i.i = alloca [24 x i8], align 8
  %_19.i = alloca [32 x i8], align 8
  %_3.i = alloca [24 x i8], align 8
  %vector.i = alloca [24 x i8], align 8
  %e.i62 = alloca [1 x i8], align 1
  %e.i57 = alloca [1 x i8], align 1
  %e.i = alloca [1 x i8], align 1
  %args5 = alloca [32 x i8], align 8
  %_138 = alloca [8 x i8], align 8
  %_135 = alloca [16 x i8], align 8
  %_134 = alloca [1 x i8], align 1
  %_132 = alloca [16 x i8], align 8
  %sum = alloca [8 x i8], align 8
  %_127 = alloca [16 x i8], align 8
  %_126 = alloca [1 x i8], align 1
  %_124 = alloca [16 x i8], align 8
  %_120 = alloca [16 x i8], align 8
  %_113 = alloca [8 x i8], align 8
  %pos = alloca [16 x i8], align 8
  %n = alloca [8 x i8], align 8
  %off = alloca [8 x i8], align 8
  %f = alloca [8 x i8], align 8
  %args3 = alloca [16 x i8], align 8
  %_63 = alloca [16 x i8], align 8
  %_58 = alloca [16 x i8], align 8
  %_51 = alloca [16 x i8], align 8
  %_48 = alloca [16 x i8], align 8
  %_44 = alloca [16 x i8], align 8
  %_41 = alloca [16 x i8], align 8
  %_28 = alloca [16 x i8], align 8
  %_24 = alloca [16 x i8], align 8
  %iter1 = alloca [184 x i8], align 8
  %count = alloca [8 x i8], align 8
  %_2 = alloca [32 x i8], align 8
  %args = alloca [24 x i8], align 8
  call void @llvm.lifetime.start.p0(ptr nonnull %args)
  call void @llvm.lifetime.start.p0(ptr nonnull %_2)
; call std::env::args
  call void @_RNvNtCs341anU20NIK_3std3env4args(ptr noalias nofree noundef nonnull sret([32 x i8]) align 8 captures(none) dereferenceable(32) %_2)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !91)
  tail call void @llvm.experimental.noalias.scope.decl(metadata !94)
  call void @llvm.lifetime.start.p0(ptr nonnull %vector.i), !noalias !96
  call void @llvm.lifetime.start.p0(ptr nonnull %_3.i), !noalias !96
; invoke <std::env::Args as core::iter::traits::iterator::Iterator>::next
  invoke void @_RNvXsc_NtCs341anU20NIK_3std3envNtB5_4ArgsNtNtNtNtCsc9NCSoc2doQ_4core4iter6traits8iterator8Iterator4next(ptr noalias nofree noundef nonnull sret([24 x i8]) align 8 captures(none) dereferenceable(24) %_3.i, ptr noalias nofree noundef nonnull align 8 dereferenceable(32) %_2)
          to label %bb1.i unwind label %cleanup.i, !noalias !91

cleanup.i:                                        ; preds = %start
  %0 = landingpad { ptr, i32 }
          cleanup
  br label %bb10.i

bb1.i:                                            ; preds = %start
  %1 = load i64, ptr %_3.i, align 8, !range !97, !noalias !96, !noundef !48
  %.not.i = icmp eq i64 %1, -1
  br i1 %.not.i, label %bb12.i, label %bb14.i

bb12.i:                                           ; preds = %bb1.i
  store i64 0, ptr %args, align 8, !alias.scope !91, !noalias !94
  %2 = getelementptr inbounds nuw i8, ptr %args, i64 8
  store ptr inttoptr (i64 8 to ptr), ptr %2, align 8, !alias.scope !91, !noalias !94
  %3 = getelementptr inbounds nuw i8, ptr %args, i64 16
  store i64 0, ptr %3, align 8, !alias.scope !91, !noalias !94
  call void @llvm.lifetime.end.p0(ptr nonnull %_3.i), !noalias !96
  call void @llvm.lifetime.end.p0(ptr nonnull %vector.i), !noalias !96
  call void @llvm.experimental.noalias.scope.decl(metadata !98)
  call void @llvm.experimental.noalias.scope.decl(metadata !101)
  call void @llvm.experimental.noalias.scope.decl(metadata !104)
  call void @llvm.experimental.noalias.scope.decl(metadata !107)
  call void @llvm.experimental.noalias.scope.decl(metadata !110)
  %4 = getelementptr inbounds nuw i8, ptr %_2, i64 8
  %self.val.i.i.i.i.i.i = load ptr, ptr %4, align 8, !alias.scope !113, !noalias !91, !nonnull !48, !noundef !48
  %5 = getelementptr inbounds nuw i8, ptr %_2, i64 24
  %self.val1.i.i.i.i.i.i = load ptr, ptr %5, align 8, !alias.scope !113, !noalias !91, !nonnull !48, !noundef !48
  %6 = ptrtoint ptr %self.val1.i.i.i.i.i.i to i64
  %7 = ptrtoint ptr %self.val.i.i.i.i.i.i to i64
  %8 = sub nuw i64 %6, %7
  %9 = udiv exact i64 %8, 24
  call void @llvm.experimental.noalias.scope.decl(metadata !114)
  %_710.i.i.i.i.i.i.i = icmp eq ptr %self.val1.i.i.i.i.i.i, %self.val.i.i.i.i.i.i
  br i1 %_710.i.i.i.i.i.i.i, label %bb5.i.i.i.i.i.i, label %bb5.i.i.i.i.i.i.i

bb5.i.i.i.i.i.i.i:                                ; preds = %bb12.i, %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i.i.i
  %_3.sroa.0.011.i.i.i.i.i.i.i = phi i64 [ %10, %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i.i.i ], [ 0, %bb12.i ]
  %_6.i.i.i.i.i.i.i = getelementptr inbounds nuw [24 x i8], ptr %self.val.i.i.i.i.i.i, i64 %_3.sroa.0.011.i.i.i.i.i.i.i
  %10 = add nuw nsw i64 %_3.sroa.0.011.i.i.i.i.i.i.i, 1
  %_6.val.i.i.i.i.i.i.i = load i64, ptr %_6.i.i.i.i.i.i.i, align 8, !alias.scope !114, !noalias !117
  %11 = icmp eq i64 %_6.val.i.i.i.i.i.i.i, 0
  br i1 %11, label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i.i.i, label %bb2.i.i.i4.i.i.i.i.i.i.i.i.i.i

bb2.i.i.i4.i.i.i.i.i.i.i.i.i.i:                   ; preds = %bb5.i.i.i.i.i.i.i
  %12 = getelementptr i8, ptr %_6.i.i.i.i.i.i.i, i64 8
  %_6.val7.i.i.i.i.i.i.i = load ptr, ptr %12, align 8, !alias.scope !114, !noalias !117, !nonnull !48, !noundef !48
; call __rustc::__rust_dealloc
  call void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr noundef nonnull %_6.val7.i.i.i.i.i.i.i, i64 noundef %_6.val.i.i.i.i.i.i.i, i64 noundef range(i64 1, -9223372036854775807) 1) #21, !noalias !118
  br label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i.i.i

_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i.i.i: ; preds = %bb2.i.i.i4.i.i.i.i.i.i.i.i.i.i, %bb5.i.i.i.i.i.i.i
  %_7.i.i.i.i.i.i.i = icmp eq i64 %10, %9
  br i1 %_7.i.i.i.i.i.i.i, label %bb5.i.i.i.i.i.i, label %bb5.i.i.i.i.i.i.i

bb5.i.i.i.i.i.i:                                  ; preds = %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i.i.i, %bb12.i
  %13 = getelementptr inbounds nuw i8, ptr %_2, i64 16
  %capacity2.i.i3.i.i.i.i.i.i = load i64, ptr %13, align 8, !alias.scope !113, !noalias !91, !noundef !48
  %14 = icmp eq i64 %capacity2.i.i3.i.i.i.i.i.i, 0
  br i1 %14, label %_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec21spec_from_iter_nestedINtB4_3VecNtNtB6_6string6StringEINtB2_18SpecFromIterNestedB11_NtNtCs341anU20NIK_3std3env4ArgsE9from_iterCs1StpruGFt5h_6driver.exit.thread, label %bb2.i.i.i.i.i4.i.i.i.i.i.i

bb2.i.i.i.i.i4.i.i.i.i.i.i:                       ; preds = %bb5.i.i.i.i.i.i
  %ptr.i.i5.i.i.i.i.i.i = load ptr, ptr %_2, align 8, !alias.scope !113, !noalias !91, !nonnull !48, !noundef !48
  %alloc_size.i.i.i.i.i.i6.i.i.i.i.i.i = mul nuw i64 %capacity2.i.i3.i.i.i.i.i.i, 24
; call __rustc::__rust_dealloc
  call void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr noundef nonnull %ptr.i.i5.i.i.i.i.i.i, i64 noundef %alloc_size.i.i.i.i.i.i6.i.i.i.i.i.i, i64 noundef range(i64 1, -9223372036854775807) 8) #21, !noalias !117
  br label %_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec21spec_from_iter_nestedINtB4_3VecNtNtB6_6string6StringEINtB2_18SpecFromIterNestedB11_NtNtCs341anU20NIK_3std3env4ArgsE9from_iterCs1StpruGFt5h_6driver.exit.thread

cleanup2.i:                                       ; preds = %bb3.i.i
  %15 = landingpad { ptr, i32 }
          cleanup
  %16 = icmp eq i64 %1, 0
  br i1 %16, label %bb10.i, label %bb2.i.i.i4.i.i.i

bb2.i.i.i4.i.i.i:                                 ; preds = %cleanup2.i
  call void @llvm.assume(i1 true) [ "nonnull"(ptr %element.sroa.5.0.copyload.i) ]
; call __rustc::__rust_dealloc
  call void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr noundef nonnull %element.sroa.5.0.copyload.i, i64 noundef %1, i64 noundef range(i64 1, -9223372036854775807) 1) #21, !noalias !91
  br label %bb10.i

bb14.i:                                           ; preds = %bb1.i
  %element.sroa.5.0._3.sroa_idx.i = getelementptr inbounds nuw i8, ptr %_3.i, i64 8
  %element.sroa.5.0.copyload.i = load ptr, ptr %element.sroa.5.0._3.sroa_idx.i, align 8, !noalias !96
  %element.sroa.6.0._3.sroa_idx.i = getelementptr inbounds nuw i8, ptr %_3.i, i64 16
  %element.sroa.6.0.copyload.i = load i64, ptr %element.sroa.6.0._3.sroa_idx.i, align 8, !noalias !96
  %17 = getelementptr inbounds nuw i8, ptr %_2, i64 8
  %iterator.val.i = load ptr, ptr %17, align 8, !alias.scope !94, !noalias !91, !nonnull !48, !noundef !48
  %18 = getelementptr inbounds nuw i8, ptr %_2, i64 24
  %iterator.val5.i = load ptr, ptr %18, align 8, !alias.scope !94, !noalias !91, !nonnull !48, !noundef !48
  %19 = ptrtoint ptr %iterator.val5.i to i64
  %20 = ptrtoint ptr %iterator.val.i to i64
  %21 = sub nuw i64 %19, %20
  %22 = udiv exact i64 %21, 24
  %23 = call i64 @llvm.umax.i64(i64 %22, i64 3)
  %..i.i = add nuw nsw i64 %23, 1
  %_34.0.i.i.i = mul i64 %..i.i, 24
  %or.cond.i.i.i = icmp ugt i64 %21, 9223372036854775776
  br i1 %or.cond.i.i.i, label %bb3.i.i, label %bb18.i.i.i, !prof !119

bb18.i.i.i:                                       ; preds = %bb14.i
  %24 = icmp eq i64 %_34.0.i.i.i, 0
  br i1 %24, label %bb15.i, label %bb3.i.i.i

bb3.i.i.i:                                        ; preds = %bb18.i.i.i
; call __rustc::__rust_no_alloc_shim_is_unstable_v2
  call void @_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2() #21, !noalias !120
; call __rustc::__rust_alloc
  %25 = call noundef align 8 ptr @_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc(i64 noundef range(i64 0, -9223372036854775808) %_34.0.i.i.i, i64 noundef range(i64 1, 9) 8) #21, !noalias !120
  %26 = icmp eq ptr %25, null
  br i1 %26, label %bb3.i.i, label %bb15.i

bb3.i.i:                                          ; preds = %bb3.i.i.i, %bb14.i
  %_4.sroa.4.0.ph.i.i = phi i64 [ 8, %bb3.i.i.i ], [ 0, %bb14.i ]
  %_4.sroa.10.0.ph.i.i = phi i64 [ %_34.0.i.i.i, %bb3.i.i.i ], [ undef, %bb14.i ]
; invoke alloc::raw_vec::handle_error
  invoke void @_RNvNtCs3v2GDSbr0UZ_5alloc7raw_vec12handle_error(i64 noundef %_4.sroa.4.0.ph.i.i, i64 %_4.sroa.10.0.ph.i.i) #22
          to label %.noexc.i unwind label %cleanup2.i, !noalias !91

.noexc.i:                                         ; preds = %bb3.i.i
  unreachable

bb15.i:                                           ; preds = %bb3.i.i.i, %bb18.i.i.i
  %_4.sroa.4.0.i.i = phi i64 [ 0, %bb18.i.i.i ], [ %..i.i, %bb3.i.i.i ]
  %_4.sroa.10.0.i.i = phi ptr [ inttoptr (i64 8 to ptr), %bb18.i.i.i ], [ %25, %bb3.i.i.i ]
  %_7.i.i = icmp samesign ult i64 %23, %_4.sroa.4.0.i.i
  call void @llvm.assume(i1 %_7.i.i)
  store i64 %1, ptr %_4.sroa.10.0.i.i, align 8, !noalias !91
  %src.sroa.4.0._26.1.sroa_idx.i = getelementptr inbounds nuw i8, ptr %_4.sroa.10.0.i.i, i64 8
  store ptr %element.sroa.5.0.copyload.i, ptr %src.sroa.4.0._26.1.sroa_idx.i, align 8, !noalias !91
  %src.sroa.5.0._26.1.sroa_idx.i = getelementptr inbounds nuw i8, ptr %_4.sroa.10.0.i.i, i64 16
  store i64 %element.sroa.6.0.copyload.i, ptr %src.sroa.5.0._26.1.sroa_idx.i, align 8, !noalias !91
  store i64 %_4.sroa.4.0.i.i, ptr %vector.i, align 8, !noalias !96
  %vector1.sroa.4.0.vector.sroa_idx.i = getelementptr inbounds nuw i8, ptr %vector.i, i64 8
  store ptr %_4.sroa.10.0.i.i, ptr %vector1.sroa.4.0.vector.sroa_idx.i, align 8, !noalias !96
  %vector1.sroa.6.0.vector.sroa_idx.i = getelementptr inbounds nuw i8, ptr %vector.i, i64 16
  store i64 1, ptr %vector1.sroa.6.0.vector.sroa_idx.i, align 8, !noalias !96
  call void @llvm.lifetime.end.p0(ptr nonnull %_3.i), !noalias !96
  call void @llvm.lifetime.start.p0(ptr nonnull %_19.i), !noalias !96
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(32) %_19.i, ptr noundef nonnull align 8 dereferenceable(32) %_2, i64 32, i1 false), !noalias !91
  call void @llvm.experimental.noalias.scope.decl(metadata !123)
  call void @llvm.experimental.noalias.scope.decl(metadata !126)
  call void @llvm.experimental.noalias.scope.decl(metadata !128)
  call void @llvm.experimental.noalias.scope.decl(metadata !131)
  %element.sroa.5.0._3.sroa_idx.i.i.i = getelementptr inbounds nuw i8, ptr %_3.i.i.i, i64 8
  %element.sroa.6.0._3.sroa_idx.i.i.i = getelementptr inbounds nuw i8, ptr %_3.i.i.i, i64 16
  %27 = getelementptr inbounds nuw i8, ptr %_19.i, i64 24
  %28 = getelementptr inbounds nuw i8, ptr %_19.i, i64 8
  br label %bb1.i.i.i

bb1.i.i.i:                                        ; preds = %bb8.i.i.i, %bb15.i
  %_23.i.i20.i = phi ptr [ %_23.i.i.i, %bb8.i.i.i ], [ %_4.sroa.10.0.i.i, %bb15.i ]
  %len.i.i.i = phi i64 [ %new_len.i.i.i, %bb8.i.i.i ], [ 1, %bb15.i ]
  call void @llvm.lifetime.start.p0(ptr nonnull %_3.i.i.i), !noalias !133
; invoke <std::env::Args as core::iter::traits::iterator::Iterator>::next
  invoke void @_RNvXsc_NtCs341anU20NIK_3std3envNtB5_4ArgsNtNtNtNtCsc9NCSoc2doQ_4core4iter6traits8iterator8Iterator4next(ptr noalias nofree noundef nonnull sret([24 x i8]) align 8 captures(none) dereferenceable(24) %_3.i.i.i, ptr noalias nofree noundef nonnull align 8 dereferenceable(32) %_19.i)
          to label %bb2.i.i7.i unwind label %cleanup.i.i.i, !noalias !134

bb11.i.i.i:                                       ; preds = %bb2.i.i.i4.i.i.i.i.i, %cleanup2.i.i.i, %cleanup.i.i.i
  %.pn.i.i.i = phi { ptr, i32 } [ %29, %cleanup.i.i.i ], [ %40, %cleanup2.i.i.i ], [ %40, %bb2.i.i.i4.i.i.i.i.i ]
; call core::ptr::drop_glue::<std::env::Args>
  call fastcc void @_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECs1StpruGFt5h_6driver(ptr noalias nofree noundef nonnull align 8 dereferenceable(32) %_19.i) #24, !noalias !134
; call core::ptr::drop_glue::<alloc::vec::Vec<alloc::string::String>>
  call fastcc void @_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver(ptr noalias nofree noundef align 8 dereferenceable(24) %vector.i) #24, !noalias !91
  br label %common.resume

cleanup.i.i.i:                                    ; preds = %bb1.i.i.i
  %29 = landingpad { ptr, i32 }
          cleanup
  br label %bb11.i.i.i

bb2.i.i7.i:                                       ; preds = %bb1.i.i.i
  %30 = load i64, ptr %_3.i.i.i, align 8, !range !97, !noalias !133, !noundef !48
  %.not.i.i.i = icmp eq i64 %30, -1
  br i1 %.not.i.i.i, label %bb9.i.i.i, label %bb3.i.i8.i

bb3.i.i8.i:                                       ; preds = %bb2.i.i7.i
  %element.sroa.5.0.copyload.i.i.i = load ptr, ptr %element.sroa.5.0._3.sroa_idx.i.i.i, align 8, !noalias !133
  %element.sroa.6.0.copyload.i.i.i = load i64, ptr %element.sroa.6.0._3.sroa_idx.i.i.i, align 8, !noalias !133
  %_19.i.i.i = icmp samesign ult i64 %len.i.i.i, 384307168202282326
  call void @llvm.assume(i1 %_19.i.i.i)
  %self1.i.i.i = load i64, ptr %vector.i, align 8, !range !52, !alias.scope !135, !noalias !136, !noundef !48
  %_8.i.i.i = icmp eq i64 %len.i.i.i, %self1.i.i.i
  br i1 %_8.i.i.i, label %bb1.i.i.i.i, label %bb8.i.i.i

bb9.i.i.i:                                        ; preds = %bb2.i.i7.i
  call void @llvm.lifetime.end.p0(ptr nonnull %_3.i.i.i), !noalias !133
  call void @llvm.experimental.noalias.scope.decl(metadata !137)
  call void @llvm.experimental.noalias.scope.decl(metadata !140)
  call void @llvm.experimental.noalias.scope.decl(metadata !143)
  call void @llvm.experimental.noalias.scope.decl(metadata !146)
  call void @llvm.experimental.noalias.scope.decl(metadata !149)
  %self.val.i.i.i.i.i.i.i.i = load ptr, ptr %28, align 8, !alias.scope !152, !noalias !153, !nonnull !48, !noundef !48
  %self.val1.i.i.i.i.i.i.i.i = load ptr, ptr %27, align 8, !alias.scope !152, !noalias !153, !nonnull !48, !noundef !48
  %31 = ptrtoint ptr %self.val1.i.i.i.i.i.i.i.i to i64
  %32 = ptrtoint ptr %self.val.i.i.i.i.i.i.i.i to i64
  %33 = sub nuw i64 %31, %32
  %34 = udiv exact i64 %33, 24
  call void @llvm.experimental.noalias.scope.decl(metadata !154)
  %_710.i.i.i.i.i.i.i.i.i = icmp eq ptr %self.val1.i.i.i.i.i.i.i.i, %self.val.i.i.i.i.i.i.i.i
  br i1 %_710.i.i.i.i.i.i.i.i.i, label %bb5.i.i.i.i.i.i.i.i, label %bb5.i.i.i.i.i.i.i.i.i

bb5.i.i.i.i.i.i.i.i.i:                            ; preds = %bb9.i.i.i, %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i.i.i.i.i
  %_3.sroa.0.011.i.i.i.i.i.i.i.i.i = phi i64 [ %35, %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i.i.i.i.i ], [ 0, %bb9.i.i.i ]
  %_6.i.i.i.i.i.i.i.i.i = getelementptr inbounds nuw [24 x i8], ptr %self.val.i.i.i.i.i.i.i.i, i64 %_3.sroa.0.011.i.i.i.i.i.i.i.i.i
  %35 = add nuw nsw i64 %_3.sroa.0.011.i.i.i.i.i.i.i.i.i, 1
  %_6.val.i.i.i.i.i.i.i.i.i = load i64, ptr %_6.i.i.i.i.i.i.i.i.i, align 8, !alias.scope !154, !noalias !157
  %36 = icmp eq i64 %_6.val.i.i.i.i.i.i.i.i.i, 0
  br i1 %36, label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i.i.i.i.i, label %bb2.i.i.i4.i.i.i.i.i.i.i.i.i.i.i.i

bb2.i.i.i4.i.i.i.i.i.i.i.i.i.i.i.i:               ; preds = %bb5.i.i.i.i.i.i.i.i.i
  %37 = getelementptr i8, ptr %_6.i.i.i.i.i.i.i.i.i, i64 8
  %_6.val7.i.i.i.i.i.i.i.i.i = load ptr, ptr %37, align 8, !alias.scope !154, !noalias !157, !nonnull !48, !noundef !48
; call __rustc::__rust_dealloc
  call void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr noundef nonnull %_6.val7.i.i.i.i.i.i.i.i.i, i64 noundef %_6.val.i.i.i.i.i.i.i.i.i, i64 noundef range(i64 1, -9223372036854775807) 1) #21, !noalias !158
  br label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i.i.i.i.i

_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i.i.i.i.i: ; preds = %bb2.i.i.i4.i.i.i.i.i.i.i.i.i.i.i.i, %bb5.i.i.i.i.i.i.i.i.i
  %_7.i.i.i.i.i.i.i.i.i = icmp eq i64 %35, %34
  br i1 %_7.i.i.i.i.i.i.i.i.i, label %bb5.i.i.i.i.i.i.i.i, label %bb5.i.i.i.i.i.i.i.i.i

bb5.i.i.i.i.i.i.i.i:                              ; preds = %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i.i.i.i.i, %bb9.i.i.i
  %38 = getelementptr inbounds nuw i8, ptr %_19.i, i64 16
  %capacity2.i.i3.i.i.i.i.i.i.i.i = load i64, ptr %38, align 8, !alias.scope !152, !noalias !153, !noundef !48
  %39 = icmp eq i64 %capacity2.i.i3.i.i.i.i.i.i.i.i, 0
  br i1 %39, label %_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec21spec_from_iter_nestedINtB4_3VecNtNtB6_6string6StringEINtB2_18SpecFromIterNestedB11_NtNtCs341anU20NIK_3std3env4ArgsE9from_iterCs1StpruGFt5h_6driver.exit, label %bb2.i.i.i.i.i4.i.i.i.i.i.i.i.i

bb2.i.i.i.i.i4.i.i.i.i.i.i.i.i:                   ; preds = %bb5.i.i.i.i.i.i.i.i
  %ptr.i.i5.i.i.i.i.i.i.i.i = load ptr, ptr %_19.i, align 8, !alias.scope !152, !noalias !153, !nonnull !48, !noundef !48
  %alloc_size.i.i.i.i.i.i6.i.i.i.i.i.i.i.i = mul nuw i64 %capacity2.i.i3.i.i.i.i.i.i.i.i, 24
; call __rustc::__rust_dealloc
  call void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr noundef nonnull %ptr.i.i5.i.i.i.i.i.i.i.i, i64 noundef %alloc_size.i.i.i.i.i.i6.i.i.i.i.i.i.i.i, i64 noundef range(i64 1, -9223372036854775807) 8) #21, !noalias !157
  br label %_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec21spec_from_iter_nestedINtB4_3VecNtNtB6_6string6StringEINtB2_18SpecFromIterNestedB11_NtNtCs341anU20NIK_3std3env4ArgsE9from_iterCs1StpruGFt5h_6driver.exit

bb8.i.i.i:                                        ; preds = %bb1.i.i.i.bb8.i.i_crit_edge.i, %bb3.i.i8.i
  %_23.i.i.i = phi ptr [ %_23.i.i.pre.i, %bb1.i.i.i.bb8.i.i_crit_edge.i ], [ %_23.i.i20.i, %bb3.i.i8.i ]
  %dst.i.i.i = getelementptr inbounds nuw [24 x i8], ptr %_23.i.i.i, i64 %len.i.i.i
  store i64 %30, ptr %dst.i.i.i, align 8, !noalias !134
  %src.sroa.4.0.dst.sroa_idx.i.i.i = getelementptr inbounds nuw i8, ptr %dst.i.i.i, i64 8
  store ptr %element.sroa.5.0.copyload.i.i.i, ptr %src.sroa.4.0.dst.sroa_idx.i.i.i, align 8, !noalias !134
  %src.sroa.5.0.dst.sroa_idx.i.i.i = getelementptr inbounds nuw i8, ptr %dst.i.i.i, i64 16
  store i64 %element.sroa.6.0.copyload.i.i.i, ptr %src.sroa.5.0.dst.sroa_idx.i.i.i, align 8, !noalias !134
  %new_len.i.i.i = add nuw nsw i64 %len.i.i.i, 1
  store i64 %new_len.i.i.i, ptr %vector1.sroa.6.0.vector.sroa_idx.i, align 8, !alias.scope !135, !noalias !136
  call void @llvm.lifetime.end.p0(ptr nonnull %_3.i.i.i), !noalias !133
  br label %bb1.i.i.i

cleanup2.i.i.i:                                   ; preds = %bb1.i.i.i.i
  %40 = landingpad { ptr, i32 }
          cleanup
  %41 = icmp eq i64 %30, 0
  br i1 %41, label %bb11.i.i.i, label %bb2.i.i.i4.i.i.i.i.i

bb2.i.i.i4.i.i.i.i.i:                             ; preds = %cleanup2.i.i.i
  call void @llvm.assume(i1 true) [ "nonnull"(ptr %element.sroa.5.0.copyload.i.i.i) ]
; call __rustc::__rust_dealloc
  call void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr noundef nonnull %element.sroa.5.0.copyload.i.i.i, i64 noundef %30, i64 noundef range(i64 1, -9223372036854775807) 1) #21, !noalias !134
  br label %bb11.i.i.i

bb1.i.i.i.i:                                      ; preds = %bb3.i.i8.i
  %iterator.val4.i.i.i = load ptr, ptr %27, align 8, !alias.scope !159, !noalias !153, !nonnull !48, !noundef !48
  %42 = ptrtoint ptr %iterator.val4.i.i.i to i64
  %iterator.val.i.i.i = load ptr, ptr %28, align 8, !alias.scope !159, !noalias !153, !nonnull !48, !noundef !48
  %43 = ptrtoint ptr %iterator.val.i.i.i to i64
  %44 = sub nuw i64 %42, %43
  %45 = udiv exact i64 %44, 24
  %_149.i.i.i = add nuw nsw i64 %45, 1
; invoke <alloc::raw_vec::RawVecInner<_>>::reserve::do_reserve_and_handle::<alloc::alloc::Global>
  invoke fastcc void @_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs1StpruGFt5h_6driver(ptr noalias nofree noundef nonnull align 8 dereferenceable(24) %vector.i, i64 noundef %len.i.i.i, i64 noundef range(i64 1, 0) %_149.i.i.i)
          to label %bb1.i.i.i.bb8.i.i_crit_edge.i unwind label %cleanup2.i.i.i

bb1.i.i.i.bb8.i.i_crit_edge.i:                    ; preds = %bb1.i.i.i.i
  %_23.i.i.pre.i = load ptr, ptr %vector1.sroa.4.0.vector.sroa_idx.i, align 8, !alias.scope !135, !noalias !136
  br label %bb8.i.i.i

common.resume:                                    ; preds = %bb4.i, %bb2.i.i.i6.i, %bb11.i.i.i, %bb5.i.i.i.i.i, %bb2.i.i.i.i.i4.i.i.i.i.i
  %common.resume.op = phi { ptr, i32 } [ %.pn.ph.i, %bb2.i.i.i.i.i4.i.i.i.i.i ], [ %.pn.i.i.i, %bb11.i.i.i ], [ %.pn.ph.i, %bb5.i.i.i.i.i ], [ %.pn.pn.pn, %bb2.i.i.i6.i ], [ %.pn.pn.pn, %bb4.i ]
  resume { ptr, i32 } %common.resume.op

bb10.i:                                           ; preds = %bb2.i.i.i4.i.i.i, %cleanup2.i, %cleanup.i
  %.pn.ph.i = phi { ptr, i32 } [ %0, %cleanup.i ], [ %15, %cleanup2.i ], [ %15, %bb2.i.i.i4.i.i.i ]
  call void @llvm.experimental.noalias.scope.decl(metadata !160)
  call void @llvm.experimental.noalias.scope.decl(metadata !163), !noalias !91
  call void @llvm.experimental.noalias.scope.decl(metadata !166), !noalias !91
  call void @llvm.experimental.noalias.scope.decl(metadata !169), !noalias !91
  call void @llvm.experimental.noalias.scope.decl(metadata !172), !noalias !91
  %46 = getelementptr inbounds nuw i8, ptr %_2, i64 8
  %self.val.i.i.i.i.i = load ptr, ptr %46, align 8, !alias.scope !175, !noalias !91, !nonnull !48, !noundef !48
  %47 = getelementptr inbounds nuw i8, ptr %_2, i64 24
  %self.val1.i.i.i.i.i = load ptr, ptr %47, align 8, !alias.scope !175, !noalias !91, !nonnull !48, !noundef !48
  %48 = ptrtoint ptr %self.val1.i.i.i.i.i to i64
  %49 = ptrtoint ptr %self.val.i.i.i.i.i to i64
  %50 = sub nuw i64 %48, %49
  %51 = udiv exact i64 %50, 24
  call void @llvm.experimental.noalias.scope.decl(metadata !176), !noalias !91
  %_710.i.i.i.i.i.i = icmp eq ptr %self.val1.i.i.i.i.i, %self.val.i.i.i.i.i
  br i1 %_710.i.i.i.i.i.i, label %bb5.i.i.i.i.i, label %bb5.i.i.i.i.i.i283

bb5.i.i.i.i.i.i283:                               ; preds = %bb10.i, %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i.i
  %_3.sroa.0.011.i.i.i.i.i.i = phi i64 [ %52, %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i.i ], [ 0, %bb10.i ]
  %_6.i.i.i.i.i.i = getelementptr inbounds nuw [24 x i8], ptr %self.val.i.i.i.i.i, i64 %_3.sroa.0.011.i.i.i.i.i.i
  %52 = add nuw nsw i64 %_3.sroa.0.011.i.i.i.i.i.i, 1
  %_6.val.i.i.i.i.i.i = load i64, ptr %_6.i.i.i.i.i.i, align 8, !alias.scope !176, !noalias !179
  %53 = icmp eq i64 %_6.val.i.i.i.i.i.i, 0
  br i1 %53, label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i.i, label %bb2.i.i.i4.i.i.i.i.i.i.i.i.i

bb2.i.i.i4.i.i.i.i.i.i.i.i.i:                     ; preds = %bb5.i.i.i.i.i.i283
  %54 = getelementptr i8, ptr %_6.i.i.i.i.i.i, i64 8
  %_6.val7.i.i.i.i.i.i = load ptr, ptr %54, align 8, !alias.scope !176, !noalias !179, !nonnull !48, !noundef !48
; call __rustc::__rust_dealloc
  call void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr noundef nonnull %_6.val7.i.i.i.i.i.i, i64 noundef %_6.val.i.i.i.i.i.i, i64 noundef range(i64 1, -9223372036854775807) 1) #21, !noalias !180
  br label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i.i

_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i.i: ; preds = %bb2.i.i.i4.i.i.i.i.i.i.i.i.i, %bb5.i.i.i.i.i.i283
  %_7.i.i.i.i.i.i = icmp eq i64 %52, %51
  br i1 %_7.i.i.i.i.i.i, label %bb5.i.i.i.i.i, label %bb5.i.i.i.i.i.i283

bb5.i.i.i.i.i:                                    ; preds = %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver.exit.i.i.i.i.i.i, %bb10.i
  %55 = getelementptr inbounds nuw i8, ptr %_2, i64 16
  %capacity2.i.i3.i.i.i.i.i = load i64, ptr %55, align 8, !alias.scope !175, !noalias !91, !noundef !48
  %56 = icmp eq i64 %capacity2.i.i3.i.i.i.i.i, 0
  br i1 %56, label %common.resume, label %bb2.i.i.i.i.i4.i.i.i.i.i

bb2.i.i.i.i.i4.i.i.i.i.i:                         ; preds = %bb5.i.i.i.i.i
  %ptr.i.i5.i.i.i.i.i = load ptr, ptr %_2, align 8, !alias.scope !175, !noalias !91, !nonnull !48, !noundef !48
  %alloc_size.i.i.i.i.i.i6.i.i.i.i.i = mul nuw i64 %capacity2.i.i3.i.i.i.i.i, 24
; call __rustc::__rust_dealloc
  call void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr noundef nonnull %ptr.i.i5.i.i.i.i.i, i64 noundef %alloc_size.i.i.i.i.i.i6.i.i.i.i.i, i64 noundef range(i64 1, -9223372036854775807) 8) #21, !noalias !179
  br label %common.resume

_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec21spec_from_iter_nestedINtB4_3VecNtNtB6_6string6StringEINtB2_18SpecFromIterNestedB11_NtNtCs341anU20NIK_3std3env4ArgsE9from_iterCs1StpruGFt5h_6driver.exit.thread: ; preds = %bb5.i.i.i.i.i.i, %bb2.i.i.i.i.i4.i.i.i.i.i.i
  call void @llvm.lifetime.end.p0(ptr nonnull %_2)
  %57 = getelementptr inbounds nuw i8, ptr %args, i64 8
  %58 = getelementptr inbounds nuw i8, ptr %args, i64 16
  br label %panic

_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec21spec_from_iter_nestedINtB4_3VecNtNtB6_6string6StringEINtB2_18SpecFromIterNestedB11_NtNtCs341anU20NIK_3std3env4ArgsE9from_iterCs1StpruGFt5h_6driver.exit: ; preds = %bb5.i.i.i.i.i.i.i.i, %bb2.i.i.i.i.i4.i.i.i.i.i.i.i.i
  call void @llvm.lifetime.end.p0(ptr nonnull %_19.i), !noalias !96
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(24) %args, ptr noundef nonnull align 8 dereferenceable(24) %vector.i, i64 24, i1 false), !noalias !94
  call void @llvm.lifetime.end.p0(ptr nonnull %vector.i), !noalias !96
  %.phi.trans.insert = getelementptr inbounds nuw i8, ptr %args, i64 16
  %_162.pre = load i64, ptr %.phi.trans.insert, align 8
  call void @llvm.lifetime.end.p0(ptr nonnull %_2)
  %59 = getelementptr inbounds nuw i8, ptr %args, i64 8
  %60 = getelementptr inbounds nuw i8, ptr %args, i64 16
  %_164 = icmp ugt i64 %_162.pre, 1
  br i1 %_164, label %bb89, label %panic

bb89:                                             ; preds = %_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec21spec_from_iter_nestedINtB4_3VecNtNtB6_6string6StringEINtB2_18SpecFromIterNestedB11_NtNtCs341anU20NIK_3std3env4ArgsE9from_iterCs1StpruGFt5h_6driver.exit
  %_163 = load ptr, ptr %59, align 8, !nonnull !48, !noundef !48
  %61 = getelementptr inbounds nuw i8, ptr %_163, i64 40
  %_170 = load i64, ptr %61, align 8, !noundef !48
  %_175 = icmp eq i64 %_170, 5
  br i1 %_175, label %bb90, label %bb116

panic:                                            ; preds = %_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec21spec_from_iter_nestedINtB4_3VecNtNtB6_6string6StringEINtB2_18SpecFromIterNestedB11_NtNtCs341anU20NIK_3std3env4ArgsE9from_iterCs1StpruGFt5h_6driver.exit.thread, %_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec21spec_from_iter_nestedINtB4_3VecNtNtB6_6string6StringEINtB2_18SpecFromIterNestedB11_NtNtCs341anU20NIK_3std3env4ArgsE9from_iterCs1StpruGFt5h_6driver.exit
  %62 = phi ptr [ %58, %_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec21spec_from_iter_nestedINtB4_3VecNtNtB6_6string6StringEINtB2_18SpecFromIterNestedB11_NtNtCs341anU20NIK_3std3env4ArgsE9from_iterCs1StpruGFt5h_6driver.exit.thread ], [ %60, %_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec21spec_from_iter_nestedINtB4_3VecNtNtB6_6string6StringEINtB2_18SpecFromIterNestedB11_NtNtCs341anU20NIK_3std3env4ArgsE9from_iterCs1StpruGFt5h_6driver.exit ]
  %63 = phi ptr [ %57, %_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec21spec_from_iter_nestedINtB4_3VecNtNtB6_6string6StringEINtB2_18SpecFromIterNestedB11_NtNtCs341anU20NIK_3std3env4ArgsE9from_iterCs1StpruGFt5h_6driver.exit.thread ], [ %59, %_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec21spec_from_iter_nestedINtB4_3VecNtNtB6_6string6StringEINtB2_18SpecFromIterNestedB11_NtNtCs341anU20NIK_3std3env4ArgsE9from_iterCs1StpruGFt5h_6driver.exit ]
  %_162713 = phi i64 [ 0, %_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec21spec_from_iter_nestedINtB4_3VecNtNtB6_6string6StringEINtB2_18SpecFromIterNestedB11_NtNtCs341anU20NIK_3std3env4ArgsE9from_iterCs1StpruGFt5h_6driver.exit.thread ], [ %_162.pre, %_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec21spec_from_iter_nestedINtB4_3VecNtNtB6_6string6StringEINtB2_18SpecFromIterNestedB11_NtNtCs341anU20NIK_3std3env4ArgsE9from_iterCs1StpruGFt5h_6driver.exit ]
; invoke core::panicking::panic_bounds_check
  invoke void @_RNvNtCsc9NCSoc2doQ_4core9panicking18panic_bounds_check(i64 noundef 1, i64 noundef %_162713, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) @alloc_76cbd47331a82c9bea1da249cd622be9) #22
          to label %unreachable unwind label %cleanup

bb85:                                             ; preds = %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VechEECs1StpruGFt5h_6driver.exit, %cleanup14, %cleanup
  %64 = phi ptr [ %60, %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VechEECs1StpruGFt5h_6driver.exit ], [ %70, %cleanup ], [ %60, %cleanup14 ]
  %65 = phi ptr [ %59, %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VechEECs1StpruGFt5h_6driver.exit ], [ %71, %cleanup ], [ %59, %cleanup14 ]
  %.pn.pn.pn = phi { ptr, i32 } [ %.pn.pn, %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VechEECs1StpruGFt5h_6driver.exit ], [ %72, %cleanup ], [ %lpad.phi340, %cleanup14 ]
  call void @llvm.experimental.noalias.scope.decl(metadata !181)
  %_1.val.i = load ptr, ptr %65, align 8, !alias.scope !181, !nonnull !48, !noundef !48
  %_1.val1.i = load i64, ptr %64, align 8, !alias.scope !181, !noundef !48
  call void @llvm.experimental.noalias.scope.decl(metadata !184)
  %_710.i.i.i = icmp eq i64 %_1.val1.i, 0
  br i1 %_710.i.i.i, label %bb4.i, label %bb5.i.i.i

bb5.i.i.i:                                        ; preds = %bb85, %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver.exit.i.i.i
  %_3.sroa.0.011.i.i.i = phi i64 [ %66, %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver.exit.i.i.i ], [ 0, %bb85 ]
  %_6.i.i.i = getelementptr inbounds nuw [24 x i8], ptr %_1.val.i, i64 %_3.sroa.0.011.i.i.i
  %66 = add nuw nsw i64 %_3.sroa.0.011.i.i.i, 1
  %_6.val.i.i.i = load i64, ptr %_6.i.i.i, align 8, !alias.scope !184, !noalias !181
  %67 = icmp eq i64 %_6.val.i.i.i, 0
  br i1 %67, label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver.exit.i.i.i, label %bb2.i.i.i4.i.i.i.i.i71

bb2.i.i.i4.i.i.i.i.i71:                           ; preds = %bb5.i.i.i
  %68 = getelementptr i8, ptr %_6.i.i.i, i64 8
  %_6.val7.i.i.i = load ptr, ptr %68, align 8, !alias.scope !184, !noalias !181, !nonnull !48, !noundef !48
; call __rustc::__rust_dealloc
  call void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr noundef nonnull %_6.val7.i.i.i, i64 noundef %_6.val.i.i.i, i64 noundef range(i64 1, -9223372036854775807) 1) #21, !noalias !187
  br label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver.exit.i.i.i

_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver.exit.i.i.i: ; preds = %bb2.i.i.i4.i.i.i.i.i71, %bb5.i.i.i
  %_7.i.i.i = icmp eq i64 %66, %_1.val1.i
  br i1 %_7.i.i.i, label %bb4.i, label %bb5.i.i.i

bb4.i:                                            ; preds = %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver.exit.i.i.i, %bb85
  %_1.val4.i = load i64, ptr %args, align 8, !range !52, !alias.scope !181, !noundef !48
  %69 = icmp eq i64 %_1.val4.i, 0
  br i1 %69, label %common.resume, label %bb2.i.i.i6.i

bb2.i.i.i6.i:                                     ; preds = %bb4.i
  %alloc_size.i.i.i.i7.i = mul nuw i64 %_1.val4.i, 24
; call __rustc::__rust_dealloc
  call void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr noundef nonnull %_1.val.i, i64 noundef %alloc_size.i.i.i.i7.i, i64 noundef range(i64 1, -9223372036854775807) 8) #21, !noalias !181
  br label %common.resume

cleanup:                                          ; preds = %panic12.invoke, %bb2.i64.invoke, %bb6.i.invoke, %bb2.i177, %bb6, %bb43, %panic
  %70 = phi ptr [ %60, %bb6.i.invoke ], [ %62, %panic ], [ %60, %bb2.i177 ], [ %60, %bb2.i64.invoke ], [ %60, %bb43 ], [ %60, %panic12.invoke ], [ %60, %bb6 ]
  %71 = phi ptr [ %59, %bb6.i.invoke ], [ %63, %panic ], [ %59, %bb2.i177 ], [ %59, %bb2.i64.invoke ], [ %59, %bb43 ], [ %59, %panic12.invoke ], [ %59, %bb6 ]
  %72 = landingpad { ptr, i32 }
          cleanup
  br label %bb85

unreachable:                                      ; preds = %bb98, %bb145, %bb67, %panic15, %bb51, %bb43, %panic
  unreachable

bb90:                                             ; preds = %bb89
  %73 = getelementptr inbounds nuw i8, ptr %_163, i64 32
  %_171 = load ptr, ptr %73, align 8, !nonnull !48, !noundef !48
  %74 = load i32, ptr %_171, align 1
  %75 = xor i32 %74, 1667590243
  %76 = getelementptr i8, ptr %_171, i64 4
  %77 = load i8, ptr %76, align 1
  %78 = zext i8 %77 to i32
  %79 = xor i32 %78, 107
  %80 = or i32 %75, %79
  %81 = icmp ne i32 %80, 0
  %82 = zext i1 %81 to i32
  %_3 = icmp eq i32 %82, 0
  br i1 %_3, label %bb1, label %bb116.thread

bb116.thread:                                     ; preds = %bb90
  call void @llvm.lifetime.start.p0(ptr nonnull %f)
  %83 = load i32, ptr %_171, align 1
  %84 = xor i32 %83, 1952543331
  %85 = getelementptr i8, ptr %_171, i64 4
  %86 = load i8, ptr %85, align 1
  %87 = zext i8 %86 to i32
  %88 = xor i32 %87, 101
  %89 = or i32 %84, %88
  %90 = icmp ne i32 %89, 0
  %91 = zext i1 %90 to i32
  %_77 = icmp eq i32 %91, 0
  br i1 %_77, label %bb124, label %bb43, !prof !188

bb1:                                              ; preds = %bb90
  call void @llvm.lifetime.start.p0(ptr nonnull %count)
  store i64 0, ptr %count, align 8
  %_14.sroa.4.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 8
  %_14.sroa.5.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 16
  %_14.sroa.6.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 24
  %_14.sroa.7.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 32
  %_14.sroa.8.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 40
  %_14.sroa.9.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 48
  %_14.sroa.10.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 56
  %_14.sroa.11.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 64
  %_14.sroa.12.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 72
  %_14.sroa.13.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 80
  %_14.sroa.14.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 88
  %_14.sroa.15.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 96
  %_14.sroa.16.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 104
  %_14.sroa.17.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 112
  %_14.sroa.18.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 120
  %_14.sroa.19.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 128
  %_14.sroa.20.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 136
  %_14.sroa.21.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 144
  %_14.sroa.22.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 152
  %_14.sroa.23.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 160
  %_14.sroa.24.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 168
  %_14.sroa.25.0.iter1.sroa_idx = getelementptr inbounds nuw i8, ptr %iter1, i64 176
  %92 = getelementptr inbounds nuw i8, ptr %_24, i64 8
  %93 = getelementptr inbounds nuw i8, ptr %_41, i64 8
  %94 = getelementptr inbounds nuw i8, ptr %_44, i64 8
  %95 = getelementptr inbounds nuw i8, ptr %_48, i64 8
  %96 = getelementptr inbounds nuw i8, ptr %_51, i64 8
  %97 = getelementptr inbounds nuw i8, ptr %_58, i64 8
  %98 = getelementptr inbounds nuw i8, ptr %_63, i64 8
  br label %bb5

bb116:                                            ; preds = %bb89
  call void @llvm.lifetime.start.p0(ptr nonnull %f)
  %cond = icmp eq i64 %_170, 3
  br i1 %cond, label %bb117, label %bb43, !prof !189

bb117:                                            ; preds = %bb116
  %99 = getelementptr inbounds nuw i8, ptr %_163, i64 32
  %_237 = load ptr, ptr %99, align 8, !nonnull !48, !noundef !48
  %100 = load i16, ptr %_237, align 1
  %101 = xor i16 %100, 29811
  %102 = getelementptr i8, ptr %_237, i64 2
  %103 = load i8, ptr %102, align 1
  %104 = zext i8 %103 to i16
  %105 = xor i16 %104, 100
  %106 = or i16 %101, %105
  %107 = icmp ne i16 %106, 0
  %108 = zext i1 %107 to i32
  %_78 = icmp eq i32 %108, 0
  br i1 %_78, label %bb124, label %bb43

bb43:                                             ; preds = %bb116, %bb117, %bb116.thread
; invoke core::panicking::panic
  invoke void @_RNvNtCsc9NCSoc2doQ_4core9panicking5panic(ptr noalias nofree noundef nonnull readonly captures(address, read_provenance) @alloc_476509aa7047bd805d630c6546685797, i64 noundef 14, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) @alloc_1cd847217f7fad949c219121493e6692) #22
          to label %unreachable unwind label %cleanup

bb124:                                            ; preds = %bb116.thread, %bb117
  %_74.sroa.0.0 = phi ptr [ @_RNvCs1StpruGFt5h_6driver8std_find, %bb117 ], [ @_RNvCs1StpruGFt5h_6driver10crate_find, %bb116.thread ]
  store ptr %_74.sroa.0.0, ptr %f, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %f) #21, !srcloc !73
  %_260.not = icmp eq i64 %_162.pre, 2
  br i1 %_260.not, label %panic12.invoke, label %bb125

bb125:                                            ; preds = %bb124
  %109 = getelementptr inbounds nuw i8, ptr %_163, i64 56
  %_265 = load ptr, ptr %109, align 8, !nonnull !48, !noundef !48
  %110 = getelementptr inbounds nuw i8, ptr %_163, i64 64
  %_264 = load i64, ptr %110, align 8, !noundef !48
  switch i64 %_264, label %bb9thread-pre-split.i [
    i64 0, label %bb2.i64
    i64 1, label %bb7.i
  ]

bb7.i:                                            ; preds = %bb125
  %111 = load i8, ptr %_265, align 1, !alias.scope !190, !noalias !193, !noundef !48
  switch i8 %111, label %bb9.i [
    i8 43, label %bb2.i64
    i8 45, label %bb2.i64
  ]

bb9thread-pre-split.i:                            ; preds = %bb125
  %.pr.i = load i8, ptr %_265, align 1, !alias.scope !190, !noalias !193
  br label %bb9.i

bb9.i:                                            ; preds = %bb9thread-pre-split.i, %bb7.i
  %112 = phi i8 [ %.pr.i, %bb9thread-pre-split.i ], [ %111, %bb7.i ]
  %cond.i = icmp eq i8 %112, 43
  %rest.1.i = sext i1 %cond.i to i64
  %src.sroa.15.0.i = add nsw i64 %_264, %rest.1.i
  %src.sroa.0.0.idx.i = zext i1 %cond.i to i64
  %src.sroa.0.0.i = getelementptr inbounds nuw i8, ptr %_265, i64 %src.sroa.0.0.idx.i
  %_10.i = icmp samesign ult i64 %src.sroa.15.0.i, 17
  br i1 %_10.i, label %bb15.preheader.i, label %bb23.i

bb15.preheader.i:                                 ; preds = %bb9.i
  %_13.not56.i = icmp eq i64 %src.sroa.15.0.i, 0
  br i1 %_13.not56.i, label %bb47, label %bb16.i

bb22.i:                                           ; preds = %bb41.i
  %_30.not.i = icmp eq i64 %rest.12.i, 0
  br i1 %_30.not.i, label %bb47, label %bb23.i

bb23.i:                                           ; preds = %bb9.i, %bb22.i
  %src.sroa.0.1.i1154 = phi ptr [ %rest.01.i, %bb22.i ], [ %src.sroa.0.0.i, %bb9.i ]
  %src.sroa.15.1.i1153 = phi i64 [ %rest.12.i, %bb22.i ], [ %src.sroa.15.0.i, %bb9.i ]
  %result.sroa.0.0.i1152 = phi i64 [ %_66.0.i, %bb22.i ], [ 0, %bb9.i ]
  %rest.01.i = getelementptr inbounds nuw i8, ptr %src.sroa.0.1.i1154, i64 1
  %rest.12.i = add nsw i64 %src.sroa.15.1.i1153, -1
  %113 = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %result.sroa.0.0.i1152, i64 10)
  %_60.0.i = extractvalue { i64, i1 } %113, 0
  %_60.1.i = extractvalue { i64, i1 } %113, 1
  %114 = load i8, ptr %src.sroa.0.1.i1154, align 1, !alias.scope !190, !noalias !193, !noundef !48
  br i1 %_60.1.i, label %bb32.i, label %bb34.i, !prof !195

bb34.i:                                           ; preds = %bb23.i
  %115 = zext i8 %114 to i32
  %116 = add nsw i32 %115, -48
  %_14.i.i = icmp ult i32 %116, 10
  br i1 %_14.i.i, label %bb41.i, label %bb2.i64

bb32.i:                                           ; preds = %bb23.i
  %117 = add i8 %114, -48
  %_14.i44.i = icmp ult i8 %117, 10
  %spec.select = select i1 %_14.i44.i, i8 2, i8 1
  br label %bb2.i64

bb41.i:                                           ; preds = %bb34.i
  %118 = zext nneg i32 %116 to i64
  %_66.0.i = add i64 %_60.0.i, %118
  %_66.1.i = icmp ult i64 %_66.0.i, %_60.0.i
  br i1 %_66.1.i, label %bb2.i64, label %bb22.i, !prof !195

bb16.i:                                           ; preds = %bb15.preheader.i, %bb20.i
  %src.sroa.0.259.i = phi ptr [ %rest.05.i, %bb20.i ], [ %src.sroa.0.0.i, %bb15.preheader.i ]
  %src.sroa.15.258.i = phi i64 [ %rest.16.i, %bb20.i ], [ %src.sroa.15.0.i, %bb15.preheader.i ]
  %result.sroa.0.257.i = phi i64 [ %121, %bb20.i ], [ 0, %bb15.preheader.i ]
  %_20.i = load i8, ptr %src.sroa.0.259.i, align 1, !alias.scope !190, !noalias !193, !noundef !48
  %_19.i73 = zext i8 %_20.i to i32
  %119 = add nsw i32 %_19.i73, -48
  %_14.i46.i = icmp ult i32 %119, 10
  br i1 %_14.i46.i, label %bb20.i, label %bb2.i64

bb20.i:                                           ; preds = %bb16.i
  %120 = mul i64 %result.sroa.0.257.i, 10
  %rest.16.i = add nsw i64 %src.sroa.15.258.i, -1
  %rest.05.i = getelementptr inbounds nuw i8, ptr %src.sroa.0.259.i, i64 1
  %_24.i = zext nneg i32 %119 to i64
  %121 = add i64 %120, %_24.i
  %_13.not.i = icmp eq i64 %rest.16.i, 0
  br i1 %_13.not.i, label %bb47, label %bb16.i

bb2.i64:                                          ; preds = %bb34.i, %bb41.i, %bb16.i, %bb32.i, %bb125, %bb7.i, %bb7.i
  %_81.sroa.4.0.ph = phi i8 [ 1, %bb7.i ], [ %spec.select, %bb32.i ], [ 1, %bb7.i ], [ 0, %bb125 ], [ 1, %bb16.i ], [ 1, %bb34.i ], [ 2, %bb41.i ]
  call void @llvm.lifetime.start.p0(ptr nonnull %e.i62), !noalias !196
  store i8 %_81.sroa.4.0.ph, ptr %e.i62, align 1, !noalias !196
  br label %bb2.i64.invoke

bb2.i64.invoke:                                   ; preds = %bb2.i, %bb2.i59, %bb2.i64
  %122 = phi ptr [ %e.i62, %bb2.i64 ], [ %e.i57, %bb2.i59 ], [ %e.i, %bb2.i ]
  %123 = phi ptr [ @alloc_0466fbcb6efd6e27b2f9ddb5c8bd67bf, %bb2.i64 ], [ @alloc_5c213bcbaef43ebb221d4146a2acfd23, %bb2.i59 ], [ @alloc_e2a94c7f70cdaf98936bf1e119b31d15, %bb2.i ]
; invoke core::result::unwrap_failed
  invoke void @_RNvNtCsc9NCSoc2doQ_4core6result13unwrap_failed(ptr noalias nofree noundef nonnull readonly captures(address, read_provenance) @alloc_00ae4b301f7fab8ac9617c03fcbd7274, i64 noundef 43, ptr noundef nonnull %122, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(32) @vtable.1, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) %123) #25
          to label %bb2.i64.cont unwind label %cleanup

bb2.i64.cont:                                     ; preds = %bb2.i64.invoke
  unreachable

bb47:                                             ; preds = %bb22.i, %bb20.i, %bb15.preheader.i
  %_81.sroa.11285.0 = phi i64 [ %121, %bb20.i ], [ 0, %bb15.preheader.i ], [ %_66.0.i, %bb22.i ]
  call void @llvm.lifetime.start.p0(ptr nonnull %off)
  %_271 = icmp ugt i64 %_162.pre, 3
  br i1 %_271, label %bb127, label %panic12.invoke

bb127:                                            ; preds = %bb47
  %124 = getelementptr inbounds nuw i8, ptr %_163, i64 80
  %_276 = load ptr, ptr %124, align 8, !nonnull !48, !noundef !48
  %125 = getelementptr inbounds nuw i8, ptr %_163, i64 88
  %_275 = load i64, ptr %125, align 8, !noundef !48
  switch i64 %_275, label %bb9thread-pre-split.i123 [
    i64 0, label %bb2.i59
    i64 1, label %bb7.i75
  ]

bb7.i75:                                          ; preds = %bb127
  %126 = load i8, ptr %_276, align 1, !alias.scope !200, !noalias !203, !noundef !48
  switch i8 %126, label %bb9.i78 [
    i8 43, label %bb2.i59
    i8 45, label %bb2.i59
  ]

bb9thread-pre-split.i123:                         ; preds = %bb127
  %.pr.i124 = load i8, ptr %_276, align 1, !alias.scope !200, !noalias !203
  br label %bb9.i78

bb9.i78:                                          ; preds = %bb9thread-pre-split.i123, %bb7.i75
  %127 = phi i8 [ %.pr.i124, %bb9thread-pre-split.i123 ], [ %126, %bb7.i75 ]
  %cond.i79 = icmp eq i8 %127, 43
  %rest.1.i80 = sext i1 %cond.i79 to i64
  %src.sroa.15.0.i81 = add nsw i64 %_275, %rest.1.i80
  %src.sroa.0.0.idx.i82 = zext i1 %cond.i79 to i64
  %src.sroa.0.0.i83 = getelementptr inbounds nuw i8, ptr %_276, i64 %src.sroa.0.0.idx.i82
  %_10.i84 = icmp samesign ult i64 %src.sroa.15.0.i81, 17
  br i1 %_10.i84, label %bb15.preheader.i107, label %bb23.i90

bb15.preheader.i107:                              ; preds = %bb9.i78
  %_13.not56.i108 = icmp eq i64 %src.sroa.15.0.i81, 0
  br i1 %_13.not56.i108, label %bb48, label %bb16.i109

bb22.i85:                                         ; preds = %bb41.i98
  %_30.not.i89 = icmp eq i64 %rest.12.i92, 0
  br i1 %_30.not.i89, label %bb48, label %bb23.i90

bb23.i90:                                         ; preds = %bb9.i78, %bb22.i85
  %src.sroa.0.1.i881157 = phi ptr [ %rest.01.i91, %bb22.i85 ], [ %src.sroa.0.0.i83, %bb9.i78 ]
  %src.sroa.15.1.i871156 = phi i64 [ %rest.12.i92, %bb22.i85 ], [ %src.sroa.15.0.i81, %bb9.i78 ]
  %result.sroa.0.0.i861155 = phi i64 [ %_66.0.i99, %bb22.i85 ], [ 0, %bb9.i78 ]
  %rest.01.i91 = getelementptr inbounds nuw i8, ptr %src.sroa.0.1.i881157, i64 1
  %rest.12.i92 = add nsw i64 %src.sroa.15.1.i871156, -1
  %128 = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %result.sroa.0.0.i861155, i64 10)
  %_60.0.i93 = extractvalue { i64, i1 } %128, 0
  %_60.1.i94 = extractvalue { i64, i1 } %128, 1
  %129 = load i8, ptr %src.sroa.0.1.i881157, align 1, !alias.scope !200, !noalias !203, !noundef !48
  br i1 %_60.1.i94, label %bb32.i102, label %bb34.i95, !prof !195

bb34.i95:                                         ; preds = %bb23.i90
  %130 = zext i8 %129 to i32
  %131 = add nsw i32 %130, -48
  %_14.i.i96 = icmp ult i32 %131, 10
  br i1 %_14.i.i96, label %bb41.i98, label %bb2.i59

bb32.i102:                                        ; preds = %bb23.i90
  %132 = add i8 %129, -48
  %_14.i44.i103 = icmp ult i8 %132, 10
  %spec.select332 = select i1 %_14.i44.i103, i8 2, i8 1
  br label %bb2.i59

bb41.i98:                                         ; preds = %bb34.i95
  %133 = zext nneg i32 %131 to i64
  %_66.0.i99 = add i64 %_60.0.i93, %133
  %_66.1.i100 = icmp ult i64 %_66.0.i99, %_60.0.i93
  br i1 %_66.1.i100, label %bb2.i59, label %bb22.i85, !prof !195

bb16.i109:                                        ; preds = %bb15.preheader.i107, %bb20.i117
  %src.sroa.0.259.i110 = phi ptr [ %rest.05.i119, %bb20.i117 ], [ %src.sroa.0.0.i83, %bb15.preheader.i107 ]
  %src.sroa.15.258.i111 = phi i64 [ %rest.16.i118, %bb20.i117 ], [ %src.sroa.15.0.i81, %bb15.preheader.i107 ]
  %result.sroa.0.257.i112 = phi i64 [ %136, %bb20.i117 ], [ 0, %bb15.preheader.i107 ]
  %_20.i113 = load i8, ptr %src.sroa.0.259.i110, align 1, !alias.scope !200, !noalias !203, !noundef !48
  %_19.i114 = zext i8 %_20.i113 to i32
  %134 = add nsw i32 %_19.i114, -48
  %_14.i46.i115 = icmp ult i32 %134, 10
  br i1 %_14.i46.i115, label %bb20.i117, label %bb2.i59

bb20.i117:                                        ; preds = %bb16.i109
  %135 = mul i64 %result.sroa.0.257.i112, 10
  %rest.16.i118 = add nsw i64 %src.sroa.15.258.i111, -1
  %rest.05.i119 = getelementptr inbounds nuw i8, ptr %src.sroa.0.259.i110, i64 1
  %_24.i120 = zext nneg i32 %134 to i64
  %136 = add i64 %135, %_24.i120
  %_13.not.i121 = icmp eq i64 %rest.16.i118, 0
  br i1 %_13.not.i121, label %bb48, label %bb16.i109

bb2.i59:                                          ; preds = %bb34.i95, %bb41.i98, %bb16.i109, %bb32.i102, %bb127, %bb7.i75, %bb7.i75
  %_85.sroa.4.0.ph = phi i8 [ 1, %bb7.i75 ], [ %spec.select332, %bb32.i102 ], [ 1, %bb7.i75 ], [ 0, %bb127 ], [ 1, %bb16.i109 ], [ 1, %bb34.i95 ], [ 2, %bb41.i98 ]
  call void @llvm.lifetime.start.p0(ptr nonnull %e.i57), !noalias !205
  store i8 %_85.sroa.4.0.ph, ptr %e.i57, align 1, !noalias !205
  br label %bb2.i64.invoke

bb48:                                             ; preds = %bb22.i85, %bb20.i117, %bb15.preheader.i107
  %_85.sroa.11286.0 = phi i64 [ %136, %bb20.i117 ], [ 0, %bb15.preheader.i107 ], [ %_66.0.i99, %bb22.i85 ]
  store i64 %_85.sroa.11286.0, ptr %off, align 8
  call void @llvm.lifetime.start.p0(ptr nonnull %n)
  %_282 = icmp ugt i64 %_162.pre, 5
  br i1 %_282, label %bb129, label %panic12.invoke

bb129:                                            ; preds = %bb48
  %137 = getelementptr inbounds nuw i8, ptr %_163, i64 128
  %_287 = load ptr, ptr %137, align 8, !nonnull !48, !noundef !48
  %138 = getelementptr inbounds nuw i8, ptr %_163, i64 136
  %_286 = load i64, ptr %138, align 8, !noundef !48
  switch i64 %_286, label %bb9thread-pre-split.i174 [
    i64 0, label %bb2.i
    i64 1, label %bb7.i126
  ]

bb7.i126:                                         ; preds = %bb129
  %139 = load i8, ptr %_287, align 1, !alias.scope !209, !noalias !212, !noundef !48
  switch i8 %139, label %bb9.i129 [
    i8 43, label %bb2.i
    i8 45, label %bb2.i
  ]

bb9thread-pre-split.i174:                         ; preds = %bb129
  %.pr.i175 = load i8, ptr %_287, align 1, !alias.scope !209, !noalias !212
  br label %bb9.i129

bb9.i129:                                         ; preds = %bb9thread-pre-split.i174, %bb7.i126
  %140 = phi i8 [ %.pr.i175, %bb9thread-pre-split.i174 ], [ %139, %bb7.i126 ]
  %cond.i130 = icmp eq i8 %140, 43
  %rest.1.i131 = sext i1 %cond.i130 to i64
  %src.sroa.15.0.i132 = add nsw i64 %_286, %rest.1.i131
  %src.sroa.0.0.idx.i133 = zext i1 %cond.i130 to i64
  %src.sroa.0.0.i134 = getelementptr inbounds nuw i8, ptr %_287, i64 %src.sroa.0.0.idx.i133
  %_10.i135 = icmp samesign ult i64 %src.sroa.15.0.i132, 17
  br i1 %_10.i135, label %bb15.preheader.i158, label %bb23.i141

bb15.preheader.i158:                              ; preds = %bb9.i129
  %_13.not56.i159 = icmp eq i64 %src.sroa.15.0.i132, 0
  br i1 %_13.not56.i159, label %bb49, label %bb16.i160

bb22.i136:                                        ; preds = %bb41.i149
  %_30.not.i140 = icmp eq i64 %rest.12.i143, 0
  br i1 %_30.not.i140, label %bb49, label %bb23.i141

bb23.i141:                                        ; preds = %bb9.i129, %bb22.i136
  %src.sroa.0.1.i1391160 = phi ptr [ %rest.01.i142, %bb22.i136 ], [ %src.sroa.0.0.i134, %bb9.i129 ]
  %src.sroa.15.1.i1381159 = phi i64 [ %rest.12.i143, %bb22.i136 ], [ %src.sroa.15.0.i132, %bb9.i129 ]
  %result.sroa.0.0.i1371158 = phi i64 [ %_66.0.i150, %bb22.i136 ], [ 0, %bb9.i129 ]
  %rest.01.i142 = getelementptr inbounds nuw i8, ptr %src.sroa.0.1.i1391160, i64 1
  %rest.12.i143 = add nsw i64 %src.sroa.15.1.i1381159, -1
  %141 = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %result.sroa.0.0.i1371158, i64 10)
  %_60.0.i144 = extractvalue { i64, i1 } %141, 0
  %_60.1.i145 = extractvalue { i64, i1 } %141, 1
  %142 = load i8, ptr %src.sroa.0.1.i1391160, align 1, !alias.scope !209, !noalias !212, !noundef !48
  br i1 %_60.1.i145, label %bb32.i153, label %bb34.i146, !prof !195

bb34.i146:                                        ; preds = %bb23.i141
  %143 = zext i8 %142 to i32
  %144 = add nsw i32 %143, -48
  %_14.i.i147 = icmp ult i32 %144, 10
  br i1 %_14.i.i147, label %bb41.i149, label %bb2.i

bb32.i153:                                        ; preds = %bb23.i141
  %145 = add i8 %142, -48
  %_14.i44.i154 = icmp ult i8 %145, 10
  %spec.select333 = select i1 %_14.i44.i154, i8 2, i8 1
  br label %bb2.i

bb41.i149:                                        ; preds = %bb34.i146
  %146 = zext nneg i32 %144 to i64
  %_66.0.i150 = add i64 %_60.0.i144, %146
  %_66.1.i151 = icmp ult i64 %_66.0.i150, %_60.0.i144
  br i1 %_66.1.i151, label %bb2.i, label %bb22.i136, !prof !195

bb16.i160:                                        ; preds = %bb15.preheader.i158, %bb20.i168
  %src.sroa.0.259.i161 = phi ptr [ %rest.05.i170, %bb20.i168 ], [ %src.sroa.0.0.i134, %bb15.preheader.i158 ]
  %src.sroa.15.258.i162 = phi i64 [ %rest.16.i169, %bb20.i168 ], [ %src.sroa.15.0.i132, %bb15.preheader.i158 ]
  %result.sroa.0.257.i163 = phi i64 [ %149, %bb20.i168 ], [ 0, %bb15.preheader.i158 ]
  %_20.i164 = load i8, ptr %src.sroa.0.259.i161, align 1, !alias.scope !209, !noalias !212, !noundef !48
  %_19.i165 = zext i8 %_20.i164 to i32
  %147 = add nsw i32 %_19.i165, -48
  %_14.i46.i166 = icmp ult i32 %147, 10
  br i1 %_14.i46.i166, label %bb20.i168, label %bb2.i

bb20.i168:                                        ; preds = %bb16.i160
  %148 = mul i64 %result.sroa.0.257.i163, 10
  %rest.16.i169 = add nsw i64 %src.sroa.15.258.i162, -1
  %rest.05.i170 = getelementptr inbounds nuw i8, ptr %src.sroa.0.259.i161, i64 1
  %_24.i171 = zext nneg i32 %147 to i64
  %149 = add i64 %148, %_24.i171
  %_13.not.i172 = icmp eq i64 %rest.16.i169, 0
  br i1 %_13.not.i172, label %bb49, label %bb16.i160

panic12.invoke:                                   ; preds = %bb48, %bb47, %bb124
  %150 = phi i64 [ 3, %bb47 ], [ 2, %bb124 ], [ 5, %bb48 ]
  %151 = phi i64 [ 3, %bb47 ], [ 2, %bb124 ], [ %_162.pre, %bb48 ]
  %152 = phi ptr [ @alloc_91bb3c8e2e46ccbc16597808f0bab401, %bb47 ], [ @alloc_97f20d6aba9b53792d2804ec8a9b80db, %bb124 ], [ @alloc_430a626d7ad8fa09ca7e11f1cb9a43c6, %bb48 ]
; invoke core::panicking::panic_bounds_check
  invoke void @_RNvNtCsc9NCSoc2doQ_4core9panicking18panic_bounds_check(i64 noundef %150, i64 noundef %151, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) %152) #22
          to label %panic12.cont unwind label %cleanup

panic12.cont:                                     ; preds = %panic12.invoke
  unreachable

bb2.i:                                            ; preds = %bb34.i146, %bb41.i149, %bb16.i160, %bb32.i153, %bb129, %bb7.i126, %bb7.i126
  %_89.sroa.4.0.ph = phi i8 [ 1, %bb7.i126 ], [ %spec.select333, %bb32.i153 ], [ 1, %bb7.i126 ], [ 0, %bb129 ], [ 1, %bb16.i160 ], [ 1, %bb34.i146 ], [ 2, %bb41.i149 ]
  call void @llvm.lifetime.start.p0(ptr nonnull %e.i), !noalias !214
  store i8 %_89.sroa.4.0.ph, ptr %e.i, align 1, !noalias !214
  br label %bb2.i64.invoke

bb49:                                             ; preds = %bb22.i136, %bb20.i168, %bb15.preheader.i158
  %_89.sroa.11287.0 = phi i64 [ %149, %bb20.i168 ], [ 0, %bb15.preheader.i158 ], [ %_66.0.i150, %bb22.i136 ]
  store i64 %_89.sroa.11287.0, ptr %n, align 8
; call __rustc::__rust_no_alloc_shim_is_unstable_v2
  call void @_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2() #21
; call __rustc::__rust_alloc
  %153 = call noundef align 64 dereferenceable_or_null(131200) ptr @_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc(i64 noundef 131200, i64 noundef 64) #21
  %154 = icmp eq ptr %153, null
  br i1 %154, label %bb2.i177, label %bb50, !prof !195

bb2.i177:                                         ; preds = %bb49
; invoke alloc::alloc::handle_alloc_error
  invoke void @_RNvNtCs3v2GDSbr0UZ_5alloc5alloc18handle_alloc_error(i64 noundef 64, i64 noundef 131200) #22
          to label %.noexc178 unwind label %cleanup

.noexc178:                                        ; preds = %bb2.i177
  unreachable

bb50:                                             ; preds = %bb49
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 64 dereferenceable(131200) %153, i8 -128, i64 131200, i1 false)
  call void @llvm.lifetime.start.p0(ptr nonnull %pos)
  %155 = getelementptr inbounds nuw i8, ptr %_163, i64 104
  %_298 = load ptr, ptr %155, align 8, !nonnull !48, !noundef !48
  %156 = getelementptr inbounds nuw i8, ptr %_163, i64 112
  %_297 = load i64, ptr %156, align 8, !noundef !48
  switch i64 %_297, label %bb51 [
    i64 6, label %bb132
    i64 5, label %bb135
    i64 4, label %bb141
  ], !prof !218

cleanup14.loopexit:                               ; preds = %bb160
  %lpad.loopexit338 = landingpad { ptr, i32 }
          cleanup
  br label %cleanup14

cleanup14.loopexit.split-lp.loopexit:             ; preds = %bb153
  %lpad.loopexit341 = landingpad { ptr, i32 }
          cleanup
  br label %cleanup14

cleanup14.loopexit.split-lp.loopexit.split-lp:    ; preds = %bb75.invoke, %bb145, %bb74, %bb67, %bb63, %panic15, %bb51
  %lpad.loopexit.split-lp342 = landingpad { ptr, i32 }
          cleanup
  br label %cleanup14

cleanup14:                                        ; preds = %cleanup14.loopexit.split-lp.loopexit, %cleanup14.loopexit.split-lp.loopexit.split-lp, %cleanup14.loopexit
  %lpad.phi340 = phi { ptr, i32 } [ %lpad.loopexit338, %cleanup14.loopexit ], [ %lpad.loopexit341, %cleanup14.loopexit.split-lp.loopexit ], [ %lpad.loopexit.split-lp342, %cleanup14.loopexit.split-lp.loopexit.split-lp ]
; call __rustc::__rust_dealloc
  call void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr noundef nonnull %153, i64 noundef 131200, i64 noundef 64) #21
  br label %bb85

bb132:                                            ; preds = %bb50
  %157 = load i32, ptr %_298, align 1
  %158 = xor i32 %157, 1702060641
  %159 = getelementptr i8, ptr %_298, i64 4
  %160 = load i16, ptr %159, align 1
  %161 = zext i16 %160 to i32
  %162 = xor i32 %161, 29806
  %163 = or i32 %158, %162
  %164 = icmp ne i32 %163, 0
  %165 = zext i1 %164 to i32
  %_101 = icmp eq i32 %165, 0
  br i1 %_101, label %bb59, label %bb138

bb135:                                            ; preds = %bb50
  %166 = load i32, ptr %_298, align 1
  %167 = xor i32 %166, 1852797542
  %168 = getelementptr i8, ptr %_298, i64 4
  %169 = load i8, ptr %168, align 1
  %170 = zext i8 %169 to i32
  %171 = xor i32 %170, 116
  %172 = or i32 %167, %171
  %173 = icmp ne i32 %172, 0
  %174 = zext i1 %173 to i32
  %_100 = icmp eq i32 %174, 0
  br i1 %_100, label %bb54, label %bb51

bb54:                                             ; preds = %bb135
  store i64 1, ptr %pos, align 8
  %175 = getelementptr inbounds nuw i8, ptr %pos, i64 8
  store i64 0, ptr %175, align 8
  br label %bb60

bb138:                                            ; preds = %bb132
  %176 = load i32, ptr %_298, align 1
  %177 = xor i32 %176, 1684302189
  %178 = getelementptr i8, ptr %_298, i64 4
  %179 = load i16, ptr %178, align 1
  %180 = zext i16 %179 to i32
  %181 = xor i32 %180, 25964
  %182 = or i32 %177, %181
  %183 = icmp ne i32 %182, 0
  %184 = zext i1 %183 to i32
  %_99 = icmp eq i32 %184, 0
  br i1 %_99, label %bb56, label %bb51

bb56:                                             ; preds = %bb138
  %_10249 = lshr i64 %_81.sroa.11285.0, 1
  %185 = getelementptr inbounds nuw i8, ptr %pos, i64 8
  store i64 %_10249, ptr %185, align 8
  store i64 1, ptr %pos, align 8
  br label %bb60

bb141:                                            ; preds = %bb50
  %186 = load i32, ptr %_298, align 1
  %187 = icmp ne i32 %186, 1953718636
  %188 = zext i1 %187 to i32
  %_98 = icmp eq i32 %188, 0
  br i1 %_98, label %bb58, label %bb51, !prof !188

bb51:                                             ; preds = %bb138, %bb135, %bb50, %bb141
; invoke core::panicking::panic
  invoke void @_RNvNtCsc9NCSoc2doQ_4core9panicking5panic(ptr noalias nofree noundef nonnull readonly captures(address, read_provenance) @alloc_476509aa7047bd805d630c6546685797, i64 noundef 14, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) @alloc_a9a7dce65c6d1c57d540b735479f6251) #22
          to label %unreachable unwind label %cleanup14.loopexit.split-lp.loopexit.split-lp

bb58:                                             ; preds = %bb141
  %_103 = add i64 %_81.sroa.11285.0, -1
  %189 = getelementptr inbounds nuw i8, ptr %pos, i64 8
  store i64 %_103, ptr %189, align 8
  store i64 1, ptr %pos, align 8
  br label %bb60

bb59:                                             ; preds = %bb132
  store i64 0, ptr %pos, align 8
  br label %bb62

bb60:                                             ; preds = %bb54, %bb56, %bb58
  %_10336.ph = phi i64 [ %_103, %bb58 ], [ %_10249, %bb56 ], [ 0, %bb54 ]
  %_107 = add i64 %_10336.ph, %_85.sroa.11286.0
  %_108 = icmp ult i64 %_107, 131200
  br i1 %_108, label %bb61, label %panic15

bb62:                                             ; preds = %bb59, %bb61
  %190 = phi i1 [ true, %bb61 ], [ false, %bb59 ]
  %191 = phi i1 [ false, %bb61 ], [ true, %bb59 ]
  %_10336304 = phi i64 [ %_10336.ph, %bb61 ], [ undef, %bb59 ]
  %_111 = add i64 %_85.sroa.11286.0, %_81.sroa.11285.0
  %_338 = icmp uge i64 %_111, %_85.sroa.11286.0
  %_334 = icmp ult i64 %_111, 131201
  %or.cond54 = and i1 %_338, %_334
  br i1 %or.cond54, label %bb144, label %bb145, !prof !219

bb61:                                             ; preds = %bb60
  %192 = getelementptr inbounds nuw i8, ptr %153, i64 %_107
  store i8 -1, ptr %192, align 1
  br label %bb62

panic15:                                          ; preds = %bb60
; invoke core::panicking::panic_bounds_check
  invoke void @_RNvNtCsc9NCSoc2doQ_4core9panicking18panic_bounds_check(i64 noundef %_107, i64 noundef 131200, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) @alloc_fee2473f5ebd52e53d5ac249e1622a16) #22
          to label %unreachable unwind label %cleanup14.loopexit.split-lp.loopexit.split-lp

bb145:                                            ; preds = %bb62
; invoke core::slice::index::slice_index_fail
  invoke void @_RNvNtNtCsc9NCSoc2doQ_4core5slice5index16slice_index_fail(i64 noundef %_85.sroa.11286.0, i64 noundef %_111, i64 noundef 131200, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) @alloc_62b520d5cd86147517119ea4db494764) #22
          to label %unreachable unwind label %cleanup14.loopexit.split-lp.loopexit.split-lp

bb144:                                            ; preds = %bb62
  %_341 = getelementptr inbounds nuw i8, ptr %153, i64 %_85.sroa.11286.0
  call void @llvm.lifetime.start.p0(ptr nonnull %_113)
  %_114 = ptrtoint ptr %_341 to i64
  %193 = and i64 %_114, 63
  store i64 %193, ptr %_113, align 8
  %_117 = icmp eq i64 %193, %_85.sroa.11286.0
  br i1 %_117, label %bb63, label %bb75.invoke, !prof !188

bb63:                                             ; preds = %bb144
  call void @llvm.lifetime.end.p0(ptr nonnull %_113)
  call void @llvm.lifetime.start.p0(ptr nonnull %_120)
  %194 = load ptr, ptr %f, align 8, !nonnull !48, !noundef !48
  %195 = invoke { i64, i64 } %194(i8 noundef -1, ptr noalias nofree noundef nonnull readonly captures(address, read_provenance) %_341, i64 noundef %_81.sroa.11285.0)
          to label %bb65 unwind label %cleanup14.loopexit.split-lp.loopexit.split-lp

bb65:                                             ; preds = %bb63
  %196 = extractvalue { i64, i64 } %195, 0
  %197 = extractvalue { i64, i64 } %195, 1
  store i64 %196, ptr %_120, align 8
  %198 = getelementptr inbounds nuw i8, ptr %_120, i64 8
  store i64 %197, ptr %198, align 8
  %199 = trunc nuw i64 %196 to i1
  br i1 %199, label %bb149, label %bb148

bb149:                                            ; preds = %bb65
  %200 = icmp eq i64 %197, %_10336304
  %or.cond334 = select i1 %190, i1 %200, i1 false, !prof !219
  br i1 %or.cond334, label %bb66, label %bb67, !prof !219

bb148:                                            ; preds = %bb65
  br i1 %191, label %bb66, label %bb67, !prof !188

bb67:                                             ; preds = %bb149, %bb148
; invoke core::panicking::assert_failed::<core::option::Option<usize>, core::option::Option<usize>>
  invoke void @_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedINtNtB4_6option6OptionjEBM_EB4_(i8 noundef 0, ptr noalias nofree noundef nonnull readonly align 8 captures(address, read_provenance) dereferenceable(16) %_120, ptr noalias nofree noundef nonnull readonly align 8 captures(address, read_provenance) dereferenceable(16) %pos, ptr noundef null, ptr undef, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) @alloc_33f467d265e61babc7c5951f1b7a303c) #22
          to label %unreachable unwind label %cleanup14.loopexit.split-lp.loopexit.split-lp

bb66:                                             ; preds = %bb149, %bb148
  call void @llvm.lifetime.end.p0(ptr nonnull %_120)
  %201 = getelementptr inbounds nuw i8, ptr %_127, i64 8
  %202 = getelementptr inbounds nuw i8, ptr %_124, i64 8
  br label %bb153

bb154:                                            ; preds = %bb69
  call void @llvm.lifetime.start.p0(ptr nonnull %sum)
  store i64 0, ptr %sum, align 8
  %203 = load i64, ptr %n, align 8, !noundef !48
  %_354451.not = icmp eq i64 %203, 0
  br i1 %_354451.not, label %bb73, label %bb160.lr.ph

bb160.lr.ph:                                      ; preds = %bb154
  %204 = getelementptr inbounds nuw i8, ptr %_135, i64 8
  %205 = getelementptr inbounds nuw i8, ptr %_132, i64 8
  br label %bb160

bb153:                                            ; preds = %bb66, %bb69
  %iter7.sroa.0.0450 = phi i32 [ 0, %bb66 ], [ %_352.0, %bb69 ]
  call void @llvm.lifetime.start.p0(ptr nonnull %_124)
  call void @llvm.lifetime.start.p0(ptr nonnull %_126)
  store i8 -1, ptr %_126, align 1
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %_126) #21, !srcloc !73
  call void @llvm.lifetime.start.p0(ptr nonnull %_127)
  store ptr %_341, ptr %_127, align 8
  store i64 %_81.sroa.11285.0, ptr %201, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %_127) #21, !srcloc !73
  %206 = load ptr, ptr %f, align 8, !nonnull !48, !noundef !48
  %207 = load i8, ptr %_126, align 1, !noundef !48
  %208 = load ptr, ptr %_127, align 8, !nonnull !48, !noundef !48
  %209 = load i64, ptr %201, align 8, !noundef !48
  %210 = invoke { i64, i64 } %206(i8 noundef %207, ptr noalias nofree noundef nonnull readonly captures(address, read_provenance) %208, i64 noundef %209)
          to label %bb69 unwind label %cleanup14.loopexit.split-lp.loopexit

bb160:                                            ; preds = %bb160.lr.ph, %bb72
  %_130 = phi i64 [ 0, %bb160.lr.ph ], [ %_129, %bb72 ]
  %iter8.sroa.0.0452 = phi i64 [ 0, %bb160.lr.ph ], [ %_355, %bb72 ]
  call void @llvm.lifetime.start.p0(ptr nonnull %_132)
  call void @llvm.lifetime.start.p0(ptr nonnull %_134)
  store i8 -1, ptr %_134, align 1
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %_134) #21, !srcloc !73
  call void @llvm.lifetime.start.p0(ptr nonnull %_135)
  store ptr %_341, ptr %_135, align 8
  store i64 %_81.sroa.11285.0, ptr %204, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %_135) #21, !srcloc !73
  %211 = load ptr, ptr %f, align 8, !nonnull !48, !noundef !48
  %212 = load i8, ptr %_134, align 1, !noundef !48
  %213 = load ptr, ptr %_135, align 8, !nonnull !48, !noundef !48
  %214 = load i64, ptr %204, align 8, !noundef !48
  %215 = invoke { i64, i64 } %211(i8 noundef %212, ptr noalias nofree noundef nonnull readonly captures(address, read_provenance) %213, i64 noundef %214)
          to label %bb72 unwind label %cleanup14.loopexit

bb73:                                             ; preds = %bb72, %bb154
  %_143 = phi i64 [ 0, %bb154 ], [ %_129, %bb72 ]
  %.lcssa431 = phi i64 [ 0, %bb154 ], [ %227, %bb72 ]
  call void @llvm.lifetime.start.p0(ptr nonnull %_138)
  %_3.i.i = add i64 %_10336304, 1
  %_0.i.i = mul i64 %.lcssa431, %_3.i.i
  %_0.sroa.0.0.i = select i1 %190, i64 %_0.i.i, i64 0
  store i64 %_0.sroa.0.0.i, ptr %_138, align 8
  %_142 = icmp eq i64 %_143, %_0.sroa.0.0.i
  br i1 %_142, label %bb74, label %bb75.invoke, !prof !188

bb75.invoke:                                      ; preds = %bb73, %bb144
  %216 = phi ptr [ %_113, %bb144 ], [ %sum, %bb73 ]
  %217 = phi ptr [ %off, %bb144 ], [ %_138, %bb73 ]
  %218 = phi ptr [ @alloc_e606c281df34283ee24a24505deb5779, %bb144 ], [ @alloc_c14e8c434fcc3b92ba63da8be42f0c60, %bb73 ]
; invoke core::panicking::assert_failed::<usize, usize>
  invoke void @_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedjjEB4_(i8 noundef 0, ptr noalias nofree noundef nonnull readonly align 8 captures(address, read_provenance) dereferenceable(8) %216, ptr noalias nofree noundef nonnull readonly align 8 captures(address, read_provenance) dereferenceable(8) %217, ptr noundef null, ptr undef, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) %218) #22
          to label %bb75.cont unwind label %cleanup14.loopexit.split-lp.loopexit.split-lp

bb75.cont:                                        ; preds = %bb75.invoke
  unreachable

bb74:                                             ; preds = %bb73
  call void @llvm.lifetime.end.p0(ptr nonnull %_138)
  call void @llvm.lifetime.start.p0(ptr nonnull %args5)
  store ptr %n, ptr %args5, align 8
  %_150.sroa.4.0..sroa_idx = getelementptr inbounds nuw i8, ptr %args5, i64 8
  store ptr @_RNvXsi_NtNtNtCsc9NCSoc2doQ_4core3fmt3num3impjNtB9_7Display3fmt, ptr %_150.sroa.4.0..sroa_idx, align 8
  %219 = getelementptr inbounds nuw i8, ptr %args5, i64 16
  store ptr %sum, ptr %219, align 8
  %_151.sroa.4.0..sroa_idx = getelementptr inbounds nuw i8, ptr %args5, i64 24
  store ptr @_RNvXsi_NtNtNtCsc9NCSoc2doQ_4core3fmt3num3impjNtB9_7Display3fmt, ptr %_151.sroa.4.0..sroa_idx, align 8
; invoke std::io::stdio::_print
  invoke void @_RNvNtNtCs341anU20NIK_3std2io5stdio6__print(ptr noundef nonnull @alloc_ea7a11d758a5a3d2649481fea54771bb, ptr noundef nonnull %args5)
          to label %bb77 unwind label %cleanup14.loopexit.split-lp.loopexit.split-lp

bb77:                                             ; preds = %bb74
  call void @llvm.lifetime.end.p0(ptr nonnull %args5)
  call void @llvm.lifetime.end.p0(ptr nonnull %sum)
  call void @llvm.lifetime.end.p0(ptr nonnull %pos)
; call __rustc::__rust_dealloc
  call void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr noundef nonnull %153, i64 noundef 131200, i64 noundef 64) #21
  call void @llvm.lifetime.end.p0(ptr nonnull %n)
  call void @llvm.lifetime.end.p0(ptr nonnull %off)
  call void @llvm.lifetime.end.p0(ptr nonnull %f)
  call void @llvm.experimental.noalias.scope.decl(metadata !220)
  %_1.val1.i180 = load i64, ptr %60, align 8, !alias.scope !220, !noundef !48
  call void @llvm.experimental.noalias.scope.decl(metadata !223)
  %_710.i.i.i181 = icmp eq i64 %_1.val1.i180, 0
  br i1 %_710.i.i.i181, label %bb4.i190, label %bb5.i.i.i182

bb5.i.i.i182:                                     ; preds = %bb77, %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver.exit.i.i.i188
  %_3.sroa.0.011.i.i.i183 = phi i64 [ %220, %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver.exit.i.i.i188 ], [ 0, %bb77 ]
  %_6.i.i.i184 = getelementptr inbounds nuw [24 x i8], ptr %_163, i64 %_3.sroa.0.011.i.i.i183
  %220 = add nuw nsw i64 %_3.sroa.0.011.i.i.i183, 1
  %_6.val.i.i.i185 = load i64, ptr %_6.i.i.i184, align 8, !alias.scope !223, !noalias !220
  %221 = icmp eq i64 %_6.val.i.i.i185, 0
  br i1 %221, label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver.exit.i.i.i188, label %bb2.i.i.i4.i.i.i.i.i186

bb2.i.i.i4.i.i.i.i.i186:                          ; preds = %bb5.i.i.i182
  %222 = getelementptr i8, ptr %_6.i.i.i184, i64 8
  %_6.val7.i.i.i187 = load ptr, ptr %222, align 8, !alias.scope !223, !noalias !220, !nonnull !48, !noundef !48
; call __rustc::__rust_dealloc
  call void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr noundef nonnull %_6.val7.i.i.i187, i64 noundef %_6.val.i.i.i185, i64 noundef range(i64 1, -9223372036854775807) 1) #21, !noalias !226
  br label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver.exit.i.i.i188

_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver.exit.i.i.i188: ; preds = %bb2.i.i.i4.i.i.i.i.i186, %bb5.i.i.i182
  %_7.i.i.i189 = icmp eq i64 %220, %_1.val1.i180
  br i1 %_7.i.i.i189, label %bb4.i190, label %bb5.i.i.i182

bb4.i190:                                         ; preds = %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver.exit.i.i.i188, %bb77
  %_1.val4.i191 = load i64, ptr %args, align 8, !range !52, !alias.scope !220, !noundef !48
  %223 = icmp eq i64 %_1.val4.i191, 0
  br i1 %223, label %bb80, label %bb2.i.i.i6.i192

bb2.i.i.i6.i192:                                  ; preds = %bb4.i190
  %alloc_size.i.i.i.i7.i193 = mul nuw i64 %_1.val4.i191, 24
; call __rustc::__rust_dealloc
  call void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr noundef nonnull %_163, i64 noundef %alloc_size.i.i.i.i7.i193, i64 noundef range(i64 1, -9223372036854775807) 8) #21, !noalias !220
  br label %bb80

bb80:                                             ; preds = %bb2.i.i.i6.i192, %bb4.i190, %bb41
  call void @llvm.lifetime.end.p0(ptr nonnull %args)
  ret void

bb72:                                             ; preds = %bb160
  %_355 = add nuw i64 %iter8.sroa.0.0452, 1
  %_133.0 = extractvalue { i64, i64 } %215, 0
  %_133.1 = extractvalue { i64, i64 } %215, 1
  call void @llvm.lifetime.end.p0(ptr nonnull %_134)
  store i64 %_133.0, ptr %_132, align 8
  store i64 %_133.1, ptr %205, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %_132) #21, !srcloc !73
  %224 = load i64, ptr %_132, align 8, !range !78, !noundef !48
  %225 = load i64, ptr %205, align 8
  %226 = trunc nuw i64 %224 to i1
  %_0.i.i195 = add i64 %225, 1
  %spec.select.i = select i1 %226, i64 %_0.i.i195, i64 0
  call void @llvm.lifetime.end.p0(ptr nonnull %_132)
  %_129 = add i64 %spec.select.i, %_130
  store i64 %_129, ptr %sum, align 8
  call void @llvm.lifetime.end.p0(ptr nonnull %_135)
  %227 = load i64, ptr %n, align 8, !noundef !48
  %_354 = icmp ult i64 %_355, %227
  br i1 %_354, label %bb160, label %bb73

bb69:                                             ; preds = %bb153
  %_352.0 = add nuw nsw i32 %iter7.sroa.0.0450, 1
  %_125.0 = extractvalue { i64, i64 } %210, 0
  %_125.1 = extractvalue { i64, i64 } %210, 1
  call void @llvm.lifetime.end.p0(ptr nonnull %_126)
  store i64 %_125.0, ptr %_124, align 8
  store i64 %_125.1, ptr %202, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %_124) #21, !srcloc !73
  call void @llvm.lifetime.end.p0(ptr nonnull %_127)
  call void @llvm.lifetime.end.p0(ptr nonnull %_124)
  %exitcond.not = icmp eq i32 %_352.0, 1000
  br i1 %exitcond.not, label %bb154, label %bb153

bb5:                                              ; preds = %bb1, %bb40
  %228 = phi i64 [ 0, %bb1 ], [ %236, %bb40 ]
  %iter.sroa.5.0501 = phi i8 [ 0, %bb1 ], [ %230, %bb40 ]
  %229 = icmp eq i8 %iter.sroa.5.0501, -1
  %230 = add i8 %iter.sroa.5.0501, 1
  %231 = icmp eq i8 %230, 0
; call __rustc::__rust_no_alloc_shim_is_unstable_v2
  call void @_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2() #21, !noalias !227
  br i1 %231, label %bb1.i204, label %bb2.i202

bb1.i204:                                         ; preds = %bb5
; call __rustc::__rust_alloc_zeroed
  %232 = call noundef dereferenceable_or_null(4352) ptr @_RNvCshVjSbrpHdcL_7___rustc19___rust_alloc_zeroed(i64 noundef range(i64 1, -9223372036854775808) 4352, i64 noundef range(i64 1, 9) 1) #21, !noalias !230
  %233 = icmp eq ptr %232, null
  br i1 %233, label %bb6.i.invoke, label %bb93

bb2.i202:                                         ; preds = %bb5
; call __rustc::__rust_alloc
  %234 = call noundef dereferenceable_or_null(4352) ptr @_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc(i64 noundef range(i64 0, -9223372036854775808) 4352, i64 noundef range(i64 1, 9) 1) #21, !noalias !233
  %235 = icmp eq ptr %234, null
  br i1 %235, label %bb6.i.invoke, label %_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner16with_capacity_inCs1StpruGFt5h_6driver.exit.i

_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner16with_capacity_inCs1StpruGFt5h_6driver.exit.i: ; preds = %bb2.i202
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 1 dereferenceable(4352) %234, i8 %230, i64 4352, i1 false), !noalias !227
  br label %bb93

bb6.i.invoke:                                     ; preds = %bb1.i204, %bb2.i202
; invoke alloc::raw_vec::handle_error
  invoke void @_RNvNtCs3v2GDSbr0UZ_5alloc7raw_vec12handle_error(i64 noundef 1, i64 4352) #22
          to label %bb6.i.cont unwind label %cleanup

bb6.i.cont:                                       ; preds = %bb6.i.invoke
  unreachable

bb6:                                              ; preds = %bb40
  call void @llvm.lifetime.start.p0(ptr nonnull %args3)
  store ptr %count, ptr %args3, align 8
  %_71.sroa.4.0..sroa_idx = getelementptr inbounds nuw i8, ptr %args3, i64 8
  store ptr @_RNvXsi_NtNtNtCsc9NCSoc2doQ_4core3fmt3num3impjNtB9_7Display3fmt, ptr %_71.sroa.4.0..sroa_idx, align 8
; invoke std::io::stdio::_print
  invoke void @_RNvNtNtCs341anU20NIK_3std2io5stdio6__print(ptr noundef nonnull @alloc_5563914751c9051696d34dc682afe217, ptr noundef nonnull %args3)
          to label %bb41 unwind label %cleanup

bb41:                                             ; preds = %bb6
  call void @llvm.lifetime.end.p0(ptr nonnull %args3)
  call void @llvm.lifetime.end.p0(ptr nonnull %count)
; call core::ptr::drop_glue::<alloc::vec::Vec<alloc::string::String>>
  call fastcc void @_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver(ptr noalias nofree noundef align 8 dereferenceable(24) %args)
  br label %bb80

bb93:                                             ; preds = %_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner16with_capacity_inCs1StpruGFt5h_6driver.exit.i, %bb1.i204
  %data.sroa.6.0 = phi ptr [ %234, %_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner16with_capacity_inCs1StpruGFt5h_6driver.exit.i ], [ %232, %bb1.i204 ]
  call void @llvm.lifetime.start.p0(ptr nonnull %iter1)
  store i64 0, ptr %iter1, align 8
  store i64 21, ptr %_14.sroa.4.0.iter1.sroa_idx, align 8
  store i64 0, ptr %_14.sroa.5.0.iter1.sroa_idx, align 8
  store i64 1, ptr %_14.sroa.6.0.iter1.sroa_idx, align 8
  store i64 7, ptr %_14.sroa.7.0.iter1.sroa_idx, align 8
  store i64 8, ptr %_14.sroa.8.0.iter1.sroa_idx, align 8
  store i64 15, ptr %_14.sroa.9.0.iter1.sroa_idx, align 8
  store i64 16, ptr %_14.sroa.10.0.iter1.sroa_idx, align 8
  store i64 17, ptr %_14.sroa.11.0.iter1.sroa_idx, align 8
  store i64 31, ptr %_14.sroa.12.0.iter1.sroa_idx, align 8
  store i64 32, ptr %_14.sroa.13.0.iter1.sroa_idx, align 8
  store i64 33, ptr %_14.sroa.14.0.iter1.sroa_idx, align 8
  store i64 63, ptr %_14.sroa.15.0.iter1.sroa_idx, align 8
  store i64 64, ptr %_14.sroa.16.0.iter1.sroa_idx, align 8
  store i64 65, ptr %_14.sroa.17.0.iter1.sroa_idx, align 8
  store i64 127, ptr %_14.sroa.18.0.iter1.sroa_idx, align 8
  store i64 128, ptr %_14.sroa.19.0.iter1.sroa_idx, align 8
  store i64 129, ptr %_14.sroa.20.0.iter1.sroa_idx, align 8
  store i64 255, ptr %_14.sroa.21.0.iter1.sroa_idx, align 8
  store i64 256, ptr %_14.sroa.22.0.iter1.sroa_idx, align 8
  store i64 257, ptr %_14.sroa.23.0.iter1.sroa_idx, align 8
  store i64 2551, ptr %_14.sroa.24.0.iter1.sroa_idx, align 8
  store i64 4096, ptr %_14.sroa.25.0.iter1.sroa_idx, align 8
  br label %bb94

bb7.loopexit:                                     ; preds = %bb38, %bb103.us.us
  %236 = phi i64 [ %245, %bb103.us.us ], [ %263, %bb38 ]
  %_5.not.i = icmp eq i64 %_11.i, 21
  br i1 %_5.not.i, label %bb40, label %bb94

cleanup16.loopexit.split:                         ; preds = %bb8.i219, %bb101, %bb8.i240, %bb31
  %lpad.loopexit335 = landingpad { ptr, i32 }
          cleanup
  store i64 %_11.i, ptr %iter1, align 8, !alias.scope !236
  br label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VechEECs1StpruGFt5h_6driver.exit

cleanup16.loopexit.split-lp:                      ; preds = %bb32.invoke, %bb98
  %lpad.loopexit.split-lp336 = landingpad { ptr, i32 }
          cleanup
  br label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VechEECs1StpruGFt5h_6driver.exit

bb94:                                             ; preds = %bb93, %bb7.loopexit
  %237 = phi i64 [ %228, %bb93 ], [ %236, %bb7.loopexit ]
  %238 = phi i64 [ 0, %bb93 ], [ %_11.i, %bb7.loopexit ]
  %_11.i = add nuw nsw i64 %238, 1
  %self3.i = getelementptr inbounds nuw [8 x i8], ptr %_14.sroa.5.0.iter1.sroa_idx, i64 %238
  %_14.i = load i64, ptr %self3.i, align 8, !alias.scope !236, !noundef !48
  %_3.i218 = icmp ult i64 %_14.i, 16
  %_64.not.i = icmp eq i64 %_14.i, 0
  %_3350 = lshr i64 %_14.i, 1
  %_34 = add i64 %_14.i, -1
  %_54 = icmp ugt i64 %_14.i, 2
  br i1 %_64.not.i, label %bb11.thread.us.us, label %bb95

bb11.thread.us.us:                                ; preds = %bb94, %bb103.us.us
  %239 = phi i64 [ %245, %bb103.us.us ], [ %237, %bb94 ]
  %iter6.sroa.0.0457.us.us = phi i64 [ %240, %bb103.us.us ], [ 0, %bb94 ]
  %240 = add nuw nsw i64 %iter6.sroa.0.0457.us.us, 1
  %_209.us.us = getelementptr inbounds nuw i8, ptr %data.sroa.6.0, i64 %iter6.sroa.0.0457.us.us
  call void @llvm.lifetime.start.p0(ptr nonnull %_28)
  %241 = load atomic ptr, ptr @_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw2FN monotonic, align 8, !noalias !239, !nonnull !48, !noundef !48
  %242 = invoke { i64, ptr } %241(i8 noundef %iter.sroa.5.0501, ptr noundef nonnull readonly %_209.us.us, ptr noundef nonnull readonly %_209.us.us)
          to label %.noexc226.us.us unwind label %cleanup16.loopexit.split.us.split.us, !inline_history !244

.noexc226.us.us:                                  ; preds = %bb11.thread.us.us
  %243 = extractvalue { i64, ptr } %242, 0
  %244 = trunc nuw i64 %243 to i1
  br i1 %244, label %bb104, label %bb103.us.us

bb103.us.us:                                      ; preds = %.noexc226.us.us
  call void @llvm.lifetime.end.p0(ptr nonnull %_28)
  %245 = add i64 %239, 1
  store i64 %245, ptr %count, align 8
  %exitcond680.not = icmp eq i64 %240, 64
  br i1 %exitcond680.not, label %bb7.loopexit, label %bb11.thread.us.us

cleanup16.loopexit.split.us.split.us:             ; preds = %bb11.thread.us.us
  %lpad.loopexit335.us.us = landingpad { ptr, i32 }
          cleanup
  store i64 %_11.i, ptr %iter1, align 8, !alias.scope !236
  br label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VechEECs1StpruGFt5h_6driver.exit

_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VechEECs1StpruGFt5h_6driver.exit: ; preds = %cleanup20.loopexit, %cleanup20.loopexit.split-lp, %cleanup16.loopexit.split.us.split.us, %cleanup16.loopexit.split-lp, %cleanup16.loopexit.split
  %.pn.pn = phi { ptr, i32 } [ %lpad.loopexit335.us.us, %cleanup16.loopexit.split.us.split.us ], [ %lpad.loopexit.split-lp336, %cleanup16.loopexit.split-lp ], [ %lpad.loopexit335, %cleanup16.loopexit.split ], [ %lpad.loopexit.split-lp, %cleanup20.loopexit.split-lp ], [ %lpad.loopexit, %cleanup20.loopexit ]
; call __rustc::__rust_dealloc
  call void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr noundef nonnull %data.sroa.6.0, i64 noundef 4352, i64 noundef range(i64 1, -9223372036854775807) 1) #21
  br label %bb85

bb40:                                             ; preds = %bb7.loopexit
  call void @llvm.lifetime.end.p0(ptr nonnull %iter1)
; call __rustc::__rust_dealloc
  call void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr noundef nonnull %data.sroa.6.0, i64 noundef 4352, i64 noundef range(i64 1, -9223372036854775807) 1) #21
  br i1 %229, label %bb6, label %bb5

bb95:                                             ; preds = %bb94, %bb38
  %246 = phi i64 [ %263, %bb38 ], [ %237, %bb94 ]
  %iter6.sroa.0.0457 = phi i64 [ %247, %bb38 ], [ 0, %bb94 ]
  %247 = add nuw nsw i64 %iter6.sroa.0.0457, 1
  %_22 = add nuw nsw i64 %iter6.sroa.0.0457, %_14.i
  %_202.not = icmp ugt i64 %_22, 4352
  br i1 %_202.not, label %bb98, label %bb97, !prof !245

bb98:                                             ; preds = %bb95
  store i64 %_11.i, ptr %iter1, align 8, !alias.scope !236
; invoke core::slice::index::slice_index_fail
  invoke void @_RNvNtNtCsc9NCSoc2doQ_4core5slice5index16slice_index_fail(i64 noundef %iter6.sroa.0.0457, i64 noundef %_22, i64 noundef 4352, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) @alloc_f2adc74b1f56daa88b0b65f22487c555) #22
          to label %unreachable unwind label %cleanup16.loopexit.split-lp

bb97:                                             ; preds = %bb95
  %_209 = getelementptr inbounds nuw i8, ptr %data.sroa.6.0, i64 %iter6.sroa.0.0457
  call void @llvm.lifetime.start.p0(ptr nonnull %_24)
  br i1 %_3.i218, label %bb4.i222, label %bb8.i219

bb8.i219:                                         ; preds = %bb97
; invoke core::slice::memchr::memchr_aligned
  %248 = invoke { i64, i64 } @_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned(i8 noundef %iter.sroa.5.0501, ptr noalias nofree noundef nonnull readonly captures(address, read_provenance) %_209, i64 noundef range(i64 0, -9223372036854775808) %_14.i)
          to label %bb11 unwind label %cleanup16.loopexit.split

bb4.i222:                                         ; preds = %bb97, %bb6.i224
  %i.sroa.0.05.i = phi i64 [ %250, %bb6.i224 ], [ 0, %bb97 ]
  %249 = getelementptr inbounds nuw i8, ptr %_209, i64 %i.sroa.0.05.i
  %_9.i223 = load i8, ptr %249, align 1, !alias.scope !246, !noundef !48
  %_8.i = icmp eq i8 %_9.i223, %iter.sroa.5.0501
  br i1 %_8.i, label %bb11.thread316, label %bb6.i224

bb11.thread316:                                   ; preds = %bb4.i222
  store i64 %_11.i, ptr %iter1, align 8, !alias.scope !236
  store i64 1, ptr %_24, align 8
  store i64 %i.sroa.0.05.i, ptr %92, align 8
  br label %bb32.invoke

bb6.i224:                                         ; preds = %bb4.i222
  %250 = add nuw nsw i64 %i.sroa.0.05.i, 1
  %exitcond.not.i = icmp eq i64 %250, %_14.i
  br i1 %exitcond.not.i, label %bb101, label %bb4.i222

bb11:                                             ; preds = %bb8.i219
  %251 = extractvalue { i64, i64 } %248, 0
  %252 = extractvalue { i64, i64 } %248, 1
  store i64 %251, ptr %_24, align 8
  store i64 %252, ptr %92, align 8
  %253 = trunc nuw i64 %251 to i1
  br i1 %253, label %bb102.loopexit.split, label %bb101, !prof !249

bb102.loopexit.split:                             ; preds = %bb11
  store i64 %_11.i, ptr %iter1, align 8, !alias.scope !236
  br label %bb32.invoke

bb101:                                            ; preds = %bb6.i224, %bb11
  call void @llvm.lifetime.end.p0(ptr nonnull %_24)
  call void @llvm.lifetime.start.p0(ptr nonnull %_28)
  %end.i.i = getelementptr inbounds nuw i8, ptr %_209, i64 %_14.i
  %254 = load atomic ptr, ptr @_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw2FN monotonic, align 8, !noalias !239, !nonnull !48, !noundef !48
  %255 = invoke { i64, ptr } %254(i8 noundef %iter.sroa.5.0501, ptr noundef nonnull readonly %_209, ptr noundef nonnull readonly %end.i.i)
          to label %.noexc226 unwind label %cleanup16.loopexit.split, !inline_history !244

.noexc226:                                        ; preds = %bb101
  %256 = extractvalue { i64, ptr } %255, 0
  %257 = trunc nuw i64 %256 to i1
  br i1 %257, label %bb104, label %bb18

bb104:                                            ; preds = %.noexc226, %.noexc226.us.us
  %_14.i607 = phi i64 [ 0, %.noexc226.us.us ], [ %_14.i, %.noexc226 ]
  %.us-phi467 = phi { i64, ptr } [ %242, %.noexc226.us.us ], [ %255, %.noexc226 ]
  %.us-phi468 = phi ptr [ %_209.us.us, %.noexc226.us.us ], [ %_209, %.noexc226 ]
  store i64 %_11.i, ptr %iter1, align 8, !alias.scope !236
  %258 = extractvalue { i64, ptr } %.us-phi467, 1
  %259 = ptrtoint ptr %258 to i64
  %260 = ptrtoint ptr %.us-phi468 to i64
  %261 = sub i64 %259, %260
  %_13.not.i.i = icmp ult i64 %261, %_14.i607
  call void @llvm.assume(i1 %_13.not.i.i)
  store i64 1, ptr %_28, align 8
  %262 = getelementptr inbounds nuw i8, ptr %_28, i64 8
  store i64 %261, ptr %262, align 8
  br label %bb32.invoke

cleanup20.loopexit:                               ; preds = %bb20.2, %bb8.i262.2, %bb20.1, %bb8.i262.1, %bb8.i262, %bb20
  %lpad.loopexit = landingpad { ptr, i32 }
          cleanup
  store i64 %_11.i, ptr %iter1, align 8, !alias.scope !236
  br label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VechEECs1StpruGFt5h_6driver.exit

cleanup20.loopexit.split-lp:                      ; preds = %bb21.invoke
  %lpad.loopexit.split-lp = landingpad { ptr, i32 }
          cleanup
  br label %_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VechEECs1StpruGFt5h_6driver.exit

bb38:                                             ; preds = %bb34, %bb23.2
  %263 = phi i64 [ %281, %bb34 ], [ %336, %bb23.2 ]
  %exitcond678.not = icmp eq i64 %247, 64
  br i1 %exitcond678.not, label %bb7.loopexit, label %bb95

bb28:                                             ; preds = %bb23.2
  %264 = getelementptr inbounds nuw i8, ptr %_209, i64 1
  store i8 %iter.sroa.5.0501, ptr %264, align 1
  store i8 %iter.sroa.5.0501, ptr %320, align 1
  call void @llvm.lifetime.start.p0(ptr nonnull %_58)
  br i1 %_3.i218, label %bb4.i246, label %bb8.i240

bb8.i240:                                         ; preds = %bb28
; invoke core::slice::memchr::memchr_aligned
  %265 = invoke { i64, i64 } @_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned(i8 noundef %iter.sroa.5.0501, ptr noalias nofree noundef nonnull readonly captures(address, read_provenance) %_209, i64 noundef range(i64 0, -9223372036854775808) %_14.i)
          to label %.noexc252 unwind label %cleanup16.loopexit.split

.noexc252:                                        ; preds = %bb8.i240
  %266 = extractvalue { i64, i64 } %265, 0
  %267 = extractvalue { i64, i64 } %265, 1
  br label %bb30

bb4.i246:                                         ; preds = %bb28, %bb6.i250
  %i.sroa.0.05.i247 = phi i64 [ %269, %bb6.i250 ], [ 0, %bb28 ]
  %268 = getelementptr inbounds nuw i8, ptr %_209, i64 %i.sroa.0.05.i247
  %_9.i248 = load i8, ptr %268, align 1, !alias.scope !250, !noundef !48
  %_8.i249 = icmp eq i8 %_9.i248, %iter.sroa.5.0501
  br i1 %_8.i249, label %bb30, label %bb6.i250

bb6.i250:                                         ; preds = %bb4.i246
  %269 = add nuw nsw i64 %i.sroa.0.05.i247, 1
  %exitcond.not.i251 = icmp eq i64 %269, %_14.i
  br i1 %exitcond.not.i251, label %bb30.thread, label %bb4.i246

bb30.thread:                                      ; preds = %bb6.i250
  store i64 %_11.i, ptr %iter1, align 8, !alias.scope !236
  store i64 0, ptr %_58, align 8
  store i64 %_34, ptr %97, align 8
  br label %bb32.invoke

bb30:                                             ; preds = %bb4.i246, %.noexc252
  %_0.sroa.4.0.i242 = phi i64 [ %267, %.noexc252 ], [ %i.sroa.0.05.i247, %bb4.i246 ]
  %_0.sroa.0.0.i243 = phi i64 [ %266, %.noexc252 ], [ 1, %bb4.i246 ]
  store i64 %_0.sroa.0.0.i243, ptr %_58, align 8
  store i64 %_0.sroa.4.0.i242, ptr %97, align 8
  %270 = trunc nuw i64 %_0.sroa.0.0.i243 to i1
  %_60 = icmp eq i64 %_0.sroa.4.0.i242, 1
  %or.cond = select i1 %270, i1 %_60, i1 false, !prof !219
  br i1 %or.cond, label %bb31, label %bb32.loopexit, !prof !253

bb32.loopexit:                                    ; preds = %bb30
  store i64 %_11.i, ptr %iter1, align 8, !alias.scope !236
  br label %bb32.invoke

bb32.invoke:                                      ; preds = %bb33.thread, %bb35.loopexit, %bb30.thread, %bb32.loopexit, %bb11.thread316, %bb102.loopexit.split, %bb104
  %271 = phi ptr [ %_24, %bb11.thread316 ], [ %_58, %bb30.thread ], [ %_28, %bb104 ], [ %_24, %bb102.loopexit.split ], [ %_58, %bb32.loopexit ], [ %_63, %bb35.loopexit ], [ %_63, %bb33.thread ]
  %272 = phi ptr [ @alloc_8e81dfbcb5e45a532aa30c8331b0b47e, %bb11.thread316 ], [ @alloc_018282178791e8a09b18fbb1ed888779, %bb30.thread ], [ @alloc_8e81dfbcb5e45a532aa30c8331b0b47e, %bb104 ], [ @alloc_8e81dfbcb5e45a532aa30c8331b0b47e, %bb102.loopexit.split ], [ @alloc_018282178791e8a09b18fbb1ed888779, %bb32.loopexit ], [ @alloc_018282178791e8a09b18fbb1ed888779, %bb35.loopexit ], [ @alloc_018282178791e8a09b18fbb1ed888779, %bb33.thread ]
  %273 = phi ptr [ @alloc_9e293b1cd83d8f2c3d64145f659adffa, %bb11.thread316 ], [ @alloc_9a88f186c58a52ebd3ead6ae60a6ebb4, %bb30.thread ], [ @alloc_63fa703696994748cc44a0c124173934, %bb104 ], [ @alloc_9e293b1cd83d8f2c3d64145f659adffa, %bb102.loopexit.split ], [ @alloc_9a88f186c58a52ebd3ead6ae60a6ebb4, %bb32.loopexit ], [ @alloc_7e7ae35d6636461e2066d261a89d0d5e, %bb35.loopexit ], [ @alloc_7e7ae35d6636461e2066d261a89d0d5e, %bb33.thread ]
; invoke core::panicking::assert_failed::<core::option::Option<usize>, core::option::Option<usize>>
  invoke void @_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedINtNtB4_6option6OptionjEBM_EB4_(i8 noundef 0, ptr noalias nofree noundef nonnull readonly align 8 captures(address, read_provenance) dereferenceable(16) %271, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(16) %272, ptr noundef null, ptr undef, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) %273) #22
          to label %bb32.cont unwind label %cleanup16.loopexit.split-lp

bb32.cont:                                        ; preds = %bb32.invoke
  unreachable

bb31:                                             ; preds = %bb30
  call void @llvm.lifetime.end.p0(ptr nonnull %_58)
  call void @llvm.lifetime.start.p0(ptr nonnull %_63)
  %274 = load atomic ptr, ptr @_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw2FN monotonic, align 8, !noalias !254, !nonnull !48, !noundef !48
  %275 = invoke { i64, ptr } %274(i8 noundef %iter.sroa.5.0501, ptr noundef nonnull readonly %_209, ptr noundef nonnull readonly %end.i.i)
          to label %.noexc259 unwind label %cleanup16.loopexit.split, !inline_history !244

.noexc259:                                        ; preds = %bb31
  %276 = extractvalue { i64, ptr } %275, 0
  %277 = trunc nuw i64 %276 to i1
  br i1 %277, label %bb33, label %bb33.thread

bb33.thread:                                      ; preds = %.noexc259
  store i64 %_11.i, ptr %iter1, align 8, !alias.scope !236
  store i64 0, ptr %_63, align 8
  br label %bb32.invoke

bb33:                                             ; preds = %.noexc259
  %278 = extractvalue { i64, ptr } %275, 1
  %279 = ptrtoint ptr %278 to i64
  %280 = sub i64 %279, %283
  %_13.not.i.i258 = icmp ult i64 %280, %_14.i
  call void @llvm.assume(i1 %_13.not.i.i258)
  store i64 1, ptr %_63, align 8
  store i64 %280, ptr %98, align 8
  %_65 = icmp eq i64 %280, 1
  br i1 %_65, label %bb34, label %bb35.loopexit, !prof !253

bb35.loopexit:                                    ; preds = %bb33
  store i64 %_11.i, ptr %iter1, align 8, !alias.scope !236
  br label %bb32.invoke

bb34:                                             ; preds = %bb33
  call void @llvm.lifetime.end.p0(ptr nonnull %_63)
  %281 = add i64 %246, 5
  store i64 %281, ptr %count, align 8
  store i8 %230, ptr %264, align 1
  store i8 %230, ptr %320, align 1
  br label %bb38

bb18:                                             ; preds = %.noexc226
  call void @llvm.lifetime.end.p0(ptr nonnull %_28)
  %282 = add i64 %246, 1
  store i64 %282, ptr %count, align 8
  %283 = ptrtoint ptr %_209 to i64
  store i8 %iter.sroa.5.0501, ptr %_209, align 1
  call void @llvm.lifetime.start.p0(ptr nonnull %_41)
  br i1 %_3.i218, label %bb4.i268, label %bb8.i262

bb8.i262:                                         ; preds = %bb18
; invoke core::slice::memchr::memchr_aligned
  %284 = invoke { i64, i64 } @_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned(i8 noundef %iter.sroa.5.0501, ptr noalias nofree noundef nonnull readonly captures(address, read_provenance) %_209, i64 noundef range(i64 0, -9223372036854775808) %_14.i)
          to label %.noexc274 unwind label %cleanup20.loopexit

.noexc274:                                        ; preds = %bb8.i262
  %285 = extractvalue { i64, i64 } %284, 0
  %286 = extractvalue { i64, i64 } %284, 1
  br label %bb19

bb4.i268:                                         ; preds = %bb18, %bb6.i272
  %i.sroa.0.05.i269 = phi i64 [ %288, %bb6.i272 ], [ 0, %bb18 ]
  %287 = getelementptr inbounds nuw i8, ptr %_209, i64 %i.sroa.0.05.i269
  %_9.i270 = load i8, ptr %287, align 1, !alias.scope !259, !noundef !48
  %_8.i271 = icmp eq i8 %_9.i270, %iter.sroa.5.0501
  br i1 %_8.i271, label %bb19, label %bb6.i272

bb6.i272:                                         ; preds = %bb4.i268
  %288 = add nuw nsw i64 %i.sroa.0.05.i269, 1
  %exitcond.not.i273 = icmp eq i64 %288, %_14.i
  br i1 %exitcond.not.i273, label %bb21.sink.split, label %bb4.i268

bb19:                                             ; preds = %bb4.i268, %.noexc274
  %_0.sroa.4.0.i264 = phi i64 [ %286, %.noexc274 ], [ %i.sroa.0.05.i269, %bb4.i268 ]
  %_0.sroa.0.0.i265 = phi i64 [ %285, %.noexc274 ], [ 1, %bb4.i268 ]
  store i64 %_0.sroa.0.0.i265, ptr %_41, align 8
  store i64 %_0.sroa.4.0.i264, ptr %93, align 8
  call void @llvm.lifetime.start.p0(ptr nonnull %_44)
  store i64 1, ptr %_44, align 8
  store i64 0, ptr %94, align 8
  %289 = trunc nuw i64 %_0.sroa.0.0.i265 to i1
  %290 = icmp eq i64 %_0.sroa.4.0.i264, 0
  %_45.sroa.0.0 = select i1 %289, i1 %290, i1 false
  br i1 %_45.sroa.0.0, label %bb20, label %bb21.invoke, !prof !262

bb21.sink.split:                                  ; preds = %bb6.i272, %bb6.i272.1, %bb6.i272.2
  %_34.lcssa828.sink = phi i64 [ %_3350, %bb6.i272.1 ], [ %_34, %bb6.i272.2 ], [ 0, %bb6.i272 ]
  store i64 0, ptr %_41, align 8
  store i64 %_34, ptr %93, align 8
  call void @llvm.lifetime.start.p0(ptr nonnull %_44)
  store i64 1, ptr %_44, align 8
  store i64 %_34.lcssa828.sink, ptr %94, align 8
  br label %bb21.invoke

bb21.invoke:                                      ; preds = %bb19, %bb19.1, %bb19.2, %bb22, %bb22.1, %bb22.2, %bb21.sink.split, %bb24.sink.split
  %291 = phi ptr [ %_48, %bb24.sink.split ], [ %_41, %bb21.sink.split ], [ %_41, %bb19 ], [ %_41, %bb19.1 ], [ %_41, %bb19.2 ], [ %_48, %bb22 ], [ %_48, %bb22.1 ], [ %_48, %bb22.2 ]
  %292 = phi ptr [ %_51, %bb24.sink.split ], [ %_44, %bb21.sink.split ], [ %_44, %bb19 ], [ %_44, %bb19.1 ], [ %_44, %bb19.2 ], [ %_51, %bb22 ], [ %_51, %bb22.1 ], [ %_51, %bb22.2 ]
  %293 = phi ptr [ @alloc_5cb5418a67bcd818f2b2b52e16b6c0ca, %bb24.sink.split ], [ @alloc_f6eff4434d88d939ba74cb3c7aa163d7, %bb21.sink.split ], [ @alloc_f6eff4434d88d939ba74cb3c7aa163d7, %bb19 ], [ @alloc_f6eff4434d88d939ba74cb3c7aa163d7, %bb19.1 ], [ @alloc_f6eff4434d88d939ba74cb3c7aa163d7, %bb19.2 ], [ @alloc_5cb5418a67bcd818f2b2b52e16b6c0ca, %bb22 ], [ @alloc_5cb5418a67bcd818f2b2b52e16b6c0ca, %bb22.1 ], [ @alloc_5cb5418a67bcd818f2b2b52e16b6c0ca, %bb22.2 ]
  store i64 %_11.i, ptr %iter1, align 8, !alias.scope !236
; invoke core::panicking::assert_failed::<core::option::Option<usize>, core::option::Option<usize>>
  invoke void @_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedINtNtB4_6option6OptionjEBM_EB4_(i8 noundef 0, ptr noalias nofree noundef nonnull readonly align 8 captures(address, read_provenance) dereferenceable(16) %291, ptr noalias nofree noundef nonnull readonly align 8 captures(address, read_provenance) dereferenceable(16) %292, ptr noundef null, ptr undef, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24) %293) #22
          to label %bb21.cont unwind label %cleanup20.loopexit.split-lp

bb21.cont:                                        ; preds = %bb21.invoke
  unreachable

bb20:                                             ; preds = %bb19
  call void @llvm.lifetime.end.p0(ptr nonnull %_44)
  call void @llvm.lifetime.end.p0(ptr nonnull %_41)
  call void @llvm.lifetime.start.p0(ptr nonnull %_48)
  %294 = load atomic ptr, ptr @_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw2FN monotonic, align 8, !noalias !263, !nonnull !48, !noundef !48
  %295 = invoke { i64, ptr } %294(i8 noundef %iter.sroa.5.0501, ptr noundef nonnull readonly %_209, ptr noundef nonnull readonly %end.i.i)
          to label %.noexc281 unwind label %cleanup20.loopexit, !inline_history !244

.noexc281:                                        ; preds = %bb20
  %296 = extractvalue { i64, ptr } %295, 0
  %297 = trunc nuw i64 %296 to i1
  br i1 %297, label %bb22, label %bb24.sink.split

bb22:                                             ; preds = %.noexc281
  %298 = extractvalue { i64, ptr } %295, 1
  %299 = ptrtoint ptr %298 to i64
  %300 = sub i64 %299, %283
  %_13.not.i.i280 = icmp ult i64 %300, %_14.i
  call void @llvm.assume(i1 %_13.not.i.i280)
  store i64 1, ptr %_48, align 8
  store i64 %300, ptr %95, align 8
  call void @llvm.lifetime.start.p0(ptr nonnull %_51)
  store i64 1, ptr %_51, align 8
  store i64 0, ptr %96, align 8
  %301 = icmp eq ptr %298, %_209
  br i1 %301, label %bb18.1, label %bb21.invoke, !prof !262

bb24.sink.split:                                  ; preds = %.noexc281, %.noexc281.2, %.noexc281.1
  %_34.lcssa829.sink = phi i64 [ %_3350, %.noexc281.1 ], [ %_34, %.noexc281.2 ], [ 0, %.noexc281 ]
  store i64 0, ptr %_48, align 8
  call void @llvm.lifetime.start.p0(ptr nonnull %_51)
  store i64 1, ptr %_51, align 8
  store i64 %_34.lcssa829.sink, ptr %96, align 8
  br label %bb21.invoke

bb18.1:                                           ; preds = %bb22
  call void @llvm.lifetime.end.p0(ptr nonnull %_51)
  call void @llvm.lifetime.end.p0(ptr nonnull %_48)
  %302 = add i64 %246, 2
  store i64 %302, ptr %count, align 8
  store i8 %230, ptr %_209, align 1
  %303 = getelementptr inbounds nuw i8, ptr %_209, i64 %_3350
  store i8 %iter.sroa.5.0501, ptr %303, align 1
  call void @llvm.lifetime.start.p0(ptr nonnull %_41)
  br i1 %_3.i218, label %bb4.i268.1, label %bb8.i262.1

bb8.i262.1:                                       ; preds = %bb18.1
; invoke core::slice::memchr::memchr_aligned
  %304 = invoke { i64, i64 } @_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned(i8 noundef %iter.sroa.5.0501, ptr noalias nofree noundef nonnull readonly captures(address, read_provenance) %_209, i64 noundef range(i64 0, -9223372036854775808) %_14.i)
          to label %.noexc274.1 unwind label %cleanup20.loopexit

.noexc274.1:                                      ; preds = %bb8.i262.1
  %305 = extractvalue { i64, i64 } %304, 0
  %306 = extractvalue { i64, i64 } %304, 1
  br label %bb19.1

bb4.i268.1:                                       ; preds = %bb18.1, %bb6.i272.1
  %i.sroa.0.05.i269.1 = phi i64 [ %308, %bb6.i272.1 ], [ 0, %bb18.1 ]
  %307 = getelementptr inbounds nuw i8, ptr %_209, i64 %i.sroa.0.05.i269.1
  %_9.i270.1 = load i8, ptr %307, align 1, !alias.scope !259, !noundef !48
  %_8.i271.1 = icmp eq i8 %_9.i270.1, %iter.sroa.5.0501
  br i1 %_8.i271.1, label %bb19.1, label %bb6.i272.1

bb6.i272.1:                                       ; preds = %bb4.i268.1
  %308 = add nuw nsw i64 %i.sroa.0.05.i269.1, 1
  %exitcond.not.i273.1 = icmp eq i64 %308, %_14.i
  br i1 %exitcond.not.i273.1, label %bb21.sink.split, label %bb4.i268.1

bb19.1:                                           ; preds = %bb4.i268.1, %.noexc274.1
  %_0.sroa.4.0.i264.1 = phi i64 [ %306, %.noexc274.1 ], [ %i.sroa.0.05.i269.1, %bb4.i268.1 ]
  %_0.sroa.0.0.i265.1 = phi i64 [ %305, %.noexc274.1 ], [ 1, %bb4.i268.1 ]
  store i64 %_0.sroa.0.0.i265.1, ptr %_41, align 8
  store i64 %_0.sroa.4.0.i264.1, ptr %93, align 8
  call void @llvm.lifetime.start.p0(ptr nonnull %_44)
  store i64 1, ptr %_44, align 8
  store i64 %_3350, ptr %94, align 8
  %309 = trunc nuw i64 %_0.sroa.0.0.i265.1 to i1
  %310 = icmp eq i64 %_0.sroa.4.0.i264.1, %_3350
  %_45.sroa.0.0.1 = select i1 %309, i1 %310, i1 false
  br i1 %_45.sroa.0.0.1, label %bb20.1, label %bb21.invoke, !prof !262

bb20.1:                                           ; preds = %bb19.1
  call void @llvm.lifetime.end.p0(ptr nonnull %_44)
  call void @llvm.lifetime.end.p0(ptr nonnull %_41)
  call void @llvm.lifetime.start.p0(ptr nonnull %_48)
  %311 = load atomic ptr, ptr @_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw2FN monotonic, align 8, !noalias !263, !nonnull !48, !noundef !48
  %312 = invoke { i64, ptr } %311(i8 noundef %iter.sroa.5.0501, ptr noundef nonnull readonly %_209, ptr noundef nonnull readonly %end.i.i)
          to label %.noexc281.1 unwind label %cleanup20.loopexit, !inline_history !244

.noexc281.1:                                      ; preds = %bb20.1
  %313 = extractvalue { i64, ptr } %312, 0
  %314 = trunc nuw i64 %313 to i1
  br i1 %314, label %bb22.1, label %bb24.sink.split

bb22.1:                                           ; preds = %.noexc281.1
  %315 = extractvalue { i64, ptr } %312, 1
  %316 = ptrtoint ptr %315 to i64
  %317 = sub i64 %316, %283
  %_13.not.i.i280.1 = icmp ult i64 %317, %_14.i
  call void @llvm.assume(i1 %_13.not.i.i280.1)
  store i64 1, ptr %_48, align 8
  store i64 %317, ptr %95, align 8
  call void @llvm.lifetime.start.p0(ptr nonnull %_51)
  store i64 1, ptr %_51, align 8
  store i64 %_3350, ptr %96, align 8
  %318 = icmp eq i64 %317, %_3350
  br i1 %318, label %bb18.2, label %bb21.invoke, !prof !262

bb18.2:                                           ; preds = %bb22.1
  call void @llvm.lifetime.end.p0(ptr nonnull %_51)
  call void @llvm.lifetime.end.p0(ptr nonnull %_48)
  %319 = add i64 %246, 3
  store i64 %319, ptr %count, align 8
  store i8 %230, ptr %303, align 1
  %320 = getelementptr inbounds nuw i8, ptr %_209, i64 %_34
  store i8 %iter.sroa.5.0501, ptr %320, align 1
  call void @llvm.lifetime.start.p0(ptr nonnull %_41)
  br i1 %_3.i218, label %bb4.i268.2, label %bb8.i262.2

bb8.i262.2:                                       ; preds = %bb18.2
; invoke core::slice::memchr::memchr_aligned
  %321 = invoke { i64, i64 } @_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned(i8 noundef %iter.sroa.5.0501, ptr noalias nofree noundef nonnull readonly captures(address, read_provenance) %_209, i64 noundef range(i64 0, -9223372036854775808) %_14.i)
          to label %.noexc274.2 unwind label %cleanup20.loopexit

.noexc274.2:                                      ; preds = %bb8.i262.2
  %322 = extractvalue { i64, i64 } %321, 0
  %323 = extractvalue { i64, i64 } %321, 1
  br label %bb19.2

bb4.i268.2:                                       ; preds = %bb18.2, %bb6.i272.2
  %i.sroa.0.05.i269.2 = phi i64 [ %325, %bb6.i272.2 ], [ 0, %bb18.2 ]
  %324 = getelementptr inbounds nuw i8, ptr %_209, i64 %i.sroa.0.05.i269.2
  %_9.i270.2 = load i8, ptr %324, align 1, !alias.scope !259, !noundef !48
  %_8.i271.2 = icmp eq i8 %_9.i270.2, %iter.sroa.5.0501
  br i1 %_8.i271.2, label %bb19.2, label %bb6.i272.2

bb6.i272.2:                                       ; preds = %bb4.i268.2
  %325 = add nuw nsw i64 %i.sroa.0.05.i269.2, 1
  %exitcond.not.i273.2 = icmp eq i64 %325, %_14.i
  br i1 %exitcond.not.i273.2, label %bb21.sink.split, label %bb4.i268.2

bb19.2:                                           ; preds = %bb4.i268.2, %.noexc274.2
  %_0.sroa.4.0.i264.2 = phi i64 [ %323, %.noexc274.2 ], [ %i.sroa.0.05.i269.2, %bb4.i268.2 ]
  %_0.sroa.0.0.i265.2 = phi i64 [ %322, %.noexc274.2 ], [ 1, %bb4.i268.2 ]
  store i64 %_0.sroa.0.0.i265.2, ptr %_41, align 8
  store i64 %_0.sroa.4.0.i264.2, ptr %93, align 8
  call void @llvm.lifetime.start.p0(ptr nonnull %_44)
  store i64 1, ptr %_44, align 8
  store i64 %_34, ptr %94, align 8
  %326 = trunc nuw i64 %_0.sroa.0.0.i265.2 to i1
  %327 = icmp eq i64 %_0.sroa.4.0.i264.2, %_34
  %_45.sroa.0.0.2 = select i1 %326, i1 %327, i1 false
  br i1 %_45.sroa.0.0.2, label %bb20.2, label %bb21.invoke, !prof !262

bb20.2:                                           ; preds = %bb19.2
  call void @llvm.lifetime.end.p0(ptr nonnull %_44)
  call void @llvm.lifetime.end.p0(ptr nonnull %_41)
  call void @llvm.lifetime.start.p0(ptr nonnull %_48)
  %328 = load atomic ptr, ptr @_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw2FN monotonic, align 8, !noalias !263, !nonnull !48, !noundef !48
  %329 = invoke { i64, ptr } %328(i8 noundef %iter.sroa.5.0501, ptr noundef nonnull readonly %_209, ptr noundef nonnull readonly %end.i.i)
          to label %.noexc281.2 unwind label %cleanup20.loopexit, !inline_history !244

.noexc281.2:                                      ; preds = %bb20.2
  %330 = extractvalue { i64, ptr } %329, 0
  %331 = trunc nuw i64 %330 to i1
  br i1 %331, label %bb22.2, label %bb24.sink.split

bb22.2:                                           ; preds = %.noexc281.2
  %332 = extractvalue { i64, ptr } %329, 1
  %333 = ptrtoint ptr %332 to i64
  %334 = sub i64 %333, %283
  %_13.not.i.i280.2 = icmp ult i64 %334, %_14.i
  call void @llvm.assume(i1 %_13.not.i.i280.2)
  store i64 1, ptr %_48, align 8
  store i64 %334, ptr %95, align 8
  call void @llvm.lifetime.start.p0(ptr nonnull %_51)
  store i64 1, ptr %_51, align 8
  store i64 %_34, ptr %96, align 8
  %335 = icmp eq i64 %334, %_34
  br i1 %335, label %bb23.2, label %bb21.invoke, !prof !262

bb23.2:                                           ; preds = %bb22.2
  call void @llvm.lifetime.end.p0(ptr nonnull %_51)
  call void @llvm.lifetime.end.p0(ptr nonnull %_48)
  %336 = add i64 %246, 4
  store i64 %336, ptr %count, align 8
  store i8 %230, ptr %320, align 1
  br i1 %_54, label %bb28, label %bb38
}

; driver::std_find
; Function Attrs: nonlazybind uwtable
define internal { i64, i64 } @_RNvCs1StpruGFt5h_6driver8std_find(i8 noundef %x, ptr noalias nofree noundef nonnull readonly captures(address, read_provenance) %s.0, i64 noundef range(i64 0, -9223372036854775808) %s.1) unnamed_addr #0 !guid !268 {
start:
  %_3 = icmp samesign ult i64 %s.1, 16
  br i1 %_3, label %bb2.preheader, label %bb8

bb2.preheader:                                    ; preds = %start
  %_64.not = icmp eq i64 %s.1, 0
  br i1 %_64.not, label %bb10, label %bb4

bb8:                                              ; preds = %start
; call core::slice::memchr::memchr_aligned
  %0 = tail call { i64, i64 } @_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned(i8 noundef %x, ptr noalias nofree noundef nonnull readonly captures(address, read_provenance) %s.0, i64 noundef %s.1)
  %1 = extractvalue { i64, i64 } %0, 0
  %2 = extractvalue { i64, i64 } %0, 1
  br label %bb10

bb10:                                             ; preds = %bb6, %bb4, %bb2.preheader, %bb8
  %_0.sroa.4.0 = phi i64 [ %2, %bb8 ], [ undef, %bb2.preheader ], [ %i.sroa.0.05, %bb4 ], [ %i.sroa.0.05, %bb6 ]
  %_0.sroa.0.0 = phi i64 [ %1, %bb8 ], [ 0, %bb2.preheader ], [ 0, %bb6 ], [ 1, %bb4 ]
  %3 = insertvalue { i64, i64 } poison, i64 %_0.sroa.0.0, 0
  %4 = insertvalue { i64, i64 } %3, i64 %_0.sroa.4.0, 1
  ret { i64, i64 } %4

bb4:                                              ; preds = %bb2.preheader, %bb6
  %i.sroa.0.05 = phi i64 [ %6, %bb6 ], [ 0, %bb2.preheader ]
  %5 = getelementptr inbounds nuw i8, ptr %s.0, i64 %i.sroa.0.05
  %_9 = load i8, ptr %5, align 1, !noundef !48
  %_8 = icmp eq i8 %_9, %x
  br i1 %_8, label %bb10, label %bb6

bb6:                                              ; preds = %bb4
  %6 = add nuw nsw i64 %i.sroa.0.05, 1
  %exitcond.not = icmp eq i64 %6, %s.1
  br i1 %exitcond.not, label %bb10, label %bb4
}

; <alloc::raw_vec::RawVecInner>::finish_grow
; Function Attrs: cold nounwind nonlazybind uwtable
define internal fastcc void @_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs1StpruGFt5h_6driver(ptr dead_on_unwind noalias nofree noundef nonnull writable writeonly align 8 captures(none) dereferenceable(24) initializes((0, 8)) %_0, i64 %self.0.val, ptr %self.8.val, i64 noundef %cap) unnamed_addr #5 !guid !269 {
start:
  %_32.0 = mul i64 %cap, 24
  %or.cond.not = icmp ugt i64 %cap, 384307168202282325
  br i1 %or.cond.not, label %bb8, label %bb12, !prof !119

bb12:                                             ; preds = %start
  %0 = icmp eq i64 %self.0.val, 0
  br i1 %0, label %bb5, label %bb3

bb3:                                              ; preds = %bb12
  %alloc_size.i = mul nuw i64 %self.0.val, 24
  call void @llvm.assume(i1 true) [ "nonnull"(ptr %self.8.val) ]
  %cond.i.i = icmp uge i64 %_32.0, %alloc_size.i
  tail call void @llvm.assume(i1 %cond.i.i)
; call __rustc::__rust_realloc
  %raw_ptr.i.i = tail call noundef align 8 ptr @_RNvCshVjSbrpHdcL_7___rustc14___rust_realloc(ptr noundef nonnull %self.8.val, i64 noundef %alloc_size.i, i64 noundef 8, i64 noundef range(i64 0, 9223372036854775801) %_32.0) #21
  br label %bb7

bb5:                                              ; preds = %bb12
  %1 = icmp eq i64 %_32.0, 0
  br i1 %1, label %bb19, label %bb1.i.i

bb1.i.i:                                          ; preds = %bb5
; call __rustc::__rust_no_alloc_shim_is_unstable_v2
  tail call void @_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2() #21
; call __rustc::__rust_alloc
  %2 = tail call noundef align 8 ptr @_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc(i64 noundef range(i64 0, -9223372036854775808) %_32.0, i64 noundef range(i64 1, 65) 8) #21
  br label %bb7

bb7:                                              ; preds = %bb1.i.i, %bb3
  %raw_ptr.i.i.pn = phi ptr [ %raw_ptr.i.i, %bb3 ], [ %2, %bb1.i.i ]
  %3 = icmp eq ptr %raw_ptr.i.i.pn, null
  br i1 %3, label %bb18, label %bb19

bb18:                                             ; preds = %bb7
  %4 = getelementptr inbounds nuw i8, ptr %_0, i64 8
  store i64 8, ptr %4, align 8
  br label %bb8

bb19:                                             ; preds = %bb5, %bb7
  %raw_ptr.i.i.pn8 = phi ptr [ %raw_ptr.i.i.pn, %bb7 ], [ inttoptr (i64 8 to ptr), %bb5 ]
  %5 = getelementptr inbounds nuw i8, ptr %_0, i64 8
  store ptr %raw_ptr.i.i.pn8, ptr %5, align 8
  br label %bb8

bb8:                                              ; preds = %start, %bb19, %bb18
  %.sink10 = phi i64 [ 16, %bb19 ], [ 16, %bb18 ], [ 8, %start ]
  %_32.0.sink = phi i64 [ %_32.0, %bb19 ], [ %_32.0, %bb18 ], [ 0, %start ]
  %.sink = phi i64 [ 0, %bb19 ], [ 1, %bb18 ], [ 1, %start ]
  %6 = getelementptr inbounds nuw i8, ptr %_0, i64 %.sink10
  store i64 %_32.0.sink, ptr %6, align 8
  store i64 %.sink, ptr %_0, align 8
  ret void
}

; <&core::num::error::IntErrorKind as core::fmt::Debug>::fmt
; Function Attrs: nonlazybind uwtable
define internal noundef zeroext i1 @_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver(ptr noalias nofree noundef readonly align 8 captures(none) dereferenceable(8) %self, ptr noalias nofree noundef align 8 dereferenceable(24) %f) unnamed_addr #0 !guid !270 {
start:
  %_3 = load ptr, ptr %self, align 8, !nonnull !48, !noundef !48
  %_3.val = load i8, ptr %_3, align 1, !range !271, !noundef !48
  %0 = zext nneg i8 %_3.val to i64
  %switch.gep = getelementptr inbounds nuw i8, ptr @switch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver, i64 %0
  %switch.load = load i8, ptr %switch.gep, align 1
  %switch.ext = zext i8 %switch.load to i64
  %1 = zext nneg i8 %_3.val to i64
  %reltable.shift = shl i64 %1, 2
  %reltable.intrinsic = call ptr @llvm.load.relative.i64(ptr @switch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.36.rel, i64 %reltable.shift)
; call <core::fmt::Formatter>::write_str
  %_0.i = tail call noundef zeroext i1 @_RNvMsa_NtCsc9NCSoc2doQ_4core3fmtNtB5_9Formatter9write_str(ptr noalias nofree noundef nonnull align 8 dereferenceable(24) %f, ptr noalias nofree noundef nonnull readonly captures(address, read_provenance) %reltable.intrinsic, i64 noundef %switch.ext)
  ret i1 %_0.i
}

; <core::num::error::ParseIntError as core::fmt::Debug>::fmt
; Function Attrs: inlinehint nonlazybind uwtable
define internal noundef zeroext i1 @_RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt(ptr noalias nofree noundef readonly captures(address, read_provenance) dereferenceable(1) %self, ptr noalias nofree noundef align 8 dereferenceable(24) %f) unnamed_addr #4 !guid !272 {
start:
  %_5 = alloca [8 x i8], align 8
  call void @llvm.lifetime.start.p0(ptr nonnull %_5)
  store ptr %self, ptr %_5, align 8
; call <core::fmt::Formatter>::debug_struct_field1_finish
  %_0 = call noundef zeroext i1 @_RNvMsa_NtCsc9NCSoc2doQ_4core3fmtNtB5_9Formatter26debug_struct_field1_finish(ptr noalias nofree noundef nonnull align 8 dereferenceable(24) %f, ptr noalias nofree noundef nonnull readonly captures(address, read_provenance) @alloc_f62df14955f7d78bca139b0a7668683d, i64 noundef 13, ptr noalias nofree noundef nonnull readonly captures(address, read_provenance) @alloc_a5d866b1768ad3f826bccdb004a1a8ae, i64 noundef 4, ptr noundef nonnull %_5, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(32) @vtable.2)
  call void @llvm.lifetime.end.p0(ptr nonnull %_5)
  ret i1 %_0
}

; Function Attrs: nounwind nonlazybind uwtable
declare noundef range(i32 0, 10) i32 @rust_eh_personality(i32 noundef, i32 noundef, i64 noundef, ptr noundef, ptr noundef) unnamed_addr #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(ptr captures(none)) #6

; <std::env::Args as core::iter::traits::iterator::Iterator>::next
; Function Attrs: nonlazybind uwtable
declare void @_RNvXsc_NtCs341anU20NIK_3std3envNtB5_4ArgsNtNtNtNtCsc9NCSoc2doQ_4core4iter6traits8iterator8Iterator4next(ptr dead_on_unwind noalias nofree noundef writable sret([24 x i8]) align 8 captures(none) dereferenceable(24), ptr noalias nofree noundef align 8 dereferenceable(32)) unnamed_addr #0

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #7

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(ptr captures(none)) #6

; std::rt::lang_start_internal
; Function Attrs: nonlazybind uwtable
declare noundef i64 @_RNvNtCs341anU20NIK_3std2rt19lang_start_internal(ptr noundef nonnull, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(48), i64 noundef, ptr noundef, i8 noundef) unnamed_addr #0

; alloc::raw_vec::handle_error
; Function Attrs: cold minsize noreturn nonlazybind optsize uwtable
declare void @_RNvNtCs3v2GDSbr0UZ_5alloc7raw_vec12handle_error(i64 noundef range(i64 0, -9223372036854775807), i64) unnamed_addr #8

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr writeonly captures(none), i8, i64, i1 immarg) #9

; std::env::args
; Function Attrs: nonlazybind uwtable
declare void @_RNvNtCs341anU20NIK_3std3env4args(ptr dead_on_unwind noalias nofree noundef writable sret([32 x i8]) align 8 captures(none) dereferenceable(32)) unnamed_addr #0

; core::panicking::panic_bounds_check
; Function Attrs: cold minsize noinline noreturn nonlazybind optsize uwtable
declare void @_RNvNtCsc9NCSoc2doQ_4core9panicking18panic_bounds_check(i64 noundef, i64 noundef, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24)) unnamed_addr #10

; core::panicking::panic
; Function Attrs: cold noinline noreturn nonlazybind uwtable
declare void @_RNvNtCsc9NCSoc2doQ_4core9panicking5panic(ptr noalias nofree noundef nonnull readonly captures(address, read_provenance), i64 noundef, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24)) unnamed_addr #11

; core::panicking::assert_failed::<usize, usize>
; Function Attrs: cold minsize noinline noreturn nonlazybind optsize uwtable
declare void @_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedjjEB4_(i8 noundef range(i8 0, 3), ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(8), ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(8), ptr noundef, ptr, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24)) unnamed_addr #10

; core::panicking::assert_failed::<core::option::Option<usize>, core::option::Option<usize>>
; Function Attrs: cold minsize noinline noreturn nonlazybind optsize uwtable
declare void @_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedINtNtB4_6option6OptionjEBM_EB4_(i8 noundef range(i8 0, 3), ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(16), ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(16), ptr noundef, ptr, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24)) unnamed_addr #10

; <usize as core::fmt::Display>::fmt
; Function Attrs: nonlazybind uwtable
declare noundef zeroext i1 @_RNvXsi_NtNtNtCsc9NCSoc2doQ_4core3fmt3num3impjNtB9_7Display3fmt(ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(8), ptr noalias nofree noundef align 8 dereferenceable(24)) unnamed_addr #0

; std::io::stdio::_print
; Function Attrs: nonlazybind uwtable
declare void @_RNvNtNtCs341anU20NIK_3std2io5stdio6__print(ptr noundef nonnull, ptr noundef nonnull) unnamed_addr #0

; core::slice::index::slice_index_fail
; Function Attrs: cold noinline noreturn nonlazybind uwtable
declare void @_RNvNtNtCsc9NCSoc2doQ_4core5slice5index16slice_index_fail(i64 noundef, i64 noundef, i64 noundef, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24)) unnamed_addr #11

; core::slice::memchr::memchr_aligned
; Function Attrs: nonlazybind uwtable
declare { i64, i64 } @_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned(i8 noundef, ptr noalias nofree noundef nonnull readonly captures(address, read_provenance), i64 noundef range(i64 0, -9223372036854775808)) unnamed_addr #0

; __rustc::__rust_dealloc
; Function Attrs: nounwind nonlazybind allockind("free") uwtable
declare void @_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc(ptr allocptr noundef nonnull captures(address), i64 noundef, i64 noundef range(i64 1, -9223372036854775807)) unnamed_addr #12

; __rustc::__rust_realloc
; Function Attrs: nounwind nonlazybind allockind("realloc,aligned") allocsize(3) uwtable
declare noalias noundef ptr @_RNvCshVjSbrpHdcL_7___rustc14___rust_realloc(ptr allocptr noundef nonnull, i64 noundef, i64 allocalign noundef range(i64 1, -9223372036854775807), i64 noundef) unnamed_addr #13

; __rustc::__rust_no_alloc_shim_is_unstable_v2
; Function Attrs: nounwind nonlazybind uwtable
declare void @_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2() unnamed_addr #1

; __rustc::__rust_alloc
; Function Attrs: nounwind nonlazybind allockind("alloc,uninitialized,aligned") allocsize(0) uwtable
declare noalias noundef ptr @_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc(i64 noundef, i64 allocalign noundef range(i64 1, -9223372036854775807)) unnamed_addr #14

; __rustc::__rust_alloc_zeroed
; Function Attrs: nounwind nonlazybind allockind("alloc,zeroed,aligned") allocsize(0) uwtable
declare noalias noundef ptr @_RNvCshVjSbrpHdcL_7___rustc19___rust_alloc_zeroed(i64 noundef, i64 allocalign noundef range(i64 1, -9223372036854775807)) unnamed_addr #15

; core::result::unwrap_failed
; Function Attrs: cold noinline noreturn nonlazybind uwtable
declare void @_RNvNtCsc9NCSoc2doQ_4core6result13unwrap_failed(ptr noalias nofree noundef nonnull readonly captures(address, read_provenance), i64 noundef, ptr noundef nonnull, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(32), ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(24)) unnamed_addr #11

; Function Attrs: mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64) #16

; alloc::alloc::handle_alloc_error
; Function Attrs: cold minsize noreturn nonlazybind optsize uwtable
declare void @_RNvNtCs3v2GDSbr0UZ_5alloc5alloc18handle_alloc_error(i64 noundef range(i64 1, -9223372036854775807), i64 noundef) unnamed_addr #8

; <core::fmt::Formatter>::debug_struct_field1_finish
; Function Attrs: nonlazybind uwtable
declare noundef zeroext i1 @_RNvMsa_NtCsc9NCSoc2doQ_4core3fmtNtB5_9Formatter26debug_struct_field1_finish(ptr noalias nofree noundef align 8 dereferenceable(24), ptr noalias nofree noundef nonnull readonly captures(address, read_provenance), i64 noundef, ptr noalias nofree noundef nonnull readonly captures(address, read_provenance), i64 noundef, ptr noundef nonnull, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(32)) unnamed_addr #0

; <core::fmt::Formatter>::write_str
; Function Attrs: nonlazybind uwtable
declare noundef zeroext i1 @_RNvMsa_NtCsc9NCSoc2doQ_4core3fmtNtB5_9Formatter9write_str(ptr noalias nofree noundef align 8 dereferenceable(24), ptr noalias nofree noundef nonnull readonly captures(address, read_provenance), i64 noundef) unnamed_addr #0

; Function Attrs: nonlazybind
define noundef i32 @main(i32 %0, ptr %1) unnamed_addr #17 !guid !273 {
top:
  %_7.i = alloca [8 x i8], align 8
  %2 = sext i32 %0 to i64
  call void @llvm.lifetime.start.p0(ptr nonnull %_7.i)
  store ptr @_RNvCs1StpruGFt5h_6driver4main, ptr %_7.i, align 8
; call std::rt::lang_start_internal
  %_0.i = call noundef i64 @_RNvNtCs341anU20NIK_3std2rt19lang_start_internal(ptr noundef nonnull %_7.i, ptr noalias nofree noundef readonly align 8 captures(address, read_provenance) dereferenceable(48) @vtable.0, i64 noundef %2, ptr noundef %1, i8 noundef 0)
  call void @llvm.lifetime.end.p0(ptr nonnull %_7.i)
  %3 = trunc i64 %_0.i to i32
  ret i32 %3
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.experimental.noalias.scope.decl(metadata) #18

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.umax.i64(i64, i64) #19

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: read)
declare ptr @llvm.load.relative.i64(ptr, i64) #20

attributes #0 = { nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #1 = { nounwind nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #2 = { noinline nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #3 = { cold nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #4 = { inlinehint nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #5 = { cold nounwind nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #6 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #7 = { mustprogress nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }
attributes #8 = { cold minsize noreturn nonlazybind optsize uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #9 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: write) }
attributes #10 = { cold minsize noinline noreturn nonlazybind optsize uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #11 = { cold noinline noreturn nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #12 = { nounwind nonlazybind allockind("free") uwtable "alloc-family"="__rust_alloc" "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #13 = { nounwind nonlazybind allockind("realloc,aligned") allocsize(3) uwtable "alloc-family"="__rust_alloc" "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #14 = { nounwind nonlazybind allockind("alloc,uninitialized,aligned") allocsize(0) uwtable "alloc-family"="__rust_alloc" "alloc-variant-zeroed"="_RNvCshVjSbrpHdcL_7___rustc19___rust_alloc_zeroed" "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #15 = { nounwind nonlazybind allockind("alloc,zeroed,aligned") allocsize(0) uwtable "alloc-family"="__rust_alloc" "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #16 = { mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #17 = { nonlazybind "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #18 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
attributes #19 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #20 = { nocallback nofree nosync nounwind willreturn memory(argmem: read) }
attributes #21 = { nounwind }
attributes #22 = { noreturn }
attributes #23 = { noinline }
attributes #24 = { cold }
attributes #25 = { noinline noreturn }

!llvm.module.flags = !{!41, !42, !43, !44}
!llvm.ident = !{!45}

!0 = !{i64 2558088239597058794}
!1 = !{i64 5903898558041300050}
!2 = !{i64 6241436570622014191}
!3 = !{i64 -2603577077814442048}
!4 = !{i64 -281887334349090911}
!5 = !{i64 -4481627312539784888}
!6 = !{i64 7519368446718232472}
!7 = !{i64 -824215671750688315}
!8 = !{i64 7054427302531919577}
!9 = !{i64 4185290911287677870}
!10 = !{i64 2001007222183860463}
!11 = !{i64 -6056404161149903701}
!12 = !{i64 -7379709749979372386}
!13 = !{i64 -5910309155911468755}
!14 = !{i64 -1964514995838354434}
!15 = !{i64 -7318236363116312795}
!16 = !{i64 -8825468316179816660}
!17 = !{i64 4720762197656767014}
!18 = !{i64 -8725476730243977279}
!19 = !{i64 -3234462715413273473}
!20 = !{i64 1448549592035940339}
!21 = !{i64 -8253342551048328786}
!22 = !{i64 874759421678295614}
!23 = !{i64 1993670137530791074}
!24 = !{i64 -1464527085550673418}
!25 = !{i64 -2798700934356623232}
!26 = !{i64 -1599649493835274061}
!27 = !{i64 3574469868183640435}
!28 = !{i64 5124332446755194994}
!29 = !{i64 7952816885497808793}
!30 = !{i64 4928569460531206698}
!31 = !{i64 7177570488855135163}
!32 = !{i64 -4150495316459156570}
!33 = !{i64 3836606134607428351}
!34 = !{i64 -8535846261211500984}
!35 = !{i64 5129875655740982280}
!36 = !{i64 2319107653298126579}
!37 = !{i64 4295019936155307106}
!38 = !{i64 -8073843985114946354}
!39 = !{i64 -5976206998442655622}
!40 = !{i64 -5452382628297890095}
!41 = !{i32 8, !"PIC Level", i32 2}
!42 = !{i32 7, !"PIE Level", i32 2}
!43 = !{i32 2, !"RtLibUseGOT", i32 1}
!44 = !{i32 7, !"uwtable", i32 2}
!45 = !{!"rustc version 1.99.0-dev"}
!46 = !{i64 -8965480478534108009}
!47 = !{i64 -111524034612500835}
!48 = !{}
!49 = !{!50}
!50 = distinct !{!50, !51, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueSNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver: %_1.0"}
!51 = distinct !{!51, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueSNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver"}
!52 = !{i64 0, i64 -9223372036854775808}
!53 = !{i64 4780356304075922330}
!54 = !{!55}
!55 = distinct !{!55, !56, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env6ArgsOsECs1StpruGFt5h_6driver: %_1"}
!56 = distinct !{!56, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env6ArgsOsECs1StpruGFt5h_6driver"}
!57 = !{!58}
!58 = distinct !{!58, !59, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtNtCs341anU20NIK_3std3sys4args6common4ArgsECs1StpruGFt5h_6driver: %_1"}
!59 = distinct !{!59, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtNtCs341anU20NIK_3std3sys4args6common4ArgsECs1StpruGFt5h_6driver"}
!60 = !{!61}
!61 = distinct !{!61, !62, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtNtCs3v2GDSbr0UZ_5alloc3vec9into_iter8IntoIterNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringEECs1StpruGFt5h_6driver: %_1"}
!62 = distinct !{!62, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtNtCs3v2GDSbr0UZ_5alloc3vec9into_iter8IntoIterNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringEECs1StpruGFt5h_6driver"}
!63 = !{!64}
!64 = distinct !{!64, !65, !"_RNvXse_NtNtCs3v2GDSbr0UZ_5alloc3vec9into_iterINtB5_8IntoIterNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringENtNtNtCsc9NCSoc2doQ_4core3ops4drop4Drop4dropCs1StpruGFt5h_6driver: %self"}
!65 = distinct !{!65, !"_RNvXse_NtNtCs3v2GDSbr0UZ_5alloc3vec9into_iterINtB5_8IntoIterNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringENtNtNtCsc9NCSoc2doQ_4core3ops4drop4Drop4dropCs1StpruGFt5h_6driver"}
!66 = !{!64, !61, !58, !55}
!67 = !{!68}
!68 = distinct !{!68, !69, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueSNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver: %_1.0"}
!69 = distinct !{!69, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueSNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver"}
!70 = !{!68, !64, !61, !58, !55}
!71 = !{i64 6400942813088426088}
!72 = distinct !{null}
!73 = !{i64 1322364596171404}
!74 = !{i64 -3444857723718012493}
!75 = !{!76}
!76 = distinct !{!76, !77, !"_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner14grow_amortizedCs1StpruGFt5h_6driver: %self"}
!77 = distinct !{!77, !"_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner14grow_amortizedCs1StpruGFt5h_6driver"}
!78 = !{i64 0, i64 2}
!79 = !{i64 0, i64 -9223372036854775807}
!80 = !{i64 6574171808280918495}
!81 = !{i64 -1674922716517144802}
!82 = !{!83}
!83 = distinct !{!83, !84, !"_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cs1StpruGFt5h_6driver: %_1"}
!84 = distinct !{!84, !"_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cs1StpruGFt5h_6driver"}
!85 = !{i64 -4609865910259469423}
!86 = !{!87}
!87 = distinct !{!87, !88, !"_RNCNvNtCs8jZOguSIGf0_6memchr6memchr6memchr0Cs1StpruGFt5h_6driver: %_1"}
!88 = distinct !{!88, !"_RNCNvNtCs8jZOguSIGf0_6memchr6memchr6memchr0Cs1StpruGFt5h_6driver"}
!89 = distinct !{null}
!90 = !{i64 -4579410620954216211}
!91 = !{!92}
!92 = distinct !{!92, !93, !"_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec21spec_from_iter_nestedINtB4_3VecNtNtB6_6string6StringEINtB2_18SpecFromIterNestedB11_NtNtCs341anU20NIK_3std3env4ArgsE9from_iterCs1StpruGFt5h_6driver: %_0"}
!93 = distinct !{!93, !"_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec21spec_from_iter_nestedINtB4_3VecNtNtB6_6string6StringEINtB2_18SpecFromIterNestedB11_NtNtCs341anU20NIK_3std3env4ArgsE9from_iterCs1StpruGFt5h_6driver"}
!94 = !{!95}
!95 = distinct !{!95, !93, !"_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec21spec_from_iter_nestedINtB4_3VecNtNtB6_6string6StringEINtB2_18SpecFromIterNestedB11_NtNtCs341anU20NIK_3std3env4ArgsE9from_iterCs1StpruGFt5h_6driver: %iterator"}
!96 = !{!92, !95}
!97 = !{i64 -1, i64 -9223372036854775808}
!98 = !{!99}
!99 = distinct !{!99, !100, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECs1StpruGFt5h_6driver: %_1"}
!100 = distinct !{!100, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECs1StpruGFt5h_6driver"}
!101 = !{!102}
!102 = distinct !{!102, !103, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env6ArgsOsECs1StpruGFt5h_6driver: %_1"}
!103 = distinct !{!103, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env6ArgsOsECs1StpruGFt5h_6driver"}
!104 = !{!105}
!105 = distinct !{!105, !106, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtNtCs341anU20NIK_3std3sys4args6common4ArgsECs1StpruGFt5h_6driver: %_1"}
!106 = distinct !{!106, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtNtCs341anU20NIK_3std3sys4args6common4ArgsECs1StpruGFt5h_6driver"}
!107 = !{!108}
!108 = distinct !{!108, !109, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtNtCs3v2GDSbr0UZ_5alloc3vec9into_iter8IntoIterNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringEECs1StpruGFt5h_6driver: %_1"}
!109 = distinct !{!109, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtNtCs3v2GDSbr0UZ_5alloc3vec9into_iter8IntoIterNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringEECs1StpruGFt5h_6driver"}
!110 = !{!111}
!111 = distinct !{!111, !112, !"_RNvXse_NtNtCs3v2GDSbr0UZ_5alloc3vec9into_iterINtB5_8IntoIterNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringENtNtNtCsc9NCSoc2doQ_4core3ops4drop4Drop4dropCs1StpruGFt5h_6driver: %self"}
!112 = distinct !{!112, !"_RNvXse_NtNtCs3v2GDSbr0UZ_5alloc3vec9into_iterINtB5_8IntoIterNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringENtNtNtCsc9NCSoc2doQ_4core3ops4drop4Drop4dropCs1StpruGFt5h_6driver"}
!113 = !{!111, !108, !105, !102, !99, !95}
!114 = !{!115}
!115 = distinct !{!115, !116, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueSNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver: %_1.0"}
!116 = distinct !{!116, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueSNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver"}
!117 = !{!111, !108, !105, !102, !99, !92}
!118 = !{!115, !111, !108, !105, !102, !99, !92}
!119 = !{!"branch_weights", i32 2002, i32 2000}
!120 = !{!121, !92}
!121 = distinct !{!121, !122, !"_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner15try_allocate_inCs1StpruGFt5h_6driver: %_0"}
!122 = distinct !{!122, !"_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner15try_allocate_inCs1StpruGFt5h_6driver"}
!123 = !{!124}
!124 = distinct !{!124, !125, !"_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec11spec_extendINtB4_3VecNtNtB6_6string6StringEINtB2_10SpecExtendBR_NtNtCs341anU20NIK_3std3env4ArgsE11spec_extendCs1StpruGFt5h_6driver: %self"}
!125 = distinct !{!125, !"_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec11spec_extendINtB4_3VecNtNtB6_6string6StringEINtB2_10SpecExtendBR_NtNtCs341anU20NIK_3std3env4ArgsE11spec_extendCs1StpruGFt5h_6driver"}
!126 = !{!127}
!127 = distinct !{!127, !125, !"_RNvXNtNtCs3v2GDSbr0UZ_5alloc3vec11spec_extendINtB4_3VecNtNtB6_6string6StringEINtB2_10SpecExtendBR_NtNtCs341anU20NIK_3std3env4ArgsE11spec_extendCs1StpruGFt5h_6driver: %iter"}
!128 = !{!129}
!129 = distinct !{!129, !130, !"_RINvMsk_NtCs3v2GDSbr0UZ_5alloc3vecINtB6_3VecNtNtB8_6string6StringE16extend_desugaredNtNtCs341anU20NIK_3std3env4ArgsECs1StpruGFt5h_6driver: %self"}
!130 = distinct !{!130, !"_RINvMsk_NtCs3v2GDSbr0UZ_5alloc3vecINtB6_3VecNtNtB8_6string6StringE16extend_desugaredNtNtCs341anU20NIK_3std3env4ArgsECs1StpruGFt5h_6driver"}
!131 = !{!132}
!132 = distinct !{!132, !130, !"_RINvMsk_NtCs3v2GDSbr0UZ_5alloc3vecINtB6_3VecNtNtB8_6string6StringE16extend_desugaredNtNtCs341anU20NIK_3std3env4ArgsECs1StpruGFt5h_6driver: %iterator"}
!133 = !{!129, !132, !124, !127, !92, !95}
!134 = !{!129, !124, !92}
!135 = !{!129, !124}
!136 = !{!132, !127, !92, !95}
!137 = !{!138}
!138 = distinct !{!138, !139, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECs1StpruGFt5h_6driver: %_1"}
!139 = distinct !{!139, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECs1StpruGFt5h_6driver"}
!140 = !{!141}
!141 = distinct !{!141, !142, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env6ArgsOsECs1StpruGFt5h_6driver: %_1"}
!142 = distinct !{!142, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env6ArgsOsECs1StpruGFt5h_6driver"}
!143 = !{!144}
!144 = distinct !{!144, !145, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtNtCs341anU20NIK_3std3sys4args6common4ArgsECs1StpruGFt5h_6driver: %_1"}
!145 = distinct !{!145, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtNtCs341anU20NIK_3std3sys4args6common4ArgsECs1StpruGFt5h_6driver"}
!146 = !{!147}
!147 = distinct !{!147, !148, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtNtCs3v2GDSbr0UZ_5alloc3vec9into_iter8IntoIterNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringEECs1StpruGFt5h_6driver: %_1"}
!148 = distinct !{!148, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtNtCs3v2GDSbr0UZ_5alloc3vec9into_iter8IntoIterNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringEECs1StpruGFt5h_6driver"}
!149 = !{!150}
!150 = distinct !{!150, !151, !"_RNvXse_NtNtCs3v2GDSbr0UZ_5alloc3vec9into_iterINtB5_8IntoIterNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringENtNtNtCsc9NCSoc2doQ_4core3ops4drop4Drop4dropCs1StpruGFt5h_6driver: %self"}
!151 = distinct !{!151, !"_RNvXse_NtNtCs3v2GDSbr0UZ_5alloc3vec9into_iterINtB5_8IntoIterNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringENtNtNtCsc9NCSoc2doQ_4core3ops4drop4Drop4dropCs1StpruGFt5h_6driver"}
!152 = !{!150, !147, !144, !141, !138, !132, !127}
!153 = !{!129, !124, !92, !95}
!154 = !{!155}
!155 = distinct !{!155, !156, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueSNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver: %_1.0"}
!156 = distinct !{!156, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueSNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver"}
!157 = !{!150, !147, !144, !141, !138, !129, !124, !92}
!158 = !{!155, !150, !147, !144, !141, !138, !129, !124, !92}
!159 = !{!132, !127}
!160 = !{!161}
!161 = distinct !{!161, !162, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECs1StpruGFt5h_6driver: %_1"}
!162 = distinct !{!162, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECs1StpruGFt5h_6driver"}
!163 = !{!164}
!164 = distinct !{!164, !165, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env6ArgsOsECs1StpruGFt5h_6driver: %_1"}
!165 = distinct !{!165, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env6ArgsOsECs1StpruGFt5h_6driver"}
!166 = !{!167}
!167 = distinct !{!167, !168, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtNtCs341anU20NIK_3std3sys4args6common4ArgsECs1StpruGFt5h_6driver: %_1"}
!168 = distinct !{!168, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtNtNtCs341anU20NIK_3std3sys4args6common4ArgsECs1StpruGFt5h_6driver"}
!169 = !{!170}
!170 = distinct !{!170, !171, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtNtCs3v2GDSbr0UZ_5alloc3vec9into_iter8IntoIterNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringEECs1StpruGFt5h_6driver: %_1"}
!171 = distinct !{!171, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtNtCs3v2GDSbr0UZ_5alloc3vec9into_iter8IntoIterNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringEECs1StpruGFt5h_6driver"}
!172 = !{!173}
!173 = distinct !{!173, !174, !"_RNvXse_NtNtCs3v2GDSbr0UZ_5alloc3vec9into_iterINtB5_8IntoIterNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringENtNtNtCsc9NCSoc2doQ_4core3ops4drop4Drop4dropCs1StpruGFt5h_6driver: %self"}
!174 = distinct !{!174, !"_RNvXse_NtNtCs3v2GDSbr0UZ_5alloc3vec9into_iterINtB5_8IntoIterNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringENtNtNtCsc9NCSoc2doQ_4core3ops4drop4Drop4dropCs1StpruGFt5h_6driver"}
!175 = !{!173, !170, !167, !164, !161}
!176 = !{!177}
!177 = distinct !{!177, !178, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueSNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver: %_1.0"}
!178 = distinct !{!178, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueSNtNtNtCs341anU20NIK_3std3ffi6os_str8OsStringECs1StpruGFt5h_6driver"}
!179 = !{!173, !170, !167, !164, !161, !92}
!180 = !{!177, !173, !170, !167, !164, !161, !92}
!181 = !{!182}
!182 = distinct !{!182, !183, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver: %_1"}
!183 = distinct !{!183, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver"}
!184 = !{!185}
!185 = distinct !{!185, !186, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueSNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver: %_1.0"}
!186 = distinct !{!186, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueSNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver"}
!187 = !{!185, !182}
!188 = !{!"branch_weights", !"expected", i32 2000, i32 1}
!189 = !{!"branch_weights", i32 1744830464, i32 871980}
!190 = !{!191}
!191 = distinct !{!191, !192, !"_RNvMsv_NtCsc9NCSoc2doQ_4core3numj27from_ascii_bytes_radix_impl: argument 1"}
!192 = distinct !{!192, !"_RNvMsv_NtCsc9NCSoc2doQ_4core3numj27from_ascii_bytes_radix_impl"}
!193 = !{!194}
!194 = distinct !{!194, !192, !"_RNvMsv_NtCsc9NCSoc2doQ_4core3numj27from_ascii_bytes_radix_impl: %_0"}
!195 = !{!"branch_weights", !"expected", i32 1, i32 2000}
!196 = !{!197, !199}
!197 = distinct !{!197, !198, !"_RNvMNtCsc9NCSoc2doQ_4core6resultINtB2_6ResultjNtNtNtB4_3num5error13ParseIntErrorE6unwrapCs1StpruGFt5h_6driver: %self"}
!198 = distinct !{!198, !"_RNvMNtCsc9NCSoc2doQ_4core6resultINtB2_6ResultjNtNtNtB4_3num5error13ParseIntErrorE6unwrapCs1StpruGFt5h_6driver"}
!199 = distinct !{!199, !198, !"_RNvMNtCsc9NCSoc2doQ_4core6resultINtB2_6ResultjNtNtNtB4_3num5error13ParseIntErrorE6unwrapCs1StpruGFt5h_6driver: argument 1"}
!200 = !{!201}
!201 = distinct !{!201, !202, !"_RNvMsv_NtCsc9NCSoc2doQ_4core3numj27from_ascii_bytes_radix_impl: argument 1"}
!202 = distinct !{!202, !"_RNvMsv_NtCsc9NCSoc2doQ_4core3numj27from_ascii_bytes_radix_impl"}
!203 = !{!204}
!204 = distinct !{!204, !202, !"_RNvMsv_NtCsc9NCSoc2doQ_4core3numj27from_ascii_bytes_radix_impl: %_0"}
!205 = !{!206, !208}
!206 = distinct !{!206, !207, !"_RNvMNtCsc9NCSoc2doQ_4core6resultINtB2_6ResultjNtNtNtB4_3num5error13ParseIntErrorE6unwrapCs1StpruGFt5h_6driver: %self"}
!207 = distinct !{!207, !"_RNvMNtCsc9NCSoc2doQ_4core6resultINtB2_6ResultjNtNtNtB4_3num5error13ParseIntErrorE6unwrapCs1StpruGFt5h_6driver"}
!208 = distinct !{!208, !207, !"_RNvMNtCsc9NCSoc2doQ_4core6resultINtB2_6ResultjNtNtNtB4_3num5error13ParseIntErrorE6unwrapCs1StpruGFt5h_6driver: argument 1"}
!209 = !{!210}
!210 = distinct !{!210, !211, !"_RNvMsv_NtCsc9NCSoc2doQ_4core3numj27from_ascii_bytes_radix_impl: argument 1"}
!211 = distinct !{!211, !"_RNvMsv_NtCsc9NCSoc2doQ_4core3numj27from_ascii_bytes_radix_impl"}
!212 = !{!213}
!213 = distinct !{!213, !211, !"_RNvMsv_NtCsc9NCSoc2doQ_4core3numj27from_ascii_bytes_radix_impl: %_0"}
!214 = !{!215, !217}
!215 = distinct !{!215, !216, !"_RNvMNtCsc9NCSoc2doQ_4core6resultINtB2_6ResultjNtNtNtB4_3num5error13ParseIntErrorE6unwrapCs1StpruGFt5h_6driver: %self"}
!216 = distinct !{!216, !"_RNvMNtCsc9NCSoc2doQ_4core6resultINtB2_6ResultjNtNtNtB4_3num5error13ParseIntErrorE6unwrapCs1StpruGFt5h_6driver"}
!217 = distinct !{!217, !216, !"_RNvMNtCsc9NCSoc2doQ_4core6resultINtB2_6ResultjNtNtNtB4_3num5error13ParseIntErrorE6unwrapCs1StpruGFt5h_6driver: argument 1"}
!218 = !{!"branch_weights", i32 1, i32 2001, i32 2001, i32 2000}
!219 = !{!"branch_weights", i32 4000000, i32 4001}
!220 = !{!221}
!221 = distinct !{!221, !222, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver: %_1"}
!222 = distinct !{!222, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver"}
!223 = !{!224}
!224 = distinct !{!224, !225, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueSNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver: %_1.0"}
!225 = distinct !{!225, !"_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueSNtNtCs3v2GDSbr0UZ_5alloc6string6StringECs1StpruGFt5h_6driver"}
!226 = !{!224, !221}
!227 = !{!228}
!228 = distinct !{!228, !229, !"_RINvXs1_NtNtCs3v2GDSbr0UZ_5alloc3vec14spec_from_elemhNtB6_12SpecFromElem9from_elemNtNtBa_5alloc6GlobalECs1StpruGFt5h_6driver: %v"}
!229 = distinct !{!229, !"_RINvXs1_NtNtCs3v2GDSbr0UZ_5alloc3vec14spec_from_elemhNtB6_12SpecFromElem9from_elemNtNtBa_5alloc6GlobalECs1StpruGFt5h_6driver"}
!230 = !{!231, !228}
!231 = distinct !{!231, !232, !"_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner15try_allocate_inCs1StpruGFt5h_6driver: %_0"}
!232 = distinct !{!232, !"_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner15try_allocate_inCs1StpruGFt5h_6driver"}
!233 = !{!234, !228}
!234 = distinct !{!234, !235, !"_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner15try_allocate_inCs1StpruGFt5h_6driver: %_0"}
!235 = distinct !{!235, !"_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner15try_allocate_inCs1StpruGFt5h_6driver"}
!236 = !{!237}
!237 = distinct !{!237, !238, !"_RNvMs8_NtNtNtCsc9NCSoc2doQ_4core5array4iter10iter_innerINtB5_15PolymorphicIterSINtNtNtBb_3mem12maybe_uninit11MaybeUninitjEE4nextCs1StpruGFt5h_6driver: %self.0"}
!238 = distinct !{!238, !"_RNvMs8_NtNtNtCsc9NCSoc2doQ_4core5array4iter10iter_innerINtB5_15PolymorphicIterSINtNtNtBb_3mem12maybe_uninit11MaybeUninitjEE4nextCs1StpruGFt5h_6driver"}
!239 = !{!240, !242}
!240 = distinct !{!240, !241, !"_RNCNvNtCs8jZOguSIGf0_6memchr6memchr6memchr0Cs1StpruGFt5h_6driver: %_1"}
!241 = distinct !{!241, !"_RNCNvNtCs8jZOguSIGf0_6memchr6memchr6memchr0Cs1StpruGFt5h_6driver"}
!242 = distinct !{!242, !243, !"_RNvCs1StpruGFt5h_6driver10crate_find: %s.0"}
!243 = distinct !{!243, !"_RNvCs1StpruGFt5h_6driver10crate_find"}
!244 = !{ptr @_RNvCs1StpruGFt5h_6driver10crate_find}
!245 = !{!"branch_weights", i32 4001, i32 4000000}
!246 = !{!247}
!247 = distinct !{!247, !248, !"_RNvCs1StpruGFt5h_6driver8std_find: %s.0"}
!248 = distinct !{!248, !"_RNvCs1StpruGFt5h_6driver8std_find"}
!249 = !{!"branch_weights", !"expected", i32 0, i32 -2147483648}
!250 = !{!251}
!251 = distinct !{!251, !252, !"_RNvCs1StpruGFt5h_6driver8std_find: %s.0"}
!252 = distinct !{!252, !"_RNvCs1StpruGFt5h_6driver8std_find"}
!253 = !{!"branch_weights", i32 -2147483648, i32 0}
!254 = !{!255, !257}
!255 = distinct !{!255, !256, !"_RNCNvNtCs8jZOguSIGf0_6memchr6memchr6memchr0Cs1StpruGFt5h_6driver: %_1"}
!256 = distinct !{!256, !"_RNCNvNtCs8jZOguSIGf0_6memchr6memchr6memchr0Cs1StpruGFt5h_6driver"}
!257 = distinct !{!257, !258, !"_RNvCs1StpruGFt5h_6driver10crate_find: %s.0"}
!258 = distinct !{!258, !"_RNvCs1StpruGFt5h_6driver10crate_find"}
!259 = !{!260}
!260 = distinct !{!260, !261, !"_RNvCs1StpruGFt5h_6driver8std_find: %s.0"}
!261 = distinct !{!261, !"_RNvCs1StpruGFt5h_6driver8std_find"}
!262 = !{!"branch_weights", !"expected", i32 -2147483648, i32 0}
!263 = !{!264, !266}
!264 = distinct !{!264, !265, !"_RNCNvNtCs8jZOguSIGf0_6memchr6memchr6memchr0Cs1StpruGFt5h_6driver: %_1"}
!265 = distinct !{!265, !"_RNCNvNtCs8jZOguSIGf0_6memchr6memchr6memchr0Cs1StpruGFt5h_6driver"}
!266 = distinct !{!266, !267, !"_RNvCs1StpruGFt5h_6driver10crate_find: %s.0"}
!267 = distinct !{!267, !"_RNvCs1StpruGFt5h_6driver10crate_find"}
!268 = !{i64 -8600482048361935889}
!269 = !{i64 7610315848303932341}
!270 = !{i64 -2493500595578129731}
!271 = !{i8 0, i8 6}
!272 = !{i64 6708299419491623874}
!273 = !{i64 -2624081020897602054}
