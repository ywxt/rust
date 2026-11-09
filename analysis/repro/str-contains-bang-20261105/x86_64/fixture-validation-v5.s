	.att_syntax
	.file	"fixture_validation_v5.acb4d8862b449710-cgu.0"
	.section	.text.unlikely._RINvNtCs6knCYbIatyh_4core9panicking13assert_failedbbECsePjmmjAuPjU_21fixture_validation_v5,"ax",@progbits
	.type	_RINvNtCs6knCYbIatyh_4core9panicking13assert_failedbbECsePjmmjAuPjU_21fixture_validation_v5,@function
_RINvNtCs6knCYbIatyh_4core9panicking13assert_failedbbECsePjmmjAuPjU_21fixture_validation_v5:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rdx, %rax
	leaq	8(%rsp), %rdx
	movq	%rdi, (%rdx)
	leaq	16(%rsp), %rcx
	movq	%rsi, (%rcx)
	leaq	.Lalloc_53a422af544a63c45be84e3f0c0221d4(%rip), %r10
	leaq	.Lvtable.2(%rip), %r8
	leaq	.Lalloc_150cf9fb508c258c80b6a996910db8f9(%rip), %r9
	xorl	%edi, %edi
	movq	%rdx, %rsi
	movq	%r8, %rdx
	pushq	%r10
	.cfi_adjust_cfa_offset 8
	pushq	%rax
	.cfi_adjust_cfa_offset 8
	callq	*_RNvNtCs6knCYbIatyh_4core9panicking19assert_failed_inner@GOTPCREL(%rip)
.Lfunc_end0:
	.size	_RINvNtCs6knCYbIatyh_4core9panicking13assert_failedbbECsePjmmjAuPjU_21fixture_validation_v5, .Lfunc_end0-_RINvNtCs6knCYbIatyh_4core9panicking13assert_failedbbECsePjmmjAuPjU_21fixture_validation_v5
	.cfi_endproc

	.section	.text._RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECsePjmmjAuPjU_21fixture_validation_v5,"ax",@progbits
	.hidden	_RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECsePjmmjAuPjU_21fixture_validation_v5
	.globl	_RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECsePjmmjAuPjU_21fixture_validation_v5
	.prefalign	4, .Lfunc_end1, nop
	.type	_RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECsePjmmjAuPjU_21fixture_validation_v5,@function
_RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECsePjmmjAuPjU_21fixture_validation_v5:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	%ecx, %r8d
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rdi, (%rsp)
	leaq	.Lvtable.3(%rip), %rsi
	movq	%rsp, %rdi
	callq	*_RNvNtCs9wefJfwQbYy_3std2rt19lang_start_internal@GOTPCREL(%rip)
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	_RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECsePjmmjAuPjU_21fixture_validation_v5, .Lfunc_end1-_RINvNtCs9wefJfwQbYy_3std2rt10lang_startuECsePjmmjAuPjU_21fixture_validation_v5
	.cfi_endproc

	.section	.text._RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsePjmmjAuPjU_21fixture_validation_v5,"ax",@progbits
	.prefalign	4, .Lfunc_end2, nop
	.type	_RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsePjmmjAuPjU_21fixture_validation_v5,@function
_RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsePjmmjAuPjU_21fixture_validation_v5:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	callq	*%rdi
	#APP
	#NO_APP
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	_RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsePjmmjAuPjU_21fixture_validation_v5, .Lfunc_end2-_RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsePjmmjAuPjU_21fixture_validation_v5
	.cfi_endproc

	.section	.text._RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0CsePjmmjAuPjU_21fixture_validation_v5,"ax",@progbits
	.prefalign	4, .Lfunc_end3, nop
	.type	_RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0CsePjmmjAuPjU_21fixture_validation_v5,@function
_RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0CsePjmmjAuPjU_21fixture_validation_v5:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	(%rdi), %rdi
	callq	_RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsePjmmjAuPjU_21fixture_validation_v5
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end3:
	.size	_RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0CsePjmmjAuPjU_21fixture_validation_v5, .Lfunc_end3-_RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0CsePjmmjAuPjU_21fixture_validation_v5
	.cfi_endproc

	.section	.text._RNSNvYNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceuE9call_once6vtableCsePjmmjAuPjU_21fixture_validation_v5,"ax",@progbits
	.prefalign	4, .Lfunc_end4, nop
	.type	_RNSNvYNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceuE9call_once6vtableCsePjmmjAuPjU_21fixture_validation_v5,@function
_RNSNvYNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceuE9call_once6vtableCsePjmmjAuPjU_21fixture_validation_v5:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	(%rdi), %rdi
	callq	_RINvNtNtCs9wefJfwQbYy_3std3sys9backtrace28___rust_begin_short_backtraceFEuuECsePjmmjAuPjU_21fixture_validation_v5
	xorl	%eax, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end4:
	.size	_RNSNvYNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceuE9call_once6vtableCsePjmmjAuPjU_21fixture_validation_v5, .Lfunc_end4-_RNSNvYNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceuE9call_once6vtableCsePjmmjAuPjU_21fixture_validation_v5
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI5_0:
	.zero	16,33
.LCPI5_1:
	.zero	16,63
.LCPI5_2:
	.byte	33
	.byte	33
	.byte	33
	.byte	33
	.byte	33
	.byte	33
	.byte	33
	.byte	33
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
.LCPI5_3:
	.byte	63
	.byte	63
	.byte	63
	.byte	63
	.byte	63
	.byte	63
	.byte	63
	.byte	63
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.zero	1
	.section	.text._RNvCsePjmmjAuPjU_21fixture_validation_v54main,"ax",@progbits
	.hidden	_RNvCsePjmmjAuPjU_21fixture_validation_v54main
	.globl	_RNvCsePjmmjAuPjU_21fixture_validation_v54main
	.prefalign	4, .Lfunc_end5, nop
	.type	_RNvCsePjmmjAuPjU_21fixture_validation_v54main,@function
_RNvCsePjmmjAuPjU_21fixture_validation_v54main:
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
	subq	$344, %rsp
	.cfi_def_cfa_offset 400
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movl	$0, 4(%rsp)
	leaq	248(%rsp), %rbp
	xorl	%eax, %eax
	leaq	.Lalloc_9ffac2c917cfb57d9cf2452c301d487a(%rip), %rcx
	leaq	_RNvXs1i_NtCs6knCYbIatyh_4core3fmtReNtB6_7Display3fmtCsePjmmjAuPjU_21fixture_validation_v5(%rip), %r12
	movq	_RNvCsbOwsw4zHH1Z_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip), %rdx
	movq	_RNvCsbOwsw4zHH1Z_7___rustc12___rust_alloc@GOTPCREL(%rip), %r13
.LBB5_1:
	movdqu	(%rax,%rcx), %xmm0
	movq	16(%rax,%rcx), %r15
	movq	24(%rax,%rcx), %rbx
	addq	$32, %rax
	movdqu	%xmm0, 328(%rsp)
	movq	%r15, 56(%rsp)
	movq	%rbx, 64(%rsp)
	testq	%rbx, %rbx
	js	.LBB5_2
	movq	%rax, 40(%rsp)
	je	.LBB5_5
	callq	*%rdx
	movl	$1, %r14d
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	*%r13
	testq	%rax, %rax
	je	.LBB5_3
	movq	%rax, %r13
	cmpq	$8, %rbx
	movdqa	.LCPI5_2(%rip), %xmm5
	movdqa	.LCPI5_3(%rip), %xmm6
	movdqa	.LCPI5_0(%rip), %xmm7
	movdqa	.LCPI5_1(%rip), %xmm8
	movl	$63, %edx
	jae	.LBB5_10
	xorl	%eax, %eax
	jmp	.LBB5_9
	.p2align	4
.LBB5_5:
	movl	$1, %r13d
	jmp	.LBB5_19
	.p2align	4
.LBB5_10:
	cmpq	$32, %rbx
	jae	.LBB5_12
	xorl	%eax, %eax
	jmp	.LBB5_16
.LBB5_12:
	movq	%rbx, %rax
	movabsq	$9223372036854775776, %rcx
	andq	%rcx, %rax
	xorl	%ecx, %ecx
	.p2align	4
.LBB5_13:
	movdqu	(%r15,%rcx), %xmm0
	movdqu	16(%r15,%rcx), %xmm1
	movdqa	%xmm0, %xmm2
	pcmpeqb	%xmm7, %xmm2
	movdqa	%xmm1, %xmm3
	pcmpeqb	%xmm7, %xmm3
	movdqa	%xmm2, %xmm4
	pandn	%xmm0, %xmm4
	pand	%xmm8, %xmm2
	por	%xmm4, %xmm2
	movdqa	%xmm3, %xmm0
	pandn	%xmm1, %xmm0
	pand	%xmm8, %xmm3
	por	%xmm0, %xmm3
	movdqu	%xmm2, (%r13,%rcx)
	movdqu	%xmm3, 16(%r13,%rcx)
	addq	$32, %rcx
	cmpq	%rcx, %rax
	jne	.LBB5_13
	cmpq	%rax, %rbx
	je	.LBB5_19
	testb	$24, %bl
	je	.LBB5_9
.LBB5_16:
	movq	%rax, %rcx
	movabsq	$9223372036854775776, %rax
	addq	$24, %rax
	andq	%rbx, %rax
	.p2align	4
.LBB5_17:
	movq	(%r15,%rcx), %xmm0
	movdqa	%xmm0, %xmm1
	pcmpeqb	%xmm5, %xmm1
	movdqa	%xmm1, %xmm2
	pandn	%xmm0, %xmm2
	pand	%xmm6, %xmm1
	por	%xmm2, %xmm1
	movq	%xmm1, (%r13,%rcx)
	addq	$8, %rcx
	cmpq	%rcx, %rax
	jne	.LBB5_17
	jmp	.LBB5_18
	.p2align	4
.LBB5_9:
	movzbl	(%r15,%rax), %ecx
	cmpb	$33, %cl
	cmovel	%edx, %ecx
	movb	%cl, (%r13,%rax)
	incq	%rax
.LBB5_18:
	cmpq	%rax, %rbx
	jne	.LBB5_9
.LBB5_19:
	leaq	56(%rsp), %rax
	movq	%rax, 232(%rsp)
	movq	%r12, 240(%rsp)
.Ltmp0:
	leaq	88(%rsp), %rdi
	leaq	.Lalloc_cee386583203eba970c996905b2bf2ce(%rip), %rsi
	leaq	232(%rsp), %rdx
	callq	*_RNvNvNtCs4XhBu2GMSOm_5alloc3fmt6format12format_inner@GOTPCREL(%rip)
.Ltmp1:
	movq	88(%rsp), %rax
	movq	%rax, 8(%rsp)
	movq	96(%rsp), %rcx
	movq	104(%rsp), %rax
	movdqu	56(%rsp), %xmm0
	movdqu	%xmm0, 248(%rsp)
	movq	%r13, 264(%rsp)
	movq	%rbx, 272(%rsp)
	movq	%rcx, 16(%rsp)
	movq	%rcx, 280(%rsp)
	movq	%rax, 288(%rsp)
	xorl	%edx, %edx
.LBB5_21:
	movq	%rdx, %rax
	shlq	$4, %rax
	movq	(%rbp,%rax), %r12
	movq	8(%rbp,%rax), %r15
	testq	%r15, %r15
	je	.LBB5_22
	leaq	-1(%r15), %rax
	xorl	%ecx, %ecx
	.p2align	4
.LBB5_28:
	cmpb	$33, (%r12,%rcx)
	sete	%bpl
	je	.LBB5_30
	cmpq	%rcx, %rax
	leaq	1(%rcx), %rcx
	jne	.LBB5_28
	jmp	.LBB5_30
	.p2align	4
.LBB5_22:
	xorl	%ebp, %ebp
.LBB5_30:
	incq	%rdx
	movq	%rdx, 48(%rsp)
	movb	%bpl, 2(%rsp)
	leaq	.Lalloc_0cc424b65dbf69defeb506189b6207fb(%rip), %rax
	movq	%rax, 104(%rsp)
	movq	$7, 112(%rsp)
	leaq	.Lalloc_f0a7980c19f39514de1d3cedf739be8d(%rip), %rax
	movq	%rax, 120(%rsp)
	movq	$8, 128(%rsp)
	leaq	.Lalloc_353fdcebd014da422cb0fcde7f6b373c(%rip), %rax
	movq	%rax, 136(%rsp)
	movq	$6, 144(%rsp)
	leaq	.Lalloc_9081d9a29e312f1c59877b6dc2556373(%rip), %rax
	movq	%rax, 152(%rsp)
	movq	$6, 160(%rsp)
	leaq	.Lalloc_1f44d2c439f55c05fc535af957b10048(%rip), %rax
	movq	%rax, 168(%rsp)
	movq	$6, 176(%rsp)
	leaq	.Lalloc_4c816276899216b5ccb686d3f7a9ee8f(%rip), %rax
	movq	%rax, 184(%rsp)
	movq	$9, 192(%rsp)
	leaq	.Lalloc_2124b3ec4808e9db578502928416a8e2(%rip), %rax
	movq	%rax, 200(%rsp)
	movq	$6, 208(%rsp)
	leaq	.Lalloc_98f8a1140d6b7d7b5798fefe2a07e477(%rip), %rax
	movq	%rax, 216(%rsp)
	movq	$9, 224(%rsp)
	xorl	%r14d, %r14d
.LBB5_31:
	movq	104(%rsp,%r14), %rax
	movq	112(%rsp,%r14), %rcx
	movq	%rax, 72(%rsp)
	movq	%rcx, 80(%rsp)
	addq	$-6, %rcx
	cmpq	$3, %rcx
	ja	.LBB5_50
	leaq	.LJTI5_0(%rip), %rdx
	movslq	(%rdx,%rcx,4), %rcx
	addq	%rdx, %rcx
	jmpq	*%rcx
.LBB5_44:
	movl	(%rax), %ecx
	movl	$1685221239, %edx
	xorl	%edx, %ecx
	movzwl	4(%rax), %edx
	xorl	$13873, %edx
	orl	%ecx, %edx
	leaq	_RNvCsePjmmjAuPjU_21fixture_validation_v56word16(%rip), %rcx
	je	.LBB5_53
	movl	(%rax), %ecx
	movl	$1684828006, %edx
	xorl	%edx, %ecx
	movzwl	4(%rax), %edx
	xorl	$13873, %edx
	orl	%ecx, %edx
	leaq	_RNvCsePjmmjAuPjU_21fixture_validation_v56fold16(%rip), %rcx
	je	.LBB5_53
	movl	(%rax), %ecx
	movl	$1684828006, %edx
	xorl	%edx, %ecx
	movzwl	4(%rax), %edx
	xorl	$13366, %edx
	orl	%ecx, %edx
	leaq	_RNvCsePjmmjAuPjU_21fixture_validation_v56fold64(%rip), %rcx
	je	.LBB5_53
	movl	(%rax), %ecx
	movl	$1684892019, %edx
	xorl	%edx, %ecx
	movzwl	4(%rax), %eax
	xorl	$13366, %eax
	orl	%ecx, %eax
	leaq	_RNvCsePjmmjAuPjU_21fixture_validation_v56simd64(%rip), %rcx
	je	.LBB5_53
	jmp	.LBB5_50
	.p2align	4
.LBB5_43:
	leaq	_RNvCsePjmmjAuPjU_21fixture_validation_v58std_char(%rip), %rcx
	movabsq	$8241983569076188275, %rdx
	cmpq	%rdx, (%rax)
	je	.LBB5_53
	jmp	.LBB5_50
	.p2align	4
.LBB5_48:
	movq	(%rax), %rcx
	movabsq	$3923601116770365283, %rdx
	xorq	%rdx, %rcx
	movzbl	8(%rax), %edx
	xorq	$52, %rdx
	orq	%rcx, %rdx
	leaq	_RNvCsePjmmjAuPjU_21fixture_validation_v59columns64(%rip), %rcx
	je	.LBB5_53
	movq	(%rax), %rcx
	movabsq	$3919369100574944353, %rdx
	xorq	%rdx, %rcx
	movzbl	8(%rax), %eax
	xorq	$52, %rax
	orq	%rcx, %rax
	leaq	_RNvCsePjmmjAuPjU_21fixture_validation_v59aligned64(%rip), %rcx
	je	.LBB5_53
	jmp	.LBB5_50
.LBB5_52:
	movl	(%rax), %ecx
	movl	$1600418931, %edx
	xorl	%edx, %ecx
	movl	3(%rax), %eax
	movl	$1920234335, %edx
	xorl	%edx, %eax
	orl	%ecx, %eax
	leaq	_RNvCsePjmmjAuPjU_21fixture_validation_v57std_str(%rip), %rcx
	jne	.LBB5_50
.LBB5_53:
	movq	%r12, 24(%rsp)
	movq	%r15, 32(%rsp)
	leaq	24(%rsp), %rax
	#APP
	#NO_APP
	movq	24(%rsp), %rdi
	movq	32(%rsp), %rsi
.Ltmp3:
	callq	*%rcx
.Ltmp4:
	movb	%al, 3(%rsp)
	cmpb	%al, %bpl
	jne	.LBB5_55
	incl	4(%rsp)
	addq	$16, %r14
	cmpq	$128, %r14
	jne	.LBB5_31
	movq	48(%rsp), %rdx
	cmpq	$3, %rdx
	leaq	248(%rsp), %rbp
	jne	.LBB5_21
	movq	8(%rsp), %rsi
	testq	%rsi, %rsi
	je	.LBB5_35
	movl	$1, %edx
	movq	16(%rsp), %rdi
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB5_35:
	testq	%rbx, %rbx
	leaq	_RNvXs1i_NtCs6knCYbIatyh_4core3fmtReNtB6_7Display3fmtCsePjmmjAuPjU_21fixture_validation_v5(%rip), %r12
	je	.LBB5_37
	movl	$1, %edx
	movq	%r13, %rdi
	movq	%rbx, %rsi
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB5_37:
	movq	40(%rsp), %rax
	cmpq	$128, %rax
	leaq	.Lalloc_9ffac2c917cfb57d9cf2452c301d487a(%rip), %rcx
	movq	_RNvCsbOwsw4zHH1Z_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip), %rdx
	movq	_RNvCsbOwsw4zHH1Z_7___rustc12___rust_alloc@GOTPCREL(%rip), %r13
	jne	.LBB5_1
	leaq	4(%rsp), %rax
	movq	%rax, 88(%rsp)
	movq	_RNvXs9_NtNtNtCs6knCYbIatyh_4core3fmt3num3implNtB9_7Display3fmt@GOTPCREL(%rip), %rax
	movq	%rax, 96(%rsp)
	leaq	.Lalloc_1e66b392e2065ab40817f6853c1297f7(%rip), %rdi
	leaq	88(%rsp), %rsi
	callq	*_RNvNtNtCs9wefJfwQbYy_3std2io5stdio6__print@GOTPCREL(%rip)
	addq	$344, %rsp
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
.LBB5_50:
	.cfi_def_cfa_offset 400
.Ltmp8:
	leaq	.Lalloc_476509aa7047bd805d630c6546685797(%rip), %rdi
	leaq	.Lalloc_fca6991b3cc86bb43212e42573e09073(%rip), %rdx
	movl	$14, %esi
	movq	8(%rsp), %r14
	callq	*_RNvNtCs6knCYbIatyh_4core9panicking5panic@GOTPCREL(%rip)
.Ltmp9:
	jmp	.LBB5_51
.LBB5_55:
	leaq	328(%rsp), %rax
	movq	%rax, 296(%rsp)
	leaq	_RNvXs1i_NtCs6knCYbIatyh_4core3fmtReNtB6_7Display3fmtCsePjmmjAuPjU_21fixture_validation_v5(%rip), %rcx
	movq	%rcx, 304(%rsp)
	leaq	72(%rsp), %rax
	movq	%rax, 312(%rsp)
	movq	%rcx, 320(%rsp)
.Ltmp6:
	leaq	3(%rsp), %rdi
	leaq	2(%rsp), %rsi
	leaq	296(%rsp), %rdx
	movq	8(%rsp), %r14
	callq	_RINvNtCs6knCYbIatyh_4core9panicking13assert_failedbbECsePjmmjAuPjU_21fixture_validation_v5
.Ltmp7:
.LBB5_51:
	ud2
.LBB5_2:
	xorl	%r14d, %r14d
.LBB5_3:
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	*_RNvNtCs4XhBu2GMSOm_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.LBB5_23:
.Ltmp2:
	movq	%rax, %r15
	jmp	.LBB5_24
.LBB5_39:
.Ltmp5:
	movq	%rax, %r15
	movq	8(%rsp), %r14
	jmp	.LBB5_41
.LBB5_40:
.Ltmp10:
	movq	%rax, %r15
.LBB5_41:
	testq	%r14, %r14
	je	.LBB5_24
	movl	$1, %edx
	movq	16(%rsp), %rdi
	movq	%r14, %rsi
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB5_24:
	testq	%rbx, %rbx
	je	.LBB5_26
	movl	$1, %edx
	movq	%r13, %rdi
	movq	%rbx, %rsi
	callq	*_RNvCsbOwsw4zHH1Z_7___rustc14___rust_dealloc@GOTPCREL(%rip)
.LBB5_26:
	movq	%r15, %rdi
	callq	_Unwind_Resume@PLT
.Lfunc_end5:
	.size	_RNvCsePjmmjAuPjU_21fixture_validation_v54main, .Lfunc_end5-_RNvCsePjmmjAuPjU_21fixture_validation_v54main
	.cfi_endproc
	.section	.rodata._RNvCsePjmmjAuPjU_21fixture_validation_v54main,"a",@progbits
	.p2align	2, 0x0
.LJTI5_0:
	.long	.LBB5_44-.LJTI5_0
	.long	.LBB5_52-.LJTI5_0
	.long	.LBB5_43-.LJTI5_0
	.long	.LBB5_48-.LJTI5_0
	.section	.gcc_except_table._RNvCsePjmmjAuPjU_21fixture_validation_v54main,"a",@progbits
	.p2align	2, 0x0
GCC_except_table5:
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
	.uleb128 .Ltmp3-.Lfunc_begin0
	.uleb128 .Ltmp4-.Ltmp3
	.uleb128 .Ltmp5-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp4-.Lfunc_begin0
	.uleb128 .Ltmp8-.Ltmp4
	.byte	0
	.byte	0
	.uleb128 .Ltmp8-.Lfunc_begin0
	.uleb128 .Ltmp7-.Ltmp8
	.uleb128 .Ltmp10-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp7-.Lfunc_begin0
	.uleb128 .Lfunc_end5-.Ltmp7
	.byte	0
	.byte	0
.Lcst_end0:
	.p2align	2, 0x0

	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI6_0:
	.zero	16,33
	.section	.text._RNvCsePjmmjAuPjU_21fixture_validation_v56fold16,"ax",@progbits
	.prefalign	4, .Lfunc_end6, nop
	.type	_RNvCsePjmmjAuPjU_21fixture_validation_v56fold16,@function
_RNvCsePjmmjAuPjU_21fixture_validation_v56fold16:
	.cfi_startproc
	movq	%rsi, %rax
	andq	$-16, %rax
	je	.LBB6_4
	xorl	%ecx, %ecx
	movdqa	.LCPI6_0(%rip), %xmm0
	.p2align	4
.LBB6_2:
	movdqu	(%rdi,%rcx), %xmm1
	pcmpeqb	%xmm0, %xmm1
	pmovmskb	%xmm1, %edx
	testl	%edx, %edx
	jne	.LBB6_12
	addq	$16, %rcx
	cmpq	%rcx, %rax
	jne	.LBB6_2
.LBB6_4:
	movl	%esi, %ecx
	andl	$15, %ecx
	cmpq	$16, %rsi
	setb	%dl
	testq	%rcx, %rcx
	sete	%r8b
	orb	%dl, %r8b
	je	.LBB6_10
	testq	%rcx, %rcx
	je	.LBB6_6
	addq	%rax, %rdi
	decq	%rcx
	xorl	%edx, %edx
	.p2align	4
.LBB6_8:
	cmpb	$33, (%rdi,%rdx)
	sete	%al
	je	.LBB6_11
	cmpq	%rdx, %rcx
	leaq	1(%rdx), %rdx
	jne	.LBB6_8
.LBB6_11:
	retq
.LBB6_10:
	movdqu	-16(%rdi,%rsi), %xmm0
	pcmpeqb	.LCPI6_0(%rip), %xmm0
	pmovmskb	%xmm0, %eax
	testl	%eax, %eax
	setne	%al
	retq
.LBB6_12:
	movb	$1, %al
	retq
.LBB6_6:
	xorl	%eax, %eax
	retq
.Lfunc_end6:
	.size	_RNvCsePjmmjAuPjU_21fixture_validation_v56fold16, .Lfunc_end6-_RNvCsePjmmjAuPjU_21fixture_validation_v56fold16
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI7_0:
	.zero	16,33
	.section	.text._RNvCsePjmmjAuPjU_21fixture_validation_v56fold64,"ax",@progbits
	.prefalign	4, .Lfunc_end7, nop
	.type	_RNvCsePjmmjAuPjU_21fixture_validation_v56fold64,@function
_RNvCsePjmmjAuPjU_21fixture_validation_v56fold64:
	.cfi_startproc
	cmpq	$64, %rsi
	jb	_RNvCsePjmmjAuPjU_21fixture_validation_v56fold16
	movq	%rsi, %rax
	andq	$-64, %rax
	je	.LBB7_5
	xorl	%ecx, %ecx
	movdqa	.LCPI7_0(%rip), %xmm0
	.p2align	4
.LBB7_3:
	movdqu	(%rdi,%rcx), %xmm1
	movdqu	16(%rdi,%rcx), %xmm2
	movdqu	32(%rdi,%rcx), %xmm3
	movdqu	48(%rdi,%rcx), %xmm4
	pcmpeqb	%xmm0, %xmm3
	pcmpeqb	%xmm0, %xmm1
	por	%xmm3, %xmm1
	pcmpeqb	%xmm0, %xmm4
	pcmpeqb	%xmm0, %xmm2
	por	%xmm4, %xmm2
	por	%xmm1, %xmm2
	pmovmskb	%xmm2, %edx
	testl	%edx, %edx
	jne	.LBB7_7
	addq	$64, %rcx
	cmpq	%rcx, %rax
	jne	.LBB7_3
.LBB7_5:
	testb	$63, %sil
	je	.LBB7_6
	movdqu	-64(%rdi,%rsi), %xmm0
	movdqu	-48(%rdi,%rsi), %xmm1
	movdqu	-32(%rdi,%rsi), %xmm2
	movdqu	-16(%rdi,%rsi), %xmm3
	movdqa	.LCPI7_0(%rip), %xmm4
	pcmpeqb	%xmm4, %xmm2
	pcmpeqb	%xmm4, %xmm0
	por	%xmm2, %xmm0
	pcmpeqb	%xmm4, %xmm3
	pcmpeqb	%xmm4, %xmm1
	por	%xmm3, %xmm1
	por	%xmm0, %xmm1
	pmovmskb	%xmm1, %eax
	testl	%eax, %eax
	setne	%al
	retq
.LBB7_7:
	movb	$1, %al
	retq
.LBB7_6:
	xorl	%eax, %eax
	retq
.Lfunc_end7:
	.size	_RNvCsePjmmjAuPjU_21fixture_validation_v56fold64, .Lfunc_end7-_RNvCsePjmmjAuPjU_21fixture_validation_v56fold64
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI8_0:
	.zero	16,33
	.section	.text._RNvCsePjmmjAuPjU_21fixture_validation_v56simd64,"ax",@progbits
	.prefalign	4, .Lfunc_end8, nop
	.type	_RNvCsePjmmjAuPjU_21fixture_validation_v56simd64,@function
_RNvCsePjmmjAuPjU_21fixture_validation_v56simd64:
	.cfi_startproc
	cmpq	$64, %rsi
	jb	_RNvCsePjmmjAuPjU_21fixture_validation_v56fold16
	movq	%rsi, %rax
	andq	$-64, %rax
	je	.LBB8_5
	xorl	%ecx, %ecx
	movdqa	.LCPI8_0(%rip), %xmm0
	.p2align	4
.LBB8_3:
	movdqu	(%rdi,%rcx), %xmm1
	movdqu	16(%rdi,%rcx), %xmm2
	movdqu	32(%rdi,%rcx), %xmm3
	movdqu	48(%rdi,%rcx), %xmm4
	pcmpeqb	%xmm0, %xmm1
	pcmpeqb	%xmm0, %xmm2
	por	%xmm1, %xmm2
	pcmpeqb	%xmm0, %xmm3
	pcmpeqb	%xmm0, %xmm4
	por	%xmm3, %xmm4
	por	%xmm2, %xmm4
	pmovmskb	%xmm4, %edx
	testl	%edx, %edx
	jne	.LBB8_7
	addq	$64, %rcx
	cmpq	%rcx, %rax
	jne	.LBB8_3
.LBB8_5:
	testb	$63, %sil
	je	.LBB8_6
	movdqa	.LCPI8_0(%rip), %xmm0
	movdqu	-64(%rdi,%rsi), %xmm1
	movdqu	-48(%rdi,%rsi), %xmm2
	movdqu	-32(%rdi,%rsi), %xmm3
	movdqu	-16(%rdi,%rsi), %xmm4
	pcmpeqb	%xmm0, %xmm1
	pcmpeqb	%xmm0, %xmm2
	por	%xmm1, %xmm2
	pcmpeqb	%xmm0, %xmm3
	pcmpeqb	%xmm0, %xmm4
	por	%xmm3, %xmm4
	por	%xmm2, %xmm4
	pmovmskb	%xmm4, %eax
	testl	%eax, %eax
	setne	%al
	retq
.LBB8_7:
	movb	$1, %al
	retq
.LBB8_6:
	xorl	%eax, %eax
	retq
.Lfunc_end8:
	.size	_RNvCsePjmmjAuPjU_21fixture_validation_v56simd64, .Lfunc_end8-_RNvCsePjmmjAuPjU_21fixture_validation_v56simd64
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI9_0:
	.zero	16,222
.LCPI9_1:
	.zero	16,1
	.section	.text._RNvCsePjmmjAuPjU_21fixture_validation_v56word16,"ax",@progbits
	.prefalign	4, .Lfunc_end9, nop
	.type	_RNvCsePjmmjAuPjU_21fixture_validation_v56word16,@function
_RNvCsePjmmjAuPjU_21fixture_validation_v56word16:
	.cfi_startproc
	movq	%rsi, %rax
	andq	$-16, %rax
	je	.LBB9_4
	movabsq	$-9187201950435737472, %rcx
	xorl	%edx, %edx
	movdqa	.LCPI9_0(%rip), %xmm0
	movdqa	.LCPI9_1(%rip), %xmm1
	.p2align	4
.LBB9_2:
	movdqu	(%rdi,%rdx), %xmm2
	movdqa	%xmm2, %xmm3
	pxor	%xmm0, %xmm3
	paddq	%xmm1, %xmm3
	por	%xmm2, %xmm3
	movq	%xmm3, %r8
	andq	%rcx, %r8
	pshufd	$238, %xmm3, %xmm2
	movq	%xmm2, %r9
	andq	%r8, %r9
	cmpq	%rcx, %r9
	jne	.LBB9_10
	addq	$16, %rdx
	cmpq	%rdx, %rax
	jne	.LBB9_2
.LBB9_4:
	andl	$15, %esi
	je	.LBB9_5
	addq	%rax, %rdi
	decq	%rsi
	xorl	%ecx, %ecx
	.p2align	4
.LBB9_7:
	cmpb	$33, (%rdi,%rcx)
	sete	%al
	je	.LBB9_9
	cmpq	%rcx, %rsi
	leaq	1(%rcx), %rcx
	jne	.LBB9_7
.LBB9_9:
	retq
.LBB9_10:
	movb	$1, %al
	retq
.LBB9_5:
	xorl	%eax, %eax
	retq
.Lfunc_end9:
	.size	_RNvCsePjmmjAuPjU_21fixture_validation_v56word16, .Lfunc_end9-_RNvCsePjmmjAuPjU_21fixture_validation_v56word16
	.cfi_endproc

	.section	.text._RNvCsePjmmjAuPjU_21fixture_validation_v57std_str,"ax",@progbits
	.prefalign	4, .Lfunc_end10, nop
	.type	_RNvCsePjmmjAuPjU_21fixture_validation_v57std_str,@function
_RNvCsePjmmjAuPjU_21fixture_validation_v57std_str:
	.cfi_startproc
	movq	%rsi, %rdx
	movq	%rdi, %rsi
	cmpq	$1, %rdx
	jbe	.LBB10_6
	cmpq	$15, %rdx
	ja	.LBB10_8
	xorl	%eax, %eax
	.p2align	4
.LBB10_3:
	cmpb	$33, (%rsi,%rax)
	je	.LBB10_9
	incq	%rax
	cmpq	%rax, %rdx
	jne	.LBB10_3
	jmp	.LBB10_10
.LBB10_6:
	jne	.LBB10_10
	cmpb	$33, (%rsi)
	sete	%al
	retq
.LBB10_8:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$33, %edi
	callq	*_RNvNtNtCs6knCYbIatyh_4core5slice6memchr14memchr_aligned@GOTPCREL(%rip)
	cmpq	$1, %rax
	leaq	8(%rsp), %rsp
	.cfi_def_cfa_offset 8
	jne	.LBB10_10
.LBB10_9:
	movb	$1, %al
	retq
.LBB10_10:
	xorl	%eax, %eax
	retq
.Lfunc_end10:
	.size	_RNvCsePjmmjAuPjU_21fixture_validation_v57std_str, .Lfunc_end10-_RNvCsePjmmjAuPjU_21fixture_validation_v57std_str
	.cfi_endproc

	.section	.text._RNvCsePjmmjAuPjU_21fixture_validation_v58std_char,"ax",@progbits
	.prefalign	4, .Lfunc_end11, nop
	.type	_RNvCsePjmmjAuPjU_21fixture_validation_v58std_char,@function
_RNvCsePjmmjAuPjU_21fixture_validation_v58std_char:
	.cfi_startproc
	movq	%rsi, %rdx
	movq	%rdi, %rsi
	cmpq	$15, %rdx
	ja	.LBB11_6
	testq	%rdx, %rdx
	je	.LBB11_5
	xorl	%eax, %eax
	.p2align	4
.LBB11_3:
	cmpb	$33, (%rsi,%rax)
	je	.LBB11_7
	incq	%rax
	cmpq	%rax, %rdx
	jne	.LBB11_3
	jmp	.LBB11_5
.LBB11_6:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$33, %edi
	callq	*_RNvNtNtCs6knCYbIatyh_4core5slice6memchr14memchr_aligned@GOTPCREL(%rip)
	cmpq	$1, %rax
	leaq	8(%rsp), %rsp
	.cfi_def_cfa_offset 8
	jne	.LBB11_5
.LBB11_7:
	movb	$1, %al
	retq
.LBB11_5:
	xorl	%eax, %eax
	retq
.Lfunc_end11:
	.size	_RNvCsePjmmjAuPjU_21fixture_validation_v58std_char, .Lfunc_end11-_RNvCsePjmmjAuPjU_21fixture_validation_v58std_char
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI12_0:
	.zero	16,33
	.section	.text._RNvCsePjmmjAuPjU_21fixture_validation_v59aligned64,"ax",@progbits
	.prefalign	4, .Lfunc_end12, nop
	.type	_RNvCsePjmmjAuPjU_21fixture_validation_v59aligned64,@function
_RNvCsePjmmjAuPjU_21fixture_validation_v59aligned64:
	.cfi_startproc
	cmpq	$128, %rsi
	jae	.LBB12_4
	cmpq	$64, %rsi
	jb	_RNvCsePjmmjAuPjU_21fixture_validation_v56fold16
	movdqa	.LCPI12_0(%rip), %xmm0
	movdqu	(%rdi), %xmm1
	movdqu	16(%rdi), %xmm2
	movdqu	32(%rdi), %xmm3
	movdqu	48(%rdi), %xmm4
	pcmpeqb	%xmm0, %xmm1
	pcmpeqb	%xmm0, %xmm2
	por	%xmm1, %xmm2
	pcmpeqb	%xmm0, %xmm3
	pcmpeqb	%xmm0, %xmm4
	por	%xmm3, %xmm4
	por	%xmm2, %xmm4
	pmovmskb	%xmm4, %ecx
	movb	$1, %al
	testl	%ecx, %ecx
	jne	.LBB12_3
	testb	$63, %sil
	jne	.LBB12_13
	jmp	.LBB12_16
.LBB12_4:
	leaq	15(%rdi), %rcx
	andq	$-16, %rcx
	subq	%rdi, %rcx
	je	.LBB12_6
	movdqu	(%rdi), %xmm0
	pcmpeqb	.LCPI12_0(%rip), %xmm0
	pmovmskb	%xmm0, %edx
	movb	$1, %al
	testl	%edx, %edx
	je	.LBB12_6
.LBB12_3:
	retq
.LBB12_6:
	movq	%rsi, %rax
	subq	%rcx, %rax
	movq	%rax, %rdx
	andq	$-64, %rdx
	je	.LBB12_10
	addq	%rdi, %rcx
	xorl	%r8d, %r8d
	movdqa	.LCPI12_0(%rip), %xmm0
	.p2align	4
.LBB12_8:
	movdqu	(%rcx,%r8), %xmm1
	movdqu	16(%rcx,%r8), %xmm2
	movdqu	32(%rcx,%r8), %xmm3
	movdqu	48(%rcx,%r8), %xmm4
	pcmpeqb	%xmm0, %xmm1
	pcmpeqb	%xmm0, %xmm2
	por	%xmm1, %xmm2
	pcmpeqb	%xmm0, %xmm3
	pcmpeqb	%xmm0, %xmm4
	por	%xmm3, %xmm4
	por	%xmm2, %xmm4
	pmovmskb	%xmm4, %r9d
	testl	%r9d, %r9d
	jne	.LBB12_14
	addq	$64, %r8
	cmpq	%r8, %rdx
	jne	.LBB12_8
.LBB12_10:
	testb	$63, %al
	je	.LBB12_16
	movdqa	.LCPI12_0(%rip), %xmm0
.LBB12_13:
	movdqu	-64(%rdi,%rsi), %xmm1
	movdqu	-48(%rdi,%rsi), %xmm2
	movdqu	-32(%rdi,%rsi), %xmm3
	movdqu	-16(%rdi,%rsi), %xmm4
	pcmpeqb	%xmm0, %xmm1
	pcmpeqb	%xmm0, %xmm2
	por	%xmm1, %xmm2
	pcmpeqb	%xmm0, %xmm3
	pcmpeqb	%xmm0, %xmm4
	por	%xmm3, %xmm4
	por	%xmm2, %xmm4
	pmovmskb	%xmm4, %eax
	testl	%eax, %eax
	setne	%al
	retq
.LBB12_16:
	xorl	%eax, %eax
	retq
.LBB12_14:
	movb	$1, %al
	retq
.Lfunc_end12:
	.size	_RNvCsePjmmjAuPjU_21fixture_validation_v59aligned64, .Lfunc_end12-_RNvCsePjmmjAuPjU_21fixture_validation_v59aligned64
	.cfi_endproc

	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4, 0x0
.LCPI13_0:
	.zero	16,33
	.section	.text._RNvCsePjmmjAuPjU_21fixture_validation_v59columns64,"ax",@progbits
	.prefalign	4, .Lfunc_end13, nop
	.type	_RNvCsePjmmjAuPjU_21fixture_validation_v59columns64,@function
_RNvCsePjmmjAuPjU_21fixture_validation_v59columns64:
	.cfi_startproc
	cmpq	$64, %rsi
	jb	_RNvCsePjmmjAuPjU_21fixture_validation_v56fold16
	movq	%rsi, %rax
	andq	$-64, %rax
	je	.LBB13_5
	xorl	%ecx, %ecx
	movdqa	.LCPI13_0(%rip), %xmm0
	.p2align	4
.LBB13_3:
	movdqu	(%rdi,%rcx), %xmm1
	movdqu	16(%rdi,%rcx), %xmm2
	movdqu	32(%rdi,%rcx), %xmm3
	movdqu	48(%rdi,%rcx), %xmm4
	pcmpeqb	%xmm0, %xmm3
	pcmpeqb	%xmm0, %xmm1
	por	%xmm3, %xmm1
	pcmpeqb	%xmm0, %xmm4
	pcmpeqb	%xmm0, %xmm2
	por	%xmm4, %xmm2
	por	%xmm1, %xmm2
	pmovmskb	%xmm2, %edx
	testl	%edx, %edx
	jne	.LBB13_7
	addq	$64, %rcx
	cmpq	%rcx, %rax
	jne	.LBB13_3
.LBB13_5:
	testb	$63, %sil
	je	.LBB13_6
	movdqu	-64(%rdi,%rsi), %xmm0
	movdqu	-48(%rdi,%rsi), %xmm1
	movdqu	-32(%rdi,%rsi), %xmm2
	movdqu	-16(%rdi,%rsi), %xmm3
	movdqa	.LCPI13_0(%rip), %xmm4
	pcmpeqb	%xmm4, %xmm2
	pcmpeqb	%xmm4, %xmm0
	por	%xmm2, %xmm0
	pcmpeqb	%xmm4, %xmm3
	pcmpeqb	%xmm4, %xmm1
	por	%xmm3, %xmm1
	por	%xmm0, %xmm1
	pmovmskb	%xmm1, %eax
	testl	%eax, %eax
	setne	%al
	retq
.LBB13_7:
	movb	$1, %al
	retq
.LBB13_6:
	xorl	%eax, %eax
	retq
.Lfunc_end13:
	.size	_RNvCsePjmmjAuPjU_21fixture_validation_v59columns64, .Lfunc_end13-_RNvCsePjmmjAuPjU_21fixture_validation_v59columns64
	.cfi_endproc

	.section	.text._RNvXs1g_NtCs6knCYbIatyh_4core3fmtRbNtB6_5Debug3fmtCsePjmmjAuPjU_21fixture_validation_v5,"ax",@progbits
	.prefalign	4, .Lfunc_end14, nop
	.type	_RNvXs1g_NtCs6knCYbIatyh_4core3fmtRbNtB6_5Debug3fmtCsePjmmjAuPjU_21fixture_validation_v5,@function
_RNvXs1g_NtCs6knCYbIatyh_4core3fmtRbNtB6_5Debug3fmtCsePjmmjAuPjU_21fixture_validation_v5:
	.cfi_startproc
	movq	(%rdi), %rdi
	jmpq	*_RNvXsg_NtCs6knCYbIatyh_4core3fmtbNtB5_7Display3fmt@GOTPCREL(%rip)
.Lfunc_end14:
	.size	_RNvXs1g_NtCs6knCYbIatyh_4core3fmtRbNtB6_5Debug3fmtCsePjmmjAuPjU_21fixture_validation_v5, .Lfunc_end14-_RNvXs1g_NtCs6knCYbIatyh_4core3fmtRbNtB6_5Debug3fmtCsePjmmjAuPjU_21fixture_validation_v5
	.cfi_endproc

	.section	.text._RNvXs1i_NtCs6knCYbIatyh_4core3fmtReNtB6_7Display3fmtCsePjmmjAuPjU_21fixture_validation_v5,"ax",@progbits
	.prefalign	4, .Lfunc_end15, nop
	.type	_RNvXs1i_NtCs6knCYbIatyh_4core3fmtReNtB6_7Display3fmtCsePjmmjAuPjU_21fixture_validation_v5,@function
_RNvXs1i_NtCs6knCYbIatyh_4core3fmtReNtB6_7Display3fmtCsePjmmjAuPjU_21fixture_validation_v5:
	.cfi_startproc
	movq	%rsi, %rdx
	movq	(%rdi), %rax
	movq	8(%rdi), %rsi
	movq	%rax, %rdi
	jmpq	*_RNvXsi_NtCs6knCYbIatyh_4core3fmteNtB5_7Display3fmt@GOTPCREL(%rip)
.Lfunc_end15:
	.size	_RNvXs1i_NtCs6knCYbIatyh_4core3fmtReNtB6_7Display3fmtCsePjmmjAuPjU_21fixture_validation_v5, .Lfunc_end15-_RNvXs1i_NtCs6knCYbIatyh_4core3fmtReNtB6_7Display3fmtCsePjmmjAuPjU_21fixture_validation_v5
	.cfi_endproc

	.section	.text.main,"ax",@progbits
	.globl	main
	.prefalign	4, .Lfunc_end16, nop
	.type	main,@function
main:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	%rsi, %rcx
	movslq	%edi, %rdx
	leaq	_RNvCsePjmmjAuPjU_21fixture_validation_v54main(%rip), %rax
	movq	%rax, (%rsp)
	leaq	.Lvtable.3(%rip), %rsi
	movq	%rsp, %rdi
	xorl	%r8d, %r8d
	callq	*_RNvNtCs9wefJfwQbYy_3std2rt19lang_start_internal@GOTPCREL(%rip)
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end16:
	.size	main, .Lfunc_end16-main
	.cfi_endproc

	.type	.Lvtable.2,@object
	.section	.data.rel.ro..Lvtable.2,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.2:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNvXs1g_NtCs6knCYbIatyh_4core3fmtRbNtB6_5Debug3fmtCsePjmmjAuPjU_21fixture_validation_v5
	.size	.Lvtable.2, 32

	.type	.Lvtable.3,@object
	.section	.data.rel.ro..Lvtable.3,"aw",@progbits
	.p2align	3, 0x0
.Lvtable.3:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_RNSNvYNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0INtNtNtCs6knCYbIatyh_4core3ops8function6FnOnceuE9call_once6vtableCsePjmmjAuPjU_21fixture_validation_v5
	.quad	_RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0CsePjmmjAuPjU_21fixture_validation_v5
	.quad	_RNCINvNtCs9wefJfwQbYy_3std2rt10lang_startuE0CsePjmmjAuPjU_21fixture_validation_v5
	.size	.Lvtable.3, 48

	.type	.Lalloc_306525db098c482a720a70411c6f3cf7,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_306525db098c482a720a70411c6f3cf7:
	.asciz	"/tmp/str-contains-bang-20261105/fixture-validation-v5.rs"
	.size	.Lalloc_306525db098c482a720a70411c6f3cf7, 57

	.type	.Lalloc_092c47c06a6226c442d77af8ed769228,@object
	.section	.rodata..Lalloc_092c47c06a6226c442d77af8ed769228,"a",@progbits
.Lalloc_092c47c06a6226c442d77af8ed769228:
	.ascii	"short_ascii"
	.size	.Lalloc_092c47c06a6226c442d77af8ed769228, 11

	.type	.Lalloc_4bd6bceb024aef9f23e5066e426491ee,@object
	.section	.rodata..Lalloc_4bd6bceb024aef9f23e5066e426491ee,"a",@progbits
.Lalloc_4bd6bceb024aef9f23e5066e426491ee:
	.ascii	"Mary had a little lamb, Little lamb Mary had a littl lamb, lamb!"
	.size	.Lalloc_4bd6bceb024aef9f23e5066e426491ee, 64

	.type	.Lalloc_646d19089e02acd036255249743c7292,@object
	.section	.rodata..Lalloc_646d19089e02acd036255249743c7292,"a",@progbits
.Lalloc_646d19089e02acd036255249743c7292:
	.ascii	"short_mixed"
	.size	.Lalloc_646d19089e02acd036255249743c7292, 11

	.type	.Lalloc_07f27d1a51ff81050a05c3aaa7bffba4,@object
	.section	.rodata..Lalloc_07f27d1a51ff81050a05c3aaa7bffba4,"a",@progbits
.Lalloc_07f27d1a51ff81050a05c3aaa7bffba4:
	.ascii	"\340\270\250\340\271\204\340\270\227\340\270\242\344\270\255\345\215\216Vi\341\273\207t Nam; Mary had a little lamb, Little lam!"
	.size	.Lalloc_07f27d1a51ff81050a05c3aaa7bffba4, 65

	.type	.Lalloc_f38b97b4a4a601195bddc40eab2a7492,@object
	.section	.rodata..Lalloc_f38b97b4a4a601195bddc40eab2a7492,"a",@progbits
.Lalloc_f38b97b4a4a601195bddc40eab2a7492:
	.ascii	"short_pile_of_poo"
	.size	.Lalloc_f38b97b4a4a601195bddc40eab2a7492, 17

	.type	.Lalloc_8ed678527068ad99dbd0bdd5650629cc,@object
	.section	.rodata..Lalloc_8ed678527068ad99dbd0bdd5650629cc,"a",@progbits
.Lalloc_8ed678527068ad99dbd0bdd5650629cc:
	.ascii	"\360\237\222\251\360\237\222\251\360\237\222\251\360\237\222\251\360\237\222\251\360\237\222\251\360\237\222\251\360\237\222\251\360\237\222\251\360\237\222\251\360\237\222\251\360\237\222\251\360\237\222\251\360\237\222\251\360\237\222\251\360\237\222\251!"
	.size	.Lalloc_8ed678527068ad99dbd0bdd5650629cc, 65

	.type	.Lalloc_2fcc467697b6d2a68e0862413c79447c,@object
	.section	.rodata.cst16,"aM",@progbits,16
.Lalloc_2fcc467697b6d2a68e0862413c79447c:
	.ascii	"long_lorem_ipsum"
	.size	.Lalloc_2fcc467697b6d2a68e0862413c79447c, 16

	.type	.Lalloc_dff9cf4bf633df229d9fbc204b3df0b7,@object
	.section	.rodata..Lalloc_dff9cf4bf633df229d9fbc204b3df0b7,"a",@progbits
.Lalloc_dff9cf4bf633df229d9fbc204b3df0b7:
	.ascii	"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse quis lorem sit amet dolor ultricies condimentum. Praesent iaculis purus elit, ac malesuada quam malesuada in. Duis sed orci eros. Suspendisse sit amet magna mollis, mollis nunc luctus, imperdiet mi. Integer fringilla non sem ut lacinia. Fusce varius tortor a risus porttitor hendrerit. Morbi mauris dui, ultricies nec tempus vel, gravida nec quam.\n\nIn est dui, tincidunt sed tempus interdum, adipiscing laoreet ante. Etiam tempor, tellus quis sagittis interdum, nulla purus mattis sem, quis auctor erat odio ac tellus. In nec nunc sit amet diam volutpat molestie at sed ipsum. Vestibulum laoreet consequat vulputate. Integer accumsan lorem ac dignissim placerat. Suspendisse convallis faucibus lorem. Aliquam erat volutpat. In vel eleifend felis. Sed suscipit nulla lorem, sed mollis est sollicitudin et. Nam fermentum egestas interdum. Curabitur ut nisi justo.\n\nSed sollicitudin ipsum tellus, ut condimentum leo eleifend nec. Cras ut velit ante. Phasellus nec mollis odio. Mauris molestie erat in arcu mattis, at aliquet dolor vehicula. Quisque malesuada lectus sit amet nisi pretium, a condimentum ipsum porta. Morbi at dapibus diam. Praesent egestas est sed risus elementum, eu rutrum metus ultrices. Etiam fermentum consectetur magna, id rutrum felis accumsan a. Aliquam ut pellentesque libero. Sed mi nulla, lobortis eu tortor id, suscipit ultricies neque. Morbi iaculis sit amet risus at iaculis. Praesent eget ligula quis turpis feugiat suscipit vel non arcu. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aliquam sit amet placerat lorem.\n\nCras a lacus vel ante posuere elementum. Nunc est leo, bibendum ut facilisis vel, bibendum at mauris. Nullam adipiscing diam vel odio ornare, luctus adipiscing mi luctus. Nulla facilisi. Mauris adipiscing bibendum neque, quis adipiscing lectus tempus et. Sed feugiat erat et nisl lobortis pharetra. Donec vitae erat enim. Nullam sit amet felis et quam lacinia tincidunt. Aliquam suscipit dapibus urna. Sed volutpat urna in magna pulvinar volutpat. Phasellus nec tellus ac diam cursus accumsan.\n\nNam lectus enim, dapibus non nisi tempor, consectetur convallis massa. Maecenas eleifend dictum feugiat. Etiam quis mauris vel risus luctus mattis a a nunc. Nullam orci quam, imperdiet id vehicula in, porttitor ut nibh. Duis sagittis adipiscing nisl vitae congue. Donec mollis risus eu leo suscipit, varius porttitor nulla porta. Pellentesque ut sem nec nisi euismod vehicula. Nulla malesuada sollicitudin quam eu fermentum!"
	.size	.Lalloc_dff9cf4bf633df229d9fbc204b3df0b7, 2551

	.type	.Lalloc_9ffac2c917cfb57d9cf2452c301d487a,@object
	.section	.data.rel.ro..Lalloc_9ffac2c917cfb57d9cf2452c301d487a,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_9ffac2c917cfb57d9cf2452c301d487a:
	.quad	.Lalloc_092c47c06a6226c442d77af8ed769228
	.asciz	"\013\000\000\000\000\000\000"
	.quad	.Lalloc_4bd6bceb024aef9f23e5066e426491ee
	.asciz	"@\000\000\000\000\000\000"
	.quad	.Lalloc_646d19089e02acd036255249743c7292
	.asciz	"\013\000\000\000\000\000\000"
	.quad	.Lalloc_07f27d1a51ff81050a05c3aaa7bffba4
	.asciz	"A\000\000\000\000\000\000"
	.quad	.Lalloc_f38b97b4a4a601195bddc40eab2a7492
	.asciz	"\021\000\000\000\000\000\000"
	.quad	.Lalloc_8ed678527068ad99dbd0bdd5650629cc
	.asciz	"A\000\000\000\000\000\000"
	.quad	.Lalloc_2fcc467697b6d2a68e0862413c79447c
	.asciz	"\020\000\000\000\000\000\000"
	.quad	.Lalloc_dff9cf4bf633df229d9fbc204b3df0b7
	.asciz	"\367\t\000\000\000\000\000"
	.size	.Lalloc_9ffac2c917cfb57d9cf2452c301d487a, 128

	.type	.Lalloc_cee386583203eba970c996905b2bf2ce,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_cee386583203eba970c996905b2bf2ce:
	.asciz	"\001!\300"
	.size	.Lalloc_cee386583203eba970c996905b2bf2ce, 4

	.type	.Lalloc_0cc424b65dbf69defeb506189b6207fb,@object
	.section	.rodata..Lalloc_0cc424b65dbf69defeb506189b6207fb,"a",@progbits
.Lalloc_0cc424b65dbf69defeb506189b6207fb:
	.ascii	"std_str"
	.size	.Lalloc_0cc424b65dbf69defeb506189b6207fb, 7

	.type	.Lalloc_f0a7980c19f39514de1d3cedf739be8d,@object
	.section	.rodata.cst8,"aM",@progbits,8
.Lalloc_f0a7980c19f39514de1d3cedf739be8d:
	.ascii	"std_char"
	.size	.Lalloc_f0a7980c19f39514de1d3cedf739be8d, 8

	.type	.Lalloc_353fdcebd014da422cb0fcde7f6b373c,@object
	.section	.rodata..Lalloc_353fdcebd014da422cb0fcde7f6b373c,"a",@progbits
.Lalloc_353fdcebd014da422cb0fcde7f6b373c:
	.ascii	"word16"
	.size	.Lalloc_353fdcebd014da422cb0fcde7f6b373c, 6

	.type	.Lalloc_9081d9a29e312f1c59877b6dc2556373,@object
	.section	.rodata..Lalloc_9081d9a29e312f1c59877b6dc2556373,"a",@progbits
.Lalloc_9081d9a29e312f1c59877b6dc2556373:
	.ascii	"fold16"
	.size	.Lalloc_9081d9a29e312f1c59877b6dc2556373, 6

	.type	.Lalloc_1f44d2c439f55c05fc535af957b10048,@object
	.section	.rodata..Lalloc_1f44d2c439f55c05fc535af957b10048,"a",@progbits
.Lalloc_1f44d2c439f55c05fc535af957b10048:
	.ascii	"fold64"
	.size	.Lalloc_1f44d2c439f55c05fc535af957b10048, 6

	.type	.Lalloc_4c816276899216b5ccb686d3f7a9ee8f,@object
	.section	.rodata..Lalloc_4c816276899216b5ccb686d3f7a9ee8f,"a",@progbits
.Lalloc_4c816276899216b5ccb686d3f7a9ee8f:
	.ascii	"columns64"
	.size	.Lalloc_4c816276899216b5ccb686d3f7a9ee8f, 9

	.type	.Lalloc_2124b3ec4808e9db578502928416a8e2,@object
	.section	.rodata..Lalloc_2124b3ec4808e9db578502928416a8e2,"a",@progbits
.Lalloc_2124b3ec4808e9db578502928416a8e2:
	.ascii	"simd64"
	.size	.Lalloc_2124b3ec4808e9db578502928416a8e2, 6

	.type	.Lalloc_98f8a1140d6b7d7b5798fefe2a07e477,@object
	.section	.rodata..Lalloc_98f8a1140d6b7d7b5798fefe2a07e477,"a",@progbits
.Lalloc_98f8a1140d6b7d7b5798fefe2a07e477:
	.ascii	"aligned64"
	.size	.Lalloc_98f8a1140d6b7d7b5798fefe2a07e477, 9

	.type	.Lalloc_150cf9fb508c258c80b6a996910db8f9,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_150cf9fb508c258c80b6a996910db8f9:
	.asciz	"\300\001 \300"
	.size	.Lalloc_150cf9fb508c258c80b6a996910db8f9, 5

	.type	.Lalloc_53a422af544a63c45be84e3f0c0221d4,@object
	.section	.data.rel.ro..Lalloc_53a422af544a63c45be84e3f0c0221d4,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_53a422af544a63c45be84e3f0c0221d4:
	.quad	.Lalloc_306525db098c482a720a70411c6f3cf7
	.asciz	"8\000\000\000\000\000\000\000n\000\000\000\021\000\000"
	.size	.Lalloc_53a422af544a63c45be84e3f0c0221d4, 24

	.type	.Lalloc_1e66b392e2065ab40817f6853c1297f7,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_1e66b392e2065ab40817f6853c1297f7:
	.asciz	"\007passed \300\034 actual-fixture comparisons\n"
	.size	.Lalloc_1e66b392e2065ab40817f6853c1297f7, 39

	.type	.Lalloc_476509aa7047bd805d630c6546685797,@object
	.section	.rodata..Lalloc_476509aa7047bd805d630c6546685797,"a",@progbits
.Lalloc_476509aa7047bd805d630c6546685797:
	.ascii	"explicit panic"
	.size	.Lalloc_476509aa7047bd805d630c6546685797, 14

	.type	.Lalloc_fca6991b3cc86bb43212e42573e09073,@object
	.section	.data.rel.ro..Lalloc_fca6991b3cc86bb43212e42573e09073,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_fca6991b3cc86bb43212e42573e09073:
	.quad	.Lalloc_306525db098c482a720a70411c6f3cf7
	.asciz	"8\000\000\000\000\000\000\000d\000\000\000\253\000\000"
	.size	.Lalloc_fca6991b3cc86bb43212e42573e09073, 24

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
