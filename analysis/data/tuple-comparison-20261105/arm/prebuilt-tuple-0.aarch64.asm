
/tmp/xdiff-src/build/aarch64-unknown-linux-gnu/stage1-std/aarch64-unknown-linux-gnu/dist/build/coretests/c8805e1d516f63c4/out/corebenches-c8805e1d516f63c4:     file format elf64-littleaarch64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

000000000001d3ec <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvNtCslrxolIbw58w_11corebenches5tuples_22bench_tuple_comparison0EBS_>:
   1d3ec:	d10203ff 	sub	sp, sp, #0x80
   1d3f0:	a9027bfd 	stp	x29, x30, [sp, #32]
   1d3f4:	a9036ffc 	stp	x28, x27, [sp, #48]
   1d3f8:	a90467fa 	stp	x26, x25, [sp, #64]
   1d3fc:	a9055ff8 	stp	x24, x23, [sp, #80]
   1d400:	a90657f6 	stp	x22, x21, [sp, #96]
   1d404:	a9074ff4 	stp	x20, x19, [sp, #112]
   1d408:	910083fd 	add	x29, sp, #0x20
   1d40c:	aa0203f3 	mov	x19, x2
   1d410:	aa0103f4 	mov	x20, x1
   1d414:	aa0003f5 	mov	x21, x0
   1d418:	97fff00e 	bl	19450 <_RNvMNtCs60nHaxeZLXj_3std4timeNtB2_7Instant3now@plt>
   1d41c:	f90007e0 	str	x0, [sp, #8]
   1d420:	b90013e1 	str	w1, [sp, #16]
   1d424:	b4000c53 	cbz	x19, 1d5ac <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvNtCslrxolIbw58w_11corebenches5tuples_22bench_tuple_comparison0EBS_+0x1c0>
   1d428:	528000d6 	mov	w22, #0x6                   	// #6
   1d42c:	52800317 	mov	w23, #0x18                  	// #24
   1d430:	5280201a 	mov	w26, #0x100                 	// #256
   1d434:	d10013bb 	sub	x27, x29, #0x4
   1d438:	14000016 	b	1d490 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvNtCslrxolIbw58w_11corebenches5tuples_22bench_tuple_comparison0EBS_+0xa4>
   1d43c:	f9400b88 	ldr	x8, [x28, #16]
   1d440:	f9400b09 	ldr	x9, [x24, #16]
   1d444:	eb09011f 	cmp	x8, x9
   1d448:	1a9f27e8 	cset	w8, cc	// cc = lo, ul, last
   1d44c:	1a9f87e9 	cset	w9, ls	// ls = plast
   1d450:	1a9f97ea 	cset	w10, hi	// hi = pmore
   1d454:	1a9f37eb 	cset	w11, cs	// cs = hs, nlast
   1d458:	7100017f 	cmp	w11, #0x0
   1d45c:	52a0200b 	mov	w11, #0x1000000             	// #16777216
   1d460:	1a9f116b 	csel	w11, w11, wzr, ne	// ne = any
   1d464:	7100015f 	cmp	w10, #0x0
   1d468:	52a0002a 	mov	w10, #0x10000               	// #65536
   1d46c:	1a9f114a 	csel	w10, w10, wzr, ne	// ne = any
   1d470:	7100013f 	cmp	w9, #0x0
   1d474:	1a9f1349 	csel	w9, w26, wzr, ne	// ne = any
   1d478:	2a0a0108 	orr	w8, w8, w10
   1d47c:	f1000673 	subs	x19, x19, #0x1
   1d480:	2a090108 	orr	w8, w8, w9
   1d484:	2a0b0108 	orr	w8, w8, w11
   1d488:	b81fc3a8 	stur	w8, [x29, #-4]
   1d48c:	54000900 	b.eq	1d5ac <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvNtCslrxolIbw58w_11corebenches5tuples_22bench_tuple_comparison0EBS_+0x1c0>  // b.none
   1d490:	29403688 	ldp	w8, w13, [x20]
   1d494:	29412a8c 	ldp	w12, w10, [x20, #8]
   1d498:	4a082d08 	eor	w8, w8, w8, lsl #11
   1d49c:	53087d09 	lsr	w9, w8, #8
   1d4a0:	4a0a0108 	eor	w8, w8, w10
   1d4a4:	4a4a4d29 	eor	w9, w9, w10, lsr #19
   1d4a8:	4a080129 	eor	w9, w9, w8
   1d4ac:	9bb67d2e 	umull	x14, w9, w22
   1d4b0:	d360fdc8 	lsr	x8, x14, #32
   1d4b4:	310015df 	cmn	w14, #0x5
   1d4b8:	540001e3 	b.cc	1d4f4 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvNtCslrxolIbw58w_11corebenches5tuples_22bench_tuple_comparison0EBS_+0x108>  // b.lo, b.ul, b.last
   1d4bc:	4a0d2dab 	eor	w11, w13, w13, lsl #11
   1d4c0:	29002a8c 	stp	w12, w10, [x20]
   1d4c4:	53087d6d 	lsr	w13, w11, #8
   1d4c8:	4a09016b 	eor	w11, w11, w9
   1d4cc:	4a494dad 	eor	w13, w13, w9, lsr #19
   1d4d0:	4a0b01ab 	eor	w11, w13, w11
   1d4d4:	9bb67d6d 	umull	x13, w11, w22
   1d4d8:	29012e89 	stp	w9, w11, [x20, #8]
   1d4dc:	d360fdad 	lsr	x13, x13, #32
   1d4e0:	2b0d01df 	cmn	w14, w13
   1d4e4:	9a883508 	cinc	x8, x8, cs	// cs = hs, nlast
   1d4e8:	f100191f 	cmp	x8, #0x6
   1d4ec:	540000c3 	b.cc	1d504 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvNtCslrxolIbw58w_11corebenches5tuples_22bench_tuple_comparison0EBS_+0x118>  // b.lo, b.ul, b.last
   1d4f0:	1400003d 	b	1d5e4 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvNtCslrxolIbw58w_11corebenches5tuples_22bench_tuple_comparison0EBS_+0x1f8>
   1d4f4:	2a0903eb 	mov	w11, w9
   1d4f8:	2a0a03e9 	mov	w9, w10
   1d4fc:	2a0c03ea 	mov	w10, w12
   1d500:	2a0d03ec 	mov	w12, w13
   1d504:	4a0c2d8c 	eor	w12, w12, w12, lsl #11
   1d508:	53137d6d 	lsr	w13, w11, #19
   1d50c:	2900268a 	stp	w10, w9, [x20]
   1d510:	4a4c21ad 	eor	w13, w13, w12, lsr #8
   1d514:	4a0c016c 	eor	w12, w11, w12
   1d518:	4a0c01ad 	eor	w13, w13, w12
   1d51c:	9bb67dae 	umull	x14, w13, w22
   1d520:	2901368b 	stp	w11, w13, [x20, #8]
   1d524:	d360fdcc 	lsr	x12, x14, #32
   1d528:	310015df 	cmn	w14, #0x5
   1d52c:	540001c3 	b.cc	1d564 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvNtCslrxolIbw58w_11corebenches5tuples_22bench_tuple_comparison0EBS_+0x178>  // b.lo, b.ul, b.last
   1d530:	4a0a2d4a 	eor	w10, w10, w10, lsl #11
   1d534:	29002e89 	stp	w9, w11, [x20]
   1d538:	53087d4f 	lsr	w15, w10, #8
   1d53c:	4a0d014a 	eor	w10, w10, w13
   1d540:	4a4d4def 	eor	w15, w15, w13, lsr #19
   1d544:	4a0a01ea 	eor	w10, w15, w10
   1d548:	9bb67d4f 	umull	x15, w10, w22
   1d54c:	29012a8d 	stp	w13, w10, [x20, #8]
   1d550:	d360fdef 	lsr	x15, x15, #32
   1d554:	2b0f01df 	cmn	w14, w15
   1d558:	9a8c358c 	cinc	x12, x12, cs	// cs = hs, nlast
   1d55c:	f100199f 	cmp	x12, #0x6
   1d560:	54000422 	b.cs	1d5e4 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvNtCslrxolIbw58w_11corebenches5tuples_22bench_tuple_comparison0EBS_+0x1f8>  // b.hs, b.nlast
   1d564:	9bb7551c 	umaddl	x28, w8, w23, x21
   1d568:	9bb75598 	umaddl	x24, w12, w23, x21
   1d56c:	a9402780 	ldp	x0, x9, [x28]
   1d570:	a9402301 	ldp	x1, x8, [x24]
   1d574:	eb080139 	subs	x25, x9, x8
   1d578:	9a883122 	csel	x2, x9, x8, cc	// cc = lo, ul, last
   1d57c:	97ffef35 	bl	19250 <memcmp@plt>
   1d580:	93407c08 	sxtw	x8, w0
   1d584:	7100001f 	cmp	w0, #0x0
   1d588:	9a88032a 	csel	x10, x25, x8, eq	// eq = none
   1d58c:	b4fff58a 	cbz	x10, 1d43c <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvNtCslrxolIbw58w_11corebenches5tuples_22bench_tuple_comparison0EBS_+0x50>
   1d590:	d37ffd48 	lsr	x8, x10, #63
   1d594:	f100055f 	cmp	x10, #0x1
   1d598:	1a9fa7e9 	cset	w9, lt	// lt = tstop
   1d59c:	f100015f 	cmp	x10, #0x0
   1d5a0:	1a9fd7ea 	cset	w10, gt
   1d5a4:	5200010b 	eor	w11, w8, #0x1
   1d5a8:	17ffffac 	b	1d458 <_RINvNtCspchWlblWlP_4test5bench13ns_iter_innerAbj4_NCNvNtCslrxolIbw58w_11corebenches5tuples_22bench_tuple_comparison0EBS_+0x6c>
   1d5ac:	910023e0 	add	x0, sp, #0x8
   1d5b0:	97ffee10 	bl	18df0 <_RNvMNtCs60nHaxeZLXj_3std4timeNtB2_7Instant7elapsed@plt>
   1d5b4:	52994008 	mov	w8, #0xca00                	// #51712
   1d5b8:	72a77348 	movk	w8, #0x3b9a, lsl #16
   1d5bc:	9b087c08 	mul	x8, x0, x8
   1d5c0:	8b214100 	add	x0, x8, w1, uxtw
   1d5c4:	a9474ff4 	ldp	x20, x19, [sp, #112]
   1d5c8:	a94657f6 	ldp	x22, x21, [sp, #96]
   1d5cc:	a9455ff8 	ldp	x24, x23, [sp, #80]
   1d5d0:	a94467fa 	ldp	x26, x25, [sp, #64]
   1d5d4:	a9436ffc 	ldp	x28, x27, [sp, #48]
   1d5d8:	a9427bfd 	ldp	x29, x30, [sp, #32]
   1d5dc:	910203ff 	add	sp, sp, #0x80
   1d5e0:	d65f03c0 	ret
   1d5e4:	d0001522 	adrp	x2, 2c3000 <GCC_except_table3+0x86bc>
   1d5e8:	911b4042 	add	x2, x2, #0x6d0
   1d5ec:	528000c0 	mov	w0, #0x6                   	// #6
   1d5f0:	528000c1 	mov	w1, #0x6                   	// #6
   1d5f4:	97ffedf3 	bl	18dc0 <_RNvNtCs5eKY5gNNvwM_4core9panicking18panic_bounds_check@plt>

Disassembly of section .fini:
