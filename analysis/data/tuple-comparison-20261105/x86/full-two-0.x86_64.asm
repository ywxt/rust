
/tmp/tuple-comparison-20261105/harness-fullflags:     file format elf64-x86-64


Disassembly of section .text:

000000000001e090 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_9bench_two0EBR_>:
   1e090:	55                   	push   %rbp
   1e091:	41 57                	push   %r15
   1e093:	41 56                	push   %r14
   1e095:	41 55                	push   %r13
   1e097:	41 54                	push   %r12
   1e099:	53                   	push   %rbx
   1e09a:	48 83 ec 18          	sub    $0x18,%rsp
   1e09e:	48 89 d3             	mov    %rdx,%rbx
   1e0a1:	49 89 f6             	mov    %rsi,%r14
   1e0a4:	49 89 ff             	mov    %rdi,%r15
   1e0a7:	ff 15 83 91 04 00    	call   *0x49183(%rip)        # 67230 <_RNvMNtCs9wefJfwQbYy_3std4timeNtB2_7Instant3now@Base>
   1e0ad:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
   1e0b2:	89 54 24 10          	mov    %edx,0x10(%rsp)
   1e0b6:	48 85 db             	test   %rbx,%rbx
   1e0b9:	0f 85 c3 00 00 00    	jne    1e182 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_9bench_two0EBR_+0xf2>
   1e0bf:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
   1e0c4:	ff 15 6e 91 04 00    	call   *0x4916e(%rip)        # 67238 <_RNvMNtCs9wefJfwQbYy_3std4timeNtB2_7Instant7elapsed@Base>
   1e0ca:	48 69 c8 00 ca 9a 3b 	imul   $0x3b9aca00,%rax,%rcx
   1e0d1:	89 d0                	mov    %edx,%eax
   1e0d3:	48 01 c8             	add    %rcx,%rax
   1e0d6:	48 83 c4 18          	add    $0x18,%rsp
   1e0da:	5b                   	pop    %rbx
   1e0db:	41 5c                	pop    %r12
   1e0dd:	41 5d                	pop    %r13
   1e0df:	41 5e                	pop    %r14
   1e0e1:	41 5f                	pop    %r15
   1e0e3:	5d                   	pop    %rbp
   1e0e4:	c3                   	ret
   1e0e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   1e0ec:	00 00 00 00 
   1e0f0:	48 8d 2c 40          	lea    (%rax,%rax,2),%rbp
   1e0f4:	4c 8d 24 76          	lea    (%rsi,%rsi,2),%r12
   1e0f8:	49 8b 3c ef          	mov    (%r15,%rbp,8),%rdi
   1e0fc:	49 8b 44 ef 08       	mov    0x8(%r15,%rbp,8),%rax
   1e101:	4b 8b 34 e7          	mov    (%r15,%r12,8),%rsi
   1e105:	4b 8b 54 e7 08       	mov    0x8(%r15,%r12,8),%rdx
   1e10a:	49 89 c5             	mov    %rax,%r13
   1e10d:	49 29 d5             	sub    %rdx,%r13
   1e110:	48 0f 42 d0          	cmovb  %rax,%rdx
   1e114:	ff 15 26 91 04 00    	call   *0x49126(%rip)        # 67240 <memcmp@GLIBC_2.2.5>
   1e11a:	48 98                	cltq
   1e11c:	85 c0                	test   %eax,%eax
   1e11e:	4c 0f 45 e8          	cmovne %rax,%r13
   1e122:	4c 89 e8             	mov    %r13,%rax
   1e125:	48 c1 e8 3f          	shr    $0x3f,%rax
   1e129:	49 8b 4c ef 10       	mov    0x10(%r15,%rbp,8),%rcx
   1e12e:	31 d2                	xor    %edx,%edx
   1e130:	31 f6                	xor    %esi,%esi
   1e132:	4b 3b 4c e7 10       	cmp    0x10(%r15,%r12,8),%rcx
   1e137:	0f 92 c2             	setb   %dl
   1e13a:	40 0f 97 c6          	seta   %sil
   1e13e:	31 c9                	xor    %ecx,%ecx
   1e140:	4d 85 ed             	test   %r13,%r13
   1e143:	0f 45 d0             	cmovne %eax,%edx
   1e146:	0f 9f c1             	setg   %cl
   1e149:	0f 45 f1             	cmovne %ecx,%esi
   1e14c:	0f b6 c2             	movzbl %dl,%eax
   1e14f:	80 f2 01             	xor    $0x1,%dl
   1e152:	0f b6 ca             	movzbl %dl,%ecx
   1e155:	c1 e1 18             	shl    $0x18,%ecx
   1e158:	40 0f b6 d6          	movzbl %sil,%edx
   1e15c:	89 d6                	mov    %edx,%esi
   1e15e:	c1 e6 10             	shl    $0x10,%esi
   1e161:	09 ce                	or     %ecx,%esi
   1e163:	80 f2 01             	xor    $0x1,%dl
   1e166:	0f b6 ca             	movzbl %dl,%ecx
   1e169:	c1 e1 08             	shl    $0x8,%ecx
   1e16c:	09 f1                	or     %esi,%ecx
   1e16e:	09 c1                	or     %eax,%ecx
   1e170:	89 4c 24 04          	mov    %ecx,0x4(%rsp)
   1e174:	48 8d 44 24 04       	lea    0x4(%rsp),%rax
   1e179:	48 ff cb             	dec    %rbx
   1e17c:	0f 84 3d ff ff ff    	je     1e0bf <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_9bench_two0EBR_+0x2f>
   1e182:	41 8b 06             	mov    (%r14),%eax
   1e185:	45 8b 46 04          	mov    0x4(%r14),%r8d
   1e189:	89 c1                	mov    %eax,%ecx
   1e18b:	c1 e1 0b             	shl    $0xb,%ecx
   1e18e:	31 c1                	xor    %eax,%ecx
   1e190:	41 8b 76 08          	mov    0x8(%r14),%esi
   1e194:	41 8b 56 0c          	mov    0xc(%r14),%edx
   1e198:	89 d0                	mov    %edx,%eax
   1e19a:	c1 e8 13             	shr    $0x13,%eax
   1e19d:	31 c8                	xor    %ecx,%eax
   1e19f:	c1 e9 08             	shr    $0x8,%ecx
   1e1a2:	31 c1                	xor    %eax,%ecx
   1e1a4:	31 d1                	xor    %edx,%ecx
   1e1a6:	48 8d 04 09          	lea    (%rcx,%rcx,1),%rax
   1e1aa:	4c 8d 0c 40          	lea    (%rax,%rax,2),%r9
   1e1ae:	4c 89 c8             	mov    %r9,%rax
   1e1b1:	48 c1 e8 20          	shr    $0x20,%rax
   1e1b5:	41 83 f9 fb          	cmp    $0xfffffffb,%r9d
   1e1b9:	72 55                	jb     1e210 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_9bench_two0EBR_+0x180>
   1e1bb:	45 89 c2             	mov    %r8d,%r10d
   1e1be:	41 c1 e2 0b          	shl    $0xb,%r10d
   1e1c2:	45 31 c2             	xor    %r8d,%r10d
   1e1c5:	41 89 36             	mov    %esi,(%r14)
   1e1c8:	41 89 56 04          	mov    %edx,0x4(%r14)
   1e1cc:	41 89 4e 08          	mov    %ecx,0x8(%r14)
   1e1d0:	41 89 c8             	mov    %ecx,%r8d
   1e1d3:	41 c1 e8 13          	shr    $0x13,%r8d
   1e1d7:	44 89 d7             	mov    %r10d,%edi
   1e1da:	c1 ef 08             	shr    $0x8,%edi
   1e1dd:	44 31 d7             	xor    %r10d,%edi
   1e1e0:	31 cf                	xor    %ecx,%edi
   1e1e2:	44 31 c7             	xor    %r8d,%edi
   1e1e5:	41 89 7e 0c          	mov    %edi,0xc(%r14)
   1e1e9:	4c 8d 04 3f          	lea    (%rdi,%rdi,1),%r8
   1e1ed:	4f 8d 04 40          	lea    (%r8,%r8,2),%r8
   1e1f1:	49 c1 e8 20          	shr    $0x20,%r8
   1e1f5:	45 01 c1             	add    %r8d,%r9d
   1e1f8:	48 83 d0 00          	adc    $0x0,%rax
   1e1fc:	48 83 f8 06          	cmp    $0x6,%rax
   1e200:	72 17                	jb     1e219 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_9bench_two0EBR_+0x189>
   1e202:	e9 a1 00 00 00       	jmp    1e2a8 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_9bench_two0EBR_+0x218>
   1e207:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
   1e20e:	00 00 
   1e210:	89 cf                	mov    %ecx,%edi
   1e212:	89 d1                	mov    %edx,%ecx
   1e214:	89 f2                	mov    %esi,%edx
   1e216:	44 89 c6             	mov    %r8d,%esi
   1e219:	41 89 f1             	mov    %esi,%r9d
   1e21c:	41 c1 e1 0b          	shl    $0xb,%r9d
   1e220:	41 31 f1             	xor    %esi,%r9d
   1e223:	41 89 16             	mov    %edx,(%r14)
   1e226:	41 89 4e 04          	mov    %ecx,0x4(%r14)
   1e22a:	41 89 7e 08          	mov    %edi,0x8(%r14)
   1e22e:	89 fe                	mov    %edi,%esi
   1e230:	c1 ee 13             	shr    $0x13,%esi
   1e233:	45 89 c8             	mov    %r9d,%r8d
   1e236:	41 c1 e8 08          	shr    $0x8,%r8d
   1e23a:	41 31 f8             	xor    %edi,%r8d
   1e23d:	41 31 f0             	xor    %esi,%r8d
   1e240:	45 31 c8             	xor    %r9d,%r8d
   1e243:	45 89 46 0c          	mov    %r8d,0xc(%r14)
   1e247:	4b 8d 34 00          	lea    (%r8,%r8,1),%rsi
   1e24b:	4c 8d 0c 76          	lea    (%rsi,%rsi,2),%r9
   1e24f:	4c 89 ce             	mov    %r9,%rsi
   1e252:	48 c1 ee 20          	shr    $0x20,%rsi
   1e256:	41 83 f9 fb          	cmp    $0xfffffffb,%r9d
   1e25a:	0f 82 90 fe ff ff    	jb     1e0f0 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_9bench_two0EBR_+0x60>
   1e260:	41 89 d2             	mov    %edx,%r10d
   1e263:	41 c1 e2 0b          	shl    $0xb,%r10d
   1e267:	41 31 d2             	xor    %edx,%r10d
   1e26a:	41 89 0e             	mov    %ecx,(%r14)
   1e26d:	41 89 7e 04          	mov    %edi,0x4(%r14)
   1e271:	45 89 46 08          	mov    %r8d,0x8(%r14)
   1e275:	44 89 d1             	mov    %r10d,%ecx
   1e278:	c1 e9 08             	shr    $0x8,%ecx
   1e27b:	44 31 d1             	xor    %r10d,%ecx
   1e27e:	44 31 c1             	xor    %r8d,%ecx
   1e281:	41 c1 e8 13          	shr    $0x13,%r8d
   1e285:	41 31 c8             	xor    %ecx,%r8d
   1e288:	45 89 46 0c          	mov    %r8d,0xc(%r14)
   1e28c:	4d 01 c0             	add    %r8,%r8
   1e28f:	4b 8d 0c 40          	lea    (%r8,%r8,2),%rcx
   1e293:	48 c1 e9 20          	shr    $0x20,%rcx
   1e297:	41 01 c9             	add    %ecx,%r9d
   1e29a:	48 83 d6 00          	adc    $0x0,%rsi
   1e29e:	48 83 fe 06          	cmp    $0x6,%rsi
   1e2a2:	0f 82 48 fe ff ff    	jb     1e0f0 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_9bench_two0EBR_+0x60>
   1e2a8:	48 8d 15 19 3b 04 00 	lea    0x43b19(%rip),%rdx        # 61dc8 <__frame_dummy_init_array_entry+0x50>
   1e2af:	bf 06 00 00 00       	mov    $0x6,%edi
   1e2b4:	be 06 00 00 00       	mov    $0x6,%esi
   1e2b9:	ff 15 89 8f 04 00    	call   *0x48f89(%rip)        # 67248 <_RNvNtCs6knCYbIatyh_4core9panicking18panic_bounds_check@Base>

Disassembly of section .init:

Disassembly of section .fini:

Disassembly of section .plt:
