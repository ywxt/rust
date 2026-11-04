; L01:堆 sift-down 的 child 選擇(child += a[child] <= a[child+1])。
; AArch64 的 select-optimize 把 zext+add 判為「該轉分支」,關掉後才是 cinc;x86 為 sbb。
; 迴圈內須有「選出的索引 → 載入 → 分支」才算得出關鍵路徑收益。
; RUN: llc -O3 -mtriple=aarch64-linux-gnu < %s | FileCheck %s --check-prefix=A64
; RUN: llc -O3 -mtriple=aarch64-linux-gnu -aarch64-select-opt=false < %s | FileCheck %s --check-prefix=A64-NOSEL
; RUN: llc -O3 -mtriple=x86_64-linux-gnu < %s | FileCheck %s --check-prefix=X86

; A64-LABEL: sift:
; A64: ldp [[L:w[0-9]+]], [[R:w[0-9]+]], [x{{[0-9]+}}]
; A64-NEXT: cmp [[L]], [[R]]
; A64-NEXT: b.hi
; A64-NOT: cinc

; A64-NOSEL-LABEL: sift:
; A64-NOSEL: ldp [[L:w[0-9]+]], [[R:w[0-9]+]], [x{{[0-9]+}}]
; A64-NOSEL-NEXT: cmp [[L]], [[R]]
; A64-NOSEL-NEXT: cinc x{{[0-9]+}}, x{{[0-9]+}}, ls

; X86-LABEL: sift:
; X86: cmpl (%rdi,%r{{[a-z0-9]+}},4),
; X86: sbbq $-1,

define void @sift(ptr %d, i64 %lim, i32 %elt) {
entry:
  br label %loop
loop:
  %child = phi i64 [ 1, %entry ], [ %next, %latch ]
  %pl = getelementptr inbounds i32, ptr %d, i64 %child
  %pr = getelementptr inbounds i32, ptr %pl, i64 1
  %l = load i32, ptr %pl
  %r = load i32, ptr %pr
  %le = icmp ule i32 %l, %r
  %z = zext i1 %le to i64
  %c = add i64 %child, %z
  %pc = getelementptr inbounds i32, ptr %d, i64 %c
  %v = load i32, ptr %pc
  %go = icmp ult i32 %elt, %v
  br i1 %go, label %latch, label %exit
latch:
  %sh = shl i64 %c, 1
  %next = or disjoint i64 %sh, 1
  %cont = icmp ult i64 %sh, %lim
  br i1 %cont, label %loop, label %exit
exit:
  ret void
}
