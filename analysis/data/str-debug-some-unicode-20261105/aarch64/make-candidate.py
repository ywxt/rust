from pathlib import Path
import subprocess,os
p=Path(__file__).resolve().parent;r=Path('/tmp/xdiff/rustc.txt').read_text().strip();e=os.environ.copy();e['LD_LIBRARY_PATH']=Path('/tmp/xdiff/libdir.txt').read_text().strip()+':'+e.get('LD_LIBRARY_PATH','')
subprocess.run([r,'-O',str(p/'gen.rs'),'-o',str(p/'gen')],env=e,check=True)
(p/'printable-blocks.rs').write_bytes(subprocess.check_output([str(p/'gen')],env=e))
