	.att_syntax
	.file	"diagnostic_wide64.ab3cbf6978ba1b1a-cgu.0"
	.section	.text._RNvCseHuvESv4PMs_17diagnostic_wide6416contains_byte_64,"ax",@progbits
	.globl	_RNvCseHuvESv4PMs_17diagnostic_wide6416contains_byte_64
	.prefalign	4, .Lfunc_end0, nop
	.type	_RNvCseHuvESv4PMs_17diagnostic_wide6416contains_byte_64,@function
_RNvCseHuvESv4PMs_17diagnostic_wide6416contains_byte_64:
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
	pcmpeqb	%xmm0, %xmm3
	pcmpeqb	%xmm0, %xmm1
	por	%xmm3, %xmm1
	pcmpeqb	%xmm0, %xmm4
	pcmpeqb	%xmm0, %xmm2
	por	%xmm4, %xmm2
	por	%xmm1, %xmm2
	pmovmskb	%xmm2, %eax
	testl	%eax, %eax
	setne	%al
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.LBB0_2:
	.cfi_def_cfa_offset 16
	leaq	.Lalloc_a57caa216b7f7cdbaccf41839ba4d102(%rip), %rdx
	leaq	.Lalloc_fde261dc87a31883afec70062fd7fe56(%rip), %r9
	movq	%rsp, %rsi
	xorl	%edi, %edi
	xorl	%ecx, %ecx
	callq	*_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedjjEB4_@GOTPCREL(%rip)
.Lfunc_end0:
	.size	_RNvCseHuvESv4PMs_17diagnostic_wide6416contains_byte_64, .Lfunc_end0-_RNvCseHuvESv4PMs_17diagnostic_wide6416contains_byte_64
	.cfi_endproc

	.type	.Lalloc_a57caa216b7f7cdbaccf41839ba4d102,@object
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.Lalloc_a57caa216b7f7cdbaccf41839ba4d102:
	.asciz	"@\000\000\000\000\000\000"
	.size	.Lalloc_a57caa216b7f7cdbaccf41839ba4d102, 8

	.type	.Lalloc_0b5855b030ad37d29eeb66e295429bf8,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_0b5855b030ad37d29eeb66e295429bf8:
	.asciz	"/tmp/contains-portable-simd-20261105/diagnostic_wide64.rs"
	.size	.Lalloc_0b5855b030ad37d29eeb66e295429bf8, 58

	.type	.Lalloc_fde261dc87a31883afec70062fd7fe56,@object
	.section	.data.rel.ro..Lalloc_fde261dc87a31883afec70062fd7fe56,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_fde261dc87a31883afec70062fd7fe56:
	.quad	.Lalloc_0b5855b030ad37d29eeb66e295429bf8
	.asciz	"9\000\000\000\000\000\000\000\002\000\000\000k\000\000"
	.size	.Lalloc_fde261dc87a31883afec70062fd7fe56, 24

	.ident	"rustc version 1.99.0-dev"
	.section	".note.GNU-stack","",@progbits
