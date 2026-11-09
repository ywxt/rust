.text
.globl retain_compact_u32_example
retain_compact_u32_example:
whilelo p0.s, xzr, x3
ld1b { z0.s }, p0/z, [x0]
cmpne p1.s, p0/z, z0.s, #0
ld1w { z1.s }, p1/z, [x1]
compact z1.s, p1, z1.s
cntp x3, p0, p1.s
whilelo p2.s, xzr, x3
st1w { z1.s }, p2, [x2]
mov x0, x3
ret
