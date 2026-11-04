// R09:write_all_vectored 的拷貝形態:8 段(128,256,…,16384 B,共 32 640 B)依序拷進同一目的緩衝
// ./repro <libc|loop|erms> <總量上限 B> [迭代]
//   libc:glibc memcpy(x86 走 __memmove_avx_unaligned_erms,大段用 rep movsb)
//   loop:手寫 16 B 載入/存儲迴圈(x86 movups,aarch64 ldp/stp q 各 32 B)
//   erms:x86 直接 rep movsb(aarch64 不支援)
// 總量上限截斷段序列(例 8192 = 前 6 段 8 064 B),用於掃描工作集(來源 + 目的 ≈ 2 × 總量)
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
static void cp_loop(unsigned char *d, const unsigned char *s, size_t n) {
#if defined(__x86_64__)
  __asm__ volatile("1: movups (%1), %%xmm0\n movups 16(%1), %%xmm1\n movups %%xmm0, (%0)\n movups %%xmm1, 16(%0)\n"
                   " add $32, %0\n add $32, %1\n sub $32, %2\n ja 1b" : "+r"(d), "+r"(s), "+r"(n) :: "xmm0", "xmm1", "memory");
#elif defined(__aarch64__)
  __asm__ volatile("1: ldp q0, q1, [%1], #32\n stp q0, q1, [%0], #32\n subs %2, %2, #32\n b.hi 1b"
                   : "+r"(d), "+r"(s), "+r"(n) :: "v0", "v1", "memory", "cc");
#endif
}
static void cp_erms(unsigned char *d, const unsigned char *s, size_t n) {
#if defined(__x86_64__)
  __asm__ volatile("rep movsb" : "+D"(d), "+S"(s), "+c"(n) :: "memory");
#else
  (void)d; (void)s; (void)n; exit(2);
#endif
}
int main(int argc, char **argv) {
  const char *m = argv[1];
  size_t cap = atol(argv[2]);
  long it = argc > 3 ? atol(argv[3]) : 100000;
  unsigned char *src[8], *dst = aligned_alloc(64, 32768 + 64);
  size_t len[8], tot = 0; int k = 0;
  for (size_t sz = 128; sz <= 16384 && tot + sz <= cap; sz *= 2, k++) {
    src[k] = aligned_alloc(64, sz); memset(src[k], k + 1, sz); len[k] = sz; tot += sz;
  }
  void (*cp)(unsigned char *, const unsigned char *, size_t) =
      !strcmp(m, "libc") ? (void (*)(unsigned char *, const unsigned char *, size_t))memcpy
      : !strcmp(m, "loop") ? cp_loop : cp_erms;
  void (*volatile vcp)(unsigned char *, const unsigned char *, size_t) = cp;
  for (long i = 0; i < it; i++) {
    size_t off = 29;  // bench 的 Vec 先有 29 B
    for (int j = 0; j < k; j++) { vcp(dst + off, src[j], len[j]); off += len[j]; }
  }
  printf("%zu %d\n", tot, dst[100]);
  return 0;
}
