
/tmp/tuple-comparison-20261105/harness-fullflags:     file format elf64-littleaarch64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

000000000000e8cc <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBQ_>:
    e8cc:	d10203ff 	sub	sp, sp, #0x80
    e8d0:	a9027bfd 	stp	x29, x30, [sp, #32]
    e8d4:	a9036ffc 	stp	x28, x27, [sp, #48]
    e8d8:	a90467fa 	stp	x26, x25, [sp, #64]
    e8dc:	a9055ff8 	stp	x24, x23, [sp, #80]
    e8e0:	a90657f6 	stp	x22, x21, [sp, #96]
    e8e4:	a9074ff4 	stp	x20, x19, [sp, #112]
    e8e8:	910083fd 	add	x29, sp, #0x20
    e8ec:	aa0203f3 	mov	x19, x2
    e8f0:	aa0103f4 	mov	x20, x1
    e8f4:	aa0003f5 	mov	x21, x0
    e8f8:	97fff842 	bl	ca00 <_RNvMNtCs60nHaxeZLXj_3std4timeNtB2_7Instant3now@plt>
    e8fc:	f90007e0 	str	x0, [sp, #8]
    e900:	b90013e1 	str	w1, [sp, #16]
    e904:	b4000b53 	cbz	x19, ea6c <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBQ_+0x1a0>
    e908:	528000d6 	mov	w22, #0x6                   	// #6
    e90c:	52800317 	mov	w23, #0x18                  	// #24
    e910:	d00001d8 	adrp	x24, 48000 <_fini+0x15d4>
    e914:	910ee318 	add	x24, x24, #0x3b8
    e918:	d10013b9 	sub	x25, x29, #0x4
    e91c:	14000014 	b	e96c <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBQ_+0xa0>
    e920:	9bb7551a 	umaddl	x26, w8, w23, x21
    e924:	9bb7559b 	umaddl	x27, w12, w23, x21
    e928:	a9402740 	ldp	x0, x9, [x26]
    e92c:	a9402361 	ldp	x1, x8, [x27]
    e930:	eb08013c 	subs	x28, x9, x8
    e934:	9a883122 	csel	x2, x9, x8, cc	// cc = lo, ul, last
    e938:	97fff7be 	bl	c830 <memcmp@plt>
    e93c:	93407c08 	sxtw	x8, w0
    e940:	7100001f 	cmp	w0, #0x0
    e944:	9a880389 	csel	x9, x28, x8, eq	// eq = none
    e948:	f100013f 	cmp	x9, #0x0
    e94c:	1a9fd7e8 	cset	w8, gt
    e950:	5a9f5108 	csinv	w8, w8, wzr, pl	// pl = nfrst
    e954:	b4000789 	cbz	x9, ea44 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBQ_+0x178>
    e958:	8b288b08 	add	x8, x24, w8, sxtb #2
    e95c:	f1000673 	subs	x19, x19, #0x1
    e960:	b9400508 	ldr	w8, [x8, #4]
    e964:	b81fc3a8 	stur	w8, [x29, #-4]
    e968:	54000820 	b.eq	ea6c <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBQ_+0x1a0>  // b.none
    e96c:	29403688 	ldp	w8, w13, [x20]
    e970:	29412a8c 	ldp	w12, w10, [x20, #8]
    e974:	4a082d08 	eor	w8, w8, w8, lsl #11
    e978:	53087d09 	lsr	w9, w8, #8
    e97c:	4a0a0108 	eor	w8, w8, w10
    e980:	4a4a4d29 	eor	w9, w9, w10, lsr #19
    e984:	4a080129 	eor	w9, w9, w8
    e988:	9bb67d2e 	umull	x14, w9, w22
    e98c:	d360fdc8 	lsr	x8, x14, #32
    e990:	310015df 	cmn	w14, #0x5
    e994:	540001e3 	b.cc	e9d0 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBQ_+0x104>  // b.lo, b.ul, b.last
    e998:	4a0d2dab 	eor	w11, w13, w13, lsl #11
    e99c:	29002a8c 	stp	w12, w10, [x20]
    e9a0:	53087d6d 	lsr	w13, w11, #8
    e9a4:	4a09016b 	eor	w11, w11, w9
    e9a8:	4a494dad 	eor	w13, w13, w9, lsr #19
    e9ac:	4a0b01ab 	eor	w11, w13, w11
    e9b0:	9bb67d6d 	umull	x13, w11, w22
    e9b4:	29012e89 	stp	w9, w11, [x20, #8]
    e9b8:	d360fdad 	lsr	x13, x13, #32
    e9bc:	2b0d01df 	cmn	w14, w13
    e9c0:	9a883508 	cinc	x8, x8, cs	// cs = hs, nlast
    e9c4:	f100191f 	cmp	x8, #0x6
    e9c8:	540000c3 	b.cc	e9e0 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBQ_+0x114>  // b.lo, b.ul, b.last
    e9cc:	14000036 	b	eaa4 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBQ_+0x1d8>
    e9d0:	2a0903eb 	mov	w11, w9
    e9d4:	2a0a03e9 	mov	w9, w10
    e9d8:	2a0c03ea 	mov	w10, w12
    e9dc:	2a0d03ec 	mov	w12, w13
    e9e0:	4a0c2d8c 	eor	w12, w12, w12, lsl #11
    e9e4:	53137d6d 	lsr	w13, w11, #19
    e9e8:	2900268a 	stp	w10, w9, [x20]
    e9ec:	4a4c21ad 	eor	w13, w13, w12, lsr #8
    e9f0:	4a0c016c 	eor	w12, w11, w12
    e9f4:	4a0c01ad 	eor	w13, w13, w12
    e9f8:	9bb67dae 	umull	x14, w13, w22
    e9fc:	2901368b 	stp	w11, w13, [x20, #8]
    ea00:	d360fdcc 	lsr	x12, x14, #32
    ea04:	310015df 	cmn	w14, #0x5
    ea08:	54fff8c3 	b.cc	e920 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBQ_+0x54>  // b.lo, b.ul, b.last
    ea0c:	4a0a2d4a 	eor	w10, w10, w10, lsl #11
    ea10:	29002e89 	stp	w9, w11, [x20]
    ea14:	53087d4f 	lsr	w15, w10, #8
    ea18:	4a0d014a 	eor	w10, w10, w13
    ea1c:	4a4d4def 	eor	w15, w15, w13, lsr #19
    ea20:	4a0a01ea 	eor	w10, w15, w10
    ea24:	9bb67d4f 	umull	x15, w10, w22
    ea28:	29012a8d 	stp	w13, w10, [x20, #8]
    ea2c:	d360fdef 	lsr	x15, x15, #32
    ea30:	2b0f01df 	cmn	w14, w15
    ea34:	9a8c358c 	cinc	x12, x12, cs	// cs = hs, nlast
    ea38:	f100199f 	cmp	x12, #0x6
    ea3c:	54fff723 	b.cc	e920 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBQ_+0x54>  // b.lo, b.ul, b.last
    ea40:	14000019 	b	eaa4 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBQ_+0x1d8>
    ea44:	f9400b48 	ldr	x8, [x26, #16]
    ea48:	f9400b69 	ldr	x9, [x27, #16]
    ea4c:	eb09011f 	cmp	x8, x9
    ea50:	1a9f97e8 	cset	w8, hi	// hi = pmore
    ea54:	5a9f2108 	csinv	w8, w8, wzr, cs	// cs = hs, nlast
    ea58:	8b288b08 	add	x8, x24, w8, sxtb #2
    ea5c:	f1000673 	subs	x19, x19, #0x1
    ea60:	b9400508 	ldr	w8, [x8, #4]
    ea64:	b81fc3a8 	stur	w8, [x29, #-4]
    ea68:	54fff821 	b.ne	e96c <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_11bench_match0EBQ_+0xa0>  // b.any
    ea6c:	910023e0 	add	x0, sp, #0x8
    ea70:	97fff680 	bl	c470 <_RNvMNtCs60nHaxeZLXj_3std4timeNtB2_7Instant7elapsed@plt>
    ea74:	52994008 	mov	w8, #0xca00                	// #51712
    ea78:	72a77348 	movk	w8, #0x3b9a, lsl #16
    ea7c:	9b087c08 	mul	x8, x0, x8
    ea80:	8b214100 	add	x0, x8, w1, uxtw
    ea84:	a9474ff4 	ldp	x20, x19, [sp, #112]
    ea88:	a94657f6 	ldp	x22, x21, [sp, #96]
    ea8c:	a9455ff8 	ldp	x24, x23, [sp, #80]
    ea90:	a94467fa 	ldp	x26, x25, [sp, #64]
    ea94:	a9436ffc 	ldp	x28, x27, [sp, #48]
    ea98:	a9427bfd 	ldp	x29, x30, [sp, #32]
    ea9c:	910203ff 	add	sp, sp, #0x80
    eaa0:	d65f03c0 	ret
    eaa4:	900002e2 	adrp	x2, 6a000 <GCC_except_table8+0x12bb8>
    eaa8:	91190042 	add	x2, x2, #0x640
    eaac:	528000c0 	mov	w0, #0x6                   	// #6
    eab0:	528000c1 	mov	w1, #0x6                   	// #6
    eab4:	97fff663 	bl	c440 <_RNvNtCs5eKY5gNNvwM_4core9panicking18panic_bounds_check@plt>

Disassembly of section .fini:
