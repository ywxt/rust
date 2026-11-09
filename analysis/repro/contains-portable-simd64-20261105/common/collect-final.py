import pathlib,json,statistics,collections,hashlib,platform,subprocess,re
r=pathlib.Path(__file__).resolve().parent;arch=platform.machine();target='aarch64-unknown-linux-gnu' if arch=='aarch64' else 'x86_64-unknown-linux-gnu'
def read(name,n):
 rows=json.loads((r/name).read_text());assert len(rows)==n,(name,len(rows));assert all(min(v['running_percent'])==100 for v in rows);return rows
b=read('bench-results.json',168);c=read('counted-results.json',168);m=read('matrix-results.json',1728)
def agg(rows,keys,metrics):
 groups=collections.defaultdict(list)
 for v in rows:groups[tuple(v[k] for k in keys)].append(v)
 out=[]
 for k,vs in groups.items():
  assert len(vs)==3
  v=dict(zip(keys,k));v.update({f:statistics.median(x[f] for x in vs) for f in metrics});v.update({f+'_range':[min(x[f] for x in vs),max(x[f] for x in vs)] for f in metrics});out.append(v)
 return out
audit=[]
for v in b:
 text=(r/f"bench-{v['trial']}-{v['variant']}-{v['bench']}.log").read_text();match=re.search(r'finished in ([0-9.]+)s',text)
 if match:
  wall=float(match[1]);cpu=v['events']['task-clock']/1000;audit.append({'trial':v['trial'],'variant':v['variant'],'bench':v['bench'],'ns':v['ns'],'wall_seconds':wall,'cpu_seconds':cpu,'cpu_wall_ratio':cpu/wall if wall else None})
(r/'libtest-timing-audit.json').write_text(json.dumps(audit,indent=2))
sha={f:hashlib.sha256((r/f).read_bytes()).hexdigest() for f in ['benches.rs','counted.rs','check.rs','custom-check.rs','matrix.rs','fixtures.rs','run-benches.py','run-counted.py','run-matrix.py']};env={}
for name,cmd in [('cpu',['lscpu']),('kernel',['uname','-a']),('libc',['ldd','--version']),('perf',['perf','--version'])]:
 p=subprocess.run(cmd,capture_output=True,text=True);env[name]=p.stdout+p.stderr
checks={v:{name:(r/v/target/(name+'.log')).read_text() for name in ['check','custom-check']} for v in ['baseline','optimized']}
s={'architecture':arch,'target':target,'primary_measurement':'fixed-count cycles:u/N; equal-length aliases; per-process ASLR disabled if supported; original query bodies retained','counted':agg(c,['variant','case'],['cycles','instructions','branches','branch_misses','ns_cpu','cpu_wall_ratio']),'bench':agg(b,['variant','bench'],['ns','cycles_est','instructions_est']),'libtest_timing_audit':audit,'matrix':agg(m,['length','offset','distribution','needle','pattern','variant'],['cycles','instructions','branches','branch_misses','ns_cpu']),'checks':checks,'source_sha256':sha,'environment':env,'pmu_running_percent_min':100,'run_journal':json.loads((r/'run-journal.json').read_text()),'bench_journal':json.loads((r/'bench-complete.json').read_text()),'counted_journal':json.loads((r/'counted-complete.json').read_text()),'matrix_journal':json.loads((r/'matrix-complete.json').read_text()),'compiler_and_source':json.loads((r/'compiler-and-source.json').read_text())}
assert s['counted_journal']['start']>=s['bench_journal']['end'];assert s['matrix_journal']['start']>=s['counted_journal']['end'];(r/'summary.json').write_text(json.dumps(s,ensure_ascii=False,indent=2));print('collected final actual std',arch,len(b),len(c),len(m),'ASLR off',s['counted_journal']['aslr_disabled'])
