	.att_syntax
	.file	"repro.ll"
	.text
	.globl	repro                           # -- Begin function repro
	.prefalign	4, .Lfunc_end0, nop
	.type	repro,@function
repro:                                  # @repro
# %bb.0:                                # %entry
	xorl	%ecx, %ecx
	leaq	-8(%rsp), %rdx
	xorl	%eax, %eax
	jmp	.LBB0_1
	.p2align	4
.LBB0_3:                                # %latch
                                        #   in Loop: Header=BB0_1 Depth=1
	incq	%rcx
	cmpq	$1000000, %rcx                  # imm = 0xF4240
	je	.LBB0_4
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	movq	%rcx, %rsi
	imulq	%rcx, %rsi
	jo	.LBB0_3
# %bb.2:                                # %accepted
                                        #   in Loop: Header=BB0_1 Depth=1
	movq	%rsi, -8(%rsp)
	#APP
	#NO_APP
	addq	-8(%rsp), %rax
	jmp	.LBB0_3
.LBB0_4:                                # %exit
	retq
.Lfunc_end0:
	.size	repro, .Lfunc_end0-repro
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
