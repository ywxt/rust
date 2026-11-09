	.att_syntax
	.file	"minimal.17726a61271bdaf4-cgu.0"
	.section	.text.collect_from_slice,"ax",@progbits
	.globl	collect_from_slice
	.prefalign	4, .Lfunc_end0, nop
	.type	collect_from_slice,@function
collect_from_slice:
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
	movq	%rdx, %rbx
	movq	%rdi, %r14
	testq	%rdx, %rdx
	je	.LBB0_1
	movq	%rsi, %r15
	leaq	(,%rbx,8), %r12
	callq	*_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$8, %esi
	movq	%r12, %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB0_5
	movq	%rax, %r13
	movq	%rax, %rdi
	movq	%r15, %rsi
	movq	%r12, %rdx
	callq	*memcpy@GOTPCREL(%rip)
	jmp	.LBB0_4
.LBB0_1:
	movl	$8, %r13d
.LBB0_4:
	movq	%rbx, (%r14)
	movq	%r13, 8(%r14)
	movq	%rbx, 16(%r14)
	movq	%r14, %rax
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
.LBB0_5:
	.cfi_def_cfa_offset 48
	movl	$8, %edi
	movq	%r12, %rsi
	callq	*_RNvNtCs3v2GDSbr0UZ_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Lfunc_end0:
	.size	collect_from_slice, .Lfunc_end0-collect_from_slice
	.cfi_endproc

	.section	.text.collect_from_vec,"ax",@progbits
	.globl	collect_from_vec
	.prefalign	4, .Lfunc_end1, nop
	.type	collect_from_vec,@function
collect_from_vec:
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
	movq	16(%rsi), %r15
	testq	%r15, %r15
	je	.LBB1_1
	movq	8(%rsi), %r12
	leaq	(,%r15,8), %r14
	callq	*_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$8, %esi
	movq	%r14, %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB1_14
	cmpq	$8, %r15
	setb	%cl
	movq	%r12, %rdx
	subq	%rax, %rdx
	cmpq	$-31, %rdx
	setae	%dl
	orb	%cl, %dl
	je	.LBB1_5
	xorl	%ecx, %ecx
	jmp	.LBB1_8
.LBB1_1:
	movl	$8, %eax
	jmp	.LBB1_13
.LBB1_5:
	movq	%r15, %rcx
	andq	$-4, %rcx
	xorl	%edx, %edx
	.p2align	4
.LBB1_6:
	movups	(%r12,%rdx,8), %xmm0
	movups	16(%r12,%rdx,8), %xmm1
	movups	%xmm0, (%rax,%rdx,8)
	movups	%xmm1, 16(%rax,%rdx,8)
	addq	$4, %rdx
	cmpq	%rdx, %rcx
	jne	.LBB1_6
	cmpq	%rcx, %r15
	je	.LBB1_13
.LBB1_8:
	movq	%r15, %rsi
	movq	%rcx, %rdx
	andq	$3, %rsi
	je	.LBB1_11
	movq	%rcx, %rdx
	.p2align	4
.LBB1_10:
	movq	(%r12,%rdx,8), %rdi
	movq	%rdi, (%rax,%rdx,8)
	incq	%rdx
	decq	%rsi
	jne	.LBB1_10
.LBB1_11:
	subq	%r15, %rcx
	cmpq	$-4, %rcx
	ja	.LBB1_13
	.p2align	4
.LBB1_12:
	movq	(%r12,%rdx,8), %rcx
	movq	%rcx, (%rax,%rdx,8)
	movq	8(%r12,%rdx,8), %rcx
	movq	%rcx, 8(%rax,%rdx,8)
	movq	16(%r12,%rdx,8), %rcx
	movq	%rcx, 16(%rax,%rdx,8)
	movq	24(%r12,%rdx,8), %rcx
	movq	%rcx, 24(%rax,%rdx,8)
	addq	$4, %rdx
	cmpq	%rdx, %r15
	jne	.LBB1_12
.LBB1_13:
	movq	%r15, (%rbx)
	movq	%rax, 8(%rbx)
	movq	%r15, 16(%rbx)
	movq	%rbx, %rax
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
.LBB1_14:
	.cfi_def_cfa_offset 48
	movl	$8, %edi
	movq	%r14, %rsi
	callq	*_RNvNtCs3v2GDSbr0UZ_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Lfunc_end1:
	.size	collect_from_vec, .Lfunc_end1-collect_from_vec
	.cfi_endproc

	.section	.text.slice_to_vec,"ax",@progbits
	.globl	slice_to_vec
	.prefalign	4, .Lfunc_end2, nop
	.type	slice_to_vec,@function
slice_to_vec:
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
	testq	%rdx, %rdx
	je	.LBB2_1
	movq	%rdx, %r14
	movq	%rsi, %r15
	leaq	(,%rdx,8), %r12
	callq	*_RNvCshVjSbrpHdcL_7___rustc35___rust_no_alloc_shim_is_unstable_v2@GOTPCREL(%rip)
	movl	$8, %esi
	movq	%r12, %rdi
	callq	*_RNvCshVjSbrpHdcL_7___rustc12___rust_alloc@GOTPCREL(%rip)
	testq	%rax, %rax
	je	.LBB2_5
	movq	%r14, (%rbx)
	movq	%rax, 8(%rbx)
	movq	%rax, %rdi
	movq	%r15, %rsi
	movq	%r12, %rdx
	callq	*memcpy@GOTPCREL(%rip)
	movq	%r14, 16(%rbx)
	jmp	.LBB2_4
.LBB2_1:
	movq	$0, (%rbx)
	movq	$8, 8(%rbx)
	movq	$0, 16(%rbx)
.LBB2_4:
	movq	%rbx, %rax
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
.LBB2_5:
	.cfi_def_cfa_offset 48
	movl	$8, %edi
	movq	%r12, %rsi
	callq	*_RNvNtCs3v2GDSbr0UZ_5alloc7raw_vec12handle_error@GOTPCREL(%rip)
.Lfunc_end2:
	.size	slice_to_vec, .Lfunc_end2-slice_to_vec
	.cfi_endproc

	.ident	"rustc version 1.99.0-dev"
	.section	".note.GNU-stack","",@progbits
