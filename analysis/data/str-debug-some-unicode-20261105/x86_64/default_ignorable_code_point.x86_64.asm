
/tmp/str-debug-some-unicode-20261105/probe:	file format elf64-x86-64

Disassembly of section .text:

000000000004f600 <_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data28default_ignorable_code_point11lookup_slow>:
   4f600: 89 f8                        	movl	%edi, %eax
   4f602: c1 e0 0b                     	shll	$0xb, %eax
   4f605: 31 c9                        	xorl	%ecx, %ecx
   4f607: 81 ff 00 fe 00 00            	cmpl	$0xfe00, %edi           # imm = 0xFE00
   4f60d: 41 b8 06 00 00 00            	movl	$0x6, %r8d
   4f613: 4c 0f 42 c1                  	cmovbq	%rcx, %r8
   4f617: 4d 8d 48 03                  	leaq	0x3(%r8), %r9
   4f61b: 48 8d 35 8a ac fb ff         	leaq	-0x45376(%rip), %rsi    # 0xa2ac <_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data28default_ignorable_code_point17SHORT_OFFSET_RUNS>
   4f622: ba ff ff 1f 00               	movl	$0x1fffff, %edx         # imm = 0x1FFFFF
   4f627: 46 8b 54 86 0c               	movl	0xc(%rsi,%r8,4), %r10d
   4f62c: 41 21 d2                     	andl	%edx, %r10d
   4f62f: 44 39 d7                     	cmpl	%r10d, %edi
   4f632: 4d 0f 42 c8                  	cmovbq	%r8, %r9
   4f636: 4d 8d 41 01                  	leaq	0x1(%r9), %r8
   4f63a: 46 8b 54 8e 04               	movl	0x4(%rsi,%r9,4), %r10d
   4f63f: 41 21 d2                     	andl	%edx, %r10d
   4f642: 44 39 d7                     	cmpl	%r10d, %edi
   4f645: 4d 0f 42 c1                  	cmovbq	%r9, %r8
   4f649: 4d 8d 50 01                  	leaq	0x1(%r8), %r10
   4f64d: 46 8b 4c 86 04               	movl	0x4(%rsi,%r8,4), %r9d
   4f652: 41 21 d1                     	andl	%edx, %r9d
   4f655: 44 39 cf                     	cmpl	%r9d, %edi
   4f658: 4d 0f 42 d0                  	cmovbq	%r8, %r10
   4f65c: 46 8b 04 96                  	movl	(%rsi,%r10,4), %r8d
   4f660: 41 c1 e0 0b                  	shll	$0xb, %r8d
   4f664: 45 31 c9                     	xorl	%r9d, %r9d
   4f667: 41 39 c0                     	cmpl	%eax, %r8d
   4f66a: 41 0f 94 c1                  	sete	%r9b
   4f66e: 4d 11 d1                     	adcq	%r10, %r9
   4f671: 42 8b 04 8e                  	movl	(%rsi,%r9,4), %eax
   4f675: c1 e8 15                     	shrl	$0x15, %eax
   4f678: 41 b8 23 00 00 00            	movl	$0x23, %r8d
   4f67e: 49 83 f9 0a                  	cmpq	$0xa, %r9
   4f682: 77 0e                        	ja	0x4f692 <_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data28default_ignorable_code_point11lookup_slow+0x92>
   4f684: 46 8b 44 8e 04               	movl	0x4(%rsi,%r9,4), %r8d
   4f689: 41 c1 e8 15                  	shrl	$0x15, %r8d
   4f68d: 4d 85 c9                     	testq	%r9, %r9
   4f690: 74 07                        	je	0x4f699 <_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data28default_ignorable_code_point11lookup_slow+0x99>
   4f692: 42 23 54 8e fc               	andl	-0x4(%rsi,%r9,4), %edx
   4f697: 89 d1                        	movl	%edx, %ecx
   4f699: 48 89 c2                     	movq	%rax, %rdx
   4f69c: 48 f7 d2                     	notq	%rdx
   4f69f: 4c 01 c2                     	addq	%r8, %rdx
   4f6a2: 74 30                        	je	0x4f6d4 <_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data28default_ignorable_code_point11lookup_slow+0xd4>
   4f6a4: 29 cf                        	subl	%ecx, %edi
   4f6a6: 49 ff c8                     	decq	%r8
   4f6a9: 31 d2                        	xorl	%edx, %edx
   4f6ab: 48 8d 0d ca a4 fb ff         	leaq	-0x45b36(%rip), %rcx    # 0x9b7c <_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data28default_ignorable_code_point7OFFSETS>
   4f6b2: 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00    	nopw	%cs:(%rax,%rax)
   4f6c0: 89 d6                        	movl	%edx, %esi
   4f6c2: 0f b6 14 08                  	movzbl	(%rax,%rcx), %edx
   4f6c6: 01 f2                        	addl	%esi, %edx
   4f6c8: 39 fa                        	cmpl	%edi, %edx
   4f6ca: 77 08                        	ja	0x4f6d4 <_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data28default_ignorable_code_point11lookup_slow+0xd4>
   4f6cc: 48 ff c0                     	incq	%rax
   4f6cf: 49 39 c0                     	cmpq	%rax, %r8
   4f6d2: 75 ec                        	jne	0x4f6c0 <_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data28default_ignorable_code_point11lookup_slow+0xc0>
   4f6d4: 24 01                        	andb	$0x1, %al
   4f6d6: c3                           	retq
   4f6d7: cc                           	int3
   4f6d8: cc                           	int3
   4f6d9: cc                           	int3
   4f6da: cc                           	int3
   4f6db: cc                           	int3
   4f6dc: cc                           	int3
   4f6dd: cc                           	int3
   4f6de: cc                           	int3
   4f6df: cc                           	int3
