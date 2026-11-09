	.att_syntax
	.file	"diagnostic_intrinsics.23360e6d95804-cgu.0"
	.section	.text._RNvCs2PTBQ8hxw_21diagnostic_intrinsics16contains_byte_64,"ax",@progbits
	.globl	_RNvCs2PTBQ8hxw_21diagnostic_intrinsics16contains_byte_64
	.prefalign	4, .Lfunc_end0, nop
	.type	_RNvCs2PTBQ8hxw_21diagnostic_intrinsics16contains_byte_64,@function
_RNvCs2PTBQ8hxw_21diagnostic_intrinsics16contains_byte_64:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	%rsi, (%rsp)
	cmpq	$64, %rsi
	jne	.LBB0_2
	movzbl	%dl, %eax
	movd	%eax, %xmm0
	punpcklbw	%xmm0, %xmm0
	pshuflw	$0, %xmm0, %xmm0
	pshufd	$68, %xmm0, %xmm0
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
	pmovmskb	%xmm4, %eax
	testl	%eax, %eax
	setne	%al
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.LBB0_2:
	.cfi_def_cfa_offset 16
	leaq	.Lalloc_a57caa216b7f7cdbaccf41839ba4d102(%rip), %rdx
	leaq	.Lalloc_73f3cca889ccc2d04c0c06d7ddd51f96(%rip), %r9
	movq	%rsp, %rsi
	xorl	%edi, %edi
	xorl	%ecx, %ecx
	callq	*_RINvNtCsc9NCSoc2doQ_4core9panicking13assert_failedjjEB4_@GOTPCREL(%rip)
.Lfunc_end0:
	.size	_RNvCs2PTBQ8hxw_21diagnostic_intrinsics16contains_byte_64, .Lfunc_end0-_RNvCs2PTBQ8hxw_21diagnostic_intrinsics16contains_byte_64
	.cfi_endproc

	.type	.Lalloc_a57caa216b7f7cdbaccf41839ba4d102,@object
	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3, 0x0
.Lalloc_a57caa216b7f7cdbaccf41839ba4d102:
	.asciz	"@\000\000\000\000\000\000"
	.size	.Lalloc_a57caa216b7f7cdbaccf41839ba4d102, 8

	.type	.Lalloc_638052b9373210eb684a53fc33558e2a,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.Lalloc_638052b9373210eb684a53fc33558e2a:
	.asciz	"/tmp/contains-portable-simd-20261105/diagnostic_intrinsics.rs"
	.size	.Lalloc_638052b9373210eb684a53fc33558e2a, 62

	.type	.Lalloc_73f3cca889ccc2d04c0c06d7ddd51f96,@object
	.section	.data.rel.ro..Lalloc_73f3cca889ccc2d04c0c06d7ddd51f96,"aw",@progbits
	.p2align	3, 0x0
.Lalloc_73f3cca889ccc2d04c0c06d7ddd51f96:
	.quad	.Lalloc_638052b9373210eb684a53fc33558e2a
	.asciz	"=\000\000\000\000\000\000\000\023\000\000\000\005\000\000"
	.size	.Lalloc_73f3cca889ccc2d04c0c06d7ddd51f96, 24

	.ident	"rustc version 1.99.0-dev"
	.section	".note.GNU-stack","",@progbits
