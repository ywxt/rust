
/tmp/contains-arm-shorttail-20261106/sysroots/optimized/lib/rustlib/aarch64-unknown-linux-gnu/lib/libstd-7a2f7be1a1e543fc.so:     file format elf64-littleaarch64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

00000000000d8860 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned>:
   d8860:	91001c28 	add	x8, x1, #0x7
   d8864:	12001c09 	and	w9, w0, #0xff
   d8868:	927df108 	and	x8, x8, #0xfffffffffffffff8
   d886c:	eb010108 	subs	x8, x8, x1
   d8870:	54000081 	b.ne	d8880 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x20>  // b.any
   d8874:	aa1f03ea 	mov	x10, xzr
   d8878:	d100404b 	sub	x11, x2, #0x10
   d887c:	14000010 	b	d88bc <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x5c>
   d8880:	eb08005f 	cmp	x2, x8
   d8884:	9a88304a 	csel	x10, x2, x8, cc	// cc = lo, ul, last
   d8888:	b4000122 	cbz	x2, d88ac <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x4c>
   d888c:	aa1f03e8 	mov	x8, xzr
   d8890:	52800020 	mov	w0, #0x1                   	// #1
   d8894:	3868682b 	ldrb	w11, [x1, x8]
   d8898:	6b09017f 	cmp	w11, w9
   d889c:	540004c0 	b.eq	d8934 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xd4>  // b.none
   d88a0:	91000508 	add	x8, x8, #0x1
   d88a4:	eb08015f 	cmp	x10, x8
   d88a8:	54ffff61 	b.ne	d8894 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x34>  // b.any
   d88ac:	d100404b 	sub	x11, x2, #0x10
   d88b0:	aa0a03e8 	mov	x8, x10
   d88b4:	eb0b015f 	cmp	x10, x11
   d88b8:	540002a8 	b.hi	d890c <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xac>  // b.pmore
   d88bc:	b200c3e8 	mov	x8, #0x101010101010101     	// #72340172838076673
   d88c0:	b200c3ed 	mov	x13, #0x101010101010101     	// #72340172838076673
   d88c4:	b201c3ee 	mov	x14, #0x8080808080808080    	// #-9187201950435737472
   d88c8:	9b087d2c 	mul	x12, x9, x8
   d88cc:	f280200d 	movk	x13, #0x100
   d88d0:	aa0a03e8 	mov	x8, x10
   d88d4:	8b08002a 	add	x10, x1, x8
   d88d8:	a940294f 	ldp	x15, x10, [x10]
   d88dc:	ca0c01ef 	eor	x15, x15, x12
   d88e0:	ca0c014a 	eor	x10, x10, x12
   d88e4:	cb0f01b0 	sub	x16, x13, x15
   d88e8:	cb0a01b1 	sub	x17, x13, x10
   d88ec:	aa0f020f 	orr	x15, x16, x15
   d88f0:	aa0a022a 	orr	x10, x17, x10
   d88f4:	8a0a01ea 	and	x10, x15, x10
   d88f8:	ea2a01df 	bics	xzr, x14, x10
   d88fc:	54000081 	b.ne	d890c <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xac>  // b.any
   d8900:	91004108 	add	x8, x8, #0x10
   d8904:	eb0b011f 	cmp	x8, x11
   d8908:	54fffe69 	b.ls	d88d4 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x74>  // b.plast
   d890c:	eb08005f 	cmp	x2, x8
   d8910:	54000100 	b.eq	d8930 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xd0>  // b.none
   d8914:	52800020 	mov	w0, #0x1                   	// #1
   d8918:	3868682a 	ldrb	w10, [x1, x8]
   d891c:	6b09015f 	cmp	w10, w9
   d8920:	540000a0 	b.eq	d8934 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xd4>  // b.none
   d8924:	91000508 	add	x8, x8, #0x1
   d8928:	eb08005f 	cmp	x2, x8
   d892c:	54ffff61 	b.ne	d8918 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xb8>  // b.any
   d8930:	aa1f03e0 	mov	x0, xzr
   d8934:	aa0803e1 	mov	x1, x8
   d8938:	d65f03c0 	ret

Disassembly of section .fini:
