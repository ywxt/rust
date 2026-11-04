// M5:隨機循環指標追逐(每 64 B 一個節點),工作集大小為參數;頁大小可選以分開 TLB 與容量
// 用法:./repro <4k|2m> 次數 MiB
#include <stdlib.h>
#include <sys/mman.h>
int main(int c, char **v) {
  long n = atol(v[2]);
  unsigned long L = atol(v[3]) << 14, *ix = malloc(L * 8); /* MiB → 64 B 行數 */
  char *b = mmap(0, L * 64, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
  madvise(b, L * 64, v[1][0] == '2' ? MADV_HUGEPAGE : MADV_NOHUGEPAGE);
  for (unsigned long i = 0; i < L; i++) ix[i] = i;
  for (unsigned long i = L - 1; i; i--) { unsigned long j = random() % i, t = ix[i]; ix[i] = ix[j]; ix[j] = t; } /* Sattolo:單一循環 */
  for (unsigned long i = 0; i < L; i++) *(char **)(b + ix[i] * 64) = b + ix[(i + 1) % L] * 64;
  char *p = b;
  while (n--) p = *(char **)p;
  return p == 0;
}
