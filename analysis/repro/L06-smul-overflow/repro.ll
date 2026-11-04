; L06:64 位乘法溢出檢查。x86 的 imul/mul 直接設 OF;AArch64 的 mul 不設旗標,要多一條高半乘加比較。
; 屬 ISA 差異,不是 LLVM 選錯。
; RUN: llc -O3 -mtriple=aarch64-linux-gnu < %s | FileCheck %s --check-prefix=A64
; RUN: llc -O3 -mtriple=x86_64-linux-gnu < %s | FileCheck %s --check-prefix=X86

; A64-LABEL: smul:
; A64: mul [[L:x[0-9]+]], x0, x1
; A64: smulh [[H:x[0-9]+]], x0, x1
; A64: cmp [[H]], [[L]], asr #63
; A64-NEXT: csel {{x[0-9]+}}, xzr, {{x[0-9]+}}, ne
; A64-LABEL: umul:
; A64: umulh [[H:x[0-9]+]], x0, x1
; A64: cmp xzr, [[H]]
; A64-NEXT: csel {{x[0-9]+}}, xzr, {{x[0-9]+}}, ne
; A64: mul

; X86-LABEL: smul:
; X86: imulq
; X86-NEXT: jno
; X86-LABEL: umul:
; X86: mulq
; X86-NEXT: jno

define i64 @smul(i64 %a, i64 %b) {
  %r = call { i64, i1 } @llvm.smul.with.overflow.i64(i64 %a, i64 %b)
  %o = extractvalue { i64, i1 } %r, 1
  br i1 %o, label %ov, label %ok
ok:
  %v = extractvalue { i64, i1 } %r, 0
  ret i64 %v
ov:
  ret i64 0
}

define i64 @umul(i64 %a, i64 %b) {
  %r = call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %a, i64 %b)
  %o = extractvalue { i64, i1 } %r, 1
  br i1 %o, label %ov, label %ok
ok:
  %v = extractvalue { i64, i1 } %r, 0
  ret i64 %v
ov:
  ret i64 0
}
