	.att_syntax
	.file	"repro.ll"
	.text
	.globl	filter_chain_ref_count          # -- Begin function filter_chain_ref_count
	.prefalign	4, .Lfunc_end0, nop
	.type	filter_chain_ref_count,@function
filter_chain_ref_count:                 # @filter_chain_ref_count
# %bb.0:                                # %entry
	xorl	%eax, %eax
	leaq	-8(%rsp), %rdi
	movabsq	$-6148914691236517205, %rcx     # imm = 0xAAAAAAAAAAAAAAAB
	movabsq	$3074457345618258602, %rdx      # imm = 0x2AAAAAAAAAAAAAAA
	movabsq	$6148914691236517205, %rsi      # imm = 0x5555555555555555
	xorl	%r8d, %r8d
	.p2align	4
.LBB0_1:                                # %first
                                        # =>This Inner Loop Header: Depth=1
	movq	%r8, -8(%rsp)
	#APP
	#NO_APP
	movq	-8(%rsp), %r9
	imulq	%rcx, %r9
	addq	%rdx, %r9
	cmpq	%rsi, %r9
	adcq	$0, %rax
	incq	%r8
	cmpq	$1000000, %r8                   # imm = 0xF4240
	jne	.LBB0_1
# %bb.2:                                # %second.preheader
	xorl	%edi, %edi
	leaq	-8(%rsp), %r8
	.p2align	4
.LBB0_3:                                # %second
                                        # =>This Inner Loop Header: Depth=1
	movq	%rdi, -8(%rsp)
	#APP
	#NO_APP
	movq	-8(%rsp), %r9
	imulq	%rcx, %r9
	addq	%rdx, %r9
	cmpq	%rsi, %r9
	adcq	$0, %rax
	incq	%rdi
	cmpq	$1000000, %rdi                  # imm = 0xF4240
	jne	.LBB0_3
# %bb.4:                                # %exit
	retq
.Lfunc_end0:
	.size	filter_chain_ref_count, .Lfunc_end0-filter_chain_ref_count
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
