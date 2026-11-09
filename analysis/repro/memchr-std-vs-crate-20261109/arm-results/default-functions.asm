
/tmp/memchr-std-crate-20261109/aarch64-unknown-linux-gnu/driver-default:     file format elf64-littleaarch64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

00000000000017b8 <_RNvCs1StpruGFt5h_6driver10crate_find>:
    17b8:	b4000142 	cbz	x2, 17e0 <_RNvCs1StpruGFt5h_6driver10crate_find+0x28>
    17bc:	f1003c5f 	cmp	x2, #0xf
    17c0:	54000148 	b.hi	17e8 <_RNvCs1StpruGFt5h_6driver10crate_find+0x30>  // b.pmore
    17c4:	aa0103e8 	mov	x8, x1
    17c8:	39400109 	ldrb	w9, [x8]
    17cc:	6b20013f 	cmp	w9, w0, uxtb
    17d0:	54000200 	b.eq	1810 <_RNvCs1StpruGFt5h_6driver10crate_find+0x58>  // b.none
    17d4:	f1000442 	subs	x2, x2, #0x1
    17d8:	91000508 	add	x8, x8, #0x1
    17dc:	54ffff61 	b.ne	17c8 <_RNvCs1StpruGFt5h_6driver10crate_find+0x10>  // b.any
    17e0:	aa1f03e0 	mov	x0, xzr
    17e4:	d65f03c0 	ret
    17e8:	4e010c00 	dup	v0.16b, w0
    17ec:	3dc00021 	ldr	q1, [x1]
    17f0:	6e218c01 	cmeq	v1.16b, v0.16b, v1.16b
    17f4:	0f0c8421 	shrn	v1.8b, v1.8h, #4
    17f8:	9e660028 	fmov	x8, d1
    17fc:	f201e108 	ands	x8, x8, #0x8888888888888888
    1800:	540000e0 	b.eq	181c <_RNvCs1StpruGFt5h_6driver10crate_find+0x64>  // b.none
    1804:	dac00108 	rbit	x8, x8
    1808:	dac01108 	clz	x8, x8
    180c:	8b480828 	add	x8, x1, x8, lsr #2
    1810:	cb010101 	sub	x1, x8, x1
    1814:	52800020 	mov	w0, #0x1                   	// #1
    1818:	d65f03c0 	ret
    181c:	92400c29 	and	x9, x1, #0xf
    1820:	52800208 	mov	w8, #0x10                  	// #16
    1824:	cb09010a 	sub	x10, x8, x9
    1828:	d1010048 	sub	x8, x2, #0x40
    182c:	eb08015f 	cmp	x10, x8
    1830:	528007e8 	mov	w8, #0x3f                  	// #63
    1834:	fa489040 	ccmp	x2, x8, #0x0, ls	// ls = plast
    1838:	8b020028 	add	x8, x1, x2
    183c:	54000369 	b.ls	18a8 <_RNvCs1StpruGFt5h_6driver10crate_find+0xf0>  // b.plast
    1840:	cb090029 	sub	x9, x1, x9
    1844:	d101010a 	sub	x10, x8, #0x40
    1848:	91008129 	add	x9, x9, #0x20
    184c:	aa0903eb 	mov	x11, x9
    1850:	ad401522 	ldp	q2, q5, [x9]
    1854:	3cdf0d61 	ldr	q1, [x11, #-16]!
    1858:	3dc00926 	ldr	q6, [x9, #32]
    185c:	6e218c04 	cmeq	v4.16b, v0.16b, v1.16b
    1860:	6e228c03 	cmeq	v3.16b, v0.16b, v2.16b
    1864:	6e258c02 	cmeq	v2.16b, v0.16b, v5.16b
    1868:	6e268c01 	cmeq	v1.16b, v0.16b, v6.16b
    186c:	4ea41c65 	orr	v5.16b, v3.16b, v4.16b
    1870:	4ea11c46 	orr	v6.16b, v2.16b, v1.16b
    1874:	4ea61ca5 	orr	v5.16b, v5.16b, v6.16b
    1878:	6e25a4a5 	umaxp	v5.16b, v5.16b, v5.16b
    187c:	9e6600ac 	fmov	x12, d5
    1880:	b50004ac 	cbnz	x12, 1914 <_RNvCs1StpruGFt5h_6driver10crate_find+0x15c>
    1884:	9101016b 	add	x11, x11, #0x40
    1888:	91010129 	add	x9, x9, #0x40
    188c:	eb0a017f 	cmp	x11, x10
    1890:	54fffde9 	b.ls	184c <_RNvCs1StpruGFt5h_6driver10crate_find+0x94>  // b.plast
    1894:	d1004129 	sub	x9, x9, #0x10
    1898:	d100410a 	sub	x10, x8, #0x10
    189c:	eb0a013f 	cmp	x9, x10
    18a0:	540000c9 	b.ls	18b8 <_RNvCs1StpruGFt5h_6driver10crate_find+0x100>  // b.plast
    18a4:	1400000e 	b	18dc <_RNvCs1StpruGFt5h_6driver10crate_find+0x124>
    18a8:	8b0a0029 	add	x9, x1, x10
    18ac:	d100410a 	sub	x10, x8, #0x10
    18b0:	eb0a013f 	cmp	x9, x10
    18b4:	54000148 	b.hi	18dc <_RNvCs1StpruGFt5h_6driver10crate_find+0x124>  // b.pmore
    18b8:	3dc00121 	ldr	q1, [x9]
    18bc:	6e218c01 	cmeq	v1.16b, v0.16b, v1.16b
    18c0:	0f0c8421 	shrn	v1.8b, v1.8h, #4
    18c4:	9e66002b 	fmov	x11, d1
    18c8:	f201e16b 	ands	x11, x11, #0x8888888888888888
    18cc:	540003a1 	b.ne	1940 <_RNvCs1StpruGFt5h_6driver10crate_find+0x188>  // b.any
    18d0:	91004129 	add	x9, x9, #0x10
    18d4:	eb0a013f 	cmp	x9, x10
    18d8:	54ffff09 	b.ls	18b8 <_RNvCs1StpruGFt5h_6driver10crate_find+0x100>  // b.plast
    18dc:	eb08013f 	cmp	x9, x8
    18e0:	54fff802 	b.cs	17e0 <_RNvCs1StpruGFt5h_6driver10crate_find+0x28>  // b.hs, b.nlast
    18e4:	3cdf0d01 	ldr	q1, [x8, #-16]!
    18e8:	6e218c00 	cmeq	v0.16b, v0.16b, v1.16b
    18ec:	0f0c8400 	shrn	v0.8b, v0.8h, #4
    18f0:	9e660009 	fmov	x9, d0
    18f4:	f201e129 	ands	x9, x9, #0x8888888888888888
    18f8:	54fff740 	b.eq	17e0 <_RNvCs1StpruGFt5h_6driver10crate_find+0x28>  // b.none
    18fc:	dac00129 	rbit	x9, x9
    1900:	dac01129 	clz	x9, x9
    1904:	8b490908 	add	x8, x8, x9, lsr #2
    1908:	cb010101 	sub	x1, x8, x1
    190c:	52800020 	mov	w0, #0x1                   	// #1
    1910:	d65f03c0 	ret
    1914:	0f0c8480 	shrn	v0.8b, v4.8h, #4
    1918:	9e660008 	fmov	x8, d0
    191c:	f201e108 	ands	x8, x8, #0x8888888888888888
    1920:	540001c0 	b.eq	1958 <_RNvCs1StpruGFt5h_6driver10crate_find+0x1a0>  // b.none
    1924:	dac00108 	rbit	x8, x8
    1928:	dac01108 	clz	x8, x8
    192c:	8b480928 	add	x8, x9, x8, lsr #2
    1930:	d1004108 	sub	x8, x8, #0x10
    1934:	cb010101 	sub	x1, x8, x1
    1938:	52800020 	mov	w0, #0x1                   	// #1
    193c:	d65f03c0 	ret
    1940:	dac00168 	rbit	x8, x11
    1944:	dac01108 	clz	x8, x8
    1948:	8b480928 	add	x8, x9, x8, lsr #2
    194c:	cb010101 	sub	x1, x8, x1
    1950:	52800020 	mov	w0, #0x1                   	// #1
    1954:	d65f03c0 	ret
    1958:	0f0c8460 	shrn	v0.8b, v3.8h, #4
    195c:	9e660008 	fmov	x8, d0
    1960:	f201e108 	ands	x8, x8, #0x8888888888888888
    1964:	540000e0 	b.eq	1980 <_RNvCs1StpruGFt5h_6driver10crate_find+0x1c8>  // b.none
    1968:	dac00108 	rbit	x8, x8
    196c:	dac01108 	clz	x8, x8
    1970:	8b480928 	add	x8, x9, x8, lsr #2
    1974:	cb010101 	sub	x1, x8, x1
    1978:	52800020 	mov	w0, #0x1                   	// #1
    197c:	d65f03c0 	ret
    1980:	0f0c8440 	shrn	v0.8b, v2.8h, #4
    1984:	9e660008 	fmov	x8, d0
    1988:	f201e108 	ands	x8, x8, #0x8888888888888888
    198c:	54000100 	b.eq	19ac <_RNvCs1StpruGFt5h_6driver10crate_find+0x1f4>  // b.none
    1990:	dac00108 	rbit	x8, x8
    1994:	dac01108 	clz	x8, x8
    1998:	8b480928 	add	x8, x9, x8, lsr #2
    199c:	91004108 	add	x8, x8, #0x10
    19a0:	cb010101 	sub	x1, x8, x1
    19a4:	52800020 	mov	w0, #0x1                   	// #1
    19a8:	d65f03c0 	ret
    19ac:	0f0c8420 	shrn	v0.8b, v1.8h, #4
    19b0:	9e660008 	fmov	x8, d0
    19b4:	9201e108 	and	x8, x8, #0x8888888888888888
    19b8:	dac00108 	rbit	x8, x8
    19bc:	dac01108 	clz	x8, x8
    19c0:	8b480928 	add	x8, x9, x8, lsr #2
    19c4:	91008108 	add	x8, x8, #0x20
    19c8:	cb010101 	sub	x1, x8, x1
    19cc:	52800020 	mov	w0, #0x1                   	// #1
    19d0:	d65f03c0 	ret

Disassembly of section .fini:

/tmp/memchr-std-crate-20261109/aarch64-unknown-linux-gnu/driver-default:     file format elf64-littleaarch64


Disassembly of section .init:

Disassembly of section .plt:

Disassembly of section .text:

0000000000002dc0 <_RNvCs1StpruGFt5h_6driver8std_find>:
    2dc0:	aa0103e8 	mov	x8, x1
    2dc4:	f1003c5f 	cmp	x2, #0xf
    2dc8:	2a0003e9 	mov	w9, w0
    2dcc:	540001a8 	b.hi	2e00 <_RNvCs1StpruGFt5h_6driver8std_find+0x40>  // b.pmore
    2dd0:	b4000262 	cbz	x2, 2e1c <_RNvCs1StpruGFt5h_6driver8std_find+0x5c>
    2dd4:	aa1f03ea 	mov	x10, xzr
    2dd8:	52800020 	mov	w0, #0x1                   	// #1
    2ddc:	aa0a03e1 	mov	x1, x10
    2de0:	386a690a 	ldrb	w10, [x8, x10]
    2de4:	6b29015f 	cmp	w10, w9, uxtb
    2de8:	54000180 	b.eq	2e18 <_RNvCs1StpruGFt5h_6driver8std_find+0x58>  // b.none
    2dec:	9100042a 	add	x10, x1, #0x1
    2df0:	eb0a005f 	cmp	x2, x10
    2df4:	54ffff41 	b.ne	2ddc <_RNvCs1StpruGFt5h_6driver8std_find+0x1c>  // b.any
    2df8:	aa1f03e0 	mov	x0, xzr
    2dfc:	d65f03c0 	ret
    2e00:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    2e04:	910003fd 	mov	x29, sp
    2e08:	2a0903e0 	mov	w0, w9
    2e0c:	aa0803e1 	mov	x1, x8
    2e10:	97fff94c 	bl	1340 <_RNvNtNtCshp6Wxz1DwXO_4core5slice6memchr14memchr_aligned@plt>
    2e14:	a8c17bfd 	ldp	x29, x30, [sp], #16
    2e18:	d65f03c0 	ret
    2e1c:	aa1f03e0 	mov	x0, xzr
    2e20:	d65f03c0 	ret

Disassembly of section .fini:
