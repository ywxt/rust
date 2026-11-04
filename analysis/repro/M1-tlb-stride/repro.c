// M1:同樣 4096 個快取行(256 KB,L2 內)、同樣跳 1153 行的訪問序,只差行如何落到 4 KB 頁:
//   spread:每頁一行 → 4096 頁(16 MB 跨度,超出 STLB)  pack:連續 → 64 頁
// 用法:./repro <spread|pack> 次數
#include <stdlib.h>
#include <sys/mman.h>
#define M 4096UL
#define S 1153UL /* 72 KB + 64 B,與 M 互質 */
int main(int c, char **v) {
  long n = atol(v[2]);
  unsigned long w = v[1][0] == 's' ? 4096 + 64 : 64; /* 行間距;spread 每頁錯開 64 B 以分散快取組 */
  char *b = mmap(0, M * w, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
  madvise(b, M * w, MADV_NOHUGEPAGE); /* aarch64 THP=always,須關掉 */
  for (unsigned long k = 0; k < M; k++) *(char **)(b + k * w) = b + (k + S) % M * w;
  char *p = b;
  while (n--) p = *(char **)p;
  return p == 0;
}
