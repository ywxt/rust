; R08:Vec::<u64>::dedup 的分塊 prescan(library/alloc/src/vec/mod.rs:dedup_simd_chunk_size 的 cfg_select!
; 與 find_first_duplicate::find_duplicate,上游 07e526db9df,#162810)。
; std 在 x86 只有 target_feature="sse4.1" 才對 8 B 元素啟用分塊(註解:64 位相等比較需 SSE4.1 的 pcmpeqq),
; x86-64 基線(SSE2)回退 dedup_by 標量迴圈;aarch64 NEON 一律啟用。
; @chunk = find_duplicate 在 chunk_size=4(16*2/8)展開後的標量 IR,分塊路徑全靠 SLP 自動向量化:
;   SSE2 不向量化;SSE4.1(std 的啟用條件)仍不向量化(cost 2 > 0);SSE4.2 與 aarch64 向量化。
; @veq 顯示 <2 x i64> 相等在 SSE2 也能下降(pcmpeqd+pshufd+pand),SSE4.1 為 pcmpeqq,aarch64 為 cmeq .2d。
; RUN: opt -S -passes=slp-vectorizer -mtriple=x86_64-linux-gnu -mcpu=x86-64 %s | FileCheck %s --check-prefix=SCALAR
; RUN: opt -S -passes=slp-vectorizer -mtriple=x86_64-linux-gnu -mcpu=x86-64 -mattr=+sse4.1 %s | FileCheck %s --check-prefix=SCALAR
; RUN: opt -disable-output -passes=slp-vectorizer -pass-remarks-missed=slp-vectorizer -mtriple=x86_64-linux-gnu -mcpu=x86-64 -mattr=+sse4.1 %s 2>&1 | FileCheck %s --check-prefix=MISS41
; RUN: opt -S -passes=slp-vectorizer -mtriple=x86_64-linux-gnu -mcpu=x86-64 -mattr=+sse4.2 %s | FileCheck %s --check-prefix=VEC
; RUN: opt -S -passes=slp-vectorizer -mtriple=aarch64-linux-gnu %s | FileCheck %s --check-prefix=VEC
; RUN: llc -O3 -mtriple=x86_64-linux-gnu -mcpu=x86-64 %s -o - | FileCheck %s --check-prefix=SSE2
; RUN: llc -O3 -mtriple=x86_64-linux-gnu -mcpu=x86-64 -mattr=+sse4.1 %s -o - | FileCheck %s --check-prefix=SSE41
; RUN: llc -O3 -mtriple=aarch64-linux-gnu %s -o - | FileCheck %s --check-prefix=A64

define i32 @chunk(ptr %v) {
  %p1 = getelementptr inbounds i8, ptr %v, i64 8
  %a1 = load i64, ptr %p1, align 8
  %a0 = load i64, ptr %v, align 8
  %e0 = icmp eq i64 %a1, %a0
  %m0 = zext i1 %e0 to i32
  %p2 = getelementptr inbounds i8, ptr %v, i64 16
  %a2 = load i64, ptr %p2, align 8
  %e1 = icmp eq i64 %a2, %a1
  %b1 = select i1 %e1, i32 2, i32 0
  %m1 = or disjoint i32 %b1, %m0
  %p3 = getelementptr inbounds i8, ptr %v, i64 24
  %a3 = load i64, ptr %p3, align 8
  %e2 = icmp eq i64 %a3, %a2
  %b2 = select i1 %e2, i32 4, i32 0
  %m2 = or disjoint i32 %b2, %m1
  %p4 = getelementptr inbounds i8, ptr %v, i64 32
  %a4 = load i64, ptr %p4, align 8
  %e3 = icmp eq i64 %a4, %a3
  %b3 = select i1 %e3, i32 8, i32 0
  %m3 = or disjoint i32 %b3, %m2
  ret i32 %m3
}

define i2 @veq(<2 x i64> %a, <2 x i64> %b) {
  %e = icmp eq <2 x i64> %a, %b
  %m = bitcast <2 x i1> %e to i2
  ret i2 %m
}

; SCALAR-LABEL: @chunk(
; SCALAR-NOT:   icmp eq <
; SCALAR:       ret i32
; MISS41:       Vectorizing horizontal reduction is possible but not beneficial
; VEC-LABEL:    @chunk(
; VEC:          icmp eq <4 x i64>

; SSE2-LABEL:  veq:
; SSE2:        pcmpeqd
; SSE2-NEXT:   pshufd
; SSE2-NEXT:   pand
; SSE2-NEXT:   movmskpd
; SSE41-LABEL: veq:
; SSE41:       pcmpeqq
; SSE41-NEXT:  movmskpd
; A64-LABEL:   veq:
; A64:         cmeq v0.2d, v0.2d, v1.2d
