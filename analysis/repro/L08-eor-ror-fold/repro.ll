; rotate + xor:AArch64 摺成一條 eor ..., ror #n,x86 為 rol + xor。
; AArch64 無開關可關閉此摺疊(-disable-shifter-op 無效)。
;
; RUN: llc -mtriple=aarch64-linux-gnu -O3 %s -o - | FileCheck %s --check-prefix=A64
; RUN: llc -mtriple=aarch64-linux-gnu -O3 -mcpu=tsv110 %s -o - | FileCheck %s --check-prefix=A64
; RUN: llc -mtriple=x86_64-linux-gnu -O3 %s -o - | FileCheck %s --check-prefix=X86

; A64-LABEL: f:
; A64-NOT:   ror x
; A64:       eor x0, x1, x0, ror #51
; A64-NEXT:  ret

; X86-LABEL: f:
; X86:       rolq $13, %rax
; X86-NEXT:  xorq %rsi, %rax

define i64 @f(i64 %a, i64 %b) {
  %r = call i64 @llvm.fshl.i64(i64 %a, i64 %a, i64 13)
  %x = xor i64 %r, %b
  ret i64 %x
}
