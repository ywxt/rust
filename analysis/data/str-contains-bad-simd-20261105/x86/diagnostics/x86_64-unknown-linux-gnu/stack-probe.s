	.att_syntax
	.file	"stack_probe.52300b21131dbeaf-cgu.0"
	.section	.text._RINvNtCs341anU20NIK_3std2rt10lang_startuECs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.hidden	_RINvNtCs341anU20NIK_3std2rt10lang_startuECs73tWNsq4cWN_11stack_probe
	.globl	_RINvNtCs341anU20NIK_3std2rt10lang_startuECs73tWNsq4cWN_11stack_probe
	.prefalign	4, .Lfunc_end0, nop
	.type	_RINvNtCs341anU20NIK_3std2rt10lang_startuECs73tWNsq4cWN_11stack_probe,@function
_RINvNtCs341anU20NIK_3std2rt10lang_startuECs73tWNsq4cWN_11stack_probe:
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
	.size	_RINvNtCs341anU20NIK_3std2rt10lang_startuECs73tWNsq4cWN_11stack_probe, .Lfunc_end0-_RINvNtCs341anU20NIK_3std2rt10lang_startuECs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text._RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.prefalign	4, .Lfunc_end1, nop
	.type	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs73tWNsq4cWN_11stack_probe,@function
_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs73tWNsq4cWN_11stack_probe:
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
	.size	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs73tWNsq4cWN_11stack_probe, .Lfunc_end1-_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text._RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.prefalign	4, .Lfunc_end2, nop
	.type	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECs73tWNsq4cWN_11stack_probe,@function
_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECs73tWNsq4cWN_11stack_probe:
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
	.size	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECs73tWNsq4cWN_11stack_probe, .Lfunc_end2-_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text.unlikely._RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedTyyEBM_ECs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.type	_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedTyyEBM_ECs73tWNsq4cWN_11stack_probe,@function
_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedTyyEBM_ECs73tWNsq4cWN_11stack_probe:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	leaq	24(%rsp), %rsi
	movq	%rdi, (%rsi)
	leaq	.Lalloc_011d402fc2fd12f79ff2bc7691f0df1d(%rip), %rax
	leaq	32(%rsp), %rcx
	movq	%rax, (%rcx)
	leaq	.Lalloc_7bcbc173a0f42afa1c2057178d25fe54(%rip), %rax
	movq	%rax, 8(%rsp)
	leaq	.Lvtable.1(%rip), %rdx
	xorl	%edi, %edi
	movq	%rdx, %r8
	xorl	%r9d, %r9d
	callq	*_RNvNtCsc9NCSoc2doQ_4core9panicking19assert_failed_inner@GOTPCREL(%rip)
.Lfunc_end3:
	.size	_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedTyyEBM_ECs73tWNsq4cWN_11stack_probe, .Lfunc_end3-_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedTyyEBM_ECs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text._RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.prefalign	4, .Lfunc_end4, nop
	.type	_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs73tWNsq4cWN_11stack_probe,@function
_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs73tWNsq4cWN_11stack_probe:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	callq	*%rdi
	#APP
	#NO_APP
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end4:
	.size	_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs73tWNsq4cWN_11stack_probe, .Lfunc_end4-_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text.unlikely._RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.prefalign	4, .Lfunc_end5, nop
	.type	_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs73tWNsq4cWN_11stack_probe,@function
_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs73tWNsq4cWN_11stack_probe:
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
	jb	.LBB5_1
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
	callq	_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs73tWNsq4cWN_11stack_probe
	cmpl	$1, (%rsp)
	je	.LBB5_3
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
.LBB5_1:
	.cfi_def_cfa_offset 48
	xorl	%edi, %edi
	callq	*_RNvNtCs3v2GDSbr0UZ_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.LBB5_3:
	movq	8(%rsp), %rdi
	movq	16(%rsp), %rsi
	callq	*_RNvNtCs3v2GDSbr0UZ_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Lfunc_end5:
	.size	_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs73tWNsq4cWN_11stack_probe, .Lfunc_end5-_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text._RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.prefalign	4, .Lfunc_end6, nop
	.type	_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cs73tWNsq4cWN_11stack_probe,@function
_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cs73tWNsq4cWN_11stack_probe:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	(%rdi), %rdi
	callq	_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs73tWNsq4cWN_11stack_probe
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end6:
	.size	_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cs73tWNsq4cWN_11stack_probe, .Lfunc_end6-_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text._RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.prefalign	4, .Lfunc_end7, nop
	.type	_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCs73tWNsq4cWN_11stack_probe,@function
_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCs73tWNsq4cWN_11stack_probe:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	(%rdi), %rdi
	callq	_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs73tWNsq4cWN_11stack_probe
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end7:
	.size	_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCs73tWNsq4cWN_11stack_probe, .Lfunc_end7-_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text._RNvCs73tWNsq4cWN_11stack_probe3run,"ax",@progbits
	.prefalign	4, .Lfunc_end8, nop
	.type	_RNvCs73tWNsq4cWN_11stack_probe3run,@function
_RNvCs73tWNsq4cWN_11stack_probe3run:
	.cfi_startproc
	movl	$1, %eax
	movl	$2, %edx
	#APP

.Ltmp0:
	movq	%rax, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	(%rdi), %rax
	movq	8(%rdi), %rdx
	decq	%rsi
	jne	.Ltmp0

	#NO_APP
	retq
.Lfunc_end8:
	.size	_RNvCs73tWNsq4cWN_11stack_probe3run, .Lfunc_end8-_RNvCs73tWNsq4cWN_11stack_probe3run
	.cfi_endproc

	.section	.text._RNvCs73tWNsq4cWN_11stack_probe4main,"ax",@progbits
	.hidden	_RNvCs73tWNsq4cWN_11stack_probe4main
	.globl	_RNvCs73tWNsq4cWN_11stack_probe4main
	.prefalign	4, .Lfunc_end9, nop
	.type	_RNvCs73tWNsq4cWN_11stack_probe4main,@function
_RNvCs73tWNsq4cWN_11stack_probe4main:
.Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, DW.ref.rust_eh_personality
	.cfi_lsda 27, .Lexception0
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	andq	$-64, %rsp
	subq	$448, %rsp
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	leaq	104(%rsp), %rbx
	movq	%rbx, %rdi
	callq	*_RNvNtCs341anU20NIK_3std3env4args@GOTPCREL(%rip)
.Ltmp1:
	leaq	192(%rsp), %rdi
	movq	%rbx, %rsi
	callq	*_RNvXsc_NtCs341anU20NIK_3std3envNtB5_4ArgsNtNtNtNtCsc9NCSoc2doQ_4core4iter6traits8iterator8Iterator4next@GOTPCREL(%rip)
.Ltmp2:
	movq	192(%rsp), %r14
	cmpq	$-1, %r14
	je	.LBB9_89
	movq	200(%rsp), %rax
	movq	%rax, 40(%rsp)
	movq	128(%rsp), %rax
	subq	112(%rsp), %rax
	movq	%rax, %rcx
	shrq	$3, %rcx
	movabsq	$-6148914691236517205, %rdx
	imulq	%rdx, %rcx
	cmpq	$4, %rcx
	movl	$3, %r15d
	cmovaeq	%rcx, %r15
	leaq	8(,%r15,8), %rcx
	leaq	(%rcx,%rcx,2), %rbx
	movabsq	$9223372036854775776, %rcx
	cmpq	%rcx, %rax
	jbe	.LBB9_5
	xorl	%r13d, %r13d
.LBB9_4:
.Ltmp22:
	movq	%r13, %rdi
	movq	%rbx, %rsi
	callq	*_RNvNtCs3v2GDSbr0UZ_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Ltmp23:
	jmp	.LBB9_100
.LBB9_5:
	movq	208(%rsp), %r12
	testq	%rbx, %rbx
	je	.LBB9_8
	callq	*_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$8, %r13d
	movl	$8, %esi
	movq	%rbx, %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB9_4
	movq	%rax, %rcx
	incq	%r15
	jmp	.LBB9_9
.LBB9_8:
	movl	$8, %ecx
	xorl	%r15d, %r15d
.LBB9_9:
	movq	%r14, (%rcx)
	movq	40(%rsp), %rax
	movq	%rax, 8(%rcx)
	movq	%r12, 16(%rcx)
	movq	%r15, 48(%rsp)
	movq	%rcx, 40(%rsp)
	movq	%rcx, 56(%rsp)
	movq	$1, 64(%rsp)
	movups	104(%rsp), %xmm0
	movups	120(%rsp), %xmm1
	movaps	%xmm1, 208(%rsp)
	movaps	%xmm0, 192(%rsp)
	movl	$1, %r15d
	movl	$40, %r13d
	leaq	192(%rsp), %rax
	movq	%rax, 184(%rsp)
	jmp	.LBB9_12
	.p2align	4
.LBB9_10:
	movq	56(%rsp), %rax
	movq	%rax, 40(%rsp)
.LBB9_11:
	movq	40(%rsp), %rax
	movq	%rbx, -16(%rax,%r13)
	movq	%r12, -8(%rax,%r13)
	movq	%r14, (%rax,%r13)
	incq	%r15
	movq	%r15, 64(%rsp)
	addq	$24, %r13
.LBB9_12:
.Ltmp4:
	leaq	80(%rsp), %rdi
	leaq	192(%rsp), %rsi
	callq	*_RNvXsc_NtCs341anU20NIK_3std3envNtB5_4ArgsNtNtNtNtCsc9NCSoc2doQ_4core4iter6traits8iterator8Iterator4next@GOTPCREL(%rip)
.Ltmp5:
	movq	80(%rsp), %rbx
	cmpq	$-1, %rbx
	je	.LBB9_16
	movq	88(%rsp), %r12
	movq	96(%rsp), %r14
	cmpq	48(%rsp), %r15
	jne	.LBB9_11
	movq	216(%rsp), %rdx
	subq	200(%rsp), %rdx
	shrq	$3, %rdx
	movabsq	$-6148914691236517205, %rax
	imulq	%rax, %rdx
	incq	%rdx
.Ltmp7:
	leaq	48(%rsp), %rdi
	movq	%r15, %rsi
	callq	_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs73tWNsq4cWN_11stack_probe
.Ltmp8:
	jmp	.LBB9_10
.LBB9_16:
	movq	200(%rsp), %r14
	movq	216(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r14, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	cmpq	%r14, %rcx
	je	.LBB9_21
	movq	%rdx, %rbx
	shrq	$4, %rbx
	addq	$8, %r14
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r15
	jmp	.LBB9_19
	.p2align	4
.LBB9_18:
	addq	$24, %r14
	decq	%rbx
	je	.LBB9_21
.LBB9_19:
	movq	-8(%r14), %rsi
	testq	%rsi, %rsi
	je	.LBB9_18
	movq	(%r14), %rdi
	movl	$1, %edx
	callq	*%r15
	jmp	.LBB9_18
.LBB9_21:
	movq	208(%rsp), %rax
	testq	%rax, %rax
	je	.LBB9_23
	movq	192(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB9_23:
	movups	48(%rsp), %xmm0
	movaps	%xmm0, 80(%rsp)
	movq	64(%rsp), %r15
	movq	%r15, 96(%rsp)
	cmpq	$2, %r15
	jb	.LBB9_97
	movq	88(%rsp), %r12
	movq	32(%r12), %rsi
	movq	40(%r12), %rdi
	cmpq	$1, %rdi
	je	.LBB9_27
	testq	%rdi, %rdi
	je	.LBB9_101
	movzbl	(%rsi), %ecx
	jmp	.LBB9_29
.LBB9_27:
	movzbl	(%rsi), %ecx
	movb	$1, %al
	cmpl	$43, %ecx
	je	.LBB9_77
	cmpl	$45, %ecx
	je	.LBB9_77
.LBB9_29:
	xorl	%eax, %eax
	cmpb	$43, %cl
	sete	%al
	movq	%rdi, %rcx
	subq	%rax, %rcx
	addq	%rax, %rsi
	negq	%rax
	cmpq	$17, %rcx
	jae	.LBB9_34
	testq	%rcx, %rcx
	je	.LBB9_59
	addq	%rax, %rdi
	negq	%rdi
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	.p2align	4
.LBB9_32:
	movzbl	(%rsi,%rax), %edx
	addl	$-48, %edx
	cmpl	$9, %edx
	ja	.LBB9_85
	leaq	(%rcx,%rcx,4), %rcx
	movl	%edx, %edx
	leaq	(%rdx,%rcx,2), %rcx
	incq	%rax
	movq	%rdi, %rdx
	addq	%rax, %rdx
	jne	.LBB9_32
	jmp	.LBB9_39
.LBB9_34:
	addq	%rax, %rdi
	negq	%rdi
	xorl	%ecx, %ecx
	movl	$10, %r8d
	xorl	%r9d, %r9d
	.p2align	4
.LBB9_35:
	movq	%rcx, %rax
	mulq	%r8
	movzbl	(%rsi,%r9), %edx
	jo	.LBB9_75
	addl	$-48, %edx
	cmpl	$10, %edx
	jae	.LBB9_85
	movq	%rax, %rcx
	movl	%edx, %eax
	addq	%rax, %rcx
	jb	.LBB9_76
	incq	%r9
	movq	%rdi, %rax
	addq	%r9, %rax
	jne	.LBB9_35
.LBB9_39:
	movq	%rcx, 168(%rsp)
	cmpq	$2, %r15
	je	.LBB9_60
.LBB9_40:
	cmpq	$5, 64(%r12)
	jne	.LBB9_42
	movq	56(%r12), %rax
	movl	$1768714355, %edx
	xorl	(%rax), %edx
	movzbl	4(%rax), %eax
	xorl	$116, %eax
	orl	%edx, %eax
	sete	%al
	jmp	.LBB9_43
.LBB9_42:
	xorl	%eax, %eax
.LBB9_43:
	movb	%al, 39(%rsp)
	cmpq	$4, %r15
	jb	.LBB9_98
	movq	80(%r12), %rsi
	movq	88(%r12), %rdi
	cmpq	$1, %rdi
	je	.LBB9_47
	testq	%rdi, %rdi
	je	.LBB9_102
	movzbl	(%rsi), %edx
	jmp	.LBB9_49
.LBB9_47:
	movzbl	(%rsi), %edx
	movb	$1, %al
	cmpl	$43, %edx
	je	.LBB9_80
	cmpl	$45, %edx
	je	.LBB9_80
.LBB9_49:
	xorl	%eax, %eax
	cmpb	$43, %dl
	sete	%al
	movq	%rdi, %rdx
	subq	%rax, %rdx
	addq	%rax, %rsi
	negq	%rax
	cmpq	$17, %rdx
	jae	.LBB9_54
	testq	%rdx, %rdx
	je	.LBB9_61
	addq	%rax, %rdi
	negq	%rdi
	xorl	%eax, %eax
	xorl	%edx, %edx
	.p2align	4
.LBB9_52:
	movzbl	(%rsi,%rdx), %r8d
	addl	$-48, %r8d
	cmpl	$9, %r8d
	ja	.LBB9_86
	leaq	(%rax,%rax,4), %rax
	movl	%r8d, %r8d
	leaq	(%r8,%rax,2), %rax
	incq	%rdx
	movq	%rdi, %r8
	addq	%rdx, %r8
	jne	.LBB9_52
	jmp	.LBB9_62
.LBB9_54:
	addq	%rax, %rdi
	negq	%rdi
	xorl	%eax, %eax
	movl	$10, %r8d
	xorl	%r9d, %r9d
	.p2align	4
.LBB9_55:
	mulq	%r8
	movzbl	(%rsi,%r9), %edx
	jo	.LBB9_78
	addl	$-48, %edx
	cmpl	$10, %edx
	jae	.LBB9_86
	movl	%edx, %edx
	addq	%rdx, %rax
	jb	.LBB9_79
	incq	%r9
	movq	%rdi, %rdx
	addq	%r9, %rdx
	jne	.LBB9_55
	jmp	.LBB9_62
.LBB9_59:
	xorl	%ecx, %ecx
	movq	%rcx, 168(%rsp)
	cmpq	$2, %r15
	jne	.LBB9_40
.LBB9_60:
	leaq	.Lalloc_673c2ecc855c5ae33303710f5ebb210a(%rip), %rdx
	movl	$2, %edi
	movl	$2, %r15d
	jmp	.LBB9_99
.LBB9_61:
	xorl	%eax, %eax
.LBB9_62:
	movq	%rax, 176(%rsp)
	xorps	%xmm0, %xmm0
	movaps	%xmm0, 304(%rsp)
	movaps	%xmm0, 288(%rsp)
	movaps	%xmm0, 272(%rsp)
	movaps	%xmm0, 256(%rsp)
	movaps	%xmm0, 240(%rsp)
	movaps	%xmm0, 224(%rsp)
	movaps	%xmm0, 208(%rsp)
	movaps	%xmm0, 192(%rsp)
	movq	%rcx, %rax
	andq	$-8, %rax
	leaq	(%rsp,%rax), %rbx
	addq	$192, %rbx
	movl	%ebx, %eax
	andl	$56, %eax
	movq	%rax, 104(%rsp)
	cmpq	%rcx, %rax
	jne	.LBB9_84
.Ltmp14:
	callq	*_RNvMNtCs341anU20NIK_3std4timeNtB2_7Instant3now@GOTPCREL(%rip)
.Ltmp15:
	movq	%rax, 360(%rsp)
	movl	%edx, 368(%rsp)
	movq	%rbx, 104(%rsp)
	leaq	104(%rsp), %rax
	#APP
	#NO_APP
	movq	104(%rsp), %rdi
	movq	176(%rsp), %rsi
	callq	_RNvCs73tWNsq4cWN_11stack_probe3run
	movq	%rax, 376(%rsp)
	movq	%rdx, 384(%rsp)
	cmpq	$2, %rdx
	sete	%cl
	cmpq	$1, %rax
	jne	.LBB9_82
	testb	%cl, %cl
	je	.LBB9_83
.LBB9_66:
.Ltmp18:
	leaq	360(%rsp), %rdi
	callq	*_RNvMNtCs341anU20NIK_3std4timeNtB2_7Instant7elapsed@GOTPCREL(%rip)
.Ltmp19:
	movl	%edx, %ecx
	movl	$1000000000, %edx
	mulq	%rdx
	movl	%ecx, %ecx
	addq	%rax, %rcx
	adcq	$0, %rdx
	movq	%rcx, 48(%rsp)
	movq	%rdx, 56(%rsp)
	leaq	168(%rsp), %rax
	movq	%rax, 104(%rsp)
	movq	_RNvXsi_NtNtNtCsc9NCSoc2doQ_4core3fmt3num3impjNtB9_7Display3fmt@GOTPCREL(%rip), %rax
	movq	%rax, 112(%rsp)
	leaq	39(%rsp), %rax
	movq	%rax, 120(%rsp)
	movq	_RNvXsg_NtCsc9NCSoc2doQ_4core3fmtbNtB5_7Display3fmt@GOTPCREL(%rip), %rax
	movq	%rax, 128(%rsp)
	leaq	176(%rsp), %rax
	movq	%rax, 136(%rsp)
	movq	_RNvXsd_NtNtNtCsc9NCSoc2doQ_4core3fmt3num3impyNtB9_7Display3fmt@GOTPCREL(%rip), %rax
	movq	%rax, 144(%rsp)
	leaq	48(%rsp), %rax
	movq	%rax, 152(%rsp)
	movq	_RNvXNtNtCsc9NCSoc2doQ_4core3fmt3numoNtB4_7Display3fmt@GOTPCREL(%rip), %rax
	movq	%rax, 160(%rsp)
.Ltmp20:
	leaq	.Lalloc_b8073bcf24be9d205b024f683ad009d8(%rip), %rdi
	leaq	104(%rsp), %rsi
	callq	*_RNvNtNtCs341anU20NIK_3std2io5stdio6__print@GOTPCREL(%rip)
.Ltmp21:
	leaq	8(%r12), %rbx
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r14
	jmp	.LBB9_70
	.p2align	4
.LBB9_69:
	addq	$24, %rbx
	decq	%r15
	je	.LBB9_72
.LBB9_70:
	movq	-8(%rbx), %rsi
	testq	%rsi, %rsi
	je	.LBB9_69
	movq	(%rbx), %rdi
	movl	$1, %edx
	callq	*%r14
	jmp	.LBB9_69
.LBB9_72:
	movq	80(%rsp), %rax
	testq	%rax, %rax
	je	.LBB9_74
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	movq	%r12, %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB9_74:
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.LBB9_75:
	.cfi_def_cfa %rbp, 16
	addb	$-48, %dl
	xorl	%eax, %eax
	cmpb	$10, %dl
	adcb	$1, %al
	jmp	.LBB9_77
.LBB9_76:
	movb	$2, %al
.LBB9_77:
	movb	%al, 192(%rsp)
	leaq	.Lalloc_9e12b251dfcfe36e07d52eb375d3474c(%rip), %r8
	jmp	.LBB9_81
.LBB9_78:
	addb	$-48, %dl
	xorl	%eax, %eax
	cmpb	$10, %dl
	adcb	$1, %al
	jmp	.LBB9_80
.LBB9_79:
	movb	$2, %al
.LBB9_80:
	movb	%al, 192(%rsp)
	leaq	.Lalloc_b5fe02085895564a3955bb0dc899e0b9(%rip), %r8
.LBB9_81:
.Ltmp10:
	leaq	.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274(%rip), %rdi
	leaq	.Lvtable.2(%rip), %rcx
	movl	$43, %esi
	movq	184(%rsp), %rdx
	callq	*_RNvNtCsc9NCSoc2doQ_4core6result13unwrap_failed@GOTPCREL(%rip)
.Ltmp11:
	jmp	.LBB9_100
.LBB9_82:
	xorl	%ecx, %ecx
	testb	%cl, %cl
	jne	.LBB9_66
.LBB9_83:
.Ltmp16:
	leaq	376(%rsp), %rdi
	callq	_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedTyyEBM_ECs73tWNsq4cWN_11stack_probe
.Ltmp17:
	jmp	.LBB9_100
.LBB9_84:
.Ltmp12:
	leaq	.Lalloc_78e6432c4c42081f09a042aa7d91dbf7(%rip), %r9
	leaq	104(%rsp), %rsi
	leaq	168(%rsp), %rdx
	xorl	%edi, %edi
	xorl	%ecx, %ecx
	callq	*_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedjjEB4_@GOTPCREL(%rip)
.Ltmp13:
	jmp	.LBB9_100
.LBB9_85:
	movb	$1, %al
	jmp	.LBB9_77
.LBB9_86:
	movb	$1, %al
	jmp	.LBB9_80
.LBB9_89:
	movq	112(%rsp), %r14
	movq	128(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r14, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	movq	$0, 80(%rsp)
	movq	$8, 88(%rsp)
	movq	$0, 96(%rsp)
	cmpq	%r14, %rcx
	jne	.LBB9_93
.LBB9_90:
	movq	120(%rsp), %rax
	testq	%rax, %rax
	je	.LBB9_92
	movq	104(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB9_92:
	leaq	.Lalloc_f18dedefa328b38e6f2c3c48dffabd23(%rip), %rdx
	movl	$1, %edi
	xorl	%r15d, %r15d
	jmp	.LBB9_99
.LBB9_93:
	movq	%rdx, %rbx
	shrq	$4, %rbx
	addq	$8, %r14
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r15
	jmp	.LBB9_95
	.p2align	4
.LBB9_94:
	addq	$24, %r14
	decq	%rbx
	je	.LBB9_90
.LBB9_95:
	movq	-8(%r14), %rsi
	testq	%rsi, %rsi
	je	.LBB9_94
	movq	(%r14), %rdi
	movl	$1, %edx
	callq	*%r15
	jmp	.LBB9_94
.LBB9_97:
	leaq	.Lalloc_f18dedefa328b38e6f2c3c48dffabd23(%rip), %rdx
	movl	$1, %edi
	jmp	.LBB9_99
.LBB9_98:
	leaq	.Lalloc_db3a5b0ef68a6f25b323fba0399275ef(%rip), %rdx
	movl	$3, %edi
	movl	$3, %r15d
.LBB9_99:
.Ltmp25:
	movq	%r15, %rsi
	callq	*_RNvNtCsc9NCSoc2doQ_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.Ltmp26:
.LBB9_100:
	ud2
.LBB9_101:
	xorl	%eax, %eax
	jmp	.LBB9_77
.LBB9_102:
	xorl	%eax, %eax
	jmp	.LBB9_80
.LBB9_103:
.Ltmp3:
	movq	%rax, %r13
	jmp	.LBB9_112
.LBB9_104:
.Ltmp9:
	movq	%rax, %r13
	testq	%rbx, %rbx
	je	.LBB9_107
	movl	$1, %edx
	movq	%r12, %rdi
	movq	%rbx, %rsi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	jmp	.LBB9_107
.LBB9_106:
.Ltmp6:
	movq	%rax, %r13
.LBB9_107:
	leaq	192(%rsp), %rdi
	callq	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECs73tWNsq4cWN_11stack_probe
	leaq	48(%rsp), %rdi
	callq	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs73tWNsq4cWN_11stack_probe
	movq	%r13, %rdi
	callq	_Unwind_Resume@PLT
.LBB9_108:
.Ltmp27:
	movq	%rax, %r13
	leaq	80(%rsp), %rdi
	callq	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECs73tWNsq4cWN_11stack_probe
	movq	%r13, %rdi
	callq	_Unwind_Resume@PLT
.LBB9_110:
.Ltmp24:
	movq	%rax, %r13
	testq	%r14, %r14
	je	.LBB9_112
	movl	$1, %edx
	movq	40(%rsp), %rdi
	movq	%r14, %rsi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB9_112:
	movq	112(%rsp), %r14
	movq	128(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r14, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	cmpq	%r14, %rcx
	jne	.LBB9_115
.LBB9_113:
	movq	120(%rsp), %rax
	testq	%rax, %rax
	jne	.LBB9_119
	movq	%r13, %rdi
	callq	_Unwind_Resume@PLT
.LBB9_115:
	movq	%rdx, %rbx
	shrq	$4, %rbx
	addq	$8, %r14
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r15
	jmp	.LBB9_117
	.p2align	4
.LBB9_116:
	addq	$24, %r14
	decq	%rbx
	je	.LBB9_113
.LBB9_117:
	movq	-8(%r14), %rsi
	testq	%rsi, %rsi
	je	.LBB9_116
	movq	(%r14), %rdi
	movl	$1, %edx
	callq	*%r15
	jmp	.LBB9_116
.LBB9_119:
	movq	104(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	movq	%r13, %rdi
	callq	_Unwind_Resume@PLT
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
	.uleb128 .Ltmp1-.Lfunc_begin0
	.byte	0
	.byte	0
	.uleb128 .Ltmp1-.Lfunc_begin0
	.uleb128 .Ltmp2-.Ltmp1
	.uleb128 .Ltmp3-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp22-.Lfunc_begin0
	.uleb128 .Ltmp23-.Ltmp22
	.uleb128 .Ltmp24-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp4-.Lfunc_begin0
	.uleb128 .Ltmp5-.Ltmp4
	.uleb128 .Ltmp6-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp7-.Lfunc_begin0
	.uleb128 .Ltmp8-.Ltmp7
	.uleb128 .Ltmp9-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp8-.Lfunc_begin0
	.uleb128 .Ltmp14-.Ltmp8
	.byte	0
	.byte	0
	.uleb128 .Ltmp14-.Lfunc_begin0
	.uleb128 .Ltmp21-.Ltmp14
	.uleb128 .Ltmp27-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp21-.Lfunc_begin0
	.uleb128 .Ltmp10-.Ltmp21
	.byte	0
	.byte	0
	.uleb128 .Ltmp10-.Lfunc_begin0
	.uleb128 .Ltmp13-.Ltmp10
	.uleb128 .Ltmp27-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp13-.Lfunc_begin0
	.uleb128 .Ltmp25-.Ltmp13
	.byte	0
	.byte	0
	.uleb128 .Ltmp25-.Lfunc_begin0
	.uleb128 .Ltmp26-.Ltmp25
	.uleb128 .Ltmp27-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp26-.Lfunc_begin0
	.uleb128 .Lfunc_end9-.Ltmp26
	.byte	0
	.byte	0
.Lcst_end0:
	.p2align	2, 0x0

	.section	.text.unlikely._RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.prefalign	4, .Lfunc_end10, nop
	.type	_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs73tWNsq4cWN_11stack_probe,@function
_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs73tWNsq4cWN_11stack_probe:
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
	.size	_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs73tWNsq4cWN_11stack_probe, .Lfunc_end10-_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.prefalign	4, .Lfunc_end11, nop
	.type	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe,@function
_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe:
	.cfi_startproc
	movq	%rsi, %rax
	movq	(%rdi), %rcx
	movzbl	(%rcx), %ecx
	leaq	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe(%rip), %rdx
	movzbl	(%rcx,%rdx), %edx
	leaq	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel(%rip), %rdi
	movslq	(%rdi,%rcx,4), %rsi
	addq	%rdi, %rsi
	movq	%rax, %rdi
	jmpq	*_RNvMsa_NtCsc9NCSoc2doQ_4core3fmtNtB5_9Formatter9write_str@GOTPCREL(%rip)
.Lfunc_end11:
	.size	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe, .Lfunc_end11-_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRTyyENtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.prefalign	4, .Lfunc_end12, nop
	.type	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRTyyENtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe,@function
_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRTyyENtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	subq	$48, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	(%rdi), %r14
	leaq	24(%rsp), %rbx
	movl	$1, %edx
	movq	%rbx, %rdi
	xorl	%ecx, %ecx
	callq	*_RNvMsa_NtCsc9NCSoc2doQ_4core3fmtNtB5_9Formatter11debug_tuple@GOTPCREL(%rip)
	movq	%r14, 8(%rsp)
	addq	$8, %r14
	movq	%r14, 16(%rsp)
	leaq	.Lvtable.3(%rip), %r14
	movq	_RNvMs3_NtNtCsc9NCSoc2doQ_4core3fmt8buildersNtB5_10DebugTuple5field@GOTPCREL(%rip), %r15
	leaq	8(%rsp), %rsi
	movq	%rbx, %rdi
	movq	%r14, %rdx
	callq	*%r15
	leaq	16(%rsp), %rsi
	movq	%rbx, %rdi
	movq	%r14, %rdx
	callq	*%r15
	movq	%rbx, %rdi
	callq	*_RNvMs3_NtNtCsc9NCSoc2doQ_4core3fmt8buildersNtB5_10DebugTuple6finish@GOTPCREL(%rip)
	addq	$48, %rsp
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end12:
	.size	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRTyyENtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe, .Lfunc_end12-_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRTyyENtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRyNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe,"ax",@progbits
	.prefalign	4, .Lfunc_end13, nop
	.type	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRyNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe,@function
_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRyNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe:
	.cfi_startproc
	movq	(%rdi), %rdi
	movl	16(%rsi), %eax
	testl	$33554432, %eax
	jne	.LBB13_3
	testl	$67108864, %eax
	jne	.LBB13_2
	jmpq	*_RNvXsd_NtNtNtCsc9NCSoc2doQ_4core3fmt3num3impyNtB9_7Display3fmt@GOTPCREL(%rip)
.LBB13_3:
	jmpq	*_RNvXsC_NtNtCsc9NCSoc2doQ_4core3fmt3numyNtB7_8LowerHex3fmt@GOTPCREL(%rip)
.LBB13_2:
	jmpq	*_RNvXsE_NtNtCsc9NCSoc2doQ_4core3fmt3numyNtB7_8UpperHex3fmt@GOTPCREL(%rip)
.Lfunc_end13:
	.size	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRyNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe, .Lfunc_end13-_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRyNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe
	.cfi_endproc

	.section	.text._RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt,"ax",@progbits
	.prefalign	4, .Lfunc_end14, nop
	.type	_RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt,@function
_RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rsi, %rax
	movq	%rdi, 16(%rsp)
	leaq	.Lvtable.4(%rip), %rcx
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
.Lfunc_end14:
	.size	_RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt, .Lfunc_end14-_RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
	.cfi_endproc

	.section	.text.main,"ax",@progbits
	.globl	main
	.prefalign	4, .Lfunc_end15, nop
	.type	main,@function
main:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	%rsi, %rcx
	movslq	%edi, %rdx
	leaq	_RNvCs73tWNsq4cWN_11stack_probe4main(%rip), %rax
	movq	%rax, (%rsp)
	leaq	.Lvtable.0(%rip), %rsi
	movq	%rsp, %rdi
	xorl	%r8d, %r8d
	callq	*_RNvNtCs341anU20NIK_3std2rt19lang_start_internal@GOTPCREL(%rip)
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end15:
	.size	main, .Lfunc_end15-main
	.cfi_endproc

	.type	.Lvtable.0,@object
	.section	.data.rel.ro..Lvtable.0,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.0:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCs73tWNsq4cWN_11stack_probe
	.quad	_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cs73tWNsq4cWN_11stack_probe
	.quad	_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cs73tWNsq4cWN_11stack_probe
	.size	.Lvtable.0, 48

	.type	.Lvtable.1,@object
	.section	.data.rel.ro..Lvtable.1,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.1:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRTyyENtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe
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
	.quad	.Lalloc_3f6d15f7c0f0226e8853a8abddaba251
	.asciz	".\000\000\000\000\000\000\000\007\000\000\000H\000\000"
	.size	.Lalloc_f18dedefa328b38e6f2c3c48dffabd23, 24

	.type	.Lalloc_9e12b251dfcfe36e07d52eb375d3474c,@object
	.section	.data.rel.ro..Lalloc_9e12b251dfcfe36e07d52eb375d3474c,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_9e12b251dfcfe36e07d52eb375d3474c:
	.quad	.Lalloc_3f6d15f7c0f0226e8853a8abddaba251
	.asciz	".\000\000\000\000\000\000\000\007\000\000\000T\000\000"
	.size	.Lalloc_9e12b251dfcfe36e07d52eb375d3474c, 24

	.type	.Lalloc_673c2ecc855c5ae33303710f5ebb210a,@object
	.section	.data.rel.ro..Lalloc_673c2ecc855c5ae33303710f5ebb210a,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_673c2ecc855c5ae33303710f5ebb210a:
	.quad	.Lalloc_3f6d15f7c0f0226e8853a8abddaba251
	.asciz	".\000\000\000\000\000\000\000\007\000\000\000k\000\000"
	.size	.Lalloc_673c2ecc855c5ae33303710f5ebb210a, 24

	.type	.Lalloc_db3a5b0ef68a6f25b323fba0399275ef,@object
	.section	.data.rel.ro..Lalloc_db3a5b0ef68a6f25b323fba0399275ef,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_db3a5b0ef68a6f25b323fba0399275ef:
	.quad	.Lalloc_3f6d15f7c0f0226e8853a8abddaba251
	.asciz	".\000\000\000\000\000\000\000\007\000\000\000\206\000\000"
	.size	.Lalloc_db3a5b0ef68a6f25b323fba0399275ef, 24

	.type	.Lalloc_b5fe02085895564a3955bb0dc899e0b9,@object
	.section	.data.rel.ro..Lalloc_b5fe02085895564a3955bb0dc899e0b9,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_b5fe02085895564a3955bb0dc899e0b9:
	.quad	.Lalloc_3f6d15f7c0f0226e8853a8abddaba251
	.asciz	".\000\000\000\000\000\000\000\007\000\000\000\222\000\000"
	.size	.Lalloc_b5fe02085895564a3955bb0dc899e0b9, 24

	.type	.Lalloc_78e6432c4c42081f09a042aa7d91dbf7,@object
	.section	.data.rel.ro..Lalloc_78e6432c4c42081f09a042aa7d91dbf7,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_78e6432c4c42081f09a042aa7d91dbf7:
	.quad	.Lalloc_3f6d15f7c0f0226e8853a8abddaba251
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
	.quad	.Lalloc_3f6d15f7c0f0226e8853a8abddaba251
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
	.quad	_RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
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
	.quad	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRyNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe
	.size	.Lvtable.3, 32

	.type	.Lvtable.4,@object
	.section	.data.rel.ro..Lvtable.4,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.4:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe
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
	.section	.rodata.cst4,"aM",@progbits,4
.Lalloc_6566120a3a17f930e960a0863fcbd591:
	.ascii	"Zero"
	.size	.Lalloc_6566120a3a17f930e960a0863fcbd591, 4

	.type	.Lalloc_6c17bac0c71cba42380f8445f4dcbd16,@object
	.section	.rodata..Lalloc_6c17bac0c71cba42380f8445f4dcbd16,"a",@progbits
.Lalloc_6c17bac0c71cba42380f8445f4dcbd16:
	.ascii	"NotAPowerOfTwo"
	.size	.Lalloc_6c17bac0c71cba42380f8445f4dcbd16, 14

	.type	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe,"a",@progbits
	.p2align	3, 0x0
.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe:
	.ascii	"\005\f\013\013\004\016"
	.size	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe, 6

	.type	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel,"a",@progbits
	.p2align	2, 0x0
.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel:
	.long	.Lalloc_59ba7b9f7211443cd55a366616eef46a-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel
	.long	.Lalloc_00315c78e51d29fe6b3102a4c1ecf6ef-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel
	.long	.Lalloc_bd3a3f3879e0d5f64554753e977f58d4-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel
	.long	.Lalloc_0964bb2a4870637395c77a018495bd5c-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel
	.long	.Lalloc_6566120a3a17f930e960a0863fcbd591-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel
	.long	.Lalloc_6c17bac0c71cba42380f8445f4dcbd16-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel
	.size	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs73tWNsq4cWN_11stack_probe.27.rel, 24

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
