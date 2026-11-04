#include <stdlib.h>
#include <stdint.h>
static int mode;
void setup(int m){mode=m;}
__attribute__((noinline,aligned(64))) uint64_t d0(uint64_t x){if(!mode)return x+1;char*p=malloc(3); __asm__ volatile("" : "+r"(p) :: "memory");p[0]=(char)x;uint64_t y=(unsigned char)p[0];free(p);return y+1;}
__attribute__((noinline,aligned(64))) uint64_t d1(uint64_t x){return d0(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d2(uint64_t x){return d1(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d3(uint64_t x){return d2(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d4(uint64_t x){return d3(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d5(uint64_t x){return d4(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d6(uint64_t x){return d5(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d7(uint64_t x){return d6(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d8(uint64_t x){return d7(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d9(uint64_t x){return d8(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d10(uint64_t x){return d9(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d11(uint64_t x){return d10(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d12(uint64_t x){return d11(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d13(uint64_t x){return d12(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d14(uint64_t x){return d13(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d15(uint64_t x){return d14(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d16(uint64_t x){return d15(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d17(uint64_t x){return d16(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d18(uint64_t x){return d17(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d19(uint64_t x){return d18(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d20(uint64_t x){return d19(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d21(uint64_t x){return d20(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d22(uint64_t x){return d21(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d23(uint64_t x){return d22(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d24(uint64_t x){return d23(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d25(uint64_t x){return d24(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d26(uint64_t x){return d25(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d27(uint64_t x){return d26(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d28(uint64_t x){return d27(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d29(uint64_t x){return d28(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d30(uint64_t x){return d29(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d31(uint64_t x){return d30(x)+1;}
__attribute__((noinline,aligned(64))) uint64_t d32(uint64_t x){return d31(x)+1;}
