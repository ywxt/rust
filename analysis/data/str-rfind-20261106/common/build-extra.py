from pathlib import Path
import os,json,subprocess
r=Path('/tmp/str-rfind-20261106');commands=json.loads((r/'build-commands.json').read_text());e=os.environ.copy();e['LD_LIBRARY_PATH']='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/lib';saved=[]
word=(r/'word.rs').read_text();fn=word[word.index('#[inline(never)]'):];fn=fn.replace('copied_memrchr','aligned16_memrchr').replace('text.align_to::<(Chunk, Chunk)>()','text.align_to::<AlignedPair>()');assert'align_to::<AlignedPair>'in fn
(r/'word-aligned.rs').write_text(word+'\n#[repr(C, align(16))]\n#[allow(dead_code)]\nstruct AlignedPair(usize,usize);\nconst _:()=assert!(size_of::<AlignedPair>()==16);\n'+fn)
p=(r/'probes.rs').read_text().replace('mod word;','#[path="word-aligned.rs"]\nmod word;').replace('"core"=>core::slice::memchr::memrchr,','"core"=>core::slice::memchr::memrchr,"align16"=>word::aligned16_memrchr,').replace('let fs:[Search;5]=[choose("core"),','let fs:[Search;6]=[choose("align16"),choose("core"),');(r/'probes-aligned.rs').write_text(p)
for target in ['aarch64-unknown-linux-gnu','x86_64-unknown-linux-gnu']:
 base=next(c.copy()for c in commands if c[-1]==str(r/target/'probes-base'))
 for name in ['load','probes-aligned']:
  c=base.copy();c[c.index(str(r/'probes.rs'))]=str(r/(name+'.rs'));c[c.index('-o')+1]=str(r/target/name);q=subprocess.run(c,env=e,text=True,capture_output=True);(r/target/(name+'-build.log')).write_text(str(c)+'\n'+q.stdout+q.stderr);assert q.returncode==0,q.stderr;saved.append(c)
(r/'extra-build-commands.json').write_text(json.dumps(saved,indent=2))
