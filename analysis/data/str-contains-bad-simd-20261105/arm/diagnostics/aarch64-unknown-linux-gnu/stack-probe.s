	.file	"stack_probe.52300b21131dbeaf-cgu.0"
	.section	.text._RINvNtCs68fcPop4ROg_3std2rt10lang_startuECs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.hidden	_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECs73tWNsq4cWN_11stack_probe
	.globl	_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECs73tWNsq4cWN_11stack_probe
	.p2align	2
	.type	_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECs73tWNsq4cWN_11stack_probe,@function
_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECs73tWNsq4cWN_11stack_probe:
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
	.size	_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECs73tWNsq4cWN_11stack_probe, .Lfunc_end0-_RINvNtCs68fcPop4ROg_3std2rt10lang_startuECs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text._RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.p2align	2
	.type	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECs73tWNsq4cWN_11stack_probe,@function
_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECs73tWNsq4cWN_11stack_probe:
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
	.size	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECs73tWNsq4cWN_11stack_probe, .Lfunc_end1-_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text._RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.p2align	2
	.type	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECs73tWNsq4cWN_11stack_probe,@function
_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECs73tWNsq4cWN_11stack_probe:
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
	.size	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECs73tWNsq4cWN_11stack_probe, .Lfunc_end2-_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text.unlikely._RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedTyyEBM_ECs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.p2align	2
	.type	_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedTyyEBM_ECs73tWNsq4cWN_11stack_probe,@function
_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedTyyEBM_ECs73tWNsq4cWN_11stack_probe:
	.cfi_startproc
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	adrp	x8, .Lalloc_011d402fc2fd12f79ff2bc7691f0df1d
	add	x8, x8, :lo12:.Lalloc_011d402fc2fd12f79ff2bc7691f0df1d
	adrp	x2, .Lvtable.1
	add	x2, x2, :lo12:.Lvtable.1
	stp	x0, x8, [sp]
	adrp	x7, .Lalloc_7bcbc173a0f42afa1c2057178d25fe54
	add	x7, x7, :lo12:.Lalloc_7bcbc173a0f42afa1c2057178d25fe54
	mov	x1, sp
	add	x3, sp, #8
	mov	w0, wzr
	mov	x4, x2
	mov	x5, xzr
	bl	_RNvNtCshp6Wxz1DwXO_4core9panicking19assert_failed_inner
.Lfunc_end3:
	.size	_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedTyyEBM_ECs73tWNsq4cWN_11stack_probe, .Lfunc_end3-_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedTyyEBM_ECs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text._RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.p2align	2
	.type	_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs73tWNsq4cWN_11stack_probe,@function
_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs73tWNsq4cWN_11stack_probe:
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
	.size	_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs73tWNsq4cWN_11stack_probe, .Lfunc_end4-_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text.unlikely._RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.p2align	2
	.type	_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs73tWNsq4cWN_11stack_probe,@function
_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs73tWNsq4cWN_11stack_probe:
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
	bl	_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs73tWNsq4cWN_11stack_probe
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
	.size	_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs73tWNsq4cWN_11stack_probe, .Lfunc_end5-_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text._RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Cs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.p2align	2
	.type	_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Cs73tWNsq4cWN_11stack_probe,@function
_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Cs73tWNsq4cWN_11stack_probe:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x0, [x0]
	bl	_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs73tWNsq4cWN_11stack_probe
	mov	w0, wzr
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end6:
	.size	_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Cs73tWNsq4cWN_11stack_probe, .Lfunc_end6-_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Cs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text._RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.p2align	2
	.type	_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCs73tWNsq4cWN_11stack_probe,@function
_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCs73tWNsq4cWN_11stack_probe:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x0, [x0]
	bl	_RINvNtNtCs68fcPop4ROg_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs73tWNsq4cWN_11stack_probe
	mov	w0, wzr
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end7:
	.size	_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCs73tWNsq4cWN_11stack_probe, .Lfunc_end7-_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text._RNvCs73tWNsq4cWN_11stack_probe3run,"ax",@progbits
	.p2align	2
	.type	_RNvCs73tWNsq4cWN_11stack_probe3run,@function
_RNvCs73tWNsq4cWN_11stack_probe3run:
	.cfi_startproc
	mov	x8, x1
	mov	x9, x0
	mov	w0, #1
	mov	w1, #2
	tbz	w2, #0, .LBB8_2
	//APP
.Ltmp27:
	stp	x0, x1, [x9]
	ldr	x0, [x9]
	ldr	x1, [x9, #8]
	subs	x8, x8, #1
	b.ne	.Ltmp27
	//NO_APP
	ret
.LBB8_2:
	//APP
.Ltmp28:
	stp	x0, x1, [x9]
	ldp	x0, x1, [x9]
	subs	x8, x8, #1
	b.ne	.Ltmp28
	//NO_APP
	ret
.Lfunc_end8:
	.size	_RNvCs73tWNsq4cWN_11stack_probe3run, .Lfunc_end8-_RNvCs73tWNsq4cWN_11stack_probe3run
	.cfi_endproc

	.section	.text._RNvCs73tWNsq4cWN_11stack_probe4main,"ax",@progbits
	.hidden	_RNvCs73tWNsq4cWN_11stack_probe4main
	.globl	_RNvCs73tWNsq4cWN_11stack_probe4main
	.p2align	2
	.type	_RNvCs73tWNsq4cWN_11stack_probe4main,@function
_RNvCs73tWNsq4cWN_11stack_probe4main:
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
	sub	x9, sp, #416
	and	sp, x9, #0xffffffffffffffc0
	add	x8, sp, #256
	bl	_RNvNtCs68fcPop4ROg_3std3env4args
.Ltmp0:
	add	x8, sp, #64
	add	x0, sp, #256
	bl	_RNvXsc_NtCs68fcPop4ROg_3std3envNtB5_4ArgsNtNtNtNtCshp6Wxz1DwXO_4core4iter6traits8iterator8Iterator4next
.Ltmp1:
	ldr	x20, [sp, #64]
	cmn	x20, #1
	b.eq	.LBB9_83
	ldr	x8, [sp, #264]
	ldr	x9, [sp, #280]
	mov	x10, #-6148914691236517206
	movk	x10, #43691
	ldr	x21, [sp, #72]
	sub	x8, x9, x8
	lsr	x9, x8, #3
	mul	x9, x9, x10
	mov	w10, #3
	cmp	x9, #3
	csel	x9, x9, x10, hi
	mov	x10, #9223372036854775776
	add	x25, x9, #1
	cmp	x8, x10
	add	x9, x25, x25, lsl #1
	lsl	x22, x9, #3
	b.ls	.LBB9_5
	mov	x23, xzr
.LBB9_4:
.Ltmp21:
	mov	x0, x23
	mov	x1, x22
	bl	_RNvNtCs6sh1iPzjxYC_5alloc7raw_vec12handle_error
.Ltmp22:
	b	.LBB9_95
.LBB9_5:
	ldr	x26, [sp, #80]
	cbz	x22, .LBB9_8
	bl	_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	x0, x22
	mov	w1, #8
	mov	w23, #8
	bl	_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc
	cbz	x0, .LBB9_4
	mov	x19, x0
	b	.LBB9_9
.LBB9_8:
	mov	x25, xzr
	mov	w19, #8
.LBB9_9:
	stp	x20, x21, [x19]
	add	x23, sp, #64
	mov	x24, xzr
	str	x26, [x19, #16]
	mov	w20, #1
	mov	x26, #1
	ldp	q0, q1, [x23, #192]
	stp	x25, x19, [sp, #320]
	mov	x25, #-6148914691236517206
	str	x20, [sp, #336]
	movk	x25, #43691
	stp	q0, q1, [sp, #64]
	b	.LBB9_12
.LBB9_10:
	ldr	x19, [sp, #328]
.LBB9_11:
	add	x8, x19, x24
	add	x20, x20, #1
	add	x24, x24, #24
	stp	x21, x22, [x8, #24]
	str	x27, [x8, #40]
	str	x20, [sp, #336]
.LBB9_12:
.Ltmp3:
	add	x8, sp, #352
	add	x0, sp, #64
	bl	_RNvXsc_NtCs68fcPop4ROg_3std3envNtB5_4ArgsNtNtNtNtCshp6Wxz1DwXO_4core4iter6traits8iterator8Iterator4next
.Ltmp4:
	ldr	x21, [sp, #352]
	cmn	x21, #1
	b.eq	.LBB9_16
	ldr	x8, [sp, #320]
	ldp	x22, x27, [sp, #360]
	cmp	x20, x8
	b.ne	.LBB9_11
	ldr	x8, [sp, #88]
	ldr	x9, [sp, #72]
	sub	x8, x8, x9
	lsr	x8, x8, #3
	madd	x2, x8, x25, x26
.Ltmp6:
	add	x0, sp, #320
	mov	x1, x20
	bl	_RINvNvMs2_NtCs6sh1iPzjxYC_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs73tWNsq4cWN_11stack_probe
.Ltmp7:
	b	.LBB9_10
.LBB9_16:
	ldr	x8, [sp, #72]
	ldr	x9, [sp, #88]
	subs	x9, x9, x8
	b.eq	.LBB9_21
	mov	x10, #-6148914691236517206
	add	x20, x8, #8
	movk	x10, #43691
	umulh	x9, x9, x10
	lsr	x19, x9, #4
	b	.LBB9_19
.LBB9_18:
	subs	x19, x19, #1
	add	x20, x20, #24
	b.eq	.LBB9_21
.LBB9_19:
	ldur	x1, [x20, #-8]
	cbz	x1, .LBB9_18
	ldr	x0, [x20]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB9_18
.LBB9_21:
	ldr	x8, [sp, #80]
	cbz	x8, .LBB9_23
	add	x8, x8, x8, lsl #1
	ldr	x0, [sp, #64]
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB9_23:
	ldr	x19, [sp, #336]
	ldr	q0, [x23, #256]
	cmp	x19, #2
	str	q0, [x23, #288]
	str	x19, [sp, #368]
	b.lo	.LBB9_87
	ldr	x20, [sp, #360]
	ldp	x8, x9, [x20, #32]
	cmp	x9, #1
	b.eq	.LBB9_27
	cbz	x9, .LBB9_96
	ldrb	w11, [x8]
	b	.LBB9_29
.LBB9_27:
	ldrb	w11, [x8]
	mov	w10, #1
	cmp	w11, #43
	b.eq	.LBB9_74
	cmp	w11, #45
	b.eq	.LBB9_74
.LBB9_29:
	cmp	w11, #43
	cset	w10, eq
	sub	x9, x9, x10
	cinc	x10, x8, eq
	cmp	x9, #17
	b.hs	.LBB9_34
	mov	x8, xzr
	cbz	x9, .LBB9_39
	mov	w11, #10
.LBB9_32:
	ldrb	w12, [x10], #1
	sub	w12, w12, #48
	cmp	w12, #9
	b.hi	.LBB9_81
	mul	x8, x8, x11
	subs	x9, x9, #1
	add	x8, x8, w12, uxtw
	b.ne	.LBB9_32
	b	.LBB9_39
.LBB9_34:
	mov	x8, xzr
	mov	w11, #10
.LBB9_35:
	umulh	x13, x8, x11
	ldrb	w12, [x10], #1
	cmp	xzr, x13
	b.ne	.LBB9_72
	sub	w12, w12, #48
	cmp	w12, #10
	b.hs	.LBB9_81
	add	x8, x8, x8, lsl #2
	lsl	x8, x8, #1
	adds	x8, x8, w12, uxtw
	b.hs	.LBB9_73
	sub	x9, x9, #1
	cbnz	x9, .LBB9_35
.LBB9_39:
	cmp	x19, #2
	str	x8, [sp, #40]
	b.eq	.LBB9_92
	ldr	x9, [x20, #64]
	cmp	x9, #5
	b.ne	.LBB9_42
	ldr	x9, [x20, #56]
	ldrb	w10, [x9, #4]
	ldr	w9, [x9]
	cmp	w10, #116
	mov	w10, #28787
	movk	w10, #26988, lsl #16
	ccmp	w9, w10, #0, eq
	cset	w9, eq
	b	.LBB9_43
.LBB9_42:
	mov	w9, wzr
.LBB9_43:
	cmp	x19, #4
	strb	w9, [sp, #52]
	b.lo	.LBB9_93
	ldp	x10, x9, [x20, #80]
	cmp	x9, #1
	b.eq	.LBB9_47
	cbz	x9, .LBB9_97
	ldrb	w12, [x10]
	b	.LBB9_49
.LBB9_47:
	ldrb	w12, [x10]
	mov	w11, #1
	cmp	w12, #43
	b.eq	.LBB9_77
	cmp	w12, #45
	b.eq	.LBB9_77
.LBB9_49:
	cmp	w12, #43
	cset	w11, eq
	cinc	x10, x10, eq
	sub	x9, x9, x11
	cmp	x9, #17
	b.hs	.LBB9_54
	mov	x11, xzr
	cbz	x9, .LBB9_59
	mov	w12, #10
.LBB9_52:
	ldrb	w13, [x10], #1
	sub	w13, w13, #48
	cmp	w13, #9
	b.hi	.LBB9_82
	mul	x11, x11, x12
	subs	x9, x9, #1
	add	x11, x11, w13, uxtw
	b.ne	.LBB9_52
	b	.LBB9_59
.LBB9_54:
	mov	x11, xzr
	mov	w12, #10
.LBB9_55:
	umulh	x14, x11, x12
	ldrb	w13, [x10], #1
	cmp	xzr, x14
	b.ne	.LBB9_75
	sub	w13, w13, #48
	cmp	w13, #10
	b.hs	.LBB9_82
	add	x11, x11, x11, lsl #2
	lsl	x11, x11, #1
	adds	x11, x11, w13, uxtw
	b.hs	.LBB9_76
	sub	x9, x9, #1
	cbnz	x9, .LBB9_55
.LBB9_59:
	movi	v0.2d, #0000000000000000
	and	x9, x8, #0xfffffffffffffff8
	add	x10, sp, #64
	add	x21, x10, x9
	str	x11, [sp, #56]
	and	x9, x21, #0x38
	cmp	x9, x8
	str	x9, [sp, #256]
	str	q0, [x23, #112]
	stp	q0, q0, [sp, #80]
	stp	q0, q0, [sp, #112]
	stp	q0, q0, [sp, #144]
	str	q0, [sp, #64]
	b.ne	.LBB9_80
.Ltmp13:
	bl	_RNvMNtCs68fcPop4ROg_3std4timeNtB2_7Instant3now
.Ltmp14:
	str	x0, [sp, #224]
	add	x8, sp, #256
	str	w1, [sp, #232]
	str	x21, [sp, #256]
	//APP
	//NO_APP
	ldrb	w2, [sp, #52]
	ldr	x0, [sp, #256]
	ldr	x1, [sp, #56]
	bl	_RNvCs73tWNsq4cWN_11stack_probe3run
	cmp	x0, #1
	stp	x0, x1, [sp, #240]
	b.ne	.LBB9_79
	cmp	x1, #2
	b.ne	.LBB9_79
.Ltmp17:
	add	x0, sp, #224
	bl	_RNvMNtCs68fcPop4ROg_3std4timeNtB2_7Instant7elapsed
.Ltmp18:
	mov	w8, #51712
	add	x10, sp, #40
	adrp	x11, :got:_RNvXsi_NtNtNtCshp6Wxz1DwXO_4core3fmt3num3impjNtB9_7Display3fmt
	movk	w8, #15258, lsl #16
	ldr	x11, [x11, :got_lo12:_RNvXsi_NtNtNtCshp6Wxz1DwXO_4core3fmt3num3impjNtB9_7Display3fmt]
	str	x10, [sp, #256]
	mul	x9, x0, x8
	adrp	x12, :got:_RNvXsg_NtCshp6Wxz1DwXO_4core3fmtbNtB5_7Display3fmt
	add	x10, sp, #52
	ldr	x12, [x12, :got_lo12:_RNvXsg_NtCshp6Wxz1DwXO_4core3fmtbNtB5_7Display3fmt]
	stp	x11, x10, [sp, #264]
	adrp	x10, :got:_RNvXsd_NtNtNtCshp6Wxz1DwXO_4core3fmt3num3impyNtB9_7Display3fmt
	umulh	x8, x0, x8
	add	x11, sp, #56
	str	x12, [sp, #280]
	ldr	x10, [x10, :got_lo12:_RNvXsd_NtNtNtCshp6Wxz1DwXO_4core3fmt3num3impyNtB9_7Display3fmt]
	adds	x9, x9, w1, uxtw
	stp	x11, x10, [sp, #288]
	add	x10, sp, #320
	str	x9, [sp, #320]
	adrp	x9, :got:_RNvXNtNtCshp6Wxz1DwXO_4core3fmt3numoNtB4_7Display3fmt
	cinc	x8, x8, hs
	ldr	x9, [x9, :got_lo12:_RNvXNtNtCshp6Wxz1DwXO_4core3fmt3numoNtB4_7Display3fmt]
	str	x8, [sp, #328]
	stp	x10, x9, [sp, #304]
.Ltmp19:
	adrp	x0, .Lalloc_b8073bcf24be9d205b024f683ad009d8
	add	x0, x0, :lo12:.Lalloc_b8073bcf24be9d205b024f683ad009d8
	add	x1, sp, #256
	bl	_RNvNtNtCs68fcPop4ROg_3std2io5stdio6__print
.Ltmp20:
	add	x21, x20, #8
	b	.LBB9_67
.LBB9_66:
	subs	x19, x19, #1
	add	x21, x21, #24
	b.eq	.LBB9_69
.LBB9_67:
	ldur	x1, [x21, #-8]
	cbz	x1, .LBB9_66
	ldr	x0, [x21]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB9_66
.LBB9_69:
	ldr	x8, [sp, #352]
	cbz	x8, .LBB9_71
	add	x8, x8, x8, lsl #1
	mov	x0, x20
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB9_71:
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
.LBB9_72:
	.cfi_restore_state
	sub	w8, w12, #48
	cmp	w8, #10
	mov	w8, #1
	cinc	w10, w8, lo
	b	.LBB9_74
.LBB9_73:
	mov	w10, #2
.LBB9_74:
	strb	w10, [sp, #64]
	adrp	x4, .Lalloc_9e12b251dfcfe36e07d52eb375d3474c
	add	x4, x4, :lo12:.Lalloc_9e12b251dfcfe36e07d52eb375d3474c
	b	.LBB9_78
.LBB9_75:
	sub	w8, w13, #48
	cmp	w8, #10
	mov	w8, #1
	cinc	w11, w8, lo
	b	.LBB9_77
.LBB9_76:
	mov	w11, #2
.LBB9_77:
	adrp	x4, .Lalloc_b5fe02085895564a3955bb0dc899e0b9
	add	x4, x4, :lo12:.Lalloc_b5fe02085895564a3955bb0dc899e0b9
	strb	w11, [sp, #64]
.LBB9_78:
	add	x2, sp, #64
.Ltmp9:
	adrp	x0, .Lalloc_00ae4b301f7fab8ac9617c03fcbd7274
	add	x0, x0, :lo12:.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274
	adrp	x3, .Lvtable.2
	add	x3, x3, :lo12:.Lvtable.2
	mov	w1, #43
	bl	_RNvNtCshp6Wxz1DwXO_4core6result13unwrap_failed
.Ltmp10:
	b	.LBB9_95
.LBB9_79:
.Ltmp15:
	add	x0, sp, #240
	bl	_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedTyyEBM_ECs73tWNsq4cWN_11stack_probe
.Ltmp16:
	b	.LBB9_95
.LBB9_80:
.Ltmp11:
	adrp	x5, .Lalloc_78e6432c4c42081f09a042aa7d91dbf7
	add	x5, x5, :lo12:.Lalloc_78e6432c4c42081f09a042aa7d91dbf7
	add	x1, sp, #256
	add	x2, sp, #40
	mov	w0, wzr
	mov	x3, xzr
	bl	_RINvNtCshp6Wxz1DwXO_4core9panicking13assert_failedjjEB4_
.Ltmp12:
	b	.LBB9_95
.LBB9_81:
	mov	w10, #1
	b	.LBB9_74
.LBB9_82:
	mov	w11, #1
	b	.LBB9_77
.LBB9_83:
	ldr	x8, [sp, #264]
	ldr	x9, [sp, #280]
	mov	w10, #8
	stp	xzr, x10, [sp, #352]
	subs	x9, x9, x8
	str	xzr, [sp, #368]
	b.ne	.LBB9_88
.LBB9_84:
	ldr	x8, [sp, #272]
	cbz	x8, .LBB9_86
	add	x8, x8, x8, lsl #1
	ldr	x0, [sp, #256]
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB9_86:
	mov	x19, xzr
.LBB9_87:
	adrp	x2, .Lalloc_f18dedefa328b38e6f2c3c48dffabd23
	add	x2, x2, :lo12:.Lalloc_f18dedefa328b38e6f2c3c48dffabd23
	mov	w0, #1
	b	.LBB9_94
.LBB9_88:
	mov	x10, #-6148914691236517206
	add	x20, x8, #8
	movk	x10, #43691
	umulh	x9, x9, x10
	lsr	x19, x9, #4
	b	.LBB9_90
.LBB9_89:
	subs	x19, x19, #1
	add	x20, x20, #24
	b.eq	.LBB9_84
.LBB9_90:
	ldur	x1, [x20, #-8]
	cbz	x1, .LBB9_89
	ldr	x0, [x20]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB9_89
.LBB9_92:
	adrp	x2, .Lalloc_673c2ecc855c5ae33303710f5ebb210a
	add	x2, x2, :lo12:.Lalloc_673c2ecc855c5ae33303710f5ebb210a
	mov	w0, #2
	b	.LBB9_94
.LBB9_93:
	adrp	x2, .Lalloc_db3a5b0ef68a6f25b323fba0399275ef
	add	x2, x2, :lo12:.Lalloc_db3a5b0ef68a6f25b323fba0399275ef
	mov	w0, #3
	mov	w19, #3
.LBB9_94:
.Ltmp24:
	mov	x1, x19
	bl	_RNvNtCshp6Wxz1DwXO_4core9panicking18panic_bounds_check
.Ltmp25:
.LBB9_95:
	brk	#0x1
.LBB9_96:
	mov	w10, wzr
	b	.LBB9_74
.LBB9_97:
	mov	w11, wzr
	b	.LBB9_77
.LBB9_98:
.Ltmp2:
	mov	x19, x0
	b	.LBB9_106
.LBB9_99:
.Ltmp8:
	mov	x19, x0
	cbz	x21, .LBB9_102
	mov	x0, x22
	mov	x1, x21
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB9_102
.LBB9_101:
.Ltmp5:
	mov	x19, x0
.LBB9_102:
	add	x0, sp, #64
	bl	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueNtNtCs68fcPop4ROg_3std3env4ArgsECs73tWNsq4cWN_11stack_probe
	add	x0, sp, #320
	bl	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECs73tWNsq4cWN_11stack_probe
	mov	x0, x19
	bl	_Unwind_Resume
.LBB9_103:
.Ltmp26:
	mov	x19, x0
	add	x0, sp, #352
	bl	_RINvNtCshp6Wxz1DwXO_4core3ptr9drop_glueINtNtCs6sh1iPzjxYC_5alloc3vec3VecNtNtBG_6string6StringEECs73tWNsq4cWN_11stack_probe
	mov	x0, x19
	bl	_Unwind_Resume
.LBB9_104:
.Ltmp23:
	mov	x19, x0
	cbz	x20, .LBB9_106
	mov	x0, x21
	mov	x1, x20
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
.LBB9_106:
	ldr	x8, [sp, #264]
	ldr	x9, [sp, #280]
	subs	x9, x9, x8
	b.ne	.LBB9_109
.LBB9_107:
	ldr	x8, [sp, #272]
	cbnz	x8, .LBB9_113
	mov	x0, x19
	bl	_Unwind_Resume
.LBB9_109:
	mov	x10, #-6148914691236517206
	add	x21, x8, #8
	movk	x10, #43691
	umulh	x9, x9, x10
	lsr	x20, x9, #4
	b	.LBB9_111
.LBB9_110:
	subs	x20, x20, #1
	add	x21, x21, #24
	b.eq	.LBB9_107
.LBB9_111:
	ldur	x1, [x21, #-8]
	cbz	x1, .LBB9_110
	ldr	x0, [x21]
	mov	w2, #1
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	b	.LBB9_110
.LBB9_113:
	add	x8, x8, x8, lsl #1
	ldr	x0, [sp, #256]
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc
	mov	x0, x19
	bl	_Unwind_Resume
.Lfunc_end9:
	.size	_RNvCs73tWNsq4cWN_11stack_probe4main, .Lfunc_end9-_RNvCs73tWNsq4cWN_11stack_probe4main
	.cfi_endproc
	.section	.gcc_except_table._RNvCs73tWNsq4cWN_11stack_probe4main,"a",@progbits
	.p2align	2, 0x0
GCC_except_table9:
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
	.uleb128 .Ltmp21-.Lfunc_begin0
	.uleb128 .Ltmp22-.Ltmp21
	.uleb128 .Ltmp23-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp3-.Lfunc_begin0
	.uleb128 .Ltmp4-.Ltmp3
	.uleb128 .Ltmp5-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp6-.Lfunc_begin0
	.uleb128 .Ltmp7-.Ltmp6
	.uleb128 .Ltmp8-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp13-.Lfunc_begin0
	.uleb128 .Ltmp25-.Ltmp13
	.uleb128 .Ltmp26-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp25-.Lfunc_begin0
	.uleb128 .Lfunc_end9-.Ltmp25
	.byte	0
	.byte	0
.Lcst_end0:
	.p2align	2, 0x0

	.section	.text.unlikely._RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.p2align	2
	.type	_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs73tWNsq4cWN_11stack_probe,@function
_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs73tWNsq4cWN_11stack_probe:
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
	.size	_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs73tWNsq4cWN_11stack_probe, .Lfunc_end10-_RNvMs5_NtCs6sh1iPzjxYC_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.p2align	2
	.type	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe,@function
_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe:
	.cfi_startproc
	ldr	x8, [x0]
	adrp	x9, .Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe
	add	x9, x9, :lo12:.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe
	mov	x0, x1
	ldrb	w8, [x8]
	ldrb	w2, [x9, x8]
	adrp	x9, .Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel
	add	x9, x9, :lo12:.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel
	ldrsw	x8, [x9, x8, lsl #2]
	add	x1, x9, x8
	b	_RNvMsa_NtCshp6Wxz1DwXO_4core3fmtNtB5_9Formatter9write_str
.Lfunc_end11:
	.size	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe, .Lfunc_end11-_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRTyyENtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.p2align	2
	.type	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRTyyENtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe,@function
_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRTyyENtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe:
	.cfi_startproc
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	stp	x29, x30, [sp, #32]
	str	x19, [sp, #48]
	add	x29, sp, #32
	.cfi_def_cfa w29, 32
	.cfi_offset w19, -16
	.cfi_offset w30, -24
	.cfi_offset w29, -32
	ldr	x19, [x0]
	mov	x0, x1
	mov	x8, sp
	mov	w1, #1
	mov	x2, xzr
	bl	_RNvMsa_NtCshp6Wxz1DwXO_4core3fmtNtB5_9Formatter11debug_tuple
	stur	x19, [x29, #-8]
	add	x8, x19, #8
	adrp	x19, .Lvtable.3
	add	x19, x19, :lo12:.Lvtable.3
	mov	x0, sp
	sub	x1, x29, #8
	mov	x2, x19
	str	x8, [x29, #24]
	bl	_RNvMs3_NtNtCshp6Wxz1DwXO_4core3fmt8buildersNtB5_10DebugTuple5field
	mov	x0, sp
	add	x1, x29, #24
	mov	x2, x19
	bl	_RNvMs3_NtNtCshp6Wxz1DwXO_4core3fmt8buildersNtB5_10DebugTuple5field
	mov	x0, sp
	bl	_RNvMs3_NtNtCshp6Wxz1DwXO_4core3fmt8buildersNtB5_10DebugTuple6finish
	.cfi_def_cfa wsp, 64
	ldp	x29, x30, [sp, #32]
	ldr	x19, [sp, #48]
	add	sp, sp, #64
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end12:
	.size	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRTyyENtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe, .Lfunc_end12-_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRTyyENtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRyNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.p2align	2
	.type	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRyNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe,@function
_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRyNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe:
	.cfi_startproc
	ldr	w8, [x1, #16]
	ldr	x0, [x0]
	tbnz	w8, #25, .LBB13_3
	tbnz	w8, #26, .LBB13_4
	b	_RNvXsd_NtNtNtCshp6Wxz1DwXO_4core3fmt3num3impyNtB9_7Display3fmt
.LBB13_3:
	b	_RNvXsC_NtNtCshp6Wxz1DwXO_4core3fmt3numyNtB7_8LowerHex3fmt
.LBB13_4:
	b	_RNvXsE_NtNtCshp6Wxz1DwXO_4core3fmt3numyNtB7_8UpperHex3fmt
.Lfunc_end13:
	.size	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRyNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe, .Lfunc_end13-_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRyNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe
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
.Lfunc_end14:
	.size	_RNvXsd_NtNtCshp6Wxz1DwXO_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt, .Lfunc_end14-_RNvXsd_NtNtCshp6Wxz1DwXO_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
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
	adrp	x8, _RNvCs73tWNsq4cWN_11stack_probe4main
	add	x8, x8, :lo12:_RNvCs73tWNsq4cWN_11stack_probe4main
	adrp	x1, .Lvtable.0
	add	x1, x1, :lo12:.Lvtable.0
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
	.xword	_RNSNvYNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0INtNtNtCshp6Wxz1DwXO_4core3ops8function6FnOnceuE9call_once6vtableCs73tWNsq4cWN_11stack_probe
	.xword	_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Cs73tWNsq4cWN_11stack_probe
	.xword	_RNCINvNtCs68fcPop4ROg_3std2rt10lang_startuE0Cs73tWNsq4cWN_11stack_probe
	.size	.Lvtable.0, 48

	.type	.Lvtable.1,@object
	.section	.data.rel.ro..Lvtable.1,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.1:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.xword	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRTyyENtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe
	.size	.Lvtable.1, 32

	.type	.Lalloc_3f6d15f7c0f0226e8853a8abddaba251,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_3f6d15f7c0f0226e8853a8abddaba251:
	.asciz	"/tmp/contains-bad-simd-20261105/stack-probe.rs"
	.size	.Lalloc_3f6d15f7c0f0226e8853a8abddaba251, 47

	.type	.Lalloc_f18dedefa328b38e6f2c3c48dffabd23,@object
	.section	.data.rel.ro..Lalloc_f18dedefa328b38e6f2c3c48dffabd23,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_f18dedefa328b38e6f2c3c48dffabd23:
	.xword	.Lalloc_3f6d15f7c0f0226e8853a8abddaba251
	.asciz	".\000\000\000\000\000\000\000\007\000\000\000H\000\000"
	.size	.Lalloc_f18dedefa328b38e6f2c3c48dffabd23, 24

	.type	.Lalloc_9e12b251dfcfe36e07d52eb375d3474c,@object
	.section	.data.rel.ro..Lalloc_9e12b251dfcfe36e07d52eb375d3474c,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_9e12b251dfcfe36e07d52eb375d3474c:
	.xword	.Lalloc_3f6d15f7c0f0226e8853a8abddaba251
	.asciz	".\000\000\000\000\000\000\000\007\000\000\000T\000\000"
	.size	.Lalloc_9e12b251dfcfe36e07d52eb375d3474c, 24

	.type	.Lalloc_673c2ecc855c5ae33303710f5ebb210a,@object
	.section	.data.rel.ro..Lalloc_673c2ecc855c5ae33303710f5ebb210a,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_673c2ecc855c5ae33303710f5ebb210a:
	.xword	.Lalloc_3f6d15f7c0f0226e8853a8abddaba251
	.asciz	".\000\000\000\000\000\000\000\007\000\000\000k\000\000"
	.size	.Lalloc_673c2ecc855c5ae33303710f5ebb210a, 24

	.type	.Lalloc_db3a5b0ef68a6f25b323fba0399275ef,@object
	.section	.data.rel.ro..Lalloc_db3a5b0ef68a6f25b323fba0399275ef,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_db3a5b0ef68a6f25b323fba0399275ef:
	.xword	.Lalloc_3f6d15f7c0f0226e8853a8abddaba251
	.asciz	".\000\000\000\000\000\000\000\007\000\000\000\206\000\000"
	.size	.Lalloc_db3a5b0ef68a6f25b323fba0399275ef, 24

	.type	.Lalloc_b5fe02085895564a3955bb0dc899e0b9,@object
	.section	.data.rel.ro..Lalloc_b5fe02085895564a3955bb0dc899e0b9,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_b5fe02085895564a3955bb0dc899e0b9:
	.xword	.Lalloc_3f6d15f7c0f0226e8853a8abddaba251
	.asciz	".\000\000\000\000\000\000\000\007\000\000\000\222\000\000"
	.size	.Lalloc_b5fe02085895564a3955bb0dc899e0b9, 24

	.type	.Lalloc_78e6432c4c42081f09a042aa7d91dbf7,@object
	.section	.data.rel.ro..Lalloc_78e6432c4c42081f09a042aa7d91dbf7,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_78e6432c4c42081f09a042aa7d91dbf7:
	.xword	.Lalloc_3f6d15f7c0f0226e8853a8abddaba251
	.asciz	".\000\000\000\000\000\000\000\007\000\000\000\334\000\000"
	.size	.Lalloc_78e6432c4c42081f09a042aa7d91dbf7, 24

	.type	.Lalloc_011d402fc2fd12f79ff2bc7691f0df1d,@object
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	3, 0x0
.Lalloc_011d402fc2fd12f79ff2bc7691f0df1d:
	.asciz	"\001\000\000\000\000\000\000\000\002\000\000\000\000\000\000"
	.size	.Lalloc_011d402fc2fd12f79ff2bc7691f0df1d, 16

	.type	.Lalloc_7bcbc173a0f42afa1c2057178d25fe54,@object
	.section	.data.rel.ro..Lalloc_7bcbc173a0f42afa1c2057178d25fe54,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_7bcbc173a0f42afa1c2057178d25fe54:
	.xword	.Lalloc_3f6d15f7c0f0226e8853a8abddaba251
	.asciz	".\000\000\000\000\000\000\000\007\000\000\000E\001\000"
	.size	.Lalloc_7bcbc173a0f42afa1c2057178d25fe54, 24

	.type	.Lalloc_b8073bcf24be9d205b024f683ad009d8,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_b8073bcf24be9d205b024f683ad009d8:
	.asciz	"\n{\"offset\":\300\t,\"split\":\300\b,\"reps\":\300\016,\"elapsed_ns\":\300\002}\n"
	.size	.Lalloc_b8073bcf24be9d205b024f683ad009d8, 53

	.type	.Lvtable.2,@object
	.section	.data.rel.ro..Lvtable.2,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.2:
	.asciz	"\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\001\000\000\000\000\000\000"
	.xword	_RNvXsd_NtNtCshp6Wxz1DwXO_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
	.size	.Lvtable.2, 32

	.type	.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274,@object
	.section	.rodata..Lalloc_00ae4b301f7fab8ac9617c03fcbd7274,"a",@progbits
.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274:
	.ascii	"called `Result::unwrap()` on an `Err` value"
	.size	.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274, 43

	.type	.Lvtable.3,@object
	.section	.data.rel.ro..Lvtable.3,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.3:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.xword	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRyNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe
	.size	.Lvtable.3, 32

	.type	.Lvtable.4,@object
	.section	.data.rel.ro..Lvtable.4,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.4:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.xword	_RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe
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

	.type	.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe,"a",@progbits
	.p2align	3, 0x0
.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe:
	.ascii	"\005\f\013\013\004\016"
	.size	.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe, 6

	.type	.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel,"a",@progbits
	.p2align	2, 0x0
.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel:
	.word	.Lalloc_59ba7b9f7211443cd55a366616eef46a-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel
	.word	.Lalloc_00315c78e51d29fe6b3102a4c1ecf6ef-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel
	.word	.Lalloc_bd3a3f3879e0d5f64554753e977f58d4-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel
	.word	.Lalloc_0964bb2a4870637395c77a018495bd5c-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel
	.word	.Lalloc_6566120a3a17f930e960a0863fcbd591-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel
	.word	.Lalloc_6c17bac0c71cba42380f8445f4dcbd16-.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel
	.size	.Lswitch.table._RNvXs1g_NtCshp6Wxz1DwXO_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel, 24

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
