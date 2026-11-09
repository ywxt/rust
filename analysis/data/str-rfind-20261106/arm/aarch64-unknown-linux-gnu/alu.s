	.file	"alu.caa5c39ebd10de37-cgu.0"
	.section	.text._RINvNtCs68fcPop4ROg_3std2rt10lang_startuECshoGEzlfe2Dr_3alu,"ax",@progbits
	.hidden	_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECshoGEzlfe2Dr_3alu
	.globl	_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECshoGEzlfe2Dr_3alu
	.p2align	2
	.type	_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECshoGEzlfe2Dr_3alu,@function
_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECshoGEzlfe2Dr_3alu:
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
	.size	_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECshoGEzlfe2Dr_3alu, .Lfunc_end0-_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECshoGEzlfe2Dr_3alu
	.cfi_endproc

	.section	.text._RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECshoGEzlfe2Dr_3alu,"ax",@progbits
	.p2align	2
	.type	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECshoGEzlfe2Dr_3alu,@function
_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECshoGEzlfe2Dr_3alu:
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
	.size	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECshoGEzlfe2Dr_3alu, .Lfunc_end1-_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECshoGEzlfe2Dr_3alu
	.cfi_endproc

	.section	.text._RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECshoGEzlfe2Dr_3alu,"ax",@progbits
	.p2align	2
	.type	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECshoGEzlfe2Dr_3alu,@function
_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECshoGEzlfe2Dr_3alu:
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
	.size	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECshoGEzlfe2Dr_3alu, .Lfunc_end2-_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECshoGEzlfe2Dr_3alu
	.cfi_endproc

	.section	.text._RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshoGEzlfe2Dr_3alu,"ax",@progbits
	.p2align	2
	.type	_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshoGEzlfe2Dr_3alu,@function
_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshoGEzlfe2Dr_3alu:
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
	.size	_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshoGEzlfe2Dr_3alu, .Lfunc_end3-_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshoGEzlfe2Dr_3alu
	.cfi_endproc

	.section	.text.unlikely._RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshoGEzlfe2Dr_3alu,"ax",@progbits
	.p2align	2
	.type	_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshoGEzlfe2Dr_3alu,@function
_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshoGEzlfe2Dr_3alu:
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
	bl	_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshoGEzlfe2Dr_3alu
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
	.size	_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshoGEzlfe2Dr_3alu, .Lfunc_end4-_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshoGEzlfe2Dr_3alu
	.cfi_endproc

	.section	.text._RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0CshoGEzlfe2Dr_3alu,"ax",@progbits
	.p2align	2
	.type	_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0CshoGEzlfe2Dr_3alu,@function
_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0CshoGEzlfe2Dr_3alu:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x0, [x0]
	bl	_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshoGEzlfe2Dr_3alu
	mov	w0, wzr
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end5:
	.size	_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0CshoGEzlfe2Dr_3alu, .Lfunc_end5-_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0CshoGEzlfe2Dr_3alu
	.cfi_endproc

	.section	.text._RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCshoGEzlfe2Dr_3alu,"ax",@progbits
	.p2align	2
	.type	_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCshoGEzlfe2Dr_3alu,@function
_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCshoGEzlfe2Dr_3alu:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x0, [x0]
	bl	_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshoGEzlfe2Dr_3alu
	mov	w0, wzr
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end6:
	.size	_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCshoGEzlfe2Dr_3alu, .Lfunc_end6-_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCshoGEzlfe2Dr_3alu
	.cfi_endproc

	.section	.text._RNvCshoGEzlfe2Dr_3alu4main,"ax",@progbits
	.hidden	_RNvCshoGEzlfe2Dr_3alu4main
	.globl	_RNvCshoGEzlfe2Dr_3alu4main
	.p2align	2
	.type	_RNvCshoGEzlfe2Dr_3alu4main,@function
_RNvCshoGEzlfe2Dr_3alu4main:
.Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 156, DW.ref.rust_eh_personality
	.cfi_lsda 28, .Lexception0
	sub	sp, sp, #208
	.cfi_def_cfa_offset 208
	stp	x29, x30, [sp, #128]
	stp	x26, x25, [sp, #144]
	stp	x24, x23, [sp, #160]
	stp	x22, x21, [sp, #176]
	stp	x20, x19, [sp, #192]
	add	x29, sp, #128
	.cfi_def_cfa w29, 80
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	.cfi_offset w25, -56
	.cfi_offset w26, -64
	.cfi_offset w30, -72
	.cfi_offset w29, -80
	.cfi_remember_state
	mov	x8, sp
	bl	_RNvNtCs68fcPop4ROg_3std3env4args
.Ltmp0:
	add	x8, sp, #64
	mov	x0, sp
	bl	_RNvXsc_NtCs68fcPop4ROg_3std3envNtB5_4ArgsNtNtNtNtCshp6Wxz1DwXO_4core4iter6traits8iterator8Iterator4next
.Ltmp1:
	ldr	x19, [sp, #64]
	cmn	x19, #1
	b.eq	.LBB7_59
	ldr	x8, [sp, #8]
	ldr	x9, [sp, #24]
	mov	x10, #-6148914691236517206
	movk	x10, #43691
	ldr	x22, [sp, #72]
	sub	x8, x9, x8
	lsr	x9, x8, #3
	mul	x9, x9, x10
	mov	w10, #3
	cmp	x9, #3
	csel	x9, x9, x10, hi
	mov	x10, #9223372036854775776
	add	x24, x9, #1
	cmp	x8, x10
	add	x9, x24, x24, lsl #1
	lsl	x21, x9, #3
	b.ls	.LBB7_5
	mov	x23, xzr
.LBB7_4:
.Ltmp20:
	mov	x0, x23
	mov	x1, x21
	bl	_RNvNtCs6sh1iPzjxYC_5alloc7raw_vec12handle_error
.Ltmp21:
	b	.LBB7_64
.LBB7_5:
	ldr	x25, [sp, #80]
	cbz	x21, .LBB7_8
	bl	_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	x0, x21
	mov	w1, #8
	mov	w23, #8
	bl	_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc
	cbz	x0, .LBB7_4
	mov	x20, x0
	b	.LBB7_9
.LBB7_8:
	mov	x24, xzr
	mov	w20, #8
.LBB7_9:
	stp	x19, x22, [x20]
	mov	x21, xzr
	mov	w19, #1
	str	x25, [x20, #16]
	mov	x25, #1
	ldp	q0, q1, [sp]
	stp	x24, x20, [sp, #40]
	mov	x24, #-6148914691236517206
	str	x19, [sp, #56]
	movk	x24, #43691
	stp	q0, q1, [sp, #64]
	b	.LBB7_12
.LBB7_10:
	ldr	x20, [sp, #48]
.LBB7_11:
	add	x8, x20, x21
	add	x19, x19, #1
	add	x21, x21, #24
	stp	x22, x23, [x8, #24]
	str	x26, [x8, #40]
	str	x19, [sp, #56]
.LBB7_12:
.Ltmp3:
	sub	x8, x29, #24
	add	x0, sp, #64
	bl	_RNvXsc_NtCs68fcPop4ROg_3std3envNtB5_4ArgsNtNtNtNtCshp6Wxz1DwXO_4core4iter6traits8iterator8Iterator4next
.Ltmp4:
	ldur	x22, [x29, #-24]
	cmn	x22, #1
	b.eq	.LBB7_16
	ldr	x8, [sp, #40]
	ldp	x23, x26, [x29, #-16]
	cmp	x19, x8
	b.ne	.LBB7_11
	ldr	x8, [sp, #88]
	ldr	x9, [sp, #72]
	sub	x8, x8, x9
	lsr	x8, x8, #3
	madd	x2, x8, x24, x25
.Ltmp6:
	add	x0, sp, #40
	mov	x1, x19
	bl	_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshoGEzlfe2Dr_3alu
.Ltmp7:
	b	.LBB7_10
.LBB7_16:
	ldr	x8, [sp, #72]
	ldr	x9, [sp, #88]
	subs	x9, x9, x8
	b.eq	.LBB7_21
	mov	x10, #-6148914691236517206
	add	x21, x8, #8
	movk	x10, #43691
	umulh	x9, x9, x10
	lsr	x20, x9, #4
	b	.LBB7_19
.LBB7_18:
	subs	x20, x20, #1
	add	x21, x21, #24
	b.eq	.LBB7_21
.LBB7_19:
	ldur	x1, [x21, #-8]
	cbz	x1, .LBB7_18
	ldr	x0, [x21]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB7_18
.LBB7_21:
	ldr	x8, [sp, #80]
	cbz	x8, .LBB7_23
	add	x8, x8, x8, lsl #1
	ldr	x0, [sp, #64]
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB7_23:
	ldp	x22, x20, [sp, #40]
	cmp	x19, #3
	b.lo	.LBB7_63
	ldp	x9, x8, [x20, #56]
	cmp	x8, #1
	b.eq	.LBB7_27
	cbz	x8, .LBB7_69
	ldrb	w11, [x9]
	b	.LBB7_29
.LBB7_27:
	ldrb	w11, [x9]
	mov	w10, #1
	cmp	w11, #43
	b.eq	.LBB7_57
	cmp	w11, #45
	b.eq	.LBB7_57
.LBB7_29:
	cmp	w11, #43
	cset	w10, eq
	cinc	x9, x9, eq
	sub	x8, x8, x10
	cmp	x8, #17
	b.hs	.LBB7_34
	mov	x21, xzr
	cbz	x8, .LBB7_39
	mov	w10, #10
.LBB7_32:
	ldrb	w11, [x9], #1
	sub	w11, w11, #48
	cmp	w11, #9
	b.hi	.LBB7_58
	mul	x12, x21, x10
	subs	x8, x8, #1
	add	x21, x12, w11, uxtw
	b.ne	.LBB7_32
	b	.LBB7_39
.LBB7_34:
	mov	x21, xzr
	mov	w10, #10
.LBB7_35:
	umulh	x12, x21, x10
	ldrb	w11, [x9], #1
	cmp	xzr, x12
	b.ne	.LBB7_55
	sub	w11, w11, #48
	cmp	w11, #10
	b.hs	.LBB7_58
	add	x12, x21, x21, lsl #2
	lsl	x12, x12, #1
	adds	x21, x12, w11, uxtw
	b.hs	.LBB7_56
	sub	x8, x8, #1
	cbnz	x8, .LBB7_35
.LBB7_39:
.Ltmp11:
	bl	_RNvMNtCs68fcPop4ROg_3std4timeNtB2_7Instant3now
.Ltmp12:
	ldr	x8, [x20, #40]
	stur	x0, [x29, #-24]
	stur	w1, [x29, #-16]
	cmp	x8, #3
	b.ne	.LBB7_44
	ldr	x8, [x20, #32]
	ldrb	w9, [x8, #2]
	ldrh	w10, [x8]
	cmp	w9, #117
	mov	w9, #27745
	ccmp	w10, w9, #0, eq
	b.eq	.LBB7_45
	ldrb	w9, [x8, #2]
	ldrh	w8, [x8]
	cmp	w9, #112
	mov	w9, #28526
	ccmp	w8, w9, #0, eq
	b.ne	.LBB7_44
	//APP
	.p2align	6
.Ltmp26:
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	subs	x21, x21, #1
	b.ne	.Ltmp26
	//NO_APP
	b	.LBB7_46
.LBB7_44:
.Ltmp13:
	adrp	x0, .Lalloc_476509aa7047bd805d630c6546685797
	add	x0, x0, :lo12:.Lalloc_476509aa7047bd805d630c6546685797
	adrp	x2, .Lalloc_76aeced0a5477c8f1830b5a8ccbcf84f
	add	x2, x2, :lo12:.Lalloc_76aeced0a5477c8f1830b5a8ccbcf84f
	mov	w1, #14
	bl	_RNvNtCshp6Wxz1DwXO_4core9panicking5panic
.Ltmp14:
	b	.LBB7_64
.LBB7_45:
	//APP
	mov	x15, #85
	mov	x9, #1
	mov	x10, #2
	mov	x11, #3
	mov	x12, #4
	mov	x13, #5
	mov	x14, #6
	.p2align	6
.Ltmp27:
	eor	x9, x9, x15
	eor	x10, x10, x15
	eor	x11, x11, x15
	eor	x12, x12, x15
	eor	x13, x13, x15
	eor	x14, x14, x15
	orr	x9, x9, x15
	orr	x10, x10, x15
	orr	x11, x11, x15
	orr	x12, x12, x15
	orr	x13, x13, x15
	orr	x14, x14, x15
	subs	x21, x21, #1
	b.ne	.Ltmp27
	//NO_APP
.LBB7_46:
	str	x21, [sp, #64]
	add	x8, sp, #64
	//APP
	//NO_APP
.Ltmp15:
	sub	x0, x29, #24
	bl	_RNvMNtCs68fcPop4ROg_3std4timeNtB2_7Instant7elapsed
.Ltmp16:
	mov	w8, #51712
	mov	x10, sp
	movk	w8, #15258, lsl #16
	mul	x9, x0, x8
	umulh	x8, x0, x8
	adds	x9, x9, w1, uxtw
	str	x9, [sp]
	adrp	x9, :got:_RNvXNtNtCshp6Wxz1DwXO_4core3fmt3numoNtB4_7Display3fmt
	cinc	x8, x8, hs
	ldr	x9, [x9, :got_lo12:_RNvXNtNtCshp6Wxz1DwXO_4core3fmt3numoNtB4_7Display3fmt]
	str	x8, [sp, #8]
	stp	x10, x9, [sp, #64]
.Ltmp17:
	adrp	x0, .Lalloc_61247b90e1706a3f65e71312b599d3d1
	add	x0, x0, :lo12:.Lalloc_61247b90e1706a3f65e71312b599d3d1
	add	x1, sp, #64
	bl	_RNvNtNtCs68fcPop4ROg_3std2io5stdio6__print
.Ltmp18:
	add	x21, x20, #8
	b	.LBB7_50
.LBB7_49:
	subs	x19, x19, #1
	add	x21, x21, #24
	b.eq	.LBB7_52
.LBB7_50:
	ldur	x1, [x21, #-8]
	cbz	x1, .LBB7_49
	ldr	x0, [x21]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB7_49
.LBB7_52:
	cbz	x22, .LBB7_54
	add	x8, x22, x22, lsl #1
	mov	x0, x20
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB7_54:
	.cfi_def_cfa wsp, 208
	ldp	x20, x19, [sp, #192]
	ldp	x22, x21, [sp, #176]
	ldp	x24, x23, [sp, #160]
	ldp	x26, x25, [sp, #144]
	ldp	x29, x30, [sp, #128]
	add	sp, sp, #208
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w23
	.cfi_restore w24
	.cfi_restore w25
	.cfi_restore w26
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB7_55:
	.cfi_restore_state
	sub	w8, w11, #48
	cmp	w8, #10
	mov	w8, #1
	cinc	w10, w8, lo
	b	.LBB7_57
.LBB7_56:
	mov	w10, #2
.LBB7_57:
	strb	w10, [sp, #64]
.Ltmp9:
	adrp	x0, .Lalloc_00ae4b301f7fab8ac9617c03fcbd7274
	add	x0, x0, :lo12:.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274
	adrp	x3, .Lvtable.1
	add	x3, x3, :lo12:.Lvtable.1
	adrp	x4, .Lalloc_a8b0ebe0d43da0c3dafb5875f5f854e1
	add	x4, x4, :lo12:.Lalloc_a8b0ebe0d43da0c3dafb5875f5f854e1
	add	x2, sp, #64
	mov	w1, #43
	bl	_RNvNtCshp6Wxz1DwXO_4core6result13unwrap_failed
.Ltmp10:
	b	.LBB7_64
.LBB7_58:
	mov	w10, #1
	b	.LBB7_57
.LBB7_59:
	ldr	x8, [sp, #8]
	ldr	x9, [sp, #24]
	subs	x9, x9, x8
	b.ne	.LBB7_65
.LBB7_60:
	ldr	x8, [sp, #16]
	cbz	x8, .LBB7_62
	add	x8, x8, x8, lsl #1
	ldr	x0, [sp]
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB7_62:
	mov	x22, xzr
	mov	x19, xzr
	mov	w20, #8
.LBB7_63:
.Ltmp23:
	adrp	x2, .Lalloc_0a75a407fb154f340d899592a8228c5e
	add	x2, x2, :lo12:.Lalloc_0a75a407fb154f340d899592a8228c5e
	mov	w0, #2
	mov	x1, x19
	bl	_RNvNtCshp6Wxz1DwXO_4core9panicking18panic_bounds_check
.Ltmp24:
.LBB7_64:
	brk	#0x1
.LBB7_65:
	mov	x10, #-6148914691236517206
	add	x20, x8, #8
	movk	x10, #43691
	umulh	x9, x9, x10
	lsr	x19, x9, #4
	b	.LBB7_67
.LBB7_66:
	subs	x19, x19, #1
	add	x20, x20, #24
	b.eq	.LBB7_60
.LBB7_67:
	ldur	x1, [x20, #-8]
	cbz	x1, .LBB7_66
	ldr	x0, [x20]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB7_66
.LBB7_69:
	mov	w10, wzr
	b	.LBB7_57
.LBB7_70:
.Ltmp2:
	mov	x21, x0
	b	.LBB7_85
.LBB7_71:
.Ltmp25:
	mov	x21, x0
	cbnz	x19, .LBB7_79
.LBB7_72:
	cbz	x22, .LBB7_87
	add	x8, x22, x22, lsl #1
	mov	x0, x20
	lsl	x1, x8, #3
	mov	w2, #8
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	mov	x0, x21
	bl	_Unwind_Resume
.LBB7_74:
.Ltmp8:
	mov	x21, x0
	cbz	x22, .LBB7_77
	mov	x0, x23
	mov	x1, x22
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	add	x0, sp, #64
	bl	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECshoGEzlfe2Dr_3alu
	add	x0, sp, #40
	bl	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECshoGEzlfe2Dr_3alu
	mov	x0, x21
	bl	_Unwind_Resume
.LBB7_76:
.Ltmp5:
	mov	x21, x0
.LBB7_77:
	add	x0, sp, #64
	bl	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECshoGEzlfe2Dr_3alu
	add	x0, sp, #40
	bl	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECshoGEzlfe2Dr_3alu
	mov	x0, x21
	bl	_Unwind_Resume
.LBB7_78:
.Ltmp19:
	mov	x21, x0
.LBB7_79:
	add	x23, x20, #8
	b	.LBB7_81
.LBB7_80:
	subs	x19, x19, #1
	add	x23, x23, #24
	b.eq	.LBB7_72
.LBB7_81:
	ldur	x1, [x23, #-8]
	cbz	x1, .LBB7_80
	ldr	x0, [x23]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB7_80
.LBB7_83:
.Ltmp22:
	mov	x21, x0
	cbz	x19, .LBB7_85
	mov	x0, x22
	mov	x1, x19
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB7_85:
	ldr	x8, [sp, #8]
	ldr	x9, [sp, #24]
	subs	x9, x9, x8
	b.ne	.LBB7_88
.LBB7_86:
	ldr	x8, [sp, #16]
	cbnz	x8, .LBB7_92
.LBB7_87:
	mov	x0, x21
	bl	_Unwind_Resume
.LBB7_88:
	mov	x10, #-6148914691236517206
	add	x20, x8, #8
	movk	x10, #43691
	umulh	x9, x9, x10
	lsr	x19, x9, #4
	b	.LBB7_90
.LBB7_89:
	subs	x19, x19, #1
	add	x20, x20, #24
	b.eq	.LBB7_86
.LBB7_90:
	ldur	x1, [x20, #-8]
	cbz	x1, .LBB7_89
	ldr	x0, [x20]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB7_89
.LBB7_92:
	add	x8, x8, x8, lsl #1
	ldr	x0, [sp]
	lsl	x1, x8, #3
	mov	w2, #8
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	mov	x0, x21
	bl	_Unwind_Resume
.Lfunc_end7:
	.size	_RNvCshoGEzlfe2Dr_3alu4main, .Lfunc_end7-_RNvCshoGEzlfe2Dr_3alu4main
	.cfi_endproc
	.section	.gcc_except_table._RNvCshoGEzlfe2Dr_3alu4main,"a",@progbits
	.p2align	2, 0x0
GCC_except_table7:
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
	.uleb128 .Ltmp20-.Lfunc_begin0
	.uleb128 .Ltmp21-.Ltmp20
	.uleb128 .Ltmp22-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp3-.Lfunc_begin0
	.uleb128 .Ltmp4-.Ltmp3
	.uleb128 .Ltmp5-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp6-.Lfunc_begin0
	.uleb128 .Ltmp7-.Ltmp6
	.uleb128 .Ltmp8-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp11-.Lfunc_begin0
	.uleb128 .Ltmp10-.Ltmp11
	.uleb128 .Ltmp19-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp23-.Lfunc_begin0
	.uleb128 .Ltmp24-.Ltmp23
	.uleb128 .Ltmp25-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp24-.Lfunc_begin0
	.uleb128 .Lfunc_end7-.Ltmp24
	.byte	0
	.byte	0
.Lcst_end0:
	.p2align	2, 0x0

	.section	.text.unlikely._RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshoGEzlfe2Dr_3alu,"ax",@progbits
	.p2align	2
	.type	_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshoGEzlfe2Dr_3alu,@function
_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshoGEzlfe2Dr_3alu:
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
	b.ls	.LBB8_2
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
.LBB8_2:
	.cfi_restore_state
	.cfi_remember_state
	add	x8, x3, x3, lsl #1
	lsl	x20, x8, #3
	cbz	x1, .LBB8_4
	add	x8, x1, x1, lsl #1
	mov	x0, x2
	mov	w2, #8
	mov	x3, x20
	lsl	x1, x8, #3
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_realloc
	cbnz	x0, .LBB8_8
	b	.LBB8_6
.LBB8_4:
	cbz	x20, .LBB8_7
	bl	_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	x0, x20
	mov	w1, #8
	bl	_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc
	cbnz	x0, .LBB8_8
.LBB8_6:
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
.LBB8_7:
	.cfi_restore_state
	mov	w0, #8
.LBB8_8:
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
.Lfunc_end8:
	.size	_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshoGEzlfe2Dr_3alu, .Lfunc_end8-_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshoGEzlfe2Dr_3alu
	.cfi_endproc

	.section	.text._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu,"ax",@progbits
	.p2align	2
	.type	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu,@function
_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu:
	.cfi_startproc
	ldr	x8, [x0]
	adrp	x9, .Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu
	add	x9, x9, :lo12:.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu
	mov	x0, x1
	ldrb	w8, [x8]
	ldrb	w2, [x9, x8]
	adrp	x9, .Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel
	add	x9, x9, :lo12:.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel
	ldrsw	x8, [x9, x8, lsl #2]
	add	x1, x9, x8
	b	_RNvMsa_NtCshp6Wxz1DwXO_4core3fmtNtB5_9Formatter9write_str
.Lfunc_end9:
	.size	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu, .Lfunc_end9-_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu
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
.Lfunc_end10:
	.size	_RNvXsd_NtNtCshp6Wxz1DwXO_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt, .Lfunc_end10-_RNvXsd_NtNtCshp6Wxz1DwXO_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
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
	adrp	x8, _RNvCshoGEzlfe2Dr_3alu4main
	add	x8, x8, :lo12:_RNvCshoGEzlfe2Dr_3alu4main
	adrp	x1, .Lvtable.0
	add	x1, x1, :lo12:.Lvtable.0
	add	x0, sp, #8
	mov	w4, wzr
	str	x8, [sp, #8]
	bl	_RNvNtCs68fcPop4ROg_3std2rt19lang_start_internal
	ldp	x29, x30, [sp, #16]
	add	sp, sp, #32
	ret
.Lfunc_end11:
	.size	main, .Lfunc_end11-main
	.cfi_endproc

	.type	.Lvtable.0,@object
	.section	.data.rel.ro..Lvtable.0,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.0:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.xword	_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCshoGEzlfe2Dr_3alu
	.xword	_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0CshoGEzlfe2Dr_3alu
	.xword	_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0CshoGEzlfe2Dr_3alu
	.size	.Lvtable.0, 48

	.type	.Lalloc_817202238b506f3adada4768b4e9cddf,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_817202238b506f3adada4768b4e9cddf:
	.asciz	"/tmp/str-rfind-20261106/alu.rs"
	.size	.Lalloc_817202238b506f3adada4768b4e9cddf, 31

	.type	.Lalloc_0a75a407fb154f340d899592a8228c5e,@object
	.section	.data.rel.ro..Lalloc_0a75a407fb154f340d899592a8228c5e,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_0a75a407fb154f340d899592a8228c5e:
	.xword	.Lalloc_817202238b506f3adada4768b4e9cddf
	.asciz	"\036\000\000\000\000\000\000\000\004\000\000\0005\000\000"
	.size	.Lalloc_0a75a407fb154f340d899592a8228c5e, 24

	.type	.Lalloc_a8b0ebe0d43da0c3dafb5875f5f854e1,@object
	.section	.data.rel.ro..Lalloc_a8b0ebe0d43da0c3dafb5875f5f854e1,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_a8b0ebe0d43da0c3dafb5875f5f854e1:
	.xword	.Lalloc_817202238b506f3adada4768b4e9cddf
	.asciz	"\036\000\000\000\000\000\000\000\004\000\000\000A\000\000"
	.size	.Lalloc_a8b0ebe0d43da0c3dafb5875f5f854e1, 24

	.type	.Lalloc_476509aa7047bd805d630c6546685797,@object
	.section	.rodata..Lalloc_476509aa7047bd805d630c6546685797,"a",@progbits
.Lalloc_476509aa7047bd805d630c6546685797:
	.ascii	"explicit panic"
	.size	.Lalloc_476509aa7047bd805d630c6546685797, 14

	.type	.Lalloc_76aeced0a5477c8f1830b5a8ccbcf84f,@object
	.section	.data.rel.ro..Lalloc_76aeced0a5477c8f1830b5a8ccbcf84f,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_76aeced0a5477c8f1830b5a8ccbcf84f:
	.xword	.Lalloc_817202238b506f3adada4768b4e9cddf
	.asciz	"\036\000\000\000\000\000\000\000\f\000\000\000\204\000\000"
	.size	.Lalloc_76aeced0a5477c8f1830b5a8ccbcf84f, 24

	.type	.Lalloc_61247b90e1706a3f65e71312b599d3d1,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_61247b90e1706a3f65e71312b599d3d1:
	.asciz	"\300\001\n"
	.size	.Lalloc_61247b90e1706a3f65e71312b599d3d1, 4

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
	.xword	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu
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

	.type	.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu,"a",@progbits
	.p2align	3, 0x0
.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu:
	.ascii	"\005\f\013\013\004\016"
	.size	.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu, 6

	.type	.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel,"a",@progbits
	.p2align	2, 0x0
.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel:
	.word	.Lalloc_59ba7b9f7211443cd55a366616eef46a-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel
	.word	.Lalloc_00315c78e51d29fe6b3102a4c1ecf6ef-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel
	.word	.Lalloc_bd3a3f3879e0d5f64554753e977f58d4-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel
	.word	.Lalloc_0964bb2a4870637395c77a018495bd5c-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel
	.word	.Lalloc_6566120a3a17f930e960a0863fcbd591-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel
	.word	.Lalloc_6c17bac0c71cba42380f8445f4dcbd16-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel
	.size	.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel, 24

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
