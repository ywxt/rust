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
include!("printable-blocks.rs");
#[inline]
fn block_printable(c:char)->bool{let u=c as u32;(0xa1..=0x2ff).contains(&u) && u!=0xad}
struct Candidate<'a,const FAST:bool>(&'a str);
impl<const FAST:bool> fmt::Debug for Candidate<'_,FAST>{
 fn fmt(&self,f:&mut fmt::Formatter<'_>)->fmt::Result{
  f.write_char('"')?;
  let mut printable_range=0..0;let mut rest=self.0;
  while !rest.is_empty(){
   let Some(i)=rest.as_bytes().iter().position(|&b|b>0x7e||b<0x20||b==b'\\'||b==b'"')else{printable_range.end+=rest.len();break};
   printable_range.end+=i;rest=&rest[i..];let mut chars=rest.chars();
   if let Some(c)=chars.next(){
    if FAST && block_printable(c){printable_range.end+=c.len_utf8();rest=chars.as_str();continue;}
    let esc=c.escape_debug();
    if esc.len()!=1{f.write_str(&self.0[printable_range.clone()])?;fmt::Display::fmt(&esc,f)?;printable_range.start=printable_range.end+c.len_utf8();}
    printable_range.end+=c.len_utf8();
   }
   rest=chars.as_str();
  }
  f.write_str(&self.0[printable_range])?;f.write_char('"')
 }
}
#[inline(never)]
#[unsafe(no_mangle)]
fn format_copy(s:&str)->String{format!("{:?}",Candidate::<false>(black_box(s)))}
#[inline(never)]
#[unsafe(no_mangle)]
fn format_fast(s:&str)->String{format!("{:?}",Candidate::<true>(black_box(s)))}
#[inline(never)]
#[unsafe(no_mangle)]
fn reused_copy(s:&str,out:&mut String){out.clear();write!(out,"{:?}",Candidate::<false>(black_box(s))).unwrap();}
#[inline(never)]
#[unsafe(no_mangle)]
fn reused_fast(s:&str,out:&mut String){out.clear();write!(out,"{:?}",Candidate::<true>(black_box(s))).unwrap();}
#[inline(never)]
#[unsafe(no_mangle)]
fn count_copy(s:&str)->usize{let mut w=Counter{len:0,calls:0};write!(&mut w,"{:?}",Candidate::<false>(black_box(s))).unwrap();black_box(w.calls);w.len}
#[inline(never)]
#[unsafe(no_mangle)]
fn count_fast(s:&str)->usize{let mut w=Counter{len:0,calls:0};write!(&mut w,"{:?}",Candidate::<true>(black_box(s))).unwrap();black_box(w.calls);w.len}
fn check_candidate(){
 let cases=[INPUT,"","'","\"","a\nb\tc\0","предложение из кириллических букв.","\"❤️\"\n\"hűha ez betű\"\n\"кириллических букв\".","中文测试","\u{ad}\u{300}\u{378}\u{200b}\u{ff9e}\u{ff9f}\u{fe0f}\u{10ffff}"];
 for s in cases{assert_eq!(format_copy(s),format_std(s));assert_eq!(format_fast(s),format_std(s));}
 let mut base=String::with_capacity(32);let mut alt=String::with_capacity(32);let mut buf=[0u8;4];
 for u in 0..=0x10ffffu32{
  if let Some(c)=char::from_u32(u){let s=c.encode_utf8(&mut buf);base.clear();alt.clear();write!(base,"{s:?}").unwrap();write!(alt,"{:?}",Candidate::<true>(s)).unwrap();assert_eq!(base,alt,"{u:x}");}
 }
 println!("all Unicode scalars and mixed cases passed");
}

fn main(){
 let a:Vec<_>=std::env::args().collect();let mode=a[1].as_str();let reps:usize=a[2].parse().unwrap();
 assert_eq!(INPUT.len(),64);let cs:Vec<char>=INPUT.chars().filter(|c|!c.is_ascii()).collect();assert_eq!(cs,['ö','é','á','ű']);
 if mode=="check"{check_candidate();return;}
 let expected=format!("\"{}\"",INPUT);assert_eq!(format_std(INPUT),expected);assert_eq!(raw_quotes(INPUT),expected);
 let mut out=String::with_capacity(128);reused_std(INPUT,&mut out);assert_eq!(out,expected);assert_eq!(count_std(INPUT),66);assert_eq!(raw_count(INPUT),66);
 assert_eq!(escape_four(&cs),4);assert_eq!(cf_four(&cs),0);assert_eq!(di_four(&cs),0);assert_eq!(scan_decode(INPUT),8);
 for _ in 0..reps {match mode{
  "copy"=>{black_box(format_copy(black_box(INPUT)));},
  "fast"=>{black_box(format_fast(black_box(INPUT)));},
  "reused_copy"=>{reused_copy(black_box(INPUT),&mut out);black_box(out.as_str());},
  "reused_fast"=>{reused_fast(black_box(INPUT),&mut out);black_box(out.as_str());},
  "count_copy"=>{black_box(count_copy(black_box(INPUT)));},
  "count_fast"=>{black_box(count_fast(black_box(INPUT)));},
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
