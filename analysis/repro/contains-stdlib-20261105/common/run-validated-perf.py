import pathlib,subprocess,platform,json,time,hashlib
r=pathlib.Path(__file__).resolve().parent;arm=platform.machine()=='aarch64';target='aarch64-unknown-linux-gnu' if arm else 'x86_64-unknown-linux-gnu';journal=[]
def phase(name,state):
 journal.append({'phase':name,'state':state,'time':time.time()});(r/'run-journal.json').write_text(json.dumps(journal,indent=2));print(name,state,flush=True)
phase('verify','start')
for v in ['baseline','optimized']:
 expected=json.loads((r/(v+'-sysroot-manifest.json')).read_text())[target];lib=r/'sysroots'/v/'lib/rustlib'/target/'lib'
 for name,sha in expected.items():assert hashlib.sha256((lib/name).read_bytes()).hexdigest()==sha,(v,name)
if not all((r/v/target/(name+'.log')).exists() for v in ['baseline','optimized'] for name in ['check','custom-check']):subprocess.run(['python3',str(r/'run-checks.py')],check=True)
for v in ['baseline','optimized']:
 assert 'passed 5573952' in (r/v/target/'check.log').read_text()
 assert 'passed custom Pattern' in (r/v/target/'custom-check.log').read_text()
phase('verify','complete')
for name in ['benches','matrix']:
 phase(name,'start');subprocess.run(['python3',str(r/('run-'+name+'.py'))],check=True);phase(name,'complete')
