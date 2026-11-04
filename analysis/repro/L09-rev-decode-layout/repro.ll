; 反向 UTF-8 解碼(chars().rev().count() 的迴圈,兩 target 的 rustc IR 相同,此為縮減版)。
; AArch64:預設佈局把 ASCII 路徑的尾端放在迴圈外,ASCII 字元走 tbz(taken)+ b.ne(taken)= 2 個 taken;
;   探測載入用 pre-index 回寫,前後各一條 mov 搬指針。
; x86:迴圈已旋轉,ASCII 字元只有 jns 一個 taken,指針用 dec / add 立即數。
; 開關:-enable-ext-tsp-block-placement(或 -mcpu=tsv110)使 AArch64 旋轉迴圈,ASCII 只剩 1 個 taken;mov + 回寫不變。
;
; RUN: llc -mtriple=aarch64-linux-gnu -O3 -asm-verbose=false %s -o - | FileCheck %s --check-prefix=A64
; RUN: llc -mtriple=x86_64-linux-gnu -O3 -asm-verbose=false %s -o - | FileCheck %s --check-prefix=X86
; RUN: llc -mtriple=aarch64-linux-gnu -O3 -asm-verbose=false -enable-ext-tsp-block-placement %s -o - | FileCheck %s --check-prefix=A64-TSP

; ASCII 字元路徑:tbz 跳到迴圈外的尾端,b.ne 再跳回 = 2 個 taken
; A64-LABEL: f:
; A64:       [[LOOP:.LBB0_[0-9]+]]:
; A64-NEXT:  mov x10, x9
; A64-NEXT:  ldrsb w11, [x10, #-1]!
; A64-NEXT:  tbz w11, #31, [[ASC:.LBB0_[0-9]+]]
; A64:       b.ne [[LOOP]]
; A64-NEXT:  b
; A64-NEXT:  [[ASC]]:
; A64-NEXT:  mov x9, x10
; A64-NEXT:  cmp x8, x10
; A64-NEXT:  add x0, x0, #1
; A64-NEXT:  b.ne [[LOOP]]

; ASCII 字元路徑:jns 跳回 decq,其後 je 不跳 = 1 個 taken
; X86-LABEL: f:
; X86:       [[TOP:.LBB0_[0-9]+]]:
; X86-NEXT:  decq %rsi
; X86-NEXT:  .LBB0_{{[0-9]+}}:
; X86-NEXT:  incq %rax
; X86-NEXT:  cmpq %rsi, %rdi
; X86-NEXT:  je
; X86-NEXT:  .LBB0_{{[0-9]+}}:
; X86-NEXT:  cmpb $0, -1(%rsi)
; X86-NEXT:  jns [[TOP]]

; A64-TSP-LABEL: f:
; A64-TSP:       [[TAIL:.LBB0_[0-9]+]]:
; A64-TSP-NEXT:  mov x9, x10
; A64-TSP-NEXT:  cmp x8, x10
; A64-TSP-NEXT:  add x0, x0, #1
; A64-TSP-NEXT:  b.eq
; A64-TSP-NEXT:  .LBB0_{{[0-9]+}}:
; A64-TSP-NEXT:  mov x10, x9
; A64-TSP-NEXT:  ldrsb w11, [x10, #-1]!
; A64-TSP-NEXT:  tbz w11, #31, [[TAIL]]

define i64 @f(ptr %s, i64 %len) {
entry:
  %end = getelementptr inbounds i8, ptr %s, i64 %len
  br label %loop

loop:
  %n = phi i64 [ 0, %entry ], [ %n1, %next ]
  %p = phi ptr [ %end, %entry ], [ %q, %next ]
  %p1 = getelementptr inbounds i8, ptr %p, i64 -1
  %b1 = load i8, ptr %p1, align 1
  %ascii = icmp sgt i8 %b1, -1
  br i1 %ascii, label %next, label %cont2

cont2:
  %p2 = getelementptr inbounds i8, ptr %p, i64 -2
  %b2 = load i8, ptr %p2, align 1
  %c2 = icmp slt i8 %b2, -64
  br i1 %c2, label %cont3, label %next

cont3:
  %p3 = getelementptr inbounds i8, ptr %p, i64 -3
  %b3 = load i8, ptr %p3, align 1
  %c3 = icmp slt i8 %b3, -64
  %p4 = getelementptr inbounds i8, ptr %p, i64 -4
  %sel = select i1 %c3, ptr %p4, ptr %p3
  br label %next

next:
  %q = phi ptr [ %p1, %loop ], [ %p2, %cont2 ], [ %sel, %cont3 ]
  %n1 = add i64 %n, 1
  %done = icmp eq ptr %s, %q
  br i1 %done, label %exit, label %loop

exit:
  ret i64 %n1
}
