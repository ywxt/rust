; ModuleID = '/tmp/iter-filter-chain-20261105/repro.ll'
source_filename = "/tmp/iter-filter-chain-20261105/repro.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "aarch64-unknown-linux-gnu"

; Function Attrs: nounwind
define i64 @filter_chain_ref_count() local_unnamed_addr #0 {
entry:
  %p = alloca i64, align 8
  br label %first

first:                                            ; preds = %first, %entry
  %i = phi i64 [ 0, %entry ], [ %inext.3, %first ]
  %a = phi i64 [ 0, %entry ], [ %anext.3, %first ]
  store i64 %i, ptr %p, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %p) #0
  %x = load i64, ptr %p, align 8
  %r = srem i64 %x, 3
  %hit = icmp eq i64 %r, 0
  %n = zext i1 %hit to i64
  %anext = add i64 %a, %n
  %inext = or disjoint i64 %i, 1
  store i64 %inext, ptr %p, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %p) #0
  %x.1 = load i64, ptr %p, align 8
  %r.1 = srem i64 %x.1, 3
  %hit.1 = icmp eq i64 %r.1, 0
  %n.1 = zext i1 %hit.1 to i64
  %anext.1 = add i64 %anext, %n.1
  %inext.1 = or disjoint i64 %i, 2
  store i64 %inext.1, ptr %p, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %p) #0
  %x.2 = load i64, ptr %p, align 8
  %r.2 = srem i64 %x.2, 3
  %hit.2 = icmp eq i64 %r.2, 0
  %n.2 = zext i1 %hit.2 to i64
  %anext.2 = add i64 %anext.1, %n.2
  %inext.2 = or disjoint i64 %i, 3
  store i64 %inext.2, ptr %p, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %p) #0
  %x.3 = load i64, ptr %p, align 8
  %r.3 = srem i64 %x.3, 3
  %hit.3 = icmp eq i64 %r.3, 0
  %n.3 = zext i1 %hit.3 to i64
  %anext.3 = add i64 %anext.2, %n.3
  %inext.3 = add nuw nsw i64 %i, 4
  %done.3 = icmp eq i64 %inext.3, 1000000
  br i1 %done.3, label %second, label %first, !llvm.loop !0

second:                                           ; preds = %first, %second
  %j = phi i64 [ %jnext.3, %second ], [ 0, %first ]
  %b = phi i64 [ %bnext.3, %second ], [ %anext.3, %first ]
  store i64 %j, ptr %p, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %p) #0
  %y = load i64, ptr %p, align 8
  %r2 = srem i64 %y, 3
  %hit2 = icmp eq i64 %r2, 0
  %n2 = zext i1 %hit2 to i64
  %bnext = add i64 %b, %n2
  %jnext = or disjoint i64 %j, 1
  store i64 %jnext, ptr %p, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %p) #0
  %y.1 = load i64, ptr %p, align 8
  %r2.1 = srem i64 %y.1, 3
  %hit2.1 = icmp eq i64 %r2.1, 0
  %n2.1 = zext i1 %hit2.1 to i64
  %bnext.1 = add i64 %bnext, %n2.1
  %jnext.1 = or disjoint i64 %j, 2
  store i64 %jnext.1, ptr %p, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %p) #0
  %y.2 = load i64, ptr %p, align 8
  %r2.2 = srem i64 %y.2, 3
  %hit2.2 = icmp eq i64 %r2.2, 0
  %n2.2 = zext i1 %hit2.2 to i64
  %bnext.2 = add i64 %bnext.1, %n2.2
  %jnext.2 = or disjoint i64 %j, 3
  store i64 %jnext.2, ptr %p, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %p) #0
  %y.3 = load i64, ptr %p, align 8
  %r2.3 = srem i64 %y.3, 3
  %hit2.3 = icmp eq i64 %r2.3, 0
  %n2.3 = zext i1 %hit2.3 to i64
  %bnext.3 = add i64 %bnext.2, %n2.3
  %jnext.3 = add nuw nsw i64 %j, 4
  %done2.3 = icmp eq i64 %jnext.3, 1000000
  br i1 %done2.3, label %exit, label %second, !llvm.loop !2

exit:                                             ; preds = %second
  ret i64 %bnext.3
}

attributes #0 = { nounwind }

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.unroll.disable"}
!2 = distinct !{!2, !1}
