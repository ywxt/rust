_RNvCsa0htB0rFyhf_13bang_probe_v36fold64:
	.cfi_startproc
	cmp	x1, #64
	mov	x8, x0
	b.hs	.LBB13_2
	mov	x0, x8
	b	_RNvCsa0htB0rFyhf_13bang_probe_v36fold16
.LBB13_2:
	tst	x1, #0xffffffffffffffc0
	b.eq	.LBB13_69
	and	x9, x1, #0xffffffffffffffc0
	mov	x10, x8
	mov	w0, #1
	neg	x9, x9
.LBB13_4:
	ldrb	w11, [x10]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #1]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #2]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #3]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #4]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #5]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #6]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #7]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #8]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #9]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #10]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #11]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #12]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #13]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #14]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #15]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #16]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #17]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #18]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #19]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #20]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #21]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #22]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #23]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #24]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #25]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #26]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #27]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #28]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #29]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #30]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #31]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #32]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #33]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #34]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #35]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #36]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #37]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #38]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #39]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #40]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #41]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #42]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #43]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #44]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #45]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #46]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #47]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #48]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #49]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #50]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #51]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #52]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #53]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #54]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #55]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #56]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #57]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #58]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #59]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #60]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #61]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #62]
	cmp	w11, #33
	b.eq	.LBB13_71
	ldrb	w11, [x10, #63]
	cmp	w11, #33
	b.eq	.LBB13_71
	adds	x9, x9, #64
	add	x10, x10, #64
	b.ne	.LBB13_4
.LBB13_69:
	and	x9, x1, #0x3f
	cbz	x9, .LBB13_72
	add	x8, x8, x1
	ldurb	w9, [x8, #-64]
	ldurb	w10, [x8, #-63]
	ldurb	w11, [x8, #-62]
	cmp	w9, #33
	mov	w9, #33
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-61]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-60]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-59]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-58]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-57]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-56]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-55]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-54]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-53]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-52]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-51]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-50]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-49]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-48]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-47]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-46]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-45]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-44]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-43]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-42]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-41]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-40]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-39]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-38]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-37]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-36]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-35]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-34]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-33]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-32]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-31]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-30]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-29]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-28]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-27]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-26]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-25]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-24]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-23]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-22]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-21]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-20]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-19]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-18]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-17]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-16]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-15]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-14]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-13]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-12]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-11]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-10]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-9]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-8]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-7]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-6]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-5]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-4]
	ccmp	w10, w9, #4, ne
	ldurb	w10, [x8, #-3]
	ccmp	w11, w9, #4, ne
	ldurb	w11, [x8, #-2]
	ldurb	w8, [x8, #-1]
	ccmp	w10, w9, #4, ne
	ccmp	w11, w9, #4, ne
	ccmp	w8, w9, #4, ne
	cset	w0, eq
.LBB13_71:
	ret
.LBB13_72:
	mov	w0, wzr
	ret
