#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#ifdef __aarch64__
#include <arm_neon.h>
#define STORE(p) vst1q_u8(p,vdupq_n_u8(1))
#else
#include <emmintrin.h>
#define STORE(p) _mm_storeu_si128((void*)(p),_mm_set1_epi8(1))
#endif
static _Alignas(64) unsigned char d[1200];
__attribute__((noinline)) void h1(unsigned char*p){size_t i=0;for(;i+16<=992;i+=16){STORE(p+i+0);}for(;i<992;i+=16){STORE(p+i);}STORE(p+984);}
__attribute__((noinline)) void h2(unsigned char*p){size_t i=0;for(;i+32<=992;i+=32){STORE(p+i+0);STORE(p+i+16);}for(;i<992;i+=16){STORE(p+i);}STORE(p+984);}
__attribute__((noinline)) void h4(unsigned char*p){size_t i=0;for(;i+64<=992;i+=64){STORE(p+i+0);STORE(p+i+16);STORE(p+i+32);STORE(p+i+48);}for(;i<992;i+=16){STORE(p+i);}STORE(p+984);}
__attribute__((noinline)) void h8(unsigned char*p){size_t i=0;for(;i+128<=992;i+=128){STORE(p+i+0);STORE(p+i+16);STORE(p+i+32);STORE(p+i+48);STORE(p+i+64);STORE(p+i+80);STORE(p+i+96);STORE(p+i+112);}for(;i<992;i+=16){STORE(p+i);}STORE(p+984);}
__attribute__((noinline)) void h64(unsigned char*p){size_t i=0;STORE(p+0);STORE(p+16);STORE(p+32);STORE(p+48);STORE(p+64);STORE(p+80);STORE(p+96);STORE(p+112);STORE(p+128);STORE(p+144);STORE(p+160);STORE(p+176);STORE(p+192);STORE(p+208);STORE(p+224);STORE(p+240);STORE(p+256);STORE(p+272);STORE(p+288);STORE(p+304);STORE(p+320);STORE(p+336);STORE(p+352);STORE(p+368);STORE(p+384);STORE(p+400);STORE(p+416);STORE(p+432);STORE(p+448);STORE(p+464);STORE(p+480);STORE(p+496);STORE(p+512);STORE(p+528);STORE(p+544);STORE(p+560);STORE(p+576);STORE(p+592);STORE(p+608);STORE(p+624);STORE(p+640);STORE(p+656);STORE(p+672);STORE(p+688);STORE(p+704);STORE(p+720);STORE(p+736);STORE(p+752);STORE(p+768);STORE(p+784);STORE(p+800);STORE(p+816);STORE(p+832);STORE(p+848);STORE(p+864);STORE(p+880);STORE(p+896);STORE(p+912);STORE(p+928);STORE(p+944);STORE(p+960);STORE(p+976);STORE(p+984);}
#ifdef __aarch64__
#include <arm_sve.h>
__attribute__((noinline)) void h32(unsigned char*p){svbool_t pg=svptrue_b8();svuint8_t x=svdup_u8(1);
svst1_u8(pg,p+0,x);svst1_u8(pg,p+32,x);svst1_u8(pg,p+64,x);svst1_u8(pg,p+96,x);svst1_u8(pg,p+128,x);svst1_u8(pg,p+160,x);svst1_u8(pg,p+192,x);svst1_u8(pg,p+224,x);svst1_u8(pg,p+256,x);svst1_u8(pg,p+288,x);svst1_u8(pg,p+320,x);svst1_u8(pg,p+352,x);svst1_u8(pg,p+384,x);svst1_u8(pg,p+416,x);svst1_u8(pg,p+448,x);svst1_u8(pg,p+480,x);svst1_u8(pg,p+512,x);svst1_u8(pg,p+544,x);svst1_u8(pg,p+576,x);svst1_u8(pg,p+608,x);svst1_u8(pg,p+640,x);svst1_u8(pg,p+672,x);svst1_u8(pg,p+704,x);svst1_u8(pg,p+736,x);svst1_u8(pg,p+768,x);svst1_u8(pg,p+800,x);svst1_u8(pg,p+832,x);svst1_u8(pg,p+864,x);svst1_u8(pg,p+896,x);svst1_u8(pg,p+928,x);svst1_u8(pg,p+960,x);svst1_u8(pg,p+968,x);}
#else
#include <immintrin.h>
__attribute__((noinline,target("avx2"))) void h32(unsigned char*p){__m256i x=_mm256_set1_epi8(1);
_mm256_storeu_si256((__m256i*)(p+0),x);_mm256_storeu_si256((__m256i*)(p+32),x);_mm256_storeu_si256((__m256i*)(p+64),x);_mm256_storeu_si256((__m256i*)(p+96),x);_mm256_storeu_si256((__m256i*)(p+128),x);_mm256_storeu_si256((__m256i*)(p+160),x);_mm256_storeu_si256((__m256i*)(p+192),x);_mm256_storeu_si256((__m256i*)(p+224),x);_mm256_storeu_si256((__m256i*)(p+256),x);_mm256_storeu_si256((__m256i*)(p+288),x);_mm256_storeu_si256((__m256i*)(p+320),x);_mm256_storeu_si256((__m256i*)(p+352),x);_mm256_storeu_si256((__m256i*)(p+384),x);_mm256_storeu_si256((__m256i*)(p+416),x);_mm256_storeu_si256((__m256i*)(p+448),x);_mm256_storeu_si256((__m256i*)(p+480),x);_mm256_storeu_si256((__m256i*)(p+512),x);_mm256_storeu_si256((__m256i*)(p+544),x);_mm256_storeu_si256((__m256i*)(p+576),x);_mm256_storeu_si256((__m256i*)(p+608),x);_mm256_storeu_si256((__m256i*)(p+640),x);_mm256_storeu_si256((__m256i*)(p+672),x);_mm256_storeu_si256((__m256i*)(p+704),x);_mm256_storeu_si256((__m256i*)(p+736),x);_mm256_storeu_si256((__m256i*)(p+768),x);_mm256_storeu_si256((__m256i*)(p+800),x);_mm256_storeu_si256((__m256i*)(p+832),x);_mm256_storeu_si256((__m256i*)(p+864),x);_mm256_storeu_si256((__m256i*)(p+896),x);_mm256_storeu_si256((__m256i*)(p+928),x);_mm256_storeu_si256((__m256i*)(p+960),x);_mm256_storeu_si256((__m256i*)(p+968),x);}
#endif
int main(int argc,char**v){long n=atol(v[2]);unsigned char*p=d+(argc>3?atoi(v[3]):0);void(*f)(unsigned char*)=0;switch(atoi(v[1])){case 32:f=h32;break;case 1:f=h1;break;case 2:f=h2;break;case 4:f=h4;break;case 8:f=h8;break;case 64:f=h64;break;}for(long i=0;i<n;i++){if(f)f(p);else memset(p,1,1000);__asm__ volatile("" ::: "memory");}for(int i=0;i<1000;i++)if(p[i]!=1)return 2;printf("ok\n");}
