from pathlib import Path
import subprocess,os,json
r=Path(__file__).resolve().parent;compiler='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/bin/rustc';e=os.environ.copy();e['LD_LIBRARY_PATH']='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/lib';cmds=[]
for target in ['aarch64-unknown-linux-gnu','x86_64-unknown-linux-gnu']:
 out=r/'diagnostics'/target;out.mkdir(parents=True,exist_ok=True)
 common=[compiler,'--sysroot',str(r/'sysroots/candidate'),'--target',target,'-O','--edition=2024','-Cprefer-dynamic','-Zinline-mir','-Cllvm-args=-import-instr-limit=10','--emit=link,llvm-ir,asm']+(['-Clinker='+str(r/'x86-cc')]if target.startswith('x86')else[])
 for source,name,extra in [('stack-probe.rs','stack-probe',[]),('benches.rs','benches-nostack',['--test','-Cllvm-args=-no-stack-coloring'])]+([('benches.rs','benches-noldst',['--test','-Cllvm-args=-aarch64-enable-ldst-opt=false'])]if target.startswith('aarch64')else[]):
  c=common+extra+[str(r/source),'-o',str(out/name)];p=subprocess.run(c,env=e,capture_output=True,text=True);(out/(name+'.build.log')).write_text(str(c)+'\n'+p.stdout+p.stderr);assert p.returncode==0,p.stderr;cmds.append(c)
(r/'diagnostic-build-commands.json').write_text(json.dumps(cmds,indent=2))
