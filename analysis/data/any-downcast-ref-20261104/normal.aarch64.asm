0000000000009804 <probe::pair_value>:
    9804:	b40004e0 	cbz	x0, 98a0 <probe::pair_value+0x9c>
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
    9844:	900002b5 	adrp	x21, 5d000 <GCC_except_table5+0x10cb0>
    9848:	913982b5 	add	x21, x21, #0xe60
    984c:	910043f6 	add	x22, sp, #0x10
    9850:	f2edceb7 	movk	x23, #0x6e75, lsl #48
    9854:	f2f36678 	movk	x24, #0x9b33, lsl #48
    9858:	910073b9 	add	x25, x29, #0x1c
    985c:	a900d3ff 	stp	xzr, x20, [sp, #8]
    9860:	f9000ff5 	str	x21, [sp, #24]
    9864:	a94123e0 	ldp	x0, x8, [sp, #16]
    9868:	f9400d08 	ldr	x8, [x8, #24]
    986c:	d63f0100 	blr	x8
    9870:	eb17001f 	cmp	x0, x23
    9874:	fa580020 	ccmp	x1, x24, #0x0, eq	// eq = none
    9878:	1a9f17e8 	cset	w8, eq	// eq = none
    987c:	f1000673 	subs	x19, x19, #0x1
    9880:	390073a8 	strb	w8, [x29, #28]
    9884:	54fffec1 	b.ne	985c <probe::pair_value+0x58>  // b.any
    9888:	a9464ff4 	ldp	x20, x19, [sp, #96]
    988c:	f9401bf9 	ldr	x25, [sp, #48]
    9890:	a94557f6 	ldp	x22, x21, [sp, #80]
    9894:	a9445ff8 	ldp	x24, x23, [sp, #64]
    9898:	a9427bfd 	ldp	x29, x30, [sp, #32]
    989c:	9101c3ff 	add	sp, sp, #0x70
    98a0:	d65f03c0 	ret

00000000000098a4 <probe::persistent>:
    98a4:	d101c3ff 	sub	sp, sp, #0x70
    98a8:	a9037bfd 	stp	x29, x30, [sp, #48]
    98ac:	a9045ff8 	stp	x24, x23, [sp, #64]
    98b0:	a90557f6 	stp	x22, x21, [sp, #80]
    98b4:	a9064ff4 	stp	x20, x19, [sp, #96]
    98b8:	9100c3fd 	add	x29, sp, #0x30
    98bc:	910023e8 	add	x8, sp, #0x8
    98c0:	900002a9 	adrp	x9, 5d000 <GCC_except_table5+0x10cb0>
    98c4:	91388129 	add	x9, x9, #0xe20
    98c8:	a900a3ff 	stp	xzr, x8, [sp, #8]
    98cc:	f9000fe9 	str	x9, [sp, #24]
    98d0:	b4000420 	cbz	x0, 9954 <probe::persistent+0xb0>
    98d4:	d28d1d77 	mov	x23, #0x68eb                	// #26859
    98d8:	d282b1f8 	mov	x24, #0x158f                	// #5519
    98dc:	aa0003f3 	mov	x19, x0
    98e0:	f2b8bbd7 	movk	x23, #0xc5de, lsl #16
    98e4:	f2bc43f8 	movk	x24, #0xe21f, lsl #16
    98e8:	910043f5 	add	x21, sp, #0x10
    98ec:	f2d036d7 	movk	x23, #0x81b6, lsl #32
    98f0:	f2d46338 	movk	x24, #0xa319, lsl #32
    98f4:	d10043b6 	sub	x22, x29, #0x10
    98f8:	f2f36677 	movk	x23, #0x9b33, lsl #48
    98fc:	f2edceb8 	movk	x24, #0x6e75, lsl #48
    9900:	14000007 	b	991c <probe::persistent+0x78>
    9904:	f9400288 	ldr	x8, [x20]
    9908:	f100011f 	cmp	x8, #0x0
    990c:	1a9f17e8 	cset	w8, eq	// eq = none
    9910:	381f03a8 	sturb	w8, [x29, #-16]
    9914:	f1000673 	subs	x19, x19, #0x1
    9918:	540001e0 	b.eq	9954 <probe::persistent+0xb0>  // b.none
    991c:	f81f03b5 	stur	x21, [x29, #-16]
    9920:	a94123f4 	ldp	x20, x8, [sp, #16]
    9924:	f9400d09 	ldr	x9, [x8, #24]
    9928:	d10043a8 	sub	x8, x29, #0x10
    992c:	aa1403e0 	mov	x0, x20
    9930:	d63f0120 	blr	x9
    9934:	a97f27a8 	ldp	x8, x9, [x29, #-16]
    9938:	ca170129 	eor	x9, x9, x23
    993c:	ca180108 	eor	x8, x8, x24
    9940:	aa090108 	orr	x8, x8, x9
    9944:	b4fffe08 	cbz	x8, 9904 <probe::persistent+0x60>
    9948:	381f03bf 	sturb	wzr, [x29, #-16]
    994c:	f1000673 	subs	x19, x19, #0x1
    9950:	54fffe61 	b.ne	991c <probe::persistent+0x78>  // b.any
    9954:	a9464ff4 	ldp	x20, x19, [sp, #96]
    9958:	a94557f6 	ldp	x22, x21, [sp, #80]
    995c:	a9445ff8 	ldp	x24, x23, [sp, #64]
    9960:	a9437bfd 	ldp	x29, x30, [sp, #48]
    9964:	9101c3ff 	add	sp, sp, #0x70
    9968:	d65f03c0 	ret

000000000000996c <probe::value_wide>:
    996c:	b4000620 	cbz	x0, 9a30 <probe::value_wide+0xc4>
    9970:	d101c3ff 	sub	sp, sp, #0x70
    9974:	a9027bfd 	stp	x29, x30, [sp, #32]
    9978:	f9001bf9 	str	x25, [sp, #48]
    997c:	a9045ff8 	stp	x24, x23, [sp, #64]
    9980:	a90557f6 	stp	x22, x21, [sp, #80]
    9984:	a9064ff4 	stp	x20, x19, [sp, #96]
    9988:	910083fd 	add	x29, sp, #0x20
    998c:	d28d1d78 	mov	x24, #0x68eb                	// #26859
    9990:	d282b1f9 	mov	x25, #0x158f                	// #5519
    9994:	aa0003f3 	mov	x19, x0
    9998:	f2b8bbd8 	movk	x24, #0xc5de, lsl #16
    999c:	f2bc43f9 	movk	x25, #0xe21f, lsl #16
    99a0:	910063b4 	add	x20, x29, #0x18
    99a4:	f2d036d8 	movk	x24, #0x81b6, lsl #32
    99a8:	f2d46339 	movk	x25, #0xa319, lsl #32
    99ac:	900002b5 	adrp	x21, 5d000 <GCC_except_table5+0x10cb0>
    99b0:	913882b5 	add	x21, x21, #0xe20
    99b4:	910003f6 	mov	x22, sp
    99b8:	910043f7 	add	x23, sp, #0x10
    99bc:	f2f36678 	movk	x24, #0x9b33, lsl #48
    99c0:	f2edceb9 	movk	x25, #0x6e75, lsl #48
    99c4:	14000004 	b	99d4 <probe::value_wide+0x68>
    99c8:	f9000be8 	str	x8, [sp, #16]
    99cc:	f1000673 	subs	x19, x19, #0x1
    99d0:	54000240 	b.eq	9a18 <probe::value_wide+0xac>  // b.none
    99d4:	f9000fbf 	str	xzr, [x29, #24]
    99d8:	a90057f4 	stp	x20, x21, [sp]
    99dc:	a94023e0 	ldp	x0, x8, [sp]
    99e0:	f9400d09 	ldr	x9, [x8, #24]
    99e4:	910043e8 	add	x8, sp, #0x10
    99e8:	d63f0120 	blr	x9
    99ec:	a94127e8 	ldp	x8, x9, [sp, #16]
    99f0:	ca180129 	eor	x9, x9, x24
    99f4:	ca190108 	eor	x8, x8, x25
    99f8:	aa090109 	orr	x9, x8, x9
    99fc:	aa1f03e8 	mov	x8, xzr
    9a00:	b5fffe49 	cbnz	x9, 99c8 <probe::value_wide+0x5c>
    9a04:	f94003e8 	ldr	x8, [sp]
    9a08:	f9400108 	ldr	x8, [x8]
    9a0c:	f100011f 	cmp	x8, #0x0
    9a10:	1a9f17e8 	cset	w8, eq	// eq = none
    9a14:	17ffffed 	b	99c8 <probe::value_wide+0x5c>
    9a18:	a9464ff4 	ldp	x20, x19, [sp, #96]
    9a1c:	f9401bf9 	ldr	x25, [sp, #48]
    9a20:	a94557f6 	ldp	x22, x21, [sp, #80]
    9a24:	a9445ff8 	ldp	x24, x23, [sp, #64]
    9a28:	a9427bfd 	ldp	x29, x30, [sp, #32]
    9a2c:	9101c3ff 	add	sp, sp, #0x70
    9a30:	d65f03c0 	ret

0000000000009a34 <probe::array_value>:
    9a34:	b4000520 	cbz	x0, 9ad8 <probe::array_value+0xa4>
    9a38:	d10203ff 	sub	sp, sp, #0x80
    9a3c:	a9037bfd 	stp	x29, x30, [sp, #48]
    9a40:	f90023f9 	str	x25, [sp, #64]
    9a44:	a9055ff8 	stp	x24, x23, [sp, #80]
    9a48:	a90657f6 	stp	x22, x21, [sp, #96]
    9a4c:	a9074ff4 	stp	x20, x19, [sp, #112]
    9a50:	9100c3fd 	add	x29, sp, #0x30
    9a54:	d282b1f7 	mov	x23, #0x158f                	// #5519
    9a58:	d28d1d78 	mov	x24, #0x68eb                	// #26859
    9a5c:	aa0003f3 	mov	x19, x0
    9a60:	f2bc43f7 	movk	x23, #0xe21f, lsl #16
    9a64:	f2b8bbd8 	movk	x24, #0xc5de, lsl #16
    9a68:	910023f4 	add	x20, sp, #0x8
    9a6c:	f2d46337 	movk	x23, #0xa319, lsl #32
    9a70:	f2d036d8 	movk	x24, #0x81b6, lsl #32
    9a74:	900002b5 	adrp	x21, 5d000 <GCC_except_table5+0x10cb0>
    9a78:	913902b5 	add	x21, x21, #0xe40
    9a7c:	910043f6 	add	x22, sp, #0x10
    9a80:	f2edceb7 	movk	x23, #0x6e75, lsl #48
    9a84:	f2f36678 	movk	x24, #0x9b33, lsl #48
    9a88:	910073b9 	add	x25, x29, #0x1c
    9a8c:	a900d3ff 	stp	xzr, x20, [sp, #8]
    9a90:	f9000ff5 	str	x21, [sp, #24]
    9a94:	a94123e0 	ldp	x0, x8, [sp, #16]
    9a98:	f9400d09 	ldr	x9, [x8, #24]
    9a9c:	d10043a8 	sub	x8, x29, #0x10
    9aa0:	d63f0120 	blr	x9
    9aa4:	a97f27a8 	ldp	x8, x9, [x29, #-16]
    9aa8:	eb17011f 	cmp	x8, x23
    9aac:	fa580120 	ccmp	x9, x24, #0x0, eq	// eq = none
    9ab0:	1a9f17e8 	cset	w8, eq	// eq = none
    9ab4:	f1000673 	subs	x19, x19, #0x1
    9ab8:	390073a8 	strb	w8, [x29, #28]
    9abc:	54fffe81 	b.ne	9a8c <probe::array_value+0x58>  // b.any
    9ac0:	a9474ff4 	ldp	x20, x19, [sp, #112]
    9ac4:	f94023f9 	ldr	x25, [sp, #64]
    9ac8:	a94657f6 	ldp	x22, x21, [sp, #96]
    9acc:	a9455ff8 	ldp	x24, x23, [sp, #80]
    9ad0:	a9437bfd 	ldp	x29, x30, [sp, #48]
    9ad4:	910203ff 	add	sp, sp, #0x80
    9ad8:	d65f03c0 	ret

0000000000009adc <probe::persistent_wide>:
    9adc:	d101c3ff 	sub	sp, sp, #0x70
    9ae0:	a9037bfd 	stp	x29, x30, [sp, #48]
    9ae4:	a9045ff8 	stp	x24, x23, [sp, #64]
    9ae8:	a90557f6 	stp	x22, x21, [sp, #80]
    9aec:	a9064ff4 	stp	x20, x19, [sp, #96]
    9af0:	9100c3fd 	add	x29, sp, #0x30
    9af4:	910023e8 	add	x8, sp, #0x8
    9af8:	900002a9 	adrp	x9, 5d000 <GCC_except_table5+0x10cb0>
    9afc:	91388129 	add	x9, x9, #0xe20
    9b00:	a900a3ff 	stp	xzr, x8, [sp, #8]
    9b04:	f9000fe9 	str	x9, [sp, #24]
    9b08:	b4000420 	cbz	x0, 9b8c <probe::persistent_wide+0xb0>
    9b0c:	d28d1d77 	mov	x23, #0x68eb                	// #26859
    9b10:	d282b1f8 	mov	x24, #0x158f                	// #5519
    9b14:	aa0003f3 	mov	x19, x0
    9b18:	f2b8bbd7 	movk	x23, #0xc5de, lsl #16
    9b1c:	f2bc43f8 	movk	x24, #0xe21f, lsl #16
    9b20:	910043f5 	add	x21, sp, #0x10
    9b24:	f2d036d7 	movk	x23, #0x81b6, lsl #32
    9b28:	f2d46338 	movk	x24, #0xa319, lsl #32
    9b2c:	d10043b6 	sub	x22, x29, #0x10
    9b30:	f2f36677 	movk	x23, #0x9b33, lsl #48
    9b34:	f2edceb8 	movk	x24, #0x6e75, lsl #48
    9b38:	14000007 	b	9b54 <probe::persistent_wide+0x78>
    9b3c:	f9400288 	ldr	x8, [x20]
    9b40:	f100011f 	cmp	x8, #0x0
    9b44:	1a9f17e8 	cset	w8, eq	// eq = none
    9b48:	f81f03a8 	stur	x8, [x29, #-16]
    9b4c:	f1000673 	subs	x19, x19, #0x1
    9b50:	540001e0 	b.eq	9b8c <probe::persistent_wide+0xb0>  // b.none
    9b54:	f81f03b5 	stur	x21, [x29, #-16]
    9b58:	a94123f4 	ldp	x20, x8, [sp, #16]
    9b5c:	f9400d09 	ldr	x9, [x8, #24]
    9b60:	d10043a8 	sub	x8, x29, #0x10
    9b64:	aa1403e0 	mov	x0, x20
    9b68:	d63f0120 	blr	x9
    9b6c:	a97f27a8 	ldp	x8, x9, [x29, #-16]
    9b70:	ca170129 	eor	x9, x9, x23
    9b74:	ca180108 	eor	x8, x8, x24
    9b78:	aa090108 	orr	x8, x8, x9
    9b7c:	b4fffe08 	cbz	x8, 9b3c <probe::persistent_wide+0x60>
    9b80:	f81f03bf 	stur	xzr, [x29, #-16]
    9b84:	f1000673 	subs	x19, x19, #0x1
    9b88:	54fffe61 	b.ne	9b54 <probe::persistent_wide+0x78>  // b.any
    9b8c:	a9464ff4 	ldp	x20, x19, [sp, #96]
    9b90:	a94557f6 	ldp	x22, x21, [sp, #80]
    9b94:	a9445ff8 	ldp	x24, x23, [sp, #64]
    9b98:	a9437bfd 	ldp	x29, x30, [sp, #48]
    9b9c:	9101c3ff 	add	sp, sp, #0x70
    9ba0:	d65f03c0 	ret

0000000000009ba4 <probe::repeated_boundary>:
    9ba4:	b4000400 	cbz	x0, 9c24 <probe::repeated_boundary+0x80>
    9ba8:	d10143ff 	sub	sp, sp, #0x50
    9bac:	a9017bfd 	stp	x29, x30, [sp, #16]
    9bb0:	f90013f7 	str	x23, [sp, #32]
    9bb4:	a90357f6 	stp	x22, x21, [sp, #48]
    9bb8:	a9044ff4 	stp	x20, x19, [sp, #64]
    9bbc:	910043fd 	add	x29, sp, #0x10
    9bc0:	aa0203f3 	mov	x19, x2
    9bc4:	aa0003f4 	mov	x20, x0
    9bc8:	aa0103f5 	mov	x21, x1
    9bcc:	910003f6 	mov	x22, sp
    9bd0:	910073b7 	add	x23, x29, #0x1c
    9bd4:	14000004 	b	9be4 <probe::repeated_boundary+0x40>
    9bd8:	390073bf 	strb	wzr, [x29, #28]
    9bdc:	f1000694 	subs	x20, x20, #0x1
    9be0:	54000180 	b.eq	9c10 <probe::repeated_boundary+0x6c>  // b.none
    9be4:	a9004ff5 	stp	x21, x19, [sp]
    9be8:	a94023e0 	ldp	x0, x8, [sp]
    9bec:	f9400d01 	ldr	x1, [x8, #24]
    9bf0:	940002f2 	bl	a7b8 <probe::isolated>
    9bf4:	b4ffff20 	cbz	x0, 9bd8 <probe::repeated_boundary+0x34>
    9bf8:	f9400008 	ldr	x8, [x0]
    9bfc:	f100011f 	cmp	x8, #0x0
    9c00:	1a9f17e8 	cset	w8, eq	// eq = none
    9c04:	390073a8 	strb	w8, [x29, #28]
    9c08:	f1000694 	subs	x20, x20, #0x1
    9c0c:	54fffec1 	b.ne	9be4 <probe::repeated_boundary+0x40>  // b.any
    9c10:	a9444ff4 	ldp	x20, x19, [sp, #64]
    9c14:	f94013f7 	ldr	x23, [sp, #32]
    9c18:	a94357f6 	ldp	x22, x21, [sp, #48]
    9c1c:	a9417bfd 	ldp	x29, x30, [sp, #16]
    9c20:	910143ff 	add	sp, sp, #0x50
    9c24:	d65f03c0 	ret

0000000000009c28 <probe::base>:
    9c28:	b4000660 	cbz	x0, 9cf4 <probe::base+0xcc>
    9c2c:	d10203ff 	sub	sp, sp, #0x80
    9c30:	a9037bfd 	stp	x29, x30, [sp, #48]
    9c34:	a90467fa 	stp	x26, x25, [sp, #64]
    9c38:	a9055ff8 	stp	x24, x23, [sp, #80]
    9c3c:	a90657f6 	stp	x22, x21, [sp, #96]
    9c40:	a9074ff4 	stp	x20, x19, [sp, #112]
    9c44:	9100c3fd 	add	x29, sp, #0x30
    9c48:	d28d1d79 	mov	x25, #0x68eb                	// #26859
    9c4c:	d282b1fa 	mov	x26, #0x158f                	// #5519
    9c50:	aa0003f3 	mov	x19, x0
    9c54:	f2b8bbd9 	movk	x25, #0xc5de, lsl #16
    9c58:	f2bc43fa 	movk	x26, #0xe21f, lsl #16
    9c5c:	910023f5 	add	x21, sp, #0x8
    9c60:	f2d036d9 	movk	x25, #0x81b6, lsl #32
    9c64:	f2d4633a 	movk	x26, #0xa319, lsl #32
    9c68:	900002b6 	adrp	x22, 5d000 <GCC_except_table5+0x10cb0>
    9c6c:	913882d6 	add	x22, x22, #0xe20
    9c70:	910043f7 	add	x23, sp, #0x10
    9c74:	d10043b8 	sub	x24, x29, #0x10
    9c78:	f2f36679 	movk	x25, #0x9b33, lsl #48
    9c7c:	f2edceba 	movk	x26, #0x6e75, lsl #48
    9c80:	14000007 	b	9c9c <probe::base+0x74>
    9c84:	f9400288 	ldr	x8, [x20]
    9c88:	f100011f 	cmp	x8, #0x0
    9c8c:	1a9f17e8 	cset	w8, eq	// eq = none
    9c90:	381f03a8 	sturb	w8, [x29, #-16]
    9c94:	f1000673 	subs	x19, x19, #0x1
    9c98:	54000220 	b.eq	9cdc <probe::base+0xb4>  // b.none
    9c9c:	a900d7ff 	stp	xzr, x21, [sp, #8]
    9ca0:	f9000ff6 	str	x22, [sp, #24]
    9ca4:	f81f03b7 	stur	x23, [x29, #-16]
    9ca8:	a94123f4 	ldp	x20, x8, [sp, #16]
    9cac:	f9400d09 	ldr	x9, [x8, #24]
    9cb0:	d10043a8 	sub	x8, x29, #0x10
    9cb4:	aa1403e0 	mov	x0, x20
    9cb8:	d63f0120 	blr	x9
    9cbc:	a97f27a8 	ldp	x8, x9, [x29, #-16]
    9cc0:	ca190129 	eor	x9, x9, x25
    9cc4:	ca1a0108 	eor	x8, x8, x26
    9cc8:	aa090108 	orr	x8, x8, x9
    9ccc:	b4fffdc8 	cbz	x8, 9c84 <probe::base+0x5c>
    9cd0:	381f03bf 	sturb	wzr, [x29, #-16]
    9cd4:	f1000673 	subs	x19, x19, #0x1
    9cd8:	54fffe21 	b.ne	9c9c <probe::base+0x74>  // b.any
    9cdc:	a9474ff4 	ldp	x20, x19, [sp, #112]
    9ce0:	a94657f6 	ldp	x22, x21, [sp, #96]
    9ce4:	a9455ff8 	ldp	x24, x23, [sp, #80]
    9ce8:	a94467fa 	ldp	x26, x25, [sp, #64]
    9cec:	a9437bfd 	ldp	x29, x30, [sp, #48]
    9cf0:	910203ff 	add	sp, sp, #0x80
    9cf4:	d65f03c0 	ret

0000000000009cf8 <probe::main>:
    9cf8:	d10283ff 	sub	sp, sp, #0xa0
    9cfc:	a9057bfd 	stp	x29, x30, [sp, #80]
    9d00:	f90033f9 	str	x25, [sp, #96]
    9d04:	a9075ff8 	stp	x24, x23, [sp, #112]
    9d08:	a90857f6 	stp	x22, x21, [sp, #128]
    9d0c:	a9094ff4 	stp	x20, x19, [sp, #144]
    9d10:	910143fd 	add	x29, sp, #0x50
    9d14:	910003e8 	mov	x8, sp
    9d18:	940066e3 	bl	238a4 <std::env::args>
    9d1c:	f90013ff 	str	xzr, [sp, #32]
    9d20:	9100a3e8 	add	x8, sp, #0x28
    9d24:	910003e0 	mov	x0, sp
    9d28:	94007b0b 	bl	28954 <<std::env::Args as core::iter::traits::iterator::Iterator>::next>
    9d2c:	f94017e1 	ldr	x1, [sp, #40]
    9d30:	b40000c1 	cbz	x1, 9d48 <probe::main+0x50>
    9d34:	b100043f 	cmn	x1, #0x1
    9d38:	54003340 	b.eq	a3a0 <probe::main+0x6a8>  // b.none
    9d3c:	f9401be0 	ldr	x0, [sp, #48]
    9d40:	52800022 	mov	w2, #0x1                   	// #1
    9d44:	9400035d 	bl	aab8 <__rustc::__rust_dealloc>
    9d48:	9100a3e8 	add	x8, sp, #0x28
    9d4c:	910003e0 	mov	x0, sp
    9d50:	94007b01 	bl	28954 <<std::env::Args as core::iter::traits::iterator::Iterator>::next>
    9d54:	f94017f3 	ldr	x19, [sp, #40]
    9d58:	b100067f 	cmn	x19, #0x1
    9d5c:	54003220 	b.eq	a3a0 <probe::main+0x6a8>  // b.none
    9d60:	a94363f4 	ldp	x20, x24, [sp, #48]
    9d64:	f100171f 	cmp	x24, #0x5
    9d68:	54000101 	b.ne	9d88 <probe::main+0x90>  // b.any
    9d6c:	39401288 	ldrb	w8, [x20, #4]
    9d70:	b9400289 	ldr	w9, [x20]
    9d74:	7101ad1f 	cmp	w8, #0x6b
    9d78:	528d0c68 	mov	w8, #0x6863                	// #26723
    9d7c:	72ac6ca8 	movk	w8, #0x6365, lsl #16
    9d80:	7a480120 	ccmp	w9, w8, #0x0, eq	// eq = none
    9d84:	54001380 	b.eq	9ff4 <probe::main+0x2fc>  // b.none
    9d88:	f94013e1 	ldr	x1, [sp, #32]
    9d8c:	b5003121 	cbnz	x1, a3b0 <probe::main+0x6b8>
    9d90:	9100a3e8 	add	x8, sp, #0x28
    9d94:	910003e0 	mov	x0, sp
    9d98:	94007aef 	bl	28954 <<std::env::Args as core::iter::traits::iterator::Iterator>::next>
    9d9c:	f94017f6 	ldr	x22, [sp, #40]
    9da0:	b10006df 	cmn	x22, #0x1
    9da4:	540030e0 	b.eq	a3c0 <probe::main+0x6c8>  // b.none
    9da8:	a94323f7 	ldp	x23, x8, [sp, #48]
    9dac:	f100051f 	cmp	x8, #0x1
    9db0:	54000080 	b.eq	9dc0 <probe::main+0xc8>  // b.none
    9db4:	b40032e8 	cbz	x8, a410 <probe::main+0x718>
    9db8:	394002e9 	ldrb	w9, [x23]
    9dbc:	14000007 	b	9dd8 <probe::main+0xe0>
    9dc0:	394002e9 	ldrb	w9, [x23]
    9dc4:	52800020 	mov	w0, #0x1                   	// #1
    9dc8:	7100ad3f 	cmp	w9, #0x2b
    9dcc:	54002de0 	b.eq	a388 <probe::main+0x690>  // b.none
    9dd0:	7100b53f 	cmp	w9, #0x2d
    9dd4:	54002da0 	b.eq	a388 <probe::main+0x690>  // b.none
    9dd8:	7100ad3f 	cmp	w9, #0x2b
    9ddc:	1a9f17e9 	cset	w9, eq	// eq = none
    9de0:	cb090108 	sub	x8, x8, x9
    9de4:	9a9716e9 	cinc	x9, x23, eq	// eq = none
    9de8:	f100451f 	cmp	x8, #0x11
    9dec:	540001a2 	b.cs	9e20 <probe::main+0x128>  // b.hs, b.nlast
    9df0:	aa1f03f5 	mov	x21, xzr
    9df4:	b4000348 	cbz	x8, 9e5c <probe::main+0x164>
    9df8:	5280014a 	mov	w10, #0xa                   	// #10
    9dfc:	3840152b 	ldrb	w11, [x9], #1
    9e00:	5100c16b 	sub	w11, w11, #0x30
    9e04:	7100257f 	cmp	w11, #0x9
    9e08:	54002fa8 	b.hi	a3fc <probe::main+0x704>  // b.pmore
    9e0c:	9b0a7eac 	mul	x12, x21, x10
    9e10:	f1000508 	subs	x8, x8, #0x1
    9e14:	8b2b4195 	add	x21, x12, w11, uxtw
    9e18:	54ffff21 	b.ne	9dfc <probe::main+0x104>  // b.any
    9e1c:	14000010 	b	9e5c <probe::main+0x164>
    9e20:	aa1f03f5 	mov	x21, xzr
    9e24:	5280014a 	mov	w10, #0xa                   	// #10
    9e28:	9bca7eac 	umulh	x12, x21, x10
    9e2c:	3840152b 	ldrb	w11, [x9], #1
    9e30:	eb0c03ff 	cmp	xzr, x12
    9e34:	540029e1 	b.ne	a370 <probe::main+0x678>  // b.any
    9e38:	5100c16b 	sub	w11, w11, #0x30
    9e3c:	7100297f 	cmp	w11, #0xa
    9e40:	54002de2 	b.cs	a3fc <probe::main+0x704>  // b.hs, b.nlast
    9e44:	8b150aac 	add	x12, x21, x21, lsl #2
    9e48:	d37ff98c 	lsl	x12, x12, #1
    9e4c:	ab2b4195 	adds	x21, x12, w11, uxtw
    9e50:	540029a2 	b.cs	a384 <probe::main+0x68c>  // b.hs, b.nlast
    9e54:	d1000508 	sub	x8, x8, #0x1
    9e58:	b5fffe88 	cbnz	x8, 9e28 <probe::main+0x130>
    9e5c:	b40000b6 	cbz	x22, 9e70 <probe::main+0x178>
    9e60:	aa1703e0 	mov	x0, x23
    9e64:	aa1603e1 	mov	x1, x22
    9e68:	52800022 	mov	w2, #0x1                   	// #1
    9e6c:	94000313 	bl	aab8 <__rustc::__rust_dealloc>
    9e70:	f100271f 	cmp	x24, #0x9
    9e74:	540003ed 	b.le	9ef0 <probe::main+0x1f8>
    9e78:	f1003b1f 	cmp	x24, #0xe
    9e7c:	5400076d 	b.le	9f68 <probe::main+0x270>
    9e80:	f1003f1f 	cmp	x24, #0xf
    9e84:	540018e0 	b.eq	a1a0 <probe::main+0x4a8>  // b.none
    9e88:	f100471f 	cmp	x24, #0x11
    9e8c:	54002a21 	b.ne	a3d0 <probe::main+0x6d8>  // b.any
    9e90:	39404288 	ldrb	w8, [x20, #16]
    9e94:	a940268a 	ldp	x10, x9, [x20]
    9e98:	7101e51f 	cmp	w8, #0x79
    9e9c:	d28c4be8 	mov	x8, #0x625f                	// #25183
    9ea0:	f2aeade8 	movk	x8, #0x756f, lsl #16
    9ea4:	f2cc8dc8 	movk	x8, #0x646e, lsl #32
    9ea8:	f2ee4c28 	movk	x8, #0x7261, lsl #48
    9eac:	fa480120 	ccmp	x9, x8, #0x0, eq	// eq = none
    9eb0:	d28cae48 	mov	x8, #0x6572                	// #25970
    9eb4:	f2acae08 	movk	x8, #0x6570, lsl #16
    9eb8:	f2ce8c28 	movk	x8, #0x7461, lsl #32
    9ebc:	f2ec8ca8 	movk	x8, #0x6465, lsl #48
    9ec0:	fa480140 	ccmp	x10, x8, #0x0, eq	// eq = none
    9ec4:	54002861 	b.ne	a3d0 <probe::main+0x6d8>  // b.any
    9ec8:	b00001a8 	adrp	x8, 3e000 <_fini+0x1cfc>
    9ecc:	91276108 	add	x8, x8, #0x9d8
    9ed0:	900002a9 	adrp	x9, 5d000 <GCC_except_table5+0x10cb0>
    9ed4:	91388129 	add	x9, x9, #0xe20
    9ed8:	a902a7e8 	stp	x8, x9, [sp, #40]
    9edc:	9100a3e8 	add	x8, sp, #0x28
    9ee0:	a9428be1 	ldp	x1, x2, [sp, #40]
    9ee4:	aa1503e0 	mov	x0, x21
    9ee8:	97ffff2f 	bl	9ba4 <probe::repeated_boundary>
    9eec:	140000fb 	b	a2d8 <probe::main+0x5e0>
    9ef0:	f100131f 	cmp	x24, #0x4
    9ef4:	54001760 	b.eq	a1e0 <probe::main+0x4e8>  // b.none
    9ef8:	f100171f 	cmp	x24, #0x5
    9efc:	540018c0 	b.eq	a214 <probe::main+0x51c>  // b.none
    9f00:	f100231f 	cmp	x24, #0x8
    9f04:	54002661 	b.ne	a3d0 <probe::main+0x6d8>  // b.any
    9f08:	d28dec49 	mov	x9, #0x6f62                	// #28514
    9f0c:	f9400288 	ldr	x8, [x20]
    9f10:	f2adcea9 	movk	x9, #0x6e75, lsl #16
    9f14:	f2cc2c89 	movk	x9, #0x6164, lsl #32
    9f18:	f2ef2e49 	movk	x9, #0x7972, lsl #48
    9f1c:	eb09011f 	cmp	x8, x9
    9f20:	54001d20 	b.eq	a2c4 <probe::main+0x5cc>  // b.none
    9f24:	d28cae49 	mov	x9, #0x6572                	// #25970
    9f28:	f9400288 	ldr	x8, [x20]
    9f2c:	f2acae09 	movk	x9, #0x6570, lsl #16
    9f30:	f2ce8c29 	movk	x9, #0x7461, lsl #32
    9f34:	f2ec8ca9 	movk	x9, #0x6465, lsl #48
    9f38:	eb09011f 	cmp	x8, x9
    9f3c:	540024a1 	b.ne	a3d0 <probe::main+0x6d8>  // b.any
    9f40:	b00001a8 	adrp	x8, 3e000 <_fini+0x1cfc>
    9f44:	91276108 	add	x8, x8, #0x9d8
    9f48:	900002a9 	adrp	x9, 5d000 <GCC_except_table5+0x10cb0>
    9f4c:	91388129 	add	x9, x9, #0xe20
    9f50:	a902a7e8 	stp	x8, x9, [sp, #40]
    9f54:	9100a3e8 	add	x8, sp, #0x28
    9f58:	a9428be1 	ldp	x1, x2, [sp, #40]
    9f5c:	aa1503e0 	mov	x0, x21
    9f60:	9400022f 	bl	a81c <probe::repeated>
    9f64:	140000dd 	b	a2d8 <probe::main+0x5e0>
    9f68:	f1002b1f 	cmp	x24, #0xa
    9f6c:	54001761 	b.ne	a258 <probe::main+0x560>  // b.any
    9f70:	d28cae0a 	mov	x10, #0x6570                	// #25968
    9f74:	f9400288 	ldr	x8, [x20]
    9f78:	79401289 	ldrh	w9, [x20, #8]
    9f7c:	f2ae6e4a 	movk	x10, #0x7372, lsl #16
    9f80:	f2ce6d2a 	movk	x10, #0x7369, lsl #32
    9f84:	f2ecae8a 	movk	x10, #0x6574, lsl #48
    9f88:	eb0a011f 	cmp	x8, x10
    9f8c:	528e8dc8 	mov	w8, #0x746e                	// #29806
    9f90:	7a480120 	ccmp	w9, w8, #0x0, eq	// eq = none
    9f94:	54001860 	b.eq	a2a0 <probe::main+0x5a8>  // b.none
    9f98:	d28c2eca 	mov	x10, #0x6176                	// #24950
    9f9c:	f9400288 	ldr	x8, [x20]
    9fa0:	79401289 	ldrh	w9, [x20, #8]
    9fa4:	f2aead8a 	movk	x10, #0x756c, lsl #16
    9fa8:	f2cbecaa 	movk	x10, #0x5f65, lsl #32
    9fac:	f2ed2eea 	movk	x10, #0x6977, lsl #48
    9fb0:	eb0a011f 	cmp	x8, x10
    9fb4:	528cac88 	mov	w8, #0x6564                	// #25956
    9fb8:	7a480120 	ccmp	w9, w8, #0x0, eq	// eq = none
    9fbc:	540018a0 	b.eq	a2d0 <probe::main+0x5d8>  // b.none
    9fc0:	d28c2e0a 	mov	x10, #0x6170                	// #24944
    9fc4:	f9400288 	ldr	x8, [x20]
    9fc8:	79401289 	ldrh	w9, [x20, #8]
    9fcc:	f2ae4d2a 	movk	x10, #0x7269, lsl #16
    9fd0:	f2cecbea 	movk	x10, #0x765f, lsl #32
    9fd4:	f2ed8c2a 	movk	x10, #0x6c61, lsl #48
    9fd8:	eb0a011f 	cmp	x8, x10
    9fdc:	528caea8 	mov	w8, #0x6575                	// #25973
    9fe0:	7a480120 	ccmp	w9, w8, #0x0, eq	// eq = none
    9fe4:	54001f61 	b.ne	a3d0 <probe::main+0x6d8>  // b.any
    9fe8:	aa1503e0 	mov	x0, x21
    9fec:	97fffe06 	bl	9804 <probe::pair_value>
    9ff0:	140000ba 	b	a2d8 <probe::main+0x5e0>
    9ff4:	b0000015 	adrp	x21, a000 <probe::main+0x308>
    9ff8:	912382b5 	add	x21, x21, #0x8e0
    9ffc:	92807ff8 	mov	x24, #0xfffffffffffffc00    	// #-1024
    a000:	90000016 	adrp	x22, a000 <probe::main+0x308>
    a004:	912512d6 	add	x22, x22, #0x944
    a008:	d10043b9 	sub	x25, x29, #0x10
    a00c:	90000017 	adrp	x23, a000 <probe::main+0x308>
    a010:	9123d2f7 	add	x23, x23, #0x8f4
    a014:	f81f03b8 	stur	x24, [x29, #-16]
    a018:	d10043a0 	sub	x0, x29, #0x10
    a01c:	aa1503e1 	mov	x1, x21
    a020:	940001e6 	bl	a7b8 <probe::isolated>
    a024:	f81f83a0 	stur	x0, [x29, #-8]
    a028:	f90017f9 	str	x25, [sp, #40]
    a02c:	b4001b20 	cbz	x0, a390 <probe::main+0x698>
    a030:	f9400008 	ldr	x8, [x0]
    a034:	f85f03a9 	ldur	x9, [x29, #-16]
    a038:	eb09011f 	cmp	x8, x9
    a03c:	54001aa1 	b.ne	a390 <probe::main+0x698>  // b.any
    a040:	f81f03b8 	stur	x24, [x29, #-16]
    a044:	d10043a0 	sub	x0, x29, #0x10
    a048:	aa1603e1 	mov	x1, x22
    a04c:	940001db 	bl	a7b8 <probe::isolated>
    a050:	f81f83a0 	stur	x0, [x29, #-8]
    a054:	f90017ff 	str	xzr, [sp, #40]
    a058:	b50019c0 	cbnz	x0, a390 <probe::main+0x698>
    a05c:	a902e3f8 	stp	x24, x24, [sp, #40]
    a060:	f9001ff8 	str	x24, [sp, #56]
    a064:	9100a3e0 	add	x0, sp, #0x28
    a068:	aa1703e1 	mov	x1, x23
    a06c:	940001d3 	bl	a7b8 <probe::isolated>
    a070:	a93f7fa0 	stp	x0, xzr, [x29, #-16]
    a074:	b5001c80 	cbnz	x0, a404 <probe::main+0x70c>
    a078:	91000718 	add	x24, x24, #0x1
    a07c:	f110031f 	cmp	x24, #0x400
    a080:	54fffca1 	b.ne	a014 <probe::main+0x31c>  // b.any
    a084:	94000290 	bl	aac4 <__rustc::__rust_no_alloc_shim_is_unstable_v2>
    a088:	52800080 	mov	w0, #0x4                   	// #4
    a08c:	52800021 	mov	w1, #0x1                   	// #1
    a090:	94000289 	bl	aab4 <__rustc::__rust_alloc>
    a094:	b4001ac0 	cbz	x0, a3ec <probe::main+0x6f4>
    a098:	528cae88 	mov	w8, #0x6574                	// #25972
    a09c:	52800089 	mov	w9, #0x4                   	// #4
    a0a0:	72ae8e68 	movk	w8, #0x7473, lsl #16
    a0a4:	a90283e9 	stp	x9, x0, [sp, #40]
    a0a8:	b9000008 	str	w8, [x0]
    a0ac:	f9001fe9 	str	x9, [sp, #56]
    a0b0:	90000001 	adrp	x1, a000 <probe::main+0x308>
    a0b4:	91247021 	add	x1, x1, #0x91c
    a0b8:	9100a3e0 	add	x0, sp, #0x28
    a0bc:	940001bf 	bl	a7b8 <probe::isolated>
    a0c0:	a93f7fa0 	stp	x0, xzr, [x29, #-16]
    a0c4:	b5001aa0 	cbnz	x0, a418 <probe::main+0x720>
    a0c8:	f94017e1 	ldr	x1, [sp, #40]
    a0cc:	b4000081 	cbz	x1, a0dc <probe::main+0x3e4>
    a0d0:	f9401be0 	ldr	x0, [sp, #48]
    a0d4:	52800022 	mov	w2, #0x1                   	// #1
    a0d8:	94000278 	bl	aab8 <__rustc::__rust_dealloc>
    a0dc:	52800028 	mov	w8, #0x1                   	// #1
    a0e0:	f9001fff 	str	xzr, [sp, #56]
    a0e4:	a902a3ff 	stp	xzr, x8, [sp, #40]
    a0e8:	90000001 	adrp	x1, a000 <probe::main+0x308>
    a0ec:	91242021 	add	x1, x1, #0x908
    a0f0:	9100a3e0 	add	x0, sp, #0x28
    a0f4:	940001b1 	bl	a7b8 <probe::isolated>
    a0f8:	a93f7fa0 	stp	x0, xzr, [x29, #-16]
    a0fc:	b5001960 	cbnz	x0, a428 <probe::main+0x730>
    a100:	f94017e1 	ldr	x1, [sp, #40]
    a104:	b4000081 	cbz	x1, a114 <probe::main+0x41c>
    a108:	f9401be0 	ldr	x0, [sp, #48]
    a10c:	52800022 	mov	w2, #0x1                   	// #1
    a110:	9400026a 	bl	aab8 <__rustc::__rust_dealloc>
    a114:	90000001 	adrp	x1, a000 <probe::main+0x308>
    a118:	9124c021 	add	x1, x1, #0x930
    a11c:	91007fa0 	add	x0, x29, #0x1f
    a120:	940001a6 	bl	a7b8 <probe::isolated>
    a124:	f81f83a0 	stur	x0, [x29, #-8]
    a128:	f90017ff 	str	xzr, [sp, #40]
    a12c:	b5001320 	cbnz	x0, a390 <probe::main+0x698>
    a130:	900001a0 	adrp	x0, 3e000 <_fini+0x1cfc>
    a134:	912f6400 	add	x0, x0, #0xbd9
    a138:	52800e61 	mov	w1, #0x73                  	// #115
    a13c:	940068d0 	bl	2447c <std::io::stdio::_print>
    a140:	b40000b3 	cbz	x19, a154 <probe::main+0x45c>
    a144:	aa1403e0 	mov	x0, x20
    a148:	aa1303e1 	mov	x1, x19
    a14c:	52800022 	mov	w2, #0x1                   	// #1
    a150:	9400025a 	bl	aab8 <__rustc::__rust_dealloc>
    a154:	f94007e8 	ldr	x8, [sp, #8]
    a158:	f9400fe9 	ldr	x9, [sp, #24]
    a15c:	eb080129 	subs	x9, x9, x8
    a160:	54000ec0 	b.eq	a338 <probe::main+0x640>  // b.none
    a164:	b201f3ea 	mov	x10, #0xaaaaaaaaaaaaaaaa    	// #-6148914691236517206
    a168:	91002114 	add	x20, x8, #0x8
    a16c:	f295556a 	movk	x10, #0xaaab
    a170:	9bca7d29 	umulh	x9, x9, x10
    a174:	d344fd33 	lsr	x19, x9, #4
    a178:	14000004 	b	a188 <probe::main+0x490>
    a17c:	f1000673 	subs	x19, x19, #0x1
    a180:	91006294 	add	x20, x20, #0x18
    a184:	54000da0 	b.eq	a338 <probe::main+0x640>  // b.none
    a188:	f85f8281 	ldur	x1, [x20, #-8]
    a18c:	b4ffff81 	cbz	x1, a17c <probe::main+0x484>
    a190:	f9400280 	ldr	x0, [x20]
    a194:	52800022 	mov	w2, #0x1                   	// #1
    a198:	94000248 	bl	aab8 <__rustc::__rust_dealloc>
    a19c:	17fffff8 	b	a17c <probe::main+0x484>
    a1a0:	d28cae0a 	mov	x10, #0x6570                	// #25968
    a1a4:	f9400288 	ldr	x8, [x20]
    a1a8:	f8407289 	ldur	x9, [x20, #7]
    a1ac:	f2ae6e4a 	movk	x10, #0x7372, lsl #16
    a1b0:	f2ce6d2a 	movk	x10, #0x7369, lsl #32
    a1b4:	f2ecae8a 	movk	x10, #0x6574, lsl #48
    a1b8:	eb0a011f 	cmp	x8, x10
    a1bc:	d28dcca8 	mov	x8, #0x6e65                	// #28261
    a1c0:	f2abee88 	movk	x8, #0x5f74, lsl #16
    a1c4:	f2cd2ee8 	movk	x8, #0x6977, lsl #32
    a1c8:	f2ecac88 	movk	x8, #0x6564, lsl #48
    a1cc:	fa480120 	ccmp	x9, x8, #0x0, eq	// eq = none
    a1d0:	54001001 	b.ne	a3d0 <probe::main+0x6d8>  // b.any
    a1d4:	aa1503e0 	mov	x0, x21
    a1d8:	97fffe41 	bl	9adc <probe::persistent_wide>
    a1dc:	1400003f 	b	a2d8 <probe::main+0x5e0>
    a1e0:	b9400288 	ldr	w8, [x20]
    a1e4:	528c2c49 	mov	w9, #0x6162                	// #24930
    a1e8:	72acae69 	movk	w9, #0x6573, lsl #16
    a1ec:	6b09011f 	cmp	w8, w9
    a1f0:	540005e0 	b.eq	a2ac <probe::main+0x5b4>  // b.none
    a1f4:	b9400288 	ldr	w8, [x20]
    a1f8:	528c2e09 	mov	w9, #0x6170                	// #24944
    a1fc:	72ae4d29 	movk	w9, #0x7269, lsl #16
    a200:	6b09011f 	cmp	w8, w9
    a204:	54000e61 	b.ne	a3d0 <probe::main+0x6d8>  // b.any
    a208:	aa1503e0 	mov	x0, x21
    a20c:	940000bf 	bl	a508 <probe::pair>
    a210:	14000032 	b	a2d8 <probe::main+0x5e0>
    a214:	39401288 	ldrb	w8, [x20, #4]
    a218:	b9400289 	ldr	w9, [x20]
    a21c:	7101951f 	cmp	w8, #0x65
    a220:	528c2ec8 	mov	w8, #0x6176                	// #24950
    a224:	72aead88 	movk	w8, #0x756c, lsl #16
    a228:	7a480120 	ccmp	w9, w8, #0x0, eq	// eq = none
    a22c:	54000460 	b.eq	a2b8 <probe::main+0x5c0>  // b.none
    a230:	39401288 	ldrb	w8, [x20, #4]
    a234:	b9400289 	ldr	w9, [x20]
    a238:	7101e51f 	cmp	w8, #0x79
    a23c:	528e4c28 	mov	w8, #0x7261                	// #29281
    a240:	72ac2e48 	movk	w8, #0x6172, lsl #16
    a244:	7a480120 	ccmp	w9, w8, #0x0, eq	// eq = none
    a248:	54000c41 	b.ne	a3d0 <probe::main+0x6d8>  // b.any
    a24c:	aa1503e0 	mov	x0, x21
    a250:	940000d7 	bl	a5ac <probe::array>
    a254:	14000021 	b	a2d8 <probe::main+0x5e0>
    a258:	f1002f1f 	cmp	x24, #0xb
    a25c:	54000ba1 	b.ne	a3d0 <probe::main+0x6d8>  // b.any
    a260:	d28e4c2a 	mov	x10, #0x7261                	// #29281
    a264:	f9400288 	ldr	x8, [x20]
    a268:	f8403289 	ldur	x9, [x20, #3]
    a26c:	f2ac2e4a 	movk	x10, #0x6172, lsl #16
    a270:	f2cbef2a 	movk	x10, #0x5f79, lsl #32
    a274:	f2ec2eca 	movk	x10, #0x6176, lsl #48
    a278:	eb0a011f 	cmp	x8, x10
    a27c:	d28f2c28 	mov	x8, #0x7961                	// #31073
    a280:	f2aecbe8 	movk	x8, #0x765f, lsl #16
    a284:	f2cd8c28 	movk	x8, #0x6c61, lsl #32
    a288:	f2ecaea8 	movk	x8, #0x6575, lsl #48
    a28c:	fa480120 	ccmp	x9, x8, #0x0, eq	// eq = none
    a290:	54000a01 	b.ne	a3d0 <probe::main+0x6d8>  // b.any
    a294:	aa1503e0 	mov	x0, x21
    a298:	97fffde7 	bl	9a34 <probe::array_value>
    a29c:	1400000f 	b	a2d8 <probe::main+0x5e0>
    a2a0:	aa1503e0 	mov	x0, x21
    a2a4:	97fffd80 	bl	98a4 <probe::persistent>
    a2a8:	1400000c 	b	a2d8 <probe::main+0x5e0>
    a2ac:	aa1503e0 	mov	x0, x21
    a2b0:	97fffe5e 	bl	9c28 <probe::base>
    a2b4:	14000009 	b	a2d8 <probe::main+0x5e0>
    a2b8:	aa1503e0 	mov	x0, x21
    a2bc:	940000e8 	bl	a65c <probe::value>
    a2c0:	14000006 	b	a2d8 <probe::main+0x5e0>
    a2c4:	aa1503e0 	mov	x0, x21
    a2c8:	94000118 	bl	a728 <probe::boundary>
    a2cc:	14000003 	b	a2d8 <probe::main+0x5e0>
    a2d0:	aa1503e0 	mov	x0, x21
    a2d4:	97fffda6 	bl	996c <probe::value_wide>
    a2d8:	b40000b3 	cbz	x19, a2ec <probe::main+0x5f4>
    a2dc:	aa1403e0 	mov	x0, x20
    a2e0:	aa1303e1 	mov	x1, x19
    a2e4:	52800022 	mov	w2, #0x1                   	// #1
    a2e8:	940001f4 	bl	aab8 <__rustc::__rust_dealloc>
    a2ec:	f94007e8 	ldr	x8, [sp, #8]
    a2f0:	f9400fe9 	ldr	x9, [sp, #24]
    a2f4:	eb080129 	subs	x9, x9, x8
    a2f8:	54000200 	b.eq	a338 <probe::main+0x640>  // b.none
    a2fc:	b201f3ea 	mov	x10, #0xaaaaaaaaaaaaaaaa    	// #-6148914691236517206
    a300:	91002114 	add	x20, x8, #0x8
    a304:	f295556a 	movk	x10, #0xaaab
    a308:	9bca7d29 	umulh	x9, x9, x10
    a30c:	d344fd33 	lsr	x19, x9, #4
    a310:	14000004 	b	a320 <probe::main+0x628>
    a314:	f1000673 	subs	x19, x19, #0x1
    a318:	91006294 	add	x20, x20, #0x18
    a31c:	540000e0 	b.eq	a338 <probe::main+0x640>  // b.none
    a320:	f85f8281 	ldur	x1, [x20, #-8]
    a324:	b4ffff81 	cbz	x1, a314 <probe::main+0x61c>
    a328:	f9400280 	ldr	x0, [x20]
    a32c:	52800022 	mov	w2, #0x1                   	// #1
    a330:	940001e2 	bl	aab8 <__rustc::__rust_dealloc>
    a334:	17fffff8 	b	a314 <probe::main+0x61c>
    a338:	f9400be8 	ldr	x8, [sp, #16]
    a33c:	b40000c8 	cbz	x8, a354 <probe::main+0x65c>
    a340:	8b080508 	add	x8, x8, x8, lsl #1
    a344:	f94003e0 	ldr	x0, [sp]
    a348:	52800102 	mov	w2, #0x8                   	// #8
    a34c:	d37df101 	lsl	x1, x8, #3
    a350:	940001da 	bl	aab8 <__rustc::__rust_dealloc>
    a354:	a9494ff4 	ldp	x20, x19, [sp, #144]
    a358:	f94033f9 	ldr	x25, [sp, #96]
    a35c:	a94857f6 	ldp	x22, x21, [sp, #128]
    a360:	a9475ff8 	ldp	x24, x23, [sp, #112]
    a364:	a9457bfd 	ldp	x29, x30, [sp, #80]
    a368:	910283ff 	add	sp, sp, #0xa0
    a36c:	d65f03c0 	ret
    a370:	5100c168 	sub	w8, w11, #0x30
    a374:	7100291f 	cmp	w8, #0xa
    a378:	52800028 	mov	w8, #0x1                   	// #1
    a37c:	1a882500 	cinc	w0, w8, cc	// cc = lo, ul, last
    a380:	14000002 	b	a388 <probe::main+0x690>
    a384:	52800040 	mov	w0, #0x2                   	// #2
    a388:	97ffe77e 	bl	4180 <core::result::unwrap_failed::<core::num::error::ParseIntError>>
    a38c:	1400002a 	b	a434 <probe::main+0x73c>
    a390:	9100a3e1 	add	x1, sp, #0x28
    a394:	d10023a0 	sub	x0, x29, #0x8
    a398:	97ffe787 	bl	41b4 <core::panicking::assert_failed::<core::option::Option<&isize>, core::option::Option<&isize>>>
    a39c:	14000026 	b	a434 <probe::main+0x73c>
    a3a0:	f0000280 	adrp	x0, 5d000 <GCC_except_table5+0x10cb0>
    a3a4:	913bc000 	add	x0, x0, #0xef0
    a3a8:	97fffb9c 	bl	9218 <core::option::unwrap_failed>
    a3ac:	14000022 	b	a434 <probe::main+0x73c>
    a3b0:	f90013ff 	str	xzr, [sp, #32]
    a3b4:	910003e0 	mov	x0, sp
    a3b8:	97fffcec 	bl	9768 <<std::env::Args as core::iter::traits::iterator::Iterator>::try_fold::<core::num::nonzero::NonZero<usize>, <std::env::Args as core::iter::traits::iterator::Iterator::advance_by::SpecAdvanceBy>::spec_advance_by::{closure#0}, core::option::Option<core::num::nonzero::NonZero<usize>>>>
    a3bc:	b4ffcea0 	cbz	x0, 9d90 <probe::main+0x98>
    a3c0:	f0000280 	adrp	x0, 5d000 <GCC_except_table5+0x10cb0>
    a3c4:	913c2000 	add	x0, x0, #0xf08
    a3c8:	97fffb94 	bl	9218 <core::option::unwrap_failed>
    a3cc:	1400001a 	b	a434 <probe::main+0x73c>
    a3d0:	900001a0 	adrp	x0, 3e000 <_fini+0x1cfc>
    a3d4:	912e8000 	add	x0, x0, #0xba0
    a3d8:	f0000282 	adrp	x2, 5d000 <GCC_except_table5+0x10cb0>
    a3dc:	913c8042 	add	x2, x2, #0xf20
    a3e0:	528001c1 	mov	w1, #0xe                   	// #14
    a3e4:	97fffbfa 	bl	93cc <core::panicking::panic>
    a3e8:	14000013 	b	a434 <probe::main+0x73c>
    a3ec:	52800020 	mov	w0, #0x1                   	// #1
    a3f0:	52800081 	mov	w1, #0x4                   	// #4
    a3f4:	97fffb4e 	bl	912c <alloc::raw_vec::handle_error>
    a3f8:	1400000f 	b	a434 <probe::main+0x73c>
    a3fc:	52800020 	mov	w0, #0x1                   	// #1
    a400:	17ffffe2 	b	a388 <probe::main+0x690>
    a404:	d10023a1 	sub	x1, x29, #0x8
    a408:	d10043a0 	sub	x0, x29, #0x10
    a40c:	17ffffe3 	b	a398 <probe::main+0x6a0>
    a410:	2a1f03e0 	mov	w0, wzr
    a414:	17ffffdd 	b	a388 <probe::main+0x690>
    a418:	d10043a0 	sub	x0, x29, #0x10
    a41c:	d10023a1 	sub	x1, x29, #0x8
    a420:	97ffe765 	bl	41b4 <core::panicking::assert_failed::<core::option::Option<&isize>, core::option::Option<&isize>>>
    a424:	14000004 	b	a434 <probe::main+0x73c>
    a428:	d10043a0 	sub	x0, x29, #0x10
    a42c:	d10023a1 	sub	x1, x29, #0x8
    a430:	97ffe761 	bl	41b4 <core::panicking::assert_failed::<core::option::Option<&isize>, core::option::Option<&isize>>>
    a434:	d4200020 	brk	#0x1
    a438:	14000001 	b	a43c <probe::main+0x744>
    a43c:	f94017e1 	ldr	x1, [sp, #40]
    a440:	aa0003f5 	mov	x21, x0
    a444:	b4000201 	cbz	x1, a484 <probe::main+0x78c>
    a448:	f9401be0 	ldr	x0, [sp, #48]
    a44c:	1400000c 	b	a47c <probe::main+0x784>
    a450:	14000003 	b	a45c <probe::main+0x764>
    a454:	aa0003f5 	mov	x21, x0
    a458:	1400000b 	b	a484 <probe::main+0x78c>
    a45c:	aa0003f5 	mov	x21, x0
    a460:	1400000e 	b	a498 <probe::main+0x7a0>
    a464:	aa0003f5 	mov	x21, x0
    a468:	14000007 	b	a484 <probe::main+0x78c>
    a46c:	aa0003f5 	mov	x21, x0
    a470:	b40000b6 	cbz	x22, a484 <probe::main+0x78c>
    a474:	aa1703e0 	mov	x0, x23
    a478:	aa1603e1 	mov	x1, x22
    a47c:	52800022 	mov	w2, #0x1                   	// #1
    a480:	9400018e 	bl	aab8 <__rustc::__rust_dealloc>
    a484:	b40000b3 	cbz	x19, a498 <probe::main+0x7a0>
    a488:	aa1403e0 	mov	x0, x20
    a48c:	aa1303e1 	mov	x1, x19
    a490:	52800022 	mov	w2, #0x1                   	// #1
    a494:	94000189 	bl	aab8 <__rustc::__rust_dealloc>
    a498:	f94007e8 	ldr	x8, [sp, #8]
    a49c:	f9400fe9 	ldr	x9, [sp, #24]
    a4a0:	eb080129 	subs	x9, x9, x8
    a4a4:	54000141 	b.ne	a4cc <probe::main+0x7d4>  // b.any
    a4a8:	f9400be8 	ldr	x8, [sp, #16]
    a4ac:	b40000c8 	cbz	x8, a4c4 <probe::main+0x7cc>
    a4b0:	8b080508 	add	x8, x8, x8, lsl #1
    a4b4:	f94003e0 	ldr	x0, [sp]
    a4b8:	52800102 	mov	w2, #0x8                   	// #8
    a4bc:	d37df101 	lsl	x1, x8, #3
    a4c0:	9400017e 	bl	aab8 <__rustc::__rust_dealloc>
    a4c4:	aa1503e0 	mov	x0, x21
    a4c8:	97ffe70e 	bl	4100 <_Unwind_Resume@plt>
    a4cc:	b201f3ea 	mov	x10, #0xaaaaaaaaaaaaaaaa    	// #-6148914691236517206
    a4d0:	91002114 	add	x20, x8, #0x8
    a4d4:	f295556a 	movk	x10, #0xaaab
    a4d8:	9bca7d29 	umulh	x9, x9, x10
    a4dc:	d344fd33 	lsr	x19, x9, #4
    a4e0:	14000004 	b	a4f0 <probe::main+0x7f8>
    a4e4:	f1000673 	subs	x19, x19, #0x1
    a4e8:	91006294 	add	x20, x20, #0x18
    a4ec:	54fffde0 	b.eq	a4a8 <probe::main+0x7b0>  // b.none
    a4f0:	f85f8281 	ldur	x1, [x20, #-8]
    a4f4:	b4ffff81 	cbz	x1, a4e4 <probe::main+0x7ec>
    a4f8:	f9400280 	ldr	x0, [x20]
    a4fc:	52800022 	mov	w2, #0x1                   	// #1
    a500:	9400016e 	bl	aab8 <__rustc::__rust_dealloc>
    a504:	17fffff8 	b	a4e4 <probe::main+0x7ec>

000000000000a508 <probe::pair>:
    a508:	b4000500 	cbz	x0, a5a8 <probe::pair+0xa0>
    a50c:	d101c3ff 	sub	sp, sp, #0x70
    a510:	a9027bfd 	stp	x29, x30, [sp, #32]
    a514:	f9001bf9 	str	x25, [sp, #48]
    a518:	a9045ff8 	stp	x24, x23, [sp, #64]
    a51c:	a90557f6 	stp	x22, x21, [sp, #80]
    a520:	a9064ff4 	stp	x20, x19, [sp, #96]
    a524:	910083fd 	add	x29, sp, #0x20
    a528:	d282b1f8 	mov	x24, #0x158f                	// #5519
    a52c:	d28d1d79 	mov	x25, #0x68eb                	// #26859
    a530:	aa0003f3 	mov	x19, x0
    a534:	f2bc43f8 	movk	x24, #0xe21f, lsl #16
    a538:	f2b8bbd9 	movk	x25, #0xc5de, lsl #16
    a53c:	910023f4 	add	x20, sp, #0x8
    a540:	f2d46338 	movk	x24, #0xa319, lsl #32
    a544:	f2d036d9 	movk	x25, #0x81b6, lsl #32
    a548:	f0000295 	adrp	x21, 5d000 <GCC_except_table5+0x10cb0>
    a54c:	913982b5 	add	x21, x21, #0xe60
    a550:	910043f6 	add	x22, sp, #0x10
    a554:	910063b7 	add	x23, x29, #0x18
    a558:	f2edceb8 	movk	x24, #0x6e75, lsl #48
    a55c:	f2f36679 	movk	x25, #0x9b33, lsl #48
    a560:	a900d3ff 	stp	xzr, x20, [sp, #8]
    a564:	f9000ff5 	str	x21, [sp, #24]
    a568:	f9000fb6 	str	x22, [x29, #24]
    a56c:	a94123e0 	ldp	x0, x8, [sp, #16]
    a570:	f9400d08 	ldr	x8, [x8, #24]
    a574:	d63f0100 	blr	x8
    a578:	eb18001f 	cmp	x0, x24
    a57c:	fa590020 	ccmp	x1, x25, #0x0, eq	// eq = none
    a580:	1a9f17e8 	cset	w8, eq	// eq = none
    a584:	f1000673 	subs	x19, x19, #0x1
    a588:	390063a8 	strb	w8, [x29, #24]
    a58c:	54fffea1 	b.ne	a560 <probe::pair+0x58>  // b.any
    a590:	a9464ff4 	ldp	x20, x19, [sp, #96]
    a594:	f9401bf9 	ldr	x25, [sp, #48]
    a598:	a94557f6 	ldp	x22, x21, [sp, #80]
    a59c:	a9445ff8 	ldp	x24, x23, [sp, #64]
    a5a0:	a9427bfd 	ldp	x29, x30, [sp, #32]
    a5a4:	9101c3ff 	add	sp, sp, #0x70
    a5a8:	d65f03c0 	ret

000000000000a5ac <probe::array>:
    a5ac:	b4000560 	cbz	x0, a658 <probe::array+0xac>
    a5b0:	d10203ff 	sub	sp, sp, #0x80
    a5b4:	a9037bfd 	stp	x29, x30, [sp, #48]
    a5b8:	a90467fa 	stp	x26, x25, [sp, #64]
    a5bc:	a9055ff8 	stp	x24, x23, [sp, #80]
    a5c0:	a90657f6 	stp	x22, x21, [sp, #96]
    a5c4:	a9074ff4 	stp	x20, x19, [sp, #112]
    a5c8:	9100c3fd 	add	x29, sp, #0x30
    a5cc:	d282b1f8 	mov	x24, #0x158f                	// #5519
    a5d0:	d28d1d79 	mov	x25, #0x68eb                	// #26859
    a5d4:	aa0003f3 	mov	x19, x0
    a5d8:	f2bc43f8 	movk	x24, #0xe21f, lsl #16
    a5dc:	f2b8bbd9 	movk	x25, #0xc5de, lsl #16
    a5e0:	f0000294 	adrp	x20, 5d000 <GCC_except_table5+0x10cb0>
    a5e4:	91390294 	add	x20, x20, #0xe40
    a5e8:	f2d46338 	movk	x24, #0xa319, lsl #32
    a5ec:	f2d036d9 	movk	x25, #0x81b6, lsl #32
    a5f0:	910003f5 	mov	x21, sp
    a5f4:	910023f6 	add	x22, sp, #0x8
    a5f8:	d10043b7 	sub	x23, x29, #0x10
    a5fc:	f2edceb8 	movk	x24, #0x6e75, lsl #48
    a600:	f2f36679 	movk	x25, #0x9b33, lsl #48
    a604:	d10053ba 	sub	x26, x29, #0x14
    a608:	a90057ff 	stp	xzr, x21, [sp]
    a60c:	f9000bf4 	str	x20, [sp, #16]
    a610:	f81f03b6 	stur	x22, [x29, #-16]
    a614:	a940a3e0 	ldp	x0, x8, [sp, #8]
    a618:	f9400d09 	ldr	x9, [x8, #24]
    a61c:	d10043a8 	sub	x8, x29, #0x10
    a620:	d63f0120 	blr	x9
    a624:	a97f27a8 	ldp	x8, x9, [x29, #-16]
    a628:	eb18011f 	cmp	x8, x24
    a62c:	fa590120 	ccmp	x9, x25, #0x0, eq	// eq = none
    a630:	1a9f17e8 	cset	w8, eq	// eq = none
    a634:	f1000673 	subs	x19, x19, #0x1
    a638:	381ec3a8 	sturb	w8, [x29, #-20]
    a63c:	54fffe61 	b.ne	a608 <probe::array+0x5c>  // b.any
    a640:	a9474ff4 	ldp	x20, x19, [sp, #112]
    a644:	a94657f6 	ldp	x22, x21, [sp, #96]
    a648:	a9455ff8 	ldp	x24, x23, [sp, #80]
    a64c:	a94467fa 	ldp	x26, x25, [sp, #64]
    a650:	a9437bfd 	ldp	x29, x30, [sp, #48]
    a654:	910203ff 	add	sp, sp, #0x80
    a658:	d65f03c0 	ret

000000000000a65c <probe::value>:
    a65c:	b4000640 	cbz	x0, a724 <probe::value+0xc8>
    a660:	d101c3ff 	sub	sp, sp, #0x70
    a664:	a9027bfd 	stp	x29, x30, [sp, #32]
    a668:	f9001bf9 	str	x25, [sp, #48]
    a66c:	a9045ff8 	stp	x24, x23, [sp, #64]
    a670:	a90557f6 	stp	x22, x21, [sp, #80]
    a674:	a9064ff4 	stp	x20, x19, [sp, #96]
    a678:	910083fd 	add	x29, sp, #0x20
    a67c:	d28d1d78 	mov	x24, #0x68eb                	// #26859
    a680:	d282b1f9 	mov	x25, #0x158f                	// #5519
    a684:	aa0003f3 	mov	x19, x0
    a688:	f2b8bbd8 	movk	x24, #0xc5de, lsl #16
    a68c:	f2bc43f9 	movk	x25, #0xe21f, lsl #16
    a690:	910063b4 	add	x20, x29, #0x18
    a694:	f2d036d8 	movk	x24, #0x81b6, lsl #32
    a698:	f2d46339 	movk	x25, #0xa319, lsl #32
    a69c:	f0000295 	adrp	x21, 5d000 <GCC_except_table5+0x10cb0>
    a6a0:	913882b5 	add	x21, x21, #0xe20
    a6a4:	910003f6 	mov	x22, sp
    a6a8:	910043f7 	add	x23, sp, #0x10
    a6ac:	f2f36678 	movk	x24, #0x9b33, lsl #48
    a6b0:	f2edceb9 	movk	x25, #0x6e75, lsl #48
    a6b4:	14000008 	b	a6d4 <probe::value+0x78>
    a6b8:	f94003e8 	ldr	x8, [sp]
    a6bc:	f9400108 	ldr	x8, [x8]
    a6c0:	f100011f 	cmp	x8, #0x0
    a6c4:	1a9f17e8 	cset	w8, eq	// eq = none
    a6c8:	390043e8 	strb	w8, [sp, #16]
    a6cc:	f1000673 	subs	x19, x19, #0x1
    a6d0:	540001e0 	b.eq	a70c <probe::value+0xb0>  // b.none
    a6d4:	f9000fbf 	str	xzr, [x29, #24]
    a6d8:	a90057f4 	stp	x20, x21, [sp]
    a6dc:	a94023e0 	ldp	x0, x8, [sp]
    a6e0:	f9400d09 	ldr	x9, [x8, #24]
    a6e4:	910043e8 	add	x8, sp, #0x10
    a6e8:	d63f0120 	blr	x9
    a6ec:	a94127e8 	ldp	x8, x9, [sp, #16]
    a6f0:	ca180129 	eor	x9, x9, x24
    a6f4:	ca190108 	eor	x8, x8, x25
    a6f8:	aa090108 	orr	x8, x8, x9
    a6fc:	b4fffde8 	cbz	x8, a6b8 <probe::value+0x5c>
    a700:	390043ff 	strb	wzr, [sp, #16]
    a704:	f1000673 	subs	x19, x19, #0x1
    a708:	54fffe61 	b.ne	a6d4 <probe::value+0x78>  // b.any
    a70c:	a9464ff4 	ldp	x20, x19, [sp, #96]
    a710:	f9401bf9 	ldr	x25, [sp, #48]
    a714:	a94557f6 	ldp	x22, x21, [sp, #80]
    a718:	a9445ff8 	ldp	x24, x23, [sp, #64]
    a71c:	a9427bfd 	ldp	x29, x30, [sp, #32]
    a720:	9101c3ff 	add	sp, sp, #0x70
    a724:	d65f03c0 	ret

000000000000a728 <probe::boundary>:
    a728:	b4000460 	cbz	x0, a7b4 <probe::boundary+0x8c>
    a72c:	d10183ff 	sub	sp, sp, #0x60
    a730:	a9027bfd 	stp	x29, x30, [sp, #32]
    a734:	f9001bf7 	str	x23, [sp, #48]
    a738:	a90457f6 	stp	x22, x21, [sp, #64]
    a73c:	a9054ff4 	stp	x20, x19, [sp, #80]
    a740:	910083fd 	add	x29, sp, #0x20
    a744:	aa0003f3 	mov	x19, x0
    a748:	f0000294 	adrp	x20, 5d000 <GCC_except_table5+0x10cb0>
    a74c:	91388294 	add	x20, x20, #0xe20
    a750:	910023f5 	add	x21, sp, #0x8
    a754:	910043f6 	add	x22, sp, #0x10
    a758:	910063b7 	add	x23, x29, #0x18
    a75c:	14000004 	b	a76c <probe::boundary+0x44>
    a760:	390063bf 	strb	wzr, [x29, #24]
    a764:	f1000673 	subs	x19, x19, #0x1
    a768:	540001c0 	b.eq	a7a0 <probe::boundary+0x78>  // b.none
    a76c:	a900d7ff 	stp	xzr, x21, [sp, #8]
    a770:	f9000ff4 	str	x20, [sp, #24]
    a774:	f9000fb6 	str	x22, [x29, #24]
    a778:	a94123e0 	ldp	x0, x8, [sp, #16]
    a77c:	f9400d01 	ldr	x1, [x8, #24]
    a780:	9400000e 	bl	a7b8 <probe::isolated>
    a784:	b4fffee0 	cbz	x0, a760 <probe::boundary+0x38>
    a788:	f9400008 	ldr	x8, [x0]
    a78c:	f100011f 	cmp	x8, #0x0
    a790:	1a9f17e8 	cset	w8, eq	// eq = none
    a794:	390063a8 	strb	w8, [x29, #24]
    a798:	f1000673 	subs	x19, x19, #0x1
    a79c:	54fffe81 	b.ne	a76c <probe::boundary+0x44>  // b.any
    a7a0:	a9454ff4 	ldp	x20, x19, [sp, #80]
    a7a4:	f9401bf7 	ldr	x23, [sp, #48]
    a7a8:	a94457f6 	ldp	x22, x21, [sp, #64]
    a7ac:	a9427bfd 	ldp	x29, x30, [sp, #32]
    a7b0:	910183ff 	add	sp, sp, #0x60
    a7b4:	d65f03c0 	ret

000000000000a7b8 <probe::isolated>:
    a7b8:	d100c3ff 	sub	sp, sp, #0x30
    a7bc:	a9017bfd 	stp	x29, x30, [sp, #16]
    a7c0:	f90013f3 	str	x19, [sp, #32]
    a7c4:	910043fd 	add	x29, sp, #0x10
    a7c8:	910003e8 	mov	x8, sp
    a7cc:	aa0003f3 	mov	x19, x0
    a7d0:	d63f0020 	blr	x1
    a7d4:	d28d1d6a 	mov	x10, #0x68eb                	// #26859
    a7d8:	d282b1eb 	mov	x11, #0x158f                	// #5519
    a7dc:	a94027e8 	ldp	x8, x9, [sp]
    a7e0:	f2b8bbca 	movk	x10, #0xc5de, lsl #16
    a7e4:	f2bc43eb 	movk	x11, #0xe21f, lsl #16
    a7e8:	f2d036ca 	movk	x10, #0x81b6, lsl #32
    a7ec:	f2d4632b 	movk	x11, #0xa319, lsl #32
    a7f0:	f2f3666a 	movk	x10, #0x9b33, lsl #48
    a7f4:	f2edceab 	movk	x11, #0x6e75, lsl #48
    a7f8:	ca0a0129 	eor	x9, x9, x10
    a7fc:	ca0b0108 	eor	x8, x8, x11
    a800:	aa090108 	orr	x8, x8, x9
    a804:	f100011f 	cmp	x8, #0x0
    a808:	9a9f0260 	csel	x0, x19, xzr, eq	// eq = none
    a80c:	a9417bfd 	ldp	x29, x30, [sp, #16]
    a810:	f94013f3 	ldr	x19, [sp, #32]
    a814:	9100c3ff 	add	sp, sp, #0x30
    a818:	d65f03c0 	ret

000000000000a81c <probe::repeated>:
    a81c:	b4000600 	cbz	x0, a8dc <probe::repeated+0xc0>
    a820:	d101c3ff 	sub	sp, sp, #0x70
    a824:	a9027bfd 	stp	x29, x30, [sp, #32]
    a828:	f9001bf9 	str	x25, [sp, #48]
    a82c:	a9045ff8 	stp	x24, x23, [sp, #64]
    a830:	a90557f6 	stp	x22, x21, [sp, #80]
    a834:	a9064ff4 	stp	x20, x19, [sp, #96]
    a838:	910083fd 	add	x29, sp, #0x20
    a83c:	d28d1d78 	mov	x24, #0x68eb                	// #26859
    a840:	d282b1f9 	mov	x25, #0x158f                	// #5519
    a844:	aa0203f3 	mov	x19, x2
    a848:	f2b8bbd8 	movk	x24, #0xc5de, lsl #16
    a84c:	f2bc43f9 	movk	x25, #0xe21f, lsl #16
    a850:	aa0003f4 	mov	x20, x0
    a854:	f2d036d8 	movk	x24, #0x81b6, lsl #32
    a858:	f2d46339 	movk	x25, #0xa319, lsl #32
    a85c:	aa0103f5 	mov	x21, x1
    a860:	910003f6 	mov	x22, sp
    a864:	910043f7 	add	x23, sp, #0x10
    a868:	f2f36678 	movk	x24, #0x9b33, lsl #48
    a86c:	f2edceb9 	movk	x25, #0x6e75, lsl #48
    a870:	14000008 	b	a890 <probe::repeated+0x74>
    a874:	f94003e8 	ldr	x8, [sp]
    a878:	f9400108 	ldr	x8, [x8]
    a87c:	f100011f 	cmp	x8, #0x0
    a880:	1a9f17e8 	cset	w8, eq	// eq = none
    a884:	390043e8 	strb	w8, [sp, #16]
    a888:	f1000694 	subs	x20, x20, #0x1
    a88c:	540001c0 	b.eq	a8c4 <probe::repeated+0xa8>  // b.none
    a890:	a9004ff5 	stp	x21, x19, [sp]
    a894:	a94023e0 	ldp	x0, x8, [sp]
    a898:	f9400d09 	ldr	x9, [x8, #24]
    a89c:	910043e8 	add	x8, sp, #0x10
    a8a0:	d63f0120 	blr	x9
    a8a4:	a94127e8 	ldp	x8, x9, [sp, #16]
    a8a8:	ca180129 	eor	x9, x9, x24
    a8ac:	ca190108 	eor	x8, x8, x25
    a8b0:	aa090108 	orr	x8, x8, x9
    a8b4:	b4fffe08 	cbz	x8, a874 <probe::repeated+0x58>
    a8b8:	390043ff 	strb	wzr, [sp, #16]
    a8bc:	f1000694 	subs	x20, x20, #0x1
    a8c0:	54fffe81 	b.ne	a890 <probe::repeated+0x74>  // b.any
    a8c4:	a9464ff4 	ldp	x20, x19, [sp, #96]
    a8c8:	f9401bf9 	ldr	x25, [sp, #48]
    a8cc:	a94557f6 	ldp	x22, x21, [sp, #80]
    a8d0:	a9445ff8 	ldp	x24, x23, [sp, #64]
    a8d4:	a9427bfd 	ldp	x29, x30, [sp, #32]
    a8d8:	9101c3ff 	add	sp, sp, #0x70
    a8dc:	d65f03c0 	ret

