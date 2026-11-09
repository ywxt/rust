	.file	"rfind_shim.22da1aca951a9229-cgu.0"
	.section	.text._RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr7memrchr,"ax",@progbits
	.globl	_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr7memrchr
	.p2align	2
	.type	_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr7memrchr,@function
_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr7memrchr:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	b	copied_memrchr
.Lfunc_end0:
	.size	_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr7memrchr, .Lfunc_end0-_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr7memrchr
	.cfi_endproc

	.section	.text.aligned16_memrchr,"ax",@progbits
	.globl	aligned16_memrchr
	.p2align	2
	.type	aligned16_memrchr,@function
aligned16_memrchr:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_remember_state
	add	x8, x1, #15
	mov	x9, x2
	mov	x11, x2
	and	x8, x8, #0xfffffffffffffff0
	sub	x8, x8, x1
	cmp	x2, x8
	b.lo	.LBB1_3
	sub	w9, w2, w8
	and	x9, x9, #0xf
	subs	x9, x2, x9
	b.lo	.LBB1_18
	mov	x11, x8
.LBB1_3:
	cmp	x9, x2
	and	w10, w0, #0xff
	b.eq	.LBB1_7
	sub	x8, x2, #1
	neg	x12, x9
	mov	w0, #1
.LBB1_5:
	ldrb	w13, [x1, x8]
	cmp	w13, w10
	b.eq	.LBB1_16
	sub	x8, x8, #1
	add	x13, x12, x8
	cmn	x13, #1
	b.ne	.LBB1_5
.LBB1_7:
	mov	x8, #72340172838076673
	mov	x13, #72340172838076673
	sub	x14, x1, #16
	mul	x12, x10, x8
	movk	x13, #256
	mov	x15, #-9187201950435737472
.LBB1_8:
	mov	x8, x9
	cmp	x9, x11
	b.ls	.LBB1_10
	add	x9, x14, x8
	ldp	x16, x9, [x9]
	eor	x16, x16, x12
	eor	x9, x9, x12
	sub	x17, x13, x16
	sub	x18, x13, x9
	orr	x16, x17, x16
	orr	x9, x18, x9
	and	x9, x16, x9
	bics	xzr, x15, x9
	sub	x9, x8, #16
	b.eq	.LBB1_8
.LBB1_10:
	cmp	x8, x2
	b.hi	.LBB1_17
	cbz	x8, .LBB1_15
	sub	x8, x8, #1
	mov	w0, #1
.LBB1_13:
	ldrb	w9, [x1, x8]
	cmp	w9, w10
	b.eq	.LBB1_16
	sub	x8, x8, #1
	cmn	x8, #1
	b.ne	.LBB1_13
.LBB1_15:
	mov	x0, xzr
.LBB1_16:
	mov	x1, x8
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB1_17:
	.cfi_restore_state
	adrp	x3, .Lalloc_1325ef7790b448e0a2c41a153c42b52e
	add	x3, x3, :lo12:.Lalloc_1325ef7790b448e0a2c41a153c42b52e
	mov	x0, xzr
	mov	x1, x8
	bl	_RNvNtNtCshp6Wxz1DwXO_4core5slice5index16slice_index_fail
.LBB1_18:
	adrp	x3, .Lalloc_a9e0750e73ad813a77a999fab81f9e39
	add	x3, x3, :lo12:.Lalloc_a9e0750e73ad813a77a999fab81f9e39
	mov	x0, x9
	mov	x1, x2
	bl	_RNvNtNtCshp6Wxz1DwXO_4core5slice5index16slice_index_fail
.Lfunc_end1:
	.size	aligned16_memrchr, .Lfunc_end1-aligned16_memrchr
	.cfi_endproc

	.section	.text.copied_memrchr,"ax",@progbits
	.globl	copied_memrchr
	.p2align	2
	.type	copied_memrchr,@function
copied_memrchr:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_remember_state
	add	x8, x1, #7
	mov	x9, x2
	mov	x11, x2
	and	x8, x8, #0xfffffffffffffff8
	sub	x8, x8, x1
	cmp	x2, x8
	b.lo	.LBB2_3
	sub	w9, w2, w8
	and	x9, x9, #0xf
	subs	x9, x2, x9
	b.lo	.LBB2_18
	mov	x11, x8
.LBB2_3:
	cmp	x9, x2
	and	w10, w0, #0xff
	b.eq	.LBB2_7
	sub	x8, x2, #1
	neg	x12, x9
	mov	w0, #1
.LBB2_5:
	ldrb	w13, [x1, x8]
	cmp	w13, w10
	b.eq	.LBB2_16
	sub	x8, x8, #1
	add	x13, x12, x8
	cmn	x13, #1
	b.ne	.LBB2_5
.LBB2_7:
	mov	x8, #72340172838076673
	mov	x13, #72340172838076673
	sub	x14, x1, #16
	mul	x12, x10, x8
	movk	x13, #256
	mov	x15, #-9187201950435737472
.LBB2_8:
	mov	x8, x9
	cmp	x9, x11
	b.ls	.LBB2_10
	add	x9, x14, x8
	ldp	x16, x9, [x9]
	eor	x16, x16, x12
	eor	x9, x9, x12
	sub	x17, x13, x16
	sub	x18, x13, x9
	orr	x16, x17, x16
	orr	x9, x18, x9
	and	x9, x16, x9
	bics	xzr, x15, x9
	sub	x9, x8, #16
	b.eq	.LBB2_8
.LBB2_10:
	cmp	x8, x2
	b.hi	.LBB2_17
	cbz	x8, .LBB2_15
	sub	x8, x8, #1
	mov	w0, #1
.LBB2_13:
	ldrb	w9, [x1, x8]
	cmp	w9, w10
	b.eq	.LBB2_16
	sub	x8, x8, #1
	cmn	x8, #1
	b.ne	.LBB2_13
.LBB2_15:
	mov	x0, xzr
.LBB2_16:
	mov	x1, x8
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB2_17:
	.cfi_restore_state
	adrp	x3, .Lalloc_f49d91e209470bbc2187e976cee12e45
	add	x3, x3, :lo12:.Lalloc_f49d91e209470bbc2187e976cee12e45
	mov	x0, xzr
	mov	x1, x8
	bl	_RNvNtNtCshp6Wxz1DwXO_4core5slice5index16slice_index_fail
.LBB2_18:
	adrp	x3, .Lalloc_e294f0d591e8cd976b3cd767a1a0cda8
	add	x3, x3, :lo12:.Lalloc_e294f0d591e8cd976b3cd767a1a0cda8
	mov	x0, x9
	mov	x1, x2
	bl	_RNvNtNtCshp6Wxz1DwXO_4core5slice5index16slice_index_fail
.Lfunc_end2:
	.size	copied_memrchr, .Lfunc_end2-copied_memrchr
	.cfi_endproc

	.type	.Lalloc_e5c6b9a4157f0fdcb47844ba38a2dc41,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_e5c6b9a4157f0fdcb47844ba38a2dc41:
	.asciz	"/tmp/str-rfind-20261106/word-aligned.rs"
	.size	.Lalloc_e5c6b9a4157f0fdcb47844ba38a2dc41, 40

	.type	.Lalloc_1325ef7790b448e0a2c41a153c42b52e,@object
	.section	.data.rel.ro..Lalloc_1325ef7790b448e0a2c41a153c42b52e,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_1325ef7790b448e0a2c41a153c42b52e:
	.xword	.Lalloc_e5c6b9a4157f0fdcb47844ba38a2dc41
	.asciz	"'\000\000\000\000\000\000\000u\000\000\000\t\000\000"
	.size	.Lalloc_1325ef7790b448e0a2c41a153c42b52e, 24

	.type	.Lalloc_a9e0750e73ad813a77a999fab81f9e39,@object
	.section	.data.rel.ro..Lalloc_a9e0750e73ad813a77a999fab81f9e39,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_a9e0750e73ad813a77a999fab81f9e39:
	.xword	.Lalloc_e5c6b9a4157f0fdcb47844ba38a2dc41
	.asciz	"'\000\000\000\000\000\000\000Y\000\000\000\036\000\000"
	.size	.Lalloc_a9e0750e73ad813a77a999fab81f9e39, 24

	.type	.Lalloc_f49d91e209470bbc2187e976cee12e45,@object
	.section	.data.rel.ro..Lalloc_f49d91e209470bbc2187e976cee12e45,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_f49d91e209470bbc2187e976cee12e45:
	.xword	.Lalloc_e5c6b9a4157f0fdcb47844ba38a2dc41
	.asciz	"'\000\000\000\000\000\000\000;\000\000\000\t\000\000"
	.size	.Lalloc_f49d91e209470bbc2187e976cee12e45, 24

	.type	.Lalloc_e294f0d591e8cd976b3cd767a1a0cda8,@object
	.section	.data.rel.ro..Lalloc_e294f0d591e8cd976b3cd767a1a0cda8,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_e294f0d591e8cd976b3cd767a1a0cda8:
	.xword	.Lalloc_e5c6b9a4157f0fdcb47844ba38a2dc41
	.asciz	"'\000\000\000\000\000\000\000\037\000\000\000\036\000\000"
	.size	.Lalloc_e294f0d591e8cd976b3cd767a1a0cda8, 24

	.ident	"rustc version 1.99.0-dev"
	.section	".note.GNU-stack","",@progbits
