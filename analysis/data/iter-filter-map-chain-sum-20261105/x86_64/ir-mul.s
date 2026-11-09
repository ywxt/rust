	.att_syntax
	.file	"repro-mul.ll"
	.text
	.globl	repro                           # -- Begin function repro
	.prefalign	4, .Lfunc_end0, nop
	.type	repro,@function
repro:                                  # @repro
# %bb.0:                                # %entry
	xorl	%ecx, %ecx
	leaq	-8(%rsp), %rdx
	xorl	%eax, %eax
	.p2align	4
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	movq	%rcx, %rsi
	imulq	%rcx, %rsi
	movq	%rsi, -8(%rsp)
	#APP
	#NO_APP
	addq	-8(%rsp), %rax
	incq	%rcx
	cmpq	$1000000, %rcx                  # imm = 0xF4240
	jne	.LBB0_1
# %bb.2:                                # %exit
	retq
.Lfunc_end0:
	.size	repro, .Lfunc_end0-repro
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
