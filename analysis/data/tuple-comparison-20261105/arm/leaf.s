	.file	"leaf.9071ff1952c27ea-cgu.0"
	.section	.text._RINvNtCs5eKY5gNNvwM_4core3ptr9drop_glueINtNtCshDmNPlWY1OA_5alloc3vec3VecNtNtBG_6string6StringEECsM3pabHJvao_4leaf,"ax",@progbits
	.p2align	2
	.type	_RINvNtCs5eKY5gNNvwM_4core3ptr9drop_glueINtNtCshDmNPlWY1OA_5alloc3vec3VecNtNtBG_6string6StringEECsM3pabHJvao_4leaf,@function
_RINvNtCs5eKY5gNNvwM_4core3ptr9drop_glueINtNtCshDmNPlWY1OA_5alloc3vec3VecNtNtBG_6string6StringEECsM3pabHJvao_4leaf:
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
	cbz	x21, .LBB0_5
	add	x22, x19, #8
	b	.LBB0_3
.LBB0_2:
	subs	x21, x21, #1
	add	x22, x22, #24
	b.eq	.LBB0_5
.LBB0_3:
	ldur	x1, [x22, #-8]
	cbz	x1, .LBB0_2
	ldr	x0, [x22]
	mov	w2, #1
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
	b	.LBB0_2
.LBB0_5:
	ldr	x8, [x20]
	cbz	x8, .LBB0_7
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
	b	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
.LBB0_7:
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
.Lfunc_end0:
	.size	_RINvNtCs5eKY5gNNvwM_4core3ptr9drop_glueINtNtCshDmNPlWY1OA_5alloc3vec3VecNtNtBG_6string6StringEECsM3pabHJvao_4leaf, .Lfunc_end0-_RINvNtCs5eKY5gNNvwM_4core3ptr9drop_glueINtNtCshDmNPlWY1OA_5alloc3vec3VecNtNtBG_6string6StringEECsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text._RINvNtCs5eKY5gNNvwM_4core3ptr9drop_glueNtNtCs60nHaxeZLXj_3std3env4ArgsECsM3pabHJvao_4leaf,"ax",@progbits
	.p2align	2
	.type	_RINvNtCs5eKY5gNNvwM_4core3ptr9drop_glueNtNtCs60nHaxeZLXj_3std3env4ArgsECsM3pabHJvao_4leaf,@function
_RINvNtCs5eKY5gNNvwM_4core3ptr9drop_glueNtNtCs60nHaxeZLXj_3std3env4ArgsECsM3pabHJvao_4leaf:
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
	b.eq	.LBB1_5
	mov	x10, #-6148914691236517206
	add	x21, x8, #8
	movk	x10, #43691
	umulh	x9, x9, x10
	lsr	x20, x9, #4
	b	.LBB1_3
.LBB1_2:
	subs	x20, x20, #1
	add	x21, x21, #24
	b.eq	.LBB1_5
.LBB1_3:
	ldur	x1, [x21, #-8]
	cbz	x1, .LBB1_2
	ldr	x0, [x21]
	mov	w2, #1
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
	b	.LBB1_2
.LBB1_5:
	ldr	x8, [x19, #16]
	cbz	x8, .LBB1_7
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
	b	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
.LBB1_7:
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
.Lfunc_end1:
	.size	_RINvNtCs5eKY5gNNvwM_4core3ptr9drop_glueNtNtCs60nHaxeZLXj_3std3env4ArgsECsM3pabHJvao_4leaf, .Lfunc_end1-_RINvNtCs5eKY5gNNvwM_4core3ptr9drop_glueNtNtCs60nHaxeZLXj_3std3env4ArgsECsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text.unlikely._RINvNtCs5eKY5gNNvwM_4core6result13unwrap_failedNtNtNtB4_3num5error13ParseIntErrorECsM3pabHJvao_4leaf,"ax",@progbits
	.p2align	2
	.type	_RINvNtCs5eKY5gNNvwM_4core6result13unwrap_failedNtNtNtB4_3num5error13ParseIntErrorECsM3pabHJvao_4leaf,@function
_RINvNtCs5eKY5gNNvwM_4core6result13unwrap_failedNtNtNtB4_3num5error13ParseIntErrorECsM3pabHJvao_4leaf:
	.cfi_startproc
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	sturb	w0, [x29, #-4]
	adrp	x0, .Lalloc_00ae4b301f7fab8ac9617c03fcbd7274
	add	x0, x0, :lo12:.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274
	adrp	x3, .Lvtable.0
	add	x3, x3, :lo12:.Lvtable.0
	adrp	x4, .Lalloc_05c202032256fef92c612b00fee0bc15
	add	x4, x4, :lo12:.Lalloc_05c202032256fef92c612b00fee0bc15
	sub	x2, x29, #4
	mov	w1, #43
	bl	_RNvNvNtCs5eKY5gNNvwM_4core6result13unwrap_failed19unwrap_failed_inner
.Lfunc_end2:
	.size	_RINvNtCs5eKY5gNNvwM_4core6result13unwrap_failedNtNtNtB4_3num5error13ParseIntErrorECsM3pabHJvao_4leaf, .Lfunc_end2-_RINvNtCs5eKY5gNNvwM_4core6result13unwrap_failedNtNtNtB4_3num5error13ParseIntErrorECsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text._RINvNtCs60nHaxeZLXj_3std2rt10lang_startuECsM3pabHJvao_4leaf,"ax",@progbits
	.hidden	_RINvNtCs60nHaxeZLXj_3std2rt10lang_startuECsM3pabHJvao_4leaf
	.globl	_RINvNtCs60nHaxeZLXj_3std2rt10lang_startuECsM3pabHJvao_4leaf
	.p2align	2
	.type	_RINvNtCs60nHaxeZLXj_3std2rt10lang_startuECsM3pabHJvao_4leaf,@function
_RINvNtCs60nHaxeZLXj_3std2rt10lang_startuECsM3pabHJvao_4leaf:
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
	bl	_RNvNtCs60nHaxeZLXj_3std2rt19lang_start_internal
	.cfi_def_cfa wsp, 32
	ldp	x29, x30, [sp, #16]
	add	sp, sp, #32
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end3:
	.size	_RINvNtCs60nHaxeZLXj_3std2rt10lang_startuECsM3pabHJvao_4leaf, .Lfunc_end3-_RINvNtCs60nHaxeZLXj_3std2rt10lang_startuECsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text._RINvNtNtCs60nHaxeZLXj_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsM3pabHJvao_4leaf,"ax",@progbits
	.p2align	2
	.type	_RINvNtNtCs60nHaxeZLXj_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsM3pabHJvao_4leaf,@function
_RINvNtNtCs60nHaxeZLXj_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsM3pabHJvao_4leaf:
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
	.size	_RINvNtNtCs60nHaxeZLXj_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsM3pabHJvao_4leaf, .Lfunc_end4-_RINvNtNtCs60nHaxeZLXj_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text.unlikely._RINvNvMs5_NtCshDmNPlWY1OA_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsM3pabHJvao_4leaf,"ax",@progbits
	.p2align	2
	.type	_RINvNvMs5_NtCshDmNPlWY1OA_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsM3pabHJvao_4leaf,@function
_RINvNvMs5_NtCshDmNPlWY1OA_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsM3pabHJvao_4leaf:
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
	cmp	x9, x8
	csel	x8, x9, x8, hi
	mov	w9, #4
	cmp	x8, #4
	csel	x20, x8, x9, hi
	mov	x3, x20
	bl	_RNvMs8_NtCshDmNPlWY1OA_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsM3pabHJvao_4leaf
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
	bl	_RNvNtCshDmNPlWY1OA_5alloc7raw_vec12handle_error
.LBB5_4:
	ldp	x0, x1, [sp, #16]
	bl	_RNvNtCshDmNPlWY1OA_5alloc7raw_vec12handle_error
.Lfunc_end5:
	.size	_RINvNvMs5_NtCshDmNPlWY1OA_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsM3pabHJvao_4leaf, .Lfunc_end5-_RINvNvMs5_NtCshDmNPlWY1OA_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text._RNCINvNtCs60nHaxeZLXj_3std2rt10lang_startuE0CsM3pabHJvao_4leaf,"ax",@progbits
	.p2align	2
	.type	_RNCINvNtCs60nHaxeZLXj_3std2rt10lang_startuE0CsM3pabHJvao_4leaf,@function
_RNCINvNtCs60nHaxeZLXj_3std2rt10lang_startuE0CsM3pabHJvao_4leaf:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x0, [x0]
	bl	_RINvNtNtCs60nHaxeZLXj_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsM3pabHJvao_4leaf
	mov	w0, wzr
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end6:
	.size	_RNCINvNtCs60nHaxeZLXj_3std2rt10lang_startuE0CsM3pabHJvao_4leaf, .Lfunc_end6-_RNCINvNtCs60nHaxeZLXj_3std2rt10lang_startuE0CsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text._RNSNvYNCINvNtCs60nHaxeZLXj_3std2rt10lang_startuE0INtNtNtCs5eKY5gNNvwM_4core3ops8function6FnOnceuE9call_once6vtableCsM3pabHJvao_4leaf,"ax",@progbits
	.p2align	2
	.type	_RNSNvYNCINvNtCs60nHaxeZLXj_3std2rt10lang_startuE0INtNtNtCs5eKY5gNNvwM_4core3ops8function6FnOnceuE9call_once6vtableCsM3pabHJvao_4leaf,@function
_RNSNvYNCINvNtCs60nHaxeZLXj_3std2rt10lang_startuE0INtNtNtCs5eKY5gNNvwM_4core3ops8function6FnOnceuE9call_once6vtableCsM3pabHJvao_4leaf:
	.cfi_startproc
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldr	x0, [x0]
	bl	_RINvNtNtCs60nHaxeZLXj_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsM3pabHJvao_4leaf
	mov	w0, wzr
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end7:
	.size	_RNSNvYNCINvNtCs60nHaxeZLXj_3std2rt10lang_startuE0INtNtNtCs5eKY5gNNvwM_4core3ops8function6FnOnceuE9call_once6vtableCsM3pabHJvao_4leaf, .Lfunc_end7-_RNSNvYNCINvNtCs60nHaxeZLXj_3std2rt10lang_startuE0INtNtNtCs5eKY5gNNvwM_4core3ops8function6FnOnceuE9call_once6vtableCsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI8_0:
	.xword	27
	.xword	123
.LCPI8_1:
	.xword	27
	.xword	456
	.section	.text._RNvCsM3pabHJvao_4leaf4main,"ax",@progbits
	.hidden	_RNvCsM3pabHJvao_4leaf4main
	.globl	_RNvCsM3pabHJvao_4leaf4main
	.p2align	2
	.type	_RNvCsM3pabHJvao_4leaf4main,@function
_RNvCsM3pabHJvao_4leaf4main:
.Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 156, DW.ref._RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality
	.cfi_lsda 28, .Lexception0
	sub	sp, sp, #256
	.cfi_def_cfa_offset 256
	stp	x29, x30, [sp, #176]
	stp	x26, x25, [sp, #192]
	stp	x24, x23, [sp, #208]
	stp	x22, x21, [sp, #224]
	stp	x20, x19, [sp, #240]
	add	x29, sp, #176
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
	add	x8, sp, #24
	bl	_RNvNtCs60nHaxeZLXj_3std3env4args
.Ltmp0:
	sub	x8, x29, #64
	add	x0, sp, #24
	bl	_RNvXse_NtCs60nHaxeZLXj_3std3envNtB5_4ArgsNtNtNtNtCs5eKY5gNNvwM_4core4iter6traits8iterator8Iterator4next
.Ltmp1:
	ldur	x20, [x29, #-64]
	cmn	x20, #1
	b.eq	.LBB8_63
	ldr	x8, [sp, #32]
	ldr	x9, [sp, #48]
	mov	x10, #-6148914691236517206
	movk	x10, #43691
	ldur	x21, [x29, #-56]
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
	b.ls	.LBB8_5
	mov	x23, xzr
.LBB8_4:
.Ltmp20:
	mov	x0, x23
	mov	x1, x22
	bl	_RNvNtCshDmNPlWY1OA_5alloc7raw_vec12handle_error
.Ltmp21:
	b	.LBB8_68
.LBB8_5:
	ldur	x25, [x29, #-48]
	cbz	x22, .LBB8_8
	bl	_RNvCsbOwsw4zHH1Z_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	x0, x22
	mov	w1, #8
	mov	w23, #8
	bl	_RNvCsbOwsw4zHH1Z_7___rustc12___rust_alloc
	cbz	x0, .LBB8_4
	mov	x19, x0
	b	.LBB8_9
.LBB8_8:
	mov	x24, xzr
	mov	w19, #8
.LBB8_9:
	stp	x20, x21, [x19]
	mov	x23, xzr
	mov	w20, #1
	str	x25, [x19, #16]
	ldur	q0, [sp, #24]
	mov	x25, #1
	stp	x24, x19, [sp, #80]
	ldur	q1, [sp, #40]
	mov	x24, #-6148914691236517206
	movk	x24, #43691
	str	x20, [sp, #96]
	stp	q0, q1, [x29, #-64]
	b	.LBB8_12
.LBB8_10:
	ldr	x19, [sp, #88]
.LBB8_11:
	add	x8, x19, x23
	add	x20, x20, #1
	add	x23, x23, #24
	stp	x21, x22, [x8, #24]
	str	x26, [x8, #40]
	str	x20, [sp, #96]
.LBB8_12:
.Ltmp3:
	sub	x8, x29, #24
	sub	x0, x29, #64
	bl	_RNvXse_NtCs60nHaxeZLXj_3std3envNtB5_4ArgsNtNtNtNtCs5eKY5gNNvwM_4core4iter6traits8iterator8Iterator4next
.Ltmp4:
	ldur	x21, [x29, #-24]
	cmn	x21, #1
	b.eq	.LBB8_16
	ldr	x8, [sp, #80]
	ldp	x22, x26, [x29, #-16]
	cmp	x20, x8
	b.ne	.LBB8_11
	ldur	x8, [x29, #-40]
	ldur	x9, [x29, #-56]
	sub	x8, x8, x9
	lsr	x8, x8, #3
	madd	x2, x8, x24, x25
.Ltmp6:
	add	x0, sp, #80
	mov	x1, x20
	bl	_RINvNvMs5_NtCshDmNPlWY1OA_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsM3pabHJvao_4leaf
.Ltmp7:
	b	.LBB8_10
.LBB8_16:
	ldur	x8, [x29, #-56]
	ldur	x9, [x29, #-40]
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
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
	b	.LBB8_18
.LBB8_21:
	ldur	x8, [x29, #-48]
	cbz	x8, .LBB8_23
	add	x8, x8, x8, lsl #1
	ldur	x0, [x29, #-64]
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
.LBB8_23:
	ldr	x19, [sp, #96]
	ldr	q0, [sp, #80]
	cmp	x19, #3
	str	q0, [sp]
	str	x19, [sp, #16]
	b.lo	.LBB8_67
	ldr	x20, [sp, #8]
	ldp	x9, x8, [x20, #56]
	cmp	x8, #1
	b.eq	.LBB8_27
	cbz	x8, .LBB8_73
	ldrb	w10, [x9]
	b	.LBB8_29
.LBB8_27:
	ldrb	w10, [x9]
	mov	w0, #1
	cmp	w10, #43
	b.eq	.LBB8_61
	cmp	w10, #45
	b.eq	.LBB8_61
.LBB8_29:
	cmp	w10, #43
	cset	w10, eq
	cinc	x9, x9, eq
	sub	x8, x8, x10
	cmp	x8, #17
	b.hs	.LBB8_34
	mov	x10, xzr
	cbz	x8, .LBB8_39
	mov	w11, #10
.LBB8_32:
	ldrb	w12, [x9], #1
	sub	w12, w12, #48
	cmp	w12, #9
	b.hi	.LBB8_62
	mul	x10, x10, x11
	subs	x8, x8, #1
	add	x10, x10, w12, uxtw
	b.ne	.LBB8_32
	b	.LBB8_39
.LBB8_34:
	mov	x10, xzr
	mov	w11, #10
.LBB8_35:
	umulh	x13, x10, x11
	ldrb	w12, [x9], #1
	cmp	xzr, x13
	b.ne	.LBB8_59
	sub	w12, w12, #48
	cmp	w12, #10
	b.hs	.LBB8_62
	add	x10, x10, x10, lsl #2
	lsl	x10, x10, #1
	adds	x10, x10, w12, uxtw
	b.hs	.LBB8_60
	sub	x8, x8, #1
	cbnz	x8, .LBB8_35
.LBB8_39:
	adrp	x8, .LCPI8_0
	adrp	x9, .LCPI8_1
	str	x10, [sp, #56]
	ldr	q0, [x8, :lo12:.LCPI8_0]
	adrp	x8, .Lalloc_6bc448098e9286fddb6a1b0985fbb1c2
	add	x8, x8, :lo12:.Lalloc_6bc448098e9286fddb6a1b0985fbb1c2
	stur	x8, [x29, #-24]
	sub	x8, x29, #24
	stur	q0, [x29, #-16]
	ldr	q0, [x9, :lo12:.LCPI8_1]
	adrp	x9, .Lalloc_5ce47bf71e58a1df2fef3d4cd6838414
	add	x9, x9, :lo12:.Lalloc_5ce47bf71e58a1df2fef3d4cd6838414
	//APP
	//NO_APP
	add	x8, sp, #24
	str	x9, [sp, #24]
	stur	q0, [sp, #32]
	//APP
	//NO_APP
	ldp	x8, x9, [x20, #32]
	cmp	x9, #5
	b.eq	.LBB8_43
	cmp	x9, #8
	b.ne	.LBB8_44
	mov	x9, #29295
	ldr	x8, [x8]
	movk	x9, #26473, lsl #16
	movk	x9, #28265, lsl #32
	movk	x9, #27745, lsl #48
	cmp	x8, x9
	b.ne	.LBB8_44
	adrp	x21, leaf_original
	add	x21, x21, :lo12:leaf_original
	b	.LBB8_45
.LBB8_43:
	ldrb	w9, [x8, #4]
	ldr	w8, [x8]
	cmp	w9, #100
	mov	w9, #30054
	movk	w9, #25971, lsl #16
	ccmp	w8, w9, #0, eq
.LBB8_44:
	adrp	x21, leaf_fused
	add	x21, x21, :lo12:leaf_fused
.LBB8_45:
.Ltmp11:
	bl	_RNvMNtCs60nHaxeZLXj_3std4timeNtB2_7Instant3now
.Ltmp12:
	ldr	x8, [sp, #56]
	str	x0, [sp, #64]
	str	w1, [sp, #72]
	cbz	x8, .LBB8_50
	mov	x22, xzr
	sub	x23, x29, #64
.LBB8_48:
.Ltmp13:
	sub	x0, x29, #24
	add	x1, sp, #24
	blr	x21
.Ltmp14:
	stur	w0, [x29, #-64]
	add	x22, x22, #1
	//APP
	//NO_APP
	ldr	x8, [sp, #56]
	cmp	x22, x8
	b.lo	.LBB8_48
.LBB8_50:
.Ltmp16:
	add	x0, sp, #64
	bl	_RNvMNtCs60nHaxeZLXj_3std4timeNtB2_7Instant7elapsed
.Ltmp17:
	mov	w8, #51712
	adrp	x11, :got:_RNvXNtNtCs5eKY5gNNvwM_4core3fmt3numoNtB4_7Display3fmt
	add	x10, sp, #80
	movk	w8, #15258, lsl #16
	ldr	x11, [x11, :got_lo12:_RNvXNtNtCs5eKY5gNNvwM_4core3fmt3numoNtB4_7Display3fmt]
	mul	x9, x0, x8
	stp	x10, x11, [x29, #-64]
	add	x10, sp, #56
	umulh	x8, x0, x8
	adds	x9, x9, w1, uxtw
	str	x9, [sp, #80]
	adrp	x9, :got:_RNvXsi_NtNtNtCs5eKY5gNNvwM_4core3fmt3num3impjNtB9_7Display3fmt
	cinc	x8, x8, hs
	ldr	x9, [x9, :got_lo12:_RNvXsi_NtNtNtCs5eKY5gNNvwM_4core3fmt3num3impjNtB9_7Display3fmt]
	str	x8, [sp, #88]
	stp	x10, x9, [x29, #-48]
.Ltmp18:
	adrp	x0, .Lalloc_e2a59742fc8ed77e1d3dcda02e2eea96
	add	x0, x0, :lo12:.Lalloc_e2a59742fc8ed77e1d3dcda02e2eea96
	sub	x1, x29, #64
	bl	_RNvNtNtCs60nHaxeZLXj_3std2io5stdio6__print
.Ltmp19:
	add	x21, x20, #8
	b	.LBB8_54
.LBB8_53:
	subs	x19, x19, #1
	add	x21, x21, #24
	b.eq	.LBB8_56
.LBB8_54:
	ldur	x1, [x21, #-8]
	cbz	x1, .LBB8_53
	ldr	x0, [x21]
	mov	w2, #1
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
	b	.LBB8_53
.LBB8_56:
	ldr	x8, [sp]
	cbz	x8, .LBB8_58
	add	x8, x8, x8, lsl #1
	mov	x0, x20
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
.LBB8_58:
	.cfi_def_cfa wsp, 256
	ldp	x20, x19, [sp, #240]
	ldp	x22, x21, [sp, #224]
	ldp	x24, x23, [sp, #208]
	ldp	x26, x25, [sp, #192]
	ldp	x29, x30, [sp, #176]
	add	sp, sp, #256
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
.LBB8_59:
	.cfi_restore_state
	sub	w8, w12, #48
	cmp	w8, #10
	mov	w8, #1
	cinc	w0, w8, lo
	b	.LBB8_61
.LBB8_60:
	mov	w0, #2
.LBB8_61:
.Ltmp9:
	bl	_RINvNtCs5eKY5gNNvwM_4core6result13unwrap_failedNtNtNtB4_3num5error13ParseIntErrorECsM3pabHJvao_4leaf
.Ltmp10:
	b	.LBB8_68
.LBB8_62:
	mov	w0, #1
	b	.LBB8_61
.LBB8_63:
	ldr	x8, [sp, #32]
	ldr	x9, [sp, #48]
	mov	w10, #8
	stp	xzr, x10, [sp]
	subs	x9, x9, x8
	str	xzr, [sp, #16]
	b.ne	.LBB8_69
.LBB8_64:
	ldr	x8, [sp, #40]
	cbz	x8, .LBB8_66
	add	x8, x8, x8, lsl #1
	ldr	x0, [sp, #24]
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
.LBB8_66:
	mov	x19, xzr
.LBB8_67:
.Ltmp23:
	adrp	x2, .Lalloc_b3660d9ba06522ca6cd2ded3fcd4363c
	add	x2, x2, :lo12:.Lalloc_b3660d9ba06522ca6cd2ded3fcd4363c
	mov	w0, #2
	mov	x1, x19
	bl	_RNvNtCs5eKY5gNNvwM_4core9panicking18panic_bounds_check
.Ltmp24:
.LBB8_68:
	brk	#0x1
.LBB8_69:
	mov	x10, #-6148914691236517206
	add	x20, x8, #8
	movk	x10, #43691
	umulh	x9, x9, x10
	lsr	x19, x9, #4
	b	.LBB8_71
.LBB8_70:
	subs	x19, x19, #1
	add	x20, x20, #24
	b.eq	.LBB8_64
.LBB8_71:
	ldur	x1, [x20, #-8]
	cbz	x1, .LBB8_70
	ldr	x0, [x20]
	mov	w2, #1
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
	b	.LBB8_70
.LBB8_73:
	mov	w0, wzr
	b	.LBB8_61
.LBB8_74:
.Ltmp2:
	mov	x19, x0
	b	.LBB8_83
.LBB8_75:
.Ltmp8:
	mov	x19, x0
	cbz	x21, .LBB8_79
	mov	x0, x22
	mov	x1, x21
	mov	w2, #1
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
	b	.LBB8_79
.LBB8_77:
.Ltmp15:
	mov	x19, x0
	mov	x0, sp
	bl	_RINvNtCs5eKY5gNNvwM_4core3ptr9drop_glueINtNtCshDmNPlWY1OA_5alloc3vec3VecNtNtBG_6string6StringEECsM3pabHJvao_4leaf
	mov	x0, x19
	bl	_Unwind_Resume
.LBB8_78:
.Ltmp5:
	mov	x19, x0
.LBB8_79:
	sub	x0, x29, #64
	bl	_RINvNtCs5eKY5gNNvwM_4core3ptr9drop_glueNtNtCs60nHaxeZLXj_3std3env4ArgsECsM3pabHJvao_4leaf
	add	x0, sp, #80
	bl	_RINvNtCs5eKY5gNNvwM_4core3ptr9drop_glueINtNtCshDmNPlWY1OA_5alloc3vec3VecNtNtBG_6string6StringEECsM3pabHJvao_4leaf
	mov	x0, x19
	bl	_Unwind_Resume
.LBB8_80:
.Ltmp25:
	mov	x19, x0
	mov	x0, sp
	bl	_RINvNtCs5eKY5gNNvwM_4core3ptr9drop_glueINtNtCshDmNPlWY1OA_5alloc3vec3VecNtNtBG_6string6StringEECsM3pabHJvao_4leaf
	mov	x0, x19
	bl	_Unwind_Resume
.LBB8_81:
.Ltmp22:
	mov	x19, x0
	cbz	x20, .LBB8_83
	mov	x0, x21
	mov	x1, x20
	mov	w2, #1
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
.LBB8_83:
	ldr	x8, [sp, #32]
	ldr	x9, [sp, #48]
	subs	x9, x9, x8
	b.ne	.LBB8_86
.LBB8_84:
	ldr	x8, [sp, #40]
	cbnz	x8, .LBB8_90
	mov	x0, x19
	bl	_Unwind_Resume
.LBB8_86:
	mov	x10, #-6148914691236517206
	add	x21, x8, #8
	movk	x10, #43691
	umulh	x9, x9, x10
	lsr	x20, x9, #4
	b	.LBB8_88
.LBB8_87:
	subs	x20, x20, #1
	add	x21, x21, #24
	b.eq	.LBB8_84
.LBB8_88:
	ldur	x1, [x21, #-8]
	cbz	x1, .LBB8_87
	ldr	x0, [x21]
	mov	w2, #1
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
	b	.LBB8_87
.LBB8_90:
	add	x8, x8, x8, lsl #1
	ldr	x0, [sp, #24]
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
	mov	x0, x19
	bl	_Unwind_Resume
.Lfunc_end8:
	.size	_RNvCsM3pabHJvao_4leaf4main, .Lfunc_end8-_RNvCsM3pabHJvao_4leaf4main
	.cfi_endproc
	.section	.gcc_except_table._RNvCsM3pabHJvao_4leaf4main,"a",@progbits
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
	.uleb128 .Ltmp12-.Ltmp11
	.uleb128 .Ltmp25-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp13-.Lfunc_begin0
	.uleb128 .Ltmp14-.Ltmp13
	.uleb128 .Ltmp15-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp16-.Lfunc_begin0
	.uleb128 .Ltmp24-.Ltmp16
	.uleb128 .Ltmp25-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp24-.Lfunc_begin0
	.uleb128 .Lfunc_end8-.Ltmp24
	.byte	0
	.byte	0
.Lcst_end0:
	.p2align	2, 0x0

	.section	.text.unlikely._RNvMs8_NtCshDmNPlWY1OA_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsM3pabHJvao_4leaf,"ax",@progbits
	.p2align	2
	.type	_RNvMs8_NtCshDmNPlWY1OA_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsM3pabHJvao_4leaf,@function
_RNvMs8_NtCshDmNPlWY1OA_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsM3pabHJvao_4leaf:
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
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_realloc
	cbnz	x0, .LBB9_8
	b	.LBB9_6
.LBB9_4:
	cbz	x20, .LBB9_7
	bl	_RNvCsbOwsw4zHH1Z_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	x0, x20
	mov	w1, #8
	bl	_RNvCsbOwsw4zHH1Z_7___rustc12___rust_alloc
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
	.size	_RNvMs8_NtCshDmNPlWY1OA_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsM3pabHJvao_4leaf, .Lfunc_end9-_RNvMs8_NtCshDmNPlWY1OA_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf,"ax",@progbits
	.p2align	2
	.type	_RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf,@function
_RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf:
	.cfi_startproc
	ldr	x8, [x0]
	adrp	x9, .Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf
	add	x9, x9, :lo12:.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf
	mov	x0, x1
	ldrb	w8, [x8]
	ldrb	w2, [x9, x8]
	adrp	x9, .Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel
	add	x9, x9, :lo12:.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel
	ldrsw	x8, [x9, x8, lsl #2]
	add	x1, x9, x8
	b	_RNvMsa_NtCs5eKY5gNNvwM_4core3fmtNtB5_9Formatter9write_str
.Lfunc_end10:
	.size	_RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf, .Lfunc_end10-_RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text._RNvXsc_NtNtCs5eKY5gNNvwM_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt,"ax",@progbits
	.p2align	2
	.type	_RNvXsc_NtNtCs5eKY5gNNvwM_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt,@function
_RNvXsc_NtNtCs5eKY5gNNvwM_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt:
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
	bl	_RNvMsa_NtCs5eKY5gNNvwM_4core3fmtNtB5_9Formatter26debug_struct_field1_finish
	.cfi_def_cfa wsp, 32
	ldp	x29, x30, [sp, #16]
	add	sp, sp, #32
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end11:
	.size	_RNvXsc_NtNtCs5eKY5gNNvwM_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt, .Lfunc_end11-_RNvXsc_NtNtCs5eKY5gNNvwM_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
	.cfi_endproc

	.section	.text.leaf_fused,"ax",@progbits
	.globl	leaf_fused
	.p2align	2
	.type	leaf_fused,@function
leaf_fused:
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
	mov	x19, x1
	mov	x20, x0
	ldp	x1, x8, [x1]
	ldp	x0, x9, [x0]
	subs	x21, x9, x8
	csel	x2, x9, x8, lo
	bl	memcmp
	sxtw	x8, w0
	cmp	w0, #0
	csel	x9, x21, x8, eq
	cmp	x9, #0
	cset	w8, gt
	csinv	w8, w8, wzr, pl
	cbnz	x9, .LBB12_2
	ldr	x8, [x20, #16]
	ldr	x9, [x19, #16]
	cmp	x8, x9
	cset	w8, hi
	csinv	w8, w8, wzr, hs
.LBB12_2:
	sxtb	w9, w8
	mov	w10, #16777216
	mov	w11, #65536
	cmp	w9, #1
	bic	w9, w10, w9
	csel	w10, wzr, w11, lt
	mov	w11, #256
	orr	w9, w9, w10
	csel	w10, w11, wzr, lt
	orr	w0, w9, w10
	bfxil	w0, w8, #7, #1
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
.Lfunc_end12:
	.size	leaf_fused, .Lfunc_end12-leaf_fused
	.cfi_endproc

	.section	.text.leaf_original,"ax",@progbits
	.globl	leaf_original
	.p2align	2
	.type	leaf_original,@function
leaf_original:
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
	mov	x19, x1
	mov	x20, x0
	ldp	x1, x8, [x1]
	ldp	x0, x9, [x0]
	subs	x21, x9, x8
	csel	x2, x9, x8, lo
	bl	memcmp
	sxtw	x8, w0
	cmp	w0, #0
	ldr	x9, [x20, #16]
	ldr	x10, [x19, #16]
	csel	x8, x21, x8, eq
	cmp	x8, #1
	cset	w11, lt
	cmn	x8, #1
	cset	w12, gt
	cmp	x9, x10
	lsr	x9, x8, #63
	cset	w10, lo
	cset	w13, ls
	cset	w14, hi
	cset	w15, hs
	cmp	x8, #0
	csel	w8, w10, w9, eq
	csel	w9, w13, w11, eq
	cset	w10, gt
	csel	w11, w15, w12, eq
	csel	w10, w14, w10, eq
	cmp	w11, #0
	mov	w11, #16777216
	csel	w11, w11, wzr, ne
	cmp	w10, #0
	mov	w10, #65536
	csel	w10, w10, wzr, ne
	cmp	w9, #0
	mov	w9, #256
	csel	w9, w9, wzr, ne
	orr	w10, w11, w10
	orr	w8, w9, w8
	orr	w0, w10, w8
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
.Lfunc_end13:
	.size	leaf_original, .Lfunc_end13-leaf_original
	.cfi_endproc

	.section	.text.leaf_two,"ax",@progbits
	.globl	leaf_two
	.p2align	2
	.type	leaf_two,@function
leaf_two:
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
	mov	x19, x1
	mov	x20, x0
	ldp	x1, x8, [x1]
	ldp	x0, x9, [x0]
	subs	x21, x9, x8
	csel	x2, x9, x8, lo
	bl	memcmp
	ldr	x8, [x20, #16]
	sxtw	x9, w0
	ldr	x10, [x19, #16]
	cmp	w0, #0
	csel	x9, x21, x9, eq
	cmp	x8, x10
	cset	w8, lo
	cset	w10, hi
	cmp	x9, #0
	lsr	x9, x9, #63
	cset	w11, gt
	csel	w10, w10, w11, eq
	mov	w11, #256
	csel	w8, w8, w9, eq
	cmp	w10, #0
	mov	w9, #65536
	eor	w10, w8, #0x1
	csel	w9, w9, wzr, ne
	orr	w9, w9, w10, lsl #24
	csel	w10, wzr, w11, ne
	orr	w8, w10, w8
	orr	w0, w9, w8
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
.Lfunc_end14:
	.size	leaf_two, .Lfunc_end14-leaf_two
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
	adrp	x8, _RNvCsM3pabHJvao_4leaf4main
	add	x8, x8, :lo12:_RNvCsM3pabHJvao_4leaf4main
	adrp	x1, .Lvtable.1
	add	x1, x1, :lo12:.Lvtable.1
	add	x0, sp, #8
	mov	w4, wzr
	str	x8, [sp, #8]
	bl	_RNvNtCs60nHaxeZLXj_3std2rt19lang_start_internal
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
	.asciz	"\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\001\000\000\000\000\000\000"
	.xword	_RNvXsc_NtNtCs5eKY5gNNvwM_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
	.size	.Lvtable.0, 32

	.type	.Lvtable.1,@object
	.section	.data.rel.ro..Lvtable.1,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.1:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.xword	_RNSNvYNCINvNtCs60nHaxeZLXj_3std2rt10lang_startuE0INtNtNtCs5eKY5gNNvwM_4core3ops8function6FnOnceuE9call_once6vtableCsM3pabHJvao_4leaf
	.xword	_RNCINvNtCs60nHaxeZLXj_3std2rt10lang_startuE0CsM3pabHJvao_4leaf
	.xword	_RNCINvNtCs60nHaxeZLXj_3std2rt10lang_startuE0CsM3pabHJvao_4leaf
	.size	.Lvtable.1, 48

	.type	.Lalloc_1a68d4663d1c50d6d88d465b9d973c09,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_1a68d4663d1c50d6d88d465b9d973c09:
	.asciz	"/tmp/tuple-comparison-20261105/leaf.rs"
	.size	.Lalloc_1a68d4663d1c50d6d88d465b9d973c09, 39

	.type	.Lalloc_b3660d9ba06522ca6cd2ded3fcd4363c,@object
	.section	.data.rel.ro..Lalloc_b3660d9ba06522ca6cd2ded3fcd4363c,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_b3660d9ba06522ca6cd2ded3fcd4363c:
	.xword	.Lalloc_1a68d4663d1c50d6d88d465b9d973c09
	.asciz	"&\000\000\000\000\000\000\000\002\000\000\000C\000\000"
	.size	.Lalloc_b3660d9ba06522ca6cd2ded3fcd4363c, 24

	.type	.Lalloc_6bc448098e9286fddb6a1b0985fbb1c2,@object
	.section	.rodata..Lalloc_6bc448098e9286fddb6a1b0985fbb1c2,"a",@progbits
.Lalloc_6bc448098e9286fddb6a1b0985fbb1c2:
	.ascii	"core::iter::adapters::Chain"
	.size	.Lalloc_6bc448098e9286fddb6a1b0985fbb1c2, 27

	.type	.Lalloc_5ce47bf71e58a1df2fef3d4cd6838414,@object
	.section	.rodata..Lalloc_5ce47bf71e58a1df2fef3d4cd6838414,"a",@progbits
.Lalloc_5ce47bf71e58a1df2fef3d4cd6838414:
	.ascii	"core::iter::adapters::Clone"
	.size	.Lalloc_5ce47bf71e58a1df2fef3d4cd6838414, 27

	.type	.Lalloc_e2a59742fc8ed77e1d3dcda02e2eea96,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_e2a59742fc8ed77e1d3dcda02e2eea96:
	.asciz	"\016{\"elapsed_ns\":\300\b,\"reps\":\300\002}\n"
	.size	.Lalloc_e2a59742fc8ed77e1d3dcda02e2eea96, 30

	.type	.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274,@object
	.section	.rodata..Lalloc_00ae4b301f7fab8ac9617c03fcbd7274,"a",@progbits
.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274:
	.ascii	"called `Result::unwrap()` on an `Err` value"
	.size	.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274, 43

	.type	.Lalloc_05c202032256fef92c612b00fee0bc15,@object
	.section	.data.rel.ro..Lalloc_05c202032256fef92c612b00fee0bc15,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_05c202032256fef92c612b00fee0bc15:
	.xword	.Lalloc_1a68d4663d1c50d6d88d465b9d973c09
	.asciz	"&\000\000\000\000\000\000\000\002\000\000\000O\000\000"
	.size	.Lalloc_05c202032256fef92c612b00fee0bc15, 24

	.type	.Lvtable.2,@object
	.section	.data.rel.ro..Lvtable.2,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.2:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.xword	_RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf
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

	.type	.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf,"a",@progbits
	.p2align	3, 0x0
.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf:
	.ascii	"\005\f\013\013\004\016"
	.size	.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf, 6

	.type	.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel,"a",@progbits
	.p2align	2, 0x0
.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel:
	.word	.Lalloc_59ba7b9f7211443cd55a366616eef46a-.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel
	.word	.Lalloc_00315c78e51d29fe6b3102a4c1ecf6ef-.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel
	.word	.Lalloc_bd3a3f3879e0d5f64554753e977f58d4-.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel
	.word	.Lalloc_0964bb2a4870637395c77a018495bd5c-.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel
	.word	.Lalloc_6566120a3a17f930e960a0863fcbd591-.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel
	.word	.Lalloc_6c17bac0c71cba42380f8445f4dcbd16-.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel
	.size	.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel, 24

	.globl	leaf_once
	.type	leaf_once,@function
leaf_once = leaf_fused
	.hidden	DW.ref._RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality
	.weak	DW.ref._RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality
	.section	.data.DW.ref._RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality,"awG",@progbits,DW.ref._RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality,comdat
	.p2align	3, 0x0
	.type	DW.ref._RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality,@object
	.size	DW.ref._RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality, 8
DW.ref._RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality:
	.xword	_RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality
	.ident	"rustc version 1.101.0-dev"
	.section	".note.GNU-stack","",@progbits
