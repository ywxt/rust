	.att_syntax
	.file	"diagnostic_wide32.93350778e58b103f-cgu.0"
	.section	.text._RNvCscDzYd9feO7z_17diagnostic_wide3216contains_byte_64,"ax",@progbits
	.globl	_RNvCscDzYd9feO7z_17diagnostic_wide3216contains_byte_64
	.prefalign	4, .Lfunc_end0, nop
	.type	_RNvCscDzYd9feO7z_17diagnostic_wide3216contains_byte_64,@function
_RNvCscDzYd9feO7z_17diagnostic_wide3216contains_byte_64:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	%rsi, (%rsp)
	cmpq	$64, %rsi
	jne	.LBB0_2
	movzbl	%dl, %eax
	movd	%eax, %xmm0
	punpcklbw	%xmm0, %xmm0
	pshuflw	$0, %xmm0, %xmm0
	pshufd	$68, %xmm0, %xmm0
	movdqu	(%rdi), %xmm1
	movdqu	16(%rdi), %xmm2
	movdqu	32(%rdi), %xmm3
	movdqu	48(%rdi), %xmm4
	pcmpeqb	%xmm0, %xmm1
	pcmpeqb	%xmm0, %xmm2
	pcmpeqb	%xmm0, %xmm3
	por	%xmm1, %xmm3
	pcmpeqb	%xmm0, %xmm4
	por	%xmm2, %xmm4
	por	%xmm3, %xmm4
	pmovmskb	%xmm4, %eax
	testl	%eax, %eax
	setne	%al
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.LBB0_2:
	.cfi_def_cfa_offset 16
	leaq	.Lalloc_a57caa216b7f7cdbaccf41839ba4d102(%rip), %rdx
	leaq	.Lalloc_dd74007490276935de2d5471e23a8d4d(%rip), %r9
	movq	%rsp, %rsi
	xorl	%edi, %edi
	xorl	%ecx, %ecx
	callq	*_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedjjEB4_@GOTPCREL(%rip)
.Lfunc_end0:
	.size	_RNvCscDzYd9feO7z_17diagnostic_wide3216contains_byte_64, .Lfunc_end0-_RNvCscDzYd9feO7z_17diagnostic_wide3216contains_byte_64
	.cfi_endproc

	.type	.Lalloc_a57caa216b7f7cdbaccf41839ba4d102,@object
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.Lalloc_a57caa216b7f7cdbaccf41839ba4d102:
	.asciz	"@\000\000\000\000\000\000"
	.size	.Lalloc_a57caa216b7f7cdbaccf41839ba4d102, 8

	.type	.Lalloc_d050b2a2588321a0f7bb60270933294f,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_d050b2a2588321a0f7bb60270933294f:
	.asciz	"/tmp/contains-portable-simd-20261105/diagnostic_wide32.rs"
	.size	.Lalloc_d050b2a2588321a0f7bb60270933294f, 58

	.type	.Lalloc_dd74007490276935de2d5471e23a8d4d,@object
	.section	.data.rel.ro..Lalloc_dd74007490276935de2d5471e23a8d4d,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_dd74007490276935de2d5471e23a8d4d:
	.quad	.Lalloc_d050b2a2588321a0f7bb60270933294f
	.asciz	"9\000\000\000\000\000\000\000\002\000\000\000k\000\000"
	.size	.Lalloc_dd74007490276935de2d5471e23a8d4d, 24

	.ident	"rustc version 1.99.0-dev"
	.section	".note.GNU-stack","",@progbits
