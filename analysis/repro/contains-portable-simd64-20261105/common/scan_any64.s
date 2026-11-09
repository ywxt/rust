	.file	"scan_any64.4a4b976d39b753f2-cgu.0"
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI0_0:
	.byte	1
	.byte	2
	.byte	4
	.byte	8
	.byte	16
	.byte	32
	.byte	64
	.byte	128
	.byte	1
	.byte	2
	.byte	4
	.byte	8
	.byte	16
	.byte	32
	.byte	64
	.byte	128
	.section	.text._RNvCs6ntgtCOtAje_10scan_any6418contains_byte_simd,"ax",@progbits
	.globl	_RNvCs6ntgtCOtAje_10scan_any6418contains_byte_simd
	.p2align	2
	.type	_RNvCs6ntgtCOtAje_10scan_any6418contains_byte_simd,@function
_RNvCs6ntgtCOtAje_10scan_any6418contains_byte_simd:
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
	ldp	q2, q1, [x0, #32]
	adrp	x8, .LCPI0_0
	ldp	q4, q3, [x0]
	ldr	q5, [x8, :lo12:.LCPI0_0]
	cmeq	v2.16b, v2.16b, v0.16b
	cmeq	v1.16b, v1.16b, v0.16b
	cmeq	v4.16b, v4.16b, v0.16b
	cmeq	v3.16b, v3.16b, v0.16b
	and	v2.16b, v2.16b, v5.16b
	and	v1.16b, v1.16b, v5.16b
	and	v4.16b, v4.16b, v5.16b
	and	v3.16b, v3.16b, v5.16b
	addp	v2.16b, v2.16b, v2.16b
	addp	v1.16b, v1.16b, v1.16b
	addp	v4.16b, v4.16b, v4.16b
	addp	v3.16b, v3.16b, v3.16b
	addp	v2.16b, v2.16b, v2.16b
	addp	v1.16b, v1.16b, v1.16b
	addp	v4.16b, v4.16b, v4.16b
	addp	v3.16b, v3.16b, v3.16b
	addp	v2.16b, v2.16b, v2.16b
	addp	v1.16b, v1.16b, v1.16b
	addp	v4.16b, v4.16b, v4.16b
	addp	v3.16b, v3.16b, v3.16b
	umov	w8, v2.h[0]
	umov	w11, v1.h[0]
	umov	w10, v4.h[0]
	umov	w12, v3.h[0]
	orr	w8, w10, w8
	orr	w10, w12, w11
	orr	w8, w8, w10
	tst	w8, #0xffff
	b.ne	.LBB0_2
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
	adrp	x10, .LCPI0_0
	and	x11, x8, #0x7fffffffffffffc0
	add	x9, x0, x9
	ldr	q1, [x10, :lo12:.LCPI0_0]
	neg	x10, x11
.LBB0_9:
	ldp	q2, q3, [x9]
	ldp	q5, q4, [x9, #32]
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
	umov	w11, v2.h[0]
	umov	w13, v3.h[0]
	umov	w12, v5.h[0]
	umov	w14, v4.h[0]
	orr	w11, w11, w12
	orr	w12, w13, w14
	orr	w11, w11, w12
	tst	w11, #0xffff
	b.ne	.LBB0_2
	adds	x10, x10, #64
	add	x9, x9, #64
	b.ne	.LBB0_9
.LBB0_11:
	and	x8, x8, #0x3f
	cbz	x8, .LBB0_14
	subs	x8, x1, #64
	b.lo	.LBB0_15
	add	x8, x0, x8
	ldp	q2, q1, [x8]
	ldp	q3, q4, [x8, #32]
	cmeq	v1.16b, v1.16b, v0.16b
	cmeq	v4.16b, v4.16b, v0.16b
	cmeq	v3.16b, v3.16b, v0.16b
	cmeq	v0.16b, v2.16b, v0.16b
	orr	v0.16b, v0.16b, v3.16b
	orr	v1.16b, v1.16b, v4.16b
	orr	v0.16b, v0.16b, v1.16b
	umaxv	b0, v0.16b
	fmov	w8, s0
	and	w0, w8, #0x1
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
	adrp	x3, .Lalloc_f0813bd2e45fdae282d6aa269171e406
	add	x3, x3, :lo12:.Lalloc_f0813bd2e45fdae282d6aa269171e406
	mov	x0, x8
	mov	x2, x1
	bl	_RNvNtNtCshp6Wxz1DwXO_4core5slice5index16slice_index_fail
.LBB0_16:
	adrp	x2, .Lalloc_1a304f7a520f2f1b52a90e3815a7ecbb
	add	x2, x2, :lo12:.Lalloc_1a304f7a520f2f1b52a90e3815a7ecbb
	mov	x0, xzr
	bl	_RNvNtCshp6Wxz1DwXO_4core9panicking18panic_bounds_check
.Lfunc_end0:
	.size	_RNvCs6ntgtCOtAje_10scan_any6418contains_byte_simd, .Lfunc_end0-_RNvCs6ntgtCOtAje_10scan_any6418contains_byte_simd
	.cfi_endproc

	.type	.Lalloc_1e1b9f5273a84b87a14ebe29aa0a2382,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_1e1b9f5273a84b87a14ebe29aa0a2382:
	.asciz	"/tmp/contains-portable-simd64-20261105/scan_any64.rs"
	.size	.Lalloc_1e1b9f5273a84b87a14ebe29aa0a2382, 53

	.type	.Lalloc_1a304f7a520f2f1b52a90e3815a7ecbb,@object
	.section	.data.rel.ro..Lalloc_1a304f7a520f2f1b52a90e3815a7ecbb,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_1a304f7a520f2f1b52a90e3815a7ecbb:
	.xword	.Lalloc_1e1b9f5273a84b87a14ebe29aa0a2382
	.asciz	"4\000\000\000\000\000\000\000\004\000\000\000\b\000\000"
	.size	.Lalloc_1a304f7a520f2f1b52a90e3815a7ecbb, 24

	.type	.Lalloc_f0813bd2e45fdae282d6aa269171e406,@object
	.section	.data.rel.ro..Lalloc_f0813bd2e45fdae282d6aa269171e406,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_f0813bd2e45fdae282d6aa269171e406:
	.xword	.Lalloc_1e1b9f5273a84b87a14ebe29aa0a2382
	.asciz	"4\000\000\000\000\000\000\000\021\000\000\000>\000\000"
	.size	.Lalloc_f0813bd2e45fdae282d6aa269171e406, 24

	.ident	"rustc version 1.99.0-dev"
	.section	".note.GNU-stack","",@progbits
