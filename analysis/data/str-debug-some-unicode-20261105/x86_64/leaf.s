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
	leaq	.Lalloc_4bdb784eb229662729e2cb30c9370ef2(%rip), %r8
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
	subq	$136, %rsp
	.cfi_def_cfa_offset 192
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	leaq	80(%rsp), %rbx
	movq	%rbx, %rdi
	callq	*_RNvNtCs9wefJfwQbYy_3std3env4args@GOTPCREL(%rip)
.Ltmp0:
	leaq	16(%rsp), %rdi
	movq	%rbx, %rsi
	callq	*_RNvXse_NtCs9wefJfwQbYy_3std3envNtB5_4ArgsNtNtNtNtCs6knCYbIatyh_4core4iter6traits8iterator8Iterator4next@GOTPCREL(%rip)
.Ltmp1:
	movq	16(%rsp), %r14
	cmpq	$-1, %r14
	je	.LBB8_67
	movq	24(%rsp), %r15
	movq	104(%rsp), %rax
	subq	88(%rsp), %rax
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
	jmp	.LBB8_78
.LBB8_5:
	movq	32(%rsp), %rax
	testq	%rbx, %rbx
	je	.LBB8_8
	movq	%rax, 8(%rsp)
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$8, %r13d
	movl	$8, %esi
	movq	%rbx, %rdi
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc12___rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB8_4
	movq	%rax, %r12
	incq	%rbp
	movq	8(%rsp), %rax
	jmp	.LBB8_9
.LBB8_8:
	movl	$8, %r12d
	xorl	%ebp, %ebp
.LBB8_9:
	movq	%r14, (%r12)
	movq	%r15, 8(%r12)
	movq	%rax, 16(%r12)
	movq	%rbp, 112(%rsp)
	movq	%r12, 120(%rsp)
	movq	$1, 128(%rsp)
	movups	80(%rsp), %xmm0
	movups	96(%rsp), %xmm1
	movaps	%xmm1, 32(%rsp)
	movaps	%xmm0, 16(%rsp)
	movl	$1, %r14d
	movl	$40, %r13d
	leaq	16(%rsp), %rax
	movq	%rax, 8(%rsp)
	jmp	.LBB8_12
	.p2align	4
.LBB8_10:
	movq	120(%rsp), %r12
.LBB8_11:
	movq	%rbp, -16(%r12,%r13)
	movq	%rbx, -8(%r12,%r13)
	movq	%r15, (%r12,%r13)
	incq	%r14
	movq	%r14, 128(%rsp)
	addq	$24, %r13
.LBB8_12:
.Ltmp3:
	leaq	48(%rsp), %rdi
	leaq	16(%rsp), %rsi
	callq	*_RNvXse_NtCs9wefJfwQbYy_3std3envNtB5_4ArgsNtNtNtNtCs6knCYbIatyh_4core4iter6traits8iterator8Iterator4next@GOTPCREL(%rip)
.Ltmp4:
	movq	48(%rsp), %rbp
	cmpq	$-1, %rbp
	je	.LBB8_16
	movq	56(%rsp), %rbx
	movq	64(%rsp), %r15
	cmpq	112(%rsp), %r14
	jne	.LBB8_11
	movq	40(%rsp), %rdx
	subq	24(%rsp), %rdx
	shrq	$3, %rdx
	movabsq	$-6148914691236517205, %rax
	imulq	%rax, %rdx
	incq	%rdx
.Ltmp6:
	leaq	112(%rsp), %rdi
	movq	%r14, %rsi
	callq	_RINvNvMs5_NtCs4XhBu2GMSOm_5alloc7raw_vecINtB8_11RawVecInnerpE7reserve21do_reserve_and_handleNtNtBa_5alloc6GlobalECsM3pabHJvao_4leaf
.Ltmp7:
	jmp	.LBB8_10
.LBB8_16:
	movq	24(%rsp), %r14
	movq	40(%rsp), %rcx
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
	movq	32(%rsp), %rax
	testq	%rax, %rax
	je	.LBB8_23
	movq	16(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB8_23:
	movups	112(%rsp), %xmm0
	movaps	%xmm0, 48(%rsp)
	movq	128(%rsp), %r14
	movq	%r14, 64(%rsp)
	cmpq	$2, %r14
	jb	.LBB8_75
	movq	56(%rsp), %r15
	cmpq	$4, 40(%r15)
	jne	.LBB8_26
	movq	32(%r15), %rax
	cmpl	$2003790963, (%rax)
	leaq	slow(%rip), %rax
	leaq	fast(%rip), %rbx
	cmoveq	%rax, %rbx
	jmp	.LBB8_27
.LBB8_26:
	leaq	fast(%rip), %rbx
.LBB8_27:
	cmpq	$2, %r14
	je	.LBB8_76
	movq	56(%r15), %rcx
	movq	64(%r15), %rsi
	cmpq	$1, %rsi
	je	.LBB8_31
	testq	%rsi, %rsi
	je	.LBB8_79
	movzbl	(%rcx), %edx
	jmp	.LBB8_33
.LBB8_31:
	movzbl	(%rcx), %edx
	movb	$1, %al
	cmpl	$43, %edx
	je	.LBB8_61
	cmpl	$45, %edx
	je	.LBB8_61
.LBB8_33:
	xorl	%eax, %eax
	cmpb	$43, %dl
	sete	%al
	movq	%rsi, %rdx
	subq	%rax, %rdx
	addq	%rax, %rcx
	negq	%rax
	cmpq	$17, %rdx
	jae	.LBB8_38
	testq	%rdx, %rdx
	je	.LBB8_43
	addq	%rax, %rsi
	negq	%rsi
	xorl	%r12d, %r12d
	xorl	%eax, %eax
	.p2align	4
.LBB8_36:
	movzbl	(%rcx,%rax), %edx
	addl	$-48, %edx
	cmpl	$9, %edx
	ja	.LBB8_66
	leaq	(%r12,%r12,4), %rdi
	movl	%edx, %edx
	leaq	(%rdx,%rdi,2), %r12
	incq	%rax
	movq	%rsi, %rdx
	addq	%rax, %rdx
	jne	.LBB8_36
	jmp	.LBB8_44
.LBB8_38:
	addq	%rax, %rsi
	negq	%rsi
	xorl	%r12d, %r12d
	movl	$10, %edi
	xorl	%r8d, %r8d
	.p2align	4
.LBB8_39:
	movq	%r12, %rax
	mulq	%rdi
	movzbl	(%rcx,%r8), %edx
	jo	.LBB8_59
	addl	$-48, %edx
	cmpl	$10, %edx
	jae	.LBB8_66
	movq	%rax, %r12
	movl	%edx, %eax
	addq	%rax, %r12
	jb	.LBB8_60
	incq	%r8
	movq	%rsi, %rax
	addq	%r8, %rax
	jne	.LBB8_39
	jmp	.LBB8_44
.LBB8_43:
	xorl	%r12d, %r12d
.LBB8_44:
.Ltmp11:
	leaq	.Lalloc_0f55ccc5796de6140dfafcec783eada4(%rip), %rdi
	movl	$4, %esi
	callq	slow
.Ltmp12:
	movq	%rax, 16(%rsp)
	cmpq	$4, %rax
	jne	.LBB8_62
.Ltmp13:
	leaq	.Lalloc_0f55ccc5796de6140dfafcec783eada4(%rip), %r13
	movl	$4, %esi
	movq	%r13, %rdi
	callq	fast
.Ltmp14:
	movq	%rax, 16(%rsp)
	cmpq	$4, %rax
	jne	.LBB8_63
	movq	%r15, 8(%rsp)
	testq	%r12, %r12
	je	.LBB8_52
	leaq	16(%rsp), %rbp
	leaq	80(%rsp), %r15
	.p2align	4
.LBB8_50:
	movq	%r13, 16(%rsp)
	movq	$4, 24(%rsp)
	#APP
	#NO_APP
	movq	16(%rsp), %rdi
	movq	24(%rsp), %rsi
.Ltmp17:
	callq	*%rbx
.Ltmp18:
	movq	%rax, 80(%rsp)
	#APP
	#NO_APP
	decq	%r12
	jne	.LBB8_50
.LBB8_52:
	movq	8(%rsp), %r12
	leaq	8(%r12), %rbx
	movq	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r15
	jmp	.LBB8_54
	.p2align	4
.LBB8_53:
	addq	$24, %rbx
	decq	%r14
	je	.LBB8_56
.LBB8_54:
	movq	-8(%rbx), %rsi
	testq	%rsi, %rsi
	je	.LBB8_53
	movq	(%rbx), %rdi
	movl	$1, %edx
	callq	*%r15
	jmp	.LBB8_53
.LBB8_56:
	movq	48(%rsp), %rax
	testq	%rax, %rax
	je	.LBB8_58
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	movq	%r12, %rdi
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB8_58:
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
.LBB8_59:
	.cfi_def_cfa_offset 192
	addb	$-48, %dl
	xorl	%eax, %eax
	cmpb	$10, %dl
	adcb	$1, %al
	jmp	.LBB8_61
.LBB8_60:
	movb	$2, %al
.LBB8_61:
.Ltmp9:
	movzbl	%al, %edi
	callq	_RINvNtCs6knCYbIatyh_4core6result13unwrap_failedNtNtNtB4_3num5error13ParseIntErrorECsM3pabHJvao_4leaf
.Ltmp10:
	jmp	.LBB8_78
.LBB8_62:
	leaq	.Lalloc_4014284bd8c57ea959725918594e45ac(%rip), %r9
	jmp	.LBB8_64
.LBB8_63:
	leaq	.Lalloc_b3b266528be359e4a0db3dc7da84a07e(%rip), %r9
.LBB8_64:
.Ltmp15:
	leaq	.Lalloc_ee2a3d99accaa3cec7cc99bf20f81916(%rip), %rdx
	xorl	%edi, %edi
	movq	8(%rsp), %rsi
	xorl	%ecx, %ecx
	callq	*_RINvNtCs6knCYbIatyh_4core9panicking13assert_failedjjEB4_@GOTPCREL(%rip)
.Ltmp16:
	jmp	.LBB8_78
.LBB8_66:
	movb	$1, %al
	jmp	.LBB8_61
.LBB8_67:
	movq	88(%rsp), %r14
	movq	104(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r14, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	movq	$0, 48(%rsp)
	movq	$8, 56(%rsp)
	movq	$0, 64(%rsp)
	cmpq	%r14, %rcx
	jne	.LBB8_71
.LBB8_68:
	movq	96(%rsp), %rax
	testq	%rax, %rax
	je	.LBB8_70
	movq	80(%rsp), %rdi
	shlq	$3, %rax
	leaq	(%rax,%rax,2), %rsi
	movl	$8, %edx
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB8_70:
	leaq	.Lalloc_0dd3479570b32f59538d76287f051d43(%rip), %rdx
	movl	$1, %edi
	xorl	%r14d, %r14d
	jmp	.LBB8_77
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
	je	.LBB8_68
.LBB8_73:
	movq	-8(%r14), %rsi
	testq	%rsi, %rsi
	je	.LBB8_72
	movq	(%r14), %rdi
	movl	$1, %edx
	callq	*%r15
	jmp	.LBB8_72
.LBB8_75:
	leaq	.Lalloc_0dd3479570b32f59538d76287f051d43(%rip), %rdx
	movl	$1, %edi
	jmp	.LBB8_77
.LBB8_76:
	leaq	.Lalloc_5acfb0f90745456c7a1384ae2e47aa0d(%rip), %rdx
	movl	$2, %edi
	movl	$2, %r14d
.LBB8_77:
.Ltmp23:
	movq	%r14, %rsi
	callq	*_RNvNtCs6knCYbIatyh_4core9panicking18panic_bounds_check@GOTPCREL(%rip)
.Ltmp24:
.LBB8_78:
	ud2
.LBB8_79:
	xorl	%eax, %eax
	jmp	.LBB8_61
.LBB8_80:
.Ltmp2:
	movq	%rax, %r12
	jmp	.LBB8_91
.LBB8_81:
.Ltmp8:
	movq	%rax, %r12
	testq	%rbp, %rbp
	je	.LBB8_85
	movl	$1, %edx
	movq	%rbx, %rdi
	movq	%rbp, %rsi
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
	jmp	.LBB8_85
.LBB8_83:
.Ltmp19:
	jmp	.LBB8_87
.LBB8_84:
.Ltmp5:
	movq	%rax, %r12
.LBB8_85:
	leaq	16(%rsp), %rdi
	callq	_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueNtNtCs9wefJfwQbYy_3std3env4ArgsECsM3pabHJvao_4leaf
	leaq	112(%rsp), %rdi
	callq	_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueINtNtCs4XhBu2GMSOm_5alloc3vec3VecNtNtBG_6string6StringEECsM3pabHJvao_4leaf
	movq	%r12, %rdi
	callq	_Unwind_Resume@PLT
.LBB8_86:
.Ltmp25:
.LBB8_87:
	movq	%rax, %r12
	leaq	48(%rsp), %rdi
	callq	_RINvNtCs6knCYbIatyh_4core3ptr9drop_glueINtNtCs4XhBu2GMSOm_5alloc3vec3VecNtNtBG_6string6StringEECsM3pabHJvao_4leaf
	movq	%r12, %rdi
	callq	_Unwind_Resume@PLT
.LBB8_89:
.Ltmp22:
	movq	%rax, %r12
	testq	%r14, %r14
	je	.LBB8_91
	movl	$1, %edx
	movq	%r15, %rdi
	movq	%r14, %rsi
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB8_91:
	movq	88(%rsp), %r14
	movq	104(%rsp), %rcx
	movq	%rcx, %rax
	subq	%r14, %rax
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	cmpq	%r14, %rcx
	jne	.LBB8_94
.LBB8_92:
	movq	96(%rsp), %rax
	testq	%rax, %rax
	jne	.LBB8_98
	movq	%r12, %rdi
	callq	_Unwind_Resume@PLT
.LBB8_94:
	movq	%rdx, %rbx
	shrq	$4, %rbx
	addq	$8, %r14
	movq	_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip), %r15
	jmp	.LBB8_96
	.p2align	4
.LBB8_95:
	addq	$24, %r14
	decq	%rbx
	je	.LBB8_92
.LBB8_96:
	movq	-8(%r14), %rsi
	testq	%rsi, %rsi
	je	.LBB8_95
	movq	(%r14), %rdi
	movl	$1, %edx
	callq	*%r15
	jmp	.LBB8_95
.LBB8_98:
	movq	80(%rsp), %rdi
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
	.uleb128 .Ltmp14-.Ltmp11
	.uleb128 .Ltmp25-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp17-.Lfunc_begin0
	.uleb128 .Ltmp18-.Ltmp17
	.uleb128 .Ltmp19-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp18-.Lfunc_begin0
	.uleb128 .Ltmp9-.Ltmp18
	.byte	0
	.byte	0
	.uleb128 .Ltmp9-.Lfunc_begin0
	.uleb128 .Ltmp16-.Ltmp9
	.uleb128 .Ltmp25-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp16-.Lfunc_begin0
	.uleb128 .Ltmp23-.Ltmp16
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

	.section	.text._RNvMNtNtCs6knCYbIatyh_4core4char7methodsc11is_assigned,"ax",@progbits
	.prefalign	4, .Lfunc_end9, nop
	.type	_RNvMNtNtCs6knCYbIatyh_4core4char7methodsc11is_assigned,@function
_RNvMNtNtCs6knCYbIatyh_4core4char7methodsc11is_assigned:
	.cfi_startproc
	movb	$1, %al
	cmpl	$888, %edi
	jae	.LBB9_1
.LBB9_4:
	retq
.LBB9_1:
	cmpl	$262142, %edi
	jae	.LBB9_2
	pushq	%rax
	.cfi_def_cfa_offset 16
	callq	*_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data13cn_planes_0_311lookup_slow@GOTPCREL(%rip)
	xorb	$1, %al
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	retq
.LBB9_2:
	cmpl	$917505, %edi
	sete	%cl
	leal	-917536(%rdi), %edx
	cmpl	$96, %edx
	setb	%dl
	leal	-917760(%rdi), %esi
	cmpl	$240, %esi
	setb	%sil
	orb	%dl, %sil
	leal	-983040(%rdi), %edx
	cmpl	$65534, %edx
	setb	%dl
	orb	%cl, %dl
	orb	%sil, %dl
	jne	.LBB9_4
	addl	$-1048576, %edi
	cmpl	$65534, %edi
	setb	%al
	retq
.Lfunc_end9:
	.size	_RNvMNtNtCs6knCYbIatyh_4core4char7methodsc11is_assigned, .Lfunc_end9-_RNvMNtNtCs6knCYbIatyh_4core4char7methodsc11is_assigned
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI10_0:
	.long	0
	.long	4294967169
	.long	4294909952
	.long	4293984256
.LCPI10_1:
	.long	2147483648
	.long	2147483648
	.long	2147483648
	.long	2147483648
.LCPI10_2:
	.long	2147483679
	.long	2147483680
	.long	2147490047
	.long	2147549181
	.section	.text._RNvMNtNtCs6knCYbIatyh_4core4char7methodsc16escape_debug_ext,"ax",@progbits
	.prefalign	4, .Lfunc_end10, nop
	.type	_RNvMNtNtCs6knCYbIatyh_4core4char7methodsc16escape_debug_ext,@function
_RNvMNtNtCs6knCYbIatyh_4core4char7methodsc16escape_debug_ext:
	.cfi_startproc
	cmpl	$39, %esi
	ja	.LBB10_1
	movl	%esi, %eax
	leaq	.LJTI10_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB10_8:
	movw	$12380, (%rdi)
	jmp	.LBB10_10
.LBB10_1:
	cmpl	$92, %esi
	jne	.LBB10_2
	movw	$23644, (%rdi)
	jmp	.LBB10_10
.LBB10_2:
	leal	-32(%rsi), %eax
	cmpl	$95, %eax
	setb	%al
	movl	%esi, %ecx
	andl	$2097150, %ecx
	cmpl	$65438, %ecx
	sete	%cl
	orb	%al, %cl
	je	.LBB10_13
	movl	%esi, (%rdi)
	movb	$-127, %cl
	movb	$-128, %al
	movb	%al, 12(%rdi)
	movb	%cl, 13(%rdi)
	retq
.LBB10_5:
	movw	$28252, (%rdi)
	jmp	.LBB10_10
.LBB10_12:
	movw	$10076, (%rdi)
	jmp	.LBB10_10
.LBB10_7:
	movw	$29276, (%rdi)
	jmp	.LBB10_10
.LBB10_6:
	movw	$29788, (%rdi)
	jmp	.LBB10_10
.LBB10_9:
	movw	$8796, (%rdi)
.LBB10_10:
	movq	$0, 2(%rdi)
	movb	$2, %cl
	xorl	%eax, %eax
	movb	%al, 12(%rdi)
	movb	%cl, 13(%rdi)
	retq
.LBB10_13:
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movd	%esi, %xmm0
	pshufd	$0, %xmm0, %xmm0
	paddd	.LCPI10_0(%rip), %xmm0
	pxor	.LCPI10_1(%rip), %xmm0
	pcmpgtd	.LCPI10_2(%rip), %xmm0
	movmskps	%xmm0, %eax
	cmpl	$15, %eax
	jne	.LBB10_19
	leal	-1048576(%rsi), %eax
	cmpl	$65534, %eax
	setb	%al
	cmpl	$32, %esi
	sete	%cl
	orb	%al, %cl
	jne	.LBB10_19
	cmpl	$133, %esi
	jae	.LBB10_16
.LBB10_23:
	movq	%rdi, %rbx
	movl	%esi, %edi
	movq	%rsi, %r14
	callq	_RNvMNtNtCs6knCYbIatyh_4core4char7methodsc11is_assigned
	movq	%r14, %rsi
	movq	%rbx, %rdi
	testb	%al, %al
	je	.LBB10_19
	movl	%esi, (%rdi)
	movb	$-127, %cl
	movb	$-128, %al
	jmp	.LBB10_25
.LBB10_16:
	movq	%rdi, %rbx
	movl	%esi, %edi
	movq	%rsi, %r14
	callq	_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data11white_space6lookup
	movq	%r14, %rsi
	movq	%rbx, %rdi
	testb	%al, %al
	je	.LBB10_17
.LBB10_19:
	movl	%esi, %eax
	orl	$1, %eax
	bsrl	%eax, %ecx
	xorl	$28, %ecx
	shrl	$2, %ecx
	leaq	-2(%rcx), %rax
	movb	$0, 16(%rsp)
	movw	$0, 14(%rsp)
	movl	%esi, %r8d
	shrl	$20, %r8d
	leaq	.Lanon.2121b0a86c24a5491334779946a88646.0(%rip), %rdx
	movzbl	(%r8,%rdx), %r8d
	movb	%r8b, 17(%rsp)
	movl	%esi, %r8d
	shrl	$16, %r8d
	andl	$15, %r8d
	movzbl	(%r8,%rdx), %r8d
	movb	%r8b, 18(%rsp)
	movl	%esi, %r8d
	shrl	$12, %r8d
	andl	$15, %r8d
	movzbl	(%r8,%rdx), %r8d
	movb	%r8b, 19(%rsp)
	movl	%esi, %r8d
	shrl	$8, %r8d
	andl	$15, %r8d
	movzbl	(%r8,%rdx), %r8d
	movb	%r8b, 20(%rsp)
	movl	%esi, %r8d
	shrl	$4, %r8d
	andl	$15, %r8d
	movzbl	(%r8,%rdx), %r8d
	movb	%r8b, 21(%rsp)
	andl	$15, %esi
	movzbl	(%rsi,%rdx), %edx
	movb	%dl, 22(%rsp)
	movb	$125, 23(%rsp)
	movw	$30044, 12(%rsp,%rcx)
	movb	$123, 14(%rsp,%rcx)
	movzwl	22(%rsp), %ecx
	movw	%cx, 8(%rdi)
	movq	14(%rsp), %rcx
	movq	%rcx, (%rdi)
	movb	$10, %cl
.LBB10_25:
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	.cfi_restore %rbx
	.cfi_restore %r14
	movb	%al, 12(%rdi)
	movb	%cl, 13(%rdi)
	retq
.LBB10_17:
	.cfi_def_cfa_offset 48
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	cmpl	$768, %esi
	jb	.LBB10_20
	movl	%esi, %edi
	callq	*_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data15grapheme_extend11lookup_slow@GOTPCREL(%rip)
	movq	%r14, %rsi
	movq	%rbx, %rdi
	testb	%al, %al
	jne	.LBB10_19
	jmp	.LBB10_21
.LBB10_20:
	cmpl	$173, %esi
	jb	.LBB10_23
.LBB10_21:
	movl	%esi, %edi
	callq	*_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data28default_ignorable_code_point11lookup_slow@GOTPCREL(%rip)
	movq	%r14, %rsi
	movq	%rbx, %rdi
	testb	%al, %al
	jne	.LBB10_19
	movl	%esi, %edi
	callq	*_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data2cf11lookup_slow@GOTPCREL(%rip)
	movq	%r14, %rsi
	movq	%rbx, %rdi
	testb	%al, %al
	je	.LBB10_23
	jmp	.LBB10_19
.Lfunc_end10:
	.size	_RNvMNtNtCs6knCYbIatyh_4core4char7methodsc16escape_debug_ext, .Lfunc_end10-_RNvMNtNtCs6knCYbIatyh_4core4char7methodsc16escape_debug_ext
	.cfi_endproc
	.section	.rodata._RNvMNtNtCs6knCYbIatyh_4core4char7methodsc16escape_debug_ext,"a",@progbits
	.p2align	2, 0x0
.LJTI10_0:
	.long	.LBB10_8-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_6-.LJTI10_0
	.long	.LBB10_5-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_7-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_9-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_2-.LJTI10_0
	.long	.LBB10_12-.LJTI10_0

	.section	.text.unlikely._RNvMs8_NtCs4XhBu2GMSOm_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsM3pabHJvao_4leaf,"ax",@progbits
	.prefalign	4, .Lfunc_end11, nop
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
	jbe	.LBB11_2
	movl	$8, %eax
	xorl	%r14d, %r14d
	jmp	.LBB11_10
.LBB11_2:
	shlq	$3, %rcx
	leaq	(%rcx,%rcx,2), %r14
	testq	%rsi, %rsi
	je	.LBB11_4
	shlq	$3, %rsi
	leaq	(%rsi,%rsi,2), %rsi
	movq	%rdx, %rdi
	movl	$8, %edx
	movq	%r14, %rcx
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_realloc@GOTPCREL(%rip)
	testq	%rax, %rax
	jne	.LBB11_6
	jmp	.LBB11_9
.LBB11_4:
	testq	%r14, %r14
	je	.LBB11_5
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$8, %esi
	movq	%r14, %rdi
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc12___rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	jne	.LBB11_6
.LBB11_9:
	movq	$8, 8(%rbx)
	movl	$16, %eax
	jmp	.LBB11_10
.LBB11_5:
	movl	$8, %eax
.LBB11_6:
	movq	%rax, 8(%rbx)
	movl	$16, %eax
	xorl	%r15d, %r15d
.LBB11_10:
	movq	%r14, (%rbx,%rax)
	movq	%r15, (%rbx)
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end11:
	.size	_RNvMs8_NtCs4XhBu2GMSOm_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsM3pabHJvao_4leaf, .Lfunc_end11-_RNvMs8_NtCs4XhBu2GMSOm_5alloc7raw_vecNtB5_11RawVecInner11finish_growCsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text._RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data11white_space6lookup,"ax",@progbits
	.prefalign	4, .Lfunc_end12, nop
	.type	_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data11white_space6lookup,@function
_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data11white_space6lookup:
	.cfi_startproc
	movl	%edi, %ecx
	shrl	$8, %ecx
	xorl	%eax, %eax
	cmpl	$31, %ecx
	jg	.LBB12_4
	testl	%ecx, %ecx
	je	.LBB12_7
	cmpl	$22, %ecx
	jne	.LBB12_8
	cmpl	$5760, %edi
	sete	%al
	andb	$1, %al
	retq
.LBB12_4:
	cmpl	$32, %ecx
	je	.LBB12_9
	cmpl	$48, %ecx
	jne	.LBB12_8
	cmpl	$12288, %edi
	sete	%al
	andb	$1, %al
	retq
.LBB12_7:
	movzbl	%dil, %eax
	movq	_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data11white_space14WHITESPACE_MAP@GOTPCREL(%rip), %rcx
	movzbl	(%rcx,%rax), %eax
.LBB12_8:
	andb	$1, %al
	retq
.LBB12_9:
	movzbl	%dil, %eax
	movq	_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data11white_space14WHITESPACE_MAP@GOTPCREL(%rip), %rcx
	movzbl	(%rcx,%rax), %eax
	shrb	%al
	andb	$1, %al
	retq
.Lfunc_end12:
	.size	_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data11white_space6lookup, .Lfunc_end12-_RNvNtNtNtCs6knCYbIatyh_4core7unicode12unicode_data11white_space6lookup
	.cfi_endproc

	.section	.text._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf,"ax",@progbits
	.prefalign	4, .Lfunc_end13, nop
	.type	_RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf,@function
_RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf:
	.cfi_startproc
	movq	%rsi, %rax
	movq	(%rdi), %rcx
	movzbl	(%rcx), %ecx
	leaq	.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf(%rip), %rdx
	movzbl	(%rcx,%rdx), %edx
	leaq	.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel(%rip), %rdi
	movslq	(%rdi,%rcx,4), %rsi
	addq	%rdi, %rsi
	movq	%rax, %rdi
	jmpq	*_RNvMsa_NtCs6knCYbIatyh_4core3fmtNtB5_9Formatter9write_str@GOTPCREL(%rip)
.Lfunc_end13:
	.size	_RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf, .Lfunc_end13-_RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf
	.cfi_endproc

	.section	.text._RNvXsc_NtNtCs6knCYbIatyh_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt,"ax",@progbits
	.prefalign	4, .Lfunc_end14, nop
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
.Lfunc_end14:
	.size	_RNvXsc_NtNtCs6knCYbIatyh_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt, .Lfunc_end14-_RNvXsc_NtNtCs6knCYbIatyh_4core3num5errorNtB5_13ParseIntErrorNtNtB9_3fmt5Debug3fmt
	.cfi_endproc

	.section	.text.fast,"ax",@progbits
	.globl	fast
	.prefalign	4, .Lfunc_end15, nop
	.type	fast,@function
fast:
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
	subq	$32, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdi, (%rsp)
	movq	%rsi, 8(%rsp)
	movq	%rsp, %rax
	#APP
	#NO_APP
	movq	8(%rsp), %r15
	testq	%r15, %r15
	je	.LBB15_1
	movq	(%rsp), %r12
	xorl	%ebx, %ebx
	leaq	16(%rsp), %r14
	xorl	%r13d, %r13d
	jmp	.LBB15_3
	.p2align	4
.LBB15_5:
	addq	%rax, %rbx
	incq	%r13
	cmpq	%r13, %r15
	je	.LBB15_6
.LBB15_3:
	movl	(%r12,%r13,4), %esi
	leal	-161(%rsi), %eax
	cmpl	$607, %eax
	setb	%cl
	cmpl	$173, %esi
	setne	%dl
	movl	$1, %eax
	testb	%cl, %dl
	jne	.LBB15_5
	movq	%r14, %rdi
	callq	_RNvMNtNtCs6knCYbIatyh_4core4char7methodsc16escape_debug_ext
	movzbl	29(%rsp), %eax
	subb	28(%rsp), %al
	movzbl	%al, %eax
	jmp	.LBB15_5
.LBB15_1:
	xorl	%ebx, %ebx
.LBB15_6:
	movq	%rbx, %rax
	addq	$32, %rsp
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
.Lfunc_end15:
	.size	fast, .Lfunc_end15-fast
	.cfi_endproc

	.section	.text.slow,"ax",@progbits
	.globl	slow
	.prefalign	4, .Lfunc_end16, nop
	.type	slow,@function
slow:
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
	subq	$32, %rsp
	.cfi_def_cfa_offset 80
	.cfi_offset %rbx, -48
	.cfi_offset %r12, -40
	.cfi_offset %r13, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	%rdi, (%rsp)
	movq	%rsi, 8(%rsp)
	movq	%rsp, %rax
	#APP
	#NO_APP
	movq	8(%rsp), %r15
	testq	%r15, %r15
	je	.LBB16_1
	movq	(%rsp), %r12
	xorl	%ebx, %ebx
	leaq	16(%rsp), %r14
	xorl	%r13d, %r13d
	.p2align	4
.LBB16_3:
	movl	(%r12,%r13,4), %esi
	movq	%r14, %rdi
	callq	_RNvMNtNtCs6knCYbIatyh_4core4char7methodsc16escape_debug_ext
	movzbl	29(%rsp), %eax
	subb	28(%rsp), %al
	movzbl	%al, %eax
	addq	%rax, %rbx
	incq	%r13
	cmpq	%r13, %r15
	jne	.LBB16_3
	jmp	.LBB16_4
.LBB16_1:
	xorl	%ebx, %ebx
.LBB16_4:
	movq	%rbx, %rax
	addq	$32, %rsp
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
.Lfunc_end16:
	.size	slow, .Lfunc_end16-slow
	.cfi_endproc

	.section	.text.main,"ax",@progbits
	.globl	main
	.prefalign	4, .Lfunc_end17, nop
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
.Lfunc_end17:
	.size	main, .Lfunc_end17-main
	.cfi_endproc

	.type	.Lanon.2121b0a86c24a5491334779946a88646.0,@object
	.section	.rodata.cst16,"aM",@progbits,16
.Lanon.2121b0a86c24a5491334779946a88646.0:
	.ascii	"0123456789abcdef"
	.size	.Lanon.2121b0a86c24a5491334779946a88646.0, 16

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

	.type	.Lalloc_21d75c3d867f14d7573b954b2f1f66cf,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_21d75c3d867f14d7573b954b2f1f66cf:
	.asciz	"/tmp/str-debug-some-unicode-20261105/leaf.rs"
	.size	.Lalloc_21d75c3d867f14d7573b954b2f1f66cf, 45

	.type	.Lalloc_0dd3479570b32f59538d76287f051d43,@object
	.section	.data.rel.ro..Lalloc_0dd3479570b32f59538d76287f051d43,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_0dd3479570b32f59538d76287f051d43:
	.quad	.Lalloc_21d75c3d867f14d7573b954b2f1f66cf
	.asciz	",\000\000\000\000\000\000\000\n\000\000\000G\000\000"
	.size	.Lalloc_0dd3479570b32f59538d76287f051d43, 24

	.type	.Lalloc_5acfb0f90745456c7a1384ae2e47aa0d,@object
	.section	.data.rel.ro..Lalloc_5acfb0f90745456c7a1384ae2e47aa0d,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_5acfb0f90745456c7a1384ae2e47aa0d:
	.quad	.Lalloc_21d75c3d867f14d7573b954b2f1f66cf
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
	.quad	.Lalloc_21d75c3d867f14d7573b954b2f1f66cf
	.asciz	",\000\000\000\000\000\000\000\013\000\000\000\032\000\000"
	.size	.Lalloc_b3b266528be359e4a0db3dc7da84a07e, 24

	.type	.Lalloc_4014284bd8c57ea959725918594e45ac,@object
	.section	.data.rel.ro..Lalloc_4014284bd8c57ea959725918594e45ac,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_4014284bd8c57ea959725918594e45ac:
	.quad	.Lalloc_21d75c3d867f14d7573b954b2f1f66cf
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
	.quad	.Lalloc_21d75c3d867f14d7573b954b2f1f66cf
	.asciz	",\000\000\000\000\000\000\000\n\000\000\000\177\000\000"
	.size	.Lalloc_4bdb784eb229662729e2cb30c9370ef2, 24

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

	.type	.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel,@object
	.section	.rodata..Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel,"a",@progbits
	.p2align	2, 0x0
.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel:
	.long	.Lalloc_59ba7b9f7211443cd55a366616eef46a-.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel
	.long	.Lalloc_00315c78e51d29fe6b3102a4c1ecf6ef-.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel
	.long	.Lalloc_bd3a3f3879e0d5f64554753e977f58d4-.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel
	.long	.Lalloc_0964bb2a4870637395c77a018495bd5c-.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel
	.long	.Lalloc_6566120a3a17f930e960a0863fcbd591-.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel
	.long	.Lalloc_6c17bac0c71cba42380f8445f4dcbd16-.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel
	.size	.Lswitch.table._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRNtNtNtB8_3num5error12IntErrorKindNtB6_5Debug3fmtCsM3pabHJvao_4leaf.36.rel, 24

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
