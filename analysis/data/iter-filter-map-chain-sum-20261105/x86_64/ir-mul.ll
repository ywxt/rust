; ModuleID = '/tmp/iter-filter-map-chain-sum-20261105/repro-mul.ll'
source_filename = "/tmp/iter-filter-map-chain-sum-20261105/repro-mul.ll"

; Function Attrs: nounwind
define i64 @repro() local_unnamed_addr #0 {
entry:
  %slot = alloca i64, align 8
  br label %loop

loop:                                             ; preds = %loop, %entry
  %i = phi i64 [ 0, %entry ], [ %next, %loop ]
  %sum = phi i64 [ 0, %entry ], [ %add, %loop ]
  %value_only = mul nuw nsw i64 %i, %i
  store i64 %value_only, ptr %slot, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %slot) #0
  %v = load i64, ptr %slot, align 8
  %add = add i64 %v, %sum
  %next = add nuw nsw i64 %i, 1
  %done = icmp eq i64 %next, 1000000
  br i1 %done, label %exit, label %loop

exit:                                             ; preds = %loop
  ret i64 %add
}

attributes #0 = { nounwind }
