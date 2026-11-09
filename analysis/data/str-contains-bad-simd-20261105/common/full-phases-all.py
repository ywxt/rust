from pathlib import Path
import subprocess,json,time,platform
r=Path(__file__).resolve().parent
for phase in ['check','benches','counted','matrix','profile']:
 subprocess.run(['python3',str(r/'run-all.py'),phase],check=True)
print('all phases finished',platform.machine(),flush=True)
