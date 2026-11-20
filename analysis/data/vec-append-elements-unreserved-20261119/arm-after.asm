
/tmp/slice-join-len-20261119/bench-len:     file format elf64-littleaarch64


Disassembly of section .text:

00000000001691ec <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join>:
  1691ec:	d101c3ff 	sub	sp, sp, #0x70
  1691f0:	a9027bfd 	stp	x29, x30, [sp, #32]
  1691f4:	a90367fa 	stp	x26, x25, [sp, #48]
  1691f8:	a9045ff8 	stp	x24, x23, [sp, #64]
  1691fc:	a90557f6 	stp	x22, x21, [sp, #80]
  169200:	a9064ff4 	stp	x20, x19, [sp, #96]
  169204:	910083fd 	add	x29, sp, #0x20
  169208:	aa0803f3 	mov	x19, x8
  16920c:	b4000141 	cbz	x1, 169234 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x48>
  169210:	8b010428 	add	x8, x1, x1, lsl #1
  169214:	aa0203f5 	mov	x21, x2
  169218:	aa0103f6 	mov	x22, x1
  16921c:	aa0003f4 	mov	x20, x0
  169220:	f100243f 	cmp	x1, #0x9
  169224:	54000102 	b.cs	169244 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x58>  // b.hs, b.nlast
  169228:	aa1f03e9 	mov	x9, xzr
  16922c:	aa1f03ea 	mov	x10, xzr
  169230:	14000027 	b	1692cc <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0xe0>
  169234:	52800088 	mov	w8, #0x4                   	// #4
  169238:	f9000a7f 	str	xzr, [x19, #16]
  16923c:	a900227f 	stp	xzr, x8, [x19]
  169240:	14000054 	b	169390 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x1a4>
  169244:	f2400ac9 	ands	x9, x22, #0x7
  169248:	5280010a 	mov	w10, #0x8                   	// #8
  16924c:	6f00e400 	movi	v0.2d, #0x0
  169250:	6f00e401 	movi	v1.2d, #0x0
  169254:	6f00e402 	movi	v2.2d, #0x0
  169258:	6f00e403 	movi	v3.2d, #0x0
  16925c:	9a890149 	csel	x9, x10, x9, eq	// eq = none
  169260:	9101c28a 	add	x10, x20, #0x70
  169264:	cb0902c9 	sub	x9, x22, x9
  169268:	aa0903eb 	mov	x11, x9
  16926c:	3cda0144 	ldur	q4, [x10, #-96]
  169270:	d101214c 	sub	x12, x10, #0x48
  169274:	3cdd0145 	ldur	q5, [x10, #-48]
  169278:	3dc00146 	ldr	q6, [x10]
  16927c:	3dc00d47 	ldr	q7, [x10, #48]
  169280:	d100614d 	sub	x13, x10, #0x18
  169284:	9100614e 	add	x14, x10, #0x18
  169288:	4d408584 	ld1	{v4.d}[1], [x12]
  16928c:	9101214c 	add	x12, x10, #0x48
  169290:	4d4085a5 	ld1	{v5.d}[1], [x13]
  169294:	4d4085c6 	ld1	{v6.d}[1], [x14]
  169298:	4d408587 	ld1	{v7.d}[1], [x12]
  16929c:	f100216b 	subs	x11, x11, #0x8
  1692a0:	9103014a 	add	x10, x10, #0xc0
  1692a4:	4ee08480 	add	v0.2d, v4.2d, v0.2d
  1692a8:	4ee184a1 	add	v1.2d, v5.2d, v1.2d
  1692ac:	4ee284c2 	add	v2.2d, v6.2d, v2.2d
  1692b0:	4ee384e3 	add	v3.2d, v7.2d, v3.2d
  1692b4:	54fffdc1 	b.ne	16926c <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x80>  // b.any
  1692b8:	4ee08420 	add	v0.2d, v1.2d, v0.2d
  1692bc:	4ee08440 	add	v0.2d, v2.2d, v0.2d
  1692c0:	4ee08460 	add	v0.2d, v3.2d, v0.2d
  1692c4:	5ef1b800 	addp	d0, v0.2d
  1692c8:	9e66000a 	fmov	x10, d0
  1692cc:	5280030b 	mov	w11, #0x18                  	// #24
  1692d0:	d37df119 	lsl	x25, x8, #3
  1692d4:	cb0902c8 	sub	x8, x22, x9
  1692d8:	9b0b512b 	madd	x11, x9, x11, x20
  1692dc:	91004169 	add	x9, x11, #0x10
  1692e0:	f841852b 	ldr	x11, [x9], #24
  1692e4:	f1000508 	subs	x8, x8, #0x1
  1692e8:	8b0a016a 	add	x10, x11, x10
  1692ec:	54ffffa1 	b.ne	1692e0 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0xf4>  // b.any
  1692f0:	8b0a02c8 	add	x8, x22, x10
  1692f4:	d100051a 	sub	x26, x8, #0x1
  1692f8:	b27ef3e8 	mov	x8, #0x7ffffffffffffffc    	// #9223372036854775804
  1692fc:	d37ef757 	lsl	x23, x26, #2
  169300:	92420749 	and	x9, x26, #0xc000000000000000
  169304:	eb0802ff 	cmp	x23, x8
  169308:	fa409920 	ccmp	x9, #0x0, #0x0, ls	// ls = plast
  16930c:	540000a0 	b.eq	169320 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x134>  // b.none
  169310:	aa1f03f8 	mov	x24, xzr
  169314:	aa1803e0 	mov	x0, x24
  169318:	aa1703e1 	mov	x1, x23
  16931c:	97fdb101 	bl	d5720 <alloc::raw_vec::handle_error@plt>
  169320:	b4000517 	cbz	x23, 1693c0 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x1d4>
  169324:	97fdaf67 	bl	d50c0 <__rustc::__rust_no_alloc_shim_is_unstable_v2@plt>
  169328:	aa1703e0 	mov	x0, x23
  16932c:	52800081 	mov	w1, #0x4                   	// #4
  169330:	52800098 	mov	w24, #0x4                   	// #4
  169334:	97fdafe7 	bl	d52d0 <__rustc::__rust_alloc@plt>
  169338:	b4fffee0 	cbz	x0, 169314 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x128>
  16933c:	a940de98 	ldp	x24, x23, [x20, #8]
  169340:	a90083fa 	stp	x26, x0, [sp, #8]
  169344:	f9000fff 	str	xzr, [sp, #24]
  169348:	eb1a02ff 	cmp	x23, x26
  16934c:	54000468 	b.hi	1693d8 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x1ec>  // b.pmore
  169350:	aa1f03fa 	mov	x26, xzr
  169354:	aa1f03e8 	mov	x8, xzr
  169358:	b40000d7 	cbz	x23, 169370 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x184>
  16935c:	d37ef6e2 	lsl	x2, x23, #2
  169360:	8b1a0800 	add	x0, x0, x26, lsl #2
  169364:	aa1803e1 	mov	x1, x24
  169368:	97fdaee2 	bl	d4ef0 <memcpy@plt>
  16936c:	aa1a03e8 	mov	x8, x26
  169370:	8b17011a 	add	x26, x8, x23
  169374:	f10006df 	cmp	x22, #0x1
  169378:	f9000ffa 	str	x26, [sp, #24]
  16937c:	54000181 	b.ne	1693ac <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x1c0>  // b.any
  169380:	3cc083e0 	ldur	q0, [sp, #8]
  169384:	f9400fe8 	ldr	x8, [sp, #24]
  169388:	3d800260 	str	q0, [x19]
  16938c:	f9000a68 	str	x8, [x19, #16]
  169390:	a9464ff4 	ldp	x20, x19, [sp, #96]
  169394:	a94557f6 	ldp	x22, x21, [sp, #80]
  169398:	a9445ff8 	ldp	x24, x23, [sp, #64]
  16939c:	a94367fa 	ldp	x26, x25, [sp, #48]
  1693a0:	a9427bfd 	ldp	x29, x30, [sp, #32]
  1693a4:	9101c3ff 	add	sp, sp, #0x70
  1693a8:	d65f03c0 	ret
  1693ac:	b94002b7 	ldr	w23, [x21]
  1693b0:	f94007e8 	ldr	x8, [sp, #8]
  1693b4:	d1006338 	sub	x24, x25, #0x18
  1693b8:	9100a299 	add	x25, x20, #0x28
  1693bc:	14000021 	b	169440 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x254>
  1693c0:	52800080 	mov	w0, #0x4                   	// #4
  1693c4:	a940de98 	ldp	x24, x23, [x20, #8]
  1693c8:	a90083ff 	stp	xzr, x0, [sp, #8]
  1693cc:	f9000fff 	str	xzr, [sp, #24]
  1693d0:	eb1f02ff 	cmp	x23, xzr
  1693d4:	54fffbe9 	b.ls	169350 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x164>  // b.plast
  1693d8:	910023e0 	add	x0, sp, #0x8
  1693dc:	aa1f03e1 	mov	x1, xzr
  1693e0:	aa1703e2 	mov	x2, x23
  1693e4:	52800083 	mov	w3, #0x4                   	// #4
  1693e8:	52800084 	mov	w4, #0x4                   	// #4
  1693ec:	97fdb50b 	bl	d6818 <<alloc::raw_vec::RawVecInner<_>>::reserve::do_reserve_and_handle::<alloc::alloc::Global>>
  1693f0:	a9416be0 	ldp	x0, x26, [sp, #16]
  1693f4:	17ffffda 	b	16935c <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x170>
  1693f8:	910023e0 	add	x0, sp, #0x8
  1693fc:	aa1503e1 	mov	x1, x21
  169400:	aa1403e2 	mov	x2, x20
  169404:	52800083 	mov	w3, #0x4                   	// #4
  169408:	52800084 	mov	w4, #0x4                   	// #4
  16940c:	97fdb503 	bl	d6818 <<alloc::raw_vec::RawVecInner<_>>::reserve::do_reserve_and_handle::<alloc::alloc::Global>>
  169410:	f9400ff5 	ldr	x21, [sp, #24]
  169414:	f9400be8 	ldr	x8, [sp, #16]
  169418:	d37ef682 	lsl	x2, x20, #2
  16941c:	aa1603e1 	mov	x1, x22
  169420:	8b150900 	add	x0, x8, x21, lsl #2
  169424:	97fdaeb3 	bl	d4ef0 <memcpy@plt>
  169428:	f94007e8 	ldr	x8, [sp, #8]
  16942c:	8b1402ba 	add	x26, x21, x20
  169430:	f1006318 	subs	x24, x24, #0x18
  169434:	91006339 	add	x25, x25, #0x18
  169438:	f9000ffa 	str	x26, [sp, #24]
  16943c:	54fffa20 	b.eq	169380 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x194>  // b.none
  169440:	eb08035f 	cmp	x26, x8
  169444:	54000061 	b.ne	169450 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x264>  // b.any
  169448:	910023e0 	add	x0, sp, #0x8
  16944c:	97fdb54a 	bl	d6974 <<alloc::raw_vec::RawVec<i32>>::grow_one>
  169450:	f9400be8 	ldr	x8, [sp, #16]
  169454:	a97fd336 	ldp	x22, x20, [x25, #-8]
  169458:	91000755 	add	x21, x26, #0x1
  16945c:	b83a7917 	str	w23, [x8, x26, lsl #2]
  169460:	f94007e8 	ldr	x8, [sp, #8]
  169464:	f9000ff5 	str	x21, [sp, #24]
  169468:	cb150109 	sub	x9, x8, x21
  16946c:	eb09029f 	cmp	x20, x9
  169470:	54fffc48 	b.hi	1693f8 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x20c>  // b.pmore
  169474:	b5fffd14 	cbnz	x20, 169414 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x228>
  169478:	17ffffed 	b	16942c <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x240>
  16947c:	14000001 	b	169480 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x294>
  169480:	f94007e8 	ldr	x8, [sp, #8]
  169484:	aa0003f3 	mov	x19, x0
  169488:	b40000a8 	cbz	x8, 16949c <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x2b0>
  16948c:	f9400be0 	ldr	x0, [sp, #16]
  169490:	d37ef501 	lsl	x1, x8, #2
  169494:	52800082 	mov	w2, #0x4                   	// #4
  169498:	97fdafba 	bl	d5380 <__rustc::__rust_dealloc@plt>
  16949c:	aa1303e0 	mov	x0, x19
  1694a0:	97fdb0bc 	bl	d5790 <_Unwind_Resume@plt>
