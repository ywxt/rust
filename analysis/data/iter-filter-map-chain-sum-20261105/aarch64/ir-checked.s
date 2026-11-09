	.file	"repro.ll"
	.text
	.globl	repro                           // -- Begin function repro
	.p2align	2
	.type	repro,@function
repro:                                  // @repro
// %bb.0:                               // %entry
	sub	sp, sp, #16
	mov	w9, #16960                      // =0x4240
	mov	x8, xzr
	mov	x0, xzr
	movk	w9, #15, lsl #16
	add	x10, sp, #8
	b	.LBB0_2
.LBB0_1:                                // %latch
                                        //   in Loop: Header=BB0_2 Depth=1
	add	x8, x8, #1
	cmp	x8, x9
	b.eq	.LBB0_4
.LBB0_2:                                // %loop
                                        // =>This Inner Loop Header: Depth=1
	mul	x11, x8, x8
	smulh	x12, x8, x8
	cmp	x12, x11, asr #63
	b.ne	.LBB0_1
// %bb.3:                               // %accepted
                                        //   in Loop: Header=BB0_2 Depth=1
	str	x11, [sp, #8]
	//APP
	//NO_APP
	ldr	x11, [sp, #8]
	add	x0, x11, x0
	b	.LBB0_1
.LBB0_4:                                // %exit
	add	sp, sp, #16
	ret
.Lfunc_end0:
	.size	repro, .Lfunc_end0-repro
                                        // -- End function
	.section	".note.GNU-stack","",@progbits
