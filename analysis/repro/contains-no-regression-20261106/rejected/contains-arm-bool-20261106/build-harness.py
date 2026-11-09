import pathlib,subprocess,os,sys,json
r=pathlib.Path(__file__).resolve().parent;variant=sys.argv[1];assert variant in ['baseline','optimized'];root=r/'sysroots'/variant;compiler='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/bin/rustc';rows=[]
e=os.environ.copy();e['LD_LIBRARY_PATH']='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/lib'
for target in ['aarch64-unknown-linux-gnu','x86_64-unknown-linux-gnu']:
 out=r/variant/target;out.mkdir(parents=True,exist_ok=True)
 for name in (sys.argv[2:] or ['check','custom-check','benches','matrix']):
  cmd=[compiler,str(r/(name+'.rs')),'--sysroot',str(root),'--target',target,'-O','--edition=2024','-Cprefer-dynamic','-Zinline-mir','-Cllvm-args=-import-instr-limit=10','--emit=link,llvm-ir,asm','-o',str(out/name)]
  if name=='benches':cmd+=['--test']
  if target.startswith('x86'):cmd+=['-Clinker='+str(r/'x86-cc')]
  p=subprocess.run(cmd,env=e,capture_output=True,text=True);(out/(name+'-build.log')).write_text(str(cmd)+'\n'+p.stdout+p.stderr);assert p.returncode==0,p.stderr
  rows.append({'target':target,'name':name,'command':cmd})
 (out/'libdir.txt').write_text(str(root/'lib/rustlib'/target/'lib'))
 print('built',variant,target,flush=True)
(r/(variant+'-harness-commands.json')).write_text(json.dumps(rows,indent=2))
