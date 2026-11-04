// S3:SVE cmpeq / compact 的延遲(相依鏈)與吞吐(8 條獨立),NEON cmeq 為對照;僅 aarch64
// 用法:./repro <模式> 次數;模式首字 c=cmpeq k=compact n=NEON cmeq,次字 l=延遲 t=吞吐;每輪 8 條
#include <stdlib.h>
#define R8(s) s s s s s s s s
#define LOOP(body, ...) __asm__ volatile("ptrue p0.b\n dup z0.b, #1\n dup z1.b, #1\n movi v1.16b, #1\n" \
  "1:\n" body "subs %0, %0, #1\n b.ne 1b" : "+r"(n) :: "p1","p2","p3","p4","p5","p6","p7","p8", \
  "z0","z1","z2","z3","z4","z5","z6","z7","z8","z9","v0","v1","cc")
int main(int c, char **v) {
  long n = atol(v[2]);
  switch (v[1][0] << 8 | v[1][1]) { /* 首兩字母區分模式 */
  case 'c' << 8 | 'l': LOOP(R8("cmpeq p1.b, p1/z, z0.b, z1.b\n")); break; /* cl:p1 經治理謂詞成鏈 */
  case 'c' << 8 | 't': LOOP("cmpeq p1.b, p0/z, z0.b, z1.b\n cmpeq p2.b, p0/z, z0.b, z1.b\n cmpeq p3.b, p0/z, z0.b, z1.b\n cmpeq p4.b, p0/z, z0.b, z1.b\n"
                       "cmpeq p5.b, p0/z, z0.b, z1.b\n cmpeq p6.b, p0/z, z0.b, z1.b\n cmpeq p7.b, p0/z, z0.b, z1.b\n cmpeq p8.b, p0/z, z0.b, z1.b\n"); break;
  case 'k' << 8 | 'l': LOOP(R8("compact z0.s, p0, z0.s\n")); break;
  case 'k' << 8 | 't': LOOP("compact z2.s, p0, z0.s\n compact z3.s, p0, z0.s\n compact z4.s, p0, z0.s\n compact z5.s, p0, z0.s\n"
                       "compact z6.s, p0, z0.s\n compact z7.s, p0, z0.s\n compact z8.s, p0, z0.s\n compact z9.s, p0, z0.s\n"); break;
  case 'n' << 8 | 'l': LOOP(R8("cmeq v0.16b, v0.16b, v1.16b\n")); break;
  case 'n' << 8 | 't': LOOP(R8("cmeq v0.16b, v1.16b, v1.16b\n")); break;
  }
  return 0;
}
