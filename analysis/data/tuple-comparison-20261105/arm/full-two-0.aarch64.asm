
/tmp/tuple-comparison-20261105/harness-fullflags:     file format elf64-littleaarch64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

000000000000eef4 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_9bench_two0EBQ_>:
    eef4:	d10203ff 	sub	sp, sp, #0x80
    eef8:	a9027bfd 	stp	x29, x30, [sp, #32]
    eefc:	a9036ffc 	stp	x28, x27, [sp, #48]
    ef00:	a90467fa 	stp	x26, x25, [sp, #64]
    ef04:	a9055ff8 	stp	x24, x23, [sp, #80]
    ef08:	a90657f6 	stp	x22, x21, [sp, #96]
    ef0c:	a9074ff4 	stp	x20, x19, [sp, #112]
    ef10:	910083fd 	add	x29, sp, #0x20
    ef14:	aa0203f3 	mov	x19, x2
    ef18:	aa0103f4 	mov	x20, x1
    ef1c:	aa0003f5 	mov	x21, x0
    ef20:	97fff6b8 	bl	ca00 <_RNvMNtCs60nHaxeZLXj_3std4timeNtB2_7Instant3now@plt>
    ef24:	f90007e0 	str	x0, [sp, #8]
    ef28:	b90013e1 	str	w1, [sp, #16]
    ef2c:	b4000bf3 	cbz	x19, f0a8 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_9bench_two0EBQ_+0x1b4>
    ef30:	528000d6 	mov	w22, #0x6                   	// #6
    ef34:	52800317 	mov	w23, #0x18                  	// #24
    ef38:	52802019 	mov	w25, #0x100                 	// #256
    ef3c:	d10013ba 	sub	x26, x29, #0x4
    ef40:	14000020 	b	efc0 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_9bench_two0EBQ_+0xcc>
    ef44:	9bb7551b 	umaddl	x27, w8, w23, x21
    ef48:	9bb7559c 	umaddl	x28, w12, w23, x21
    ef4c:	a9402760 	ldp	x0, x9, [x27]
    ef50:	a9402381 	ldp	x1, x8, [x28]
    ef54:	eb080138 	subs	x24, x9, x8
    ef58:	9a883122 	csel	x2, x9, x8, cc	// cc = lo, ul, last
    ef5c:	97fff635 	bl	c830 <memcmp@plt>
    ef60:	f9400b68 	ldr	x8, [x27, #16]
    ef64:	93407c09 	sxtw	x9, w0
    ef68:	f9400b8a 	ldr	x10, [x28, #16]
    ef6c:	7100001f 	cmp	w0, #0x0
    ef70:	9a890309 	csel	x9, x24, x9, eq	// eq = none
    ef74:	eb0a011f 	cmp	x8, x10
    ef78:	1a9f27e8 	cset	w8, cc	// cc = lo, ul, last
    ef7c:	1a9f97ea 	cset	w10, hi	// hi = pmore
    ef80:	f100013f 	cmp	x9, #0x0
    ef84:	d37ffd29 	lsr	x9, x9, #63
    ef88:	1a9fd7eb 	cset	w11, gt
    ef8c:	1a8b014a 	csel	w10, w10, w11, eq	// eq = none
    ef90:	1a890108 	csel	w8, w8, w9, eq	// eq = none
    ef94:	7100015f 	cmp	w10, #0x0
    ef98:	52a0002a 	mov	w10, #0x10000               	// #65536
    ef9c:	52000109 	eor	w9, w8, #0x1
    efa0:	1a9f114a 	csel	w10, w10, wzr, ne	// ne = any
    efa4:	2a096149 	orr	w9, w10, w9, lsl #24
    efa8:	1a9913ea 	csel	w10, wzr, w25, ne	// ne = any
    efac:	f1000673 	subs	x19, x19, #0x1
    efb0:	2a080148 	orr	w8, w10, w8
    efb4:	2a080128 	orr	w8, w9, w8
    efb8:	b81fc3a8 	stur	w8, [x29, #-4]
    efbc:	54000760 	b.eq	f0a8 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_9bench_two0EBQ_+0x1b4>  // b.none
    efc0:	29403688 	ldp	w8, w13, [x20]
    efc4:	29412a8c 	ldp	w12, w10, [x20, #8]
    efc8:	4a082d08 	eor	w8, w8, w8, lsl #11
    efcc:	53087d09 	lsr	w9, w8, #8
    efd0:	4a0a0108 	eor	w8, w8, w10
    efd4:	4a4a4d29 	eor	w9, w9, w10, lsr #19
    efd8:	4a080129 	eor	w9, w9, w8
    efdc:	9bb67d2e 	umull	x14, w9, w22
    efe0:	d360fdc8 	lsr	x8, x14, #32
    efe4:	310015df 	cmn	w14, #0x5
    efe8:	540001e3 	b.cc	f024 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_9bench_two0EBQ_+0x130>  // b.lo, b.ul, b.last
    efec:	4a0d2dab 	eor	w11, w13, w13, lsl #11
    eff0:	29002a8c 	stp	w12, w10, [x20]
    eff4:	53087d6d 	lsr	w13, w11, #8
    eff8:	4a09016b 	eor	w11, w11, w9
    effc:	4a494dad 	eor	w13, w13, w9, lsr #19
    f000:	4a0b01ab 	eor	w11, w13, w11
    f004:	9bb67d6d 	umull	x13, w11, w22
    f008:	29012e89 	stp	w9, w11, [x20, #8]
    f00c:	d360fdad 	lsr	x13, x13, #32
    f010:	2b0d01df 	cmn	w14, w13
    f014:	9a883508 	cinc	x8, x8, cs	// cs = hs, nlast
    f018:	f100191f 	cmp	x8, #0x6
    f01c:	540000c3 	b.cc	f034 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_9bench_two0EBQ_+0x140>  // b.lo, b.ul, b.last
    f020:	1400001d 	b	f094 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_9bench_two0EBQ_+0x1a0>
    f024:	2a0903eb 	mov	w11, w9
    f028:	2a0a03e9 	mov	w9, w10
    f02c:	2a0c03ea 	mov	w10, w12
    f030:	2a0d03ec 	mov	w12, w13
    f034:	4a0c2d8c 	eor	w12, w12, w12, lsl #11
    f038:	53137d6d 	lsr	w13, w11, #19
    f03c:	2900268a 	stp	w10, w9, [x20]
    f040:	4a4c21ad 	eor	w13, w13, w12, lsr #8
    f044:	4a0c016c 	eor	w12, w11, w12
    f048:	4a0c01ad 	eor	w13, w13, w12
    f04c:	9bb67dae 	umull	x14, w13, w22
    f050:	2901368b 	stp	w11, w13, [x20, #8]
    f054:	d360fdcc 	lsr	x12, x14, #32
    f058:	310015df 	cmn	w14, #0x5
    f05c:	54fff743 	b.cc	ef44 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_9bench_two0EBQ_+0x50>  // b.lo, b.ul, b.last
    f060:	4a0a2d4a 	eor	w10, w10, w10, lsl #11
    f064:	29002e89 	stp	w9, w11, [x20]
    f068:	53087d4f 	lsr	w15, w10, #8
    f06c:	4a0d014a 	eor	w10, w10, w13
    f070:	4a4d4def 	eor	w15, w15, w13, lsr #19
    f074:	4a0a01ea 	eor	w10, w15, w10
    f078:	9bb67d4f 	umull	x15, w10, w22
    f07c:	29012a8d 	stp	w13, w10, [x20, #8]
    f080:	d360fdef 	lsr	x15, x15, #32
    f084:	2b0f01df 	cmn	w14, w15
    f088:	9a8c358c 	cinc	x12, x12, cs	// cs = hs, nlast
    f08c:	f100199f 	cmp	x12, #0x6
    f090:	54fff5a3 	b.cc	ef44 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvCslDem8Xm031_13harness_exacts_9bench_two0EBQ_+0x50>  // b.lo, b.ul, b.last
    f094:	f00002c2 	adrp	x2, 6a000 <GCC_except_table8+0x12bb8>
    f098:	91190042 	add	x2, x2, #0x640
    f09c:	528000c0 	mov	w0, #0x6                   	// #6
    f0a0:	528000c1 	mov	w1, #0x6                   	// #6
    f0a4:	97fff4e7 	bl	c440 <_RNvNtCs5eKY5gNNvwM_4core9panicking18panic_bounds_check@plt>
    f0a8:	910023e0 	add	x0, sp, #0x8
    f0ac:	97fff4f1 	bl	c470 <_RNvMNtCs60nHaxeZLXj_3std4timeNtB2_7Instant7elapsed@plt>
    f0b0:	52994008 	mov	w8, #0xca00                	// #51712
    f0b4:	72a77348 	movk	w8, #0x3b9a, lsl #16
    f0b8:	9b087c08 	mul	x8, x0, x8
    f0bc:	8b214100 	add	x0, x8, w1, uxtw
    f0c0:	a9474ff4 	ldp	x20, x19, [sp, #112]
    f0c4:	a94657f6 	ldp	x22, x21, [sp, #96]
    f0c8:	a9455ff8 	ldp	x24, x23, [sp, #80]
    f0cc:	a94467fa 	ldp	x26, x25, [sp, #64]
    f0d0:	a9436ffc 	ldp	x28, x27, [sp, #48]
    f0d4:	a9427bfd 	ldp	x29, x30, [sp, #32]
    f0d8:	910203ff 	add	sp, sp, #0x80
    f0dc:	d65f03c0 	ret

Disassembly of section .fini:
