	.file	"wordlib.b87ebe2fed1e2186-cgu.0"
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
	b.lo	.LBB0_3
	sub	w9, w2, w8
	and	x9, x9, #0xf
	subs	x9, x2, x9
	b.lo	.LBB0_18
	mov	x11, x8
.LBB0_3:
	cmp	x9, x2
	and	w10, w0, #0xff
	b.eq	.LBB0_7
	sub	x8, x2, #1
	neg	x12, x9
	mov	w0, #1
.LBB0_5:
	ldrb	w13, [x1, x8]
	cmp	w13, w10
	b.eq	.LBB0_16
	sub	x8, x8, #1
	add	x13, x12, x8
	cmn	x13, #1
	b.ne	.LBB0_5
.LBB0_7:
	mov	x8, #72340172838076673
	mov	x13, #72340172838076673
	sub	x14, x1, #8
	mul	x12, x10, x8
	movk	x13, #256
	mov	x15, #-9187201950435737472
.LBB0_8:
	mov	x8, x9
	cmp	x9, x11
	b.ls	.LBB0_10
	add	x9, x14, x8
	ldp	x16, x9, [x9, #-8]
	eor	x16, x16, x12
	eor	x9, x9, x12
	sub	x17, x13, x16
	sub	x18, x13, x9
	orr	x16, x17, x16
	orr	x9, x18, x9
	and	x9, x16, x9
	bics	xzr, x15, x9
	sub	x9, x8, #16
	b.eq	.LBB0_8
.LBB0_10:
	cmp	x8, x2
	b.hi	.LBB0_17
	cbz	x8, .LBB0_15
	sub	x8, x8, #1
	mov	w0, #1
.LBB0_13:
	ldrb	w9, [x1, x8]
	cmp	w9, w10
	b.eq	.LBB0_16
	sub	x8, x8, #1
	cmn	x8, #1
	b.ne	.LBB0_13
.LBB0_15:
	mov	x0, xzr
.LBB0_16:
	mov	x1, x8
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB0_17:
	.cfi_restore_state
	adrp	x3, .Lalloc_f77b16add3c824dd405a5b8eb5c54c47
	add	x3, x3, :lo12:.Lalloc_f77b16add3c824dd405a5b8eb5c54c47
	mov	x0, xzr
	mov	x1, x8
	bl	_RNvNtNtCshp6Wxz1DwXO_4core5slice5index16slice_index_fail
.LBB0_18:
	adrp	x3, .Lalloc_3d26d86a09d4c08e50f7e3a9c381d0f1
	add	x3, x3, :lo12:.Lalloc_3d26d86a09d4c08e50f7e3a9c381d0f1
	mov	x0, x9
	mov	x1, x2
	bl	_RNvNtNtCshp6Wxz1DwXO_4core5slice5index16slice_index_fail
.Lfunc_end0:
	.size	copied_memrchr, .Lfunc_end0-copied_memrchr
	.cfi_endproc

	.type	.Lalloc_088a2d5149e17651a8647d6a8e1ed81c,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_088a2d5149e17651a8647d6a8e1ed81c:
	.asciz	"/tmp/str-rfind-20261106/word.rs"
	.size	.Lalloc_088a2d5149e17651a8647d6a8e1ed81c, 32

	.type	.Lalloc_f77b16add3c824dd405a5b8eb5c54c47,@object
	.section	.data.rel.ro..Lalloc_f77b16add3c824dd405a5b8eb5c54c47,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_f77b16add3c824dd405a5b8eb5c54c47:
	.xword	.Lalloc_088a2d5149e17651a8647d6a8e1ed81c
	.asciz	"\037\000\000\000\000\000\000\000;\000\000\000\t\000\000"
	.size	.Lalloc_f77b16add3c824dd405a5b8eb5c54c47, 24

	.type	.Lalloc_3d26d86a09d4c08e50f7e3a9c381d0f1,@object
	.section	.data.rel.ro..Lalloc_3d26d86a09d4c08e50f7e3a9c381d0f1,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_3d26d86a09d4c08e50f7e3a9c381d0f1:
	.xword	.Lalloc_088a2d5149e17651a8647d6a8e1ed81c
	.asciz	"\037\000\000\000\000\000\000\000\037\000\000\000\036\000\000"
	.size	.Lalloc_3d26d86a09d4c08e50f7e3a9c381d0f1, 24

	.ident	"rustc version 1.99.0-dev"
	.section	".note.GNU-stack","",@progbits
