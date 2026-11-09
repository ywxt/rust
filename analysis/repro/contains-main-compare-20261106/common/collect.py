from pathlib import Path
import json,statistics,collections,hashlib,platform,subprocess
r=Path(__file__).parent;arm=platform.machine()=="aarch64";target="aarch64-unknown-linux-gnu" if arm else "x86_64-unknown-linux-gnu"
c=json.loads((r/"counted-results.json").read_text());m=json.loads((r/"matrix-results.json").read_text());assert len(c)==336;assert len(m)==3456
assert all(len(v["running_percent"])==4 and min(v["running_percent"])==100 for v in c+m)
def agg(rows,keys):
 g=collections.defaultdict(list)
 for v in rows:g[tuple(v[k] for k in keys)].append(v)
 out=[]
 for key,vs in g.items():
  assert len(vs)==3
  v=dict(zip(keys,key))
  for metric in ["cycles","instructions","branches","branch_misses","ns_cpu"]:
   values=[x[metric] for x in vs];v[metric]=statistics.median(values);v[metric+"_range"]=[min(values),max(values)]
  out.append(v)
 return out
env={}
for name,cmd in [("cpu",["lscpu"]),("kernel",["uname","-a"]),("libc",["ldd","--version"]),("perf",["perf","--version"])]:
 p=subprocess.run(cmd,capture_output=True,text=True);env[name]=p.stdout+p.stderr
s={"architecture":platform.machine(),"counted":agg(c,["case","variant"]),"matrix":agg(m,["length","offset","distribution","needle","pattern","variant"]),"provenance":json.loads((r/"provenance.json").read_text()),"source_sha256":{f.name:hashlib.sha256(f.read_bytes()).hexdigest() for f in r.iterdir() if f.suffix in [".rs",".py"]},"environment":env,"pmu_running_percent":100,"aslr_disabled":True,"equal_length_path_aliases":True,"cpu_migrations_max":max(x["events"]["cpu-migrations"] for x in c+m),"checks":{v:{n:(r/v/target/(n+".log")).read_text() for n in ["check","custom-check"]} for v in ["main","manual","simd16","simd64"]},"journal":json.loads((r/"run-journal.json").read_text())}
(r/"summary.json").write_text(json.dumps(s,ensure_ascii=False,indent=2));print("collected",platform.machine(),len(c),len(m))
