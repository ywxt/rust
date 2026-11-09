from pathlib import Path
import subprocess,sys,json,time,platform
r=Path(__file__).resolve().parent;arch=platform.machine();journal=[]
for phase in ['check','bench','profile','cases','matrix','flags','alu']:
 journal.append(dict(phase=phase,state='start',time=time.time()));(r/f'journal.{arch}.json').write_text(json.dumps(journal,indent=2))
 with (r/f'{phase}.{arch}.log').open('w')as f:p=subprocess.run([sys.executable,str(r/'run.py'),phase],stdout=f,stderr=subprocess.STDOUT)
 assert p.returncode==0,(phase,p.returncode)
 journal.append(dict(phase=phase,state='complete',time=time.time()));(r/f'journal.{arch}.json').write_text(json.dumps(journal,indent=2));print(phase,'complete',flush=True)
