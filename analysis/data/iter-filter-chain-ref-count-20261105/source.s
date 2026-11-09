	.att_syntax
	.file	"source_probe.3cb19ccc78a57572-cgu.0"
	.section	.text._RINvNtCs6knCYbIatyh_4core3ptr9drop_glueINtNtCs4XhBu2GMSOm_5alloc3vec3VecNtNtBG_6string6StringEECs5d4rudRldWE_12source_probe,"ax",@progbits
	.prefalign	4, .Lfunc_end0, nop
	.type	_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueINtNtCs4XhBu2GMSOm_5alloc3vec3VecNtNtBG_6string6StringEECs5d4rudRldWE_12source_probe,@function
_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueINtNtCs4XhBu2GMSOm_5alloc3vec3VecNtNtBG_6string6StringEECs5d4rudRldWE_12source_probe:
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
	je	.LBB0_5
	leaq	8(%rbx), %r12
	movq	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r13
	jmp	.LBB0_2
	.p2align	4
.LBB0_4:
	addq	$24, %r12
	decq	%r15
	je	.LBB0_5
.LBB0_2:
	movq	-8(%r12), %rsi
	testq	%rsi, %rsi
	je	.LBB0_4
	movq	(%r12), %rdi
	movl	$1, %edx
	callq	*%r13
	jmp	.LBB0_4
.LBB0_5:
	movq	(%r14), %rax
	testq	%rax, %rax
	je	.LBB0_6
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
	jmpq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB0_6:
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
.Lfunc_end0:
	.size	_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueINtNtCs4XhBu2GMSOm_5alloc3vec3VecNtNtBG_6string6StringEECs5d4rudRldWE_12source_probe, .Lfunc_end0-_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueINtNtCs4XhBu2GMSOm_5alloc3vec3VecNtNtBG_6string6StringEECs5d4rudRldWE_12source_probe
	.cfi_endproc

	.section	.text._RINvNtCs6knCYbIatyh_4core3ptr9drop_glueNtNtCs9wefJfwQbYy_3std3env4ArgsECs5d4rudRldWE_12source_probe,"ax",@progbits
	.prefalign	4, .Lfunc_end1, nop
	.type	_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueNtNtCs9wefJfwQbYy_3std3env4ArgsECs5d4rudRldWE_12source_probe,@function
_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueNtNtCs9wefJfwQbYy_3std3env4ArgsECs5d4rudRldWE_12source_probe:
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
	je	.LBB1_5
	movq	%rdx, %r14
	shrq	$4, %r14
	addq	$8, %r15
	movq	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r12
	jmp	.LBB1_2
	.p2align	4
.LBB1_4:
	addq	$24, %r15
	decq	%r14
	je	.LBB1_5
.LBB1_2:
	movq	-8(%r15), %rsi
	testq	%rsi, %rsi
	je	.LBB1_4
	movq	(%r15), %rdi
	movl	$1, %edx
	callq	*%r12
	jmp	.LBB1_4
.LBB1_5:
	movq	16(%rbx), %rax
	testq	%rax, %rax
	je	.LBB1_6
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
	jmpq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB1_6:
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
.Lfunc_end1:
	.size	_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueNtNtCs9wefJfwQbYy_3std3env4ArgsECs5d4rudRldWE_12source_probe, .Lfunc_end1-_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueNtNtCs9wefJfwQbYy_3std3env4ArgsECs5d4rudRldWE_12source_probe
	.cfi_endproc

	.section	.text.unlikely._RINvNtCs6knCYbIatyh_4core6result13unwrap_failedNtNtNtB4_3num5error13ParseIntErrorECs5d4rudRldWE_12source_probe,"ax",@progbits
	.prefalign	4, .Lfunc_end2, nop
	.type	_RINvNtCs6knCYbIatyh_4core6result13unwrap_failedNtNtNtB4_3num5error13ParseIntErrorECs5d4rudRldWE_12source_probe,@function
_RINvNtCs6knCYbIatyh_4core6result13unwrap_failedNtNtNtB4_3num5error13ParseIntErrorECs5d4rudRldWE_12source_probe:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movb	%dil, 7(%rsp)
	leaq	.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274(%rip), %rdi
	leaq	.Lvtable.0(%rip), %rcx
	leaq	.Lalloc_9c36da405e10a0a8abb38df9ba7ee95b(%rip), %r8
	leaq	7(%rsp), %rdx
	movl	$43, %esi
	callq	*_RNvNvNtCs6knCYbIatyh_4core6result13unwrap_failed19unwrap_failed_inner@GOTPCREL(%rip)
.Lfunc_end2:
	.size	_RINvNtCs6knCYbIatyh_4core6result13unwrap_failedNtNtNtB4_3num5error13ParseIntErrorECs5d4rudRldWE_12source_probe, .Lfunc_end2-_RINvNtCs6knCYbIatyh_4core6result13unwrap_failedNtNtNtB4_3num5error13ParseIntErrorECs5d4rudRldWE_12source_probe
	.cfi_endproc

	.section	.text._RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECs5d4rudRldWE_12source_probe,"ax",@progbits
	.hidden	_RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECs5d4rudRldWE_12source_probe
	.globl	_RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECs5d4rudRldWE_12source_probe
	.prefalign	4, .Lfunc_end3, nop
	.type	_RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECs5d4rudRldWE_12source_probe,@function
_RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECs5d4rudRldWE_12source_probe:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	%ecx, %r8d
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rdi, (%rsp)
	leaq	.Lvtable.1(%rip), %rsi
	movq	%rsp, %rdi
	callq	*_RNvNtCs9wefJfwQbYy_3std2rt19lang_start_internal@GOTPCREL(%rip)
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end3:
	.size	_RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECs5d4rudRldWE_12source_probe, .Lfunc_end3-_RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECs5d4rudRldWE_12source_probe
	.cfi_endproc

	.section	.text._RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs5d4rudRldWE_12source_probe,"ax",@progbits
	.prefalign	4, .Lfunc_end4, nop
	.type	_RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs5d4rudRldWE_12source_probe,@function
_RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs5d4rudRldWE_12source_probe:
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
	.size	_RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs5d4rudRldWE_12source_probe, .Lfunc_end4-_RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs5d4rudRldWE_12source_probe
	.cfi_endproc

	.section	.text.unlikely._RINvNvMs5_NtCs4XhBu2GMSOm_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs5d4rudRldWE_12source_probe,"ax",@progbits
	.prefalign	4, .Lfunc_end5, nop
	.type	_RINvNvMs5_NtCs4XhBu2GMSOm_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs5d4rudRldWE_12source_probe,@function
_RINvNvMs5_NtCs4XhBu2GMSOm_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs5d4rudRldWE_12source_probe:
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
	cmpq	%rsi, %rcx
	cmovaq	%rcx, %rsi
	cmpq	$5, %rsi
	movl	$4, %r14d
	cmovaeq	%rsi, %r14
	movq	8(%rdi), %rdx
	movq	%rsp, %rdi
	movq	%rax, %rsi
	movq	%r14, %rcx
	callq	_RNvMs8_NtCs4XhBu2GMSOm_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs5d4rudRldWE_12source_probe
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
	callq	*_RNvNtCs4XhBu2GMSOm_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.LBB5_3:
	movq	8(%rsp), %rdi
	movq	16(%rsp), %rsi
	callq	*_RNvNtCs4XhBu2GMSOm_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Lfunc_end5:
	.size	_RINvNvMs5_NtCs4XhBu2GMSOm_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs5d4rudRldWE_12source_probe, .Lfunc_end5-_RINvNvMs5_NtCs4XhBu2GMSOm_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs5d4rudRldWE_12source_probe
	.cfi_endproc

	.section	.text._RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0Cs5d4rudRldWE_12source_probe,"ax",@progbits
	.prefalign	4, .Lfunc_end6, nop
	.type	_RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0Cs5d4rudRldWE_12source_probe,@function
_RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0Cs5d4rudRldWE_12source_probe:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	(%rdi), %rdi
	callq	_RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs5d4rudRldWE_12source_probe
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end6:
	.size	_RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0Cs5d4rudRldWE_12source_probe, .Lfunc_end6-_RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0Cs5d4rudRldWE_12source_probe
	.cfi_endproc

	.section	.text._RNSNvYNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceuE9call_once6vtableCs5d4rudRldWE_12source_probe,"ax",@progbits
	.prefalign	4, .Lfunc_end7, nop
	.type	_RNSNvYNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceuE9call_once6vtableCs5d4rudRldWE_12source_probe,@function
_RNSNvYNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceuE9call_once6vtableCs5d4rudRldWE_12source_probe:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	(%rdi), %rdi
	callq	_RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECs5d4rudRldWE_12source_probe
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end7:
	.size	_RNSNvYNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceuE9call_once6vtableCs5d4rudRldWE_12source_probe, .Lfunc_end7-_RNSNvYNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceuE9call_once6vtableCs5d4rudRldWE_12source_probe
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI8_0:
	.byte	95
	.byte	117
	.byte	110
	.byte	114
	.byte	111
	.byte	108
	.byte	108
	.byte	52
	.byte	95
	.byte	111
	.byte	110
	.byte	101
	.byte	95
	.byte	97
	.byte	99
	.byte	99
.LCPI8_1:
	.byte	115
	.byte	111
	.byte	117
	.byte	114
	.byte	99
	.byte	101
	.byte	95
	.byte	117
	.byte	110
	.byte	114
	.byte	111
	.byte	108
	.byte	108
	.byte	52
	.byte	95
	.byte	111
	.section	.text._RNvCs5d4rudRldWE_12source_probe4main,"ax",@progbits
	.hidden	_RNvCs5d4rudRldWE_12source_probe4main
	.globl	_RNvCs5d4rudRldWE_12source_probe4main
	.prefalign	4, .Lfunc_end8, nop
	.type	_RNvCs5d4rudRldWE_12source_probe4main,@function
_RNvCs5d4rudRldWE_12source_probe4main:
.Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, DW.ref._RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality
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
	subq	$120, %rsp
	.cfi_def_cfa_offset 176
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	leaq	56(%rsp), %rbx
	movq	%rbx, %rdi
	callq	*_RNvNtCs9wefJfwQbYy_3std3env4args@GOTPCREL(%rip)
.Ltmp0:
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	callq	*_RNvXse_NtCs9wefJfwQbYy_3std3envNtB5_4ArgsNtNtNtNtCs6knCYbIatyh_4core4iter6traits8iterator8Iterator4next@GOTPCREL(%rip)
.Ltmp1:
	movq	(%rsp), %r14
	cmpq	$-1, %r14
	je	.LBB8_80
	movq	8(%rsp), %r15
	movq	80(%rsp), %rax
	subq	64(%rsp), %rax
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
	jbe	.LBB8_5
	xorl	%r13d, %r13d
.LBB8_4:
.Ltmp20:
	movq	%r13, %rdi
	movq	%r12, %rsi
	callq	*_RNvNtCs4XhBu2GMSOm_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Ltmp21:
	jmp	.LBB8_91
.LBB8_5:
	movq	16(%rsp), %rax
	testq	%r12, %r12
	je	.LBB8_8
	movq	%rax, 112(%rsp)
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$8, %r13d
	movl	$8, %esi
	movq	%r12, %rdi
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc12___rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB8_4
	movq	%rax, %rbx
	incq	%rbp
	movq	112(%rsp), %rax
	jmp	.LBB8_9
.LBB8_8:
	movl	$8, %ebx
	xorl	%ebp, %ebp
.LBB8_9:
	movq	%r14, (%rbx)
	movq	%r15, 8(%rbx)
	movq	%rax, 16(%rbx)
	movq	%rbp, 88(%rsp)
	movq	%rbx, 96(%rsp)
	movq	$1, 104(%rsp)
	movups	56(%rsp), %xmm0
	movdqu	72(%rsp), %xmm1
	movdqa	%xmm1, 16(%rsp)
	movaps	%xmm0, (%rsp)
	movl	$1, %r14d
	movl	$40, %r15d
	jmp	.LBB8_12
	.p2align	4
.LBB8_10:
	movq	96(%rsp), %rbx
.LBB8_11:
	movq	%rbp, -16(%rbx,%r15)
	movq	%r13, -8(%rbx,%r15)
	movq	%r12, (%rbx,%r15)
	incq	%r14
	movq	%r14, 104(%rsp)
	addq	$24, %r15
.LBB8_12:
.Ltmp3:
	leaq	32(%rsp), %rdi
	movq	%rsp, %rsi
	callq	*_RNvXse_NtCs9wefJfwQbYy_3std3envNtB5_4ArgsNtNtNtNtCs6knCYbIatyh_4core4iter6traits8iterator8Iterator4next@GOTPCREL(%rip)
.Ltmp4:
	movq	32(%rsp), %rbp
	cmpq	$-1, %rbp
	je	.LBB8_16
	movq	40(%rsp), %r13
	movq	48(%rsp), %r12
	cmpq	88(%rsp), %r14
	jne	.LBB8_11
	movq	24(%rsp), %rdx
	subq	8(%rsp), %rdx
	shrq	$3, %rdx
	movabsq	$-6148914691236517205, %rax
	imulq	%rax, %rdx
	incq	%rdx
.Ltmp6:
	leaq	88(%rsp), %rdi
	movq	%r14, %rsi
	callq	_RINvNvMs5_NtCs4XhBu2GMSOm_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECs5d4rudRldWE_12source_probe
.Ltmp7:
	jmp	.LBB8_10
.LBB8_16:
	movq	8(%rsp), %r14
	movq	24(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r14, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	cmpq	%r14, %rcx
	je	.LBB8_21
	movq	%rdx, %rbx
	shrq	$4, %rbx
	addq	$8, %r14
	movq	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r15
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
	movq	16(%rsp), %rax
	testq	%rax, %rax
	je	.LBB8_23
	movq	(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB8_23:
	movdqu	88(%rsp), %xmm0
	movdqa	%xmm0, 32(%rsp)
	movq	104(%rsp), %rbx
	movq	%rbx, 48(%rsp)
	cmpq	$2, %rbx
	jb	.LBB8_88
	movq	40(%rsp), %r14
	movq	40(%r14), %rcx
	addq	$-5, %rcx
	cmpq	$17, %rcx
	ja	.LBB8_77
	movq	32(%r14), %rax
	leaq	.LJTI8_0(%rip), %rdx
	movslq	(%rdx,%rcx,4), %rcx
	addq	%rdx, %rcx
	jmpq	*%rcx
.LBB8_26:
	movl	$1701738351, %ecx
	xorl	(%rax), %ecx
	movzbl	4(%rax), %edx
	xorl	$100, %edx
	orl	%ecx, %edx
	je	.LBB8_41
	movl	$1768714355, %ecx
	xorl	(%rax), %ecx
	movzbl	4(%rax), %eax
	xorl	$116, %eax
	orl	%ecx, %eax
	jne	.LBB8_77
	leaq	split(%rip), %r12
	jmp	.LBB8_42
.LBB8_29:
	movabsq	$7809644627822735983, %rcx
	cmpq	%rcx, (%rax)
	je	.LBB8_40
	movabsq	$7234309766870429301, %rcx
	cmpq	%rcx, (%rax)
	jne	.LBB8_77
	leaq	unsigned(%rip), %r12
	jmp	.LBB8_42
.LBB8_32:
	movl	$1970168173, %ecx
	xorl	(%rax), %ecx
	movzwl	4(%rax), %eax
	xorl	$27745, %eax
	orl	%ecx, %eax
	jne	.LBB8_77
	leaq	manual(%rip), %r12
	jmp	.LBB8_42
.LBB8_34:
	movabsq	$8457590103021547379, %rcx
	xorq	(%rax), %rcx
	movabsq	$3777513413374014815, %rdx
	xorq	6(%rax), %rdx
	orq	%rcx, %rdx
	jne	.LBB8_77
	leaq	source_unroll4(%rip), %r12
	jmp	.LBB8_42
.LBB8_36:
	movdqu	(%rax), %xmm0
	movdqu	6(%rax), %xmm1
	pcmpeqb	.LCPI8_0(%rip), %xmm1
	pcmpeqb	.LCPI8_1(%rip), %xmm0
	pand	%xmm1, %xmm0
	pmovmskb	%xmm0, %eax
	cmpl	$65535, %eax
	jne	.LBB8_77
	leaq	source_unroll4_one_acc(%rip), %r12
	jmp	.LBB8_42
.LBB8_38:
	movabsq	$7815263158110482286, %rcx
	xorq	(%rax), %rcx
	movzwl	8(%rax), %eax
	xorq	$29557, %rax
	orq	%rcx, %rax
	jne	.LBB8_77
	leaq	no_modulus(%rip), %r12
	jmp	.LBB8_42
.LBB8_40:
	leaq	original(%rip), %r12
	jmp	.LBB8_42
.LBB8_41:
	leaq	owned(%rip), %r12
.LBB8_42:
.Ltmp9:
	callq	*%r12
.Ltmp10:
	movq	%rax, 56(%rsp)
	movl	$666668, %ecx
	cmpq	$10, 40(%r14)
	jne	.LBB8_45
	movq	32(%r14), %rcx
	movabsq	$7815263158110482286, %rdx
	xorq	(%rcx), %rdx
	movzwl	8(%rcx), %ecx
	xorq	$29557, %rcx
	orq	%rdx, %rcx
	movl	$1000000, %edx
	movl	$666668, %ecx
	cmoveq	%rdx, %rcx
.LBB8_45:
	movq	%rcx, (%rsp)
	cmpq	%rcx, %rax
	jne	.LBB8_76
	cmpq	$2, %rbx
	je	.LBB8_89
	movq	56(%r14), %rcx
	movq	64(%r14), %rsi
	cmpq	$1, %rsi
	je	.LBB8_50
	testq	%rsi, %rsi
	je	.LBB8_92
	movzbl	(%rcx), %edx
	jmp	.LBB8_52
.LBB8_50:
	movzbl	(%rcx), %edx
	movb	$1, %al
	cmpl	$43, %edx
	je	.LBB8_75
	cmpl	$45, %edx
	je	.LBB8_75
.LBB8_52:
	xorl	%eax, %eax
	cmpb	$43, %dl
	sete	%al
	movq	%rsi, %rdx
	subq	%rax, %rdx
	addq	%rax, %rcx
	negq	%rax
	cmpq	$17, %rdx
	jae	.LBB8_57
	testq	%rdx, %rdx
	je	.LBB8_66
	addq	%rax, %rsi
	negq	%rsi
	xorl	%r15d, %r15d
	xorl	%eax, %eax
	.p2align	4
.LBB8_55:
	movzbl	(%rcx,%rax), %edx
	addl	$-48, %edx
	cmpl	$9, %edx
	ja	.LBB8_79
	leaq	(%r15,%r15,4), %rdi
	movl	%edx, %edx
	leaq	(%rdx,%rdi,2), %r15
	incq	%rax
	movq	%rsi, %rdx
	addq	%rax, %rdx
	jne	.LBB8_55
	jmp	.LBB8_62
.LBB8_57:
	addq	%rax, %rsi
	negq	%rsi
	xorl	%r15d, %r15d
	movl	$10, %edi
	xorl	%r8d, %r8d
	.p2align	4
.LBB8_58:
	movq	%r15, %rax
	mulq	%rdi
	movzbl	(%rcx,%r8), %edx
	jo	.LBB8_73
	addl	$-48, %edx
	cmpl	$10, %edx
	jae	.LBB8_79
	movq	%rax, %r15
	movl	%edx, %eax
	addq	%rax, %r15
	jb	.LBB8_74
	incq	%r8
	movq	%rsi, %rax
	addq	%r8, %rax
	jne	.LBB8_58
.LBB8_62:
	testq	%r15, %r15
	je	.LBB8_66
	movq	%rsp, %r13
	.p2align	4
.LBB8_64:
.Ltmp15:
	callq	*%r12
.Ltmp16:
	movq	%rax, (%rsp)
	#APP
	#NO_APP
	decq	%r15
	jne	.LBB8_64
.LBB8_66:
	leaq	8(%r14), %r15
	movq	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r12
	jmp	.LBB8_68
	.p2align	4
.LBB8_67:
	addq	$24, %r15
	decq	%rbx
	je	.LBB8_70
.LBB8_68:
	movq	-8(%r15), %rsi
	testq	%rsi, %rsi
	je	.LBB8_67
	movq	(%r15), %rdi
	movl	$1, %edx
	callq	*%r12
	jmp	.LBB8_67
.LBB8_70:
	movq	32(%rsp), %rax
	testq	%rax, %rax
	je	.LBB8_72
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	movq	%r14, %rdi
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB8_72:
	addq	$120, %rsp
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
.LBB8_73:
	.cfi_def_cfa_offset 176
	addb	$-48, %dl
	xorl	%eax, %eax
	cmpb	$10, %dl
	adcb	$1, %al
	jmp	.LBB8_75
.LBB8_74:
	movb	$2, %al
.LBB8_75:
.Ltmp13:
	movzbl	%al, %edi
	callq	_RINvNtCs6knCYbIatyh_4core6result13unwrap_failedNtNtNtB4_3num5error13ParseIntErrorECs5d4rudRldWE_12source_probe
.Ltmp14:
	jmp	.LBB8_91
.LBB8_76:
.Ltmp11:
	leaq	.Lalloc_080ada99a9040ff5939f0c539f14eb34(%rip), %r9
	leaq	56(%rsp), %rsi
	movq	%rsp, %rdx
	xorl	%edi, %edi
	xorl	%ecx, %ecx
	callq	*_RINvNtCs6knCYbIatyh_4core9panicking13assert_failedjjEB4_@GOTPCREL(%rip)
.Ltmp12:
	jmp	.LBB8_91
.LBB8_77:
.Ltmp18:
	leaq	.Lalloc_476509aa7047bd805d630c6546685797(%rip), %rdi
	leaq	.Lalloc_37afb19b6074d42e0a073e2c4bb21567(%rip), %rdx
	movl	$14, %esi
	callq	*_RNvNtCs6knCYbIatyh_4core9panicking5panic@GOTPCREL(%rip)
.Ltmp19:
	jmp	.LBB8_91
.LBB8_79:
	movb	$1, %al
	jmp	.LBB8_75
.LBB8_80:
	movq	64(%rsp), %r14
	movq	80(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r14, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	movq	$0, 32(%rsp)
	movq	$8, 40(%rsp)
	movq	$0, 48(%rsp)
	cmpq	%r14, %rcx
	jne	.LBB8_84
.LBB8_81:
	movq	72(%rsp), %rax
	testq	%rax, %rax
	je	.LBB8_83
	movq	56(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB8_83:
	leaq	.Lalloc_1d94add87e3dcf7e1111ac5ccc13c9f1(%rip), %rdx
	movl	$1, %edi
	xorl	%ebx, %ebx
	jmp	.LBB8_90
.LBB8_84:
	movq	%rdx, %rbx
	shrq	$4, %rbx
	addq	$8, %r14
	movq	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r15
	jmp	.LBB8_86
	.p2align	4
.LBB8_85:
	addq	$24, %r14
	decq	%rbx
	je	.LBB8_81
.LBB8_86:
	movq	-8(%r14), %rsi
	testq	%rsi, %rsi
	je	.LBB8_85
	movq	(%r14), %rdi
	movl	$1, %edx
	callq	*%r15
	jmp	.LBB8_85
.LBB8_88:
	leaq	.Lalloc_1d94add87e3dcf7e1111ac5ccc13c9f1(%rip), %rdx
	movl	$1, %edi
	jmp	.LBB8_90
.LBB8_89:
	leaq	.Lalloc_42cc296b28798c6afd9e87c5ffa2f5ae(%rip), %rdx
	movl	$2, %edi
	movl	$2, %ebx
.LBB8_90:
.Ltmp23:
	movq	%rbx, %rsi
	callq	*_RNvNtCs6knCYbIatyh_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.Ltmp24:
.LBB8_91:
	ud2
.LBB8_92:
	xorl	%eax, %eax
	jmp	.LBB8_75
.LBB8_93:
.Ltmp2:
	movq	%rax, %rbx
	jmp	.LBB8_104
.LBB8_94:
.Ltmp8:
	movq	%rax, %rbx
	testq	%rbp, %rbp
	je	.LBB8_98
	movl	$1, %edx
	movq	%r13, %rdi
	movq	%rbp, %rsi
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	jmp	.LBB8_98
.LBB8_96:
.Ltmp17:
	jmp	.LBB8_100
.LBB8_97:
.Ltmp5:
	movq	%rax, %rbx
.LBB8_98:
	movq	%rsp, %rdi
	callq	_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueNtNtCs9wefJfwQbYy_3std3env4ArgsECs5d4rudRldWE_12source_probe
	leaq	88(%rsp), %rdi
	callq	_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueINtNtCs4XhBu2GMSOm_5alloc3vec3VecNtNtBG_6string6StringEECs5d4rudRldWE_12source_probe
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.LBB8_99:
.Ltmp25:
.LBB8_100:
	movq	%rax, %rbx
	leaq	32(%rsp), %rdi
	callq	_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueINtNtCs4XhBu2GMSOm_5alloc3vec3VecNtNtBG_6string6StringEECs5d4rudRldWE_12source_probe
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.LBB8_102:
.Ltmp22:
	movq	%rax, %rbx
	testq	%r14, %r14
	je	.LBB8_104
	movl	$1, %edx
	movq	%r15, %rdi
	movq	%r14, %rsi
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB8_104:
	movq	64(%rsp), %r15
	movq	80(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r15, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	cmpq	%r15, %rcx
	jne	.LBB8_107
.LBB8_105:
	movq	72(%rsp), %rax
	testq	%rax, %rax
	jne	.LBB8_111
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.LBB8_107:
	movq	%rdx, %r14
	shrq	$4, %r14
	addq	$8, %r15
	movq	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r12
	jmp	.LBB8_109
	.p2align	4
.LBB8_108:
	addq	$24, %r15
	decq	%r14
	je	.LBB8_105
.LBB8_109:
	movq	-8(%r15), %rsi
	testq	%rsi, %rsi
	je	.LBB8_108
	movq	(%r15), %rdi
	movl	$1, %edx
	callq	*%r12
	jmp	.LBB8_108
.LBB8_111:
	movq	56(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	movq	%rbx, %rdi
	callq	_Unwind_Resume@PLT
.Lfunc_end8:
	.size	_RNvCs5d4rudRldWE_12source_probe4main, .Lfunc_end8-_RNvCs5d4rudRldWE_12source_probe4main
	.cfi_endproc
	.section	.rodata._RNvCs5d4rudRldWE_12source_probe4main,"a",@progbits
	.p2align	2, 0x0
.LJTI8_0:
	.long	.LBB8_26-.LJTI8_0
	.long	.LBB8_32-.LJTI8_0
	.long	.LBB8_77-.LJTI8_0
	.long	.LBB8_29-.LJTI8_0
	.long	.LBB8_77-.LJTI8_0
	.long	.LBB8_38-.LJTI8_0
	.long	.LBB8_77-.LJTI8_0
	.long	.LBB8_77-.LJTI8_0
	.long	.LBB8_77-.LJTI8_0
	.long	.LBB8_34-.LJTI8_0
	.long	.LBB8_77-.LJTI8_0
	.long	.LBB8_77-.LJTI8_0
	.long	.LBB8_77-.LJTI8_0
	.long	.LBB8_77-.LJTI8_0
	.long	.LBB8_77-.LJTI8_0
	.long	.LBB8_77-.LJTI8_0
	.long	.LBB8_77-.LJTI8_0
	.long	.LBB8_36-.LJTI8_0
	.section	.gcc_except_table._RNvCs5d4rudRldWE_12source_probe4main,"a",@progbits
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
	.uleb128 .Ltmp7-.Lfunc_begin0
	.uleb128 .Ltmp9-.Ltmp7
	.byte	0
	.byte	0
	.uleb128 .Ltmp9-.Lfunc_begin0
	.uleb128 .Ltmp10-.Ltmp9
	.uleb128 .Ltmp25-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp15-.Lfunc_begin0
	.uleb128 .Ltmp16-.Ltmp15
	.uleb128 .Ltmp17-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp16-.Lfunc_begin0
	.uleb128 .Ltmp13-.Ltmp16
	.byte	0
	.byte	0
	.uleb128 .Ltmp13-.Lfunc_begin0
	.uleb128 .Ltmp19-.Ltmp13
	.uleb128 .Ltmp25-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp19-.Lfunc_begin0
	.uleb128 .Ltmp23-.Ltmp19
	.byte	0
	.byte	0
	.uleb128 .Ltmp23-.Lfunc_begin0
	.uleb128 .Ltmp24-.Ltmp23
	.uleb128 .Ltmp25-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp24-.Lfunc_begin0
	.uleb128 .Lfunc_end8-.Ltmp24
	.byte	0
	.byte	0
.Lcst_end0:
	.p2align	2, 0x0

	.section	.text.unlikely._RNvMs8_NtCs4XhBu2GMSOm_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs5d4rudRldWE_12source_probe,"ax",@progbits
	.prefalign	4, .Lfunc_end9, nop
	.type	_RNvMs8_NtCs4XhBu2GMSOm_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs5d4rudRldWE_12source_probe,@function
_RNvMs8_NtCs4XhBu2GMSOm_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs5d4rudRldWE_12source_probe:
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
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_realloc@GOTPCREL(%rip)
	testq	%rax, %rax
	jne	.LBB9_6
	jmp	.LBB9_9
.LBB9_4:
	testq	%r14, %r14
	je	.LBB9_5
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$8, %esi
	movq	%r14, %rdi
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc12___rust_alloc@GOTPCREL(%rip)
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
	.size	_RNvMs8_NtCs4XhBu2GMSOm_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs5d4rudRldWE_12source_probe, .Lfunc_end9-_RNvMs8_NtCs4XhBu2GMSOm_5alloc7raw_vecNtB5_11RawVecInner11finish_growCs5d4rudRldWE_12source_probe
	.cfi_endproc

	.section	.text._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe,"ax",@progbits
	.prefalign	4, .Lfunc_end10, nop
	.type	_RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe,@function
_RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe:
	.cfi_startproc
	movq	%rsi, %rax
	movq	(%rdi), %rcx
	movzbl	(%rcx), %ecx
	leaq	.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe(%rip), %rdx
	movzbl	(%rcx,%rdx), %edx
	leaq	.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe.74.rel(%rip), %rdi
	movslq	(%rdi,%rcx,4), %rsi
	addq	%rdi, %rsi
	movq	%rax, %rdi
	jmpq	*_RNvMsa_NtCs6knCYbIatyh_4core3fmtNtB5_9Formatter9write_str@GOTPCREL(%rip)
.Lfunc_end10:
	.size	_RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe, .Lfunc_end10-_RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe
	.cfi_endproc

	.section	.text._RNvXsc_NtNtCs6knCYbIatyh_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt,"ax",@progbits
	.prefalign	4, .Lfunc_end11, nop
	.type	_RNvXsc_NtNtCs6knCYbIatyh_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt,@function
_RNvXsc_NtNtCs6knCYbIatyh_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt:
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
	callq	*_RNvMsa_NtCs6knCYbIatyh_4core3fmtNtB5_9Formatter26debug_struct_field1_finish@GOTPCREL(%rip)
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end11:
	.size	_RNvXsc_NtNtCs6knCYbIatyh_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt, .Lfunc_end11-_RNvXsc_NtNtCs6knCYbIatyh_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
	.cfi_endproc

	.section	.text.manual,"ax",@progbits
	.globl	manual
	.prefalign	4, .Lfunc_end12, nop
	.type	manual,@function
manual:
	.cfi_startproc
	xorl	%eax, %eax
	leaq	-8(%rsp), %rdi
	movabsq	$-6148914691236517205, %rcx
	movabsq	$3074457345618258602, %rdx
	movabsq	$6148914691236517205, %rsi
	xorl	%r8d, %r8d
	.p2align	4
.LBB12_1:
	movq	%r8, -8(%rsp)
	incq	%r8
	#APP
	#NO_APP
	movq	-8(%rsp), %r9
	imulq	%rcx, %r9
	addq	%rdx, %r9
	cmpq	%rsi, %r9
	adcq	$0, %rax
	cmpq	$1000000, %r8
	jne	.LBB12_1
	xorl	%edi, %edi
	leaq	-8(%rsp), %r8
	.p2align	4
.LBB12_3:
	movq	%rdi, -8(%rsp)
	incq	%rdi
	#APP
	#NO_APP
	movq	-8(%rsp), %r9
	imulq	%rcx, %r9
	addq	%rdx, %r9
	cmpq	%rsi, %r9
	adcq	$0, %rax
	cmpq	$1000000, %rdi
	jne	.LBB12_3
	retq
.Lfunc_end12:
	.size	manual, .Lfunc_end12-manual
	.cfi_endproc

	.section	.text.no_modulus,"ax",@progbits
	.globl	no_modulus
	.prefalign	4, .Lfunc_end13, nop
	.type	no_modulus,@function
no_modulus:
	.cfi_startproc
	xorl	%eax, %eax
	leaq	-8(%rsp), %rcx
	xorl	%edx, %edx
	.p2align	4
.LBB13_1:
	movq	%rdx, -8(%rsp)
	incq	%rdx
	#APP
	#NO_APP
	movl	-8(%rsp), %esi
	notl	%esi
	andl	$1, %esi
	addq	%rsi, %rax
	cmpq	$1000000, %rdx
	jne	.LBB13_1
	xorl	%ecx, %ecx
	leaq	-8(%rsp), %rdx
	.p2align	4
.LBB13_3:
	movq	%rcx, -8(%rsp)
	incq	%rcx
	#APP
	#NO_APP
	movl	-8(%rsp), %esi
	notl	%esi
	andl	$1, %esi
	addq	%rsi, %rax
	cmpq	$1000000, %rcx
	jne	.LBB13_3
	retq
.Lfunc_end13:
	.size	no_modulus, .Lfunc_end13-no_modulus
	.cfi_endproc

	.section	.text.original,"ax",@progbits
	.globl	original
	.prefalign	4, .Lfunc_end14, nop
	.type	original,@function
original:
	.cfi_startproc
	xorl	%eax, %eax
	leaq	-8(%rsp), %rdi
	movabsq	$-6148914691236517205, %rcx
	movabsq	$3074457345618258602, %rdx
	movabsq	$6148914691236517205, %rsi
	xorl	%r8d, %r8d
	.p2align	4
.LBB14_1:
	movq	%r8, -8(%rsp)
	incq	%r8
	#APP
	#NO_APP
	movq	-8(%rsp), %r9
	imulq	%rcx, %r9
	addq	%rdx, %r9
	cmpq	%rsi, %r9
	adcq	$0, %rax
	cmpq	$1000000, %r8
	jne	.LBB14_1
	xorl	%edi, %edi
	leaq	-8(%rsp), %r8
	.p2align	4
.LBB14_3:
	movq	%rdi, -8(%rsp)
	incq	%rdi
	#APP
	#NO_APP
	movq	-8(%rsp), %r9
	imulq	%rcx, %r9
	addq	%rdx, %r9
	cmpq	%rsi, %r9
	adcq	$0, %rax
	cmpq	$1000000, %rdi
	jne	.LBB14_3
	retq
.Lfunc_end14:
	.size	original, .Lfunc_end14-original
	.cfi_endproc

	.section	.text.owned,"ax",@progbits
	.globl	owned
	.prefalign	4, .Lfunc_end15, nop
	.type	owned,@function
owned:
	.cfi_startproc
	xorl	%eax, %eax
	leaq	-8(%rsp), %rdi
	movabsq	$-6148914691236517205, %rcx
	movabsq	$3074457345618258602, %rdx
	movabsq	$6148914691236517205, %rsi
	xorl	%r8d, %r8d
	.p2align	4
.LBB15_1:
	movq	%r8, -8(%rsp)
	incq	%r8
	#APP
	#NO_APP
	movq	-8(%rsp), %r9
	imulq	%rcx, %r9
	addq	%rdx, %r9
	cmpq	%rsi, %r9
	adcq	$0, %rax
	cmpq	$1000000, %r8
	jne	.LBB15_1
	xorl	%edi, %edi
	leaq	-8(%rsp), %r8
	.p2align	4
.LBB15_3:
	movq	%rdi, -8(%rsp)
	incq	%rdi
	#APP
	#NO_APP
	movq	-8(%rsp), %r9
	imulq	%rcx, %r9
	addq	%rdx, %r9
	cmpq	%rsi, %r9
	adcq	$0, %rax
	cmpq	$1000000, %rdi
	jne	.LBB15_3
	retq
.Lfunc_end15:
	.size	owned, .Lfunc_end15-owned
	.cfi_endproc

	.section	.text.source_unroll4,"ax",@progbits
	.globl	source_unroll4
	.prefalign	4, .Lfunc_end16, nop
	.type	source_unroll4,@function
source_unroll4:
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
	xorl	%ecx, %ecx
	leaq	-8(%rsp), %rax
	movabsq	$-6148914691236517205, %rsi
	movabsq	$3074457345618258602, %r8
	movabsq	$6148914691236517205, %r9
	xorl	%edx, %edx
	xorl	%edi, %edi
	xorl	%r11d, %r11d
	xorl	%r10d, %r10d
	.p2align	4
.LBB16_1:
	movq	%r11, -8(%rsp)
	#APP
	#NO_APP
	movq	-8(%rsp), %rbx
	imulq	%rsi, %rbx
	addq	%r8, %rbx
	cmpq	%r9, %rbx
	adcq	$0, %r10
	leaq	1(%r11), %rbx
	movq	%rbx, -8(%rsp)
	#APP
	#NO_APP
	movq	-8(%rsp), %rbx
	imulq	%rsi, %rbx
	addq	%r8, %rbx
	cmpq	%r9, %rbx
	adcq	$0, %rdi
	leaq	2(%r11), %rbx
	movq	%rbx, -8(%rsp)
	#APP
	#NO_APP
	movq	-8(%rsp), %rbx
	imulq	%rsi, %rbx
	addq	%r8, %rbx
	cmpq	%r9, %rbx
	adcq	$0, %rdx
	leaq	3(%r11), %rbx
	movq	%rbx, -8(%rsp)
	#APP
	#NO_APP
	movq	-8(%rsp), %rbx
	imulq	%rsi, %rbx
	addq	%r8, %rbx
	cmpq	%r9, %rbx
	adcq	$0, %rcx
	cmpq	$999996, %r11
	leaq	4(%r11), %r11
	jb	.LBB16_1
	xorl	%eax, %eax
	leaq	-8(%rsp), %r15
	xorl	%ebx, %ebx
	xorl	%r11d, %r11d
	xorl	%r12d, %r12d
	xorl	%r14d, %r14d
	.p2align	4
.LBB16_3:
	movq	%r12, -8(%rsp)
	#APP
	#NO_APP
	movq	-8(%rsp), %r13
	imulq	%rsi, %r13
	addq	%r8, %r13
	cmpq	%r9, %r13
	adcq	$0, %r14
	leaq	1(%r12), %r13
	movq	%r13, -8(%rsp)
	#APP
	#NO_APP
	movq	-8(%rsp), %r13
	imulq	%rsi, %r13
	addq	%r8, %r13
	cmpq	%r9, %r13
	adcq	$0, %r11
	leaq	2(%r12), %r13
	movq	%r13, -8(%rsp)
	#APP
	#NO_APP
	movq	-8(%rsp), %r13
	imulq	%rsi, %r13
	addq	%r8, %r13
	cmpq	%r9, %r13
	adcq	$0, %rbx
	leaq	3(%r12), %r13
	movq	%r13, -8(%rsp)
	#APP
	#NO_APP
	movq	-8(%rsp), %r13
	imulq	%rsi, %r13
	addq	%r8, %r13
	cmpq	%r9, %r13
	adcq	$0, %rax
	cmpq	$999996, %r12
	leaq	4(%r12), %r12
	jb	.LBB16_3
	addq	%r10, %rdi
	addq	%rdi, %rdx
	addq	%rdx, %rcx
	addq	%r14, %r11
	addq	%rbx, %rax
	addq	%r11, %rax
	addq	%rcx, %rax
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
.Lfunc_end16:
	.size	source_unroll4, .Lfunc_end16-source_unroll4
	.cfi_endproc

	.section	.text.source_unroll4_one_acc,"ax",@progbits
	.globl	source_unroll4_one_acc
	.prefalign	4, .Lfunc_end17, nop
	.type	source_unroll4_one_acc,@function
source_unroll4_one_acc:
	.cfi_startproc
	xorl	%edi, %edi
	leaq	-8(%rsp), %r8
	movabsq	$-6148914691236517205, %rcx
	movabsq	$3074457345618258602, %rdx
	movabsq	$6148914691236517205, %rsi
	xorl	%eax, %eax
	.p2align	4
.LBB17_1:
	movq	%rdi, -8(%rsp)
	#APP
	#NO_APP
	movq	-8(%rsp), %r9
	imulq	%rcx, %r9
	addq	%rdx, %r9
	xorl	%r10d, %r10d
	cmpq	%rsi, %r9
	setb	%r10b
	leaq	1(%rdi), %r9
	movq	%r9, -8(%rsp)
	#APP
	#NO_APP
	movq	-8(%rsp), %r9
	imulq	%rcx, %r9
	addq	%rdx, %r9
	cmpq	%rsi, %r9
	movq	%rax, %r9
	adcq	%r10, %r9
	leaq	2(%rdi), %rax
	movq	%rax, -8(%rsp)
	#APP
	#NO_APP
	movq	-8(%rsp), %r10
	imulq	%rcx, %r10
	addq	%rdx, %r10
	xorl	%eax, %eax
	cmpq	%rsi, %r10
	setb	%al
	leaq	3(%rdi), %r10
	movq	%r10, -8(%rsp)
	#APP
	#NO_APP
	movq	-8(%rsp), %r10
	imulq	%rcx, %r10
	addq	%rdx, %r10
	cmpq	%rsi, %r10
	adcq	%r9, %rax
	cmpq	$999996, %rdi
	leaq	4(%rdi), %rdi
	jb	.LBB17_1
	xorl	%edi, %edi
	leaq	-8(%rsp), %r8
	.p2align	4
.LBB17_3:
	movq	%rdi, -8(%rsp)
	#APP
	#NO_APP
	movq	-8(%rsp), %r9
	imulq	%rcx, %r9
	addq	%rdx, %r9
	xorl	%r10d, %r10d
	cmpq	%rsi, %r9
	setb	%r10b
	leaq	1(%rdi), %r9
	movq	%r9, -8(%rsp)
	#APP
	#NO_APP
	movq	-8(%rsp), %r9
	imulq	%rcx, %r9
	addq	%rdx, %r9
	cmpq	%rsi, %r9
	movq	%rax, %r9
	adcq	%r10, %r9
	leaq	2(%rdi), %rax
	movq	%rax, -8(%rsp)
	#APP
	#NO_APP
	movq	-8(%rsp), %r10
	imulq	%rcx, %r10
	addq	%rdx, %r10
	xorl	%eax, %eax
	cmpq	%rsi, %r10
	setb	%al
	leaq	3(%rdi), %r10
	movq	%r10, -8(%rsp)
	#APP
	#NO_APP
	movq	-8(%rsp), %r10
	imulq	%rcx, %r10
	addq	%rdx, %r10
	cmpq	%rsi, %r10
	adcq	%r9, %rax
	cmpq	$999996, %rdi
	leaq	4(%rdi), %rdi
	jb	.LBB17_3
	retq
.Lfunc_end17:
	.size	source_unroll4_one_acc, .Lfunc_end17-source_unroll4_one_acc
	.cfi_endproc

	.section	.text.split,"ax",@progbits
	.globl	split
	.prefalign	4, .Lfunc_end18, nop
	.type	split,@function
split:
	.cfi_startproc
	xorl	%ecx, %ecx
	leaq	-8(%rsp), %rax
	movabsq	$-6148914691236517205, %rdx
	movabsq	$3074457345618258602, %rsi
	movabsq	$6148914691236517205, %rdi
	xorl	%r8d, %r8d
	.p2align	4
.LBB18_1:
	movq	%r8, -8(%rsp)
	incq	%r8
	#APP
	#NO_APP
	movq	-8(%rsp), %r9
	imulq	%rdx, %r9
	addq	%rsi, %r9
	cmpq	%rdi, %r9
	adcq	$0, %rcx
	cmpq	$1000000, %r8
	jne	.LBB18_1
	xorl	%eax, %eax
	leaq	-8(%rsp), %r8
	xorl	%r9d, %r9d
	.p2align	4
.LBB18_3:
	movq	%r9, -8(%rsp)
	incq	%r9
	#APP
	#NO_APP
	movq	-8(%rsp), %r10
	imulq	%rdx, %r10
	addq	%rsi, %r10
	cmpq	%rdi, %r10
	adcq	$0, %rax
	cmpq	$1000000, %r9
	jne	.LBB18_3
	addq	%rcx, %rax
	retq
.Lfunc_end18:
	.size	split, .Lfunc_end18-split
	.cfi_endproc

	.section	.text.unsigned,"ax",@progbits
	.globl	unsigned
	.prefalign	4, .Lfunc_end19, nop
	.type	unsigned,@function
unsigned:
	.cfi_startproc
	xorl	%eax, %eax
	leaq	-8(%rsp), %rsi
	movabsq	$-6148914691236517205, %rcx
	movabsq	$6148914691236517206, %rdx
	xorl	%edi, %edi
	.p2align	4
.LBB19_1:
	movq	%rdi, -8(%rsp)
	incq	%rdi
	#APP
	#NO_APP
	movq	-8(%rsp), %r8
	imulq	%rcx, %r8
	cmpq	%rdx, %r8
	adcq	$0, %rax
	cmpq	$1000000, %rdi
	jne	.LBB19_1
	xorl	%esi, %esi
	leaq	-8(%rsp), %rdi
	.p2align	4
.LBB19_3:
	movq	%rsi, -8(%rsp)
	incq	%rsi
	#APP
	#NO_APP
	movq	-8(%rsp), %r8
	imulq	%rcx, %r8
	cmpq	%rdx, %r8
	adcq	$0, %rax
	cmpq	$1000000, %rsi
	jne	.LBB19_3
	retq
.Lfunc_end19:
	.size	unsigned, .Lfunc_end19-unsigned
	.cfi_endproc

	.section	.text.main,"ax",@progbits
	.globl	main
	.prefalign	4, .Lfunc_end20, nop
	.type	main,@function
main:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	%rsi, %rcx
	movslq	%edi, %rdx
	leaq	_RNvCs5d4rudRldWE_12source_probe4main(%rip), %rax
	movq	%rax, (%rsp)
	leaq	.Lvtable.1(%rip), %rsi
	movq	%rsp, %rdi
	xorl	%r8d, %r8d
	callq	*_RNvNtCs9wefJfwQbYy_3std2rt19lang_start_internal@GOTPCREL(%rip)
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end20:
	.size	main, .Lfunc_end20-main
	.cfi_endproc

	.type	.Lvtable.0,@object
	.section	.data.rel.ro..Lvtable.0,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.0:
	.asciz	"\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\001\000\000\000\000\000\000"
	.quad	_RNvXsc_NtNtCs6knCYbIatyh_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
	.size	.Lvtable.0, 32

	.type	.Lvtable.1,@object
	.section	.data.rel.ro..Lvtable.1,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.1:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNSNvYNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceuE9call_once6vtableCs5d4rudRldWE_12source_probe
	.quad	_RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0Cs5d4rudRldWE_12source_probe
	.quad	_RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0Cs5d4rudRldWE_12source_probe
	.size	.Lvtable.1, 48

	.type	.Lalloc_06f579ee8a4f6b7e5ec4ae779160f088,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_06f579ee8a4f6b7e5ec4ae779160f088:
	.asciz	"/tmp/iter-filter-chain-20261105/source-probe.rs"
	.size	.Lalloc_06f579ee8a4f6b7e5ec4ae779160f088, 48

	.type	.Lalloc_1d94add87e3dcf7e1111ac5ccc13c9f1,@object
	.section	.data.rel.ro..Lalloc_1d94add87e3dcf7e1111ac5ccc13c9f1,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_1d94add87e3dcf7e1111ac5ccc13c9f1:
	.quad	.Lalloc_06f579ee8a4f6b7e5ec4ae779160f088
	.asciz	"/\000\000\000\000\000\000\000G\000\000\000\"\000\000"
	.size	.Lalloc_1d94add87e3dcf7e1111ac5ccc13c9f1, 24

	.type	.Lalloc_476509aa7047bd805d630c6546685797,@object
	.section	.rodata..Lalloc_476509aa7047bd805d630c6546685797,"a",@progbits
.Lalloc_476509aa7047bd805d630c6546685797:
	.ascii	"explicit panic"
	.size	.Lalloc_476509aa7047bd805d630c6546685797, 14

	.type	.Lalloc_37afb19b6074d42e0a073e2c4bb21567,@object
	.section	.data.rel.ro..Lalloc_37afb19b6074d42e0a073e2c4bb21567,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_37afb19b6074d42e0a073e2c4bb21567:
	.quad	.Lalloc_06f579ee8a4f6b7e5ec4ae779160f088
	.asciz	"/\000\000\000\000\000\000\000H\000\000\000\320\000\000"
	.size	.Lalloc_37afb19b6074d42e0a073e2c4bb21567, 24

	.type	.Lalloc_080ada99a9040ff5939f0c539f14eb34,@object
	.section	.data.rel.ro..Lalloc_080ada99a9040ff5939f0c539f14eb34,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_080ada99a9040ff5939f0c539f14eb34:
	.quad	.Lalloc_06f579ee8a4f6b7e5ec4ae779160f088
	.asciz	"/\000\000\000\000\000\000\000J\000\000\000\005\000\000"
	.size	.Lalloc_080ada99a9040ff5939f0c539f14eb34, 24

	.type	.Lalloc_42cc296b28798c6afd9e87c5ffa2f5ae,@object
	.section	.data.rel.ro..Lalloc_42cc296b28798c6afd9e87c5ffa2f5ae,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_42cc296b28798c6afd9e87c5ffa2f5ae:
	.quad	.Lalloc_06f579ee8a4f6b7e5ec4ae779160f088
	.asciz	"/\000\000\000\000\000\000\000K\000\000\000\030\000\000"
	.size	.Lalloc_42cc296b28798c6afd9e87c5ffa2f5ae, 24

	.type	.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274,@object
	.section	.rodata..Lalloc_00ae4b301f7fab8ac9617c03fcbd7274,"a",@progbits
.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274:
	.ascii	"called `Result::unwrap()` on an `Err` value"
	.size	.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274, 43

	.type	.Lalloc_9c36da405e10a0a8abb38df9ba7ee95b,@object
	.section	.data.rel.ro..Lalloc_9c36da405e10a0a8abb38df9ba7ee95b,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_9c36da405e10a0a8abb38df9ba7ee95b:
	.quad	.Lalloc_06f579ee8a4f6b7e5ec4ae779160f088
	.asciz	"/\000\000\000\000\000\000\000K\000\000\000$\000\000"
	.size	.Lalloc_9c36da405e10a0a8abb38df9ba7ee95b, 24

	.type	.Lvtable.2,@object
	.section	.data.rel.ro..Lvtable.2,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.2:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe
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

	.type	.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe,"a",@progbits
	.p2align	3, 0x0
.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe:
	.ascii	"\005\f\013\013\004\016"
	.size	.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe, 6

	.type	.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe.74.rel,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe.74.rel,"a",@progbits
	.p2align	2, 0x0
.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe.74.rel:
	.long	.Lalloc_59ba7b9f7211443cd55a366616eef46a-.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe.74.rel
	.long	.Lalloc_00315c78e51d29fe6b3102a4c1ecf6ef-.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe.74.rel
	.long	.Lalloc_bd3a3f3879e0d5f64554753e977f58d4-.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe.74.rel
	.long	.Lalloc_0964bb2a4870637395c77a018495bd5c-.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe.74.rel
	.long	.Lalloc_6566120a3a17f930e960a0863fcbd591-.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe.74.rel
	.long	.Lalloc_6c17bac0c71cba42380f8445f4dcbd16-.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe.74.rel
	.size	.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCs5d4rudRldWE_12source_probe.74.rel, 24

	.hidden	DW.ref._RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality
	.weak	DW.ref._RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality
	.section	.data.DW.ref._RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality,"awG",@progbits,DW.ref._RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality,comdat
	.p2align	3, 0x0
	.type	DW.ref._RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality,@object
	.size	DW.ref._RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality, 8
DW.ref._RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality:
	.quad	_RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality
	.ident	"rustc version 1.101.0-dev"
	.section	".note.GNU-stack","",@progbits
