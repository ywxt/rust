from pathlib import Path
import tarfile
r=Path(__file__).resolve().parent;target='x86_64-unknown-linux-gnu';out=r/'x86-evidence-final.tar.gz';gcc=Path('/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib/libgcc_s.so.1')
def add_file(t,p,arc):
 if p.is_file() and not p.is_symlink():t.add(p,arcname=arc,recursive=False)
with tarfile.open(out,'w:gz') as t:
 for p in r.iterdir():
  if p.is_file() and p.suffix in ['.rs','.py','.json','.log','.txt','.md','.data']:add_file(t,p,'x86_64/'+p.name)
 for v in ['baseline','optimized']:
  for p in (r/v/target).iterdir():add_file(t,p,'x86_64/'+str(p.relative_to(r)))
  for p in (r/'sysroots'/v/'lib/rustlib'/target/'lib').glob('*.so'):add_file(t,p,'x86_64/'+str(p.relative_to(r)))
  add_file(t,gcc,'x86_64/sysroots/'+v+'/lib/rustlib/'+target+'/lib/libgcc_s.so.1')
 prev=r/'previous-v1'
 for p in prev.iterdir():
  if p.is_file():add_file(t,p,'previous-v1/x86_64/'+p.name)
 for p in (prev/'optimized'/target).iterdir():add_file(t,p,'previous-v1/x86_64/optimized/'+target+'/'+p.name)
 for p in (prev/'sysroots/optimized/lib/rustlib'/target/'lib').glob('*.so'):add_file(t,p,'previous-v1/x86_64/sysroots/optimized/lib/rustlib/'+target+'/lib/'+p.name)
print('x86 lean evidence archive',out.stat().st_size)
