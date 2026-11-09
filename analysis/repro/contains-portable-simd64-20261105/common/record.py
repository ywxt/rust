import pathlib,platform,subprocess,json,time
r=pathlib.Path(__file__).resolve().parent;arm=platform.machine()=='aarch64';target='aarch64-unknown-linux-gnu' if arm else 'x86_64-unknown-linux-gnu';core='52' if arm else '12';start=time.time()
for case in ['str::contains_bang_str_long_lorem_ipsum','str::bench_contains_short_short']:
 for variant in ['baseline','optimized']:
  stem=variant+'-'+case;data=r/(stem+'.data');libs=str(r/'sysroots'/variant/'lib/rustlib'/target/'lib')+('' if arm else ':/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib')
  p=subprocess.run(['taskset','-c',core,'env','-u','LD_LIBRARY_PATH','perf','record','-o',str(data),'-e','cycles:u','-c','500003','--','env','LD_LIBRARY_PATH='+libs,str(r/variant/target/'benches'),'--bench',case,'--exact','--format=terse'],capture_output=True,text=True);(r/(stem+'-record.log')).write_text(p.stdout+p.stderr);assert p.returncode==0,p.stderr
  for tool in ['report','annotate']:
   cmd=['env','-u','LD_LIBRARY_PATH','perf',tool,'-i',str(data),'--stdio']
   if tool=='report':cmd+=['--percent-limit','1','--sort','symbol']
   p=subprocess.run(cmd,capture_output=True,text=True);(r/(stem+'-'+tool+'.txt')).write_text(p.stdout+p.stderr);assert p.returncode==0,p.stderr
  print('recorded',stem,flush=True)
(r/'record-complete.json').write_text(json.dumps({'start':start,'end':time.time()}))
