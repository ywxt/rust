#include <dlfcn.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
int main(int argc,char**argv){void*h=dlopen(argv[1],RTLD_NOW);if(!h){puts(dlerror());return 1;}void(*setup)(int)=dlsym(h,"setup");setup(atoi(argv[3]));char name[40];snprintf(name,sizeof name,"d%d",atoi(argv[2]));uint64_t(*f)(uint64_t)=dlsym(h,name);uint64_t n=strtoull(argv[4],0,10),sum=0;for(uint64_t i=0;i<n;i++)sum+=f(i);printf("%llu\n",(unsigned long long)sum);}
