	.att_syntax
	.file	"portable_mask_probe.7707f75c3b3477a0-cgu.0"
	.section	.text._RNvCsadBbONxITBY_19portable_mask_probe14contains_match,"ax",@progbits
	.globl	_RNvCsadBbONxITBY_19portable_mask_probe14contains_match
	.prefalign	4, .Lfunc_end0, nop
	.type	_RNvCsadBbONxITBY_19portable_mask_probe14contains_match,@function
_RNvCsadBbONxITBY_19portable_mask_probe14contains_match:
	.cfi_startproc
	movl	$1, %eax
	cmpb	%dil, (%rsi)
	je	.LBB0_12
	movzbl	%dil, %ecx
	movd	%ecx, %xmm0
	punpcklbw	%xmm0, %xmm0
	pshuflw	$0, %xmm0, %xmm0
	pshufd	$68, %xmm0, %xmm0
	movabsq	$9223372036854775744, %rcx
	andq	%rdx, %rcx
	je	.LBB0_5
	xorl	%edi, %edi
	.p2align	4
.LBB0_3:
	movdqu	(%rsi,%rdi), %xmm1
	movdqu	16(%rsi,%rdi), %xmm2
	movdqu	32(%rsi,%rdi), %xmm3
	movdqu	48(%rsi,%rdi), %xmm4
	pcmpeqb	%xmm0, %xmm1
	pcmpeqb	%xmm0, %xmm2
	por	%xmm1, %xmm2
	pcmpeqb	%xmm0, %xmm3
	pcmpeqb	%xmm0, %xmm4
	por	%xmm3, %xmm4
	por	%xmm2, %xmm4
	pmovmskb	%xmm4, %r8d
	testl	%r8d, %r8d
	jne	.LBB0_12
	addq	$64, %rdi
	cmpq	%rdi, %rcx
	jne	.LBB0_3
.LBB0_5:
	movq	%rdx, %rdi
	andq	$48, %rdi
	je	.LBB0_9
	addq	%rsi, %rcx
	xorl	%r8d, %r8d
	.p2align	4
.LBB0_7:
	movdqu	(%rcx,%r8), %xmm1
	pcmpeqb	%xmm0, %xmm1
	pmovmskb	%xmm1, %r9d
	testl	%r9d, %r9d
	jne	.LBB0_12
	addq	$16, %r8
	cmpq	%r8, %rdi
	jne	.LBB0_7
.LBB0_9:
	testb	$15, %dl
	je	.LBB0_10
	movdqu	-16(%rsi,%rdx), %xmm1
	pcmpeqb	%xmm0, %xmm1
	pmovmskb	%xmm1, %ecx
	xorl	%eax, %eax
	testl	%ecx, %ecx
	setne	%al
.LBB0_12:
	retq
.LBB0_10:
	xorl	%eax, %eax
	retq
.Lfunc_end0:
	.size	_RNvCsadBbONxITBY_19portable_mask_probe14contains_match, .Lfunc_end0-_RNvCsadBbONxITBY_19portable_mask_probe14contains_match
	.cfi_endproc

	.ident	"rustc version 1.99.0-dev"
	.section	".note.GNU-stack","",@progbits
