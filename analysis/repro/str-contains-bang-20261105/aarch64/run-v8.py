import pathlib,json,time,os
journal=[];artifact_root=pathlib.Path('/tmp/str-contains-bang-20261105')
def phase(name,state):
 journal.append({'phase':name,'state':state,'monotonic':time.monotonic(),'pid':os.getpid()})
 (artifact_root/'v8-run-journal.json').write_text(json.dumps(journal,indent=2))
 print('v8',name,state,flush=True)
phase('matrix','start')
import pathlib,platform,subprocess,json
r=pathlib.Path('/tmp/str-contains-bang-20261105');arm=platform.machine()=='aarch64';core='52' if arm else '12';libs=pathlib.Path('/tmp/xdiff/libdir.txt').read_text().strip();rows=[]
for trial in range(3):
 cases=[('default',r/'bang-probe-v7',mode,off,'original') for off in [0,8,16,32] for mode in ['std_str','word16','simd64','aligned64','align32','align64']]
 cases += [('default',r/'bang-probe-v7',mode,off,dist) for off in [0,1] for dist in ['absent','front'] for mode in ['simd64','align32','align64']]
 if arm:cases += [('no-pair',r/'ldp-alignment'/'no-pair',mode,off,'original') for off in [0,8,16,32] for mode in ['word16','simd64']]
 for variant,bin,mode,off,dist in cases if trial%2==0 else cases[::-1]:
  n=10000000 if dist=='front' else 1000000
  p=subprocess.run(['taskset','-c',core,'env','-u','LD_LIBRARY_PATH','perf','stat','-x',',','-e','cycles:u,instructions:u,branches:u,branch-misses:u,task-clock','--','env','LD_LIBRARY_PATH='+libs,str(bin),mode,'3',str(n),str(off),dist],capture_output=True,text=True);assert p.returncode==0,p.stderr
  (r/f'matrix-v8-{trial}-{variant}-{mode}-{off}-{dist}.log').write_text(p.stdout+p.stderr);e={}
  for line in p.stderr.splitlines():
   a=line.split(',')
   if len(a)<3 or 'cpu_atom' in a[2]:continue
   try:v=float(a[0])
   except ValueError:continue
   k=a[2].replace('cpu_core/','').replace('/u','').replace(':u','').rstrip('/');e[k]=v
  rows.append({'trial':trial,'variant':variant,'mode':mode,'offset':off,'distribution':dist,'cycles':e['cycles']/n,'instructions':e['instructions']/n,'branches':e['branches']/n,'branch_misses':e['branch-misses']/n,'ns_cpu':e['task-clock']*1e6/n})
  (r/'matrix-v8-results.json').write_text(json.dumps(rows,indent=2))
 print('matrix trial',trial,'completed',flush=True)

phase('matrix','complete')
phase('guarded-stat','start')

import os,platform,subprocess,pathlib,re,json
root=pathlib.Path('/tmp/str-contains-bang-20261105')
root.mkdir(exist_ok=True)
arm=platform.machine()=='aarch64'; core='52' if arm else '12'
binary=str(root/'bang-benches-v8')
libs=pathlib.Path('/tmp/xdiff/libdir.txt').read_text().strip()
names=[kind+'::'+case for kind in ['contains_bang_str','contains_bang_char','simd64_str','simd64_char','align32_str','align32_char','align64_str','align64_char'] for case in ['short_ascii','short_mixed','short_pile_of_poo','long_lorem_ipsum']]
events='cycles:u,instructions:u,branches:u,branch-misses:u,L1-dcache-load-misses:u,task-clock,context-switches,cpu-migrations'
records=[]
for trial in range(3):
    for name in names if trial%2==0 else names[::-1]:
        p=subprocess.run(['taskset','-c',core,'env','-u','LD_LIBRARY_PATH','perf','stat','-x',',','-e',events,'--','env','LD_LIBRARY_PATH='+libs,binary,'--bench','str::'+name,'--exact','--format=terse'],capture_output=True,text=True,timeout=180)
        (root/f'guarded-v8-{trial}-{name}.stdout').write_text(p.stdout)
        (root/f'guarded-v8-{trial}-{name}.perf').write_text(p.stderr)
        match=re.search(r'([\d,.]+)ns/iter',p.stdout) or re.search(r'bench:\s+([\d,.]+) ns/iter',p.stdout)
        rec={'trial':trial,'bench':name,'code':p.returncode,'ns':float(match.group(1).replace(',','')) if match else None,'events':{}}
        for line in p.stderr.splitlines():
            f=line.split(',')
            if len(f)>=3 and 'cpu_atom' not in f[2]:
                try: val=float(f[0])
                except ValueError: continue
                key=f[2].replace('cpu_core/','').replace('/u','').replace(':u','').rstrip('/')
                rec['events'][key]={'value':val,'unit':f[1]}
        records.append(rec)
        (root/'guarded-v8-stat-results.json').write_text(json.dumps(records,indent=2))
        pass
        assert p.returncode==0 and rec['ns'] is not None,p.stdout+p.stderr

    print('v8 guarded trial',trial,'completed',flush=True)

data=json.loads((root/'guarded-v8-stat-results.json').read_text());assert len(data)==96
checks=[]
for v in data:
 e={k:x['value'] for k,x in v['events'].items()};c=v['ns']*e['cycles']/e['task-clock']/1e6;ins=c*e['instructions']/e['cycles']
 assert ins>(100 if 'long' in v['bench'] else 15),(v['bench'],ins)
 checks.append({'trial':v['trial'],'bench':v['bench'],'instructions_est':ins})
(root/'guarded-v8-no-hoisting-check.json').write_text(json.dumps(checks,indent=2))

phase('guarded-stat','complete')
phase('record','start')
import pathlib,platform,subprocess
r=pathlib.Path('/tmp/str-contains-bang-20261105');arm=platform.machine()=='aarch64';core='52' if arm else '12';libs=pathlib.Path('/tmp/xdiff/libdir.txt').read_text().strip()
for name in ['align32_str::long_lorem_ipsum','align64_str::long_lorem_ipsum','align32_str::short_ascii']:
 data=r/('guarded-v8-'+name+'.data')
 p=subprocess.run(['taskset','-c',core,'env','-u','LD_LIBRARY_PATH','perf','record','-o',str(data),'-e','cycles:u','-c','500003','--','env','LD_LIBRARY_PATH='+libs,str(r/'bang-benches-v8'),'--bench','str::'+name,'--exact','--format=terse'],capture_output=True,text=True);assert p.returncode==0,p.stderr
 (r/('guarded-v8-'+name+'-record.log')).write_text(p.stdout+p.stderr)
 for tool in ['report','annotate']:
  a=['env','-u','LD_LIBRARY_PATH','perf',tool,'-i',str(data),'--stdio']
  if tool=='report':a+=['--percent-limit','1','--sort','symbol']
  q=subprocess.run(a,capture_output=True,text=True);assert q.returncode==0,q.stderr;(r/('guarded-v8-'+name+'-'+tool+'.txt')).write_text(q.stdout+q.stderr)
 print('v8 recorded',name,flush=True)

phase('record','complete')
