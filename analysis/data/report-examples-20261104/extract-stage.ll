define <2 x i64> @xor_stage(<2 x i64> %x, <2 x i64> %mask) {
  %q = and <2 x i64> %x, %mask
  %keep = xor <2 x i64> %x, %q
  %shift = lshr <2 x i64> %q, <i64 1, i64 1>
  %r = xor <2 x i64> %keep, %shift
  ret <2 x i64> %r
}
define <2 x i64> @add_stage(<2 x i64> %x, <2 x i64> %mask) {
  %notmask = xor <2 x i64> %mask, <i64 -1, i64 -1>
  %keep = and <2 x i64> %x, %notmask
  %q = and <2 x i64> %x, %mask
  %shift = lshr <2 x i64> %q, <i64 1, i64 1>
  %r = add <2 x i64> %keep, %shift
  ret <2 x i64> %r
}
