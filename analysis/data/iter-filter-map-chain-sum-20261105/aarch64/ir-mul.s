	.file	"repro-mul.ll"
	.text
	.globl	repro                           // -- Begin function repro
	.p2align	2
	.type	repro,@function
repro:                                  // @repro
// %bb.0:                               // %entry
	sub	sp, sp, #16
	mov	w10, #16960                     // =0x4240
	mov	x8, xzr
	mov	x0, xzr
	add	x9, sp, #8
	movk	w10, #15, lsl #16
.LBB0_1:                                // %loop
                                        // =>This Inner Loop Header: Depth=1
	mul	x11, x8, x8
	add	x8, x8, #1
	cmp	x8, x10
	str	x11, [sp, #8]
	//APP
	//NO_APP
	ldr	x11, [sp, #8]
	add	x0, x11, x0
	b.ne	.LBB0_1
// %bb.2:                               // %exit
	add	sp, sp, #16
	ret
.Lfunc_end0:
	.size	repro, .Lfunc_end0-repro
                                        // -- End function
	.section	".note.GNU-stack","",@progbits
