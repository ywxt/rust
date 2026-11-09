from pathlib import Path
import subprocess,json,platform,hashlib,time,os
r=Path(__file__).parent;arm=platform.machine()=="aarch64";target="aarch64-unknown-linux-gnu" if arm else "x86_64-unknown-linux-gnu";journal=[]
def mark(stage,state):
 journal.append({"stage":stage,"state":state,"time":time.time()});(r/"run-journal.json").write_text(json.dumps(journal,indent=2));print(stage,state,flush=True)
mark("verify","start")
for variant,targets in json.loads((r/"sysroot-manifests.json").read_text()).items():
 lib=r/"sysroots"/variant/"lib/rustlib"/target/"lib"
 for name,sha in targets[target].items():assert hashlib.sha256((lib/name).read_bytes()).hexdigest()==sha,(variant,name)
 for name in ["check","custom-check"]:
  out=r/variant/target;libs=str(lib)+("" if arm else ":/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib")
  p=subprocess.run(["env","LD_LIBRARY_PATH="+libs,str(out/name)],capture_output=True,text=True);(out/(name+".log")).write_text(p.stdout+p.stderr);assert p.returncode==0,p.stderr;print(variant,name,p.stdout,flush=True)
mark("verify","complete")
for stage in ["counted","matrix"]:
 mark(stage,"start");subprocess.run(["python3",str(r/("run-"+stage+".py"))],check=True);mark(stage,"complete")
