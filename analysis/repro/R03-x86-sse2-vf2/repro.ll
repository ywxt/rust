; R03:逐字節計數 (b as i8) >= -64 的歸約迴圈(char_count case01 的 general)。
; x86-64 基線(SSE2)cost model 只給 VF 2 × IC 2(i8→i64 加寬貴,無 pmovzx);x86-64-v2 仍 VF 2;
; aarch64 NEON VF 16 × IC 2。強制 VF 16 在 x86 上合法,見 FORCE。
; RUN: opt -passes=loop-vectorize -pass-remarks=loop-vectorize -disable-output -mtriple=x86_64-linux-gnu -mcpu=x86-64 %s 2>&1 | FileCheck %s --check-prefix=X86
; RUN: opt -passes=loop-vectorize -pass-remarks=loop-vectorize -disable-output -mtriple=x86_64-linux-gnu -mcpu=x86-64-v2 %s 2>&1 | FileCheck %s --check-prefix=X86
; RUN: opt -passes=loop-vectorize -pass-remarks=loop-vectorize -disable-output -mtriple=aarch64-linux-gnu %s 2>&1 | FileCheck %s --check-prefix=A64
; RUN: opt -passes=loop-vectorize -force-vector-width=16 -S -mtriple=x86_64-linux-gnu -mcpu=x86-64 %s | FileCheck %s --check-prefix=FORCE
; X86: vectorized loop (vectorization width: 2, interleaved count: 2)
; A64: vectorized loop (vectorization width: 16, interleaved count: 2)
; FORCE: load <16 x i8>
; FORCE: icmp sgt <16 x i8>
; FORCE: zext <16 x i1> {{.*}} to <16 x i64>

define i64 @count(ptr %p, i64 %n) {
entry:
  %e = icmp eq i64 %n, 0
  br i1 %e, label %done, label %loop
loop:
  %i = phi i64 [ 0, %entry ], [ %i1, %loop ]
  %acc = phi i64 [ 0, %entry ], [ %acc1, %loop ]
  %q = getelementptr inbounds i8, ptr %p, i64 %i
  %b = load i8, ptr %q, align 1
  %c = icmp sgt i8 %b, -65
  %z = zext i1 %c to i64
  %acc1 = add i64 %acc, %z
  %i1 = add nuw i64 %i, 1
  %x = icmp eq i64 %i1, %n
  br i1 %x, label %done, label %loop
done:
  %r = phi i64 [ 0, %entry ], [ %acc1, %loop ]
  ret i64 %r
}
