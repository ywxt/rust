; L05:LSR 改寫 len - index 時,SCEV 把 urem 展開成 r - (r /u n) * n,在新 IV 上重建第二條除法,
; 未複用迴圈頭已算出的商。兩個 target 都發生;-disable-lsr 後只剩一條。
; RUN: opt -S -passes=loop-simplify,loop-reduce -mtriple=aarch64-linux-gnu < %s | FileCheck %s --check-prefix=LSR
; RUN: opt -S -passes=loop-simplify,loop-reduce -mtriple=x86_64-linux-gnu < %s | FileCheck %s --check-prefix=LSR
; RUN: llc -O3 -mtriple=aarch64-linux-gnu < %s | FileCheck %s --check-prefix=A64
; RUN: llc -O3 -mtriple=aarch64-linux-gnu -disable-lsr < %s | FileCheck %s --check-prefix=A64-NOLSR
; RUN: llc -O3 -mtriple=x86_64-linux-gnu < %s | FileCheck %s --check-prefix=X86
; RUN: llc -O3 -mtriple=x86_64-linux-gnu -disable-lsr < %s | FileCheck %s --check-prefix=X86-NOLSR

; LSR: urem i64 %r,
; LSR: move:
; LSR-NEXT: urem i64 %r,

; A64: udiv
; A64: cmp
; A64: b.hs
; A64: udiv
; A64: bl use

; A64-NOLSR: udiv
; A64-NOLSR-NOT: udiv
; A64-NOLSR: ret

; X86: divq
; X86: jae
; X86: divq
; X86: callq use

; X86-NOLSR: divq
; X86-NOLSR-NOT: divq
; X86-NOLSR: retq

declare void @use(i64)

define void @ins(i64 %r) {
entry:
  br label %loop
loop:
  %l = phi i64 [ 0, %entry ], [ %n, %latch ]
  %n = add nsw i64 %l, 1
  %idx = urem i64 %r, %n
  %lt = icmp ult i64 %idx, %l
  br i1 %lt, label %move, label %latch
move:
  %count = sub i64 %l, %idx
  call void @use(i64 %count)
  br label %latch
latch:
  %done = icmp eq i64 %n, 130
  br i1 %done, label %exit, label %loop
exit:
  ret void
}
