
/tmp/contains-portable-simd-20261105/sysroots/optimized/lib/rustlib/aarch64-unknown-linux-gnu/lib/libstd-7a2f7be1a1e543fc.so:	file format elf64-littleaarch64

Disassembly of section .text:

00000000000d70dc <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd>:
   d70dc: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
   d70e0: 910003fd     	mov	x29, sp
   d70e4: b4000a61     	cbz	x1, 0xd7230 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x154>
   d70e8: 39400008     	ldrb	w8, [x0]
   d70ec: 6b22011f     	cmp	w8, w2, uxtb
   d70f0: 54000081     	b.ne	0xd7100 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x24>
   d70f4: 52800020     	mov	w0, #0x1                // =1
   d70f8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
   d70fc: d65f03c0     	ret
   d7100: 4e010c40     	dup	v0.16b, w2
   d7104: f102003f     	cmp	x1, #0x80
   d7108: 540002c3     	b.lo	0xd7160 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x84>
   d710c: 9100fc08     	add	x8, x0, #0x3f
   d7110: 927ae508     	and	x8, x8, #0xffffffffffffffc0
   d7114: eb000109     	subs	x9, x8, x0
   d7118: 540001c0     	b.eq	0xd7150 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x74>
   d711c: ad408403     	ldp	q3, q1, [x0, #0x10]
   d7120: 3dc00002     	ldr	q2, [x0]
   d7124: 3dc00c04     	ldr	q4, [x0, #0x30]
   d7128: 6e208c42     	cmeq	v2.16b, v2.16b, v0.16b
   d712c: 6e208c21     	cmeq	v1.16b, v1.16b, v0.16b
   d7130: 6e208c63     	cmeq	v3.16b, v3.16b, v0.16b
   d7134: 6e208c84     	cmeq	v4.16b, v4.16b, v0.16b
   d7138: 4ea31c42     	orr	v2.16b, v2.16b, v3.16b
   d713c: 4ea41c21     	orr	v1.16b, v1.16b, v4.16b
   d7140: 4ea11c41     	orr	v1.16b, v2.16b, v1.16b
   d7144: 5ef1b821     	addp	d1, v1.2d
   d7148: 9e660028     	fmov	x8, d1
   d714c: b5fffd48     	cbnz	x8, 0xd70f4 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x18>
   d7150: cb090028     	sub	x8, x1, x9
   d7154: f27ae11f     	tst	x8, #0x7fffffffffffffc0
   d7158: 540000c1     	b.ne	0xd7170 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x94>
   d715c: 14000018     	b	0xd71bc <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0xe0>
   d7160: aa1f03e9     	mov	x9, xzr
   d7164: cb1f0028     	sub	x8, x1, xzr
   d7168: f27ae11f     	tst	x8, #0x7fffffffffffffc0
   d716c: 54000280     	b.eq	0xd71bc <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0xe0>
   d7170: 927ae10a     	and	x10, x8, #0x7fffffffffffffc0
   d7174: 8b090009     	add	x9, x0, x9
   d7178: cb0a03ea     	neg	x10, x10
   d717c: ad408523     	ldp	q3, q1, [x9, #0x10]
   d7180: 3dc00122     	ldr	q2, [x9]
   d7184: 3dc00d24     	ldr	q4, [x9, #0x30]
   d7188: 6e208c42     	cmeq	v2.16b, v2.16b, v0.16b
   d718c: 6e208c21     	cmeq	v1.16b, v1.16b, v0.16b
   d7190: 6e208c63     	cmeq	v3.16b, v3.16b, v0.16b
   d7194: 6e208c84     	cmeq	v4.16b, v4.16b, v0.16b
   d7198: 4ea31c42     	orr	v2.16b, v2.16b, v3.16b
   d719c: 4ea41c21     	orr	v1.16b, v1.16b, v4.16b
   d71a0: 4ea11c41     	orr	v1.16b, v2.16b, v1.16b
   d71a4: 5ef1b821     	addp	d1, v1.2d
   d71a8: 9e66002b     	fmov	x11, d1
   d71ac: b5fffa4b     	cbnz	x11, 0xd70f4 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x18>
   d71b0: b101014a     	adds	x10, x10, #0x40
   d71b4: 91010129     	add	x9, x9, #0x40
   d71b8: 54fffe21     	b.ne	0xd717c <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0xa0>
   d71bc: 92401508     	and	x8, x8, #0x3f
   d71c0: b4000288     	cbz	x8, 0xd7210 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x134>
   d71c4: f1010028     	subs	x8, x1, #0x40
   d71c8: 540002a3     	b.lo	0xd721c <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x140>
   d71cc: 8b080008     	add	x8, x0, x8
   d71d0: ad408503     	ldp	q3, q1, [x8, #0x10]
   d71d4: 3dc00102     	ldr	q2, [x8]
   d71d8: 3dc00d04     	ldr	q4, [x8, #0x30]
   d71dc: 6e208c42     	cmeq	v2.16b, v2.16b, v0.16b
   d71e0: 6e208c21     	cmeq	v1.16b, v1.16b, v0.16b
   d71e4: 6e208c63     	cmeq	v3.16b, v3.16b, v0.16b
   d71e8: 6e208c80     	cmeq	v0.16b, v4.16b, v0.16b
   d71ec: 4ea31c42     	orr	v2.16b, v2.16b, v3.16b
   d71f0: 4ea01c20     	orr	v0.16b, v1.16b, v0.16b
   d71f4: 4ea01c40     	orr	v0.16b, v2.16b, v0.16b
   d71f8: 5ef1b800     	addp	d0, v0.2d
   d71fc: 9e660008     	fmov	x8, d0
   d7200: f100011f     	cmp	x8, #0x0
   d7204: 1a9f07e0     	cset	w0, ne
   d7208: a8c17bfd     	ldp	x29, x30, [sp], #0x10
   d720c: d65f03c0     	ret
   d7210: 2a1f03e0     	mov	w0, wzr
   d7214: a8c17bfd     	ldp	x29, x30, [sp], #0x10
   d7218: d65f03c0     	ret
   d721c: d0000323     	adrp	x3, 0x13d000 <_RNvNtCs68fcPop4ROg_3std9panicking11EMPTY_PANIC+0x4c60>
   d7220: 91388063     	add	x3, x3, #0xe20
   d7224: aa0803e0     	mov	x0, x8
   d7228: aa0103e2     	mov	x2, x1
   d722c: 97fdb7f9     	bl	0x45210 <_RNvNtNtCshp6Wxz1DwXO_4core5slice5index16slice_index_fail@plt>
   d7230: d0000322     	adrp	x2, 0x13d000 <_RNvNtCs68fcPop4ROg_3std9panicking11EMPTY_PANIC+0x4c60>
   d7234: 91382042     	add	x2, x2, #0xe08
   d7238: aa1f03e0     	mov	x0, xzr
   d723c: 97fdb7b1     	bl	0x45100 <_RNvNtCshp6Wxz1DwXO_4core9panicking18panic_bounds_check@plt>
