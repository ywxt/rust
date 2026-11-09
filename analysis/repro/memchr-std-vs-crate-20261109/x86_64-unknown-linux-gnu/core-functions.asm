
/tmp/memchr-std-crate-20261109/x86_64-unknown-linux-gnu/driver-core:     file format elf64-x86-64


Disassembly of section .text:

00000000000029a0 <_RNvCs1StpruGFt5h_6driver10crate_find>:
    29a0:	53                   	push   %rbx
    29a1:	48 89 f3             	mov    %rsi,%rbx
    29a4:	48 01 f2             	add    %rsi,%rdx
    29a7:	48 8b 05 aa 30 00 00 	mov    0x30aa(%rip),%rax        # 5a58 <_DYNAMIC+0x210>
    29ae:	48 8b 00             	mov    (%rax),%rax
    29b1:	ff d0                	call   *%rax
    29b3:	48 83 f8 01          	cmp    $0x1,%rax
    29b7:	75 0a                	jne    29c3 <_RNvCs1StpruGFt5h_6driver10crate_find+0x23>
    29b9:	48 29 da             	sub    %rbx,%rdx
    29bc:	b8 01 00 00 00       	mov    $0x1,%eax
    29c1:	5b                   	pop    %rbx
    29c2:	c3                   	ret
    29c3:	31 c0                	xor    %eax,%eax
    29c5:	5b                   	pop    %rbx
    29c6:	c3                   	ret

Disassembly of section .init:

Disassembly of section .fini:

Disassembly of section .plt:

/tmp/memchr-std-crate-20261109/x86_64-unknown-linux-gnu/driver-core:     file format elf64-x86-64


Disassembly of section .text:

0000000000004050 <_RNvCs1StpruGFt5h_6driver8std_find>:
    4050:	48 89 d1             	mov    %rdx,%rcx
    4053:	48 83 fa 0f          	cmp    $0xf,%rdx
    4057:	77 2a                	ja     4083 <_RNvCs1StpruGFt5h_6driver8std_find+0x33>
    4059:	31 c0                	xor    %eax,%eax
    405b:	48 85 c9             	test   %rcx,%rcx
    405e:	74 36                	je     4096 <_RNvCs1StpruGFt5h_6driver8std_find+0x46>
    4060:	45 31 c0             	xor    %r8d,%r8d
    4063:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    406a:	84 00 00 00 00 00 
    4070:	4c 89 c2             	mov    %r8,%rdx
    4073:	42 38 3c 06          	cmp    %dil,(%rsi,%r8,1)
    4077:	74 1e                	je     4097 <_RNvCs1StpruGFt5h_6driver8std_find+0x47>
    4079:	4c 8d 42 01          	lea    0x1(%rdx),%r8
    407d:	4c 39 c1             	cmp    %r8,%rcx
    4080:	75 ee                	jne    4070 <_RNvCs1StpruGFt5h_6driver8std_find+0x20>
    4082:	c3                   	ret
    4083:	50                   	push   %rax
    4084:	40 0f b6 ff          	movzbl %dil,%edi
    4088:	48 89 ca             	mov    %rcx,%rdx
    408b:	ff 15 ff 19 00 00    	call   *0x19ff(%rip)        # 5a90 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned@Base>
    4091:	48 83 c4 08          	add    $0x8,%rsp
    4095:	c3                   	ret
    4096:	c3                   	ret
    4097:	b8 01 00 00 00       	mov    $0x1,%eax
    409c:	c3                   	ret

Disassembly of section .init:

Disassembly of section .fini:

Disassembly of section .plt:

/tmp/memchr-std-crate-20261109/x86_64-unknown-linux-gnu/driver-core:     file format elf64-x86-64


Disassembly of section .text:

00000000000043c0 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2>:
    43c0:	48 89 d1             	mov    %rdx,%rcx
    43c3:	48 39 d6             	cmp    %rdx,%rsi
    43c6:	0f 83 38 01 00 00    	jae    4504 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x144>
    43cc:	48 89 f2             	mov    %rsi,%rdx
    43cf:	49 89 c8             	mov    %rcx,%r8
    43d2:	49 29 f0             	sub    %rsi,%r8
    43d5:	49 83 f8 0f          	cmp    $0xf,%r8
    43d9:	77 16                	ja     43f1 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x31>
    43db:	49 01 d0             	add    %rdx,%r8
    43de:	31 c0                	xor    %eax,%eax
    43e0:	40 38 3a             	cmp    %dil,(%rdx)
    43e3:	74 35                	je     441a <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x5a>
    43e5:	48 ff c2             	inc    %rdx
    43e8:	48 39 ca             	cmp    %rcx,%rdx
    43eb:	75 f3                	jne    43e0 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x20>
    43ed:	4c 89 c2             	mov    %r8,%rdx
    43f0:	c3                   	ret
    43f1:	66 0f 6e c7          	movd   %edi,%xmm0
    43f5:	66 0f 60 c0          	punpcklbw %xmm0,%xmm0
    43f9:	f2 0f 70 c0 00       	pshuflw $0x0,%xmm0,%xmm0
    43fe:	66 0f 70 c0 44       	pshufd $0x44,%xmm0,%xmm0
    4403:	f3 0f 6f 0a          	movdqu (%rdx),%xmm1
    4407:	66 0f 74 c8          	pcmpeqb %xmm0,%xmm1
    440b:	66 0f d7 c1          	pmovmskb %xmm1,%eax
    440f:	85 c0                	test   %eax,%eax
    4411:	74 0d                	je     4420 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x60>
    4413:	f3 0f bc c0          	tzcnt  %eax,%eax
    4417:	48 01 c2             	add    %rax,%rdx
    441a:	b8 01 00 00 00       	mov    $0x1,%eax
    441f:	c3                   	ret
    4420:	48 89 d6             	mov    %rdx,%rsi
    4423:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
    4427:	48 83 c6 10          	add    $0x10,%rsi
    442b:	49 83 f8 40          	cmp    $0x40,%r8
    442f:	40 0f 93 c7          	setae  %dil
    4433:	48 8d 41 c0          	lea    -0x40(%rcx),%rax
    4437:	48 39 c6             	cmp    %rax,%rsi
    443a:	41 0f 96 c0          	setbe  %r8b
    443e:	41 20 f8             	and    %dil,%r8b
    4441:	41 80 f8 01          	cmp    $0x1,%r8b
    4445:	75 70                	jne    44b7 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0xf7>
    4447:	89 d6                	mov    %edx,%esi
    4449:	83 e6 0f             	and    $0xf,%esi
    444c:	48 29 f2             	sub    %rsi,%rdx
    444f:	48 83 c2 20          	add    $0x20,%rdx
    4453:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    445a:	84 00 00 00 00 00 
    4460:	66 0f 6f 62 f0       	movdqa -0x10(%rdx),%xmm4
    4465:	66 0f 74 e0          	pcmpeqb %xmm0,%xmm4
    4469:	66 0f 6f 1a          	movdqa (%rdx),%xmm3
    446d:	66 0f 74 d8          	pcmpeqb %xmm0,%xmm3
    4471:	66 0f 6f 52 10       	movdqa 0x10(%rdx),%xmm2
    4476:	66 0f 74 d0          	pcmpeqb %xmm0,%xmm2
    447a:	66 0f 6f 4a 20       	movdqa 0x20(%rdx),%xmm1
    447f:	66 0f 74 c8          	pcmpeqb %xmm0,%xmm1
    4483:	66 0f 6f ec          	movdqa %xmm4,%xmm5
    4487:	66 0f eb eb          	por    %xmm3,%xmm5
    448b:	66 0f 6f f2          	movdqa %xmm2,%xmm6
    448f:	66 0f eb f1          	por    %xmm1,%xmm6
    4493:	66 0f eb f5          	por    %xmm5,%xmm6
    4497:	66 0f d7 f6          	pmovmskb %xmm6,%esi
    449b:	85 f6                	test   %esi,%esi
    449d:	75 68                	jne    4507 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x147>
    449f:	48 8d 72 f0          	lea    -0x10(%rdx),%rsi
    44a3:	48 83 c2 40          	add    $0x40,%rdx
    44a7:	48 83 c6 40          	add    $0x40,%rsi
    44ab:	48 39 c6             	cmp    %rax,%rsi
    44ae:	76 b0                	jbe    4460 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0xa0>
    44b0:	48 83 c2 f0          	add    $0xfffffffffffffff0,%rdx
    44b4:	48 89 d6             	mov    %rdx,%rsi
    44b7:	48 8d 41 f0          	lea    -0x10(%rcx),%rax
    44bb:	48 39 c6             	cmp    %rax,%rsi
    44be:	77 19                	ja     44d9 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x119>
    44c0:	f3 0f 6f 0e          	movdqu (%rsi),%xmm1
    44c4:	66 0f 74 c8          	pcmpeqb %xmm0,%xmm1
    44c8:	66 0f d7 d1          	pmovmskb %xmm1,%edx
    44cc:	85 d2                	test   %edx,%edx
    44ce:	75 50                	jne    4520 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x160>
    44d0:	48 83 c6 10          	add    $0x10,%rsi
    44d4:	48 39 c6             	cmp    %rax,%rsi
    44d7:	76 e7                	jbe    44c0 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x100>
    44d9:	48 39 ce             	cmp    %rcx,%rsi
    44dc:	73 26                	jae    4504 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x144>
    44de:	f3 0f 6f 49 f0       	movdqu -0x10(%rcx),%xmm1
    44e3:	66 0f 74 c8          	pcmpeqb %xmm0,%xmm1
    44e7:	66 0f d7 d1          	pmovmskb %xmm1,%edx
    44eb:	31 c0                	xor    %eax,%eax
    44ed:	85 d2                	test   %edx,%edx
    44ef:	0f 95 c0             	setne  %al
    44f2:	be 20 00 00 00       	mov    $0x20,%esi
    44f7:	f3 0f bc f2          	tzcnt  %edx,%esi
    44fb:	48 8d 14 31          	lea    (%rcx,%rsi,1),%rdx
    44ff:	48 83 c2 f0          	add    $0xfffffffffffffff0,%rdx
    4503:	c3                   	ret
    4504:	31 c0                	xor    %eax,%eax
    4506:	c3                   	ret
    4507:	66 0f d7 c4          	pmovmskb %xmm4,%eax
    450b:	85 c0                	test   %eax,%eax
    450d:	74 21                	je     4530 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x170>
    450f:	f3 0f bc c0          	tzcnt  %eax,%eax
    4513:	48 01 c2             	add    %rax,%rdx
    4516:	48 83 c2 f0          	add    $0xfffffffffffffff0,%rdx
    451a:	b8 01 00 00 00       	mov    $0x1,%eax
    451f:	c3                   	ret
    4520:	f3 0f bc c2          	tzcnt  %edx,%eax
    4524:	48 01 c6             	add    %rax,%rsi
    4527:	b8 01 00 00 00       	mov    $0x1,%eax
    452c:	48 89 f2             	mov    %rsi,%rdx
    452f:	c3                   	ret
    4530:	66 0f d7 c3          	pmovmskb %xmm3,%eax
    4534:	85 c0                	test   %eax,%eax
    4536:	0f 85 d7 fe ff ff    	jne    4413 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x53>
    453c:	66 0f d7 c2          	pmovmskb %xmm2,%eax
    4540:	85 c0                	test   %eax,%eax
    4542:	74 11                	je     4555 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x195>
    4544:	f3 0f bc c0          	tzcnt  %eax,%eax
    4548:	48 01 c2             	add    %rax,%rdx
    454b:	48 83 c2 10          	add    $0x10,%rdx
    454f:	b8 01 00 00 00       	mov    $0x1,%eax
    4554:	c3                   	ret
    4555:	66 0f d7 c1          	pmovmskb %xmm1,%eax
    4559:	b9 20 00 00 00       	mov    $0x20,%ecx
    455e:	f3 0f bc c8          	tzcnt  %eax,%ecx
    4562:	48 01 ca             	add    %rcx,%rdx
    4565:	48 83 c2 20          	add    $0x20,%rdx
    4569:	b8 01 00 00 00       	mov    $0x1,%eax
    456e:	c3                   	ret

Disassembly of section .init:

Disassembly of section .fini:

Disassembly of section .plt:
