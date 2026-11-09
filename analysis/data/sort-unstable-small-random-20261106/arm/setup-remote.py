from pathlib import Path
import subprocess, os, json, re, hashlib
r = Path('/tmp/sort-small-random-20261106');r.mkdir(exist_ok=True)
repo=Path('/home/wheel/c00936152/rust-analysis');snap=Path('/tmp/contains-bad-simd-source')
files=['library/alloctests/benches/slice.rs','library/alloctests/benches/lib.rs','library/alloctests/Cargo.toml','Cargo.lock']+[str(p.relative_to(repo)) for p in (repo/'library/core/src/slice/sort').rglob('*.rs')]
hashes={}
for f in files:
    data=(repo/f).read_bytes();dst=r/'source'/f;dst.parent.mkdir(parents=True,exist_ok=True);dst.write_bytes(data);hashes[f]=hashlib.sha256(data).hexdigest()
    if f.startswith('library/core/src/slice/sort/'):
        assert data==(snap/f).read_bytes(),f+' differs from frozen sysroot source'
s=(repo/'library/alloctests/benches/slice.rs').read_text()
def function(text,name):
    start=text.index('fn '+name+'(');brace=text.index('{',start);depth=0
    for i in range(brace,len(text)):
        if text[i]=='{':depth+=1
        elif text[i]=='}':
            depth-=1
            if depth==0:return text[start:i+1]
rng=function((repo/'library/alloctests/benches/lib.rs').read_text(),'bench_rng')
gens='\n'.join(function(s,n) for n in ['gen_ascending','gen_descending','gen_random','gen_mostly_ascending','gen_mostly_descending','gen_big_random'])
macro=s[s.index('macro_rules! sort {'):s.index('macro_rules! sort_strings {')]
invocations=re.findall(r'^sort!\(.*?\);$',s,re.M)
names=[re.search(r'sort!\([^,]+,\s*([^,]+),',l)[1] for l in invocations]
common=rng+'\nmod slice {\nuse rand::Rng;\nuse rand::distr::StandardUniform;\nuse test::{Bencher,black_box};\n'+gens+'\n'+macro+'\n'+'\n'.join(invocations)+'\n}\n'
(r/'benches.rs').write_text('#![feature(test)]\nextern crate test;\n'+common)
(r/'query-bodies.rs').write_text(common)
counted=common.replace('#[bench]','').replace('fn $name','pub fn $name').replace('use test::{','use crate::test::{')
prefix='mod test {pub use std::hint::black_box;pub struct Bencher{pub bytes:u64,pub n:usize}impl Bencher{pub fn iter<T,F:FnMut()->T>(&mut self,mut f:F){for _ in 0..self.n{std::hint::black_box(f());}}}}\n'
main='fn main(){let a:Vec<_>=std::env::args().collect();let n:usize=a[2].parse().unwrap();let f:fn(&mut test::Bencher)=match a[1].as_str(){'+''.join('"slice::'+n+'"=>slice::'+n+',' for n in names)+'_=>panic!()};let mut b=test::Bencher{bytes:0,n};let t=std::time::Instant::now();f(&mut b);println!("{}",t.elapsed().as_nanos());}\n'
(r/'counted.rs').write_text(prefix+counted+main)
provenance=dict(source_head=subprocess.check_output(['git','-C',str(repo),'rev-parse','HEAD'],text=True).strip(),files=hashes,benchmarks=names,original_macros_and_generators_preserved=True,compiler='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/bin/rustc',sysroot='/tmp/contains-bad-simd-20261105/sysroots/baseline')
(r/'provenance.json').write_text(json.dumps(provenance,indent=2))
