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
    pattern::ends_with_char                      4597.97ns/iter   +/- 5.92
    pattern::ends_with_str                       4598.14ns/iter   +/- 3.82
    pattern::find_1byte_str_early_return        11512.55ns/iter   +/- 6.60
    pattern::find_1byte_str_long_match_end       5180.74ns/iter   +/- 9.93
    pattern::find_1byte_str_long_nomatch         5172.59ns/iter   +/- 6.81
    pattern::find_1byte_str_short_haystack       9242.62ns/iter +/- 204.13
    pattern::find_char_early_return              7787.22ns/iter   +/- 7.72
    pattern::find_char_long_match_end            5096.61ns/iter   +/- 5.25
    pattern::find_char_long_nomatch              5104.69ns/iter   +/- 6.13
    pattern::find_char_short_haystack            5313.39ns/iter   +/- 6.93
    pattern::find_str                            7090.74ns/iter   +/- 5.68
    pattern::find_str_worst_case                 1482.15ns/iter   +/- 8.95
    pattern::rfind_1byte_str_long_nomatch        5391.75ns/iter   +/- 9.99
    pattern::rfind_char_long_nomatch             5351.41ns/iter  +/- 10.68
    pattern::rfind_str                           5708.62ns/iter   +/- 4.87
    pattern::rfind_str_worst_case               23512.81ns/iter  +/- 17.75
    pattern::split_1byte_str_dense              54059.19ns/iter  +/- 29.86
    pattern::split_1byte_str_multibyte_haystack 80609.83ns/iter  +/- 70.10
    pattern::split_1byte_str_sparse             16889.26ns/iter  +/- 42.32
    pattern::split_char_dense                   42748.78ns/iter  +/- 30.34
    pattern::split_char_multibyte_haystack      69253.86ns/iter  +/- 57.51
    pattern::split_char_sparse                  14326.42ns/iter  +/- 14.53
    pattern::starts_with_char                    4598.04ns/iter   +/- 3.52
    pattern::starts_with_str                     4597.53ns/iter   +/- 3.53




### 優化後

benchmarks:
    pattern::ends_with_char                      4600.08ns/iter  +/- 83.31
    pattern::ends_with_str                       4599.04ns/iter   +/- 7.30
    pattern::find_1byte_str_early_return        12162.06ns/iter +/- 266.43
    pattern::find_1byte_str_long_match_end       1182.60ns/iter   +/- 5.33
    pattern::find_1byte_str_long_nomatch         1286.60ns/iter  +/- 12.17
    pattern::find_1byte_str_short_haystack       9314.57ns/iter  +/- 51.13
    pattern::find_char_early_return              7784.51ns/iter   +/- 5.90
    pattern::find_char_long_match_end            1242.24ns/iter  +/- 10.21
    pattern::find_char_long_nomatch              1318.24ns/iter   +/- 3.43
    pattern::find_char_short_haystack            5569.64ns/iter   +/- 9.63
    pattern::find_str                            7093.10ns/iter   +/- 7.14
    pattern::find_str_worst_case                 1460.42ns/iter  +/- 10.55
    pattern::rfind_1byte_str_long_nomatch        1302.14ns/iter   +/- 7.33
    pattern::rfind_char_long_nomatch             1279.11ns/iter   +/- 4.52
    pattern::rfind_str                           6225.30ns/iter   +/- 8.46
    pattern::rfind_str_worst_case               24622.20ns/iter  +/- 39.85
    pattern::split_1byte_str_dense              55237.39ns/iter +/- 435.06
    pattern::split_1byte_str_multibyte_haystack 78901.17ns/iter +/- 132.03
    pattern::split_1byte_str_sparse              7111.13ns/iter  +/- 12.05
    pattern::split_char_dense                   43158.21ns/iter  +/- 11.31
    pattern::split_char_multibyte_haystack      62913.94ns/iter  +/- 18.51
    pattern::split_char_sparse                   4654.07ns/iter   +/- 2.46
    pattern::starts_with_char                    4598.76ns/iter   +/- 5.49
    pattern::starts_with_str                     4599.39ns/iter   +/- 6.96

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
