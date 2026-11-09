import pathlib,platform,subprocess,json,re
r=pathlib.Path(__file__).resolve().parent
arm=platform.machine()=='aarch64'; core='52' if arm else '12'
bins=pathlib.Path('/tmp/xdiff/bins.txt').read_text().splitlines();binary=bins[0 if arm else 1]
libs=pathlib.Path('/tmp/xdiff/libdir.txt').read_text().strip()
names=['short_short','2b_repeated_long','short_long','16b_in_long','32b_in_long','bad_naive','bad_simd','equal']; rows=[]
for trial in range(3):
 for name in names if trial%2==0 else names[::-1]:
  case='str::bench_contains_'+name
  cmd=['taskset','-c',core,'env','-u','LD_LIBRARY_PATH','perf','stat','-x',',','-e','cycles:u,instructions:u,branches:u,branch-misses:u,task-clock','--','env','LD_LIBRARY_PATH='+libs,binary,'--bench',case,'--exact','--format=terse']
  p=subprocess.run(cmd,capture_output=True,text=True);(r/f'existing-{trial}-{name}.log').write_text(p.stdout+p.stderr)
  assert p.returncode==0,p.stderr
  m=re.search(r'([\d,.]+)ns/iter',p.stdout) or re.search(r'bench:\s+([\d,.]+) ns/iter',p.stdout); assert m,p.stdout
  ev={}
  for line in p.stderr.splitlines():
   f=line.split(',')
   if len(f)<3 or 'cpu_atom' in f[2]:continue
   try:v=float(f[0])
   except ValueError:continue
   k=f[2].replace('cpu_core/','').replace('/u','').replace(':u','').rstrip('/');ev[k]=v
  ns=float(m[1].replace(',',''));rows.append({'trial':trial,'bench':name,'ns':ns,'cycles_est':ns*ev['cycles']/ev['task-clock']/1e6,'events':ev})
  (r/'existing-results.json').write_text(json.dumps(rows,indent=2))
 print('existing trial',trial,'completed',flush=True)
