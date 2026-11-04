; <16 x i1> → i16 位元遮罩(movemask)。
; x86:一條 pmovmskb。AArch64(含 +sve)無 movemask:cmlt + and 位權常數 + 3×addp + umov。
; 只判非零時 AArch64 走 addp d + fmov,不必完整遮罩。
;
; RUN: llc -mtriple=aarch64-linux-gnu -O3 -asm-verbose=false %s -o - | FileCheck %s --check-prefix=A64
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve -O3 -asm-verbose=false %s -o - | FileCheck %s --check-prefix=A64
; RUN: llc -mtriple=x86_64-linux-gnu -O3 -asm-verbose=false %s -o - | FileCheck %s --check-prefix=X86

; A64-LABEL: mask:
; A64:       cmlt v0.16b, v0.16b, #0
; A64:       and v0.16b, v0.16b, v1.16b
; A64-NEXT:  addp v0.16b, v0.16b, v0.16b
; A64-NEXT:  addp v0.16b, v0.16b, v0.16b
; A64-NEXT:  addp v0.16b, v0.16b, v0.16b
; A64-NEXT:  umov w0, v0.h[0]
; A64-NEXT:  ret
; A64-LABEL: any:
; A64:       cmlt v0.16b, v0.16b, #0
; A64-NEXT:  addp d0, v0.2d
; A64-NEXT:  fmov x8, d0

; X86-LABEL: mask:
; X86:       pmovmskb %xmm0, %eax
; X86-NEXT:  retq
; X86-LABEL: any:
; X86:       pmovmskb %xmm0, %eax
; X86-NEXT:  testl %eax, %eax

define i16 @mask(<16 x i8> %v) {
  %c = icmp slt <16 x i8> %v, zeroinitializer
  %m = bitcast <16 x i1> %c to i16
  ret i16 %m
}

define i1 @any(<16 x i8> %v) {
  %c = icmp slt <16 x i8> %v, zeroinitializer
  %m = bitcast <16 x i1> %c to i16
  %r = icmp ne i16 %m, 0
  ret i1 %r
}
