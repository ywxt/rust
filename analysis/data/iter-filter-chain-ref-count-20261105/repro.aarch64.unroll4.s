	.file	"repro.ll"
	.text
	.globl	filter_chain_ref_count          // -- Begin function filter_chain_ref_count
	.p2align	2
	.type	filter_chain_ref_count,@function
filter_chain_ref_count:                 // @filter_chain_ref_count
// %bb.0:                               // %entry
	sub	sp, sp, #16
	mov	w8, #16960                      // =0x4240
	mov	x11, #-6148914691236517206      // =0xaaaaaaaaaaaaaaaa
	mov	x12, #-6148914691236517206      // =0xaaaaaaaaaaaaaaaa
	mov	x9, xzr
	mov	x0, xzr
	movk	w8, #15, lsl #16
	add	x10, sp, #8
	movk	x11, #43691
	movk	x12, #10922, lsl #48
	mov	x13, #6148914691236517205       // =0x5555555555555555
.LBB0_1:                                // %first
                                        // =>This Inner Loop Header: Depth=1
	str	x9, [sp, #8]
	add	x14, x9, #1
	//APP
	//NO_APP
	ldr	x15, [sp, #8]
	str	x14, [sp, #8]
	add	x14, x9, #2
	//APP
	//NO_APP
	ldr	x16, [sp, #8]
	str	x14, [sp, #8]
	add	x14, x9, #3
	//APP
	//NO_APP
	madd	x15, x15, x11, x12
	add	x9, x9, #4
	ldr	x17, [sp, #8]
	str	x14, [sp, #8]
	//APP
	//NO_APP
	madd	x16, x16, x11, x12
	madd	x14, x17, x11, x12
	ldr	x17, [sp, #8]
	cmp	x15, x13
	madd	x17, x17, x11, x12
	cinc	x15, x0, lo
	cmp	x16, x13
	cinc	x15, x15, lo
	cmp	x14, x13
	cinc	x14, x15, lo
	cmp	x17, x13
	cinc	x0, x14, lo
	cmp	x9, x8
	b.ne	.LBB0_1
// %bb.2:                               // %second.preheader
	mov	x11, #-6148914691236517206      // =0xaaaaaaaaaaaaaaaa
	mov	x12, #-6148914691236517206      // =0xaaaaaaaaaaaaaaaa
	mov	x9, xzr
	add	x10, sp, #8
	movk	x11, #43691
	movk	x12, #10922, lsl #48
	mov	x13, #6148914691236517205       // =0x5555555555555555
.LBB0_3:                                // %second
                                        // =>This Inner Loop Header: Depth=1
	str	x9, [sp, #8]
	add	x14, x9, #1
	//APP
	//NO_APP
	ldr	x15, [sp, #8]
	str	x14, [sp, #8]
	add	x14, x9, #2
	//APP
	//NO_APP
	ldr	x16, [sp, #8]
	str	x14, [sp, #8]
	add	x14, x9, #3
	//APP
	//NO_APP
	madd	x15, x15, x11, x12
	add	x9, x9, #4
	ldr	x17, [sp, #8]
	str	x14, [sp, #8]
	//APP
	//NO_APP
	madd	x16, x16, x11, x12
	madd	x14, x17, x11, x12
	ldr	x17, [sp, #8]
	cmp	x15, x13
	madd	x17, x17, x11, x12
	cinc	x15, x0, lo
	cmp	x16, x13
	cinc	x15, x15, lo
	cmp	x14, x13
	cinc	x14, x15, lo
	cmp	x17, x13
	cinc	x0, x14, lo
	cmp	x9, x8
	b.ne	.LBB0_3
// %bb.4:                               // %exit
	add	sp, sp, #16
	ret
.Lfunc_end0:
	.size	filter_chain_ref_count, .Lfunc_end0-filter_chain_ref_count
                                        // -- End function
	.section	".note.GNU-stack","",@progbits
