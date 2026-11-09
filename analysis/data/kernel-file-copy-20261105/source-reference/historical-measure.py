# 統一量測:對每個 bench 二進位的每個 benchmark 跑 `--bench NAME --exact`,收 ns/iter 與 perf 計數。
# 用法:python3 -I xdiff_measure.py <out.json> <cores,逗號分隔> <bin>...   (環境變數 ARCH=aarch64|x86)
import json, os, re, subprocess, sys, concurrent.futures as cf
out, cores, bins = sys.argv[1], [int(c) for c in sys.argv[2].split(",")], sys.argv[3:]
arch = os.environ["ARCH"]
if arch == "x86":
    ev = "cycles:u,instructions:u,branches:u,branch-misses:u,L1-dcache-load-misses:u,task-clock:u"
    perf = ["env", "-u", "LD_LIBRARY_PATH", "perf"]
else:
    ev = "cycles,instructions,branches,branch-misses,L1-dcache-load-misses,stall_frontend,stall_backend,task-clock"
    perf = ["perf"]
libdir = os.environ.get("BENCH_LIB", "")
env = dict(os.environ, LD_LIBRARY_PATH=libdir)
names = []
for b in bins:
    r = subprocess.run([b, "--list", "--bench"], capture_output=True, text=True, env=env)
    for l in r.stdout.splitlines():
        if l.endswith(": benchmark"):
            names.append((b, l[:-len(": benchmark")]))
try:
    res = json.load(open(out))
except Exception:
    res = {}
todo = [(b, n) for b, n in names if f"{os.path.basename(b)}|{n}" not in res]
print(f"{len(names)} benches, {len(todo)} to run", flush=True)
free = list(cores)
import threading
lock = threading.Lock()
def run(item):
    b, n = item
    with lock:
        core = free.pop()
    try:
        cmd = ["taskset", "-c", str(core)] + perf + ["stat", "-x", ",", "-e", ev, "--", "env", f"LD_LIBRARY_PATH={libdir}", b, "--bench", n, "--exact"]
        r = subprocess.run(cmd, capture_output=True, text=True, timeout=600)
    except subprocess.TimeoutExpired:
        return item, {"err": "timeout"}
    finally:
        with lock:
            free.append(core)
    m = re.search(r"bench:\s+([\d,\.]+) ns/iter \(\+/- ([\d,\.]+)\)", r.stdout)
    rec = {"core": core}
    if m:
        rec["ns"] = float(m.group(1).replace(",", "")); rec["dev"] = float(m.group(2).replace(",", ""))
    else:
        rec["err"] = (r.stdout + r.stderr)[-300:]
    for l in r.stderr.splitlines():
        f = l.split(",")
        if len(f) > 3 and f[0] and f[0][0].isdigit():
            key = f[2]
            if arch == "x86":
                if "cpu_atom" in key: continue
                key = key.replace("cpu_core/", "").replace("/u", "").replace(":u", "")
            rec[key] = float(f[0])
    if "cycles" in rec and "task-clock" in rec and rec["task-clock"] > 0:
        rec["ghz"] = rec["cycles"] / (rec["task-clock"] * 1e6)  # task-clock 單位 ms
    return item, rec
done = 0
with cf.ThreadPoolExecutor(len(cores)) as ex:
    for (b, n), rec in ex.map(run, todo):
        res[f"{os.path.basename(b)}|{n}"] = rec
        done += 1
        if done % 25 == 0:
            json.dump(res, open(out, "w"), indent=0); print(done, flush=True)
json.dump(res, open(out, "w"), indent=0)
print("MEASURE_DONE", flush=True)
