// G4:malloc+free 與 calloc+free 每對成本;800 B 在 tcache 內,8000 B 超出
// 用法:./repro <malloc|calloc> 次數 位元組
#include <stdlib.h>
int main(int c, char **v) {
  long n = atol(v[2]); size_t z = atol(v[3]);
  void *volatile p;
  while (n--) { p = v[1][0] == 'm' ? malloc(z) : calloc(1, z); free(p); }
  return 0;
}
