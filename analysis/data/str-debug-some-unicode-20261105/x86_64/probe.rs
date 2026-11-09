#![feature(unicode_internals)]
use std::fmt::{self,Write};
use std::hint::black_box;
use core::unicode::unicode_data as ud;
const INPUT:&str="egy kis szöveg néhány unicode betűvel. legyen ez is 64 byte.";
struct Counter{len:usize,calls:usize}
impl Write for Counter {fn write_str(&mut self,s:&str)->fmt::Result{self.len+=s.len();self.calls+=1;Ok(())}}
#[inline(never)]
#[unsafe(no_mangle)]
fn format_std(s:&str)->String{format!("{:?}",black_box(s))}
#[inline(never)]
#[unsafe(no_mangle)]
fn reused_std(s:&str,out:&mut String){out.clear();write!(out,"{:?}",black_box(s)).unwrap();}
#[inline(never)]
#[unsafe(no_mangle)]
fn count_std(s:&str)->usize{let mut w=Counter{len:0,calls:0};write!(&mut w,"{:?}",black_box(s)).unwrap();black_box(w.calls);w.len}
#[inline(never)]
#[unsafe(no_mangle)]
fn raw_quotes(s:&str)->String{let mut out=String::new();out.push('"');out.push_str(black_box(s));out.push('"');out}
#[inline(never)]
#[unsafe(no_mangle)]
fn raw_count(s:&str)->usize{let mut w=Counter{len:0,calls:0};w.write_str("\"").unwrap();w.write_str(black_box(s)).unwrap();w.write_str("\"").unwrap();black_box(w.calls);w.len}
#[inline(never)]
#[unsafe(no_mangle)]
fn scan_decode(s:&str)->usize{
 let mut rest=black_box(s);let mut count=0;
 while !rest.is_empty(){
  let Some(i)=rest.as_bytes().iter().position(|&b|b>0x7e||b<0x20||b==b'\\'||b==b'"')else{break};
  let mut chars=rest[i..].chars();let c=chars.next().unwrap();count+=c.len_utf8();rest=chars.as_str();
 }
 count
}
#[inline(never)]
#[unsafe(no_mangle)]
fn escape_four(cs:&[char])->usize{let mut n=0;for &c in black_box(cs){n+=c.escape_debug().len();}n}
#[inline(never)]
#[unsafe(no_mangle)]
fn cf_four(cs:&[char])->usize{let mut n=0;for &c in black_box(cs){n+=ud::cf::lookup(c) as usize;}n}
#[inline(never)]
#[unsafe(no_mangle)]
fn di_four(cs:&[char])->usize{let mut n=0;for &c in black_box(cs){n+=ud::default_ignorable_code_point::lookup(c) as usize;}n}
fn main(){
 let a:Vec<_>=std::env::args().collect();let mode=a[1].as_str();let reps:usize=a[2].parse().unwrap();
 assert_eq!(INPUT.len(),64);let cs:Vec<char>=INPUT.chars().filter(|c|!c.is_ascii()).collect();assert_eq!(cs,['ö','é','á','ű']);
 let expected=format!("\"{}\"",INPUT);assert_eq!(format_std(INPUT),expected);assert_eq!(raw_quotes(INPUT),expected);
 let mut out=String::with_capacity(128);reused_std(INPUT,&mut out);assert_eq!(out,expected);assert_eq!(count_std(INPUT),66);assert_eq!(raw_count(INPUT),66);
 assert_eq!(escape_four(&cs),4);assert_eq!(cf_four(&cs),0);assert_eq!(di_four(&cs),0);assert_eq!(scan_decode(INPUT),8);
 for _ in 0..reps {match mode{
  "format"=>{black_box(format_std(black_box(INPUT)));},
  "reused"=>{reused_std(black_box(INPUT),&mut out);black_box(out.as_str());},
  "count"=>{black_box(count_std(black_box(INPUT)));},
  "raw"=>{black_box(raw_quotes(black_box(INPUT)));},
  "raw_count"=>{black_box(raw_count(black_box(INPUT)));},
  "scan"=>{black_box(scan_decode(black_box(INPUT)));},
  "escape"=>{black_box(escape_four(black_box(&cs)));},
  "cf"=>{black_box(cf_four(black_box(&cs)));},
  "di"=>{black_box(di_four(black_box(&cs)));},_=>panic!()
 }}
}
