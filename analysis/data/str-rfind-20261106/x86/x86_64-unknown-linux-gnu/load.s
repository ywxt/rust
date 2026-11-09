	.att_syntax
	.file	"load.a40d29b615b0ce51-cgu.0"
	.section	.text._RINvNtCs341anU20NIK_3std2rt10lang_startuECse5eZEUQffQP_4load,"ax",@progbits
	.hidden	_RINvNtCs341anU20NIK_3std2rt10lang_startuECse5eZEUQffQP_4load
	.globl	_RINvNtCs341anU20NIK_3std2rt10lang_startuECse5eZEUQffQP_4load
	.prefalign	4, .Lfunc_end0, nop
	.type	_RINvNtCs341anU20NIK_3std2rt10lang_startuECse5eZEUQffQP_4load,@function
_RINvNtCs341anU20NIK_3std2rt10lang_startuECse5eZEUQffQP_4load:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%ecx, %r8d
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rdi, -8(%rbp)
	leaq	.Lvtable.0(%rip), %rsi
	leaq	-8(%rbp), %rdi
	callq	*_RNvNtCs341anU20NIK_3std2rt19lang_start_internal@GOTPCREL(%rip)
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	_RINvNtCs341anU20NIK_3std2rt10lang_startuECse5eZEUQffQP_4load, .Lfunc_end0-_RINvNtCs341anU20NIK_3std2rt10lang_startuECse5eZEUQffQP_4load
	.cfi_endproc

	.section	.text._RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECse5eZEUQffQP_4load,"ax",@progbits
	.prefalign	4, .Lfunc_end1, nop
	.type	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECse5eZEUQffQP_4load,@function
_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECse5eZEUQffQP_4load:
	.cfi_startproc
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
	pushq	%rax
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
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
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	jmpq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB1_6:
	.cfi_def_cfa %rbp, 16
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end1:
	.size	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECse5eZEUQffQP_4load, .Lfunc_end1-_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECse5eZEUQffQP_4load
	.cfi_endproc

	.section	.text._RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECse5eZEUQffQP_4load,"ax",@progbits
	.prefalign	4, .Lfunc_end2, nop
	.type	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECse5eZEUQffQP_4load,@function
_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECse5eZEUQffQP_4load:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
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
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	jmpq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB2_6:
	.cfi_def_cfa %rbp, 16
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end2:
	.size	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECse5eZEUQffQP_4load, .Lfunc_end2-_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECse5eZEUQffQP_4load
	.cfi_endproc

	.section	.text._RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECse5eZEUQffQP_4load,"ax",@progbits
	.prefalign	4, .Lfunc_end3, nop
	.type	_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECse5eZEUQffQP_4load,@function
_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECse5eZEUQffQP_4load:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	callq	*%rdi
	#APP
	#NO_APP
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end3:
	.size	_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECse5eZEUQffQP_4load, .Lfunc_end3-_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECse5eZEUQffQP_4load
	.cfi_endproc

	.section	.text.unlikely._RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECse5eZEUQffQP_4load,"ax",@progbits
	.prefalign	4, .Lfunc_end4, nop
	.type	_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECse5eZEUQffQP_4load,@function
_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECse5eZEUQffQP_4load:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	subq	$32, %rsp
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	addq	%rdx, %rsi
	jb	.LBB4_1
	movq	%rcx, %r8
	movq	%rdi, %rbx
	movq	(%rdi), %rax
	leaq	(%rax,%rax), %rcx
	cmpq	%rcx, %rsi
	cmovaq	%rsi, %rcx
	cmpq	$5, %rcx
	movl	$4, %r14d
	cmovaeq	%rcx, %r14
	movq	8(%rdi), %rdx
	leaq	-40(%rbp), %rdi
	movq	%rax, %rsi
	movq	%r14, %rcx
	callq	_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCse5eZEUQffQP_4load
	cmpl	$1, -40(%rbp)
	je	.LBB4_3
	movq	-32(%rbp), %rax
	movq	%rax, 8(%rbx)
	movq	%r14, (%rbx)
	addq	$32, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.LBB4_1:
	.cfi_def_cfa %rbp, 16
	xorl	%edi, %edi
	callq	*_RNvNtCs3v2GDSbr0UZ_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.LBB4_3:
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %rsi
	callq	*_RNvNtCs3v2GDSbr0UZ_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Lfunc_end4:
	.size	_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECse5eZEUQffQP_4load, .Lfunc_end4-_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECse5eZEUQffQP_4load
	.cfi_endproc

	.section	.text._RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cse5eZEUQffQP_4load,"ax",@progbits
	.prefalign	4, .Lfunc_end5, nop
	.type	_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cse5eZEUQffQP_4load,@function
_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cse5eZEUQffQP_4load:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	(%rdi), %rdi
	callq	_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECse5eZEUQffQP_4load
	xorl	%eax, %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end5:
	.size	_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cse5eZEUQffQP_4load, .Lfunc_end5-_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cse5eZEUQffQP_4load
	.cfi_endproc

	.section	.text._RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCse5eZEUQffQP_4load,"ax",@progbits
	.prefalign	4, .Lfunc_end6, nop
	.type	_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCse5eZEUQffQP_4load,@function
_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCse5eZEUQffQP_4load:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	(%rdi), %rdi
	callq	_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECse5eZEUQffQP_4load
	xorl	%eax, %eax
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end6:
	.size	_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCse5eZEUQffQP_4load, .Lfunc_end6-_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCse5eZEUQffQP_4load
	.cfi_endproc

	.section	.text._RNvCse5eZEUQffQP_4load4main,"ax",@progbits
	.hidden	_RNvCse5eZEUQffQP_4load4main
	.globl	_RNvCse5eZEUQffQP_4load4main
	.prefalign	4, .Lfunc_end7, nop
	.type	_RNvCse5eZEUQffQP_4load4main,@function
_RNvCse5eZEUQffQP_4load4main:
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
	subq	$216, %rsp
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	leaq	-176(%rbp), %rbx
	movq	%rbx, %rdi
	callq	*_RNvNtCs341anU20NIK_3std3env4args@GOTPCREL(%rip)
.Ltmp0:
	leaq	-112(%rbp), %rdi
	movq	%rbx, %rsi
	callq	*_RNvXsc_NtCs341anU20NIK_3std3envNtB5_4ArgsNtNtNtNtCsc9NCSoc2doQ_4core4iter6traits8iterator8Iterator4next@GOTPCREL(%rip)
.Ltmp1:
	movq	-112(%rbp), %r14
	cmpq	$-1, %r14
	je	.LBB7_104
	movq	-104(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	-152(%rbp), %rax
	subq	-168(%rbp), %rax
	movq	%rax, %rcx
	shrq	$3, %rcx
	movabsq	$-6148914691236517205, %rdx
	imulq	%rdx, %rcx
	cmpq	$4, %rcx
	movl	$3, %r15d
	cmovaeq	%rcx, %r15
	leaq	8(,%r15,8), %rcx
	leaq	(%rcx,%rcx,2), %r12
	movabsq	$9223372036854775776, %rcx
	cmpq	%rcx, %rax
	jbe	.LBB7_5
	xorl	%r13d, %r13d
.LBB7_4:
.Ltmp28:
	movq	%r13, %rdi
	movq	%r12, %rsi
	callq	*_RNvNtCs3v2GDSbr0UZ_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Ltmp29:
	jmp	.LBB7_120
.LBB7_5:
	movq	-96(%rbp), %rcx
	testq	%r12, %r12
	je	.LBB7_8
	movq	%rcx, -56(%rbp)
	callq	*_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$8, %r13d
	movl	$8, %esi
	movq	%r12, %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB7_4
	movq	%rax, %rdx
	incq	%r15
	movq	-56(%rbp), %rcx
	jmp	.LBB7_9
.LBB7_8:
	movl	$8, %edx
	xorl	%r15d, %r15d
.LBB7_9:
	movq	%r14, (%rdx)
	movq	-48(%rbp), %rax
	movq	%rax, 8(%rdx)
	movq	%rcx, 16(%rdx)
	movq	%r15, -136(%rbp)
	movq	%rdx, -48(%rbp)
	movq	%rdx, -128(%rbp)
	movq	$1, -120(%rbp)
	movups	-176(%rbp), %xmm0
	movups	-160(%rbp), %xmm1
	movaps	%xmm1, -96(%rbp)
	movaps	%xmm0, -112(%rbp)
	movl	$1, %r15d
	movl	$40, %r12d
	jmp	.LBB7_12
	.p2align	4
.LBB7_10:
	movq	-128(%rbp), %rax
	movq	%rax, -48(%rbp)
.LBB7_11:
	movq	-48(%rbp), %rax
	movq	%r14, -16(%rax,%r12)
	movq	%r13, -8(%rax,%r12)
	movq	%rbx, (%rax,%r12)
	incq	%r15
	movq	%r15, -120(%rbp)
	addq	$24, %r12
.LBB7_12:
	leaq	-112(%rbp), %r13
.Ltmp3:
	leaq	-208(%rbp), %rdi
	movq	%r13, %rsi
	callq	*_RNvXsc_NtCs341anU20NIK_3std3envNtB5_4ArgsNtNtNtNtCsc9NCSoc2doQ_4core4iter6traits8iterator8Iterator4next@GOTPCREL(%rip)
.Ltmp4:
	movq	-208(%rbp), %r14
	cmpq	$-1, %r14
	je	.LBB7_16
	movq	-200(%rbp), %r13
	movq	-192(%rbp), %rbx
	cmpq	-136(%rbp), %r15
	jne	.LBB7_11
	movq	-88(%rbp), %rdx
	subq	-104(%rbp), %rdx
	shrq	$3, %rdx
	movabsq	$-6148914691236517205, %rax
	imulq	%rax, %rdx
	incq	%rdx
.Ltmp6:
	movl	$24, %ecx
	leaq	-136(%rbp), %rdi
	movq	%r15, %rsi
	callq	_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECse5eZEUQffQP_4load
.Ltmp7:
	jmp	.LBB7_10
.LBB7_16:
	movq	-104(%rbp), %r14
	movq	-88(%rbp), %rcx
	movq	%rcx, %rax
	subq	%r14, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	cmpq	%r14, %rcx
	je	.LBB7_21
	movq	%rdx, %rbx
	shrq	$4, %rbx
	addq	$8, %r14
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r15
	jmp	.LBB7_19
	.p2align	4
.LBB7_18:
	addq	$24, %r14
	decq	%rbx
	je	.LBB7_21
.LBB7_19:
	movq	-8(%r14), %rsi
	testq	%rsi, %rsi
	je	.LBB7_18
	movq	(%r14), %rdi
	movl	$1, %edx
	callq	*%r15
	jmp	.LBB7_18
.LBB7_21:
	movq	-96(%rbp), %rax
	testq	%rax, %rax
	je	.LBB7_23
	movq	-112(%rbp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB7_23:
	movups	-136(%rbp), %xmm0
	movaps	%xmm0, -208(%rbp)
	movq	-120(%rbp), %r15
	movq	%r15, -192(%rbp)
	cmpq	$2, %r15
	jb	.LBB7_112
	je	.LBB7_113
	movq	-200(%rbp), %r12
	movq	56(%r12), %rsi
	movq	64(%r12), %rdi
	cmpq	$1, %rdi
	je	.LBB7_28
	testq	%rdi, %rdi
	je	.LBB7_121
	movzbl	(%rsi), %ecx
	jmp	.LBB7_30
.LBB7_28:
	movzbl	(%rsi), %ecx
	movb	$1, %al
	cmpl	$43, %ecx
	je	.LBB7_92
	cmpl	$45, %ecx
	je	.LBB7_92
.LBB7_30:
	xorl	%eax, %eax
	cmpb	$43, %cl
	sete	%al
	movq	%rdi, %rcx
	subq	%rax, %rcx
	addq	%rax, %rsi
	negq	%rax
	cmpq	$17, %rcx
	jae	.LBB7_35
	testq	%rcx, %rcx
	je	.LBB7_86
	addq	%rax, %rdi
	negq	%rdi
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	.p2align	4
.LBB7_33:
	movzbl	(%rsi,%rax), %edx
	addl	$-48, %edx
	cmpl	$9, %edx
	ja	.LBB7_100
	leaq	(%rcx,%rcx,4), %rcx
	movl	%edx, %edx
	leaq	(%rdx,%rcx,2), %rcx
	incq	%rax
	movq	%rdi, %rdx
	addq	%rax, %rdx
	jne	.LBB7_33
	jmp	.LBB7_40
.LBB7_35:
	addq	%rax, %rdi
	negq	%rdi
	xorl	%ecx, %ecx
	movl	$10, %r8d
	xorl	%r9d, %r9d
	.p2align	4
.LBB7_36:
	movq	%rcx, %rax
	mulq	%r8
	movzbl	(%rsi,%r9), %edx
	jo	.LBB7_90
	addl	$-48, %edx
	cmpl	$10, %edx
	jae	.LBB7_100
	movq	%rax, %rcx
	movl	%edx, %eax
	addq	%rax, %rcx
	jb	.LBB7_91
	incq	%r9
	movq	%rdi, %rax
	addq	%r9, %rax
	jne	.LBB7_36
.LBB7_40:
	movq	%rcx, -216(%rbp)
	cmpq	$4, %r15
	jb	.LBB7_87
.LBB7_41:
	movq	80(%r12), %rsi
	movq	88(%r12), %rdi
	cmpq	$1, %rdi
	je	.LBB7_44
	testq	%rdi, %rdi
	je	.LBB7_122
	movzbl	(%rsi), %edx
	jmp	.LBB7_46
.LBB7_44:
	movzbl	(%rsi), %edx
	movb	$1, %al
	cmpl	$43, %edx
	je	.LBB7_95
	cmpl	$45, %edx
	je	.LBB7_95
.LBB7_46:
	xorl	%eax, %eax
	cmpb	$43, %dl
	sete	%al
	movq	%rdi, %rdx
	subq	%rax, %rdx
	addq	%rax, %rsi
	negq	%rax
	cmpq	$17, %rdx
	jae	.LBB7_51
	testq	%rdx, %rdx
	je	.LBB7_88
	addq	%rax, %rdi
	negq	%rdi
	xorl	%ebx, %ebx
	xorl	%eax, %eax
	.p2align	4
.LBB7_49:
	movzbl	(%rsi,%rax), %edx
	addl	$-48, %edx
	cmpl	$9, %edx
	ja	.LBB7_101
	leaq	(%rbx,%rbx,4), %r8
	movl	%edx, %edx
	leaq	(%rdx,%r8,2), %rbx
	incq	%rax
	movq	%rdi, %rdx
	addq	%rax, %rdx
	jne	.LBB7_49
	jmp	.LBB7_56
.LBB7_51:
	addq	%rax, %rdi
	negq	%rdi
	xorl	%ebx, %ebx
	movl	$10, %r8d
	xorl	%r9d, %r9d
	.p2align	4
.LBB7_52:
	movq	%rbx, %rax
	mulq	%r8
	movzbl	(%rsi,%r9), %edx
	jo	.LBB7_93
	addl	$-48, %edx
	cmpl	$10, %edx
	jae	.LBB7_101
	movq	%rax, %rbx
	movl	%edx, %eax
	addq	%rax, %rbx
	jb	.LBB7_94
	incq	%r9
	movq	%rdi, %rax
	addq	%r9, %rax
	jne	.LBB7_52
.LBB7_56:
	cmpq	$64, %rcx
	jae	.LBB7_89
.LBB7_57:
	testb	$7, %cl
	jne	.LBB7_89
	testq	%rbx, %rbx
	je	.LBB7_89
	callq	*_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$2048, %edi
	movl	$8, %esi
	callq	*_RNvCshVjSbrpHdcL_7___rustc19___rust_alloc_zeroed@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB7_115
	movl	%eax, %ecx
	negl	%ecx
	andl	$56, %ecx
	movq	-216(%rbp), %r8
	addq	%r8, %rcx
	movq	%rcx, %rdx
	shrq	$3, %rdx
	leaq	32(%rdx), %rdi
	cmpq	$1792, %rcx
	movq	%rax, -56(%rbp)
	jae	.LBB7_117
	leaq	64(%rdx), %rsi
	leaq	(%rax,%rdi,8), %rdi
	movq	%rdi, (%rax,%rdx,8)
	cmpq	$1536, %rcx
	movq	%rdi, -240(%rbp)
	jae	.LBB7_116
	leaq	(%rax,%rdx,8), %rcx
	leaq	(%rax,%rsi,8), %rdx
	movq	%rdx, (%rdi)
	movq	%rcx, (%rax,%rsi,8)
	movq	%rcx, -48(%rbp)
	andl	$56, %ecx
	movq	%rcx, -112(%rbp)
	cmpq	%r8, %rcx
	jne	.LBB7_97
	movq	%rbx, -224(%rbp)
	movq	40(%r12), %rsi
	cmpq	$4, %rsi
	movq	%rdx, -232(%rbp)
	jbe	.LBB7_65
	movq	32(%r12), %rcx
	movl	$1767991395, %edx
	xorl	-5(%rcx,%rsi), %edx
	movzbl	-1(%rcx,%rsi), %ecx
	xorl	$110, %ecx
	orl	%edx, %ecx
	leaq	(,%rbx,8), %rax
	testl	%ecx, %ecx
	cmoveq	%rbx, %rax
	jmp	.LBB7_66
.LBB7_65:
	leaq	(,%rbx,8), %rax
.LBB7_66:
	movq	%rax, -248(%rbp)
.Ltmp15:
	callq	*_RNvMNtCs341anU20NIK_3std4timeNtB2_7Instant3now@GOTPCREL(%rip)
.Ltmp16:
	movq	%rax, -136(%rbp)
	movl	%edx, -128(%rbp)
	movq	32(%r12), %rax
	movq	40(%r12), %rcx
	leaq	.Lalloc_914b300a969ec1f0629b8996394c2a5b(%rip), %rdx
	movl	$14, %esi
	leaq	.Lalloc_476509aa7047bd805d630c6546685797(%rip), %rdi
	cmpq	$3, %rcx
	jne	.LBB7_70
	movzwl	(%rax), %ecx
	xorl	$28525, %ecx
	movzbl	2(%rax), %eax
	xorl	$118, %eax
	orw	%cx, %ax
	jne	.LBB7_119
	movq	%r15, %rax
	movq	%r12, %rcx
	movq	-48(%rbp), %rdx
	#APP

	.p2align	6
.Ltmp34:
	movq	(%rdx), %r8
	movq	8(%rdx), %r9
	movq	(%rdx), %r10
	movq	8(%rdx), %r11
	movq	(%rdx), %r12
	movq	8(%rdx), %r13
	movq	(%rdx), %r14
	movq	8(%rdx), %r15
	movq	(%rdx), %r8
	movq	8(%rdx), %r9
	movq	(%rdx), %r10
	movq	8(%rdx), %r11
	movq	(%rdx), %r12
	movq	8(%rdx), %r13
	movq	(%rdx), %r14
	movq	8(%rdx), %r15
	decq	%rbx
	jne	.Ltmp34

	#NO_APP
	movq	%rcx, %r12
	movq	%rax, %r15
	movq	%rdx, %r14
	jmp	.LBB7_73
.LBB7_70:
	cmpq	$9, %rcx
	jne	.LBB7_119
	movabsq	$7593465221897154413, %rcx
	xorq	(%rax), %rcx
	movzbl	8(%rax), %eax
	xorq	$110, %rax
	orq	%rcx, %rax
	jne	.LBB7_119
	movq	-48(%rbp), %r14
	#APP

	.p2align	6
.Ltmp35:
	movq	(%r14), %r14
	decq	%rbx
	jne	.Ltmp35

	#NO_APP
.LBB7_73:
	movq	%rbx, -224(%rbp)
.Ltmp17:
	leaq	-136(%rbp), %rdi
	callq	*_RNvMNtCs341anU20NIK_3std4timeNtB2_7Instant7elapsed@GOTPCREL(%rip)
.Ltmp18:
	movl	%edx, %ecx
	movl	$1000000000, %edx
	mulq	%rdx
	movl	%ecx, %ecx
	addq	%rax, %rcx
	adcq	$0, %rdx
	movq	%rcx, -176(%rbp)
	movq	%rdx, -168(%rbp)
	testq	%rbx, %rbx
	jne	.LBB7_98
	cmpq	-48(%rbp), %r14
	je	.LBB7_78
	cmpq	-240(%rbp), %r14
	je	.LBB7_78
	cmpq	-232(%rbp), %r14
	jne	.LBB7_118
.LBB7_78:
	leaq	-176(%rbp), %rax
	movq	%rax, -112(%rbp)
	movq	_RNvXNtNtCsc9NCSoc2doQ_4core3fmt3numoNtB4_7Display3fmt@GOTPCREL(%rip), %rax
	movq	%rax, -104(%rbp)
	leaq	-248(%rbp), %rax
	movq	%rax, -96(%rbp)
	movq	_RNvXsi_NtNtNtCsc9NCSoc2doQ_4core3fmt3num3impjNtB9_7Display3fmt@GOTPCREL(%rip), %rax
	movq	%rax, -88(%rbp)
	leaq	-216(%rbp), %rcx
	movq	%rcx, -80(%rbp)
	movq	%rax, -72(%rbp)
.Ltmp21:
	leaq	.Lalloc_a2e74a6541c48cbb69d2ea18d05ed4af(%rip), %rdi
	leaq	-112(%rbp), %rsi
	callq	*_RNvNtNtCs341anU20NIK_3std2io5stdio6__print@GOTPCREL(%rip)
.Ltmp22:
	movl	$2048, %esi
	movl	$8, %edx
	movq	-56(%rbp), %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	leaq	8(%r12), %rbx
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r14
	jmp	.LBB7_81
	.p2align	4
.LBB7_80:
	addq	$24, %rbx
	decq	%r15
	je	.LBB7_83
.LBB7_81:
	movq	-8(%rbx), %rsi
	testq	%rsi, %rsi
	je	.LBB7_80
	movq	(%rbx), %rdi
	movl	$1, %edx
	callq	*%r14
	jmp	.LBB7_80
.LBB7_83:
	movq	-208(%rbp), %rax
	testq	%rax, %rax
	je	.LBB7_85
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	movq	%r12, %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB7_85:
	addq	$216, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.LBB7_86:
	.cfi_def_cfa %rbp, 16
	xorl	%ecx, %ecx
	movq	%rcx, -216(%rbp)
	cmpq	$4, %r15
	jae	.LBB7_41
.LBB7_87:
	leaq	.Lalloc_d50ea6cdcd54f85eaa40ef2be93511d1(%rip), %rdx
	movl	$3, %edi
	movl	$3, %esi
	jmp	.LBB7_114
.LBB7_88:
	xorl	%ebx, %ebx
	cmpq	$64, %rcx
	jb	.LBB7_57
.LBB7_89:
.Ltmp11:
	leaq	.Lalloc_420eb395d9a878d45ae0b3deb55ceb7d(%rip), %rdi
	leaq	.Lalloc_d5d66c52ede0808a25fb919dc8e9dce7(%rip), %rdx
	movl	$57, %esi
	callq	*_RNvNtCsc9NCSoc2doQ_4core9panicking5panic@GOTPCREL(%rip)
.Ltmp12:
	jmp	.LBB7_120
.LBB7_90:
	addb	$-48, %dl
	xorl	%eax, %eax
	cmpb	$10, %dl
	adcb	$1, %al
	jmp	.LBB7_92
.LBB7_91:
	movb	$2, %al
.LBB7_92:
	movb	%al, -112(%rbp)
	leaq	.Lalloc_4494d098b37242f7928d2c8d1f49b7d4(%rip), %r8
	jmp	.LBB7_96
.LBB7_93:
	addb	$-48, %dl
	xorl	%eax, %eax
	cmpb	$10, %dl
	adcb	$1, %al
	jmp	.LBB7_95
.LBB7_94:
	movb	$2, %al
.LBB7_95:
	movb	%al, -112(%rbp)
	leaq	.Lalloc_76f12a8800874b824ed9e3f937e4de0c(%rip), %r8
.LBB7_96:
	leaq	-112(%rbp), %rdx
.Ltmp9:
	leaq	.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274(%rip), %rdi
	leaq	.Lvtable.1(%rip), %rcx
	movl	$43, %esi
	callq	*_RNvNtCsc9NCSoc2doQ_4core6result13unwrap_failed@GOTPCREL(%rip)
.Ltmp10:
	jmp	.LBB7_120
.LBB7_97:
	leaq	.Lalloc_00f10fda0189451fdd9f906c323b1f7a(%rip), %r9
	leaq	-216(%rbp), %rdx
	jmp	.LBB7_99
.LBB7_98:
	leaq	.Lalloc_043ce7de8df2be6d13a067d36671b4bb(%rip), %r9
	leaq	.Lalloc_53973d2fe29b4adba8bb7390b5678745(%rip), %rdx
	leaq	-224(%rbp), %r13
.LBB7_99:
.Ltmp19:
	xorl	%edi, %edi
	movq	%r13, %rsi
	xorl	%ecx, %ecx
	callq	*_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedjjEB4_@GOTPCREL(%rip)
.Ltmp20:
	jmp	.LBB7_120
.LBB7_100:
	movb	$1, %al
	jmp	.LBB7_92
.LBB7_101:
	movb	$1, %al
	jmp	.LBB7_95
.LBB7_104:
	movq	-168(%rbp), %r14
	movq	-152(%rbp), %rcx
	movq	%rcx, %rax
	subq	%r14, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	movq	$0, -208(%rbp)
	movq	$8, -200(%rbp)
	movq	$0, -192(%rbp)
	cmpq	%r14, %rcx
	jne	.LBB7_108
.LBB7_105:
	movq	-160(%rbp), %rax
	testq	%rax, %rax
	je	.LBB7_107
	movq	-176(%rbp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB7_107:
	leaq	.Lalloc_1ee0f155632c3b02935294b090f6771d(%rip), %rdx
	movl	$1, %edi
	xorl	%esi, %esi
	jmp	.LBB7_114
.LBB7_108:
	movq	%rdx, %rbx
	shrq	$4, %rbx
	addq	$8, %r14
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r15
	jmp	.LBB7_110
	.p2align	4
.LBB7_109:
	addq	$24, %r14
	decq	%rbx
	je	.LBB7_105
.LBB7_110:
	movq	-8(%r14), %rsi
	testq	%rsi, %rsi
	je	.LBB7_109
	movq	(%r14), %rdi
	movl	$1, %edx
	callq	*%r15
	jmp	.LBB7_109
.LBB7_112:
	movq	%r15, %rsi
	leaq	.Lalloc_1ee0f155632c3b02935294b090f6771d(%rip), %rdx
	movl	$1, %edi
	jmp	.LBB7_114
.LBB7_113:
	leaq	.Lalloc_2ba955f078ef0c11d638541e04137d9e(%rip), %rdx
	movl	$2, %edi
	movl	$2, %esi
.LBB7_114:
.Ltmp31:
	callq	*_RNvNtCsc9NCSoc2doQ_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.Ltmp32:
	jmp	.LBB7_120
.LBB7_115:
.Ltmp26:
	movl	$8, %edi
	movl	$2048, %esi
	callq	*_RNvNtCs3v2GDSbr0UZ_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Ltmp27:
	jmp	.LBB7_120
.LBB7_116:
	movq	%rsi, %rdi
.LBB7_117:
.Ltmp13:
	leaq	.Lalloc_35c978fcd580d2a5bb05b3f4e6f3fe6f(%rip), %rdx
	movl	$256, %esi
	callq	*_RNvNtCsc9NCSoc2doQ_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.Ltmp14:
	jmp	.LBB7_120
.LBB7_118:
	leaq	.Lalloc_e0774f4b155633eee15ba7f95ca6f57b(%rip), %rdx
	movl	$78, %esi
	leaq	.Lalloc_7c120839c2e7226ab80bcf84126cb91f(%rip), %rdi
.LBB7_119:
.Ltmp23:
	callq	*_RNvNtCsc9NCSoc2doQ_4core9panicking5panic@GOTPCREL(%rip)
.Ltmp24:
.LBB7_120:
	ud2
.LBB7_121:
	xorl	%eax, %eax
	jmp	.LBB7_92
.LBB7_122:
	xorl	%eax, %eax
	jmp	.LBB7_95
.LBB7_123:
.Ltmp2:
	movq	%rax, %rbx
	jmp	.LBB7_134
.LBB7_124:
.Ltmp8:
	movq	%rax, %rbx
	testq	%r14, %r14
	je	.LBB7_127
	movl	$1, %edx
	movq	%r13, %rdi
	movq	%r14, %rsi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	jmp	.LBB7_127
.LBB7_126:
.Ltmp5:
	movq	%rax, %rbx
.LBB7_127:
	leaq	-112(%rbp), %rdi
	callq	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECse5eZEUQffQP_4load
	leaq	-136(%rbp), %rdi
	callq	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECse5eZEUQffQP_4load
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.LBB7_128:
.Ltmp25:
	movq	%rax, %rbx
	movl	$2048, %esi
	movl	$8, %edx
	movq	-56(%rbp), %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	leaq	-208(%rbp), %rdi
	callq	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECse5eZEUQffQP_4load
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.LBB7_129:
.Ltmp33:
	movq	%rax, %rbx
	leaq	-208(%rbp), %rdi
	callq	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECse5eZEUQffQP_4load
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.LBB7_132:
.Ltmp30:
	movq	%rax, %rbx
	testq	%r14, %r14
	je	.LBB7_134
	movl	$1, %edx
	movq	-48(%rbp), %rdi
	movq	%r14, %rsi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB7_134:
	movq	-168(%rbp), %r15
	movq	-152(%rbp), %rcx
	movq	%rcx, %rax
	subq	%r15, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	cmpq	%r15, %rcx
	jne	.LBB7_137
.LBB7_135:
	movq	-160(%rbp), %rax
	testq	%rax, %rax
	jne	.LBB7_141
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.LBB7_137:
	movq	%rdx, %r14
	shrq	$4, %r14
	addq	$8, %r15
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r12
	jmp	.LBB7_139
	.p2align	4
.LBB7_138:
	addq	$24, %r15
	decq	%r14
	je	.LBB7_135
.LBB7_139:
	movq	-8(%r15), %rsi
	testq	%rsi, %rsi
	je	.LBB7_138
	movq	(%r15), %rdi
	movl	$1, %edx
	callq	*%r12
	jmp	.LBB7_138
.LBB7_141:
	movq	-176(%rbp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.Lfunc_end7:
	.size	_RNvCse5eZEUQffQP_4load4main, .Lfunc_end7-_RNvCse5eZEUQffQP_4load4main
	.cfi_endproc
	.section	.gcc_except_table._RNvCse5eZEUQffQP_4load4main,"a",@progbits
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
	.uleb128 .Ltmp28-.Lfunc_begin0
	.uleb128 .Ltmp29-.Ltmp28
	.uleb128 .Ltmp30-.Lfunc_begin0
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
	.uleb128 .Ltmp15-.Ltmp7
	.byte	0
	.byte	0
	.uleb128 .Ltmp15-.Lfunc_begin0
	.uleb128 .Ltmp22-.Ltmp15
	.uleb128 .Ltmp25-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp22-.Lfunc_begin0
	.uleb128 .Ltmp11-.Ltmp22
	.byte	0
	.byte	0
	.uleb128 .Ltmp11-.Lfunc_begin0
	.uleb128 .Ltmp10-.Ltmp11
	.uleb128 .Ltmp33-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp19-.Lfunc_begin0
	.uleb128 .Ltmp20-.Ltmp19
	.uleb128 .Ltmp25-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp20-.Lfunc_begin0
	.uleb128 .Ltmp31-.Ltmp20
	.byte	0
	.byte	0
	.uleb128 .Ltmp31-.Lfunc_begin0
	.uleb128 .Ltmp27-.Ltmp31
	.uleb128 .Ltmp33-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp13-.Lfunc_begin0
	.uleb128 .Ltmp24-.Ltmp13
	.uleb128 .Ltmp25-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp24-.Lfunc_begin0
	.uleb128 .Lfunc_end7-.Ltmp24
	.byte	0
	.byte	0
.Lcst_end0:
	.p2align	2, 0x0

	.section	.text.unlikely._RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCse5eZEUQffQP_4load,"ax",@progbits
	.prefalign	4, .Lfunc_end8, nop
	.type	_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCse5eZEUQffQP_4load,@function
_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCse5eZEUQffQP_4load:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	.cfi_offset %rbx, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	movq	%rdx, %r9
	movq	%rdi, %rbx
	movq	%r8, %rax
	mulq	%rcx
	movq	%rax, %r14
	seto	%al
	movabsq	$9223372036854775800, %rcx
	cmpq	%rcx, %r14
	seta	%cl
	orb	%al, %cl
	movl	$1, %r15d
	je	.LBB8_2
	movl	$8, %eax
	xorl	%r14d, %r14d
	jmp	.LBB8_10
.LBB8_2:
	testq	%rsi, %rsi
	je	.LBB8_4
	imulq	%rsi, %r8
	movl	$8, %edx
	movq	%r9, %rdi
	movq	%r8, %rsi
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
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end8:
	.size	_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCse5eZEUQffQP_4load, .Lfunc_end8-_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCse5eZEUQffQP_4load
	.cfi_endproc

	.section	.text._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load,"ax",@progbits
	.prefalign	4, .Lfunc_end9, nop
	.type	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load,@function
_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rsi, %rax
	movq	(%rdi), %rcx
	movzbl	(%rcx), %ecx
	leaq	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load(%rip), %rdx
	movzbl	(%rcx,%rdx), %edx
	leaq	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load.37.rel(%rip), %rdi
	movslq	(%rdi,%rcx,4), %rsi
	addq	%rdi, %rsi
	movq	%rax, %rdi
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	jmpq	*_RNvMsa_NtCsc9NCSoc2doQ_4core3fmtNtB5_9Formatter9write_str@GOTPCREL(%rip)
.Lfunc_end9:
	.size	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load, .Lfunc_end9-_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load
	.cfi_endproc

	.section	.text._RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt,"ax",@progbits
	.prefalign	4, .Lfunc_end10, nop
	.type	_RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt,@function
_RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rsi, %rax
	movq	%rdi, -8(%rbp)
	leaq	.Lvtable.2(%rip), %rcx
	movq	%rcx, (%rsp)
	leaq	.Lalloc_f62df14955f7d78bca139b0a7668683d(%rip), %rsi
	leaq	.Lalloc_a5d866b1768ad3f826bccdb004a1a8ae(%rip), %rcx
	leaq	-8(%rbp), %r9
	movl	$13, %edx
	movl	$4, %r8d
	movq	%rax, %rdi
	callq	*_RNvMsa_NtCsc9NCSoc2doQ_4core3fmtNtB5_9Formatter26debug_struct_field1_finish@GOTPCREL(%rip)
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
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
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rsi, %rcx
	movslq	%edi, %rdx
	leaq	_RNvCse5eZEUQffQP_4load4main(%rip), %rax
	movq	%rax, -8(%rbp)
	leaq	.Lvtable.0(%rip), %rsi
	leaq	-8(%rbp), %rdi
	xorl	%r8d, %r8d
	callq	*_RNvNtCs341anU20NIK_3std2rt19lang_start_internal@GOTPCREL(%rip)
	addq	$16, %rsp
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end11:
	.size	main, .Lfunc_end11-main
	.cfi_endproc

	.type	.Lvtable.0,@object
	.section	.data.rel.ro..Lvtable.0,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.0:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCse5eZEUQffQP_4load
	.quad	_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cse5eZEUQffQP_4load
	.quad	_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0Cse5eZEUQffQP_4load
	.size	.Lvtable.0, 48

	.type	.Lalloc_ce2cc312368ebd978acf8f5fde6470cd,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_ce2cc312368ebd978acf8f5fde6470cd:
	.asciz	"/tmp/str-rfind-20261106/load.rs"
	.size	.Lalloc_ce2cc312368ebd978acf8f5fde6470cd, 32

	.type	.Lalloc_1ee0f155632c3b02935294b090f6771d,@object
	.section	.data.rel.ro..Lalloc_1ee0f155632c3b02935294b090f6771d,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_1ee0f155632c3b02935294b090f6771d:
	.quad	.Lalloc_ce2cc312368ebd978acf8f5fde6470cd
	.asciz	"\037\000\000\000\000\000\000\000\003\000\000\0005\000\000"
	.size	.Lalloc_1ee0f155632c3b02935294b090f6771d, 24

	.type	.Lalloc_2ba955f078ef0c11d638541e04137d9e,@object
	.section	.data.rel.ro..Lalloc_2ba955f078ef0c11d638541e04137d9e,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_2ba955f078ef0c11d638541e04137d9e:
	.quad	.Lalloc_ce2cc312368ebd978acf8f5fde6470cd
	.asciz	"\037\000\000\000\000\000\000\000\003\000\000\000K\000\000"
	.size	.Lalloc_2ba955f078ef0c11d638541e04137d9e, 24

	.type	.Lalloc_4494d098b37242f7928d2c8d1f49b7d4,@object
	.section	.data.rel.ro..Lalloc_4494d098b37242f7928d2c8d1f49b7d4,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_4494d098b37242f7928d2c8d1f49b7d4:
	.quad	.Lalloc_ce2cc312368ebd978acf8f5fde6470cd
	.asciz	"\037\000\000\000\000\000\000\000\003\000\000\000W\000\000"
	.size	.Lalloc_4494d098b37242f7928d2c8d1f49b7d4, 24

	.type	.Lalloc_d50ea6cdcd54f85eaa40ef2be93511d1,@object
	.section	.data.rel.ro..Lalloc_d50ea6cdcd54f85eaa40ef2be93511d1,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_d50ea6cdcd54f85eaa40ef2be93511d1:
	.quad	.Lalloc_ce2cc312368ebd978acf8f5fde6470cd
	.asciz	"\037\000\000\000\000\000\000\000\003\000\000\000m\000\000"
	.size	.Lalloc_d50ea6cdcd54f85eaa40ef2be93511d1, 24

	.type	.Lalloc_76f12a8800874b824ed9e3f937e4de0c,@object
	.section	.data.rel.ro..Lalloc_76f12a8800874b824ed9e3f937e4de0c,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_76f12a8800874b824ed9e3f937e4de0c:
	.quad	.Lalloc_ce2cc312368ebd978acf8f5fde6470cd
	.asciz	"\037\000\000\000\000\000\000\000\003\000\000\000y\000\000"
	.size	.Lalloc_76f12a8800874b824ed9e3f937e4de0c, 24

	.type	.Lalloc_00f10fda0189451fdd9f906c323b1f7a,@object
	.section	.data.rel.ro..Lalloc_00f10fda0189451fdd9f906c323b1f7a,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_00f10fda0189451fdd9f906c323b1f7a:
	.quad	.Lalloc_ce2cc312368ebd978acf8f5fde6470cd
	.asciz	"\037\000\000\000\000\000\000\000\006\000\000\000-\000\000"
	.size	.Lalloc_00f10fda0189451fdd9f906c323b1f7a, 24

	.type	.Lalloc_476509aa7047bd805d630c6546685797,@object
	.section	.rodata..Lalloc_476509aa7047bd805d630c6546685797,"a",@progbits
.Lalloc_476509aa7047bd805d630c6546685797:
	.ascii	"explicit panic"
	.size	.Lalloc_476509aa7047bd805d630c6546685797, 14

	.type	.Lalloc_914b300a969ec1f0629b8996394c2a5b,@object
	.section	.data.rel.ro..Lalloc_914b300a969ec1f0629b8996394c2a5b,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_914b300a969ec1f0629b8996394c2a5b:
	.quad	.Lalloc_ce2cc312368ebd978acf8f5fde6470cd
	.asciz	"\037\000\000\000\000\000\000\000\033\000\000\000\211\000\000"
	.size	.Lalloc_914b300a969ec1f0629b8996394c2a5b, 24

	.type	.Lalloc_53973d2fe29b4adba8bb7390b5678745,@object
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.Lalloc_53973d2fe29b4adba8bb7390b5678745:
	.zero	8
	.size	.Lalloc_53973d2fe29b4adba8bb7390b5678745, 8

	.type	.Lalloc_7c120839c2e7226ab80bcf84126cb91f,@object
	.section	.rodata..Lalloc_7c120839c2e7226ab80bcf84126cb91f,"a",@progbits
.Lalloc_7c120839c2e7226ab80bcf84126cb91f:
	.ascii	"assertion failed: nodes.iter().any(|i| (&b[*i] as *const usize) as usize == p)"
	.size	.Lalloc_7c120839c2e7226ab80bcf84126cb91f, 78

	.type	.Lalloc_e0774f4b155633eee15ba7f95ca6f57b,@object
	.section	.data.rel.ro..Lalloc_e0774f4b155633eee15ba7f95ca6f57b,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_e0774f4b155633eee15ba7f95ca6f57b:
	.quad	.Lalloc_ce2cc312368ebd978acf8f5fde6470cd
	.asciz	"\037\000\000\000\000\000\000\000\036\000\000\0009\000\000"
	.size	.Lalloc_e0774f4b155633eee15ba7f95ca6f57b, 24

	.type	.Lalloc_a2e74a6541c48cbb69d2ea18d05ed4af,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_a2e74a6541c48cbb69d2ea18d05ed4af:
	.asciz	"\016{\"elapsed_ns\":\300\007,\"ops\":\300\r,\"alignment\":\300\002}\n"
	.size	.Lalloc_a2e74a6541c48cbb69d2ea18d05ed4af, 44

	.type	.Lalloc_043ce7de8df2be6d13a067d36671b4bb,@object
	.section	.data.rel.ro..Lalloc_043ce7de8df2be6d13a067d36671b4bb,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_043ce7de8df2be6d13a067d36671b4bb:
	.quad	.Lalloc_ce2cc312368ebd978acf8f5fde6470cd
	.asciz	"\037\000\000\000\000\000\000\000\036\000\000\000%\000\000"
	.size	.Lalloc_043ce7de8df2be6d13a067d36671b4bb, 24

	.type	.Lalloc_35c978fcd580d2a5bb05b3f4e6f3fe6f,@object
	.section	.data.rel.ro..Lalloc_35c978fcd580d2a5bb05b3f4e6f3fe6f,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_35c978fcd580d2a5bb05b3f4e6f3fe6f:
	.quad	.Lalloc_ce2cc312368ebd978acf8f5fde6470cd
	.asciz	"\037\000\000\000\000\000\000\000\005\000\000\000 \000\000"
	.size	.Lalloc_35c978fcd580d2a5bb05b3f4e6f3fe6f, 24

	.type	.Lalloc_420eb395d9a878d45ae0b3deb55ceb7d,@object
	.section	.rodata..Lalloc_420eb395d9a878d45ae0b3deb55ceb7d,"a",@progbits
.Lalloc_420eb395d9a878d45ae0b3deb55ceb7d:
	.ascii	"assertion failed: offset < 64 && offset % 8 == 0 && n > 0"
	.size	.Lalloc_420eb395d9a878d45ae0b3deb55ceb7d, 57

	.type	.Lalloc_d5d66c52ede0808a25fb919dc8e9dce7,@object
	.section	.data.rel.ro..Lalloc_d5d66c52ede0808a25fb919dc8e9dce7,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_d5d66c52ede0808a25fb919dc8e9dce7:
	.quad	.Lalloc_ce2cc312368ebd978acf8f5fde6470cd
	.asciz	"\037\000\000\000\000\000\000\000\003\000\000\000\202\000\000"
	.size	.Lalloc_d5d66c52ede0808a25fb919dc8e9dce7, 24

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
	.quad	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load
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

	.type	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load,"a",@progbits
	.p2align	3, 0x0
.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load:
	.ascii	"\005\f\013\013\004\016"
	.size	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load, 6

	.type	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load.37.rel,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load.37.rel,"a",@progbits
	.p2align	2, 0x0
.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load.37.rel:
	.long	.Lalloc_59ba7b9f7211443cd55a366616eef46a-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load.37.rel
	.long	.Lalloc_00315c78e51d29fe6b3102a4c1ecf6ef-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load.37.rel
	.long	.Lalloc_bd3a3f3879e0d5f64554753e977f58d4-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load.37.rel
	.long	.Lalloc_0964bb2a4870637395c77a018495bd5c-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load.37.rel
	.long	.Lalloc_6566120a3a17f930e960a0863fcbd591-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load.37.rel
	.long	.Lalloc_6c17bac0c71cba42380f8445f4dcbd16-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load.37.rel
	.size	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCse5eZEUQffQP_4load.37.rel, 24

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
