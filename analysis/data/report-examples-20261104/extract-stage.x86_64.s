	.att_syntax
	.file	"extract-stage.ll"
	.text
	.globl	xor_stage                       # -- Begin function xor_stage
	.prefalign	4, .Lfunc_end0, nop
	.type	xor_stage,@function
xor_stage:                              # @xor_stage
	.cfi_startproc
# %bb.0:
	pand	%xmm0, %xmm1
	pxor	%xmm1, %xmm0
	psrlq	$1, %xmm1
	pxor	%xmm1, %xmm0
	retq
.Lfunc_end0:
	.size	xor_stage, .Lfunc_end0-xor_stage
	.cfi_endproc
                                        # -- End function
	.globl	add_stage                       # -- Begin function add_stage
	.prefalign	4, .Lfunc_end1, nop
	.type	add_stage,@function
add_stage:                              # @add_stage
	.cfi_startproc
# %bb.0:
	movdqa	%xmm1, %xmm2
	pandn	%xmm0, %xmm2
	pand	%xmm1, %xmm0
	psrlq	$1, %xmm0
	paddq	%xmm2, %xmm0
	retq
.Lfunc_end1:
	.size	add_stage, .Lfunc_end1-add_stage
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
