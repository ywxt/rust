	.file	"rawcopy.cb6247de70df53e9-cgu.0"
	.section	.text._RINvNtCs68fcPop4ROg_3std2rt10lang_startuECshsBGi11rG2H_7rawcopy,"ax",@progbits
	.hidden	_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECshsBGi11rG2H_7rawcopy
	.globl	_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECshsBGi11rG2H_7rawcopy
	.p2align	2
	.type	_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECshsBGi11rG2H_7rawcopy,@function
_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECshsBGi11rG2H_7rawcopy:
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
	adrp	x1, .Lvtable.1
	add	x1, x1, :lo12:.Lvtable.1
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
	.size	_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECshsBGi11rG2H_7rawcopy, .Lfunc_end0-_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text._RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECshsBGi11rG2H_7rawcopy,"ax",@progbits
	.p2align	2
	.type	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECshsBGi11rG2H_7rawcopy,@function
_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECshsBGi11rG2H_7rawcopy:
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
	.size	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECshsBGi11rG2H_7rawcopy, .Lfunc_end1-_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text._RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECshsBGi11rG2H_7rawcopy,"ax",@progbits
	.p2align	2
	.type	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECshsBGi11rG2H_7rawcopy,@function
_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECshsBGi11rG2H_7rawcopy:
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
	.size	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECshsBGi11rG2H_7rawcopy, .Lfunc_end2-_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text.unlikely._RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedRSjBM_ECshsBGi11rG2H_7rawcopy,"ax",@progbits
	.p2align	2
	.type	_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedRSjBM_ECshsBGi11rG2H_7rawcopy,@function
_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedRSjBM_ECshsBGi11rG2H_7rawcopy:
	.cfi_startproc
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	adrp	x2, .Lvtable.2
	add	x2, x2, :lo12:.Lvtable.2
	stp	x0, x1, [sp]
	adrp	x7, .Lalloc_67e13228cc1d9cff242e5e6206de75d9
	add	x7, x7, :lo12:.Lalloc_67e13228cc1d9cff242e5e6206de75d9
	mov	x1, sp
	add	x3, sp, #8
	mov	w0, wzr
	mov	x4, x2
	mov	x5, xzr
	bl	_RNvNtCshp6Wxz1DwXO_4core9panicking19assert_failed_inner
.Lfunc_end3:
	.size	_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedRSjBM_ECshsBGi11rG2H_7rawcopy, .Lfunc_end3-_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedRSjBM_ECshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text._RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshsBGi11rG2H_7rawcopy,"ax",@progbits
	.p2align	2
	.type	_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshsBGi11rG2H_7rawcopy,@function
_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshsBGi11rG2H_7rawcopy:
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
.Lfunc_end4:
	.size	_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshsBGi11rG2H_7rawcopy, .Lfunc_end4-_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text.unlikely._RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshsBGi11rG2H_7rawcopy,"ax",@progbits
	.p2align	2
	.type	_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshsBGi11rG2H_7rawcopy,@function
_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshsBGi11rG2H_7rawcopy:
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
	b.hs	.LBB5_3
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
	bl	_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshsBGi11rG2H_7rawcopy
	ldr	x8, [sp, #8]
	cbnz	x8, .LBB5_4
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
.LBB5_3:
	.cfi_restore_state
	mov	x0, xzr
	bl	_RNvNtCs6sh1iPzjxYC_5alloc7raw_vec12handle_error
.LBB5_4:
	ldp	x0, x1, [sp, #16]
	bl	_RNvNtCs6sh1iPzjxYC_5alloc7raw_vec12handle_error
.Lfunc_end5:
	.size	_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshsBGi11rG2H_7rawcopy, .Lfunc_end5-_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text._RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0CshsBGi11rG2H_7rawcopy,"ax",@progbits
	.p2align	2
	.type	_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0CshsBGi11rG2H_7rawcopy,@function
_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0CshsBGi11rG2H_7rawcopy:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x0, [x0]
	bl	_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshsBGi11rG2H_7rawcopy
	mov	w0, wzr
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end6:
	.size	_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0CshsBGi11rG2H_7rawcopy, .Lfunc_end6-_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0CshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text._RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCshsBGi11rG2H_7rawcopy,"ax",@progbits
	.p2align	2
	.type	_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCshsBGi11rG2H_7rawcopy,@function
_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCshsBGi11rG2H_7rawcopy:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x0, [x0]
	bl	_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshsBGi11rG2H_7rawcopy
	mov	w0, wzr
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end7:
	.size	_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCshsBGi11rG2H_7rawcopy, .Lfunc_end7-_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text._RNvCshsBGi11rG2H_7rawcopy4main,"ax",@progbits
	.hidden	_RNvCshsBGi11rG2H_7rawcopy4main
	.globl	_RNvCshsBGi11rG2H_7rawcopy4main
	.p2align	2
	.type	_RNvCshsBGi11rG2H_7rawcopy4main,@function
_RNvCshsBGi11rG2H_7rawcopy4main:
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
	sub	x9, sp, #8, lsl #12
	sub	x9, x9, #288
	and	x9, x9, #0xffffffffffffffc0
	sub	sp, sp, #1, lsl #12
	cmp	sp, x9
	b.le	.LBB8_2
.LBB8_1:
	ldr	xzr, [sp]
	sub	sp, sp, #1, lsl #12
	cmp	sp, x9
	b.gt	.LBB8_1
.LBB8_2:
	mov	sp, x9
	ldr	xzr, [sp]
	add	x8, sp, #64
	bl	_RNvNtCs68fcPop4ROg_3std3env4args
.Ltmp0:
	add	x8, sp, #4, lsl #12
	add	x0, sp, #64
	add	x8, x8, #64
	bl	_RNvXsc_NtCs68fcPop4ROg_3std3envNtB5_4ArgsNtNtNtNtCshp6Wxz1DwXO_4core4iter6traits8iterator8Iterator4next
.Ltmp1:
	ldr	x20, [sp, #16448]
	cmn	x20, #1
	b.eq	.LBB8_154
	ldr	x8, [sp, #72]
	ldr	x9, [sp, #88]
	mov	x10, #-6148914691236517206
	movk	x10, #43691
	ldr	x21, [sp, #16456]
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
	lsl	x22, x9, #3
	b.ls	.LBB8_7
	mov	x23, xzr
.LBB8_6:
.Ltmp23:
	mov	x0, x23
	mov	x1, x22
	bl	_RNvNtCs6sh1iPzjxYC_5alloc7raw_vec12handle_error
.Ltmp24:
	b	.LBB8_167
.LBB8_7:
	ldr	x26, [sp, #16464]
	cbz	x22, .LBB8_10
	bl	_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	x0, x22
	mov	w1, #8
	mov	w23, #8
	bl	_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc
	cbz	x0, .LBB8_6
	mov	x19, x0
	b	.LBB8_11
.LBB8_10:
	mov	x24, xzr
	mov	w19, #8
.LBB8_11:
	stp	x20, x21, [x19]
	add	x23, sp, #8, lsl #12
	mov	x25, xzr
	str	x26, [x19, #16]
	add	x23, x23, #112
	mov	x26, #-6148914691236517206
	ldp	q0, q1, [sp, #64]
	stp	x24, x19, [x23, #120]
	add	x24, sp, #4, lsl #12
	mov	w20, #1
	movk	x26, #43691
	add	x24, x24, #64
	mov	x27, #1
	str	x20, [x23, #136]
	str	q0, [sp, #16448]
	str	q1, [sp, #16464]
	b	.LBB8_14
.LBB8_12:
	ldr	x19, [x23, #128]
.LBB8_13:
	add	x8, x19, x25
	add	x20, x20, #1
	add	x25, x25, #24
	stp	x21, x22, [x8, #24]
	str	x28, [x8, #40]
	str	x20, [x23, #136]
.LBB8_14:
.Ltmp3:
	add	x8, sp, #8, lsl #12
	add	x0, sp, #4, lsl #12
	add	x8, x8, #152
	add	x0, x0, #64
	bl	_RNvXsc_NtCs68fcPop4ROg_3std3envNtB5_4ArgsNtNtNtNtCshp6Wxz1DwXO_4core4iter6traits8iterator8Iterator4next
.Ltmp4:
	ldr	x21, [x23, #40]
	cmn	x21, #1
	b.eq	.LBB8_18
	ldr	x8, [x23, #120]
	ldp	x22, x28, [x23, #48]
	cmp	x20, x8
	b.ne	.LBB8_13
	ldr	x8, [sp, #16472]
	ldr	x9, [sp, #16456]
	sub	x8, x8, x9
	lsr	x8, x8, #3
	madd	x2, x8, x26, x27
.Ltmp6:
	add	x0, sp, #8, lsl #12
	mov	x1, x20
	add	x0, x0, #232
	bl	_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshsBGi11rG2H_7rawcopy
.Ltmp7:
	b	.LBB8_12
.LBB8_18:
	ldr	x8, [sp, #16456]
	ldr	x9, [sp, #16472]
	subs	x9, x9, x8
	b.eq	.LBB8_23
	mov	x10, #-6148914691236517206
	add	x20, x8, #8
	movk	x10, #43691
	umulh	x9, x9, x10
	lsr	x19, x9, #4
	b	.LBB8_21
.LBB8_20:
	subs	x19, x19, #1
	add	x20, x20, #24
	b.eq	.LBB8_23
.LBB8_21:
	ldur	x1, [x20, #-8]
	cbz	x1, .LBB8_20
	ldr	x0, [x20]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB8_20
.LBB8_23:
	ldr	x8, [sp, #16464]
	cbz	x8, .LBB8_25
	add	x8, x8, x8, lsl #1
	ldr	x0, [sp, #16448]
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB8_25:
	ldr	x1, [x23, #136]
	ldur	q0, [x23, #120]
	cmp	x1, #2
	str	q0, [sp, #16]
	str	x1, [sp, #32]
	b.lo	.LBB8_158
	ldr	x21, [sp, #24]
	ldp	x9, x8, [x21, #32]
	cmp	x8, #1
	b.eq	.LBB8_29
	cbz	x8, .LBB8_168
	ldrb	w11, [x9]
	b	.LBB8_31
.LBB8_29:
	ldrb	w11, [x9]
	mov	w10, #1
	cmp	w11, #43
	b.eq	.LBB8_133
	cmp	w11, #45
	b.eq	.LBB8_133
.LBB8_31:
	cmp	w11, #43
	cset	w10, eq
	cinc	x9, x9, eq
	sub	x8, x8, x10
	cmp	x8, #17
	b.hs	.LBB8_36
	mov	x20, xzr
	cbz	x8, .LBB8_41
	mov	w10, #10
.LBB8_34:
	ldrb	w11, [x9], #1
	sub	w11, w11, #48
	cmp	w11, #9
	b.hi	.LBB8_150
	mul	x12, x20, x10
	subs	x8, x8, #1
	add	x20, x12, w11, uxtw
	b.ne	.LBB8_34
	b	.LBB8_41
.LBB8_36:
	mov	x20, xzr
	mov	w10, #10
.LBB8_37:
	umulh	x12, x20, x10
	ldrb	w11, [x9], #1
	cmp	xzr, x12
	b.ne	.LBB8_131
	sub	w11, w11, #48
	cmp	w11, #10
	b.hs	.LBB8_150
	add	x12, x20, x20, lsl #2
	lsl	x12, x12, #1
	adds	x20, x12, w11, uxtw
	b.hs	.LBB8_132
	sub	x8, x8, #1
	cbnz	x8, .LBB8_37
.LBB8_41:
	cmp	x1, #2
	str	x20, [sp, #48]
	b.eq	.LBB8_163
	ldp	x8, x9, [x21, #56]
	cmp	x9, #1
	b.eq	.LBB8_45
	cbz	x9, .LBB8_169
	ldrb	w11, [x8]
	b	.LBB8_47
.LBB8_45:
	ldrb	w11, [x8]
	mov	w10, #1
	cmp	w11, #43
	b.eq	.LBB8_136
	cmp	w11, #45
	b.eq	.LBB8_136
.LBB8_47:
	cmp	w11, #43
	cset	w10, eq
	sub	x9, x9, x10
	cinc	x10, x8, eq
	cmp	x9, #17
	b.hs	.LBB8_52
	mov	x8, xzr
	cbz	x9, .LBB8_57
	mov	w11, #10
.LBB8_50:
	ldrb	w12, [x10], #1
	sub	w12, w12, #48
	cmp	w12, #9
	b.hi	.LBB8_151
	mul	x8, x8, x11
	subs	x9, x9, #1
	add	x8, x8, w12, uxtw
	b.ne	.LBB8_50
	b	.LBB8_57
.LBB8_52:
	mov	x8, xzr
	mov	w11, #10
.LBB8_53:
	umulh	x13, x8, x11
	ldrb	w12, [x10], #1
	cmp	xzr, x13
	b.ne	.LBB8_134
	sub	w12, w12, #48
	cmp	w12, #10
	b.hs	.LBB8_151
	add	x8, x8, x8, lsl #2
	lsl	x8, x8, #1
	adds	x8, x8, w12, uxtw
	b.hs	.LBB8_135
	sub	x9, x9, #1
	cbnz	x9, .LBB8_53
.LBB8_57:
	cmp	x1, #4
	b.lo	.LBB8_164
	ldp	x10, x9, [x21, #80]
	cmp	x9, #1
	b.eq	.LBB8_61
	cbz	x9, .LBB8_170
	ldrb	w12, [x10]
	b	.LBB8_63
.LBB8_61:
	ldrb	w12, [x10]
	mov	w11, #1
	cmp	w12, #43
	b.eq	.LBB8_139
	cmp	w12, #45
	b.eq	.LBB8_139
.LBB8_63:
	cmp	w12, #43
	cset	w11, eq
	cinc	x10, x10, eq
	sub	x9, x9, x11
	cmp	x9, #17
	b.hs	.LBB8_68
	mov	x25, xzr
	cbz	x9, .LBB8_73
	mov	w11, #10
.LBB8_66:
	ldrb	w12, [x10], #1
	sub	w12, w12, #48
	cmp	w12, #9
	b.hi	.LBB8_152
	mul	x13, x25, x11
	subs	x9, x9, #1
	add	x25, x13, w12, uxtw
	b.ne	.LBB8_66
	b	.LBB8_73
.LBB8_68:
	mov	x25, xzr
	mov	w11, #10
.LBB8_69:
	umulh	x13, x25, x11
	ldrb	w12, [x10], #1
	cmp	xzr, x13
	b.ne	.LBB8_137
	sub	w12, w12, #48
	cmp	w12, #10
	b.hs	.LBB8_152
	add	x13, x25, x25, lsl #2
	lsl	x13, x13, #1
	adds	x25, x13, w12, uxtw
	b.hs	.LBB8_138
	sub	x9, x9, #1
	cbnz	x9, .LBB8_69
.LBB8_73:
	cmp	x1, #4
	b.eq	.LBB8_165
	ldp	x10, x9, [x21, #104]
	cmp	x9, #1
	b.eq	.LBB8_77
	cbz	x9, .LBB8_171
	ldrb	w12, [x10]
	b	.LBB8_79
.LBB8_77:
	ldrb	w12, [x10]
	mov	w11, #1
	cmp	w12, #43
	b.eq	.LBB8_142
	cmp	w12, #45
	b.eq	.LBB8_142
.LBB8_79:
	cmp	w12, #43
	cset	w11, eq
	cinc	x10, x10, eq
	sub	x9, x9, x11
	cmp	x9, #17
	b.hs	.LBB8_84
	mov	x27, xzr
	cbz	x9, .LBB8_89
	mov	w11, #10
.LBB8_82:
	ldrb	w12, [x10], #1
	sub	w12, w12, #48
	cmp	w12, #9
	b.hi	.LBB8_153
	mul	x13, x27, x11
	subs	x9, x9, #1
	add	x27, x13, w12, uxtw
	b.ne	.LBB8_82
	b	.LBB8_89
.LBB8_84:
	mov	x27, xzr
	mov	w11, #10
.LBB8_85:
	umulh	x13, x27, x11
	ldrb	w12, [x10], #1
	cmp	xzr, x13
	b.ne	.LBB8_140
	sub	w12, w12, #48
	cmp	w12, #10
	b.hs	.LBB8_153
	add	x13, x27, x27, lsl #2
	lsl	x13, x13, #1
	adds	x27, x13, w12, uxtw
	b.hs	.LBB8_141
	sub	x9, x9, #1
	cbnz	x9, .LBB8_85
.LBB8_89:
	orr	w9, w25, w8
	str	x27, [sp, #56]
	tst	x9, #0x7
	b.ne	.LBB8_144
	lsr	x28, x8, #3
	add	x8, x28, x20
	cmp	x8, #2048
	b.hi	.LBB8_144
	lsr	x9, x25, #3
	add	x8, x9, x20
	cmp	x8, #2049
	b.hs	.LBB8_144
	add	x0, sp, #64
	mov	w1, wzr
	mov	w2, #16384
	str	x9, [sp, #8]
	add	x19, sp, #64
	bl	memset
	add	x0, sp, #4, lsl #12
	mov	w1, #255
	mov	w2, #16384
	add	x0, x0, #64
	bl	memset
	orr	x8, x19, #0x20
	mov	w9, #2048
	mov	w10, #1099
.LBB8_93:
	sub	x11, x10, #1099
	sub	x12, x10, #942
	sub	x13, x10, #785
	eor	x11, x20, x11
	eor	x12, x20, x12
	eor	x13, x20, x13
	stp	x11, x12, [x8, #-32]
	sub	x11, x10, #628
	sub	x12, x10, #471
	eor	x11, x20, x11
	eor	x12, x20, x12
	subs	x9, x9, #8
	stp	x13, x11, [x8, #-16]
	sub	x13, x10, #314
	sub	x11, x10, #157
	eor	x13, x20, x13
	eor	x11, x20, x11
	stp	x12, x13, [x8]
	eor	x12, x20, x10
	add	x10, x10, #1256
	stp	x11, x12, [x8, #16]
	add	x8, x8, #64
	b.ne	.LBB8_93
.Ltmp11:
	bl	_RNvMNtCs68fcPop4ROg_3std4timeNtB2_7Instant3now
.Ltmp12:
	add	x8, sp, #64
	and	x9, x25, #0xfffffffffffffff8
	mov	x26, x28
	add	x22, x8, x28, lsl #3
	add	x8, sp, #4, lsl #12
	str	x0, [x24, #16432]
	add	x8, x8, #64
	str	w1, [x23, #8]
	add	x20, x8, x9
	cbz	x27, .LBB8_98
	add	x27, sp, #8, lsl #12
	add	x28, sp, #8, lsl #12
	add	x19, sp, #8, lsl #12
	mov	x24, xzr
	add	x27, x27, #128
	add	x28, x28, #232
	add	x19, x19, #152
.LBB8_97:
	str	x20, [x23, #16]
	//APP
	//NO_APP
	str	x22, [x23, #120]
	//APP
	//NO_APP
	ldr	x8, [sp, #48]
	str	x8, [x23, #40]
	//APP
	//NO_APP
	ldr	x0, [x23, #16]
	ldr	x1, [x23, #120]
	ldr	x2, [x23, #40]
	bl	raw_copy
	str	x20, [x23, #40]
	add	x24, x24, #1
	//APP
	//NO_APP
	ldr	x8, [sp, #56]
	cmp	x24, x8
	b.lo	.LBB8_97
.LBB8_98:
.Ltmp13:
	add	x0, sp, #8, lsl #12
	add	x0, x0, #112
	bl	_RNvMNtCs68fcPop4ROg_3std4timeNtB2_7Instant7elapsed
.Ltmp14:
	mov	w8, #51712
	ldr	x19, [sp, #8]
	adrp	x3, .Lalloc_33aa5ed87fc549baeed98c7b00832370
	add	x3, x3, :lo12:.Lalloc_33aa5ed87fc549baeed98c7b00832370
	movk	w8, #15258, lsl #16
	mul	x9, x0, x8
	umulh	x10, x0, x8
	ldr	x8, [sp, #48]
	add	x24, x8, x19
	adds	x9, x9, w1, uxtw
	cinc	x10, x10, hs
	cmp	x24, x19
	stp	x9, x10, [x23, #16]
	b.lo	.LBB8_146
	cmp	x24, #2049
	b.hs	.LBB8_146
	add	x1, x8, x26
	adrp	x3, .Lalloc_b648483c9ddff22c79d46fb5d378ae68
	add	x3, x3, :lo12:.Lalloc_b648483c9ddff22c79d46fb5d378ae68
	cmp	x1, x26
	stp	x20, x8, [x23, #120]
	b.lo	.LBB8_148
	cmp	x1, #2048
	b.hi	.LBB8_148
	lsl	x2, x8, #3
	mov	x0, x20
	mov	x1, x22
	stp	x22, x8, [x23, #40]
	bl	bcmp
	cbnz	w0, .LBB8_149
	cmp	x19, #2048
	b.hi	.LBB8_147
	and	x8, x25, #0xfffffffffffffff8
	cbz	x8, .LBB8_118
	sub	x9, x25, #8
	lsr	w8, w9, #3
	add	w8, w8, #1
	ands	x10, x8, #0x3
	b.eq	.LBB8_111
	add	x8, sp, #4, lsl #12
	adrp	x2, .Lalloc_4efdf6768da75f185dd8c24d590857cb
	add	x2, x2, :lo12:.Lalloc_4efdf6768da75f185dd8c24d590857cb
	add	x8, x8, #64
	adrp	x0, .Lalloc_0151101a464c295a00273d42c0a8e152
	add	x0, x0, :lo12:.Lalloc_0151101a464c295a00273d42c0a8e152
	mov	w1, #66
.LBB8_108:
	ldr	x11, [x8], #8
	cmn	x11, #1
	b.ne	.LBB8_145
	subs	x10, x10, #1
	b.ne	.LBB8_108
	cmp	x9, #24
	b.hs	.LBB8_112
	b	.LBB8_118
.LBB8_111:
	add	x8, sp, #4, lsl #12
	add	x8, x8, #64
	cmp	x9, #24
	b.lo	.LBB8_118
.LBB8_112:
	adrp	x2, .Lalloc_4efdf6768da75f185dd8c24d590857cb
	add	x2, x2, :lo12:.Lalloc_4efdf6768da75f185dd8c24d590857cb
	adrp	x0, .Lalloc_0151101a464c295a00273d42c0a8e152
	add	x0, x0, :lo12:.Lalloc_0151101a464c295a00273d42c0a8e152
	mov	w1, #66
.LBB8_113:
	ldr	x9, [x8]
	cmn	x9, #1
	b.ne	.LBB8_145
	ldr	x9, [x8, #8]
	cmn	x9, #1
	b.ne	.LBB8_145
	ldr	x9, [x8, #16]
	cmn	x9, #1
	b.ne	.LBB8_145
	ldr	x9, [x8, #24]
	cmn	x9, #1
	b.ne	.LBB8_145
	add	x8, x8, #32
	cmp	x8, x20
	b.ne	.LBB8_113
.LBB8_118:
	cmp	x24, #2048
	b.eq	.LBB8_122
	add	x9, sp, #4, lsl #12
	lsl	x8, x24, #3
	adrp	x2, .Lalloc_d781ac801ac6145c24d2c4d0e1bd65e1
	add	x2, x2, :lo12:.Lalloc_d781ac801ac6145c24d2c4d0e1bd65e1
	add	x9, x9, #64
	adrp	x0, .Lalloc_daae9162f00161f2bf97338a4f1e35ab
	add	x0, x0, :lo12:.Lalloc_daae9162f00161f2bf97338a4f1e35ab
	mov	w1, #70
.LBB8_120:
	ldr	x10, [x9, x8]
	cmn	x10, #1
	b.ne	.LBB8_145
	add	x8, x8, #8
	cmp	x8, #4, lsl #12
	b.ne	.LBB8_120
.LBB8_122:
	adrp	x10, :got:_RNvXsi_NtNtNtCshp6Wxz1DwXO_4core3fmt3num3impjNtB9_7Display3fmt
	and	x8, x22, #0x38
	add	x9, sp, #48
	ldr	x10, [x10, :got_lo12:_RNvXsi_NtNtNtCshp6Wxz1DwXO_4core3fmt3num3impjNtB9_7Display3fmt]
	stp	x8, x9, [x23, #32]
	add	x8, sp, #56
	adrp	x9, :got:_RNvXNtNtCshp6Wxz1DwXO_4core3fmt3numoNtB4_7Display3fmt
	stp	x10, x8, [x23, #48]
	add	x8, sp, #8, lsl #12
	add	x8, x8, #128
	ldr	x9, [x9, :got_lo12:_RNvXNtNtCshp6Wxz1DwXO_4core3fmt3numoNtB4_7Display3fmt]
	stp	x10, x8, [x23, #64]
	add	x8, sp, #8, lsl #12
	add	x8, x8, #144
	stp	x9, x8, [x23, #80]
	add	x8, sp, #8, lsl #12
	add	x8, x8, #232
	stp	x10, x8, [x23, #96]
	and	x8, x20, #0x38
	stp	x10, x8, [x23, #112]
.Ltmp21:
	add	x1, sp, #8, lsl #12
	adrp	x0, .Lalloc_242483277d2d9f144f9009149d5c5880
	add	x0, x0, :lo12:.Lalloc_242483277d2d9f144f9009149d5c5880
	add	x1, x1, #152
	bl	_RNvNtNtCs68fcPop4ROg_3std2io5stdio6__print
.Ltmp22:
	ldr	x20, [sp, #32]
	cbz	x20, .LBB8_128
	add	x19, x21, #8
	b	.LBB8_126
.LBB8_125:
	subs	x20, x20, #1
	add	x19, x19, #24
	b.eq	.LBB8_128
.LBB8_126:
	ldur	x1, [x19, #-8]
	cbz	x1, .LBB8_125
	ldr	x0, [x19]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB8_125
.LBB8_128:
	ldr	x8, [sp, #16]
	cbz	x8, .LBB8_130
	add	x8, x8, x8, lsl #1
	mov	x0, x21
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB8_130:
	mov	sp, x29
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
.LBB8_131:
	.cfi_restore_state
	sub	w8, w11, #48
	cmp	w8, #10
	mov	w8, #1
	cinc	w10, w8, lo
	b	.LBB8_133
.LBB8_132:
	mov	w10, #2
.LBB8_133:
	adrp	x4, .Lalloc_2aba04fc1d6f3a5c9fce7237ada90207
	add	x4, x4, :lo12:.Lalloc_2aba04fc1d6f3a5c9fce7237ada90207
	strb	w10, [x24]
	b	.LBB8_143
.LBB8_134:
	sub	w8, w12, #48
	cmp	w8, #10
	mov	w8, #1
	cinc	w10, w8, lo
	b	.LBB8_136
.LBB8_135:
	mov	w10, #2
.LBB8_136:
	strb	w10, [x24]
	adrp	x4, .Lalloc_0f4f7a1a3c3a0039de13b53ee49f7ed2
	add	x4, x4, :lo12:.Lalloc_0f4f7a1a3c3a0039de13b53ee49f7ed2
	b	.LBB8_143
.LBB8_137:
	sub	w8, w12, #48
	cmp	w8, #10
	mov	w8, #1
	cinc	w11, w8, lo
	b	.LBB8_139
.LBB8_138:
	mov	w11, #2
.LBB8_139:
	strb	w11, [x24]
	adrp	x4, .Lalloc_bb7ca809939e31d7cb465de2851968a0
	add	x4, x4, :lo12:.Lalloc_bb7ca809939e31d7cb465de2851968a0
	b	.LBB8_143
.LBB8_140:
	sub	w8, w12, #48
	cmp	w8, #10
	mov	w8, #1
	cinc	w11, w8, lo
	b	.LBB8_142
.LBB8_141:
	mov	w11, #2
.LBB8_142:
	strb	w11, [x24]
	adrp	x4, .Lalloc_2dbb0a2bc2b617546882d4168664f6f3
	add	x4, x4, :lo12:.Lalloc_2dbb0a2bc2b617546882d4168664f6f3
.LBB8_143:
	add	x2, sp, #4, lsl #12
	add	x2, x2, #64
.Ltmp9:
	adrp	x0, .Lalloc_00ae4b301f7fab8ac9617c03fcbd7274
	add	x0, x0, :lo12:.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274
	adrp	x3, .Lvtable.3
	add	x3, x3, :lo12:.Lvtable.3
	mov	w1, #43
	bl	_RNvNtCshp6Wxz1DwXO_4core6result13unwrap_failed
.Ltmp10:
	b	.LBB8_167
.LBB8_144:
	adrp	x2, .Lalloc_128dcacd48065ecac459e8f68ca2fcca
	add	x2, x2, :lo12:.Lalloc_128dcacd48065ecac459e8f68ca2fcca
	adrp	x0, .Lalloc_10fe3fd7842db3316470af18c3d2140d
	add	x0, x0, :lo12:.Lalloc_10fe3fd7842db3316470af18c3d2140d
	mov	w1, #92
.LBB8_145:
.Ltmp19:
	bl	_RNvNtCshp6Wxz1DwXO_4core9panicking5panic
.Ltmp20:
	b	.LBB8_167
.LBB8_146:
	mov	x26, x19
	mov	x1, x24
	b	.LBB8_148
.LBB8_147:
	mov	x26, xzr
	adrp	x3, .Lalloc_1b0a3b640c3f7194bb0ebfe90a831d5d
	add	x3, x3, :lo12:.Lalloc_1b0a3b640c3f7194bb0ebfe90a831d5d
	mov	x1, x19
.LBB8_148:
.Ltmp17:
	mov	x0, x26
	mov	w2, #2048
	bl	_RNvNtNtCshp6Wxz1DwXO_4core5slice5index16slice_index_fail
.Ltmp18:
	b	.LBB8_167
.LBB8_149:
.Ltmp15:
	add	x0, sp, #8, lsl #12
	add	x1, sp, #8, lsl #12
	add	x0, x0, #232
	add	x1, x1, #152
	bl	_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedRSjBM_ECshsBGi11rG2H_7rawcopy
.Ltmp16:
	b	.LBB8_167
.LBB8_150:
	mov	w10, #1
	b	.LBB8_133
.LBB8_151:
	mov	w10, #1
	b	.LBB8_136
.LBB8_152:
	mov	w11, #1
	b	.LBB8_139
.LBB8_153:
	mov	w11, #1
	b	.LBB8_142
.LBB8_154:
	ldr	x8, [sp, #72]
	ldr	x9, [sp, #88]
	mov	w10, #8
	stp	xzr, x10, [sp, #16]
	subs	x9, x9, x8
	str	xzr, [sp, #32]
	b.ne	.LBB8_159
.LBB8_155:
	ldr	x8, [sp, #80]
	cbz	x8, .LBB8_157
	add	x8, x8, x8, lsl #1
	ldr	x0, [sp, #64]
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB8_157:
	mov	x1, xzr
.LBB8_158:
	adrp	x2, .Lalloc_964559183541d0267187e2c4b277bb4e
	add	x2, x2, :lo12:.Lalloc_964559183541d0267187e2c4b277bb4e
	mov	w0, #1
	b	.LBB8_166
.LBB8_159:
	mov	x10, #-6148914691236517206
	add	x20, x8, #8
	movk	x10, #43691
	umulh	x9, x9, x10
	lsr	x19, x9, #4
	b	.LBB8_161
.LBB8_160:
	subs	x19, x19, #1
	add	x20, x20, #24
	b.eq	.LBB8_155
.LBB8_161:
	ldur	x1, [x20, #-8]
	cbz	x1, .LBB8_160
	ldr	x0, [x20]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB8_160
.LBB8_163:
	adrp	x2, .Lalloc_9189b17a0d38f81e0b768fdd496ad016
	add	x2, x2, :lo12:.Lalloc_9189b17a0d38f81e0b768fdd496ad016
	mov	w0, #2
	b	.LBB8_166
.LBB8_164:
	adrp	x2, .Lalloc_5402922c1b616663f39de9605452433b
	add	x2, x2, :lo12:.Lalloc_5402922c1b616663f39de9605452433b
	mov	w0, #3
	mov	w1, #3
	b	.LBB8_166
.LBB8_165:
	adrp	x2, .Lalloc_2be509ebd9cc61f70f092dfe957ed169
	add	x2, x2, :lo12:.Lalloc_2be509ebd9cc61f70f092dfe957ed169
	mov	w0, #4
.LBB8_166:
.Ltmp26:
	bl	_RNvNtCshp6Wxz1DwXO_4core9panicking18panic_bounds_check
.Ltmp27:
.LBB8_167:
	brk	#0x1
.LBB8_168:
	mov	w10, wzr
	b	.LBB8_133
.LBB8_169:
	mov	w10, wzr
	b	.LBB8_136
.LBB8_170:
	mov	w11, wzr
	b	.LBB8_139
.LBB8_171:
	mov	w11, wzr
	b	.LBB8_142
.LBB8_172:
.Ltmp2:
	mov	x19, x0
	b	.LBB8_180
.LBB8_173:
.Ltmp8:
	mov	x19, x0
	cbz	x21, .LBB8_176
	mov	x0, x22
	mov	x1, x21
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB8_176
.LBB8_175:
.Ltmp5:
	mov	x19, x0
.LBB8_176:
	add	x0, sp, #4, lsl #12
	add	x0, x0, #64
	bl	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECshsBGi11rG2H_7rawcopy
	add	x0, sp, #8, lsl #12
	add	x0, x0, #232
	bl	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECshsBGi11rG2H_7rawcopy
	mov	x0, x19
	bl	_Unwind_Resume
.LBB8_177:
.Ltmp28:
	mov	x19, x0
	add	x0, sp, #16
	bl	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECshsBGi11rG2H_7rawcopy
	mov	x0, x19
	bl	_Unwind_Resume
.LBB8_178:
.Ltmp25:
	mov	x19, x0
	cbz	x20, .LBB8_180
	mov	x0, x21
	mov	x1, x20
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB8_180:
	ldr	x8, [sp, #72]
	ldr	x9, [sp, #88]
	subs	x9, x9, x8
	b.ne	.LBB8_183
.LBB8_181:
	ldr	x8, [sp, #80]
	cbnz	x8, .LBB8_187
	mov	x0, x19
	bl	_Unwind_Resume
.LBB8_183:
	mov	x10, #-6148914691236517206
	add	x21, x8, #8
	movk	x10, #43691
	umulh	x9, x9, x10
	lsr	x20, x9, #4
	b	.LBB8_185
.LBB8_184:
	subs	x20, x20, #1
	add	x21, x21, #24
	b.eq	.LBB8_181
.LBB8_185:
	ldur	x1, [x21, #-8]
	cbz	x1, .LBB8_184
	ldr	x0, [x21]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB8_184
.LBB8_187:
	add	x8, x8, x8, lsl #1
	ldr	x0, [sp, #64]
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	mov	x0, x19
	bl	_Unwind_Resume
.Lfunc_end8:
	.size	_RNvCshsBGi11rG2H_7rawcopy4main, .Lfunc_end8-_RNvCshsBGi11rG2H_7rawcopy4main
	.cfi_endproc
	.section	.gcc_except_table._RNvCshsBGi11rG2H_7rawcopy4main,"a",@progbits
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
	.uleb128 .Ltmp23-.Lfunc_begin0
	.uleb128 .Ltmp24-.Ltmp23
	.uleb128 .Ltmp25-.Lfunc_begin0
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
	.uleb128 .Ltmp11-.Ltmp7
	.byte	0
	.byte	0
	.uleb128 .Ltmp11-.Lfunc_begin0
	.uleb128 .Ltmp27-.Ltmp11
	.uleb128 .Ltmp28-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp27-.Lfunc_begin0
	.uleb128 .Lfunc_end8-.Ltmp27
	.byte	0
	.byte	0
.Lcst_end0:
	.p2align	2, 0x0

	.section	.text.unlikely._RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshsBGi11rG2H_7rawcopy,"ax",@progbits
	.p2align	2
	.type	_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshsBGi11rG2H_7rawcopy,@function
_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshsBGi11rG2H_7rawcopy:
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
	b.ls	.LBB9_2
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
.LBB9_2:
	.cfi_restore_state
	.cfi_remember_state
	add	x8, x3, x3, lsl #1
	lsl	x20, x8, #3
	cbz	x1, .LBB9_4
	add	x8, x1, x1, lsl #1
	mov	x0, x2
	mov	w2, #8
	mov	x3, x20
	lsl	x1, x8, #3
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_realloc
	cbnz	x0, .LBB9_8
	b	.LBB9_6
.LBB9_4:
	cbz	x20, .LBB9_7
	bl	_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	x0, x20
	mov	w1, #8
	bl	_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc
	cbnz	x0, .LBB9_8
.LBB9_6:
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
.LBB9_7:
	.cfi_restore_state
	mov	w0, #8
.LBB9_8:
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
.Lfunc_end9:
	.size	_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshsBGi11rG2H_7rawcopy, .Lfunc_end9-_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy,"ax",@progbits
	.p2align	2
	.type	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy,@function
_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy:
	.cfi_startproc
	ldr	x8, [x0]
	adrp	x9, .Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy
	add	x9, x9, :lo12:.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy
	mov	x0, x1
	ldrb	w8, [x8]
	ldrb	w2, [x9, x8]
	adrp	x9, .Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel
	add	x9, x9, :lo12:.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel
	ldrsw	x8, [x9, x8, lsl #2]
	add	x1, x9, x8
	b	_RNvMsa_NtCshp6Wxz1DwXO_4core3fmtNtB5_9Formatter9write_str
.Lfunc_end10:
	.size	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy, .Lfunc_end10-_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRRSjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy,"ax",@progbits
	.p2align	2
	.type	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRRSjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy,@function
_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRRSjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy:
	.cfi_startproc
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	stp	x29, x30, [sp, #16]
	str	x21, [sp, #32]
	stp	x20, x19, [sp, #48]
	add	x29, sp, #16
	.cfi_def_cfa w29, 48
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -32
	.cfi_offset w30, -40
	.cfi_offset w29, -48
	ldr	x8, [x0]
	mov	x0, x1
	ldp	x20, x19, [x8]
	mov	x8, sp
	bl	_RNvMsa_NtCshp6Wxz1DwXO_4core3fmtNtB5_9Formatter10debug_list
	cbz	x19, .LBB11_3
	lsl	x21, x19, #3
	adrp	x19, .Lvtable.0
	add	x19, x19, :lo12:.Lvtable.0
.LBB11_2:
	mov	x0, sp
	add	x1, x29, #24
	mov	x2, x19
	str	x20, [x29, #24]
	add	x20, x20, #8
	bl	_RNvMs6_NtNtCshp6Wxz1DwXO_4core3fmt8buildersNtB5_9DebugList5entry
	subs	x21, x21, #8
	b.ne	.LBB11_2
.LBB11_3:
	mov	x0, sp
	bl	_RNvMs6_NtNtCshp6Wxz1DwXO_4core3fmt8buildersNtB5_9DebugList6finish
	.cfi_def_cfa wsp, 64
	ldp	x20, x19, [sp, #48]
	ldr	x21, [sp, #32]
	ldp	x29, x30, [sp, #16]
	add	sp, sp, #64
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end11:
	.size	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRRSjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy, .Lfunc_end11-_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRRSjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy,"ax",@progbits
	.p2align	2
	.type	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy,@function
_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy:
	.cfi_startproc
	ldr	w8, [x1, #16]
	ldr	x0, [x0]
	tbnz	w8, #25, .LBB12_3
	tbnz	w8, #26, .LBB12_4
	b	_RNvXsi_NtNtNtCshp6Wxz1DwXO_4core3fmt3num3impjNtB9_7Display3fmt
.LBB12_3:
	b	_RNvXs6_NtNtCshp6Wxz1DwXO_4core3fmt3numjNtB7_8LowerHex3fmt
.LBB12_4:
	b	_RNvXs8_NtNtCshp6Wxz1DwXO_4core3fmt3numjNtB7_8UpperHex3fmt
.Lfunc_end12:
	.size	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy, .Lfunc_end12-_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy
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
	adrp	x6, .Lvtable.4
	add	x6, x6, :lo12:.Lvtable.4
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
.Lfunc_end13:
	.size	_RNvXsd_NtNtCshp6Wxz1DwXO_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt, .Lfunc_end13-_RNvXsd_NtNtCshp6Wxz1DwXO_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
	.cfi_endproc

	.section	.text.raw_copy,"ax",@progbits
	.globl	raw_copy
	.p2align	2
	.type	raw_copy,@function
raw_copy:
	.cfi_startproc
	cbz	x2, .LBB14_6
	cmp	x2, #1
	b.eq	.LBB14_3
	sub	x8, x1, x0
	cmn	x8, #128
	b.ls	.LBB14_7
.LBB14_3:
	mov	x8, xzr
.LBB14_4:
	lsl	x10, x8, #3
	sub	x8, x2, x8
	add	x9, x1, x10
	add	x10, x0, x10
.LBB14_5:
	ldr	x11, [x9], #8
	subs	x8, x8, #1
	str	x11, [x10], #8
	b.ne	.LBB14_5
.LBB14_6:
	ret
.LBB14_7:
	cmp	x2, #16
	b.hs	.LBB14_9
	mov	x8, xzr
	b	.LBB14_13
.LBB14_9:
	and	x9, x2, #0xe
	and	x8, x2, #0xfffffffffffffff0
	add	x10, x0, #64
	add	x11, x1, #64
	and	x12, x2, #0xfffffffffffffff0
.LBB14_10:
	ldp	q0, q1, [x11, #-64]
	subs	x12, x12, #16
	ldp	q2, q3, [x11, #-32]
	ldp	q4, q5, [x11]
	ldp	q6, q7, [x11, #32]
	add	x11, x11, #128
	stp	q0, q1, [x10, #-64]
	stp	q2, q3, [x10, #-32]
	stp	q4, q5, [x10]
	stp	q6, q7, [x10, #32]
	add	x10, x10, #128
	b.ne	.LBB14_10
	cmp	x2, x8
	b.eq	.LBB14_6
	cbz	x9, .LBB14_4
.LBB14_13:
	mov	x9, x8
	and	x8, x2, #0xfffffffffffffffe
	lsl	x11, x9, #3
	sub	x9, x9, x8
	add	x10, x1, x11
	add	x11, x0, x11
.LBB14_14:
	ldr	q0, [x10], #16
	adds	x9, x9, #2
	str	q0, [x11], #16
	b.ne	.LBB14_14
	cmp	x2, x8
	b.ne	.LBB14_4
	b	.LBB14_6
.Lfunc_end14:
	.size	raw_copy, .Lfunc_end14-raw_copy
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
	adrp	x8, _RNvCshsBGi11rG2H_7rawcopy4main
	add	x8, x8, :lo12:_RNvCshsBGi11rG2H_7rawcopy4main
	adrp	x1, .Lvtable.1
	add	x1, x1, :lo12:.Lvtable.1
	add	x0, sp, #8
	mov	w4, wzr
	str	x8, [sp, #8]
	bl	_RNvNtCs68fcPop4ROg_3std2rt19lang_start_internal
	ldp	x29, x30, [sp, #16]
	add	sp, sp, #32
	ret
.Lfunc_end15:
	.size	main, .Lfunc_end15-main
	.cfi_endproc

	.type	.Lvtable.0,@object
	.section	.data.rel.ro..Lvtable.0,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.0:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.xword	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy
	.size	.Lvtable.0, 32

	.type	.Lvtable.1,@object
	.section	.data.rel.ro..Lvtable.1,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.1:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.xword	_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCshsBGi11rG2H_7rawcopy
	.xword	_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0CshsBGi11rG2H_7rawcopy
	.xword	_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0CshsBGi11rG2H_7rawcopy
	.size	.Lvtable.1, 48

	.type	.Lvtable.2,@object
	.section	.data.rel.ro..Lvtable.2,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.2:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.xword	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRRSjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy
	.size	.Lvtable.2, 32

	.type	.Lalloc_a63772ed514a93359afe3b0a31acdc8c,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_a63772ed514a93359afe3b0a31acdc8c:
	.asciz	"/tmp/vec-from-iter-20261106/rawcopy.rs"
	.size	.Lalloc_a63772ed514a93359afe3b0a31acdc8c, 39

	.type	.Lalloc_964559183541d0267187e2c4b277bb4e,@object
	.section	.data.rel.ro..Lalloc_964559183541d0267187e2c4b277bb4e,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_964559183541d0267187e2c4b277bb4e:
	.xword	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000@\000\000"
	.size	.Lalloc_964559183541d0267187e2c4b277bb4e, 24

	.type	.Lalloc_2aba04fc1d6f3a5c9fce7237ada90207,@object
	.section	.data.rel.ro..Lalloc_2aba04fc1d6f3a5c9fce7237ada90207,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_2aba04fc1d6f3a5c9fce7237ada90207:
	.xword	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000L\000\000"
	.size	.Lalloc_2aba04fc1d6f3a5c9fce7237ada90207, 24

	.type	.Lalloc_9189b17a0d38f81e0b768fdd496ad016,@object
	.section	.data.rel.ro..Lalloc_9189b17a0d38f81e0b768fdd496ad016,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_9189b17a0d38f81e0b768fdd496ad016:
	.xword	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000c\000\000"
	.size	.Lalloc_9189b17a0d38f81e0b768fdd496ad016, 24

	.type	.Lalloc_0f4f7a1a3c3a0039de13b53ee49f7ed2,@object
	.section	.data.rel.ro..Lalloc_0f4f7a1a3c3a0039de13b53ee49f7ed2,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_0f4f7a1a3c3a0039de13b53ee49f7ed2:
	.xword	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000o\000\000"
	.size	.Lalloc_0f4f7a1a3c3a0039de13b53ee49f7ed2, 24

	.type	.Lalloc_5402922c1b616663f39de9605452433b,@object
	.section	.data.rel.ro..Lalloc_5402922c1b616663f39de9605452433b,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_5402922c1b616663f39de9605452433b:
	.xword	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000\210\000\000"
	.size	.Lalloc_5402922c1b616663f39de9605452433b, 24

	.type	.Lalloc_bb7ca809939e31d7cb465de2851968a0,@object
	.section	.data.rel.ro..Lalloc_bb7ca809939e31d7cb465de2851968a0,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_bb7ca809939e31d7cb465de2851968a0:
	.xword	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000\224\000\000"
	.size	.Lalloc_bb7ca809939e31d7cb465de2851968a0, 24

	.type	.Lalloc_2be509ebd9cc61f70f092dfe957ed169,@object
	.section	.data.rel.ro..Lalloc_2be509ebd9cc61f70f092dfe957ed169,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_2be509ebd9cc61f70f092dfe957ed169:
	.xword	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000\255\000\000"
	.size	.Lalloc_2be509ebd9cc61f70f092dfe957ed169, 24

	.type	.Lalloc_2dbb0a2bc2b617546882d4168664f6f3,@object
	.section	.data.rel.ro..Lalloc_2dbb0a2bc2b617546882d4168664f6f3,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_2dbb0a2bc2b617546882d4168664f6f3:
	.xword	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000\271\000\000"
	.size	.Lalloc_2dbb0a2bc2b617546882d4168664f6f3, 24

	.type	.Lalloc_67e13228cc1d9cff242e5e6206de75d9,@object
	.section	.data.rel.ro..Lalloc_67e13228cc1d9cff242e5e6206de75d9,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_67e13228cc1d9cff242e5e6206de75d9:
	.xword	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000g\002\000"
	.size	.Lalloc_67e13228cc1d9cff242e5e6206de75d9, 24

	.type	.Lalloc_0151101a464c295a00273d42c0a8e152,@object
	.section	.rodata..Lalloc_0151101a464c295a00273d42c0a8e152,"a",@progbits
.Lalloc_0151101a464c295a00273d42c0a8e152:
	.ascii	"assertion failed: d.0[..doff / 8].iter().all(|&x| x == usize::MAX)"
	.size	.Lalloc_0151101a464c295a00273d42c0a8e152, 66

	.type	.Lalloc_4efdf6768da75f185dd8c24d590857cb,@object
	.section	.data.rel.ro..Lalloc_4efdf6768da75f185dd8c24d590857cb,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_4efdf6768da75f185dd8c24d590857cb:
	.xword	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000\235\002\000"
	.size	.Lalloc_4efdf6768da75f185dd8c24d590857cb, 24

	.type	.Lalloc_daae9162f00161f2bf97338a4f1e35ab,@object
	.section	.rodata..Lalloc_daae9162f00161f2bf97338a4f1e35ab,"a",@progbits
.Lalloc_daae9162f00161f2bf97338a4f1e35ab:
	.ascii	"assertion failed: d.0[doff / 8 + n..].iter().all(|&x| x == usize::MAX)"
	.size	.Lalloc_daae9162f00161f2bf97338a4f1e35ab, 70

	.type	.Lalloc_d781ac801ac6145c24d2c4d0e1bd65e1,@object
	.section	.data.rel.ro..Lalloc_d781ac801ac6145c24d2c4d0e1bd65e1,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_d781ac801ac6145c24d2c4d0e1bd65e1:
	.xword	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000\322\002\000"
	.size	.Lalloc_d781ac801ac6145c24d2c4d0e1bd65e1, 24

	.type	.Lalloc_242483277d2d9f144f9009149d5c5880,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_242483277d2d9f144f9009149d5c5880:
	.asciz	"\005{\"n\":\300\b,\"reps\":\300\016,\"elapsed_ns\":\300\r,\"src_mod64\":\300\r,\"dst_mod64\":\300\002}\n"
	.size	.Lalloc_242483277d2d9f144f9009149d5c5880, 67

	.type	.Lalloc_1b0a3b640c3f7194bb0ebfe90a831d5d,@object
	.section	.data.rel.ro..Lalloc_1b0a3b640c3f7194bb0ebfe90a831d5d,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_1b0a3b640c3f7194bb0ebfe90a831d5d:
	.xword	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000\250\002\000"
	.size	.Lalloc_1b0a3b640c3f7194bb0ebfe90a831d5d, 24

	.type	.Lalloc_b648483c9ddff22c79d46fb5d378ae68,@object
	.section	.data.rel.ro..Lalloc_b648483c9ddff22c79d46fb5d378ae68,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_b648483c9ddff22c79d46fb5d378ae68:
	.xword	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000\215\002\000"
	.size	.Lalloc_b648483c9ddff22c79d46fb5d378ae68, 24

	.type	.Lalloc_33aa5ed87fc549baeed98c7b00832370,@object
	.section	.data.rel.ro..Lalloc_33aa5ed87fc549baeed98c7b00832370,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_33aa5ed87fc549baeed98c7b00832370:
	.xword	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000v\002\000"
	.size	.Lalloc_33aa5ed87fc549baeed98c7b00832370, 24

	.type	.Lalloc_10fe3fd7842db3316470af18c3d2140d,@object
	.section	.rodata..Lalloc_10fe3fd7842db3316470af18c3d2140d,"a",@progbits
.Lalloc_10fe3fd7842db3316470af18c3d2140d:
	.ascii	"assertion failed: so % 8 == 0 && doff % 8 == 0 && n + so / 8 <= 2048 && n + doff / 8 <= 2048"
	.size	.Lalloc_10fe3fd7842db3316470af18c3d2140d, 92

	.type	.Lalloc_128dcacd48065ecac459e8f68ca2fcca,@object
	.section	.data.rel.ro..Lalloc_128dcacd48065ecac459e8f68ca2fcca,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_128dcacd48065ecac459e8f68ca2fcca:
	.xword	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000\302\000\000"
	.size	.Lalloc_128dcacd48065ecac459e8f68ca2fcca, 24

	.type	.Lvtable.3,@object
	.section	.data.rel.ro..Lvtable.3,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.3:
	.asciz	"\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\001\000\000\000\000\000\000"
	.xword	_RNvXsd_NtNtCshp6Wxz1DwXO_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
	.size	.Lvtable.3, 32

	.type	.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274,@object
	.section	.rodata..Lalloc_00ae4b301f7fab8ac9617c03fcbd7274,"a",@progbits
.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274:
	.ascii	"called `Result::unwrap()` on an `Err` value"
	.size	.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274, 43

	.type	.Lvtable.4,@object
	.section	.data.rel.ro..Lvtable.4,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.4:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.xword	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy
	.size	.Lvtable.4, 32

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

	.type	.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy,"a",@progbits
	.p2align	3, 0x0
.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy:
	.ascii	"\005\f\013\013\004\016"
	.size	.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy, 6

	.type	.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel,"a",@progbits
	.p2align	2, 0x0
.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel:
	.word	.Lalloc_59ba7b9f7211443cd55a366616eef46a-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel
	.word	.Lalloc_00315c78e51d29fe6b3102a4c1ecf6ef-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel
	.word	.Lalloc_bd3a3f3879e0d5f64554753e977f58d4-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel
	.word	.Lalloc_0964bb2a4870637395c77a018495bd5c-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel
	.word	.Lalloc_6566120a3a17f930e960a0863fcbd591-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel
	.word	.Lalloc_6c17bac0c71cba42380f8445f4dcbd16-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel
	.size	.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel, 24

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
