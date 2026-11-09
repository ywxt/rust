	.file	"driver.15e1a5ac6b98e495-cgu.0"
	.section	.text._RINvNtCs68fcPop4ROg_3std2rt10lang_startuECs1StpruGFt5h_6driver,"ax",@progbits
	.hidden	_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECs1StpruGFt5h_6driver
	.globl	_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECs1StpruGFt5h_6driver
	.p2align	2
	.type	_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECs1StpruGFt5h_6driver,@function
_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECs1StpruGFt5h_6driver:
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
	.size	_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECs1StpruGFt5h_6driver, .Lfunc_end0-_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECs1StpruGFt5h_6driver
	.cfi_endproc

	.section	.text._RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver,"ax",@progbits
	.p2align	2
	.type	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver,@function
_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver:
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
	ldp	x19, x21, [x0, #8]
	mov	x20, x0
	cbz	x21, .LBB1_5
	add	x22, x19, #8
	b	.LBB1_3
.LBB1_2:
	subs	x21, x21, #1
	add	x22, x22, #24
	b.eq	.LBB1_5
.LBB1_3:
	ldur	x1, [x22, #-8]
	cbz	x1, .LBB1_2
	ldr	x0, [x22]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB1_2
.LBB1_5:
	ldr	x8, [x20]
	cbz	x8, .LBB1_7
	add	x8, x8, x8, lsl #1
	mov	x0, x19
	lsl	x1, x8, #3
	mov	w2, #8
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
	b	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB1_7:
	.cfi_restore_state
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
	.size	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver, .Lfunc_end1-_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver
	.cfi_endproc

	.section	.text._RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECs1StpruGFt5h_6driver,"ax",@progbits
	.p2align	2
	.type	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECs1StpruGFt5h_6driver,@function
_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECs1StpruGFt5h_6driver:
	.cfi_startproc
	stp	x29, x30, [sp, #-48]!
	.cfi_def_cfa_offset 48
	str	x21, [sp, #16]
	stp	x20, x19, [sp, #32]
	mov	x29, sp
	.cfi_def_cfa w29, 48
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -32
	.cfi_offset w30, -40
	.cfi_offset w29, -48
	.cfi_remember_state
	ldr	x8, [x0, #8]
	ldr	x9, [x0, #24]
	mov	x19, x0
	subs	x9, x9, x8
	b.eq	.LBB2_5
	mov	x10, #-6148914691236517206
	add	x21, x8, #8
	movk	x10, #43691
	umulh	x9, x9, x10
	lsr	x20, x9, #4
	b	.LBB2_3
.LBB2_2:
	subs	x20, x20, #1
	add	x21, x21, #24
	b.eq	.LBB2_5
.LBB2_3:
	ldur	x1, [x21, #-8]
	cbz	x1, .LBB2_2
	ldr	x0, [x21]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB2_2
.LBB2_5:
	ldr	x8, [x19, #16]
	cbz	x8, .LBB2_7
	add	x8, x8, x8, lsl #1
	ldr	x0, [x19]
	lsl	x1, x8, #3
	mov	w2, #8
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]
	ldr	x21, [sp, #16]
	ldp	x29, x30, [sp], #48
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	b	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB2_7:
	.cfi_restore_state
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]
	ldr	x21, [sp, #16]
	ldp	x29, x30, [sp], #48
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end2:
	.size	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECs1StpruGFt5h_6driver, .Lfunc_end2-_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECs1StpruGFt5h_6driver
	.cfi_endproc

	.section	.text._RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs1StpruGFt5h_6driver,"ax",@progbits
	.p2align	2
	.type	_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs1StpruGFt5h_6driver,@function
_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs1StpruGFt5h_6driver:
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
.Lfunc_end3:
	.size	_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs1StpruGFt5h_6driver, .Lfunc_end3-_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs1StpruGFt5h_6driver
	.cfi_endproc

	.section	.text.unlikely._RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs1StpruGFt5h_6driver,"ax",@progbits
	.p2align	2
	.type	_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs1StpruGFt5h_6driver,@function
_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs1StpruGFt5h_6driver:
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
	b.hs	.LBB4_3
	ldp	x1, x2, [x0]
	mov	x19, x0
	add	x0, sp, #8
	lsl	x9, x1, #1
	cmp	x8, x9
	csel	x8, x8, x9, hi
	mov	w9, #4
	cmp	x8, #4
	csel	x20, x8, x9, hi
	mov	x3, x20
	bl	_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs1StpruGFt5h_6driver
	ldr	x8, [sp, #8]
	cbnz	x8, .LBB4_4
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
.LBB4_3:
	.cfi_restore_state
	mov	x0, xzr
	bl	_RNvNtCs6sh1iPzjxYC_5alloc7raw_vec12handle_error
.LBB4_4:
	ldp	x0, x1, [sp, #16]
	bl	_RNvNtCs6sh1iPzjxYC_5alloc7raw_vec12handle_error
.Lfunc_end4:
	.size	_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs1StpruGFt5h_6driver, .Lfunc_end4-_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs1StpruGFt5h_6driver
	.cfi_endproc

	.section	.text._RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Cs1StpruGFt5h_6driver,"ax",@progbits
	.p2align	2
	.type	_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Cs1StpruGFt5h_6driver,@function
_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Cs1StpruGFt5h_6driver:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x0, [x0]
	bl	_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs1StpruGFt5h_6driver
	mov	w0, wzr
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end5:
	.size	_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Cs1StpruGFt5h_6driver, .Lfunc_end5-_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Cs1StpruGFt5h_6driver
	.cfi_endproc

	.section	.text._RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCs1StpruGFt5h_6driver,"ax",@progbits
	.p2align	2
	.type	_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCs1StpruGFt5h_6driver,@function
_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCs1StpruGFt5h_6driver:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x0, [x0]
	bl	_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs1StpruGFt5h_6driver
	mov	w0, wzr
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end6:
	.size	_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCs1StpruGFt5h_6driver, .Lfunc_end6-_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCs1StpruGFt5h_6driver
	.cfi_endproc

	.section	.text._RNvCs1StpruGFt5h_6driver10crate_find,"ax",@progbits
	.p2align	2
	.type	_RNvCs1StpruGFt5h_6driver10crate_find,@function
_RNvCs1StpruGFt5h_6driver10crate_find:
	.cfi_startproc
	cbz	x2, .LBB7_5
	cmp	x2, #15
	b.hi	.LBB7_6
	mov	x8, x1
.LBB7_3:
	ldrb	w9, [x8]
	cmp	w9, w0, uxtb
	b.eq	.LBB7_8
	subs	x2, x2, #1
	add	x8, x8, #1
	b.ne	.LBB7_3
.LBB7_5:
	mov	x0, xzr
	ret
.LBB7_6:
	dup	v0.16b, w0
	ldr	q1, [x1]
	cmeq	v1.16b, v0.16b, v1.16b
	shrn	v1.8b, v1.8h, #4
	fmov	x8, d1
	ands	x8, x8, #0x8888888888888888
	b.eq	.LBB7_9
	rbit	x8, x8
	clz	x8, x8
	add	x8, x1, x8, lsr #2
.LBB7_8:
	sub	x1, x8, x1
	mov	w0, #1
	ret
.LBB7_9:
	and	x9, x1, #0xf
	mov	w8, #16
	sub	x10, x8, x9
	sub	x8, x2, #64
	cmp	x10, x8
	mov	w8, #63
	ccmp	x2, x8, #0, ls
	add	x8, x1, x2
	b.ls	.LBB7_14
	sub	x9, x1, x9
	sub	x10, x8, #64
	add	x9, x9, #64
.LBB7_11:
	mov	x11, x9
	ldp	q2, q5, [x9, #-32]
	ldr	q1, [x11, #-48]!
	ldr	q6, [x9]
	cmeq	v4.16b, v0.16b, v1.16b
	cmeq	v3.16b, v0.16b, v2.16b
	cmeq	v2.16b, v0.16b, v5.16b
	cmeq	v1.16b, v0.16b, v6.16b
	orr	v5.16b, v3.16b, v4.16b
	orr	v6.16b, v2.16b, v1.16b
	orr	v5.16b, v5.16b, v6.16b
	umaxp	v5.16b, v5.16b, v5.16b
	fmov	x12, d5
	cbnz	x12, .LBB7_20
	add	x11, x11, #64
	add	x9, x9, #64
	cmp	x11, x10
	b.ls	.LBB7_11
	sub	x9, x9, #48
	sub	x10, x8, #16
	cmp	x9, x10
	b.ls	.LBB7_15
	b	.LBB7_17
.LBB7_14:
	add	x9, x1, x10
	sub	x10, x8, #16
	cmp	x9, x10
	b.hi	.LBB7_17
.LBB7_15:
	ldr	q1, [x9]
	cmeq	v1.16b, v0.16b, v1.16b
	shrn	v1.8b, v1.8h, #4
	fmov	x11, d1
	ands	x11, x11, #0x8888888888888888
	b.ne	.LBB7_22
	add	x9, x9, #16
	cmp	x9, x10
	b.ls	.LBB7_15
.LBB7_17:
	cmp	x9, x8
	b.hs	.LBB7_5
	ldr	q1, [x8, #-16]!
	cmeq	v0.16b, v0.16b, v1.16b
	shrn	v0.8b, v0.8h, #4
	fmov	x9, d0
	ands	x9, x9, #0x8888888888888888
	b.eq	.LBB7_5
	rbit	x9, x9
	clz	x9, x9
	add	x8, x8, x9, lsr #2
	sub	x1, x8, x1
	mov	w0, #1
	ret
.LBB7_20:
	shrn	v0.8b, v4.8h, #4
	fmov	x8, d0
	ands	x8, x8, #0x8888888888888888
	b.eq	.LBB7_23
	rbit	x8, x8
	clz	x8, x8
	add	x8, x9, x8, lsr #2
	sub	x8, x8, #48
	sub	x1, x8, x1
	mov	w0, #1
	ret
.LBB7_22:
	rbit	x8, x11
	clz	x8, x8
	add	x8, x9, x8, lsr #2
	sub	x1, x8, x1
	mov	w0, #1
	ret
.LBB7_23:
	shrn	v0.8b, v3.8h, #4
	fmov	x8, d0
	ands	x8, x8, #0x8888888888888888
	b.eq	.LBB7_25
	rbit	x8, x8
	clz	x8, x8
	add	x8, x9, x8, lsr #2
	sub	x8, x8, #32
	sub	x1, x8, x1
	mov	w0, #1
	ret
.LBB7_25:
	shrn	v0.8b, v2.8h, #4
	fmov	x8, d0
	ands	x8, x8, #0x8888888888888888
	b.eq	.LBB7_27
	rbit	x8, x8
	clz	x8, x8
	add	x8, x9, x8, lsr #2
	sub	x8, x8, #16
	sub	x1, x8, x1
	mov	w0, #1
	ret
.LBB7_27:
	shrn	v0.8b, v1.8h, #4
	fmov	x8, d0
	and	x8, x8, #0x8888888888888888
	rbit	x8, x8
	clz	x8, x8
	add	x8, x9, x8, lsr #2
	sub	x1, x8, x1
	mov	w0, #1
	ret
.Lfunc_end7:
	.size	_RNvCs1StpruGFt5h_6driver10crate_find, .Lfunc_end7-_RNvCs1StpruGFt5h_6driver10crate_find
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI8_0:
	.xword	1
	.xword	0
.LCPI8_1:
	.xword	0
	.xword	21
.LCPI8_2:
	.xword	0
	.xword	1
.LCPI8_3:
	.xword	7
	.xword	8
.LCPI8_4:
	.xword	15
	.xword	16
.LCPI8_5:
	.xword	17
	.xword	31
.LCPI8_6:
	.xword	32
	.xword	33
.LCPI8_7:
	.xword	63
	.xword	64
.LCPI8_8:
	.xword	65
	.xword	127
.LCPI8_9:
	.xword	128
	.xword	129
.LCPI8_10:
	.xword	255
	.xword	256
.LCPI8_11:
	.xword	257
	.xword	2551
.LCPI8_12:
	.xword	3
	.xword	0
	.section	.text._RNvCs1StpruGFt5h_6driver4main,"ax",@progbits
	.hidden	_RNvCs1StpruGFt5h_6driver4main
	.globl	_RNvCs1StpruGFt5h_6driver4main
	.p2align	2
	.type	_RNvCs1StpruGFt5h_6driver4main,@function
_RNvCs1StpruGFt5h_6driver4main:
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
	sub	sp, sp, #672
	sub	x8, x29, #144
	bl	_RNvNtCs68fcPop4ROg_3std3env4args
.Ltmp0:
	add	x8, sp, #336
	sub	x0, x29, #144
	bl	_RNvXsc_NtCs68fcPop4ROg_3std3envNtB5_4ArgsNtNtNtNtCshp6Wxz1DwXO_4core4iter6traits8iterator8Iterator4next
.Ltmp1:
	ldr	x21, [sp, #336]
	cmn	x21, #1
	b.eq	.LBB8_225
	ldur	x8, [x29, #-136]
	ldur	x9, [x29, #-120]
	mov	x10, #-6148914691236517206
	movk	x10, #43691
	mov	x11, #9223372036854775776
	ldr	x22, [sp, #344]
	sub	x9, x9, x8
	lsr	x8, x9, #3
	mul	x8, x8, x10
	mov	w10, #3
	cmp	x8, #3
	csel	x8, x8, x10, hi
	cmp	x9, x11
	b.ls	.LBB8_5
	mov	x23, xzr
.LBB8_4:
.Ltmp60:
	mov	x0, x23
	mov	x1, x20
	bl	_RNvNtCs6sh1iPzjxYC_5alloc7raw_vec12handle_error
.Ltmp61:
	b	.LBB8_245
.LBB8_5:
	add	x24, x8, #1
	ldr	x25, [sp, #352]
	add	x8, x24, x24, lsl #1
	lsl	x20, x8, #3
	cbz	x20, .LBB8_8
	bl	_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	x0, x20
	mov	w1, #8
	mov	w23, #8
	bl	_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc
	cbz	x0, .LBB8_4
	mov	x19, x0
	b	.LBB8_9
.LBB8_8:
	mov	x24, xzr
	mov	w19, #8
.LBB8_9:
	stp	x21, x22, [x19]
	mov	x23, xzr
	mov	w20, #1
	str	x25, [x19, #16]
	mov	x25, #1
	ldp	q0, q1, [x29, #-144]
	stp	x24, x19, [x29, #-64]
	mov	x24, #-6148914691236517206
	stur	x20, [x29, #-48]
	movk	x24, #43691
	stp	q0, q1, [sp, #336]
	b	.LBB8_12
.LBB8_10:
	ldur	x19, [x29, #-56]
.LBB8_11:
	add	x8, x19, x23
	add	x20, x20, #1
	add	x23, x23, #24
	stp	x21, x22, [x8, #24]
	str	x26, [x8, #40]
	stur	x20, [x29, #-48]
.LBB8_12:
.Ltmp3:
	sub	x8, x29, #32
	add	x0, sp, #336
	bl	_RNvXsc_NtCs68fcPop4ROg_3std3envNtB5_4ArgsNtNtNtNtCshp6Wxz1DwXO_4core4iter6traits8iterator8Iterator4next
.Ltmp4:
	ldur	x21, [x29, #-32]
	cmn	x21, #1
	b.eq	.LBB8_16
	ldur	x8, [x29, #-64]
	ldp	x22, x26, [x29, #-24]
	cmp	x20, x8
	b.ne	.LBB8_11
	ldr	x8, [sp, #360]
	ldr	x9, [sp, #344]
	sub	x8, x8, x9
	lsr	x8, x8, #3
	madd	x2, x8, x24, x25
.Ltmp6:
	sub	x0, x29, #64
	mov	x1, x20
	bl	_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs1StpruGFt5h_6driver
.Ltmp7:
	b	.LBB8_10
.LBB8_16:
	ldr	x8, [sp, #344]
	ldr	x9, [sp, #360]
	subs	x9, x9, x8
	b.eq	.LBB8_21
	mov	x10, #-6148914691236517206
	add	x20, x8, #8
	movk	x10, #43691
	umulh	x9, x9, x10
	lsr	x19, x9, #4
	b	.LBB8_19
.LBB8_18:
	subs	x19, x19, #1
	add	x20, x20, #24
	b.eq	.LBB8_21
.LBB8_19:
	ldur	x1, [x20, #-8]
	cbz	x1, .LBB8_18
	ldr	x0, [x20]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB8_18
.LBB8_21:
	ldr	x8, [sp, #352]
	cbz	x8, .LBB8_23
	add	x8, x8, x8, lsl #1
	ldr	x0, [sp, #336]
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB8_23:
	ldur	x1, [x29, #-48]
	ldur	q0, [x29, #-64]
	cmp	x1, #2
	stur	q0, [x29, #-32]
	stur	x1, [x29, #-16]
	b.lo	.LBB8_229
	ldur	x19, [x29, #-24]
	ldr	x8, [x19, #40]
	cmp	x8, #5
	b.ne	.LBB8_28
	ldr	x8, [x19, #32]
	ldrb	w9, [x8, #4]
	ldr	w10, [x8]
	cmp	w9, #107
	mov	w9, #26723
	movk	w9, #25445, lsl #16
	ccmp	w10, w9, #0, eq
	b.eq	.LBB8_119
	ldrb	w9, [x8, #4]
	ldr	w8, [x8]
	cmp	w9, #101
	mov	w9, #29283
	movk	w9, #29793, lsl #16
	ccmp	w8, w9, #0, eq
	b.ne	.LBB8_216
	adrp	x8, _RNvCs1StpruGFt5h_6driver10crate_find
	add	x8, x8, :lo12:_RNvCs1StpruGFt5h_6driver10crate_find
	b	.LBB8_31
.LBB8_28:
	cmp	x8, #3
	b.ne	.LBB8_216
	ldr	x8, [x19, #32]
	ldrb	w9, [x8, #2]
	ldrh	w8, [x8]
	cmp	w9, #100
	mov	w9, #29811
	ccmp	w8, w9, #0, eq
	b.ne	.LBB8_216
	adrp	x8, _RNvCs1StpruGFt5h_6driver8std_find
	add	x8, x8, :lo12:_RNvCs1StpruGFt5h_6driver8std_find
.LBB8_31:
	stur	x8, [x29, #-88]
	sub	x8, x29, #88
	cmp	x1, #2
	//APP
	//NO_APP
	b.eq	.LBB8_235
	ldp	x9, x8, [x19, #56]
	cmp	x8, #1
	b.eq	.LBB8_35
	cbz	x8, .LBB8_241
	ldrb	w11, [x9]
	b	.LBB8_37
.LBB8_35:
	ldrb	w11, [x9]
	mov	w10, #1
	cmp	w11, #43
	b.eq	.LBB8_205
	cmp	w11, #45
	b.eq	.LBB8_205
.LBB8_37:
	cmp	w11, #43
	cset	w10, eq
	cinc	x9, x9, eq
	sub	x8, x8, x10
	cmp	x8, #17
	b.hs	.LBB8_42
	mov	x20, xzr
	cbz	x8, .LBB8_47
	mov	w10, #10
.LBB8_40:
	ldrb	w11, [x9], #1
	sub	w11, w11, #48
	cmp	w11, #9
	b.hi	.LBB8_222
	mul	x12, x20, x10
	subs	x8, x8, #1
	add	x20, x12, w11, uxtw
	b.ne	.LBB8_40
	b	.LBB8_47
.LBB8_42:
	mov	x20, xzr
	mov	w10, #10
.LBB8_43:
	umulh	x12, x20, x10
	ldrb	w11, [x9], #1
	cmp	xzr, x12
	b.ne	.LBB8_203
	sub	w11, w11, #48
	cmp	w11, #10
	b.hs	.LBB8_222
	add	x12, x20, x20, lsl #2
	lsl	x12, x12, #1
	adds	x20, x12, w11, uxtw
	b.hs	.LBB8_204
	sub	x8, x8, #1
	cbnz	x8, .LBB8_43
.LBB8_47:
	cmp	x1, #4
	b.lo	.LBB8_236
	ldp	x9, x8, [x19, #80]
	cmp	x8, #1
	b.eq	.LBB8_51
	cbz	x8, .LBB8_242
	ldrb	w11, [x9]
	b	.LBB8_53
.LBB8_51:
	ldrb	w11, [x9]
	mov	w10, #1
	cmp	w11, #43
	b.eq	.LBB8_208
	cmp	w11, #45
	b.eq	.LBB8_208
.LBB8_53:
	cmp	w11, #43
	cset	w10, eq
	cinc	x9, x9, eq
	sub	x8, x8, x10
	cmp	x8, #17
	b.hs	.LBB8_58
	mov	x22, xzr
	cbz	x8, .LBB8_63
	mov	w10, #10
.LBB8_56:
	ldrb	w11, [x9], #1
	sub	w11, w11, #48
	cmp	w11, #9
	b.hi	.LBB8_223
	mul	x12, x22, x10
	subs	x8, x8, #1
	add	x22, x12, w11, uxtw
	b.ne	.LBB8_56
	b	.LBB8_63
.LBB8_58:
	mov	x22, xzr
	mov	w10, #10
.LBB8_59:
	umulh	x12, x22, x10
	ldrb	w11, [x9], #1
	cmp	xzr, x12
	b.ne	.LBB8_206
	sub	w11, w11, #48
	cmp	w11, #10
	b.hs	.LBB8_223
	add	x12, x22, x22, lsl #2
	lsl	x12, x12, #1
	adds	x22, x12, w11, uxtw
	b.hs	.LBB8_207
	sub	x8, x8, #1
	cbnz	x8, .LBB8_59
.LBB8_63:
	cmp	x1, #6
	stur	x22, [x29, #-80]
	b.lo	.LBB8_237
	ldp	x9, x8, [x19, #128]
	cmp	x8, #1
	b.eq	.LBB8_67
	cbz	x8, .LBB8_243
	ldrb	w11, [x9]
	b	.LBB8_69
.LBB8_67:
	ldrb	w11, [x9]
	mov	w10, #1
	cmp	w11, #43
	b.eq	.LBB8_211
	cmp	w11, #45
	b.eq	.LBB8_211
.LBB8_69:
	cmp	w11, #43
	cset	w10, eq
	cinc	x9, x9, eq
	sub	x8, x8, x10
	cmp	x8, #17
	b.hs	.LBB8_74
	mov	x10, xzr
	cbz	x8, .LBB8_79
	mov	w11, #10
.LBB8_72:
	ldrb	w12, [x9], #1
	sub	w12, w12, #48
	cmp	w12, #9
	b.hi	.LBB8_224
	mul	x10, x10, x11
	subs	x8, x8, #1
	add	x10, x10, w12, uxtw
	b.ne	.LBB8_72
	b	.LBB8_79
.LBB8_74:
	mov	x10, xzr
	mov	w11, #10
.LBB8_75:
	umulh	x13, x10, x11
	ldrb	w12, [x9], #1
	cmp	xzr, x13
	b.ne	.LBB8_209
	sub	w12, w12, #48
	cmp	w12, #10
	b.hs	.LBB8_224
	add	x10, x10, x10, lsl #2
	lsl	x10, x10, #1
	adds	x10, x10, w12, uxtw
	b.hs	.LBB8_210
	sub	x8, x8, #1
	cbnz	x8, .LBB8_75
.LBB8_79:
	mov	w23, #128
	stur	x10, [x29, #-72]
	movk	w23, #2, lsl #16
	bl	_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	w0, #128
	mov	w1, #64
	movk	w0, #2, lsl #16
	bl	_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc
	cbz	x0, .LBB8_217
	mov	w2, #128
	mov	w1, #128
	mov	x21, x0
	movk	w2, #2, lsl #16
	bl	memset
	ldp	x8, x9, [x19, #104]
	cmp	x9, #5
	b.eq	.LBB8_85
	cmp	x9, #6
	b.ne	.LBB8_87
	ldr	w9, [x8]
	mov	w11, #25185
	ldrh	w10, [x8, #4]
	movk	w11, #25971, lsl #16
	cmp	w9, w11
	mov	w9, #29806
	ccmp	w10, w9, #0, eq
	b.eq	.LBB8_191
	ldr	w9, [x8]
	mov	w10, #26989
	ldrh	w8, [x8, #4]
	movk	w10, #25700, lsl #16
	cmp	w9, w10
	mov	w9, #25964
	ccmp	w8, w9, #0, eq
	b.ne	.LBB8_221
	lsr	x24, x20, #1
	b	.LBB8_90
.LBB8_85:
	ldrb	w9, [x8, #4]
	ldr	w8, [x8]
	cmp	w9, #116
	mov	w9, #29286
	movk	w9, #28271, lsl #16
	ccmp	w8, w9, #0, eq
	b.ne	.LBB8_221
	adrp	x8, .LCPI8_0
	mov	x24, xzr
	ldr	q0, [x8, :lo12:.LCPI8_0]
	stur	q0, [x29, #-64]
	b	.LBB8_91
.LBB8_87:
	cmp	x9, #4
	b.ne	.LBB8_221
	ldr	w8, [x8]
	mov	w9, #24940
	movk	w9, #29811, lsl #16
	cmp	w8, w9
	b.ne	.LBB8_221
	sub	x24, x20, #1
.LBB8_90:
	mov	w8, #1
	stp	x8, x24, [x29, #-64]
.LBB8_91:
	add	x0, x24, x22
	cmp	x0, x23
	b.hs	.LBB8_239
	mov	w26, wzr
	mov	w8, #255
	strb	w8, [x21, x0]
	mov	w28, #1
	add	x1, x22, x20
	cmp	x1, x22
	b.lo	.LBB8_192
.LBB8_93:
	add	x8, x23, #1
	cmp	x1, x8
	b.hs	.LBB8_192
	add	x23, x21, x22
	and	x8, x23, #0x3f
	cmp	x8, x22
	str	x8, [sp, #336]
	b.ne	.LBB8_218
	ldur	x8, [x29, #-88]
.Ltmp17:
	mov	w0, #255
	mov	x1, x23
	mov	x2, x20
	blr	x8
.Ltmp18:
	cmp	x0, #1
	stp	x0, x1, [sp, #336]
	b.ne	.LBB8_99
	cmp	x1, x24
	csel	w8, wzr, w28, ne
	tbnz	w8, #0, .LBB8_100
.LBB8_98:
.Ltmp19:
	adrp	x5, .Lalloc_33f467d265e61babc7c5951f1b7a303c
	add	x5, x5, :lo12:.Lalloc_33f467d265e61babc7c5951f1b7a303c
	add	x1, sp, #336
	sub	x2, x29, #64
	mov	w0, wzr
	mov	x3, xzr
	bl	_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedINtNtB4_6option6OptionjEBM_EB4_
.Ltmp20:
	b	.LBB8_245
.LBB8_99:
	tbz	w26, #0, .LBB8_98
.LBB8_100:
	mov	w22, #1000
	mov	w25, #255
	sub	x26, x29, #144
	add	x27, sp, #336
.LBB8_101:
	sturb	w25, [x29, #-144]
	//APP
	//NO_APP
	stp	x23, x20, [sp, #336]
	//APP
	//NO_APP
	ldp	x1, x2, [sp, #336]
	ldurb	w0, [x29, #-144]
	ldur	x8, [x29, #-88]
.Ltmp21:
	blr	x8
.Ltmp22:
	stp	x0, x1, [x29, #-144]
	subs	w22, w22, #1
	//APP
	//NO_APP
	b.ne	.LBB8_101
	ldur	x8, [x29, #-72]
	stur	xzr, [x29, #-104]
	cbz	x8, .LBB8_108
	str	x21, [sp, #320]
	mov	w21, w28
	mov	x22, xzr
	mov	x26, xzr
	mov	w27, #255
	sub	x28, x29, #144
	add	x25, sp, #336
.LBB8_105:
	sturb	w27, [x29, #-144]
	//APP
	//NO_APP
	stp	x23, x20, [sp, #336]
	//APP
	//NO_APP
	ldp	x1, x2, [sp, #336]
	ldurb	w0, [x29, #-144]
	ldur	x8, [x29, #-88]
.Ltmp24:
	blr	x8
.Ltmp25:
	stp	x0, x1, [x29, #-144]
	add	x26, x26, #1
	//APP
	//NO_APP
	ldur	w8, [x29, #-144]
	ldur	x9, [x29, #-136]
	cmp	w8, #0
	ldur	x8, [x29, #-72]
	csinc	x9, xzr, x9, eq
	add	x22, x9, x22
	cmp	x26, x8
	stur	x22, [x29, #-104]
	b.lo	.LBB8_105
	mov	w28, w21
	ldr	x21, [sp, #320]
	b	.LBB8_109
.LBB8_108:
	mov	x22, xzr
.LBB8_109:
	madd	x8, x8, x24, x8
	cmp	w28, #0
	sub	x1, x29, #104
	csel	x8, x8, xzr, ne
	cmp	x22, x8
	str	x8, [sp, #336]
	b.ne	.LBB8_219
	adrp	x9, :got:_RNvXsi_NtNtNtCshp6Wxz1DwXO_4core3fmt3num3impjNtB9_7Display3fmt
	sub	x8, x29, #72
	ldr	x9, [x9, :got_lo12:_RNvXsi_NtNtNtCshp6Wxz1DwXO_4core3fmt3num3impjNtB9_7Display3fmt]
	stp	x8, x9, [sp, #336]
	stp	x1, x9, [sp, #352]
.Ltmp29:
	adrp	x0, .Lalloc_ea7a11d758a5a3d2649481fea54771bb
	add	x0, x0, :lo12:.Lalloc_ea7a11d758a5a3d2649481fea54771bb
	add	x1, sp, #336
	bl	_RNvNtNtCs68fcPop4ROg_3std2io5stdio6__print
.Ltmp30:
	mov	w1, #128
	mov	x0, x21
	mov	w2, #64
	movk	w1, #2, lsl #16
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	ldur	x20, [x29, #-16]
	cbz	x20, .LBB8_116
	add	x21, x19, #8
	b	.LBB8_114
.LBB8_113:
	subs	x20, x20, #1
	add	x21, x21, #24
	b.eq	.LBB8_116
.LBB8_114:
	ldur	x1, [x21, #-8]
	cbz	x1, .LBB8_113
	ldr	x0, [x21]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB8_113
.LBB8_116:
	ldur	x8, [x29, #-32]
	cbz	x8, .LBB8_118
	add	x8, x8, x8, lsl #1
	mov	x0, x19
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB8_118:
	add	sp, sp, #672
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
.LBB8_119:
	.cfi_restore_state
	add	x8, sp, #336
	sub	x9, x29, #144
	adrp	x10, .LCPI8_4
	add	x8, x8, #16
	add	x9, x9, #16
	mov	x25, xzr
	str	x8, [sp, #208]
	adrp	x8, .LCPI8_1
	mov	w21, wzr
	ldr	q0, [x8, :lo12:.LCPI8_1]
	adrp	x8, .LCPI8_2
	str	x9, [sp, #280]
	adrp	x9, .LCPI8_3
	mov	w22, #1
	mov	w20, #4096
	str	q0, [sp, #176]
	ldr	q0, [x8, :lo12:.LCPI8_2]
	adrp	x8, .LCPI8_5
	stur	xzr, [x29, #-72]
	str	q0, [sp, #160]
	ldr	q0, [x9, :lo12:.LCPI8_3]
	adrp	x9, .LCPI8_6
	str	q0, [sp, #144]
	ldr	q0, [x10, :lo12:.LCPI8_4]
	adrp	x10, .LCPI8_7
	str	q0, [sp, #128]
	ldr	q0, [x8, :lo12:.LCPI8_5]
	adrp	x8, .LCPI8_8
	str	q0, [sp, #112]
	ldr	q0, [x9, :lo12:.LCPI8_6]
	adrp	x9, .LCPI8_9
	str	q0, [sp, #96]
	ldr	q0, [x10, :lo12:.LCPI8_7]
	adrp	x10, .LCPI8_10
	str	q0, [sp, #80]
	ldr	q0, [x8, :lo12:.LCPI8_8]
	adrp	x8, .LCPI8_11
	str	q0, [sp, #64]
	ldr	q0, [x9, :lo12:.LCPI8_9]
	adrp	x9, .Lalloc_018282178791e8a09b18fbb1ed888779
	add	x9, x9, :lo12:.Lalloc_018282178791e8a09b18fbb1ed888779
	str	q0, [sp, #48]
	ldr	q0, [x10, :lo12:.LCPI8_10]
	str	q0, [sp, #32]
	ldr	q0, [x8, :lo12:.LCPI8_11]
	adrp	x8, .Lalloc_f6eff4434d88d939ba74cb3c7aa163d7
	add	x10, x8, :lo12:.Lalloc_f6eff4434d88d939ba74cb3c7aa163d7
	adrp	x8, .LCPI8_12
	str	q0, [sp, #16]
	ldr	q0, [x8, :lo12:.LCPI8_12]
	stp	x10, x9, [sp]
	str	q0, [sp, #224]
.LBB8_120:
	and	w8, w21, #0xff
	add	w19, w8, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	w0, #4352
	mov	w1, #1
	str	w19, [sp, #292]
	tbz	w19, #8, .LBB8_122
	bl	_RNvCshVjSbrpHdcL_7___rustc19___rust_alloc_zeroed
	str	x0, [sp, #296]
	cbnz	x0, .LBB8_124
	b	.LBB8_244
.LBB8_122:
	bl	_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc
	str	x0, [sp, #296]
	cbz	x0, .LBB8_244
	ldr	x0, [sp, #296]
	ldr	w1, [sp, #292]
	mov	w2, #4352
	bl	memset
.LBB8_124:
	ldp	q0, q1, [sp, #160]
	mov	x8, xzr
	str	x20, [sp, #512]
	stp	q1, q0, [sp, #336]
	ldp	q0, q1, [sp, #128]
	stp	q1, q0, [sp, #368]
	ldp	q0, q1, [sp, #96]
	stp	q1, q0, [sp, #400]
	ldp	q0, q1, [sp, #64]
	stp	q1, q0, [sp, #432]
	ldp	q0, q1, [sp, #32]
	stp	q1, q0, [sp, #464]
	dup	v0.16b, w21
	str	q0, [sp, #320]
	ldr	q0, [sp, #16]
	str	q0, [sp, #496]
	b	.LBB8_127
.LBB8_125:
	stur	x19, [x29, #-72]
	mov	x25, x19
.LBB8_126:
	ldr	x8, [sp, #216]
	cmp	x8, #21
	b.eq	.LBB8_188
.LBB8_127:
	ldr	x9, [sp, #208]
	add	x23, x8, #1
	mov	x20, xzr
	str	x23, [sp, #336]
	ldr	x24, [x9, x8, lsl #3]
	str	x23, [sp, #216]
	cbz	x24, .LBB8_185
	lsr	x8, x24, #1
	ldr	x28, [sp, #296]
	sub	x27, x24, #1
	str	x27, [sp, #200]
	str	x8, [sp, #240]
	mov	w8, w28
	str	x8, [sp, #256]
	b	.LBB8_131
.LBB8_129:
	ldr	w8, [sp, #292]
	add	x25, x19, #2
	stur	x25, [x29, #-72]
	strb	w8, [x26, #1]
	strb	w8, [x26, x27]
.LBB8_130:
	ldr	x8, [sp, #256]
	cmp	x20, #64
	add	x28, x28, #1
	add	w8, w8, #1
	str	x8, [sp, #256]
	b.eq	.LBB8_126
.LBB8_131:
	add	x1, x20, x24
	mov	w8, #4353
	cmp	x1, x8
	b.hs	.LBB8_193
	ldr	x8, [sp, #296]
	cmp	x24, #15
	add	x26, x8, x20
	b.hi	.LBB8_136
	mov	x8, xzr
.LBB8_134:
	ldrb	w9, [x28, x8]
	cmp	w9, w21, uxtb
	b.eq	.LBB8_214
	add	x8, x8, #1
	cmp	x24, x8
	b.ne	.LBB8_134
	b	.LBB8_138
.LBB8_136:
.Ltmp38:
	add	x1, x8, x20
	mov	w0, w21
	mov	x2, x24
	bl	_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned
.Ltmp39:
	stp	x0, x1, [x29, #-144]
	tbnz	w0, #0, .LBB8_246
.LBB8_138:
	ldr	x8, [sp, #296]
	mov	w0, w21
	mov	x2, x24
	add	x1, x8, x20
	bl	_RNvCs1StpruGFt5h_6driver10crate_find
	stp	x0, x1, [x29, #-144]
	tbnz	w0, #0, .LBB8_194
	ldr	x8, [sp, #256]
	add	x20, x20, #1
	mov	w9, #16
	str	x20, [sp, #248]
	cmp	x24, #63
	add	x10, x26, x24
	and	x8, x8, #0xf
	ldr	q0, [sp, #224]
	mov	x23, xzr
	neg	x20, x8
	and	x8, x26, #0xf
	add	x25, x25, #1
	sub	x8, x9, x8
	ldr	x9, [sp, #240]
	sub	x11, x10, #64
	stur	x25, [x29, #-72]
	stp	x9, x27, [x29, #-120]
	sub	x9, x24, #64
	ccmp	x8, x9, #2, hi
	add	x8, x26, x8
	stur	q0, [x29, #-136]
	str	x8, [sp, #272]
	cset	w8, ls
	str	w8, [sp, #268]
	sub	x8, x10, #16
	stp	x8, x11, [sp, #304]
.LBB8_140:
	ldr	x8, [sp, #280]
	ldr	x27, [x8, x23, lsl #3]
	add	x23, x23, #1
	stur	x23, [x29, #-144]
	cmp	x27, x24
	b.hs	.LBB8_213
	mov	x19, x25
	ldr	x25, [sp, #296]
	cmp	x24, #15
	strb	w21, [x26, x27]
	b.hi	.LBB8_145
	mov	x8, xzr
.LBB8_143:
	ldrb	w9, [x28, x8]
	cmp	w9, w21, uxtb
	b.eq	.LBB8_150
	add	x8, x8, #1
	cmp	x24, x8
	b.ne	.LBB8_143
	b	.LBB8_196
.LBB8_145:
.Ltmp42:
	mov	w0, w21
	mov	x1, x26
	mov	x2, x24
	bl	_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned
.Ltmp43:
	mov	x8, x1
	stp	x0, x1, [x29, #-104]
	cmp	x0, #1
	sub	x2, x29, #64
	sub	x1, x29, #104
	stp	x22, x27, [x29, #-64]
	b.ne	.LBB8_198
	cmp	x8, x27
	b.ne	.LBB8_198
	ldr	q0, [x26]
	ldr	q1, [sp, #320]
	cmeq	v0.16b, v1.16b, v0.16b
	shrn	v0.8b, v0.8h, #4
	fmov	x8, d0
	ands	x8, x8, #0x8888888888888888
	b.eq	.LBB8_154
	rbit	x8, x8
	clz	x8, x8
	add	x8, x26, x8, lsr #2
	sub	x8, x8, x26
	stp	x22, x27, [x29, #-64]
	cmp	x8, x27
	stp	x22, x8, [x29, #-104]
	b.eq	.LBB8_171
	b	.LBB8_234
.LBB8_150:
	cmp	x27, x8
	stp	x22, x8, [x29, #-104]
	stp	x22, x27, [x29, #-64]
	b.ne	.LBB8_240
	mov	x9, x24
	mov	x8, x26
.LBB8_152:
	ldrb	w10, [x8]
	cmp	w10, w21, uxtb
	b.eq	.LBB8_170
	subs	x9, x9, #1
	add	x8, x8, #1
	b.ne	.LBB8_152
	b	.LBB8_195
.LBB8_154:
	ldr	x9, [sp, #272]
	ldr	w10, [sp, #268]
	mov	x8, x28
	cbz	w10, .LBB8_157
.LBB8_155:
	add	x9, x8, x20
	ldr	q6, [sp, #320]
	ldp	q0, q1, [x9, #16]
	ldp	q4, q5, [x9, #48]
	cmeq	v3.16b, v6.16b, v0.16b
	cmeq	v2.16b, v6.16b, v1.16b
	cmeq	v1.16b, v6.16b, v4.16b
	cmeq	v0.16b, v6.16b, v5.16b
	orr	v4.16b, v2.16b, v3.16b
	orr	v5.16b, v1.16b, v0.16b
	orr	v4.16b, v4.16b, v5.16b
	umaxp	v4.16b, v4.16b, v4.16b
	fmov	x9, d4
	cbnz	x9, .LBB8_163
	add	x8, x8, #64
	ldr	x10, [sp, #312]
	add	x9, x8, x20
	add	x9, x9, #16
	cmp	x9, x10
	b.ls	.LBB8_155
.LBB8_157:
	ldr	x8, [sp, #304]
	cmp	x9, x8
	b.hi	.LBB8_160
.LBB8_158:
	ldr	q0, [x9]
	ldr	q1, [sp, #320]
	cmeq	v0.16b, v1.16b, v0.16b
	shrn	v0.8b, v0.8h, #4
	fmov	x8, d0
	ands	x8, x8, #0x8888888888888888
	b.ne	.LBB8_165
	add	x9, x9, #16
	ldr	x8, [sp, #304]
	cmp	x9, x8
	b.ls	.LBB8_158
.LBB8_160:
	add	x8, x26, x24
	cmp	x9, x8
	b.hs	.LBB8_195
	add	x8, x26, x24
	ldr	q1, [sp, #320]
	ldr	q0, [x8, #-16]!
	cmeq	v0.16b, v1.16b, v0.16b
	shrn	v0.8b, v0.8h, #4
	fmov	x9, d0
	ands	x9, x9, #0x8888888888888888
	b.eq	.LBB8_195
	rbit	x9, x9
	clz	x9, x9
	add	x8, x8, x9, lsr #2
	sub	x8, x8, x26
	stp	x22, x27, [x29, #-64]
	cmp	x8, x27
	stp	x22, x8, [x29, #-104]
	b.eq	.LBB8_171
	b	.LBB8_234
.LBB8_163:
	shrn	v3.8b, v3.8h, #4
	fmov	x9, d3
	ands	x9, x9, #0x8888888888888888
	b.eq	.LBB8_166
	rbit	x9, x9
	add	x8, x8, x20
	clz	x9, x9
	add	x8, x8, x9, lsr #2
	add	x8, x8, #16
	sub	x8, x8, x26
	stp	x22, x27, [x29, #-64]
	cmp	x8, x27
	stp	x22, x8, [x29, #-104]
	b.eq	.LBB8_171
	b	.LBB8_234
.LBB8_165:
	rbit	x8, x8
	clz	x8, x8
	add	x8, x9, x8, lsr #2
	sub	x8, x8, x26
	stp	x22, x27, [x29, #-64]
	cmp	x8, x27
	stp	x22, x8, [x29, #-104]
	b.eq	.LBB8_171
	b	.LBB8_234
.LBB8_166:
	shrn	v2.8b, v2.8h, #4
	fmov	x9, d2
	ands	x9, x9, #0x8888888888888888
	b.eq	.LBB8_168
	rbit	x9, x9
	add	x8, x8, x20
	clz	x9, x9
	add	x8, x8, x9, lsr #2
	add	x8, x8, #32
	sub	x8, x8, x26
	stp	x22, x27, [x29, #-64]
	cmp	x8, x27
	stp	x22, x8, [x29, #-104]
	b.eq	.LBB8_171
	b	.LBB8_234
.LBB8_168:
	shrn	v1.8b, v1.8h, #4
	fmov	x9, d1
	ands	x9, x9, #0x8888888888888888
	b.eq	.LBB8_172
	rbit	x9, x9
	add	x8, x8, x20
	clz	x9, x9
	add	x8, x8, x9, lsr #2
	add	x8, x8, #48
.LBB8_170:
	sub	x8, x8, x26
	stp	x22, x27, [x29, #-64]
	cmp	x8, x27
	stp	x22, x8, [x29, #-104]
	b.ne	.LBB8_234
.LBB8_171:
	add	x25, x19, #1
	cmp	x23, #3
	ldr	w8, [sp, #292]
	stur	x25, [x29, #-72]
	strb	w8, [x26, x27]
	b.ne	.LBB8_140
	b	.LBB8_173
.LBB8_172:
	shrn	v0.8b, v0.8h, #4
	add	x8, x8, x20
	fmov	x9, d0
	and	x9, x9, #0x8888888888888888
	rbit	x9, x9
	clz	x9, x9
	add	x8, x8, x9, lsr #2
	add	x8, x8, #64
	sub	x8, x8, x26
	stp	x22, x27, [x29, #-64]
	cmp	x8, x27
	stp	x22, x8, [x29, #-104]
	b.eq	.LBB8_171
	b	.LBB8_234
.LBB8_173:
	ldr	x20, [sp, #248]
	cmp	x24, #2
	sub	x27, x24, #1
	b.ls	.LBB8_130
	cmp	x24, #15
	strb	w21, [x26, #1]
	strb	w21, [x26, x27]
	b.hi	.LBB8_178
	ldr	x25, [sp, #296]
	mov	x8, xzr
.LBB8_176:
	ldrb	w9, [x28, x8]
	cmp	w9, w21, uxtb
	b.eq	.LBB8_180
	add	x8, x8, #1
	cmp	x24, x8
	b.ne	.LBB8_176
	b	.LBB8_215
.LBB8_178:
.Ltmp48:
	mov	w0, w21
	mov	x1, x26
	mov	x2, x24
	bl	_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned
.Ltmp49:
	ldr	x25, [sp, #296]
	mov	x8, x1
	b	.LBB8_181
.LBB8_180:
	mov	w0, #1
.LBB8_181:
	cmp	x0, #1
	sub	x1, x29, #144
	stp	x0, x8, [x29, #-144]
	b.ne	.LBB8_247
	cmp	x8, #1
	adrp	x5, .Lalloc_9a88f186c58a52ebd3ead6ae60a6ebb4
	add	x5, x5, :lo12:.Lalloc_9a88f186c58a52ebd3ead6ae60a6ebb4
	b.ne	.LBB8_202
	mov	w0, w21
	mov	x1, x26
	mov	x2, x24
	bl	_RNvCs1StpruGFt5h_6driver10crate_find
	mov	x8, x1
	sub	x1, x29, #144
	cmp	x0, #1
	stp	x0, x8, [x29, #-144]
	b.ne	.LBB8_201
	cmp	x8, #1
	adrp	x5, .Lalloc_7e7ae35d6636461e2066d261a89d0d5e
	add	x5, x5, :lo12:.Lalloc_7e7ae35d6636461e2066d261a89d0d5e
	b.eq	.LBB8_129
	b	.LBB8_202
.LBB8_185:
	ldr	x24, [sp, #296]
	add	x19, x25, #64
.LBB8_186:
	mov	w0, w21
	mov	x1, x24
	mov	x2, xzr
	bl	_RNvCs1StpruGFt5h_6driver10crate_find
	stp	x0, x1, [x29, #-144]
	tbnz	w0, #0, .LBB8_199
	sub	x20, x20, #1
	add	x24, x24, #1
	cmn	x20, #64
	b.ne	.LBB8_186
	b	.LBB8_125
.LBB8_188:
	ldr	x0, [sp, #296]
	mov	w8, #255
	mov	w1, #4352
	mov	w2, #1
	bic	w19, w8, w21
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	ldr	w21, [sp, #292]
	mov	w20, #4096
	cbnz	w19, .LBB8_120
	adrp	x9, :got:_RNvXsi_NtNtNtCshp6Wxz1DwXO_4core3fmt3num3impjNtB9_7Display3fmt
	sub	x8, x29, #72
	ldr	x9, [x9, :got_lo12:_RNvXsi_NtNtNtCshp6Wxz1DwXO_4core3fmt3num3impjNtB9_7Display3fmt]
	stp	x8, x9, [sp, #336]
.Ltmp53:
	adrp	x0, .Lalloc_5563914751c9051696d34dc682afe217
	add	x0, x0, :lo12:.Lalloc_5563914751c9051696d34dc682afe217
	add	x1, sp, #336
	bl	_RNvNtNtCs68fcPop4ROg_3std2io5stdio6__print
.Ltmp54:
	sub	x0, x29, #32
	bl	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver
	b	.LBB8_118
.LBB8_191:
	mov	w28, wzr
	mov	w26, #1
	stur	xzr, [x29, #-64]
	add	x1, x22, x20
	cmp	x1, x22
	b.hs	.LBB8_93
.LBB8_192:
.Ltmp15:
	mov	w2, #128
	adrp	x3, .Lalloc_62b520d5cd86147517119ea4db494764
	add	x3, x3, :lo12:.Lalloc_62b520d5cd86147517119ea4db494764
	mov	x0, x22
	movk	w2, #2, lsl #16
	bl	_RNvNtNtCshp6Wxz1DwXO_4core5slice5index16slice_index_fail
.Ltmp16:
	b	.LBB8_245
.LBB8_193:
.Ltmp51:
	adrp	x3, .Lalloc_f2adc74b1f56daa88b0b65f22487c555
	add	x3, x3, :lo12:.Lalloc_f2adc74b1f56daa88b0b65f22487c555
	mov	x0, x20
	mov	w2, #4352
	ldr	x25, [sp, #296]
	bl	_RNvNtNtCshp6Wxz1DwXO_4core5slice5index16slice_index_fail
.Ltmp52:
	b	.LBB8_245
.LBB8_194:
	adrp	x8, .Lalloc_8e81dfbcb5e45a532aa30c8331b0b47e
	add	x8, x8, :lo12:.Lalloc_8e81dfbcb5e45a532aa30c8331b0b47e
	ldr	x25, [sp, #296]
	sub	x1, x29, #144
	str	x8, [sp, #8]
	adrp	x5, .Lalloc_63fa703696994748cc44a0c124173934
	add	x5, x5, :lo12:.Lalloc_63fa703696994748cc44a0c124173934
	b	.LBB8_202
.LBB8_195:
	mov	w8, #1
	adrp	x9, .Lalloc_5cb5418a67bcd818f2b2b52e16b6c0ca
	add	x9, x9, :lo12:.Lalloc_5cb5418a67bcd818f2b2b52e16b6c0ca
	stur	xzr, [x29, #-104]
	str	x9, [sp]
	stur	x8, [x29, #-64]
	b	.LBB8_197
.LBB8_196:
	mov	w8, #1
	ldr	x9, [sp, #200]
	stur	x8, [x29, #-64]
	adrp	x8, .Lalloc_f6eff4434d88d939ba74cb3c7aa163d7
	add	x8, x8, :lo12:.Lalloc_f6eff4434d88d939ba74cb3c7aa163d7
	stp	xzr, x9, [x29, #-104]
	str	x8, [sp]
.LBB8_197:
	sub	x2, x29, #64
	sub	x1, x29, #104
	stur	x27, [x29, #-56]
.LBB8_198:
.Ltmp45:
	ldr	x5, [sp]
	mov	w0, wzr
	mov	x3, xzr
	bl	_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedINtNtB4_6option6OptionjEBM_EB4_
.Ltmp46:
	b	.LBB8_245
.LBB8_199:
	sub	x8, x25, x20
	adrp	x5, .Lalloc_63fa703696994748cc44a0c124173934
	add	x5, x5, :lo12:.Lalloc_63fa703696994748cc44a0c124173934
	stur	x8, [x29, #-72]
.LBB8_200:
	adrp	x8, .Lalloc_8e81dfbcb5e45a532aa30c8331b0b47e
	add	x8, x8, :lo12:.Lalloc_8e81dfbcb5e45a532aa30c8331b0b47e
	ldr	x25, [sp, #296]
	str	x8, [sp, #8]
	sub	x1, x29, #144
	b	.LBB8_202
.LBB8_201:
	adrp	x5, .Lalloc_7e7ae35d6636461e2066d261a89d0d5e
	add	x5, x5, :lo12:.Lalloc_7e7ae35d6636461e2066d261a89d0d5e
.LBB8_202:
.Ltmp55:
	ldr	x2, [sp, #8]
	mov	w0, wzr
	mov	x3, xzr
	bl	_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedINtNtB4_6option6OptionjEBM_EB4_
.Ltmp56:
	b	.LBB8_245
.LBB8_203:
	sub	w8, w11, #48
	cmp	w8, #10
	mov	w8, #1
	cinc	w10, w8, lo
	b	.LBB8_205
.LBB8_204:
	mov	w10, #2
.LBB8_205:
	adrp	x4, .Lalloc_0466fbcb6efd6e27b2f9ddb5c8bd67bf
	add	x4, x4, :lo12:.Lalloc_0466fbcb6efd6e27b2f9ddb5c8bd67bf
	strb	w10, [sp, #336]
	b	.LBB8_212
.LBB8_206:
	sub	w8, w11, #48
	cmp	w8, #10
	mov	w8, #1
	cinc	w10, w8, lo
	b	.LBB8_208
.LBB8_207:
	mov	w10, #2
.LBB8_208:
	strb	w10, [sp, #336]
	adrp	x4, .Lalloc_5c213bcbaef43ebb221d4146a2acfd23
	add	x4, x4, :lo12:.Lalloc_5c213bcbaef43ebb221d4146a2acfd23
	b	.LBB8_212
.LBB8_209:
	sub	w8, w12, #48
	cmp	w8, #10
	mov	w8, #1
	cinc	w10, w8, lo
	b	.LBB8_211
.LBB8_210:
	mov	w10, #2
.LBB8_211:
	strb	w10, [sp, #336]
	adrp	x4, .Lalloc_e2a94c7f70cdaf98936bf1e119b31d15
	add	x4, x4, :lo12:.Lalloc_e2a94c7f70cdaf98936bf1e119b31d15
.LBB8_212:
	add	x2, sp, #336
.Ltmp11:
	adrp	x0, .Lalloc_00ae4b301f7fab8ac9617c03fcbd7274
	add	x0, x0, :lo12:.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274
	adrp	x3, .Lvtable.1
	add	x3, x3, :lo12:.Lvtable.1
	mov	w1, #43
	bl	_RNvNtCshp6Wxz1DwXO_4core6result13unwrap_failed
.Ltmp12:
	b	.LBB8_245
.LBB8_213:
.Ltmp40:
	adrp	x2, .Lalloc_2bbc4fcfb26821af03642ab87949ed0b
	add	x2, x2, :lo12:.Lalloc_2bbc4fcfb26821af03642ab87949ed0b
	mov	x0, x27
	mov	x1, x24
	ldr	x25, [sp, #296]
	bl	_RNvNtCshp6Wxz1DwXO_4core9panicking18panic_bounds_check
.Ltmp41:
	b	.LBB8_245
.LBB8_214:
	mov	w9, #1
	adrp	x5, .Lalloc_9e293b1cd83d8f2c3d64145f659adffa
	add	x5, x5, :lo12:.Lalloc_9e293b1cd83d8f2c3d64145f659adffa
	stp	x9, x8, [x29, #-144]
	b	.LBB8_200
.LBB8_215:
	adrp	x8, .Lalloc_018282178791e8a09b18fbb1ed888779
	add	x8, x8, :lo12:.Lalloc_018282178791e8a09b18fbb1ed888779
	stp	xzr, x27, [x29, #-144]
	adrp	x5, .Lalloc_9a88f186c58a52ebd3ead6ae60a6ebb4
	add	x5, x5, :lo12:.Lalloc_9a88f186c58a52ebd3ead6ae60a6ebb4
	str	x8, [sp, #8]
	sub	x1, x29, #144
	b	.LBB8_202
.LBB8_216:
.Ltmp9:
	adrp	x0, .Lalloc_476509aa7047bd805d630c6546685797
	add	x0, x0, :lo12:.Lalloc_476509aa7047bd805d630c6546685797
	adrp	x2, .Lalloc_1cd847217f7fad949c219121493e6692
	add	x2, x2, :lo12:.Lalloc_1cd847217f7fad949c219121493e6692
	mov	w1, #14
	bl	_RNvNtCshp6Wxz1DwXO_4core9panicking5panic
.Ltmp10:
	b	.LBB8_245
.LBB8_217:
.Ltmp34:
	mov	w1, #128
	mov	w0, #64
	movk	w1, #2, lsl #16
	bl	_RNvNtCs6sh1iPzjxYC_5alloc5alloc18handle_alloc_error
.Ltmp35:
	b	.LBB8_245
.LBB8_218:
	adrp	x5, .Lalloc_e606c281df34283ee24a24505deb5779
	add	x5, x5, :lo12:.Lalloc_e606c281df34283ee24a24505deb5779
	sub	x2, x29, #80
	add	x1, sp, #336
	b	.LBB8_220
.LBB8_219:
	adrp	x5, .Lalloc_c14e8c434fcc3b92ba63da8be42f0c60
	add	x5, x5, :lo12:.Lalloc_c14e8c434fcc3b92ba63da8be42f0c60
	add	x2, sp, #336
.LBB8_220:
.Ltmp27:
	mov	w0, wzr
	mov	x3, xzr
	bl	_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedjjEB4_
.Ltmp28:
	b	.LBB8_245
.LBB8_221:
.Ltmp31:
	adrp	x0, .Lalloc_476509aa7047bd805d630c6546685797
	add	x0, x0, :lo12:.Lalloc_476509aa7047bd805d630c6546685797
	adrp	x2, .Lalloc_a9a7dce65c6d1c57d540b735479f6251
	add	x2, x2, :lo12:.Lalloc_a9a7dce65c6d1c57d540b735479f6251
	mov	w1, #14
	bl	_RNvNtCshp6Wxz1DwXO_4core9panicking5panic
.Ltmp32:
	b	.LBB8_245
.LBB8_222:
	mov	w10, #1
	b	.LBB8_205
.LBB8_223:
	mov	w10, #1
	b	.LBB8_208
.LBB8_224:
	mov	w10, #1
	b	.LBB8_211
.LBB8_225:
	ldur	x8, [x29, #-136]
	ldur	x9, [x29, #-120]
	mov	w10, #8
	stp	xzr, x10, [x29, #-32]
	subs	x9, x9, x8
	stur	xzr, [x29, #-16]
	b.ne	.LBB8_230
.LBB8_226:
	ldur	x8, [x29, #-128]
	cbz	x8, .LBB8_228
	add	x8, x8, x8, lsl #1
	ldur	x0, [x29, #-144]
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB8_228:
	mov	x1, xzr
.LBB8_229:
.Ltmp63:
	adrp	x2, .Lalloc_76cbd47331a82c9bea1da249cd622be9
	add	x2, x2, :lo12:.Lalloc_76cbd47331a82c9bea1da249cd622be9
	mov	w0, #1
	bl	_RNvNtCshp6Wxz1DwXO_4core9panicking18panic_bounds_check
.Ltmp64:
	b	.LBB8_245
.LBB8_230:
	mov	x10, #-6148914691236517206
	add	x20, x8, #8
	movk	x10, #43691
	umulh	x9, x9, x10
	lsr	x19, x9, #4
	b	.LBB8_232
.LBB8_231:
	subs	x19, x19, #1
	add	x20, x20, #24
	b.eq	.LBB8_226
.LBB8_232:
	ldur	x1, [x20, #-8]
	cbz	x1, .LBB8_231
	ldr	x0, [x20]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB8_231
.LBB8_234:
	adrp	x8, .Lalloc_5cb5418a67bcd818f2b2b52e16b6c0ca
	add	x8, x8, :lo12:.Lalloc_5cb5418a67bcd818f2b2b52e16b6c0ca
	ldr	x25, [sp, #296]
	sub	x2, x29, #64
	sub	x1, x29, #104
	str	x8, [sp]
	b	.LBB8_198
.LBB8_235:
	adrp	x2, .Lalloc_97f20d6aba9b53792d2804ec8a9b80db
	add	x2, x2, :lo12:.Lalloc_97f20d6aba9b53792d2804ec8a9b80db
	mov	w0, #2
	b	.LBB8_238
.LBB8_236:
	adrp	x2, .Lalloc_91bb3c8e2e46ccbc16597808f0bab401
	add	x2, x2, :lo12:.Lalloc_91bb3c8e2e46ccbc16597808f0bab401
	mov	w0, #3
	mov	w1, #3
	b	.LBB8_238
.LBB8_237:
	adrp	x2, .Lalloc_430a626d7ad8fa09ca7e11f1cb9a43c6
	add	x2, x2, :lo12:.Lalloc_430a626d7ad8fa09ca7e11f1cb9a43c6
	mov	w0, #5
.LBB8_238:
.Ltmp36:
	bl	_RNvNtCshp6Wxz1DwXO_4core9panicking18panic_bounds_check
.Ltmp37:
	b	.LBB8_245
.LBB8_239:
.Ltmp13:
	mov	w1, #128
	adrp	x2, .Lalloc_fee2473f5ebd52e53d5ac249e1622a16
	add	x2, x2, :lo12:.Lalloc_fee2473f5ebd52e53d5ac249e1622a16
	movk	w1, #2, lsl #16
	bl	_RNvNtCshp6Wxz1DwXO_4core9panicking18panic_bounds_check
.Ltmp14:
	b	.LBB8_245
.LBB8_240:
	sub	x2, x29, #64
	sub	x1, x29, #104
	b	.LBB8_198
.LBB8_241:
	mov	w10, wzr
	b	.LBB8_205
.LBB8_242:
	mov	w10, wzr
	b	.LBB8_208
.LBB8_243:
	mov	w10, wzr
	b	.LBB8_211
.LBB8_244:
.Ltmp58:
	mov	w0, #1
	mov	w1, #4352
	bl	_RNvNtCs6sh1iPzjxYC_5alloc7raw_vec12handle_error
.Ltmp59:
.LBB8_245:
	brk	#0x1
.LBB8_246:
	adrp	x8, .Lalloc_8e81dfbcb5e45a532aa30c8331b0b47e
	add	x8, x8, :lo12:.Lalloc_8e81dfbcb5e45a532aa30c8331b0b47e
	ldr	x25, [sp, #296]
	sub	x1, x29, #144
	str	x8, [sp, #8]
	adrp	x5, .Lalloc_9e293b1cd83d8f2c3d64145f659adffa
	add	x5, x5, :lo12:.Lalloc_9e293b1cd83d8f2c3d64145f659adffa
	b	.LBB8_202
.LBB8_247:
	adrp	x5, .Lalloc_9a88f186c58a52ebd3ead6ae60a6ebb4
	add	x5, x5, :lo12:.Lalloc_9a88f186c58a52ebd3ead6ae60a6ebb4
	b	.LBB8_202
.LBB8_248:
.Ltmp2:
	mov	x20, x0
	b	.LBB8_273
.LBB8_249:
.Ltmp26:
	ldr	x21, [sp, #320]
	b	.LBB8_258
.LBB8_250:
.Ltmp8:
	mov	x20, x0
	cbz	x21, .LBB8_254
	mov	x0, x22
	mov	x1, x21
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	add	x0, sp, #336
	bl	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECs1StpruGFt5h_6driver
	sub	x0, x29, #64
	bl	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver
	mov	x0, x20
	bl	_Unwind_Resume
.LBB8_252:
.Ltmp23:
	b	.LBB8_258
.LBB8_253:
.Ltmp5:
	mov	x20, x0
.LBB8_254:
	add	x0, sp, #336
	bl	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECs1StpruGFt5h_6driver
	sub	x0, x29, #64
	bl	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver
	mov	x0, x20
	bl	_Unwind_Resume
.LBB8_255:
.Ltmp50:
	ldr	x25, [sp, #296]
	b	.LBB8_262
.LBB8_256:
.Ltmp44:
	b	.LBB8_262
.LBB8_257:
.Ltmp33:
.LBB8_258:
	mov	x20, x0
	mov	w1, #128
	mov	x0, x21
	mov	w2, #64
	movk	w1, #2, lsl #16
	b	.LBB8_263
.LBB8_259:
.Ltmp65:
	mov	x20, x0
	b	.LBB8_264
.LBB8_260:
.Ltmp47:
	b	.LBB8_262
.LBB8_261:
.Ltmp57:
.LBB8_262:
	mov	x20, x0
	mov	x0, x25
	mov	w1, #4352
	mov	w2, #1
.LBB8_263:
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB8_264:
	ldp	x19, x21, [x29, #-24]
	cbnz	x21, .LBB8_267
.LBB8_265:
	ldur	x8, [x29, #-32]
	cbz	x8, .LBB8_275
	add	x8, x8, x8, lsl #1
	mov	x0, x19
	lsl	x1, x8, #3
	mov	w2, #8
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	mov	x0, x20
	bl	_Unwind_Resume
.LBB8_267:
	add	x22, x19, #8
	b	.LBB8_269
.LBB8_268:
	subs	x21, x21, #1
	add	x22, x22, #24
	b.eq	.LBB8_265
.LBB8_269:
	ldur	x1, [x22, #-8]
	cbz	x1, .LBB8_268
	ldr	x0, [x22]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB8_268
.LBB8_271:
.Ltmp62:
	mov	x20, x0
	cbz	x21, .LBB8_273
	mov	x0, x22
	mov	x1, x21
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB8_273:
	ldur	x8, [x29, #-136]
	ldur	x9, [x29, #-120]
	subs	x9, x9, x8
	b.ne	.LBB8_276
.LBB8_274:
	ldur	x8, [x29, #-128]
	cbnz	x8, .LBB8_280
.LBB8_275:
	mov	x0, x20
	bl	_Unwind_Resume
.LBB8_276:
	mov	x10, #-6148914691236517206
	add	x21, x8, #8
	movk	x10, #43691
	umulh	x9, x9, x10
	lsr	x19, x9, #4
	b	.LBB8_278
.LBB8_277:
	subs	x19, x19, #1
	add	x21, x21, #24
	b.eq	.LBB8_274
.LBB8_278:
	ldur	x1, [x21, #-8]
	cbz	x1, .LBB8_277
	ldr	x0, [x21]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB8_277
.LBB8_280:
	add	x8, x8, x8, lsl #1
	ldur	x0, [x29, #-144]
	lsl	x1, x8, #3
	mov	w2, #8
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	mov	x0, x20
	bl	_Unwind_Resume
.Lfunc_end8:
	.size	_RNvCs1StpruGFt5h_6driver4main, .Lfunc_end8-_RNvCs1StpruGFt5h_6driver4main
	.cfi_endproc
	.section	.gcc_except_table._RNvCs1StpruGFt5h_6driver4main,"a",@progbits
	.p2align	2, 0x0
GCC_except_table8:
.Lexception0:
	.byte	255
	.byte	255
	.byte	1
	.uleb128 .Lcst_end0-.Lcst_begin0
.Lcst_begin0:
	.uleb128 .Lfunc_begin0-.Lfunc_begin0
	.uleb128 .Ltmp0-.Lfunc_begin0
	.byte	0
	.byte	0
	.uleb128 .Ltmp0-.Lfunc_begin0
	.uleb128 .Ltmp1-.Ltmp0
	.uleb128 .Ltmp2-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp60-.Lfunc_begin0
	.uleb128 .Ltmp61-.Ltmp60
	.uleb128 .Ltmp62-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp3-.Lfunc_begin0
	.uleb128 .Ltmp4-.Ltmp3
	.uleb128 .Ltmp5-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp6-.Lfunc_begin0
	.uleb128 .Ltmp7-.Ltmp6
	.uleb128 .Ltmp8-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp7-.Lfunc_begin0
	.uleb128 .Ltmp17-.Ltmp7
	.byte	0
	.byte	0
	.uleb128 .Ltmp17-.Lfunc_begin0
	.uleb128 .Ltmp20-.Ltmp17
	.uleb128 .Ltmp33-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp21-.Lfunc_begin0
	.uleb128 .Ltmp22-.Ltmp21
	.uleb128 .Ltmp23-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp24-.Lfunc_begin0
	.uleb128 .Ltmp25-.Ltmp24
	.uleb128 .Ltmp26-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp29-.Lfunc_begin0
	.uleb128 .Ltmp30-.Ltmp29
	.uleb128 .Ltmp33-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp30-.Lfunc_begin0
	.uleb128 .Ltmp38-.Ltmp30
	.byte	0
	.byte	0
	.uleb128 .Ltmp38-.Lfunc_begin0
	.uleb128 .Ltmp39-.Ltmp38
	.uleb128 .Ltmp50-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp42-.Lfunc_begin0
	.uleb128 .Ltmp43-.Ltmp42
	.uleb128 .Ltmp44-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp48-.Lfunc_begin0
	.uleb128 .Ltmp49-.Ltmp48
	.uleb128 .Ltmp50-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp53-.Lfunc_begin0
	.uleb128 .Ltmp54-.Ltmp53
	.uleb128 .Ltmp65-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp15-.Lfunc_begin0
	.uleb128 .Ltmp16-.Ltmp15
	.uleb128 .Ltmp33-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp51-.Lfunc_begin0
	.uleb128 .Ltmp52-.Ltmp51
	.uleb128 .Ltmp57-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp45-.Lfunc_begin0
	.uleb128 .Ltmp46-.Ltmp45
	.uleb128 .Ltmp47-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp55-.Lfunc_begin0
	.uleb128 .Ltmp56-.Ltmp55
	.uleb128 .Ltmp57-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp11-.Lfunc_begin0
	.uleb128 .Ltmp12-.Ltmp11
	.uleb128 .Ltmp65-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp40-.Lfunc_begin0
	.uleb128 .Ltmp41-.Ltmp40
	.uleb128 .Ltmp47-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp9-.Lfunc_begin0
	.uleb128 .Ltmp35-.Ltmp9
	.uleb128 .Ltmp65-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp27-.Lfunc_begin0
	.uleb128 .Ltmp32-.Ltmp27
	.uleb128 .Ltmp33-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp63-.Lfunc_begin0
	.uleb128 .Ltmp37-.Ltmp63
	.uleb128 .Ltmp65-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp13-.Lfunc_begin0
	.uleb128 .Ltmp14-.Ltmp13
	.uleb128 .Ltmp33-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp58-.Lfunc_begin0
	.uleb128 .Ltmp59-.Ltmp58
	.uleb128 .Ltmp65-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp59-.Lfunc_begin0
	.uleb128 .Lfunc_end8-.Ltmp59
	.byte	0
	.byte	0
.Lcst_end0:
	.p2align	2, 0x0

	.section	.text._RNvCs1StpruGFt5h_6driver8std_find,"ax",@progbits
	.p2align	2
	.type	_RNvCs1StpruGFt5h_6driver8std_find,@function
_RNvCs1StpruGFt5h_6driver8std_find:
	.cfi_startproc
	mov	x8, x1
	cmp	x2, #15
	mov	w9, w0
	b.hi	.LBB9_6
	cbz	x2, .LBB9_8
	mov	x10, xzr
	mov	w0, #1
.LBB9_3:
	mov	x1, x10
	ldrb	w10, [x8, x10]
	cmp	w10, w9, uxtb
	b.eq	.LBB9_7
	add	x10, x1, #1
	cmp	x2, x10
	b.ne	.LBB9_3
	mov	x0, xzr
	ret
.LBB9_6:
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w0, w9
	mov	x1, x8
	bl	_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
.LBB9_7:
	ret
.LBB9_8:
	mov	x0, xzr
	ret
.Lfunc_end9:
	.size	_RNvCs1StpruGFt5h_6driver8std_find, .Lfunc_end9-_RNvCs1StpruGFt5h_6driver8std_find
	.cfi_endproc

	.section	.text.unlikely._RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs1StpruGFt5h_6driver,"ax",@progbits
	.p2align	2
	.type	_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs1StpruGFt5h_6driver,@function
_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs1StpruGFt5h_6driver:
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
	mov	x8, #6148914691236517205
	mov	x19, x0
	movk	x8, #1365, lsl #48
	cmp	x3, x8
	b.ls	.LBB10_2
	mov	w8, #1
	mov	w9, #8
	str	xzr, [x19, x9]
	str	x8, [x19]
	.cfi_def_cfa wsp, 32
	ldp	x20, x19, [sp, #16]
	ldp	x29, x30, [sp], #32
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB10_2:
	.cfi_restore_state
	.cfi_remember_state
	add	x8, x3, x3, lsl #1
	lsl	x20, x8, #3
	cbz	x1, .LBB10_4
	add	x8, x1, x1, lsl #1
	mov	x0, x2
	mov	w2, #8
	mov	x3, x20
	lsl	x1, x8, #3
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_realloc
	cbnz	x0, .LBB10_8
	b	.LBB10_6
.LBB10_4:
	cbz	x20, .LBB10_7
	bl	_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	x0, x20
	mov	w1, #8
	bl	_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc
	cbnz	x0, .LBB10_8
.LBB10_6:
	mov	w8, #8
	str	x8, [x19, #8]
	mov	w8, #1
	mov	w9, #16
	str	x20, [x19, x9]
	str	x8, [x19]
	.cfi_def_cfa wsp, 32
	ldp	x20, x19, [sp, #16]
	ldp	x29, x30, [sp], #32
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB10_7:
	.cfi_restore_state
	mov	w0, #8
.LBB10_8:
	str	x0, [x19, #8]
	mov	w9, #16
	str	x20, [x19, x9]
	str	xzr, [x19]
	.cfi_def_cfa wsp, 32
	ldp	x20, x19, [sp, #16]
	ldp	x29, x30, [sp], #32
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end10:
	.size	_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs1StpruGFt5h_6driver, .Lfunc_end10-_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs1StpruGFt5h_6driver
	.cfi_endproc

	.section	.text._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver,"ax",@progbits
	.p2align	2
	.type	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver,@function
_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver:
	.cfi_startproc
	ldr	x8, [x0]
	adrp	x9, .Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver
	add	x9, x9, :lo12:.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver
	mov	x0, x1
	ldrb	w8, [x8]
	ldrb	w2, [x9, x8]
	adrp	x9, .Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.46.rel
	add	x9, x9, :lo12:.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.46.rel
	ldrsw	x8, [x9, x8, lsl #2]
	add	x1, x9, x8
	b	_RNvMsa_NtCshp6Wxz1DwXO_4core3fmtNtB5_9Formatter9write_str
.Lfunc_end11:
	.size	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver, .Lfunc_end11-_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver
	.cfi_endproc

	.section	.text._RNvXsd_NtNtCshp6Wxz1DwXO_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt,"ax",@progbits
	.p2align	2
	.type	_RNvXsd_NtNtCshp6Wxz1DwXO_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt,@function
_RNvXsd_NtNtCshp6Wxz1DwXO_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt:
	.cfi_startproc
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	x8, x1
	str	x0, [sp, #8]
	adrp	x1, .Lalloc_f62df14955f7d78bca139b0a7668683d
	add	x1, x1, :lo12:.Lalloc_f62df14955f7d78bca139b0a7668683d
	adrp	x3, .Lalloc_a5d866b1768ad3f826bccdb004a1a8ae
	add	x3, x3, :lo12:.Lalloc_a5d866b1768ad3f826bccdb004a1a8ae
	adrp	x6, .Lvtable.2
	add	x6, x6, :lo12:.Lvtable.2
	add	x5, sp, #8
	mov	x0, x8
	mov	w2, #13
	mov	w4, #4
	bl	_RNvMsa_NtCshp6Wxz1DwXO_4core3fmtNtB5_9Formatter26debug_struct_field1_finish
	.cfi_def_cfa wsp, 32
	ldp	x29, x30, [sp, #16]
	add	sp, sp, #32
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end12:
	.size	_RNvXsd_NtNtCshp6Wxz1DwXO_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt, .Lfunc_end12-_RNvXsd_NtNtCshp6Wxz1DwXO_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
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
	adrp	x8, _RNvCs1StpruGFt5h_6driver4main
	add	x8, x8, :lo12:_RNvCs1StpruGFt5h_6driver4main
	adrp	x1, .Lvtable.0
	add	x1, x1, :lo12:.Lvtable.0
	add	x0, sp, #8
	mov	w4, wzr
	str	x8, [sp, #8]
	bl	_RNvNtCs68fcPop4ROg_3std2rt19lang_start_internal
	ldp	x29, x30, [sp, #16]
	add	sp, sp, #32
	ret
.Lfunc_end13:
	.size	main, .Lfunc_end13-main
	.cfi_endproc

	.type	.Lalloc_8e81dfbcb5e45a532aa30c8331b0b47e,@object
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	3, 0x0
.Lalloc_8e81dfbcb5e45a532aa30c8331b0b47e:
	.zero	8
	.zero	8
	.size	.Lalloc_8e81dfbcb5e45a532aa30c8331b0b47e, 16

	.type	.Lvtable.0,@object
	.section	.data.rel.ro..Lvtable.0,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.0:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.xword	_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCs1StpruGFt5h_6driver
	.xword	_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Cs1StpruGFt5h_6driver
	.xword	_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Cs1StpruGFt5h_6driver
	.size	.Lvtable.0, 48

	.type	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_b2b1f45faefdb6cfee69b54794ef8140:
	.asciz	"/tmp/memchr-std-crate-20261109/driver.rs"
	.size	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140, 41

	.type	.Lalloc_76cbd47331a82c9bea1da249cd622be9,@object
	.section	.data.rel.ro..Lalloc_76cbd47331a82c9bea1da249cd622be9,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_76cbd47331a82c9bea1da249cd622be9:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000\026\000\000\000\f\000\000"
	.size	.Lalloc_76cbd47331a82c9bea1da249cd622be9, 24

	.type	.Lalloc_476509aa7047bd805d630c6546685797,@object
	.section	.rodata..Lalloc_476509aa7047bd805d630c6546685797,"a",@progbits
.Lalloc_476509aa7047bd805d630c6546685797:
	.ascii	"explicit panic"
	.size	.Lalloc_476509aa7047bd805d630c6546685797, 14

	.type	.Lalloc_1cd847217f7fad949c219121493e6692,@object
	.section	.data.rel.ro..Lalloc_1cd847217f7fad949c219121493e6692,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_1cd847217f7fad949c219121493e6692:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000.\000\000\000o\000\000"
	.size	.Lalloc_1cd847217f7fad949c219121493e6692, 24

	.type	.Lalloc_97f20d6aba9b53792d2804ec8a9b80db,@object
	.section	.data.rel.ro..Lalloc_97f20d6aba9b53792d2804ec8a9b80db,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_97f20d6aba9b53792d2804ec8a9b80db:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000/\000\000\000\027\000\000"
	.size	.Lalloc_97f20d6aba9b53792d2804ec8a9b80db, 24

	.type	.Lalloc_0466fbcb6efd6e27b2f9ddb5c8bd67bf,@object
	.section	.data.rel.ro..Lalloc_0466fbcb6efd6e27b2f9ddb5c8bd67bf,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_0466fbcb6efd6e27b2f9ddb5c8bd67bf:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000/\000\000\000#\000\000"
	.size	.Lalloc_0466fbcb6efd6e27b2f9ddb5c8bd67bf, 24

	.type	.Lalloc_91bb3c8e2e46ccbc16597808f0bab401,@object
	.section	.data.rel.ro..Lalloc_91bb3c8e2e46ccbc16597808f0bab401,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_91bb3c8e2e46ccbc16597808f0bab401:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000/\000\000\000>\000\000"
	.size	.Lalloc_91bb3c8e2e46ccbc16597808f0bab401, 24

	.type	.Lalloc_5c213bcbaef43ebb221d4146a2acfd23,@object
	.section	.data.rel.ro..Lalloc_5c213bcbaef43ebb221d4146a2acfd23,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_5c213bcbaef43ebb221d4146a2acfd23:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000/\000\000\000J\000\000"
	.size	.Lalloc_5c213bcbaef43ebb221d4146a2acfd23, 24

	.type	.Lalloc_430a626d7ad8fa09ca7e11f1cb9a43c6,@object
	.section	.data.rel.ro..Lalloc_430a626d7ad8fa09ca7e11f1cb9a43c6,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_430a626d7ad8fa09ca7e11f1cb9a43c6:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000/\000\000\000c\000\000"
	.size	.Lalloc_430a626d7ad8fa09ca7e11f1cb9a43c6, 24

	.type	.Lalloc_e2a94c7f70cdaf98936bf1e119b31d15,@object
	.section	.data.rel.ro..Lalloc_e2a94c7f70cdaf98936bf1e119b31d15,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_e2a94c7f70cdaf98936bf1e119b31d15:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000/\000\000\000o\000\000"
	.size	.Lalloc_e2a94c7f70cdaf98936bf1e119b31d15, 24

	.type	.Lalloc_a9a7dce65c6d1c57d540b735479f6251,@object
	.section	.data.rel.ro..Lalloc_a9a7dce65c6d1c57d540b735479f6251,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_a9a7dce65c6d1c57d540b735479f6251:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\0002\000\000\000q\000\000"
	.size	.Lalloc_a9a7dce65c6d1c57d540b735479f6251, 24

	.type	.Lalloc_fee2473f5ebd52e53d5ac249e1622a16,@object
	.section	.data.rel.ro..Lalloc_fee2473f5ebd52e53d5ac249e1622a16,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_fee2473f5ebd52e53d5ac249e1622a16:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\0003\000\000\000\030\000\000"
	.size	.Lalloc_fee2473f5ebd52e53d5ac249e1622a16, 24

	.type	.Lalloc_e606c281df34283ee24a24505deb5779,@object
	.section	.data.rel.ro..Lalloc_e606c281df34283ee24a24505deb5779,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_e606c281df34283ee24a24505deb5779:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\0004\000\000\000!\000\000"
	.size	.Lalloc_e606c281df34283ee24a24505deb5779, 24

	.type	.Lalloc_33f467d265e61babc7c5951f1b7a303c,@object
	.section	.data.rel.ro..Lalloc_33f467d265e61babc7c5951f1b7a303c,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_33f467d265e61babc7c5951f1b7a303c:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\0005\000\000\000\005\000\000"
	.size	.Lalloc_33f467d265e61babc7c5951f1b7a303c, 24

	.type	.Lalloc_c14e8c434fcc3b92ba63da8be42f0c60,@object
	.section	.data.rel.ro..Lalloc_c14e8c434fcc3b92ba63da8be42f0c60,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_c14e8c434fcc3b92ba63da8be42f0c60:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\0009\000\000\000\005\000\000"
	.size	.Lalloc_c14e8c434fcc3b92ba63da8be42f0c60, 24

	.type	.Lalloc_ea7a11d758a5a3d2649481fea54771bb,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_ea7a11d758a5a3d2649481fea54771bb:
	.asciz	"\002n=\300\005 sum=\300\001\n"
	.size	.Lalloc_ea7a11d758a5a3d2649481fea54771bb, 14

	.type	.Lalloc_62b520d5cd86147517119ea4db494764,@object
	.section	.data.rel.ro..Lalloc_62b520d5cd86147517119ea4db494764,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_62b520d5cd86147517119ea4db494764:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\0004\000\000\000\022\000\000"
	.size	.Lalloc_62b520d5cd86147517119ea4db494764, 24

	.type	.Lalloc_5563914751c9051696d34dc682afe217,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_5563914751c9051696d34dc682afe217:
	.asciz	"\007passed \300+ cases per implementation, all 256 needles\n"
	.size	.Lalloc_5563914751c9051696d34dc682afe217, 54

	.type	.Lalloc_018282178791e8a09b18fbb1ed888779,@object
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	3, 0x0
.Lalloc_018282178791e8a09b18fbb1ed888779:
	.asciz	"\001\000\000\000\000\000\000\000\001\000\000\000\000\000\000"
	.size	.Lalloc_018282178791e8a09b18fbb1ed888779, 16

	.type	.Lalloc_9a88f186c58a52ebd3ead6ae60a6ebb4,@object
	.section	.data.rel.ro..Lalloc_9a88f186c58a52ebd3ead6ae60a6ebb4,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_9a88f186c58a52ebd3ead6ae60a6ebb4:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000&\000\000\000\031\000\000"
	.size	.Lalloc_9a88f186c58a52ebd3ead6ae60a6ebb4, 24

	.type	.Lalloc_7e7ae35d6636461e2066d261a89d0d5e,@object
	.section	.data.rel.ro..Lalloc_7e7ae35d6636461e2066d261a89d0d5e,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_7e7ae35d6636461e2066d261a89d0d5e:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000&\000\000\000@\000\000"
	.size	.Lalloc_7e7ae35d6636461e2066d261a89d0d5e, 24

	.type	.Lalloc_2bbc4fcfb26821af03642ab87949ed0b,@object
	.section	.data.rel.ro..Lalloc_2bbc4fcfb26821af03642ab87949ed0b,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_2bbc4fcfb26821af03642ab87949ed0b:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000 \000\000\000\031\000\000"
	.size	.Lalloc_2bbc4fcfb26821af03642ab87949ed0b, 24

	.type	.Lalloc_f6eff4434d88d939ba74cb3c7aa163d7,@object
	.section	.data.rel.ro..Lalloc_f6eff4434d88d939ba74cb3c7aa163d7,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_f6eff4434d88d939ba74cb3c7aa163d7:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000!\000\000\000\031\000\000"
	.size	.Lalloc_f6eff4434d88d939ba74cb3c7aa163d7, 24

	.type	.Lalloc_5cb5418a67bcd818f2b2b52e16b6c0ca,@object
	.section	.data.rel.ro..Lalloc_5cb5418a67bcd818f2b2b52e16b6c0ca,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_5cb5418a67bcd818f2b2b52e16b6c0ca:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000!\000\000\000B\000\000"
	.size	.Lalloc_5cb5418a67bcd818f2b2b52e16b6c0ca, 24

	.type	.Lalloc_63fa703696994748cc44a0c124173934,@object
	.section	.data.rel.ro..Lalloc_63fa703696994748cc44a0c124173934,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_63fa703696994748cc44a0c124173934:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000\035\000\000\0009\000\000"
	.size	.Lalloc_63fa703696994748cc44a0c124173934, 24

	.type	.Lalloc_9e293b1cd83d8f2c3d64145f659adffa,@object
	.section	.data.rel.ro..Lalloc_9e293b1cd83d8f2c3d64145f659adffa,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_9e293b1cd83d8f2c3d64145f659adffa:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000\035\000\000\000\025\000\000"
	.size	.Lalloc_9e293b1cd83d8f2c3d64145f659adffa, 24

	.type	.Lalloc_f2adc74b1f56daa88b0b65f22487c555,@object
	.section	.data.rel.ro..Lalloc_f2adc74b1f56daa88b0b65f22487c555,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_f2adc74b1f56daa88b0b65f22487c555:
	.xword	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000\034\000\000\000$\000\000"
	.size	.Lalloc_f2adc74b1f56daa88b0b65f22487c555, 24

	.type	.Lvtable.1,@object
	.section	.data.rel.ro..Lvtable.1,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.1:
	.asciz	"\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\001\000\000\000\000\000\000"
	.xword	_RNvXsd_NtNtCshp6Wxz1DwXO_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
	.size	.Lvtable.1, 32

	.type	.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274,@object
	.section	.rodata..Lalloc_00ae4b301f7fab8ac9617c03fcbd7274,"a",@progbits
.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274:
	.ascii	"called `Result::unwrap()` on an `Err` value"
	.size	.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274, 43

	.type	.Lvtable.2,@object
	.section	.data.rel.ro..Lvtable.2,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.2:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.xword	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver
	.size	.Lvtable.2, 32

	.type	.Lalloc_f62df14955f7d78bca139b0a7668683d,@object
	.section	.rodata..Lalloc_f62df14955f7d78bca139b0a7668683d,"a",@progbits
.Lalloc_f62df14955f7d78bca139b0a7668683d:
	.ascii	"ParseIntError"
	.size	.Lalloc_f62df14955f7d78bca139b0a7668683d, 13

	.type	.Lalloc_a5d866b1768ad3f826bccdb004a1a8ae,@object
	.section	.rodata.cst4,"aM",@progbits,4
.Lalloc_a5d866b1768ad3f826bccdb004a1a8ae:
	.ascii	"kind"
	.size	.Lalloc_a5d866b1768ad3f826bccdb004a1a8ae, 4

	.type	.Lalloc_59ba7b9f7211443cd55a366616eef46a,@object
	.section	.rodata..Lalloc_59ba7b9f7211443cd55a366616eef46a,"a",@progbits
.Lalloc_59ba7b9f7211443cd55a366616eef46a:
	.ascii	"Empty"
	.size	.Lalloc_59ba7b9f7211443cd55a366616eef46a, 5

	.type	.Lalloc_00315c78e51d29fe6b3102a4c1ecf6ef,@object
	.section	.rodata..Lalloc_00315c78e51d29fe6b3102a4c1ecf6ef,"a",@progbits
.Lalloc_00315c78e51d29fe6b3102a4c1ecf6ef:
	.ascii	"InvalidDigit"
	.size	.Lalloc_00315c78e51d29fe6b3102a4c1ecf6ef, 12

	.type	.Lalloc_bd3a3f3879e0d5f64554753e977f58d4,@object
	.section	.rodata..Lalloc_bd3a3f3879e0d5f64554753e977f58d4,"a",@progbits
.Lalloc_bd3a3f3879e0d5f64554753e977f58d4:
	.ascii	"PosOverflow"
	.size	.Lalloc_bd3a3f3879e0d5f64554753e977f58d4, 11

	.type	.Lalloc_0964bb2a4870637395c77a018495bd5c,@object
	.section	.rodata..Lalloc_0964bb2a4870637395c77a018495bd5c,"a",@progbits
.Lalloc_0964bb2a4870637395c77a018495bd5c:
	.ascii	"NegOverflow"
	.size	.Lalloc_0964bb2a4870637395c77a018495bd5c, 11

	.type	.Lalloc_6566120a3a17f930e960a0863fcbd591,@object
	.section	.rodata..Lalloc_6566120a3a17f930e960a0863fcbd591,"a",@progbits
.Lalloc_6566120a3a17f930e960a0863fcbd591:
	.ascii	"Zero"
	.size	.Lalloc_6566120a3a17f930e960a0863fcbd591, 4

	.type	.Lalloc_6c17bac0c71cba42380f8445f4dcbd16,@object
	.section	.rodata..Lalloc_6c17bac0c71cba42380f8445f4dcbd16,"a",@progbits
.Lalloc_6c17bac0c71cba42380f8445f4dcbd16:
	.ascii	"NotAPowerOfTwo"
	.size	.Lalloc_6c17bac0c71cba42380f8445f4dcbd16, 14

	.type	.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver,"a",@progbits
	.p2align	3, 0x0
.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver:
	.ascii	"\005\f\013\013\004\016"
	.size	.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver, 6

	.type	.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.46.rel,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.46.rel,"a",@progbits
	.p2align	2, 0x0
.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.46.rel:
	.word	.Lalloc_59ba7b9f7211443cd55a366616eef46a-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.46.rel
	.word	.Lalloc_00315c78e51d29fe6b3102a4c1ecf6ef-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.46.rel
	.word	.Lalloc_bd3a3f3879e0d5f64554753e977f58d4-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.46.rel
	.word	.Lalloc_0964bb2a4870637395c77a018495bd5c-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.46.rel
	.word	.Lalloc_6566120a3a17f930e960a0863fcbd591-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.46.rel
	.word	.Lalloc_6c17bac0c71cba42380f8445f4dcbd16-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.46.rel
	.size	.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.46.rel, 24

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
