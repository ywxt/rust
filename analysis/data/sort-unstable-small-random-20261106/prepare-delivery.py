from pathlib import Path
import shutil,json,hashlib
r=Path(__file__).resolve().parent;d=r/'delivery'
shutil.copytree(r/'arm-final',d/'arm',dirs_exist_ok=True)
x=d/'x86';x.mkdir(exist_ok=True)
for p in r.iterdir():
 if p.is_file()and('.x86_64.'in p.name or p.name in ['environment.x86_64.json','overlap-note.json']):shutil.copy2(p,x/p.name)
shutil.copytree(r/'x86_64-unknown-linux-gnu',x/'x86_64-unknown-linux-gnu',dirs_exist_ok=True)
for f in ['validate-layout.py','summarize.py','prepare-delivery.py','layout-validation.json']:
 shutil.copy2(r/f,d/f)
shutil.copy2(r/'chapter.md',d/'chapter-in-conclusion.md')
for arch,p in [('aarch64',d/'arm'),('x86_64',x)]:
 for variant in ['base','nounroll','nolsr']:
  f=p/f'check.{variant}.{arch}.txt';assert 'CHECK_OK'in f.read_text(),str(f)
 for phase,n in [('target',60 if arch=='aarch64'else 30),('related',66),('probes',549),('layout',96),('nolsr',20),('nolsr-probes',549)]:
  rows=json.loads((p/f'{phase}.{arch}.json').read_text());assert len(rows)==n;assert all(min(v['running'].values())==100 for v in rows);assert all(v['metrics']['cpu-migrations']==0 for v in rows)
manifest={str(p.relative_to(d)):hashlib.sha256(p.read_bytes()).hexdigest()for p in sorted(d.rglob('*'))if p.is_file()and p.name!='SHA256SUMS.json'}
(d/'SHA256SUMS.json').write_text(json.dumps(manifest,indent=2));print('Validated artifact files',len(manifest))
