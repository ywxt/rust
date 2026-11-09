from pathlib import Path
import subprocess
r=Path(__file__).resolve().parent
for phase in ['profile','bench','counted','primitive','alignment']:
 subprocess.run(['python3',str(r/'run.py'),phase],check=True)
print('all phases complete',flush=True)
