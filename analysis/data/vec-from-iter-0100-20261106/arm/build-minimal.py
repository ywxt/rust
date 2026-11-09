from pathlib import Path
import subprocess,os,json
r=Path(__file__).resolve().parent;cc='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/bin/rustc';e=os.environ.copy();e['LD_LIBRARY_PATH']='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/lib';commands=[]
for target in ['aarch64-unknown-linux-gnu','x86_64-unknown-linux-gnu']:
 c=[cc,'--sysroot','/tmp/contains-bad-simd-20261105/sysroots/baseline','--target',target,'--crate-type=lib','--edition=2024','-O','-Ccodegen-units=1','--emit=asm,llvm-ir',str(r/'minimal.rs'),'-o',str(r/target/'minimal')];p=subprocess.run(c,env=e,text=True,capture_output=True);(r/target/'minimal-build.log').write_text(str(c)+'\n'+p.stdout+p.stderr);assert p.returncode==0,p.stderr;commands.append(c)
(r/'minimal-build-commands.json').write_text(json.dumps(commands,indent=2))
