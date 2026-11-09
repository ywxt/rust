
/tmp/str-debug-some-unicode-20261105/probe:	file format elf64-x86-64

Disassembly of section .text:

000000000004f6e0 <_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data2cf11lookup_slow>:
   4f6e0: 89 f8                        	movl	%edi, %eax
   4f6e2: c1 e0 0b                     	shll	$0xb, %eax
   4f6e5: 31 c9                        	xorl	%ecx, %ecx
   4f6e7: 81 ff bd 10 01 00            	cmpl	$0x110bd, %edi          # imm = 0x110BD
   4f6ed: 0f 93 c1                     	setae	%cl
   4f6f0: 48 8d 14 89                  	leaq	(%rcx,%rcx,4), %rdx
   4f6f4: 4c 8d 04 89                  	leaq	(%rcx,%rcx,4), %r8
   4f6f8: 49 83 c0 03                  	addq	$0x3, %r8
   4f6fc: 48 8d 35 d9 ab fb ff         	leaq	-0x45427(%rip), %rsi    # 0xa2dc <_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data2cf17SHORT_OFFSET_RUNS>
   4f703: b9 ff ff 1f 00               	movl	$0x1fffff, %ecx         # imm = 0x1FFFFF
   4f708: 44 8b 4c 96 0c               	movl	0xc(%rsi,%rdx,4), %r9d
   4f70d: 41 21 c9                     	andl	%ecx, %r9d
   4f710: 44 39 cf                     	cmpl	%r9d, %edi
   4f713: 4c 0f 42 c2                  	cmovbq	%rdx, %r8
   4f717: 49 8d 50 01                  	leaq	0x1(%r8), %rdx
   4f71b: 46 8b 4c 86 04               	movl	0x4(%rsi,%r8,4), %r9d
   4f720: 41 21 c9                     	andl	%ecx, %r9d
   4f723: 44 39 cf                     	cmpl	%r9d, %edi
   4f726: 49 0f 42 d0                  	cmovbq	%r8, %rdx
   4f72a: 4c 8d 4a 01                  	leaq	0x1(%rdx), %r9
   4f72e: 44 8b 44 96 04               	movl	0x4(%rsi,%rdx,4), %r8d
   4f733: 41 21 c8                     	andl	%ecx, %r8d
   4f736: 44 39 c7                     	cmpl	%r8d, %edi
   4f739: 4c 0f 42 ca                  	cmovbq	%rdx, %r9
   4f73d: 42 8b 14 8e                  	movl	(%rsi,%r9,4), %edx
   4f741: c1 e2 0b                     	shll	$0xb, %edx
   4f744: 45 31 c0                     	xorl	%r8d, %r8d
   4f747: 39 c2                        	cmpl	%eax, %edx
   4f749: 41 0f 94 c0                  	sete	%r8b
   4f74d: 4d 11 c8                     	adcq	%r9, %r8
   4f750: 42 8b 04 86                  	movl	(%rsi,%r8,4), %eax
   4f754: c1 e8 15                     	shrl	$0x15, %eax
   4f757: ba 2b 00 00 00               	movl	$0x2b, %edx
   4f75c: 49 83 f8 09                  	cmpq	$0x9, %r8
   4f760: 77 0d                        	ja	0x4f76f <_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data2cf11lookup_slow+0x8f>
   4f762: 42 8b 54 86 04               	movl	0x4(%rsi,%r8,4), %edx
   4f767: c1 ea 15                     	shrl	$0x15, %edx
   4f76a: 4d 85 c0                     	testq	%r8, %r8
   4f76d: 74 3a                        	je	0x4f7a9 <_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data2cf11lookup_slow+0xc9>
   4f76f: 42 23 4c 86 fc               	andl	-0x4(%rsi,%r8,4), %ecx
   4f774: 48 89 c6                     	movq	%rax, %rsi
   4f777: 48 f7 d6                     	notq	%rsi
   4f77a: 48 01 d6                     	addq	%rdx, %rsi
   4f77d: 74 27                        	je	0x4f7a6 <_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data2cf11lookup_slow+0xc6>
   4f77f: 29 cf                        	subl	%ecx, %edi
   4f781: 48 ff ca                     	decq	%rdx
   4f784: 31 f6                        	xorl	%esi, %esi
   4f786: 48 8d 0d 12 a4 fb ff         	leaq	-0x45bee(%rip), %rcx    # 0x9b9f <_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data2cf7OFFSETS>
   4f78d: 0f 1f 00                     	nopl	(%rax)
   4f790: 41 89 f0                     	movl	%esi, %r8d
   4f793: 0f b6 34 08                  	movzbl	(%rax,%rcx), %esi
   4f797: 44 01 c6                     	addl	%r8d, %esi
   4f79a: 39 fe                        	cmpl	%edi, %esi
   4f79c: 77 08                        	ja	0x4f7a6 <_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data2cf11lookup_slow+0xc6>
   4f79e: 48 ff c0                     	incq	%rax
   4f7a1: 48 39 c2                     	cmpq	%rax, %rdx
   4f7a4: 75 ea                        	jne	0x4f790 <_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data2cf11lookup_slow+0xb0>
   4f7a6: 24 01                        	andb	$0x1, %al
   4f7a8: c3                           	retq
   4f7a9: 31 c9                        	xorl	%ecx, %ecx
   4f7ab: 48 89 c6                     	movq	%rax, %rsi
   4f7ae: 48 f7 d6                     	notq	%rsi
   4f7b1: 48 01 d6                     	addq	%rdx, %rsi
   4f7b4: 75 c9                        	jne	0x4f77f <_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data2cf11lookup_slow+0x9f>
   4f7b6: eb ee                        	jmp	0x4f7a6 <_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data2cf11lookup_slow+0xc6>
   4f7b8: cc                           	int3
   4f7b9: cc                           	int3
   4f7ba: cc                           	int3
   4f7bb: cc                           	int3
   4f7bc: cc                           	int3
   4f7bd: cc                           	int3
   4f7be: cc                           	int3
   4f7bf: cc                           	int3
