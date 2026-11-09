from pathlib import Path
import subprocess,os,json
r=Path('/tmp/sort-small-random-20261106');cc='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/bin/rustc';sysroot='/tmp/contains-bad-simd-20261105/sysroots/baseline';reg=Path('/home/wheel/.cargo/registry/src/rsproxy.cn-e3de039b2554c837');e=os.environ.copy();e['LD_LIBRARY_PATH']='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/lib';commands=[]
variants={'base':[],'noselect':['-Cllvm-args=-aarch64-select-opt=false'],'noifcvt':['-Cllvm-args=-aarch64-enable-early-ifcvt=false'],'nostack':['-Cllvm-args=-no-stack-coloring'],'noldst':['-Cllvm-args=-aarch64-enable-ldst-opt=false'],'nounroll':['-Cllvm-args=-unroll-threshold=0','-Cllvm-args=-unroll-partial-threshold=0']}
def run(c,log):
 p=subprocess.run(c,env=e,text=True,capture_output=True);log.write_text(str(c)+'\n'+p.stdout+p.stderr);assert p.returncode==0,p.stderr;commands.append(c)
for target in ['aarch64-unknown-linux-gnu','x86_64-unknown-linux-gnu']:
 out=r/target;out.mkdir(exist_ok=True);deps=out/'deps';deps.mkdir(exist_ok=True)
 common=[cc,'--sysroot',sysroot,'--target',target,'-O','-Cprefer-dynamic','--edition=2021']
 for name,version,extra in [('rand_core','0.9.3',[]),('rand','0.9.3',['--cfg','feature="alloc"','--extern','rand_core='+str(deps/'librand_core.rlib')]),('rand_xorshift','0.4.0',['--extern','rand_core='+str(deps/'librand_core.rlib')])]:
  run(common+['--crate-name',name,'--crate-type=rlib',str(reg/(name+'-'+version)/'src/lib.rs'),'-Ldependency='+str(deps)]+extra+['-o',str(deps/('lib'+name+'.rlib'))],deps/(name+'-build.log'))
 app=[cc,'--sysroot',sysroot,'--target',target,'-O','--edition=2024','-Cprefer-dynamic','-Zinline-mir','-Cllvm-args=-import-instr-limit=10','--emit=link,asm,llvm-ir','-Ldependency='+str(deps),'--extern','rand='+str(deps/'librand.rlib'),'--extern','rand_xorshift='+str(deps/'librand_xorshift.rlib')]+(['-Clinker=/tmp/contains-stdlib-20261105/x86-cc']if target.startswith('x86')else[])
 for v,flags in variants.items():
  if target.startswith('x86') and v in ['noselect','noifcvt','noldst']:continue
  for name in ['benches','counted','probes']:
   if name=='probes' and not (r/'probes.rs').exists():continue
   run(app+flags+(['--test']if name=='benches'else[])+[str(r/(name+'.rs')),'-o',str(out/(name+'-'+v))],out/(name+'-'+v+'-build.log'))
  print('built',target,v,flush=True)
(r/'build-commands.json').write_text(json.dumps(commands,indent=2));(r/'rustc-vV.txt').write_text(subprocess.check_output([cc,'-vV'],env=e,text=True))
