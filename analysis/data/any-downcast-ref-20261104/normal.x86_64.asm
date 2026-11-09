0000000000015590 <probe::pair_value>:
   15590:	48 85 ff             	test   %rdi,%rdi
   15593:	0f 84 7d 00 00 00    	je     15616 <probe::pair_value+0x86>
   15599:	55                   	push   %rbp
   1559a:	41 57                	push   %r15
   1559c:	41 56                	push   %r14
   1559e:	41 55                	push   %r13
   155a0:	41 54                	push   %r12
   155a2:	53                   	push   %rbx
   155a3:	48 83 ec 28          	sub    $0x28,%rsp
   155a7:	48 89 fb             	mov    %rdi,%rbx
   155aa:	4c 8d 3d 07 d7 03 00 	lea    0x3d707(%rip),%r15        # 52cb8 <__frame_dummy_init_array_entry+0x78>
   155b1:	4c 8d 64 24 10       	lea    0x10(%rsp),%r12
   155b6:	49 bd 8f 15 1f e2 19 	movabs $0x6e75a319e21f158f,%r13
   155bd:	a3 75 6e 
   155c0:	48 bd eb 68 de c5 b6 	movabs $0x9b3381b6c5de68eb,%rbp
   155c7:	81 33 9b 
   155ca:	4c 8d 74 24 0f       	lea    0xf(%rsp),%r14
   155cf:	90                   	nop
   155d0:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   155d7:	00 00 
   155d9:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
   155de:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
   155e3:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
   155e8:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
   155ed:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
   155f2:	ff 50 18             	call   *0x18(%rax)
   155f5:	4c 31 e8             	xor    %r13,%rax
   155f8:	48 31 ea             	xor    %rbp,%rdx
   155fb:	48 09 c2             	or     %rax,%rdx
   155fe:	0f 94 44 24 0f       	sete   0xf(%rsp)
   15603:	48 ff cb             	dec    %rbx
   15606:	75 c8                	jne    155d0 <probe::pair_value+0x40>
   15608:	48 83 c4 28          	add    $0x28,%rsp
   1560c:	5b                   	pop    %rbx
   1560d:	41 5c                	pop    %r12
   1560f:	41 5d                	pop    %r13
   15611:	41 5e                	pop    %r14
   15613:	41 5f                	pop    %r15
   15615:	5d                   	pop    %rbp
   15616:	c3                   	ret
   15617:	cc                   	int3
   15618:	cc                   	int3
   15619:	cc                   	int3
   1561a:	cc                   	int3
   1561b:	cc                   	int3
   1561c:	cc                   	int3
   1561d:	cc                   	int3
   1561e:	cc                   	int3
   1561f:	cc                   	int3

0000000000015620 <probe::persistent>:
   15620:	41 57                	push   %r15
   15622:	41 56                	push   %r14
   15624:	41 54                	push   %r12
   15626:	53                   	push   %rbx
   15627:	48 83 ec 28          	sub    $0x28,%rsp
   1562b:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   15632:	00 00 
   15634:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
   15639:	48 89 04 24          	mov    %rax,(%rsp)
   1563d:	48 8d 05 34 d6 03 00 	lea    0x3d634(%rip),%rax        # 52c78 <__frame_dummy_init_array_entry+0x38>
   15644:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   15649:	48 85 ff             	test   %rdi,%rdi
   1564c:	74 5d                	je     156ab <probe::persistent+0x8b>
   1564e:	48 89 fb             	mov    %rdi,%rbx
   15651:	49 89 e4             	mov    %rsp,%r12
   15654:	4c 8d 74 24 10       	lea    0x10(%rsp),%r14
   15659:	eb 15                	jmp    15670 <probe::persistent+0x50>
   1565b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   15660:	49 83 3f 00          	cmpq   $0x0,(%r15)
   15664:	0f 94 c0             	sete   %al
   15667:	88 44 24 10          	mov    %al,0x10(%rsp)
   1566b:	48 ff cb             	dec    %rbx
   1566e:	74 3b                	je     156ab <probe::persistent+0x8b>
   15670:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
   15675:	4c 8b 3c 24          	mov    (%rsp),%r15
   15679:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
   1567e:	4c 89 f7             	mov    %r14,%rdi
   15681:	4c 89 fe             	mov    %r15,%rsi
   15684:	ff 50 18             	call   *0x18(%rax)
   15687:	66 0f 6f 44 24 10    	movdqa 0x10(%rsp),%xmm0
   1568d:	66 0f 74 05 6b fc fe 	pcmpeqb -0x10395(%rip),%xmm0        # 5300 <__abi_tag+0x4fcc>
   15694:	ff 
   15695:	66 0f d7 c0          	pmovmskb %xmm0,%eax
   15699:	3d ff ff 00 00       	cmp    $0xffff,%eax
   1569e:	74 c0                	je     15660 <probe::persistent+0x40>
   156a0:	31 c0                	xor    %eax,%eax
   156a2:	88 44 24 10          	mov    %al,0x10(%rsp)
   156a6:	48 ff cb             	dec    %rbx
   156a9:	75 c5                	jne    15670 <probe::persistent+0x50>
   156ab:	48 83 c4 28          	add    $0x28,%rsp
   156af:	5b                   	pop    %rbx
   156b0:	41 5c                	pop    %r12
   156b2:	41 5e                	pop    %r14
   156b4:	41 5f                	pop    %r15
   156b6:	c3                   	ret
   156b7:	cc                   	int3
   156b8:	cc                   	int3
   156b9:	cc                   	int3
   156ba:	cc                   	int3
   156bb:	cc                   	int3
   156bc:	cc                   	int3
   156bd:	cc                   	int3
   156be:	cc                   	int3
   156bf:	cc                   	int3

00000000000156c0 <probe::value_wide>:
   156c0:	48 85 ff             	test   %rdi,%rdi
   156c3:	0f 84 a4 00 00 00    	je     1576d <probe::value_wide+0xad>
   156c9:	41 57                	push   %r15
   156cb:	41 56                	push   %r14
   156cd:	41 55                	push   %r13
   156cf:	41 54                	push   %r12
   156d1:	53                   	push   %rbx
   156d2:	48 83 ec 30          	sub    $0x30,%rsp
   156d6:	48 89 fb             	mov    %rdi,%rbx
   156d9:	4c 8d 7c 24 18       	lea    0x18(%rsp),%r15
   156de:	4c 8d 25 93 d5 03 00 	lea    0x3d593(%rip),%r12        # 52c78 <__frame_dummy_init_array_entry+0x38>
   156e5:	4c 8d 6c 24 08       	lea    0x8(%rsp),%r13
   156ea:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
   156ef:	eb 27                	jmp    15718 <probe::value_wide+0x58>
   156f1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   156f8:	0f 1f 84 00 00 00 00 
   156ff:	00 
   15700:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
   15705:	31 c0                	xor    %eax,%eax
   15707:	48 83 39 00          	cmpq   $0x0,(%rcx)
   1570b:	0f 94 c0             	sete   %al
   1570e:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   15713:	48 ff cb             	dec    %rbx
   15716:	74 48                	je     15760 <probe::value_wide+0xa0>
   15718:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
   1571f:	00 00 
   15721:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
   15726:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
   1572b:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
   15730:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
   15735:	4c 89 f7             	mov    %r14,%rdi
   15738:	ff 50 18             	call   *0x18(%rax)
   1573b:	66 0f 6f 44 24 20    	movdqa 0x20(%rsp),%xmm0
   15741:	66 0f 74 05 b7 fb fe 	pcmpeqb -0x10449(%rip),%xmm0        # 5300 <__abi_tag+0x4fcc>
   15748:	ff 
   15749:	66 0f d7 c0          	pmovmskb %xmm0,%eax
   1574d:	3d ff ff 00 00       	cmp    $0xffff,%eax
   15752:	74 ac                	je     15700 <probe::value_wide+0x40>
   15754:	31 c0                	xor    %eax,%eax
   15756:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   1575b:	48 ff cb             	dec    %rbx
   1575e:	75 b8                	jne    15718 <probe::value_wide+0x58>
   15760:	48 83 c4 30          	add    $0x30,%rsp
   15764:	5b                   	pop    %rbx
   15765:	41 5c                	pop    %r12
   15767:	41 5d                	pop    %r13
   15769:	41 5e                	pop    %r14
   1576b:	41 5f                	pop    %r15
   1576d:	c3                   	ret
   1576e:	cc                   	int3
   1576f:	cc                   	int3

0000000000015770 <probe::array_value>:
   15770:	48 85 ff             	test   %rdi,%rdi
   15773:	0f 84 89 00 00 00    	je     15802 <probe::array_value+0x92>
   15779:	55                   	push   %rbp
   1577a:	41 57                	push   %r15
   1577c:	41 56                	push   %r14
   1577e:	41 55                	push   %r13
   15780:	41 54                	push   %r12
   15782:	53                   	push   %rbx
   15783:	48 83 ec 38          	sub    $0x38,%rsp
   15787:	48 89 fb             	mov    %rdi,%rbx
   1578a:	4c 8d 7c 24 18       	lea    0x18(%rsp),%r15
   1578f:	4c 8d 25 02 d5 03 00 	lea    0x3d502(%rip),%r12        # 52c98 <__frame_dummy_init_array_entry+0x58>
   15796:	4c 8d 6c 24 08       	lea    0x8(%rsp),%r13
   1579b:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
   157a0:	48 8d 6c 24 07       	lea    0x7(%rsp),%rbp
   157a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   157ac:	00 00 00 00 
   157b0:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
   157b7:	00 00 
   157b9:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
   157be:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
   157c3:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
   157c8:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
   157cd:	4c 89 f7             	mov    %r14,%rdi
   157d0:	ff 50 18             	call   *0x18(%rax)
   157d3:	66 0f 6f 44 24 20    	movdqa 0x20(%rsp),%xmm0
   157d9:	66 0f 74 05 1f fb fe 	pcmpeqb -0x104e1(%rip),%xmm0        # 5300 <__abi_tag+0x4fcc>
   157e0:	ff 
   157e1:	66 0f d7 c0          	pmovmskb %xmm0,%eax
   157e5:	3d ff ff 00 00       	cmp    $0xffff,%eax
   157ea:	0f 94 44 24 07       	sete   0x7(%rsp)
   157ef:	48 ff cb             	dec    %rbx
   157f2:	75 bc                	jne    157b0 <probe::array_value+0x40>
   157f4:	48 83 c4 38          	add    $0x38,%rsp
   157f8:	5b                   	pop    %rbx
   157f9:	41 5c                	pop    %r12
   157fb:	41 5d                	pop    %r13
   157fd:	41 5e                	pop    %r14
   157ff:	41 5f                	pop    %r15
   15801:	5d                   	pop    %rbp
   15802:	c3                   	ret
   15803:	cc                   	int3
   15804:	cc                   	int3
   15805:	cc                   	int3
   15806:	cc                   	int3
   15807:	cc                   	int3
   15808:	cc                   	int3
   15809:	cc                   	int3
   1580a:	cc                   	int3
   1580b:	cc                   	int3
   1580c:	cc                   	int3
   1580d:	cc                   	int3
   1580e:	cc                   	int3
   1580f:	cc                   	int3

0000000000015810 <probe::persistent_wide>:
   15810:	41 57                	push   %r15
   15812:	41 56                	push   %r14
   15814:	41 54                	push   %r12
   15816:	53                   	push   %rbx
   15817:	48 83 ec 28          	sub    $0x28,%rsp
   1581b:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   15822:	00 00 
   15824:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
   15829:	48 89 04 24          	mov    %rax,(%rsp)
   1582d:	48 8d 05 44 d4 03 00 	lea    0x3d444(%rip),%rax        # 52c78 <__frame_dummy_init_array_entry+0x38>
   15834:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   15839:	48 85 ff             	test   %rdi,%rdi
   1583c:	74 61                	je     1589f <probe::persistent_wide+0x8f>
   1583e:	48 89 fb             	mov    %rdi,%rbx
   15841:	49 89 e4             	mov    %rsp,%r12
   15844:	4c 8d 74 24 10       	lea    0x10(%rsp),%r14
   15849:	eb 18                	jmp    15863 <probe::persistent_wide+0x53>
   1584b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   15850:	31 c0                	xor    %eax,%eax
   15852:	49 83 3f 00          	cmpq   $0x0,(%r15)
   15856:	0f 94 c0             	sete   %al
   15859:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
   1585e:	48 ff cb             	dec    %rbx
   15861:	74 3c                	je     1589f <probe::persistent_wide+0x8f>
   15863:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
   15868:	4c 8b 3c 24          	mov    (%rsp),%r15
   1586c:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
   15871:	4c 89 f7             	mov    %r14,%rdi
   15874:	4c 89 fe             	mov    %r15,%rsi
   15877:	ff 50 18             	call   *0x18(%rax)
   1587a:	66 0f 6f 44 24 10    	movdqa 0x10(%rsp),%xmm0
   15880:	66 0f 74 05 78 fa fe 	pcmpeqb -0x10588(%rip),%xmm0        # 5300 <__abi_tag+0x4fcc>
   15887:	ff 
   15888:	66 0f d7 c0          	pmovmskb %xmm0,%eax
   1588c:	3d ff ff 00 00       	cmp    $0xffff,%eax
   15891:	74 bd                	je     15850 <probe::persistent_wide+0x40>
   15893:	31 c0                	xor    %eax,%eax
   15895:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
   1589a:	48 ff cb             	dec    %rbx
   1589d:	75 c4                	jne    15863 <probe::persistent_wide+0x53>
   1589f:	48 83 c4 28          	add    $0x28,%rsp
   158a3:	5b                   	pop    %rbx
   158a4:	41 5c                	pop    %r12
   158a6:	41 5e                	pop    %r14
   158a8:	41 5f                	pop    %r15
   158aa:	c3                   	ret
   158ab:	cc                   	int3
   158ac:	cc                   	int3
   158ad:	cc                   	int3
   158ae:	cc                   	int3
   158af:	cc                   	int3

00000000000158b0 <probe::repeated_boundary>:
   158b0:	48 85 ff             	test   %rdi,%rdi
   158b3:	74 75                	je     1592a <probe::repeated_boundary+0x7a>
   158b5:	41 57                	push   %r15
   158b7:	41 56                	push   %r14
   158b9:	41 55                	push   %r13
   158bb:	41 54                	push   %r12
   158bd:	53                   	push   %rbx
   158be:	48 83 ec 20          	sub    $0x20,%rsp
   158c2:	48 89 d3             	mov    %rdx,%rbx
   158c5:	49 89 f6             	mov    %rsi,%r14
   158c8:	49 89 ff             	mov    %rdi,%r15
   158cb:	4c 8d 64 24 10       	lea    0x10(%rsp),%r12
   158d0:	4c 8d 6c 24 0f       	lea    0xf(%rsp),%r13
   158d5:	eb 14                	jmp    158eb <probe::repeated_boundary+0x3b>
   158d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   158de:	00 00 
   158e0:	31 c0                	xor    %eax,%eax
   158e2:	88 44 24 0f          	mov    %al,0xf(%rsp)
   158e6:	49 ff cf             	dec    %r15
   158e9:	74 32                	je     1591d <probe::repeated_boundary+0x6d>
   158eb:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
   158f0:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
   158f5:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
   158fa:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
   158ff:	48 8b 70 18          	mov    0x18(%rax),%rsi
   15903:	e8 68 0e 00 00       	call   16770 <probe::isolated>
   15908:	48 85 c0             	test   %rax,%rax
   1590b:	74 d3                	je     158e0 <probe::repeated_boundary+0x30>
   1590d:	48 83 38 00          	cmpq   $0x0,(%rax)
   15911:	0f 94 c0             	sete   %al
   15914:	88 44 24 0f          	mov    %al,0xf(%rsp)
   15918:	49 ff cf             	dec    %r15
   1591b:	75 ce                	jne    158eb <probe::repeated_boundary+0x3b>
   1591d:	48 83 c4 20          	add    $0x20,%rsp
   15921:	5b                   	pop    %rbx
   15922:	41 5c                	pop    %r12
   15924:	41 5d                	pop    %r13
   15926:	41 5e                	pop    %r14
   15928:	41 5f                	pop    %r15
   1592a:	c3                   	ret
   1592b:	cc                   	int3
   1592c:	cc                   	int3
   1592d:	cc                   	int3
   1592e:	cc                   	int3
   1592f:	cc                   	int3

0000000000015930 <probe::base>:
   15930:	48 85 ff             	test   %rdi,%rdi
   15933:	0f 84 92 00 00 00    	je     159cb <probe::base+0x9b>
   15939:	55                   	push   %rbp
   1593a:	41 57                	push   %r15
   1593c:	41 56                	push   %r14
   1593e:	41 55                	push   %r13
   15940:	41 54                	push   %r12
   15942:	53                   	push   %rbx
   15943:	48 83 ec 28          	sub    $0x28,%rsp
   15947:	48 89 fb             	mov    %rdi,%rbx
   1594a:	4c 8d 64 24 20       	lea    0x20(%rsp),%r12
   1594f:	4c 8d 2d 22 d3 03 00 	lea    0x3d322(%rip),%r13        # 52c78 <__frame_dummy_init_array_entry+0x38>
   15956:	48 89 e5             	mov    %rsp,%rbp
   15959:	4c 8d 74 24 10       	lea    0x10(%rsp),%r14
   1595e:	eb 10                	jmp    15970 <probe::base+0x40>
   15960:	49 83 3f 00          	cmpq   $0x0,(%r15)
   15964:	0f 94 c0             	sete   %al
   15967:	88 44 24 10          	mov    %al,0x10(%rsp)
   1596b:	48 ff cb             	dec    %rbx
   1596e:	74 4d                	je     159bd <probe::base+0x8d>
   15970:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   15977:	00 00 
   15979:	4c 89 24 24          	mov    %r12,(%rsp)
   1597d:	4c 89 6c 24 08       	mov    %r13,0x8(%rsp)
   15982:	48 89 6c 24 10       	mov    %rbp,0x10(%rsp)
   15987:	4c 8b 3c 24          	mov    (%rsp),%r15
   1598b:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
   15990:	4c 89 f7             	mov    %r14,%rdi
   15993:	4c 89 fe             	mov    %r15,%rsi
   15996:	ff 50 18             	call   *0x18(%rax)
   15999:	66 0f 6f 44 24 10    	movdqa 0x10(%rsp),%xmm0
   1599f:	66 0f 74 05 59 f9 fe 	pcmpeqb -0x106a7(%rip),%xmm0        # 5300 <__abi_tag+0x4fcc>
   159a6:	ff 
   159a7:	66 0f d7 c0          	pmovmskb %xmm0,%eax
   159ab:	3d ff ff 00 00       	cmp    $0xffff,%eax
   159b0:	74 ae                	je     15960 <probe::base+0x30>
   159b2:	31 c0                	xor    %eax,%eax
   159b4:	88 44 24 10          	mov    %al,0x10(%rsp)
   159b8:	48 ff cb             	dec    %rbx
   159bb:	75 b3                	jne    15970 <probe::base+0x40>
   159bd:	48 83 c4 28          	add    $0x28,%rsp
   159c1:	5b                   	pop    %rbx
   159c2:	41 5c                	pop    %r12
   159c4:	41 5d                	pop    %r13
   159c6:	41 5e                	pop    %r14
   159c8:	41 5f                	pop    %r15
   159ca:	5d                   	pop    %rbp
   159cb:	c3                   	ret
   159cc:	cc                   	int3
   159cd:	cc                   	int3
   159ce:	cc                   	int3
   159cf:	cc                   	int3

00000000000159d0 <probe::main>:
   159d0:	55                   	push   %rbp
   159d1:	41 57                	push   %r15
   159d3:	41 56                	push   %r14
   159d5:	41 55                	push   %r13
   159d7:	41 54                	push   %r12
   159d9:	53                   	push   %rbx
   159da:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
   159e1:	48 8d 5c 24 60       	lea    0x60(%rsp),%rbx
   159e6:	48 89 df             	mov    %rbx,%rdi
   159e9:	ff 15 69 f1 03 00    	call   *0x3f169(%rip)        # 54b58 <_DYNAMIC+0x278>
   159ef:	48 c7 84 24 80 00 00 	movq   $0x0,0x80(%rsp)
   159f6:	00 00 00 00 00 
   159fb:	48 89 e7             	mov    %rsp,%rdi
   159fe:	48 89 de             	mov    %rbx,%rsi
   15a01:	ff 15 41 f1 03 00    	call   *0x3f141(%rip)        # 54b48 <_DYNAMIC+0x268>
   15a07:	48 8b 34 24          	mov    (%rsp),%rsi
   15a0b:	48 85 f6             	test   %rsi,%rsi
   15a0e:	74 1a                	je     15a2a <probe::main+0x5a>
   15a10:	48 83 fe ff          	cmp    $0xffffffffffffffff,%rsi
   15a14:	0f 84 e7 08 00 00    	je     16301 <probe::main+0x931>
   15a1a:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
   15a1f:	ba 01 00 00 00       	mov    $0x1,%edx
   15a24:	ff 15 26 f1 03 00    	call   *0x3f126(%rip)        # 54b50 <_DYNAMIC+0x270>
   15a2a:	49 89 e7             	mov    %rsp,%r15
   15a2d:	48 8d 74 24 60       	lea    0x60(%rsp),%rsi
   15a32:	4c 89 ff             	mov    %r15,%rdi
   15a35:	ff 15 0d f1 03 00    	call   *0x3f10d(%rip)        # 54b48 <_DYNAMIC+0x268>
   15a3b:	48 8b 2c 24          	mov    (%rsp),%rbp
   15a3f:	48 83 fd ff          	cmp    $0xffffffffffffffff,%rbp
   15a43:	0f 84 b8 08 00 00    	je     16301 <probe::main+0x931>
   15a49:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
   15a4e:	48 8b 5c 24 10       	mov    0x10(%rsp),%rbx
   15a53:	48 83 fb 05          	cmp    $0x5,%rbx
   15a57:	75 18                	jne    15a71 <probe::main+0xa1>
   15a59:	b8 63 68 65 63       	mov    $0x63656863,%eax
   15a5e:	41 33 06             	xor    (%r14),%eax
   15a61:	41 0f b6 4e 04       	movzbl 0x4(%r14),%ecx
   15a66:	83 f1 6b             	xor    $0x6b,%ecx
   15a69:	09 c1                	or     %eax,%ecx
   15a6b:	0f 84 73 01 00 00    	je     15be4 <probe::main+0x214>
   15a71:	48 8b b4 24 80 00 00 	mov    0x80(%rsp),%rsi
   15a78:	00 
   15a79:	48 85 f6             	test   %rsi,%rsi
   15a7c:	0f 85 91 08 00 00    	jne    16313 <probe::main+0x943>
   15a82:	48 89 e7             	mov    %rsp,%rdi
   15a85:	48 8d 74 24 60       	lea    0x60(%rsp),%rsi
   15a8a:	ff 15 b8 f0 03 00    	call   *0x3f0b8(%rip)        # 54b48 <_DYNAMIC+0x268>
   15a90:	4c 8b 3c 24          	mov    (%rsp),%r15
   15a94:	49 83 ff ff          	cmp    $0xffffffffffffffff,%r15
   15a98:	0f 84 94 08 00 00    	je     16332 <probe::main+0x962>
   15a9e:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
   15aa3:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
   15aa8:	48 83 f9 01          	cmp    $0x1,%rcx
   15aac:	74 10                	je     15abe <probe::main+0xee>
   15aae:	48 85 c9             	test   %rcx,%rcx
   15ab1:	0f 84 0c 09 00 00    	je     163c3 <probe::main+0x9f3>
   15ab7:	41 0f b6 14 24       	movzbl (%r12),%edx
   15abc:	eb 19                	jmp    15ad7 <probe::main+0x107>
   15abe:	41 0f b6 14 24       	movzbl (%r12),%edx
   15ac3:	b0 01                	mov    $0x1,%al
   15ac5:	83 fa 2b             	cmp    $0x2b,%edx
   15ac8:	0f 84 f6 07 00 00    	je     162c4 <probe::main+0x8f4>
   15ace:	83 fa 2d             	cmp    $0x2d,%edx
   15ad1:	0f 84 ed 07 00 00    	je     162c4 <probe::main+0x8f4>
   15ad7:	31 f6                	xor    %esi,%esi
   15ad9:	80 fa 2b             	cmp    $0x2b,%dl
   15adc:	40 0f 94 c6          	sete   %sil
   15ae0:	48 89 f0             	mov    %rsi,%rax
   15ae3:	48 f7 d8             	neg    %rax
   15ae6:	48 89 ca             	mov    %rcx,%rdx
   15ae9:	48 29 f2             	sub    %rsi,%rdx
   15aec:	4c 01 e6             	add    %r12,%rsi
   15aef:	4d 89 f5             	mov    %r14,%r13
   15af2:	48 83 fa 11          	cmp    $0x11,%rdx
   15af6:	73 3f                	jae    15b37 <probe::main+0x167>
   15af8:	48 85 d2             	test   %rdx,%rdx
   15afb:	0f 84 02 05 00 00    	je     16003 <probe::main+0x633>
   15b01:	48 01 c1             	add    %rax,%rcx
   15b04:	48 f7 d9             	neg    %rcx
   15b07:	31 c0                	xor    %eax,%eax
   15b09:	31 d2                	xor    %edx,%edx
   15b0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   15b10:	0f b6 3c 16          	movzbl (%rsi,%rdx,1),%edi
   15b14:	83 c7 d0             	add    $0xffffffd0,%edi
   15b17:	83 ff 09             	cmp    $0x9,%edi
   15b1a:	0f 87 90 08 00 00    	ja     163b0 <probe::main+0x9e0>
   15b20:	48 8d 04 80          	lea    (%rax,%rax,4),%rax
   15b24:	89 ff                	mov    %edi,%edi
   15b26:	48 8d 04 47          	lea    (%rdi,%rax,2),%rax
   15b2a:	48 ff c2             	inc    %rdx
   15b2d:	48 89 cf             	mov    %rcx,%rdi
   15b30:	48 01 d7             	add    %rdx,%rdi
   15b33:	75 db                	jne    15b10 <probe::main+0x140>
   15b35:	eb 49                	jmp    15b80 <probe::main+0x1b0>
   15b37:	48 01 c1             	add    %rax,%rcx
   15b3a:	48 f7 d9             	neg    %rcx
   15b3d:	31 c0                	xor    %eax,%eax
   15b3f:	bf 0a 00 00 00       	mov    $0xa,%edi
   15b44:	45 31 c0             	xor    %r8d,%r8d
   15b47:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   15b4e:	00 00 
   15b50:	48 f7 e7             	mul    %rdi
   15b53:	42 0f b6 14 06       	movzbl (%rsi,%r8,1),%edx
   15b58:	0f 80 55 07 00 00    	jo     162b3 <probe::main+0x8e3>
   15b5e:	83 c2 d0             	add    $0xffffffd0,%edx
   15b61:	83 fa 0a             	cmp    $0xa,%edx
   15b64:	0f 83 46 08 00 00    	jae    163b0 <probe::main+0x9e0>
   15b6a:	89 d2                	mov    %edx,%edx
   15b6c:	48 01 d0             	add    %rdx,%rax
   15b6f:	0f 82 4a 07 00 00    	jb     162bf <probe::main+0x8ef>
   15b75:	49 ff c0             	inc    %r8
   15b78:	48 89 ca             	mov    %rcx,%rdx
   15b7b:	4c 01 c2             	add    %r8,%rdx
   15b7e:	75 d0                	jne    15b50 <probe::main+0x180>
   15b80:	4d 85 ff             	test   %r15,%r15
   15b83:	74 17                	je     15b9c <probe::main+0x1cc>
   15b85:	ba 01 00 00 00       	mov    $0x1,%edx
   15b8a:	4c 89 e7             	mov    %r12,%rdi
   15b8d:	4c 89 fe             	mov    %r15,%rsi
   15b90:	49 89 c6             	mov    %rax,%r14
   15b93:	ff 15 b7 ef 03 00    	call   *0x3efb7(%rip)        # 54b50 <_DYNAMIC+0x270>
   15b99:	4c 89 f0             	mov    %r14,%rax
   15b9c:	48 83 c3 fc          	add    $0xfffffffffffffffc,%rbx
   15ba0:	48 83 fb 0d          	cmp    $0xd,%rbx
   15ba4:	4d 89 ee             	mov    %r13,%r14
   15ba7:	0f 87 97 07 00 00    	ja     16344 <probe::main+0x974>
   15bad:	48 8d 0d 5c f9 fe ff 	lea    -0x106a4(%rip),%rcx        # 5510 <__abi_tag+0x51dc>
   15bb4:	48 63 14 99          	movslq (%rcx,%rbx,4),%rdx
   15bb8:	48 01 ca             	add    %rcx,%rdx
   15bbb:	ff e2                	jmp    *%rdx
   15bbd:	41 81 3e 62 61 73 65 	cmpl   $0x65736162,(%r14)
   15bc4:	0f 84 21 06 00 00    	je     161eb <probe::main+0x81b>
   15bca:	41 81 3e 70 61 69 72 	cmpl   $0x72696170,(%r14)
   15bd1:	0f 85 6d 07 00 00    	jne    16344 <probe::main+0x974>
   15bd7:	48 89 c7             	mov    %rax,%rdi
   15bda:	e8 21 09 00 00       	call   16500 <probe::pair>
   15bdf:	e9 23 06 00 00       	jmp    16207 <probe::main+0x837>
   15be4:	4c 89 7c 24 58       	mov    %r15,0x58(%rsp)
   15be9:	4c 89 74 24 40       	mov    %r14,0x40(%rsp)
   15bee:	48 89 6c 24 48       	mov    %rbp,0x48(%rsp)
   15bf3:	49 bf d7 4a 03 7f dd 	movabs $0xf928d5dd7f034ad7,%r15
   15bfa:	d5 28 f9 
   15bfd:	48 bb 83 1e ad de 52 	movabs $0xacf90852dead1e83,%rbx
   15c04:	08 f9 ac 
   15c07:	48 b8 eb 68 de c5 b6 	movabs $0x9b3381b6c5de68eb,%rax
   15c0e:	81 33 9b 
   15c11:	48 b9 8f 15 1f e2 19 	movabs $0x6e75a319e21f158f,%rcx
   15c18:	a3 75 6e 
   15c1b:	49 bc 41 5d 9d 93 05 	movabs $0x9110c405939d5d41,%r12
   15c22:	c4 10 91 
   15c25:	49 be 55 12 9a 1a 53 	movabs $0xda31bd531a9a1255,%r14
   15c2c:	bd 31 da 
   15c2f:	48 c7 c5 00 fc ff ff 	mov    $0xfffffffffffffc00,%rbp
   15c36:	4c 8d 6c 24 30       	lea    0x30(%rsp),%r13
   15c3b:	48 31 c9             	xor    %rcx,%rcx
   15c3e:	48 89 8c 24 90 00 00 	mov    %rcx,0x90(%rsp)
   15c45:	00 
   15c46:	48 31 c0             	xor    %rax,%rax
   15c49:	48 89 84 24 88 00 00 	mov    %rax,0x88(%rsp)
   15c50:	00 
   15c51:	4d 31 f6             	xor    %r14,%r14
   15c54:	4d 31 e4             	xor    %r12,%r12
   15c57:	48 31 db             	xor    %rbx,%rbx
   15c5a:	4d 31 ff             	xor    %r15,%r15
   15c5d:	0f 1f 00             	nopl   (%rax)
   15c60:	48 89 6c 24 30       	mov    %rbp,0x30(%rsp)
   15c65:	4c 89 ef             	mov    %r13,%rdi
   15c68:	48 8d 35 d1 0b 00 00 	lea    0xbd1(%rip),%rsi        # 16840 <<isize as probe::ArrayId>::array_id>
   15c6f:	e8 fc 0a 00 00       	call   16770 <probe::isolated>
   15c74:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   15c79:	4c 89 2c 24          	mov    %r13,(%rsp)
   15c7d:	48 85 c0             	test   %rax,%rax
   15c80:	0f 84 6b 07 00 00    	je     163f1 <probe::main+0xa21>
   15c86:	48 8b 00             	mov    (%rax),%rax
   15c89:	48 3b 44 24 30       	cmp    0x30(%rsp),%rax
   15c8e:	0f 85 5d 07 00 00    	jne    163f1 <probe::main+0xa21>
   15c94:	48 b8 eb 68 de c5 b6 	movabs $0x9b3381b6c5de68eb,%rax
   15c9b:	81 33 9b 
   15c9e:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
   15ca3:	48 b9 8f 15 1f e2 19 	movabs $0x6e75a319e21f158f,%rcx
   15caa:	a3 75 6e 
   15cad:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   15cb2:	48 89 0c 24          	mov    %rcx,(%rsp)
   15cb6:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   15cbb:	48 8b 84 24 90 00 00 	mov    0x90(%rsp),%rax
   15cc2:	00 
   15cc3:	48 0b 84 24 88 00 00 	or     0x88(%rsp),%rax
   15cca:	00 
   15ccb:	0f 85 00 06 00 00    	jne    162d1 <probe::main+0x901>
   15cd1:	48 89 6c 24 30       	mov    %rbp,0x30(%rsp)
   15cd6:	4c 89 ef             	mov    %r13,%rdi
   15cd9:	48 8d 35 b0 0b 00 00 	lea    0xbb0(%rip),%rsi        # 16890 <<u64 as core::any::Any>::type_id>
   15ce0:	e8 8b 0a 00 00       	call   16770 <probe::isolated>
   15ce5:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   15cea:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
   15cf1:	00 
   15cf2:	48 85 c0             	test   %rax,%rax
   15cf5:	0f 85 f6 06 00 00    	jne    163f1 <probe::main+0xa21>
   15cfb:	48 b8 41 5d 9d 93 05 	movabs $0x9110c405939d5d41,%rax
   15d02:	c4 10 91 
   15d05:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
   15d0a:	48 b9 55 12 9a 1a 53 	movabs $0xda31bd531a9a1255,%rcx
   15d11:	bd 31 da 
   15d14:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   15d19:	48 89 0c 24          	mov    %rcx,(%rsp)
   15d1d:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   15d22:	4c 89 f0             	mov    %r14,%rax
   15d25:	4c 09 e0             	or     %r12,%rax
   15d28:	0f 85 a3 05 00 00    	jne    162d1 <probe::main+0x901>
   15d2e:	48 89 2c 24          	mov    %rbp,(%rsp)
   15d32:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
   15d37:	48 89 6c 24 10       	mov    %rbp,0x10(%rsp)
   15d3c:	48 89 e7             	mov    %rsp,%rdi
   15d3f:	48 8d 35 0a 0b 00 00 	lea    0xb0a(%rip),%rsi        # 16850 <<[isize; 3] as core::any::Any>::type_id>
   15d46:	e8 25 0a 00 00       	call   16770 <probe::isolated>
   15d4b:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
   15d50:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   15d57:	00 00 
   15d59:	48 85 c0             	test   %rax,%rax
   15d5c:	0f 85 55 06 00 00    	jne    163b7 <probe::main+0x9e7>
   15d62:	48 b8 d7 4a 03 7f dd 	movabs $0xf928d5dd7f034ad7,%rax
   15d69:	d5 28 f9 
   15d6c:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
   15d71:	48 b9 83 1e ad de 52 	movabs $0xacf90852dead1e83,%rcx
   15d78:	08 f9 ac 
   15d7b:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
   15d80:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   15d85:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
   15d8a:	48 89 d8             	mov    %rbx,%rax
   15d8d:	4c 09 f8             	or     %r15,%rax
   15d90:	0f 85 4f 05 00 00    	jne    162e5 <probe::main+0x915>
   15d96:	48 ff c5             	inc    %rbp
   15d99:	48 81 fd 00 04 00 00 	cmp    $0x400,%rbp
   15da0:	0f 85 ba fe ff ff    	jne    15c60 <probe::main+0x290>
   15da6:	ff 15 b4 ed 03 00    	call   *0x3edb4(%rip)        # 54b60 <_DYNAMIC+0x280>
   15dac:	bf 04 00 00 00       	mov    $0x4,%edi
   15db1:	be 01 00 00 00       	mov    $0x1,%esi
   15db6:	ff 15 ac ed 03 00    	call   *0x3edac(%rip)        # 54b68 <_DYNAMIC+0x288>
   15dbc:	48 85 c0             	test   %rax,%rax
   15dbf:	0f 84 9d 05 00 00    	je     16362 <probe::main+0x992>
   15dc5:	c7 00 74 65 73 74    	movl   $0x74736574,(%rax)
   15dcb:	48 c7 04 24 04 00 00 	movq   $0x4,(%rsp)
   15dd2:	00 
   15dd3:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   15dd8:	48 c7 44 24 10 04 00 	movq   $0x4,0x10(%rsp)
   15ddf:	00 00 
   15de1:	48 8d 35 88 0a 00 00 	lea    0xa88(%rip),%rsi        # 16870 <<alloc::string::String as core::any::Any>::type_id>
   15de8:	48 89 e7             	mov    %rsp,%rdi
   15deb:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
   15df0:	4c 8b 74 24 40       	mov    0x40(%rsp),%r14
   15df5:	e8 76 09 00 00       	call   16770 <probe::isolated>
   15dfa:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
   15dff:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   15e06:	00 00 
   15e08:	48 85 c0             	test   %rax,%rax
   15e0b:	0f 85 b9 05 00 00    	jne    163ca <probe::main+0x9fa>
   15e11:	48 b8 7a 8f 66 26 66 	movabs $0xa725906626668f7a,%rax
   15e18:	90 25 a7 
   15e1b:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
   15e20:	48 b9 b8 1d 0f eb 2d 	movabs $0x518f72deb0f1db8,%rcx
   15e27:	f7 18 05 
   15e2a:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
   15e2f:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   15e34:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
   15e39:	66 0f 6f 44 24 20    	movdqa 0x20(%rsp),%xmm0
   15e3f:	66 0f 74 05 09 f6 fe 	pcmpeqb -0x109f7(%rip),%xmm0        # 5450 <__abi_tag+0x511c>
   15e46:	ff 
   15e47:	66 0f d7 c0          	pmovmskb %xmm0,%eax
   15e4b:	3d ff ff 00 00       	cmp    $0xffff,%eax
   15e50:	0f 85 2b 05 00 00    	jne    16381 <probe::main+0x9b1>
   15e56:	48 8b 34 24          	mov    (%rsp),%rsi
   15e5a:	48 85 f6             	test   %rsi,%rsi
   15e5d:	74 10                	je     15e6f <probe::main+0x49f>
   15e5f:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
   15e64:	ba 01 00 00 00       	mov    $0x1,%edx
   15e69:	ff 15 e1 ec 03 00    	call   *0x3ece1(%rip)        # 54b50 <_DYNAMIC+0x270>
   15e6f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
   15e76:	00 
   15e77:	48 c7 44 24 08 01 00 	movq   $0x1,0x8(%rsp)
   15e7e:	00 00 
   15e80:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
   15e87:	00 00 
   15e89:	48 8d 35 d0 09 00 00 	lea    0x9d0(%rip),%rsi        # 16860 <<alloc::vec::Vec<u8> as core::any::Any>::type_id>
   15e90:	48 89 e3             	mov    %rsp,%rbx
   15e93:	48 89 df             	mov    %rbx,%rdi
   15e96:	e8 d5 08 00 00       	call   16770 <probe::isolated>
   15e9b:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
   15ea0:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   15ea7:	00 00 
   15ea9:	48 85 c0             	test   %rax,%rax
   15eac:	0f 85 29 05 00 00    	jne    163db <probe::main+0xa0b>
   15eb2:	48 b8 0f 38 5e e9 9e 	movabs $0x5ea2649ee95e380f,%rax
   15eb9:	64 a2 5e 
   15ebc:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
   15ec1:	48 b9 07 5c a4 34 09 	movabs $0x8c66ab0934a45c07,%rcx
   15ec8:	ab 66 8c 
   15ecb:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
   15ed0:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   15ed5:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
   15eda:	66 0f 6f 44 24 20    	movdqa 0x20(%rsp),%xmm0
   15ee0:	66 0f 74 05 08 f6 fe 	pcmpeqb -0x109f8(%rip),%xmm0        # 54f0 <__abi_tag+0x51bc>
   15ee7:	ff 
   15ee8:	66 0f d7 c0          	pmovmskb %xmm0,%eax
   15eec:	3d ff ff 00 00       	cmp    $0xffff,%eax
   15ef1:	0f 85 9b 04 00 00    	jne    16392 <probe::main+0x9c2>
   15ef7:	48 8b 34 24          	mov    (%rsp),%rsi
   15efb:	48 85 f6             	test   %rsi,%rsi
   15efe:	74 10                	je     15f10 <probe::main+0x540>
   15f00:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
   15f05:	ba 01 00 00 00       	mov    $0x1,%edx
   15f0a:	ff 15 40 ec 03 00    	call   *0x3ec40(%rip)        # 54b50 <_DYNAMIC+0x270>
   15f10:	48 8d 35 69 09 00 00 	lea    0x969(%rip),%rsi        # 16880 <<() as core::any::Any>::type_id>
   15f17:	48 8d 7c 24 57       	lea    0x57(%rsp),%rdi
   15f1c:	e8 4f 08 00 00       	call   16770 <probe::isolated>
   15f21:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
   15f26:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
   15f2d:	00 
   15f2e:	48 85 c0             	test   %rax,%rax
   15f31:	0f 85 b5 04 00 00    	jne    163ec <probe::main+0xa1c>
   15f37:	48 b8 cd e7 45 8e 40 	movabs $0x5fc01408e45e7cd,%rax
   15f3e:	01 fc 05 
   15f41:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
   15f46:	48 b9 fc ea 91 33 1e 	movabs $0xdf9e041e3391eafc,%rcx
   15f4d:	04 9e df 
   15f50:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
   15f55:	48 89 0c 24          	mov    %rcx,(%rsp)
   15f59:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   15f5e:	66 0f 6f 04 24       	movdqa (%rsp),%xmm0
   15f63:	66 0f 74 05 c5 f3 fe 	pcmpeqb -0x10c3b(%rip),%xmm0        # 5330 <__abi_tag+0x4ffc>
   15f6a:	ff 
   15f6b:	66 0f d7 c0          	pmovmskb %xmm0,%eax
   15f6f:	3d ff ff 00 00       	cmp    $0xffff,%eax
   15f74:	0f 85 29 04 00 00    	jne    163a3 <probe::main+0x9d3>
   15f7a:	48 8d 3d b0 06 ff ff 	lea    -0xf950(%rip),%rdi        # 6631 <__abi_tag+0x62fd>
   15f81:	be 73 00 00 00       	mov    $0x73,%esi
   15f86:	ff 15 e4 eb 03 00    	call   *0x3ebe4(%rip)        # 54b70 <_DYNAMIC+0x290>
   15f8c:	48 85 ed             	test   %rbp,%rbp
   15f8f:	74 11                	je     15fa2 <probe::main+0x5d2>
   15f91:	ba 01 00 00 00       	mov    $0x1,%edx
   15f96:	4c 89 f7             	mov    %r14,%rdi
   15f99:	48 89 ee             	mov    %rbp,%rsi
   15f9c:	ff 15 ae eb 03 00    	call   *0x3ebae(%rip)        # 54b50 <_DYNAMIC+0x270>
   15fa2:	4c 8b 74 24 68       	mov    0x68(%rsp),%r14
   15fa7:	48 8b 4c 24 78       	mov    0x78(%rsp),%rcx
   15fac:	48 89 c8             	mov    %rcx,%rax
   15faf:	4c 29 f0             	sub    %r14,%rax
   15fb2:	48 ba ab aa aa aa aa 	movabs $0xaaaaaaaaaaaaaaab,%rdx
   15fb9:	aa aa aa 
   15fbc:	48 f7 e2             	mul    %rdx
   15fbf:	4c 39 f1             	cmp    %r14,%rcx
   15fc2:	0f 84 b7 02 00 00    	je     1627f <probe::main+0x8af>
   15fc8:	48 89 d3             	mov    %rdx,%rbx
   15fcb:	48 c1 eb 04          	shr    $0x4,%rbx
   15fcf:	49 83 c6 08          	add    $0x8,%r14
   15fd3:	4c 8b 3d 76 eb 03 00 	mov    0x3eb76(%rip),%r15        # 54b50 <_DYNAMIC+0x270>
   15fda:	eb 11                	jmp    15fed <probe::main+0x61d>
   15fdc:	0f 1f 40 00          	nopl   0x0(%rax)
   15fe0:	49 83 c6 18          	add    $0x18,%r14
   15fe4:	48 ff cb             	dec    %rbx
   15fe7:	0f 84 92 02 00 00    	je     1627f <probe::main+0x8af>
   15fed:	49 8b 76 f8          	mov    -0x8(%r14),%rsi
   15ff1:	48 85 f6             	test   %rsi,%rsi
   15ff4:	74 ea                	je     15fe0 <probe::main+0x610>
   15ff6:	49 8b 3e             	mov    (%r14),%rdi
   15ff9:	ba 01 00 00 00       	mov    $0x1,%edx
   15ffe:	41 ff d7             	call   *%r15
   16001:	eb dd                	jmp    15fe0 <probe::main+0x610>
   16003:	31 c0                	xor    %eax,%eax
   16005:	4d 85 ff             	test   %r15,%r15
   16008:	0f 85 77 fb ff ff    	jne    15b85 <probe::main+0x1b5>
   1600e:	e9 89 fb ff ff       	jmp    15b9c <probe::main+0x1cc>
   16013:	48 b9 70 65 72 73 69 	movabs $0x6574736973726570,%rcx
   1601a:	73 74 65 
   1601d:	49 33 0e             	xor    (%r14),%rcx
   16020:	48 ba 65 6e 74 5f 77 	movabs $0x656469775f746e65,%rdx
   16027:	69 64 65 
   1602a:	49 33 56 07          	xor    0x7(%r14),%rdx
   1602e:	48 09 ca             	or     %rcx,%rdx
   16031:	0f 85 0d 03 00 00    	jne    16344 <probe::main+0x974>
   16037:	48 89 c7             	mov    %rax,%rdi
   1603a:	e8 d1 f7 ff ff       	call   15810 <probe::persistent_wide>
   1603f:	e9 c3 01 00 00       	jmp    16207 <probe::main+0x837>
   16044:	f3 41 0f 6f 06       	movdqu (%r14),%xmm0
   16049:	41 0f b6 4e 10       	movzbl 0x10(%r14),%ecx
   1604e:	66 0f 6e c9          	movd   %ecx,%xmm1
   16052:	66 0f 74 05 a6 f4 fe 	pcmpeqb -0x10b5a(%rip),%xmm0        # 5500 <__abi_tag+0x51cc>
   16059:	ff 
   1605a:	66 0f 74 0d fe f2 fe 	pcmpeqb -0x10d02(%rip),%xmm1        # 5360 <__abi_tag+0x502c>
   16061:	ff 
   16062:	66 0f db c8          	pand   %xmm0,%xmm1
   16066:	66 0f d7 c9          	pmovmskb %xmm1,%ecx
   1606a:	81 f9 ff ff 00 00    	cmp    $0xffff,%ecx
   16070:	0f 85 ce 02 00 00    	jne    16344 <probe::main+0x974>
   16076:	48 8d 0d 63 05 ff ff 	lea    -0xfa9d(%rip),%rcx        # 65e0 <__abi_tag+0x62ac>
   1607d:	48 89 0c 24          	mov    %rcx,(%rsp)
   16081:	48 8d 0d f0 cb 03 00 	lea    0x3cbf0(%rip),%rcx        # 52c78 <__frame_dummy_init_array_entry+0x38>
   16088:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
   1608d:	48 89 e1             	mov    %rsp,%rcx
   16090:	48 8b 34 24          	mov    (%rsp),%rsi
   16094:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
   16099:	48 89 c7             	mov    %rax,%rdi
   1609c:	e8 0f f8 ff ff       	call   158b0 <probe::repeated_boundary>
   160a1:	e9 61 01 00 00       	jmp    16207 <probe::main+0x837>
   160a6:	48 b9 70 65 72 73 69 	movabs $0x6574736973726570,%rcx
   160ad:	73 74 65 
   160b0:	49 33 0e             	xor    (%r14),%rcx
   160b3:	41 0f b7 56 08       	movzwl 0x8(%r14),%edx
   160b8:	48 81 f2 6e 74 00 00 	xor    $0x746e,%rdx
   160bf:	48 09 ca             	or     %rcx,%rdx
   160c2:	0f 84 0f 01 00 00    	je     161d7 <probe::main+0x807>
   160c8:	48 b9 76 61 6c 75 65 	movabs $0x69775f65756c6176,%rcx
   160cf:	5f 77 69 
   160d2:	49 33 0e             	xor    (%r14),%rcx
   160d5:	41 0f b7 56 08       	movzwl 0x8(%r14),%edx
   160da:	48 81 f2 64 65 00 00 	xor    $0x6564,%rdx
   160e1:	48 09 ca             	or     %rcx,%rdx
   160e4:	0f 84 15 01 00 00    	je     161ff <probe::main+0x82f>
   160ea:	48 b9 70 61 69 72 5f 	movabs $0x6c61765f72696170,%rcx
   160f1:	76 61 6c 
   160f4:	49 33 0e             	xor    (%r14),%rcx
   160f7:	41 0f b7 56 08       	movzwl 0x8(%r14),%edx
   160fc:	48 81 f2 75 65 00 00 	xor    $0x6575,%rdx
   16103:	48 09 ca             	or     %rcx,%rdx
   16106:	0f 85 38 02 00 00    	jne    16344 <probe::main+0x974>
   1610c:	48 89 c7             	mov    %rax,%rdi
   1610f:	e8 7c f4 ff ff       	call   15590 <probe::pair_value>
   16114:	e9 ee 00 00 00       	jmp    16207 <probe::main+0x837>
   16119:	b9 76 61 6c 75       	mov    $0x756c6176,%ecx
   1611e:	41 33 0e             	xor    (%r14),%ecx
   16121:	41 0f b6 56 04       	movzbl 0x4(%r14),%edx
   16126:	83 f2 65             	xor    $0x65,%edx
   16129:	09 ca                	or     %ecx,%edx
   1612b:	0f 84 b0 00 00 00    	je     161e1 <probe::main+0x811>
   16131:	b9 61 72 72 61       	mov    $0x61727261,%ecx
   16136:	41 33 0e             	xor    (%r14),%ecx
   16139:	41 0f b6 56 04       	movzbl 0x4(%r14),%edx
   1613e:	83 f2 79             	xor    $0x79,%edx
   16141:	09 ca                	or     %ecx,%edx
   16143:	0f 85 fb 01 00 00    	jne    16344 <probe::main+0x974>
   16149:	48 89 c7             	mov    %rax,%rdi
   1614c:	e8 3f 04 00 00       	call   16590 <probe::array>
   16151:	e9 b1 00 00 00       	jmp    16207 <probe::main+0x837>
   16156:	48 b9 62 6f 75 6e 64 	movabs $0x797261646e756f62,%rcx
   1615d:	61 72 79 
   16160:	49 39 0e             	cmp    %rcx,(%r14)
   16163:	0f 84 8c 00 00 00    	je     161f5 <probe::main+0x825>
   16169:	48 b9 72 65 70 65 61 	movabs $0x6465746165706572,%rcx
   16170:	74 65 64 
   16173:	49 39 0e             	cmp    %rcx,(%r14)
   16176:	0f 85 c8 01 00 00    	jne    16344 <probe::main+0x974>
   1617c:	48 8d 0d 5d 04 ff ff 	lea    -0xfba3(%rip),%rcx        # 65e0 <__abi_tag+0x62ac>
   16183:	48 89 0c 24          	mov    %rcx,(%rsp)
   16187:	48 8d 0d ea ca 03 00 	lea    0x3caea(%rip),%rcx        # 52c78 <__frame_dummy_init_array_entry+0x38>
   1618e:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
   16193:	48 89 e1             	mov    %rsp,%rcx
   16196:	48 8b 34 24          	mov    (%rsp),%rsi
   1619a:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
   1619f:	48 89 c7             	mov    %rax,%rdi
   161a2:	e8 09 06 00 00       	call   167b0 <probe::repeated>
   161a7:	eb 5e                	jmp    16207 <probe::main+0x837>
   161a9:	48 b9 61 72 72 61 79 	movabs $0x61765f7961727261,%rcx
   161b0:	5f 76 61 
   161b3:	49 33 0e             	xor    (%r14),%rcx
   161b6:	48 ba 61 79 5f 76 61 	movabs $0x65756c61765f7961,%rdx
   161bd:	6c 75 65 
   161c0:	49 33 56 03          	xor    0x3(%r14),%rdx
   161c4:	48 09 ca             	or     %rcx,%rdx
   161c7:	0f 85 77 01 00 00    	jne    16344 <probe::main+0x974>
   161cd:	48 89 c7             	mov    %rax,%rdi
   161d0:	e8 9b f5 ff ff       	call   15770 <probe::array_value>
   161d5:	eb 30                	jmp    16207 <probe::main+0x837>
   161d7:	48 89 c7             	mov    %rax,%rdi
   161da:	e8 41 f4 ff ff       	call   15620 <probe::persistent>
   161df:	eb 26                	jmp    16207 <probe::main+0x837>
   161e1:	48 89 c7             	mov    %rax,%rdi
   161e4:	e8 47 04 00 00       	call   16630 <probe::value>
   161e9:	eb 1c                	jmp    16207 <probe::main+0x837>
   161eb:	48 89 c7             	mov    %rax,%rdi
   161ee:	e8 3d f7 ff ff       	call   15930 <probe::base>
   161f3:	eb 12                	jmp    16207 <probe::main+0x837>
   161f5:	48 89 c7             	mov    %rax,%rdi
   161f8:	e8 e3 04 00 00       	call   166e0 <probe::boundary>
   161fd:	eb 08                	jmp    16207 <probe::main+0x837>
   161ff:	48 89 c7             	mov    %rax,%rdi
   16202:	e8 b9 f4 ff ff       	call   156c0 <probe::value_wide>
   16207:	48 85 ed             	test   %rbp,%rbp
   1620a:	74 11                	je     1621d <probe::main+0x84d>
   1620c:	ba 01 00 00 00       	mov    $0x1,%edx
   16211:	4c 89 f7             	mov    %r14,%rdi
   16214:	48 89 ee             	mov    %rbp,%rsi
   16217:	ff 15 33 e9 03 00    	call   *0x3e933(%rip)        # 54b50 <_DYNAMIC+0x270>
   1621d:	4c 8b 74 24 68       	mov    0x68(%rsp),%r14
   16222:	48 8b 4c 24 78       	mov    0x78(%rsp),%rcx
   16227:	48 89 c8             	mov    %rcx,%rax
   1622a:	4c 29 f0             	sub    %r14,%rax
   1622d:	48 ba ab aa aa aa aa 	movabs $0xaaaaaaaaaaaaaaab,%rdx
   16234:	aa aa aa 
   16237:	48 f7 e2             	mul    %rdx
   1623a:	4c 39 f1             	cmp    %r14,%rcx
   1623d:	74 40                	je     1627f <probe::main+0x8af>
   1623f:	48 89 d3             	mov    %rdx,%rbx
   16242:	48 c1 eb 04          	shr    $0x4,%rbx
   16246:	49 83 c6 08          	add    $0x8,%r14
   1624a:	4c 8b 3d ff e8 03 00 	mov    0x3e8ff(%rip),%r15        # 54b50 <_DYNAMIC+0x270>
   16251:	eb 16                	jmp    16269 <probe::main+0x899>
   16253:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   1625a:	84 00 00 00 00 00 
   16260:	49 83 c6 18          	add    $0x18,%r14
   16264:	48 ff cb             	dec    %rbx
   16267:	74 16                	je     1627f <probe::main+0x8af>
   16269:	49 8b 76 f8          	mov    -0x8(%r14),%rsi
   1626d:	48 85 f6             	test   %rsi,%rsi
   16270:	74 ee                	je     16260 <probe::main+0x890>
   16272:	49 8b 3e             	mov    (%r14),%rdi
   16275:	ba 01 00 00 00       	mov    $0x1,%edx
   1627a:	41 ff d7             	call   *%r15
   1627d:	eb e1                	jmp    16260 <probe::main+0x890>
   1627f:	48 8b 44 24 70       	mov    0x70(%rsp),%rax
   16284:	48 85 c0             	test   %rax,%rax
   16287:	74 18                	je     162a1 <probe::main+0x8d1>
   16289:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
   1628e:	48 c1 e0 03          	shl    $0x3,%rax
   16292:	48 8d 34 40          	lea    (%rax,%rax,2),%rsi
   16296:	ba 08 00 00 00       	mov    $0x8,%edx
   1629b:	ff 15 af e8 03 00    	call   *0x3e8af(%rip)        # 54b50 <_DYNAMIC+0x270>
   162a1:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
   162a8:	5b                   	pop    %rbx
   162a9:	41 5c                	pop    %r12
   162ab:	41 5d                	pop    %r13
   162ad:	41 5e                	pop    %r14
   162af:	41 5f                	pop    %r15
   162b1:	5d                   	pop    %rbp
   162b2:	c3                   	ret
   162b3:	80 c2 d0             	add    $0xd0,%dl
   162b6:	31 c0                	xor    %eax,%eax
   162b8:	80 fa 0a             	cmp    $0xa,%dl
   162bb:	14 01                	adc    $0x1,%al
   162bd:	eb 02                	jmp    162c1 <probe::main+0x8f1>
   162bf:	b0 02                	mov    $0x2,%al
   162c1:	4d 89 ee             	mov    %r13,%r14
   162c4:	0f b6 f8             	movzbl %al,%edi
   162c7:	e8 84 f1 ff ff       	call   15450 <core::result::unwrap_failed::<core::num::error::ParseIntError>>
   162cc:	e9 3c 01 00 00       	jmp    1640d <probe::main+0xa3d>
   162d1:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
   162d6:	4c 8b 74 24 40       	mov    0x40(%rsp),%r14
   162db:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   162e0:	48 89 e7             	mov    %rsp,%rdi
   162e3:	eb 12                	jmp    162f7 <probe::main+0x927>
   162e5:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
   162ea:	4c 89 ee             	mov    %r13,%rsi
   162ed:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
   162f2:	4c 8b 74 24 40       	mov    0x40(%rsp),%r14
   162f7:	e8 7f f1 ff ff       	call   1547b <core::panicking::assert_failed::<[u64; 2], [u64; 2]>>
   162fc:	e9 0c 01 00 00       	jmp    1640d <probe::main+0xa3d>
   16301:	48 8d 3d 80 ca 03 00 	lea    0x3ca80(%rip),%rdi        # 52d88 <__frame_dummy_init_array_entry+0x148>
   16308:	ff 15 6a e8 03 00    	call   *0x3e86a(%rip)        # 54b78 <_DYNAMIC+0x298>
   1630e:	e9 fa 00 00 00       	jmp    1640d <probe::main+0xa3d>
   16313:	48 c7 84 24 80 00 00 	movq   $0x0,0x80(%rsp)
   1631a:	00 00 00 00 00 
   1631f:	48 8d 7c 24 60       	lea    0x60(%rsp),%rdi
   16324:	e8 d7 f1 ff ff       	call   15500 <<std::env::Args as core::iter::traits::iterator::Iterator>::try_fold::<core::num::nonzero::NonZero<usize>, <std::env::Args as core::iter::traits::iterator::Iterator::advance_by::SpecAdvanceBy>::spec_advance_by::{closure#0}, core::option::Option<core::num::nonzero::NonZero<usize>>>>
   16329:	48 85 c0             	test   %rax,%rax
   1632c:	0f 84 50 f7 ff ff    	je     15a82 <probe::main+0xb2>
   16332:	48 8d 3d 67 ca 03 00 	lea    0x3ca67(%rip),%rdi        # 52da0 <__frame_dummy_init_array_entry+0x160>
   16339:	ff 15 39 e8 03 00    	call   *0x3e839(%rip)        # 54b78 <_DYNAMIC+0x298>
   1633f:	e9 c9 00 00 00       	jmp    1640d <probe::main+0xa3d>
   16344:	48 8d 3d ad 02 ff ff 	lea    -0xfd53(%rip),%rdi        # 65f8 <__abi_tag+0x62c4>
   1634b:	48 8d 15 66 ca 03 00 	lea    0x3ca66(%rip),%rdx        # 52db8 <__frame_dummy_init_array_entry+0x178>
   16352:	be 0e 00 00 00       	mov    $0xe,%esi
   16357:	ff 15 23 e8 03 00    	call   *0x3e823(%rip)        # 54b80 <_DYNAMIC+0x2a0>
   1635d:	e9 ab 00 00 00       	jmp    1640d <probe::main+0xa3d>
   16362:	bf 01 00 00 00       	mov    $0x1,%edi
   16367:	be 04 00 00 00       	mov    $0x4,%esi
   1636c:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
   16371:	4c 8b 74 24 40       	mov    0x40(%rsp),%r14
   16376:	ff 15 0c e8 03 00    	call   *0x3e80c(%rip)        # 54b88 <_DYNAMIC+0x2a8>
   1637c:	e9 8c 00 00 00       	jmp    1640d <probe::main+0xa3d>
   16381:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
   16386:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
   1638b:	e8 eb f0 ff ff       	call   1547b <core::panicking::assert_failed::<[u64; 2], [u64; 2]>>
   16390:	eb 7b                	jmp    1640d <probe::main+0xa3d>
   16392:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
   16397:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
   1639c:	e8 da f0 ff ff       	call   1547b <core::panicking::assert_failed::<[u64; 2], [u64; 2]>>
   163a1:	eb 6a                	jmp    1640d <probe::main+0xa3d>
   163a3:	48 89 e7             	mov    %rsp,%rdi
   163a6:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   163ab:	e9 47 ff ff ff       	jmp    162f7 <probe::main+0x927>
   163b0:	b0 01                	mov    $0x1,%al
   163b2:	e9 0a ff ff ff       	jmp    162c1 <probe::main+0x8f1>
   163b7:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
   163bc:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
   163c1:	eb 33                	jmp    163f6 <probe::main+0xa26>
   163c3:	31 c0                	xor    %eax,%eax
   163c5:	e9 fa fe ff ff       	jmp    162c4 <probe::main+0x8f4>
   163ca:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
   163cf:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   163d4:	e8 da f0 ff ff       	call   154b3 <core::panicking::assert_failed::<core::option::Option<&isize>, core::option::Option<&isize>>>
   163d9:	eb 32                	jmp    1640d <probe::main+0xa3d>
   163db:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
   163e0:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
   163e5:	e8 c9 f0 ff ff       	call   154b3 <core::panicking::assert_failed::<core::option::Option<&isize>, core::option::Option<&isize>>>
   163ea:	eb 21                	jmp    1640d <probe::main+0xa3d>
   163ec:	48 89 5c 24 58       	mov    %rbx,0x58(%rsp)
   163f1:	4c 8d 6c 24 20       	lea    0x20(%rsp),%r13
   163f6:	4c 89 ef             	mov    %r13,%rdi
   163f9:	48 8b 74 24 58       	mov    0x58(%rsp),%rsi
   163fe:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
   16403:	4c 8b 74 24 40       	mov    0x40(%rsp),%r14
   16408:	e8 a6 f0 ff ff       	call   154b3 <core::panicking::assert_failed::<core::option::Option<&isize>, core::option::Option<&isize>>>
   1640d:	0f 0b                	ud2
   1640f:	eb 29                	jmp    1643a <probe::main+0xa6a>
   16411:	49 89 c5             	mov    %rax,%r13
   16414:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
   16419:	4c 8b 74 24 40       	mov    0x40(%rsp),%r14
   1641e:	eb 3d                	jmp    1645d <probe::main+0xa8d>
   16420:	eb 00                	jmp    16422 <probe::main+0xa52>
   16422:	49 89 c5             	mov    %rax,%r13
   16425:	48 8b 34 24          	mov    (%rsp),%rsi
   16429:	48 85 f6             	test   %rsi,%rsi
   1642c:	74 2f                	je     1645d <probe::main+0xa8d>
   1642e:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
   16433:	ba 01 00 00 00       	mov    $0x1,%edx
   16438:	eb 1d                	jmp    16457 <probe::main+0xa87>
   1643a:	49 89 c5             	mov    %rax,%r13
   1643d:	eb 34                	jmp    16473 <probe::main+0xaa3>
   1643f:	49 89 c5             	mov    %rax,%r13
   16442:	eb 19                	jmp    1645d <probe::main+0xa8d>
   16444:	49 89 c5             	mov    %rax,%r13
   16447:	4d 85 ff             	test   %r15,%r15
   1644a:	74 11                	je     1645d <probe::main+0xa8d>
   1644c:	ba 01 00 00 00       	mov    $0x1,%edx
   16451:	4c 89 e7             	mov    %r12,%rdi
   16454:	4c 89 fe             	mov    %r15,%rsi
   16457:	ff 15 f3 e6 03 00    	call   *0x3e6f3(%rip)        # 54b50 <_DYNAMIC+0x270>
   1645d:	48 85 ed             	test   %rbp,%rbp
   16460:	74 11                	je     16473 <probe::main+0xaa3>
   16462:	ba 01 00 00 00       	mov    $0x1,%edx
   16467:	4c 89 f7             	mov    %r14,%rdi
   1646a:	48 89 ee             	mov    %rbp,%rsi
   1646d:	ff 15 dd e6 03 00    	call   *0x3e6dd(%rip)        # 54b50 <_DYNAMIC+0x270>
   16473:	4c 8b 74 24 68       	mov    0x68(%rsp),%r14
   16478:	48 8b 4c 24 78       	mov    0x78(%rsp),%rcx
   1647d:	48 89 c8             	mov    %rcx,%rax
   16480:	4c 29 f0             	sub    %r14,%rax
   16483:	48 ba ab aa aa aa aa 	movabs $0xaaaaaaaaaaaaaaab,%rdx
   1648a:	aa aa aa 
   1648d:	48 f7 e2             	mul    %rdx
   16490:	4c 39 f1             	cmp    %r14,%rcx
   16493:	75 2a                	jne    164bf <probe::main+0xaef>
   16495:	48 8b 44 24 70       	mov    0x70(%rsp),%rax
   1649a:	48 85 c0             	test   %rax,%rax
   1649d:	74 18                	je     164b7 <probe::main+0xae7>
   1649f:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
   164a4:	48 c1 e0 03          	shl    $0x3,%rax
   164a8:	48 8d 34 40          	lea    (%rax,%rax,2),%rsi
   164ac:	ba 08 00 00 00       	mov    $0x8,%edx
   164b1:	ff 15 99 e6 03 00    	call   *0x3e699(%rip)        # 54b50 <_DYNAMIC+0x270>
   164b7:	4c 89 ef             	mov    %r13,%rdi
   164ba:	e8 31 b7 03 00       	call   51bf0 <_Unwind_Resume@plt>
   164bf:	48 89 d3             	mov    %rdx,%rbx
   164c2:	48 c1 eb 04          	shr    $0x4,%rbx
   164c6:	49 83 c6 08          	add    $0x8,%r14
   164ca:	4c 8b 3d 7f e6 03 00 	mov    0x3e67f(%rip),%r15        # 54b50 <_DYNAMIC+0x270>
   164d1:	eb 16                	jmp    164e9 <probe::main+0xb19>
   164d3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   164da:	84 00 00 00 00 00 
   164e0:	49 83 c6 18          	add    $0x18,%r14
   164e4:	48 ff cb             	dec    %rbx
   164e7:	74 ac                	je     16495 <probe::main+0xac5>
   164e9:	49 8b 76 f8          	mov    -0x8(%r14),%rsi
   164ed:	48 85 f6             	test   %rsi,%rsi
   164f0:	74 ee                	je     164e0 <probe::main+0xb10>
   164f2:	49 8b 3e             	mov    (%r14),%rdi
   164f5:	ba 01 00 00 00       	mov    $0x1,%edx
   164fa:	41 ff d7             	call   *%r15
   164fd:	eb e1                	jmp    164e0 <probe::main+0xb10>
   164ff:	cc                   	int3

0000000000016500 <probe::pair>:
   16500:	48 85 ff             	test   %rdi,%rdi
   16503:	0f 84 82 00 00 00    	je     1658b <probe::pair+0x8b>
   16509:	55                   	push   %rbp
   1650a:	41 57                	push   %r15
   1650c:	41 56                	push   %r14
   1650e:	41 55                	push   %r13
   16510:	41 54                	push   %r12
   16512:	53                   	push   %rbx
   16513:	48 83 ec 28          	sub    $0x28,%rsp
   16517:	48 89 fb             	mov    %rdi,%rbx
   1651a:	4c 8d 3d 97 c7 03 00 	lea    0x3c797(%rip),%r15        # 52cb8 <__frame_dummy_init_array_entry+0x78>
   16521:	4c 8d 64 24 10       	lea    0x10(%rsp),%r12
   16526:	4c 8d 6c 24 08       	lea    0x8(%rsp),%r13
   1652b:	48 bd 8f 15 1f e2 19 	movabs $0x6e75a319e21f158f,%rbp
   16532:	a3 75 6e 
   16535:	49 be eb 68 de c5 b6 	movabs $0x9b3381b6c5de68eb,%r14
   1653c:	81 33 9b 
   1653f:	90                   	nop
   16540:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
   16547:	00 00 
   16549:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
   1654e:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
   16553:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
   16558:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
   1655d:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
   16562:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
   16567:	ff 50 18             	call   *0x18(%rax)
   1656a:	48 31 e8             	xor    %rbp,%rax
   1656d:	4c 31 f2             	xor    %r14,%rdx
   16570:	48 09 c2             	or     %rax,%rdx
   16573:	0f 94 44 24 08       	sete   0x8(%rsp)
   16578:	48 ff cb             	dec    %rbx
   1657b:	75 c3                	jne    16540 <probe::pair+0x40>
   1657d:	48 83 c4 28          	add    $0x28,%rsp
   16581:	5b                   	pop    %rbx
   16582:	41 5c                	pop    %r12
   16584:	41 5d                	pop    %r13
   16586:	41 5e                	pop    %r14
   16588:	41 5f                	pop    %r15
   1658a:	5d                   	pop    %rbp
   1658b:	c3                   	ret
   1658c:	cc                   	int3
   1658d:	cc                   	int3
   1658e:	cc                   	int3
   1658f:	cc                   	int3

0000000000016590 <probe::array>:
   16590:	48 85 ff             	test   %rdi,%rdi
   16593:	0f 84 8e 00 00 00    	je     16627 <probe::array+0x97>
   16599:	55                   	push   %rbp
   1659a:	41 57                	push   %r15
   1659c:	41 56                	push   %r14
   1659e:	41 55                	push   %r13
   165a0:	41 54                	push   %r12
   165a2:	53                   	push   %rbx
   165a3:	48 83 ec 38          	sub    $0x38,%rsp
   165a7:	48 89 fb             	mov    %rdi,%rbx
   165aa:	4c 8d 7c 24 18       	lea    0x18(%rsp),%r15
   165af:	4c 8d 25 e2 c6 03 00 	lea    0x3c6e2(%rip),%r12        # 52c98 <__frame_dummy_init_array_entry+0x58>
   165b6:	4c 8d 6c 24 08       	lea    0x8(%rsp),%r13
   165bb:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
   165c0:	48 8d 6c 24 07       	lea    0x7(%rsp),%rbp
   165c5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   165cc:	00 00 00 00 
   165d0:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
   165d7:	00 00 
   165d9:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
   165de:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
   165e3:	4c 89 6c 24 20       	mov    %r13,0x20(%rsp)
   165e8:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
   165ed:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
   165f2:	4c 89 f7             	mov    %r14,%rdi
   165f5:	ff 50 18             	call   *0x18(%rax)
   165f8:	66 0f 6f 44 24 20    	movdqa 0x20(%rsp),%xmm0
   165fe:	66 0f 74 05 fa ec fe 	pcmpeqb -0x11306(%rip),%xmm0        # 5300 <__abi_tag+0x4fcc>
   16605:	ff 
   16606:	66 0f d7 c0          	pmovmskb %xmm0,%eax
   1660a:	3d ff ff 00 00       	cmp    $0xffff,%eax
   1660f:	0f 94 44 24 07       	sete   0x7(%rsp)
   16614:	48 ff cb             	dec    %rbx
   16617:	75 b7                	jne    165d0 <probe::array+0x40>
   16619:	48 83 c4 38          	add    $0x38,%rsp
   1661d:	5b                   	pop    %rbx
   1661e:	41 5c                	pop    %r12
   16620:	41 5d                	pop    %r13
   16622:	41 5e                	pop    %r14
   16624:	41 5f                	pop    %r15
   16626:	5d                   	pop    %rbp
   16627:	c3                   	ret
   16628:	cc                   	int3
   16629:	cc                   	int3
   1662a:	cc                   	int3
   1662b:	cc                   	int3
   1662c:	cc                   	int3
   1662d:	cc                   	int3
   1662e:	cc                   	int3
   1662f:	cc                   	int3

0000000000016630 <probe::value>:
   16630:	48 85 ff             	test   %rdi,%rdi
   16633:	0f 84 a0 00 00 00    	je     166d9 <probe::value+0xa9>
   16639:	41 57                	push   %r15
   1663b:	41 56                	push   %r14
   1663d:	41 55                	push   %r13
   1663f:	41 54                	push   %r12
   16641:	53                   	push   %rbx
   16642:	48 83 ec 30          	sub    $0x30,%rsp
   16646:	48 89 fb             	mov    %rdi,%rbx
   16649:	4c 8d 7c 24 18       	lea    0x18(%rsp),%r15
   1664e:	4c 8d 25 23 c6 03 00 	lea    0x3c623(%rip),%r12        # 52c78 <__frame_dummy_init_array_entry+0x38>
   16655:	4c 8d 6c 24 08       	lea    0x8(%rsp),%r13
   1665a:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
   1665f:	eb 24                	jmp    16685 <probe::value+0x55>
   16661:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   16668:	0f 1f 84 00 00 00 00 
   1666f:	00 
   16670:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
   16675:	48 83 38 00          	cmpq   $0x0,(%rax)
   16679:	0f 94 c0             	sete   %al
   1667c:	88 44 24 20          	mov    %al,0x20(%rsp)
   16680:	48 ff cb             	dec    %rbx
   16683:	74 47                	je     166cc <probe::value+0x9c>
   16685:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
   1668c:	00 00 
   1668e:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
   16693:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
   16698:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
   1669d:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
   166a2:	4c 89 f7             	mov    %r14,%rdi
   166a5:	ff 50 18             	call   *0x18(%rax)
   166a8:	66 0f 6f 44 24 20    	movdqa 0x20(%rsp),%xmm0
   166ae:	66 0f 74 05 4a ec fe 	pcmpeqb -0x113b6(%rip),%xmm0        # 5300 <__abi_tag+0x4fcc>
   166b5:	ff 
   166b6:	66 0f d7 c0          	pmovmskb %xmm0,%eax
   166ba:	3d ff ff 00 00       	cmp    $0xffff,%eax
   166bf:	74 af                	je     16670 <probe::value+0x40>
   166c1:	31 c0                	xor    %eax,%eax
   166c3:	88 44 24 20          	mov    %al,0x20(%rsp)
   166c7:	48 ff cb             	dec    %rbx
   166ca:	75 b9                	jne    16685 <probe::value+0x55>
   166cc:	48 83 c4 30          	add    $0x30,%rsp
   166d0:	5b                   	pop    %rbx
   166d1:	41 5c                	pop    %r12
   166d3:	41 5d                	pop    %r13
   166d5:	41 5e                	pop    %r14
   166d7:	41 5f                	pop    %r15
   166d9:	c3                   	ret
   166da:	cc                   	int3
   166db:	cc                   	int3
   166dc:	cc                   	int3
   166dd:	cc                   	int3
   166de:	cc                   	int3
   166df:	cc                   	int3

00000000000166e0 <probe::boundary>:
   166e0:	48 85 ff             	test   %rdi,%rdi
   166e3:	0f 84 7c 00 00 00    	je     16765 <probe::boundary+0x85>
   166e9:	41 57                	push   %r15
   166eb:	41 56                	push   %r14
   166ed:	41 55                	push   %r13
   166ef:	41 54                	push   %r12
   166f1:	53                   	push   %rbx
   166f2:	48 83 ec 20          	sub    $0x20,%rsp
   166f6:	48 89 fb             	mov    %rdi,%rbx
   166f9:	4c 8d 74 24 18       	lea    0x18(%rsp),%r14
   166fe:	4c 8d 3d 73 c5 03 00 	lea    0x3c573(%rip),%r15        # 52c78 <__frame_dummy_init_array_entry+0x38>
   16705:	4c 8d 64 24 08       	lea    0x8(%rsp),%r12
   1670a:	49 89 e5             	mov    %rsp,%r13
   1670d:	eb 0b                	jmp    1671a <probe::boundary+0x3a>
   1670f:	90                   	nop
   16710:	31 c0                	xor    %eax,%eax
   16712:	88 04 24             	mov    %al,(%rsp)
   16715:	48 ff cb             	dec    %rbx
   16718:	74 3e                	je     16758 <probe::boundary+0x78>
   1671a:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
   16721:	00 00 
   16723:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
   16728:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
   1672d:	4c 89 24 24          	mov    %r12,(%rsp)
   16731:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
   16736:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
   1673b:	48 8b 70 18          	mov    0x18(%rax),%rsi
   1673f:	e8 2c 00 00 00       	call   16770 <probe::isolated>
   16744:	48 85 c0             	test   %rax,%rax
   16747:	74 c7                	je     16710 <probe::boundary+0x30>
   16749:	48 83 38 00          	cmpq   $0x0,(%rax)
   1674d:	0f 94 c0             	sete   %al
   16750:	88 04 24             	mov    %al,(%rsp)
   16753:	48 ff cb             	dec    %rbx
   16756:	75 c2                	jne    1671a <probe::boundary+0x3a>
   16758:	48 83 c4 20          	add    $0x20,%rsp
   1675c:	5b                   	pop    %rbx
   1675d:	41 5c                	pop    %r12
   1675f:	41 5d                	pop    %r13
   16761:	41 5e                	pop    %r14
   16763:	41 5f                	pop    %r15
   16765:	c3                   	ret
   16766:	cc                   	int3
   16767:	cc                   	int3
   16768:	cc                   	int3
   16769:	cc                   	int3
   1676a:	cc                   	int3
   1676b:	cc                   	int3
   1676c:	cc                   	int3
   1676d:	cc                   	int3
   1676e:	cc                   	int3
   1676f:	cc                   	int3

0000000000016770 <probe::isolated>:
   16770:	53                   	push   %rbx
   16771:	48 83 ec 10          	sub    $0x10,%rsp
   16775:	48 89 f0             	mov    %rsi,%rax
   16778:	48 89 fb             	mov    %rdi,%rbx
   1677b:	48 89 e7             	mov    %rsp,%rdi
   1677e:	48 89 de             	mov    %rbx,%rsi
   16781:	ff d0                	call   *%rax
   16783:	66 0f 6f 04 24       	movdqa (%rsp),%xmm0
   16788:	66 0f 74 05 70 eb fe 	pcmpeqb -0x11490(%rip),%xmm0        # 5300 <__abi_tag+0x4fcc>
   1678f:	ff 
   16790:	66 0f d7 c8          	pmovmskb %xmm0,%ecx
   16794:	31 c0                	xor    %eax,%eax
   16796:	81 f9 ff ff 00 00    	cmp    $0xffff,%ecx
   1679c:	48 0f 44 c3          	cmove  %rbx,%rax
   167a0:	48 83 c4 10          	add    $0x10,%rsp
   167a4:	5b                   	pop    %rbx
   167a5:	c3                   	ret
   167a6:	cc                   	int3
   167a7:	cc                   	int3
   167a8:	cc                   	int3
   167a9:	cc                   	int3
   167aa:	cc                   	int3
   167ab:	cc                   	int3
   167ac:	cc                   	int3
   167ad:	cc                   	int3
   167ae:	cc                   	int3
   167af:	cc                   	int3

00000000000167b0 <probe::repeated>:
   167b0:	48 85 ff             	test   %rdi,%rdi
   167b3:	0f 84 84 00 00 00    	je     1683d <probe::repeated+0x8d>
   167b9:	41 57                	push   %r15
   167bb:	41 56                	push   %r14
   167bd:	41 55                	push   %r13
   167bf:	41 54                	push   %r12
   167c1:	53                   	push   %rbx
   167c2:	48 83 ec 20          	sub    $0x20,%rsp
   167c6:	48 89 d3             	mov    %rdx,%rbx
   167c9:	49 89 f6             	mov    %rsi,%r14
   167cc:	49 89 ff             	mov    %rdi,%r15
   167cf:	49 89 e5             	mov    %rsp,%r13
   167d2:	4c 8d 64 24 10       	lea    0x10(%rsp),%r12
   167d7:	eb 1b                	jmp    167f4 <probe::repeated+0x44>
   167d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
   167e0:	48 8b 04 24          	mov    (%rsp),%rax
   167e4:	48 83 38 00          	cmpq   $0x0,(%rax)
   167e8:	0f 94 c0             	sete   %al
   167eb:	88 44 24 10          	mov    %al,0x10(%rsp)
   167ef:	49 ff cf             	dec    %r15
   167f2:	74 3c                	je     16830 <probe::repeated+0x80>
   167f4:	4c 89 34 24          	mov    %r14,(%rsp)
   167f8:	48 89 5c 24 08       	mov    %rbx,0x8(%rsp)
   167fd:	48 8b 34 24          	mov    (%rsp),%rsi
   16801:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
   16806:	4c 89 e7             	mov    %r12,%rdi
   16809:	ff 50 18             	call   *0x18(%rax)
   1680c:	66 0f 6f 44 24 10    	movdqa 0x10(%rsp),%xmm0
   16812:	66 0f 74 05 e6 ea fe 	pcmpeqb -0x1151a(%rip),%xmm0        # 5300 <__abi_tag+0x4fcc>
   16819:	ff 
   1681a:	66 0f d7 c0          	pmovmskb %xmm0,%eax
   1681e:	3d ff ff 00 00       	cmp    $0xffff,%eax
   16823:	74 bb                	je     167e0 <probe::repeated+0x30>
   16825:	31 c0                	xor    %eax,%eax
   16827:	88 44 24 10          	mov    %al,0x10(%rsp)
   1682b:	49 ff cf             	dec    %r15
   1682e:	75 c4                	jne    167f4 <probe::repeated+0x44>
   16830:	48 83 c4 20          	add    $0x20,%rsp
   16834:	5b                   	pop    %rbx
   16835:	41 5c                	pop    %r12
   16837:	41 5d                	pop    %r13
   16839:	41 5e                	pop    %r14
   1683b:	41 5f                	pop    %r15
   1683d:	c3                   	ret
   1683e:	cc                   	int3
   1683f:	cc                   	int3

