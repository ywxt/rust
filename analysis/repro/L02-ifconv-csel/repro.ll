; L02:char_len 的 1/2/3/4 字節判斷。
; AArch64 early-ifcvt 把 2 字節路徑併成 csel,長度變成依賴 load 的資料鏈;x86 保留分支。
; ldrsb 是為 tbnz 取符號位,多字節路徑再補 and #0xff。
; RUN: llc -O3 -mtriple=aarch64-linux-gnu < %s | FileCheck %s --check-prefix=A64
; RUN: llc -O3 -mtriple=aarch64-linux-gnu -aarch64-enable-early-ifcvt=false < %s | FileCheck %s --check-prefix=A64-NOIFC
; RUN: llc -O3 -mtriple=x86_64-linux-gnu < %s | FileCheck %s --check-prefix=X86

; A64-LABEL: char_len:
; A64: and [[B:w[0-9]+]], [[B]], #0xff
; A64: cmp [[B]], #240
; A64-NEXT: cinc
; A64-NEXT: cmp [[B]], #224
; A64-NEXT: csel
; A64: ldrsb
; A64-NEXT: tbnz

; A64-NOIFC-LABEL: char_len:
; A64-NOIFC-NOT: csel
; A64-NOIFC: ldrsb
; A64-NOIFC: and [[B:w[0-9]+]], [[B]], #0xff
; A64-NOIFC-NEXT: cmp [[B]], #224
; A64-NOIFC-NEXT: b.hs

; X86-LABEL: char_len:
; X86-NOT: cmov
; X86: movzbl
; X86: cmpb $-32,
; X86-NEXT: jb
; X86: cmpb $-16,
; X86: sbbq $0,

define i64 @char_len(ptr %s, i64 %n) {
entry:
  br label %loop
loop:
  %i = phi i64 [ 0, %entry ], [ %i2, %latch ]
  %p = getelementptr inbounds i8, ptr %s, i64 %i
  %b = load i8, ptr %p
  %ascii = icmp sgt i8 %b, -1
  br i1 %ascii, label %latch, label %multi
multi:
  %two = icmp ult i8 %b, -32
  br i1 %two, label %latch, label %big
big:
  %three = icmp ult i8 %b, -16
  %l34 = select i1 %three, i64 3, i64 4
  br label %latch
latch:
  %len = phi i64 [ 1, %loop ], [ 2, %multi ], [ %l34, %big ]
  %i2 = add i64 %i, %len
  %cont = icmp ult i64 %i2, %n
  br i1 %cont, label %loop, label %exit
exit:
  ret i64 %i2
}
