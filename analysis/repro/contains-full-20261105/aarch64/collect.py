import json,pathlib,statistics,collections,hashlib,platform,shutil,subprocess
r=pathlib.Path(__file__).resolve().parent
shutil.copy2('/tmp/str-contains-bang-20261105/environment.json',r/'environment.json')
shutil.copy2('/tmp/xdiff-src/library/alloctests/benches/str.rs',r/'original-str-benches.rs')
b=json.loads((r/'bench-results.json').read_text());m=json.loads((r/'matrix-results.json').read_text());assert len(b)==168 and len(m)==864
assert all(len(v['running_percent'])>=4 and min(v['running_percent'])==100 for v in b+m)
def aggregate(rows,keys,metrics):
 groups=collections.defaultdict(list)
 for v in rows:groups[tuple(v[k] for k in keys)].append(v)
 result=[]
 for key,vs in groups.items():
  assert len(vs)==3
  v=dict(zip(keys,key));v.update({k:statistics.median(t[k] for t in vs) for k in metrics});v.update({k+'_range':[min(t[k] for t in vs),max(t[k] for t in vs)] for k in metrics});result.append(v)
 return result
sha={f:hashlib.sha256((r/f).read_bytes()).hexdigest() for f in ['contains_impl.rs','benches.rs','matrix.rs','check.rs','custom-check.rs','fixtures.rs','build.py','run-benches.py','run-matrix.py','original-str-benches.rs']}
s={'architecture':platform.machine(),'bench':aggregate(b,['bench'],['ns','cycles_est','instructions_est']),'matrix':aggregate(m,['length','offset','distribution','needle','mode'],['cycles','instructions','branches','branch_misses','ns_cpu']),'source_sha256':sha,'check':(r/'check.log').read_text(),'custom_check':(r/'custom-check.log').read_text(),'bench_journal':json.loads((r/'bench-complete.json').read_text()),'matrix_journal':json.loads((r/'matrix-complete.json').read_text()),'pmu_running_percent_min':min(x for v in b+m for x in v['running_percent']),'environment':json.loads((r/'environment.json').read_text())}
assert s['matrix_journal']['start']>=s['bench_journal']['end']
(r/'summary.json').write_text(json.dumps(s,ensure_ascii=False,indent=2));print('collected',s['architecture'],len(b),len(m),sha['contains_impl.rs'])
