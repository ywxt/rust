// S2:同寬 16 B 的 memchr 形迴圈,命中後向量遮罩 → GPR → 計尾零
//   aarch64:cmeq → shrn #4 → fmov → rbit/clz   x86:pcmpeqb → pmovmskb → tzcnt
// 用法:./repro chain 次數 D(每 D 位元組一個命中,下次從命中後開始,延遲鏈)
//       ./repro nomatch 次數 LEN(無命中,吞吐;對照組)
#include <stdlib.h>
#include <string.h>
#ifdef __aarch64__
#include <arm_neon.h>
#else
#include <emmintrin.h>
#endif
__attribute__((noinline)) static long find(const unsigned char *p, long n, unsigned char c) {
  for (long i = 0; i + 16 <= n; i += 16) {
#ifdef __aarch64__
    uint8x16_t e = vceqq_u8(vld1q_u8(p + i), vdupq_n_u8(c));
    uint64_t m = vget_lane_u64(vreinterpret_u64_u8(vshrn_n_u16(vreinterpretq_u16_u8(e), 4)), 0);
    if (m) return i + (__builtin_ctzll(m) >> 2);
#else
    unsigned m = _mm_movemask_epi8(_mm_cmpeq_epi8(_mm_loadu_si128((void *)(p + i)), _mm_set1_epi8(c)));
    if (m) return i + __builtin_ctz(m);
#endif
  }
  return n;
}
static unsigned char b[8192 + 64];
int main(int c, char **v) {
  long n = atol(v[2]), d = atol(v[3]), pos = 0, s = 0;
  memset(b, 'a', sizeof b);
  if (v[1][0] == 'c') for (long i = d - 1; i < 8192; i += d) b[i] = 'x';
  while (n--) {
    if (v[1][0] == 'c') { pos += find(b + pos, 8192 - pos, 'x') + 1; if (pos > 8000) pos = 0; }
    else s += find(b, d, 'x');
  }
  return (pos + s) & 1;
}
