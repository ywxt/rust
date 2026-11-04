// S6:128 位整數移位 / 異或的相依鏈延遲,以及前綴異或一步 p ^= p << 1;GPR add 鏈為對照(應 1 cycle)
// 用法:./repro <shl|eor|step|gpr> 次數;每輪 8 條(step 為 8 步)
#include <stdlib.h>
#define R8(s) s s s s s s s s
#ifdef __aarch64__
#define LOOP(b) __asm__ volatile("movi v1.16b, #1\n 1:\n" b "subs %0, %0, #1\n b.ne 1b" : "+r"(n) :: "v0", "v1", "v2", "x9", "cc")
#define SHL "shl v0.2d, v0.2d, #1\n"
#define EOR "eor v0.16b, v0.16b, v1.16b\n"
#define STEP "shl v2.2d, v0.2d, #1\n eor v0.16b, v0.16b, v2.16b\n"
#define GPR "add x9, x9, x9\n"
#else
#define LOOP(b) __asm__ volatile("1:\n" b "dec %0\n jne 1b" : "+r"(n) :: "xmm0", "xmm1", "xmm2", "r9", "cc")
#define SHL "psllq $1, %%xmm0\n"
#define EOR "pxor %%xmm1, %%xmm0\n"
#define STEP "movdqa %%xmm0, %%xmm2\n psllq $1, %%xmm2\n pxor %%xmm2, %%xmm0\n"
#define GPR "add %%r9, %%r9\n"
#endif
int main(int c, char **v) {
  long n = atol(v[2]);
  switch (v[1][1]) {
  case 'h': LOOP(R8(SHL)); break;
  case 'o': LOOP(R8(EOR)); break;
  case 't': LOOP(R8(STEP)); break;
  case 'p': LOOP(R8(GPR)); break;
  }
  return 0;
}
