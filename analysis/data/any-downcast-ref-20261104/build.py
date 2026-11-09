from pathlib import Path
import subprocess,os,platform
p=Path(__file__).resolve().parent
r=Path('/tmp/xdiff/rustc.txt').read_text().strip();env=os.environ.copy();env['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+env.get('LD_LIBRARY_PATH','')
cases=[('normal',[]),('no-color',['-C','llvm-args=-no-stack-coloring'])]
if platform.machine()=='aarch64':cases += [('no-ldst',['-C','llvm-args=-aarch64-enable-ldst-opt=false']),('no-color-ldst',['-C','llvm-args=-no-stack-coloring','-C','llvm-args=-aarch64-enable-ldst-opt=false'])]
for tag,extra in cases:
 subprocess.run([r,'--edition=2021','-C','opt-level=3','-C','debuginfo=1',*extra,str(p/'probe.rs'),'-o',str(p/tag)],env=env,check=True)
 subprocess.run([str(p/tag),'check'],env=env,check=True)
