	.att_syntax
	.file	"leaf.9071ff1952c27ea-cgu.0"
	.section	.text._RINvNtCs6knCYbIatyh_4core3ptr9drop_glueINtNtCs4XhBu2GMSOm_5alloc3vec3VecNtNtBG_6string6StringEECsM3pabHJvao_4leaf,"ax",@progbits
	.prefalign	4, .Lfunc_end0, nop
	.type	_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueINtNtCs4XhBu2GMSOm_5alloc3vec3VecNtNtBG_6string6StringEECsM3pabHJvao_4leaf,@function
_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueINtNtCs4XhBu2GMSOm_5alloc3vec3VecNtNtBG_6string6StringEECsM3pabHJvao_4leaf:
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
	.size	_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueINtNtCs4XhBu2GMSOm_5alloc3vec3VecNtNtBG_6string6StringEECsM3pabHJvao_4leaf, .Lfunc_end0-_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueINtNtCs4XhBu2GMSOm_5alloc3vec3VecNtNtBG_6string6StringEECsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text._RINvNtCs6knCYbIatyh_4core3ptr9drop_glueNtNtCs9wefJfwQbYy_3std3env4ArgsECsM3pabHJvao_4leaf,"ax",@progbits
	.prefalign	4, .Lfunc_end1, nop
	.type	_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueNtNtCs9wefJfwQbYy_3std3env4ArgsECsM3pabHJvao_4leaf,@function
_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueNtNtCs9wefJfwQbYy_3std3env4ArgsECsM3pabHJvao_4leaf:
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
	.size	_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueNtNtCs9wefJfwQbYy_3std3env4ArgsECsM3pabHJvao_4leaf, .Lfunc_end1-_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueNtNtCs9wefJfwQbYy_3std3env4ArgsECsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text.unlikely._RINvNtCs6knCYbIatyh_4core6result13unwrap_failedNtNtNtB4_3num5error13ParseIntErrorECsM3pabHJvao_4leaf,"ax",@progbits
	.prefalign	4, .Lfunc_end2, nop
	.type	_RINvNtCs6knCYbIatyh_4core6result13unwrap_failedNtNtNtB4_3num5error13ParseIntErrorECsM3pabHJvao_4leaf,@function
_RINvNtCs6knCYbIatyh_4core6result13unwrap_failedNtNtNtB4_3num5error13ParseIntErrorECsM3pabHJvao_4leaf:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movb	%dil, 7(%rsp)
	leaq	.Lalloc_00ae4b301f7fab8ac9617c03fcbd7274(%rip), %rdi
	leaq	.Lvtable.0(%rip), %rcx
	leaq	.Lalloc_05c202032256fef92c612b00fee0bc15(%rip), %r8
	leaq	7(%rsp), %rdx
	movl	$43, %esi
	callq	*_RNvNvNtCs6knCYbIatyh_4core6result13unwrap_failed19unwrap_failed_inner@GOTPCREL(%rip)
.Lfunc_end2:
	.size	_RINvNtCs6knCYbIatyh_4core6result13unwrap_failedNtNtNtB4_3num5error13ParseIntErrorECsM3pabHJvao_4leaf, .Lfunc_end2-_RINvNtCs6knCYbIatyh_4core6result13unwrap_failedNtNtNtB4_3num5error13ParseIntErrorECsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text._RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECsM3pabHJvao_4leaf,"ax",@progbits
	.hidden	_RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECsM3pabHJvao_4leaf
	.globl	_RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECsM3pabHJvao_4leaf
	.prefalign	4, .Lfunc_end3, nop
	.type	_RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECsM3pabHJvao_4leaf,@function
_RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECsM3pabHJvao_4leaf:
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
	.size	_RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECsM3pabHJvao_4leaf, .Lfunc_end3-_RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text._RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsM3pabHJvao_4leaf,"ax",@progbits
	.prefalign	4, .Lfunc_end4, nop
	.type	_RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsM3pabHJvao_4leaf,@function
_RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsM3pabHJvao_4leaf:
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
	.size	_RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsM3pabHJvao_4leaf, .Lfunc_end4-_RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text.unlikely._RINvNvMs5_NtCs4XhBu2GMSOm_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsM3pabHJvao_4leaf,"ax",@progbits
	.prefalign	4, .Lfunc_end5, nop
	.type	_RINvNvMs5_NtCs4XhBu2GMSOm_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsM3pabHJvao_4leaf,@function
_RINvNvMs5_NtCs4XhBu2GMSOm_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsM3pabHJvao_4leaf:
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
	callq	_RNvMs8_NtCs4XhBu2GMSOm_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsM3pabHJvao_4leaf
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
	.size	_RINvNvMs5_NtCs4XhBu2GMSOm_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsM3pabHJvao_4leaf, .Lfunc_end5-_RINvNvMs5_NtCs4XhBu2GMSOm_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text._RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0CsM3pabHJvao_4leaf,"ax",@progbits
	.prefalign	4, .Lfunc_end6, nop
	.type	_RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0CsM3pabHJvao_4leaf,@function
_RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0CsM3pabHJvao_4leaf:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	(%rdi), %rdi
	callq	_RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsM3pabHJvao_4leaf
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end6:
	.size	_RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0CsM3pabHJvao_4leaf, .Lfunc_end6-_RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0CsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text._RNSNvYNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceuE9call_once6vtableCsM3pabHJvao_4leaf,"ax",@progbits
	.prefalign	4, .Lfunc_end7, nop
	.type	_RNSNvYNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceuE9call_once6vtableCsM3pabHJvao_4leaf,@function
_RNSNvYNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceuE9call_once6vtableCsM3pabHJvao_4leaf:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	(%rdi), %rdi
	callq	_RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsM3pabHJvao_4leaf
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end7:
	.size	_RNSNvYNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceuE9call_once6vtableCsM3pabHJvao_4leaf, .Lfunc_end7-_RNSNvYNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceuE9call_once6vtableCsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text._RNvCsM3pabHJvao_4leaf4main,"ax",@progbits
	.hidden	_RNvCsM3pabHJvao_4leaf4main
	.globl	_RNvCsM3pabHJvao_4leaf4main
	.prefalign	4, .Lfunc_end8, nop
	.type	_RNvCsM3pabHJvao_4leaf4main,@function
_RNvCsM3pabHJvao_4leaf4main:
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
	subq	$168, %rsp
	.cfi_def_cfa_offset 224
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	leaq	32(%rsp), %rbx
	movq	%rbx, %rdi
	callq	*_RNvNtCs9wefJfwQbYy_3std3env4args@GOTPCREL(%rip)
.Ltmp0:
	movq	%rsp, %rdi
	movq	%rbx, %rsi
	callq	*_RNvXse_NtCs9wefJfwQbYy_3std3envNtB5_4ArgsNtNtNtNtCs6knCYbIatyh_4core4iter6traits8iterator8Iterator4next@GOTPCREL(%rip)
.Ltmp1:
	movq	(%rsp), %r14
	cmpq	$-1, %r14
	je	.LBB8_65
	movq	8(%rsp), %r15
	movq	56(%rsp), %rax
	subq	40(%rsp), %rax
	movq	%rax, %rcx
	shrq	$3, %rcx
	movabsq	$-6148914691236517205, %rdx
	imulq	%rdx, %rcx
	cmpq	$4, %rcx
	movl	$3, %ebp
	cmovaeq	%rcx, %rbp
	leaq	8(,%rbp,8), %rcx
	leaq	(%rcx,%rcx,2), %rbx
	movabsq	$9223372036854775776, %rcx
	cmpq	%rcx, %rax
	jbe	.LBB8_5
	xorl	%r13d, %r13d
.LBB8_4:
.Ltmp20:
	movq	%r13, %rdi
	movq	%rbx, %rsi
	callq	*_RNvNtCs4XhBu2GMSOm_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Ltmp21:
	jmp	.LBB8_70
.LBB8_5:
	movq	16(%rsp), %rax
	testq	%rbx, %rbx
	je	.LBB8_8
	movq	%rax, 88(%rsp)
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$8, %r13d
	movl	$8, %esi
	movq	%rbx, %rdi
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc12___rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB8_4
	movq	%rax, %r12
	incq	%rbp
	movq	88(%rsp), %rax
	jmp	.LBB8_9
.LBB8_8:
	movl	$8, %r12d
	xorl	%ebp, %ebp
.LBB8_9:
	movq	%r14, (%r12)
	movq	%r15, 8(%r12)
	movq	%rax, 16(%r12)
	movq	%rbp, 64(%rsp)
	movq	%r12, 72(%rsp)
	movq	$1, 80(%rsp)
	movups	32(%rsp), %xmm0
	movups	48(%rsp), %xmm1
	movaps	%xmm1, 16(%rsp)
	movaps	%xmm0, (%rsp)
	movl	$1, %r14d
	movl	$40, %r15d
	jmp	.LBB8_12
	.p2align	4
.LBB8_10:
	movq	72(%rsp), %r12
.LBB8_11:
	movq	%rbp, -16(%r12,%r15)
	movq	%rbx, -8(%r12,%r15)
	movq	%r13, (%r12,%r15)
	incq	%r14
	movq	%r14, 80(%rsp)
	addq	$24, %r15
.LBB8_12:
.Ltmp3:
	leaq	104(%rsp), %rdi
	movq	%rsp, %rsi
	callq	*_RNvXse_NtCs9wefJfwQbYy_3std3envNtB5_4ArgsNtNtNtNtCs6knCYbIatyh_4core4iter6traits8iterator8Iterator4next@GOTPCREL(%rip)
.Ltmp4:
	movq	104(%rsp), %rbp
	cmpq	$-1, %rbp
	je	.LBB8_16
	movq	112(%rsp), %rbx
	movq	120(%rsp), %r13
	cmpq	64(%rsp), %r14
	jne	.LBB8_11
	movq	24(%rsp), %rdx
	subq	8(%rsp), %rdx
	shrq	$3, %rdx
	movabsq	$-6148914691236517205, %rax
	imulq	%rax, %rdx
	incq	%rdx
.Ltmp6:
	leaq	64(%rsp), %rdi
	movq	%r14, %rsi
	callq	_RINvNvMs5_NtCs4XhBu2GMSOm_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsM3pabHJvao_4leaf
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
	movups	64(%rsp), %xmm0
	movaps	%xmm0, 128(%rsp)
	movq	80(%rsp), %r14
	movq	%r14, 144(%rsp)
	cmpq	$3, %r14
	jb	.LBB8_69
	movq	136(%rsp), %r9
	movq	56(%r9), %rcx
	movq	64(%r9), %rsi
	cmpq	$1, %rsi
	je	.LBB8_27
	testq	%rsi, %rsi
	je	.LBB8_75
	movzbl	(%rcx), %edx
	jmp	.LBB8_29
.LBB8_27:
	movzbl	(%rcx), %edx
	movb	$1, %al
	cmpl	$43, %edx
	je	.LBB8_62
	cmpl	$45, %edx
	je	.LBB8_62
.LBB8_29:
	xorl	%eax, %eax
	cmpb	$43, %dl
	sete	%al
	movq	%rsi, %rdx
	subq	%rax, %rdx
	addq	%rax, %rcx
	negq	%rax
	cmpq	$17, %rdx
	jae	.LBB8_34
	testq	%rdx, %rdx
	je	.LBB8_39
	addq	%rax, %rsi
	negq	%rsi
	xorl	%eax, %eax
	xorl	%edx, %edx
	.p2align	4
.LBB8_32:
	movzbl	(%rcx,%rdx), %edi
	addl	$-48, %edi
	cmpl	$9, %edi
	ja	.LBB8_64
	leaq	(%rax,%rax,4), %rax
	movl	%edi, %edi
	leaq	(%rdi,%rax,2), %rax
	incq	%rdx
	movq	%rsi, %rdi
	addq	%rdx, %rdi
	jne	.LBB8_32
	jmp	.LBB8_40
.LBB8_34:
	addq	%rax, %rsi
	negq	%rsi
	xorl	%eax, %eax
	movl	$10, %edi
	xorl	%r8d, %r8d
	.p2align	4
.LBB8_35:
	mulq	%rdi
	movzbl	(%rcx,%r8), %edx
	jo	.LBB8_60
	addl	$-48, %edx
	cmpl	$10, %edx
	jae	.LBB8_64
	movl	%edx, %edx
	addq	%rdx, %rax
	jb	.LBB8_61
	incq	%r8
	movq	%rsi, %rdx
	addq	%r8, %rdx
	jne	.LBB8_35
	jmp	.LBB8_40
.LBB8_39:
	xorl	%eax, %eax
.LBB8_40:
	movq	%rax, 96(%rsp)
	leaq	.Lalloc_6bc448098e9286fddb6a1b0985fbb1c2(%rip), %rax
	movq	%rax, 104(%rsp)
	movq	$27, 112(%rsp)
	movq	$123, 120(%rsp)
	leaq	104(%rsp), %rax
	#APP
	#NO_APP
	leaq	.Lalloc_5ce47bf71e58a1df2fef3d4cd6838414(%rip), %rax
	movq	%rax, 32(%rsp)
	movq	$27, 40(%rsp)
	movq	$456, 48(%rsp)
	leaq	32(%rsp), %rax
	#APP
	#NO_APP
	movq	32(%r9), %rax
	movq	40(%r9), %rcx
	cmpq	$5, %rcx
	je	.LBB8_44
	cmpq	$8, %rcx
	jne	.LBB8_45
	movabsq	$7809644627822735983, %rcx
	cmpq	%rcx, (%rax)
	jne	.LBB8_45
	leaq	leaf_original(%rip), %r13
	jmp	.LBB8_46
.LBB8_44:
	movl	$1702065510, %ecx
	xorl	(%rax), %ecx
	movzbl	4(%rax), %eax
	xorl	$100, %eax
	orl	%ecx, %eax
.LBB8_45:
	leaq	leaf_fused(%rip), %r13
.LBB8_46:
.Ltmp11:
	movq	%r9, 88(%rsp)
	callq	*_RNvMNtCs9wefJfwQbYy_3std4timeNtB2_7Instant3now@GOTPCREL(%rip)
.Ltmp12:
	movq	%rax, 152(%rsp)
	movl	%edx, 160(%rsp)
	movq	96(%rsp), %rbp
	testq	%rbp, %rbp
	je	.LBB8_51
	leaq	104(%rsp), %rbx
	leaq	32(%rsp), %r12
	movq	%rsp, %r15
	.p2align	4
.LBB8_49:
.Ltmp13:
	movq	%rbx, %rdi
	movq	%r12, %rsi
	callq	*%r13
.Ltmp14:
	movl	%eax, (%rsp)
	#APP
	#NO_APP
	decq	%rbp
	jne	.LBB8_49
.LBB8_51:
.Ltmp16:
	leaq	152(%rsp), %rdi
	callq	*_RNvMNtCs9wefJfwQbYy_3std4timeNtB2_7Instant7elapsed@GOTPCREL(%rip)
.Ltmp17:
	movl	%edx, %ecx
	movl	$1000000000, %edx
	mulq	%rdx
	movl	%ecx, %ecx
	addq	%rax, %rcx
	adcq	$0, %rdx
	movq	%rcx, 64(%rsp)
	movq	%rdx, 72(%rsp)
	leaq	64(%rsp), %rax
	movq	%rax, (%rsp)
	movq	_RNvXNtNtCs6knCYbIatyh_4core3fmt3numoNtB4_7Display3fmt@GOTPCREL(%rip), %rax
	movq	%rax, 8(%rsp)
	leaq	96(%rsp), %rax
	movq	%rax, 16(%rsp)
	movq	_RNvXsi_NtNtNtCs6knCYbIatyh_4core3fmt3num3impjNtB9_7Display3fmt@GOTPCREL(%rip), %rax
	movq	%rax, 24(%rsp)
.Ltmp18:
	leaq	.Lalloc_e2a59742fc8ed77e1d3dcda02e2eea96(%rip), %rdi
	movq	%rsp, %rsi
	callq	*_RNvNtNtCs9wefJfwQbYy_3std2io5stdio6__print@GOTPCREL(%rip)
.Ltmp19:
	movq	88(%rsp), %r15
	leaq	8(%r15), %rbx
	movq	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r12
	jmp	.LBB8_55
	.p2align	4
.LBB8_54:
	addq	$24, %rbx
	decq	%r14
	je	.LBB8_57
.LBB8_55:
	movq	-8(%rbx), %rsi
	testq	%rsi, %rsi
	je	.LBB8_54
	movq	(%rbx), %rdi
	movl	$1, %edx
	callq	*%r12
	jmp	.LBB8_54
.LBB8_57:
	movq	128(%rsp), %rax
	testq	%rax, %rax
	je	.LBB8_59
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	movq	%r15, %rdi
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB8_59:
	addq	$168, %rsp
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
.LBB8_60:
	.cfi_def_cfa_offset 224
	addb	$-48, %dl
	xorl	%eax, %eax
	cmpb	$10, %dl
	adcb	$1, %al
	jmp	.LBB8_62
.LBB8_61:
	movb	$2, %al
.LBB8_62:
.Ltmp9:
	movzbl	%al, %edi
	callq	_RINvNtCs6knCYbIatyh_4core6result13unwrap_failedNtNtNtB4_3num5error13ParseIntErrorECsM3pabHJvao_4leaf
.Ltmp10:
	jmp	.LBB8_70
.LBB8_64:
	movb	$1, %al
	jmp	.LBB8_62
.LBB8_65:
	movq	40(%rsp), %r14
	movq	56(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r14, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	movq	$0, 128(%rsp)
	movq	$8, 136(%rsp)
	movq	$0, 144(%rsp)
	cmpq	%r14, %rcx
	jne	.LBB8_71
.LBB8_66:
	movq	48(%rsp), %rax
	testq	%rax, %rax
	je	.LBB8_68
	movq	32(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB8_68:
	xorl	%r14d, %r14d
.LBB8_69:
.Ltmp23:
	leaq	.Lalloc_b3660d9ba06522ca6cd2ded3fcd4363c(%rip), %rdx
	movl	$2, %edi
	movq	%r14, %rsi
	callq	*_RNvNtCs6knCYbIatyh_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.Ltmp24:
.LBB8_70:
	ud2
.LBB8_71:
	movq	%rdx, %rbx
	shrq	$4, %rbx
	addq	$8, %r14
	movq	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r15
	jmp	.LBB8_73
	.p2align	4
.LBB8_72:
	addq	$24, %r14
	decq	%rbx
	je	.LBB8_66
.LBB8_73:
	movq	-8(%r14), %rsi
	testq	%rsi, %rsi
	je	.LBB8_72
	movq	(%r14), %rdi
	movl	$1, %edx
	callq	*%r15
	jmp	.LBB8_72
.LBB8_75:
	xorl	%eax, %eax
	jmp	.LBB8_62
.LBB8_76:
.Ltmp2:
	movq	%rax, %r12
	jmp	.LBB8_87
.LBB8_77:
.Ltmp8:
	movq	%rax, %r12
	testq	%rbp, %rbp
	je	.LBB8_81
	movl	$1, %edx
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	jmp	.LBB8_81
.LBB8_79:
.Ltmp15:
	jmp	.LBB8_83
.LBB8_80:
.Ltmp5:
	movq	%rax, %r12
.LBB8_81:
	movq	%rsp, %rdi
	callq	_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueNtNtCs9wefJfwQbYy_3std3env4ArgsECsM3pabHJvao_4leaf
	leaq	64(%rsp), %rdi
	callq	_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueINtNtCs4XhBu2GMSOm_5alloc3vec3VecNtNtBG_6string6StringEECsM3pabHJvao_4leaf
	movq	%r12, %rdi
	callq	_Unwind_Resume@PLT
.LBB8_82:
.Ltmp25:
.LBB8_83:
	movq	%rax, %r12
	leaq	128(%rsp), %rdi
	callq	_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueINtNtCs4XhBu2GMSOm_5alloc3vec3VecNtNtBG_6string6StringEECsM3pabHJvao_4leaf
	movq	%r12, %rdi
	callq	_Unwind_Resume@PLT
.LBB8_85:
.Ltmp22:
	movq	%rax, %r12
	testq	%r14, %r14
	je	.LBB8_87
	movl	$1, %edx
	movq	%r15, %rdi
	movq	%r14, %rsi
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB8_87:
	movq	40(%rsp), %r14
	movq	56(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r14, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	cmpq	%r14, %rcx
	jne	.LBB8_90
.LBB8_88:
	movq	48(%rsp), %rax
	testq	%rax, %rax
	jne	.LBB8_94
	movq	%r12, %rdi
	callq	_Unwind_Resume@PLT
.LBB8_90:
	movq	%rdx, %rbx
	shrq	$4, %rbx
	addq	$8, %r14
	movq	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r15
	jmp	.LBB8_92
	.p2align	4
.LBB8_91:
	addq	$24, %r14
	decq	%rbx
	je	.LBB8_88
.LBB8_92:
	movq	-8(%r14), %rsi
	testq	%rsi, %rsi
	je	.LBB8_91
	movq	(%r14), %rdi
	movl	$1, %edx
	callq	*%r15
	jmp	.LBB8_91
.LBB8_94:
	movq	32(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	movq	%r12, %rdi
	callq	_Unwind_Resume@PLT
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
	.uleb128 .Ltmp7-.Lfunc_begin0
	.uleb128 .Ltmp11-.Ltmp7
	.byte	0
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
	.uleb128 .Ltmp19-.Ltmp16
	.uleb128 .Ltmp25-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp19-.Lfunc_begin0
	.uleb128 .Ltmp9-.Ltmp19
	.byte	0
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

	.section	.text.unlikely._RNvMs8_NtCs4XhBu2GMSOm_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsM3pabHJvao_4leaf,"ax",@progbits
	.prefalign	4, .Lfunc_end9, nop
	.type	_RNvMs8_NtCs4XhBu2GMSOm_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsM3pabHJvao_4leaf,@function
_RNvMs8_NtCs4XhBu2GMSOm_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsM3pabHJvao_4leaf:
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
	.size	_RNvMs8_NtCs4XhBu2GMSOm_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsM3pabHJvao_4leaf, .Lfunc_end9-_RNvMs8_NtCs4XhBu2GMSOm_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf,"ax",@progbits
	.prefalign	4, .Lfunc_end10, nop
	.type	_RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf,@function
_RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf:
	.cfi_startproc
	movq	%rsi, %rax
	movq	(%rdi), %rcx
	movzbl	(%rcx), %ecx
	leaq	.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf(%rip), %rdx
	movzbl	(%rcx,%rdx), %edx
	leaq	.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel(%rip), %rdi
	movslq	(%rdi,%rcx,4), %rsi
	addq	%rdi, %rsi
	movq	%rax, %rdi
	jmpq	*_RNvMsa_NtCs6knCYbIatyh_4core3fmtNtB5_9Formatter9write_str@GOTPCREL(%rip)
.Lfunc_end10:
	.size	_RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf, .Lfunc_end10-_RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf
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

	.section	.text.leaf_fused,"ax",@progbits
	.globl	leaf_fused
	.prefalign	4, .Lfunc_end12, nop
	.type	leaf_fused,@function
leaf_fused:
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
	movq	%rsi, %rbx
	movq	%rdi, %r14
	movq	(%rdi), %rdi
	movq	8(%r14), %rax
	movq	(%rsi), %rsi
	movq	8(%rbx), %rdx
	movq	%rax, %r15
	subq	%rdx, %r15
	cmovbq	%rax, %rdx
	callq	*memcmp@GOTPCREL(%rip)
	cltq
	testl	%eax, %eax
	cmovneq	%rax, %r15
	testq	%r15, %r15
	sets	%cl
	setg	%al
	je	.LBB12_2
	subb	%cl, %al
	jmp	.LBB12_3
.LBB12_2:
	movq	16(%r14), %rax
	cmpq	16(%rbx), %rax
	seta	%al
	sbbb	$0, %al
.LBB12_3:
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	xorl	%esi, %esi
	testb	%al, %al
	setg	%cl
	setns	%dl
	setle	%sil
	shrb	$7, %al
	shll	$24, %edx
	shll	$16, %ecx
	orl	%edx, %ecx
	shll	$8, %esi
	orl	%ecx, %esi
	movzbl	%al, %eax
	orl	%esi, %eax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end12:
	.size	leaf_fused, .Lfunc_end12-leaf_fused
	.cfi_endproc

	.section	.text.leaf_original,"ax",@progbits
	.globl	leaf_original
	.prefalign	4, .Lfunc_end13, nop
	.type	leaf_original,@function
leaf_original:
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
	movq	%rsi, %rbx
	movq	%rdi, %r14
	movq	(%rdi), %rdi
	movq	8(%r14), %rax
	movq	(%rsi), %rsi
	movq	8(%rbx), %rdx
	movq	%rax, %r15
	subq	%rdx, %r15
	cmovbq	%rax, %rdx
	callq	*memcmp@GOTPCREL(%rip)
	cltq
	testl	%eax, %eax
	cmovneq	%rax, %r15
	movq	%r15, %rdi
	shrq	$63, %rdi
	movq	16(%r14), %r8
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	xorl	%esi, %esi
	xorl	%edx, %edx
	cmpq	16(%rbx), %r8
	setbe	%al
	seta	%sil
	setb	%cl
	setae	%dl
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	xorl	%r10d, %r10d
	testq	%r15, %r15
	cmovnel	%edi, %ecx
	setle	%r8b
	cmovnel	%r8d, %eax
	setg	%r9b
	cmovnel	%r9d, %esi
	setns	%r10b
	cmovnel	%r10d, %edx
	shll	$24, %edx
	movzbl	%sil, %esi
	shll	$16, %esi
	orl	%edx, %esi
	movzbl	%al, %eax
	shll	$8, %eax
	orl	%esi, %eax
	orl	%ecx, %eax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end13:
	.size	leaf_original, .Lfunc_end13-leaf_original
	.cfi_endproc

	.section	.text.leaf_two,"ax",@progbits
	.globl	leaf_two
	.prefalign	4, .Lfunc_end14, nop
	.type	leaf_two,@function
leaf_two:
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
	movq	%rsi, %rbx
	movq	%rdi, %r14
	movq	(%rdi), %rdi
	movq	8(%r14), %rax
	movq	(%rsi), %rsi
	movq	8(%rbx), %rdx
	movq	%rax, %r15
	subq	%rdx, %r15
	cmovbq	%rax, %rdx
	callq	*memcmp@GOTPCREL(%rip)
	cltq
	testl	%eax, %eax
	cmovneq	%rax, %r15
	movq	%r15, %rax
	shrq	$63, %rax
	movq	16(%r14), %rcx
	xorl	%edx, %edx
	xorl	%esi, %esi
	cmpq	16(%rbx), %rcx
	setb	%dl
	seta	%sil
	xorl	%ecx, %ecx
	testq	%r15, %r15
	cmovnel	%eax, %edx
	setg	%cl
	cmovnel	%ecx, %esi
	movzbl	%dl, %ecx
	xorb	$1, %dl
	movzbl	%dl, %eax
	shll	$24, %eax
	movzbl	%sil, %edx
	movl	%edx, %esi
	shll	$16, %esi
	orl	%eax, %esi
	xorb	$1, %dl
	movzbl	%dl, %eax
	shll	$8, %eax
	orl	%esi, %eax
	orl	%ecx, %eax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end14:
	.size	leaf_two, .Lfunc_end14-leaf_two
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
	leaq	_RNvCsM3pabHJvao_4leaf4main(%rip), %rax
	movq	%rax, (%rsp)
	leaq	.Lvtable.1(%rip), %rsi
	movq	%rsp, %rdi
	xorl	%r8d, %r8d
	callq	*_RNvNtCs9wefJfwQbYy_3std2rt19lang_start_internal@GOTPCREL(%rip)
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
	.asciz	"\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\001\000\000\000\000\000\000"
	.quad	_RNvXsc_NtNtCs6knCYbIatyh_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
	.size	.Lvtable.0, 32

	.type	.Lvtable.1,@object
	.section	.data.rel.ro..Lvtable.1,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.1:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNSNvYNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceuE9call_once6vtableCsM3pabHJvao_4leaf
	.quad	_RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0CsM3pabHJvao_4leaf
	.quad	_RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0CsM3pabHJvao_4leaf
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
	.quad	.Lalloc_1a68d4663d1c50d6d88d465b9d973c09
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
	.quad	.Lalloc_1a68d4663d1c50d6d88d465b9d973c09
	.asciz	"&\000\000\000\000\000\000\000\002\000\000\000O\000\000"
	.size	.Lalloc_05c202032256fef92c612b00fee0bc15, 24

	.type	.Lvtable.2,@object
	.section	.data.rel.ro..Lvtable.2,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.2:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf
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

	.type	.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf,"a",@progbits
	.p2align	3, 0x0
.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf:
	.ascii	"\005\f\013\013\004\016"
	.size	.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf, 6

	.type	.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel,"a",@progbits
	.p2align	2, 0x0
.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel:
	.long	.Lalloc_59ba7b9f7211443cd55a366616eef46a-.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel
	.long	.Lalloc_00315c78e51d29fe6b3102a4c1ecf6ef-.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel
	.long	.Lalloc_bd3a3f3879e0d5f64554753e977f58d4-.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel
	.long	.Lalloc_0964bb2a4870637395c77a018495bd5c-.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel
	.long	.Lalloc_6566120a3a17f930e960a0863fcbd591-.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel
	.long	.Lalloc_6c17bac0c71cba42380f8445f4dcbd16-.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel
	.size	.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.27.rel, 24

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
	.quad	_RNvCsbOwsw4zHH1Z_7___rustc19rust_eh_personality
	.ident	"rustc version 1.101.0-dev"
	.section	".note.GNU-stack","",@progbits
