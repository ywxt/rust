// G2:L1 內 1000 B memset。set1:libc 非零;set0:libc 零(對照:只差值);hand:同寬 16 B 向量 store 迴圈
// bb1:同 set1,但指標與長度經記憶體來回(模擬章節探針的 black_box,只差這一處)
// 用法:./repro <set1|set0|hand|bb1> 次數 [起點偏移]
#include <stdlib.h>
#include <string.h>
#ifdef __aarch64__
#include <arm_neon.h>
#define ST(p) vst1q_u8(p, vdupq_n_u8(1))
#else
#include <emmintrin.h>
#define ST(p) _mm_storeu_si128((void *)(p), _mm_set1_epi8(1))
#endif
static _Alignas(64) unsigned char D[1024 + 64];
__attribute__((noinline)) static void hand(unsigned char *p, size_t n) {
  for (size_t i = 0; i + 16 < n; i += 16) ST(p + i);
  ST(p + n - 16); /* 尾端重疊 store */
}
int main(int c, char **v) {
  long n = atol(v[2]); unsigned char *d = D + (c > 3 ? atol(v[3]) : 0);
  while (n--) {
    if (v[1][0] == 'b') { unsigned char *volatile vp = d; volatile size_t vn = 1000; memset(vp, 1, vn); }
    else if (v[1][0] == 'h') hand(d, 1000);
    else memset(d, v[1][3] - '0', 1000);
    __asm__ volatile("" ::: "memory");
  }
  return D[7];
}
