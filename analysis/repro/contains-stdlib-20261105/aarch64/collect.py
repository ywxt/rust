import pathlib,json,statistics,collections,hashlib,platform,subprocess
r=pathlib.Path(__file__).resolve().parent;arm=platform.machine()=='aarch64';target='aarch64-unknown-linux-gnu' if arm else 'x86_64-unknown-linux-gnu'
b=json.loads((r/'bench-results.json').read_text());m=json.loads((r/'matrix-results.json').read_text());assert len(b)==168 and len(m)==864
assert all(len(v['running_percent'])>=4 and min(v['running_percent'])==100 for v in b+m)
def agg(rows,keys,metrics):
 groups=collections.defaultdict(list)
 for v in rows:groups[tuple(v[k] for k in keys)].append(v)
 out=[]
 for k,vs in groups.items():
  assert len(vs)==3
  v=dict(zip(keys,k));v.update({f:statistics.median(x[f] for x in vs) for f in metrics});v.update({f+'_range':[min(x[f] for x in vs),max(x[f] for x in vs)] for f in metrics});out.append(v)
 return out
checks={v:{name:(r/v/target/(name+'.log')).read_text() for name in ['check','custom-check']} for v in ['baseline','optimized']}
sha={f:hashlib.sha256((r/f).read_bytes()).hexdigest() for f in ['benches.rs','check.rs','custom-check.rs','matrix.rs','fixtures.rs','run-benches.py','run-matrix.py']}
env={}
for name,cmd in [('cpu',['lscpu']),('kernel',['uname','-a']),('libc',['ldd','--version']),('perf',['perf','--version'])]:
 p=subprocess.run(cmd,capture_output=True,text=True);env[name]=p.stdout+p.stderr
s={'architecture':platform.machine(),'target':target,'bench':agg(b,['variant','bench'],['ns','cycles_est','instructions_est']),'matrix':agg(m,['length','offset','distribution','needle','variant'],['cycles','instructions','branches','branch_misses','ns_cpu']),'checks':checks,'source_sha256':sha,'environment':env,'pmu_running_percent_min':min(x for v in b+m for x in v['running_percent']),'run_journal':json.loads((r/'run-journal.json').read_text()),'bench_journal':json.loads((r/'bench-complete.json').read_text()),'matrix_journal':json.loads((r/'matrix-complete.json').read_text()),'compiler_and_source':json.loads((r/'compiler-and-source.json').read_text())}
assert s['matrix_journal']['start']>=s['bench_journal']['end'];(r/'summary.json').write_text(json.dumps(s,ensure_ascii=False,indent=2));print('collected actual std',s['architecture'],len(b),len(m))
