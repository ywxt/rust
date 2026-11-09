
/tmp/memchr-std-crate-20261109/x86_64-unknown-linux-gnu/driver-default:     file format elf64-x86-64


Disassembly of section .text:

0000000000002ac0 <_RNvCs1StpruGFt5h_6driver10crate_find>:
    2ac0:	53                   	push   %rbx
    2ac1:	48 89 f3             	mov    %rsi,%rbx
    2ac4:	48 01 f2             	add    %rsi,%rdx
    2ac7:	48 8b 05 7a 31 00 00 	mov    0x317a(%rip),%rax        # 5c48 <_DYNAMIC+0x210>
    2ace:	48 8b 00             	mov    (%rax),%rax
    2ad1:	ff d0                	call   *%rax
    2ad3:	48 83 f8 01          	cmp    $0x1,%rax
    2ad7:	75 0a                	jne    2ae3 <_RNvCs1StpruGFt5h_6driver10crate_find+0x23>
    2ad9:	48 29 da             	sub    %rbx,%rdx
    2adc:	b8 01 00 00 00       	mov    $0x1,%eax
    2ae1:	5b                   	pop    %rbx
    2ae2:	c3                   	ret
    2ae3:	31 c0                	xor    %eax,%eax
    2ae5:	5b                   	pop    %rbx
    2ae6:	c3                   	ret

Disassembly of section .init:

Disassembly of section .fini:

Disassembly of section .plt:

/tmp/memchr-std-crate-20261109/x86_64-unknown-linux-gnu/driver-default:     file format elf64-x86-64


Disassembly of section .text:

0000000000004170 <_RNvCs1StpruGFt5h_6driver8std_find>:
    4170:	48 89 d1             	mov    %rdx,%rcx
    4173:	48 83 fa 0f          	cmp    $0xf,%rdx
    4177:	77 2a                	ja     41a3 <_RNvCs1StpruGFt5h_6driver8std_find+0x33>
    4179:	31 c0                	xor    %eax,%eax
    417b:	48 85 c9             	test   %rcx,%rcx
    417e:	74 36                	je     41b6 <_RNvCs1StpruGFt5h_6driver8std_find+0x46>
    4180:	45 31 c0             	xor    %r8d,%r8d
    4183:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    418a:	84 00 00 00 00 00 
    4190:	4c 89 c2             	mov    %r8,%rdx
    4193:	42 38 3c 06          	cmp    %dil,(%rsi,%r8,1)
    4197:	74 1e                	je     41b7 <_RNvCs1StpruGFt5h_6driver8std_find+0x47>
    4199:	4c 8d 42 01          	lea    0x1(%rdx),%r8
    419d:	4c 39 c1             	cmp    %r8,%rcx
    41a0:	75 ee                	jne    4190 <_RNvCs1StpruGFt5h_6driver8std_find+0x20>
    41a2:	c3                   	ret
    41a3:	50                   	push   %rax
    41a4:	40 0f b6 ff          	movzbl %dil,%edi
    41a8:	48 89 ca             	mov    %rcx,%rdx
    41ab:	ff 15 cf 1a 00 00    	call   *0x1acf(%rip)        # 5c80 <_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned@Base>
    41b1:	48 83 c4 08          	add    $0x8,%rsp
    41b5:	c3                   	ret
    41b6:	c3                   	ret
    41b7:	b8 01 00 00 00       	mov    $0x1,%eax
    41bc:	c3                   	ret

Disassembly of section .init:

Disassembly of section .fini:

Disassembly of section .plt:

/tmp/memchr-std-crate-20261109/x86_64-unknown-linux-gnu/driver-default:     file format elf64-x86-64


Disassembly of section .text:

0000000000004370 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2>:
    4370:	48 89 d0             	mov    %rdx,%rax
    4373:	48 39 d6             	cmp    %rdx,%rsi
    4376:	0f 83 b4 01 00 00    	jae    4530 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x1c0>
    437c:	48 89 f2             	mov    %rsi,%rdx
    437f:	c5 f9 6e c7          	vmovd  %edi,%xmm0
    4383:	c4 e2 7d 78 c0       	vpbroadcastb %xmm0,%ymm0
    4388:	49 89 c0             	mov    %rax,%r8
    438b:	49 29 f0             	sub    %rsi,%r8
    438e:	49 83 f8 20          	cmp    $0x20,%r8
    4392:	73 3a                	jae    43ce <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x5e>
    4394:	49 83 f8 0f          	cmp    $0xf,%r8
    4398:	0f 87 1a 01 00 00    	ja     44b8 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x148>
    439e:	49 01 d0             	add    %rdx,%r8
    43a1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    43a8:	0f 1f 84 00 00 00 00 
    43af:	00 
    43b0:	40 38 3a             	cmp    %dil,(%rdx)
    43b3:	0f 94 c1             	sete   %cl
    43b6:	0f 84 11 01 00 00    	je     44cd <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x15d>
    43bc:	48 ff c2             	inc    %rdx
    43bf:	48 39 c2             	cmp    %rax,%rdx
    43c2:	75 ec                	jne    43b0 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x40>
    43c4:	4c 89 c2             	mov    %r8,%rdx
    43c7:	0f b6 c1             	movzbl %cl,%eax
    43ca:	c5 f8 77             	vzeroupper
    43cd:	c3                   	ret
    43ce:	c5 fd 74 0a          	vpcmpeqb (%rdx),%ymm0,%ymm1
    43d2:	c5 fd d7 c9          	vpmovmskb %ymm1,%ecx
    43d6:	85 c9                	test   %ecx,%ecx
    43d8:	0f 85 e6 00 00 00    	jne    44c4 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x154>
    43de:	48 89 d6             	mov    %rdx,%rsi
    43e1:	48 83 e6 e0          	and    $0xffffffffffffffe0,%rsi
    43e5:	48 83 c6 20          	add    $0x20,%rsi
    43e9:	49 83 f8 7f          	cmp    $0x7f,%r8
    43ed:	40 0f 97 c7          	seta   %dil
    43f1:	48 8d 48 80          	lea    -0x80(%rax),%rcx
    43f5:	48 39 ce             	cmp    %rcx,%rsi
    43f8:	41 0f 96 c0          	setbe  %r8b
    43fc:	41 20 f8             	and    %dil,%r8b
    43ff:	41 80 f8 01          	cmp    $0x1,%r8b
    4403:	75 5e                	jne    4463 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0xf3>
    4405:	89 d6                	mov    %edx,%esi
    4407:	83 e6 1f             	and    $0x1f,%esi
    440a:	48 29 f2             	sub    %rsi,%rdx
    440d:	48 83 c2 40          	add    $0x40,%rdx
    4411:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4418:	0f 1f 84 00 00 00 00 
    441f:	00 
    4420:	c5 fd 74 62 e0       	vpcmpeqb -0x20(%rdx),%ymm0,%ymm4
    4425:	c5 fd 74 1a          	vpcmpeqb (%rdx),%ymm0,%ymm3
    4429:	c5 fd 74 52 20       	vpcmpeqb 0x20(%rdx),%ymm0,%ymm2
    442e:	c5 fd 74 4a 40       	vpcmpeqb 0x40(%rdx),%ymm0,%ymm1
    4433:	c5 dd eb eb          	vpor   %ymm3,%ymm4,%ymm5
    4437:	c5 ed eb f1          	vpor   %ymm1,%ymm2,%ymm6
    443b:	c5 cd eb ed          	vpor   %ymm5,%ymm6,%ymm5
    443f:	c5 fd d7 f5          	vpmovmskb %ymm5,%esi
    4443:	85 f6                	test   %esi,%esi
    4445:	0f 85 ee 00 00 00    	jne    4539 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x1c9>
    444b:	48 8d 72 e0          	lea    -0x20(%rdx),%rsi
    444f:	48 83 ea 80          	sub    $0xffffffffffffff80,%rdx
    4453:	48 83 ee 80          	sub    $0xffffffffffffff80,%rsi
    4457:	48 39 ce             	cmp    %rcx,%rsi
    445a:	76 c4                	jbe    4420 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0xb0>
    445c:	48 83 c2 e0          	add    $0xffffffffffffffe0,%rdx
    4460:	48 89 d6             	mov    %rdx,%rsi
    4463:	48 8d 48 e0          	lea    -0x20(%rax),%rcx
    4467:	48 39 ce             	cmp    %rcx,%rsi
    446a:	77 1d                	ja     4489 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x119>
    446c:	0f 1f 40 00          	nopl   0x0(%rax)
    4470:	c5 fd 74 0e          	vpcmpeqb (%rsi),%ymm0,%ymm1
    4474:	c5 fd d7 d1          	vpmovmskb %ymm1,%edx
    4478:	85 d2                	test   %edx,%edx
    447a:	0f 85 d1 00 00 00    	jne    4551 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x1e1>
    4480:	48 83 c6 20          	add    $0x20,%rsi
    4484:	48 39 ce             	cmp    %rcx,%rsi
    4487:	76 e7                	jbe    4470 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x100>
    4489:	48 39 c6             	cmp    %rax,%rsi
    448c:	0f 83 9e 00 00 00    	jae    4530 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x1c0>
    4492:	c5 fd 74 40 e0       	vpcmpeqb -0x20(%rax),%ymm0,%ymm0
    4497:	c5 fd d7 d0          	vpmovmskb %ymm0,%edx
    449b:	85 d2                	test   %edx,%edx
    449d:	0f 95 c1             	setne  %cl
    44a0:	be 20 00 00 00       	mov    $0x20,%esi
    44a5:	f3 0f bc f2          	tzcnt  %edx,%esi
    44a9:	48 8d 14 30          	lea    (%rax,%rsi,1),%rdx
    44ad:	48 83 c2 e0          	add    $0xffffffffffffffe0,%rdx
    44b1:	0f b6 c1             	movzbl %cl,%eax
    44b4:	c5 f8 77             	vzeroupper
    44b7:	c3                   	ret
    44b8:	c5 f9 74 0a          	vpcmpeqb (%rdx),%xmm0,%xmm1
    44bc:	c5 f9 d7 c9          	vpmovmskb %xmm1,%ecx
    44c0:	85 c9                	test   %ecx,%ecx
    44c2:	74 10                	je     44d4 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x164>
    44c4:	f3 0f bc c1          	tzcnt  %ecx,%eax
    44c8:	48 01 c2             	add    %rax,%rdx
    44cb:	b1 01                	mov    $0x1,%cl
    44cd:	0f b6 c1             	movzbl %cl,%eax
    44d0:	c5 f8 77             	vzeroupper
    44d3:	c3                   	ret
    44d4:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    44d8:	48 83 c2 10          	add    $0x10,%rdx
    44dc:	48 8d 48 f0          	lea    -0x10(%rax),%rcx
    44e0:	48 39 ca             	cmp    %rcx,%rdx
    44e3:	77 20                	ja     4505 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x195>
    44e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    44ec:	00 00 00 00 
    44f0:	c5 f9 74 0a          	vpcmpeqb (%rdx),%xmm0,%xmm1
    44f4:	c5 f9 d7 f1          	vpmovmskb %xmm1,%esi
    44f8:	85 f6                	test   %esi,%esi
    44fa:	75 68                	jne    4564 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x1f4>
    44fc:	48 83 c2 10          	add    $0x10,%rdx
    4500:	48 39 ca             	cmp    %rcx,%rdx
    4503:	76 eb                	jbe    44f0 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x180>
    4505:	48 39 c2             	cmp    %rax,%rdx
    4508:	73 26                	jae    4530 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x1c0>
    450a:	c5 f9 74 40 f0       	vpcmpeqb -0x10(%rax),%xmm0,%xmm0
    450f:	c5 f9 d7 d0          	vpmovmskb %xmm0,%edx
    4513:	85 d2                	test   %edx,%edx
    4515:	0f 95 c1             	setne  %cl
    4518:	be 20 00 00 00       	mov    $0x20,%esi
    451d:	f3 0f bc f2          	tzcnt  %edx,%esi
    4521:	48 8d 14 30          	lea    (%rax,%rsi,1),%rdx
    4525:	48 83 c2 f0          	add    $0xfffffffffffffff0,%rdx
    4529:	0f b6 c1             	movzbl %cl,%eax
    452c:	c5 f8 77             	vzeroupper
    452f:	c3                   	ret
    4530:	31 c9                	xor    %ecx,%ecx
    4532:	0f b6 c1             	movzbl %cl,%eax
    4535:	c5 f8 77             	vzeroupper
    4538:	c3                   	ret
    4539:	c5 fd d7 c4          	vpmovmskb %ymm4,%eax
    453d:	85 c0                	test   %eax,%eax
    453f:	74 2c                	je     456d <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x1fd>
    4541:	f3 0f bc c0          	tzcnt  %eax,%eax
    4545:	48 01 c2             	add    %rax,%rdx
    4548:	48 83 c2 e0          	add    $0xffffffffffffffe0,%rdx
    454c:	e9 7a ff ff ff       	jmp    44cb <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x15b>
    4551:	f3 0f bc c2          	tzcnt  %edx,%eax
    4555:	48 01 c6             	add    %rax,%rsi
    4558:	b1 01                	mov    $0x1,%cl
    455a:	48 89 f2             	mov    %rsi,%rdx
    455d:	0f b6 c1             	movzbl %cl,%eax
    4560:	c5 f8 77             	vzeroupper
    4563:	c3                   	ret
    4564:	f3 0f bc c6          	tzcnt  %esi,%eax
    4568:	e9 5b ff ff ff       	jmp    44c8 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x158>
    456d:	c5 fd d7 c3          	vpmovmskb %ymm3,%eax
    4571:	85 c0                	test   %eax,%eax
    4573:	74 09                	je     457e <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x20e>
    4575:	f3 0f bc c0          	tzcnt  %eax,%eax
    4579:	e9 4a ff ff ff       	jmp    44c8 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x158>
    457e:	c5 fd d7 c2          	vpmovmskb %ymm2,%eax
    4582:	85 c0                	test   %eax,%eax
    4584:	74 10                	je     4596 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x226>
    4586:	f3 0f bc c0          	tzcnt  %eax,%eax
    458a:	48 01 c2             	add    %rax,%rdx
    458d:	48 83 c2 20          	add    $0x20,%rdx
    4591:	e9 35 ff ff ff       	jmp    44cb <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x15b>
    4596:	c5 fd d7 c1          	vpmovmskb %ymm1,%eax
    459a:	b9 20 00 00 00       	mov    $0x20,%ecx
    459f:	f3 0f bc c8          	tzcnt  %eax,%ecx
    45a3:	48 01 ca             	add    %rcx,%rdx
    45a6:	48 83 c2 40          	add    $0x40,%rdx
    45aa:	e9 1c ff ff ff       	jmp    44cb <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_avx2+0x15b>

Disassembly of section .init:

Disassembly of section .fini:

Disassembly of section .plt:

/tmp/memchr-std-crate-20261109/x86_64-unknown-linux-gnu/driver-default:     file format elf64-x86-64


Disassembly of section .text:

00000000000045b0 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2>:
    45b0:	48 89 d1             	mov    %rdx,%rcx
    45b3:	48 39 d6             	cmp    %rdx,%rsi
    45b6:	0f 83 38 01 00 00    	jae    46f4 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x144>
    45bc:	48 89 f2             	mov    %rsi,%rdx
    45bf:	49 89 c8             	mov    %rcx,%r8
    45c2:	49 29 f0             	sub    %rsi,%r8
    45c5:	49 83 f8 0f          	cmp    $0xf,%r8
    45c9:	77 16                	ja     45e1 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x31>
    45cb:	49 01 d0             	add    %rdx,%r8
    45ce:	31 c0                	xor    %eax,%eax
    45d0:	40 38 3a             	cmp    %dil,(%rdx)
    45d3:	74 35                	je     460a <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x5a>
    45d5:	48 ff c2             	inc    %rdx
    45d8:	48 39 ca             	cmp    %rcx,%rdx
    45db:	75 f3                	jne    45d0 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x20>
    45dd:	4c 89 c2             	mov    %r8,%rdx
    45e0:	c3                   	ret
    45e1:	66 0f 6e c7          	movd   %edi,%xmm0
    45e5:	66 0f 60 c0          	punpcklbw %xmm0,%xmm0
    45e9:	f2 0f 70 c0 00       	pshuflw $0x0,%xmm0,%xmm0
    45ee:	66 0f 70 c0 44       	pshufd $0x44,%xmm0,%xmm0
    45f3:	f3 0f 6f 0a          	movdqu (%rdx),%xmm1
    45f7:	66 0f 74 c8          	pcmpeqb %xmm0,%xmm1
    45fb:	66 0f d7 c1          	pmovmskb %xmm1,%eax
    45ff:	85 c0                	test   %eax,%eax
    4601:	74 0d                	je     4610 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x60>
    4603:	f3 0f bc c0          	tzcnt  %eax,%eax
    4607:	48 01 c2             	add    %rax,%rdx
    460a:	b8 01 00 00 00       	mov    $0x1,%eax
    460f:	c3                   	ret
    4610:	48 89 d6             	mov    %rdx,%rsi
    4613:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
    4617:	48 83 c6 10          	add    $0x10,%rsi
    461b:	49 83 f8 40          	cmp    $0x40,%r8
    461f:	40 0f 93 c7          	setae  %dil
    4623:	48 8d 41 c0          	lea    -0x40(%rcx),%rax
    4627:	48 39 c6             	cmp    %rax,%rsi
    462a:	41 0f 96 c0          	setbe  %r8b
    462e:	41 20 f8             	and    %dil,%r8b
    4631:	41 80 f8 01          	cmp    $0x1,%r8b
    4635:	75 70                	jne    46a7 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0xf7>
    4637:	89 d6                	mov    %edx,%esi
    4639:	83 e6 0f             	and    $0xf,%esi
    463c:	48 29 f2             	sub    %rsi,%rdx
    463f:	48 83 c2 20          	add    $0x20,%rdx
    4643:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    464a:	84 00 00 00 00 00 
    4650:	66 0f 6f 62 f0       	movdqa -0x10(%rdx),%xmm4
    4655:	66 0f 74 e0          	pcmpeqb %xmm0,%xmm4
    4659:	66 0f 6f 1a          	movdqa (%rdx),%xmm3
    465d:	66 0f 74 d8          	pcmpeqb %xmm0,%xmm3
    4661:	66 0f 6f 52 10       	movdqa 0x10(%rdx),%xmm2
    4666:	66 0f 74 d0          	pcmpeqb %xmm0,%xmm2
    466a:	66 0f 6f 4a 20       	movdqa 0x20(%rdx),%xmm1
    466f:	66 0f 74 c8          	pcmpeqb %xmm0,%xmm1
    4673:	66 0f 6f ec          	movdqa %xmm4,%xmm5
    4677:	66 0f eb eb          	por    %xmm3,%xmm5
    467b:	66 0f 6f f2          	movdqa %xmm2,%xmm6
    467f:	66 0f eb f1          	por    %xmm1,%xmm6
    4683:	66 0f eb f5          	por    %xmm5,%xmm6
    4687:	66 0f d7 f6          	pmovmskb %xmm6,%esi
    468b:	85 f6                	test   %esi,%esi
    468d:	75 68                	jne    46f7 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x147>
    468f:	48 8d 72 f0          	lea    -0x10(%rdx),%rsi
    4693:	48 83 c2 40          	add    $0x40,%rdx
    4697:	48 83 c6 40          	add    $0x40,%rsi
    469b:	48 39 c6             	cmp    %rax,%rsi
    469e:	76 b0                	jbe    4650 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0xa0>
    46a0:	48 83 c2 f0          	add    $0xfffffffffffffff0,%rdx
    46a4:	48 89 d6             	mov    %rdx,%rsi
    46a7:	48 8d 41 f0          	lea    -0x10(%rcx),%rax
    46ab:	48 39 c6             	cmp    %rax,%rsi
    46ae:	77 19                	ja     46c9 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x119>
    46b0:	f3 0f 6f 0e          	movdqu (%rsi),%xmm1
    46b4:	66 0f 74 c8          	pcmpeqb %xmm0,%xmm1
    46b8:	66 0f d7 d1          	pmovmskb %xmm1,%edx
    46bc:	85 d2                	test   %edx,%edx
    46be:	75 50                	jne    4710 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x160>
    46c0:	48 83 c6 10          	add    $0x10,%rsi
    46c4:	48 39 c6             	cmp    %rax,%rsi
    46c7:	76 e7                	jbe    46b0 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x100>
    46c9:	48 39 ce             	cmp    %rcx,%rsi
    46cc:	73 26                	jae    46f4 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x144>
    46ce:	f3 0f 6f 49 f0       	movdqu -0x10(%rcx),%xmm1
    46d3:	66 0f 74 c8          	pcmpeqb %xmm0,%xmm1
    46d7:	66 0f d7 d1          	pmovmskb %xmm1,%edx
    46db:	31 c0                	xor    %eax,%eax
    46dd:	85 d2                	test   %edx,%edx
    46df:	0f 95 c0             	setne  %al
    46e2:	be 20 00 00 00       	mov    $0x20,%esi
    46e7:	f3 0f bc f2          	tzcnt  %edx,%esi
    46eb:	48 8d 14 31          	lea    (%rcx,%rsi,1),%rdx
    46ef:	48 83 c2 f0          	add    $0xfffffffffffffff0,%rdx
    46f3:	c3                   	ret
    46f4:	31 c0                	xor    %eax,%eax
    46f6:	c3                   	ret
    46f7:	66 0f d7 c4          	pmovmskb %xmm4,%eax
    46fb:	85 c0                	test   %eax,%eax
    46fd:	74 21                	je     4720 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x170>
    46ff:	f3 0f bc c0          	tzcnt  %eax,%eax
    4703:	48 01 c2             	add    %rax,%rdx
    4706:	48 83 c2 f0          	add    $0xfffffffffffffff0,%rdx
    470a:	b8 01 00 00 00       	mov    $0x1,%eax
    470f:	c3                   	ret
    4710:	f3 0f bc c2          	tzcnt  %edx,%eax
    4714:	48 01 c6             	add    %rax,%rsi
    4717:	b8 01 00 00 00       	mov    $0x1,%eax
    471c:	48 89 f2             	mov    %rsi,%rdx
    471f:	c3                   	ret
    4720:	66 0f d7 c3          	pmovmskb %xmm3,%eax
    4724:	85 c0                	test   %eax,%eax
    4726:	0f 85 d7 fe ff ff    	jne    4603 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x53>
    472c:	66 0f d7 c2          	pmovmskb %xmm2,%eax
    4730:	85 c0                	test   %eax,%eax
    4732:	74 11                	je     4745 <_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw9find_sse2+0x195>
    4734:	f3 0f bc c0          	tzcnt  %eax,%eax
    4738:	48 01 c2             	add    %rax,%rdx
    473b:	48 83 c2 10          	add    $0x10,%rdx
    473f:	b8 01 00 00 00       	mov    $0x1,%eax
    4744:	c3                   	ret
    4745:	66 0f d7 c1          	pmovmskb %xmm1,%eax
    4749:	b9 20 00 00 00       	mov    $0x20,%ecx
    474e:	f3 0f bc c8          	tzcnt  %eax,%ecx
    4752:	48 01 ca             	add    %rcx,%rdx
    4755:	48 83 c2 20          	add    $0x20,%rdx
    4759:	b8 01 00 00 00       	mov    $0x1,%eax
    475e:	c3                   	ret

Disassembly of section .init:

Disassembly of section .fini:

Disassembly of section .plt:
