; range.step_by(64).map(|x| x ^ (x - 1)).fold(0, add) 的標量迴圈(i16 與 i64 兩版)。
; i16:AArch64 generic 與 x86-64 基線都選 VF 8、IC 2,IR 層無差異。
; i64:AArch64 選 IC 4,x86 選 IC 2(成本模型差,章節中每元素打平)。
; 補充:AArch64 generic 的 IC 上限對 i16 是 2(i32 / i64 為 4),-mcpu=neoverse-v2 時 i16 也是 4。
; 開關:-force-vector-interleave=4。
;
; RUN: opt -mtriple=aarch64-linux-gnu -passes=loop-vectorize -pass-remarks=loop-vectorize -disable-output %s 2>&1 | FileCheck %s --check-prefix=A64
; RUN: opt -mtriple=x86_64-linux-gnu -passes=loop-vectorize -pass-remarks=loop-vectorize -disable-output %s 2>&1 | FileCheck %s --check-prefix=X86
; RUN: opt -mtriple=aarch64-linux-gnu -mcpu=neoverse-v2 -passes=loop-vectorize -pass-remarks=loop-vectorize -disable-output %s 2>&1 | FileCheck %s --check-prefix=V2
; RUN: opt -mtriple=aarch64-linux-gnu -force-vector-interleave=4 -passes=loop-vectorize -pass-remarks=loop-vectorize -disable-output %s 2>&1 | FileCheck %s --check-prefix=V2

; A64: vectorization width: 8, interleaved count: 2
; A64: vectorization width: 2, interleaved count: 4
; X86: vectorization width: 8, interleaved count: 2
; X86: vectorization width: 2, interleaved count: 2
; V2:  vectorization width: 8, interleaved count: 4

define i16 @f16(i16 %n) {
entry:
  br label %loop
loop:
  %k = phi i16 [ 0, %entry ], [ %k1, %loop ]
  %acc = phi i16 [ 0, %entry ], [ %acc1, %loop ]
  %i = shl i16 %k, 6
  %m = add i16 %i, -1
  %x = xor i16 %i, %m
  %acc1 = add i16 %acc, %x
  %k1 = add nuw i16 %k, 1
  %c = icmp eq i16 %k1, %n
  br i1 %c, label %exit, label %loop
exit:
  ret i16 %acc1
}

define i64 @f64(i64 %n) {
entry:
  br label %loop
loop:
  %k = phi i64 [ 0, %entry ], [ %k1, %loop ]
  %acc = phi i64 [ 0, %entry ], [ %acc1, %loop ]
  %i = shl i64 %k, 6
  %m = add i64 %i, -1
  %x = xor i64 %i, %m
  %acc1 = add i64 %acc, %x
  %k1 = add nuw i64 %k, 1
  %c = icmp eq i64 %k1, %n
  br i1 %c, label %exit, label %loop
exit:
  ret i64 %acc1
}
