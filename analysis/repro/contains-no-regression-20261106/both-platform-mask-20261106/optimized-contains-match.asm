
/tmp/contains-both-mask-20261106/sysroots/optimized/lib/rustlib/x86_64-unknown-linux-gnu/lib/libstd-320fe7036dd8354d.so:     file format elf64-x86-64


Disassembly of section .text:

0000000000114950 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14contains_match>:
  114950:	b8 01 00 00 00       	mov    $0x1,%eax
  114955:	40 38 3e             	cmp    %dil,(%rsi)
  114958:	0f 84 c9 00 00 00    	je     114a27 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14contains_match+0xd7>
  11495e:	40 0f b6 cf          	movzbl %dil,%ecx
  114962:	66 0f 6e c1          	movd   %ecx,%xmm0
  114966:	66 0f 60 c0          	punpcklbw %xmm0,%xmm0
  11496a:	f2 0f 70 c0 00       	pshuflw $0x0,%xmm0,%xmm0
  11496f:	66 0f 70 c0 44       	pshufd $0x44,%xmm0,%xmm0
  114974:	48 b9 c0 ff ff ff ff 	movabs $0x7fffffffffffffc0,%rcx
  11497b:	ff ff 7f 
  11497e:	48 21 d1             	and    %rdx,%rcx
  114981:	74 53                	je     1149d6 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14contains_match+0x86>
  114983:	31 ff                	xor    %edi,%edi
  114985:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  11498c:	00 00 00 00 
  114990:	f3 0f 6f 0c 3e       	movdqu (%rsi,%rdi,1),%xmm1
  114995:	f3 0f 6f 54 3e 10    	movdqu 0x10(%rsi,%rdi,1),%xmm2
  11499b:	f3 0f 6f 5c 3e 20    	movdqu 0x20(%rsi,%rdi,1),%xmm3
  1149a1:	f3 0f 6f 64 3e 30    	movdqu 0x30(%rsi,%rdi,1),%xmm4
  1149a7:	66 0f 74 c8          	pcmpeqb %xmm0,%xmm1
  1149ab:	66 0f 74 d0          	pcmpeqb %xmm0,%xmm2
  1149af:	66 0f eb d1          	por    %xmm1,%xmm2
  1149b3:	66 0f 74 d8          	pcmpeqb %xmm0,%xmm3
  1149b7:	66 0f 74 e0          	pcmpeqb %xmm0,%xmm4
  1149bb:	66 0f eb e3          	por    %xmm3,%xmm4
  1149bf:	66 0f eb e2          	por    %xmm2,%xmm4
  1149c3:	66 44 0f d7 c4       	pmovmskb %xmm4,%r8d
  1149c8:	45 85 c0             	test   %r8d,%r8d
  1149cb:	75 5a                	jne    114a27 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14contains_match+0xd7>
  1149cd:	48 83 c7 40          	add    $0x40,%rdi
  1149d1:	48 39 f9             	cmp    %rdi,%rcx
  1149d4:	75 ba                	jne    114990 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14contains_match+0x40>
  1149d6:	48 89 d7             	mov    %rdx,%rdi
  1149d9:	48 83 e7 30          	and    $0x30,%rdi
  1149dd:	74 2e                	je     114a0d <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14contains_match+0xbd>
  1149df:	48 01 f1             	add    %rsi,%rcx
  1149e2:	45 31 c0             	xor    %r8d,%r8d
  1149e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  1149ec:	00 00 00 00 
  1149f0:	f3 42 0f 6f 0c 01    	movdqu (%rcx,%r8,1),%xmm1
  1149f6:	66 0f 74 c8          	pcmpeqb %xmm0,%xmm1
  1149fa:	66 44 0f d7 c9       	pmovmskb %xmm1,%r9d
  1149ff:	45 85 c9             	test   %r9d,%r9d
  114a02:	75 23                	jne    114a27 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14contains_match+0xd7>
  114a04:	49 83 c0 10          	add    $0x10,%r8
  114a08:	4c 39 c7             	cmp    %r8,%rdi
  114a0b:	75 e3                	jne    1149f0 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14contains_match+0xa0>
  114a0d:	f6 c2 0f             	test   $0xf,%dl
  114a10:	74 16                	je     114a28 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14contains_match+0xd8>
  114a12:	f3 0f 6f 4c 16 f0    	movdqu -0x10(%rsi,%rdx,1),%xmm1
  114a18:	66 0f 74 c8          	pcmpeqb %xmm0,%xmm1
  114a1c:	66 0f d7 c9          	pmovmskb %xmm1,%ecx
  114a20:	31 c0                	xor    %eax,%eax
  114a22:	85 c9                	test   %ecx,%ecx
  114a24:	0f 95 c0             	setne  %al
  114a27:	c3                   	ret
  114a28:	31 c0                	xor    %eax,%eax
  114a2a:	c3                   	ret

Disassembly of section .init:

Disassembly of section .fini:

Disassembly of section .plt:
