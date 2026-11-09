
/tmp/contains-arm-bool-20261106/sysroots/optimized/lib/rustlib/aarch64-unknown-linux-gnu/lib/libstd-7a2f7be1a1e543fc.so:     file format elf64-littleaarch64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

00000000000d86f4 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned>:
   d86f4:	91001c28 	add	x8, x1, #0x7
   d86f8:	12001c09 	and	w9, w0, #0xff
   d86fc:	927df108 	and	x8, x8, #0xfffffffffffffff8
   d8700:	eb010108 	subs	x8, x8, x1
   d8704:	54000081 	b.ne	d8714 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x20>  // b.any
   d8708:	aa1f03ea 	mov	x10, xzr
   d870c:	d100404b 	sub	x11, x2, #0x10
   d8710:	14000010 	b	d8750 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x5c>
   d8714:	eb08005f 	cmp	x2, x8
   d8718:	9a88304a 	csel	x10, x2, x8, cc	// cc = lo, ul, last
   d871c:	b4000122 	cbz	x2, d8740 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x4c>
   d8720:	aa1f03e8 	mov	x8, xzr
   d8724:	52800020 	mov	w0, #0x1                   	// #1
   d8728:	3868682b 	ldrb	w11, [x1, x8]
   d872c:	6b09017f 	cmp	w11, w9
   d8730:	540004c0 	b.eq	d87c8 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xd4>  // b.none
   d8734:	91000508 	add	x8, x8, #0x1
   d8738:	eb08015f 	cmp	x10, x8
   d873c:	54ffff61 	b.ne	d8728 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x34>  // b.any
   d8740:	d100404b 	sub	x11, x2, #0x10
   d8744:	aa0a03e8 	mov	x8, x10
   d8748:	eb0b015f 	cmp	x10, x11
   d874c:	540002a8 	b.hi	d87a0 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xac>  // b.pmore
   d8750:	b200c3e8 	mov	x8, #0x101010101010101     	// #72340172838076673
   d8754:	b200c3ed 	mov	x13, #0x101010101010101     	// #72340172838076673
   d8758:	b201c3ee 	mov	x14, #0x8080808080808080    	// #-9187201950435737472
   d875c:	9b087d2c 	mul	x12, x9, x8
   d8760:	f280200d 	movk	x13, #0x100
   d8764:	aa0a03e8 	mov	x8, x10
   d8768:	8b08002a 	add	x10, x1, x8
   d876c:	a940294f 	ldp	x15, x10, [x10]
   d8770:	ca0c01ef 	eor	x15, x15, x12
   d8774:	ca0c014a 	eor	x10, x10, x12
   d8778:	cb0f01b0 	sub	x16, x13, x15
   d877c:	cb0a01b1 	sub	x17, x13, x10
   d8780:	aa0f020f 	orr	x15, x16, x15
   d8784:	aa0a022a 	orr	x10, x17, x10
   d8788:	8a0a01ea 	and	x10, x15, x10
   d878c:	ea2a01df 	bics	xzr, x14, x10
   d8790:	54000081 	b.ne	d87a0 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xac>  // b.any
   d8794:	91004108 	add	x8, x8, #0x10
   d8798:	eb0b011f 	cmp	x8, x11
   d879c:	54fffe69 	b.ls	d8768 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x74>  // b.plast
   d87a0:	eb08005f 	cmp	x2, x8
   d87a4:	54000100 	b.eq	d87c4 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xd0>  // b.none
   d87a8:	52800020 	mov	w0, #0x1                   	// #1
   d87ac:	3868682a 	ldrb	w10, [x1, x8]
   d87b0:	6b09015f 	cmp	w10, w9
   d87b4:	540000a0 	b.eq	d87c8 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xd4>  // b.none
   d87b8:	91000508 	add	x8, x8, #0x1
   d87bc:	eb08005f 	cmp	x2, x8
   d87c0:	54ffff61 	b.ne	d87ac <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xb8>  // b.any
   d87c4:	aa1f03e0 	mov	x0, xzr
   d87c8:	aa0803e1 	mov	x1, x8
   d87cc:	d65f03c0 	ret

Disassembly of section .fini:
