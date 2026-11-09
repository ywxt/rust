
/tmp/contains-portable-simd64-20261105/sysroots/optimized/lib/rustlib/aarch64-unknown-linux-gnu/lib/libstd-7a2f7be1a1e543fc.so:	file format elf64-littleaarch64

Disassembly of section .text:

00000000000d70dc <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd>:
   d70dc: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
   d70e0: 910003fd     	mov	x29, sp
   d70e4: b4000f21     	cbz	x1, 0xd72c8 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x1ec>
   d70e8: 39400008     	ldrb	w8, [x0]
   d70ec: 6b22011f     	cmp	w8, w2, uxtb
   d70f0: 54000081     	b.ne	0xd7100 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x24>
   d70f4: 52800020     	mov	w0, #0x1                // =1
   d70f8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
   d70fc: d65f03c0     	ret
   d7100: 4e010c40     	dup	v0.16b, w2
   d7104: f102003f     	cmp	x1, #0x80
   d7108: 54000543     	b.lo	0xd71b0 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0xd4>
   d710c: 9100fc08     	add	x8, x0, #0x3f
   d7110: 927ae508     	and	x8, x8, #0xffffffffffffffc0
   d7114: eb000109     	subs	x9, x8, x0
   d7118: 54000440     	b.eq	0xd71a0 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0xc4>
   d711c: ad410402     	ldp	q2, q1, [x0, #0x20]
   d7120: 900000a8     	adrp	x8, 0xeb000 <__aarch64_swp1_relax+0x14>
   d7124: ad400c04     	ldp	q4, q3, [x0]
   d7128: 3dc26505     	ldr	q5, [x8, #0x990]
   d712c: 6e208c42     	cmeq	v2.16b, v2.16b, v0.16b
   d7130: 6e208c21     	cmeq	v1.16b, v1.16b, v0.16b
   d7134: 6e208c84     	cmeq	v4.16b, v4.16b, v0.16b
   d7138: 6e208c63     	cmeq	v3.16b, v3.16b, v0.16b
   d713c: 4e251c42     	and	v2.16b, v2.16b, v5.16b
   d7140: 4e251c21     	and	v1.16b, v1.16b, v5.16b
   d7144: 4e251c84     	and	v4.16b, v4.16b, v5.16b
   d7148: 4e251c63     	and	v3.16b, v3.16b, v5.16b
   d714c: 4e22bc42     	addp	v2.16b, v2.16b, v2.16b
   d7150: 4e21bc21     	addp	v1.16b, v1.16b, v1.16b
   d7154: 4e24bc84     	addp	v4.16b, v4.16b, v4.16b
   d7158: 4e23bc63     	addp	v3.16b, v3.16b, v3.16b
   d715c: 4e22bc42     	addp	v2.16b, v2.16b, v2.16b
   d7160: 4e21bc21     	addp	v1.16b, v1.16b, v1.16b
   d7164: 4e24bc84     	addp	v4.16b, v4.16b, v4.16b
   d7168: 4e23bc63     	addp	v3.16b, v3.16b, v3.16b
   d716c: 4e22bc42     	addp	v2.16b, v2.16b, v2.16b
   d7170: 4e21bc21     	addp	v1.16b, v1.16b, v1.16b
   d7174: 4e24bc84     	addp	v4.16b, v4.16b, v4.16b
   d7178: 4e23bc63     	addp	v3.16b, v3.16b, v3.16b
   d717c: 0e023c48     	umov	w8, v2.h[0]
   d7180: 0e023c2b     	umov	w11, v1.h[0]
   d7184: 0e023c8a     	umov	w10, v4.h[0]
   d7188: 0e023c6c     	umov	w12, v3.h[0]
   d718c: 2a080148     	orr	w8, w10, w8
   d7190: 2a0b018a     	orr	w10, w12, w11
   d7194: 2a0a0108     	orr	w8, w8, w10
   d7198: 72003d1f     	tst	w8, #0xffff
   d719c: 54fffac1     	b.ne	0xd70f4 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x18>
   d71a0: cb090028     	sub	x8, x1, x9
   d71a4: f27ae11f     	tst	x8, #0x7fffffffffffffc0
   d71a8: 540000c1     	b.ne	0xd71c0 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0xe4>
   d71ac: 1400002c     	b	0xd725c <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x180>
   d71b0: aa1f03e9     	mov	x9, xzr
   d71b4: cb1f0028     	sub	x8, x1, xzr
   d71b8: f27ae11f     	tst	x8, #0x7fffffffffffffc0
   d71bc: 54000500     	b.eq	0xd725c <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x180>
   d71c0: 900000aa     	adrp	x10, 0xeb000 <__aarch64_swp1_relax+0x14>
   d71c4: 927ae10b     	and	x11, x8, #0x7fffffffffffffc0
   d71c8: 8b090009     	add	x9, x0, x9
   d71cc: 3dc26541     	ldr	q1, [x10, #0x990]
   d71d0: cb0b03ea     	neg	x10, x11
   d71d4: ad400d22     	ldp	q2, q3, [x9]
   d71d8: ad411125     	ldp	q5, q4, [x9, #0x20]
   d71dc: 6e208c42     	cmeq	v2.16b, v2.16b, v0.16b
   d71e0: 6e208c63     	cmeq	v3.16b, v3.16b, v0.16b
   d71e4: 6e208ca5     	cmeq	v5.16b, v5.16b, v0.16b
   d71e8: 6e208c84     	cmeq	v4.16b, v4.16b, v0.16b
   d71ec: 4e211c42     	and	v2.16b, v2.16b, v1.16b
   d71f0: 4e211c63     	and	v3.16b, v3.16b, v1.16b
   d71f4: 4e211ca5     	and	v5.16b, v5.16b, v1.16b
   d71f8: 4e211c84     	and	v4.16b, v4.16b, v1.16b
   d71fc: 4e22bc42     	addp	v2.16b, v2.16b, v2.16b
   d7200: 4e23bc63     	addp	v3.16b, v3.16b, v3.16b
   d7204: 4e25bca5     	addp	v5.16b, v5.16b, v5.16b
   d7208: 4e24bc84     	addp	v4.16b, v4.16b, v4.16b
   d720c: 4e22bc42     	addp	v2.16b, v2.16b, v2.16b
   d7210: 4e23bc63     	addp	v3.16b, v3.16b, v3.16b
   d7214: 4e25bca5     	addp	v5.16b, v5.16b, v5.16b
   d7218: 4e24bc84     	addp	v4.16b, v4.16b, v4.16b
   d721c: 4e22bc42     	addp	v2.16b, v2.16b, v2.16b
   d7220: 4e23bc63     	addp	v3.16b, v3.16b, v3.16b
   d7224: 4e25bca5     	addp	v5.16b, v5.16b, v5.16b
   d7228: 4e24bc84     	addp	v4.16b, v4.16b, v4.16b
   d722c: 0e023c4b     	umov	w11, v2.h[0]
   d7230: 0e023c6d     	umov	w13, v3.h[0]
   d7234: 0e023cac     	umov	w12, v5.h[0]
   d7238: 0e023c8e     	umov	w14, v4.h[0]
   d723c: 2a0c016b     	orr	w11, w11, w12
   d7240: 2a0e01ac     	orr	w12, w13, w14
   d7244: 2a0c016b     	orr	w11, w11, w12
   d7248: 72003d7f     	tst	w11, #0xffff
   d724c: 54fff541     	b.ne	0xd70f4 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x18>
   d7250: b101014a     	adds	x10, x10, #0x40
   d7254: 91010129     	add	x9, x9, #0x40
   d7258: 54fffbe1     	b.ne	0xd71d4 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0xf8>
   d725c: 92401508     	and	x8, x8, #0x3f
   d7260: b4000248     	cbz	x8, 0xd72a8 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x1cc>
   d7264: f1010028     	subs	x8, x1, #0x40
   d7268: 54000263     	b.lo	0xd72b4 <_RNvNtNtCshp6Wxz1DwXO_4core3str7pattern18contains_byte_simd+0x1d8>
   d726c: 8b080008     	add	x8, x0, x8
   d7270: ad400502     	ldp	q2, q1, [x8]
   d7274: ad411103     	ldp	q3, q4, [x8, #0x20]
   d7278: 6e208c21     	cmeq	v1.16b, v1.16b, v0.16b
   d727c: 6e208c84     	cmeq	v4.16b, v4.16b, v0.16b
   d7280: 6e208c63     	cmeq	v3.16b, v3.16b, v0.16b
   d7284: 6e208c40     	cmeq	v0.16b, v2.16b, v0.16b
   d7288: 4ea31c00     	orr	v0.16b, v0.16b, v3.16b
   d728c: 4ea41c21     	orr	v1.16b, v1.16b, v4.16b
   d7290: 4ea11c00     	orr	v0.16b, v0.16b, v1.16b
   d7294: 6e30a800     	umaxv	b0, v0.16b
   d7298: 1e260008     	fmov	w8, s0
   d729c: 12000100     	and	w0, w8, #0x1
   d72a0: a8c17bfd     	ldp	x29, x30, [sp], #0x10
   d72a4: d65f03c0     	ret
   d72a8: 2a1f03e0     	mov	w0, wzr
   d72ac: a8c17bfd     	ldp	x29, x30, [sp], #0x10
   d72b0: d65f03c0     	ret
   d72b4: d0000323     	adrp	x3, 0x13d000 <_RNvNtCs68fcPop4ROg_3std9panicking11EMPTY_PANIC+0x4c60>
   d72b8: 91388063     	add	x3, x3, #0xe20
   d72bc: aa0803e0     	mov	x0, x8
   d72c0: aa0103e2     	mov	x2, x1
   d72c4: 97fdb7d3     	bl	0x45210 <_RNvNtNtCshp6Wxz1DwXO_4core5slice5index16slice_index_fail@plt>
   d72c8: d0000322     	adrp	x2, 0x13d000 <_RNvNtCs68fcPop4ROg_3std9panicking11EMPTY_PANIC+0x4c60>
   d72cc: 91382042     	add	x2, x2, #0xe08
   d72d0: aa1f03e0     	mov	x0, xzr
   d72d4: 97fdb78b     	bl	0x45100 <_RNvNtCshp6Wxz1DwXO_4core9panicking18panic_bounds_check@plt>
