	.att_syntax
	.file	"shape.dc6e593b42efc4fc-cgu.0"
	.section	.text.chained,"ax",@progbits
	.globl	chained
	.prefalign	4, .Lfunc_end0, nop
	.type	chained,@function
chained:
	.cfi_startproc
	xorl	%eax, %eax
	leaq	-8(%rsp), %rcx
	xorl	%edx, %edx
	jmp	.LBB0_1
	.p2align	4
.LBB0_3:
	incq	%rdx
	cmpq	$1000000, %rdx
	je	.LBB0_4
.LBB0_1:
	movq	%rdx, %rsi
	imulq	%rdx, %rsi
	jo	.LBB0_3
	movq	%rsi, -8(%rsp)
	#APP
	#NO_APP
	addq	-8(%rsp), %rax
	jmp	.LBB0_3
.LBB0_4:
	xorl	%ecx, %ecx
	leaq	-8(%rsp), %rdx
	jmp	.LBB0_5
	.p2align	4
.LBB0_7:
	incq	%rcx
	cmpq	$1000000, %rcx
	je	.LBB0_8
.LBB0_5:
	movq	%rcx, %rsi
	imulq	%rcx, %rsi
	jo	.LBB0_7
	movq	%rsi, -8(%rsp)
	#APP
	#NO_APP
	addq	-8(%rsp), %rax
	jmp	.LBB0_7
.LBB0_8:
	retq
.Lfunc_end0:
	.size	chained, .Lfunc_end0-chained
	.cfi_endproc

	.section	.text.single,"ax",@progbits
	.globl	single
	.prefalign	4, .Lfunc_end1, nop
	.type	single,@function
single:
	.cfi_startproc
	xorl	%eax, %eax
	leaq	-8(%rsp), %rcx
	xorl	%edx, %edx
	.p2align	4
.LBB1_1:
	leaq	1(%rdx), %rsi
	imulq	%rdx, %rdx
	movq	%rdx, -8(%rsp)
	#APP
	#NO_APP
	addq	-8(%rsp), %rax
	movq	%rsi, %rdx
	cmpq	$1000000, %rsi
	jne	.LBB1_1
	retq
.Lfunc_end1:
	.size	single, .Lfunc_end1-single
	.cfi_endproc

	.section	.text.single_ref,"ax",@progbits
	.globl	single_ref
	.prefalign	4, .Lfunc_end2, nop
	.type	single_ref,@function
single_ref:
	.cfi_startproc
	xorl	%eax, %eax
	leaq	-8(%rsp), %rcx
	xorl	%edx, %edx
	jmp	.LBB2_1
	.p2align	4
.LBB2_3:
	incq	%rdx
	cmpq	$1000000, %rdx
	je	.LBB2_4
.LBB2_1:
	movq	%rdx, %rsi
	imulq	%rdx, %rsi
	jo	.LBB2_3
	movq	%rsi, -8(%rsp)
	#APP
	#NO_APP
	addq	-8(%rsp), %rax
	jmp	.LBB2_3
.LBB2_4:
	retq
.Lfunc_end2:
	.size	single_ref, .Lfunc_end2-single_ref
	.cfi_endproc

	.ident	"rustc version 1.101.0-dev"
	.section	".note.GNU-stack","",@progbits
