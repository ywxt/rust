
/tmp/contains-arm-mask-abi-20261106/sysroots/optimized/lib/rustlib/aarch64-unknown-linux-gnu/lib/libstd-7a2f7be1a1e543fc.so:     file format elf64-littleaarch64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

00000000000d96ec <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned>:
   d96ec:	91001c28 	add	x8, x1, #0x7
   d96f0:	12001c09 	and	w9, w0, #0xff
   d96f4:	927df108 	and	x8, x8, #0xfffffffffffffff8
   d96f8:	eb010108 	subs	x8, x8, x1
   d96fc:	54000081 	b.ne	d970c <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x20>  // b.any
   d9700:	aa1f03ea 	mov	x10, xzr
   d9704:	d100404b 	sub	x11, x2, #0x10
   d9708:	14000010 	b	d9748 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x5c>
   d970c:	eb08005f 	cmp	x2, x8
   d9710:	9a88304a 	csel	x10, x2, x8, cc	// cc = lo, ul, last
   d9714:	b4000122 	cbz	x2, d9738 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x4c>
   d9718:	aa1f03e8 	mov	x8, xzr
   d971c:	52800020 	mov	w0, #0x1                   	// #1
   d9720:	3868682b 	ldrb	w11, [x1, x8]
   d9724:	6b09017f 	cmp	w11, w9
   d9728:	540004c0 	b.eq	d97c0 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xd4>  // b.none
   d972c:	91000508 	add	x8, x8, #0x1
   d9730:	eb08015f 	cmp	x10, x8
   d9734:	54ffff61 	b.ne	d9720 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x34>  // b.any
   d9738:	d100404b 	sub	x11, x2, #0x10
   d973c:	aa0a03e8 	mov	x8, x10
   d9740:	eb0b015f 	cmp	x10, x11
   d9744:	540002a8 	b.hi	d9798 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xac>  // b.pmore
   d9748:	b200c3e8 	mov	x8, #0x101010101010101     	// #72340172838076673
   d974c:	b200c3ed 	mov	x13, #0x101010101010101     	// #72340172838076673
   d9750:	b201c3ee 	mov	x14, #0x8080808080808080    	// #-9187201950435737472
   d9754:	9b087d2c 	mul	x12, x9, x8
   d9758:	f280200d 	movk	x13, #0x100
   d975c:	aa0a03e8 	mov	x8, x10
   d9760:	8b08002a 	add	x10, x1, x8
   d9764:	a940294f 	ldp	x15, x10, [x10]
   d9768:	ca0c01ef 	eor	x15, x15, x12
   d976c:	ca0c014a 	eor	x10, x10, x12
   d9770:	cb0f01b0 	sub	x16, x13, x15
   d9774:	cb0a01b1 	sub	x17, x13, x10
   d9778:	aa0f020f 	orr	x15, x16, x15
   d977c:	aa0a022a 	orr	x10, x17, x10
   d9780:	8a0a01ea 	and	x10, x15, x10
   d9784:	ea2a01df 	bics	xzr, x14, x10
   d9788:	54000081 	b.ne	d9798 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xac>  // b.any
   d978c:	91004108 	add	x8, x8, #0x10
   d9790:	eb0b011f 	cmp	x8, x11
   d9794:	54fffe69 	b.ls	d9760 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0x74>  // b.plast
   d9798:	eb08005f 	cmp	x2, x8
   d979c:	54000100 	b.eq	d97bc <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xd0>  // b.none
   d97a0:	52800020 	mov	w0, #0x1                   	// #1
   d97a4:	3868682a 	ldrb	w10, [x1, x8]
   d97a8:	6b09015f 	cmp	w10, w9
   d97ac:	540000a0 	b.eq	d97c0 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xd4>  // b.none
   d97b0:	91000508 	add	x8, x8, #0x1
   d97b4:	eb08005f 	cmp	x2, x8
   d97b8:	54ffff61 	b.ne	d97a4 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned+0xb8>  // b.any
   d97bc:	aa1f03e0 	mov	x0, xzr
   d97c0:	aa0803e1 	mov	x1, x8
   d97c4:	d65f03c0 	ret

Disassembly of section .fini:
