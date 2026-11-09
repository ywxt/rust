from pathlib import Path
import re,json,hashlib,subprocess,shutil
r=Path('/tmp/str-rfind-20261106');r.mkdir(exist_ok=True);repo=Path('/home/wheel/c00936152/rust-analysis');frozen=Path('/tmp/contains-bad-simd-source')
files=['library/alloctests/benches/str.rs','library/core/src/str/mod.rs','library/core/src/str/pattern.rs','library/core/src/slice/memchr.rs','library/core/src/slice/mod.rs'];hashes={}
for rel in files:
 b=(repo/rel).read_bytes();p=r/'source'/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b);hashes[rel]=hashlib.sha256(b).hexdigest()
rel='library/core/src/slice/memchr.rs';assert (repo/rel).read_bytes()==(frozen/rel).read_bytes(),rel+' differs from baseline'
current_pattern=(repo/'library/core/src/str/pattern.rs').read_text();frozen_pattern=(frozen/'library/core/src/str/pattern.rs').read_text();marker='    fn is_contained_in(self, haystack: &str) -> bool {'
assert current_pattern[:current_pattern.index(marker,current_pattern.index('pub struct CharSearcher'))]==frozen_pattern[:frozen_pattern.index(marker,frozen_pattern.index('pub struct CharSearcher'))],'CharSearcher prefix differs'
diff=subprocess.run(['diff','-u',str(frozen/'library/core/src/str/pattern.rs'),str(repo/'library/core/src/str/pattern.rs')],text=True,capture_output=True);(r/'pattern-vs-frozen.diff').write_text(diff.stdout)
s=(repo/'library/alloctests/benches/str.rs').read_text();macros=s[s.index('macro_rules! make_test_inner'):s.index('make_test!(chars_count')];groups=['rfind_underscore_char','rfind_zzz_char','find_underscore_char','find_zzz_char'];calls=[next(l for l in s.splitlines()if l.startswith('make_test!('+g+','))for g in groups]
fs=(frozen/'library/alloctests/benches/str.rs').read_text();assert macros==fs[fs.index('macro_rules! make_test_inner'):fs.index('make_test!(chars_count')]
body='use test::{Bencher,black_box};\nmod str {\nuse super::*;\n'+macros+'\n'+'\n'.join(calls)+'\n}\n';(r/'benches.rs').write_text('#![feature(test)]\nextern crate test;\n'+body);(r/'query-bodies.rs').write_text(body)
inputs=re.findall(r'make_test_inner!\(\$s, \$code, (\w+),\s*("(?:\\.|[^"\\])*"), \$iters\);',macros,re.S);assert len(inputs)==4,len(inputs)
(r/'inputs.rs').write_text('pub static INPUTS: &[(&str,&str)] = &[\n'+''.join('("'+n+'", '+literal+'),\n'for n,literal in inputs)+'];\n')
input_meta=[]
for n,literal in inputs:
 cleaned=re.sub(r'\\\n\s*','',literal);text=json.loads(cleaned,strict=False);data=text.encode();assert b'_'not in data and '\U0001f4a4'not in text and 0xa4 not in data;input_meta.append(dict(name=n,bytes=len(data),chars=len(text),sha256=hashlib.sha256(data).hexdigest(),underscore=data.rfind(b'_'),zzz=text.rfind('\U0001f4a4')))
(r/'inputs.json').write_text(json.dumps(input_meta,indent=2,ensure_ascii=False))
prefix='mod test {pub use std::hint::black_box;pub struct Bencher{pub bytes:u64,pub n:usize}impl Bencher{pub fn iter<T,F:FnMut()->T>(&mut self,mut f:F){for _ in 0..self.n{std::hint::black_box(f());}}}}\n'
fixed=body.replace('#[bench]','').replace('fn $name','pub fn $name').replace('mod $name','pub mod $name').replace('use test::','use crate::test::')
names=['str::'+g+'::'+n for g in groups for n,_ in inputs]
main='fn main(){let a:Vec<_>=std::env::args().collect();let n:usize=a[2].parse().unwrap();let f:fn(&mut test::Bencher)=match a[1].as_str(){'+''.join('"'+n+'"=>'+n+','for n in names)+'_=>panic!()};let mut b=test::Bencher{bytes:0,n};let t=std::time::Instant::now();f(&mut b);println!("{}",t.elapsed().as_nanos());}\n'
(r/'counted.rs').write_text(prefix+fixed+main)
def fn(text,name):
 start=text.index('fn '+name+'(');brace=text.index('{',start);depth=0
 for i in range(brace,len(text)):
  if text[i]=='{':depth+=1
  elif text[i]=='}':
   depth-=1
   if depth==0:return text[start:i+1]
word=(repo/'library/core/src/slice/memchr.rs').read_text();copied='use std::mem::size_of;\nconst LO_USIZE:usize=usize::MAX/255;\nconst HI_USIZE:usize=LO_USIZE*128;\n#[inline]\nconst '+fn(word,'contains_zero_byte')+'\n#[inline(never)]\n#[unsafe(no_mangle)]\npub '+fn(word,'memrchr').replace('fn memrchr(','fn copied_memrchr(').replace('usize::repeat_u8(x)','(x as usize).wrapping_mul(LO_USIZE)')+'\n';(r/'word.rs').write_text(copied)
crate=Path('/home/wheel/.cargo/registry/src/rsproxy.cn-e3de039b2554c837/memchr-2.8.3');shutil.copytree(crate,r/'dependency-source/memchr-2.8.3',dirs_exist_ok=True)
(r/'provenance.json').write_text(json.dumps(dict(source_head=subprocess.check_output(['git','-C',str(repo),'rev-parse','HEAD'],text=True).strip(),files=hashes,benchmarks=names,compiler='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/bin/rustc',sysroot='/tmp/contains-bad-simd-20261105/sysroots/baseline',benchmark_macros_preserved=True,copied_memrchr_changes=['rename','noinline/export annotation','equivalent repeated-byte construction']),indent=2))
