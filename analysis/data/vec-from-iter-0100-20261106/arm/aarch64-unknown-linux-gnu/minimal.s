	.file	"minimal.17726a61271bdaf4-cgu.0"
	.section	.text.collect_from_slice,"ax",@progbits
	.globl	collect_from_slice
	.p2align	2
	.type	collect_from_slice,@function
collect_from_slice:
	.cfi_startproc
	stp	x29, x30, [sp, #-64]!
	.cfi_def_cfa_offset 64
	str	x23, [sp, #16]
	stp	x22, x21, [sp, #32]
	stp	x20, x19, [sp, #48]
	mov	x29, sp
	.cfi_def_cfa w29, 64
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -48
	.cfi_offset w30, -56
	.cfi_offset w29, -64
	.cfi_remember_state
	mov	x19, x1
	mov	x20, x8
	cbz	x1, .LBB0_3
	mov	x22, x0
	lsl	x21, x19, #3
	bl	_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	x0, x21
	mov	w1, #8
	bl	_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc
	cbz	x0, .LBB0_5
	mov	x1, x22
	mov	x2, x21
	mov	x23, x0
	bl	memcpy
	b	.LBB0_4
.LBB0_3:
	mov	w23, #8
.LBB0_4:
	stp	x19, x23, [x20]
	str	x19, [x20, #16]
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]
	ldr	x23, [sp, #16]
	ldp	x22, x21, [sp, #32]
	ldp	x29, x30, [sp], #64
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB0_5:
	.cfi_restore_state
	mov	w0, #8
	mov	x1, x21
	bl	_RNvNtCs6sh1iPzjxYC_5alloc7raw_vec12handle_error
.Lfunc_end0:
	.size	collect_from_slice, .Lfunc_end0-collect_from_slice
	.cfi_endproc

	.section	.text.collect_from_vec,"ax",@progbits
	.globl	collect_from_vec
	.p2align	2
	.type	collect_from_vec,@function
collect_from_vec:
	.cfi_startproc
	stp	x29, x30, [sp, #-48]!
	.cfi_def_cfa_offset 48
	stp	x22, x21, [sp, #16]
	stp	x20, x19, [sp, #32]
	mov	x29, sp
	.cfi_def_cfa w29, 48
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w30, -40
	.cfi_offset w29, -48
	.cfi_remember_state
	ldr	x21, [x0, #16]
	mov	x19, x8
	cbz	x21, .LBB1_4
	ldr	x22, [x0, #8]
	lsl	x20, x21, #3
	bl	_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	x0, x20
	mov	w1, #8
	bl	_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc
	cbz	x0, .LBB1_7
	sub	x8, x22, x0
	cmn	x8, #32
	ccmp	x21, #6, #0, ls
	b.hs	.LBB1_5
	mov	x8, xzr
	b	.LBB1_8
.LBB1_4:
	mov	w0, #8
	stp	x21, x0, [x19]
	str	x21, [x19, #16]
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]
	ldp	x22, x21, [sp, #16]
	ldp	x29, x30, [sp], #48
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB1_5:
	.cfi_restore_state
	and	x8, x21, #0xfffffffffffffffc
	add	x9, x0, #16
	add	x10, x22, #16
	and	x11, x21, #0xfffffffffffffffc
.LBB1_6:
	ldp	q0, q1, [x10, #-16]
	subs	x11, x11, #4
	add	x10, x10, #32
	stp	q0, q1, [x9, #-16]
	add	x9, x9, #32
	b.ne	.LBB1_6
	b	.LBB1_9
.LBB1_7:
	mov	w0, #8
	mov	x1, x20
	bl	_RNvNtCs6sh1iPzjxYC_5alloc7raw_vec12handle_error
.LBB1_8:
	ldr	x9, [x22, x8, lsl #3]
	str	x9, [x0, x8, lsl #3]
	add	x8, x8, #1
.LBB1_9:
	cmp	x21, x8
	b.ne	.LBB1_8
	stp	x21, x0, [x19]
	str	x21, [x19, #16]
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]
	ldp	x22, x21, [sp, #16]
	ldp	x29, x30, [sp], #48
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end1:
	.size	collect_from_vec, .Lfunc_end1-collect_from_vec
	.cfi_endproc

	.section	.text.slice_to_vec,"ax",@progbits
	.globl	slice_to_vec
	.p2align	2
	.type	slice_to_vec,@function
slice_to_vec:
	.cfi_startproc
	stp	x29, x30, [sp, #-48]!
	.cfi_def_cfa_offset 48
	stp	x22, x21, [sp, #16]
	stp	x20, x19, [sp, #32]
	mov	x29, sp
	.cfi_def_cfa w29, 48
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w30, -40
	.cfi_offset w29, -48
	.cfi_remember_state
	mov	x19, x8
	cbz	x1, .LBB2_3
	mov	x20, x1
	mov	x22, x0
	lsl	x21, x1, #3
	bl	_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	x0, x21
	mov	w1, #8
	bl	_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc
	cbz	x0, .LBB2_4
	mov	x1, x22
	mov	x2, x21
	stp	x20, x0, [x19]
	bl	memcpy
	str	x20, [x19, #16]
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]
	ldp	x22, x21, [sp, #16]
	ldp	x29, x30, [sp], #48
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB2_3:
	.cfi_restore_state
	.cfi_remember_state
	mov	w8, #8
	str	xzr, [x19, #16]
	stp	xzr, x8, [x19]
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]
	ldp	x22, x21, [sp, #16]
	ldp	x29, x30, [sp], #48
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB2_4:
	.cfi_restore_state
	mov	w0, #8
	mov	x1, x21
	bl	_RNvNtCs6sh1iPzjxYC_5alloc7raw_vec12handle_error
.Lfunc_end2:
	.size	slice_to_vec, .Lfunc_end2-slice_to_vec
	.cfi_endproc

	.ident	"rustc version 1.99.0-dev"
	.section	".note.GNU-stack","",@progbits
