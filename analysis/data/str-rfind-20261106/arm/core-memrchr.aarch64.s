
/tmp/contains-bad-simd-20261105/sysroots/baseline/lib/rustlib/aarch64-unknown-linux-gnu/lib/libstd-7a2f7be1a1e543fc.so:     file format elf64-littleaarch64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

00000000000d88a8 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr7memrchr>:
   d88a8:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
   d88ac:	910003fd 	mov	x29, sp
   d88b0:	91001c28 	add	x8, x1, #0x7
   d88b4:	aa0203e9 	mov	x9, x2
   d88b8:	aa0203eb 	mov	x11, x2
   d88bc:	927df108 	and	x8, x8, #0xfffffffffffffff8
   d88c0:	cb010108 	sub	x8, x8, x1
   d88c4:	eb08005f 	cmp	x2, x8
   d88c8:	540000c3 	b.cc	d88e0 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr7memrchr+0x38>  // b.lo, b.ul, b.last
   d88cc:	4b080049 	sub	w9, w2, w8
   d88d0:	92400d29 	and	x9, x9, #0xf
   d88d4:	eb090049 	subs	x9, x2, x9
   d88d8:	54000703 	b.cc	d89b8 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr7memrchr+0x110>  // b.lo, b.ul, b.last
   d88dc:	aa0803eb 	mov	x11, x8
   d88e0:	eb02013f 	cmp	x9, x2
   d88e4:	12001c0a 	and	w10, w0, #0xff
   d88e8:	54000160 	b.eq	d8914 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr7memrchr+0x6c>  // b.none
   d88ec:	d1000448 	sub	x8, x2, #0x1
   d88f0:	cb0903ec 	neg	x12, x9
   d88f4:	52800020 	mov	w0, #0x1                   	// #1
   d88f8:	3868682d 	ldrb	w13, [x1, x8]
   d88fc:	6b0a01bf 	cmp	w13, w10
   d8900:	540004c0 	b.eq	d8998 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr7memrchr+0xf0>  // b.none
   d8904:	d1000508 	sub	x8, x8, #0x1
   d8908:	8b08018d 	add	x13, x12, x8
   d890c:	b10005bf 	cmn	x13, #0x1
   d8910:	54ffff41 	b.ne	d88f8 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr7memrchr+0x50>  // b.any
   d8914:	b200c3e8 	mov	x8, #0x101010101010101     	// #72340172838076673
   d8918:	b200c3ed 	mov	x13, #0x101010101010101     	// #72340172838076673
   d891c:	d100202e 	sub	x14, x1, #0x8
   d8920:	9b087d4c 	mul	x12, x10, x8
   d8924:	f280200d 	movk	x13, #0x100
   d8928:	b201c3ef 	mov	x15, #0x8080808080808080    	// #-9187201950435737472
   d892c:	aa0903e8 	mov	x8, x9
   d8930:	eb0b013f 	cmp	x9, x11
   d8934:	540001a9 	b.ls	d8968 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr7memrchr+0xc0>  // b.plast
   d8938:	8b0801c9 	add	x9, x14, x8
   d893c:	a97fa530 	ldp	x16, x9, [x9, #-8]
   d8940:	ca0c0210 	eor	x16, x16, x12
   d8944:	ca0c0129 	eor	x9, x9, x12
   d8948:	cb1001b1 	sub	x17, x13, x16
   d894c:	cb0901b2 	sub	x18, x13, x9
   d8950:	aa100230 	orr	x16, x17, x16
   d8954:	aa090249 	orr	x9, x18, x9
   d8958:	8a090209 	and	x9, x16, x9
   d895c:	ea2901ff 	bics	xzr, x15, x9
   d8960:	d1004109 	sub	x9, x8, #0x10
   d8964:	54fffe40 	b.eq	d892c <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr7memrchr+0x84>  // b.none
   d8968:	eb02011f 	cmp	x8, x2
   d896c:	540001c8 	b.hi	d89a4 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr7memrchr+0xfc>  // b.pmore
   d8970:	b4000128 	cbz	x8, d8994 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr7memrchr+0xec>
   d8974:	d1000508 	sub	x8, x8, #0x1
   d8978:	52800020 	mov	w0, #0x1                   	// #1
   d897c:	38686829 	ldrb	w9, [x1, x8]
   d8980:	6b0a013f 	cmp	w9, w10
   d8984:	540000a0 	b.eq	d8998 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr7memrchr+0xf0>  // b.none
   d8988:	d1000508 	sub	x8, x8, #0x1
   d898c:	b100051f 	cmn	x8, #0x1
   d8990:	54ffff61 	b.ne	d897c <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr7memrchr+0xd4>  // b.any
   d8994:	aa1f03e0 	mov	x0, xzr
   d8998:	aa0803e1 	mov	x1, x8
   d899c:	a8c17bfd 	ldp	x29, x30, [sp], #16
   d89a0:	d65f03c0 	ret
   d89a4:	b0000323 	adrp	x3, 13d000 <_RNvNtCs68fcPop4ROg_3std9panicking11EMPTY_PANIC+0x4c60>
   d89a8:	913a6063 	add	x3, x3, #0xe98
   d89ac:	aa1f03e0 	mov	x0, xzr
   d89b0:	aa0803e1 	mov	x1, x8
   d89b4:	97fdb217 	bl	45210 <_RNvNtNtCshp6Wxz1DwXO_4core5slice5index16slice_index_fail@plt>
   d89b8:	b0000323 	adrp	x3, 13d000 <_RNvNtCs68fcPop4ROg_3std9panicking11EMPTY_PANIC+0x4c60>
   d89bc:	913ac063 	add	x3, x3, #0xeb0
   d89c0:	aa0903e0 	mov	x0, x9
   d89c4:	aa0203e1 	mov	x1, x2
   d89c8:	97fdb212 	bl	45210 <_RNvNtNtCshp6Wxz1DwXO_4core5slice5index16slice_index_fail@plt>

Disassembly of section .fini:
