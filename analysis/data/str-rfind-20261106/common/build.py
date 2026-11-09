from pathlib import Path
import subprocess,os,json
r=Path('/tmp/str-rfind-20261106');cc='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/bin/rustc';root='/tmp/contains-bad-simd-20261105/sysroots/baseline';e=os.environ.copy();e['LD_LIBRARY_PATH']='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/lib';commands=[]
def run(c,p):
 q=subprocess.run(c,env=e,text=True,capture_output=True);p.write_text(str(c)+'\n'+q.stdout+q.stderr);assert q.returncode==0,q.stderr;commands.append(c)
for target in ['aarch64-unknown-linux-gnu','x86_64-unknown-linux-gnu']:
 out=r/target;out.mkdir(exist_ok=True);common=[cc,'--sysroot',root,'--target',target,'-O','--edition=2024','-Cprefer-dynamic','-Zinline-mir','-Cllvm-args=-import-instr-limit=10','--emit=link,asm,llvm-ir']+(['-Clinker=/tmp/contains-stdlib-20261105/x86-cc']if target.startswith('x86')else[])
 for name in ['benches','counted']:
  run(common+(['--test']if name=='benches'else[])+[str(r/(name+'.rs')),'-o',str(out/(name+'-base'))],out/(name+'-build.log'))
 fast=out/'libfast_memchr.rlib';c=[cc,'--sysroot',root,'--target',target,'--edition=2021','-O','-Cprefer-dynamic','--crate-name','fast_memchr','--crate-type=rlib','--cfg','feature="std"','--cfg','feature="alloc"',str(r/'dependency-source/memchr-2.8.3/src/lib.rs'),'-o',str(fast)];run(c,out/'fast-build.log')
 if (r/'probes.rs').exists():
  variants={'base':[],'nolsr':['-Cllvm-args=-disable-lsr'],'unroll4':['-Cllvm-args=-unroll-count=4','-Cllvm-args=-unroll-runtime=true']}
  if target.startswith('aarch64'):variants['noldst']=['-Cllvm-args=-aarch64-enable-ldst-opt=false'];variants['both']=['-Cllvm-args=-disable-lsr','-Cllvm-args=-aarch64-enable-ldst-opt=false']
  for v,flags in variants.items():run(common+['-Cforce-frame-pointers=yes','--extern','fast='+str(fast)]+flags+[str(r/'probes.rs'),'-o',str(out/('probes-'+v))],out/('probes-'+v+'-build.log'))
 if (r/'alu.rs').exists():run(common+[str(r/'alu.rs'),'-o',str(out/'alu')],out/'alu-build.log')
 print('built',target,flush=True)
(r/'build-commands.json').write_text(json.dumps(commands,indent=2));(r/'rustc-vV.txt').write_text(subprocess.check_output([cc,'-vV'],env=e,text=True))
