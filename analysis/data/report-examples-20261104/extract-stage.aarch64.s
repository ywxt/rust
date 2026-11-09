	.file	"extract-stage.ll"
	.text
	.globl	xor_stage                       // -- Begin function xor_stage
	.p2align	2
	.type	xor_stage,@function
xor_stage:                              // @xor_stage
	.cfi_startproc
// %bb.0:
	and	v1.16b, v0.16b, v1.16b
	eor	v0.16b, v0.16b, v1.16b
	ushr	v1.2d, v1.2d, #1
	eor	v0.16b, v0.16b, v1.16b
	ret
.Lfunc_end0:
	.size	xor_stage, .Lfunc_end0-xor_stage
	.cfi_endproc
                                        // -- End function
	.globl	add_stage                       // -- Begin function add_stage
	.p2align	2
	.type	add_stage,@function
add_stage:                              // @add_stage
	.cfi_startproc
// %bb.0:
	bic	v2.16b, v0.16b, v1.16b
	and	v0.16b, v0.16b, v1.16b
	usra	v2.2d, v0.2d, #1
	mov	v0.16b, v2.16b
	ret
.Lfunc_end1:
	.size	add_stage, .Lfunc_end1-add_stage
	.cfi_endproc
                                        // -- End function
	.section	".note.GNU-stack","",@progbits
