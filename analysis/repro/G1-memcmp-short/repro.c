// G1:libc memcmp 短串;62 字母表隨機內容。rand:長度 1–20 隨機;fixed:長度固定 10(只差長度分佈)
// 用法:./repro <rand|fixed> 次數
#include <stdlib.h>
#include <string.h>
static unsigned char a[4096 * 32], b[4096 * 32], len[4096];
int main(int c, char **v) {
  long n = atol(v[2]), s = 0;
  for (int i = 0; i < 4096 * 32; i++) a[i] = 'A' + random() % 62, b[i] = 'A' + random() % 62;
  for (int i = 0; i < 4096; i++) len[i] = v[1][0] == 'r' ? 1 + random() % 20 : 10;
  for (long k = 0; k < n; k++) { int i = k & 4095; s += memcmp(a + i * 32, b + i * 32, len[i]) > 0; }
  return s & 1;
}
