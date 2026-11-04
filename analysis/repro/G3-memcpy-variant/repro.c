// L1 內重複拷貝(源與目的皆 4 KB 對齊,偏移另給):libc memcpy vs 同寬手寫 16 B 向量迴圈 vs rep movsb(x86)
// 用法:./repro <libc|hand|movsb> 次數 位元組 [源偏移](hand 需為 64 的倍數;偏移改變源/目的相對對齊)
#include <stdlib.h>
#include <string.h>
#ifdef __aarch64__
#include <arm_neon.h>
#define LD(p) vld1q_u8(p)
#define ST(p, x) vst1q_u8(p, x)
#else
#include <emmintrin.h>
#define LD(p) _mm_loadu_si128((void *)(p))
#define ST(p, x) _mm_storeu_si128((void *)(p), x)
#endif
static _Alignas(4096) unsigned char S0[16384 + 4096], d[16384];
static unsigned char *s;
__attribute__((noinline)) static void hand(unsigned char *d, const unsigned char *s, size_t n) {
  for (size_t i = 0; i < n; i += 64) {
    __typeof__(LD(s)) a = LD(s + i), b = LD(s + i + 16), c = LD(s + i + 32), e = LD(s + i + 48);
    ST(d + i, a); ST(d + i + 16, b); ST(d + i + 32, c); ST(d + i + 48, e);
  }
}
int main(int c, char **v) {
  long n = atol(v[2]); size_t z = atol(v[3]);
  s = S0 + (c > 4 ? atol(v[4]) : 0);
  while (n--) {
    if (v[1][0] == 'l') memcpy(d, s, z);
    else if (v[1][0] == 'h') hand(d, s, z);
#ifndef __aarch64__
    else { void *D = d, *S = s; size_t Z = z; __asm__ volatile("rep movsb" : "+D"(D), "+S"(S), "+c"(Z)::"memory"); }
#endif
    __asm__ volatile("" ::: "memory");
  }
  return d[1];
}
