	.file	"portable_mask_probe.7707f75c3b3477a0-cgu.0"
	.section	.text._RNvCsadBbONxITBY_19portable_mask_probe14contains_match,"ax",@progbits
	.globl	_RNvCsadBbONxITBY_19portable_mask_probe14contains_match
	.p2align	2
	.type	_RNvCsadBbONxITBY_19portable_mask_probe14contains_match,@function
_RNvCsadBbONxITBY_19portable_mask_probe14contains_match:
	.cfi_startproc
	ldrb	w8, [x1]
	cmp	w8, w0, uxtb
	b.ne	.LBB0_3
	mov	w0, #1
.LBB0_2:
	ret
.LBB0_3:
	dup	v0.16b, w0
	ands	x8, x2, #0x7fffffffffffffc0
	b.eq	.LBB0_7
	and	x9, x2, #0xffffffffffffffc0
	mov	w0, #1
	mov	x10, x1
	neg	x9, x9
.LBB0_5:
	ldp	q1, q2, [x10]
	ldp	q3, q4, [x10, #32]
	cmeq	v1.16b, v1.16b, v0.16b
	cmeq	v2.16b, v2.16b, v0.16b
	cmeq	v3.16b, v3.16b, v0.16b
	cmeq	v4.16b, v4.16b, v0.16b
	orr	v1.16b, v1.16b, v2.16b
	orr	v2.16b, v3.16b, v4.16b
	orr	v1.16b, v1.16b, v2.16b
	addp	d1, v1.2d
	fmov	x11, d1
	cbnz	x11, .LBB0_2
	adds	x9, x9, #64
	add	x10, x10, #64
	b.ne	.LBB0_5
.LBB0_7:
	tst	x2, #0x30
	b.eq	.LBB0_11
	and	x9, x2, #0x30
	add	x8, x1, x8
	mov	w0, #1
	neg	x9, x9
.LBB0_9:
	ldr	q1, [x8], #16
	cmeq	v1.16b, v1.16b, v0.16b
	addp	d1, v1.2d
	fmov	x10, d1
	cbnz	x10, .LBB0_2
	adds	x9, x9, #16
	b.ne	.LBB0_9
.LBB0_11:
	and	x8, x2, #0xf
	cbz	x8, .LBB0_13
	add	x8, x1, x2
	ldur	q1, [x8, #-16]
	cmeq	v0.16b, v1.16b, v0.16b
	addp	d0, v0.2d
	fmov	x8, d0
	cmp	x8, #0
	cset	w0, ne
	ret
.LBB0_13:
	mov	x0, xzr
	ret
.Lfunc_end0:
	.size	_RNvCsadBbONxITBY_19portable_mask_probe14contains_match, .Lfunc_end0-_RNvCsadBbONxITBY_19portable_mask_probe14contains_match
	.cfi_endproc

	.ident	"rustc version 1.99.0-dev"
	.section	".note.GNU-stack","",@progbits
