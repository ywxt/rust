
/tmp/tuple-comparison-20261105/harness-fullflags:     file format elf64-littleaarch64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

000000000000ece8 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBQ_>:
    ece8:	d10203ff 	sub	sp, sp, #0x80
    ecec:	a9027bfd 	stp	x29, x30, [sp, #32]
    ecf0:	a9036ffc 	stp	x28, x27, [sp, #48]
    ecf4:	a90467fa 	stp	x26, x25, [sp, #64]
    ecf8:	a9055ff8 	stp	x24, x23, [sp, #80]
    ecfc:	a90657f6 	stp	x22, x21, [sp, #96]
    ed00:	a9074ff4 	stp	x20, x19, [sp, #112]
    ed04:	910083fd 	add	x29, sp, #0x20
    ed08:	aa0203f3 	mov	x19, x2
    ed0c:	aa0103f4 	mov	x20, x1
    ed10:	aa0003f5 	mov	x21, x0
    ed14:	97fff73b 	bl	ca00 <_RNvMNtCs60nHaxeZLXj_3std4timeNtB2_7Instant3now@plt>
    ed18:	f90007e0 	str	x0, [sp, #8]
    ed1c:	b90013e1 	str	w1, [sp, #16]
    ed20:	b4000c53 	cbz	x19, eea8 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBQ_+0x1c0>
    ed24:	528000d6 	mov	w22, #0x6                   	// #6
    ed28:	52800317 	mov	w23, #0x18                  	// #24
    ed2c:	5280201a 	mov	w26, #0x100                 	// #256
    ed30:	d10013bb 	sub	x27, x29, #0x4
    ed34:	14000016 	b	ed8c <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBQ_+0xa4>
    ed38:	f9400b88 	ldr	x8, [x28, #16]
    ed3c:	f9400b09 	ldr	x9, [x24, #16]
    ed40:	eb09011f 	cmp	x8, x9
    ed44:	1a9f27e8 	cset	w8, cc	// cc = lo, ul, last
    ed48:	1a9f87e9 	cset	w9, ls	// ls = plast
    ed4c:	1a9f97ea 	cset	w10, hi	// hi = pmore
    ed50:	1a9f37eb 	cset	w11, cs	// cs = hs, nlast
    ed54:	7100017f 	cmp	w11, #0x0
    ed58:	52a0200b 	mov	w11, #0x1000000             	// #16777216
    ed5c:	1a9f116b 	csel	w11, w11, wzr, ne	// ne = any
    ed60:	7100015f 	cmp	w10, #0x0
    ed64:	52a0002a 	mov	w10, #0x10000               	// #65536
    ed68:	1a9f114a 	csel	w10, w10, wzr, ne	// ne = any
    ed6c:	7100013f 	cmp	w9, #0x0
    ed70:	1a9f1349 	csel	w9, w26, wzr, ne	// ne = any
    ed74:	2a0a0108 	orr	w8, w8, w10
    ed78:	f1000673 	subs	x19, x19, #0x1
    ed7c:	2a090108 	orr	w8, w8, w9
    ed80:	2a0b0108 	orr	w8, w8, w11
    ed84:	b81fc3a8 	stur	w8, [x29, #-4]
    ed88:	54000900 	b.eq	eea8 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBQ_+0x1c0>  // b.none
    ed8c:	29403688 	ldp	w8, w13, [x20]
    ed90:	29412a8c 	ldp	w12, w10, [x20, #8]
    ed94:	4a082d08 	eor	w8, w8, w8, lsl #11
    ed98:	53087d09 	lsr	w9, w8, #8
    ed9c:	4a0a0108 	eor	w8, w8, w10
    eda0:	4a4a4d29 	eor	w9, w9, w10, lsr #19
    eda4:	4a080129 	eor	w9, w9, w8
    eda8:	9bb67d2e 	umull	x14, w9, w22
    edac:	d360fdc8 	lsr	x8, x14, #32
    edb0:	310015df 	cmn	w14, #0x5
    edb4:	540001e3 	b.cc	edf0 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBQ_+0x108>  // b.lo, b.ul, b.last
    edb8:	4a0d2dab 	eor	w11, w13, w13, lsl #11
    edbc:	29002a8c 	stp	w12, w10, [x20]
    edc0:	53087d6d 	lsr	w13, w11, #8
    edc4:	4a09016b 	eor	w11, w11, w9
    edc8:	4a494dad 	eor	w13, w13, w9, lsr #19
    edcc:	4a0b01ab 	eor	w11, w13, w11
    edd0:	9bb67d6d 	umull	x13, w11, w22
    edd4:	29012e89 	stp	w9, w11, [x20, #8]
    edd8:	d360fdad 	lsr	x13, x13, #32
    eddc:	2b0d01df 	cmn	w14, w13
    ede0:	9a883508 	cinc	x8, x8, cs	// cs = hs, nlast
    ede4:	f100191f 	cmp	x8, #0x6
    ede8:	540000c3 	b.cc	ee00 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBQ_+0x118>  // b.lo, b.ul, b.last
    edec:	1400003d 	b	eee0 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBQ_+0x1f8>
    edf0:	2a0903eb 	mov	w11, w9
    edf4:	2a0a03e9 	mov	w9, w10
    edf8:	2a0c03ea 	mov	w10, w12
    edfc:	2a0d03ec 	mov	w12, w13
    ee00:	4a0c2d8c 	eor	w12, w12, w12, lsl #11
    ee04:	53137d6d 	lsr	w13, w11, #19
    ee08:	2900268a 	stp	w10, w9, [x20]
    ee0c:	4a4c21ad 	eor	w13, w13, w12, lsr #8
    ee10:	4a0c016c 	eor	w12, w11, w12
    ee14:	4a0c01ad 	eor	w13, w13, w12
    ee18:	9bb67dae 	umull	x14, w13, w22
    ee1c:	2901368b 	stp	w11, w13, [x20, #8]
    ee20:	d360fdcc 	lsr	x12, x14, #32
    ee24:	310015df 	cmn	w14, #0x5
    ee28:	540001c3 	b.cc	ee60 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBQ_+0x178>  // b.lo, b.ul, b.last
    ee2c:	4a0a2d4a 	eor	w10, w10, w10, lsl #11
    ee30:	29002e89 	stp	w9, w11, [x20]
    ee34:	53087d4f 	lsr	w15, w10, #8
    ee38:	4a0d014a 	eor	w10, w10, w13
    ee3c:	4a4d4def 	eor	w15, w15, w13, lsr #19
    ee40:	4a0a01ea 	eor	w10, w15, w10
    ee44:	9bb67d4f 	umull	x15, w10, w22
    ee48:	29012a8d 	stp	w13, w10, [x20, #8]
    ee4c:	d360fdef 	lsr	x15, x15, #32
    ee50:	2b0f01df 	cmn	w14, w15
    ee54:	9a8c358c 	cinc	x12, x12, cs	// cs = hs, nlast
    ee58:	f100199f 	cmp	x12, #0x6
    ee5c:	54000422 	b.cs	eee0 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBQ_+0x1f8>  // b.hs, b.nlast
    ee60:	9bb7551c 	umaddl	x28, w8, w23, x21
    ee64:	9bb75598 	umaddl	x24, w12, w23, x21
    ee68:	a9402780 	ldp	x0, x9, [x28]
    ee6c:	a9402301 	ldp	x1, x8, [x24]
    ee70:	eb080139 	subs	x25, x9, x8
    ee74:	9a883122 	csel	x2, x9, x8, cc	// cc = lo, ul, last
    ee78:	97fff66e 	bl	c830 <memcmp@plt>
    ee7c:	93407c08 	sxtw	x8, w0
    ee80:	7100001f 	cmp	w0, #0x0
    ee84:	9a88032a 	csel	x10, x25, x8, eq	// eq = none
    ee88:	b4fff58a 	cbz	x10, ed38 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBQ_+0x50>
    ee8c:	d37ffd48 	lsr	x8, x10, #63
    ee90:	f100055f 	cmp	x10, #0x1
    ee94:	1a9fa7e9 	cset	w9, lt	// lt = tstop
    ee98:	f100015f 	cmp	x10, #0x0
    ee9c:	1a9fd7ea 	cset	w10, gt
    eea0:	5200010b 	eor	w11, w8, #0x1
    eea4:	17ffffac 	b	ed54 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_14bench_original0EBQ_+0x6c>
    eea8:	910023e0 	add	x0, sp, #0x8
    eeac:	97fff571 	bl	c470 <_RNvMNtCs60nHaxeZLXj_3std4timeNtB2_7Instant7elapsed@plt>
    eeb0:	52994008 	mov	w8, #0xca00                	// #51712
    eeb4:	72a77348 	movk	w8, #0x3b9a, lsl #16
    eeb8:	9b087c08 	mul	x8, x0, x8
    eebc:	8b214100 	add	x0, x8, w1, uxtw
    eec0:	a9474ff4 	ldp	x20, x19, [sp, #112]
    eec4:	a94657f6 	ldp	x22, x21, [sp, #96]
    eec8:	a9455ff8 	ldp	x24, x23, [sp, #80]
    eecc:	a94467fa 	ldp	x26, x25, [sp, #64]
    eed0:	a9436ffc 	ldp	x28, x27, [sp, #48]
    eed4:	a9427bfd 	ldp	x29, x30, [sp, #32]
    eed8:	910203ff 	add	sp, sp, #0x80
    eedc:	d65f03c0 	ret
    eee0:	900002e2 	adrp	x2, 6a000 <GCC_except_table8+0x12bb8>
    eee4:	91190042 	add	x2, x2, #0x640
    eee8:	528000c0 	mov	w0, #0x6                   	// #6
    eeec:	528000c1 	mov	w1, #0x6                   	// #6
    eef0:	97fff554 	bl	c440 <_RNvNtCs5eKY5gNNvwM_4core9panicking18panic_bounds_check@plt>

Disassembly of section .fini:
