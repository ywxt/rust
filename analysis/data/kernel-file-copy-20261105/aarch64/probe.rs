use std::{fs::{File,OpenOptions},io::{self,Read,Write,Seek,SeekFrom},hint::black_box,os::fd::AsRawFd,time::Instant};
unsafe extern "C" {fn copy_file_range(a:i32,ao:*mut i64,b:i32,bo:*mut i64,n:usize,f:u32)->isize;}
fn direct(a:&File,b:&File,limit:Option<usize>)->io::Result<u64>{
 let mut total=0;loop{let n=limit.map_or(0x40000000,|n|n-total);if n==0{return Ok(total as u64)}
 let k=unsafe{copy_file_range(a.as_raw_fd(),std::ptr::null_mut(),b.as_raw_fd(),std::ptr::null_mut(),n,0)};
 if k<0{let e=io::Error::last_os_error();if e.kind()==io::ErrorKind::Interrupted{continue}return Err(e)}
 if k==0{return Ok(total as u64)}total+=k as usize;
 }
}
fn main()->io::Result<()>{
 let a:Vec<_>=std::env::args().collect();let mode=&a[1];let size:usize=a[2].parse().unwrap();let reps:usize=a[3].parse().unwrap();let root=std::path::Path::new(&a[4]);
 let dir=root.join(format!("copy-probe-{}",std::process::id()));std::fs::create_dir(&dir)?;
 let mut src=OpenOptions::new().create_new(true).read(true).write(true).open(dir.join("src"))?;
 let mut dst=OpenOptions::new().create_new(true).read(true).write(true).open(dir.join("dst"))?;
 let data:Vec<u8>=(0..size).map(|i|if a.get(5).is_some_and(|s|s=="pattern"){(i.wrapping_mul(17).wrapping_add(i>>8))as u8}else{0}).collect();
 src.write_all(&data)?;
 let mut buf=vec![0u8;if mode=="rw8"{8192}else{131072}];
 let start=Instant::now();
 for _ in 0..reps{
  src.seek(SeekFrom::Start(0))?;dst.seek(SeekFrom::Start(0))?;
  let n=match mode.as_str(){
   "std"=>io::copy(&mut src,&mut dst)?,
   "take"=>io::copy(&mut (&mut src).take(size as u64),&mut dst)?,
   "cfr"=>direct(&src,&dst,None)?,
   "cfr_limited"=>direct(&src,&dst,Some(size))?,
   "rw8"|"rw128"=>{let mut n=0;loop{let k=src.read(&mut buf)?;if k==0{break}dst.write_all(&buf[..k])?;n+=k as u64;}n},
   "seeks"=>size as u64,
   "metadata"=>{black_box(src.metadata()?);black_box(dst.metadata()?);size as u64},
   _=>panic!("unknown mode"),
  };assert_eq!(n,size as u64);black_box(n);
 }
 let elapsed=start.elapsed().as_nanos();
 if mode!="seeks" && mode!="metadata"{dst.seek(SeekFrom::Start(0))?;let mut out=Vec::new();dst.read_to_end(&mut out)?;assert_eq!(out,data);}
 println!("{{\"mode\":\"{}\",\"bytes\":{},\"reps\":{},\"loop_ns\":{},\"ns_per_call\":{}}}",mode,size,reps,elapsed,elapsed as f64/reps as f64);
 drop(src);drop(dst);std::fs::remove_dir_all(dir)?;Ok(())
}
