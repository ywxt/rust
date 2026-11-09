	.att_syntax
	.file	"driver.15e1a5ac6b98e495-cgu.0"
	.section	.text._RINvNtCs341anU20NIK_3std2rt10lang_startuECs1StpruGFt5h_6driver,"ax",@progbits
	.hidden	_RINvNtCs341anU20NIK_3std2rt10lang_startuECs1StpruGFt5h_6driver
	.globl	_RINvNtCs341anU20NIK_3std2rt10lang_startuECs1StpruGFt5h_6driver
	.prefalign	4, .Lfunc_end0, nop
	.type	_RINvNtCs341anU20NIK_3std2rt10lang_startuECs1StpruGFt5h_6driver,@function
_RINvNtCs341anU20NIK_3std2rt10lang_startuECs1StpruGFt5h_6driver:
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
	.size	_RINvNtCs341anU20NIK_3std2rt10lang_startuECs1StpruGFt5h_6driver, .Lfunc_end0-_RINvNtCs341anU20NIK_3std2rt10lang_startuECs1StpruGFt5h_6driver
	.cfi_endproc

	.section	.text._RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver,"ax",@progbits
	.prefalign	4, .Lfunc_end1, nop
	.type	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver,@function
_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver:
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
	.size	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver, .Lfunc_end1-_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver
	.cfi_endproc

	.section	.text._RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECs1StpruGFt5h_6driver,"ax",@progbits
	.prefalign	4, .Lfunc_end2, nop
	.type	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECs1StpruGFt5h_6driver,@function
_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECs1StpruGFt5h_6driver:
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
	.size	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECs1StpruGFt5h_6driver, .Lfunc_end2-_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECs1StpruGFt5h_6driver
	.cfi_endproc

	.section	.text._RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs1StpruGFt5h_6driver,"ax",@progbits
	.prefalign	4, .Lfunc_end3, nop
	.type	_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs1StpruGFt5h_6driver,@function
_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs1StpruGFt5h_6driver:
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
	.size	_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs1StpruGFt5h_6driver, .Lfunc_end3-_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs1StpruGFt5h_6driver
	.cfi_endproc

	.section	.text.unlikely._RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs1StpruGFt5h_6driver,"ax",@progbits
	.prefalign	4, .Lfunc_end4, nop
	.type	_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs1StpruGFt5h_6driver,@function
_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs1StpruGFt5h_6driver:
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
	callq	_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs1StpruGFt5h_6driver
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
	.size	_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs1StpruGFt5h_6driver, .Lfunc_end4-_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs1StpruGFt5h_6driver
	.cfi_endproc

	.section	.text._RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cs1StpruGFt5h_6driver,"ax",@progbits
	.prefalign	4, .Lfunc_end5, nop
	.type	_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cs1StpruGFt5h_6driver,@function
_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cs1StpruGFt5h_6driver:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	(%rdi), %rdi
	callq	_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs1StpruGFt5h_6driver
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end5:
	.size	_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cs1StpruGFt5h_6driver, .Lfunc_end5-_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cs1StpruGFt5h_6driver
	.cfi_endproc

	.section	.text._RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCs1StpruGFt5h_6driver,"ax",@progbits
	.prefalign	4, .Lfunc_end6, nop
	.type	_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCs1StpruGFt5h_6driver,@function
_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCs1StpruGFt5h_6driver:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	(%rdi), %rdi
	callq	_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs1StpruGFt5h_6driver
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end6:
	.size	_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCs1StpruGFt5h_6driver, .Lfunc_end6-_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCs1StpruGFt5h_6driver
	.cfi_endproc

	.section	.text._RNvCs1StpruGFt5h_6driver10crate_find,"ax",@progbits
	.prefalign	4, .Lfunc_end7, nop
	.type	_RNvCs1StpruGFt5h_6driver10crate_find,@function
_RNvCs1StpruGFt5h_6driver10crate_find:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	movq	%rsi, %rbx
	addq	%rsi, %rdx
	movq	_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw2FN@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	callq	*%rax
	cmpq	$1, %rax
	jne	.LBB7_1
	subq	%rbx, %rdx
	movl	$1, %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.LBB7_1:
	.cfi_def_cfa_offset 16
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end7:
	.size	_RNvCs1StpruGFt5h_6driver10crate_find, .Lfunc_end7-_RNvCs1StpruGFt5h_6driver10crate_find
	.cfi_endproc

	.section	.text._RNvCs1StpruGFt5h_6driver4main,"ax",@progbits
	.hidden	_RNvCs1StpruGFt5h_6driver4main
	.globl	_RNvCs1StpruGFt5h_6driver4main
	.prefalign	4, .Lfunc_end8, nop
	.type	_RNvCs1StpruGFt5h_6driver4main,@function
_RNvCs1StpruGFt5h_6driver4main:
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
	subq	$376, %rsp
	.cfi_def_cfa_offset 432
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	leaq	8(%rsp), %rbx
	movq	%rbx, %rdi
	callq	*_RNvNtCs341anU20NIK_3std3env4args@GOTPCREL(%rip)
.Ltmp0:
	leaq	160(%rsp), %rdi
	movq	%rbx, %rsi
	callq	*_RNvXsc_NtCs341anU20NIK_3std3envNtB5_4ArgsNtNtNtNtCsc9NCSoc2doQ_4core4iter6traits8iterator8Iterator4next@GOTPCREL(%rip)
.Ltmp1:
	movq	160(%rsp), %r14
	cmpq	$-1, %r14
	je	.LBB8_244
	movq	168(%rsp), %r15
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	movq	%rax, %rcx
	shrq	$3, %rcx
	movabsq	$-6148914691236517205, %rdx
	imulq	%rdx, %rcx
	cmpq	$4, %rcx
	movl	$3, %ebp
	cmovaeq	%rcx, %rbp
	movabsq	$9223372036854775776, %rcx
	cmpq	%rcx, %rax
	jbe	.LBB8_5
	xorl	%r13d, %r13d
.LBB8_4:
.Ltmp75:
	movq	%r13, %rdi
	movq	%r12, %rsi
	callq	*_RNvNtCs3v2GDSbr0UZ_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Ltmp76:
	jmp	.LBB8_256
.LBB8_5:
	movq	176(%rsp), %rcx
	leaq	8(,%rbp,8), %rax
	leaq	(%rax,%rax,2), %r12
	testq	%r12, %r12
	je	.LBB8_8
	movq	%rcx, 40(%rsp)
	callq	*_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$8, %r13d
	movl	$8, %esi
	movq	%r12, %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB8_4
	movq	%rax, %rbx
	incq	%rbp
	movq	40(%rsp), %rcx
	jmp	.LBB8_9
.LBB8_8:
	movl	$8, %ebx
	xorl	%ebp, %ebp
.LBB8_9:
	movq	%r14, (%rbx)
	movq	%r15, 8(%rbx)
	movq	%rcx, 16(%rbx)
	movq	%rbp, 64(%rsp)
	movq	%rbx, 72(%rsp)
	movq	$1, 80(%rsp)
	movups	8(%rsp), %xmm0
	movups	24(%rsp), %xmm1
	movaps	%xmm1, 176(%rsp)
	movaps	%xmm0, 160(%rsp)
	movl	$1, %r14d
	movl	$40, %r12d
	leaq	160(%rsp), %rsi
	leaq	64(%rsp), %rax
	movq	%rax, 352(%rsp)
	jmp	.LBB8_12
	.p2align	4
.LBB8_10:
	movq	72(%rsp), %rbx
.LBB8_11:
	movq	%r13, -16(%rbx,%r12)
	movq	%rbp, -8(%rbx,%r12)
	movq	%r15, (%rbx,%r12)
	incq	%r14
	movq	%r14, 80(%rsp)
	addq	$24, %r12
	leaq	160(%rsp), %rsi
.LBB8_12:
.Ltmp3:
	leaq	112(%rsp), %rdi
	callq	*_RNvXsc_NtCs341anU20NIK_3std3envNtB5_4ArgsNtNtNtNtCsc9NCSoc2doQ_4core4iter6traits8iterator8Iterator4next@GOTPCREL(%rip)
.Ltmp4:
	movq	112(%rsp), %r13
	cmpq	$-1, %r13
	je	.LBB8_16
	movq	120(%rsp), %rbp
	movq	128(%rsp), %r15
	cmpq	64(%rsp), %r14
	jne	.LBB8_11
	movq	184(%rsp), %rdx
	subq	168(%rsp), %rdx
	shrq	$3, %rdx
	movabsq	$-6148914691236517205, %rax
	imulq	%rax, %rdx
	incq	%rdx
.Ltmp6:
	leaq	64(%rsp), %rdi
	movq	%r14, %rsi
	callq	_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs1StpruGFt5h_6driver
.Ltmp7:
	jmp	.LBB8_10
.LBB8_16:
	movq	168(%rsp), %r14
	movq	184(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r14, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	cmpq	%r14, %rcx
	je	.LBB8_21
	movq	%rdx, %rbx
	shrq	$4, %rbx
	addq	$8, %r14
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r15
	jmp	.LBB8_19
	.p2align	4
.LBB8_18:
	addq	$24, %r14
	decq	%rbx
	je	.LBB8_21
.LBB8_19:
	movq	-8(%r14), %rsi
	testq	%rsi, %rsi
	je	.LBB8_18
	movq	(%r14), %rdi
	movl	$1, %edx
	callq	*%r15
	jmp	.LBB8_18
.LBB8_21:
	movq	176(%rsp), %rax
	testq	%rax, %rax
	je	.LBB8_23
	movq	160(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB8_23:
	movups	64(%rsp), %xmm0
	movaps	%xmm0, 112(%rsp)
	movq	80(%rsp), %rsi
	movq	%rsi, 128(%rsp)
	cmpq	$2, %rsi
	jb	.LBB8_248
	movq	120(%rsp), %r12
	movq	40(%r12), %rax
	cmpq	$5, %rax
	jne	.LBB8_28
	movq	32(%r12), %rax
	movl	$1667590243, %ecx
	xorl	(%rax), %ecx
	movzbl	4(%rax), %edx
	xorl	$107, %edx
	orl	%ecx, %edx
	je	.LBB8_79
	movl	$1952543331, %ecx
	xorl	(%rax), %ecx
	movzbl	4(%rax), %eax
	xorl	$101, %eax
	orl	%ecx, %eax
	jne	.LBB8_226
	leaq	_RNvCs1StpruGFt5h_6driver10crate_find(%rip), %rax
	jmp	.LBB8_31
.LBB8_28:
	cmpq	$3, %rax
	jne	.LBB8_226
	movq	32(%r12), %rax
	movzwl	(%rax), %ecx
	xorl	$29811, %ecx
	movzbl	2(%rax), %eax
	xorl	$100, %eax
	orw	%cx, %ax
	jne	.LBB8_226
	leaq	_RNvCs1StpruGFt5h_6driver8std_find(%rip), %rax
.LBB8_31:
	movq	%rax, 144(%rsp)
	leaq	144(%rsp), %rax
	#APP
	#NO_APP
	cmpq	$2, %rsi
	je	.LBB8_253
	movq	56(%r12), %rcx
	movq	64(%r12), %rdi
	cmpq	$1, %rdi
	je	.LBB8_35
	testq	%rdi, %rdi
	je	.LBB8_257
	movzbl	(%rcx), %edx
	jmp	.LBB8_37
.LBB8_35:
	movzbl	(%rcx), %edx
	movb	$1, %al
	cmpl	$43, %edx
	je	.LBB8_214
	cmpl	$45, %edx
	je	.LBB8_214
.LBB8_37:
	xorl	%eax, %eax
	cmpb	$43, %dl
	sete	%al
	movq	%rdi, %rdx
	subq	%rax, %rdx
	addq	%rax, %rcx
	negq	%rax
	cmpq	$17, %rdx
	jae	.LBB8_42
	testq	%rdx, %rdx
	je	.LBB8_163
	addq	%rax, %rdi
	negq	%rdi
	xorl	%ebx, %ebx
	xorl	%eax, %eax
	.p2align	4
.LBB8_40:
	movzbl	(%rcx,%rax), %edx
	addl	$-48, %edx
	cmpl	$9, %edx
	ja	.LBB8_241
	leaq	(%rbx,%rbx,4), %r8
	movl	%edx, %edx
	leaq	(%rdx,%r8,2), %rbx
	incq	%rax
	movq	%rdi, %rdx
	addq	%rax, %rdx
	jne	.LBB8_40
	jmp	.LBB8_47
.LBB8_42:
	addq	%rax, %rdi
	negq	%rdi
	xorl	%ebx, %ebx
	movl	$10, %r8d
	xorl	%r9d, %r9d
	.p2align	4
.LBB8_43:
	movq	%rbx, %rax
	mulq	%r8
	movzbl	(%rcx,%r9), %edx
	jo	.LBB8_212
	addl	$-48, %edx
	cmpl	$10, %edx
	jae	.LBB8_241
	movq	%rax, %rbx
	movl	%edx, %eax
	addq	%rax, %rbx
	jb	.LBB8_213
	incq	%r9
	movq	%rdi, %rax
	addq	%r9, %rax
	jne	.LBB8_43
.LBB8_47:
	cmpq	$4, %rsi
	jb	.LBB8_164
.LBB8_48:
	movq	80(%r12), %rcx
	movq	88(%r12), %rdi
	cmpq	$1, %rdi
	je	.LBB8_51
	testq	%rdi, %rdi
	je	.LBB8_258
	movzbl	(%rcx), %edx
	jmp	.LBB8_53
.LBB8_51:
	movzbl	(%rcx), %edx
	movb	$1, %al
	cmpl	$43, %edx
	je	.LBB8_217
	cmpl	$45, %edx
	je	.LBB8_217
.LBB8_53:
	xorl	%eax, %eax
	cmpb	$43, %dl
	sete	%al
	movq	%rdi, %rdx
	subq	%rax, %rdx
	addq	%rax, %rcx
	negq	%rax
	cmpq	$17, %rdx
	jae	.LBB8_58
	testq	%rdx, %rdx
	je	.LBB8_165
	addq	%rax, %rdi
	negq	%rdi
	xorl	%r13d, %r13d
	xorl	%eax, %eax
	.p2align	4
.LBB8_56:
	movzbl	(%rcx,%rax), %edx
	addl	$-48, %edx
	cmpl	$9, %edx
	ja	.LBB8_242
	leaq	(,%r13,4), %r8
	addq	%r13, %r8
	movl	%edx, %edx
	leaq	(%rdx,%r8,2), %r13
	incq	%rax
	movq	%rdi, %rdx
	addq	%rax, %rdx
	jne	.LBB8_56
	jmp	.LBB8_63
.LBB8_58:
	addq	%rax, %rdi
	negq	%rdi
	xorl	%r13d, %r13d
	movl	$10, %r8d
	xorl	%r9d, %r9d
	.p2align	4
.LBB8_59:
	movq	%r13, %rax
	mulq	%r8
	movzbl	(%rcx,%r9), %edx
	jo	.LBB8_215
	addl	$-48, %edx
	cmpl	$10, %edx
	jae	.LBB8_242
	movq	%rax, %r13
	movl	%edx, %eax
	addq	%rax, %r13
	jb	.LBB8_216
	incq	%r9
	movq	%rdi, %rax
	addq	%r9, %rax
	jne	.LBB8_59
.LBB8_63:
	movq	%r13, 368(%rsp)
	cmpq	$6, %rsi
	jb	.LBB8_166
.LBB8_64:
	movq	128(%r12), %rcx
	movq	136(%r12), %rsi
	cmpq	$1, %rsi
	je	.LBB8_67
	testq	%rsi, %rsi
	je	.LBB8_259
	movzbl	(%rcx), %edx
	jmp	.LBB8_69
.LBB8_67:
	movzbl	(%rcx), %edx
	movb	$1, %al
	cmpl	$43, %edx
	je	.LBB8_220
	cmpl	$45, %edx
	je	.LBB8_220
.LBB8_69:
	xorl	%eax, %eax
	cmpb	$43, %dl
	sete	%al
	movq	%rsi, %rdx
	subq	%rax, %rdx
	addq	%rax, %rcx
	negq	%rax
	cmpq	$17, %rdx
	jae	.LBB8_74
	testq	%rdx, %rdx
	je	.LBB8_167
	addq	%rax, %rsi
	negq	%rsi
	xorl	%eax, %eax
	xorl	%edx, %edx
	.p2align	4
.LBB8_72:
	movzbl	(%rcx,%rdx), %edi
	addl	$-48, %edi
	cmpl	$9, %edi
	ja	.LBB8_243
	leaq	(%rax,%rax,4), %rax
	movl	%edi, %edi
	leaq	(%rdi,%rax,2), %rax
	incq	%rdx
	movq	%rsi, %rdi
	addq	%rdx, %rdi
	jne	.LBB8_72
	jmp	.LBB8_168
.LBB8_74:
	addq	%rax, %rsi
	negq	%rsi
	xorl	%eax, %eax
	movl	$10, %edi
	xorl	%r8d, %r8d
	.p2align	4
.LBB8_75:
	mulq	%rdi
	movzbl	(%rcx,%r8), %edx
	jo	.LBB8_218
	addl	$-48, %edx
	cmpl	$10, %edx
	jae	.LBB8_243
	movl	%edx, %edx
	addq	%rdx, %rax
	jb	.LBB8_219
	incq	%r8
	movq	%rsi, %rdx
	addq	%r8, %rdx
	jne	.LBB8_75
	jmp	.LBB8_168
.LBB8_79:
	movq	$0, 56(%rsp)
	movq	_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip), %rax
	xorl	%ebp, %ebp
	xorl	%r15d, %r15d
	xorl	%ebx, %ebx
	jmp	.LBB8_81
.LBB8_80:
	movl	$4352, %esi
	movl	$1, %edx
	movq	96(%rsp), %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	cmpb	$-1, %r15b
	movq	88(%rsp), %rbx
	movl	%ebx, %r15d
	movq	_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip), %rax
	je	.LBB8_210
.LBB8_81:
	callq	*%rax
	movl	$4352, %edi
	movl	$1, %esi
	incb	%bl
	jne	.LBB8_84
	callq	*_RNvCshVjSbrpHdcL_7___rustc19___rust_alloc_zeroed@GOTPCREL(%rip)
	movq	%rax, 96(%rsp)
	testq	%rax, %rax
	jne	.LBB8_86
	jmp	.LBB8_83
.LBB8_84:
	callq	*_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc@GOTPCREL(%rip)
	movq	%rax, 96(%rsp)
	testq	%rax, %rax
	je	.LBB8_83
	movzbl	%bl, %esi
	movl	$4352, %edx
	movq	96(%rsp), %rdi
	callq	*memset@GOTPCREL(%rip)
.LBB8_86:
	movq	%rbx, 88(%rsp)
	movq	$0, 160(%rsp)
	movq	$21, 168(%rsp)
	movq	$0, 176(%rsp)
	movq	$1, 184(%rsp)
	movq	$7, 192(%rsp)
	movq	$8, 200(%rsp)
	movq	$15, 208(%rsp)
	movq	$16, 216(%rsp)
	movq	$17, 224(%rsp)
	movq	$31, 232(%rsp)
	movq	$32, 240(%rsp)
	movq	$33, 248(%rsp)
	movq	$63, 256(%rsp)
	movq	$64, 264(%rsp)
	movq	$65, 272(%rsp)
	movq	$127, 280(%rsp)
	movq	$128, 288(%rsp)
	movq	$129, 296(%rsp)
	movq	$255, 304(%rsp)
	movq	$256, 312(%rsp)
	movq	$257, 320(%rsp)
	movq	$2551, 328(%rsp)
	movq	$4096, 336(%rsp)
	movzbl	%r15b, %eax
	movl	%eax, 40(%rsp)
	xorl	%eax, %eax
	jmp	.LBB8_88
	.p2align	4
.LBB8_87:
	movq	(%rsp), %rax
	cmpq	$21, %rax
	je	.LBB8_80
.LBB8_88:
	movq	176(%rsp,%rax,8), %r13
	incq	%rax
	movq	%rax, (%rsp)
	movq	%r13, %rax
	subq	$1, %rax
	jae	.LBB8_93
	xorl	%r14d, %r14d
	.p2align	4
.LBB8_90:
	movq	96(%rsp), %rax
	leaq	(%rax,%r14), %rbx
	movq	_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw2FN@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
.Ltmp65:
	movl	40(%rsp), %edi
	movq	%rbx, %rsi
	movq	%rbx, %rdx
	callq	*%rax
.Ltmp66:
	testb	$1, %al
	jne	.LBB8_232
	incq	%r14
	incq	%rbp
	movq	%rbp, 56(%rsp)
	cmpq	$64, %r14
	jne	.LBB8_90
	jmp	.LBB8_87
	.p2align	4
.LBB8_93:
	movq	%rax, 48(%rsp)
	movq	%r13, %rax
	shrq	%rax
	movq	%rax, 104(%rsp)
	movq	96(%rsp), %r14
	movq	%rbp, %r12
	xorl	%edi, %edi
	jmp	.LBB8_95
	.p2align	4
.LBB8_94:
	movq	360(%rsp), %rdi
	incq	%rdi
	incq	%r14
	movq	%rbp, %r12
	cmpq	$64, %rdi
	je	.LBB8_87
.LBB8_95:
	leaq	(%rdi,%r13), %rsi
	cmpq	$4353, %rsi
	jae	.LBB8_162
	movq	96(%rsp), %rax
	movq	%rdi, 360(%rsp)
	leaq	(%rax,%rdi), %rbx
	cmpq	$15, %r13
	ja	.LBB8_100
	xorl	%eax, %eax
	movq	_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw2FN@GOTPCREL(%rip), %rbp
	.p2align	4
.LBB8_98:
	cmpb	%r15b, (%r14,%rax)
	je	.LBB8_222
	incq	%rax
	cmpq	%rax, %r13
	jne	.LBB8_98
	jmp	.LBB8_102
	.p2align	4
.LBB8_100:
.Ltmp38:
	movl	40(%rsp), %edi
	movq	%rbx, %rsi
	movq	%r13, %rdx
	callq	*_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned@GOTPCREL(%rip)
.Ltmp39:
	movq	_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw2FN@GOTPCREL(%rip), %rbp
	movq	%rax, 8(%rsp)
	movq	%rdx, 16(%rsp)
	cmpq	$1, %rax
	je	.LBB8_262
.LBB8_102:
	leaq	(%rbx,%r13), %rdx
	movq	(%rbp), %rax
.Ltmp40:
	movl	40(%rsp), %edi
	movq	%rbx, %rsi
	callq	*%rax
.Ltmp41:
	testb	$1, %al
	jne	.LBB8_232
	leaq	1(%r12), %rax
	movq	%rax, 56(%rsp)
	movb	%r15b, (%rbx)
	cmpq	$15, %r13
	ja	.LBB8_110
	xorl	%edx, %edx
	.p2align	4
.LBB8_106:
	cmpb	%r15b, (%r14,%rdx)
	je	.LBB8_111
	incq	%rdx
	cmpq	%rdx, %r13
	jne	.LBB8_106
	jmp	.LBB8_108
	.p2align	4
.LBB8_110:
.Ltmp42:
	movl	40(%rsp), %edi
	movq	%rbx, %rsi
	movq	%r13, %rdx
	callq	*_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned@GOTPCREL(%rip)
.Ltmp43:
	jmp	.LBB8_112
	.p2align	4
.LBB8_111:
	movl	$1, %eax
.LBB8_112:
	movq	%rax, 64(%rsp)
	movq	%rdx, 72(%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	cmpq	$1, %rax
	jne	.LBB8_135
	testq	%rdx, %rdx
	jne	.LBB8_135
	movq	(%rbp), %rax
.Ltmp44:
	movl	40(%rsp), %edi
	movq	%rbx, %rsi
	leaq	(%rbx,%r13), %rdx
	callq	*%rax
.Ltmp45:
	cmpq	$1, %rax
	jne	.LBB8_235
	movq	$1, 64(%rsp)
	movq	$1, 8(%rsp)
	movq	$0, 16(%rsp)
	subq	%rbx, %rdx
	movq	%rdx, 72(%rsp)
	jne	.LBB8_260
	leaq	2(%r12), %rax
	movq	%rax, 56(%rsp)
	movq	88(%rsp), %rax
	movb	%al, (%rbx)
	movq	104(%rsp), %rax
	movb	%r15b, (%rbx,%rax)
	cmpq	$15, %r13
	ja	.LBB8_122
	xorl	%edx, %edx
	.p2align	4
.LBB8_119:
	cmpb	%r15b, (%r14,%rdx)
	je	.LBB8_123
	incq	%rdx
	cmpq	%rdx, %r13
	jne	.LBB8_119
	jmp	.LBB8_121
	.p2align	4
.LBB8_122:
.Ltmp46:
	movl	40(%rsp), %edi
	movq	%rbx, %rsi
	movq	%r13, %rdx
	callq	*_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned@GOTPCREL(%rip)
.Ltmp47:
	jmp	.LBB8_124
	.p2align	4
.LBB8_123:
	movl	$1, %eax
.LBB8_124:
	movq	%rax, 64(%rsp)
	movq	%rdx, 72(%rsp)
	movq	$1, 8(%rsp)
	movq	104(%rsp), %rcx
	movq	%rcx, 16(%rsp)
	cmpq	$1, %rax
	jne	.LBB8_135
	cmpq	%rcx, %rdx
	jne	.LBB8_135
	movq	(%rbp), %rax
.Ltmp48:
	movl	40(%rsp), %edi
	movq	%rbx, %rsi
	leaq	(%rbx,%r13), %rdx
	callq	*%rax
.Ltmp49:
	cmpq	$1, %rax
	jne	.LBB8_234
	subq	%rbx, %rdx
	movq	$1, 64(%rsp)
	movq	%rdx, 72(%rsp)
	movq	$1, 8(%rsp)
	movq	104(%rsp), %rcx
	movq	%rcx, 16(%rsp)
	cmpq	%rcx, %rdx
	jne	.LBB8_260
	leaq	3(%r12), %rax
	movq	%rax, 56(%rsp)
	movq	88(%rsp), %rax
	movb	%al, (%rbx,%rcx)
	movq	48(%rsp), %rax
	movb	%r15b, (%rbx,%rax)
	cmpq	$15, %r13
	ja	.LBB8_137
	xorl	%edx, %edx
	.p2align	4
.LBB8_131:
	cmpb	%r15b, (%r14,%rdx)
	je	.LBB8_138
	incq	%rdx
	cmpq	%rdx, %r13
	jne	.LBB8_131
	jmp	.LBB8_133
	.p2align	4
.LBB8_137:
.Ltmp50:
	movl	40(%rsp), %edi
	movq	%rbx, %rsi
	movq	%r13, %rdx
	callq	*_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned@GOTPCREL(%rip)
.Ltmp51:
	jmp	.LBB8_139
	.p2align	4
.LBB8_138:
	movl	$1, %eax
.LBB8_139:
	movq	%rax, 64(%rsp)
	movq	%rdx, 72(%rsp)
	movq	$1, 8(%rsp)
	movq	48(%rsp), %rcx
	movq	%rcx, 16(%rsp)
	cmpq	$1, %rax
	jne	.LBB8_135
	cmpq	%rcx, %rdx
	jne	.LBB8_135
	movq	(%rbp), %rax
.Ltmp52:
	movl	40(%rsp), %edi
	movq	%rbx, %rsi
	leaq	(%rbx,%r13), %rdx
	callq	*%rax
.Ltmp53:
	cmpq	$1, %rax
	jne	.LBB8_236
	subq	%rbx, %rdx
	movq	$1, 64(%rsp)
	movq	%rdx, 72(%rsp)
	movq	$1, 8(%rsp)
	movq	48(%rsp), %rcx
	movq	%rcx, 16(%rsp)
	cmpq	%rcx, %rdx
	jne	.LBB8_260
	leaq	4(%r12), %rbp
	movq	%rbp, 56(%rsp)
	movq	88(%rsp), %rax
	movb	%al, (%rbx,%rcx)
	cmpq	$2, %r13
	jbe	.LBB8_94
	movb	%r15b, 1(%rbx)
	movb	%r15b, (%rbx,%rcx)
	cmpq	$15, %r13
	ja	.LBB8_150
	xorl	%edx, %edx
	movq	_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw2FN@GOTPCREL(%rip), %rsi
	.p2align	4
.LBB8_147:
	cmpb	%r15b, (%r14,%rdx)
	je	.LBB8_151
	incq	%rdx
	cmpq	%rdx, %r13
	jne	.LBB8_147
	jmp	.LBB8_149
	.p2align	4
.LBB8_150:
.Ltmp58:
	movl	40(%rsp), %edi
	movq	%rbx, %rsi
	movq	%r13, %rdx
	callq	*_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned@GOTPCREL(%rip)
.Ltmp59:
	movq	_RNvNvNtNtNtCs8jZOguSIGf0_6memchr4arch6x86_646memchr10memchr_raw2FN@GOTPCREL(%rip), %rsi
	jmp	.LBB8_152
	.p2align	4
.LBB8_151:
	movl	$1, %eax
.LBB8_152:
	movq	%rax, 8(%rsp)
	movq	%rdx, 16(%rsp)
	cmpq	$1, %rdx
	sete	%cl
	testb	$1, %al
	je	.LBB8_158
	testb	%cl, %cl
	je	.LBB8_159
.LBB8_154:
	movq	(%rsi), %rax
.Ltmp60:
	movl	40(%rsp), %edi
	movq	%rbx, %rsi
	leaq	(%rbx,%r13), %rdx
	callq	*%rax
.Ltmp61:
	testb	$1, %al
	je	.LBB8_240
	subq	%rbx, %rdx
	movq	$1, 8(%rsp)
	movq	%rdx, 16(%rsp)
	cmpq	$1, %rdx
	jne	.LBB8_261
	addq	$5, %r12
	movq	%r12, 56(%rsp)
	movq	88(%rsp), %rax
	movb	%al, 1(%rbx)
	movq	48(%rsp), %rcx
	movb	%al, (%rbx,%rcx)
	movq	%r12, %rbp
	jmp	.LBB8_94
.LBB8_158:
	xorl	%ecx, %ecx
	testb	%cl, %cl
	jne	.LBB8_154
.LBB8_159:
	movq	(%rsp), %rax
	movq	%rax, 160(%rsp)
	jmp	.LBB8_160
.LBB8_162:
	movq	(%rsp), %rax
	movq	%rax, 160(%rsp)
.Ltmp63:
	leaq	.Lalloc_f2adc74b1f56daa88b0b65f22487c555(%rip), %rcx
	movl	$4352, %edx
	callq	*_RNvNtNtCsc9NCSoc2doQ_4core5slice5index16slice_index_fail@GOTPCREL(%rip)
.Ltmp64:
	jmp	.LBB8_256
.LBB8_163:
	xorl	%ebx, %ebx
	cmpq	$4, %rsi
	jae	.LBB8_48
.LBB8_164:
	leaq	.Lalloc_91bb3c8e2e46ccbc16597808f0bab401(%rip), %rdx
	movl	$3, %edi
	movl	$3, %esi
	jmp	.LBB8_254
.LBB8_165:
	xorl	%r13d, %r13d
	movq	%r13, 368(%rsp)
	cmpq	$6, %rsi
	jae	.LBB8_64
.LBB8_166:
	leaq	.Lalloc_430a626d7ad8fa09ca7e11f1cb9a43c6(%rip), %rdx
	movl	$5, %edi
	jmp	.LBB8_254
.LBB8_167:
	xorl	%eax, %eax
.LBB8_168:
	movq	%rax, 152(%rsp)
	callq	*_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$131200, %edi
	movl	$64, %esi
	callq	*_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB8_227
	movq	%rax, %r14
	movl	$131200, %edx
	movq	%rax, %rdi
	movl	$128, %esi
	callq	*memset@GOTPCREL(%rip)
	movq	104(%r12), %rax
	movq	112(%r12), %rcx
	cmpq	$5, %rcx
	je	.LBB8_174
	cmpq	$6, %rcx
	jne	.LBB8_176
	movl	$1702060641, %ecx
	xorl	(%rax), %ecx
	movzwl	4(%rax), %edx
	xorl	$29806, %edx
	orl	%ecx, %edx
	je	.LBB8_208
	movl	$1684302189, %ecx
	xorl	(%rax), %ecx
	movzwl	4(%rax), %eax
	xorl	$25964, %eax
	orl	%ecx, %eax
	jne	.LBB8_233
	movq	%rbx, %rax
	shrq	%rax
	jmp	.LBB8_179
.LBB8_174:
	movl	$1852797542, %ecx
	xorl	(%rax), %ecx
	movzbl	4(%rax), %eax
	xorl	$116, %eax
	orl	%ecx, %eax
	jne	.LBB8_233
	movq	$1, 64(%rsp)
	movq	$0, 72(%rsp)
	xorl	%eax, %eax
	jmp	.LBB8_180
.LBB8_176:
	cmpq	$4, %rcx
	jne	.LBB8_233
	cmpl	$1953718636, (%rax)
	jne	.LBB8_233
	leaq	-1(%rbx), %rax
.LBB8_179:
	movq	%rax, 72(%rsp)
	movq	$1, 64(%rsp)
.LBB8_180:
	movq	%rax, 48(%rsp)
	leaq	(%rax,%r13), %rdi
	cmpq	$131200, %rdi
	jae	.LBB8_255
	movb	$-1, (%r14,%rdi)
	movb	$1, %al
	movl	%eax, 40(%rsp)
	xorl	%r15d, %r15d
	leaq	(%rbx,%r13), %rsi
	cmpq	%r13, %rsi
	jb	.LBB8_209
.LBB8_182:
	cmpq	$131201, %rsi
	jae	.LBB8_209
	movq	%r14, %rbp
	addq	%r13, %rbp
	movl	%ebp, %eax
	andl	$63, %eax
	movq	%rax, 160(%rsp)
	cmpq	%r13, %rax
	jne	.LBB8_228
.Ltmp17:
	movl	$255, %edi
	movq	%rbp, %rsi
	movq	%rbx, %rdx
	callq	*144(%rsp)
.Ltmp18:
	movq	%rax, 160(%rsp)
	movq	%rdx, 168(%rsp)
	cmpq	$1, %rax
	jne	.LBB8_189
	cmpq	48(%rsp), %rdx
	sete	%al
	cmpb	$0, 40(%rsp)
	je	.LBB8_229
	testb	%al, %al
	jne	.LBB8_190
.LBB8_188:
.Ltmp19:
	leaq	.Lalloc_33f467d265e61babc7c5951f1b7a303c(%rip), %r9
	leaq	160(%rsp), %rsi
	leaq	64(%rsp), %rdx
	xorl	%edi, %edi
	xorl	%ecx, %ecx
	callq	*_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedINtNtB4_6option6OptionjEBM_EB4_@GOTPCREL(%rip)
.Ltmp20:
	jmp	.LBB8_256
.LBB8_189:
	testb	%r15b, %r15b
	je	.LBB8_188
.LBB8_190:
	movq	%r14, 88(%rsp)
	movl	$1000, %r14d
	leaq	8(%rsp), %r15
	leaq	160(%rsp), %r13
	.p2align	4
.LBB8_191:
	movb	$-1, 8(%rsp)
	#APP
	#NO_APP
	movq	%rbp, 160(%rsp)
	movq	%rbx, 168(%rsp)
	#APP
	#NO_APP
	movq	160(%rsp), %rsi
	movq	168(%rsp), %rdx
	movzbl	8(%rsp), %edi
.Ltmp21:
	callq	*144(%rsp)
.Ltmp22:
	movq	%rax, 8(%rsp)
	movq	%rdx, 16(%rsp)
	#APP
	#NO_APP
	decl	%r14d
	jne	.LBB8_191
	movq	%r12, 104(%rsp)
	movq	$0, 56(%rsp)
	cmpq	$0, 152(%rsp)
	je	.LBB8_197
	leaq	8(%rsp), %r14
	xorl	%r12d, %r12d
	xorl	%r15d, %r15d
	.p2align	4
.LBB8_195:
	movb	$-1, 8(%rsp)
	#APP
	#NO_APP
	movq	%rbp, 160(%rsp)
	movq	%rbx, 168(%rsp)
	leaq	160(%rsp), %rax
	#APP
	#NO_APP
	movq	160(%rsp), %rsi
	movq	168(%rsp), %rdx
	movzbl	8(%rsp), %edi
.Ltmp24:
	callq	*144(%rsp)
.Ltmp25:
	incq	%r15
	movq	%rax, 8(%rsp)
	movq	%rdx, 16(%rsp)
	#APP
	#NO_APP
	movq	16(%rsp), %rax
	incq	%rax
	cmpb	$0, 8(%rsp)
	movl	$0, %ecx
	cmoveq	%rcx, %rax
	addq	%rax, %r12
	movq	%r12, 56(%rsp)
	movq	152(%rsp), %rax
	cmpq	%rax, %r15
	jb	.LBB8_195
	jmp	.LBB8_198
.LBB8_197:
	xorl	%r12d, %r12d
	xorl	%eax, %eax
.LBB8_198:
	movq	48(%rsp), %rcx
	incq	%rcx
	imulq	%rax, %rcx
	xorl	%eax, %eax
	cmpb	$0, 40(%rsp)
	cmovneq	%rcx, %rax
	movq	%rax, 160(%rsp)
	cmpq	%rax, %r12
	jne	.LBB8_230
	leaq	152(%rsp), %rax
	movq	%rax, 160(%rsp)
	movq	_RNvXsi_NtNtNtCsc9NCSoc2doQ_4core3fmt3num3impjNtB9_7Display3fmt@GOTPCREL(%rip), %rax
	movq	%rax, 168(%rsp)
	leaq	56(%rsp), %rcx
	movq	%rcx, 176(%rsp)
	movq	%rax, 184(%rsp)
.Ltmp29:
	leaq	.Lalloc_ea7a11d758a5a3d2649481fea54771bb(%rip), %rdi
	leaq	160(%rsp), %rsi
	movq	88(%rsp), %r14
	callq	*_RNvNtNtCs341anU20NIK_3std2io5stdio6__print@GOTPCREL(%rip)
.Ltmp30:
	movq	104(%rsp), %r12
	movl	$131200, %esi
	movl	$64, %edx
	movq	%r14, %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	movq	128(%rsp), %rbx
	testq	%rbx, %rbx
	je	.LBB8_205
	leaq	8(%r12), %r14
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r15
	jmp	.LBB8_203
	.p2align	4
.LBB8_202:
	addq	$24, %r14
	decq	%rbx
	je	.LBB8_205
.LBB8_203:
	movq	-8(%r14), %rsi
	testq	%rsi, %rsi
	je	.LBB8_202
	movq	(%r14), %rdi
	movl	$1, %edx
	callq	*%r15
	jmp	.LBB8_202
.LBB8_205:
	movq	112(%rsp), %rax
	testq	%rax, %rax
	je	.LBB8_207
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	movq	%r12, %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB8_207:
	addq	$376, %rsp
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
.LBB8_208:
	.cfi_def_cfa_offset 432
	movq	$0, 64(%rsp)
	movb	$1, %r15b
	movl	$0, 40(%rsp)
	leaq	(%rbx,%r13), %rsi
	cmpq	%r13, %rsi
	jae	.LBB8_182
.LBB8_209:
.Ltmp15:
	leaq	.Lalloc_62b520d5cd86147517119ea4db494764(%rip), %rcx
	movl	$131200, %edx
	movq	%r13, %rdi
	callq	*_RNvNtNtCsc9NCSoc2doQ_4core5slice5index16slice_index_fail@GOTPCREL(%rip)
.Ltmp16:
	jmp	.LBB8_256
.LBB8_210:
	leaq	56(%rsp), %rax
	movq	%rax, 160(%rsp)
	movq	_RNvXsi_NtNtNtCsc9NCSoc2doQ_4core3fmt3num3impjNtB9_7Display3fmt@GOTPCREL(%rip), %rax
	movq	%rax, 168(%rsp)
.Ltmp68:
	leaq	.Lalloc_5563914751c9051696d34dc682afe217(%rip), %rdi
	leaq	160(%rsp), %rsi
	callq	*_RNvNtNtCs341anU20NIK_3std2io5stdio6__print@GOTPCREL(%rip)
.Ltmp69:
	leaq	112(%rsp), %rdi
	callq	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver
	jmp	.LBB8_207
.LBB8_212:
	addb	$-48, %dl
	xorl	%eax, %eax
	cmpb	$10, %dl
	adcb	$1, %al
	jmp	.LBB8_214
.LBB8_213:
	movb	$2, %al
.LBB8_214:
	movb	%al, 160(%rsp)
	leaq	.Lalloc_0466fbcb6efd6e27b2f9ddb5c8bd67bf(%rip), %r8
	jmp	.LBB8_221
.LBB8_215:
	addb	$-48, %dl
	xorl	%eax, %eax
	cmpb	$10, %dl
	adcb	$1, %al
	jmp	.LBB8_217
.LBB8_216:
	movb	$2, %al
.LBB8_217:
	movb	%al, 160(%rsp)
	leaq	.Lalloc_5c213bcbaef43ebb221d4146a2acfd23(%rip), %r8
	jmp	.LBB8_221
.LBB8_218:
	addb	$-48, %dl
	xorl	%eax, %eax
	cmpb	$10, %dl
	adcb	$1, %al
	jmp	.LBB8_220
.LBB8_219:
	movb	$2, %al
.LBB8_220:
	movb	%al, 160(%rsp)
	leaq	.Lalloc_e2a94c7f70cdaf98936bf1e119b31d15(%rip), %r8
.LBB8_221:
	leaq	160(%rsp), %rdx
.Ltmp11:
	leaq	.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274(%rip), %rdi
	leaq	.Lvtable.1(%rip), %rcx
	movl	$43, %esi
	callq	*_RNvNtCsc9NCSoc2doQ_4core6result13unwrap_failed@GOTPCREL(%rip)
.Ltmp12:
	jmp	.LBB8_256
.LBB8_222:
	movq	(%rsp), %rcx
	movq	%rcx, 160(%rsp)
	movq	$1, 8(%rsp)
	movq	%rax, 16(%rsp)
.LBB8_223:
	leaq	.Lalloc_9e293b1cd83d8f2c3d64145f659adffa(%rip), %r9
.LBB8_224:
	leaq	.Lalloc_8e81dfbcb5e45a532aa30c8331b0b47e(%rip), %rdx
	jmp	.LBB8_225
.LBB8_108:
	xorl	%eax, %eax
	jmp	.LBB8_109
.LBB8_121:
	movq	104(%rsp), %rax
.LBB8_109:
	movq	48(%rsp), %rcx
	jmp	.LBB8_134
.LBB8_133:
	movq	48(%rsp), %rcx
	movq	%rcx, %rax
.LBB8_134:
	movq	$0, 64(%rsp)
	movq	%rcx, 72(%rsp)
	movq	$1, 8(%rsp)
	movq	%rax, 16(%rsp)
.LBB8_135:
	leaq	8(%rsp), %rdx
	leaq	.Lalloc_f6eff4434d88d939ba74cb3c7aa163d7(%rip), %r9
.LBB8_136:
	movq	(%rsp), %rax
.LBB8_239:
	movq	%rax, 160(%rsp)
.Ltmp55:
	xorl	%edi, %edi
	movq	352(%rsp), %rsi
	xorl	%ecx, %ecx
	callq	*_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedINtNtB4_6option6OptionjEBM_EB4_@GOTPCREL(%rip)
.Ltmp56:
	jmp	.LBB8_256
.LBB8_149:
	movq	(%rsp), %rax
	movq	%rax, 160(%rsp)
	movq	$0, 8(%rsp)
	movq	48(%rsp), %rax
	movq	%rax, 16(%rsp)
.LBB8_160:
	leaq	.Lalloc_9a88f186c58a52ebd3ead6ae60a6ebb4(%rip), %r9
.LBB8_161:
	leaq	.Lalloc_018282178791e8a09b18fbb1ed888779(%rip), %rdx
.LBB8_225:
	leaq	8(%rsp), %rsi
.Ltmp70:
	xorl	%edi, %edi
	xorl	%ecx, %ecx
	callq	*_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedINtNtB4_6option6OptionjEBM_EB4_@GOTPCREL(%rip)
.Ltmp71:
	jmp	.LBB8_256
.LBB8_226:
.Ltmp9:
	leaq	.Lalloc_476509aa7047bd805d630c6546685797(%rip), %rdi
	leaq	.Lalloc_1cd847217f7fad949c219121493e6692(%rip), %rdx
	movl	$14, %esi
	callq	*_RNvNtCsc9NCSoc2doQ_4core9panicking5panic@GOTPCREL(%rip)
.Ltmp10:
	jmp	.LBB8_256
.LBB8_227:
.Ltmp34:
	movl	$64, %edi
	movl	$131200, %esi
	callq	*_RNvNtCs3v2GDSbr0UZ_5alloc5alloc18handle_alloc_error@GOTPCREL(%rip)
.Ltmp35:
	jmp	.LBB8_256
.LBB8_228:
	leaq	.Lalloc_e606c281df34283ee24a24505deb5779(%rip), %r9
	leaq	368(%rsp), %r13
	leaq	160(%rsp), %rsi
	jmp	.LBB8_231
.LBB8_229:
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB8_190
	jmp	.LBB8_188
.LBB8_230:
	leaq	.Lalloc_c14e8c434fcc3b92ba63da8be42f0c60(%rip), %r9
	leaq	56(%rsp), %rsi
	movq	88(%rsp), %r14
.LBB8_231:
.Ltmp27:
	xorl	%edi, %edi
	movq	%r13, %rdx
	xorl	%ecx, %ecx
	callq	*_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedjjEB4_@GOTPCREL(%rip)
.Ltmp28:
	jmp	.LBB8_256
.LBB8_232:
	subq	%rbx, %rdx
	movq	(%rsp), %rax
	movq	%rax, 160(%rsp)
	movq	$1, 8(%rsp)
	movq	%rdx, 16(%rsp)
	leaq	.Lalloc_63fa703696994748cc44a0c124173934(%rip), %r9
	jmp	.LBB8_224
.LBB8_233:
.Ltmp31:
	leaq	.Lalloc_476509aa7047bd805d630c6546685797(%rip), %rdi
	leaq	.Lalloc_a9a7dce65c6d1c57d540b735479f6251(%rip), %rdx
	movl	$14, %esi
	callq	*_RNvNtCsc9NCSoc2doQ_4core9panicking5panic@GOTPCREL(%rip)
.Ltmp32:
	jmp	.LBB8_256
.LBB8_234:
	leaq	8(%rsp), %rdx
	movq	(%rsp), %rax
	movq	104(%rsp), %rcx
	jmp	.LBB8_238
.LBB8_235:
	xorl	%ecx, %ecx
	jmp	.LBB8_237
.LBB8_236:
	movq	48(%rsp), %rcx
.LBB8_237:
	leaq	8(%rsp), %rdx
	movq	(%rsp), %rax
.LBB8_238:
	movq	$0, 64(%rsp)
	movq	$1, 8(%rsp)
	movq	%rcx, 16(%rsp)
	leaq	.Lalloc_5cb5418a67bcd818f2b2b52e16b6c0ca(%rip), %r9
	jmp	.LBB8_239
.LBB8_240:
	movq	(%rsp), %rax
	movq	%rax, 160(%rsp)
	movq	$0, 8(%rsp)
	leaq	.Lalloc_7e7ae35d6636461e2066d261a89d0d5e(%rip), %r9
	jmp	.LBB8_161
.LBB8_241:
	movb	$1, %al
	jmp	.LBB8_214
.LBB8_242:
	movb	$1, %al
	jmp	.LBB8_217
.LBB8_243:
	movb	$1, %al
	jmp	.LBB8_220
.LBB8_244:
	movq	16(%rsp), %r14
	movq	32(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r14, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	movq	$0, 112(%rsp)
	movq	$8, 120(%rsp)
	movq	$0, 128(%rsp)
	cmpq	%r14, %rcx
	jne	.LBB8_249
.LBB8_245:
	movq	24(%rsp), %rax
	testq	%rax, %rax
	je	.LBB8_247
	movq	8(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB8_247:
	xorl	%esi, %esi
.LBB8_248:
.Ltmp78:
	leaq	.Lalloc_76cbd47331a82c9bea1da249cd622be9(%rip), %rdx
	movl	$1, %edi
	callq	*_RNvNtCsc9NCSoc2doQ_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.Ltmp79:
	jmp	.LBB8_256
.LBB8_249:
	movq	%rdx, %rbx
	shrq	$4, %rbx
	addq	$8, %r14
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r15
	jmp	.LBB8_251
	.p2align	4
.LBB8_250:
	addq	$24, %r14
	decq	%rbx
	je	.LBB8_245
.LBB8_251:
	movq	-8(%r14), %rsi
	testq	%rsi, %rsi
	je	.LBB8_250
	movq	(%r14), %rdi
	movl	$1, %edx
	callq	*%r15
	jmp	.LBB8_250
.LBB8_253:
	leaq	.Lalloc_97f20d6aba9b53792d2804ec8a9b80db(%rip), %rdx
	movl	$2, %edi
	movl	$2, %esi
.LBB8_254:
.Ltmp36:
	callq	*_RNvNtCsc9NCSoc2doQ_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.Ltmp37:
	jmp	.LBB8_256
.LBB8_255:
.Ltmp13:
	leaq	.Lalloc_fee2473f5ebd52e53d5ac249e1622a16(%rip), %rdx
	movl	$131200, %esi
	callq	*_RNvNtCsc9NCSoc2doQ_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.Ltmp14:
	jmp	.LBB8_256
.LBB8_83:
.Ltmp73:
	movl	$1, %edi
	movl	$4352, %esi
	callq	*_RNvNtCs3v2GDSbr0UZ_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Ltmp74:
.LBB8_256:
	ud2
.LBB8_257:
	xorl	%eax, %eax
	jmp	.LBB8_214
.LBB8_258:
	xorl	%eax, %eax
	jmp	.LBB8_217
.LBB8_259:
	xorl	%eax, %eax
	jmp	.LBB8_220
.LBB8_260:
	leaq	.Lalloc_5cb5418a67bcd818f2b2b52e16b6c0ca(%rip), %r9
	leaq	8(%rsp), %rdx
	jmp	.LBB8_136
.LBB8_261:
	movq	(%rsp), %rax
	movq	%rax, 160(%rsp)
	leaq	.Lalloc_7e7ae35d6636461e2066d261a89d0d5e(%rip), %r9
	jmp	.LBB8_161
.LBB8_262:
	movq	(%rsp), %rax
	movq	%rax, 160(%rsp)
	jmp	.LBB8_223
.LBB8_263:
.Ltmp2:
	movq	%rax, %rbx
	jmp	.LBB8_292
.LBB8_264:
.Ltmp26:
	jmp	.LBB8_268
.LBB8_265:
.Ltmp8:
	movq	%rax, %rbx
	testq	%r13, %r13
	je	.LBB8_270
	movl	$1, %edx
	movq	%rbp, %rdi
	movq	%r13, %rsi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	jmp	.LBB8_270
.LBB8_267:
.Ltmp23:
.LBB8_268:
	movq	%rax, %rbx
	movq	88(%rsp), %r14
	jmp	.LBB8_276
.LBB8_269:
.Ltmp5:
	movq	%rax, %rbx
.LBB8_270:
	leaq	160(%rsp), %rdi
	callq	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECs1StpruGFt5h_6driver
	leaq	64(%rsp), %rdi
	callq	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs1StpruGFt5h_6driver
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.LBB8_271:
.Ltmp67:
	jmp	.LBB8_274
.LBB8_272:
.Ltmp62:
	jmp	.LBB8_274
.LBB8_273:
.Ltmp54:
.LBB8_274:
	movq	%rax, %rbx
	movq	(%rsp), %rax
	movq	%rax, 160(%rsp)
	jmp	.LBB8_281
.LBB8_275:
.Ltmp33:
	movq	%rax, %rbx
.LBB8_276:
	movl	$131200, %esi
	movl	$64, %edx
	movq	%r14, %rdi
	jmp	.LBB8_282
.LBB8_277:
.Ltmp57:
	jmp	.LBB8_280
.LBB8_278:
.Ltmp80:
	movq	%rax, %rbx
	jmp	.LBB8_283
.LBB8_279:
.Ltmp72:
.LBB8_280:
	movq	%rax, %rbx
.LBB8_281:
	movl	$4352, %esi
	movl	$1, %edx
	movq	96(%rsp), %rdi
.LBB8_282:
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB8_283:
	movq	120(%rsp), %r14
	movq	128(%rsp), %r15
	testq	%r15, %r15
	jne	.LBB8_286
.LBB8_284:
	movq	112(%rsp), %rax
	testq	%rax, %rax
	je	.LBB8_294
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	movq	%r14, %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.LBB8_286:
	leaq	8(%r14), %r12
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r13
	jmp	.LBB8_288
	.p2align	4
.LBB8_287:
	addq	$24, %r12
	decq	%r15
	je	.LBB8_284
.LBB8_288:
	movq	-8(%r12), %rsi
	testq	%rsi, %rsi
	je	.LBB8_287
	movq	(%r12), %rdi
	movl	$1, %edx
	callq	*%r13
	jmp	.LBB8_287
.LBB8_290:
.Ltmp77:
	movq	%rax, %rbx
	testq	%r14, %r14
	je	.LBB8_292
	movl	$1, %edx
	movq	%r15, %rdi
	movq	%r14, %rsi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB8_292:
	movq	16(%rsp), %r15
	movq	32(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r15, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	cmpq	%r15, %rcx
	jne	.LBB8_295
.LBB8_293:
	movq	24(%rsp), %rax
	testq	%rax, %rax
	jne	.LBB8_299
.LBB8_294:
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.LBB8_295:
	movq	%rdx, %r14
	shrq	$4, %r14
	addq	$8, %r15
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r12
	jmp	.LBB8_297
	.p2align	4
.LBB8_296:
	addq	$24, %r15
	decq	%r14
	je	.LBB8_293
.LBB8_297:
	movq	-8(%r15), %rsi
	testq	%rsi, %rsi
	je	.LBB8_296
	movq	(%r15), %rdi
	movl	$1, %edx
	callq	*%r12
	jmp	.LBB8_296
.LBB8_299:
	movq	8(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
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
	.uleb128 .Ltmp75-.Lfunc_begin0
	.uleb128 .Ltmp76-.Ltmp75
	.uleb128 .Ltmp77-.Lfunc_begin0
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
	.uleb128 .Ltmp65-.Ltmp7
	.byte	0
	.byte	0
	.uleb128 .Ltmp65-.Lfunc_begin0
	.uleb128 .Ltmp66-.Ltmp65
	.uleb128 .Ltmp67-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp38-.Lfunc_begin0
	.uleb128 .Ltmp41-.Ltmp38
	.uleb128 .Ltmp62-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp42-.Lfunc_begin0
	.uleb128 .Ltmp53-.Ltmp42
	.uleb128 .Ltmp54-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp58-.Lfunc_begin0
	.uleb128 .Ltmp61-.Ltmp58
	.uleb128 .Ltmp62-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp63-.Lfunc_begin0
	.uleb128 .Ltmp64-.Ltmp63
	.uleb128 .Ltmp72-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp64-.Lfunc_begin0
	.uleb128 .Ltmp17-.Ltmp64
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
	.uleb128 .Ltmp15-.Ltmp30
	.byte	0
	.byte	0
	.uleb128 .Ltmp15-.Lfunc_begin0
	.uleb128 .Ltmp16-.Ltmp15
	.uleb128 .Ltmp33-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp68-.Lfunc_begin0
	.uleb128 .Ltmp12-.Ltmp68
	.uleb128 .Ltmp80-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp55-.Lfunc_begin0
	.uleb128 .Ltmp56-.Ltmp55
	.uleb128 .Ltmp57-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp70-.Lfunc_begin0
	.uleb128 .Ltmp71-.Ltmp70
	.uleb128 .Ltmp72-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp9-.Lfunc_begin0
	.uleb128 .Ltmp35-.Ltmp9
	.uleb128 .Ltmp80-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp27-.Lfunc_begin0
	.uleb128 .Ltmp32-.Ltmp27
	.uleb128 .Ltmp33-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp78-.Lfunc_begin0
	.uleb128 .Ltmp79-.Ltmp78
	.uleb128 .Ltmp80-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp79-.Lfunc_begin0
	.uleb128 .Ltmp36-.Ltmp79
	.byte	0
	.byte	0
	.uleb128 .Ltmp36-.Lfunc_begin0
	.uleb128 .Ltmp37-.Ltmp36
	.uleb128 .Ltmp80-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp13-.Lfunc_begin0
	.uleb128 .Ltmp14-.Ltmp13
	.uleb128 .Ltmp33-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp73-.Lfunc_begin0
	.uleb128 .Ltmp74-.Ltmp73
	.uleb128 .Ltmp80-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp74-.Lfunc_begin0
	.uleb128 .Lfunc_end8-.Ltmp74
	.byte	0
	.byte	0
.Lcst_end0:
	.p2align	2, 0x0

	.section	.text._RNvCs1StpruGFt5h_6driver8std_find,"ax",@progbits
	.prefalign	4, .Lfunc_end9, nop
	.type	_RNvCs1StpruGFt5h_6driver8std_find,@function
_RNvCs1StpruGFt5h_6driver8std_find:
	.cfi_startproc
	movq	%rdx, %rcx
	cmpq	$15, %rdx
	ja	.LBB9_3
	xorl	%eax, %eax
	testq	%rcx, %rcx
	je	.LBB9_2
	xorl	%r8d, %r8d
	.p2align	4
.LBB9_6:
	movq	%r8, %rdx
	cmpb	%dil, (%rsi,%r8)
	je	.LBB9_7
	leaq	1(%rdx), %r8
	cmpq	%r8, %rcx
	jne	.LBB9_6
	retq
.LBB9_3:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movzbl	%dil, %edi
	movq	%rcx, %rdx
	callq	*_RNvNtNtCsc9NCSoc2doQ_4core5slice6memchr14memchr_aligned@GOTPCREL(%rip)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	retq
.LBB9_2:
	retq
.LBB9_7:
	movl	$1, %eax
	retq
.Lfunc_end9:
	.size	_RNvCs1StpruGFt5h_6driver8std_find, .Lfunc_end9-_RNvCs1StpruGFt5h_6driver8std_find
	.cfi_endproc

	.section	.text.unlikely._RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs1StpruGFt5h_6driver,"ax",@progbits
	.prefalign	4, .Lfunc_end10, nop
	.type	_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs1StpruGFt5h_6driver,@function
_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs1StpruGFt5h_6driver:
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
	jbe	.LBB10_2
	movl	$8, %eax
	xorl	%r14d, %r14d
	jmp	.LBB10_10
.LBB10_2:
	shlq	$3, %rcx
	leaq	(%rcx,%rcx,2), %r14
	testq	%rsi, %rsi
	je	.LBB10_4
	shlq	$3, %rsi
	leaq	(%rsi,%rsi,2), %rsi
	movq	%rdx, %rdi
	movl	$8, %edx
	movq	%r14, %rcx
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_realloc@GOTPCREL(%rip)
	testq	%rax, %rax
	jne	.LBB10_6
	jmp	.LBB10_9
.LBB10_4:
	testq	%r14, %r14
	je	.LBB10_5
	callq	*_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$8, %esi
	movq	%r14, %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	jne	.LBB10_6
.LBB10_9:
	movq	$8, 8(%rbx)
	movl	$16, %eax
	jmp	.LBB10_10
.LBB10_5:
	movl	$8, %eax
.LBB10_6:
	movq	%rax, 8(%rbx)
	movl	$16, %eax
	xorl	%r15d, %r15d
.LBB10_10:
	movq	%r14, (%rbx,%rax)
	movq	%r15, (%rbx)
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end10:
	.size	_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs1StpruGFt5h_6driver, .Lfunc_end10-_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs1StpruGFt5h_6driver
	.cfi_endproc

	.section	.text._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver,"ax",@progbits
	.prefalign	4, .Lfunc_end11, nop
	.type	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver,@function
_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver:
	.cfi_startproc
	movq	%rsi, %rax
	movq	(%rdi), %rcx
	movzbl	(%rcx), %ecx
	leaq	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver(%rip), %rdx
	movzbl	(%rcx,%rdx), %edx
	leaq	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.36.rel(%rip), %rdi
	movslq	(%rdi,%rcx,4), %rsi
	addq	%rdi, %rsi
	movq	%rax, %rdi
	jmpq	*_RNvMsa_NtCsc9NCSoc2doQ_4core3fmtNtB5_9Formatter9write_str@GOTPCREL(%rip)
.Lfunc_end11:
	.size	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver, .Lfunc_end11-_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver
	.cfi_endproc

	.section	.text._RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt,"ax",@progbits
	.prefalign	4, .Lfunc_end12, nop
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
.Lfunc_end12:
	.size	_RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt, .Lfunc_end12-_RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
	.cfi_endproc

	.section	.text.main,"ax",@progbits
	.globl	main
	.prefalign	4, .Lfunc_end13, nop
	.type	main,@function
main:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	%rsi, %rcx
	movslq	%edi, %rdx
	leaq	_RNvCs1StpruGFt5h_6driver4main(%rip), %rax
	movq	%rax, (%rsp)
	leaq	.Lvtable.0(%rip), %rsi
	movq	%rsp, %rdi
	xorl	%r8d, %r8d
	callq	*_RNvNtCs341anU20NIK_3std2rt19lang_start_internal@GOTPCREL(%rip)
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end13:
	.size	main, .Lfunc_end13-main
	.cfi_endproc

	.type	.Lvtable.0,@object
	.section	.data.rel.ro..Lvtable.0,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.0:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCs1StpruGFt5h_6driver
	.quad	_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cs1StpruGFt5h_6driver
	.quad	_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cs1StpruGFt5h_6driver
	.size	.Lvtable.0, 48

	.type	.Lalloc_8e81dfbcb5e45a532aa30c8331b0b47e,@object
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	3, 0x0
.Lalloc_8e81dfbcb5e45a532aa30c8331b0b47e:
	.zero	8
	.zero	8
	.size	.Lalloc_8e81dfbcb5e45a532aa30c8331b0b47e, 16

	.type	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_b2b1f45faefdb6cfee69b54794ef8140:
	.asciz	"/tmp/memchr-std-crate-20261109/driver.rs"
	.size	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140, 41

	.type	.Lalloc_76cbd47331a82c9bea1da249cd622be9,@object
	.section	.data.rel.ro..Lalloc_76cbd47331a82c9bea1da249cd622be9,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_76cbd47331a82c9bea1da249cd622be9:
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
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
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000.\000\000\000o\000\000"
	.size	.Lalloc_1cd847217f7fad949c219121493e6692, 24

	.type	.Lalloc_97f20d6aba9b53792d2804ec8a9b80db,@object
	.section	.data.rel.ro..Lalloc_97f20d6aba9b53792d2804ec8a9b80db,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_97f20d6aba9b53792d2804ec8a9b80db:
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000/\000\000\000\027\000\000"
	.size	.Lalloc_97f20d6aba9b53792d2804ec8a9b80db, 24

	.type	.Lalloc_0466fbcb6efd6e27b2f9ddb5c8bd67bf,@object
	.section	.data.rel.ro..Lalloc_0466fbcb6efd6e27b2f9ddb5c8bd67bf,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_0466fbcb6efd6e27b2f9ddb5c8bd67bf:
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000/\000\000\000#\000\000"
	.size	.Lalloc_0466fbcb6efd6e27b2f9ddb5c8bd67bf, 24

	.type	.Lalloc_91bb3c8e2e46ccbc16597808f0bab401,@object
	.section	.data.rel.ro..Lalloc_91bb3c8e2e46ccbc16597808f0bab401,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_91bb3c8e2e46ccbc16597808f0bab401:
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000/\000\000\000>\000\000"
	.size	.Lalloc_91bb3c8e2e46ccbc16597808f0bab401, 24

	.type	.Lalloc_5c213bcbaef43ebb221d4146a2acfd23,@object
	.section	.data.rel.ro..Lalloc_5c213bcbaef43ebb221d4146a2acfd23,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_5c213bcbaef43ebb221d4146a2acfd23:
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000/\000\000\000J\000\000"
	.size	.Lalloc_5c213bcbaef43ebb221d4146a2acfd23, 24

	.type	.Lalloc_430a626d7ad8fa09ca7e11f1cb9a43c6,@object
	.section	.data.rel.ro..Lalloc_430a626d7ad8fa09ca7e11f1cb9a43c6,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_430a626d7ad8fa09ca7e11f1cb9a43c6:
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000/\000\000\000c\000\000"
	.size	.Lalloc_430a626d7ad8fa09ca7e11f1cb9a43c6, 24

	.type	.Lalloc_e2a94c7f70cdaf98936bf1e119b31d15,@object
	.section	.data.rel.ro..Lalloc_e2a94c7f70cdaf98936bf1e119b31d15,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_e2a94c7f70cdaf98936bf1e119b31d15:
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000/\000\000\000o\000\000"
	.size	.Lalloc_e2a94c7f70cdaf98936bf1e119b31d15, 24

	.type	.Lalloc_a9a7dce65c6d1c57d540b735479f6251,@object
	.section	.data.rel.ro..Lalloc_a9a7dce65c6d1c57d540b735479f6251,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_a9a7dce65c6d1c57d540b735479f6251:
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\0002\000\000\000q\000\000"
	.size	.Lalloc_a9a7dce65c6d1c57d540b735479f6251, 24

	.type	.Lalloc_fee2473f5ebd52e53d5ac249e1622a16,@object
	.section	.data.rel.ro..Lalloc_fee2473f5ebd52e53d5ac249e1622a16,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_fee2473f5ebd52e53d5ac249e1622a16:
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\0003\000\000\000\030\000\000"
	.size	.Lalloc_fee2473f5ebd52e53d5ac249e1622a16, 24

	.type	.Lalloc_e606c281df34283ee24a24505deb5779,@object
	.section	.data.rel.ro..Lalloc_e606c281df34283ee24a24505deb5779,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_e606c281df34283ee24a24505deb5779:
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\0004\000\000\000!\000\000"
	.size	.Lalloc_e606c281df34283ee24a24505deb5779, 24

	.type	.Lalloc_33f467d265e61babc7c5951f1b7a303c,@object
	.section	.data.rel.ro..Lalloc_33f467d265e61babc7c5951f1b7a303c,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_33f467d265e61babc7c5951f1b7a303c:
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\0005\000\000\000\005\000\000"
	.size	.Lalloc_33f467d265e61babc7c5951f1b7a303c, 24

	.type	.Lalloc_c14e8c434fcc3b92ba63da8be42f0c60,@object
	.section	.data.rel.ro..Lalloc_c14e8c434fcc3b92ba63da8be42f0c60,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_c14e8c434fcc3b92ba63da8be42f0c60:
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
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
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
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
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000&\000\000\000\031\000\000"
	.size	.Lalloc_9a88f186c58a52ebd3ead6ae60a6ebb4, 24

	.type	.Lalloc_7e7ae35d6636461e2066d261a89d0d5e,@object
	.section	.data.rel.ro..Lalloc_7e7ae35d6636461e2066d261a89d0d5e,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_7e7ae35d6636461e2066d261a89d0d5e:
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000&\000\000\000@\000\000"
	.size	.Lalloc_7e7ae35d6636461e2066d261a89d0d5e, 24

	.type	.Lalloc_f6eff4434d88d939ba74cb3c7aa163d7,@object
	.section	.data.rel.ro..Lalloc_f6eff4434d88d939ba74cb3c7aa163d7,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_f6eff4434d88d939ba74cb3c7aa163d7:
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000!\000\000\000\031\000\000"
	.size	.Lalloc_f6eff4434d88d939ba74cb3c7aa163d7, 24

	.type	.Lalloc_5cb5418a67bcd818f2b2b52e16b6c0ca,@object
	.section	.data.rel.ro..Lalloc_5cb5418a67bcd818f2b2b52e16b6c0ca,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_5cb5418a67bcd818f2b2b52e16b6c0ca:
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000!\000\000\000B\000\000"
	.size	.Lalloc_5cb5418a67bcd818f2b2b52e16b6c0ca, 24

	.type	.Lalloc_63fa703696994748cc44a0c124173934,@object
	.section	.data.rel.ro..Lalloc_63fa703696994748cc44a0c124173934,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_63fa703696994748cc44a0c124173934:
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000\035\000\000\0009\000\000"
	.size	.Lalloc_63fa703696994748cc44a0c124173934, 24

	.type	.Lalloc_9e293b1cd83d8f2c3d64145f659adffa,@object
	.section	.data.rel.ro..Lalloc_9e293b1cd83d8f2c3d64145f659adffa,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_9e293b1cd83d8f2c3d64145f659adffa:
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000\035\000\000\000\025\000\000"
	.size	.Lalloc_9e293b1cd83d8f2c3d64145f659adffa, 24

	.type	.Lalloc_f2adc74b1f56daa88b0b65f22487c555,@object
	.section	.data.rel.ro..Lalloc_f2adc74b1f56daa88b0b65f22487c555,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_f2adc74b1f56daa88b0b65f22487c555:
	.quad	.Lalloc_b2b1f45faefdb6cfee69b54794ef8140
	.asciz	"(\000\000\000\000\000\000\000\034\000\000\000$\000\000"
	.size	.Lalloc_f2adc74b1f56daa88b0b65f22487c555, 24

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
	.quad	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver
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

	.type	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver,"a",@progbits
	.p2align	3, 0x0
.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver:
	.ascii	"\005\f\013\013\004\016"
	.size	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver, 6

	.type	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.36.rel,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.36.rel,"a",@progbits
	.p2align	2, 0x0
.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.36.rel:
	.long	.Lalloc_59ba7b9f7211443cd55a366616eef46a-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.36.rel
	.long	.Lalloc_00315c78e51d29fe6b3102a4c1ecf6ef-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.36.rel
	.long	.Lalloc_bd3a3f3879e0d5f64554753e977f58d4-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.36.rel
	.long	.Lalloc_0964bb2a4870637395c77a018495bd5c-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.36.rel
	.long	.Lalloc_6566120a3a17f930e960a0863fcbd591-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.36.rel
	.long	.Lalloc_6c17bac0c71cba42380f8445f4dcbd16-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.36.rel
	.size	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs1StpruGFt5h_6driver.36.rel, 24

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
