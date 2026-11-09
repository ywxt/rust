	.file	"diagnostic_portable.314cb60ea13ae64c-cgu.0"
	.section	.text._RNvCs4eq5VhZJSXw_19diagnostic_portable16contains_byte_64,"ax",@progbits
	.globl	_RNvCs4eq5VhZJSXw_19diagnostic_portable16contains_byte_64
	.p2align	2
	.type	_RNvCs4eq5VhZJSXw_19diagnostic_portable16contains_byte_64,@function
_RNvCs4eq5VhZJSXw_19diagnostic_portable16contains_byte_64:
	.cfi_startproc
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_remember_state
	cmp	x1, #64
	str	x1, [sp, #8]
	b.ne	.LBB0_2
	dup	v0.16b, w2
	ldp	q3, q1, [x0, #16]
	ldr	q2, [x0]
	ldr	q4, [x0, #48]
	cmeq	v1.16b, v1.16b, v0.16b
	cmeq	v3.16b, v3.16b, v0.16b
	cmeq	v2.16b, v2.16b, v0.16b
	cmeq	v0.16b, v4.16b, v0.16b
	orr	v2.16b, v2.16b, v3.16b
	orr	v0.16b, v1.16b, v0.16b
	orr	v0.16b, v2.16b, v0.16b
	addp	d0, v0.2d
	fmov	x8, d0
	cmp	x8, #0
	cset	w0, ne
	.cfi_def_cfa wsp, 32
	ldp	x29, x30, [sp, #16]
	add	sp, sp, #32
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB0_2:
	.cfi_restore_state
	adrp	x2, .Lalloc_a57caa216b7f7cdbaccf41839ba4d102
	add	x2, x2, :lo12:.Lalloc_a57caa216b7f7cdbaccf41839ba4d102
	adrp	x5, .Lalloc_af090e5f3d84b660ae7e6e77cbbce6ad
	add	x5, x5, :lo12:.Lalloc_af090e5f3d84b660ae7e6e77cbbce6ad
	add	x1, sp, #8
	mov	w0, wzr
	mov	x3, xzr
	bl	_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedjjEB4_
.Lfunc_end0:
	.size	_RNvCs4eq5VhZJSXw_19diagnostic_portable16contains_byte_64, .Lfunc_end0-_RNvCs4eq5VhZJSXw_19diagnostic_portable16contains_byte_64
	.cfi_endproc

	.type	.Lalloc_a57caa216b7f7cdbaccf41839ba4d102,@object
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.Lalloc_a57caa216b7f7cdbaccf41839ba4d102:
	.asciz	"@\000\000\000\000\000\000"
	.size	.Lalloc_a57caa216b7f7cdbaccf41839ba4d102, 8

	.type	.Lalloc_306de6403fa5da3f8d5b0117c61bb51a,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_306de6403fa5da3f8d5b0117c61bb51a:
	.asciz	"/tmp/contains-portable-simd-20261105/diagnostic_portable.rs"
	.size	.Lalloc_306de6403fa5da3f8d5b0117c61bb51a, 60

	.type	.Lalloc_af090e5f3d84b660ae7e6e77cbbce6ad,@object
	.section	.data.rel.ro..Lalloc_af090e5f3d84b660ae7e6e77cbbce6ad,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_af090e5f3d84b660ae7e6e77cbbce6ad:
	.xword	.Lalloc_306de6403fa5da3f8d5b0117c61bb51a
	.asciz	";\000\000\000\000\000\000\000\n\000\000\000\005\000\000"
	.size	.Lalloc_af090e5f3d84b660ae7e6e77cbbce6ad, 24

	.ident	"rustc version 1.99.0-dev"
	.section	".note.GNU-stack","",@progbits
