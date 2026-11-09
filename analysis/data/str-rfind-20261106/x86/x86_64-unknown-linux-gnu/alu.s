	.att_syntax
	.file	"alu.caa5c39ebd10de37-cgu.0"
	.section	.text._RINvNtCs341anU20NIK_3std2rt10lang_startuECshoGEzlfe2Dr_3alu,"ax",@progbits
	.hidden	_RINvNtCs341anU20NIK_3std2rt10lang_startuECshoGEzlfe2Dr_3alu
	.globl	_RINvNtCs341anU20NIK_3std2rt10lang_startuECshoGEzlfe2Dr_3alu
	.prefalign	4, .Lfunc_end0, nop
	.type	_RINvNtCs341anU20NIK_3std2rt10lang_startuECshoGEzlfe2Dr_3alu,@function
_RINvNtCs341anU20NIK_3std2rt10lang_startuECshoGEzlfe2Dr_3alu:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	%ecx, %r8d
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rdi, (%rsp)
	leaq	.Lvtable.0(%rip), %rsi
	movq	%rsp, %rdi
	callq	*_RNvNtCs341anU20NIK_3std2rt19lang_start_internal@GOTPCREL(%rip)
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	_RINvNtCs341anU20NIK_3std2rt10lang_startuECshoGEzlfe2Dr_3alu, .Lfunc_end0-_RINvNtCs341anU20NIK_3std2rt10lang_startuECshoGEzlfe2Dr_3alu
	.cfi_endproc

	.section	.text._RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECshoGEzlfe2Dr_3alu,"ax",@progbits
	.prefalign	4, .Lfunc_end1, nop
	.type	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECshoGEzlfe2Dr_3alu,@function
_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECshoGEzlfe2Dr_3alu:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r13
	.cfi_def_cfa_offset 32
	pushq	%r12
	.cfi_def_cfa_offset 40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdi, %r14
	movq	8(%rdi), %rbx
	movq	16(%rdi), %r15
	testq	%r15, %r15
	je	.LBB1_5
	leaq	8(%rbx), %r12
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r13
	jmp	.LBB1_2
	.p2align	4
.LBB1_4:
	addq	$24, %r12
	decq	%r15
	je	.LBB1_5
.LBB1_2:
	movq	-8(%r12), %rsi
	testq	%rsi, %rsi
	je	.LBB1_4
	movq	(%r12), %rdi
	movl	$1, %edx
	callq	*%r13
	jmp	.LBB1_4
.LBB1_5:
	movq	(%r14), %rax
	testq	%rax, %rax
	je	.LBB1_6
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmpq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB1_6:
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECshoGEzlfe2Dr_3alu, .Lfunc_end1-_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECshoGEzlfe2Dr_3alu
	.cfi_endproc

	.section	.text._RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECshoGEzlfe2Dr_3alu,"ax",@progbits
	.prefalign	4, .Lfunc_end2, nop
	.type	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECshoGEzlfe2Dr_3alu,@function
_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECshoGEzlfe2Dr_3alu:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%r12
	.cfi_def_cfa_offset 32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	pushq	%rax
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -40
	.cfi_offset %r12, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdi, %rbx
	movq	8(%rdi), %r15
	movq	24(%rdi), %rcx
	movq	%rcx, %rax
	subq	%r15, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	cmpq	%r15, %rcx
	je	.LBB2_5
	movq	%rdx, %r14
	shrq	$4, %r14
	addq	$8, %r15
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r12
	jmp	.LBB2_2
	.p2align	4
.LBB2_4:
	addq	$24, %r15
	decq	%r14
	je	.LBB2_5
.LBB2_2:
	movq	-8(%r15), %rsi
	testq	%rsi, %rsi
	je	.LBB2_4
	movq	(%r15), %rdi
	movl	$1, %edx
	callq	*%r12
	jmp	.LBB2_4
.LBB2_5:
	movq	16(%rbx), %rax
	testq	%rax, %rax
	je	.LBB2_6
	movq	(%rbx), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmpq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB2_6:
	.cfi_def_cfa_offset 48
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECshoGEzlfe2Dr_3alu, .Lfunc_end2-_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECshoGEzlfe2Dr_3alu
	.cfi_endproc

	.section	.text._RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshoGEzlfe2Dr_3alu,"ax",@progbits
	.prefalign	4, .Lfunc_end3, nop
	.type	_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshoGEzlfe2Dr_3alu,@function
_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshoGEzlfe2Dr_3alu:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	callq	*%rdi
	#APP
	#NO_APP
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end3:
	.size	_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshoGEzlfe2Dr_3alu, .Lfunc_end3-_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshoGEzlfe2Dr_3alu
	.cfi_endproc

	.section	.text.unlikely._RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshoGEzlfe2Dr_3alu,"ax",@progbits
	.prefalign	4, .Lfunc_end4, nop
	.type	_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshoGEzlfe2Dr_3alu,@function
_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshoGEzlfe2Dr_3alu:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	addq	%rdx, %rsi
	jb	.LBB4_1
	movq	%rdi, %rbx
	movq	(%rdi), %rax
	leaq	(%rax,%rax), %rcx
	cmpq	%rcx, %rsi
	cmovaq	%rsi, %rcx
	cmpq	$5, %rcx
	movl	$4, %r14d
	cmovaeq	%rcx, %r14
	movq	8(%rdi), %rdx
	movq	%rsp, %rdi
	movq	%rax, %rsi
	movq	%r14, %rcx
	callq	_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshoGEzlfe2Dr_3alu
	cmpl	$1, (%rsp)
	je	.LBB4_3
	movq	8(%rsp), %rax
	movq	%rax, 8(%rbx)
	movq	%r14, (%rbx)
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.LBB4_1:
	.cfi_def_cfa_offset 48
	xorl	%edi, %edi
	callq	*_RNvNtCs3v2GDSbr0UZ_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.LBB4_3:
	movq	8(%rsp), %rdi
	movq	16(%rsp), %rsi
	callq	*_RNvNtCs3v2GDSbr0UZ_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Lfunc_end4:
	.size	_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshoGEzlfe2Dr_3alu, .Lfunc_end4-_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshoGEzlfe2Dr_3alu
	.cfi_endproc

	.section	.text._RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0CshoGEzlfe2Dr_3alu,"ax",@progbits
	.prefalign	4, .Lfunc_end5, nop
	.type	_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0CshoGEzlfe2Dr_3alu,@function
_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0CshoGEzlfe2Dr_3alu:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	(%rdi), %rdi
	callq	_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshoGEzlfe2Dr_3alu
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end5:
	.size	_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0CshoGEzlfe2Dr_3alu, .Lfunc_end5-_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0CshoGEzlfe2Dr_3alu
	.cfi_endproc

	.section	.text._RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCshoGEzlfe2Dr_3alu,"ax",@progbits
	.prefalign	4, .Lfunc_end6, nop
	.type	_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCshoGEzlfe2Dr_3alu,@function
_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCshoGEzlfe2Dr_3alu:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	(%rdi), %rdi
	callq	_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshoGEzlfe2Dr_3alu
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end6:
	.size	_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCshoGEzlfe2Dr_3alu, .Lfunc_end6-_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCshoGEzlfe2Dr_3alu
	.cfi_endproc

	.section	.text._RNvCshoGEzlfe2Dr_3alu4main,"ax",@progbits
	.hidden	_RNvCshoGEzlfe2Dr_3alu4main
	.globl	_RNvCshoGEzlfe2Dr_3alu4main
	.prefalign	4, .Lfunc_end7, nop
	.type	_RNvCshoGEzlfe2Dr_3alu4main,@function
_RNvCshoGEzlfe2Dr_3alu4main:
.Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, DW.ref.rust_eh_personality
	.cfi_lsda 27, .Lexception0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$136, %rsp
	.cfi_def_cfa_offset 192
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	leaq	48(%rsp), %rbx
	movq	%rbx, %rdi
	callq	*_RNvNtCs341anU20NIK_3std3env4args@GOTPCREL(%rip)
.Ltmp0:
	leaq	16(%rsp), %rdi
	movq	%rbx, %rsi
	callq	*_RNvXsc_NtCs341anU20NIK_3std3envNtB5_4ArgsNtNtNtNtCsc9NCSoc2doQ_4core4iter6traits8iterator8Iterator4next@GOTPCREL(%rip)
.Ltmp1:
	movq	16(%rsp), %rbx
	cmpq	$-1, %rbx
	je	.LBB7_61
	movq	24(%rsp), %r14
	movq	72(%rsp), %rax
	subq	56(%rsp), %rax
	movq	%rax, %rcx
	shrq	$3, %rcx
	movabsq	$-6148914691236517205, %rdx
	imulq	%rdx, %rcx
	cmpq	$4, %rcx
	movl	$3, %ebp
	cmovaeq	%rcx, %rbp
	leaq	8(,%rbp,8), %rcx
	leaq	(%rcx,%rcx,2), %r12
	movabsq	$9223372036854775776, %rcx
	cmpq	%rcx, %rax
	jbe	.LBB7_5
	xorl	%r13d, %r13d
.LBB7_4:
.Ltmp20:
	movq	%r13, %rdi
	movq	%r12, %rsi
	callq	*_RNvNtCs3v2GDSbr0UZ_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Ltmp21:
	jmp	.LBB7_66
.LBB7_5:
	movq	32(%rsp), %rax
	testq	%r12, %r12
	je	.LBB7_8
	movq	%rax, 8(%rsp)
	callq	*_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$8, %r13d
	movl	$8, %esi
	movq	%r12, %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB7_4
	movq	%rax, %r15
	incq	%rbp
	movq	8(%rsp), %rax
	jmp	.LBB7_9
.LBB7_8:
	movl	$8, %r15d
	xorl	%ebp, %ebp
.LBB7_9:
	movq	%rbx, (%r15)
	movq	%r14, 8(%r15)
	movq	%rax, 16(%r15)
	movq	%rbp, 88(%rsp)
	movq	%r15, 96(%rsp)
	movq	$1, 104(%rsp)
	movups	48(%rsp), %xmm0
	movups	64(%rsp), %xmm1
	movaps	%xmm1, 32(%rsp)
	movaps	%xmm0, 16(%rsp)
	movl	$1, %ebx
	movl	$40, %r14d
	jmp	.LBB7_12
	.p2align	4
.LBB7_10:
	movq	96(%rsp), %r15
.LBB7_11:
	movq	%rbp, -16(%r15,%r14)
	movq	%r13, -8(%r15,%r14)
	movq	%r12, (%r15,%r14)
	incq	%rbx
	movq	%rbx, 104(%rsp)
	addq	$24, %r14
.LBB7_12:
.Ltmp3:
	leaq	112(%rsp), %rdi
	leaq	16(%rsp), %rsi
	callq	*_RNvXsc_NtCs341anU20NIK_3std3envNtB5_4ArgsNtNtNtNtCsc9NCSoc2doQ_4core4iter6traits8iterator8Iterator4next@GOTPCREL(%rip)
.Ltmp4:
	movq	112(%rsp), %rbp
	cmpq	$-1, %rbp
	je	.LBB7_16
	movq	120(%rsp), %r13
	movq	128(%rsp), %r12
	cmpq	88(%rsp), %rbx
	jne	.LBB7_11
	movq	40(%rsp), %rdx
	subq	24(%rsp), %rdx
	shrq	$3, %rdx
	movabsq	$-6148914691236517205, %rax
	imulq	%rax, %rdx
	incq	%rdx
.Ltmp6:
	leaq	88(%rsp), %rdi
	movq	%rbx, %rsi
	callq	_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshoGEzlfe2Dr_3alu
.Ltmp7:
	jmp	.LBB7_10
.LBB7_16:
	movq	24(%rsp), %r15
	movq	40(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r15, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	cmpq	%r15, %rcx
	je	.LBB7_21
	movq	%rdx, %r14
	shrq	$4, %r14
	addq	$8, %r15
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r12
	jmp	.LBB7_19
	.p2align	4
.LBB7_18:
	addq	$24, %r15
	decq	%r14
	je	.LBB7_21
.LBB7_19:
	movq	-8(%r15), %rsi
	testq	%rsi, %rsi
	je	.LBB7_18
	movq	(%r15), %rdi
	movl	$1, %edx
	callq	*%r12
	jmp	.LBB7_18
.LBB7_21:
	movq	32(%rsp), %rax
	testq	%rax, %rax
	je	.LBB7_23
	movq	16(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB7_23:
	movq	88(%rsp), %rax
	movq	%rax, 8(%rsp)
	movq	96(%rsp), %r14
	cmpq	$3, %rbx
	leaq	48(%rsp), %r15
	jb	.LBB7_65
	movq	56(%r14), %rcx
	movq	64(%r14), %rsi
	cmpq	$1, %rsi
	je	.LBB7_27
	testq	%rsi, %rsi
	je	.LBB7_71
	movzbl	(%rcx), %edx
	jmp	.LBB7_29
.LBB7_27:
	movzbl	(%rcx), %edx
	movb	$1, %al
	cmpl	$43, %edx
	je	.LBB7_58
	cmpl	$45, %edx
	je	.LBB7_58
.LBB7_29:
	xorl	%eax, %eax
	cmpb	$43, %dl
	sete	%al
	movq	%rsi, %rdx
	subq	%rax, %rdx
	addq	%rax, %rcx
	negq	%rax
	cmpq	$17, %rdx
	jae	.LBB7_34
	testq	%rdx, %rdx
	je	.LBB7_39
	addq	%rax, %rsi
	negq	%rsi
	xorl	%ebp, %ebp
	xorl	%eax, %eax
	.p2align	4
.LBB7_32:
	movzbl	(%rcx,%rax), %edx
	addl	$-48, %edx
	cmpl	$9, %edx
	ja	.LBB7_60
	leaq	(,%rbp,4), %rdi
	addq	%rbp, %rdi
	movl	%edx, %edx
	leaq	(%rdx,%rdi,2), %rbp
	incq	%rax
	movq	%rsi, %rdx
	addq	%rax, %rdx
	jne	.LBB7_32
	jmp	.LBB7_40
.LBB7_34:
	addq	%rax, %rsi
	negq	%rsi
	xorl	%ebp, %ebp
	movl	$10, %edi
	xorl	%r8d, %r8d
	.p2align	4
.LBB7_35:
	movq	%rbp, %rax
	mulq	%rdi
	movzbl	(%rcx,%r8), %edx
	jo	.LBB7_56
	addl	$-48, %edx
	cmpl	$10, %edx
	jae	.LBB7_60
	movq	%rax, %rbp
	movl	%edx, %eax
	addq	%rax, %rbp
	jb	.LBB7_57
	incq	%r8
	movq	%rsi, %rax
	addq	%r8, %rax
	jne	.LBB7_35
	jmp	.LBB7_40
.LBB7_39:
	xorl	%ebp, %ebp
.LBB7_40:
.Ltmp11:
	callq	*_RNvMNtCs341anU20NIK_3std4timeNtB2_7Instant3now@GOTPCREL(%rip)
.Ltmp12:
	movq	%rax, 112(%rsp)
	movl	%edx, 120(%rsp)
	cmpq	$3, 40(%r14)
	jne	.LBB7_45
	movq	32(%r14), %rax
	movzwl	(%rax), %ecx
	xorl	$27745, %ecx
	movzbl	2(%rax), %edx
	xorl	$117, %edx
	orw	%cx, %dx
	je	.LBB7_46
	movzwl	(%rax), %ecx
	xorl	$28526, %ecx
	movzbl	2(%rax), %eax
	xorl	$112, %eax
	orw	%cx, %ax
	jne	.LBB7_45
	#APP

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
	decq	%rbp
	jne	.Ltmp26

	#NO_APP
	jmp	.LBB7_47
.LBB7_45:
.Ltmp13:
	leaq	.Lalloc_476509aa7047bd805d630c6546685797(%rip), %rdi
	leaq	.Lalloc_cc025e4bbd599630ae10637782e6577c(%rip), %rdx
	movl	$14, %esi
	callq	*_RNvNtCsc9NCSoc2doQ_4core9panicking5panic@GOTPCREL(%rip)
.Ltmp14:
	jmp	.LBB7_66
.LBB7_46:
	#APP

	movq	$85, %r15
	movq	$1, %r8
	movq	$2, %r9
	movq	$3, %r10
	movq	$4, %r11
	movq	$5, %r12
	movq	$6, %r13
	.p2align	6
.Ltmp27:
	xorq	%r15, %r8
	xorq	%r15, %r9
	xorq	%r15, %r10
	xorq	%r15, %r11
	xorq	%r15, %r12
	xorq	%r15, %r13
	orq	%r15, %r8
	orq	%r15, %r9
	orq	%r15, %r10
	orq	%r15, %r11
	orq	%r15, %r12
	orq	%r15, %r13
	decq	%rbp
	jne	.Ltmp27

	#NO_APP
	leaq	48(%rsp), %r15
.LBB7_47:
	movq	%rbp, 16(%rsp)
	leaq	16(%rsp), %rax
	#APP
	#NO_APP
.Ltmp15:
	leaq	112(%rsp), %rdi
	callq	*_RNvMNtCs341anU20NIK_3std4timeNtB2_7Instant7elapsed@GOTPCREL(%rip)
.Ltmp16:
	movl	%edx, %ecx
	movl	$1000000000, %edx
	mulq	%rdx
	movl	%ecx, %ecx
	addq	%rax, %rcx
	adcq	$0, %rdx
	movq	%rcx, 48(%rsp)
	movq	%rdx, 56(%rsp)
	movq	%r15, 16(%rsp)
	movq	_RNvXNtNtCsc9NCSoc2doQ_4core3fmt3numoNtB4_7Display3fmt@GOTPCREL(%rip), %rax
	movq	%rax, 24(%rsp)
.Ltmp17:
	leaq	.Lalloc_61247b90e1706a3f65e71312b599d3d1(%rip), %rdi
	leaq	16(%rsp), %rsi
	callq	*_RNvNtNtCs341anU20NIK_3std2io5stdio6__print@GOTPCREL(%rip)
.Ltmp18:
	leaq	8(%r14), %r15
	xorl	%r12d, %r12d
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r13
	jmp	.LBB7_51
	.p2align	4
.LBB7_50:
	incq	%r12
	addq	$24, %r15
	cmpq	%r12, %rbx
	je	.LBB7_53
.LBB7_51:
	movq	-8(%r15), %rsi
	testq	%rsi, %rsi
	je	.LBB7_50
	movq	(%r15), %rdi
	movl	$1, %edx
	callq	*%r13
	jmp	.LBB7_50
.LBB7_53:
	movq	8(%rsp), %rax
	testq	%rax, %rax
	je	.LBB7_55
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	movq	%r14, %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB7_55:
	addq	$136, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.LBB7_56:
	.cfi_def_cfa_offset 192
	addb	$-48, %dl
	xorl	%eax, %eax
	cmpb	$10, %dl
	adcb	$1, %al
	jmp	.LBB7_58
.LBB7_57:
	movb	$2, %al
.LBB7_58:
	movb	%al, 16(%rsp)
.Ltmp9:
	leaq	.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274(%rip), %rdi
	leaq	.Lvtable.1(%rip), %rcx
	leaq	.Lalloc_a8b0ebe0d43da0c3dafb5875f5f854e1(%rip), %r8
	leaq	16(%rsp), %rdx
	movl	$43, %esi
	callq	*_RNvNtCsc9NCSoc2doQ_4core6result13unwrap_failed@GOTPCREL(%rip)
.Ltmp10:
	jmp	.LBB7_66
.LBB7_60:
	movb	$1, %al
	jmp	.LBB7_58
.LBB7_61:
	movq	56(%rsp), %r14
	movq	72(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r14, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	cmpq	%r14, %rcx
	jne	.LBB7_67
.LBB7_62:
	movq	64(%rsp), %rax
	testq	%rax, %rax
	je	.LBB7_64
	movq	48(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB7_64:
	movl	$8, %r14d
	movq	$0, 8(%rsp)
	xorl	%ebx, %ebx
.LBB7_65:
.Ltmp23:
	leaq	.Lalloc_0a75a407fb154f340d899592a8228c5e(%rip), %rdx
	movl	$2, %edi
	movq	%rbx, %rsi
	callq	*_RNvNtCsc9NCSoc2doQ_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.Ltmp24:
.LBB7_66:
	ud2
.LBB7_67:
	movq	%rdx, %rbx
	shrq	$4, %rbx
	addq	$8, %r14
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r15
	jmp	.LBB7_69
	.p2align	4
.LBB7_68:
	addq	$24, %r14
	decq	%rbx
	je	.LBB7_62
.LBB7_69:
	movq	-8(%r14), %rsi
	testq	%rsi, %rsi
	je	.LBB7_68
	movq	(%r14), %rdi
	movl	$1, %edx
	callq	*%r15
	jmp	.LBB7_68
.LBB7_71:
	xorl	%eax, %eax
	jmp	.LBB7_58
.LBB7_72:
.Ltmp2:
	movq	%rax, %r15
	jmp	.LBB7_87
.LBB7_73:
.Ltmp25:
	movq	%rax, %r15
	testq	%rbx, %rbx
	jne	.LBB7_81
.LBB7_74:
	movq	8(%rsp), %rax
	testq	%rax, %rax
	je	.LBB7_89
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	movq	%r14, %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	movq	%r15, %rdi
	callq	_Unwind_Resume@PLT
.LBB7_76:
.Ltmp8:
	movq	%rax, %r15
	testq	%rbp, %rbp
	je	.LBB7_79
	movl	$1, %edx
	movq	%r13, %rdi
	movq	%rbp, %rsi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	jmp	.LBB7_79
.LBB7_78:
.Ltmp5:
	movq	%rax, %r15
.LBB7_79:
	leaq	16(%rsp), %rdi
	callq	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECshoGEzlfe2Dr_3alu
	leaq	88(%rsp), %rdi
	callq	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECshoGEzlfe2Dr_3alu
	movq	%r15, %rdi
	callq	_Unwind_Resume@PLT
.LBB7_80:
.Ltmp19:
	movq	%rax, %r15
.LBB7_81:
	leaq	8(%r14), %r12
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r13
	jmp	.LBB7_83
	.p2align	4
.LBB7_82:
	addq	$24, %r12
	decq	%rbx
	je	.LBB7_74
.LBB7_83:
	movq	-8(%r12), %rsi
	testq	%rsi, %rsi
	je	.LBB7_82
	movq	(%r12), %rdi
	movl	$1, %edx
	callq	*%r13
	jmp	.LBB7_82
.LBB7_85:
.Ltmp22:
	movq	%rax, %r15
	testq	%rbx, %rbx
	je	.LBB7_87
	movl	$1, %edx
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB7_87:
	movq	56(%rsp), %r14
	movq	72(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r14, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	cmpq	%r14, %rcx
	jne	.LBB7_90
.LBB7_88:
	movq	64(%rsp), %rax
	testq	%rax, %rax
	jne	.LBB7_94
.LBB7_89:
	movq	%r15, %rdi
	callq	_Unwind_Resume@PLT
.LBB7_90:
	movq	%rdx, %rbx
	shrq	$4, %rbx
	addq	$8, %r14
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r12
	jmp	.LBB7_92
	.p2align	4
.LBB7_91:
	addq	$24, %r14
	decq	%rbx
	je	.LBB7_88
.LBB7_92:
	movq	-8(%r14), %rsi
	testq	%rsi, %rsi
	je	.LBB7_91
	movq	(%r14), %rdi
	movl	$1, %edx
	callq	*%r12
	jmp	.LBB7_91
.LBB7_94:
	movq	48(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	movq	%r15, %rdi
	callq	_Unwind_Resume@PLT
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
	.uleb128 .Ltmp7-.Lfunc_begin0
	.uleb128 .Ltmp11-.Ltmp7
	.byte	0
	.byte	0
	.uleb128 .Ltmp11-.Lfunc_begin0
	.uleb128 .Ltmp18-.Ltmp11
	.uleb128 .Ltmp19-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp18-.Lfunc_begin0
	.uleb128 .Ltmp9-.Ltmp18
	.byte	0
	.byte	0
	.uleb128 .Ltmp9-.Lfunc_begin0
	.uleb128 .Ltmp10-.Ltmp9
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

	.section	.text.unlikely._RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshoGEzlfe2Dr_3alu,"ax",@progbits
	.prefalign	4, .Lfunc_end8, nop
	.type	_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshoGEzlfe2Dr_3alu,@function
_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshoGEzlfe2Dr_3alu:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdi, %rbx
	movl	$1, %r15d
	movabsq	$384307168202282325, %rax
	cmpq	%rax, %rcx
	jbe	.LBB8_2
	movl	$8, %eax
	xorl	%r14d, %r14d
	jmp	.LBB8_10
.LBB8_2:
	shlq	$3, %rcx
	leaq	(%rcx,%rcx,2), %r14
	testq	%rsi, %rsi
	je	.LBB8_4
	shlq	$3, %rsi
	leaq	(%rsi,%rsi,2), %rsi
	movq	%rdx, %rdi
	movl	$8, %edx
	movq	%r14, %rcx
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_realloc@GOTPCREL(%rip)
	testq	%rax, %rax
	jne	.LBB8_6
	jmp	.LBB8_9
.LBB8_4:
	testq	%r14, %r14
	je	.LBB8_5
	callq	*_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$8, %esi
	movq	%r14, %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	jne	.LBB8_6
.LBB8_9:
	movq	$8, 8(%rbx)
	movl	$16, %eax
	jmp	.LBB8_10
.LBB8_5:
	movl	$8, %eax
.LBB8_6:
	movq	%rax, 8(%rbx)
	movl	$16, %eax
	xorl	%r15d, %r15d
.LBB8_10:
	movq	%r14, (%rbx,%rax)
	movq	%r15, (%rbx)
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end8:
	.size	_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshoGEzlfe2Dr_3alu, .Lfunc_end8-_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshoGEzlfe2Dr_3alu
	.cfi_endproc

	.section	.text._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu,"ax",@progbits
	.prefalign	4, .Lfunc_end9, nop
	.type	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu,@function
_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu:
	.cfi_startproc
	movq	%rsi, %rax
	movq	(%rdi), %rcx
	movzbl	(%rcx), %ecx
	leaq	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu(%rip), %rdx
	movzbl	(%rcx,%rdx), %edx
	leaq	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel(%rip), %rdi
	movslq	(%rdi,%rcx,4), %rsi
	addq	%rdi, %rsi
	movq	%rax, %rdi
	jmpq	*_RNvMsa_NtCsc9NCSoc2doQ_4core3fmtNtB5_9Formatter9write_str@GOTPCREL(%rip)
.Lfunc_end9:
	.size	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu, .Lfunc_end9-_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu
	.cfi_endproc

	.section	.text._RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt,"ax",@progbits
	.prefalign	4, .Lfunc_end10, nop
	.type	_RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt,@function
_RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rsi, %rax
	movq	%rdi, 16(%rsp)
	leaq	.Lvtable.2(%rip), %rcx
	movq	%rcx, (%rsp)
	leaq	.Lalloc_f62df14955f7d78bca139b0a7668683d(%rip), %rsi
	leaq	.Lalloc_a5d866b1768ad3f826bccdb004a1a8ae(%rip), %rcx
	leaq	16(%rsp), %r9
	movl	$13, %edx
	movl	$4, %r8d
	movq	%rax, %rdi
	callq	*_RNvMsa_NtCsc9NCSoc2doQ_4core3fmtNtB5_9Formatter26debug_struct_field1_finish@GOTPCREL(%rip)
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end10:
	.size	_RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt, .Lfunc_end10-_RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
	.cfi_endproc

	.section	.text.main,"ax",@progbits
	.globl	main
	.prefalign	4, .Lfunc_end11, nop
	.type	main,@function
main:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	%rsi, %rcx
	movslq	%edi, %rdx
	leaq	_RNvCshoGEzlfe2Dr_3alu4main(%rip), %rax
	movq	%rax, (%rsp)
	leaq	.Lvtable.0(%rip), %rsi
	movq	%rsp, %rdi
	xorl	%r8d, %r8d
	callq	*_RNvNtCs341anU20NIK_3std2rt19lang_start_internal@GOTPCREL(%rip)
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end11:
	.size	main, .Lfunc_end11-main
	.cfi_endproc

	.type	.Lvtable.0,@object
	.section	.data.rel.ro..Lvtable.0,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.0:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCshoGEzlfe2Dr_3alu
	.quad	_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0CshoGEzlfe2Dr_3alu
	.quad	_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0CshoGEzlfe2Dr_3alu
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
	.quad	.Lalloc_817202238b506f3adada4768b4e9cddf
	.asciz	"\036\000\000\000\000\000\000\000\004\000\000\0005\000\000"
	.size	.Lalloc_0a75a407fb154f340d899592a8228c5e, 24

	.type	.Lalloc_a8b0ebe0d43da0c3dafb5875f5f854e1,@object
	.section	.data.rel.ro..Lalloc_a8b0ebe0d43da0c3dafb5875f5f854e1,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_a8b0ebe0d43da0c3dafb5875f5f854e1:
	.quad	.Lalloc_817202238b506f3adada4768b4e9cddf
	.asciz	"\036\000\000\000\000\000\000\000\004\000\000\000A\000\000"
	.size	.Lalloc_a8b0ebe0d43da0c3dafb5875f5f854e1, 24

	.type	.Lalloc_476509aa7047bd805d630c6546685797,@object
	.section	.rodata..Lalloc_476509aa7047bd805d630c6546685797,"a",@progbits
.Lalloc_476509aa7047bd805d630c6546685797:
	.ascii	"explicit panic"
	.size	.Lalloc_476509aa7047bd805d630c6546685797, 14

	.type	.Lalloc_cc025e4bbd599630ae10637782e6577c,@object
	.section	.data.rel.ro..Lalloc_cc025e4bbd599630ae10637782e6577c,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_cc025e4bbd599630ae10637782e6577c:
	.quad	.Lalloc_817202238b506f3adada4768b4e9cddf
	.asciz	"\036\000\000\000\000\000\000\000\024\000\000\000{\000\000"
	.size	.Lalloc_cc025e4bbd599630ae10637782e6577c, 24

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
	.quad	_RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
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
	.quad	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu
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
	.section	.rodata.cst4,"aM",@progbits,4
.Lalloc_6566120a3a17f930e960a0863fcbd591:
	.ascii	"Zero"
	.size	.Lalloc_6566120a3a17f930e960a0863fcbd591, 4

	.type	.Lalloc_6c17bac0c71cba42380f8445f4dcbd16,@object
	.section	.rodata..Lalloc_6c17bac0c71cba42380f8445f4dcbd16,"a",@progbits
.Lalloc_6c17bac0c71cba42380f8445f4dcbd16:
	.ascii	"NotAPowerOfTwo"
	.size	.Lalloc_6c17bac0c71cba42380f8445f4dcbd16, 14

	.type	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu,"a",@progbits
	.p2align	3, 0x0
.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu:
	.ascii	"\005\f\013\013\004\016"
	.size	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu, 6

	.type	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel,"a",@progbits
	.p2align	2, 0x0
.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel:
	.long	.Lalloc_59ba7b9f7211443cd55a366616eef46a-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel
	.long	.Lalloc_00315c78e51d29fe6b3102a4c1ecf6ef-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel
	.long	.Lalloc_bd3a3f3879e0d5f64554753e977f58d4-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel
	.long	.Lalloc_0964bb2a4870637395c77a018495bd5c-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel
	.long	.Lalloc_6566120a3a17f930e960a0863fcbd591-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel
	.long	.Lalloc_6c17bac0c71cba42380f8445f4dcbd16-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel
	.size	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshoGEzlfe2Dr_3alu.26.rel, 24

	.hidden	DW.ref.rust_eh_personality
	.weak	DW.ref.rust_eh_personality
	.section	.data.DW.ref.rust_eh_personality,"awG",@progbits,DW.ref.rust_eh_personality,comdat
	.p2align	3, 0x0
	.type	DW.ref.rust_eh_personality,@object
	.size	DW.ref.rust_eh_personality, 8
DW.ref.rust_eh_personality:
	.quad	rust_eh_personality
	.ident	"rustc version 1.99.0-dev"
	.section	".note.GNU-stack","",@progbits
