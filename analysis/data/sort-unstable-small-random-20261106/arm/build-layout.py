from pathlib import Path
import subprocess,json,os,re,hashlib,shutil,sys
r=Path('/tmp/sort-small-random-20261106');cc='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/bin/rustc';e=os.environ.copy();e['LD_LIBRARY_PATH']='/home/wheel/c00936152/rust-analysis/build/aarch64-unknown-linux-gnu/stage1/lib';cmds=[]
(r/'link-capture.py').chmod(0o755)
allcmd=json.loads((r/'build-commands.json').read_text())
for target in ['aarch64-unknown-linux-gnu','x86_64-unknown-linux-gnu']:
 for name in ['benches','counted']:
  out=r/target/'layout-build';out.mkdir(exist_ok=True)
  original=next(c for c in allcmd if c[-1]==str(r/target/(name+'-base')))
  c=[v for v in original if not v.startswith('-Clinker=')];c[c.index('-o')+1]=str(out/name);c+=['-Clinker='+str(r/'link-capture.py'),'-Csave-temps'];e['SORT_LAYOUT_TARGET']=target;e['SORT_LAYOUT_NAME']=name
  if 'resume' not in sys.argv:
   p=subprocess.run(c,env=e,text=True,capture_output=True);(out/(name+'-build.log')).write_text(str(c)+'\n'+p.stdout+p.stderr);assert p.returncode==0,p.stderr
  cmds.append(c)
  args=json.loads((out/(name+'-captured-link.json')).read_text());objects=[Path(a)for a in args if a.endswith('.o')and Path(a).exists()];selected=None
  for obj in objects:
   nm=subprocess.check_output(['nm',str(obj)],text=True)
   syms=[l.split()[-1]for l in nm.splitlines()if 'sort_unstable_small_random' in l and len(l.split())>=3 and l.split()[-2] in ['t','T','w','W']]
   if syms:assert selected is None;selected=(obj,syms[0])
  assert selected,objects
  obj,symbol=selected;section='.text.'+symbol
  headers=subprocess.check_output(['objdump','-h',str(obj)],text=True);assert section in headers,section
  shutil.copy2(obj,out/(name+'-original.o'))
  (out/(name+'-selected.json')).write_text(json.dumps(dict(object=str(obj),symbol=symbol,section=section,object_sha256=hashlib.sha256(obj.read_bytes()).hexdigest()),indent=2))
  # Change only section placement. Relocations are resolved by the existing linker.
  if target.startswith('x86'):
   if not (out/(name+'-placed.o')).exists():print('needs local x86 objcopy',target,name,flush=True);continue
  else:subprocess.run(['objcopy','--rename-section',section+'=.sort_case',str(obj),str(out/(name+'-placed.o'))],check=True)
  linker='/usr/bin/cc' if target.startswith('aarch64') else '/tmp/contains-stdlib-20261105/x86-cc'
  placed=[]
  for offset in range(0,256,16):
   exe=r/target/(name+f'-layout{offset:03}');la=[str(out/(name+'-placed.o'))if a==str(obj)else a for a in args];la[la.index('-o')+1]=str(exe);la+=['-Wl,--section-start=.sort_case='+hex(0x1000000+offset)]
   p=subprocess.run([linker]+la,env=e,text=True,capture_output=True);assert p.returncode==0,p.stderr
   nm=subprocess.check_output(['nm','-S',str(exe)],text=True);line=next(l for l in nm.splitlines()if l.split()[-1]==symbol);assert int(line.split()[0],16)==0x1000000+offset,line
   placed.append(dict(offset=offset,exe=str(exe),symbol_line=line,command=[linker]+la))
  (out/(name+'-placements.json')).write_text(json.dumps(placed,indent=2));print('layout built',target,name,flush=True)
(r/'layout-build-commands.json').write_text(json.dumps(cmds,indent=2))
