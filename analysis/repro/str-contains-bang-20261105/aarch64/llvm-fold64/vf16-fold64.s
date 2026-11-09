_RNvCsa0htB0rFyhf_13bang_probe_v36fold64:
	.cfi_startproc
	cmp	x1, #64
	b.hs	.LBB13_2
	b	_RNvCsa0htB0rFyhf_13bang_probe_v36fold16
.LBB13_2:
	tst	x1, #0xffffffffffffffc0
	b.eq	.LBB13_6
	movi	v0.16b, #33
	adrp	x8, .LCPI13_0
	and	x9, x1, #0xffffffffffffffc0
	ldr	q1, [x8, :lo12:.LCPI13_0]
	neg	x8, x9
	mov	x9, x0
.LBB13_4:
	ldp	q2, q3, [x9, #32]
	ldp	q5, q4, [x9], #64
	cmeq	v2.16b, v2.16b, v0.16b
	cmeq	v3.16b, v3.16b, v0.16b
	cmeq	v5.16b, v5.16b, v0.16b
	cmeq	v4.16b, v4.16b, v0.16b
	and	v2.16b, v2.16b, v1.16b
	and	v3.16b, v3.16b, v1.16b
	and	v5.16b, v5.16b, v1.16b
	and	v4.16b, v4.16b, v1.16b
	addp	v2.16b, v2.16b, v2.16b
	addp	v3.16b, v3.16b, v3.16b
	addp	v5.16b, v5.16b, v5.16b
	addp	v4.16b, v4.16b, v4.16b
	addp	v2.16b, v2.16b, v2.16b
	addp	v3.16b, v3.16b, v3.16b
	addp	v5.16b, v5.16b, v5.16b
	addp	v4.16b, v4.16b, v4.16b
	addp	v2.16b, v2.16b, v2.16b
	addp	v3.16b, v3.16b, v3.16b
	addp	v5.16b, v5.16b, v5.16b
	addp	v4.16b, v4.16b, v4.16b
	umov	w10, v2.h[0]
	umov	w12, v3.h[0]
	umov	w11, v5.h[0]
	umov	w13, v4.h[0]
	orr	w10, w11, w10
	orr	w11, w13, w12
	orr	w10, w10, w11
	tst	w10, #0xffff
	b.ne	.LBB13_8
	adds	x8, x8, #64
	b.ne	.LBB13_4
.LBB13_6:
	and	x8, x1, #0x3f
	cbz	x8, .LBB13_9
	movi	v0.16b, #33
	add	x8, x0, x1
	ldp	q1, q2, [x8, #-32]
	ldp	q4, q3, [x8, #-64]
	cmeq	v1.16b, v1.16b, v0.16b
	cmeq	v2.16b, v2.16b, v0.16b
	cmeq	v4.16b, v4.16b, v0.16b
	cmeq	v0.16b, v3.16b, v0.16b
	orr	v0.16b, v0.16b, v2.16b
	orr	v1.16b, v4.16b, v1.16b
	orr	v0.16b, v1.16b, v0.16b
	umaxv	b0, v0.16b
	fmov	w8, s0
	and	w0, w8, #0x1
	ret
.LBB13_8:
	mov	w0, #1
	ret
.LBB13_9:
	mov	w0, wzr
	ret
