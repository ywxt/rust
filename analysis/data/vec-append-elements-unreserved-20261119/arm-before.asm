
/tmp/stdlib-join-unified-20261119/bench-base:     file format elf64-littleaarch64


Disassembly of section .text:

00000000001691e4 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join>:
  1691e4:	d101c3ff 	sub	sp, sp, #0x70
  1691e8:	a9027bfd 	stp	x29, x30, [sp, #32]
  1691ec:	a90367fa 	stp	x26, x25, [sp, #48]
  1691f0:	a9045ff8 	stp	x24, x23, [sp, #64]
  1691f4:	a90557f6 	stp	x22, x21, [sp, #80]
  1691f8:	a9064ff4 	stp	x20, x19, [sp, #96]
  1691fc:	910083fd 	add	x29, sp, #0x20
  169200:	aa0803f3 	mov	x19, x8
  169204:	b4000141 	cbz	x1, 16922c <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x48>
  169208:	8b010428 	add	x8, x1, x1, lsl #1
  16920c:	aa0203f5 	mov	x21, x2
  169210:	aa0103f6 	mov	x22, x1
  169214:	aa0003f4 	mov	x20, x0
  169218:	f100243f 	cmp	x1, #0x9
  16921c:	54000102 	b.cs	16923c <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x58>  // b.hs, b.nlast
  169220:	aa1f03e9 	mov	x9, xzr
  169224:	aa1f03ea 	mov	x10, xzr
  169228:	14000027 	b	1692c4 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0xe0>
  16922c:	52800088 	mov	w8, #0x4                   	// #4
  169230:	f9000a7f 	str	xzr, [x19, #16]
  169234:	a900227f 	stp	xzr, x8, [x19]
  169238:	14000054 	b	169388 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x1a4>
  16923c:	f2400ac9 	ands	x9, x22, #0x7
  169240:	5280010a 	mov	w10, #0x8                   	// #8
  169244:	6f00e400 	movi	v0.2d, #0x0
  169248:	6f00e401 	movi	v1.2d, #0x0
  16924c:	6f00e402 	movi	v2.2d, #0x0
  169250:	6f00e403 	movi	v3.2d, #0x0
  169254:	9a890149 	csel	x9, x10, x9, eq	// eq = none
  169258:	9101c28a 	add	x10, x20, #0x70
  16925c:	cb0902c9 	sub	x9, x22, x9
  169260:	aa0903eb 	mov	x11, x9
  169264:	3cda0144 	ldur	q4, [x10, #-96]
  169268:	d101214c 	sub	x12, x10, #0x48
  16926c:	3cdd0145 	ldur	q5, [x10, #-48]
  169270:	3dc00146 	ldr	q6, [x10]
  169274:	3dc00d47 	ldr	q7, [x10, #48]
  169278:	d100614d 	sub	x13, x10, #0x18
  16927c:	9100614e 	add	x14, x10, #0x18
  169280:	4d408584 	ld1	{v4.d}[1], [x12]
  169284:	9101214c 	add	x12, x10, #0x48
  169288:	4d4085a5 	ld1	{v5.d}[1], [x13]
  16928c:	4d4085c6 	ld1	{v6.d}[1], [x14]
  169290:	4d408587 	ld1	{v7.d}[1], [x12]
  169294:	f100216b 	subs	x11, x11, #0x8
  169298:	9103014a 	add	x10, x10, #0xc0
  16929c:	4ee08480 	add	v0.2d, v4.2d, v0.2d
  1692a0:	4ee184a1 	add	v1.2d, v5.2d, v1.2d
  1692a4:	4ee284c2 	add	v2.2d, v6.2d, v2.2d
  1692a8:	4ee384e3 	add	v3.2d, v7.2d, v3.2d
  1692ac:	54fffdc1 	b.ne	169264 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x80>  // b.any
  1692b0:	4ee08420 	add	v0.2d, v1.2d, v0.2d
  1692b4:	4ee08440 	add	v0.2d, v2.2d, v0.2d
  1692b8:	4ee08460 	add	v0.2d, v3.2d, v0.2d
  1692bc:	5ef1b800 	addp	d0, v0.2d
  1692c0:	9e66000a 	fmov	x10, d0
  1692c4:	5280030b 	mov	w11, #0x18                  	// #24
  1692c8:	d37df119 	lsl	x25, x8, #3
  1692cc:	cb0902c8 	sub	x8, x22, x9
  1692d0:	9b0b512b 	madd	x11, x9, x11, x20
  1692d4:	91004169 	add	x9, x11, #0x10
  1692d8:	f841852b 	ldr	x11, [x9], #24
  1692dc:	f1000508 	subs	x8, x8, #0x1
  1692e0:	8b0a016a 	add	x10, x11, x10
  1692e4:	54ffffa1 	b.ne	1692d8 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0xf4>  // b.any
  1692e8:	8b0a02c8 	add	x8, x22, x10
  1692ec:	d100051a 	sub	x26, x8, #0x1
  1692f0:	b27ef3e8 	mov	x8, #0x7ffffffffffffffc    	// #9223372036854775804
  1692f4:	d37ef757 	lsl	x23, x26, #2
  1692f8:	92420749 	and	x9, x26, #0xc000000000000000
  1692fc:	eb0802ff 	cmp	x23, x8
  169300:	fa409920 	ccmp	x9, #0x0, #0x0, ls	// ls = plast
  169304:	540000a0 	b.eq	169318 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x134>  // b.none
  169308:	aa1f03f8 	mov	x24, xzr
  16930c:	aa1803e0 	mov	x0, x24
  169310:	aa1703e1 	mov	x1, x23
  169314:	97fdb103 	bl	d5720 <alloc::raw_vec::handle_error@plt>
  169318:	b4000517 	cbz	x23, 1693b8 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x1d4>
  16931c:	97fdaf69 	bl	d50c0 <__rustc::__rust_no_alloc_shim_is_unstable_v2@plt>
  169320:	aa1703e0 	mov	x0, x23
  169324:	52800081 	mov	w1, #0x4                   	// #4
  169328:	52800098 	mov	w24, #0x4                   	// #4
  16932c:	97fdafe9 	bl	d52d0 <__rustc::__rust_alloc@plt>
  169330:	b4fffee0 	cbz	x0, 16930c <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x128>
  169334:	a940de98 	ldp	x24, x23, [x20, #8]
  169338:	a90083fa 	stp	x26, x0, [sp, #8]
  16933c:	f9000fff 	str	xzr, [sp, #24]
  169340:	eb1a02ff 	cmp	x23, x26
  169344:	54000468 	b.hi	1693d0 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x1ec>  // b.pmore
  169348:	aa1f03fa 	mov	x26, xzr
  16934c:	aa1f03e8 	mov	x8, xzr
  169350:	b40000d7 	cbz	x23, 169368 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x184>
  169354:	d37ef6e2 	lsl	x2, x23, #2
  169358:	8b1a0800 	add	x0, x0, x26, lsl #2
  16935c:	aa1803e1 	mov	x1, x24
  169360:	97fdaee4 	bl	d4ef0 <memcpy@plt>
  169364:	aa1a03e8 	mov	x8, x26
  169368:	8b17011a 	add	x26, x8, x23
  16936c:	f10006df 	cmp	x22, #0x1
  169370:	f9000ffa 	str	x26, [sp, #24]
  169374:	54000181 	b.ne	1693a4 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x1c0>  // b.any
  169378:	3cc083e0 	ldur	q0, [sp, #8]
  16937c:	f9400fe8 	ldr	x8, [sp, #24]
  169380:	3d800260 	str	q0, [x19]
  169384:	f9000a68 	str	x8, [x19, #16]
  169388:	a9464ff4 	ldp	x20, x19, [sp, #96]
  16938c:	a94557f6 	ldp	x22, x21, [sp, #80]
  169390:	a9445ff8 	ldp	x24, x23, [sp, #64]
  169394:	a94367fa 	ldp	x26, x25, [sp, #48]
  169398:	a9427bfd 	ldp	x29, x30, [sp, #32]
  16939c:	9101c3ff 	add	sp, sp, #0x70
  1693a0:	d65f03c0 	ret
  1693a4:	b94002b6 	ldr	w22, [x21]
  1693a8:	f94007e8 	ldr	x8, [sp, #8]
  1693ac:	d1006337 	sub	x23, x25, #0x18
  1693b0:	9100a298 	add	x24, x20, #0x28
  1693b4:	14000021 	b	169438 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x254>
  1693b8:	52800080 	mov	w0, #0x4                   	// #4
  1693bc:	a940de98 	ldp	x24, x23, [x20, #8]
  1693c0:	a90083ff 	stp	xzr, x0, [sp, #8]
  1693c4:	f9000fff 	str	xzr, [sp, #24]
  1693c8:	eb1f02ff 	cmp	x23, xzr
  1693cc:	54fffbe9 	b.ls	169348 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x164>  // b.plast
  1693d0:	910023e0 	add	x0, sp, #0x8
  1693d4:	aa1f03e1 	mov	x1, xzr
  1693d8:	aa1703e2 	mov	x2, x23
  1693dc:	52800083 	mov	w3, #0x4                   	// #4
  1693e0:	52800084 	mov	w4, #0x4                   	// #4
  1693e4:	97fdb50d 	bl	d6818 <<alloc::raw_vec::RawVecInner<_>>::reserve::do_reserve_and_handle::<alloc::alloc::Global>>
  1693e8:	a9416be0 	ldp	x0, x26, [sp, #16]
  1693ec:	17ffffda 	b	169354 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x170>
  1693f0:	910023e0 	add	x0, sp, #0x8
  1693f4:	aa1403e2 	mov	x2, x20
  1693f8:	52800083 	mov	w3, #0x4                   	// #4
  1693fc:	52800084 	mov	w4, #0x4                   	// #4
  169400:	97fdb506 	bl	d6818 <<alloc::raw_vec::RawVecInner<_>>::reserve::do_reserve_and_handle::<alloc::alloc::Global>>
  169404:	f9400fe1 	ldr	x1, [sp, #24]
  169408:	f9400be8 	ldr	x8, [sp, #16]
  16940c:	d37ef682 	lsl	x2, x20, #2
  169410:	8b010900 	add	x0, x8, x1, lsl #2
  169414:	aa1503e1 	mov	x1, x21
  169418:	97fdaeb6 	bl	d4ef0 <memcpy@plt>
  16941c:	f9400fe1 	ldr	x1, [sp, #24]
  169420:	f94007e8 	ldr	x8, [sp, #8]
  169424:	8b14003a 	add	x26, x1, x20
  169428:	f10062f7 	subs	x23, x23, #0x18
  16942c:	91006318 	add	x24, x24, #0x18
  169430:	f9000ffa 	str	x26, [sp, #24]
  169434:	54fffa20 	b.eq	169378 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x194>  // b.none
  169438:	eb08035f 	cmp	x26, x8
  16943c:	54000061 	b.ne	169448 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x264>  // b.any
  169440:	910023e0 	add	x0, sp, #0x8
  169444:	97fdb54c 	bl	d6974 <<alloc::raw_vec::RawVec<i32>>::grow_one>
  169448:	f9400be8 	ldr	x8, [sp, #16]
  16944c:	a97fd315 	ldp	x21, x20, [x24, #-8]
  169450:	91000741 	add	x1, x26, #0x1
  169454:	b83a7916 	str	w22, [x8, x26, lsl #2]
  169458:	f94007e8 	ldr	x8, [sp, #8]
  16945c:	f9000fe1 	str	x1, [sp, #24]
  169460:	cb010109 	sub	x9, x8, x1
  169464:	eb09029f 	cmp	x20, x9
  169468:	54fffc48 	b.hi	1693f0 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x20c>  // b.pmore
  16946c:	b5fffcf4 	cbnz	x20, 169408 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x224>
  169470:	17ffffed 	b	169424 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x240>
  169474:	14000001 	b	169478 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x294>
  169478:	f94007e8 	ldr	x8, [sp, #8]
  16947c:	aa0003f3 	mov	x19, x0
  169480:	b40000a8 	cbz	x8, 169494 <<[alloc::vec::Vec<i32>] as alloc::slice::Join<&i32>>::join+0x2b0>
  169484:	f9400be0 	ldr	x0, [sp, #16]
  169488:	d37ef501 	lsl	x1, x8, #2
  16948c:	52800082 	mov	w2, #0x4                   	// #4
  169490:	97fdafbc 	bl	d5380 <__rustc::__rust_dealloc@plt>
  169494:	aa1303e0 	mov	x0, x19
  169498:	97fdb0be 	bl	d5790 <_Unwind_Resume@plt>
