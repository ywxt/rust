; R04:u128::isqrt 的分派形狀:高 64 位為 0 走查表快路徑,否則走含 __udivti3 呼叫的慢路徑,兩路在 phi 匯合。
; x86:phi 被分到被呼叫者保存暫存器(rbx,因慢路徑的值跨呼叫存活),快路徑也寫它,
;      於是 push 放在入口、分派之前,快路徑也付保存/恢復;aarch64 shrink-wrap,快路徑無 spill。
; 本最小 IR 中關掉 x86 的 64 位除法旁路(-mattr=-idivq-to-divl)可消除,見 NOBYPASS;
; 但完整的 isqrt 函數關掉後仍在入口 push 5 個暫存器(見 manifest)。
; RUN: llc -O3 -mtriple=x86_64-linux-gnu -mcpu=x86-64 %s -o - | FileCheck %s --check-prefix=X86
; RUN: llc -O3 -mtriple=aarch64-linux-gnu %s -o - | FileCheck %s --check-prefix=A64
; RUN: llc -O3 -mtriple=x86_64-linux-gnu -mcpu=x86-64 -mattr=-idivq-to-divl %s -o - | FileCheck %s --check-prefix=NOBYPASS

@t = constant [256 x i8] zeroinitializer

define i128 @isqrt(i128 %n) {
entry:
  %lo = trunc i128 %n to i64
  %hi128 = lshr i128 %n, 64
  %hi = trunc i128 %hi128 to i64
  %z = icmp eq i64 %hi, 0
  br i1 %z, label %small, label %big
small:
  %i = and i64 %lo, 255
  %p = getelementptr inbounds i8, ptr @t, i64 %i
  %b = load i8, ptr %p, align 1
  %r0 = zext i8 %b to i128
  br label %done
big:
  %q1 = udiv i64 %lo, %hi
  %q2 = udiv i128 %n, %hi128
  %s = shl i64 %q1, 1
  %w = zext i64 %s to i128
  %o = or i128 %q2, %w
  br label %done
done:
  %r = phi i128 [ %r0, %small ], [ %o, %big ]
  ret i128 %r
}

; X86-LABEL: isqrt:
; X86-NOT:   {{test|cmp}}
; X86:       pushq %rbx
; X86:       testq %rsi, %rsi
; X86:       movzbl (%rcx,%rax), %ebx

; A64-LABEL: isqrt:
; A64-NOT:   {{stp|str}}
; A64:       cbz x1, [[SMALL:.LBB[0-9_]+]]
; A64:       stp x30, x19, [sp, #-16]!
; A64:       bl __udivti3
; A64:       [[SMALL]]:
; A64-NOT:   {{stp|str}}
; A64:       ldrb w0,
; A64-NEXT:  ret

; NOBYPASS-LABEL: isqrt:
; NOBYPASS-NOT:   push
; NOBYPASS:       testq %rsi, %rsi
; NOBYPASS-NEXT:  je
; NOBYPASS:       pushq %rbx
