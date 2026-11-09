# ARM/x86 相對 cycles 比值變化

固定候選 contains-arm-mask-abi-20261106。R=ARM cycles/x86 cycles；變化=(R後/R前−1)×100%。負數表示比值下降，並非吞吐率提升百分比。x86 兩組代碼相同而量測有波動，因此同時列固定 x86-main 參考。完整 CSV 另有 CPU ns 比值；1,601 條目含 16 個重複參數的邊界補測。

| 場景 | 實測 cycles 比前 → 後 | 實測比值變化 | 固定 x86-main 比值變化 |
|---|---:|---:|---:|
| bench_contains_short_short | 1.215 → 1.196 | -1.57% | -0.30% |
| bench_contains_2b_repeated_long | 1.686 → 1.480 | -12.25% | +0.41% |
| bench_contains_short_long | 1.569 → 1.739 | +10.83% | -0.02% |
| bench_contains_16b_in_long | 1.618 → 1.780 | +10.00% | +0.04% |
| bench_contains_32b_in_long | 1.890 → 1.884 | -0.34% | -0.07% |
| bench_contains_bad_naive | 1.078 → 0.957 | -11.15% | +0.06% |
| bench_contains_bad_simd | 1.142 → 1.229 | +7.57% | +0.27% |
| bench_contains_equal | 0.907 → 1.011 | +11.39% | -0.42% |
| contains_bang_str_short_ascii | 0.838 → 0.271 | -67.61% | -66.15% |
| contains_bang_char_short_ascii | 0.890 → 0.251 | -71.77% | -71.81% |
| contains_bang_str_short_mixed | 0.968 → 0.445 | -54.09% | -54.63% |
| contains_bang_char_short_mixed | 0.983 → 0.257 | -73.89% | -72.73% |
| contains_bang_str_short_pile_of_poo | 0.453 → 0.453 | -0.11% | -10.47% |
| contains_bang_char_short_pile_of_poo | 0.482 → 0.254 | -47.34% | -46.98% |
| contains_bang_str_long_lorem_ipsum | 1.262 → 0.311 | -75.35% | -71.62% |
| contains_bang_char_long_lorem_ipsum | 1.075 → 0.308 | -71.35% | -73.94% |
| extra_empty | 1.004 → 1.156 | +15.17% | +0.39% |
| extra_empty_in_long | 1.158 → 1.158 | +0.01% | +0.75% |
| extra_longer_needle | 1.188 → 1.194 | +0.50% | +0.35% |
| extra_unicode_str_hit | 0.960 → 0.948 | -1.25% | -0.42% |
| extra_unicode_str_miss | 1.474 → 1.606 | +8.93% | -0.02% |
| extra_unicode_char_hit | 0.962 → 0.967 | +0.48% | -0.23% |
| extra_unicode_char_miss | 1.713 → 1.568 | -8.46% | +0.03% |
| extra_nul_str | 1.098 → 0.349 | -68.24% | -69.52% |
| extra_ascii_char | 1.041 → 0.323 | -68.95% | -70.19% |
| extra_char_array | 1.359 → 1.379 | +1.48% | -0.01% |
| extra_char_slice | 1.224 → 1.214 | -0.79% | +0.03% |
| extra_predicate | 1.346 → 1.330 | -1.18% | -0.01% |
