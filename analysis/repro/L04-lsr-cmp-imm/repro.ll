; L04:1 000 000 編不進 AArch64 cmp 立即數。LSR 先把出口改寫為 icmp eq (iv + -998999), 1001;
; 若同函式有 >=2 個這樣的迴圈,ConstantHoisting 把 -998999 提到入口,SelectionDAG 看不到常量、
; 折不回 cmp x, reg,每輪多一條 add。單一迴圈、或常量編得進 cmp 時都不發生。
; RUN: llc -O3 -mtriple=aarch64-linux-gnu < %s | FileCheck %s --check-prefix=A64
; RUN: llc -O3 -mtriple=aarch64-linux-gnu -disable-lsr < %s | FileCheck %s --check-prefix=NOFIX
; RUN: llc -O3 -mtriple=aarch64-linux-gnu -disable-constant-hoisting < %s | FileCheck %s --check-prefix=NOFIX
; RUN: llc -O3 -mtriple=x86_64-linux-gnu < %s | FileCheck %s --check-prefix=X86

; A64-LABEL: two:
; A64: add [[T:x[0-9]+]], x{{[0-9]+}}, x{{[0-9]+}}
; A64: cmp [[T]], #1001
; A64: b.ne
; A64: add [[U:x[0-9]+]], x{{[0-9]+}}, x{{[0-9]+}}
; A64: cmp [[U]], #1001
; A64-LABEL: one:
; A64-NOT: #1001{{$}}
; A64: cmp x{{[0-9]+}}, x{{[0-9]+}}
; A64-LABEL: fits:
; A64: cmp x{{[0-9]+}}, #4095
; A64: cmp x{{[0-9]+}}, #4095

; NOFIX-LABEL: two:
; NOFIX-NOT: cmp x{{[0-9]+}}, #1001
; NOFIX: cmp x{{[0-9]+}}, x{{[0-9]+}}
; NOFIX-NOT: cmp x{{[0-9]+}}, #1001
; NOFIX: cmp x{{[0-9]+}}, x{{[0-9]+}}

; X86-LABEL: two:
; X86: cmpq $1000000,
; X86: cmpq $1000000,

define void @two(i1 %f, ptr %p) {
entry:
  br i1 %f, label %a, label %b
a:
  %x = phi i64 [ 1001, %entry ], [ %x2, %a ]
  %x2 = add i64 %x, 1
  store volatile i64 %x, ptr %p
  %c1 = icmp eq i64 %x2, 1000000
  br i1 %c1, label %exit, label %a
b:
  %y = phi i64 [ 1001, %entry ], [ %y2, %b ]
  %y2 = add i64 %y, 1
  store volatile i64 %y, ptr %p
  %c2 = icmp eq i64 %y2, 1000000
  br i1 %c2, label %exit, label %b
exit:
  ret void
}

; 對照:只有一個迴圈
define void @one(ptr %p) {
entry:
  br label %a
a:
  %x = phi i64 [ 1001, %entry ], [ %x2, %a ]
  %x2 = add i64 %x, 1
  store volatile i64 %x, ptr %p
  %c1 = icmp eq i64 %x2, 1000000
  br i1 %c1, label %exit, label %a
exit:
  ret void
}

; 對照:兩個迴圈,但常量編得進 cmp
define void @fits(i1 %f, ptr %p) {
entry:
  br i1 %f, label %a, label %b
a:
  %x = phi i64 [ 1001, %entry ], [ %x2, %a ]
  %x2 = add i64 %x, 1
  store volatile i64 %x, ptr %p
  %c1 = icmp eq i64 %x2, 4095
  br i1 %c1, label %exit, label %a
b:
  %y = phi i64 [ 1001, %entry ], [ %y2, %b ]
  %y2 = add i64 %y, 1
  store volatile i64 %y, ptr %p
  %c2 = icmp eq i64 %y2, 4095
  br i1 %c2, label %exit, label %b
exit:
  ret void
}
