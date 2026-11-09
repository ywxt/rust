
/tmp/contains-arm-word4-20261106/sysroots/optimized/lib/rustlib/aarch64-unknown-linux-gnu/lib/libstd-7a2f7be1a1e543fc.so:     file format elf64-littleaarch64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

00000000000d8588 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned>:
   d8588:	91001c28 	add	x8, x1, #0x7
   d858c:	12001c09 	and	w9, w0, #0xff
   d8590:	927df108 	and	x8, x8, #0xfffffffffffffff8
   d8594:	eb010108 	subs	x8, x8, x1
   d8598:	54000081 	b.ne	d85a8 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x20>  // b.any
   d859c:	aa1f03ee 	mov	x14, xzr
   d85a0:	d100404a 	sub	x10, x2, #0x10
   d85a4:	14000010 	b	d85e4 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x5c>
   d85a8:	eb08005f 	cmp	x2, x8
   d85ac:	9a88304e 	csel	x14, x2, x8, cc	// cc = lo, ul, last
   d85b0:	b4000122 	cbz	x2, d85d4 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x4c>
   d85b4:	aa1f03e8 	mov	x8, xzr
   d85b8:	52800020 	mov	w0, #0x1                   	// #1
   d85bc:	3868682a 	ldrb	w10, [x1, x8]
   d85c0:	6b09015f 	cmp	w10, w9
   d85c4:	54000a40 	b.eq	d870c <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x184>  // b.none
   d85c8:	91000508 	add	x8, x8, #0x1
   d85cc:	eb0801df 	cmp	x14, x8
   d85d0:	54ffff61 	b.ne	d85bc <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x34>  // b.any
   d85d4:	d100404a 	sub	x10, x2, #0x10
   d85d8:	aa0e03e8 	mov	x8, x14
   d85dc:	eb0a01df 	cmp	x14, x10
   d85e0:	54000828 	b.hi	d86e4 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x15c>  // b.pmore
   d85e4:	b200c3e8 	mov	x8, #0x101010101010101     	// #72340172838076673
   d85e8:	b200c3ec 	mov	x12, #0x101010101010101     	// #72340172838076673
   d85ec:	b201c3ed 	mov	x13, #0x8080808080808080    	// #-9187201950435737472
   d85f0:	9b087d2b 	mul	x11, x9, x8
   d85f4:	f280200c 	movk	x12, #0x100
   d85f8:	aa0e03e8 	mov	x8, x14
   d85fc:	8b08002e 	add	x14, x1, x8
   d8600:	a94039cf 	ldp	x15, x14, [x14]
   d8604:	ca0b01ef 	eor	x15, x15, x11
   d8608:	ca0b01ce 	eor	x14, x14, x11
   d860c:	cb0f0190 	sub	x16, x12, x15
   d8610:	cb0e0191 	sub	x17, x12, x14
   d8614:	aa0f020f 	orr	x15, x16, x15
   d8618:	aa0e022e 	orr	x14, x17, x14
   d861c:	8a0e01ee 	and	x14, x15, x14
   d8620:	ea2e01bf 	bics	xzr, x13, x14
   d8624:	54000601 	b.ne	d86e4 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x15c>  // b.any
   d8628:	9100410e 	add	x14, x8, #0x10
   d862c:	eb0a01df 	cmp	x14, x10
   d8630:	54000588 	b.hi	d86e0 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x158>  // b.pmore
   d8634:	8b08002f 	add	x15, x1, x8
   d8638:	a9413df0 	ldp	x16, x15, [x15, #16]
   d863c:	ca0b0210 	eor	x16, x16, x11
   d8640:	ca0b01ef 	eor	x15, x15, x11
   d8644:	cb100191 	sub	x17, x12, x16
   d8648:	cb0f0192 	sub	x18, x12, x15
   d864c:	aa100230 	orr	x16, x17, x16
   d8650:	aa0f024f 	orr	x15, x18, x15
   d8654:	8a0f020f 	and	x15, x16, x15
   d8658:	ea2f01bf 	bics	xzr, x13, x15
   d865c:	54000421 	b.ne	d86e0 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x158>  // b.any
   d8660:	9100810e 	add	x14, x8, #0x20
   d8664:	eb0a01df 	cmp	x14, x10
   d8668:	540003c8 	b.hi	d86e0 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x158>  // b.pmore
   d866c:	8b08002e 	add	x14, x1, x8
   d8670:	a94239cf 	ldp	x15, x14, [x14, #32]
   d8674:	ca0b01ef 	eor	x15, x15, x11
   d8678:	ca0b01ce 	eor	x14, x14, x11
   d867c:	cb0f0190 	sub	x16, x12, x15
   d8680:	cb0e0191 	sub	x17, x12, x14
   d8684:	aa0f020f 	orr	x15, x16, x15
   d8688:	aa0e022e 	orr	x14, x17, x14
   d868c:	8a0e01ee 	and	x14, x15, x14
   d8690:	ea2e01bf 	bics	xzr, x13, x14
   d8694:	54000401 	b.ne	d8714 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x18c>  // b.any
   d8698:	9100c10e 	add	x14, x8, #0x30
   d869c:	eb0a01df 	cmp	x14, x10
   d86a0:	54000208 	b.hi	d86e0 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x158>  // b.pmore
   d86a4:	8b08002f 	add	x15, x1, x8
   d86a8:	a9433df0 	ldp	x16, x15, [x15, #48]
   d86ac:	ca0b0210 	eor	x16, x16, x11
   d86b0:	ca0b01ef 	eor	x15, x15, x11
   d86b4:	cb100191 	sub	x17, x12, x16
   d86b8:	cb0f0192 	sub	x18, x12, x15
   d86bc:	aa100230 	orr	x16, x17, x16
   d86c0:	aa0f024f 	orr	x15, x18, x15
   d86c4:	8a0f020f 	and	x15, x16, x15
   d86c8:	ea2f01bf 	bics	xzr, x13, x15
   d86cc:	540000a1 	b.ne	d86e0 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x158>  // b.any
   d86d0:	91010108 	add	x8, x8, #0x40
   d86d4:	eb0a011f 	cmp	x8, x10
   d86d8:	54fff929 	b.ls	d85fc <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x74>  // b.plast
   d86dc:	14000002 	b	d86e4 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x15c>
   d86e0:	aa0e03e8 	mov	x8, x14
   d86e4:	eb08005f 	cmp	x2, x8
   d86e8:	54000100 	b.eq	d8708 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x180>  // b.none
   d86ec:	52800020 	mov	w0, #0x1                   	// #1
   d86f0:	3868682a 	ldrb	w10, [x1, x8]
   d86f4:	6b09015f 	cmp	w10, w9
   d86f8:	540000a0 	b.eq	d870c <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x184>  // b.none
   d86fc:	91000508 	add	x8, x8, #0x1
   d8700:	eb08005f 	cmp	x2, x8
   d8704:	54ffff61 	b.ne	d86f0 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x168>  // b.any
   d8708:	aa1f03e0 	mov	x0, xzr
   d870c:	aa0803e1 	mov	x1, x8
   d8710:	d65f03c0 	ret
   d8714:	91008108 	add	x8, x8, #0x20
   d8718:	eb08005f 	cmp	x2, x8
   d871c:	54fffe81 	b.ne	d86ec <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x164>  // b.any
   d8720:	17fffffa 	b	d8708 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x180>

Disassembly of section .fini:
