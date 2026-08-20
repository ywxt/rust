# memchr

## 優化代碼

library/core/src/slice/memchr.rs

## benchmarks


### 優化前 
benchmarks:
    slice::memchr_benches::len_0016::fwd_match_first    3.80ns/iter  +/- 0.00
    slice::memchr_benches::len_0016::fwd_match_last     9.66ns/iter  +/- 0.01
    slice::memchr_benches::len_0016::fwd_match_none     3.45ns/iter  +/- 0.01
    slice::memchr_benches::len_0016::rev_match_first   10.39ns/iter  +/- 0.14
    slice::memchr_benches::len_0016::rev_match_last     4.36ns/iter  +/- 0.01
    slice::memchr_benches::len_0016::rev_match_none     4.23ns/iter  +/- 0.01
    slice::memchr_benches::len_0032::fwd_match_first    3.79ns/iter  +/- 0.01
    slice::memchr_benches::len_0032::fwd_match_last    10.01ns/iter  +/- 0.03
    slice::memchr_benches::len_0032::fwd_match_none     4.17ns/iter  +/- 0.01
    slice::memchr_benches::len_0032::rev_match_first   12.42ns/iter  +/- 0.41
    slice::memchr_benches::len_0032::rev_match_last     4.35ns/iter  +/- 0.07
    slice::memchr_benches::len_0032::rev_match_none     6.79ns/iter  +/- 1.36
    slice::memchr_benches::len_0064::fwd_match_first    3.79ns/iter  +/- 0.01
    slice::memchr_benches::len_0064::fwd_match_last    12.65ns/iter  +/- 0.39
    slice::memchr_benches::len_0064::fwd_match_none     6.25ns/iter  +/- 0.13
    slice::memchr_benches::len_0064::rev_match_first   16.67ns/iter  +/- 0.03
    slice::memchr_benches::len_0064::rev_match_last     4.30ns/iter  +/- 0.03
    slice::memchr_benches::len_0064::rev_match_none     7.78ns/iter  +/- 0.01
    slice::memchr_benches::len_0256::fwd_match_first    3.80ns/iter  +/- 0.01
    slice::memchr_benches::len_0256::fwd_match_last    28.74ns/iter  +/- 0.33
    slice::memchr_benches::len_0256::fwd_match_none    21.11ns/iter  +/- 0.11
    slice::memchr_benches::len_0256::rev_match_first   30.79ns/iter  +/- 0.05
    slice::memchr_benches::len_0256::rev_match_last     4.34ns/iter  +/- 0.06
    slice::memchr_benches::len_0256::rev_match_none    23.83ns/iter  +/- 0.12
    slice::memchr_benches::len_1k::fwd_match_first      3.80ns/iter  +/- 0.01
    slice::memchr_benches::len_1k::fwd_match_last      89.09ns/iter  +/- 0.31
    slice::memchr_benches::len_1k::fwd_match_none      81.11ns/iter  +/- 0.47
    slice::memchr_benches::len_1k::rev_match_first     93.71ns/iter  +/- 1.26
    slice::memchr_benches::len_1k::rev_match_last       4.29ns/iter  +/- 0.01
    slice::memchr_benches::len_1k::rev_match_none      86.16ns/iter  +/- 0.22
    slice::memchr_benches::len_4k::fwd_match_first      3.79ns/iter  +/- 0.01
    slice::memchr_benches::len_4k::fwd_match_last     336.51ns/iter  +/- 5.01
    slice::memchr_benches::len_4k::fwd_match_none     321.08ns/iter  +/- 2.08
    slice::memchr_benches::len_4k::rev_match_first    350.16ns/iter  +/- 0.38
    slice::memchr_benches::len_4k::rev_match_last       4.30ns/iter  +/- 0.01
    slice::memchr_benches::len_4k::rev_match_none     346.42ns/iter  +/- 3.00
    slice::memchr_benches::len_64k::fwd_match_first     3.79ns/iter  +/- 0.01
    slice::memchr_benches::len_64k::fwd_match_last   5098.57ns/iter +/- 12.70
    slice::memchr_benches::len_64k::fwd_match_none   5107.51ns/iter +/- 18.46
    slice::memchr_benches::len_64k::rev_match_first  5364.25ns/iter +/- 23.28
    slice::memchr_benches::len_64k::rev_match_last      4.29ns/iter  +/- 0.01
    slice::memchr_benches::len_64k::rev_match_none   5368.44ns/iter +/- 19.57

benchmarks:
    pattern::contains_char_missing        3082.19ns/iter  +/- 26.38
    pattern::contains_char_short_missing  9194.34ns/iter +/- 319.57
    pattern::ends_with_char               4598.78ns/iter   +/- 5.27
    pattern::find_char_missing            3081.17ns/iter  +/- 28.15
    pattern::find_char_short_missing     10253.89ns/iter +/- 273.56
    pattern::find_char_sparse               55.91ns/iter   +/- 0.35
    pattern::matches_char_sparse_count    3653.83ns/iter  +/- 58.62
    pattern::rfind_char_missing           3235.95ns/iter  +/- 23.67
    pattern::split_char_dense_count       8908.60ns/iter  +/- 44.02
    pattern::starts_with_char             4599.79ns/iter  +/- 22.12



### 優化後

benchmarks:
    pattern::contains_char_missing        1254.59ns/iter +/- 421.52
    pattern::contains_char_short_missing  7075.88ns/iter   +/- 7.70
    pattern::ends_with_char               4599.33ns/iter  +/- 24.52
    pattern::find_char_missing             783.28ns/iter  +/- 10.23
    pattern::find_char_short_missing      8135.74ns/iter +/- 171.58
    pattern::find_char_sparse               18.01ns/iter   +/- 0.09
    pattern::matches_char_sparse_count    1110.85ns/iter   +/- 3.02
    pattern::rfind_char_missing            877.37ns/iter  +/- 29.95
    pattern::split_char_dense_count       6501.38ns/iter +/- 141.05
    pattern::starts_with_char             4598.40ns/iter   +/- 6.84

benchmarks:
    slice::memchr_benches::len_0016::fwd_match_first    3.45ns/iter   +/- 0.01
    slice::memchr_benches::len_0016::fwd_match_last     9.32ns/iter   +/- 0.03
    slice::memchr_benches::len_0016::fwd_match_none     3.11ns/iter   +/- 0.01
    slice::memchr_benches::len_0016::rev_match_first    8.06ns/iter   +/- 0.08
    slice::memchr_benches::len_0016::rev_match_last     2.11ns/iter   +/- 0.01
    slice::memchr_benches::len_0016::rev_match_none     2.21ns/iter   +/- 0.03
    slice::memchr_benches::len_0032::fwd_match_first    3.45ns/iter   +/- 0.00
    slice::memchr_benches::len_0032::fwd_match_last     9.66ns/iter   +/- 0.38
    slice::memchr_benches::len_0032::fwd_match_none     3.45ns/iter   +/- 0.00
    slice::memchr_benches::len_0032::rev_match_first    8.51ns/iter   +/- 0.02
    slice::memchr_benches::len_0032::rev_match_last     2.11ns/iter   +/- 0.02
    slice::memchr_benches::len_0032::rev_match_none     2.25ns/iter   +/- 0.00
    slice::memchr_benches::len_0064::fwd_match_first    3.80ns/iter   +/- 0.01
    slice::memchr_benches::len_0064::fwd_match_last    11.41ns/iter   +/- 0.03
    slice::memchr_benches::len_0064::fwd_match_none     3.45ns/iter   +/- 0.01
    slice::memchr_benches::len_0064::rev_match_first   10.92ns/iter   +/- 0.09
    slice::memchr_benches::len_0064::rev_match_last     3.14ns/iter   +/- 0.01
    slice::memchr_benches::len_0064::rev_match_none     2.87ns/iter   +/- 0.00
    slice::memchr_benches::len_0256::fwd_match_first    3.80ns/iter   +/- 0.00
    slice::memchr_benches::len_0256::fwd_match_last    14.15ns/iter   +/- 0.02
    slice::memchr_benches::len_0256::fwd_match_none     6.56ns/iter   +/- 0.01
    slice::memchr_benches::len_0256::rev_match_first   13.06ns/iter   +/- 0.71
    slice::memchr_benches::len_0256::rev_match_last     3.12ns/iter   +/- 0.01
    slice::memchr_benches::len_0256::rev_match_none     6.99ns/iter   +/- 0.03
    slice::memchr_benches::len_1k::fwd_match_first      3.80ns/iter   +/- 0.02
    slice::memchr_benches::len_1k::fwd_match_last      31.60ns/iter   +/- 1.66
    slice::memchr_benches::len_1k::fwd_match_none      27.22ns/iter   +/- 5.35
    slice::memchr_benches::len_1k::rev_match_first     31.24ns/iter   +/- 1.12
    slice::memchr_benches::len_1k::rev_match_last       3.13ns/iter   +/- 0.06
    slice::memchr_benches::len_1k::rev_match_none      23.19ns/iter   +/- 1.96
    slice::memchr_benches::len_4k::fwd_match_first      3.80ns/iter   +/- 0.01
    slice::memchr_benches::len_4k::fwd_match_last      90.49ns/iter  +/- 26.45
    slice::memchr_benches::len_4k::fwd_match_none      92.32ns/iter  +/- 11.14
    slice::memchr_benches::len_4k::rev_match_first     85.71ns/iter   +/- 7.48
    slice::memchr_benches::len_4k::rev_match_last       3.12ns/iter   +/- 0.00
    slice::memchr_benches::len_4k::rev_match_none      83.58ns/iter   +/- 0.12
    slice::memchr_benches::len_64k::fwd_match_first     3.80ns/iter   +/- 0.01
    slice::memchr_benches::len_64k::fwd_match_last   1761.04ns/iter +/- 361.02
    slice::memchr_benches::len_64k::fwd_match_none   1389.31ns/iter   +/- 4.22
    slice::memchr_benches::len_64k::rev_match_first  1638.84ns/iter +/- 287.15
    slice::memchr_benches::len_64k::rev_match_last      3.34ns/iter   +/- 0.01
    slice::memchr_benches::len_64k::rev_match_none   1704.41ns/iter +/- 316.68
