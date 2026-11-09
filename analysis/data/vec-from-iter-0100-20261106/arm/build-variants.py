from pathlib import Path
import subprocess,os,json
r=Path(__file__).resolve().parent;compiler='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/bin/rustc';env=os.environ.copy();env['LD_LIBRARY_PATH']='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/lib';commands=[]
variants={'base':[],'interleave4':['-Cllvm-args=-force-vector-interleave=4'],'interleave8':['-Cllvm-args=-force-vector-interleave=8'],'noldst':['-Cllvm-args=-aarch64-enable-ldst-opt=false'],'nostack':['-Cllvm-args=-no-stack-coloring']}
s=(r/'counted.rs').read_text();s=s.replace('let mut b=Bencher{bytes:0,n};let t=', 'let worker=args.get(3).is_some_and(|s|s=="worker");let task=move||{let mut b=Bencher{bytes:0,n};let t=').replace('t.elapsed().as_nanos(),n);}', 't.elapsed().as_nanos(),n);};if worker{std::thread::spawn(task).join().unwrap()}else{task()}}');(r/'counted.rs').write_text(s)
for target in ['aarch64-unknown-linux-gnu','x86_64-unknown-linux-gnu']:
 out=r/target;common=[compiler,'--sysroot','/tmp/contains-bad-simd-20261105/sysroots/baseline','--target',target,'-O','--edition=2024','-Cprefer-dynamic','-Zinline-mir','-Cllvm-args=-import-instr-limit=10','--emit=link,asm,llvm-ir']+(['-Clinker=/tmp/contains-stdlib-20261105/x86-cc']if target.startswith('x86')else[])
 configs=[('benches',v,f)for v,f in variants.items()if v!='noldst'or target.startswith('aarch64')]+[('counted','base',[]),('diagnostics','base',[])]
 for name,v,flags in configs:
  c=common+flags+(['--test']if name=='benches'else[])+[str(r/(name+'.rs')),'-o',str(out/(name+'-'+v))];p=subprocess.run(c,env=env,text=True,capture_output=True);(out/(name+'-'+v+'-build.log')).write_text(str(c)+'\n'+p.stdout+p.stderr);assert p.returncode==0,p.stderr;commands.append(c)
 print('variants built',target,flush=True)
(r/'variant-commands.json').write_text(json.dumps(commands,indent=2))
