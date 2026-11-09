
/tmp/contains-arm-word4-20261106/sysroots/baseline/lib/rustlib/aarch64-unknown-linux-gnu/lib/libstd-7a2f7be1a1e543fc.so:     file format elf64-littleaarch64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

00000000000d85e4 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned>:
   d85e4:	91001c28 	add	x8, x1, #0x7
   d85e8:	12001c09 	and	w9, w0, #0xff
   d85ec:	927df108 	and	x8, x8, #0xfffffffffffffff8
   d85f0:	eb010108 	subs	x8, x8, x1
   d85f4:	54000081 	b.ne	d8604 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x20>  // b.any
   d85f8:	aa1f03ea 	mov	x10, xzr
   d85fc:	d100404b 	sub	x11, x2, #0x10
   d8600:	14000010 	b	d8640 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x5c>
   d8604:	eb08005f 	cmp	x2, x8
   d8608:	9a88304a 	csel	x10, x2, x8, cc	// cc = lo, ul, last
   d860c:	b4000122 	cbz	x2, d8630 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x4c>
   d8610:	aa1f03e8 	mov	x8, xzr
   d8614:	52800020 	mov	w0, #0x1                   	// #1
   d8618:	3868682b 	ldrb	w11, [x1, x8]
   d861c:	6b09017f 	cmp	w11, w9
   d8620:	540004c0 	b.eq	d86b8 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xd4>  // b.none
   d8624:	91000508 	add	x8, x8, #0x1
   d8628:	eb08015f 	cmp	x10, x8
   d862c:	54ffff61 	b.ne	d8618 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x34>  // b.any
   d8630:	d100404b 	sub	x11, x2, #0x10
   d8634:	aa0a03e8 	mov	x8, x10
   d8638:	eb0b015f 	cmp	x10, x11
   d863c:	540002a8 	b.hi	d8690 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xac>  // b.pmore
   d8640:	b200c3e8 	mov	x8, #0x101010101010101     	// #72340172838076673
   d8644:	b200c3ed 	mov	x13, #0x101010101010101     	// #72340172838076673
   d8648:	b201c3ee 	mov	x14, #0x8080808080808080    	// #-9187201950435737472
   d864c:	9b087d2c 	mul	x12, x9, x8
   d8650:	f280200d 	movk	x13, #0x100
   d8654:	aa0a03e8 	mov	x8, x10
   d8658:	8b08002a 	add	x10, x1, x8
   d865c:	a940294f 	ldp	x15, x10, [x10]
   d8660:	ca0c01ef 	eor	x15, x15, x12
   d8664:	ca0c014a 	eor	x10, x10, x12
   d8668:	cb0f01b0 	sub	x16, x13, x15
   d866c:	cb0a01b1 	sub	x17, x13, x10
   d8670:	aa0f020f 	orr	x15, x16, x15
   d8674:	aa0a022a 	orr	x10, x17, x10
   d8678:	8a0a01ea 	and	x10, x15, x10
   d867c:	ea2a01df 	bics	xzr, x14, x10
   d8680:	54000081 	b.ne	d8690 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xac>  // b.any
   d8684:	91004108 	add	x8, x8, #0x10
   d8688:	eb0b011f 	cmp	x8, x11
   d868c:	54fffe69 	b.ls	d8658 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x74>  // b.plast
   d8690:	eb08005f 	cmp	x2, x8
   d8694:	54000100 	b.eq	d86b4 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xd0>  // b.none
   d8698:	52800020 	mov	w0, #0x1                   	// #1
   d869c:	3868682a 	ldrb	w10, [x1, x8]
   d86a0:	6b09015f 	cmp	w10, w9
   d86a4:	540000a0 	b.eq	d86b8 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xd4>  // b.none
   d86a8:	91000508 	add	x8, x8, #0x1
   d86ac:	eb08005f 	cmp	x2, x8
   d86b0:	54ffff61 	b.ne	d869c <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xb8>  // b.any
   d86b4:	aa1f03e0 	mov	x0, xzr
   d86b8:	aa0803e1 	mov	x1, x8
   d86bc:	d65f03c0 	ret

Disassembly of section .fini:
