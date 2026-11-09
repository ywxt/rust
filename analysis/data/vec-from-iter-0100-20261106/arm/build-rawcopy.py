from pathlib import Path
import subprocess,os,json
r=Path(__file__).resolve().parent;compiler='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/bin/rustc';e=os.environ.copy();e['LD_LIBRARY_PATH']='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/lib';commands=[]
for target in ['aarch64-unknown-linux-gnu','x86_64-unknown-linux-gnu']:
 for v,extra in [('base',[]),('interleave4',['-Cllvm-args=-force-vector-interleave=4']),('interleave8',['-Cllvm-args=-force-vector-interleave=8'])]:
  c=[compiler,'--sysroot','/tmp/contains-bad-simd-20261105/sysroots/baseline','--target',target,'-O','--edition=2024','-Cprefer-dynamic','--emit=link,asm,llvm-ir']+extra+(['-Clinker=/tmp/contains-stdlib-20261105/x86-cc']if target.startswith('x86')else[])+[str(r/'rawcopy.rs'),'-o',str(r/target/('rawcopy-'+v))];p=subprocess.run(c,env=e,text=True,capture_output=True);(r/target/('rawcopy-'+v+'-build.log')).write_text(str(c)+'\n'+p.stdout+p.stderr);assert p.returncode==0,p.stderr;commands.append(c)
(r/'rawcopy-commands.json').write_text(json.dumps(commands,indent=2))
