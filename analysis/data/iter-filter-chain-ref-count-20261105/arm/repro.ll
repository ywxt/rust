define i64 @filter_chain_ref_count() {
entry:
  %p = alloca i64, align 8
  br label %first
first:
  %i = phi i64 [0, %entry], [%inext, %first]
  %a = phi i64 [0, %entry], [%anext, %first]
  store i64 %i, ptr %p, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr %p)
  %x = load i64, ptr %p, align 8
  %r = srem i64 %x, 3
  %hit = icmp eq i64 %r, 0
  %n = zext i1 %hit to i64
  %anext = add i64 %a, %n
  %inext = add nuw nsw i64 %i, 1
  %done = icmp eq i64 %inext, 1000000
  br i1 %done, label %second, label %first
second:
  %j = phi i64 [0, %first], [%jnext, %second]
  %b = phi i64 [%anext, %first], [%bnext, %second]
  store i64 %j, ptr %p, align 8
  call void asm sideeffect "", "r,~{memory}"(ptr %p)
  %y = load i64, ptr %p, align 8
  %r2 = srem i64 %y, 3
  %hit2 = icmp eq i64 %r2, 0
  %n2 = zext i1 %hit2 to i64
  %bnext = add i64 %b, %n2
  %jnext = add nuw nsw i64 %j, 1
  %done2 = icmp eq i64 %jnext, 1000000
  br i1 %done2, label %exit, label %second
exit:
  ret i64 %bnext
}
