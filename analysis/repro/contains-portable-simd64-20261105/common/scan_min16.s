	.file	"scan_min16.8d9168f0b3b7eac8-cgu.0"
	.section	.text._RNvCsc9yUS3K9YJU_10scan_min1618contains_byte_simd,"ax",@progbits
	.globl	_RNvCsc9yUS3K9YJU_10scan_min1618contains_byte_simd
	.p2align	2
	.type	_RNvCsc9yUS3K9YJU_10scan_min1618contains_byte_simd,@function
_RNvCsc9yUS3K9YJU_10scan_min1618contains_byte_simd:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_remember_state
	cbz	x1, .LBB0_16
	ldrb	w8, [x0]
	cmp	w8, w2, uxtb
	b.ne	.LBB0_3
.LBB0_2:
	mov	w0, #1
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB0_3:
	.cfi_restore_state
	.cfi_remember_state
	dup	v0.16b, w2
	cmp	x1, #128
	b.lo	.LBB0_7
	add	x8, x0, #63
	and	x8, x8, #0xffffffffffffffc0
	subs	x9, x8, x0
	b.eq	.LBB0_6
	ldp	q3, q1, [x0, #16]
	ldr	q2, [x0]
	ldr	q4, [x0, #48]
	cmeq	v2.16b, v2.16b, v0.16b
	cmeq	v1.16b, v1.16b, v0.16b
	cmeq	v3.16b, v3.16b, v0.16b
	cmeq	v4.16b, v4.16b, v0.16b
	orr	v2.16b, v2.16b, v3.16b
	orr	v1.16b, v1.16b, v4.16b
	orr	v1.16b, v2.16b, v1.16b
	addp	d1, v1.2d
	fmov	x8, d1
	cbnz	x8, .LBB0_2
.LBB0_6:
	sub	x8, x1, x9
	tst	x8, #0x7fffffffffffffc0
	b.ne	.LBB0_8
	b	.LBB0_11
.LBB0_7:
	mov	x9, xzr
	sub	x8, x1, xzr
	tst	x8, #0x7fffffffffffffc0
	b.eq	.LBB0_11
.LBB0_8:
	and	x10, x8, #0x7fffffffffffffc0
	add	x9, x0, x9
	neg	x10, x10
.LBB0_9:
	ldp	q3, q1, [x9, #16]
	ldr	q2, [x9]
	ldr	q4, [x9, #48]
	cmeq	v2.16b, v2.16b, v0.16b
	cmeq	v1.16b, v1.16b, v0.16b
	cmeq	v3.16b, v3.16b, v0.16b
	cmeq	v4.16b, v4.16b, v0.16b
	orr	v2.16b, v2.16b, v3.16b
	orr	v1.16b, v1.16b, v4.16b
	orr	v1.16b, v2.16b, v1.16b
	addp	d1, v1.2d
	fmov	x11, d1
	cbnz	x11, .LBB0_2
	adds	x10, x10, #64
	add	x9, x9, #64
	b.ne	.LBB0_9
.LBB0_11:
	and	x8, x8, #0x3f
	cbz	x8, .LBB0_14
	subs	x8, x1, #64
	b.lo	.LBB0_15
	add	x8, x0, x8
	ldp	q3, q1, [x8, #16]
	ldr	q2, [x8]
	ldr	q4, [x8, #48]
	cmeq	v2.16b, v2.16b, v0.16b
	cmeq	v1.16b, v1.16b, v0.16b
	cmeq	v3.16b, v3.16b, v0.16b
	cmeq	v0.16b, v4.16b, v0.16b
	orr	v2.16b, v2.16b, v3.16b
	orr	v0.16b, v1.16b, v0.16b
	orr	v0.16b, v2.16b, v0.16b
	addp	d0, v0.2d
	fmov	x8, d0
	cmp	x8, #0
	cset	w0, ne
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB0_14:
	.cfi_restore_state
	.cfi_remember_state
	mov	w0, wzr
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB0_15:
	.cfi_restore_state
	adrp	x3, .Lalloc_60c3f71f0b6c0c17f3b699d55e0395be
	add	x3, x3, :lo12:.Lalloc_60c3f71f0b6c0c17f3b699d55e0395be
	mov	x0, x8
	mov	x2, x1
	bl	_RNvNtNtCshp6Wxz1DwXO_4core5slice5index16slice_index_fail
.LBB0_16:
	adrp	x2, .Lalloc_489d5e7084d2fa0dfc82d306c28d96f6
	add	x2, x2, :lo12:.Lalloc_489d5e7084d2fa0dfc82d306c28d96f6
	mov	x0, xzr
	bl	_RNvNtCshp6Wxz1DwXO_4core9panicking18panic_bounds_check
.Lfunc_end0:
	.size	_RNvCsc9yUS3K9YJU_10scan_min1618contains_byte_simd, .Lfunc_end0-_RNvCsc9yUS3K9YJU_10scan_min1618contains_byte_simd
	.cfi_endproc

	.type	.Lalloc_b9cc5ac15a0e0c6b4732046d7a49707c,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_b9cc5ac15a0e0c6b4732046d7a49707c:
	.asciz	"/tmp/contains-portable-simd64-20261105/scan_min16.rs"
	.size	.Lalloc_b9cc5ac15a0e0c6b4732046d7a49707c, 53

	.type	.Lalloc_489d5e7084d2fa0dfc82d306c28d96f6,@object
	.section	.data.rel.ro..Lalloc_489d5e7084d2fa0dfc82d306c28d96f6,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_489d5e7084d2fa0dfc82d306c28d96f6:
	.xword	.Lalloc_b9cc5ac15a0e0c6b4732046d7a49707c
	.asciz	"4\000\000\000\000\000\000\000\004\000\000\000\b\000\000"
	.size	.Lalloc_489d5e7084d2fa0dfc82d306c28d96f6, 24

	.type	.Lalloc_60c3f71f0b6c0c17f3b699d55e0395be,@object
	.section	.data.rel.ro..Lalloc_60c3f71f0b6c0c17f3b699d55e0395be,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_60c3f71f0b6c0c17f3b699d55e0395be:
	.xword	.Lalloc_b9cc5ac15a0e0c6b4732046d7a49707c
	.asciz	"4\000\000\000\000\000\000\000\021\000\000\000>\000\000"
	.size	.Lalloc_60c3f71f0b6c0c17f3b699d55e0395be, 24

	.ident	"rustc version 1.99.0-dev"
	.section	".note.GNU-stack","",@progbits
