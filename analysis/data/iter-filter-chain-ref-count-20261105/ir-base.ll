; ModuleID = '/tmp/iter-filter-chain-20261105/repro.ll'
source_filename = "/tmp/iter-filter-chain-20261105/repro.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind
define i64 @filter_chain_ref_count() local_unnamed_addr #0 {
entry:
  %p = alloca i64, align 8
  br label %first

first:                                            ; preds = %first, %entry
  %i = phi i64 [ 0, %entry ], [ %inext, %first ]
  %a = phi i64 [ 0, %entry ], [ %anext, %first ]
  store i64 %i, ptr %p, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %p) #0
  %x = load i64, ptr %p, align 8
  %r = srem i64 %x, 3
  %hit = icmp eq i64 %r, 0
  %n = zext i1 %hit to i64
  %anext = add i64 %a, %n
  %inext = add nuw nsw i64 %i, 1
  %done = icmp eq i64 %inext, 1000000
  br i1 %done, label %second, label %first

second:                                           ; preds = %first, %second
  %j = phi i64 [ %jnext, %second ], [ 0, %first ]
  %b = phi i64 [ %bnext, %second ], [ %anext, %first ]
  store i64 %j, ptr %p, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %p) #0
  %y = load i64, ptr %p, align 8
  %r2 = srem i64 %y, 3
  %hit2 = icmp eq i64 %r2, 0
  %n2 = zext i1 %hit2 to i64
  %bnext = add i64 %b, %n2
  %jnext = add nuw nsw i64 %j, 1
  %done2 = icmp eq i64 %jnext, 1000000
  br i1 %done2, label %exit, label %second

exit:                                             ; preds = %second
  ret i64 %bnext
}

attributes #0 = { nounwind }
