
/tmp/contains-portable-simd-20261105/sysroots/baseline/lib/rustlib/aarch64-unknown-linux-gnu/lib/libstd-7a2f7be1a1e543fc.so:	file format elf64-littleaarch64

Disassembly of section .text:

00000000000d70dc <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd>:
   d70dc: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
   d70e0: 910003fd     	mov	x29, sp
   d70e4: b4000a01     	cbz	x1, 0xd7224 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x148>
   d70e8: 39400008     	ldrb	w8, [x0]
   d70ec: 6b22011f     	cmp	w8, w2, uxtb
   d70f0: 54000081     	b.ne	0xd7100 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x24>
   d70f4: 52800020     	mov	w0, #0x1                // =1
   d70f8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
   d70fc: d65f03c0     	ret
   d7100: 4e010c40     	dup	v0.16b, w2
   d7104: f102003f     	cmp	x1, #0x80
   d7108: 540002a3     	b.lo	0xd715c <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x80>
   d710c: 9100fc08     	add	x8, x0, #0x3f
   d7110: 927ae508     	and	x8, x8, #0xffffffffffffffc0
   d7114: eb000109     	subs	x9, x8, x0
   d7118: 540001a0     	b.eq	0xd714c <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x70>
   d711c: ad400801     	ldp	q1, q2, [x0]
   d7120: ad411003     	ldp	q3, q4, [x0, #0x20]
   d7124: 6e208c21     	cmeq	v1.16b, v1.16b, v0.16b
   d7128: 6e208c42     	cmeq	v2.16b, v2.16b, v0.16b
   d712c: 6e208c63     	cmeq	v3.16b, v3.16b, v0.16b
   d7130: 6e208c84     	cmeq	v4.16b, v4.16b, v0.16b
   d7134: 4ea21c21     	orr	v1.16b, v1.16b, v2.16b
   d7138: 4ea41c62     	orr	v2.16b, v3.16b, v4.16b
   d713c: 4ea21c21     	orr	v1.16b, v1.16b, v2.16b
   d7140: 5ef1b821     	addp	d1, v1.2d
   d7144: 9e660028     	fmov	x8, d1
   d7148: b5fffd68     	cbnz	x8, 0xd70f4 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x18>
   d714c: cb090028     	sub	x8, x1, x9
   d7150: f27ae11f     	tst	x8, #0x7fffffffffffffc0
   d7154: 540000c1     	b.ne	0xd716c <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x90>
   d7158: 14000017     	b	0xd71b4 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0xd8>
   d715c: aa1f03e9     	mov	x9, xzr
   d7160: cb1f0028     	sub	x8, x1, xzr
   d7164: f27ae11f     	tst	x8, #0x7fffffffffffffc0
   d7168: 54000260     	b.eq	0xd71b4 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0xd8>
   d716c: 927ae10a     	and	x10, x8, #0x7fffffffffffffc0
   d7170: 8b090009     	add	x9, x0, x9
   d7174: cb0a03ea     	neg	x10, x10
   d7178: ad400921     	ldp	q1, q2, [x9]
   d717c: ad411123     	ldp	q3, q4, [x9, #0x20]
   d7180: 6e208c21     	cmeq	v1.16b, v1.16b, v0.16b
   d7184: 6e208c42     	cmeq	v2.16b, v2.16b, v0.16b
   d7188: 6e208c63     	cmeq	v3.16b, v3.16b, v0.16b
   d718c: 6e208c84     	cmeq	v4.16b, v4.16b, v0.16b
   d7190: 4ea21c21     	orr	v1.16b, v1.16b, v2.16b
   d7194: 4ea41c62     	orr	v2.16b, v3.16b, v4.16b
   d7198: 4ea21c21     	orr	v1.16b, v1.16b, v2.16b
   d719c: 5ef1b821     	addp	d1, v1.2d
   d71a0: 9e66002b     	fmov	x11, d1
   d71a4: b5fffa8b     	cbnz	x11, 0xd70f4 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x18>
   d71a8: b101014a     	adds	x10, x10, #0x40
   d71ac: 91010129     	add	x9, x9, #0x40
   d71b0: 54fffe41     	b.ne	0xd7178 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x9c>
   d71b4: 92401508     	and	x8, x8, #0x3f
   d71b8: b4000268     	cbz	x8, 0xd7204 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x128>
   d71bc: f1010028     	subs	x8, x1, #0x40
   d71c0: 54000283     	b.lo	0xd7210 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x134>
   d71c4: 8b080008     	add	x8, x0, x8
   d71c8: ad400901     	ldp	q1, q2, [x8]
   d71cc: ad411103     	ldp	q3, q4, [x8, #0x20]
   d71d0: 6e208c21     	cmeq	v1.16b, v1.16b, v0.16b
   d71d4: 6e208c42     	cmeq	v2.16b, v2.16b, v0.16b
   d71d8: 6e208c63     	cmeq	v3.16b, v3.16b, v0.16b
   d71dc: 6e208c80     	cmeq	v0.16b, v4.16b, v0.16b
   d71e0: 4ea21c21     	orr	v1.16b, v1.16b, v2.16b
   d71e4: 4ea01c60     	orr	v0.16b, v3.16b, v0.16b
   d71e8: 4ea01c20     	orr	v0.16b, v1.16b, v0.16b
   d71ec: 5ef1b800     	addp	d0, v0.2d
   d71f0: 9e660008     	fmov	x8, d0
   d71f4: f100011f     	cmp	x8, #0x0
   d71f8: 1a9f07e0     	cset	w0, ne
   d71fc: a8c17bfd     	ldp	x29, x30, [sp], #0x10
   d7200: d65f03c0     	ret
   d7204: 2a1f03e0     	mov	w0, wzr
   d7208: a8c17bfd     	ldp	x29, x30, [sp], #0x10
   d720c: d65f03c0     	ret
   d7210: d0000323     	adrp	x3, 0x13d000 <_RNvNtCs68fcPop4ROg_3std9panicking11EMPTY_PANIC+0x4c60>
   d7214: 91388063     	add	x3, x3, #0xe20
   d7218: aa0803e0     	mov	x0, x8
   d721c: aa0103e2     	mov	x2, x1
   d7220: 97fdb7fc     	bl	0x45210 <_RNvNtNtCshp6Wxz1DwXO_4core5slice5index16slice_index_fail@plt>
   d7224: d0000322     	adrp	x2, 0x13d000 <_RNvNtCs68fcPop4ROg_3std9panicking11EMPTY_PANIC+0x4c60>
   d7228: 91382042     	add	x2, x2, #0xe08
   d722c: aa1f03e0     	mov	x0, xzr
   d7230: 97fdb7b4     	bl	0x45100 <_RNvNtCshp6Wxz1DwXO_4core9panicking18panic_bounds_check@plt>
