from pathlib import Path
import subprocess,os,sys,json,hashlib,shutil,re
r=Path(__file__).resolve().parent;v=sys.argv[1];assert v in ['baseline','candidate','mask','combined'];sysroot=r/'sysroots'/v;sysroot.mkdir(parents=True,exist_ok=False);manifest={};cmds=[]
for target in ['aarch64-unknown-linux-gnu','x86_64-unknown-linux-gnu']:
 base=Path('/tmp/contains-bad-simd-build/aarch64-unknown-linux-gnu/stage0-std')/target/'dist/build';dest=sysroot/'lib/rustlib'/target/'lib';dest.mkdir(parents=True);fs=[]
 for f in base.glob('*/*/out/*'):
  if f.is_file()and f.suffix in ['.rmeta','.rlib','.so']and f.name.startswith('lib'):
   if(dest/f.name).exists():assert(dest/f.name).read_bytes()==f.read_bytes()
   else:shutil.copy2(f,dest/f.name)
 assert len(list(dest.glob('libcore-*.rmeta')))==len(list(dest.glob('libstd-*.rmeta')))==1
 manifest[target]={f.name:hashlib.sha256(f.read_bytes()).hexdigest()for f in dest.iterdir()}
 compiler='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/bin/rustc';e=os.environ.copy();e['LD_LIBRARY_PATH']='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/lib';out=r/v/target;out.mkdir(parents=True)
 for name in ['benches','counted','scenarios']:
  c=[compiler,str(r/(name+'.rs')),'--sysroot',str(sysroot),'--target',target,'-O','--edition=2024','-Cprefer-dynamic','-Zinline-mir','-Cllvm-args=-import-instr-limit=10','--emit=link,llvm-ir,asm','-o',str(out/name)]+(['--test']if name=='benches'else[])+(['-Clinker='+str(r/'x86-cc')]if target.startswith('x86')else[])
  p=subprocess.run(c,env=e,capture_output=True,text=True);(out/(name+'-build.log')).write_text(str(c)+'\n'+p.stdout+p.stderr);assert p.returncode==0,p.stderr;cmds.append(c)
 print('built drivers',v,target,flush=True)
(r/(v+'-sysroot-manifest.json')).write_text(json.dumps(manifest,indent=2));(r/(v+'-driver-commands.json')).write_text(json.dumps(cmds,indent=2))
if v=='baseline':
 origin=Path('/home/wheel/c00936152/rust-analysis/library/alloctests/benches/str.rs').read_text();copy=(r/'benches.rs').read_text()
 def body(s,n):
  begin=s.index('fn '+n+'(');begin=s.index('{',begin);depth=0
  for i in range(begin,len(s)):
   if s[i]=='{':depth+=1
   elif s[i]=='}':
    depth-=1
    if depth==0:return s[begin:i+1]
 names=re.findall(r'fn (bench_contains_\w+)\(',origin);check={}
 for n in names:
  a,b=body(origin,n),body(copy,n);tokens=lambda t:re.findall(r'"(?:[^"\\]|\\.)*"|\w+|[^\s]',t);assert tokens(a)==tokens(b),n;check[n]=hashlib.sha256(a.encode()).hexdigest()
 (r/'original-bench-body-check.json').write_text(json.dumps(check,indent=2));print('unchanged original benchmark bodies',len(check),flush=True)
