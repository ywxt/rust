
/tmp/contains-arm-word4-exit-20261106/sysroots/optimized/lib/rustlib/aarch64-unknown-linux-gnu/lib/libstd-7a2f7be1a1e543fc.so:     file format elf64-littleaarch64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

00000000000d8588 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned>:
   d8588:	91001c28 	add	x8, x1, #0x7
   d858c:	12001c09 	and	w9, w0, #0xff
   d8590:	927df108 	and	x8, x8, #0xfffffffffffffff8
   d8594:	eb010108 	subs	x8, x8, x1
   d8598:	54000061 	b.ne	d85a4 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x1c>  // b.any
   d859c:	aa1f03ea 	mov	x10, xzr
   d85a0:	1400000c 	b	d85d0 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x48>
   d85a4:	eb08005f 	cmp	x2, x8
   d85a8:	9a88304a 	csel	x10, x2, x8, cc	// cc = lo, ul, last
   d85ac:	b4000122 	cbz	x2, d85d0 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x48>
   d85b0:	aa1f03e8 	mov	x8, xzr
   d85b4:	52800020 	mov	w0, #0x1                   	// #1
   d85b8:	3868682b 	ldrb	w11, [x1, x8]
   d85bc:	6b09017f 	cmp	w11, w9
   d85c0:	54000200 	b.eq	d8600 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x78>  // b.none
   d85c4:	91000508 	add	x8, x8, #0x1
   d85c8:	eb08015f 	cmp	x10, x8
   d85cc:	54ffff61 	b.ne	d85b8 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x30>  // b.any
   d85d0:	d1004048 	sub	x8, x2, #0x10
   d85d4:	eb08015f 	cmp	x10, x8
   d85d8:	54000189 	b.ls	d8608 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x80>  // b.plast
   d85dc:	52800020 	mov	w0, #0x1                   	// #1
   d85e0:	aa0a03e8 	mov	x8, x10
   d85e4:	3868682a 	ldrb	w10, [x1, x8]
   d85e8:	6b09015f 	cmp	w10, w9
   d85ec:	540000a0 	b.eq	d8600 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x78>  // b.none
   d85f0:	91000508 	add	x8, x8, #0x1
   d85f4:	eb08005f 	cmp	x2, x8
   d85f8:	54ffff61 	b.ne	d85e4 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x5c>  // b.any
   d85fc:	aa1f03e0 	mov	x0, xzr
   d8600:	aa0803e1 	mov	x1, x8
   d8604:	d65f03c0 	ret
   d8608:	b200c3eb 	mov	x11, #0x101010101010101     	// #72340172838076673
   d860c:	b200c3ec 	mov	x12, #0x101010101010101     	// #72340172838076673
   d8610:	b201c3ed 	mov	x13, #0x8080808080808080    	// #-9187201950435737472
   d8614:	9b0b7d2b 	mul	x11, x9, x11
   d8618:	f280200c 	movk	x12, #0x100
   d861c:	8b0a002e 	add	x14, x1, x10
   d8620:	a94039cf 	ldp	x15, x14, [x14]
   d8624:	ca0b01ef 	eor	x15, x15, x11
   d8628:	ca0b01ce 	eor	x14, x14, x11
   d862c:	cb0f0190 	sub	x16, x12, x15
   d8630:	cb0e0191 	sub	x17, x12, x14
   d8634:	aa0f020f 	orr	x15, x16, x15
   d8638:	aa0e022e 	orr	x14, x17, x14
   d863c:	8a0e01ee 	and	x14, x15, x14
   d8640:	ea2e01bf 	bics	xzr, x13, x14
   d8644:	54fffcc1 	b.ne	d85dc <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x54>  // b.any
   d8648:	9100414e 	add	x14, x10, #0x10
   d864c:	eb0801df 	cmp	x14, x8
   d8650:	54000628 	b.hi	d8714 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x18c>  // b.pmore
   d8654:	8b0a002e 	add	x14, x1, x10
   d8658:	a94139cf 	ldp	x15, x14, [x14, #16]
   d865c:	ca0b01ef 	eor	x15, x15, x11
   d8660:	ca0b01ce 	eor	x14, x14, x11
   d8664:	cb0f0190 	sub	x16, x12, x15
   d8668:	cb0e0191 	sub	x17, x12, x14
   d866c:	aa0f020f 	orr	x15, x16, x15
   d8670:	aa0e022e 	orr	x14, x17, x14
   d8674:	8a0e01ee 	and	x14, x15, x14
   d8678:	ea2e01bf 	bics	xzr, x13, x14
   d867c:	54000461 	b.ne	d8708 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x180>  // b.any
   d8680:	9100814e 	add	x14, x10, #0x20
   d8684:	eb0801df 	cmp	x14, x8
   d8688:	54000448 	b.hi	d8710 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x188>  // b.pmore
   d868c:	8b0a002e 	add	x14, x1, x10
   d8690:	a94239cf 	ldp	x15, x14, [x14, #32]
   d8694:	ca0b01ef 	eor	x15, x15, x11
   d8698:	ca0b01ce 	eor	x14, x14, x11
   d869c:	cb0f0190 	sub	x16, x12, x15
   d86a0:	cb0e0191 	sub	x17, x12, x14
   d86a4:	aa0f020f 	orr	x15, x16, x15
   d86a8:	aa0e022e 	orr	x14, x17, x14
   d86ac:	8a0e01ee 	and	x14, x15, x14
   d86b0:	ea2e01bf 	bics	xzr, x13, x14
   d86b4:	54000381 	b.ne	d8724 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x19c>  // b.any
   d86b8:	9100c14e 	add	x14, x10, #0x30
   d86bc:	eb0801df 	cmp	x14, x8
   d86c0:	54000368 	b.hi	d872c <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x1a4>  // b.pmore
   d86c4:	8b0a002e 	add	x14, x1, x10
   d86c8:	a94339cf 	ldp	x15, x14, [x14, #48]
   d86cc:	ca0b01ef 	eor	x15, x15, x11
   d86d0:	ca0b01ce 	eor	x14, x14, x11
   d86d4:	cb0f0190 	sub	x16, x12, x15
   d86d8:	cb0e0191 	sub	x17, x12, x14
   d86dc:	aa0f020f 	orr	x15, x16, x15
   d86e0:	aa0e022e 	orr	x14, x17, x14
   d86e4:	8a0e01ee 	and	x14, x15, x14
   d86e8:	ea2e01bf 	bics	xzr, x13, x14
   d86ec:	540002a1 	b.ne	d8740 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x1b8>  // b.any
   d86f0:	9101014a 	add	x10, x10, #0x40
   d86f4:	eb08015f 	cmp	x10, x8
   d86f8:	54fff929 	b.ls	d861c <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x94>  // b.plast
   d86fc:	eb0a005f 	cmp	x2, x10
   d8700:	54fff6e1 	b.ne	d85dc <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x54>  // b.any
   d8704:	17ffffbe 	b	d85fc <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x74>
   d8708:	9100414a 	add	x10, x10, #0x10
   d870c:	17ffffb4 	b	d85dc <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x54>
   d8710:	d1008048 	sub	x8, x2, #0x20
   d8714:	eb0a011f 	cmp	x8, x10
   d8718:	aa0e03ea 	mov	x10, x14
   d871c:	54fff601 	b.ne	d85dc <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x54>  // b.any
   d8720:	17ffffb7 	b	d85fc <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x74>
   d8724:	9100814a 	add	x10, x10, #0x20
   d8728:	17ffffad 	b	d85dc <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x54>
   d872c:	d100c048 	sub	x8, x2, #0x30
   d8730:	eb0a011f 	cmp	x8, x10
   d8734:	aa0e03ea 	mov	x10, x14
   d8738:	54fff521 	b.ne	d85dc <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x54>  // b.any
   d873c:	17ffffb0 	b	d85fc <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x74>
   d8740:	9100c14a 	add	x10, x10, #0x30
   d8744:	17ffffa6 	b	d85dc <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x54>

Disassembly of section .fini:
