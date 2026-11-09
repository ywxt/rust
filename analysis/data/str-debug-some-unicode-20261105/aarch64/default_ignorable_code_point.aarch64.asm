
/tmp/str-debug-some-unicode-20261105/probe:	file format elf64-littleaarch64

Disassembly of section .text:

000000000003965c <_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data28default_ignorable_code_point11lookup_slow>:
   3965c: 53097c09     	lsr	w9, w0, #9
   39660: 528000c8     	mov	w8, #0x6                // =6
   39664: 9000004a     	adrp	x10, 0x41000 <_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data2cf7OFFSETS+0x150>
   39668: 9116f14a     	add	x10, x10, #0x5bc
   3966c: 7101fd3f     	cmp	w9, #0x7f
   39670: 9a8833e8     	csel	x8, xzr, x8, lo
   39674: 91000d09     	add	x9, x8, #0x3
   39678: b869794b     	ldr	w11, [x10, x9, lsl #2]
   3967c: 1200516b     	and	w11, w11, #0x1fffff
   39680: 6b0b001f     	cmp	w0, w11
   39684: 9a893108     	csel	x8, x8, x9, lo
   39688: 91000509     	add	x9, x8, #0x1
   3968c: b8697949     	ldr	w9, [x10, x9, lsl #2]
   39690: 12005129     	and	w9, w9, #0x1fffff
   39694: 6b09001f     	cmp	w0, w9
   39698: 9a883508     	cinc	x8, x8, hs
   3969c: 91000509     	add	x9, x8, #0x1
   396a0: b8697949     	ldr	w9, [x10, x9, lsl #2]
   396a4: 12005129     	and	w9, w9, #0x1fffff
   396a8: 6b09001f     	cmp	w0, w9
   396ac: 9a883508     	cinc	x8, x8, hs
   396b0: b8687949     	ldr	w9, [x10, x8, lsl #2]
   396b4: 53155129     	lsl	w9, w9, #11
   396b8: 6b002d3f     	cmp	w9, w0, lsl #11
   396bc: 1a9f17e9     	cset	w9, eq
   396c0: 9a892529     	cinc	x9, x9, lo
   396c4: 8b08012b     	add	x11, x9, x8
   396c8: 8b0b094a     	add	x10, x10, x11, lsl #2
   396cc: f100297f     	cmp	x11, #0xa
   396d0: b9400148     	ldr	w8, [x10]
   396d4: d355fd08     	lsr	x8, x8, #21
   396d8: 54000108     	b.hi	0x396f8 <_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data28default_ignorable_code_point11lookup_slow+0x9c>
   396dc: b9400549     	ldr	w9, [x10, #0x4]
   396e0: d355fd29     	lsr	x9, x9, #21
   396e4: b50000cb     	cbnz	x11, 0x396fc <_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data28default_ignorable_code_point11lookup_slow+0xa0>
   396e8: aa2803ea     	mvn	x10, x8
   396ec: ab0a013f     	cmn	x9, x10
   396f0: 54000101     	b.ne	0x39710 <_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data28default_ignorable_code_point11lookup_slow+0xb4>
   396f4: 14000013     	b	0x39740 <_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data28default_ignorable_code_point11lookup_slow+0xe4>
   396f8: 52800469     	mov	w9, #0x23               // =35
   396fc: b85fc14a     	ldur	w10, [x10, #-0x4]
   39700: 1200514b     	and	w11, w10, #0x1fffff
   39704: aa2803ea     	mvn	x10, x8
   39708: ab0a013f     	cmn	x9, x10
   3970c: 540001a0     	b.eq	0x39740 <_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data28default_ignorable_code_point11lookup_slow+0xe4>
   39710: 2a1f03ea     	mov	w10, wzr
   39714: 4b0b000b     	sub	w11, w0, w11
   39718: d1000529     	sub	x9, x9, #0x1
   3971c: f000002c     	adrp	x12, 0x40000 <_RNvNtCs8lZo0byVeZr_12panic_unwind3imp6CANARY+0x1fa>
   39720: 913a358c     	add	x12, x12, #0xe8d
   39724: 3868698d     	ldrb	w13, [x12, x8]
   39728: 0b0d014a     	add	w10, w10, w13
   3972c: 6b0b015f     	cmp	w10, w11
   39730: 54000088     	b.hi	0x39740 <_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data28default_ignorable_code_point11lookup_slow+0xe4>
   39734: 91000508     	add	x8, x8, #0x1
   39738: eb08013f     	cmp	x9, x8
   3973c: 54ffff41     	b.ne	0x39724 <_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data28default_ignorable_code_point11lookup_slow+0xc8>
   39740: 12000100     	and	w0, w8, #0x1
   39744: d65f03c0     	ret
