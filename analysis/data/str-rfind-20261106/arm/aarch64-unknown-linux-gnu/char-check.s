	.file	"char_check.74cb049094147fd0-cgu.0"
	.section	.text._RINvNtCs68fcPop4ROg_3std2rt10lang_startuECsa1GziGG0QHQ_10char_check,"ax",@progbits
	.hidden	_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECsa1GziGG0QHQ_10char_check
	.globl	_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECsa1GziGG0QHQ_10char_check
	.p2align	2
	.type	_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECsa1GziGG0QHQ_10char_check,@function
_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECsa1GziGG0QHQ_10char_check:
	.cfi_startproc
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w4, w3
	mov	x3, x2
	mov	x2, x1
	str	x0, [sp, #8]
	adrp	x1, .Lvtable.0
	add	x1, x1, :lo12:.Lvtable.0
	add	x0, sp, #8
	bl	_RNvNtCs68fcPop4ROg_3std2rt19lang_start_internal
	.cfi_def_cfa wsp, 32
	ldp	x29, x30, [sp, #16]
	add	sp, sp, #32
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end0:
	.size	_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECsa1GziGG0QHQ_10char_check, .Lfunc_end0-_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECsa1GziGG0QHQ_10char_check
	.cfi_endproc

	.section	.text._RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsa1GziGG0QHQ_10char_check,"ax",@progbits
	.p2align	2
	.type	_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsa1GziGG0QHQ_10char_check,@function
_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsa1GziGG0QHQ_10char_check:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	blr	x0
	//APP
	//NO_APP
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end1:
	.size	_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsa1GziGG0QHQ_10char_check, .Lfunc_end1-_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsa1GziGG0QHQ_10char_check
	.cfi_endproc

	.section	.text.unlikely._RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsa1GziGG0QHQ_10char_check,"ax",@progbits
	.p2align	2
	.type	_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsa1GziGG0QHQ_10char_check,@function
_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsa1GziGG0QHQ_10char_check:
	.cfi_startproc
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	stp	x29, x30, [sp, #32]
	stp	x20, x19, [sp, #48]
	add	x29, sp, #32
	.cfi_def_cfa w29, 32
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w30, -24
	.cfi_offset w29, -32
	.cfi_remember_state
	adds	x8, x2, x1
	b.hs	.LBB2_3
	ldp	x1, x2, [x0]
	mov	x19, x0
	add	x0, sp, #8
	lsl	x9, x1, #1
	cmp	x8, x9
	csel	x8, x8, x9, hi
	mov	w9, #8
	cmp	x8, #8
	csel	x20, x8, x9, hi
	mov	x3, x20
	bl	_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsa1GziGG0QHQ_10char_check
	ldr	x8, [sp, #8]
	cbnz	x8, .LBB2_4
	ldr	x8, [sp, #16]
	stp	x20, x8, [x19]
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]
	ldp	x29, x30, [sp, #32]
	add	sp, sp, #64
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB2_3:
	.cfi_restore_state
	mov	x0, xzr
	bl	_RNvNtCs6sh1iPzjxYC_5alloc7raw_vec12handle_error
.LBB2_4:
	ldp	x0, x1, [sp, #16]
	bl	_RNvNtCs6sh1iPzjxYC_5alloc7raw_vec12handle_error
.Lfunc_end2:
	.size	_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsa1GziGG0QHQ_10char_check, .Lfunc_end2-_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsa1GziGG0QHQ_10char_check
	.cfi_endproc

	.section	.text._RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Csa1GziGG0QHQ_10char_check,"ax",@progbits
	.p2align	2
	.type	_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Csa1GziGG0QHQ_10char_check,@function
_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Csa1GziGG0QHQ_10char_check:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x0, [x0]
	bl	_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsa1GziGG0QHQ_10char_check
	mov	w0, wzr
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end3:
	.size	_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Csa1GziGG0QHQ_10char_check, .Lfunc_end3-_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Csa1GziGG0QHQ_10char_check
	.cfi_endproc

	.section	.text._RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCsa1GziGG0QHQ_10char_check,"ax",@progbits
	.p2align	2
	.type	_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCsa1GziGG0QHQ_10char_check,@function
_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCsa1GziGG0QHQ_10char_check:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x0, [x0]
	bl	_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsa1GziGG0QHQ_10char_check
	mov	w0, wzr
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end4:
	.size	_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCsa1GziGG0QHQ_10char_check, .Lfunc_end4-_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCsa1GziGG0QHQ_10char_check
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI5_0:
	.word	97
	.word	95
	.word	0
	.word	164
.LCPI5_1:
	.word	233
	.word	20013
	.word	128169
	.word	128164
.LCPI5_2:
	.xword	6
	.xword	0
.LCPI5_3:
	.xword	1
	.xword	7
.LCPI5_4:
	.xword	8
	.xword	15
	.section	.text._RNvCsa1GziGG0QHQ_10char_check4main,"ax",@progbits
	.hidden	_RNvCsa1GziGG0QHQ_10char_check4main
	.globl	_RNvCsa1GziGG0QHQ_10char_check4main
	.p2align	2
	.type	_RNvCsa1GziGG0QHQ_10char_check4main,@function
_RNvCsa1GziGG0QHQ_10char_check4main:
.Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 156, DW.ref.rust_eh_personality
	.cfi_lsda 28, .Lexception0
	stp	x29, x30, [sp, #-96]!
	.cfi_def_cfa_offset 96
	stp	x28, x27, [sp, #16]
	stp	x26, x25, [sp, #32]
	stp	x24, x23, [sp, #48]
	stp	x22, x21, [sp, #64]
	stp	x20, x19, [sp, #80]
	mov	x29, sp
	.cfi_def_cfa w29, 96
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	.cfi_offset w25, -56
	.cfi_offset w26, -64
	.cfi_offset w27, -72
	.cfi_offset w28, -80
	.cfi_offset w30, -88
	.cfi_offset w29, -96
	.cfi_remember_state
	sub	sp, sp, #496
	adrp	x8, .LCPI5_0
	adrp	x9, .LCPI5_1
	mov	w10, #1114111
	ldr	q0, [x8, :lo12:.LCPI5_0]
	add	x8, sp, #224
	ldr	q1, [x9, :lo12:.LCPI5_1]
	sub	x9, x29, #160
	add	x8, x8, #16
	str	w10, [sp, #208]
	sub	x10, x29, #56
	str	x8, [sp, #96]
	add	x8, x9, #16
	str	x8, [sp, #144]
	add	x8, x10, #16
	adrp	x9, .LCPI5_4
	str	x8, [sp, #128]
	mov	w8, #1
	mov	x11, xzr
	str	x8, [sp, #8]
	adrp	x8, .LCPI5_2
	add	x21, x10, #32
	stp	q0, q1, [sp, #176]
	ldr	q0, [x8, :lo12:.LCPI5_2]
	adrp	x8, .LCPI5_3
	str	wzr, [sp, #220]
	str	q0, [sp, #64]
	ldr	q0, [x8, :lo12:.LCPI5_3]
	str	q0, [sp, #48]
	ldr	q0, [x9, :lo12:.LCPI5_4]
	str	q0, [sp, #32]
.LBB5_1:
	mov	x25, x11
	add	x26, sp, #176
	str	xzr, [sp, #88]
	str	x11, [sp, #16]
.LBB5_2:
	mov	w8, #1
	stur	xzr, [x29, #-144]
	stp	xzr, x8, [x29, #-160]
	str	x26, [sp, #24]
	cbnz	x25, .LBB5_153
	mov	w8, #1
	mov	x26, xzr
	str	xzr, [sp, #104]
	str	x8, [sp, #80]
.LBB5_4:
	ldp	q0, q1, [sp, #48]
	add	x8, sp, #9
	mov	x9, xzr
	str	x26, [sp, #136]
	stur	q0, [sp, #248]
	ldr	q0, [sp, #32]
	stur	q1, [sp, #232]
	stur	q0, [x8, #255]
	ldr	x8, [sp, #88]
	add	x8, x8, #1
	str	x8, [sp, #88]
	mov	w8, #31
	str	x8, [sp, #280]
	b	.LBB5_6
.LBB5_5:
	ldr	x9, [sp, #112]
	cmp	x9, #6
	b.eq	.LBB5_150
.LBB5_6:
	mov	x8, x9
	ldr	x9, [sp, #96]
	add	x22, x8, #1
	ldr	x23, [x9, x8, lsl #3]
	str	x22, [sp, #224]
	str	x22, [sp, #112]
	cbz	x23, .LBB5_13
	tbnz	x23, #63, .LBB5_179
	bl	_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	x0, x23
	mov	w1, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc
	cbz	x0, .LBB5_180
	lsr	x20, x23, #1
	mov	x24, x0
	mov	w8, #120
	mov	w19, #1
	strb	w8, [x0]
	cbz	x20, .LBB5_11
.LBB5_10:
	add	x0, x24, x19
	mov	x1, x24
	mov	x2, x19
	bl	memcpy
	lsr	x20, x20, #1
	lsl	x19, x19, #1
	cbnz	x20, .LBB5_10
.LBB5_11:
	subs	x2, x23, x19
	b.eq	.LBB5_14
	add	x0, x24, x19
	mov	x1, x24
	bl	memcpy
	b	.LBB5_14
.LBB5_13:
	mov	w24, #1
.LBB5_14:
	ldr	x20, [sp, #104]
	mov	x25, x23
	mov	x19, x23
	stp	x23, x24, [x29, #-160]
	stur	x23, [x29, #-144]
	cbnz	x20, .LBB5_148
	add	x1, x19, x20
	cbz	x23, .LBB5_19
.LBB5_16:
	cmp	x1, x23
	b.ls	.LBB5_18
	ldrsb	w8, [x24, x23]
	cmn	w8, #65
	b.gt	.LBB5_19
	b	.LBB5_178
.LBB5_18:
	b.ne	.LBB5_178
.LBB5_19:
	add	x8, x24, x23
	sub	x9, x1, x23
	stp	x25, x24, [sp, #152]
	stp	x8, x9, [x29, #-208]
	sub	x8, x29, #208
	mov	x22, xzr
	//APP
	//NO_APP
	ldp	q0, q1, [sp, #176]
	ldr	w8, [sp, #208]
	ldr	x9, [sp, #144]
	str	w8, [x9, #32]
	mov	w8, #9
	stp	q0, q1, [x9]
	stur	x8, [x29, #-152]
	b	.LBB5_22
.LBB5_20:
	cmp	x24, x25
	stur	xzr, [x29, #-56]
	b.ne	.LBB5_172
.LBB5_21:
	ldr	w8, [sp, #220]
	ldr	x26, [sp, #136]
	cmp	x22, #9
	add	w8, w8, #1
	str	w8, [sp, #220]
	b.eq	.LBB5_51
.LBB5_22:
	ldp	x24, x9, [x29, #-208]
	ldr	x8, [sp, #144]
	ldr	w8, [x8, x22, lsl #2]
	add	x22, x22, #1
	add	x9, x24, x9
	stur	x22, [x29, #-160]
	b	.LBB5_26
.LBB5_23:
	and	w11, w11, #0x1f
.LBB5_24:
	and	w10, w10, #0x3f
	orr	w10, w10, w11, lsl #6
.LBB5_25:
	cmp	w10, w8
	b.eq	.LBB5_34
.LBB5_26:
	mov	x25, x9
	cmp	x24, x9
	b.eq	.LBB5_33
	mov	x9, x25
	ldrsb	w10, [x9, #-1]!
	tbz	w10, #31, .LBB5_25
	mov	x9, x25
	ldrsb	w11, [x9, #-2]!
	cmn	w11, #64
	b.ge	.LBB5_23
	mov	x9, x25
	ldrsb	w12, [x9, #-3]!
	cmn	w12, #64
	b.ge	.LBB5_31
	mov	x9, x25
	and	w12, w12, #0xff
	ldrb	w13, [x9, #-4]!
	and	w12, w12, #0x3f
	bfi	w12, w13, #6, #3
	b	.LBB5_32
.LBB5_31:
	and	w12, w12, #0xf
.LBB5_32:
	and	w11, w11, #0xff
	and	w11, w11, #0x3f
	orr	w11, w11, w12, lsl #6
	b	.LBB5_24
.LBB5_33:
	mov	x9, xzr
	b	.LBB5_35
.LBB5_34:
	sub	x9, x9, x24
	str	x9, [sp, #120]
	stur	x9, [x29, #-168]
	mov	w9, #1
.LBB5_35:
	str	x9, [sp, #168]
	stur	x9, [x29, #-176]
	stur	w8, [x29, #-192]
	sub	x8, x29, #192
	//APP
	//NO_APP
	ldur	w8, [x29, #-192]
	ldp	x23, x26, [x29, #-208]
	cmp	w8, #128
	b.hs	.LBB5_37
	mov	w10, wzr
	mov	w12, wzr
	mov	w9, wzr
	mov	w11, w8
	mov	w28, #1
	b	.LBB5_42
.LBB5_37:
	mov	w9, #128
	cmp	w8, #2047
	bfxil	w9, w8, #0, #6
	b.hi	.LBB5_39
	lsr	w11, w8, #6
	mov	w10, wzr
	mov	w12, wzr
	mov	w28, #2
	orr	w11, w11, #0xc0
	b	.LBB5_42
.LBB5_39:
	mov	w13, #128
	lsr	w10, w8, #16
	bfxil	w13, w8, #6, #6
	cbnz	w10, .LBB5_41
	lsr	w11, w8, #12
	mov	w12, w9
	mov	w9, w13
	mov	w28, #3
	orr	w11, w11, #0xe0
	b	.LBB5_42
.LBB5_41:
	mov	w14, #128
	lsr	w11, w8, #18
	lsl	w10, w9, #24
	bfxil	w14, w8, #12, #6
	mov	w12, w13
	mov	w28, #4
	orr	w11, w11, #0xf0
	mov	w9, w14
.LBB5_42:
	orr	w10, w10, w12, lsl #16
	sub	x20, x28, #1
	mov	x19, x26
	stur	x26, [x29, #-32]
	orr	w9, w10, w9, lsl #8
	and	w10, w11, #0xff
	sturb	w28, [x29, #-16]
	orr	w9, w9, w10
	stp	w9, w8, [x29, #-24]
	b	.LBB5_44
.LBB5_43:
	cmp	x19, x26
	stur	x19, [x29, #-32]
	b.hi	.LBB5_20
.LBB5_44:
	ldrb	w0, [x21, x20]
.Ltmp15:
	mov	x1, x23
	mov	x2, x19
	bl	_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr7memrchr
.Ltmp16:
	cmp	x0, #1
	b.ne	.LBB5_20
	mov	x19, x1
	cmp	x1, x20
	b.lo	.LBB5_43
	sub	x27, x19, x20
	adds	x8, x27, x28
	cset	w9, hs
	cmp	x8, x26
	csinc	w8, w9, wzr, ls
	tbnz	w8, #0, .LBB5_43
	add	x0, x23, x27
	mov	x1, x21
	mov	x2, x28
	bl	bcmp
	cbnz	w0, .LBB5_43
	ldr	x8, [sp, #120]
	cmp	x27, x8
	mov	w8, #1
	stp	x8, x27, [x29, #-56]
	b.ne	.LBB5_172
	ldr	x8, [sp, #168]
	tbnz	w8, #0, .LBB5_21
	b	.LBB5_172
.LBB5_51:
	mov	w8, #3
	ldp	x25, x24, [sp, #152]
	stur	x8, [x29, #-48]
	mov	x8, #95
	mov	x19, xzr
	movk	x8, #97, lsl #32
	stur	wzr, [x29, #-32]
	stur	x8, [x29, #-40]
	b	.LBB5_54
.LBB5_52:
	cmp	x25, x24
	stur	xzr, [x29, #-160]
	ldp	x25, x24, [sp, #152]
	b.ne	.LBB5_171
.LBB5_53:
	ldr	w8, [sp, #220]
	mov	x0, x23
	mov	x1, x28
	mov	w2, #1
	add	w8, w8, #1
	str	w8, [sp, #220]
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	cmp	x19, #3
	b.eq	.LBB5_146
.LBB5_54:
	ldr	x8, [sp, #128]
	stur	wzr, [x29, #-160]
	ldr	w20, [x8, x19, lsl #2]
	add	x19, x19, #1
	stur	x19, [x29, #-56]
	cmp	w20, #128
	b.hs	.LBB5_56
	mov	w28, #1
	sturb	w20, [x29, #-160]
	bl	_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	x0, x28
	mov	w1, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc
	cbnz	x0, .LBB5_61
	b	.LBB5_176
.LBB5_56:
	mov	w8, #-128
	cmp	w20, #2048
	bfxil	w8, w20, #0, #6
	b.hs	.LBB5_58
	lsr	w9, w20, #6
	sturb	w8, [x29, #-159]
	mov	w28, #2
	orr	w9, w9, #0xc0
	sturb	w9, [x29, #-160]
	bl	_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	x0, x28
	mov	w1, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc
	cbnz	x0, .LBB5_61
	b	.LBB5_176
.LBB5_58:
	mov	w9, #-128
	lsr	w10, w20, #16
	bfxil	w9, w20, #6, #6
	cbnz	w10, .LBB5_60
	lsr	w10, w20, #12
	sturb	w9, [x29, #-159]
	mov	w28, #3
	sturb	w8, [x29, #-158]
	orr	w9, w10, #0xe0
	sturb	w9, [x29, #-160]
	bl	_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	x0, x28
	mov	w1, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc
	cbnz	x0, .LBB5_61
	b	.LBB5_176
.LBB5_60:
	lsr	w10, w20, #18
	mov	w11, #-128
	sturb	w9, [x29, #-158]
	bfxil	w11, w20, #12, #6
	sturb	w8, [x29, #-157]
	mov	w28, #4
	orr	w9, w10, #0xfffffff0
	sturb	w9, [x29, #-160]
	sturb	w11, [x29, #-159]
	bl	_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	x0, x28
	mov	w1, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc
	cbz	x0, .LBB5_176
.LBB5_61:
	sub	x1, x29, #160
	mov	x2, x28
	mov	x23, x0
	bl	memcpy
	ldp	x25, x8, [x29, #-208]
	add	x8, x25, x8
	b	.LBB5_65
.LBB5_62:
	and	w10, w10, #0x1f
.LBB5_63:
	and	w9, w9, #0x3f
	orr	w9, w9, w10, lsl #6
.LBB5_64:
	cmp	w9, w20
	b.eq	.LBB5_73
.LBB5_65:
	mov	x24, x8
	cmp	x25, x8
	b.eq	.LBB5_72
	mov	x8, x24
	ldrsb	w9, [x8, #-1]!
	tbz	w9, #31, .LBB5_64
	mov	x8, x24
	ldrsb	w10, [x8, #-2]!
	cmn	w10, #64
	b.ge	.LBB5_62
	mov	x8, x24
	ldrsb	w11, [x8, #-3]!
	cmn	w11, #64
	b.ge	.LBB5_70
	mov	x8, x24
	and	w11, w11, #0xff
	ldrb	w12, [x8, #-4]!
	and	w11, w11, #0x3f
	bfi	w11, w12, #6, #3
	b	.LBB5_71
.LBB5_70:
	and	w11, w11, #0xf
.LBB5_71:
	and	w10, w10, #0xff
	and	w10, w10, #0x3f
	orr	w10, w10, w11, lsl #6
	b	.LBB5_63
.LBB5_72:
	mov	x22, xzr
	b	.LBB5_74
.LBB5_73:
	sub	x27, x8, x25
	mov	w22, #1
	stur	x27, [x29, #-184]
.LBB5_74:
	stur	x22, [x29, #-192]
	sub	x8, x29, #176
	stp	x23, x28, [x29, #-176]
	//APP
	//NO_APP
	ldp	x0, x1, [x29, #-208]
	ldp	x2, x3, [x29, #-176]
.Ltmp21:
	sub	x8, x29, #160
	bl	_RNvMsu_NtNtCshp6Wxz1DwXO_4core3str7patternNtB5_11StrSearcher3new
.Ltmp22:
	ldur	w8, [x29, #-160]
	tbz	w8, #0, .LBB5_79
	ldur	x11, [x29, #-104]
	ldp	x8, x9, [x29, #-88]
	ldp	x10, x1, [x29, #-72]
	cmn	x11, #1
	b.eq	.LBB5_83
	ldur	x15, [x29, #-112]
	sub	x3, x15, x1
	cmp	x3, x9
	b.hs	.LBB5_52
	ldp	x11, x12, [x29, #-144]
	ldur	x13, [x29, #-128]
	ldur	x17, [x29, #-96]
	cmp	x11, x1
	neg	x16, x11
	csel	x14, x11, x1, hi
	b	.LBB5_88
.LBB5_79:
	ldurb	w8, [x29, #-134]
	tbnz	w8, #0, .LBB5_52
	ldur	x3, [x29, #-144]
	ldurb	w8, [x29, #-135]
	cbz	x3, .LBB5_100
	ldp	x0, x1, [x29, #-88]
	cmp	x3, x1
	b.hs	.LBB5_102
	ldrsb	w9, [x0, x3]
	cmn	w9, #64
	b.ge	.LBB5_103
	b	.LBB5_177
.LBB5_83:
	ldur	x13, [x29, #-112]
	sub	x3, x13, x1
	cmp	x3, x9
	b.hs	.LBB5_52
	ldp	x14, x12, [x29, #-144]
	ldur	x11, [x29, #-128]
	cmp	x14, x1
	sub	x0, x14, #1
	csel	x16, x14, x1, hi
	cmp	x0, x1
	b.hs	.LBB5_110
	sub	x15, x10, #1
	add	x10, x10, x14
	sub	x16, x16, x14
	b	.LBB5_117
.LBB5_86:
	sub	x15, x15, x11
	add	x3, x15, x0
.LBB5_87:
	mov	x17, x1
	sub	x18, x3, x1
	mov	x15, x3
	cmp	x18, x9
	mov	x3, x18
	b.hs	.LBB5_52
.LBB5_88:
	ldrb	w18, [x8, x3]
	lsr	x18, x13, x18
	tbz	w18, #0, .LBB5_87
	cmp	x17, x11
	csel	x18, x17, x11, lo
	cbz	x18, .LBB5_94
	sub	x0, x18, #1
	add	x18, x8, x3
.LBB5_91:
	cmp	x0, x1
	b.hs	.LBB5_173
	ldrb	w2, [x10, x0]
	ldrb	w4, [x18, x0]
	cmp	w2, w4
	b.ne	.LBB5_86
	sub	x0, x0, #1
	cmn	x0, #1
	b.ne	.LBB5_91
.LBB5_94:
	cmp	x17, x11
	csel	x18, x17, x11, hi
	cmp	x11, x17
	b.hs	.LBB5_143
	add	x17, x11, x3
	add	x18, x16, x18
	sub	x0, x14, x11
	add	x2, x10, x11
.LBB5_96:
	cbz	x0, .LBB5_174
	ldrb	w4, [x2], #1
	ldrb	w5, [x8, x17]
	cmp	w4, w5
	b.ne	.LBB5_99
	subs	x18, x18, #1
	sub	x0, x0, #1
	add	x17, x17, #1
	b.ne	.LBB5_96
	b	.LBB5_143
.LBB5_99:
	sub	x3, x15, x12
	mov	x17, x12
	sub	x18, x3, x1
	mov	x15, x3
	cmp	x18, x9
	mov	x3, x18
	b.lo	.LBB5_88
	b	.LBB5_52
.LBB5_100:
	and	x9, x8, #0x1
	stp	x9, xzr, [x29, #-160]
	tbnz	w8, #0, .LBB5_144
	cmp	x25, x24
	ldp	x25, x24, [sp, #152]
	b.eq	.LBB5_53
	b	.LBB5_171
.LBB5_102:
	b.ne	.LBB5_177
.LBB5_103:
	add	x11, x0, x3
	ldursb	w10, [x11, #-1]
	and	w9, w10, #0xff
	tbnz	w10, #31, .LBB5_107
	tbnz	w8, #0, .LBB5_143
.LBB5_105:
	cmp	w9, #128
	b.hs	.LBB5_127
	mov	x8, #-1
	adds	x3, x8, x3
	b.ne	.LBB5_131
	b	.LBB5_143
.LBB5_107:
	ldursb	w10, [x11, #-2]
	cmn	w10, #65
	b.gt	.LBB5_129
	ldursb	w12, [x11, #-3]
	cmn	w12, #65
	b.gt	.LBB5_142
	and	w12, w12, #0xff
	ldurb	w13, [x11, #-4]
	and	w11, w12, #0x3f
	bfi	w11, w13, #6, #3
	and	w10, w10, #0xff
	and	w10, w10, #0x3f
	orr	w10, w10, w11, lsl #6
	and	w9, w9, #0x3f
	orr	w9, w9, w10, lsl #6
	tbnz	w8, #0, .LBB5_143
	b	.LBB5_105
.LBB5_110:
	cbz	x14, .LBB5_138
	ldrb	w10, [x8, x3]
	lsr	x10, x11, x10
	tbnz	w10, #0, .LBB5_173
	sub	x10, x13, x1, lsl #1
.LBB5_113:
	cmp	x10, x9
	b.hs	.LBB5_52
	ldrb	w12, [x8, x10]
	sub	x10, x10, x1
	lsr	x12, x11, x12
	tbz	w12, #0, .LBB5_113
	b	.LBB5_173
.LBB5_115:
	sub	x3, x13, x12
.LBB5_116:
	sub	x17, x3, x1
	mov	x13, x3
	cmp	x17, x9
	mov	x3, x17
	b.hs	.LBB5_52
.LBB5_117:
	ldrb	w17, [x8, x3]
	lsr	x17, x11, x17
	tbz	w17, #0, .LBB5_116
	cbz	x14, .LBB5_122
	sub	x17, x13, #1
	add	x18, x0, x3
	mov	x2, x14
.LBB5_120:
	ldrb	w4, [x15, x2]
	ldrb	w5, [x8, x18]
	cmp	w4, w5
	b.ne	.LBB5_126
	sub	x2, x2, #1
	sub	x17, x17, #1
	sub	x18, x18, #1
	cbnz	x2, .LBB5_120
.LBB5_122:
	cmp	x14, x1
	b.hs	.LBB5_143
	add	x17, x14, x3
	mov	x18, x16
	mov	x2, x10
.LBB5_124:
	ldrb	w4, [x2], #1
	ldrb	w5, [x8, x17]
	cmp	w4, w5
	b.ne	.LBB5_115
	subs	x18, x18, #1
	add	x17, x17, #1
	b.ne	.LBB5_124
	b	.LBB5_143
.LBB5_126:
	mov	x3, x17
	b	.LBB5_116
.LBB5_127:
	cmp	w9, #2048
	b.hs	.LBB5_130
	mov	x8, #-2
	adds	x3, x8, x3
	b.ne	.LBB5_131
	b	.LBB5_143
.LBB5_129:
	and	w10, w10, #0x1f
	and	w9, w9, #0x3f
	orr	w9, w9, w10, lsl #6
	tbz	w8, #0, .LBB5_105
	b	.LBB5_143
.LBB5_130:
	cmp	w9, #16, lsl #12
	mov	x8, #-4
	cinc	x8, x8, lo
	adds	x3, x8, x3
	b.eq	.LBB5_143
.LBB5_131:
	cmp	x3, x1
	b.hs	.LBB5_133
	ldrsb	w8, [x0, x3]
	cmn	w8, #64
	b.ge	.LBB5_134
	b	.LBB5_177
.LBB5_133:
	b.ne	.LBB5_177
.LBB5_134:
	add	x8, x0, x3
	ldursb	w9, [x8, #-1]
	tbz	w9, #31, .LBB5_143
	ldursb	w8, [x8, #-2]
	cmn	w8, #65
	b	.LBB5_143
.LBB5_136:
	sub	x3, x13, x12
.LBB5_137:
	mov	x13, x3
	sub	x3, x3, x1
	cmp	x3, x9
	b.hs	.LBB5_52
.LBB5_138:
	ldrb	w14, [x8, x3]
	lsr	x14, x11, x14
	tbz	w14, #0, .LBB5_137
	mov	x14, x16
	mov	x15, x10
	mov	x17, x3
	cbz	x16, .LBB5_143
.LBB5_140:
	ldrb	w18, [x15], #1
	ldrb	w0, [x8, x17]
	cmp	w18, w0
	b.ne	.LBB5_136
	subs	x14, x14, #1
	add	x17, x17, #1
	b.ne	.LBB5_140
	b	.LBB5_143
.LBB5_142:
	and	w11, w12, #0xf
	and	w10, w10, #0xff
	and	w10, w10, #0x3f
	orr	w10, w10, w11, lsl #6
	and	w9, w9, #0x3f
	orr	w9, w9, w10, lsl #6
	tbz	w8, #0, .LBB5_105
.LBB5_143:
	mov	w8, #1
	stp	x8, x3, [x29, #-160]
.LBB5_144:
	ldp	x25, x24, [sp, #152]
	cmp	x3, x27
	b.ne	.LBB5_171
	tbnz	w22, #0, .LBB5_53
	b	.LBB5_171
.LBB5_146:
	cbz	x25, .LBB5_5
	mov	x0, x24
	mov	x1, x25
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB5_5
.LBB5_148:
.Ltmp9:
	sub	x0, x29, #160
	mov	x1, x23
	mov	x2, x20
	bl	_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsa1GziGG0QHQ_10char_check
.Ltmp10:
	ldp	x24, x19, [x29, #-152]
	mov	x2, x20
	ldr	x1, [sp, #80]
	add	x0, x24, x19
	bl	memcpy
	ldur	x25, [x29, #-160]
	add	x1, x19, x20
	cbnz	x23, .LBB5_16
	b	.LBB5_19
.LBB5_150:
	cbz	x26, .LBB5_152
	ldr	x0, [sp, #80]
	mov	x1, x26
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB5_152:
	ldp	x25, x26, [sp, #16]
	ldr	x8, [sp, #88]
	cmp	x8, #9
	add	x26, x26, #4
	add	x11, x25, #1
	b.ne	.LBB5_2
	b	.LBB5_169
.LBB5_153:
.Ltmp0:
	sub	x0, x29, #160
	mov	x1, xzr
	mov	x2, x25
	bl	_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsa1GziGG0QHQ_10char_check
.Ltmp1:
	ldur	x1, [x29, #-144]
	ldr	x22, [sp, #88]
	mov	x20, x25
	mov	x23, x26
	b	.LBB5_156
.LBB5_155:
	strb	w24, [x8]
	add	x1, x19, x1
	subs	x20, x20, #1
	add	x23, x23, #4
	add	x22, x22, #1
	stur	x1, [x29, #-144]
	b.eq	.LBB5_168
.LBB5_156:
	mov	x8, #58255
	mov	x9, #-36
	mov	x27, x1
	movk	x8, #36408, lsl #16
	movk	x8, #14563, lsl #32
	movk	x8, #58254, lsl #48
	umulh	x8, x22, x8
	lsr	x8, x8, #3
	mul	x8, x8, x9
	ldr	w24, [x23, x8]
	cmp	w24, #128
	b.hs	.LBB5_158
	mov	w19, #1
	b	.LBB5_159
.LBB5_158:
	cmp	w24, #16, lsl #12
	mov	w8, #3
	mov	w9, #2
	cinc	x8, x8, hs
	cmp	w24, #2048
	csel	x19, x9, x8, lo
.LBB5_159:
	ldur	x8, [x29, #-160]
	mov	x1, x27
	sub	x8, x8, x27
	cmp	x19, x8
	b.hi	.LBB5_167
.LBB5_160:
	ldur	x8, [x29, #-152]
	cmp	w24, #128
	str	x8, [sp, #80]
	add	x8, x8, x1
	b.lo	.LBB5_155
	mov	w9, #-128
	cmp	w24, #2048
	bfxil	w9, w24, #0, #6
	b.hs	.LBB5_163
	lsr	w10, w24, #6
	strb	w9, [x8, #1]
	orr	w10, w10, #0xc0
	strb	w10, [x8]
	b	.LBB5_166
.LBB5_163:
	mov	w10, #-128
	lsr	w11, w24, #16
	bfxil	w10, w24, #6, #6
	cbnz	w11, .LBB5_165
	lsr	w11, w24, #12
	strb	w10, [x8, #1]
	strb	w9, [x8, #2]
	orr	w10, w11, #0xe0
	strb	w10, [x8]
	b	.LBB5_166
.LBB5_165:
	lsr	w11, w24, #18
	mov	w12, #-128
	strb	w10, [x8, #2]
	bfxil	w12, w24, #12, #6
	strb	w9, [x8, #3]
	orr	w10, w11, #0xfffffff0
	strb	w10, [x8]
	strb	w12, [x8, #1]
.LBB5_166:
	add	x1, x19, x27
	subs	x20, x20, #1
	add	x23, x23, #4
	add	x22, x22, #1
	stur	x1, [x29, #-144]
	b.ne	.LBB5_156
	b	.LBB5_168
.LBB5_167:
.Ltmp3:
	sub	x0, x29, #160
	mov	x2, x19
	bl	_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsa1GziGG0QHQ_10char_check
	mov	x1, x27
.Ltmp4:
	b	.LBB5_160
.LBB5_168:
	ldur	x26, [x29, #-160]
	str	x1, [sp, #104]
	b	.LBB5_4
.LBB5_169:
	cmp	x11, #129
	b.ne	.LBB5_1
	adrp	x9, :got:_RNvXs9_NtNtNtCshp6Wxz1DwXO_4core3fmt3num3implNtB9_7Display3fmt
	add	x8, sp, #220
	adrp	x0, .Lalloc_e35b61108c387c129169318fbaa84f19
	add	x0, x0, :lo12:.Lalloc_e35b61108c387c129169318fbaa84f19
	ldr	x9, [x9, :got_lo12:_RNvXs9_NtNtNtCshp6Wxz1DwXO_4core3fmt3num3implNtB9_7Display3fmt]
	sub	x1, x29, #160
	stp	x8, x9, [x29, #-160]
	bl	_RNvNtNtCs68fcPop4ROg_3std2io5stdio6__print
	add	sp, sp, #496
	.cfi_def_cfa wsp, 96
	ldp	x20, x19, [sp, #80]
	ldp	x22, x21, [sp, #64]
	ldp	x24, x23, [sp, #48]
	ldp	x26, x25, [sp, #32]
	ldp	x28, x27, [sp, #16]
	ldp	x29, x30, [sp], #96
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w25
	.cfi_restore w26
	.cfi_restore w27
	.cfi_restore w28
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB5_171:
	.cfi_restore_state
.Ltmp28:
	adrp	x5, .Lalloc_41f2d315767eaaec6af3e31fc87caeb8
	add	x5, x5, :lo12:.Lalloc_41f2d315767eaaec6af3e31fc87caeb8
	sub	x1, x29, #160
	sub	x2, x29, #192
	mov	w0, wzr
	mov	x3, xzr
	bl	_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedINtNtB4_6option6OptionjEBM_EB4_
.Ltmp29:
	b	.LBB5_181
.LBB5_172:
.Ltmp18:
	ldp	x25, x24, [sp, #152]
	adrp	x5, .Lalloc_a877d8f58214054011e63c44aec5b78c
	add	x5, x5, :lo12:.Lalloc_a877d8f58214054011e63c44aec5b78c
	sub	x1, x29, #56
	sub	x2, x29, #176
	mov	w0, wzr
	mov	x3, xzr
	ldr	x26, [sp, #136]
	bl	_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedINtNtB4_6option6OptionjEBM_EB4_
.Ltmp19:
	b	.LBB5_181
.LBB5_173:
	adrp	x2, .Lalloc_8819073e04e9b8e5c06efc9cd6763319
	add	x2, x2, :lo12:.Lalloc_8819073e04e9b8e5c06efc9cd6763319
	b	.LBB5_175
.LBB5_174:
	mov	x0, x14
	adrp	x2, .Lalloc_57e9d1db5edcf44fe5250fc671c984f9
	add	x2, x2, :lo12:.Lalloc_57e9d1db5edcf44fe5250fc671c984f9
.LBB5_175:
.Ltmp26:
	ldp	x25, x24, [sp, #152]
	bl	_RNvNtCshp6Wxz1DwXO_4core9panicking18panic_bounds_check
.Ltmp27:
	b	.LBB5_181
.LBB5_176:
.Ltmp31:
	mov	w0, #1
	mov	x1, x28
	bl	_RNvNtCs6sh1iPzjxYC_5alloc7raw_vec12handle_error
.Ltmp32:
	b	.LBB5_181
.LBB5_177:
	ldp	x25, x24, [sp, #152]
.Ltmp24:
	adrp	x4, .Lalloc_ddc11afbdf6e6371e27b90abd6d51e89
	add	x4, x4, :lo12:.Lalloc_ddc11afbdf6e6371e27b90abd6d51e89
	mov	x2, xzr
	bl	_RNvNtCshp6Wxz1DwXO_4core3str16slice_error_fail
.Ltmp25:
	b	.LBB5_181
.LBB5_178:
.Ltmp12:
	adrp	x4, .Lalloc_7458713cc1a266feb0040d33e8f549cc
	add	x4, x4, :lo12:.Lalloc_7458713cc1a266feb0040d33e8f549cc
	mov	x0, x24
	mov	x2, x23
	mov	x3, x1
	bl	_RNvNtCshp6Wxz1DwXO_4core3str16slice_error_fail
.Ltmp13:
	b	.LBB5_181
.LBB5_179:
	str	xzr, [sp, #8]
.LBB5_180:
.Ltmp6:
	ldr	x0, [sp, #8]
	mov	x1, x23
	bl	_RNvNtCs6sh1iPzjxYC_5alloc7raw_vec12handle_error
.Ltmp7:
.LBB5_181:
	brk	#0x1
.LBB5_182:
.Ltmp5:
	b	.LBB5_184
.LBB5_183:
.Ltmp2:
.LBB5_184:
	ldur	x1, [x29, #-160]
	mov	x21, x0
	cbz	x1, .LBB5_201
	ldur	x0, [x29, #-152]
	b	.LBB5_200
.LBB5_186:
.Ltmp11:
	ldur	x1, [x29, #-160]
	mov	x21, x0
	cbz	x1, .LBB5_190
	ldur	x0, [x29, #-152]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB5_190
.LBB5_188:
.Ltmp14:
	mov	x21, x0
	cbnz	x25, .LBB5_197
	b	.LBB5_198
.LBB5_189:
.Ltmp8:
	mov	x21, x0
.LBB5_190:
	ldr	x26, [sp, #136]
	b	.LBB5_198
.LBB5_191:
.Ltmp23:
	ldp	x25, x24, [sp, #152]
	b	.LBB5_196
.LBB5_192:
.Ltmp33:
	mov	x21, x0
	cbnz	x25, .LBB5_197
	b	.LBB5_198
.LBB5_193:
.Ltmp17:
	ldp	x25, x24, [sp, #152]
	mov	x21, x0
	ldr	x26, [sp, #136]
	cbnz	x25, .LBB5_197
	b	.LBB5_198
.LBB5_194:
.Ltmp20:
	mov	x21, x0
	cbnz	x25, .LBB5_197
	b	.LBB5_198
.LBB5_195:
.Ltmp30:
.LBB5_196:
	mov	x21, x0
	mov	x0, x23
	mov	x1, x28
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	cbz	x25, .LBB5_198
.LBB5_197:
	mov	x0, x24
	mov	x1, x25
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB5_198:
	cbz	x26, .LBB5_201
	ldr	x0, [sp, #80]
	mov	x1, x26
.LBB5_200:
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB5_201:
	mov	x0, x21
	bl	_Unwind_Resume
.Lfunc_end5:
	.size	_RNvCsa1GziGG0QHQ_10char_check4main, .Lfunc_end5-_RNvCsa1GziGG0QHQ_10char_check4main
	.cfi_endproc
	.section	.gcc_except_table._RNvCsa1GziGG0QHQ_10char_check4main,"a",@progbits
	.p2align	2, 0x0
GCC_except_table5:
.Lexception0:
	.byte	255
	.byte	255
	.byte	1
	.uleb128 .Lcst_end0-.Lcst_begin0
.Lcst_begin0:
	.uleb128 .Lfunc_begin0-.Lfunc_begin0
	.uleb128 .Ltmp15-.Lfunc_begin0
	.byte	0
	.byte	0
	.uleb128 .Ltmp15-.Lfunc_begin0
	.uleb128 .Ltmp16-.Ltmp15
	.uleb128 .Ltmp17-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp16-.Lfunc_begin0
	.uleb128 .Ltmp21-.Ltmp16
	.byte	0
	.byte	0
	.uleb128 .Ltmp21-.Lfunc_begin0
	.uleb128 .Ltmp22-.Ltmp21
	.uleb128 .Ltmp23-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp9-.Lfunc_begin0
	.uleb128 .Ltmp10-.Ltmp9
	.uleb128 .Ltmp11-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp10-.Lfunc_begin0
	.uleb128 .Ltmp0-.Ltmp10
	.byte	0
	.byte	0
	.uleb128 .Ltmp0-.Lfunc_begin0
	.uleb128 .Ltmp1-.Ltmp0
	.uleb128 .Ltmp2-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp3-.Lfunc_begin0
	.uleb128 .Ltmp4-.Ltmp3
	.uleb128 .Ltmp5-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp4-.Lfunc_begin0
	.uleb128 .Ltmp28-.Ltmp4
	.byte	0
	.byte	0
	.uleb128 .Ltmp28-.Lfunc_begin0
	.uleb128 .Ltmp29-.Ltmp28
	.uleb128 .Ltmp30-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp18-.Lfunc_begin0
	.uleb128 .Ltmp19-.Ltmp18
	.uleb128 .Ltmp20-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp26-.Lfunc_begin0
	.uleb128 .Ltmp27-.Ltmp26
	.uleb128 .Ltmp30-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp31-.Lfunc_begin0
	.uleb128 .Ltmp32-.Ltmp31
	.uleb128 .Ltmp33-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp24-.Lfunc_begin0
	.uleb128 .Ltmp25-.Ltmp24
	.uleb128 .Ltmp30-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp12-.Lfunc_begin0
	.uleb128 .Ltmp13-.Ltmp12
	.uleb128 .Ltmp14-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp6-.Lfunc_begin0
	.uleb128 .Ltmp7-.Ltmp6
	.uleb128 .Ltmp8-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp7-.Lfunc_begin0
	.uleb128 .Lfunc_end5-.Ltmp7
	.byte	0
	.byte	0
.Lcst_end0:
	.p2align	2, 0x0

	.section	.text.unlikely._RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsa1GziGG0QHQ_10char_check,"ax",@progbits
	.p2align	2
	.type	_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsa1GziGG0QHQ_10char_check,@function
_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsa1GziGG0QHQ_10char_check:
	.cfi_startproc
	stp	x29, x30, [sp, #-32]!
	.cfi_def_cfa_offset 32
	stp	x20, x19, [sp, #16]
	mov	x29, sp
	.cfi_def_cfa w29, 32
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w30, -24
	.cfi_offset w29, -32
	.cfi_remember_state
	mov	x20, x0
	tbnz	x3, #63, .LBB6_3
	mov	x19, x3
	cbz	x1, .LBB6_4
	mov	x0, x2
	mov	w2, #1
	mov	x3, x19
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_realloc
	cbnz	x0, .LBB6_8
	b	.LBB6_6
.LBB6_3:
	mov	w8, #1
	mov	w9, #8
	str	xzr, [x20, x9]
	str	x8, [x20]
	.cfi_def_cfa wsp, 32
	ldp	x20, x19, [sp, #16]
	ldp	x29, x30, [sp], #32
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB6_4:
	.cfi_restore_state
	.cfi_remember_state
	cbz	x19, .LBB6_7
	bl	_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	x0, x19
	mov	w1, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc
	cbnz	x0, .LBB6_8
.LBB6_6:
	mov	w8, #1
	str	x8, [x20, #8]
	mov	w9, #16
	str	x19, [x20, x9]
	str	x8, [x20]
	.cfi_def_cfa wsp, 32
	ldp	x20, x19, [sp, #16]
	ldp	x29, x30, [sp], #32
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB6_7:
	.cfi_restore_state
	mov	w0, #1
.LBB6_8:
	str	x0, [x20, #8]
	mov	w9, #16
	str	x19, [x20, x9]
	str	xzr, [x20]
	.cfi_def_cfa wsp, 32
	ldp	x20, x19, [sp, #16]
	ldp	x29, x30, [sp], #32
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end6:
	.size	_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsa1GziGG0QHQ_10char_check, .Lfunc_end6-_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsa1GziGG0QHQ_10char_check
	.cfi_endproc

	.section	.text.main,"ax",@progbits
	.globl	main
	.p2align	2
	.type	main,@function
main:
	.cfi_startproc
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	sxtw	x2, w0
	mov	x3, x1
	adrp	x8, _RNvCsa1GziGG0QHQ_10char_check4main
	add	x8, x8, :lo12:_RNvCsa1GziGG0QHQ_10char_check4main
	adrp	x1, .Lvtable.0
	add	x1, x1, :lo12:.Lvtable.0
	add	x0, sp, #8
	mov	w4, wzr
	str	x8, [sp, #8]
	bl	_RNvNtCs68fcPop4ROg_3std2rt19lang_start_internal
	ldp	x29, x30, [sp, #16]
	add	sp, sp, #32
	ret
.Lfunc_end7:
	.size	main, .Lfunc_end7-main
	.cfi_endproc

	.type	.Lalloc_fe7982d43e652b3fb39b1ffe8b374b41,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_fe7982d43e652b3fb39b1ffe8b374b41:
	.asciz	"library/core/src/str/pattern.rs"
	.size	.Lalloc_fe7982d43e652b3fb39b1ffe8b374b41, 32

	.type	.Lalloc_57e9d1db5edcf44fe5250fc671c984f9,@object
	.section	.data.rel.ro..Lalloc_57e9d1db5edcf44fe5250fc671c984f9,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_57e9d1db5edcf44fe5250fc671c984f9:
	.xword	.Lalloc_fe7982d43e652b3fb39b1ffe8b374b41
	.asciz	"\037\000\000\000\000\000\000\000d\006\000\000\024\000\000"
	.size	.Lalloc_57e9d1db5edcf44fe5250fc671c984f9, 24

	.type	.Lalloc_8819073e04e9b8e5c06efc9cd6763319,@object
	.section	.data.rel.ro..Lalloc_8819073e04e9b8e5c06efc9cd6763319,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_8819073e04e9b8e5c06efc9cd6763319:
	.xword	.Lalloc_fe7982d43e652b3fb39b1ffe8b374b41
	.asciz	"\037\000\000\000\000\000\000\000S\006\000\000\024\000\000"
	.size	.Lalloc_8819073e04e9b8e5c06efc9cd6763319, 24

	.type	.Lvtable.0,@object
	.section	.data.rel.ro..Lvtable.0,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.0:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.xword	_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCsa1GziGG0QHQ_10char_check
	.xword	_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Csa1GziGG0QHQ_10char_check
	.xword	_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Csa1GziGG0QHQ_10char_check
	.size	.Lvtable.0, 48

	.type	.Lalloc_dd6c130b73b5a65a5c14d3e598a4b37a,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_dd6c130b73b5a65a5c14d3e598a4b37a:
	.asciz	"/tmp/str-rfind-20261106/char-check.rs"
	.size	.Lalloc_dd6c130b73b5a65a5c14d3e598a4b37a, 38

	.type	.Lalloc_e35b61108c387c129169318fbaa84f19,@object
.Lalloc_e35b61108c387c129169318fbaa84f19:
	.asciz	"\024CHAR_CHECK_OK cases=\300\001\n"
	.size	.Lalloc_e35b61108c387c129169318fbaa84f19, 25

	.type	.Lalloc_7458713cc1a266feb0040d33e8f549cc,@object
	.section	.data.rel.ro..Lalloc_7458713cc1a266feb0040d33e8f549cc,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_7458713cc1a266feb0040d33e8f549cc:
	.xword	.Lalloc_dd6c130b73b5a65a5c14d3e598a4b37a
	.asciz	"%\000\000\000\000\000\000\000\004\000\000\000\323\000\000"
	.size	.Lalloc_7458713cc1a266feb0040d33e8f549cc, 24

	.type	.Lalloc_41f2d315767eaaec6af3e31fc87caeb8,@object
	.section	.data.rel.ro..Lalloc_41f2d315767eaaec6af3e31fc87caeb8,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_41f2d315767eaaec6af3e31fc87caeb8:
	.xword	.Lalloc_dd6c130b73b5a65a5c14d3e598a4b37a
	.asciz	"%\000\000\000\000\000\000\000\006\000\000\000}\000\000"
	.size	.Lalloc_41f2d315767eaaec6af3e31fc87caeb8, 24

	.type	.Lalloc_a877d8f58214054011e63c44aec5b78c,@object
	.section	.data.rel.ro..Lalloc_a877d8f58214054011e63c44aec5b78c,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_a877d8f58214054011e63c44aec5b78c:
	.xword	.Lalloc_dd6c130b73b5a65a5c14d3e598a4b37a
	.asciz	"%\000\000\000\000\000\000\000\005\000\000\000^\000\000"
	.size	.Lalloc_a877d8f58214054011e63c44aec5b78c, 24

	.type	.Lalloc_ddc11afbdf6e6371e27b90abd6d51e89,@object
	.section	.data.rel.ro..Lalloc_ddc11afbdf6e6371e27b90abd6d51e89,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_ddc11afbdf6e6371e27b90abd6d51e89:
	.xword	.Lalloc_fe7982d43e652b3fb39b1ffe8b374b41
	.asciz	"\037\000\000\000\000\000\000\000\315\004\000\000$\000\000"
	.size	.Lalloc_ddc11afbdf6e6371e27b90abd6d51e89, 24

	.hidden	DW.ref.rust_eh_personality
	.weak	DW.ref.rust_eh_personality
	.section	.data.DW.ref.rust_eh_personality,"awG",@progbits,DW.ref.rust_eh_personality,comdat
	.p2align	3, 0x0
	.type	DW.ref.rust_eh_personality,@object
	.size	DW.ref.rust_eh_personality, 8
DW.ref.rust_eh_personality:
	.xword	rust_eh_personality
	.ident	"rustc version 1.99.0-dev"
	.section	".note.GNU-stack","",@progbits
