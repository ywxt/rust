
/tmp/str-debug-some-unicode-20261105/probe:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000039748 <_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data2cf11lookup_slow>:
   39748: 528217a8     	mov	w8, #0x10bd             // =4285
   3974c: 9000004a     	adrp	x10, 0x41000 <_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data2cf7OFFSETS+0x150>
   39750: 9117b14a     	add	x10, x10, #0x5ec
   39754: 72a00028     	movk	w8, #0x1, lsl #16
   39758: 6b08001f     	cmp	w0, w8
   3975c: 528000a8     	mov	w8, #0x5                // =5
   39760: 9a8833e8     	csel	x8, xzr, x8, lo
   39764: 91000d09     	add	x9, x8, #0x3
   39768: b869794b     	ldr	w11, [x10, x9, lsl #2]
   3976c: 1200516b     	and	w11, w11, #0x1fffff
   39770: 6b0b001f     	cmp	w0, w11
   39774: 9a893108     	csel	x8, x8, x9, lo
   39778: 91000509     	add	x9, x8, #0x1
   3977c: b8697949     	ldr	w9, [x10, x9, lsl #2]
   39780: 12005129     	and	w9, w9, #0x1fffff
   39784: 6b09001f     	cmp	w0, w9
   39788: 9a883508     	cinc	x8, x8, hs
   3978c: 91000509     	add	x9, x8, #0x1
   39790: b8697949     	ldr	w9, [x10, x9, lsl #2]
   39794: 12005129     	and	w9, w9, #0x1fffff
   39798: 6b09001f     	cmp	w0, w9
   3979c: 9a883508     	cinc	x8, x8, hs
   397a0: b8687949     	ldr	w9, [x10, x8, lsl #2]
   397a4: 53155129     	lsl	w9, w9, #11
   397a8: 6b002d3f     	cmp	w9, w0, lsl #11
   397ac: 1a9f17e9     	cset	w9, eq
   397b0: 9a892529     	cinc	x9, x9, lo
   397b4: 8b08012b     	add	x11, x9, x8
   397b8: 8b0b094a     	add	x10, x10, x11, lsl #2
   397bc: f100257f     	cmp	x11, #0x9
   397c0: b9400148     	ldr	w8, [x10]
   397c4: d355fd08     	lsr	x8, x8, #21
   397c8: 54000108     	b.hi	0x397e8 <_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data2cf11lookup_slow+0xa0>
   397cc: b9400549     	ldr	w9, [x10, #0x4]
   397d0: d355fd29     	lsr	x9, x9, #21
   397d4: b50000cb     	cbnz	x11, 0x397ec <_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data2cf11lookup_slow+0xa4>
   397d8: aa2803ea     	mvn	x10, x8
   397dc: ab0a013f     	cmn	x9, x10
   397e0: 54000101     	b.ne	0x39800 <_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data2cf11lookup_slow+0xb8>
   397e4: 14000013     	b	0x39830 <_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data2cf11lookup_slow+0xe8>
   397e8: 52800569     	mov	w9, #0x2b               // =43
   397ec: b85fc14a     	ldur	w10, [x10, #-0x4]
   397f0: 1200514b     	and	w11, w10, #0x1fffff
   397f4: aa2803ea     	mvn	x10, x8
   397f8: ab0a013f     	cmn	x9, x10
   397fc: 540001a0     	b.eq	0x39830 <_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data2cf11lookup_slow+0xe8>
   39800: 2a1f03ea     	mov	w10, wzr
   39804: 4b0b000b     	sub	w11, w0, w11
   39808: d1000529     	sub	x9, x9, #0x1
   3980c: f000002c     	adrp	x12, 0x40000 <_RNvNtCs8lZo0byVeZr_12panic_unwind3imp6CANARY+0x1fa>
   39810: 913ac18c     	add	x12, x12, #0xeb0
   39814: 3868698d     	ldrb	w13, [x12, x8]
   39818: 0b0d014a     	add	w10, w10, w13
   3981c: 6b0b015f     	cmp	w10, w11
   39820: 54000088     	b.hi	0x39830 <_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data2cf11lookup_slow+0xe8>
   39824: 91000508     	add	x8, x8, #0x1
   39828: eb08013f     	cmp	x9, x8
   3982c: 54ffff41     	b.ne	0x39814 <_RNvNtNtNtCs5eKY5gNNvwM_4core7unicode12unicode_data2cf11lookup_slow+0xcc>
   39830: 12000100     	and	w0, w8, #0x1
   39834: d65f03c0     	ret
