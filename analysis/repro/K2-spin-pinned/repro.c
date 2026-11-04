// K2:兩執行緒 ping-pong;對端以非阻塞 read 自旋(spin)或 EAGAIN 後 sched_yield(yield),只差這一處
// 須以 taskset 綁同一核。用法:./repro <spin|yield> 來回次數;印對端佔 CPU 時間比例
#define _GNU_SOURCE
#include <fcntl.h>
#include <pthread.h>
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
static int a[2], b[2], yld;
static void *peer(void *x) {
  char c;
  for (;;) if (read(a[0], &c, 1) == 1) write(b[1], &c, 1); else if (yld) sched_yield();
}
static double t(clockid_t k) { struct timespec s; clock_gettime(k, &s); return s.tv_sec + s.tv_nsec * 1e-9; }
int main(int c, char **v) {
  long n = atol(v[2]); char ch = 0; pthread_t th; clockid_t k;
  yld = v[1][0] == 'y'; pipe(a); pipe(b); fcntl(a[0], F_SETFL, O_NONBLOCK);
  pthread_create(&th, 0, peer, 0); pthread_getcpuclockid(th, &k);
  while (n--) { write(a[1], &ch, 1); read(b[0], &ch, 1); }
  printf("%s 對端佔 CPU %.1f%%\n", v[1], 100 * t(k) / t(CLOCK_PROCESS_CPUTIME_ID));
  return 0;
}
