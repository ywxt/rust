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
	adrp	x4, .Lalloc_4bdb784eb229662729e2cb30c9370ef2
	add	x4, x4, :lo12:.Lalloc_4bdb784eb229662729e2cb30c9370ef2
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
	add	x8, sp, #8
	bl	_RNvNtCs60nHaxeZLXj_3std3env4args
.Ltmp0:
	add	x8, sp, #64
	add	x0, sp, #8
	bl	_RNvXse_NtCs60nHaxeZLXj_3std3envNtB5_4ArgsNtNtNtNtCs5eKY5gNNvwM_4core4iter6traits8iterator8Iterator4next
.Ltmp1:
	ldr	x20, [sp, #64]
	cmn	x20, #1
	b.eq	.LBB8_64
	ldr	x8, [sp, #16]
	ldr	x9, [sp, #32]
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
	b	.LBB8_75
.LBB8_5:
	ldr	x25, [sp, #80]
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
	ldur	q0, [sp, #8]
	mov	x25, #1
	stp	x24, x19, [sp, #40]
	ldur	q1, [sp, #24]
	mov	x24, #-6148914691236517206
	movk	x24, #43691
	str	x20, [sp, #56]
	stp	q0, q1, [sp, #64]
	b	.LBB8_12
.LBB8_10:
	ldr	x19, [sp, #48]
.LBB8_11:
	add	x8, x19, x23
	add	x20, x20, #1
	add	x23, x23, #24
	stp	x21, x22, [x8, #24]
	str	x26, [x8, #40]
	str	x20, [sp, #56]
.LBB8_12:
.Ltmp3:
	sub	x8, x29, #32
	add	x0, sp, #64
	bl	_RNvXse_NtCs60nHaxeZLXj_3std3envNtB5_4ArgsNtNtNtNtCs5eKY5gNNvwM_4core4iter6traits8iterator8Iterator4next
.Ltmp4:
	ldur	x21, [x29, #-32]
	cmn	x21, #1
	b.eq	.LBB8_16
	ldr	x8, [sp, #40]
	ldp	x22, x26, [x29, #-24]
	cmp	x20, x8
	b.ne	.LBB8_11
	ldr	x8, [sp, #88]
	ldr	x9, [sp, #72]
	sub	x8, x8, x9
	lsr	x8, x8, #3
	madd	x2, x8, x24, x25
.Ltmp6:
	add	x0, sp, #40
	mov	x1, x20
	bl	_RINvNvMs5_NtCshDmNPlWY1OA_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsM3pabHJvao_4leaf
.Ltmp7:
	b	.LBB8_10
.LBB8_16:
	ldr	x8, [sp, #72]
	ldr	x9, [sp, #88]
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
	ldr	x8, [sp, #80]
	cbz	x8, .LBB8_23
	add	x8, x8, x8, lsl #1
	ldr	x0, [sp, #64]
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
.LBB8_23:
	ldr	x19, [sp, #56]
	ldur	q0, [sp, #40]
	cmp	x19, #2
	stur	q0, [x29, #-32]
	stur	x19, [x29, #-16]
	b.lo	.LBB8_68
	ldur	x20, [x29, #-24]
	adrp	x22, fast
	add	x22, x22, :lo12:fast
	ldr	x8, [x20, #40]
	cmp	x8, #4
	b.ne	.LBB8_26
	ldr	x8, [x20, #32]
	mov	w9, #27763
	movk	w9, #30575, lsl #16
	ldr	w8, [x8]
	cmp	w8, w9
	adrp	x8, slow
	add	x8, x8, :lo12:slow
	csel	x22, x22, x8, ne
.LBB8_26:
	cmp	x19, #2
	b.eq	.LBB8_73
	ldp	x9, x8, [x20, #56]
	cmp	x8, #1
	b.eq	.LBB8_30
	cbz	x8, .LBB8_76
	ldrb	w10, [x9]
	b	.LBB8_32
.LBB8_30:
	ldrb	w10, [x9]
	mov	w0, #1
	cmp	w10, #43
	b.eq	.LBB8_59
	cmp	w10, #45
	b.eq	.LBB8_59
.LBB8_32:
	cmp	w10, #43
	cset	w10, eq
	cinc	x9, x9, eq
	sub	x8, x8, x10
	cmp	x8, #17
	b.hs	.LBB8_37
	mov	x23, xzr
	cbz	x8, .LBB8_42
	mov	w10, #10
.LBB8_35:
	ldrb	w11, [x9], #1
	sub	w11, w11, #48
	cmp	w11, #9
	b.hi	.LBB8_63
	mul	x12, x23, x10
	subs	x8, x8, #1
	add	x23, x12, w11, uxtw
	b.ne	.LBB8_35
	b	.LBB8_42
.LBB8_37:
	mov	x23, xzr
	mov	w10, #10
.LBB8_38:
	umulh	x12, x23, x10
	ldrb	w11, [x9], #1
	cmp	xzr, x12
	b.ne	.LBB8_57
	sub	w11, w11, #48
	cmp	w11, #10
	b.hs	.LBB8_63
	add	x12, x23, x23, lsl #2
	lsl	x12, x12, #1
	adds	x23, x12, w11, uxtw
	b.hs	.LBB8_58
	sub	x8, x8, #1
	cbnz	x8, .LBB8_38
.LBB8_42:
.Ltmp11:
	adrp	x0, .Lalloc_0f55ccc5796de6140dfafcec783eada4
	add	x0, x0, :lo12:.Lalloc_0f55ccc5796de6140dfafcec783eada4
	mov	w1, #4
	bl	slow
.Ltmp12:
	cmp	x0, #4
	str	x0, [sp, #64]
	b.ne	.LBB8_60
.Ltmp13:
	adrp	x21, .Lalloc_0f55ccc5796de6140dfafcec783eada4
	add	x21, x21, :lo12:.Lalloc_0f55ccc5796de6140dfafcec783eada4
	mov	w1, #4
	mov	x0, x21
	bl	fast
.Ltmp14:
	cmp	x0, #4
	str	x0, [sp, #64]
	b.ne	.LBB8_61
	cbz	x23, .LBB8_50
	mov	w24, #4
	add	x25, sp, #64
	add	x26, sp, #8
.LBB8_48:
	stp	x21, x24, [sp, #64]
	//APP
	//NO_APP
	ldp	x0, x1, [sp, #64]
.Ltmp17:
	blr	x22
.Ltmp18:
	str	x0, [sp, #8]
	subs	x23, x23, #1
	//APP
	//NO_APP
	b.ne	.LBB8_48
.LBB8_50:
	add	x21, x20, #8
	b	.LBB8_52
.LBB8_51:
	subs	x19, x19, #1
	add	x21, x21, #24
	b.eq	.LBB8_54
.LBB8_52:
	ldur	x1, [x21, #-8]
	cbz	x1, .LBB8_51
	ldr	x0, [x21]
	mov	w2, #1
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
	b	.LBB8_51
.LBB8_54:
	ldur	x8, [x29, #-32]
	cbz	x8, .LBB8_56
	add	x8, x8, x8, lsl #1
	mov	x0, x20
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
.LBB8_56:
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
.LBB8_57:
	.cfi_restore_state
	sub	w8, w11, #48
	cmp	w8, #10
	mov	w8, #1
	cinc	w0, w8, lo
	b	.LBB8_59
.LBB8_58:
	mov	w0, #2
.LBB8_59:
.Ltmp9:
	bl	_RINvNtCs5eKY5gNNvwM_4core6result13unwrap_failedNtNtNtB4_3num5error13ParseIntErrorECsM3pabHJvao_4leaf
.Ltmp10:
	b	.LBB8_75
.LBB8_60:
	adrp	x5, .Lalloc_4014284bd8c57ea959725918594e45ac
	add	x5, x5, :lo12:.Lalloc_4014284bd8c57ea959725918594e45ac
	b	.LBB8_62
.LBB8_61:
	adrp	x5, .Lalloc_b3b266528be359e4a0db3dc7da84a07e
	add	x5, x5, :lo12:.Lalloc_b3b266528be359e4a0db3dc7da84a07e
.LBB8_62:
	add	x1, sp, #64
.Ltmp15:
	adrp	x2, .Lalloc_ee2a3d99accaa3cec7cc99bf20f81916
	add	x2, x2, :lo12:.Lalloc_ee2a3d99accaa3cec7cc99bf20f81916
	mov	w0, wzr
	mov	x3, xzr
	bl	_RINvNtCs5eKY5gNNvwM_4core9panicking13assert_failedjjEB4_
.Ltmp16:
	b	.LBB8_75
.LBB8_63:
	mov	w0, #1
	b	.LBB8_59
.LBB8_64:
	ldr	x8, [sp, #16]
	ldr	x9, [sp, #32]
	mov	w10, #8
	stp	xzr, x10, [x29, #-32]
	subs	x9, x9, x8
	stur	xzr, [x29, #-16]
	b.ne	.LBB8_69
.LBB8_65:
	ldr	x8, [sp, #24]
	cbz	x8, .LBB8_67
	add	x8, x8, x8, lsl #1
	ldr	x0, [sp, #8]
	mov	w2, #8
	lsl	x1, x8, #3
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
.LBB8_67:
	mov	x19, xzr
.LBB8_68:
	adrp	x2, .Lalloc_0dd3479570b32f59538d76287f051d43
	add	x2, x2, :lo12:.Lalloc_0dd3479570b32f59538d76287f051d43
	mov	w0, #1
	b	.LBB8_74
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
	b.eq	.LBB8_65
.LBB8_71:
	ldur	x1, [x20, #-8]
	cbz	x1, .LBB8_70
	ldr	x0, [x20]
	mov	w2, #1
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
	b	.LBB8_70
.LBB8_73:
	adrp	x2, .Lalloc_5acfb0f90745456c7a1384ae2e47aa0d
	add	x2, x2, :lo12:.Lalloc_5acfb0f90745456c7a1384ae2e47aa0d
	mov	w0, #2
.LBB8_74:
.Ltmp23:
	mov	x1, x19
	bl	_RNvNtCs5eKY5gNNvwM_4core9panicking18panic_bounds_check
.Ltmp24:
.LBB8_75:
	brk	#0x1
.LBB8_76:
	mov	w0, wzr
	b	.LBB8_59
.LBB8_77:
.Ltmp2:
	mov	x19, x0
	b	.LBB8_86
.LBB8_78:
.Ltmp8:
	mov	x19, x0
	cbz	x21, .LBB8_82
	mov	x0, x22
	mov	x1, x21
	mov	w2, #1
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
	b	.LBB8_82
.LBB8_80:
.Ltmp19:
	mov	x19, x0
	sub	x0, x29, #32
	bl	_RINvNtCs5eKY5gNNvwM_4core3ptr9drop_glueINtNtCshDmNPlWY1OA_5alloc3vec3VecNtNtBG_6string6StringEECsM3pabHJvao_4leaf
	mov	x0, x19
	bl	_Unwind_Resume
.LBB8_81:
.Ltmp5:
	mov	x19, x0
.LBB8_82:
	add	x0, sp, #64
	bl	_RINvNtCs5eKY5gNNvwM_4core3ptr9drop_glueNtNtCs60nHaxeZLXj_3std3env4ArgsECsM3pabHJvao_4leaf
	add	x0, sp, #40
	bl	_RINvNtCs5eKY5gNNvwM_4core3ptr9drop_glueINtNtCshDmNPlWY1OA_5alloc3vec3VecNtNtBG_6string6StringEECsM3pabHJvao_4leaf
	mov	x0, x19
	bl	_Unwind_Resume
.LBB8_83:
.Ltmp25:
	mov	x19, x0
	sub	x0, x29, #32
	bl	_RINvNtCs5eKY5gNNvwM_4core3ptr9drop_glueINtNtCshDmNPlWY1OA_5alloc3vec3VecNtNtBG_6string6StringEECsM3pabHJvao_4leaf
	mov	x0, x19
	bl	_Unwind_Resume
.LBB8_84:
.Ltmp22:
	mov	x19, x0
	cbz	x20, .LBB8_86
	mov	x0, x21
	mov	x1, x20
	mov	w2, #1
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
.LBB8_86:
	ldr	x8, [sp, #16]
	ldr	x9, [sp, #32]
	subs	x9, x9, x8
	b.ne	.LBB8_89
.LBB8_87:
	ldr	x8, [sp, #24]
	cbnz	x8, .LBB8_93
	mov	x0, x19
	bl	_Unwind_Resume
.LBB8_89:
	mov	x10, #-6148914691236517206
	add	x21, x8, #8
	movk	x10, #43691
	umulh	x9, x9, x10
	lsr	x20, x9, #4
	b	.LBB8_91
.LBB8_90:
	subs	x20, x20, #1
	add	x21, x21, #24
	b.eq	.LBB8_87
.LBB8_91:
	ldur	x1, [x21, #-8]
	cbz	x1, .LBB8_90
	ldr	x0, [x21]
	mov	w2, #1
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc
	b	.LBB8_90
.LBB8_93:
	add	x8, x8, x8, lsl #1
	ldr	x0, [sp, #8]
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
	.uleb128 .Ltmp14-.Ltmp11
	.uleb128 .Ltmp25-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp17-.Lfunc_begin0
	.uleb128 .Ltmp18-.Ltmp17
	.uleb128 .Ltmp19-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp9-.Lfunc_begin0
	.uleb128 .Ltmp24-.Ltmp9
	.uleb128 .Ltmp25-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp24-.Lfunc_begin0
	.uleb128 .Lfunc_end8-.Ltmp24
	.byte	0
	.byte	0
.Lcst_end0:
	.p2align	2, 0x0

	.section	.text._RNvMNtNtCs5eKY5gNNvwM_4core4char7methodsc11is_assigned,"ax",@progbits
	.p2align	2
	.type	_RNvMNtNtCs5eKY5gNNvwM_4core4char7methodsc11is_assigned,@function
_RNvMNtNtCs5eKY5gNNvwM_4core4char7methodsc11is_assigned:
	.cfi_startproc
	cmp	w0, #888
	b.hs	.LBB9_2
	mov	w0, #1
	ret
.LBB9_2:
	mov	w8, #262142
	cmp	w0, w8
	b.hs	.LBB9_4
	stp	x29, x30, [sp, #-16]!
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data13cn_planes_0_311lookup_slow
	eor	w0, w0, #0x1
	.cfi_def_cfa wsp, 16
	ldp	x29, x30, [sp], #16
	.cfi_def_cfa_offset 0
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB9_4:
	sub	w9, w0, #240, lsl #12
	mov	w8, #65534
	sub	w10, w0, #224, lsl #12
	cmp	w9, w8
	mov	w9, #1
	movk	w9, #14, lsl #16
	ccmp	w0, w9, #4, hs
	sub	w9, w10, #256
	mov	w10, #240
	add	w11, w9, #224
	ccmp	w9, w10, #0, ne
	mov	w9, #96
	ccmp	w11, w9, #0, hs
	b.hs	.LBB9_6
	mov	w0, #1
	ret
.LBB9_6:
	sub	w9, w0, #256, lsl #12
	cmp	w9, w8
	cset	w0, lo
	ret
.Lfunc_end9:
	.size	_RNvMNtNtCs5eKY5gNNvwM_4core4char7methodsc11is_assigned, .Lfunc_end9-_RNvMNtNtCs5eKY5gNNvwM_4core4char7methodsc11is_assigned
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI10_0:
	.word	0
	.word	4294967169
	.word	4294909952
	.word	4293984256
.LCPI10_1:
	.word	32
	.word	33
	.word	6400
	.word	65534
	.section	.text._RNvMNtNtCs5eKY5gNNvwM_4core4char7methodsc16escape_debug_ext,"ax",@progbits
	.p2align	2
	.type	_RNvMNtNtCs5eKY5gNNvwM_4core4char7methodsc16escape_debug_ext,@function
_RNvMNtNtCs5eKY5gNNvwM_4core4char7methodsc16escape_debug_ext:
	.cfi_startproc
	cmp	w1, #12
	b.le	.LBB10_5
	cmp	w1, #38
	b.gt	.LBB10_9
	cmp	w1, #13
	b.eq	.LBB10_15
	cmp	w1, #34
	b.ne	.LBB10_13
	mov	w8, wzr
	mov	w9, #8796
	strh	w9, [x0]
	mov	w9, #2
	stur	xzr, [x0, #2]
	strb	w8, [x0, #12]
	strb	w9, [x0, #13]
	ret
.LBB10_5:
	cbz	w1, .LBB10_12
	cmp	w1, #9
	b.eq	.LBB10_17
	cmp	w1, #10
	b.ne	.LBB10_13
	mov	w8, wzr
	mov	w9, #28252
	strh	w9, [x0]
	mov	w9, #2
	stur	xzr, [x0, #2]
	strb	w8, [x0, #12]
	strb	w9, [x0, #13]
	ret
.LBB10_9:
	cmp	w1, #39
	b.eq	.LBB10_16
	cmp	w1, #92
	b.ne	.LBB10_13
	mov	w8, wzr
	mov	w9, #23644
	strh	w9, [x0]
	mov	w9, #2
	stur	xzr, [x0, #2]
	strb	w8, [x0, #12]
	strb	w9, [x0, #13]
	ret
.LBB10_12:
	mov	w8, wzr
	mov	w9, #12380
	strh	w9, [x0]
	mov	w9, #2
	stur	xzr, [x0, #2]
	strb	w8, [x0, #12]
	strb	w9, [x0, #13]
	ret
.LBB10_13:
	and	w8, w1, #0x1ffffe
	mov	w9, #65438
	sub	w10, w1, #32
	cmp	w8, w9
	mov	w8, #95
	ccmp	w10, w8, #0, ne
	b.hs	.LBB10_18
	str	w1, [x0]
	mov	w9, #129
	mov	w8, #128
	strb	w8, [x0, #12]
	strb	w9, [x0, #13]
	ret
.LBB10_15:
	mov	w8, wzr
	mov	w9, #29276
	strh	w9, [x0]
	mov	w9, #2
	stur	xzr, [x0, #2]
	strb	w8, [x0, #12]
	strb	w9, [x0, #13]
	ret
.LBB10_16:
	mov	w8, wzr
	mov	w9, #10076
	strh	w9, [x0]
	mov	w9, #2
	stur	xzr, [x0, #2]
	strb	w8, [x0, #12]
	strb	w9, [x0, #13]
	ret
.LBB10_17:
	mov	w8, wzr
	mov	w9, #29788
	strh	w9, [x0]
	mov	w9, #2
	stur	xzr, [x0, #2]
	strb	w8, [x0, #12]
	strb	w9, [x0, #13]
	ret
.LBB10_18:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #16]
	stp	x20, x19, [sp, #32]
	add	x29, sp, #16
	.cfi_def_cfa w29, 32
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w30, -24
	.cfi_offset w29, -32
	.cfi_remember_state
	dup	v0.4s, w1
	adrp	x8, .LCPI10_0
	ldr	q1, [x8, :lo12:.LCPI10_0]
	adrp	x8, .LCPI10_1
	add	v0.4s, v0.4s, v1.4s
	ldr	q1, [x8, :lo12:.LCPI10_1]
	cmhi	v0.4s, v1.4s, v0.4s
	addp	d0, v0.2d
	fmov	x8, d0
	cbnz	x8, .LBB10_24
	sub	w8, w1, #256, lsl #12
	mov	w9, #65534
	cmp	w8, w9
	mov	w8, #32
	ccmp	w1, w8, #4, hs
	b.eq	.LBB10_24
	cmp	w1, #133
	b.hs	.LBB10_23
.LBB10_21:
	mov	x19, x0
	mov	w0, w1
	mov	x20, x1
	bl	_RNvMNtNtCs5eKY5gNNvwM_4core4char7methodsc11is_assigned
	mov	x1, x20
	mov	w8, w0
	mov	x0, x19
	tbz	w8, #0, .LBB10_24
	mov	w9, #129
	mov	w8, #128
	str	w1, [x0]
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]
	ldp	x29, x30, [sp, #16]
	add	sp, sp, #48
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w30
	.cfi_restore w29
	strb	w8, [x0, #12]
	strb	w9, [x0, #13]
	ret
.LBB10_23:
	.cfi_restore_state
	.cfi_remember_state
	mov	x19, x0
	mov	w0, w1
	mov	x20, x1
	bl	_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data11white_space6lookup
	mov	x1, x20
	mov	w8, w0
	mov	x0, x19
	tbz	w8, #0, .LBB10_25
.LBB10_24:
	mov	w8, w1
	adrp	x11, .Lanon.ac0e6a0124ddfcc5e8e1efc76584fb4a.0
	add	x11, x11, :lo12:.Lanon.ac0e6a0124ddfcc5e8e1efc76584fb4a.0
	lsr	x10, x8, #20
	ubfx	x9, x1, #16, #4
	ubfx	x12, x1, #12, #4
	and	x8, x8, #0xf
	ubfx	x13, x1, #4, #4
	strb	wzr, [sp, #6]
	ldrb	w10, [x11, x10]
	ldrb	w9, [x11, x9]
	ldrb	w12, [x11, x12]
	strh	wzr, [sp, #4]
	strb	w10, [sp, #7]
	ubfx	x10, x1, #8, #4
	strb	w9, [sp, #8]
	orr	w9, w1, #0x1
	ldrb	w10, [x11, x10]
	clz	w9, w9
	strb	w12, [sp, #9]
	lsr	x9, x9, #2
	ldrb	w12, [x11, x13]
	strb	w10, [sp, #10]
	ldrb	w10, [x11, x8]
	mov	w11, #92
	sub	x8, x9, #2
	strb	w12, [sp, #11]
	strb	w10, [sp, #12]
	add	x10, sp, #4
	strb	w11, [x10, x8]
	add	x9, x10, x9
	mov	w10, #117
	sturb	w10, [x9, #-1]
	mov	w10, #123
	mov	w11, #125
	strb	w10, [x9]
	strb	w11, [sp, #13]
	ldur	x9, [sp, #4]
	ldrh	w10, [sp, #12]
	str	x9, [x0]
	mov	w9, #10
	strh	w10, [x0, #8]
	.cfi_def_cfa wsp, 48
	ldp	x20, x19, [sp, #32]
	ldp	x29, x30, [sp, #16]
	add	sp, sp, #48
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w30
	.cfi_restore w29
	strb	w8, [x0, #12]
	strb	w9, [x0, #13]
	ret
.LBB10_25:
	.cfi_restore_state
	cmp	w1, #768
	b.lo	.LBB10_27
	mov	w0, w1
	bl	_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data15grapheme_extend11lookup_slow
	mov	x1, x20
	mov	w8, w0
	mov	x0, x19
	tbnz	w8, #0, .LBB10_24
	b	.LBB10_28
.LBB10_27:
	cmp	w1, #173
	b.lo	.LBB10_21
.LBB10_28:
	mov	w0, w1
	bl	_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data28default_ignorable_code_point11lookup_slow
	mov	x1, x20
	mov	w8, w0
	mov	x0, x19
	tbnz	w8, #0, .LBB10_24
	mov	w0, w1
	bl	_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data2cf11lookup_slow
	mov	x1, x20
	mov	w8, w0
	mov	x0, x19
	tbz	w8, #0, .LBB10_21
	b	.LBB10_24
.Lfunc_end10:
	.size	_RNvMNtNtCs5eKY5gNNvwM_4core4char7methodsc16escape_debug_ext, .Lfunc_end10-_RNvMNtNtCs5eKY5gNNvwM_4core4char7methodsc16escape_debug_ext
	.cfi_endproc

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
	b.ls	.LBB11_2
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
.LBB11_2:
	.cfi_restore_state
	.cfi_remember_state
	add	x8, x3, x3, lsl #1
	lsl	x20, x8, #3
	cbz	x1, .LBB11_4
	add	x8, x1, x1, lsl #1
	mov	x0, x2
	mov	w2, #8
	mov	x3, x20
	lsl	x1, x8, #3
	bl	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_realloc
	cbnz	x0, .LBB11_8
	b	.LBB11_6
.LBB11_4:
	cbz	x20, .LBB11_7
	bl	_RNvCsbOwsw4zHH1Z_7___rustc35___rust_no_alloc_shim_is_unstable_v2
	mov	x0, x20
	mov	w1, #8
	bl	_RNvCsbOwsw4zHH1Z_7___rustc12___rust_alloc
	cbnz	x0, .LBB11_8
.LBB11_6:
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
.LBB11_7:
	.cfi_restore_state
	mov	w0, #8
.LBB11_8:
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
.Lfunc_end11:
	.size	_RNvMs8_NtCshDmNPlWY1OA_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsM3pabHJvao_4leaf, .Lfunc_end11-_RNvMs8_NtCshDmNPlWY1OA_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text._RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data11white_space6lookup,"ax",@progbits
	.p2align	2
	.type	_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data11white_space6lookup,@function
_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data11white_space6lookup:
	.cfi_startproc
	lsr	w8, w0, #8
	cmp	w8, #31
	b.gt	.LBB12_3
	cbz	w8, .LBB12_5
	mov	w9, #5760
	cmp	w0, w9
	cset	w9, eq
	cmp	w8, #22
	csel	w8, w9, wzr, eq
	and	w0, w8, #0x1
	ret
.LBB12_3:
	cmp	w8, #32
	b.eq	.LBB12_6
	cmp	w0, #3, lsl #12
	cset	w9, eq
	cmp	w8, #48
	csel	w8, w9, wzr, eq
	and	w0, w8, #0x1
	ret
.LBB12_5:
	adrp	x8, :got:_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data11white_space14WHITESPACE_MAP
	and	x9, x0, #0xff
	ldr	x8, [x8, :got_lo12:_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data11white_space14WHITESPACE_MAP]
	ldrb	w8, [x8, x9]
	and	w0, w8, #0x1
	ret
.LBB12_6:
	adrp	x8, :got:_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data11white_space14WHITESPACE_MAP
	and	x9, x0, #0xff
	ldr	x8, [x8, :got_lo12:_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data11white_space14WHITESPACE_MAP]
	ldrb	w8, [x8, x9]
	ubfx	w8, w8, #1, #1
	and	w0, w8, #0x1
	ret
.Lfunc_end12:
	.size	_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data11white_space6lookup, .Lfunc_end12-_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data11white_space6lookup
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
	adrp	x9, .Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel
	add	x9, x9, :lo12:.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel
	ldrsw	x8, [x9, x8, lsl #2]
	add	x1, x9, x8
	b	_RNvMsa_NtCs5eKY5gNNvwM_4core3fmtNtB5_9Formatter9write_str
.Lfunc_end13:
	.size	_RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf, .Lfunc_end13-_RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf
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
.Lfunc_end14:
	.size	_RNvXsc_NtNtCs5eKY5gNNvwM_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt, .Lfunc_end14-_RNvXsc_NtNtCs5eKY5gNNvwM_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
	.cfi_endproc

	.section	.text.fast,"ax",@progbits
	.globl	fast
	.p2align	2
	.type	fast,@function
fast:
	.cfi_startproc
	sub	sp, sp, #80
	.cfi_def_cfa_offset 80
	stp	x29, x30, [sp, #32]
	stp	x22, x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	add	x29, sp, #32
	.cfi_def_cfa w29, 48
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -24
	.cfi_offset w22, -32
	.cfi_offset w30, -40
	.cfi_offset w29, -48
	.cfi_remember_state
	stp	x0, x1, [sp]
	mov	x8, sp
	//APP
	//NO_APP
	ldr	x20, [sp, #8]
	cbz	x20, .LBB15_6
	ldr	x21, [sp]
	mov	x19, xzr
	mov	w22, #173
	b	.LBB15_3
.LBB15_2:
	mov	w8, #1
	subs	x20, x20, #1
	add	x19, x8, x19
	b.eq	.LBB15_5
.LBB15_3:
	ldr	w1, [x21], #4
	sub	w8, w1, #161
	cmp	w8, #607
	ccmp	w1, w22, #4, lo
	b.ne	.LBB15_2
	add	x0, sp, #16
	bl	_RNvMNtNtCs5eKY5gNNvwM_4core4char7methodsc16escape_debug_ext
	ldrb	w8, [sp, #29]
	ldrb	w9, [sp, #28]
	sub	w8, w8, w9
	and	x8, x8, #0xff
	subs	x20, x20, #1
	add	x19, x8, x19
	b.ne	.LBB15_3
.LBB15_5:
	mov	x0, x19
	.cfi_def_cfa wsp, 80
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x29, x30, [sp, #32]
	add	sp, sp, #80
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB15_6:
	.cfi_restore_state
	mov	x19, xzr
	mov	x0, x19
	.cfi_def_cfa wsp, 80
	ldp	x20, x19, [sp, #64]
	ldp	x22, x21, [sp, #48]
	ldp	x29, x30, [sp, #32]
	add	sp, sp, #80
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w22
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end15:
	.size	fast, .Lfunc_end15-fast
	.cfi_endproc

	.section	.text.slow,"ax",@progbits
	.globl	slow
	.p2align	2
	.type	slow,@function
slow:
	.cfi_startproc
	sub	sp, sp, #80
	.cfi_def_cfa_offset 80
	stp	x29, x30, [sp, #32]
	str	x21, [sp, #48]
	stp	x20, x19, [sp, #64]
	add	x29, sp, #32
	.cfi_def_cfa w29, 48
	.cfi_offset w19, -8
	.cfi_offset w20, -16
	.cfi_offset w21, -32
	.cfi_offset w30, -40
	.cfi_offset w29, -48
	.cfi_remember_state
	stp	x0, x1, [sp]
	mov	x8, sp
	//APP
	//NO_APP
	ldr	x20, [sp, #8]
	cbz	x20, .LBB16_4
	ldr	x21, [sp]
	mov	x19, xzr
.LBB16_2:
	ldr	w1, [x21], #4
	add	x0, sp, #16
	bl	_RNvMNtNtCs5eKY5gNNvwM_4core4char7methodsc16escape_debug_ext
	ldrb	w8, [sp, #29]
	ldrb	w9, [sp, #28]
	subs	x20, x20, #1
	sub	w8, w8, w9
	add	x19, x19, w8, uxtb
	b.ne	.LBB16_2
	mov	x0, x19
	.cfi_def_cfa wsp, 80
	ldp	x20, x19, [sp, #64]
	ldr	x21, [sp, #48]
	ldp	x29, x30, [sp, #32]
	add	sp, sp, #80
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	ret
.LBB16_4:
	.cfi_restore_state
	mov	x19, xzr
	mov	x0, x19
	.cfi_def_cfa wsp, 80
	ldp	x20, x19, [sp, #64]
	ldr	x21, [sp, #48]
	ldp	x29, x30, [sp, #32]
	add	sp, sp, #80
	.cfi_def_cfa_offset 0
	.cfi_restore w19
	.cfi_restore w20
	.cfi_restore w21
	.cfi_restore w30
	.cfi_restore w29
	ret
.Lfunc_end16:
	.size	slow, .Lfunc_end16-slow
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
.Lfunc_end17:
	.size	main, .Lfunc_end17-main
	.cfi_endproc

	.type	.Lanon.ac0e6a0124ddfcc5e8e1efc76584fb4a.0,@object
	.section	.rodata.cst16,"aM",@progbits,16
.Lanon.ac0e6a0124ddfcc5e8e1efc76584fb4a.0:
	.ascii	"0123456789abcdef"
	.size	.Lanon.ac0e6a0124ddfcc5e8e1efc76584fb4a.0, 16

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

	.type	.Lalloc_21d75c3d867f14d7573b954b2f1f66cf,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_21d75c3d867f14d7573b954b2f1f66cf:
	.asciz	"/tmp/str-debug-some-unicode-20261105/leaf.rs"
	.size	.Lalloc_21d75c3d867f14d7573b954b2f1f66cf, 45

	.type	.Lalloc_0dd3479570b32f59538d76287f051d43,@object
	.section	.data.rel.ro..Lalloc_0dd3479570b32f59538d76287f051d43,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_0dd3479570b32f59538d76287f051d43:
	.xword	.Lalloc_21d75c3d867f14d7573b954b2f1f66cf
	.asciz	",\000\000\000\000\000\000\000\n\000\000\000G\000\000"
	.size	.Lalloc_0dd3479570b32f59538d76287f051d43, 24

	.type	.Lalloc_5acfb0f90745456c7a1384ae2e47aa0d,@object
	.section	.data.rel.ro..Lalloc_5acfb0f90745456c7a1384ae2e47aa0d,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_5acfb0f90745456c7a1384ae2e47aa0d:
	.xword	.Lalloc_21d75c3d867f14d7573b954b2f1f66cf
	.asciz	",\000\000\000\000\000\000\000\n\000\000\000s\000\000"
	.size	.Lalloc_5acfb0f90745456c7a1384ae2e47aa0d, 24

	.type	.Lalloc_0f55ccc5796de6140dfafcec783eada4,@object
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	2, 0x0
.Lalloc_0f55ccc5796de6140dfafcec783eada4:
	.asciz	"\366\000\000\000\351\000\000\000\341\000\000\000q\001\000"
	.size	.Lalloc_0f55ccc5796de6140dfafcec783eada4, 16

	.type	.Lalloc_ee2a3d99accaa3cec7cc99bf20f81916,@object
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.Lalloc_ee2a3d99accaa3cec7cc99bf20f81916:
	.asciz	"\004\000\000\000\000\000\000"
	.size	.Lalloc_ee2a3d99accaa3cec7cc99bf20f81916, 8

	.type	.Lalloc_b3b266528be359e4a0db3dc7da84a07e,@object
	.section	.data.rel.ro..Lalloc_b3b266528be359e4a0db3dc7da84a07e,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_b3b266528be359e4a0db3dc7da84a07e:
	.xword	.Lalloc_21d75c3d867f14d7573b954b2f1f66cf
	.asciz	",\000\000\000\000\000\000\000\013\000\000\000\032\000\000"
	.size	.Lalloc_b3b266528be359e4a0db3dc7da84a07e, 24

	.type	.Lalloc_4014284bd8c57ea959725918594e45ac,@object
	.section	.data.rel.ro..Lalloc_4014284bd8c57ea959725918594e45ac,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_4014284bd8c57ea959725918594e45ac:
	.xword	.Lalloc_21d75c3d867f14d7573b954b2f1f66cf
	.asciz	",\000\000\000\000\000\000\000\013\000\000\000\002\000\000"
	.size	.Lalloc_4014284bd8c57ea959725918594e45ac, 24

	.type	.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274,@object
	.section	.rodata..Lalloc_00ae4b301f7fab8ac9617c03fcbd7274,"a",@progbits
.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274:
	.ascii	"called `Result::unwrap()` on an `Err` value"
	.size	.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274, 43

	.type	.Lalloc_4bdb784eb229662729e2cb30c9370ef2,@object
	.section	.data.rel.ro..Lalloc_4bdb784eb229662729e2cb30c9370ef2,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_4bdb784eb229662729e2cb30c9370ef2:
	.xword	.Lalloc_21d75c3d867f14d7573b954b2f1f66cf
	.asciz	",\000\000\000\000\000\000\000\n\000\000\000\177\000\000"
	.size	.Lalloc_4bdb784eb229662729e2cb30c9370ef2, 24

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

	.type	.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel,"a",@progbits
	.p2align	2, 0x0
.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel:
	.word	.Lalloc_59ba7b9f7211443cd55a366616eef46a-.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel
	.word	.Lalloc_00315c78e51d29fe6b3102a4c1ecf6ef-.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel
	.word	.Lalloc_bd3a3f3879e0d5f64554753e977f58d4-.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel
	.word	.Lalloc_0964bb2a4870637395c77a018495bd5c-.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel
	.word	.Lalloc_6566120a3a17f930e960a0863fcbd591-.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel
	.word	.Lalloc_6c17bac0c71cba42380f8445f4dcbd16-.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel
	.size	.Lswitch.table._RNvXs1g_NtCs5eKY5gNNvwM_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel, 24

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
