import pathlib,platform,subprocess,json,time
r=pathlib.Path(__file__).resolve().parent;core='52' if platform.machine()=='aarch64' else '12';libs=pathlib.Path('/tmp/xdiff/libdir.txt').read_text().strip();start=time.time()
for case in ['main::contains_bang_str_long_lorem_ipsum','optimized::contains_bang_str_long_lorem_ipsum','main::bench_contains_short_long','optimized::bench_contains_short_long']:
 data=r/(case+'.data')
 p=subprocess.run(['taskset','-c',core,'env','-u','LD_LIBRARY_PATH','perf','record','-o',str(data),'-e','cycles:u','-c','500003','--','env','LD_LIBRARY_PATH='+libs,str(r/'benches'),'--bench',case,'--exact','--format=terse'],capture_output=True,text=True);(r/(case+'-record.log')).write_text(p.stdout+p.stderr);assert p.returncode==0,p.stderr
 for tool in ['report','annotate']:
  cmd=['env','-u','LD_LIBRARY_PATH','perf',tool,'-i',str(data),'--stdio']
  if tool=='report':cmd+=['--percent-limit','1','--sort','symbol']
  p=subprocess.run(cmd,capture_output=True,text=True);(r/(case+'-'+tool+'.txt')).write_text(p.stdout+p.stderr);assert p.returncode==0,p.stderr
 print('recorded',case,flush=True)
(r/'record-complete.json').write_text(json.dumps({'start':start,'end':time.time()}))
