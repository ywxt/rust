import pathlib,platform,subprocess,json,time,re,os
r=pathlib.Path(__file__).resolve().parent;arch=platform.machine();arm=arch=='aarch64';target='aarch64-unknown-linux-gnu' if arm else 'x86_64-unknown-linux-gnu';core='52' if arm else '12'
p=subprocess.run(['setarch',arch,'-R','true'],capture_output=True,text=True);no_aslr=p.returncode==0
for alias,variant in [('v0','main'),('v1','manual'),('v2','simd16'),('v3','simd64')]:
 for base in [r,r/'sysroots']:
  pth=base/alias
  if not pth.exists():pth.symlink_to(base/variant,target_is_directory=True)
  assert pth.resolve()==(base/variant).resolve()
source=(r/'counted.rs').read_text();names=['str::'+x for x in re.findall(r'pub fn (\w+)\(b: &mut Bencher\)',source)];assert len(names)==28
rows=[];start=time.time()
for trial in range(3):
 for case in names if trial%2==0 else names[::-1]:
  heavy=any(k in case for k in ['long_lorem','2b_repeated_long','short_long','16b_in_long','32b_in_long','bad_simd','extra_nul','extra_ascii_char','unicode_char_miss','unicode_str_miss'])
  n=2000000 if heavy else 10000000
  for alias,variant in [('v0','main'),('v1','manual'),('v2','simd16'),('v3','simd64')] if trial%2==0 else [('v3','simd64'),('v2','simd16'),('v1','manual'),('v0','main')]:
   libs=str(r/'sysroots'/alias/'lib/rustlib'/target/'lib')+('' if arm else ':/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib')
   cmd=['taskset','-c',core,'env','-u','LD_LIBRARY_PATH','perf','stat','-x',',','-e','cycles:u,instructions:u,branches:u,branch-misses:u,task-clock,context-switches,cpu-migrations','--','env','LD_LIBRARY_PATH='+libs]+(['setarch',arch,'-R'] if no_aslr else [])+[str(r/alias/target/'counted'),case,str(n)]
   wall_start=time.monotonic();p=subprocess.run(cmd,capture_output=True,text=True);wall=time.monotonic()-wall_start;(r/f'counted-{trial}-{variant}-{case}.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stderr
   personality=int(re.search(r'personality=([0-9a-fA-F]+)',p.stderr)[1],16)
   assert not no_aslr or personality & 0x40000
   ev={};running=[]
   for line in p.stderr.splitlines():
    f=line.split(',')
    if len(f)<3 or 'cpu_atom' in f[2]:continue
    try:v=float(f[0])
    except ValueError:continue
    k=f[2].replace('cpu_core/','').replace('/u','').replace(':u','').rstrip('/');ev[k]=v
    if k in ['cycles','instructions','branches','branch-misses'] and len(f)>4:
     try:running.append(float(f[4]))
     except ValueError:pass
   rows.append({'trial':trial,'case':case,'variant':variant,'n':n,'cycles':ev['cycles']/n,'instructions':ev['instructions']/n,'branches':ev['branches']/n,'branch_misses':ev['branch-misses']/n,'ns_cpu':ev['task-clock']*1e6/n,'elapsed_wall':wall,'cpu_wall_ratio':ev['task-clock']/1000/wall,'events':ev,'running_percent':running,'aslr_disabled':no_aslr});(r/'counted-results.json').write_text(json.dumps(rows,indent=2))
 print('counted trial',trial,'complete',len(rows),'ASLR off',no_aslr,flush=True)
(r/'counted-complete.json').write_text(json.dumps({'start':start,'end':time.time(),'rows':len(rows),'aslr_disabled':no_aslr,'equal_length_variant_aliases':True}))
