; L03:每輪 4 個對稱 i64 lane(do_count_chars 的 unroll)。各 lane 運算相同,本可直接順序載入。
; AArch64 interleaved-access 成本偏低:LV 選 VF2×IC4 的交錯群 → 4 條 ld4,迴圈內向量暫存器不足而棧往返。
; -enable-interleaved-mem-accesses=false 後同樣向量化但無 ld4、無棧往返;x86 無交錯載入。
; RUN: opt -S -passes=loop-vectorize -mtriple=aarch64-linux-gnu < %s | llc -O3 -mtriple=aarch64-linux-gnu | FileCheck %s --check-prefix=A64
; RUN: opt -S -passes=loop-vectorize -mtriple=aarch64-linux-gnu -enable-interleaved-mem-accesses=false < %s | llc -O3 -mtriple=aarch64-linux-gnu | FileCheck %s --check-prefix=A64-NOIL
; RUN: opt -S -passes=loop-vectorize -mtriple=x86_64-linux-gnu < %s | llc -O3 -mtriple=x86_64-linux-gnu | FileCheck %s --check-prefix=X86

; A64-LABEL: count:
; A64: %vector.body
; A64: Spill
; A64: ld4 { v{{[0-9]+}}.2d,
; A64: ld4 { v{{[0-9]+}}.2d,
; A64: ld4 { v{{[0-9]+}}.2d,
; A64: ld4 { v{{[0-9]+}}.2d,
; A64: Reload
; A64: b.ne

; A64-NOIL-LABEL: count:
; A64-NOIL: %vector.body
; A64-NOIL-NOT: ld4
; A64-NOIL-NOT: Spill
; A64-NOIL-NOT: Reload
; A64-NOIL: b.ne

; X86-LABEL: count:
; X86: %vector.body
; X86-NOT: (%rsp)
; X86: psrlq $7,
; X86: paddq
; X86: jne

define i64 @count(ptr %d, i64 %n) {
entry:
  br label %loop
loop:
  %i = phi i64 [ 0, %entry ], [ %i2, %loop ]
  %c = phi i64 [ 0, %entry ], [ %s3, %loop ]
  %p = getelementptr inbounds [4 x i64], ptr %d, i64 %i
  %p0 = getelementptr inbounds i64, ptr %p, i64 0
  %w0 = load i64, ptr %p0
  %n0 = xor i64 %w0, -1
  %a0 = lshr i64 %n0, 7
  %b0 = lshr i64 %w0, 6
  %o0 = or i64 %a0, %b0
  %m0 = and i64 %o0, 72340172838076673
  %s0 = add i64 %c, %m0
  %p1 = getelementptr inbounds i64, ptr %p, i64 1
  %w1 = load i64, ptr %p1
  %n1 = xor i64 %w1, -1
  %a1 = lshr i64 %n1, 7
  %b1 = lshr i64 %w1, 6
  %o1 = or i64 %a1, %b1
  %m1 = and i64 %o1, 72340172838076673
  %s1 = add i64 %s0, %m1
  %p2 = getelementptr inbounds i64, ptr %p, i64 2
  %w2 = load i64, ptr %p2
  %n2 = xor i64 %w2, -1
  %a2 = lshr i64 %n2, 7
  %b2 = lshr i64 %w2, 6
  %o2 = or i64 %a2, %b2
  %m2 = and i64 %o2, 72340172838076673
  %s2 = add i64 %s1, %m2
  %p3 = getelementptr inbounds i64, ptr %p, i64 3
  %w3 = load i64, ptr %p3
  %n3 = xor i64 %w3, -1
  %a3 = lshr i64 %n3, 7
  %b3 = lshr i64 %w3, 6
  %o3 = or i64 %a3, %b3
  %m3 = and i64 %o3, 72340172838076673
  %s3 = add i64 %s2, %m3
  %i2 = add i64 %i, 1
  %cont = icmp ult i64 %i2, %n
  br i1 %cont, label %loop, label %exit
exit:
  ret i64 %s3
}
