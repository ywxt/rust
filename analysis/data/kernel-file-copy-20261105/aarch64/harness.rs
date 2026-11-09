#![feature(test)]
extern crate test;
use std::{fs::OpenOptions,io::{self,Read,Write,Seek,SeekFrom},path::PathBuf};
struct Cleanup(PathBuf);impl Drop for Cleanup{fn drop(&mut self){std::fs::remove_dir_all(&self.0).unwrap();}}
#[inline(always)]
fn bench<const MODE:u8>(b:&mut test::Bencher){
 const BYTES:usize=128*1024;
 let dir=std::env::temp_dir().join(format!("copy-harness-{}-{}",std::process::id(),MODE));std::fs::create_dir(&dir).unwrap();let _cleanup=Cleanup(dir.clone());
 let mut src=OpenOptions::new().create_new(true).read(true).write(true).open(dir.join("src")).unwrap();src.write_all(&vec![0;BYTES]).unwrap();
 let mut dst=OpenOptions::new().create_new(true).write(true).open(dir.join("dst")).unwrap();let mut buf=vec![0u8;BYTES];b.bytes=BYTES as u64;
 b.iter(||{src.seek(SeekFrom::Start(0)).unwrap();dst.seek(SeekFrom::Start(0)).unwrap();let n=match MODE{
  0=>io::copy(&mut src,&mut dst).unwrap(),
  1=>io::copy(&mut (&mut src).take(BYTES as u64),&mut dst).unwrap(),
  _=>{let mut n=0u64;loop{let k=src.read(&mut buf).unwrap();if k==0{break}dst.write_all(&buf[..k]).unwrap();n+=k as u64;}n}
 };assert_eq!(n,BYTES as u64);});
}
#[bench]fn original(b:&mut test::Bencher){bench::<0>(b)}
#[bench]fn limited(b:&mut test::Bencher){bench::<1>(b)}
#[bench]fn buffered(b:&mut test::Bencher){bench::<2>(b)}
