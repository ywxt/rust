
/tmp/xdiff-src/build/x86_64-unknown-linux-gnu/stage1-std/x86_64-unknown-linux-gnu/dist/build/coretests/d6382d1542e5d229/out/corebenches-d6382d1542e5d229:	file format elf64-x86-64

Disassembly of section .text:

0000000000192750 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvNtCsjC2aHCArQCR_11corebenches5tuples_22bench_tuple_comparison0EBT_>:
  192750: 55                           	pushq	%rbp
  192751: 48 89 e5                     	movq	%rsp, %rbp
  192754: 41 57                        	pushq	%r15
  192756: 41 56                        	pushq	%r14
  192758: 41 55                        	pushq	%r13
  19275a: 41 54                        	pushq	%r12
  19275c: 53                           	pushq	%rbx
  19275d: 48 83 ec 28                  	subq	$0x28, %rsp
  192761: 48 89 d3                     	movq	%rdx, %rbx
  192764: 49 89 f6                     	movq	%rsi, %r14
  192767: 49 89 ff                     	movq	%rdi, %r15
  19276a: ff 15 d8 14 19 00            	callq	*0x1914d8(%rip)         # 0x323c48 <memset+0x323c48>
  192770: 48 89 45 b8                  	movq	%rax, -0x48(%rbp)
  192774: 89 55 c0                     	movl	%edx, -0x40(%rbp)
  192777: 48 85 db                     	testq	%rbx, %rbx
  19277a: 75 7c                        	jne	0x1927f8 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvNtCsjC2aHCArQCR_11corebenches5tuples_22bench_tuple_comparison0EBT_+0xa8>
  19277c: 48 8d 7d b8                  	leaq	-0x48(%rbp), %rdi
  192780: ff 15 ca 14 19 00            	callq	*0x1914ca(%rip)         # 0x323c50 <memset+0x323c50>
  192786: 48 69 c8 00 ca 9a 3b         	imulq	$0x3b9aca00, %rax, %rcx # imm = 0x3B9ACA00
  19278d: 89 d0                        	movl	%edx, %eax
  19278f: 48 01 c8                     	addq	%rcx, %rax
  192792: 48 83 c4 28                  	addq	$0x28, %rsp
  192796: 5b                           	popq	%rbx
  192797: 41 5c                        	popq	%r12
  192799: 41 5d                        	popq	%r13
  19279b: 41 5e                        	popq	%r14
  19279d: 41 5f                        	popq	%r15
  19279f: 5d                           	popq	%rbp
  1927a0: c3                           	retq
  1927a1: 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 	nopw	%cs:(%rax,%rax)
  1927b0: 4a 8d 0c eb                  	leaq	(%rbx,%r13,8), %rcx
  1927b4: 49 8b 54 24 10               	movq	0x10(%r12), %rdx
  1927b9: 31 c0                        	xorl	%eax, %eax
  1927bb: 48 3b 51 10                  	cmpq	0x10(%rcx), %rdx
  1927bf: 0f 96 c1                     	setbe	%cl
  1927c2: 0f 92 c0                     	setb	%al
  1927c5: 0f 97 c2                     	seta	%dl
  1927c8: 40 0f 93 c6                  	setae	%sil
  1927cc: 49 89 df                     	movq	%rbx, %r15
  1927cf: 40 0f b6 f6                  	movzbl	%sil, %esi
  1927d3: c1 e6 18                     	shll	$0x18, %esi
  1927d6: 0f b6 d2                     	movzbl	%dl, %edx
  1927d9: c1 e2 10                     	shll	$0x10, %edx
  1927dc: 09 c2                        	orl	%eax, %edx
  1927de: 0f b6 c1                     	movzbl	%cl, %eax
  1927e1: c1 e0 08                     	shll	$0x8, %eax
  1927e4: 09 d0                        	orl	%edx, %eax
  1927e6: 09 f0                        	orl	%esi, %eax
  1927e8: 89 45 d4                     	movl	%eax, -0x2c(%rbp)
  1927eb: 48 8d 45 d4                  	leaq	-0x2c(%rbp), %rax
  1927ef: 48 8b 5d c8                  	movq	-0x38(%rbp), %rbx
  1927f3: 48 ff cb                     	decq	%rbx
  1927f6: 74 84                        	je	0x19277c <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvNtCsjC2aHCArQCR_11corebenches5tuples_22bench_tuple_comparison0EBT_+0x2c>
  1927f8: 41 8b 06                     	movl	(%r14), %eax
  1927fb: 45 8b 46 04                  	movl	0x4(%r14), %r8d
  1927ff: 89 c1                        	movl	%eax, %ecx
  192801: c1 e1 0b                     	shll	$0xb, %ecx
  192804: 31 c1                        	xorl	%eax, %ecx
  192806: 41 8b 76 08                  	movl	0x8(%r14), %esi
  19280a: 41 8b 56 0c                  	movl	0xc(%r14), %edx
  19280e: 89 d0                        	movl	%edx, %eax
  192810: c1 e8 13                     	shrl	$0x13, %eax
  192813: 31 c8                        	xorl	%ecx, %eax
  192815: c1 e9 08                     	shrl	$0x8, %ecx
  192818: 31 c1                        	xorl	%eax, %ecx
  19281a: 31 d1                        	xorl	%edx, %ecx
  19281c: 48 8d 04 09                  	leaq	(%rcx,%rcx), %rax
  192820: 4c 8d 0c 40                  	leaq	(%rax,%rax,2), %r9
  192824: 4c 89 c8                     	movq	%r9, %rax
  192827: 48 c1 e8 20                  	shrq	$0x20, %rax
  19282b: 41 83 f9 fb                  	cmpl	$-0x5, %r9d
  19282f: 72 4f                        	jb	0x192880 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvNtCsjC2aHCArQCR_11corebenches5tuples_22bench_tuple_comparison0EBT_+0x130>
  192831: 45 89 c2                     	movl	%r8d, %r10d
  192834: 41 c1 e2 0b                  	shll	$0xb, %r10d
  192838: 45 31 c2                     	xorl	%r8d, %r10d
  19283b: 41 89 36                     	movl	%esi, (%r14)
  19283e: 41 89 56 04                  	movl	%edx, 0x4(%r14)
  192842: 41 89 4e 08                  	movl	%ecx, 0x8(%r14)
  192846: 41 89 c8                     	movl	%ecx, %r8d
  192849: 41 c1 e8 13                  	shrl	$0x13, %r8d
  19284d: 44 89 d7                     	movl	%r10d, %edi
  192850: c1 ef 08                     	shrl	$0x8, %edi
  192853: 44 31 d7                     	xorl	%r10d, %edi
  192856: 31 cf                        	xorl	%ecx, %edi
  192858: 44 31 c7                     	xorl	%r8d, %edi
  19285b: 41 89 7e 0c                  	movl	%edi, 0xc(%r14)
  19285f: 4c 8d 04 3f                  	leaq	(%rdi,%rdi), %r8
  192863: 4f 8d 04 40                  	leaq	(%r8,%r8,2), %r8
  192867: 49 c1 e8 20                  	shrq	$0x20, %r8
  19286b: 45 01 c1                     	addl	%r8d, %r9d
  19286e: 48 83 d0 00                  	adcq	$0x0, %rax
  192872: 48 83 f8 06                  	cmpq	$0x6, %rax
  192876: 72 11                        	jb	0x192889 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvNtCsjC2aHCArQCR_11corebenches5tuples_22bench_tuple_comparison0EBT_+0x139>
  192878: e9 f2 00 00 00               	jmp	0x19296f <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvNtCsjC2aHCArQCR_11corebenches5tuples_22bench_tuple_comparison0EBT_+0x21f>
  19287d: 0f 1f 00                     	nopl	(%rax)
  192880: 89 cf                        	movl	%ecx, %edi
  192882: 89 d1                        	movl	%edx, %ecx
  192884: 89 f2                        	movl	%esi, %edx
  192886: 44 89 c6                     	movl	%r8d, %esi
  192889: 41 89 f1                     	movl	%esi, %r9d
  19288c: 41 c1 e1 0b                  	shll	$0xb, %r9d
  192890: 41 31 f1                     	xorl	%esi, %r9d
  192893: 41 89 16                     	movl	%edx, (%r14)
  192896: 41 89 4e 04                  	movl	%ecx, 0x4(%r14)
  19289a: 41 89 7e 08                  	movl	%edi, 0x8(%r14)
  19289e: 89 fe                        	movl	%edi, %esi
  1928a0: c1 ee 13                     	shrl	$0x13, %esi
  1928a3: 45 89 c8                     	movl	%r9d, %r8d
  1928a6: 41 c1 e8 08                  	shrl	$0x8, %r8d
  1928aa: 41 31 f8                     	xorl	%edi, %r8d
  1928ad: 41 31 f0                     	xorl	%esi, %r8d
  1928b0: 45 31 c8                     	xorl	%r9d, %r8d
  1928b3: 45 89 46 0c                  	movl	%r8d, 0xc(%r14)
  1928b7: 4b 8d 34 00                  	leaq	(%r8,%r8), %rsi
  1928bb: 4c 8d 0c 76                  	leaq	(%rsi,%rsi,2), %r9
  1928bf: 4c 89 ce                     	movq	%r9, %rsi
  1928c2: 48 c1 ee 20                  	shrq	$0x20, %rsi
  1928c6: 41 83 f9 fb                  	cmpl	$-0x5, %r9d
  1928ca: 48 89 5d c8                  	movq	%rbx, -0x38(%rbp)
  1928ce: 72 44                        	jb	0x192914 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvNtCsjC2aHCArQCR_11corebenches5tuples_22bench_tuple_comparison0EBT_+0x1c4>
  1928d0: 41 89 d2                     	movl	%edx, %r10d
  1928d3: 41 c1 e2 0b                  	shll	$0xb, %r10d
  1928d7: 41 31 d2                     	xorl	%edx, %r10d
  1928da: 41 89 0e                     	movl	%ecx, (%r14)
  1928dd: 41 89 7e 04                  	movl	%edi, 0x4(%r14)
  1928e1: 45 89 46 08                  	movl	%r8d, 0x8(%r14)
  1928e5: 44 89 d1                     	movl	%r10d, %ecx
  1928e8: c1 e9 08                     	shrl	$0x8, %ecx
  1928eb: 44 31 d1                     	xorl	%r10d, %ecx
  1928ee: 44 31 c1                     	xorl	%r8d, %ecx
  1928f1: 41 c1 e8 13                  	shrl	$0x13, %r8d
  1928f5: 41 31 c8                     	xorl	%ecx, %r8d
  1928f8: 45 89 46 0c                  	movl	%r8d, 0xc(%r14)
  1928fc: 4d 01 c0                     	addq	%r8, %r8
  1928ff: 4b 8d 0c 40                  	leaq	(%r8,%r8,2), %rcx
  192903: 48 c1 e9 20                  	shrq	$0x20, %rcx
  192907: 41 01 c9                     	addl	%ecx, %r9d
  19290a: 48 83 d6 00                  	adcq	$0x0, %rsi
  19290e: 48 83 fe 06                  	cmpq	$0x6, %rsi
  192912: 73 5b                        	jae	0x19296f <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvNtCsjC2aHCArQCR_11corebenches5tuples_22bench_tuple_comparison0EBT_+0x21f>
  192914: 48 8d 04 40                  	leaq	(%rax,%rax,2), %rax
  192918: 4d 8d 24 c7                  	leaq	(%r15,%rax,8), %r12
  19291c: 4c 8d 2c 76                  	leaq	(%rsi,%rsi,2), %r13
  192920: 49 8b 3c 24                  	movq	(%r12), %rdi
  192924: 49 8b 44 24 08               	movq	0x8(%r12), %rax
  192929: 4b 8b 34 ef                  	movq	(%r15,%r13,8), %rsi
  19292d: 4b 8b 54 ef 08               	movq	0x8(%r15,%r13,8), %rdx
  192932: 4c 89 fb                     	movq	%r15, %rbx
  192935: 49 89 c7                     	movq	%rax, %r15
  192938: 49 29 d7                     	subq	%rdx, %r15
  19293b: 48 0f 42 d0                  	cmovbq	%rax, %rdx
  19293f: ff 15 13 13 19 00            	callq	*0x191313(%rip)         # 0x323c58 <memset+0x323c58>
  192945: 48 98                        	cltq
  192947: 85 c0                        	testl	%eax, %eax
  192949: 4c 0f 45 f8                  	cmovneq	%rax, %r15
  19294d: 4d 85 ff                     	testq	%r15, %r15
  192950: 0f 84 5a fe ff ff            	je	0x1927b0 <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvNtCsjC2aHCArQCR_11corebenches5tuples_22bench_tuple_comparison0EBT_+0x60>
  192956: 4c 89 f8                     	movq	%r15, %rax
  192959: 48 c1 e8 3f                  	shrq	$0x3f, %rax
  19295d: 4d 85 ff                     	testq	%r15, %r15
  192960: 0f 9e c1                     	setle	%cl
  192963: 0f 9f c2                     	setg	%dl
  192966: 40 0f 99 c6                  	setns	%sil
  19296a: e9 5d fe ff ff               	jmp	0x1927cc <_RINvNtCsbvh2iR3x0la_4test5bench13ns_iter_innerAbj4_NCNvNtCsjC2aHCArQCR_11corebenches5tuples_22bench_tuple_comparison0EBT_+0x7c>
  19296f: 48 8d 15 d2 4f 17 00         	leaq	0x174fd2(%rip), %rdx    # 0x307948 <memset+0x307948>
  192976: bf 06 00 00 00               	movl	$0x6, %edi
  19297b: be 06 00 00 00               	movl	$0x6, %esi
  192980: ff 15 7a 12 19 00            	callq	*0x19127a(%rip)         # 0x323c00 <memset+0x323c00>
  192986: cc                           	int3
  192987: cc                           	int3
  192988: cc                           	int3
  192989: cc                           	int3
  19298a: cc                           	int3
  19298b: cc                           	int3
  19298c: cc                           	int3
  19298d: cc                           	int3
  19298e: cc                           	int3
  19298f: cc                           	int3
