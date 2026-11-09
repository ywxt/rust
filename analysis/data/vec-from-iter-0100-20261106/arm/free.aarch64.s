
/usr/lib64/libc.so.6:     file format elf64-littleaarch64


Disassembly of section .plt:

Disassembly of section .text:

000000000008f870 <__libc_free@@GLIBC_2.17>:
   8f870:	b4000740 	cbz	x0, 8f958 <__libc_free@@GLIBC_2.17+0xe8>
   8f874:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
   8f878:	d1004001 	sub	x1, x0, #0x10
   8f87c:	910003fd 	mov	x29, sp
   8f880:	f9400420 	ldr	x0, [x1, #8]
   8f884:	a90153f3 	stp	x19, x20, [sp, #16]
   8f888:	90000894 	adrp	x20, 19f000 <h_errlist@@GLIBC_2.17+0x5b8>
   8f88c:	f946ea94 	ldr	x20, [x20, #3536]
   8f890:	d53bd053 	mrs	x19, tpidr_el0
   8f894:	f90013f5 	str	x21, [sp, #32]
   8f898:	b8746a75 	ldr	w21, [x19, x20]
   8f89c:	36080220 	tbz	w0, #1, 8f8e0 <__libc_free@@GLIBC_2.17+0x70>
   8f8a0:	b0000883 	adrp	x3, 1a0000 <_IO_wfile_jumps@@GLIBC_2.17+0xbf0>
   8f8a4:	91044062 	add	x2, x3, #0x110
   8f8a8:	b9404844 	ldr	w4, [x2, #72]
   8f8ac:	350000c4 	cbnz	w4, 8f8c4 <__libc_free@@GLIBC_2.17+0x54>
   8f8b0:	f9400845 	ldr	x5, [x2, #16]
   8f8b4:	d2a04004 	mov	x4, #0x2000000             	// #33554432
   8f8b8:	eb05001f 	cmp	x0, x5
   8f8bc:	fa448002 	ccmp	x0, x4, #0x2, hi	// hi = pmore
   8f8c0:	54000409 	b.ls	8f940 <__libc_free@@GLIBC_2.17+0xd0>  // b.plast
   8f8c4:	aa0103e0 	mov	x0, x1
   8f8c8:	97ffefe6 	bl	8b860 <timer_settime@@GLIBC_2.34+0x6c0>
   8f8cc:	b8346a75 	str	w21, [x19, x20]
   8f8d0:	a94153f3 	ldp	x19, x20, [sp, #16]
   8f8d4:	f94013f5 	ldr	x21, [sp, #32]
   8f8d8:	a8c47bfd 	ldp	x29, x30, [sp], #64
   8f8dc:	d65f03c0 	ret
   8f8e0:	90000882 	adrp	x2, 19f000 <h_errlist@@GLIBC_2.17+0x5b8>
   8f8e4:	f946c442 	ldr	x2, [x2, #3464]
   8f8e8:	8b020262 	add	x2, x19, x2
   8f8ec:	f9400443 	ldr	x3, [x2, #8]
   8f8f0:	b4000363 	cbz	x3, 8f95c <__libc_free@@GLIBC_2.17+0xec>
   8f8f4:	36100200 	tbz	w0, #2, 8f934 <__libc_free@@GLIBC_2.17+0xc4>
   8f8f8:	b0000880 	adrp	x0, 1a0000 <_IO_wfile_jumps@@GLIBC_2.17+0xbf0>
   8f8fc:	b26697e2 	mov	x2, #0xfffffffffc000000    	// #-67108864
   8f900:	f940a000 	ldr	x0, [x0, #320]
   8f904:	f100001f 	cmp	x0, #0x0
   8f908:	cb000be0 	neg	x0, x0, lsl #2
   8f90c:	9a821000 	csel	x0, x0, x2, ne	// ne = any
   8f910:	8a000020 	and	x0, x1, x0
   8f914:	f9400000 	ldr	x0, [x0]
   8f918:	52800002 	mov	w2, #0x0                   	// #0
   8f91c:	97fff6ce 	bl	8d454 <__default_morecore@GLIBC_2.17+0x624>
   8f920:	b8346a75 	str	w21, [x19, x20]
   8f924:	a94153f3 	ldp	x19, x20, [sp, #16]
   8f928:	f94013f5 	ldr	x21, [sp, #32]
   8f92c:	a8c47bfd 	ldp	x29, x30, [sp], #64
   8f930:	d65f03c0 	ret
   8f934:	b0000880 	adrp	x0, 1a0000 <_IO_wfile_jumps@@GLIBC_2.17+0xbf0>
   8f938:	91294000 	add	x0, x0, #0xa50
   8f93c:	17fffff7 	b	8f918 <__libc_free@@GLIBC_2.17+0xa8>
   8f940:	927df000 	and	x0, x0, #0xfffffffffffffff8
   8f944:	f9000840 	str	x0, [x2, #16]
   8f948:	d37ff802 	lsl	x2, x0, #1
   8f94c:	f9008862 	str	x2, [x3, #272]
   8f950:	d503201f 	nop
   8f954:	17ffffdc 	b	8f8c4 <__libc_free@@GLIBC_2.17+0x54>
   8f958:	d65f03c0 	ret
   8f95c:	39404042 	ldrb	w2, [x2, #16]
   8f960:	3707fca2 	tbnz	w2, #0, 8f8f4 <__libc_free@@GLIBC_2.17+0x84>
   8f964:	f9001fe1 	str	x1, [sp, #56]
   8f968:	97fffcdb 	bl	8ecd4 <__default_morecore@GLIBC_2.17+0x1ea4>
   8f96c:	f9401fe1 	ldr	x1, [sp, #56]
   8f970:	f9400420 	ldr	x0, [x1, #8]
   8f974:	17ffffe0 	b	8f8f4 <__libc_free@@GLIBC_2.17+0x84>
