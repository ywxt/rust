0000000000009804 <probe::pair_value>:
    9804:	b4000520 	cbz	x0, 98a8 <probe::pair_value+0xa4>
    9808:	d101c3ff 	sub	sp, sp, #0x70
    980c:	a9027bfd 	stp	x29, x30, [sp, #32]
    9810:	f9001bf9 	str	x25, [sp, #48]
    9814:	a9045ff8 	stp	x24, x23, [sp, #64]
    9818:	a90557f6 	stp	x22, x21, [sp, #80]
    981c:	a9064ff4 	stp	x20, x19, [sp, #96]
    9820:	910083fd 	add	x29, sp, #0x20
    9824:	d282b1f7 	mov	x23, #0x158f                	// #5519
    9828:	d28d1d78 	mov	x24, #0x68eb                	// #26859
    982c:	aa0003f3 	mov	x19, x0
    9830:	f2bc43f7 	movk	x23, #0xe21f, lsl #16
    9834:	f2b8bbd8 	movk	x24, #0xc5de, lsl #16
    9838:	910023f4 	add	x20, sp, #0x8
    983c:	f2d46337 	movk	x23, #0xa319, lsl #32
    9840:	f2d036d8 	movk	x24, #0x81b6, lsl #32
    9844:	900002b5 	adrp	x21, 5d000 <GCC_except_table5+0x10bf0>
    9848:	913982b5 	add	x21, x21, #0xe60
    984c:	910043f6 	add	x22, sp, #0x10
    9850:	f2edceb7 	movk	x23, #0x6e75, lsl #48
    9854:	f2f36678 	movk	x24, #0x9b33, lsl #48
    9858:	910073b9 	add	x25, x29, #0x1c
    985c:	f90007ff 	str	xzr, [sp, #8]
    9860:	f9000bf4 	str	x20, [sp, #16]
    9864:	f9000ff5 	str	x21, [sp, #24]
    9868:	f9400fe8 	ldr	x8, [sp, #24]
    986c:	f9400be0 	ldr	x0, [sp, #16]
    9870:	f9400d08 	ldr	x8, [x8, #24]
    9874:	d63f0100 	blr	x8
    9878:	eb17001f 	cmp	x0, x23
    987c:	fa580020 	ccmp	x1, x24, #0x0, eq	// eq = none
    9880:	1a9f17e8 	cset	w8, eq	// eq = none
    9884:	f1000673 	subs	x19, x19, #0x1
    9888:	390073a8 	strb	w8, [x29, #28]
    988c:	54fffe81 	b.ne	985c <probe::pair_value+0x58>  // b.any
    9890:	a9464ff4 	ldp	x20, x19, [sp, #96]
    9894:	f9401bf9 	ldr	x25, [sp, #48]
    9898:	a94557f6 	ldp	x22, x21, [sp, #80]
    989c:	a9445ff8 	ldp	x24, x23, [sp, #64]
    98a0:	a9427bfd 	ldp	x29, x30, [sp, #32]
    98a4:	9101c3ff 	add	sp, sp, #0x70
    98a8:	d65f03c0 	ret

00000000000098ac <probe::persistent>:
    98ac:	d101c3ff 	sub	sp, sp, #0x70
    98b0:	a9037bfd 	stp	x29, x30, [sp, #48]
    98b4:	a9045ff8 	stp	x24, x23, [sp, #64]
    98b8:	a90557f6 	stp	x22, x21, [sp, #80]
    98bc:	a9064ff4 	stp	x20, x19, [sp, #96]
    98c0:	9100c3fd 	add	x29, sp, #0x30
    98c4:	910023e8 	add	x8, sp, #0x8
    98c8:	900002a9 	adrp	x9, 5d000 <GCC_except_table5+0x10bf0>
    98cc:	91388129 	add	x9, x9, #0xe20
    98d0:	f90007ff 	str	xzr, [sp, #8]
    98d4:	f9000be8 	str	x8, [sp, #16]
    98d8:	f9000fe9 	str	x9, [sp, #24]
    98dc:	b4000460 	cbz	x0, 9968 <probe::persistent+0xbc>
    98e0:	d28d1d77 	mov	x23, #0x68eb                	// #26859
    98e4:	d282b1f8 	mov	x24, #0x158f                	// #5519
    98e8:	aa0003f3 	mov	x19, x0
    98ec:	f2b8bbd7 	movk	x23, #0xc5de, lsl #16
    98f0:	f2bc43f8 	movk	x24, #0xe21f, lsl #16
    98f4:	910043f5 	add	x21, sp, #0x10
    98f8:	f2d036d7 	movk	x23, #0x81b6, lsl #32
    98fc:	f2d46338 	movk	x24, #0xa319, lsl #32
    9900:	d10043b6 	sub	x22, x29, #0x10
    9904:	f2f36677 	movk	x23, #0x9b33, lsl #48
    9908:	f2edceb8 	movk	x24, #0x6e75, lsl #48
    990c:	14000007 	b	9928 <probe::persistent+0x7c>
    9910:	f9400288 	ldr	x8, [x20]
    9914:	f100011f 	cmp	x8, #0x0
    9918:	1a9f17e8 	cset	w8, eq	// eq = none
    991c:	381f03a8 	sturb	w8, [x29, #-16]
    9920:	f1000673 	subs	x19, x19, #0x1
    9924:	54000220 	b.eq	9968 <probe::persistent+0xbc>  // b.none
    9928:	f81f03b5 	stur	x21, [x29, #-16]
    992c:	f9400fe8 	ldr	x8, [sp, #24]
    9930:	f9400bf4 	ldr	x20, [sp, #16]
    9934:	f9400d09 	ldr	x9, [x8, #24]
    9938:	d10043a8 	sub	x8, x29, #0x10
    993c:	aa1403e0 	mov	x0, x20
    9940:	d63f0120 	blr	x9
    9944:	f85f03a8 	ldur	x8, [x29, #-16]
    9948:	f85f83a9 	ldur	x9, [x29, #-8]
    994c:	ca170129 	eor	x9, x9, x23
    9950:	ca180108 	eor	x8, x8, x24
    9954:	aa090108 	orr	x8, x8, x9
    9958:	b4fffdc8 	cbz	x8, 9910 <probe::persistent+0x64>
    995c:	381f03bf 	sturb	wzr, [x29, #-16]
    9960:	f1000673 	subs	x19, x19, #0x1
    9964:	54fffe21 	b.ne	9928 <probe::persistent+0x7c>  // b.any
    9968:	a9464ff4 	ldp	x20, x19, [sp, #96]
    996c:	a94557f6 	ldp	x22, x21, [sp, #80]
    9970:	a9445ff8 	ldp	x24, x23, [sp, #64]
    9974:	a9437bfd 	ldp	x29, x30, [sp, #48]
    9978:	9101c3ff 	add	sp, sp, #0x70
    997c:	d65f03c0 	ret

0000000000009980 <probe::value_wide>:
    9980:	b4000680 	cbz	x0, 9a50 <probe::value_wide+0xd0>
    9984:	d101c3ff 	sub	sp, sp, #0x70
    9988:	a9027bfd 	stp	x29, x30, [sp, #32]
    998c:	f9001bf9 	str	x25, [sp, #48]
    9990:	a9045ff8 	stp	x24, x23, [sp, #64]
    9994:	a90557f6 	stp	x22, x21, [sp, #80]
    9998:	a9064ff4 	stp	x20, x19, [sp, #96]
    999c:	910083fd 	add	x29, sp, #0x20
    99a0:	d28d1d78 	mov	x24, #0x68eb                	// #26859
    99a4:	d282b1f9 	mov	x25, #0x158f                	// #5519
    99a8:	aa0003f3 	mov	x19, x0
    99ac:	f2b8bbd8 	movk	x24, #0xc5de, lsl #16
    99b0:	f2bc43f9 	movk	x25, #0xe21f, lsl #16
    99b4:	910063b4 	add	x20, x29, #0x18
    99b8:	f2d036d8 	movk	x24, #0x81b6, lsl #32
    99bc:	f2d46339 	movk	x25, #0xa319, lsl #32
    99c0:	900002b5 	adrp	x21, 5d000 <GCC_except_table5+0x10bf0>
    99c4:	913882b5 	add	x21, x21, #0xe20
    99c8:	910003f6 	mov	x22, sp
    99cc:	910043f7 	add	x23, sp, #0x10
    99d0:	f2f36678 	movk	x24, #0x9b33, lsl #48
    99d4:	f2edceb9 	movk	x25, #0x6e75, lsl #48
    99d8:	14000004 	b	99e8 <probe::value_wide+0x68>
    99dc:	f9000be8 	str	x8, [sp, #16]
    99e0:	f1000673 	subs	x19, x19, #0x1
    99e4:	540002a0 	b.eq	9a38 <probe::value_wide+0xb8>  // b.none
    99e8:	f9000fbf 	str	xzr, [x29, #24]
    99ec:	f90003f4 	str	x20, [sp]
    99f0:	f90007f5 	str	x21, [sp, #8]
    99f4:	f94007e8 	ldr	x8, [sp, #8]
    99f8:	f94003e0 	ldr	x0, [sp]
    99fc:	f9400d09 	ldr	x9, [x8, #24]
    9a00:	910043e8 	add	x8, sp, #0x10
    9a04:	d63f0120 	blr	x9
    9a08:	f9400be8 	ldr	x8, [sp, #16]
    9a0c:	f9400fe9 	ldr	x9, [sp, #24]
    9a10:	ca180129 	eor	x9, x9, x24
    9a14:	ca190108 	eor	x8, x8, x25
    9a18:	aa090109 	orr	x9, x8, x9
    9a1c:	aa1f03e8 	mov	x8, xzr
    9a20:	b5fffde9 	cbnz	x9, 99dc <probe::value_wide+0x5c>
    9a24:	f94003e8 	ldr	x8, [sp]
    9a28:	f9400108 	ldr	x8, [x8]
    9a2c:	f100011f 	cmp	x8, #0x0
    9a30:	1a9f17e8 	cset	w8, eq	// eq = none
    9a34:	17ffffea 	b	99dc <probe::value_wide+0x5c>
    9a38:	a9464ff4 	ldp	x20, x19, [sp, #96]
    9a3c:	f9401bf9 	ldr	x25, [sp, #48]
    9a40:	a94557f6 	ldp	x22, x21, [sp, #80]
    9a44:	a9445ff8 	ldp	x24, x23, [sp, #64]
    9a48:	a9427bfd 	ldp	x29, x30, [sp, #32]
    9a4c:	9101c3ff 	add	sp, sp, #0x70
    9a50:	d65f03c0 	ret

0000000000009a54 <probe::array_value>:
    9a54:	b4000580 	cbz	x0, 9b04 <probe::array_value+0xb0>
    9a58:	d10203ff 	sub	sp, sp, #0x80
    9a5c:	a9037bfd 	stp	x29, x30, [sp, #48]
    9a60:	f90023f9 	str	x25, [sp, #64]
    9a64:	a9055ff8 	stp	x24, x23, [sp, #80]
    9a68:	a90657f6 	stp	x22, x21, [sp, #96]
    9a6c:	a9074ff4 	stp	x20, x19, [sp, #112]
    9a70:	9100c3fd 	add	x29, sp, #0x30
    9a74:	d282b1f7 	mov	x23, #0x158f                	// #5519
    9a78:	d28d1d78 	mov	x24, #0x68eb                	// #26859
    9a7c:	aa0003f3 	mov	x19, x0
    9a80:	f2bc43f7 	movk	x23, #0xe21f, lsl #16
    9a84:	f2b8bbd8 	movk	x24, #0xc5de, lsl #16
    9a88:	910023f4 	add	x20, sp, #0x8
    9a8c:	f2d46337 	movk	x23, #0xa319, lsl #32
    9a90:	f2d036d8 	movk	x24, #0x81b6, lsl #32
    9a94:	900002b5 	adrp	x21, 5d000 <GCC_except_table5+0x10bf0>
    9a98:	913902b5 	add	x21, x21, #0xe40
    9a9c:	910043f6 	add	x22, sp, #0x10
    9aa0:	f2edceb7 	movk	x23, #0x6e75, lsl #48
    9aa4:	f2f36678 	movk	x24, #0x9b33, lsl #48
    9aa8:	910073b9 	add	x25, x29, #0x1c
    9aac:	f90007ff 	str	xzr, [sp, #8]
    9ab0:	f9000bf4 	str	x20, [sp, #16]
    9ab4:	f9000ff5 	str	x21, [sp, #24]
    9ab8:	f9400fe8 	ldr	x8, [sp, #24]
    9abc:	f9400be0 	ldr	x0, [sp, #16]
    9ac0:	f9400d09 	ldr	x9, [x8, #24]
    9ac4:	d10043a8 	sub	x8, x29, #0x10
    9ac8:	d63f0120 	blr	x9
    9acc:	f85f03a8 	ldur	x8, [x29, #-16]
    9ad0:	f85f83a9 	ldur	x9, [x29, #-8]
    9ad4:	eb17011f 	cmp	x8, x23
    9ad8:	fa580120 	ccmp	x9, x24, #0x0, eq	// eq = none
    9adc:	1a9f17e8 	cset	w8, eq	// eq = none
    9ae0:	f1000673 	subs	x19, x19, #0x1
    9ae4:	390073a8 	strb	w8, [x29, #28]
    9ae8:	54fffe21 	b.ne	9aac <probe::array_value+0x58>  // b.any
    9aec:	a9474ff4 	ldp	x20, x19, [sp, #112]
    9af0:	f94023f9 	ldr	x25, [sp, #64]
    9af4:	a94657f6 	ldp	x22, x21, [sp, #96]
    9af8:	a9455ff8 	ldp	x24, x23, [sp, #80]
    9afc:	a9437bfd 	ldp	x29, x30, [sp, #48]
    9b00:	910203ff 	add	sp, sp, #0x80
    9b04:	d65f03c0 	ret

0000000000009b08 <probe::persistent_wide>:
    9b08:	d101c3ff 	sub	sp, sp, #0x70
    9b0c:	a9037bfd 	stp	x29, x30, [sp, #48]
    9b10:	a9045ff8 	stp	x24, x23, [sp, #64]
    9b14:	a90557f6 	stp	x22, x21, [sp, #80]
    9b18:	a9064ff4 	stp	x20, x19, [sp, #96]
    9b1c:	9100c3fd 	add	x29, sp, #0x30
    9b20:	910023e8 	add	x8, sp, #0x8
    9b24:	900002a9 	adrp	x9, 5d000 <GCC_except_table5+0x10bf0>
    9b28:	91388129 	add	x9, x9, #0xe20
    9b2c:	f90007ff 	str	xzr, [sp, #8]
    9b30:	f9000be8 	str	x8, [sp, #16]
    9b34:	f9000fe9 	str	x9, [sp, #24]
    9b38:	b4000460 	cbz	x0, 9bc4 <probe::persistent_wide+0xbc>
    9b3c:	d28d1d77 	mov	x23, #0x68eb                	// #26859
    9b40:	d282b1f8 	mov	x24, #0x158f                	// #5519
    9b44:	aa0003f3 	mov	x19, x0
    9b48:	f2b8bbd7 	movk	x23, #0xc5de, lsl #16
    9b4c:	f2bc43f8 	movk	x24, #0xe21f, lsl #16
    9b50:	910043f5 	add	x21, sp, #0x10
    9b54:	f2d036d7 	movk	x23, #0x81b6, lsl #32
    9b58:	f2d46338 	movk	x24, #0xa319, lsl #32
    9b5c:	d10043b6 	sub	x22, x29, #0x10
    9b60:	f2f36677 	movk	x23, #0x9b33, lsl #48
    9b64:	f2edceb8 	movk	x24, #0x6e75, lsl #48
    9b68:	14000007 	b	9b84 <probe::persistent_wide+0x7c>
    9b6c:	f9400288 	ldr	x8, [x20]
    9b70:	f100011f 	cmp	x8, #0x0
    9b74:	1a9f17e8 	cset	w8, eq	// eq = none
    9b78:	f81f03a8 	stur	x8, [x29, #-16]
    9b7c:	f1000673 	subs	x19, x19, #0x1
    9b80:	54000220 	b.eq	9bc4 <probe::persistent_wide+0xbc>  // b.none
    9b84:	f81f03b5 	stur	x21, [x29, #-16]
    9b88:	f9400fe8 	ldr	x8, [sp, #24]
    9b8c:	f9400bf4 	ldr	x20, [sp, #16]
    9b90:	f9400d09 	ldr	x9, [x8, #24]
    9b94:	d10043a8 	sub	x8, x29, #0x10
    9b98:	aa1403e0 	mov	x0, x20
    9b9c:	d63f0120 	blr	x9
    9ba0:	f85f03a8 	ldur	x8, [x29, #-16]
    9ba4:	f85f83a9 	ldur	x9, [x29, #-8]
    9ba8:	ca170129 	eor	x9, x9, x23
    9bac:	ca180108 	eor	x8, x8, x24
    9bb0:	aa090108 	orr	x8, x8, x9
    9bb4:	b4fffdc8 	cbz	x8, 9b6c <probe::persistent_wide+0x64>
    9bb8:	f81f03bf 	stur	xzr, [x29, #-16]
    9bbc:	f1000673 	subs	x19, x19, #0x1
    9bc0:	54fffe21 	b.ne	9b84 <probe::persistent_wide+0x7c>  // b.any
    9bc4:	a9464ff4 	ldp	x20, x19, [sp, #96]
    9bc8:	a94557f6 	ldp	x22, x21, [sp, #80]
    9bcc:	a9445ff8 	ldp	x24, x23, [sp, #64]
    9bd0:	a9437bfd 	ldp	x29, x30, [sp, #48]
    9bd4:	9101c3ff 	add	sp, sp, #0x70
    9bd8:	d65f03c0 	ret

0000000000009bdc <probe::repeated_boundary>:
    9bdc:	b4000440 	cbz	x0, 9c64 <probe::repeated_boundary+0x88>
    9be0:	d10143ff 	sub	sp, sp, #0x50
    9be4:	a9017bfd 	stp	x29, x30, [sp, #16]
    9be8:	f90013f7 	str	x23, [sp, #32]
    9bec:	a90357f6 	stp	x22, x21, [sp, #48]
    9bf0:	a9044ff4 	stp	x20, x19, [sp, #64]
    9bf4:	910043fd 	add	x29, sp, #0x10
    9bf8:	aa0203f3 	mov	x19, x2
    9bfc:	aa0003f4 	mov	x20, x0
    9c00:	aa0103f5 	mov	x21, x1
    9c04:	910003f6 	mov	x22, sp
    9c08:	910073b7 	add	x23, x29, #0x1c
    9c0c:	14000004 	b	9c1c <probe::repeated_boundary+0x40>
    9c10:	390073bf 	strb	wzr, [x29, #28]
    9c14:	f1000694 	subs	x20, x20, #0x1
    9c18:	540001c0 	b.eq	9c50 <probe::repeated_boundary+0x74>  // b.none
    9c1c:	f90003f5 	str	x21, [sp]
    9c20:	f90007f3 	str	x19, [sp, #8]
    9c24:	f94007e8 	ldr	x8, [sp, #8]
    9c28:	f94003e0 	ldr	x0, [sp]
    9c2c:	f9400d01 	ldr	x1, [x8, #24]
    9c30:	9400030d 	bl	a864 <probe::isolated>
    9c34:	b4fffee0 	cbz	x0, 9c10 <probe::repeated_boundary+0x34>
    9c38:	f9400008 	ldr	x8, [x0]
    9c3c:	f100011f 	cmp	x8, #0x0
    9c40:	1a9f17e8 	cset	w8, eq	// eq = none
    9c44:	390073a8 	strb	w8, [x29, #28]
    9c48:	f1000694 	subs	x20, x20, #0x1
    9c4c:	54fffe81 	b.ne	9c1c <probe::repeated_boundary+0x40>  // b.any
    9c50:	a9444ff4 	ldp	x20, x19, [sp, #64]
    9c54:	f94013f7 	ldr	x23, [sp, #32]
    9c58:	a94357f6 	ldp	x22, x21, [sp, #48]
    9c5c:	a9417bfd 	ldp	x29, x30, [sp, #16]
    9c60:	910143ff 	add	sp, sp, #0x50
    9c64:	d65f03c0 	ret

0000000000009c68 <probe::base>:
    9c68:	b40006c0 	cbz	x0, 9d40 <probe::base+0xd8>
    9c6c:	d10203ff 	sub	sp, sp, #0x80
    9c70:	a9037bfd 	stp	x29, x30, [sp, #48]
    9c74:	a90467fa 	stp	x26, x25, [sp, #64]
    9c78:	a9055ff8 	stp	x24, x23, [sp, #80]
    9c7c:	a90657f6 	stp	x22, x21, [sp, #96]
    9c80:	a9074ff4 	stp	x20, x19, [sp, #112]
    9c84:	9100c3fd 	add	x29, sp, #0x30
    9c88:	d28d1d79 	mov	x25, #0x68eb                	// #26859
    9c8c:	d282b1fa 	mov	x26, #0x158f                	// #5519
    9c90:	aa0003f3 	mov	x19, x0
    9c94:	f2b8bbd9 	movk	x25, #0xc5de, lsl #16
    9c98:	f2bc43fa 	movk	x26, #0xe21f, lsl #16
    9c9c:	910023f5 	add	x21, sp, #0x8
    9ca0:	f2d036d9 	movk	x25, #0x81b6, lsl #32
    9ca4:	f2d4633a 	movk	x26, #0xa319, lsl #32
    9ca8:	900002b6 	adrp	x22, 5d000 <GCC_except_table5+0x10bf0>
    9cac:	913882d6 	add	x22, x22, #0xe20
    9cb0:	910043f7 	add	x23, sp, #0x10
    9cb4:	d10043b8 	sub	x24, x29, #0x10
    9cb8:	f2f36679 	movk	x25, #0x9b33, lsl #48
    9cbc:	f2edceba 	movk	x26, #0x6e75, lsl #48
    9cc0:	14000007 	b	9cdc <probe::base+0x74>
    9cc4:	f9400288 	ldr	x8, [x20]
    9cc8:	f100011f 	cmp	x8, #0x0
    9ccc:	1a9f17e8 	cset	w8, eq	// eq = none
    9cd0:	381f03a8 	sturb	w8, [x29, #-16]
    9cd4:	f1000673 	subs	x19, x19, #0x1
    9cd8:	54000280 	b.eq	9d28 <probe::base+0xc0>  // b.none
    9cdc:	f90007ff 	str	xzr, [sp, #8]
    9ce0:	f9000bf5 	str	x21, [sp, #16]
    9ce4:	f9000ff6 	str	x22, [sp, #24]
    9ce8:	f81f03b7 	stur	x23, [x29, #-16]
    9cec:	f9400fe8 	ldr	x8, [sp, #24]
    9cf0:	f9400bf4 	ldr	x20, [sp, #16]
    9cf4:	f9400d09 	ldr	x9, [x8, #24]
    9cf8:	d10043a8 	sub	x8, x29, #0x10
    9cfc:	aa1403e0 	mov	x0, x20
    9d00:	d63f0120 	blr	x9
    9d04:	f85f03a8 	ldur	x8, [x29, #-16]
    9d08:	f85f83a9 	ldur	x9, [x29, #-8]
    9d0c:	ca190129 	eor	x9, x9, x25
    9d10:	ca1a0108 	eor	x8, x8, x26
    9d14:	aa090108 	orr	x8, x8, x9
    9d18:	b4fffd68 	cbz	x8, 9cc4 <probe::base+0x5c>
    9d1c:	381f03bf 	sturb	wzr, [x29, #-16]
    9d20:	f1000673 	subs	x19, x19, #0x1
    9d24:	54fffdc1 	b.ne	9cdc <probe::base+0x74>  // b.any
    9d28:	a9474ff4 	ldp	x20, x19, [sp, #112]
    9d2c:	a94657f6 	ldp	x22, x21, [sp, #96]
    9d30:	a9455ff8 	ldp	x24, x23, [sp, #80]
    9d34:	a94467fa 	ldp	x26, x25, [sp, #64]
    9d38:	a9437bfd 	ldp	x29, x30, [sp, #48]
    9d3c:	910203ff 	add	sp, sp, #0x80
    9d40:	d65f03c0 	ret

0000000000009d44 <probe::main>:
    9d44:	d10283ff 	sub	sp, sp, #0xa0
    9d48:	a9057bfd 	stp	x29, x30, [sp, #80]
    9d4c:	f90033f9 	str	x25, [sp, #96]
    9d50:	a9075ff8 	stp	x24, x23, [sp, #112]
    9d54:	a90857f6 	stp	x22, x21, [sp, #128]
    9d58:	a9094ff4 	stp	x20, x19, [sp, #144]
    9d5c:	910143fd 	add	x29, sp, #0x50
    9d60:	910003e8 	mov	x8, sp
    9d64:	940066ff 	bl	23960 <std::env::args>
    9d68:	f90013ff 	str	xzr, [sp, #32]
    9d6c:	9100a3e8 	add	x8, sp, #0x28
    9d70:	910003e0 	mov	x0, sp
    9d74:	94007b27 	bl	28a10 <<std::env::Args as core::iter::traits::iterator::Iterator>::next>
    9d78:	f94017e1 	ldr	x1, [sp, #40]
    9d7c:	b40000c1 	cbz	x1, 9d94 <probe::main+0x50>
    9d80:	b100043f 	cmn	x1, #0x1
    9d84:	54003500 	b.eq	a424 <probe::main+0x6e0>  // b.none
    9d88:	f9401be0 	ldr	x0, [sp, #48]
    9d8c:	52800022 	mov	w2, #0x1                   	// #1
    9d90:	94000379 	bl	ab74 <__rustc::__rust_dealloc>
    9d94:	9100a3e8 	add	x8, sp, #0x28
    9d98:	910003e0 	mov	x0, sp
    9d9c:	94007b1d 	bl	28a10 <<std::env::Args as core::iter::traits::iterator::Iterator>::next>
    9da0:	f94017f3 	ldr	x19, [sp, #40]
    9da4:	b100067f 	cmn	x19, #0x1
    9da8:	540033e0 	b.eq	a424 <probe::main+0x6e0>  // b.none
    9dac:	f9401ff8 	ldr	x24, [sp, #56]
    9db0:	f9401bf4 	ldr	x20, [sp, #48]
    9db4:	f100171f 	cmp	x24, #0x5
    9db8:	54000101 	b.ne	9dd8 <probe::main+0x94>  // b.any
    9dbc:	39401288 	ldrb	w8, [x20, #4]
    9dc0:	b9400289 	ldr	w9, [x20]
    9dc4:	7101ad1f 	cmp	w8, #0x6b
    9dc8:	528d0c68 	mov	w8, #0x6863                	// #26723
    9dcc:	72ac6ca8 	movk	w8, #0x6365, lsl #16
    9dd0:	7a480120 	ccmp	w9, w8, #0x0, eq	// eq = none
    9dd4:	54001460 	b.eq	a060 <probe::main+0x31c>  // b.none
    9dd8:	f94013e1 	ldr	x1, [sp, #32]
    9ddc:	b50032c1 	cbnz	x1, a434 <probe::main+0x6f0>
    9de0:	9100a3e8 	add	x8, sp, #0x28
    9de4:	910003e0 	mov	x0, sp
    9de8:	94007b0a 	bl	28a10 <<std::env::Args as core::iter::traits::iterator::Iterator>::next>
    9dec:	f94017f6 	ldr	x22, [sp, #40]
    9df0:	b10006df 	cmn	x22, #0x1
    9df4:	54003280 	b.eq	a444 <probe::main+0x700>  // b.none
    9df8:	f9401fe8 	ldr	x8, [sp, #56]
    9dfc:	f9401bf7 	ldr	x23, [sp, #48]
    9e00:	f100051f 	cmp	x8, #0x1
    9e04:	54000080 	b.eq	9e14 <probe::main+0xd0>  // b.none
    9e08:	b4003468 	cbz	x8, a494 <probe::main+0x750>
    9e0c:	394002e9 	ldrb	w9, [x23]
    9e10:	14000007 	b	9e2c <probe::main+0xe8>
    9e14:	394002e9 	ldrb	w9, [x23]
    9e18:	52800020 	mov	w0, #0x1                   	// #1
    9e1c:	7100ad3f 	cmp	w9, #0x2b
    9e20:	54002f60 	b.eq	a40c <probe::main+0x6c8>  // b.none
    9e24:	7100b53f 	cmp	w9, #0x2d
    9e28:	54002f20 	b.eq	a40c <probe::main+0x6c8>  // b.none
    9e2c:	7100ad3f 	cmp	w9, #0x2b
    9e30:	1a9f17e9 	cset	w9, eq	// eq = none
    9e34:	cb090108 	sub	x8, x8, x9
    9e38:	9a9716e9 	cinc	x9, x23, eq	// eq = none
    9e3c:	f100451f 	cmp	x8, #0x11
    9e40:	540001c2 	b.cs	9e78 <probe::main+0x134>  // b.hs, b.nlast
    9e44:	aa1f03f5 	mov	x21, xzr
    9e48:	b4000368 	cbz	x8, 9eb4 <probe::main+0x170>
    9e4c:	5280014a 	mov	w10, #0xa                   	// #10
    9e50:	3940012b 	ldrb	w11, [x9]
    9e54:	5100c16b 	sub	w11, w11, #0x30
    9e58:	7100257f 	cmp	w11, #0x9
    9e5c:	54003128 	b.hi	a480 <probe::main+0x73c>  // b.pmore
    9e60:	9b0a7eac 	mul	x12, x21, x10
    9e64:	f1000508 	subs	x8, x8, #0x1
    9e68:	91000529 	add	x9, x9, #0x1
    9e6c:	8b2b4195 	add	x21, x12, w11, uxtw
    9e70:	54ffff01 	b.ne	9e50 <probe::main+0x10c>  // b.any
    9e74:	14000010 	b	9eb4 <probe::main+0x170>
    9e78:	aa1f03f5 	mov	x21, xzr
    9e7c:	5280014a 	mov	w10, #0xa                   	// #10
    9e80:	9bca7eac 	umulh	x12, x21, x10
    9e84:	3840152b 	ldrb	w11, [x9], #1
    9e88:	eb0c03ff 	cmp	xzr, x12
    9e8c:	54002b41 	b.ne	a3f4 <probe::main+0x6b0>  // b.any
    9e90:	5100c16b 	sub	w11, w11, #0x30
    9e94:	7100297f 	cmp	w11, #0xa
    9e98:	54002f42 	b.cs	a480 <probe::main+0x73c>  // b.hs, b.nlast
    9e9c:	8b150aac 	add	x12, x21, x21, lsl #2
    9ea0:	d37ff98c 	lsl	x12, x12, #1
    9ea4:	ab2b4195 	adds	x21, x12, w11, uxtw
    9ea8:	54002b02 	b.cs	a408 <probe::main+0x6c4>  // b.hs, b.nlast
    9eac:	d1000508 	sub	x8, x8, #0x1
    9eb0:	b5fffe88 	cbnz	x8, 9e80 <probe::main+0x13c>
    9eb4:	b40000b6 	cbz	x22, 9ec8 <probe::main+0x184>
    9eb8:	aa1703e0 	mov	x0, x23
    9ebc:	aa1603e1 	mov	x1, x22
    9ec0:	52800022 	mov	w2, #0x1                   	// #1
    9ec4:	9400032c 	bl	ab74 <__rustc::__rust_dealloc>
    9ec8:	f100271f 	cmp	x24, #0x9
    9ecc:	5400044d 	b.le	9f54 <probe::main+0x210>
    9ed0:	f1003b1f 	cmp	x24, #0xe
    9ed4:	5400080d 	b.le	9fd4 <probe::main+0x290>
    9ed8:	f1003f1f 	cmp	x24, #0xf
    9edc:	54001a40 	b.eq	a224 <probe::main+0x4e0>  // b.none
    9ee0:	f100471f 	cmp	x24, #0x11
    9ee4:	54002b81 	b.ne	a454 <probe::main+0x710>  // b.any
    9ee8:	39404288 	ldrb	w8, [x20, #16]
    9eec:	f9400689 	ldr	x9, [x20, #8]
    9ef0:	f940028a 	ldr	x10, [x20]
    9ef4:	7101e51f 	cmp	w8, #0x79
    9ef8:	d28c4be8 	mov	x8, #0x625f                	// #25183
    9efc:	f2aeade8 	movk	x8, #0x756f, lsl #16
    9f00:	f2cc8dc8 	movk	x8, #0x646e, lsl #32
    9f04:	f2ee4c28 	movk	x8, #0x7261, lsl #48
    9f08:	fa480120 	ccmp	x9, x8, #0x0, eq	// eq = none
    9f0c:	d28cae48 	mov	x8, #0x6572                	// #25970
    9f10:	f2acae08 	movk	x8, #0x6570, lsl #16
    9f14:	f2ce8c28 	movk	x8, #0x7461, lsl #32
    9f18:	f2ec8ca8 	movk	x8, #0x6465, lsl #48
    9f1c:	fa480140 	ccmp	x10, x8, #0x0, eq	// eq = none
    9f20:	540029a1 	b.ne	a454 <probe::main+0x710>  // b.any
    9f24:	b00001a8 	adrp	x8, 3e000 <_fini+0x1c40>
    9f28:	912a6108 	add	x8, x8, #0xa98
    9f2c:	900002a9 	adrp	x9, 5d000 <GCC_except_table5+0x10bf0>
    9f30:	91388129 	add	x9, x9, #0xe20
    9f34:	f90017e8 	str	x8, [sp, #40]
    9f38:	9100a3e8 	add	x8, sp, #0x28
    9f3c:	f9001be9 	str	x9, [sp, #48]
    9f40:	f94017e1 	ldr	x1, [sp, #40]
    9f44:	f9401be2 	ldr	x2, [sp, #48]
    9f48:	aa1503e0 	mov	x0, x21
    9f4c:	97ffff24 	bl	9bdc <probe::repeated_boundary>
    9f50:	14000103 	b	a35c <probe::main+0x618>
    9f54:	f100131f 	cmp	x24, #0x4
    9f58:	54001860 	b.eq	a264 <probe::main+0x520>  // b.none
    9f5c:	f100171f 	cmp	x24, #0x5
    9f60:	540019c0 	b.eq	a298 <probe::main+0x554>  // b.none
    9f64:	f100231f 	cmp	x24, #0x8
    9f68:	54002761 	b.ne	a454 <probe::main+0x710>  // b.any
    9f6c:	d28dec49 	mov	x9, #0x6f62                	// #28514
    9f70:	f9400288 	ldr	x8, [x20]
    9f74:	f2adcea9 	movk	x9, #0x6e75, lsl #16
    9f78:	f2cc2c89 	movk	x9, #0x6164, lsl #32
    9f7c:	f2ef2e49 	movk	x9, #0x7972, lsl #48
    9f80:	eb09011f 	cmp	x8, x9
    9f84:	54001e20 	b.eq	a348 <probe::main+0x604>  // b.none
    9f88:	d28cae49 	mov	x9, #0x6572                	// #25970
    9f8c:	f9400288 	ldr	x8, [x20]
    9f90:	f2acae09 	movk	x9, #0x6570, lsl #16
    9f94:	f2ce8c29 	movk	x9, #0x7461, lsl #32
    9f98:	f2ec8ca9 	movk	x9, #0x6465, lsl #48
    9f9c:	eb09011f 	cmp	x8, x9
    9fa0:	540025a1 	b.ne	a454 <probe::main+0x710>  // b.any
    9fa4:	b00001a8 	adrp	x8, 3e000 <_fini+0x1c40>
    9fa8:	912a6108 	add	x8, x8, #0xa98
    9fac:	900002a9 	adrp	x9, 5d000 <GCC_except_table5+0x10bf0>
    9fb0:	91388129 	add	x9, x9, #0xe20
    9fb4:	f90017e8 	str	x8, [sp, #40]
    9fb8:	9100a3e8 	add	x8, sp, #0x28
    9fbc:	f9001be9 	str	x9, [sp, #48]
    9fc0:	f94017e1 	ldr	x1, [sp, #40]
    9fc4:	f9401be2 	ldr	x2, [sp, #48]
    9fc8:	aa1503e0 	mov	x0, x21
    9fcc:	94000240 	bl	a8cc <probe::repeated>
    9fd0:	140000e3 	b	a35c <probe::main+0x618>
    9fd4:	f1002b1f 	cmp	x24, #0xa
    9fd8:	54001821 	b.ne	a2dc <probe::main+0x598>  // b.any
    9fdc:	d28cae0a 	mov	x10, #0x6570                	// #25968
    9fe0:	f9400288 	ldr	x8, [x20]
    9fe4:	79401289 	ldrh	w9, [x20, #8]
    9fe8:	f2ae6e4a 	movk	x10, #0x7372, lsl #16
    9fec:	f2ce6d2a 	movk	x10, #0x7369, lsl #32
    9ff0:	f2ecae8a 	movk	x10, #0x6574, lsl #48
    9ff4:	eb0a011f 	cmp	x8, x10
    9ff8:	528e8dc8 	mov	w8, #0x746e                	// #29806
    9ffc:	7a480120 	ccmp	w9, w8, #0x0, eq	// eq = none
    a000:	54001920 	b.eq	a324 <probe::main+0x5e0>  // b.none
    a004:	d28c2eca 	mov	x10, #0x6176                	// #24950
    a008:	f9400288 	ldr	x8, [x20]
    a00c:	79401289 	ldrh	w9, [x20, #8]
    a010:	f2aead8a 	movk	x10, #0x756c, lsl #16
    a014:	f2cbecaa 	movk	x10, #0x5f65, lsl #32
    a018:	f2ed2eea 	movk	x10, #0x6977, lsl #48
    a01c:	eb0a011f 	cmp	x8, x10
    a020:	528cac88 	mov	w8, #0x6564                	// #25956
    a024:	7a480120 	ccmp	w9, w8, #0x0, eq	// eq = none
    a028:	54001960 	b.eq	a354 <probe::main+0x610>  // b.none
    a02c:	d28c2e0a 	mov	x10, #0x6170                	// #24944
    a030:	f9400288 	ldr	x8, [x20]
    a034:	79401289 	ldrh	w9, [x20, #8]
    a038:	f2ae4d2a 	movk	x10, #0x7269, lsl #16
    a03c:	f2cecbea 	movk	x10, #0x765f, lsl #32
    a040:	f2ed8c2a 	movk	x10, #0x6c61, lsl #48
    a044:	eb0a011f 	cmp	x8, x10
    a048:	528caea8 	mov	w8, #0x6575                	// #25973
    a04c:	7a480120 	ccmp	w9, w8, #0x0, eq	// eq = none
    a050:	54002021 	b.ne	a454 <probe::main+0x710>  // b.any
    a054:	aa1503e0 	mov	x0, x21
    a058:	97fffdeb 	bl	9804 <probe::pair_value>
    a05c:	140000c0 	b	a35c <probe::main+0x618>
    a060:	90000015 	adrp	x21, a000 <probe::main+0x2bc>
    a064:	912672b5 	add	x21, x21, #0x99c
    a068:	92807ff8 	mov	x24, #0xfffffffffffffc00    	// #-1024
    a06c:	90000016 	adrp	x22, a000 <probe::main+0x2bc>
    a070:	912802d6 	add	x22, x22, #0xa00
    a074:	d10043b9 	sub	x25, x29, #0x10
    a078:	90000017 	adrp	x23, a000 <probe::main+0x2bc>
    a07c:	9126c2f7 	add	x23, x23, #0x9b0
    a080:	f81f03b8 	stur	x24, [x29, #-16]
    a084:	d10043a0 	sub	x0, x29, #0x10
    a088:	aa1503e1 	mov	x1, x21
    a08c:	940001f6 	bl	a864 <probe::isolated>
    a090:	f81f83a0 	stur	x0, [x29, #-8]
    a094:	f90017f9 	str	x25, [sp, #40]
    a098:	b4001be0 	cbz	x0, a414 <probe::main+0x6d0>
    a09c:	f9400008 	ldr	x8, [x0]
    a0a0:	f85f03a9 	ldur	x9, [x29, #-16]
    a0a4:	eb09011f 	cmp	x8, x9
    a0a8:	54001b61 	b.ne	a414 <probe::main+0x6d0>  // b.any
    a0ac:	f81f03b8 	stur	x24, [x29, #-16]
    a0b0:	d10043a0 	sub	x0, x29, #0x10
    a0b4:	aa1603e1 	mov	x1, x22
    a0b8:	940001eb 	bl	a864 <probe::isolated>
    a0bc:	f81f83a0 	stur	x0, [x29, #-8]
    a0c0:	f90017ff 	str	xzr, [sp, #40]
    a0c4:	b5001a80 	cbnz	x0, a414 <probe::main+0x6d0>
    a0c8:	f90017f8 	str	x24, [sp, #40]
    a0cc:	f9001bf8 	str	x24, [sp, #48]
    a0d0:	f9001ff8 	str	x24, [sp, #56]
    a0d4:	9100a3e0 	add	x0, sp, #0x28
    a0d8:	aa1703e1 	mov	x1, x23
    a0dc:	940001e2 	bl	a864 <probe::isolated>
    a0e0:	f81f03a0 	stur	x0, [x29, #-16]
    a0e4:	f81f83bf 	stur	xzr, [x29, #-8]
    a0e8:	b5001d00 	cbnz	x0, a488 <probe::main+0x744>
    a0ec:	91000718 	add	x24, x24, #0x1
    a0f0:	f110031f 	cmp	x24, #0x400
    a0f4:	54fffc61 	b.ne	a080 <probe::main+0x33c>  // b.any
    a0f8:	940002a2 	bl	ab80 <__rustc::__rust_no_alloc_shim_is_unstable_v2>
    a0fc:	52800080 	mov	w0, #0x4                   	// #4
    a100:	52800021 	mov	w1, #0x1                   	// #1
    a104:	9400029b 	bl	ab70 <__rustc::__rust_alloc>
    a108:	b4001b40 	cbz	x0, a470 <probe::main+0x72c>
    a10c:	528cae88 	mov	w8, #0x6574                	// #25972
    a110:	52800089 	mov	w9, #0x4                   	// #4
    a114:	f9001be0 	str	x0, [sp, #48]
    a118:	72ae8e68 	movk	w8, #0x7473, lsl #16
    a11c:	f90017e9 	str	x9, [sp, #40]
    a120:	b9000008 	str	w8, [x0]
    a124:	f9001fe9 	str	x9, [sp, #56]
    a128:	90000001 	adrp	x1, a000 <probe::main+0x2bc>
    a12c:	91276021 	add	x1, x1, #0x9d8
    a130:	9100a3e0 	add	x0, sp, #0x28
    a134:	940001cc 	bl	a864 <probe::isolated>
    a138:	f81f03a0 	stur	x0, [x29, #-16]
    a13c:	f81f83bf 	stur	xzr, [x29, #-8]
    a140:	b5001ae0 	cbnz	x0, a49c <probe::main+0x758>
    a144:	f94017e1 	ldr	x1, [sp, #40]
    a148:	b4000081 	cbz	x1, a158 <probe::main+0x414>
    a14c:	f9401be0 	ldr	x0, [sp, #48]
    a150:	52800022 	mov	w2, #0x1                   	// #1
    a154:	94000288 	bl	ab74 <__rustc::__rust_dealloc>
    a158:	52800028 	mov	w8, #0x1                   	// #1
    a15c:	f90017ff 	str	xzr, [sp, #40]
    a160:	f9001be8 	str	x8, [sp, #48]
    a164:	f9001fff 	str	xzr, [sp, #56]
    a168:	90000001 	adrp	x1, a000 <probe::main+0x2bc>
    a16c:	91271021 	add	x1, x1, #0x9c4
    a170:	9100a3e0 	add	x0, sp, #0x28
    a174:	940001bc 	bl	a864 <probe::isolated>
    a178:	f81f03a0 	stur	x0, [x29, #-16]
    a17c:	f81f83bf 	stur	xzr, [x29, #-8]
    a180:	b5001960 	cbnz	x0, a4ac <probe::main+0x768>
    a184:	f94017e1 	ldr	x1, [sp, #40]
    a188:	b4000081 	cbz	x1, a198 <probe::main+0x454>
    a18c:	f9401be0 	ldr	x0, [sp, #48]
    a190:	52800022 	mov	w2, #0x1                   	// #1
    a194:	94000278 	bl	ab74 <__rustc::__rust_dealloc>
    a198:	90000001 	adrp	x1, a000 <probe::main+0x2bc>
    a19c:	9127b021 	add	x1, x1, #0x9ec
    a1a0:	91007fa0 	add	x0, x29, #0x1f
    a1a4:	940001b0 	bl	a864 <probe::isolated>
    a1a8:	f81f83a0 	stur	x0, [x29, #-8]
    a1ac:	f90017ff 	str	xzr, [sp, #40]
    a1b0:	b5001320 	cbnz	x0, a414 <probe::main+0x6d0>
    a1b4:	900001a0 	adrp	x0, 3e000 <_fini+0x1c40>
    a1b8:	91326400 	add	x0, x0, #0xc99
    a1bc:	52800e61 	mov	w1, #0x73                  	// #115
    a1c0:	940068de 	bl	24538 <std::io::stdio::_print>
    a1c4:	b40000b3 	cbz	x19, a1d8 <probe::main+0x494>
    a1c8:	aa1403e0 	mov	x0, x20
    a1cc:	aa1303e1 	mov	x1, x19
    a1d0:	52800022 	mov	w2, #0x1                   	// #1
    a1d4:	94000268 	bl	ab74 <__rustc::__rust_dealloc>
    a1d8:	f94007e8 	ldr	x8, [sp, #8]
    a1dc:	f9400fe9 	ldr	x9, [sp, #24]
    a1e0:	eb080129 	subs	x9, x9, x8
    a1e4:	54000ec0 	b.eq	a3bc <probe::main+0x678>  // b.none
    a1e8:	b201f3ea 	mov	x10, #0xaaaaaaaaaaaaaaaa    	// #-6148914691236517206
    a1ec:	91002114 	add	x20, x8, #0x8
    a1f0:	f295556a 	movk	x10, #0xaaab
    a1f4:	9bca7d29 	umulh	x9, x9, x10
    a1f8:	d344fd33 	lsr	x19, x9, #4
    a1fc:	14000004 	b	a20c <probe::main+0x4c8>
    a200:	f1000673 	subs	x19, x19, #0x1
    a204:	91006294 	add	x20, x20, #0x18
    a208:	54000da0 	b.eq	a3bc <probe::main+0x678>  // b.none
    a20c:	f85f8281 	ldur	x1, [x20, #-8]
    a210:	b4ffff81 	cbz	x1, a200 <probe::main+0x4bc>
    a214:	f9400280 	ldr	x0, [x20]
    a218:	52800022 	mov	w2, #0x1                   	// #1
    a21c:	94000256 	bl	ab74 <__rustc::__rust_dealloc>
    a220:	17fffff8 	b	a200 <probe::main+0x4bc>
    a224:	d28cae0a 	mov	x10, #0x6570                	// #25968
    a228:	f9400288 	ldr	x8, [x20]
    a22c:	f8407289 	ldur	x9, [x20, #7]
    a230:	f2ae6e4a 	movk	x10, #0x7372, lsl #16
    a234:	f2ce6d2a 	movk	x10, #0x7369, lsl #32
    a238:	f2ecae8a 	movk	x10, #0x6574, lsl #48
    a23c:	eb0a011f 	cmp	x8, x10
    a240:	d28dcca8 	mov	x8, #0x6e65                	// #28261
    a244:	f2abee88 	movk	x8, #0x5f74, lsl #16
    a248:	f2cd2ee8 	movk	x8, #0x6977, lsl #32
    a24c:	f2ecac88 	movk	x8, #0x6564, lsl #48
    a250:	fa480120 	ccmp	x9, x8, #0x0, eq	// eq = none
    a254:	54001001 	b.ne	a454 <probe::main+0x710>  // b.any
    a258:	aa1503e0 	mov	x0, x21
    a25c:	97fffe2b 	bl	9b08 <probe::persistent_wide>
    a260:	1400003f 	b	a35c <probe::main+0x618>
    a264:	b9400288 	ldr	w8, [x20]
    a268:	528c2c49 	mov	w9, #0x6162                	// #24930
    a26c:	72acae69 	movk	w9, #0x6573, lsl #16
    a270:	6b09011f 	cmp	w8, w9
    a274:	540005e0 	b.eq	a330 <probe::main+0x5ec>  // b.none
    a278:	b9400288 	ldr	w8, [x20]
    a27c:	528c2e09 	mov	w9, #0x6170                	// #24944
    a280:	72ae4d29 	movk	w9, #0x7269, lsl #16
    a284:	6b09011f 	cmp	w8, w9
    a288:	54000e61 	b.ne	a454 <probe::main+0x710>  // b.any
    a28c:	aa1503e0 	mov	x0, x21
    a290:	940000bf 	bl	a58c <probe::pair>
    a294:	14000032 	b	a35c <probe::main+0x618>
    a298:	39401288 	ldrb	w8, [x20, #4]
    a29c:	b9400289 	ldr	w9, [x20]
    a2a0:	7101951f 	cmp	w8, #0x65
    a2a4:	528c2ec8 	mov	w8, #0x6176                	// #24950
    a2a8:	72aead88 	movk	w8, #0x756c, lsl #16
    a2ac:	7a480120 	ccmp	w9, w8, #0x0, eq	// eq = none
    a2b0:	54000460 	b.eq	a33c <probe::main+0x5f8>  // b.none
    a2b4:	39401288 	ldrb	w8, [x20, #4]
    a2b8:	b9400289 	ldr	w9, [x20]
    a2bc:	7101e51f 	cmp	w8, #0x79
    a2c0:	528e4c28 	mov	w8, #0x7261                	// #29281
    a2c4:	72ac2e48 	movk	w8, #0x6172, lsl #16
    a2c8:	7a480120 	ccmp	w9, w8, #0x0, eq	// eq = none
    a2cc:	54000c41 	b.ne	a454 <probe::main+0x710>  // b.any
    a2d0:	aa1503e0 	mov	x0, x21
    a2d4:	940000d9 	bl	a638 <probe::array>
    a2d8:	14000021 	b	a35c <probe::main+0x618>
    a2dc:	f1002f1f 	cmp	x24, #0xb
    a2e0:	54000ba1 	b.ne	a454 <probe::main+0x710>  // b.any
    a2e4:	d28e4c2a 	mov	x10, #0x7261                	// #29281
    a2e8:	f9400288 	ldr	x8, [x20]
    a2ec:	f8403289 	ldur	x9, [x20, #3]
    a2f0:	f2ac2e4a 	movk	x10, #0x6172, lsl #16
    a2f4:	f2cbef2a 	movk	x10, #0x5f79, lsl #32
    a2f8:	f2ec2eca 	movk	x10, #0x6176, lsl #48
    a2fc:	eb0a011f 	cmp	x8, x10
    a300:	d28f2c28 	mov	x8, #0x7961                	// #31073
    a304:	f2aecbe8 	movk	x8, #0x765f, lsl #16
    a308:	f2cd8c28 	movk	x8, #0x6c61, lsl #32
    a30c:	f2ecaea8 	movk	x8, #0x6575, lsl #48
    a310:	fa480120 	ccmp	x9, x8, #0x0, eq	// eq = none
    a314:	54000a01 	b.ne	a454 <probe::main+0x710>  // b.any
    a318:	aa1503e0 	mov	x0, x21
    a31c:	97fffdce 	bl	9a54 <probe::array_value>
    a320:	1400000f 	b	a35c <probe::main+0x618>
    a324:	aa1503e0 	mov	x0, x21
    a328:	97fffd61 	bl	98ac <probe::persistent>
    a32c:	1400000c 	b	a35c <probe::main+0x618>
    a330:	aa1503e0 	mov	x0, x21
    a334:	97fffe4d 	bl	9c68 <probe::base>
    a338:	14000009 	b	a35c <probe::main+0x618>
    a33c:	aa1503e0 	mov	x0, x21
    a340:	940000ed 	bl	a6f4 <probe::value>
    a344:	14000006 	b	a35c <probe::main+0x618>
    a348:	aa1503e0 	mov	x0, x21
    a34c:	94000120 	bl	a7cc <probe::boundary>
    a350:	14000003 	b	a35c <probe::main+0x618>
    a354:	aa1503e0 	mov	x0, x21
    a358:	97fffd8a 	bl	9980 <probe::value_wide>
    a35c:	b40000b3 	cbz	x19, a370 <probe::main+0x62c>
    a360:	aa1403e0 	mov	x0, x20
    a364:	aa1303e1 	mov	x1, x19
    a368:	52800022 	mov	w2, #0x1                   	// #1
    a36c:	94000202 	bl	ab74 <__rustc::__rust_dealloc>
    a370:	f94007e8 	ldr	x8, [sp, #8]
    a374:	f9400fe9 	ldr	x9, [sp, #24]
    a378:	eb080129 	subs	x9, x9, x8
    a37c:	54000200 	b.eq	a3bc <probe::main+0x678>  // b.none
    a380:	b201f3ea 	mov	x10, #0xaaaaaaaaaaaaaaaa    	// #-6148914691236517206
    a384:	91002114 	add	x20, x8, #0x8
    a388:	f295556a 	movk	x10, #0xaaab
    a38c:	9bca7d29 	umulh	x9, x9, x10
    a390:	d344fd33 	lsr	x19, x9, #4
    a394:	14000004 	b	a3a4 <probe::main+0x660>
    a398:	f1000673 	subs	x19, x19, #0x1
    a39c:	91006294 	add	x20, x20, #0x18
    a3a0:	540000e0 	b.eq	a3bc <probe::main+0x678>  // b.none
    a3a4:	f85f8281 	ldur	x1, [x20, #-8]
    a3a8:	b4ffff81 	cbz	x1, a398 <probe::main+0x654>
    a3ac:	f9400280 	ldr	x0, [x20]
    a3b0:	52800022 	mov	w2, #0x1                   	// #1
    a3b4:	940001f0 	bl	ab74 <__rustc::__rust_dealloc>
    a3b8:	17fffff8 	b	a398 <probe::main+0x654>
    a3bc:	f9400be8 	ldr	x8, [sp, #16]
    a3c0:	b40000c8 	cbz	x8, a3d8 <probe::main+0x694>
    a3c4:	8b080508 	add	x8, x8, x8, lsl #1
    a3c8:	f94003e0 	ldr	x0, [sp]
    a3cc:	52800102 	mov	w2, #0x8                   	// #8
    a3d0:	d37df101 	lsl	x1, x8, #3
    a3d4:	940001e8 	bl	ab74 <__rustc::__rust_dealloc>
    a3d8:	a9494ff4 	ldp	x20, x19, [sp, #144]
    a3dc:	f94033f9 	ldr	x25, [sp, #96]
    a3e0:	a94857f6 	ldp	x22, x21, [sp, #128]
    a3e4:	a9475ff8 	ldp	x24, x23, [sp, #112]
    a3e8:	a9457bfd 	ldp	x29, x30, [sp, #80]
    a3ec:	910283ff 	add	sp, sp, #0xa0
    a3f0:	d65f03c0 	ret
    a3f4:	5100c168 	sub	w8, w11, #0x30
    a3f8:	7100291f 	cmp	w8, #0xa
    a3fc:	52800028 	mov	w8, #0x1                   	// #1
    a400:	1a882500 	cinc	w0, w8, cc	// cc = lo, ul, last
    a404:	14000002 	b	a40c <probe::main+0x6c8>
    a408:	52800040 	mov	w0, #0x2                   	// #2
    a40c:	97ffe75d 	bl	4180 <core::result::unwrap_failed::<core::num::error::ParseIntError>>
    a410:	1400002a 	b	a4b8 <probe::main+0x774>
    a414:	9100a3e1 	add	x1, sp, #0x28
    a418:	d10023a0 	sub	x0, x29, #0x8
    a41c:	97ffe766 	bl	41b4 <core::panicking::assert_failed::<core::option::Option<&isize>, core::option::Option<&isize>>>
    a420:	14000026 	b	a4b8 <probe::main+0x774>
    a424:	f0000280 	adrp	x0, 5d000 <GCC_except_table5+0x10bf0>
    a428:	913bc000 	add	x0, x0, #0xef0
    a42c:	97fffb7c 	bl	921c <core::option::unwrap_failed>
    a430:	14000022 	b	a4b8 <probe::main+0x774>
    a434:	f90013ff 	str	xzr, [sp, #32]
    a438:	910003e0 	mov	x0, sp
    a43c:	97fffccb 	bl	9768 <<std::env::Args as core::iter::traits::iterator::Iterator>::try_fold::<core::num::nonzero::NonZero<usize>, <std::env::Args as core::iter::traits::iterator::Iterator::advance_by::SpecAdvanceBy>::spec_advance_by::{closure#0}, core::option::Option<core::num::nonzero::NonZero<usize>>>>
    a440:	b4ffcd00 	cbz	x0, 9de0 <probe::main+0x9c>
    a444:	f0000280 	adrp	x0, 5d000 <GCC_except_table5+0x10bf0>
    a448:	913c2000 	add	x0, x0, #0xf08
    a44c:	97fffb74 	bl	921c <core::option::unwrap_failed>
    a450:	1400001a 	b	a4b8 <probe::main+0x774>
    a454:	900001a0 	adrp	x0, 3e000 <_fini+0x1c40>
    a458:	91318000 	add	x0, x0, #0xc60
    a45c:	f0000282 	adrp	x2, 5d000 <GCC_except_table5+0x10bf0>
    a460:	913c8042 	add	x2, x2, #0xf20
    a464:	528001c1 	mov	w1, #0xe                   	// #14
    a468:	97fffbda 	bl	93d0 <core::panicking::panic>
    a46c:	14000013 	b	a4b8 <probe::main+0x774>
    a470:	52800020 	mov	w0, #0x1                   	// #1
    a474:	52800081 	mov	w1, #0x4                   	// #4
    a478:	97fffb2e 	bl	9130 <alloc::raw_vec::handle_error>
    a47c:	1400000f 	b	a4b8 <probe::main+0x774>
    a480:	52800020 	mov	w0, #0x1                   	// #1
    a484:	17ffffe2 	b	a40c <probe::main+0x6c8>
    a488:	d10023a1 	sub	x1, x29, #0x8
    a48c:	d10043a0 	sub	x0, x29, #0x10
    a490:	17ffffe3 	b	a41c <probe::main+0x6d8>
    a494:	2a1f03e0 	mov	w0, wzr
    a498:	17ffffdd 	b	a40c <probe::main+0x6c8>
    a49c:	d10043a0 	sub	x0, x29, #0x10
    a4a0:	d10023a1 	sub	x1, x29, #0x8
    a4a4:	97ffe744 	bl	41b4 <core::panicking::assert_failed::<core::option::Option<&isize>, core::option::Option<&isize>>>
    a4a8:	14000004 	b	a4b8 <probe::main+0x774>
    a4ac:	d10043a0 	sub	x0, x29, #0x10
    a4b0:	d10023a1 	sub	x1, x29, #0x8
    a4b4:	97ffe740 	bl	41b4 <core::panicking::assert_failed::<core::option::Option<&isize>, core::option::Option<&isize>>>
    a4b8:	d4200020 	brk	#0x1
    a4bc:	14000001 	b	a4c0 <probe::main+0x77c>
    a4c0:	f94017e1 	ldr	x1, [sp, #40]
    a4c4:	aa0003f5 	mov	x21, x0
    a4c8:	b4000201 	cbz	x1, a508 <probe::main+0x7c4>
    a4cc:	f9401be0 	ldr	x0, [sp, #48]
    a4d0:	1400000c 	b	a500 <probe::main+0x7bc>
    a4d4:	14000003 	b	a4e0 <probe::main+0x79c>
    a4d8:	aa0003f5 	mov	x21, x0
    a4dc:	1400000b 	b	a508 <probe::main+0x7c4>
    a4e0:	aa0003f5 	mov	x21, x0
    a4e4:	1400000e 	b	a51c <probe::main+0x7d8>
    a4e8:	aa0003f5 	mov	x21, x0
    a4ec:	14000007 	b	a508 <probe::main+0x7c4>
    a4f0:	aa0003f5 	mov	x21, x0
    a4f4:	b40000b6 	cbz	x22, a508 <probe::main+0x7c4>
    a4f8:	aa1703e0 	mov	x0, x23
    a4fc:	aa1603e1 	mov	x1, x22
    a500:	52800022 	mov	w2, #0x1                   	// #1
    a504:	9400019c 	bl	ab74 <__rustc::__rust_dealloc>
    a508:	b40000b3 	cbz	x19, a51c <probe::main+0x7d8>
    a50c:	aa1403e0 	mov	x0, x20
    a510:	aa1303e1 	mov	x1, x19
    a514:	52800022 	mov	w2, #0x1                   	// #1
    a518:	94000197 	bl	ab74 <__rustc::__rust_dealloc>
    a51c:	f94007e8 	ldr	x8, [sp, #8]
    a520:	f9400fe9 	ldr	x9, [sp, #24]
    a524:	eb080129 	subs	x9, x9, x8
    a528:	54000141 	b.ne	a550 <probe::main+0x80c>  // b.any
    a52c:	f9400be8 	ldr	x8, [sp, #16]
    a530:	b40000c8 	cbz	x8, a548 <probe::main+0x804>
    a534:	8b080508 	add	x8, x8, x8, lsl #1
    a538:	f94003e0 	ldr	x0, [sp]
    a53c:	52800102 	mov	w2, #0x8                   	// #8
    a540:	d37df101 	lsl	x1, x8, #3
    a544:	9400018c 	bl	ab74 <__rustc::__rust_dealloc>
    a548:	aa1503e0 	mov	x0, x21
    a54c:	97ffe6ed 	bl	4100 <_Unwind_Resume@plt>
    a550:	b201f3ea 	mov	x10, #0xaaaaaaaaaaaaaaaa    	// #-6148914691236517206
    a554:	91002114 	add	x20, x8, #0x8
    a558:	f295556a 	movk	x10, #0xaaab
    a55c:	9bca7d29 	umulh	x9, x9, x10
    a560:	d344fd33 	lsr	x19, x9, #4
    a564:	14000004 	b	a574 <probe::main+0x830>
    a568:	f1000673 	subs	x19, x19, #0x1
    a56c:	91006294 	add	x20, x20, #0x18
    a570:	54fffde0 	b.eq	a52c <probe::main+0x7e8>  // b.none
    a574:	f85f8281 	ldur	x1, [x20, #-8]
    a578:	b4ffff81 	cbz	x1, a568 <probe::main+0x824>
    a57c:	f9400280 	ldr	x0, [x20]
    a580:	52800022 	mov	w2, #0x1                   	// #1
    a584:	9400017c 	bl	ab74 <__rustc::__rust_dealloc>
    a588:	17fffff8 	b	a568 <probe::main+0x824>

000000000000a58c <probe::pair>:
    a58c:	b4000540 	cbz	x0, a634 <probe::pair+0xa8>
    a590:	d101c3ff 	sub	sp, sp, #0x70
    a594:	a9027bfd 	stp	x29, x30, [sp, #32]
    a598:	f9001bf9 	str	x25, [sp, #48]
    a59c:	a9045ff8 	stp	x24, x23, [sp, #64]
    a5a0:	a90557f6 	stp	x22, x21, [sp, #80]
    a5a4:	a9064ff4 	stp	x20, x19, [sp, #96]
    a5a8:	910083fd 	add	x29, sp, #0x20
    a5ac:	d282b1f8 	mov	x24, #0x158f                	// #5519
    a5b0:	d28d1d79 	mov	x25, #0x68eb                	// #26859
    a5b4:	aa0003f3 	mov	x19, x0
    a5b8:	f2bc43f8 	movk	x24, #0xe21f, lsl #16
    a5bc:	f2b8bbd9 	movk	x25, #0xc5de, lsl #16
    a5c0:	910023f4 	add	x20, sp, #0x8
    a5c4:	f2d46338 	movk	x24, #0xa319, lsl #32
    a5c8:	f2d036d9 	movk	x25, #0x81b6, lsl #32
    a5cc:	f0000295 	adrp	x21, 5d000 <GCC_except_table5+0x10bf0>
    a5d0:	913982b5 	add	x21, x21, #0xe60
    a5d4:	910043f6 	add	x22, sp, #0x10
    a5d8:	910063b7 	add	x23, x29, #0x18
    a5dc:	f2edceb8 	movk	x24, #0x6e75, lsl #48
    a5e0:	f2f36679 	movk	x25, #0x9b33, lsl #48
    a5e4:	f90007ff 	str	xzr, [sp, #8]
    a5e8:	f9000bf4 	str	x20, [sp, #16]
    a5ec:	f9000ff5 	str	x21, [sp, #24]
    a5f0:	f9000fb6 	str	x22, [x29, #24]
    a5f4:	f9400fe8 	ldr	x8, [sp, #24]
    a5f8:	f9400be0 	ldr	x0, [sp, #16]
    a5fc:	f9400d08 	ldr	x8, [x8, #24]
    a600:	d63f0100 	blr	x8
    a604:	eb18001f 	cmp	x0, x24
    a608:	fa590020 	ccmp	x1, x25, #0x0, eq	// eq = none
    a60c:	1a9f17e8 	cset	w8, eq	// eq = none
    a610:	f1000673 	subs	x19, x19, #0x1
    a614:	390063a8 	strb	w8, [x29, #24]
    a618:	54fffe61 	b.ne	a5e4 <probe::pair+0x58>  // b.any
    a61c:	a9464ff4 	ldp	x20, x19, [sp, #96]
    a620:	f9401bf9 	ldr	x25, [sp, #48]
    a624:	a94557f6 	ldp	x22, x21, [sp, #80]
    a628:	a9445ff8 	ldp	x24, x23, [sp, #64]
    a62c:	a9427bfd 	ldp	x29, x30, [sp, #32]
    a630:	9101c3ff 	add	sp, sp, #0x70
    a634:	d65f03c0 	ret

000000000000a638 <probe::array>:
    a638:	b40005c0 	cbz	x0, a6f0 <probe::array+0xb8>
    a63c:	d10203ff 	sub	sp, sp, #0x80
    a640:	a9037bfd 	stp	x29, x30, [sp, #48]
    a644:	a90467fa 	stp	x26, x25, [sp, #64]
    a648:	a9055ff8 	stp	x24, x23, [sp, #80]
    a64c:	a90657f6 	stp	x22, x21, [sp, #96]
    a650:	a9074ff4 	stp	x20, x19, [sp, #112]
    a654:	9100c3fd 	add	x29, sp, #0x30
    a658:	d282b1f8 	mov	x24, #0x158f                	// #5519
    a65c:	d28d1d79 	mov	x25, #0x68eb                	// #26859
    a660:	aa0003f3 	mov	x19, x0
    a664:	f2bc43f8 	movk	x24, #0xe21f, lsl #16
    a668:	f2b8bbd9 	movk	x25, #0xc5de, lsl #16
    a66c:	f0000294 	adrp	x20, 5d000 <GCC_except_table5+0x10bf0>
    a670:	91390294 	add	x20, x20, #0xe40
    a674:	f2d46338 	movk	x24, #0xa319, lsl #32
    a678:	f2d036d9 	movk	x25, #0x81b6, lsl #32
    a67c:	910003f5 	mov	x21, sp
    a680:	910023f6 	add	x22, sp, #0x8
    a684:	d10043b7 	sub	x23, x29, #0x10
    a688:	f2edceb8 	movk	x24, #0x6e75, lsl #48
    a68c:	f2f36679 	movk	x25, #0x9b33, lsl #48
    a690:	d10053ba 	sub	x26, x29, #0x14
    a694:	f90003ff 	str	xzr, [sp]
    a698:	f90007f5 	str	x21, [sp, #8]
    a69c:	f9000bf4 	str	x20, [sp, #16]
    a6a0:	f81f03b6 	stur	x22, [x29, #-16]
    a6a4:	f9400be8 	ldr	x8, [sp, #16]
    a6a8:	f94007e0 	ldr	x0, [sp, #8]
    a6ac:	f9400d09 	ldr	x9, [x8, #24]
    a6b0:	d10043a8 	sub	x8, x29, #0x10
    a6b4:	d63f0120 	blr	x9
    a6b8:	f85f03a8 	ldur	x8, [x29, #-16]
    a6bc:	f85f83a9 	ldur	x9, [x29, #-8]
    a6c0:	eb18011f 	cmp	x8, x24
    a6c4:	fa590120 	ccmp	x9, x25, #0x0, eq	// eq = none
    a6c8:	1a9f17e8 	cset	w8, eq	// eq = none
    a6cc:	f1000673 	subs	x19, x19, #0x1
    a6d0:	381ec3a8 	sturb	w8, [x29, #-20]
    a6d4:	54fffe01 	b.ne	a694 <probe::array+0x5c>  // b.any
    a6d8:	a9474ff4 	ldp	x20, x19, [sp, #112]
    a6dc:	a94657f6 	ldp	x22, x21, [sp, #96]
    a6e0:	a9455ff8 	ldp	x24, x23, [sp, #80]
    a6e4:	a94467fa 	ldp	x26, x25, [sp, #64]
    a6e8:	a9437bfd 	ldp	x29, x30, [sp, #48]
    a6ec:	910203ff 	add	sp, sp, #0x80
    a6f0:	d65f03c0 	ret

000000000000a6f4 <probe::value>:
    a6f4:	b40006a0 	cbz	x0, a7c8 <probe::value+0xd4>
    a6f8:	d101c3ff 	sub	sp, sp, #0x70
    a6fc:	a9027bfd 	stp	x29, x30, [sp, #32]
    a700:	f9001bf9 	str	x25, [sp, #48]
    a704:	a9045ff8 	stp	x24, x23, [sp, #64]
    a708:	a90557f6 	stp	x22, x21, [sp, #80]
    a70c:	a9064ff4 	stp	x20, x19, [sp, #96]
    a710:	910083fd 	add	x29, sp, #0x20
    a714:	d28d1d78 	mov	x24, #0x68eb                	// #26859
    a718:	d282b1f9 	mov	x25, #0x158f                	// #5519
    a71c:	aa0003f3 	mov	x19, x0
    a720:	f2b8bbd8 	movk	x24, #0xc5de, lsl #16
    a724:	f2bc43f9 	movk	x25, #0xe21f, lsl #16
    a728:	910063b4 	add	x20, x29, #0x18
    a72c:	f2d036d8 	movk	x24, #0x81b6, lsl #32
    a730:	f2d46339 	movk	x25, #0xa319, lsl #32
    a734:	f0000295 	adrp	x21, 5d000 <GCC_except_table5+0x10bf0>
    a738:	913882b5 	add	x21, x21, #0xe20
    a73c:	910003f6 	mov	x22, sp
    a740:	910043f7 	add	x23, sp, #0x10
    a744:	f2f36678 	movk	x24, #0x9b33, lsl #48
    a748:	f2edceb9 	movk	x25, #0x6e75, lsl #48
    a74c:	14000008 	b	a76c <probe::value+0x78>
    a750:	f94003e8 	ldr	x8, [sp]
    a754:	f9400108 	ldr	x8, [x8]
    a758:	f100011f 	cmp	x8, #0x0
    a75c:	1a9f17e8 	cset	w8, eq	// eq = none
    a760:	390043e8 	strb	w8, [sp, #16]
    a764:	f1000673 	subs	x19, x19, #0x1
    a768:	54000240 	b.eq	a7b0 <probe::value+0xbc>  // b.none
    a76c:	f9000fbf 	str	xzr, [x29, #24]
    a770:	f90003f4 	str	x20, [sp]
    a774:	f90007f5 	str	x21, [sp, #8]
    a778:	f94007e8 	ldr	x8, [sp, #8]
    a77c:	f94003e0 	ldr	x0, [sp]
    a780:	f9400d09 	ldr	x9, [x8, #24]
    a784:	910043e8 	add	x8, sp, #0x10
    a788:	d63f0120 	blr	x9
    a78c:	f9400be8 	ldr	x8, [sp, #16]
    a790:	f9400fe9 	ldr	x9, [sp, #24]
    a794:	ca180129 	eor	x9, x9, x24
    a798:	ca190108 	eor	x8, x8, x25
    a79c:	aa090108 	orr	x8, x8, x9
    a7a0:	b4fffd88 	cbz	x8, a750 <probe::value+0x5c>
    a7a4:	390043ff 	strb	wzr, [sp, #16]
    a7a8:	f1000673 	subs	x19, x19, #0x1
    a7ac:	54fffe01 	b.ne	a76c <probe::value+0x78>  // b.any
    a7b0:	a9464ff4 	ldp	x20, x19, [sp, #96]
    a7b4:	f9401bf9 	ldr	x25, [sp, #48]
    a7b8:	a94557f6 	ldp	x22, x21, [sp, #80]
    a7bc:	a9445ff8 	ldp	x24, x23, [sp, #64]
    a7c0:	a9427bfd 	ldp	x29, x30, [sp, #32]
    a7c4:	9101c3ff 	add	sp, sp, #0x70
    a7c8:	d65f03c0 	ret

000000000000a7cc <probe::boundary>:
    a7cc:	b40004a0 	cbz	x0, a860 <probe::boundary+0x94>
    a7d0:	d10183ff 	sub	sp, sp, #0x60
    a7d4:	a9027bfd 	stp	x29, x30, [sp, #32]
    a7d8:	f9001bf7 	str	x23, [sp, #48]
    a7dc:	a90457f6 	stp	x22, x21, [sp, #64]
    a7e0:	a9054ff4 	stp	x20, x19, [sp, #80]
    a7e4:	910083fd 	add	x29, sp, #0x20
    a7e8:	aa0003f3 	mov	x19, x0
    a7ec:	f0000294 	adrp	x20, 5d000 <GCC_except_table5+0x10bf0>
    a7f0:	91388294 	add	x20, x20, #0xe20
    a7f4:	910023f5 	add	x21, sp, #0x8
    a7f8:	910043f6 	add	x22, sp, #0x10
    a7fc:	910063b7 	add	x23, x29, #0x18
    a800:	14000004 	b	a810 <probe::boundary+0x44>
    a804:	390063bf 	strb	wzr, [x29, #24]
    a808:	f1000673 	subs	x19, x19, #0x1
    a80c:	54000200 	b.eq	a84c <probe::boundary+0x80>  // b.none
    a810:	f90007ff 	str	xzr, [sp, #8]
    a814:	f9000bf5 	str	x21, [sp, #16]
    a818:	f9000ff4 	str	x20, [sp, #24]
    a81c:	f9000fb6 	str	x22, [x29, #24]
    a820:	f9400fe8 	ldr	x8, [sp, #24]
    a824:	f9400be0 	ldr	x0, [sp, #16]
    a828:	f9400d01 	ldr	x1, [x8, #24]
    a82c:	9400000e 	bl	a864 <probe::isolated>
    a830:	b4fffea0 	cbz	x0, a804 <probe::boundary+0x38>
    a834:	f9400008 	ldr	x8, [x0]
    a838:	f100011f 	cmp	x8, #0x0
    a83c:	1a9f17e8 	cset	w8, eq	// eq = none
    a840:	390063a8 	strb	w8, [x29, #24]
    a844:	f1000673 	subs	x19, x19, #0x1
    a848:	54fffe41 	b.ne	a810 <probe::boundary+0x44>  // b.any
    a84c:	a9454ff4 	ldp	x20, x19, [sp, #80]
    a850:	f9401bf7 	ldr	x23, [sp, #48]
    a854:	a94457f6 	ldp	x22, x21, [sp, #64]
    a858:	a9427bfd 	ldp	x29, x30, [sp, #32]
    a85c:	910183ff 	add	sp, sp, #0x60
    a860:	d65f03c0 	ret

000000000000a864 <probe::isolated>:
    a864:	d100c3ff 	sub	sp, sp, #0x30
    a868:	a9017bfd 	stp	x29, x30, [sp, #16]
    a86c:	f90013f3 	str	x19, [sp, #32]
    a870:	910043fd 	add	x29, sp, #0x10
    a874:	910003e8 	mov	x8, sp
    a878:	aa0003f3 	mov	x19, x0
    a87c:	d63f0020 	blr	x1
    a880:	d28d1d6a 	mov	x10, #0x68eb                	// #26859
    a884:	d282b1eb 	mov	x11, #0x158f                	// #5519
    a888:	f94003e8 	ldr	x8, [sp]
    a88c:	f2b8bbca 	movk	x10, #0xc5de, lsl #16
    a890:	f2bc43eb 	movk	x11, #0xe21f, lsl #16
    a894:	f94007e9 	ldr	x9, [sp, #8]
    a898:	f2d036ca 	movk	x10, #0x81b6, lsl #32
    a89c:	f2d4632b 	movk	x11, #0xa319, lsl #32
    a8a0:	f2f3666a 	movk	x10, #0x9b33, lsl #48
    a8a4:	f2edceab 	movk	x11, #0x6e75, lsl #48
    a8a8:	ca0a0129 	eor	x9, x9, x10
    a8ac:	ca0b0108 	eor	x8, x8, x11
    a8b0:	aa090108 	orr	x8, x8, x9
    a8b4:	f100011f 	cmp	x8, #0x0
    a8b8:	9a9f0260 	csel	x0, x19, xzr, eq	// eq = none
    a8bc:	a9417bfd 	ldp	x29, x30, [sp, #16]
    a8c0:	f94013f3 	ldr	x19, [sp, #32]
    a8c4:	9100c3ff 	add	sp, sp, #0x30
    a8c8:	d65f03c0 	ret

000000000000a8cc <probe::repeated>:
    a8cc:	b4000660 	cbz	x0, a998 <probe::repeated+0xcc>
    a8d0:	d101c3ff 	sub	sp, sp, #0x70
    a8d4:	a9027bfd 	stp	x29, x30, [sp, #32]
    a8d8:	f9001bf9 	str	x25, [sp, #48]
    a8dc:	a9045ff8 	stp	x24, x23, [sp, #64]
    a8e0:	a90557f6 	stp	x22, x21, [sp, #80]
    a8e4:	a9064ff4 	stp	x20, x19, [sp, #96]
    a8e8:	910083fd 	add	x29, sp, #0x20
    a8ec:	d28d1d78 	mov	x24, #0x68eb                	// #26859
    a8f0:	d282b1f9 	mov	x25, #0x158f                	// #5519
    a8f4:	aa0203f3 	mov	x19, x2
    a8f8:	f2b8bbd8 	movk	x24, #0xc5de, lsl #16
    a8fc:	f2bc43f9 	movk	x25, #0xe21f, lsl #16
    a900:	aa0003f4 	mov	x20, x0
    a904:	f2d036d8 	movk	x24, #0x81b6, lsl #32
    a908:	f2d46339 	movk	x25, #0xa319, lsl #32
    a90c:	aa0103f5 	mov	x21, x1
    a910:	910003f6 	mov	x22, sp
    a914:	910043f7 	add	x23, sp, #0x10
    a918:	f2f36678 	movk	x24, #0x9b33, lsl #48
    a91c:	f2edceb9 	movk	x25, #0x6e75, lsl #48
    a920:	14000008 	b	a940 <probe::repeated+0x74>
    a924:	f94003e8 	ldr	x8, [sp]
    a928:	f9400108 	ldr	x8, [x8]
    a92c:	f100011f 	cmp	x8, #0x0
    a930:	1a9f17e8 	cset	w8, eq	// eq = none
    a934:	390043e8 	strb	w8, [sp, #16]
    a938:	f1000694 	subs	x20, x20, #0x1
    a93c:	54000220 	b.eq	a980 <probe::repeated+0xb4>  // b.none
    a940:	f90003f5 	str	x21, [sp]
    a944:	f90007f3 	str	x19, [sp, #8]
    a948:	f94007e8 	ldr	x8, [sp, #8]
    a94c:	f94003e0 	ldr	x0, [sp]
    a950:	f9400d09 	ldr	x9, [x8, #24]
    a954:	910043e8 	add	x8, sp, #0x10
    a958:	d63f0120 	blr	x9
    a95c:	f9400be8 	ldr	x8, [sp, #16]
    a960:	f9400fe9 	ldr	x9, [sp, #24]
    a964:	ca180129 	eor	x9, x9, x24
    a968:	ca190108 	eor	x8, x8, x25
    a96c:	aa090108 	orr	x8, x8, x9
    a970:	b4fffda8 	cbz	x8, a924 <probe::repeated+0x58>
    a974:	390043ff 	strb	wzr, [sp, #16]
    a978:	f1000694 	subs	x20, x20, #0x1
    a97c:	54fffe21 	b.ne	a940 <probe::repeated+0x74>  // b.any
    a980:	a9464ff4 	ldp	x20, x19, [sp, #96]
    a984:	f9401bf9 	ldr	x25, [sp, #48]
    a988:	a94557f6 	ldp	x22, x21, [sp, #80]
    a98c:	a9445ff8 	ldp	x24, x23, [sp, #64]
    a990:	a9427bfd 	ldp	x29, x30, [sp, #32]
    a994:	9101c3ff 	add	sp, sp, #0x70
    a998:	d65f03c0 	ret

