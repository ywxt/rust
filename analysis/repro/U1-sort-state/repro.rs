// U1:sort 內組件交錯是否使每 cycle 變慢。
// small:只做 32 元素 sort_unstable;part:只做 1024 元素 select_nth_unstable(同一 partition 實作);
// both:兩者交替;交互代價 = both − part − small(各模式都含相同的拷貝)。whole:10000 元素整體 sort_unstable。
use std::fs::File;
use std::hint::black_box;
use std::io::Read;
use std::os::fd::FromRawFd;

extern "C" { fn syscall(n: i64, ...) -> i64; }
#[cfg(target_arch = "x86_64")] const NR: i64 = 298;
#[cfg(target_arch = "aarch64")] const NR: i64 = 241;
// perf_event_attr:type=HARDWARE,config 0=cycles 1=instructions 5=branch-misses;exclude_kernel|exclude_hv
fn counter(cfg: u64) -> File {
    let pmu = std::fs::read_to_string("/sys/bus/event_source/devices/cpu_core/type").ok().and_then(|s| s.trim().parse::<u64>().ok()).unwrap_or(0);
    let mut a = [0u64; 16];
    a[0] = 128 << 32; a[1] = cfg | pmu << 32; a[5] = 1 << 5 | 1 << 6;
    let fd = unsafe { syscall(NR, a.as_ptr(), 0i32, -1i32, -1i32, 0u64) };
    assert!(fd >= 0, "perf_event_open");
    unsafe { File::from_raw_fd(fd as i32) }
}
fn rd(c: &mut [File; 3]) -> [u64; 3] {
    let mut r = [0u64; 3];
    for i in 0..3 { let mut b = [0u8; 8]; c[i].read_exact(&mut b).unwrap(); r[i] = u64::from_ne_bytes(b); }
    r
}

fn main() {
    let mode = std::env::args().nth(1).unwrap();
    let mut s = 0x9E3779B97F4A7C15u64;
    let mut rnd = || { s ^= s << 13; s ^= s >> 7; s ^= s << 17; s };
    let sm: Vec<Vec<u64>> = (0..64).map(|_| (0..32).map(|_| rnd()).collect()).collect(); // 64 組輪流,避免預測器背數據
    let pt: Vec<Vec<u64>> = (0..64).map(|_| (0..1024).map(|_| rnd()).collect()).collect();
    let wh: Vec<u64> = (0..10000).map(|_| rnd()).collect();
    let (mut a, mut b, mut w) = (vec![0u64; 32], vec![0u64; 1024], vec![0u64; 10000]);
    let mut c = [counter(0), counter(1), counter(5)];
    let n = if mode == "whole" { 200 } else { 20000 };
    let mut best = [u64::MAX; 3];
    for _ in 0..5 {
        let t0 = rd(&mut c);
        for i in 0..n {
            let k = i % 64;
            if mode == "part" || mode == "both" { b.copy_from_slice(&pt[k]); black_box(b.select_nth_unstable(512)); }
            if mode == "small" || mode == "both" { a.copy_from_slice(&sm[k]); a.sort_unstable(); black_box(&a); }
            if mode == "whole" { w.copy_from_slice(&wh); w.sort_unstable(); black_box(&w); }
        }
        let t1 = rd(&mut c);
        if t1[0] - t0[0] < best[0] { for j in 0..3 { best[j] = t1[j] - t0[j]; } }
    }
    let n = n as f64;
    println!("{mode:5} cyc/iter {:9.1} ins/iter {:9.1} miss/iter {:6.2}", best[0] as f64 / n, best[1] as f64 / n, best[2] as f64 / n);
}
