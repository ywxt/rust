import pathlib,subprocess,platform,json,time,hashlib
r=pathlib.Path(__file__).resolve().parent;arch=platform.machine();target='aarch64-unknown-linux-gnu' if arch=='aarch64' else 'x86_64-unknown-linux-gnu';journal=[]
def mark(stage,state):
 journal.append({'stage':stage,'state':state,'time':time.time()});(r/'run-journal.json').write_text(json.dumps(journal,indent=2));print(stage,state,flush=True)
mark('verify','start')
for variant in ['baseline','optimized']:
 expected=json.loads((r/(variant+'-sysroot-manifest.json')).read_text())[target];lib=r/'sysroots'/variant/'lib/rustlib'/target/'lib'
 for f,sha in expected.items():assert hashlib.sha256((lib/f).read_bytes()).hexdigest()==sha,(variant,f)
 for name in ['check','custom-check']:
  out=r/variant/target;log=out/(name+'.log')
  if not log.exists():
   libs=str(lib)+(':/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib' if arch!='aarch64' else '')
   p=subprocess.run(['env','LD_LIBRARY_PATH='+libs,str(out/name)],capture_output=True,text=True);log.write_text(p.stdout+p.stderr);print(variant,name,p.stdout,flush=True);assert p.returncode==0,p.stderr
  assert 'passed' in log.read_text()
mark('verify','complete')
for name in ['benches','counted','matrix']:
 mark(name,'start');subprocess.run(['python3',str(r/('run-'+name+'.py'))],check=True);mark(name,'complete')
