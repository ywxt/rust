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
    9844:	900002b5 	adrp	x21, 5d000 <GCC_except_table5+0x10c50>
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
    98a4:	d10203ff 	sub	sp, sp, #0x80
    98a8:	a9037bfd 	stp	x29, x30, [sp, #48]
    98ac:	f90023f9 	str	x25, [sp, #64]
    98b0:	a9055ff8 	stp	x24, x23, [sp, #80]
    98b4:	a90657f6 	stp	x22, x21, [sp, #96]
    98b8:	a9074ff4 	stp	x20, x19, [sp, #112]
    98bc:	9100c3fd 	add	x29, sp, #0x30
    98c0:	910003e8 	mov	x8, sp
    98c4:	900002a9 	adrp	x9, 5d000 <GCC_except_table5+0x10c50>
    98c8:	91388129 	add	x9, x9, #0xe20
    98cc:	a90023ff 	stp	xzr, x8, [sp]
    98d0:	f9000be9 	str	x9, [sp, #16]
    98d4:	b4000440 	cbz	x0, 995c <probe::persistent+0xb8>
    98d8:	d28d1d77 	mov	x23, #0x68eb                	// #26859
    98dc:	d282b1f8 	mov	x24, #0x158f                	// #5519
    98e0:	aa0003f3 	mov	x19, x0
    98e4:	f2b8bbd7 	movk	x23, #0xc5de, lsl #16
    98e8:	f2bc43f8 	movk	x24, #0xe21f, lsl #16
    98ec:	910023f5 	add	x21, sp, #0x8
    98f0:	f2d036d7 	movk	x23, #0x81b6, lsl #32
    98f4:	f2d46338 	movk	x24, #0xa319, lsl #32
    98f8:	910063f6 	add	x22, sp, #0x18
    98fc:	f2f36677 	movk	x23, #0x9b33, lsl #48
    9900:	f2edceb8 	movk	x24, #0x6e75, lsl #48
    9904:	910073b9 	add	x25, x29, #0x1c
    9908:	14000007 	b	9924 <probe::persistent+0x80>
    990c:	f9400288 	ldr	x8, [x20]
    9910:	f100011f 	cmp	x8, #0x0
    9914:	1a9f17e8 	cset	w8, eq	// eq = none
    9918:	390073a8 	strb	w8, [x29, #28]
    991c:	f1000673 	subs	x19, x19, #0x1
    9920:	540001e0 	b.eq	995c <probe::persistent+0xb8>  // b.none
    9924:	f9000ff5 	str	x21, [sp, #24]
    9928:	a940a3f4 	ldp	x20, x8, [sp, #8]
    992c:	f9400d09 	ldr	x9, [x8, #24]
    9930:	d10043a8 	sub	x8, x29, #0x10
    9934:	aa1403e0 	mov	x0, x20
    9938:	d63f0120 	blr	x9
    993c:	a97f27a8 	ldp	x8, x9, [x29, #-16]
    9940:	ca170129 	eor	x9, x9, x23
    9944:	ca180108 	eor	x8, x8, x24
    9948:	aa090108 	orr	x8, x8, x9
    994c:	b4fffe08 	cbz	x8, 990c <probe::persistent+0x68>
    9950:	390073bf 	strb	wzr, [x29, #28]
    9954:	f1000673 	subs	x19, x19, #0x1
    9958:	54fffe61 	b.ne	9924 <probe::persistent+0x80>  // b.any
    995c:	a9474ff4 	ldp	x20, x19, [sp, #112]
    9960:	f94023f9 	ldr	x25, [sp, #64]
    9964:	a94657f6 	ldp	x22, x21, [sp, #96]
    9968:	a9455ff8 	ldp	x24, x23, [sp, #80]
    996c:	a9437bfd 	ldp	x29, x30, [sp, #48]
    9970:	910203ff 	add	sp, sp, #0x80
    9974:	d65f03c0 	ret

0000000000009978 <probe::value_wide>:
    9978:	b4000620 	cbz	x0, 9a3c <probe::value_wide+0xc4>
    997c:	d10203ff 	sub	sp, sp, #0x80
    9980:	a9037bfd 	stp	x29, x30, [sp, #48]
    9984:	f90023f9 	str	x25, [sp, #64]
    9988:	a9055ff8 	stp	x24, x23, [sp, #80]
    998c:	a90657f6 	stp	x22, x21, [sp, #96]
    9990:	a9074ff4 	stp	x20, x19, [sp, #112]
    9994:	9100c3fd 	add	x29, sp, #0x30
    9998:	d28d1d77 	mov	x23, #0x68eb                	// #26859
    999c:	d282b1f8 	mov	x24, #0x158f                	// #5519
    99a0:	aa0003f3 	mov	x19, x0
    99a4:	f2b8bbd7 	movk	x23, #0xc5de, lsl #16
    99a8:	f2bc43f8 	movk	x24, #0xe21f, lsl #16
    99ac:	910023f4 	add	x20, sp, #0x8
    99b0:	f2d036d7 	movk	x23, #0x81b6, lsl #32
    99b4:	f2d46338 	movk	x24, #0xa319, lsl #32
    99b8:	900002b5 	adrp	x21, 5d000 <GCC_except_table5+0x10c50>
    99bc:	913882b5 	add	x21, x21, #0xe20
    99c0:	910043f6 	add	x22, sp, #0x10
    99c4:	f2f36677 	movk	x23, #0x9b33, lsl #48
    99c8:	f2edceb8 	movk	x24, #0x6e75, lsl #48
    99cc:	910063b9 	add	x25, x29, #0x18
    99d0:	14000004 	b	99e0 <probe::value_wide+0x68>
    99d4:	f9000fa8 	str	x8, [x29, #24]
    99d8:	f1000673 	subs	x19, x19, #0x1
    99dc:	54000240 	b.eq	9a24 <probe::value_wide+0xac>  // b.none
    99e0:	a900d3ff 	stp	xzr, x20, [sp, #8]
    99e4:	f9000ff5 	str	x21, [sp, #24]
    99e8:	a94123e0 	ldp	x0, x8, [sp, #16]
    99ec:	f9400d09 	ldr	x9, [x8, #24]
    99f0:	d10043a8 	sub	x8, x29, #0x10
    99f4:	d63f0120 	blr	x9
    99f8:	a97f27a8 	ldp	x8, x9, [x29, #-16]
    99fc:	ca170129 	eor	x9, x9, x23
    9a00:	ca180108 	eor	x8, x8, x24
    9a04:	aa090109 	orr	x9, x8, x9
    9a08:	aa1f03e8 	mov	x8, xzr
    9a0c:	b5fffe49 	cbnz	x9, 99d4 <probe::value_wide+0x5c>
    9a10:	f9400be8 	ldr	x8, [sp, #16]
    9a14:	f9400108 	ldr	x8, [x8]
    9a18:	f100011f 	cmp	x8, #0x0
    9a1c:	1a9f17e8 	cset	w8, eq	// eq = none
    9a20:	17ffffed 	b	99d4 <probe::value_wide+0x5c>
    9a24:	a9474ff4 	ldp	x20, x19, [sp, #112]
    9a28:	f94023f9 	ldr	x25, [sp, #64]
    9a2c:	a94657f6 	ldp	x22, x21, [sp, #96]
    9a30:	a9455ff8 	ldp	x24, x23, [sp, #80]
    9a34:	a9437bfd 	ldp	x29, x30, [sp, #48]
    9a38:	910203ff 	add	sp, sp, #0x80
    9a3c:	d65f03c0 	ret

0000000000009a40 <probe::array_value>:
    9a40:	b4000520 	cbz	x0, 9ae4 <probe::array_value+0xa4>
    9a44:	d10203ff 	sub	sp, sp, #0x80
    9a48:	a9037bfd 	stp	x29, x30, [sp, #48]
    9a4c:	f90023f9 	str	x25, [sp, #64]
    9a50:	a9055ff8 	stp	x24, x23, [sp, #80]
    9a54:	a90657f6 	stp	x22, x21, [sp, #96]
    9a58:	a9074ff4 	stp	x20, x19, [sp, #112]
    9a5c:	9100c3fd 	add	x29, sp, #0x30
    9a60:	d282b1f7 	mov	x23, #0x158f                	// #5519
    9a64:	d28d1d78 	mov	x24, #0x68eb                	// #26859
    9a68:	aa0003f3 	mov	x19, x0
    9a6c:	f2bc43f7 	movk	x23, #0xe21f, lsl #16
    9a70:	f2b8bbd8 	movk	x24, #0xc5de, lsl #16
    9a74:	910023f4 	add	x20, sp, #0x8
    9a78:	f2d46337 	movk	x23, #0xa319, lsl #32
    9a7c:	f2d036d8 	movk	x24, #0x81b6, lsl #32
    9a80:	900002b5 	adrp	x21, 5d000 <GCC_except_table5+0x10c50>
    9a84:	913902b5 	add	x21, x21, #0xe40
    9a88:	910043f6 	add	x22, sp, #0x10
    9a8c:	f2edceb7 	movk	x23, #0x6e75, lsl #48
    9a90:	f2f36678 	movk	x24, #0x9b33, lsl #48
    9a94:	910073b9 	add	x25, x29, #0x1c
    9a98:	a900d3ff 	stp	xzr, x20, [sp, #8]
    9a9c:	f9000ff5 	str	x21, [sp, #24]
    9aa0:	a94123e0 	ldp	x0, x8, [sp, #16]
    9aa4:	f9400d09 	ldr	x9, [x8, #24]
    9aa8:	d10043a8 	sub	x8, x29, #0x10
    9aac:	d63f0120 	blr	x9
    9ab0:	a97f27a8 	ldp	x8, x9, [x29, #-16]
    9ab4:	eb17011f 	cmp	x8, x23
    9ab8:	fa580120 	ccmp	x9, x24, #0x0, eq	// eq = none
    9abc:	1a9f17e8 	cset	w8, eq	// eq = none
    9ac0:	f1000673 	subs	x19, x19, #0x1
    9ac4:	390073a8 	strb	w8, [x29, #28]
    9ac8:	54fffe81 	b.ne	9a98 <probe::array_value+0x58>  // b.any
    9acc:	a9474ff4 	ldp	x20, x19, [sp, #112]
    9ad0:	f94023f9 	ldr	x25, [sp, #64]
    9ad4:	a94657f6 	ldp	x22, x21, [sp, #96]
    9ad8:	a9455ff8 	ldp	x24, x23, [sp, #80]
    9adc:	a9437bfd 	ldp	x29, x30, [sp, #48]
    9ae0:	910203ff 	add	sp, sp, #0x80
    9ae4:	d65f03c0 	ret

0000000000009ae8 <probe::persistent_wide>:
    9ae8:	d10203ff 	sub	sp, sp, #0x80
    9aec:	a9037bfd 	stp	x29, x30, [sp, #48]
    9af0:	f90023f9 	str	x25, [sp, #64]
    9af4:	a9055ff8 	stp	x24, x23, [sp, #80]
    9af8:	a90657f6 	stp	x22, x21, [sp, #96]
    9afc:	a9074ff4 	stp	x20, x19, [sp, #112]
    9b00:	9100c3fd 	add	x29, sp, #0x30
    9b04:	910003e8 	mov	x8, sp
    9b08:	900002a9 	adrp	x9, 5d000 <GCC_except_table5+0x10c50>
    9b0c:	91388129 	add	x9, x9, #0xe20
    9b10:	a90023ff 	stp	xzr, x8, [sp]
    9b14:	f9000be9 	str	x9, [sp, #16]
    9b18:	b4000440 	cbz	x0, 9ba0 <probe::persistent_wide+0xb8>
    9b1c:	d28d1d77 	mov	x23, #0x68eb                	// #26859
    9b20:	d282b1f8 	mov	x24, #0x158f                	// #5519
    9b24:	aa0003f3 	mov	x19, x0
    9b28:	f2b8bbd7 	movk	x23, #0xc5de, lsl #16
    9b2c:	f2bc43f8 	movk	x24, #0xe21f, lsl #16
    9b30:	910023f5 	add	x21, sp, #0x8
    9b34:	f2d036d7 	movk	x23, #0x81b6, lsl #32
    9b38:	f2d46338 	movk	x24, #0xa319, lsl #32
    9b3c:	910063f6 	add	x22, sp, #0x18
    9b40:	f2f36677 	movk	x23, #0x9b33, lsl #48
    9b44:	f2edceb8 	movk	x24, #0x6e75, lsl #48
    9b48:	910063b9 	add	x25, x29, #0x18
    9b4c:	14000007 	b	9b68 <probe::persistent_wide+0x80>
    9b50:	f9400288 	ldr	x8, [x20]
    9b54:	f100011f 	cmp	x8, #0x0
    9b58:	1a9f17e8 	cset	w8, eq	// eq = none
    9b5c:	f9000fa8 	str	x8, [x29, #24]
    9b60:	f1000673 	subs	x19, x19, #0x1
    9b64:	540001e0 	b.eq	9ba0 <probe::persistent_wide+0xb8>  // b.none
    9b68:	f9000ff5 	str	x21, [sp, #24]
    9b6c:	a940a3f4 	ldp	x20, x8, [sp, #8]
    9b70:	f9400d09 	ldr	x9, [x8, #24]
    9b74:	d10043a8 	sub	x8, x29, #0x10
    9b78:	aa1403e0 	mov	x0, x20
    9b7c:	d63f0120 	blr	x9
    9b80:	a97f27a8 	ldp	x8, x9, [x29, #-16]
    9b84:	ca170129 	eor	x9, x9, x23
    9b88:	ca180108 	eor	x8, x8, x24
    9b8c:	aa090108 	orr	x8, x8, x9
    9b90:	b4fffe08 	cbz	x8, 9b50 <probe::persistent_wide+0x68>
    9b94:	f9000fbf 	str	xzr, [x29, #24]
    9b98:	f1000673 	subs	x19, x19, #0x1
    9b9c:	54fffe61 	b.ne	9b68 <probe::persistent_wide+0x80>  // b.any
    9ba0:	a9474ff4 	ldp	x20, x19, [sp, #112]
    9ba4:	f94023f9 	ldr	x25, [sp, #64]
    9ba8:	a94657f6 	ldp	x22, x21, [sp, #96]
    9bac:	a9455ff8 	ldp	x24, x23, [sp, #80]
    9bb0:	a9437bfd 	ldp	x29, x30, [sp, #48]
    9bb4:	910203ff 	add	sp, sp, #0x80
    9bb8:	d65f03c0 	ret

0000000000009bbc <probe::repeated_boundary>:
    9bbc:	b4000400 	cbz	x0, 9c3c <probe::repeated_boundary+0x80>
    9bc0:	d10143ff 	sub	sp, sp, #0x50
    9bc4:	a9017bfd 	stp	x29, x30, [sp, #16]
    9bc8:	f90013f7 	str	x23, [sp, #32]
    9bcc:	a90357f6 	stp	x22, x21, [sp, #48]
    9bd0:	a9044ff4 	stp	x20, x19, [sp, #64]
    9bd4:	910043fd 	add	x29, sp, #0x10
    9bd8:	aa0203f3 	mov	x19, x2
    9bdc:	aa0003f4 	mov	x20, x0
    9be0:	aa0103f5 	mov	x21, x1
    9be4:	910003f6 	mov	x22, sp
    9be8:	910073b7 	add	x23, x29, #0x1c
    9bec:	14000004 	b	9bfc <probe::repeated_boundary+0x40>
    9bf0:	390073bf 	strb	wzr, [x29, #28]
    9bf4:	f1000694 	subs	x20, x20, #0x1
    9bf8:	54000180 	b.eq	9c28 <probe::repeated_boundary+0x6c>  // b.none
    9bfc:	a9004ff5 	stp	x21, x19, [sp]
    9c00:	a94023e0 	ldp	x0, x8, [sp]
    9c04:	f9400d01 	ldr	x1, [x8, #24]
    9c08:	940002fc 	bl	a7f8 <probe::isolated>
    9c0c:	b4ffff20 	cbz	x0, 9bf0 <probe::repeated_boundary+0x34>
    9c10:	f9400008 	ldr	x8, [x0]
    9c14:	f100011f 	cmp	x8, #0x0
    9c18:	1a9f17e8 	cset	w8, eq	// eq = none
    9c1c:	390073a8 	strb	w8, [x29, #28]
    9c20:	f1000694 	subs	x20, x20, #0x1
    9c24:	54fffec1 	b.ne	9bfc <probe::repeated_boundary+0x40>  // b.any
    9c28:	a9444ff4 	ldp	x20, x19, [sp, #64]
    9c2c:	f94013f7 	ldr	x23, [sp, #32]
    9c30:	a94357f6 	ldp	x22, x21, [sp, #48]
    9c34:	a9417bfd 	ldp	x29, x30, [sp, #16]
    9c38:	910143ff 	add	sp, sp, #0x50
    9c3c:	d65f03c0 	ret

0000000000009c40 <probe::base>:
    9c40:	b40006a0 	cbz	x0, 9d14 <probe::base+0xd4>
    9c44:	d10243ff 	sub	sp, sp, #0x90
    9c48:	a9037bfd 	stp	x29, x30, [sp, #48]
    9c4c:	f90023fb 	str	x27, [sp, #64]
    9c50:	a90567fa 	stp	x26, x25, [sp, #80]
    9c54:	a9065ff8 	stp	x24, x23, [sp, #96]
    9c58:	a90757f6 	stp	x22, x21, [sp, #112]
    9c5c:	a9084ff4 	stp	x20, x19, [sp, #128]
    9c60:	9100c3fd 	add	x29, sp, #0x30
    9c64:	d28d1d79 	mov	x25, #0x68eb                	// #26859
    9c68:	d282b1fa 	mov	x26, #0x158f                	// #5519
    9c6c:	aa0003f3 	mov	x19, x0
    9c70:	f2b8bbd9 	movk	x25, #0xc5de, lsl #16
    9c74:	f2bc43fa 	movk	x26, #0xe21f, lsl #16
    9c78:	900002b5 	adrp	x21, 5d000 <GCC_except_table5+0x10c50>
    9c7c:	913882b5 	add	x21, x21, #0xe20
    9c80:	f2d036d9 	movk	x25, #0x81b6, lsl #32
    9c84:	f2d4633a 	movk	x26, #0xa319, lsl #32
    9c88:	910003f6 	mov	x22, sp
    9c8c:	910023f7 	add	x23, sp, #0x8
    9c90:	910063f8 	add	x24, sp, #0x18
    9c94:	f2f36679 	movk	x25, #0x9b33, lsl #48
    9c98:	f2edceba 	movk	x26, #0x6e75, lsl #48
    9c9c:	910073bb 	add	x27, x29, #0x1c
    9ca0:	14000007 	b	9cbc <probe::base+0x7c>
    9ca4:	f9400288 	ldr	x8, [x20]
    9ca8:	f100011f 	cmp	x8, #0x0
    9cac:	1a9f17e8 	cset	w8, eq	// eq = none
    9cb0:	390073a8 	strb	w8, [x29, #28]
    9cb4:	f1000673 	subs	x19, x19, #0x1
    9cb8:	54000200 	b.eq	9cf8 <probe::base+0xb8>  // b.none
    9cbc:	a9005bff 	stp	xzr, x22, [sp]
    9cc0:	a9015ff5 	stp	x21, x23, [sp, #16]
    9cc4:	a940a3f4 	ldp	x20, x8, [sp, #8]
    9cc8:	f9400d09 	ldr	x9, [x8, #24]
    9ccc:	d10043a8 	sub	x8, x29, #0x10
    9cd0:	aa1403e0 	mov	x0, x20
    9cd4:	d63f0120 	blr	x9
    9cd8:	a97f27a8 	ldp	x8, x9, [x29, #-16]
    9cdc:	ca190129 	eor	x9, x9, x25
    9ce0:	ca1a0108 	eor	x8, x8, x26
    9ce4:	aa090108 	orr	x8, x8, x9
    9ce8:	b4fffde8 	cbz	x8, 9ca4 <probe::base+0x64>
    9cec:	390073bf 	strb	wzr, [x29, #28]
    9cf0:	f1000673 	subs	x19, x19, #0x1
    9cf4:	54fffe41 	b.ne	9cbc <probe::base+0x7c>  // b.any
    9cf8:	a9484ff4 	ldp	x20, x19, [sp, #128]
    9cfc:	f94023fb 	ldr	x27, [sp, #64]
    9d00:	a94757f6 	ldp	x22, x21, [sp, #112]
    9d04:	a9465ff8 	ldp	x24, x23, [sp, #96]
    9d08:	a94567fa 	ldp	x26, x25, [sp, #80]
    9d0c:	a9437bfd 	ldp	x29, x30, [sp, #48]
    9d10:	910243ff 	add	sp, sp, #0x90
    9d14:	d65f03c0 	ret

0000000000009d18 <probe::main>:
    9d18:	d10683ff 	sub	sp, sp, #0x1a0
    9d1c:	a9157bfd 	stp	x29, x30, [sp, #336]
    9d20:	a91667fc 	stp	x28, x25, [sp, #352]
    9d24:	a9175ff8 	stp	x24, x23, [sp, #368]
    9d28:	a91857f6 	stp	x22, x21, [sp, #384]
    9d2c:	a9194ff4 	stp	x20, x19, [sp, #400]
    9d30:	910543fd 	add	x29, sp, #0x150
    9d34:	910003e8 	mov	x8, sp
    9d38:	940066eb 	bl	238e4 <std::env::args>
    9d3c:	f90013ff 	str	xzr, [sp, #32]
    9d40:	9101e3e8 	add	x8, sp, #0x78
    9d44:	910003e0 	mov	x0, sp
    9d48:	94007b13 	bl	28994 <<std::env::Args as core::iter::traits::iterator::Iterator>::next>
    9d4c:	f9403fe1 	ldr	x1, [sp, #120]
    9d50:	b40000c1 	cbz	x1, 9d68 <probe::main+0x50>
    9d54:	b100043f 	cmn	x1, #0x1
    9d58:	540032e0 	b.eq	a3b4 <probe::main+0x69c>  // b.none
    9d5c:	f94043e0 	ldr	x0, [sp, #128]
    9d60:	52800022 	mov	w2, #0x1                   	// #1
    9d64:	94000365 	bl	aaf8 <__rustc::__rust_dealloc>
    9d68:	9100a3e8 	add	x8, sp, #0x28
    9d6c:	910003e0 	mov	x0, sp
    9d70:	94007b09 	bl	28994 <<std::env::Args as core::iter::traits::iterator::Iterator>::next>
    9d74:	f94017f3 	ldr	x19, [sp, #40]
    9d78:	b100067f 	cmn	x19, #0x1
    9d7c:	540031c0 	b.eq	a3b4 <probe::main+0x69c>  // b.none
    9d80:	a94363f4 	ldp	x20, x24, [sp, #48]
    9d84:	f100171f 	cmp	x24, #0x5
    9d88:	54000101 	b.ne	9da8 <probe::main+0x90>  // b.any
    9d8c:	39401288 	ldrb	w8, [x20, #4]
    9d90:	b9400289 	ldr	w9, [x20]
    9d94:	7101ad1f 	cmp	w8, #0x6b
    9d98:	528d0c68 	mov	w8, #0x6863                	// #26723
    9d9c:	72ac6ca8 	movk	w8, #0x6365, lsl #16
    9da0:	7a480120 	ccmp	w9, w8, #0x0, eq	// eq = none
    9da4:	54001380 	b.eq	a014 <probe::main+0x2fc>  // b.none
    9da8:	f94013e1 	ldr	x1, [sp, #32]
    9dac:	b50030c1 	cbnz	x1, a3c4 <probe::main+0x6ac>
    9db0:	910103e8 	add	x8, sp, #0x40
    9db4:	910003e0 	mov	x0, sp
    9db8:	94007af7 	bl	28994 <<std::env::Args as core::iter::traits::iterator::Iterator>::next>
    9dbc:	f94023f6 	ldr	x22, [sp, #64]
    9dc0:	b10006df 	cmn	x22, #0x1
    9dc4:	54003080 	b.eq	a3d4 <probe::main+0x6bc>  // b.none
    9dc8:	a944a3f7 	ldp	x23, x8, [sp, #72]
    9dcc:	f100051f 	cmp	x8, #0x1
    9dd0:	54000080 	b.eq	9de0 <probe::main+0xc8>  // b.none
    9dd4:	b40032e8 	cbz	x8, a430 <probe::main+0x718>
    9dd8:	394002e9 	ldrb	w9, [x23]
    9ddc:	14000007 	b	9df8 <probe::main+0xe0>
    9de0:	394002e9 	ldrb	w9, [x23]
    9de4:	52800020 	mov	w0, #0x1                   	// #1
    9de8:	7100ad3f 	cmp	w9, #0x2b
    9dec:	54002d80 	b.eq	a39c <probe::main+0x684>  // b.none
    9df0:	7100b53f 	cmp	w9, #0x2d
    9df4:	54002d40 	b.eq	a39c <probe::main+0x684>  // b.none
    9df8:	7100ad3f 	cmp	w9, #0x2b
    9dfc:	1a9f17e9 	cset	w9, eq	// eq = none
    9e00:	cb090108 	sub	x8, x8, x9
    9e04:	9a9716e9 	cinc	x9, x23, eq	// eq = none
    9e08:	f100451f 	cmp	x8, #0x11
    9e0c:	540001a2 	b.cs	9e40 <probe::main+0x128>  // b.hs, b.nlast
    9e10:	aa1f03f5 	mov	x21, xzr
    9e14:	b4000348 	cbz	x8, 9e7c <probe::main+0x164>
    9e18:	5280014a 	mov	w10, #0xa                   	// #10
    9e1c:	3840152b 	ldrb	w11, [x9], #1
    9e20:	5100c16b 	sub	w11, w11, #0x30
    9e24:	7100257f 	cmp	w11, #0x9
    9e28:	54002f48 	b.hi	a410 <probe::main+0x6f8>  // b.pmore
    9e2c:	9b0a7eac 	mul	x12, x21, x10
    9e30:	f1000508 	subs	x8, x8, #0x1
    9e34:	8b2b4195 	add	x21, x12, w11, uxtw
    9e38:	54ffff21 	b.ne	9e1c <probe::main+0x104>  // b.any
    9e3c:	14000010 	b	9e7c <probe::main+0x164>
    9e40:	aa1f03f5 	mov	x21, xzr
    9e44:	5280014a 	mov	w10, #0xa                   	// #10
    9e48:	9bca7eac 	umulh	x12, x21, x10
    9e4c:	3840152b 	ldrb	w11, [x9], #1
    9e50:	eb0c03ff 	cmp	xzr, x12
    9e54:	54002981 	b.ne	a384 <probe::main+0x66c>  // b.any
    9e58:	5100c16b 	sub	w11, w11, #0x30
    9e5c:	7100297f 	cmp	w11, #0xa
    9e60:	54002d82 	b.cs	a410 <probe::main+0x6f8>  // b.hs, b.nlast
    9e64:	8b150aac 	add	x12, x21, x21, lsl #2
    9e68:	d37ff98c 	lsl	x12, x12, #1
    9e6c:	ab2b4195 	adds	x21, x12, w11, uxtw
    9e70:	54002942 	b.cs	a398 <probe::main+0x680>  // b.hs, b.nlast
    9e74:	d1000508 	sub	x8, x8, #0x1
    9e78:	b5fffe88 	cbnz	x8, 9e48 <probe::main+0x130>
    9e7c:	b40000b6 	cbz	x22, 9e90 <probe::main+0x178>
    9e80:	aa1703e0 	mov	x0, x23
    9e84:	aa1603e1 	mov	x1, x22
    9e88:	52800022 	mov	w2, #0x1                   	// #1
    9e8c:	9400031b 	bl	aaf8 <__rustc::__rust_dealloc>
    9e90:	f100271f 	cmp	x24, #0x9
    9e94:	540003ed 	b.le	9f10 <probe::main+0x1f8>
    9e98:	f1003b1f 	cmp	x24, #0xe
    9e9c:	5400076d 	b.le	9f88 <probe::main+0x270>
    9ea0:	f1003f1f 	cmp	x24, #0xf
    9ea4:	54001880 	b.eq	a1b4 <probe::main+0x49c>  // b.none
    9ea8:	f100471f 	cmp	x24, #0x11
    9eac:	540029c1 	b.ne	a3e4 <probe::main+0x6cc>  // b.any
    9eb0:	39404288 	ldrb	w8, [x20, #16]
    9eb4:	a940268a 	ldp	x10, x9, [x20]
    9eb8:	7101e51f 	cmp	w8, #0x79
    9ebc:	d28c4be8 	mov	x8, #0x625f                	// #25183
    9ec0:	f2aeade8 	movk	x8, #0x756f, lsl #16
    9ec4:	f2cc8dc8 	movk	x8, #0x646e, lsl #32
    9ec8:	f2ee4c28 	movk	x8, #0x7261, lsl #48
    9ecc:	fa480120 	ccmp	x9, x8, #0x0, eq	// eq = none
    9ed0:	d28cae48 	mov	x8, #0x6572                	// #25970
    9ed4:	f2acae08 	movk	x8, #0x6570, lsl #16
    9ed8:	f2ce8c28 	movk	x8, #0x7461, lsl #32
    9edc:	f2ec8ca8 	movk	x8, #0x6465, lsl #48
    9ee0:	fa480140 	ccmp	x10, x8, #0x0, eq	// eq = none
    9ee4:	54002801 	b.ne	a3e4 <probe::main+0x6cc>  // b.any
    9ee8:	b00001a8 	adrp	x8, 3e000 <_fini+0x1cbc>
    9eec:	91286108 	add	x8, x8, #0xa18
    9ef0:	900002a9 	adrp	x9, 5d000 <GCC_except_table5+0x10c50>
    9ef4:	91388129 	add	x9, x9, #0xe20
    9ef8:	a906a7e8 	stp	x8, x9, [sp, #104]
    9efc:	9101a3e8 	add	x8, sp, #0x68
    9f00:	a9468be1 	ldp	x1, x2, [sp, #104]
    9f04:	aa1503e0 	mov	x0, x21
    9f08:	97ffff2d 	bl	9bbc <probe::repeated_boundary>
    9f0c:	140000f8 	b	a2ec <probe::main+0x5d4>
    9f10:	f100131f 	cmp	x24, #0x4
    9f14:	54001700 	b.eq	a1f4 <probe::main+0x4dc>  // b.none
    9f18:	f100171f 	cmp	x24, #0x5
    9f1c:	54001860 	b.eq	a228 <probe::main+0x510>  // b.none
    9f20:	f100231f 	cmp	x24, #0x8
    9f24:	54002601 	b.ne	a3e4 <probe::main+0x6cc>  // b.any
    9f28:	d28dec49 	mov	x9, #0x6f62                	// #28514
    9f2c:	f9400288 	ldr	x8, [x20]
    9f30:	f2adcea9 	movk	x9, #0x6e75, lsl #16
    9f34:	f2cc2c89 	movk	x9, #0x6164, lsl #32
    9f38:	f2ef2e49 	movk	x9, #0x7972, lsl #48
    9f3c:	eb09011f 	cmp	x8, x9
    9f40:	54001c60 	b.eq	a2cc <probe::main+0x5b4>  // b.none
    9f44:	d28cae49 	mov	x9, #0x6572                	// #25970
    9f48:	f9400288 	ldr	x8, [x20]
    9f4c:	f2acae09 	movk	x9, #0x6570, lsl #16
    9f50:	f2ce8c29 	movk	x9, #0x7461, lsl #32
    9f54:	f2ec8ca9 	movk	x9, #0x6465, lsl #48
    9f58:	eb09011f 	cmp	x8, x9
    9f5c:	54002441 	b.ne	a3e4 <probe::main+0x6cc>  // b.any
    9f60:	b00001a8 	adrp	x8, 3e000 <_fini+0x1cbc>
    9f64:	91286108 	add	x8, x8, #0xa18
    9f68:	900002a9 	adrp	x9, 5d000 <GCC_except_table5+0x10c50>
    9f6c:	91388129 	add	x9, x9, #0xe20
    9f70:	a905a7e8 	stp	x8, x9, [sp, #88]
    9f74:	910163e8 	add	x8, sp, #0x58
    9f78:	a9458be1 	ldp	x1, x2, [sp, #88]
    9f7c:	aa1503e0 	mov	x0, x21
    9f80:	94000237 	bl	a85c <probe::repeated>
    9f84:	140000da 	b	a2ec <probe::main+0x5d4>
    9f88:	f1002b1f 	cmp	x24, #0xa
    9f8c:	54001701 	b.ne	a26c <probe::main+0x554>  // b.any
    9f90:	d28cae0a 	mov	x10, #0x6570                	// #25968
    9f94:	f9400288 	ldr	x8, [x20]
    9f98:	79401289 	ldrh	w9, [x20, #8]
    9f9c:	f2ae6e4a 	movk	x10, #0x7372, lsl #16
    9fa0:	f2ce6d2a 	movk	x10, #0x7369, lsl #32
    9fa4:	f2ecae8a 	movk	x10, #0x6574, lsl #48
    9fa8:	eb0a011f 	cmp	x8, x10
    9fac:	528e8dc8 	mov	w8, #0x746e                	// #29806
    9fb0:	7a480120 	ccmp	w9, w8, #0x0, eq	// eq = none
    9fb4:	54001800 	b.eq	a2b4 <probe::main+0x59c>  // b.none
    9fb8:	d28c2eca 	mov	x10, #0x6176                	// #24950
    9fbc:	f9400288 	ldr	x8, [x20]
    9fc0:	79401289 	ldrh	w9, [x20, #8]
    9fc4:	f2aead8a 	movk	x10, #0x756c, lsl #16
    9fc8:	f2cbecaa 	movk	x10, #0x5f65, lsl #32
    9fcc:	f2ed2eea 	movk	x10, #0x6977, lsl #48
    9fd0:	eb0a011f 	cmp	x8, x10
    9fd4:	528cac88 	mov	w8, #0x6564                	// #25956
    9fd8:	7a480120 	ccmp	w9, w8, #0x0, eq	// eq = none
    9fdc:	54001840 	b.eq	a2e4 <probe::main+0x5cc>  // b.none
    9fe0:	d28c2e0a 	mov	x10, #0x6170                	// #24944
    9fe4:	f9400288 	ldr	x8, [x20]
    9fe8:	79401289 	ldrh	w9, [x20, #8]
    9fec:	f2ae4d2a 	movk	x10, #0x7269, lsl #16
    9ff0:	f2cecbea 	movk	x10, #0x765f, lsl #32
    9ff4:	f2ed8c2a 	movk	x10, #0x6c61, lsl #48
    9ff8:	eb0a011f 	cmp	x8, x10
    9ffc:	528caea8 	mov	w8, #0x6575                	// #25973
    a000:	7a480120 	ccmp	w9, w8, #0x0, eq	// eq = none
    a004:	54001f01 	b.ne	a3e4 <probe::main+0x6cc>  // b.any
    a008:	aa1503e0 	mov	x0, x21
    a00c:	97fffdfe 	bl	9804 <probe::pair_value>
    a010:	140000b7 	b	a2ec <probe::main+0x5d4>
    a014:	90000015 	adrp	x21, a000 <probe::main+0x2e8>
    a018:	912482b5 	add	x21, x21, #0x920
    a01c:	92807ff8 	mov	x24, #0xfffffffffffffc00    	// #-1024
    a020:	90000016 	adrp	x22, a000 <probe::main+0x2e8>
    a024:	912612d6 	add	x22, x22, #0x984
    a028:	d101e3b9 	sub	x25, x29, #0x78
    a02c:	90000017 	adrp	x23, a000 <probe::main+0x2e8>
    a030:	9124d2f7 	add	x23, x23, #0x934
    a034:	f81883b8 	stur	x24, [x29, #-120]
    a038:	d101e3a0 	sub	x0, x29, #0x78
    a03c:	aa1503e1 	mov	x1, x21
    a040:	940001ee 	bl	a7f8 <probe::isolated>
    a044:	a93967a0 	stp	x0, x25, [x29, #-112]
    a048:	b4001ae0 	cbz	x0, a3a4 <probe::main+0x68c>
    a04c:	f9400008 	ldr	x8, [x0]
    a050:	f85883a9 	ldur	x9, [x29, #-120]
    a054:	eb09011f 	cmp	x8, x9
    a058:	54001a61 	b.ne	a3a4 <probe::main+0x68c>  // b.any
    a05c:	f81a03b8 	stur	x24, [x29, #-96]
    a060:	d10183a0 	sub	x0, x29, #0x60
    a064:	aa1603e1 	mov	x1, x22
    a068:	940001e4 	bl	a7f8 <probe::isolated>
    a06c:	a93affa0 	stp	x0, xzr, [x29, #-88]
    a070:	b5001d40 	cbnz	x0, a418 <probe::main+0x700>
    a074:	a90963f8 	stp	x24, x24, [sp, #144]
    a078:	f90053f8 	str	x24, [sp, #160]
    a07c:	910243e0 	add	x0, sp, #0x90
    a080:	aa1703e1 	mov	x1, x23
    a084:	940001dd 	bl	a7f8 <probe::isolated>
    a088:	a93effa0 	stp	x0, xzr, [x29, #-24]
    a08c:	b5001cc0 	cbnz	x0, a424 <probe::main+0x70c>
    a090:	91000718 	add	x24, x24, #0x1
    a094:	f110031f 	cmp	x24, #0x400
    a098:	54fffce1 	b.ne	a034 <probe::main+0x31c>  // b.any
    a09c:	9400029a 	bl	ab04 <__rustc::__rust_no_alloc_shim_is_unstable_v2>
    a0a0:	52800080 	mov	w0, #0x4                   	// #4
    a0a4:	52800021 	mov	w1, #0x1                   	// #1
    a0a8:	94000293 	bl	aaf4 <__rustc::__rust_alloc>
    a0ac:	b4001aa0 	cbz	x0, a400 <probe::main+0x6e8>
    a0b0:	528cae88 	mov	w8, #0x6574                	// #25972
    a0b4:	52800089 	mov	w9, #0x4                   	// #4
    a0b8:	72ae8e68 	movk	w8, #0x7473, lsl #16
    a0bc:	a90a83e9 	stp	x9, x0, [sp, #168]
    a0c0:	b9000008 	str	w8, [x0]
    a0c4:	f9005fe9 	str	x9, [sp, #184]
    a0c8:	90000001 	adrp	x1, a000 <probe::main+0x2e8>
    a0cc:	91257021 	add	x1, x1, #0x95c
    a0d0:	9102a3e0 	add	x0, sp, #0xa8
    a0d4:	940001c9 	bl	a7f8 <probe::isolated>
    a0d8:	a93bffa0 	stp	x0, xzr, [x29, #-72]
    a0dc:	b5001ae0 	cbnz	x0, a438 <probe::main+0x720>
    a0e0:	f94057e1 	ldr	x1, [sp, #168]
    a0e4:	b4000081 	cbz	x1, a0f4 <probe::main+0x3dc>
    a0e8:	f9405be0 	ldr	x0, [sp, #176]
    a0ec:	52800022 	mov	w2, #0x1                   	// #1
    a0f0:	94000282 	bl	aaf8 <__rustc::__rust_dealloc>
    a0f4:	52800028 	mov	w8, #0x1                   	// #1
    a0f8:	f81803bf 	stur	xzr, [x29, #-128]
    a0fc:	a93723bf 	stp	xzr, x8, [x29, #-144]
    a100:	90000001 	adrp	x1, a000 <probe::main+0x2e8>
    a104:	91252021 	add	x1, x1, #0x948
    a108:	d10243a0 	sub	x0, x29, #0x90
    a10c:	940001bb 	bl	a7f8 <probe::isolated>
    a110:	a93cffa0 	stp	x0, xzr, [x29, #-56]
    a114:	b50019a0 	cbnz	x0, a448 <probe::main+0x730>
    a118:	f85703a1 	ldur	x1, [x29, #-144]
    a11c:	b4000081 	cbz	x1, a12c <probe::main+0x414>
    a120:	f85783a0 	ldur	x0, [x29, #-136]
    a124:	52800022 	mov	w2, #0x1                   	// #1
    a128:	94000274 	bl	aaf8 <__rustc::__rust_dealloc>
    a12c:	90000001 	adrp	x1, a000 <probe::main+0x2e8>
    a130:	9125c021 	add	x1, x1, #0x970
    a134:	d10007a0 	sub	x0, x29, #0x1
    a138:	940001b0 	bl	a7f8 <probe::isolated>
    a13c:	a93dffa0 	stp	x0, xzr, [x29, #-40]
    a140:	b50018c0 	cbnz	x0, a458 <probe::main+0x740>
    a144:	900001a0 	adrp	x0, 3e000 <_fini+0x1cbc>
    a148:	91306400 	add	x0, x0, #0xc19
    a14c:	52800e61 	mov	w1, #0x73                  	// #115
    a150:	940068db 	bl	244bc <std::io::stdio::_print>
    a154:	b40000b3 	cbz	x19, a168 <probe::main+0x450>
    a158:	aa1403e0 	mov	x0, x20
    a15c:	aa1303e1 	mov	x1, x19
    a160:	52800022 	mov	w2, #0x1                   	// #1
    a164:	94000265 	bl	aaf8 <__rustc::__rust_dealloc>
    a168:	f94007e8 	ldr	x8, [sp, #8]
    a16c:	f9400fe9 	ldr	x9, [sp, #24]
    a170:	eb080129 	subs	x9, x9, x8
    a174:	54000ec0 	b.eq	a34c <probe::main+0x634>  // b.none
    a178:	b201f3ea 	mov	x10, #0xaaaaaaaaaaaaaaaa    	// #-6148914691236517206
    a17c:	91002114 	add	x20, x8, #0x8
    a180:	f295556a 	movk	x10, #0xaaab
    a184:	9bca7d29 	umulh	x9, x9, x10
    a188:	d344fd33 	lsr	x19, x9, #4
    a18c:	14000004 	b	a19c <probe::main+0x484>
    a190:	f1000673 	subs	x19, x19, #0x1
    a194:	91006294 	add	x20, x20, #0x18
    a198:	54000da0 	b.eq	a34c <probe::main+0x634>  // b.none
    a19c:	f85f8281 	ldur	x1, [x20, #-8]
    a1a0:	b4ffff81 	cbz	x1, a190 <probe::main+0x478>
    a1a4:	f9400280 	ldr	x0, [x20]
    a1a8:	52800022 	mov	w2, #0x1                   	// #1
    a1ac:	94000253 	bl	aaf8 <__rustc::__rust_dealloc>
    a1b0:	17fffff8 	b	a190 <probe::main+0x478>
    a1b4:	d28cae0a 	mov	x10, #0x6570                	// #25968
    a1b8:	f9400288 	ldr	x8, [x20]
    a1bc:	f8407289 	ldur	x9, [x20, #7]
    a1c0:	f2ae6e4a 	movk	x10, #0x7372, lsl #16
    a1c4:	f2ce6d2a 	movk	x10, #0x7369, lsl #32
    a1c8:	f2ecae8a 	movk	x10, #0x6574, lsl #48
    a1cc:	eb0a011f 	cmp	x8, x10
    a1d0:	d28dcca8 	mov	x8, #0x6e65                	// #28261
    a1d4:	f2abee88 	movk	x8, #0x5f74, lsl #16
    a1d8:	f2cd2ee8 	movk	x8, #0x6977, lsl #32
    a1dc:	f2ecac88 	movk	x8, #0x6564, lsl #48
    a1e0:	fa480120 	ccmp	x9, x8, #0x0, eq	// eq = none
    a1e4:	54001001 	b.ne	a3e4 <probe::main+0x6cc>  // b.any
    a1e8:	aa1503e0 	mov	x0, x21
    a1ec:	97fffe3f 	bl	9ae8 <probe::persistent_wide>
    a1f0:	1400003f 	b	a2ec <probe::main+0x5d4>
    a1f4:	b9400288 	ldr	w8, [x20]
    a1f8:	528c2c49 	mov	w9, #0x6162                	// #24930
    a1fc:	72acae69 	movk	w9, #0x6573, lsl #16
    a200:	6b09011f 	cmp	w8, w9
    a204:	540005e0 	b.eq	a2c0 <probe::main+0x5a8>  // b.none
    a208:	b9400288 	ldr	w8, [x20]
    a20c:	528c2e09 	mov	w9, #0x6170                	// #24944
    a210:	72ae4d29 	movk	w9, #0x7269, lsl #16
    a214:	6b09011f 	cmp	w8, w9
    a218:	54000e61 	b.ne	a3e4 <probe::main+0x6cc>  // b.any
    a21c:	aa1503e0 	mov	x0, x21
    a220:	940000c9 	bl	a544 <probe::pair>
    a224:	14000032 	b	a2ec <probe::main+0x5d4>
    a228:	39401288 	ldrb	w8, [x20, #4]
    a22c:	b9400289 	ldr	w9, [x20]
    a230:	7101951f 	cmp	w8, #0x65
    a234:	528c2ec8 	mov	w8, #0x6176                	// #24950
    a238:	72aead88 	movk	w8, #0x756c, lsl #16
    a23c:	7a480120 	ccmp	w9, w8, #0x0, eq	// eq = none
    a240:	540004c0 	b.eq	a2d8 <probe::main+0x5c0>  // b.none
    a244:	39401288 	ldrb	w8, [x20, #4]
    a248:	b9400289 	ldr	w9, [x20]
    a24c:	7101e51f 	cmp	w8, #0x79
    a250:	528e4c28 	mov	w8, #0x7261                	// #29281
    a254:	72ac2e48 	movk	w8, #0x6172, lsl #16
    a258:	7a480120 	ccmp	w9, w8, #0x0, eq	// eq = none
    a25c:	54000c41 	b.ne	a3e4 <probe::main+0x6cc>  // b.any
    a260:	aa1503e0 	mov	x0, x21
    a264:	940000e2 	bl	a5ec <probe::array>
    a268:	14000021 	b	a2ec <probe::main+0x5d4>
    a26c:	f1002f1f 	cmp	x24, #0xb
    a270:	54000ba1 	b.ne	a3e4 <probe::main+0x6cc>  // b.any
    a274:	d28e4c2a 	mov	x10, #0x7261                	// #29281
    a278:	f9400288 	ldr	x8, [x20]
    a27c:	f8403289 	ldur	x9, [x20, #3]
    a280:	f2ac2e4a 	movk	x10, #0x6172, lsl #16
    a284:	f2cbef2a 	movk	x10, #0x5f79, lsl #32
    a288:	f2ec2eca 	movk	x10, #0x6176, lsl #48
    a28c:	eb0a011f 	cmp	x8, x10
    a290:	d28f2c28 	mov	x8, #0x7961                	// #31073
    a294:	f2aecbe8 	movk	x8, #0x765f, lsl #16
    a298:	f2cd8c28 	movk	x8, #0x6c61, lsl #32
    a29c:	f2ecaea8 	movk	x8, #0x6575, lsl #48
    a2a0:	fa480120 	ccmp	x9, x8, #0x0, eq	// eq = none
    a2a4:	54000a01 	b.ne	a3e4 <probe::main+0x6cc>  // b.any
    a2a8:	aa1503e0 	mov	x0, x21
    a2ac:	97fffde5 	bl	9a40 <probe::array_value>
    a2b0:	1400000f 	b	a2ec <probe::main+0x5d4>
    a2b4:	aa1503e0 	mov	x0, x21
    a2b8:	97fffd7b 	bl	98a4 <probe::persistent>
    a2bc:	1400000c 	b	a2ec <probe::main+0x5d4>
    a2c0:	aa1503e0 	mov	x0, x21
    a2c4:	97fffe5f 	bl	9c40 <probe::base>
    a2c8:	14000009 	b	a2ec <probe::main+0x5d4>
    a2cc:	aa1503e0 	mov	x0, x21
    a2d0:	94000125 	bl	a764 <probe::boundary>
    a2d4:	14000006 	b	a2ec <probe::main+0x5d4>
    a2d8:	aa1503e0 	mov	x0, x21
    a2dc:	940000ef 	bl	a698 <probe::value>
    a2e0:	14000003 	b	a2ec <probe::main+0x5d4>
    a2e4:	aa1503e0 	mov	x0, x21
    a2e8:	97fffda4 	bl	9978 <probe::value_wide>
    a2ec:	b40000b3 	cbz	x19, a300 <probe::main+0x5e8>
    a2f0:	aa1403e0 	mov	x0, x20
    a2f4:	aa1303e1 	mov	x1, x19
    a2f8:	52800022 	mov	w2, #0x1                   	// #1
    a2fc:	940001ff 	bl	aaf8 <__rustc::__rust_dealloc>
    a300:	f94007e8 	ldr	x8, [sp, #8]
    a304:	f9400fe9 	ldr	x9, [sp, #24]
    a308:	eb080129 	subs	x9, x9, x8
    a30c:	54000200 	b.eq	a34c <probe::main+0x634>  // b.none
    a310:	b201f3ea 	mov	x10, #0xaaaaaaaaaaaaaaaa    	// #-6148914691236517206
    a314:	91002114 	add	x20, x8, #0x8
    a318:	f295556a 	movk	x10, #0xaaab
    a31c:	9bca7d29 	umulh	x9, x9, x10
    a320:	d344fd33 	lsr	x19, x9, #4
    a324:	14000004 	b	a334 <probe::main+0x61c>
    a328:	f1000673 	subs	x19, x19, #0x1
    a32c:	91006294 	add	x20, x20, #0x18
    a330:	540000e0 	b.eq	a34c <probe::main+0x634>  // b.none
    a334:	f85f8281 	ldur	x1, [x20, #-8]
    a338:	b4ffff81 	cbz	x1, a328 <probe::main+0x610>
    a33c:	f9400280 	ldr	x0, [x20]
    a340:	52800022 	mov	w2, #0x1                   	// #1
    a344:	940001ed 	bl	aaf8 <__rustc::__rust_dealloc>
    a348:	17fffff8 	b	a328 <probe::main+0x610>
    a34c:	f9400be8 	ldr	x8, [sp, #16]
    a350:	b40000c8 	cbz	x8, a368 <probe::main+0x650>
    a354:	8b080508 	add	x8, x8, x8, lsl #1
    a358:	f94003e0 	ldr	x0, [sp]
    a35c:	52800102 	mov	w2, #0x8                   	// #8
    a360:	d37df101 	lsl	x1, x8, #3
    a364:	940001e5 	bl	aaf8 <__rustc::__rust_dealloc>
    a368:	a9594ff4 	ldp	x20, x19, [sp, #400]
    a36c:	a95857f6 	ldp	x22, x21, [sp, #384]
    a370:	a9575ff8 	ldp	x24, x23, [sp, #368]
    a374:	a95667fc 	ldp	x28, x25, [sp, #352]
    a378:	a9557bfd 	ldp	x29, x30, [sp, #336]
    a37c:	910683ff 	add	sp, sp, #0x1a0
    a380:	d65f03c0 	ret
    a384:	5100c168 	sub	w8, w11, #0x30
    a388:	7100291f 	cmp	w8, #0xa
    a38c:	52800028 	mov	w8, #0x1                   	// #1
    a390:	1a882500 	cinc	w0, w8, cc	// cc = lo, ul, last
    a394:	14000002 	b	a39c <probe::main+0x684>
    a398:	52800040 	mov	w0, #0x2                   	// #2
    a39c:	97ffe779 	bl	4180 <core::result::unwrap_failed::<core::num::error::ParseIntError>>
    a3a0:	1400002d 	b	a454 <probe::main+0x73c>
    a3a4:	d101a3a1 	sub	x1, x29, #0x68
    a3a8:	d101c3a0 	sub	x0, x29, #0x70
    a3ac:	97ffe782 	bl	41b4 <core::panicking::assert_failed::<core::option::Option<&isize>, core::option::Option<&isize>>>
    a3b0:	14000029 	b	a454 <probe::main+0x73c>
    a3b4:	f0000280 	adrp	x0, 5d000 <GCC_except_table5+0x10c50>
    a3b8:	913bc000 	add	x0, x0, #0xef0
    a3bc:	97fffb97 	bl	9218 <core::option::unwrap_failed>
    a3c0:	14000025 	b	a454 <probe::main+0x73c>
    a3c4:	f90013ff 	str	xzr, [sp, #32]
    a3c8:	910003e0 	mov	x0, sp
    a3cc:	97fffce7 	bl	9768 <<std::env::Args as core::iter::traits::iterator::Iterator>::try_fold::<core::num::nonzero::NonZero<usize>, <std::env::Args as core::iter::traits::iterator::Iterator::advance_by::SpecAdvanceBy>::spec_advance_by::{closure#0}, core::option::Option<core::num::nonzero::NonZero<usize>>>>
    a3d0:	b4ffcf00 	cbz	x0, 9db0 <probe::main+0x98>
    a3d4:	f0000280 	adrp	x0, 5d000 <GCC_except_table5+0x10c50>
    a3d8:	913c2000 	add	x0, x0, #0xf08
    a3dc:	97fffb8f 	bl	9218 <core::option::unwrap_failed>
    a3e0:	1400001d 	b	a454 <probe::main+0x73c>
    a3e4:	900001a0 	adrp	x0, 3e000 <_fini+0x1cbc>
    a3e8:	912f8000 	add	x0, x0, #0xbe0
    a3ec:	f0000282 	adrp	x2, 5d000 <GCC_except_table5+0x10c50>
    a3f0:	913c8042 	add	x2, x2, #0xf20
    a3f4:	528001c1 	mov	w1, #0xe                   	// #14
    a3f8:	97fffbf5 	bl	93cc <core::panicking::panic>
    a3fc:	14000016 	b	a454 <probe::main+0x73c>
    a400:	52800020 	mov	w0, #0x1                   	// #1
    a404:	52800081 	mov	w1, #0x4                   	// #4
    a408:	97fffb49 	bl	912c <alloc::raw_vec::handle_error>
    a40c:	14000012 	b	a454 <probe::main+0x73c>
    a410:	52800020 	mov	w0, #0x1                   	// #1
    a414:	17ffffe2 	b	a39c <probe::main+0x684>
    a418:	d10143a1 	sub	x1, x29, #0x50
    a41c:	d10163a0 	sub	x0, x29, #0x58
    a420:	17ffffe3 	b	a3ac <probe::main+0x694>
    a424:	d10043a1 	sub	x1, x29, #0x10
    a428:	d10063a0 	sub	x0, x29, #0x18
    a42c:	17ffffe0 	b	a3ac <probe::main+0x694>
    a430:	2a1f03e0 	mov	w0, wzr
    a434:	17ffffda 	b	a39c <probe::main+0x684>
    a438:	d10123a0 	sub	x0, x29, #0x48
    a43c:	d10103a1 	sub	x1, x29, #0x40
    a440:	97ffe75d 	bl	41b4 <core::panicking::assert_failed::<core::option::Option<&isize>, core::option::Option<&isize>>>
    a444:	14000004 	b	a454 <probe::main+0x73c>
    a448:	d100e3a0 	sub	x0, x29, #0x38
    a44c:	d100c3a1 	sub	x1, x29, #0x30
    a450:	97ffe759 	bl	41b4 <core::panicking::assert_failed::<core::option::Option<&isize>, core::option::Option<&isize>>>
    a454:	d4200020 	brk	#0x1
    a458:	d10083a1 	sub	x1, x29, #0x20
    a45c:	d100a3a0 	sub	x0, x29, #0x28
    a460:	17ffffd3 	b	a3ac <probe::main+0x694>
    a464:	f85703a1 	ldur	x1, [x29, #-144]
    a468:	aa0003f5 	mov	x21, x0
    a46c:	b40002a1 	cbz	x1, a4c0 <probe::main+0x7a8>
    a470:	f85783a0 	ldur	x0, [x29, #-136]
    a474:	14000011 	b	a4b8 <probe::main+0x7a0>
    a478:	f94057e1 	ldr	x1, [sp, #168]
    a47c:	aa0003f5 	mov	x21, x0
    a480:	b4000201 	cbz	x1, a4c0 <probe::main+0x7a8>
    a484:	f9405be0 	ldr	x0, [sp, #176]
    a488:	1400000c 	b	a4b8 <probe::main+0x7a0>
    a48c:	14000003 	b	a498 <probe::main+0x780>
    a490:	aa0003f5 	mov	x21, x0
    a494:	1400000b 	b	a4c0 <probe::main+0x7a8>
    a498:	aa0003f5 	mov	x21, x0
    a49c:	1400000e 	b	a4d4 <probe::main+0x7bc>
    a4a0:	aa0003f5 	mov	x21, x0
    a4a4:	14000007 	b	a4c0 <probe::main+0x7a8>
    a4a8:	aa0003f5 	mov	x21, x0
    a4ac:	b40000b6 	cbz	x22, a4c0 <probe::main+0x7a8>
    a4b0:	aa1703e0 	mov	x0, x23
    a4b4:	aa1603e1 	mov	x1, x22
    a4b8:	52800022 	mov	w2, #0x1                   	// #1
    a4bc:	9400018f 	bl	aaf8 <__rustc::__rust_dealloc>
    a4c0:	b40000b3 	cbz	x19, a4d4 <probe::main+0x7bc>
    a4c4:	aa1403e0 	mov	x0, x20
    a4c8:	aa1303e1 	mov	x1, x19
    a4cc:	52800022 	mov	w2, #0x1                   	// #1
    a4d0:	9400018a 	bl	aaf8 <__rustc::__rust_dealloc>
    a4d4:	f94007e8 	ldr	x8, [sp, #8]
    a4d8:	f9400fe9 	ldr	x9, [sp, #24]
    a4dc:	eb080129 	subs	x9, x9, x8
    a4e0:	54000141 	b.ne	a508 <probe::main+0x7f0>  // b.any
    a4e4:	f9400be8 	ldr	x8, [sp, #16]
    a4e8:	b40000c8 	cbz	x8, a500 <probe::main+0x7e8>
    a4ec:	8b080508 	add	x8, x8, x8, lsl #1
    a4f0:	f94003e0 	ldr	x0, [sp]
    a4f4:	52800102 	mov	w2, #0x8                   	// #8
    a4f8:	d37df101 	lsl	x1, x8, #3
    a4fc:	9400017f 	bl	aaf8 <__rustc::__rust_dealloc>
    a500:	aa1503e0 	mov	x0, x21
    a504:	97ffe6ff 	bl	4100 <_Unwind_Resume@plt>
    a508:	b201f3ea 	mov	x10, #0xaaaaaaaaaaaaaaaa    	// #-6148914691236517206
    a50c:	91002114 	add	x20, x8, #0x8
    a510:	f295556a 	movk	x10, #0xaaab
    a514:	9bca7d29 	umulh	x9, x9, x10
    a518:	d344fd33 	lsr	x19, x9, #4
    a51c:	14000004 	b	a52c <probe::main+0x814>
    a520:	f1000673 	subs	x19, x19, #0x1
    a524:	91006294 	add	x20, x20, #0x18
    a528:	54fffde0 	b.eq	a4e4 <probe::main+0x7cc>  // b.none
    a52c:	f85f8281 	ldur	x1, [x20, #-8]
    a530:	b4ffff81 	cbz	x1, a520 <probe::main+0x808>
    a534:	f9400280 	ldr	x0, [x20]
    a538:	52800022 	mov	w2, #0x1                   	// #1
    a53c:	9400016f 	bl	aaf8 <__rustc::__rust_dealloc>
    a540:	17fffff8 	b	a520 <probe::main+0x808>

000000000000a544 <probe::pair>:
    a544:	b4000520 	cbz	x0, a5e8 <probe::pair+0xa4>
    a548:	d10203ff 	sub	sp, sp, #0x80
    a54c:	a9037bfd 	stp	x29, x30, [sp, #48]
    a550:	a90467fa 	stp	x26, x25, [sp, #64]
    a554:	a9055ff8 	stp	x24, x23, [sp, #80]
    a558:	a90657f6 	stp	x22, x21, [sp, #96]
    a55c:	a9074ff4 	stp	x20, x19, [sp, #112]
    a560:	9100c3fd 	add	x29, sp, #0x30
    a564:	d282b1f8 	mov	x24, #0x158f                	// #5519
    a568:	d28d1d79 	mov	x25, #0x68eb                	// #26859
    a56c:	aa0003f3 	mov	x19, x0
    a570:	f2bc43f8 	movk	x24, #0xe21f, lsl #16
    a574:	f2b8bbd9 	movk	x25, #0xc5de, lsl #16
    a578:	f0000294 	adrp	x20, 5d000 <GCC_except_table5+0x10c50>
    a57c:	91398294 	add	x20, x20, #0xe60
    a580:	f2d46338 	movk	x24, #0xa319, lsl #32
    a584:	f2d036d9 	movk	x25, #0x81b6, lsl #32
    a588:	910023f5 	add	x21, sp, #0x8
    a58c:	910043f6 	add	x22, sp, #0x10
    a590:	d10043b7 	sub	x23, x29, #0x10
    a594:	f2edceb8 	movk	x24, #0x6e75, lsl #48
    a598:	f2f36679 	movk	x25, #0x9b33, lsl #48
    a59c:	d10013ba 	sub	x26, x29, #0x4
    a5a0:	a900d7ff 	stp	xzr, x21, [sp, #8]
    a5a4:	f9000ff4 	str	x20, [sp, #24]
    a5a8:	f81f03b6 	stur	x22, [x29, #-16]
    a5ac:	a94123e0 	ldp	x0, x8, [sp, #16]
    a5b0:	f9400d08 	ldr	x8, [x8, #24]
    a5b4:	d63f0100 	blr	x8
    a5b8:	eb18001f 	cmp	x0, x24
    a5bc:	fa590020 	ccmp	x1, x25, #0x0, eq	// eq = none
    a5c0:	1a9f17e8 	cset	w8, eq	// eq = none
    a5c4:	f1000673 	subs	x19, x19, #0x1
    a5c8:	381fc3a8 	sturb	w8, [x29, #-4]
    a5cc:	54fffea1 	b.ne	a5a0 <probe::pair+0x5c>  // b.any
    a5d0:	a9474ff4 	ldp	x20, x19, [sp, #112]
    a5d4:	a94657f6 	ldp	x22, x21, [sp, #96]
    a5d8:	a9455ff8 	ldp	x24, x23, [sp, #80]
    a5dc:	a94467fa 	ldp	x26, x25, [sp, #64]
    a5e0:	a9437bfd 	ldp	x29, x30, [sp, #48]
    a5e4:	910203ff 	add	sp, sp, #0x80
    a5e8:	d65f03c0 	ret

000000000000a5ec <probe::array>:
    a5ec:	b4000540 	cbz	x0, a694 <probe::array+0xa8>
    a5f0:	d10243ff 	sub	sp, sp, #0x90
    a5f4:	a9047bfd 	stp	x29, x30, [sp, #64]
    a5f8:	a90567fa 	stp	x26, x25, [sp, #80]
    a5fc:	a9065ff8 	stp	x24, x23, [sp, #96]
    a600:	a90757f6 	stp	x22, x21, [sp, #112]
    a604:	a9084ff4 	stp	x20, x19, [sp, #128]
    a608:	910103fd 	add	x29, sp, #0x40
    a60c:	d282b1f8 	mov	x24, #0x158f                	// #5519
    a610:	d28d1d79 	mov	x25, #0x68eb                	// #26859
    a614:	aa0003f3 	mov	x19, x0
    a618:	f2bc43f8 	movk	x24, #0xe21f, lsl #16
    a61c:	f2b8bbd9 	movk	x25, #0xc5de, lsl #16
    a620:	f0000294 	adrp	x20, 5d000 <GCC_except_table5+0x10c50>
    a624:	91390294 	add	x20, x20, #0xe40
    a628:	f2d46338 	movk	x24, #0xa319, lsl #32
    a62c:	f2d036d9 	movk	x25, #0x81b6, lsl #32
    a630:	910023f5 	add	x21, sp, #0x8
    a634:	910043f6 	add	x22, sp, #0x10
    a638:	910083f7 	add	x23, sp, #0x20
    a63c:	f2edceb8 	movk	x24, #0x6e75, lsl #48
    a640:	f2f36679 	movk	x25, #0x9b33, lsl #48
    a644:	d10053ba 	sub	x26, x29, #0x14
    a648:	a900d7ff 	stp	xzr, x21, [sp, #8]
    a64c:	a901dbf4 	stp	x20, x22, [sp, #24]
    a650:	a94123e0 	ldp	x0, x8, [sp, #16]
    a654:	f9400d09 	ldr	x9, [x8, #24]
    a658:	d10043a8 	sub	x8, x29, #0x10
    a65c:	d63f0120 	blr	x9
    a660:	a97f27a8 	ldp	x8, x9, [x29, #-16]
    a664:	eb18011f 	cmp	x8, x24
    a668:	fa590120 	ccmp	x9, x25, #0x0, eq	// eq = none
    a66c:	1a9f17e8 	cset	w8, eq	// eq = none
    a670:	f1000673 	subs	x19, x19, #0x1
    a674:	381ec3a8 	sturb	w8, [x29, #-20]
    a678:	54fffe81 	b.ne	a648 <probe::array+0x5c>  // b.any
    a67c:	a9484ff4 	ldp	x20, x19, [sp, #128]
    a680:	a94757f6 	ldp	x22, x21, [sp, #112]
    a684:	a9465ff8 	ldp	x24, x23, [sp, #96]
    a688:	a94567fa 	ldp	x26, x25, [sp, #80]
    a68c:	a9447bfd 	ldp	x29, x30, [sp, #64]
    a690:	910243ff 	add	sp, sp, #0x90
    a694:	d65f03c0 	ret

000000000000a698 <probe::value>:
    a698:	b4000640 	cbz	x0, a760 <probe::value+0xc8>
    a69c:	d10203ff 	sub	sp, sp, #0x80
    a6a0:	a9037bfd 	stp	x29, x30, [sp, #48]
    a6a4:	f90023f9 	str	x25, [sp, #64]
    a6a8:	a9055ff8 	stp	x24, x23, [sp, #80]
    a6ac:	a90657f6 	stp	x22, x21, [sp, #96]
    a6b0:	a9074ff4 	stp	x20, x19, [sp, #112]
    a6b4:	9100c3fd 	add	x29, sp, #0x30
    a6b8:	d28d1d77 	mov	x23, #0x68eb                	// #26859
    a6bc:	d282b1f8 	mov	x24, #0x158f                	// #5519
    a6c0:	aa0003f3 	mov	x19, x0
    a6c4:	f2b8bbd7 	movk	x23, #0xc5de, lsl #16
    a6c8:	f2bc43f8 	movk	x24, #0xe21f, lsl #16
    a6cc:	910023f4 	add	x20, sp, #0x8
    a6d0:	f2d036d7 	movk	x23, #0x81b6, lsl #32
    a6d4:	f2d46338 	movk	x24, #0xa319, lsl #32
    a6d8:	f0000295 	adrp	x21, 5d000 <GCC_except_table5+0x10c50>
    a6dc:	913882b5 	add	x21, x21, #0xe20
    a6e0:	910043f6 	add	x22, sp, #0x10
    a6e4:	f2f36677 	movk	x23, #0x9b33, lsl #48
    a6e8:	f2edceb8 	movk	x24, #0x6e75, lsl #48
    a6ec:	910073b9 	add	x25, x29, #0x1c
    a6f0:	14000008 	b	a710 <probe::value+0x78>
    a6f4:	f9400be8 	ldr	x8, [sp, #16]
    a6f8:	f9400108 	ldr	x8, [x8]
    a6fc:	f100011f 	cmp	x8, #0x0
    a700:	1a9f17e8 	cset	w8, eq	// eq = none
    a704:	390073a8 	strb	w8, [x29, #28]
    a708:	f1000673 	subs	x19, x19, #0x1
    a70c:	540001e0 	b.eq	a748 <probe::value+0xb0>  // b.none
    a710:	a900d3ff 	stp	xzr, x20, [sp, #8]
    a714:	f9000ff5 	str	x21, [sp, #24]
    a718:	a94123e0 	ldp	x0, x8, [sp, #16]
    a71c:	f9400d09 	ldr	x9, [x8, #24]
    a720:	d10043a8 	sub	x8, x29, #0x10
    a724:	d63f0120 	blr	x9
    a728:	a97f27a8 	ldp	x8, x9, [x29, #-16]
    a72c:	ca170129 	eor	x9, x9, x23
    a730:	ca180108 	eor	x8, x8, x24
    a734:	aa090108 	orr	x8, x8, x9
    a738:	b4fffde8 	cbz	x8, a6f4 <probe::value+0x5c>
    a73c:	390073bf 	strb	wzr, [x29, #28]
    a740:	f1000673 	subs	x19, x19, #0x1
    a744:	54fffe61 	b.ne	a710 <probe::value+0x78>  // b.any
    a748:	a9474ff4 	ldp	x20, x19, [sp, #112]
    a74c:	f94023f9 	ldr	x25, [sp, #64]
    a750:	a94657f6 	ldp	x22, x21, [sp, #96]
    a754:	a9455ff8 	ldp	x24, x23, [sp, #80]
    a758:	a9437bfd 	ldp	x29, x30, [sp, #48]
    a75c:	910203ff 	add	sp, sp, #0x80
    a760:	d65f03c0 	ret

000000000000a764 <probe::boundary>:
    a764:	b4000480 	cbz	x0, a7f4 <probe::boundary+0x90>
    a768:	d101c3ff 	sub	sp, sp, #0x70
    a76c:	a9037bfd 	stp	x29, x30, [sp, #48]
    a770:	a9045ff8 	stp	x24, x23, [sp, #64]
    a774:	a90557f6 	stp	x22, x21, [sp, #80]
    a778:	a9064ff4 	stp	x20, x19, [sp, #96]
    a77c:	9100c3fd 	add	x29, sp, #0x30
    a780:	aa0003f3 	mov	x19, x0
    a784:	910023f4 	add	x20, sp, #0x8
    a788:	f0000295 	adrp	x21, 5d000 <GCC_except_table5+0x10c50>
    a78c:	913882b5 	add	x21, x21, #0xe20
    a790:	910043f6 	add	x22, sp, #0x10
    a794:	d10043b7 	sub	x23, x29, #0x10
    a798:	d10013b8 	sub	x24, x29, #0x4
    a79c:	14000004 	b	a7ac <probe::boundary+0x48>
    a7a0:	381fc3bf 	sturb	wzr, [x29, #-4]
    a7a4:	f1000673 	subs	x19, x19, #0x1
    a7a8:	540001c0 	b.eq	a7e0 <probe::boundary+0x7c>  // b.none
    a7ac:	a900d3ff 	stp	xzr, x20, [sp, #8]
    a7b0:	f9000ff5 	str	x21, [sp, #24]
    a7b4:	f81f03b6 	stur	x22, [x29, #-16]
    a7b8:	a94123e0 	ldp	x0, x8, [sp, #16]
    a7bc:	f9400d01 	ldr	x1, [x8, #24]
    a7c0:	9400000e 	bl	a7f8 <probe::isolated>
    a7c4:	b4fffee0 	cbz	x0, a7a0 <probe::boundary+0x3c>
    a7c8:	f9400008 	ldr	x8, [x0]
    a7cc:	f100011f 	cmp	x8, #0x0
    a7d0:	1a9f17e8 	cset	w8, eq	// eq = none
    a7d4:	381fc3a8 	sturb	w8, [x29, #-4]
    a7d8:	f1000673 	subs	x19, x19, #0x1
    a7dc:	54fffe81 	b.ne	a7ac <probe::boundary+0x48>  // b.any
    a7e0:	a9464ff4 	ldp	x20, x19, [sp, #96]
    a7e4:	a94557f6 	ldp	x22, x21, [sp, #80]
    a7e8:	a9445ff8 	ldp	x24, x23, [sp, #64]
    a7ec:	a9437bfd 	ldp	x29, x30, [sp, #48]
    a7f0:	9101c3ff 	add	sp, sp, #0x70
    a7f4:	d65f03c0 	ret

000000000000a7f8 <probe::isolated>:
    a7f8:	d100c3ff 	sub	sp, sp, #0x30
    a7fc:	a9017bfd 	stp	x29, x30, [sp, #16]
    a800:	f90013f3 	str	x19, [sp, #32]
    a804:	910043fd 	add	x29, sp, #0x10
    a808:	910003e8 	mov	x8, sp
    a80c:	aa0003f3 	mov	x19, x0
    a810:	d63f0020 	blr	x1
    a814:	d28d1d6a 	mov	x10, #0x68eb                	// #26859
    a818:	d282b1eb 	mov	x11, #0x158f                	// #5519
    a81c:	a94027e8 	ldp	x8, x9, [sp]
    a820:	f2b8bbca 	movk	x10, #0xc5de, lsl #16
    a824:	f2bc43eb 	movk	x11, #0xe21f, lsl #16
    a828:	f2d036ca 	movk	x10, #0x81b6, lsl #32
    a82c:	f2d4632b 	movk	x11, #0xa319, lsl #32
    a830:	f2f3666a 	movk	x10, #0x9b33, lsl #48
    a834:	f2edceab 	movk	x11, #0x6e75, lsl #48
    a838:	ca0a0129 	eor	x9, x9, x10
    a83c:	ca0b0108 	eor	x8, x8, x11
    a840:	aa090108 	orr	x8, x8, x9
    a844:	f100011f 	cmp	x8, #0x0
    a848:	9a9f0260 	csel	x0, x19, xzr, eq	// eq = none
    a84c:	a9417bfd 	ldp	x29, x30, [sp, #16]
    a850:	f94013f3 	ldr	x19, [sp, #32]
    a854:	9100c3ff 	add	sp, sp, #0x30
    a858:	d65f03c0 	ret

000000000000a85c <probe::repeated>:
    a85c:	b4000600 	cbz	x0, a91c <probe::repeated+0xc0>
    a860:	d101c3ff 	sub	sp, sp, #0x70
    a864:	a9027bfd 	stp	x29, x30, [sp, #32]
    a868:	f9001bf9 	str	x25, [sp, #48]
    a86c:	a9045ff8 	stp	x24, x23, [sp, #64]
    a870:	a90557f6 	stp	x22, x21, [sp, #80]
    a874:	a9064ff4 	stp	x20, x19, [sp, #96]
    a878:	910083fd 	add	x29, sp, #0x20
    a87c:	d28d1d77 	mov	x23, #0x68eb                	// #26859
    a880:	d282b1f8 	mov	x24, #0x158f                	// #5519
    a884:	aa0203f3 	mov	x19, x2
    a888:	f2b8bbd7 	movk	x23, #0xc5de, lsl #16
    a88c:	f2bc43f8 	movk	x24, #0xe21f, lsl #16
    a890:	aa0003f4 	mov	x20, x0
    a894:	f2d036d7 	movk	x23, #0x81b6, lsl #32
    a898:	f2d46338 	movk	x24, #0xa319, lsl #32
    a89c:	aa0103f5 	mov	x21, x1
    a8a0:	910003f6 	mov	x22, sp
    a8a4:	f2f36677 	movk	x23, #0x9b33, lsl #48
    a8a8:	f2edceb8 	movk	x24, #0x6e75, lsl #48
    a8ac:	910073b9 	add	x25, x29, #0x1c
    a8b0:	14000008 	b	a8d0 <probe::repeated+0x74>
    a8b4:	f94003e8 	ldr	x8, [sp]
    a8b8:	f9400108 	ldr	x8, [x8]
    a8bc:	f100011f 	cmp	x8, #0x0
    a8c0:	1a9f17e8 	cset	w8, eq	// eq = none
    a8c4:	390073a8 	strb	w8, [x29, #28]
    a8c8:	f1000694 	subs	x20, x20, #0x1
    a8cc:	540001c0 	b.eq	a904 <probe::repeated+0xa8>  // b.none
    a8d0:	a9004ff5 	stp	x21, x19, [sp]
    a8d4:	a94023e0 	ldp	x0, x8, [sp]
    a8d8:	f9400d09 	ldr	x9, [x8, #24]
    a8dc:	910043e8 	add	x8, sp, #0x10
    a8e0:	d63f0120 	blr	x9
    a8e4:	a94127e8 	ldp	x8, x9, [sp, #16]
    a8e8:	ca170129 	eor	x9, x9, x23
    a8ec:	ca180108 	eor	x8, x8, x24
    a8f0:	aa090108 	orr	x8, x8, x9
    a8f4:	b4fffe08 	cbz	x8, a8b4 <probe::repeated+0x58>
    a8f8:	390073bf 	strb	wzr, [x29, #28]
    a8fc:	f1000694 	subs	x20, x20, #0x1
    a900:	54fffe81 	b.ne	a8d0 <probe::repeated+0x74>  // b.any
    a904:	a9464ff4 	ldp	x20, x19, [sp, #96]
    a908:	f9401bf9 	ldr	x25, [sp, #48]
    a90c:	a94557f6 	ldp	x22, x21, [sp, #80]
    a910:	a9445ff8 	ldp	x24, x23, [sp, #64]
    a914:	a9427bfd 	ldp	x29, x30, [sp, #32]
    a918:	9101c3ff 	add	sp, sp, #0x70
    a91c:	d65f03c0 	ret

