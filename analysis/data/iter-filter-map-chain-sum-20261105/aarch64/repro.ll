declare { i64, i1 } @llvm.smul.with.overflow.i64(i64, i64)
define i64 @repro() {
entry:
  %slot = alloca i64, align 8
  br label %loop
loop:
  %i = phi i64 [0, %entry], [%next, %latch]
  %sum = phi i64 [0, %entry], [%newsum, %latch]
  %prod = call {i64, i1} @llvm.smul.with.overflow.i64(i64 %i, i64 %i)
  %ov = extractvalue {i64, i1} %prod, 1
  br i1 %ov, label %latch, label %accepted
accepted:
  %value = extractvalue {i64, i1} %prod, 0
  store i64 %value, ptr %slot, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr %slot)
  %v = load i64, ptr %slot, align 8
  %add = add i64 %sum, %v
  br label %latch
latch:
  %newsum = phi i64 [%sum, %loop], [%add, %accepted]
  %next = add nuw nsw i64 %i, 1
  %done = icmp eq i64 %next, 1000000
  br i1 %done, label %exit, label %loop
exit:
  ret i64 %newsum
}
