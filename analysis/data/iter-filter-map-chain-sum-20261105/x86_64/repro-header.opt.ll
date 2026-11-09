; ModuleID = '/tmp/iter-filter-map-chain-sum-20261105/repro-header.ll'
source_filename = "/tmp/iter-filter-map-chain-sum-20261105/repro-header.ll"

; Function Attrs: nounwind
define i64 @repro() local_unnamed_addr #0 {
entry:
  %slot = alloca i64, align 8
  br label %accepted

accepted:                                         ; preds = %entry, %accepted
  %sum2 = phi i64 [ 0, %entry ], [ %add, %accepted ]
  %i1 = phi i64 [ 0, %entry ], [ %next, %accepted ]
  %prod = mul nuw nsw i64 %i1, %i1
  store i64 %prod, ptr %slot, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr nonnull %slot) #0
  %v = load i64, ptr %slot, align 8
  %add = add i64 %v, %sum2
  %next = add nuw nsw i64 %i1, 1
  %within = icmp samesign ult i64 %i1, 999999
  br i1 %within, label %accepted, label %exit

exit:                                             ; preds = %accepted
  ret i64 %add
}

attributes #0 = { nounwind }
