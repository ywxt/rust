; ModuleID = '/tmp/iter-filter-map-chain-sum-20261105/repro.ll'
source_filename = "/tmp/iter-filter-map-chain-sum-20261105/repro.ll"

; Function Attrs: mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare { i64, i1 } @llvm.smul.with.overflow.i64(i64, i64) #0

; Function Attrs: nounwind
define i64 @repro() local_unnamed_addr #1 {
entry:
  %slot = alloca i64, align 8
  br label %loop

loop:                                             ; preds = %latch, %entry
  %i = phi i64 [ 0, %entry ], [ %next, %latch ]
  %sum = phi i64 [ 0, %entry ], [ %newsum, %latch ]
  %prod = call { i64, i1 } @llvm.smul.with.overflow.i64(i64 %i, i64 %i)
  %ov = extractvalue { i64, i1 } %prod, 1
  br i1 %ov, label %latch, label %accepted

accepted:                                         ; preds = %loop
  %value = extractvalue { i64, i1 } %prod, 0
  store i64 %value, ptr %slot, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %slot) #1
  %v = load i64, ptr %slot, align 8
  %add = add i64 %v, %sum
  br label %latch

latch:                                            ; preds = %accepted, %loop
  %newsum = phi i64 [ %sum, %loop ], [ %add, %accepted ]
  %next = add nuw nsw i64 %i, 1
  %done = icmp eq i64 %next, 1000000
  br i1 %done, label %exit, label %loop

exit:                                             ; preds = %latch
  ret i64 %newsum
}

attributes #0 = { mustprogress nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }
attributes #1 = { nounwind }
