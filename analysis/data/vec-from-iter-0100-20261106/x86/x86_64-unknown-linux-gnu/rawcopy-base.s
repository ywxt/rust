	.att_syntax
	.file	"rawcopy.cb6247de70df53e9-cgu.0"
	.section	.text._RINvNtCs341anU20NIK_3std2rt10lang_startuECshsBGi11rG2H_7rawcopy,"ax",@progbits
	.hidden	_RINvNtCs341anU20NIK_3std2rt10lang_startuECshsBGi11rG2H_7rawcopy
	.globl	_RINvNtCs341anU20NIK_3std2rt10lang_startuECshsBGi11rG2H_7rawcopy
	.prefalign	4, .Lfunc_end0, nop
	.type	_RINvNtCs341anU20NIK_3std2rt10lang_startuECshsBGi11rG2H_7rawcopy,@function
_RINvNtCs341anU20NIK_3std2rt10lang_startuECshsBGi11rG2H_7rawcopy:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	%ecx, %r8d
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rdi, (%rsp)
	leaq	.Lvtable.1(%rip), %rsi
	movq	%rsp, %rdi
	callq	*_RNvNtCs341anU20NIK_3std2rt19lang_start_internal@GOTPCREL(%rip)
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	_RINvNtCs341anU20NIK_3std2rt10lang_startuECshsBGi11rG2H_7rawcopy, .Lfunc_end0-_RINvNtCs341anU20NIK_3std2rt10lang_startuECshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text._RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECshsBGi11rG2H_7rawcopy,"ax",@progbits
	.prefalign	4, .Lfunc_end1, nop
	.type	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECshsBGi11rG2H_7rawcopy,@function
_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECshsBGi11rG2H_7rawcopy:
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
	.size	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECshsBGi11rG2H_7rawcopy, .Lfunc_end1-_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text._RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECshsBGi11rG2H_7rawcopy,"ax",@progbits
	.prefalign	4, .Lfunc_end2, nop
	.type	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECshsBGi11rG2H_7rawcopy,@function
_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECshsBGi11rG2H_7rawcopy:
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
	.size	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECshsBGi11rG2H_7rawcopy, .Lfunc_end2-_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text.unlikely._RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedRSjBM_ECshsBGi11rG2H_7rawcopy,"ax",@progbits
	.type	_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedRSjBM_ECshsBGi11rG2H_7rawcopy,@function
_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedRSjBM_ECshsBGi11rG2H_7rawcopy:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	leaq	24(%rsp), %rax
	movq	%rdi, (%rax)
	leaq	32(%rsp), %rcx
	movq	%rsi, (%rcx)
	leaq	.Lalloc_67e13228cc1d9cff242e5e6206de75d9(%rip), %rdx
	movq	%rdx, 8(%rsp)
	leaq	.Lvtable.2(%rip), %rdx
	xorl	%edi, %edi
	movq	%rax, %rsi
	movq	%rdx, %r8
	xorl	%r9d, %r9d
	callq	*_RNvNtCsc9NCSoc2doQ_4core9panicking19assert_failed_inner@GOTPCREL(%rip)
.Lfunc_end3:
	.size	_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedRSjBM_ECshsBGi11rG2H_7rawcopy, .Lfunc_end3-_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedRSjBM_ECshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text._RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshsBGi11rG2H_7rawcopy,"ax",@progbits
	.prefalign	4, .Lfunc_end4, nop
	.type	_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshsBGi11rG2H_7rawcopy,@function
_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshsBGi11rG2H_7rawcopy:
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
	.size	_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshsBGi11rG2H_7rawcopy, .Lfunc_end4-_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text.unlikely._RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshsBGi11rG2H_7rawcopy,"ax",@progbits
	.prefalign	4, .Lfunc_end5, nop
	.type	_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshsBGi11rG2H_7rawcopy,@function
_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshsBGi11rG2H_7rawcopy:
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
	callq	_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshsBGi11rG2H_7rawcopy
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
	.size	_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshsBGi11rG2H_7rawcopy, .Lfunc_end5-_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text._RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0CshsBGi11rG2H_7rawcopy,"ax",@progbits
	.prefalign	4, .Lfunc_end6, nop
	.type	_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0CshsBGi11rG2H_7rawcopy,@function
_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0CshsBGi11rG2H_7rawcopy:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	(%rdi), %rdi
	callq	_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshsBGi11rG2H_7rawcopy
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end6:
	.size	_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0CshsBGi11rG2H_7rawcopy, .Lfunc_end6-_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0CshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text._RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCshsBGi11rG2H_7rawcopy,"ax",@progbits
	.prefalign	4, .Lfunc_end7, nop
	.type	_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCshsBGi11rG2H_7rawcopy,@function
_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCshsBGi11rG2H_7rawcopy:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	(%rdi), %rdi
	callq	_RINvNtNtCs341anU20NIK_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECshsBGi11rG2H_7rawcopy
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end7:
	.size	_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCshsBGi11rG2H_7rawcopy, .Lfunc_end7-_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI8_0:
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
.LCPI8_1:
	.quad	157
	.quad	157
.LCPI8_2:
	.quad	314
	.quad	314
.LCPI8_3:
	.quad	4
	.quad	4
	.section	.text._RNvCshsBGi11rG2H_7rawcopy4main,"ax",@progbits
	.hidden	_RNvCshsBGi11rG2H_7rawcopy4main
	.globl	_RNvCshsBGi11rG2H_7rawcopy4main
	.prefalign	4, .Lfunc_end8, nop
	.type	_RNvCshsBGi11rG2H_7rawcopy4main,@function
_RNvCshsBGi11rG2H_7rawcopy4main:
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
	subq	$64, %rsp
	movq	$0, (%rsp)
	movq	%rsp, %r11
	subq	$32768, %r11
.LBB8_1:
	subq	$4096, %rsp
	movq	$0, (%rsp)
	cmpq	%r11, %rsp
	jne	.LBB8_1
	subq	$256, %rsp
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	leaq	16640(%rsp), %rbx
	movq	%rbx, %rdi
	callq	*_RNvNtCs341anU20NIK_3std3env4args@GOTPCREL(%rip)
.Ltmp0:
	leaq	256(%rsp), %rdi
	movq	%rbx, %rsi
	callq	*_RNvXsc_NtCs341anU20NIK_3std3envNtB5_4ArgsNtNtNtNtCsc9NCSoc2doQ_4core4iter6traits8iterator8Iterator4next@GOTPCREL(%rip)
.Ltmp1:
	movq	256(%rsp), %r14
	cmpq	$-1, %r14
	je	.LBB8_157
	movq	264(%rsp), %rax
	movq	%rax, 16(%rsp)
	movq	16664(%rsp), %rax
	subq	16648(%rsp), %rax
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
	jbe	.LBB8_7
	xorl	%r13d, %r13d
.LBB8_6:
.Ltmp23:
	movq	%r13, %rdi
	movq	%r12, %rsi
	callq	*_RNvNtCs3v2GDSbr0UZ_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Ltmp24:
	jmp	.LBB8_167
.LBB8_7:
	movq	272(%rsp), %rbx
	testq	%r12, %r12
	je	.LBB8_10
	callq	*_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$8, %r13d
	movl	$8, %esi
	movq	%r12, %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB8_6
	movq	%rax, %rcx
	incq	%r15
	jmp	.LBB8_11
.LBB8_10:
	movl	$8, %ecx
	xorl	%r15d, %r15d
.LBB8_11:
	movq	%r14, (%rcx)
	movq	16(%rsp), %rax
	movq	%rax, 8(%rcx)
	movq	%rbx, 16(%rcx)
	movq	%r15, 24(%rsp)
	movq	%rcx, 16(%rsp)
	movq	%rcx, 32(%rsp)
	movq	$1, 40(%rsp)
	movups	16640(%rsp), %xmm0
	movdqu	16656(%rsp), %xmm1
	movdqa	%xmm1, 272(%rsp)
	movaps	%xmm0, 256(%rsp)
	movl	$1, %r14d
	movl	$40, %r12d
	leaq	256(%rsp), %rax
	movq	%rax, 48(%rsp)
	jmp	.LBB8_14
	.p2align	4
.LBB8_12:
	movq	32(%rsp), %rax
	movq	%rax, 16(%rsp)
.LBB8_13:
	movq	16(%rsp), %rax
	movq	%r13, -16(%rax,%r12)
	movq	%rbx, -8(%rax,%r12)
	movq	%r15, (%rax,%r12)
	incq	%r14
	movq	%r14, 40(%rsp)
	addq	$24, %r12
.LBB8_14:
.Ltmp3:
	leaq	128(%rsp), %rdi
	leaq	256(%rsp), %rsi
	callq	*_RNvXsc_NtCs341anU20NIK_3std3envNtB5_4ArgsNtNtNtNtCsc9NCSoc2doQ_4core4iter6traits8iterator8Iterator4next@GOTPCREL(%rip)
.Ltmp4:
	movq	128(%rsp), %r13
	cmpq	$-1, %r13
	je	.LBB8_18
	movq	136(%rsp), %rbx
	movq	144(%rsp), %r15
	cmpq	24(%rsp), %r14
	jne	.LBB8_13
	movq	280(%rsp), %rdx
	subq	264(%rsp), %rdx
	shrq	$3, %rdx
	movabsq	$-6148914691236517205, %rax
	imulq	%rax, %rdx
	incq	%rdx
.Ltmp6:
	leaq	24(%rsp), %rdi
	movq	%r14, %rsi
	callq	_RINvNvMs2_NtCs3v2GDSbr0UZ_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECshsBGi11rG2H_7rawcopy
.Ltmp7:
	jmp	.LBB8_12
.LBB8_18:
	movq	264(%rsp), %r14
	movq	280(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r14, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	cmpq	%r14, %rcx
	je	.LBB8_23
	movq	%rdx, %rbx
	shrq	$4, %rbx
	addq	$8, %r14
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r15
	jmp	.LBB8_21
	.p2align	4
.LBB8_20:
	addq	$24, %r14
	decq	%rbx
	je	.LBB8_23
.LBB8_21:
	movq	-8(%r14), %rsi
	testq	%rsi, %rsi
	je	.LBB8_20
	movq	(%r14), %rdi
	movl	$1, %edx
	callq	*%r15
	jmp	.LBB8_20
.LBB8_23:
	movq	272(%rsp), %rax
	testq	%rax, %rax
	je	.LBB8_25
	movq	256(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB8_25:
	movdqu	24(%rsp), %xmm0
	movdqa	%xmm0, 64(%rsp)
	movq	40(%rsp), %rsi
	movq	%rsi, 80(%rsp)
	cmpq	$2, %rsi
	jb	.LBB8_165
	movq	72(%rsp), %r10
	movq	32(%r10), %rcx
	movq	40(%r10), %rdi
	cmpq	$1, %rdi
	je	.LBB8_29
	testq	%rdi, %rdi
	je	.LBB8_168
	movzbl	(%rcx), %edx
	jmp	.LBB8_31
.LBB8_29:
	movzbl	(%rcx), %edx
	movb	$1, %al
	cmpl	$43, %edx
	je	.LBB8_131
	cmpl	$45, %edx
	je	.LBB8_131
.LBB8_31:
	xorl	%eax, %eax
	cmpb	$43, %dl
	sete	%al
	movq	%rdi, %rdx
	subq	%rax, %rdx
	addq	%rax, %rcx
	negq	%rax
	cmpq	$17, %rdx
	jae	.LBB8_36
	testq	%rdx, %rdx
	je	.LBB8_89
	addq	%rax, %rdi
	negq	%rdi
	xorl	%r13d, %r13d
	xorl	%eax, %eax
	.p2align	4
.LBB8_34:
	movzbl	(%rcx,%rax), %edx
	addl	$-48, %edx
	cmpl	$9, %edx
	ja	.LBB8_147
	leaq	(,%r13,4), %r8
	addq	%r13, %r8
	movl	%edx, %edx
	leaq	(%rdx,%r8,2), %r13
	incq	%rax
	movq	%rdi, %rdx
	addq	%rax, %rdx
	jne	.LBB8_34
	jmp	.LBB8_41
.LBB8_36:
	addq	%rax, %rdi
	negq	%rdi
	xorl	%r13d, %r13d
	movl	$10, %r8d
	xorl	%r9d, %r9d
	.p2align	4
.LBB8_37:
	movq	%r13, %rax
	mulq	%r8
	movzbl	(%rcx,%r9), %edx
	jo	.LBB8_129
	addl	$-48, %edx
	cmpl	$10, %edx
	jae	.LBB8_147
	movq	%rax, %r13
	movl	%edx, %eax
	addq	%rax, %r13
	jb	.LBB8_130
	incq	%r9
	movq	%rdi, %rax
	addq	%r9, %rax
	jne	.LBB8_37
.LBB8_41:
	movq	%r13, 56(%rsp)
	cmpq	$2, %rsi
	je	.LBB8_90
.LBB8_42:
	movq	56(%r10), %rcx
	movq	64(%r10), %rdi
	cmpq	$1, %rdi
	je	.LBB8_45
	testq	%rdi, %rdi
	je	.LBB8_169
	movzbl	(%rcx), %edx
	jmp	.LBB8_47
.LBB8_45:
	movzbl	(%rcx), %edx
	movb	$1, %al
	cmpl	$43, %edx
	je	.LBB8_134
	cmpl	$45, %edx
	je	.LBB8_134
.LBB8_47:
	xorl	%eax, %eax
	cmpb	$43, %dl
	sete	%al
	movq	%rdi, %rdx
	subq	%rax, %rdx
	addq	%rax, %rcx
	negq	%rax
	cmpq	$17, %rdx
	jae	.LBB8_52
	testq	%rdx, %rdx
	je	.LBB8_91
	addq	%rax, %rdi
	negq	%rdi
	xorl	%r12d, %r12d
	xorl	%eax, %eax
	.p2align	4
.LBB8_50:
	movzbl	(%rcx,%rax), %edx
	addl	$-48, %edx
	cmpl	$9, %edx
	ja	.LBB8_148
	leaq	(%r12,%r12,4), %r8
	movl	%edx, %edx
	leaq	(%rdx,%r8,2), %r12
	incq	%rax
	movq	%rdi, %rdx
	addq	%rax, %rdx
	jne	.LBB8_50
	jmp	.LBB8_57
.LBB8_52:
	addq	%rax, %rdi
	negq	%rdi
	xorl	%r12d, %r12d
	movl	$10, %r8d
	xorl	%r9d, %r9d
	.p2align	4
.LBB8_53:
	movq	%r12, %rax
	mulq	%r8
	movzbl	(%rcx,%r9), %edx
	jo	.LBB8_132
	addl	$-48, %edx
	cmpl	$10, %edx
	jae	.LBB8_148
	movq	%rax, %r12
	movl	%edx, %eax
	addq	%rax, %r12
	jb	.LBB8_133
	incq	%r9
	movq	%rdi, %rax
	addq	%r9, %rax
	jne	.LBB8_53
.LBB8_57:
	cmpq	$4, %rsi
	jb	.LBB8_92
.LBB8_58:
	movq	80(%r10), %rcx
	movq	88(%r10), %rdi
	cmpq	$1, %rdi
	je	.LBB8_61
	testq	%rdi, %rdi
	je	.LBB8_170
	movzbl	(%rcx), %edx
	jmp	.LBB8_63
.LBB8_61:
	movzbl	(%rcx), %edx
	movb	$1, %al
	cmpl	$43, %edx
	je	.LBB8_137
	cmpl	$45, %edx
	je	.LBB8_137
.LBB8_63:
	xorl	%eax, %eax
	cmpb	$43, %dl
	sete	%al
	movq	%rdi, %rdx
	subq	%rax, %rdx
	addq	%rax, %rcx
	negq	%rax
	cmpq	$17, %rdx
	jae	.LBB8_68
	testq	%rdx, %rdx
	je	.LBB8_93
	addq	%rax, %rdi
	negq	%rdi
	xorl	%ebx, %ebx
	xorl	%eax, %eax
	.p2align	4
.LBB8_66:
	movzbl	(%rcx,%rax), %edx
	addl	$-48, %edx
	cmpl	$9, %edx
	ja	.LBB8_149
	leaq	(%rbx,%rbx,4), %r8
	movl	%edx, %edx
	leaq	(%rdx,%r8,2), %rbx
	incq	%rax
	movq	%rdi, %rdx
	addq	%rax, %rdx
	jne	.LBB8_66
	jmp	.LBB8_73
.LBB8_68:
	addq	%rax, %rdi
	negq	%rdi
	xorl	%ebx, %ebx
	movl	$10, %r8d
	xorl	%r9d, %r9d
	.p2align	4
.LBB8_69:
	movq	%rbx, %rax
	mulq	%r8
	movzbl	(%rcx,%r9), %edx
	jo	.LBB8_135
	addl	$-48, %edx
	cmpl	$10, %edx
	jae	.LBB8_149
	movq	%rax, %rbx
	movl	%edx, %eax
	addq	%rax, %rbx
	jb	.LBB8_136
	incq	%r9
	movq	%rdi, %rax
	addq	%r9, %rax
	jne	.LBB8_69
.LBB8_73:
	cmpq	$4, %rsi
	je	.LBB8_94
.LBB8_74:
	movq	104(%r10), %rcx
	movq	112(%r10), %rsi
	cmpq	$1, %rsi
	je	.LBB8_77
	testq	%rsi, %rsi
	je	.LBB8_171
	movzbl	(%rcx), %edx
	jmp	.LBB8_79
.LBB8_77:
	movzbl	(%rcx), %edx
	movb	$1, %al
	cmpl	$43, %edx
	je	.LBB8_140
	cmpl	$45, %edx
	je	.LBB8_140
.LBB8_79:
	xorl	%eax, %eax
	cmpb	$43, %dl
	sete	%al
	movq	%rsi, %rdx
	subq	%rax, %rdx
	addq	%rax, %rcx
	negq	%rax
	cmpq	$17, %rdx
	jae	.LBB8_84
	testq	%rdx, %rdx
	je	.LBB8_95
	addq	%rax, %rsi
	negq	%rsi
	xorl	%r14d, %r14d
	xorl	%eax, %eax
	.p2align	4
.LBB8_82:
	movzbl	(%rcx,%rax), %edx
	addl	$-48, %edx
	cmpl	$9, %edx
	ja	.LBB8_152
	leaq	(%r14,%r14,4), %rdi
	movl	%edx, %edx
	leaq	(%rdx,%rdi,2), %r14
	incq	%rax
	movq	%rsi, %rdx
	addq	%rax, %rdx
	jne	.LBB8_82
	jmp	.LBB8_96
.LBB8_84:
	addq	%rax, %rsi
	negq	%rsi
	xorl	%r14d, %r14d
	movl	$10, %edi
	xorl	%r8d, %r8d
	.p2align	4
.LBB8_85:
	movq	%r14, %rax
	mulq	%rdi
	movzbl	(%rcx,%r8), %edx
	jo	.LBB8_138
	addl	$-48, %edx
	cmpl	$10, %edx
	jae	.LBB8_152
	movq	%rax, %r14
	movl	%edx, %eax
	addq	%rax, %r14
	jb	.LBB8_139
	incq	%r8
	movq	%rsi, %rax
	addq	%r8, %rax
	jne	.LBB8_85
	jmp	.LBB8_96
.LBB8_89:
	xorl	%r13d, %r13d
	movq	%r13, 56(%rsp)
	cmpq	$2, %rsi
	jne	.LBB8_42
.LBB8_90:
	leaq	.Lalloc_9189b17a0d38f81e0b768fdd496ad016(%rip), %rdx
	movl	$2, %edi
	movl	$2, %esi
	jmp	.LBB8_166
.LBB8_91:
	xorl	%r12d, %r12d
	cmpq	$4, %rsi
	jae	.LBB8_58
.LBB8_92:
	leaq	.Lalloc_5402922c1b616663f39de9605452433b(%rip), %rdx
	movl	$3, %edi
	movl	$3, %esi
	jmp	.LBB8_166
.LBB8_93:
	xorl	%ebx, %ebx
	cmpq	$4, %rsi
	jne	.LBB8_74
.LBB8_94:
	leaq	.Lalloc_2be509ebd9cc61f70f092dfe957ed169(%rip), %rdx
	movl	$4, %edi
	movl	$4, %esi
	jmp	.LBB8_166
.LBB8_95:
	xorl	%r14d, %r14d
.LBB8_96:
	movq	%r14, 120(%rsp)
	movl	%ebx, %eax
	orl	%r12d, %eax
	leaq	.Lalloc_128dcacd48065ecac459e8f68ca2fcca(%rip), %rdx
	movl	$92, %esi
	leaq	.Lalloc_10fe3fd7842db3316470af18c3d2140d(%rip), %rdi
	testb	$7, %al
	jne	.LBB8_151
	shrq	$3, %r12
	leaq	(%r12,%r13), %rax
	cmpq	$2048, %rax
	ja	.LBB8_151
	movq	%rbx, %rax
	shrq	$3, %rax
	movq	%rax, 48(%rsp)
	addq	%r13, %rax
	cmpq	$2049, %rax
	jae	.LBB8_151
	movq	%r10, 16(%rsp)
	leaq	16640(%rsp), %rdi
	xorl	%r15d, %r15d
	movl	$16384, %edx
	xorl	%esi, %esi
	callq	*memset@GOTPCREL(%rip)
	leaq	256(%rsp), %rdi
	movl	$16384, %edx
	movl	$255, %esi
	callq	*memset@GOTPCREL(%rip)
	movq	%r13, %xmm0
	pshufd	$68, %xmm0, %xmm0
	movdqa	.LCPI8_0(%rip), %xmm1
	movdqa	.LCPI8_1(%rip), %xmm2
	movdqa	.LCPI8_2(%rip), %xmm3
	movdqa	.LCPI8_3(%rip), %xmm4
	.p2align	4
.LBB8_100:
	movdqa	%xmm1, %xmm5
	pmuludq	%xmm2, %xmm5
	movdqa	%xmm1, %xmm6
	psrlq	$32, %xmm6
	pmuludq	%xmm2, %xmm6
	psllq	$32, %xmm6
	paddq	%xmm5, %xmm6
	movdqa	%xmm0, %xmm5
	pxor	%xmm6, %xmm5
	paddq	%xmm3, %xmm6
	pxor	%xmm0, %xmm6
	movdqa	%xmm5, 16640(%rsp,%r15,8)
	movdqa	%xmm6, 16656(%rsp,%r15,8)
	addq	$4, %r15
	paddq	%xmm4, %xmm1
	cmpq	$2048, %r15
	jne	.LBB8_100
.Ltmp11:
	callq	*_RNvMNtCs341anU20NIK_3std4timeNtB2_7Instant3now@GOTPCREL(%rip)
.Ltmp12:
	movq	%r12, 224(%rsp)
	leaq	(%rsp,%r12,8), %rsi
	addq	$16640, %rsi
	movq	%rbx, %rcx
	andq	$-8, %rcx
	movq	%rcx, 208(%rsp)
	leaq	(%rsp,%rcx), %r15
	addq	$256, %r15
	movq	%rax, 240(%rsp)
	movl	%edx, 248(%rsp)
	testq	%r14, %r14
	je	.LBB8_105
	xorl	%r14d, %r14d
	.p2align	4
.LBB8_104:
	movq	%r15, 96(%rsp)
	leaq	96(%rsp), %rax
	#APP
	#NO_APP
	movq	%rsi, 24(%rsp)
	leaq	24(%rsp), %rax
	#APP
	#NO_APP
	movq	56(%rsp), %rax
	movq	%rax, 128(%rsp)
	leaq	128(%rsp), %r12
	#APP
	#NO_APP
	movq	96(%rsp), %rdi
	movq	%r15, %r13
	movq	%rsi, %r15
	movq	24(%rsp), %rsi
	movq	128(%rsp), %rdx
	callq	raw_copy
	movq	%r15, %rsi
	movq	%r13, %r15
	incq	%r14
	movq	%r13, 128(%rsp)
	#APP
	#NO_APP
	cmpq	120(%rsp), %r14
	jb	.LBB8_104
.LBB8_105:
.Ltmp13:
	movq	%rsi, 216(%rsp)
	leaq	240(%rsp), %rdi
	callq	*_RNvMNtCs341anU20NIK_3std4timeNtB2_7Instant7elapsed@GOTPCREL(%rip)
.Ltmp14:
	movq	224(%rsp), %rdi
	movl	%edx, %ecx
	movl	$1000000000, %edx
	mulq	%rdx
	movl	%ecx, %ecx
	addq	%rax, %rcx
	adcq	$0, %rdx
	movq	%rcx, 96(%rsp)
	movq	%rdx, 104(%rsp)
	movq	56(%rsp), %rdx
	movq	48(%rsp), %r13
	leaq	(%rdx,%r13), %r14
	leaq	.Lalloc_33aa5ed87fc549baeed98c7b00832370(%rip), %rcx
	cmpq	%r13, %r14
	jb	.LBB8_142
	cmpq	$2049, %r14
	jae	.LBB8_142
	movq	%r15, 24(%rsp)
	movq	%rdx, 32(%rsp)
	leaq	(%rdx,%rdi), %rsi
	leaq	.Lalloc_b648483c9ddff22c79d46fb5d378ae68(%rip), %rcx
	cmpq	%rdi, %rsi
	jb	.LBB8_144
	cmpq	$2048, %rsi
	ja	.LBB8_144
	movq	216(%rsp), %r12
	movq	%r12, 128(%rsp)
	movq	%rdx, 136(%rsp)
	shlq	$3, %rdx
	movq	%r15, %rdi
	movq	%r12, %rsi
	callq	*bcmp@GOTPCREL(%rip)
	testl	%eax, %eax
	jne	.LBB8_145
	cmpq	$16391, %rbx
	ja	.LBB8_143
	movq	208(%rsp), %rcx
	testq	%rcx, %rcx
	je	.LBB8_116
	xorl	%eax, %eax
	leaq	.Lalloc_4efdf6768da75f185dd8c24d590857cb(%rip), %rdx
	leaq	.Lalloc_0151101a464c295a00273d42c0a8e152(%rip), %rdi
	.p2align	4
.LBB8_114:
	cmpq	$-1, 256(%rsp,%rax)
	jne	.LBB8_146
	addq	$8, %rax
	cmpq	%rax, %rcx
	jne	.LBB8_114
.LBB8_116:
	cmpq	$2048, %r14
	je	.LBB8_120
	shlq	$3, %r14
	leaq	.Lalloc_d781ac801ac6145c24d2c4d0e1bd65e1(%rip), %rdx
	leaq	.Lalloc_daae9162f00161f2bf97338a4f1e35ab(%rip), %rdi
	.p2align	4
.LBB8_118:
	cmpq	$-1, 256(%rsp,%r14)
	jne	.LBB8_150
	addq	$8, %r14
	cmpq	$16384, %r14
	jne	.LBB8_118
.LBB8_120:
	andl	$56, %r12d
	movq	%r12, 232(%rsp)
	andl	$56, %r15d
	movq	%r15, 24(%rsp)
	leaq	56(%rsp), %rax
	movq	%rax, 128(%rsp)
	movq	_RNvXsi_NtNtNtCsc9NCSoc2doQ_4core3fmt3num3impjNtB9_7Display3fmt@GOTPCREL(%rip), %rax
	movq	%rax, 136(%rsp)
	leaq	120(%rsp), %rcx
	movq	%rcx, 144(%rsp)
	movq	%rax, 152(%rsp)
	leaq	96(%rsp), %rcx
	movq	%rcx, 160(%rsp)
	movq	_RNvXNtNtCsc9NCSoc2doQ_4core3fmt3numoNtB4_7Display3fmt@GOTPCREL(%rip), %rcx
	movq	%rcx, 168(%rsp)
	leaq	232(%rsp), %rcx
	movq	%rcx, 176(%rsp)
	movq	%rax, 184(%rsp)
	leaq	24(%rsp), %rcx
	movq	%rcx, 192(%rsp)
	movq	%rax, 200(%rsp)
.Ltmp21:
	leaq	.Lalloc_242483277d2d9f144f9009149d5c5880(%rip), %rdi
	leaq	128(%rsp), %rsi
	callq	*_RNvNtNtCs341anU20NIK_3std2io5stdio6__print@GOTPCREL(%rip)
.Ltmp22:
	movq	80(%rsp), %rbx
	testq	%rbx, %rbx
	je	.LBB8_126
	movq	16(%rsp), %rax
	leaq	8(%rax), %r14
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r15
	jmp	.LBB8_124
	.p2align	4
.LBB8_123:
	addq	$24, %r14
	decq	%rbx
	je	.LBB8_126
.LBB8_124:
	movq	-8(%r14), %rsi
	testq	%rsi, %rsi
	je	.LBB8_123
	movq	(%r14), %rdi
	movl	$1, %edx
	callq	*%r15
	jmp	.LBB8_123
.LBB8_126:
	movq	64(%rsp), %rax
	testq	%rax, %rax
	je	.LBB8_128
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	movq	16(%rsp), %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB8_128:
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.LBB8_129:
	.cfi_def_cfa %rbp, 16
	addb	$-48, %dl
	xorl	%eax, %eax
	cmpb	$10, %dl
	adcb	$1, %al
	jmp	.LBB8_131
.LBB8_130:
	movb	$2, %al
.LBB8_131:
	movb	%al, 256(%rsp)
	leaq	.Lalloc_2aba04fc1d6f3a5c9fce7237ada90207(%rip), %r8
	jmp	.LBB8_141
.LBB8_132:
	addb	$-48, %dl
	xorl	%eax, %eax
	cmpb	$10, %dl
	adcb	$1, %al
	jmp	.LBB8_134
.LBB8_133:
	movb	$2, %al
.LBB8_134:
	movb	%al, 256(%rsp)
	leaq	.Lalloc_0f4f7a1a3c3a0039de13b53ee49f7ed2(%rip), %r8
	jmp	.LBB8_141
.LBB8_135:
	addb	$-48, %dl
	xorl	%eax, %eax
	cmpb	$10, %dl
	adcb	$1, %al
	jmp	.LBB8_137
.LBB8_136:
	movb	$2, %al
.LBB8_137:
	movb	%al, 256(%rsp)
	leaq	.Lalloc_bb7ca809939e31d7cb465de2851968a0(%rip), %r8
	jmp	.LBB8_141
.LBB8_138:
	addb	$-48, %dl
	xorl	%eax, %eax
	cmpb	$10, %dl
	adcb	$1, %al
	jmp	.LBB8_140
.LBB8_139:
	movb	$2, %al
.LBB8_140:
	movb	%al, 256(%rsp)
	leaq	.Lalloc_2dbb0a2bc2b617546882d4168664f6f3(%rip), %r8
.LBB8_141:
.Ltmp9:
	leaq	.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274(%rip), %rdi
	leaq	.Lvtable.3(%rip), %rcx
	movl	$43, %esi
	movq	48(%rsp), %rdx
	callq	*_RNvNtCsc9NCSoc2doQ_4core6result13unwrap_failed@GOTPCREL(%rip)
.Ltmp10:
	jmp	.LBB8_167
.LBB8_142:
	movq	%r13, %rdi
	movq	%r14, %rsi
	jmp	.LBB8_144
.LBB8_143:
	leaq	.Lalloc_1b0a3b640c3f7194bb0ebfe90a831d5d(%rip), %rcx
	xorl	%edi, %edi
	movq	%r13, %rsi
.LBB8_144:
.Ltmp17:
	movl	$2048, %edx
	callq	*_RNvNtNtCsc9NCSoc2doQ_4core5slice5index16slice_index_fail@GOTPCREL(%rip)
.Ltmp18:
	jmp	.LBB8_167
.LBB8_145:
.Ltmp15:
	leaq	24(%rsp), %rdi
	leaq	128(%rsp), %rsi
	callq	_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedRSjBM_ECshsBGi11rG2H_7rawcopy
.Ltmp16:
	jmp	.LBB8_167
.LBB8_147:
	movb	$1, %al
	jmp	.LBB8_131
.LBB8_148:
	movb	$1, %al
	jmp	.LBB8_134
.LBB8_149:
	movb	$1, %al
	jmp	.LBB8_137
.LBB8_152:
	movb	$1, %al
	jmp	.LBB8_140
.LBB8_146:
	movl	$66, %esi
	jmp	.LBB8_151
.LBB8_150:
	movl	$70, %esi
.LBB8_151:
.Ltmp19:
	callq	*_RNvNtCsc9NCSoc2doQ_4core9panicking5panic@GOTPCREL(%rip)
.Ltmp20:
	jmp	.LBB8_167
.LBB8_157:
	movq	16648(%rsp), %r14
	movq	16664(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r14, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	movq	$0, 64(%rsp)
	movq	$8, 72(%rsp)
	movq	$0, 80(%rsp)
	cmpq	%r14, %rcx
	jne	.LBB8_161
.LBB8_158:
	movq	16656(%rsp), %rax
	testq	%rax, %rax
	je	.LBB8_160
	movq	16640(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB8_160:
	leaq	.Lalloc_964559183541d0267187e2c4b277bb4e(%rip), %rdx
	movl	$1, %edi
	xorl	%esi, %esi
	jmp	.LBB8_166
.LBB8_161:
	movq	%rdx, %rbx
	shrq	$4, %rbx
	addq	$8, %r14
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r15
	jmp	.LBB8_163
	.p2align	4
.LBB8_162:
	addq	$24, %r14
	decq	%rbx
	je	.LBB8_158
.LBB8_163:
	movq	-8(%r14), %rsi
	testq	%rsi, %rsi
	je	.LBB8_162
	movq	(%r14), %rdi
	movl	$1, %edx
	callq	*%r15
	jmp	.LBB8_162
.LBB8_165:
	leaq	.Lalloc_964559183541d0267187e2c4b277bb4e(%rip), %rdx
	movl	$1, %edi
.LBB8_166:
.Ltmp26:
	callq	*_RNvNtCsc9NCSoc2doQ_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.Ltmp27:
.LBB8_167:
	ud2
.LBB8_168:
	xorl	%eax, %eax
	jmp	.LBB8_131
.LBB8_169:
	xorl	%eax, %eax
	jmp	.LBB8_134
.LBB8_170:
	xorl	%eax, %eax
	jmp	.LBB8_137
.LBB8_171:
	xorl	%eax, %eax
	jmp	.LBB8_140
.LBB8_172:
.Ltmp2:
	movq	%rax, %rbx
	jmp	.LBB8_180
.LBB8_173:
.Ltmp8:
	movq	%rax, %r14
	testq	%r13, %r13
	je	.LBB8_176
	movl	$1, %edx
	movq	%rbx, %rdi
	movq	%r13, %rsi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	jmp	.LBB8_176
.LBB8_175:
.Ltmp5:
	movq	%rax, %r14
.LBB8_176:
	leaq	256(%rsp), %rdi
	callq	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueNtNtCs341anU20NIK_3std3env4ArgsECshsBGi11rG2H_7rawcopy
	leaq	24(%rsp), %rdi
	callq	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECshsBGi11rG2H_7rawcopy
	movq	%r14, %rbx
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.LBB8_177:
.Ltmp28:
	movq	%rax, %rbx
	leaq	64(%rsp), %rdi
	callq	_RINvNtCsc9NCSoc2doQ_4core3ptr9drop_glueINtNtCs3v2GDSbr0UZ_5alloc3vec3VecNtNtBG_6string6StringEECshsBGi11rG2H_7rawcopy
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.LBB8_178:
.Ltmp25:
	movq	%rax, %rbx
	testq	%r14, %r14
	je	.LBB8_180
	movl	$1, %edx
	movq	16(%rsp), %rdi
	movq	%r14, %rsi
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB8_180:
	movq	16648(%rsp), %r15
	movq	16664(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r15, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	cmpq	%r15, %rcx
	jne	.LBB8_183
.LBB8_181:
	movq	16656(%rsp), %rax
	testq	%rax, %rax
	jne	.LBB8_187
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.LBB8_183:
	movq	%rdx, %r14
	shrq	$4, %r14
	addq	$8, %r15
	movq	_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r12
	jmp	.LBB8_185
	.p2align	4
.LBB8_184:
	addq	$24, %r15
	decq	%r14
	je	.LBB8_181
.LBB8_185:
	movq	-8(%r15), %rsi
	testq	%rsi, %rsi
	je	.LBB8_184
	movq	(%r15), %rdi
	movl	$1, %edx
	callq	*%r12
	jmp	.LBB8_184
.LBB8_187:
	movq	16640(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
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
	.uleb128 .Ltmp22-.Ltmp11
	.uleb128 .Ltmp28-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp22-.Lfunc_begin0
	.uleb128 .Ltmp9-.Ltmp22
	.byte	0
	.byte	0
	.uleb128 .Ltmp9-.Lfunc_begin0
	.uleb128 .Ltmp20-.Ltmp9
	.uleb128 .Ltmp28-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp20-.Lfunc_begin0
	.uleb128 .Ltmp26-.Ltmp20
	.byte	0
	.byte	0
	.uleb128 .Ltmp26-.Lfunc_begin0
	.uleb128 .Ltmp27-.Ltmp26
	.uleb128 .Ltmp28-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp27-.Lfunc_begin0
	.uleb128 .Lfunc_end8-.Ltmp27
	.byte	0
	.byte	0
.Lcst_end0:
	.p2align	2, 0x0

	.section	.text.unlikely._RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshsBGi11rG2H_7rawcopy,"ax",@progbits
	.prefalign	4, .Lfunc_end9, nop
	.type	_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshsBGi11rG2H_7rawcopy,@function
_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshsBGi11rG2H_7rawcopy:
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
	jbe	.LBB9_2
	movl	$8, %eax
	xorl	%r14d, %r14d
	jmp	.LBB9_10
.LBB9_2:
	shlq	$3, %rcx
	leaq	(%rcx,%rcx,2), %r14
	testq	%rsi, %rsi
	je	.LBB9_4
	shlq	$3, %rsi
	leaq	(%rsi,%rsi,2), %rsi
	movq	%rdx, %rdi
	movl	$8, %edx
	movq	%r14, %rcx
	callq	*_RNvCshVjSbrpHdcL_7___rustc14___rust_realloc@GOTPCREL(%rip)
	testq	%rax, %rax
	jne	.LBB9_6
	jmp	.LBB9_9
.LBB9_4:
	testq	%r14, %r14
	je	.LBB9_5
	callq	*_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$8, %esi
	movq	%r14, %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	jne	.LBB9_6
.LBB9_9:
	movq	$8, 8(%rbx)
	movl	$16, %eax
	jmp	.LBB9_10
.LBB9_5:
	movl	$8, %eax
.LBB9_6:
	movq	%rax, 8(%rbx)
	movl	$16, %eax
	xorl	%r15d, %r15d
.LBB9_10:
	movq	%r14, (%rbx,%rax)
	movq	%r15, (%rbx)
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end9:
	.size	_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshsBGi11rG2H_7rawcopy, .Lfunc_end9-_RNvMs5_NtCs3v2GDSbr0UZ_5alloc7raw_vecNtB5_11RawVecInner11finish_growCshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy,"ax",@progbits
	.prefalign	4, .Lfunc_end10, nop
	.type	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy,@function
_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy:
	.cfi_startproc
	movq	%rsi, %rax
	movq	(%rdi), %rcx
	movzbl	(%rcx), %ecx
	leaq	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy(%rip), %rdx
	movzbl	(%rcx,%rdx), %edx
	leaq	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel(%rip), %rdi
	movslq	(%rdi,%rcx,4), %rsi
	addq	%rdi, %rsi
	movq	%rax, %rdi
	jmpq	*_RNvMsa_NtCsc9NCSoc2doQ_4core3fmtNtB5_9Formatter9write_str@GOTPCREL(%rip)
.Lfunc_end10:
	.size	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy, .Lfunc_end10-_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRRSjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy,"ax",@progbits
	.prefalign	4, .Lfunc_end11, nop
	.type	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRRSjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy,@function
_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRRSjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy:
	.cfi_startproc
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
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	(%rdi), %rax
	movq	(%rax), %r12
	movq	8(%rax), %r13
	leaq	8(%rsp), %rdi
	callq	*_RNvMsa_NtCsc9NCSoc2doQ_4core3fmtNtB5_9Formatter10debug_list@GOTPCREL(%rip)
	testq	%r13, %r13
	je	.LBB11_3
	shlq	$3, %r13
	leaq	.Lvtable.0(%rip), %rbx
	leaq	8(%rsp), %r14
	movq	%rsp, %r15
	movq	_RNvMs6_NtNtCsc9NCSoc2doQ_4core3fmt8buildersNtB5_9DebugList5entry@GOTPCREL(%rip), %rbp
	.p2align	4
.LBB11_2:
	movq	%r12, (%rsp)
	addq	$8, %r12
	movq	%r14, %rdi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	*%rbp
	addq	$-8, %r13
	jne	.LBB11_2
.LBB11_3:
	leaq	8(%rsp), %rdi
	callq	*_RNvMs6_NtNtCsc9NCSoc2doQ_4core3fmt8buildersNtB5_9DebugList6finish@GOTPCREL(%rip)
	addq	$24, %rsp
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
.Lfunc_end11:
	.size	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRRSjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy, .Lfunc_end11-_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRRSjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy,"ax",@progbits
	.prefalign	4, .Lfunc_end12, nop
	.type	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy,@function
_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy:
	.cfi_startproc
	movq	(%rdi), %rdi
	movl	16(%rsi), %eax
	testl	$33554432, %eax
	jne	.LBB12_3
	testl	$67108864, %eax
	jne	.LBB12_2
	jmpq	*_RNvXsi_NtNtNtCsc9NCSoc2doQ_4core3fmt3num3impjNtB9_7Display3fmt@GOTPCREL(%rip)
.LBB12_3:
	jmpq	*_RNvXs6_NtNtCsc9NCSoc2doQ_4core3fmt3numjNtB7_8LowerHex3fmt@GOTPCREL(%rip)
.LBB12_2:
	jmpq	*_RNvXs8_NtNtCsc9NCSoc2doQ_4core3fmt3numjNtB7_8UpperHex3fmt@GOTPCREL(%rip)
.Lfunc_end12:
	.size	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy, .Lfunc_end12-_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy
	.cfi_endproc

	.section	.text._RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt,"ax",@progbits
	.prefalign	4, .Lfunc_end13, nop
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
.Lfunc_end13:
	.size	_RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt, .Lfunc_end13-_RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
	.cfi_endproc

	.section	.text.raw_copy,"ax",@progbits
	.globl	raw_copy
	.prefalign	4, .Lfunc_end14, nop
	.type	raw_copy,@function
raw_copy:
	.cfi_startproc
	testq	%rdx, %rdx
	je	.LBB14_11
	cmpq	$8, %rdx
	setb	%al
	movq	%rsi, %rcx
	subq	%rdi, %rcx
	cmpq	$-31, %rcx
	setae	%cl
	orb	%al, %cl
	je	.LBB14_3
	xorl	%eax, %eax
	jmp	.LBB14_6
.LBB14_3:
	movq	%rdx, %rax
	andq	$-4, %rax
	xorl	%ecx, %ecx
	.p2align	4
.LBB14_4:
	movups	(%rsi,%rcx,8), %xmm0
	movups	16(%rsi,%rcx,8), %xmm1
	movups	%xmm0, (%rdi,%rcx,8)
	movups	%xmm1, 16(%rdi,%rcx,8)
	addq	$4, %rcx
	cmpq	%rcx, %rax
	jne	.LBB14_4
	cmpq	%rax, %rdx
	je	.LBB14_11
.LBB14_6:
	movq	%rdx, %r8
	movq	%rax, %rcx
	andq	$3, %r8
	je	.LBB14_9
	movq	%rax, %rcx
	.p2align	4
.LBB14_8:
	movq	(%rsi,%rcx,8), %r9
	movq	%r9, (%rdi,%rcx,8)
	incq	%rcx
	decq	%r8
	jne	.LBB14_8
.LBB14_9:
	subq	%rdx, %rax
	cmpq	$-4, %rax
	ja	.LBB14_11
	.p2align	4
.LBB14_10:
	movq	(%rsi,%rcx,8), %rax
	movq	%rax, (%rdi,%rcx,8)
	movq	8(%rsi,%rcx,8), %rax
	movq	%rax, 8(%rdi,%rcx,8)
	movq	16(%rsi,%rcx,8), %rax
	movq	%rax, 16(%rdi,%rcx,8)
	movq	24(%rsi,%rcx,8), %rax
	movq	%rax, 24(%rdi,%rcx,8)
	addq	$4, %rcx
	cmpq	%rcx, %rdx
	jne	.LBB14_10
.LBB14_11:
	retq
.Lfunc_end14:
	.size	raw_copy, .Lfunc_end14-raw_copy
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
	leaq	_RNvCshsBGi11rG2H_7rawcopy4main(%rip), %rax
	movq	%rax, (%rsp)
	leaq	.Lvtable.1(%rip), %rsi
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
	.quad	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy
	.size	.Lvtable.0, 32

	.type	.Lvtable.1,@object
	.section	.data.rel.ro..Lvtable.1,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.1:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNSNvYNCINvNtCs341anU20NIK_3std2rt10lang_startuE0INtNtNtCsc9NCSoc2doQ_4core3ops8function6FnOnceuE9call_once6vtableCshsBGi11rG2H_7rawcopy
	.quad	_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0CshsBGi11rG2H_7rawcopy
	.quad	_RNCINvNtCs341anU20NIK_3std2rt10lang_startuE0CshsBGi11rG2H_7rawcopy
	.size	.Lvtable.1, 48

	.type	.Lvtable.2,@object
	.section	.data.rel.ro..Lvtable.2,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.2:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRRSjNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy
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
	.quad	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000@\000\000"
	.size	.Lalloc_964559183541d0267187e2c4b277bb4e, 24

	.type	.Lalloc_2aba04fc1d6f3a5c9fce7237ada90207,@object
	.section	.data.rel.ro..Lalloc_2aba04fc1d6f3a5c9fce7237ada90207,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_2aba04fc1d6f3a5c9fce7237ada90207:
	.quad	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000L\000\000"
	.size	.Lalloc_2aba04fc1d6f3a5c9fce7237ada90207, 24

	.type	.Lalloc_9189b17a0d38f81e0b768fdd496ad016,@object
	.section	.data.rel.ro..Lalloc_9189b17a0d38f81e0b768fdd496ad016,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_9189b17a0d38f81e0b768fdd496ad016:
	.quad	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000c\000\000"
	.size	.Lalloc_9189b17a0d38f81e0b768fdd496ad016, 24

	.type	.Lalloc_0f4f7a1a3c3a0039de13b53ee49f7ed2,@object
	.section	.data.rel.ro..Lalloc_0f4f7a1a3c3a0039de13b53ee49f7ed2,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_0f4f7a1a3c3a0039de13b53ee49f7ed2:
	.quad	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000o\000\000"
	.size	.Lalloc_0f4f7a1a3c3a0039de13b53ee49f7ed2, 24

	.type	.Lalloc_5402922c1b616663f39de9605452433b,@object
	.section	.data.rel.ro..Lalloc_5402922c1b616663f39de9605452433b,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_5402922c1b616663f39de9605452433b:
	.quad	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000\210\000\000"
	.size	.Lalloc_5402922c1b616663f39de9605452433b, 24

	.type	.Lalloc_bb7ca809939e31d7cb465de2851968a0,@object
	.section	.data.rel.ro..Lalloc_bb7ca809939e31d7cb465de2851968a0,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_bb7ca809939e31d7cb465de2851968a0:
	.quad	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000\224\000\000"
	.size	.Lalloc_bb7ca809939e31d7cb465de2851968a0, 24

	.type	.Lalloc_2be509ebd9cc61f70f092dfe957ed169,@object
	.section	.data.rel.ro..Lalloc_2be509ebd9cc61f70f092dfe957ed169,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_2be509ebd9cc61f70f092dfe957ed169:
	.quad	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000\255\000\000"
	.size	.Lalloc_2be509ebd9cc61f70f092dfe957ed169, 24

	.type	.Lalloc_2dbb0a2bc2b617546882d4168664f6f3,@object
	.section	.data.rel.ro..Lalloc_2dbb0a2bc2b617546882d4168664f6f3,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_2dbb0a2bc2b617546882d4168664f6f3:
	.quad	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000\271\000\000"
	.size	.Lalloc_2dbb0a2bc2b617546882d4168664f6f3, 24

	.type	.Lalloc_67e13228cc1d9cff242e5e6206de75d9,@object
	.section	.data.rel.ro..Lalloc_67e13228cc1d9cff242e5e6206de75d9,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_67e13228cc1d9cff242e5e6206de75d9:
	.quad	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
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
	.quad	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
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
	.quad	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
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
	.quad	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000\250\002\000"
	.size	.Lalloc_1b0a3b640c3f7194bb0ebfe90a831d5d, 24

	.type	.Lalloc_b648483c9ddff22c79d46fb5d378ae68,@object
	.section	.data.rel.ro..Lalloc_b648483c9ddff22c79d46fb5d378ae68,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_b648483c9ddff22c79d46fb5d378ae68:
	.quad	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000\215\002\000"
	.size	.Lalloc_b648483c9ddff22c79d46fb5d378ae68, 24

	.type	.Lalloc_33aa5ed87fc549baeed98c7b00832370,@object
	.section	.data.rel.ro..Lalloc_33aa5ed87fc549baeed98c7b00832370,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_33aa5ed87fc549baeed98c7b00832370:
	.quad	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
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
	.quad	.Lalloc_a63772ed514a93359afe3b0a31acdc8c
	.asciz	"&\000\000\000\000\000\000\000\004\000\000\000\302\000\000"
	.size	.Lalloc_128dcacd48065ecac459e8f68ca2fcca, 24

	.type	.Lvtable.3,@object
	.section	.data.rel.ro..Lvtable.3,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.3:
	.asciz	"\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\001\000\000\000\000\000\000"
	.quad	_RNvXsd_NtNtCsc9NCSoc2doQ_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
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
	.quad	_RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy
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

	.type	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy,"a",@progbits
	.p2align	3, 0x0
.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy:
	.ascii	"\005\f\013\013\004\016"
	.size	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy, 6

	.type	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel,"a",@progbits
	.p2align	2, 0x0
.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel:
	.long	.Lalloc_59ba7b9f7211443cd55a366616eef46a-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel
	.long	.Lalloc_00315c78e51d29fe6b3102a4c1ecf6ef-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel
	.long	.Lalloc_bd3a3f3879e0d5f64554753e977f58d4-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel
	.long	.Lalloc_0964bb2a4870637395c77a018495bd5c-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel
	.long	.Lalloc_6566120a3a17f930e960a0863fcbd591-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel
	.long	.Lalloc_6c17bac0c71cba42380f8445f4dcbd16-.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel
	.size	.Lswitch.table._RNvXs1g_NtCsc9NCSoc2doQ_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCshsBGi11rG2H_7rawcopy.30.rel, 24

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
