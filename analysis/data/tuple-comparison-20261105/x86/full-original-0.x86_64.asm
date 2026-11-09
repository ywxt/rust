
/tmp/tuple-comparison-20261105/harness-fullflags:     file format elf64-x86-64


Disassembly of section .text:

000000000001de60 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBR_>:
   1de60:	55                   	push   %rbp
   1de61:	41 57                	push   %r15
   1de63:	41 56                	push   %r14
   1de65:	41 55                	push   %r13
   1de67:	41 54                	push   %r12
   1de69:	53                   	push   %rbx
   1de6a:	48 83 ec 18          	sub    $0x18,%rsp
   1de6e:	48 89 d3             	mov    %rdx,%rbx
   1de71:	49 89 f6             	mov    %rsi,%r14
   1de74:	49 89 ff             	mov    %rdi,%r15
   1de77:	ff 15 b3 93 04 00    	call   *0x493b3(%rip)        # 67230 <_RNvMNtCs9wefJfwQbYy_3std4timeNtB2_7Instant3now@Base>
   1de7d:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   1de82:	89 54 24 10          	mov    %edx,0x10(%rsp)
   1de86:	48 85 db             	test   %rbx,%rbx
   1de89:	75 77                	jne    1df02 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBR_+0xa2>
   1de8b:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
   1de90:	ff 15 a2 93 04 00    	call   *0x493a2(%rip)        # 67238 <_RNvMNtCs9wefJfwQbYy_3std4timeNtB2_7Instant7elapsed@Base>
   1de96:	48 69 c8 00 ca 9a 3b 	imul   $0x3b9aca00,%rax,%rcx
   1de9d:	89 d0                	mov    %edx,%eax
   1de9f:	48 01 c8             	add    %rcx,%rax
   1dea2:	48 83 c4 18          	add    $0x18,%rsp
   1dea6:	5b                   	pop    %rbx
   1dea7:	41 5c                	pop    %r12
   1dea9:	41 5d                	pop    %r13
   1deab:	41 5e                	pop    %r14
   1dead:	41 5f                	pop    %r15
   1deaf:	5d                   	pop    %rbp
   1deb0:	c3                   	ret
   1deb1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
   1deb8:	0f 1f 84 00 00 00 00 
   1debf:	00 
   1dec0:	4b 8d 0c e7          	lea    (%r15,%r12,8),%rcx
   1dec4:	48 8b 55 10          	mov    0x10(%rbp),%rdx
   1dec8:	31 c0                	xor    %eax,%eax
   1deca:	48 3b 51 10          	cmp    0x10(%rcx),%rdx
   1dece:	0f 96 c1             	setbe  %cl
   1ded1:	0f 92 c0             	setb   %al
   1ded4:	0f 97 c2             	seta   %dl
   1ded7:	40 0f 93 c6          	setae  %sil
   1dedb:	40 0f b6 f6          	movzbl %sil,%esi
   1dedf:	c1 e6 18             	shl    $0x18,%esi
   1dee2:	0f b6 d2             	movzbl %dl,%edx
   1dee5:	c1 e2 10             	shl    $0x10,%edx
   1dee8:	09 c2                	or     %eax,%edx
   1deea:	0f b6 c1             	movzbl %cl,%eax
   1deed:	c1 e0 08             	shl    $0x8,%eax
   1def0:	09 d0                	or     %edx,%eax
   1def2:	09 f0                	or     %esi,%eax
   1def4:	89 44 24 04          	mov    %eax,0x4(%rsp)
   1def8:	48 8d 44 24 04       	lea    0x4(%rsp),%rax
   1defd:	48 ff cb             	dec    %rbx
   1df00:	74 89                	je     1de8b <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBR_+0x2b>
   1df02:	41 8b 06             	mov    (%r14),%eax
   1df05:	45 8b 46 04          	mov    0x4(%r14),%r8d
   1df09:	89 c1                	mov    %eax,%ecx
   1df0b:	c1 e1 0b             	shl    $0xb,%ecx
   1df0e:	31 c1                	xor    %eax,%ecx
   1df10:	41 8b 76 08          	mov    0x8(%r14),%esi
   1df14:	41 8b 56 0c          	mov    0xc(%r14),%edx
   1df18:	89 d0                	mov    %edx,%eax
   1df1a:	c1 e8 13             	shr    $0x13,%eax
   1df1d:	31 c8                	xor    %ecx,%eax
   1df1f:	c1 e9 08             	shr    $0x8,%ecx
   1df22:	31 c1                	xor    %eax,%ecx
   1df24:	31 d1                	xor    %edx,%ecx
   1df26:	48 8d 04 09          	lea    (%rcx,%rcx,1),%rax
   1df2a:	4c 8d 0c 40          	lea    (%rax,%rax,2),%r9
   1df2e:	4c 89 c8             	mov    %r9,%rax
   1df31:	48 c1 e8 20          	shr    $0x20,%rax
   1df35:	41 83 f9 fb          	cmp    $0xfffffffb,%r9d
   1df39:	72 55                	jb     1df90 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBR_+0x130>
   1df3b:	45 89 c2             	mov    %r8d,%r10d
   1df3e:	41 c1 e2 0b          	shl    $0xb,%r10d
   1df42:	45 31 c2             	xor    %r8d,%r10d
   1df45:	41 89 36             	mov    %esi,(%r14)
   1df48:	41 89 56 04          	mov    %edx,0x4(%r14)
   1df4c:	41 89 4e 08          	mov    %ecx,0x8(%r14)
   1df50:	41 89 c8             	mov    %ecx,%r8d
   1df53:	41 c1 e8 13          	shr    $0x13,%r8d
   1df57:	44 89 d7             	mov    %r10d,%edi
   1df5a:	c1 ef 08             	shr    $0x8,%edi
   1df5d:	44 31 d7             	xor    %r10d,%edi
   1df60:	31 cf                	xor    %ecx,%edi
   1df62:	44 31 c7             	xor    %r8d,%edi
   1df65:	41 89 7e 0c          	mov    %edi,0xc(%r14)
   1df69:	4c 8d 04 3f          	lea    (%rdi,%rdi,1),%r8
   1df6d:	4f 8d 04 40          	lea    (%r8,%r8,2),%r8
   1df71:	49 c1 e8 20          	shr    $0x20,%r8
   1df75:	45 01 c1             	add    %r8d,%r9d
   1df78:	48 83 d0 00          	adc    $0x0,%rax
   1df7c:	48 83 f8 06          	cmp    $0x6,%rax
   1df80:	72 17                	jb     1df99 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBR_+0x139>
   1df82:	e9 f0 00 00 00       	jmp    1e077 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBR_+0x217>
   1df87:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   1df8e:	00 00 
   1df90:	89 cf                	mov    %ecx,%edi
   1df92:	89 d1                	mov    %edx,%ecx
   1df94:	89 f2                	mov    %esi,%edx
   1df96:	44 89 c6             	mov    %r8d,%esi
   1df99:	41 89 f1             	mov    %esi,%r9d
   1df9c:	41 c1 e1 0b          	shl    $0xb,%r9d
   1dfa0:	41 31 f1             	xor    %esi,%r9d
   1dfa3:	41 89 16             	mov    %edx,(%r14)
   1dfa6:	41 89 4e 04          	mov    %ecx,0x4(%r14)
   1dfaa:	41 89 7e 08          	mov    %edi,0x8(%r14)
   1dfae:	89 fe                	mov    %edi,%esi
   1dfb0:	c1 ee 13             	shr    $0x13,%esi
   1dfb3:	45 89 c8             	mov    %r9d,%r8d
   1dfb6:	41 c1 e8 08          	shr    $0x8,%r8d
   1dfba:	41 31 f8             	xor    %edi,%r8d
   1dfbd:	41 31 f0             	xor    %esi,%r8d
   1dfc0:	45 31 c8             	xor    %r9d,%r8d
   1dfc3:	45 89 46 0c          	mov    %r8d,0xc(%r14)
   1dfc7:	4b 8d 34 00          	lea    (%r8,%r8,1),%rsi
   1dfcb:	4c 8d 0c 76          	lea    (%rsi,%rsi,2),%r9
   1dfcf:	4c 89 ce             	mov    %r9,%rsi
   1dfd2:	48 c1 ee 20          	shr    $0x20,%rsi
   1dfd6:	41 83 f9 fb          	cmp    $0xfffffffb,%r9d
   1dfda:	72 44                	jb     1e020 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBR_+0x1c0>
   1dfdc:	41 89 d2             	mov    %edx,%r10d
   1dfdf:	41 c1 e2 0b          	shl    $0xb,%r10d
   1dfe3:	41 31 d2             	xor    %edx,%r10d
   1dfe6:	41 89 0e             	mov    %ecx,(%r14)
   1dfe9:	41 89 7e 04          	mov    %edi,0x4(%r14)
   1dfed:	45 89 46 08          	mov    %r8d,0x8(%r14)
   1dff1:	44 89 d1             	mov    %r10d,%ecx
   1dff4:	c1 e9 08             	shr    $0x8,%ecx
   1dff7:	44 31 d1             	xor    %r10d,%ecx
   1dffa:	44 31 c1             	xor    %r8d,%ecx
   1dffd:	41 c1 e8 13          	shr    $0x13,%r8d
   1e001:	41 31 c8             	xor    %ecx,%r8d
   1e004:	45 89 46 0c          	mov    %r8d,0xc(%r14)
   1e008:	4d 01 c0             	add    %r8,%r8
   1e00b:	4b 8d 0c 40          	lea    (%r8,%r8,2),%rcx
   1e00f:	48 c1 e9 20          	shr    $0x20,%rcx
   1e013:	41 01 c9             	add    %ecx,%r9d
   1e016:	48 83 d6 00          	adc    $0x0,%rsi
   1e01a:	48 83 fe 06          	cmp    $0x6,%rsi
   1e01e:	73 57                	jae    1e077 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBR_+0x217>
   1e020:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
   1e024:	49 8d 2c c7          	lea    (%r15,%rax,8),%rbp
   1e028:	4c 8d 24 76          	lea    (%rsi,%rsi,2),%r12
   1e02c:	48 8b 7d 00          	mov    0x0(%rbp),%rdi
   1e030:	48 8b 45 08          	mov    0x8(%rbp),%rax
   1e034:	4b 8b 34 e7          	mov    (%r15,%r12,8),%rsi
   1e038:	4b 8b 54 e7 08       	mov    0x8(%r15,%r12,8),%rdx
   1e03d:	49 89 c5             	mov    %rax,%r13
   1e040:	49 29 d5             	sub    %rdx,%r13
   1e043:	48 0f 42 d0          	cmovb  %rax,%rdx
   1e047:	ff 15 f3 91 04 00    	call   *0x491f3(%rip)        # 67240 <memcmp@GLIBC_2.2.5>
   1e04d:	48 98                	cltq
   1e04f:	85 c0                	test   %eax,%eax
   1e051:	4c 0f 45 e8          	cmovne %rax,%r13
   1e055:	4d 85 ed             	test   %r13,%r13
   1e058:	0f 84 62 fe ff ff    	je     1dec0 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBR_+0x60>
   1e05e:	4c 89 e8             	mov    %r13,%rax
   1e061:	48 c1 e8 3f          	shr    $0x3f,%rax
   1e065:	4d 85 ed             	test   %r13,%r13
   1e068:	0f 9e c1             	setle  %cl
   1e06b:	0f 9f c2             	setg   %dl
   1e06e:	40 0f 99 c6          	setns  %sil
   1e072:	e9 64 fe ff ff       	jmp    1dedb <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBR_+0x7b>
   1e077:	48 8d 15 4a 3d 04 00 	lea    0x43d4a(%rip),%rdx        # 61dc8 <__frame_dummy_init_array_entry+0x50>
   1e07e:	bf 06 00 00 00       	mov    $0x6,%edi
   1e083:	be 06 00 00 00       	mov    $0x6,%esi
   1e088:	ff 15 ba 91 04 00    	call   *0x491ba(%rip)        # 67248 <_RNvNtCs6knCYbIatyh_4core9panicking18panic_bounds_check@Base>

Disassembly of section .init:

Disassembly of section .fini:

Disassembly of section .plt:
