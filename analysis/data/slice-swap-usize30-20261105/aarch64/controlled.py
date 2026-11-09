from pathlib import Path
import subprocess,os,json,platform
p=Path(__file__).resolve().parent;arch=platform.machine()
subprocess.run(['python3',str(p/'aligned.py')],check=True)
e=os.environ.copy();e.update(TAG='aligned',ROUNDS='3',CONFIGS=(p/'aligned-configs.json').read_text());subprocess.run(['python3',str(p/'measure.py')],env=e,check=True)
subprocess.run(['python3',str(p/'layout.py')],check=True);e.update(TAG='layout',CONFIGS=(p/'layout-configs.json').read_text());subprocess.run(['python3',str(p/'measure.py')],env=e,check=True)
subprocess.run(['python3',str(p/'scenarios.py')],check=True)
