
/tmp/contains-portable-simd-20261105/sysroots/baseline/lib/rustlib/x86_64-unknown-linux-gnu/lib/libstd-320fe7036dd8354d.so:	file format elf64-x86-64

Disassembly of section .text:

00000000001144b0 <_RNvNtNtCsc9NCSoc2doQ_4core3str7pattern18contains_byte_simd>:
  1144b0: 55                           	pushq	%rbp
  1144b1: 48 89 e5                     	movq	%rsp, %rbp
  1144b4: 48 85 f6                     	testq	%rsi, %rsi
  1144b7: 0f 84 51 01 00 00            	je	0x11460e <_RNvNtNtCsc9NCSoc2doQ_4core3str7pattern18contains_byte_simd+0x15e>
  1144bd: b0 01                        	movb	$0x1, %al
  1144bf: 38 17                        	cmpb	%dl, (%rdi)
  1144c1: 75 02                        	jne	0x1144c5 <_RNvNtNtCsc9NCSoc2doQ_4core3str7pattern18contains_byte_simd+0x15>
  1144c3: 5d                           	popq	%rbp
  1144c4: c3                           	retq
  1144c5: 0f b6 d2                     	movzbl	%dl, %edx
  1144c8: 48 81 fe 80 00 00 00         	cmpq	$0x80, %rsi
  1144cf: 72 5a                        	jb	0x11452b <_RNvNtNtCsc9NCSoc2doQ_4core3str7pattern18contains_byte_simd+0x7b>
  1144d1: 48 8d 4f 3f                  	leaq	0x3f(%rdi), %rcx
  1144d5: 48 83 e1 c0                  	andq	$-0x40, %rcx
  1144d9: 48 29 f9                     	subq	%rdi, %rcx
  1144dc: 74 4d                        	je	0x11452b <_RNvNtNtCsc9NCSoc2doQ_4core3str7pattern18contains_byte_simd+0x7b>
  1144de: 66 0f 6e c2                  	movd	%edx, %xmm0
  1144e2: 66 0f 60 c0                  	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
  1144e6: f2 0f 70 c0 00               	pshuflw	$0x0, %xmm0, %xmm0      # xmm0 = xmm0[0,0,0,0,4,5,6,7]
  1144eb: 66 0f 70 c0 44               	pshufd	$0x44, %xmm0, %xmm0     # xmm0 = xmm0[0,1,0,1]
  1144f0: f3 0f 6f 0f                  	movdqu	(%rdi), %xmm1
  1144f4: f3 0f 6f 57 10               	movdqu	0x10(%rdi), %xmm2
  1144f9: f3 0f 6f 5f 20               	movdqu	0x20(%rdi), %xmm3
  1144fe: f3 0f 6f 67 30               	movdqu	0x30(%rdi), %xmm4
  114503: 66 0f 74 c8                  	pcmpeqb	%xmm0, %xmm1
  114507: 66 0f 74 d0                  	pcmpeqb	%xmm0, %xmm2
  11450b: 66 0f eb d1                  	por	%xmm1, %xmm2
  11450f: 66 0f 74 d8                  	pcmpeqb	%xmm0, %xmm3
  114513: 66 0f 74 e0                  	pcmpeqb	%xmm0, %xmm4
  114517: 66 0f eb e3                  	por	%xmm3, %xmm4
  11451b: 66 0f eb e2                  	por	%xmm2, %xmm4
  11451f: 66 44 0f d7 c4               	pmovmskb	%xmm4, %r8d
  114524: 45 85 c0                     	testl	%r8d, %r8d
  114527: 75 9a                        	jne	0x1144c3 <_RNvNtNtCsc9NCSoc2doQ_4core3str7pattern18contains_byte_simd+0x13>
  114529: eb 02                        	jmp	0x11452d <_RNvNtNtCsc9NCSoc2doQ_4core3str7pattern18contains_byte_simd+0x7d>
  11452b: 31 c9                        	xorl	%ecx, %ecx
  11452d: 49 89 f0                     	movq	%rsi, %r8
  114530: 49 29 c8                     	subq	%rcx, %r8
  114533: 49 b9 c0 ff ff ff ff ff ff 7f	movabsq	$0x7fffffffffffffc0, %r9 # imm = 0x7FFFFFFFFFFFFFC0
  11453d: 66 0f 6e c2                  	movd	%edx, %xmm0
  114541: 66 0f 60 c0                  	punpcklbw	%xmm0, %xmm0    # xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
  114545: f2 0f 70 c0 00               	pshuflw	$0x0, %xmm0, %xmm0      # xmm0 = xmm0[0,0,0,0,4,5,6,7]
  11454a: 66 0f 70 c0 44               	pshufd	$0x44, %xmm0, %xmm0     # xmm0 = xmm0[0,1,0,1]
  11454f: 4d 21 c1                     	andq	%r8, %r9
  114552: 74 56                        	je	0x1145aa <_RNvNtNtCsc9NCSoc2doQ_4core3str7pattern18contains_byte_simd+0xfa>
  114554: 48 01 f9                     	addq	%rdi, %rcx
  114557: 31 d2                        	xorl	%edx, %edx
  114559: 0f 1f 80 00 00 00 00         	nopl	(%rax)
  114560: f3 0f 6f 0c 11               	movdqu	(%rcx,%rdx), %xmm1
  114565: f3 0f 6f 54 11 10            	movdqu	0x10(%rcx,%rdx), %xmm2
  11456b: f3 0f 6f 5c 11 20            	movdqu	0x20(%rcx,%rdx), %xmm3
  114571: f3 0f 6f 64 11 30            	movdqu	0x30(%rcx,%rdx), %xmm4
  114577: 66 0f 74 c8                  	pcmpeqb	%xmm0, %xmm1
  11457b: 66 0f 74 d0                  	pcmpeqb	%xmm0, %xmm2
  11457f: 66 0f eb d1                  	por	%xmm1, %xmm2
  114583: 66 0f 74 d8                  	pcmpeqb	%xmm0, %xmm3
  114587: 66 0f 74 e0                  	pcmpeqb	%xmm0, %xmm4
  11458b: 66 0f eb e3                  	por	%xmm3, %xmm4
  11458f: 66 0f eb e2                  	por	%xmm2, %xmm4
  114593: 66 44 0f d7 d4               	pmovmskb	%xmm4, %r10d
  114598: 45 85 d2                     	testl	%r10d, %r10d
  11459b: 0f 85 22 ff ff ff            	jne	0x1144c3 <_RNvNtNtCsc9NCSoc2doQ_4core3str7pattern18contains_byte_simd+0x13>
  1145a1: 48 83 c2 40                  	addq	$0x40, %rdx
  1145a5: 49 39 d1                     	cmpq	%rdx, %r9
  1145a8: 75 b6                        	jne	0x114560 <_RNvNtNtCsc9NCSoc2doQ_4core3str7pattern18contains_byte_simd+0xb0>
  1145aa: 41 f6 c0 3f                  	testb	$0x3f, %r8b
  1145ae: 74 47                        	je	0x1145f7 <_RNvNtNtCsc9NCSoc2doQ_4core3str7pattern18contains_byte_simd+0x147>
  1145b0: 48 89 f0                     	movq	%rsi, %rax
  1145b3: 48 83 e8 40                  	subq	$0x40, %rax
  1145b7: 72 42                        	jb	0x1145fb <_RNvNtNtCsc9NCSoc2doQ_4core3str7pattern18contains_byte_simd+0x14b>
  1145b9: f3 0f 6f 0c 07               	movdqu	(%rdi,%rax), %xmm1
  1145be: f3 0f 6f 54 07 10            	movdqu	0x10(%rdi,%rax), %xmm2
  1145c4: f3 0f 6f 5c 07 20            	movdqu	0x20(%rdi,%rax), %xmm3
  1145ca: f3 0f 6f 64 07 30            	movdqu	0x30(%rdi,%rax), %xmm4
  1145d0: 66 0f 74 c8                  	pcmpeqb	%xmm0, %xmm1
  1145d4: 66 0f 74 d0                  	pcmpeqb	%xmm0, %xmm2
  1145d8: 66 0f eb d1                  	por	%xmm1, %xmm2
  1145dc: 66 0f 74 d8                  	pcmpeqb	%xmm0, %xmm3
  1145e0: 66 0f 74 e0                  	pcmpeqb	%xmm0, %xmm4
  1145e4: 66 0f eb e3                  	por	%xmm3, %xmm4
  1145e8: 66 0f eb e2                  	por	%xmm2, %xmm4
  1145ec: 66 0f d7 c4                  	pmovmskb	%xmm4, %eax
  1145f0: 85 c0                        	testl	%eax, %eax
  1145f2: 0f 95 c0                     	setne	%al
  1145f5: 5d                           	popq	%rbp
  1145f6: c3                           	retq
  1145f7: 31 c0                        	xorl	%eax, %eax
  1145f9: 5d                           	popq	%rbp
  1145fa: c3                           	retq
  1145fb: 48 8d 0d 9e b7 01 00         	leaq	0x1b79e(%rip), %rcx     # 0x12fda0 <_RNvNtCs341anU20NIK_3std9panicking11EMPTY_PANIC+0x5b10>
  114602: 48 89 c7                     	movq	%rax, %rdi
  114605: 48 89 f2                     	movq	%rsi, %rdx
  114608: ff 15 92 cb 01 00            	callq	*0x1cb92(%rip)          # 0x1311a0 <writev+0x1311a0>
  11460e: 48 8d 15 73 b7 01 00         	leaq	0x1b773(%rip), %rdx     # 0x12fd88 <_RNvNtCs341anU20NIK_3std9panicking11EMPTY_PANIC+0x5af8>
  114615: 31 ff                        	xorl	%edi, %edi
  114617: 31 f6                        	xorl	%esi, %esi
  114619: ff 15 29 cb 01 00            	callq	*0x1cb29(%rip)          # 0x131148 <writev+0x131148>
  11461f: cc                           	int3
