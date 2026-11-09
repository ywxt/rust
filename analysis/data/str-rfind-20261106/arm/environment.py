from pathlib import Path
import os,subprocess,json,platform,time,hashlib
r=Path(__file__).resolve().parent;arch=platform.machine();core=52 if arch=='aarch64'else 12;meta={'platform':platform.platform(),'time':time.time(),'cpu':core,'commands':{}}
for c in [['uname','-a'],['lscpu'],['perf','--version'],['ldd','--version']]:
 p=subprocess.run(c,text=True,capture_output=True);meta['commands'][' '.join(c)]=dict(returncode=p.returncode,stdout=p.stdout,stderr=p.stderr)
meta['cpu_files']={}
for rel in ['topology/thread_siblings_list','cpufreq/scaling_governor','cpufreq/scaling_driver','cpufreq/scaling_cur_freq','cpufreq/scaling_min_freq','cpufreq/scaling_max_freq']:
 p=Path(f'/sys/devices/system/cpu/cpu{core}')/rel
 if p.exists():meta['cpu_files'][rel]=p.read_text().strip()
meta['proc_stat_before']=Path('/proc/stat').read_text();time.sleep(.25);meta['proc_stat_after']=Path('/proc/stat').read_text();meta['loadavg']=Path('/proc/loadavg').read_text()
std=Path('/tmp/contains-bad-simd-20261105/sysroots/baseline/lib/rustlib')/(arch+'-unknown-linux-gnu')/'lib';e=os.environ.copy();e['LD_LIBRARY_PATH']=str(std)+(':/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib'if arch=='x86_64'else'');p=subprocess.run(['ldd',str(r/(arch+'-unknown-linux-gnu')/'benches-base')],env=e,text=True,capture_output=True);meta['ldd_binary']=p.stdout+p.stderr
paths={str(p)for p in std.glob('*.so')}
for l in p.stdout.splitlines():
 for word in l.split():
  if word.startswith('/')and Path(word).is_file():paths.add(word)
meta['runtime_sha256']={p:hashlib.sha256(Path(p).read_bytes()).hexdigest()for p in sorted(paths)}
(r/('environment.'+arch+'.json')).write_text(json.dumps(meta,indent=2))
