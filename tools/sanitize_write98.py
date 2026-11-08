#!/usr/bin/env python3
"""Instrument every C file changed in 0.98; reuse other native objects explicitly."""
from pathlib import Path
import os
import shlex
import subprocess

ROOT=Path(__file__).resolve().parents[1]
os.chdir(ROOT)
BUILD=ROOT/'build-sanitize';BUILD.mkdir(exist_ok=True)
cc=shlex.split(os.environ.get('CC','cc'))
cxx=shlex.split(os.environ.get('CXX','c++'))
flags=['-O1','-g','-std=c11','-Wall','-Wextra','-Wpedantic','-fPIC',
       '-fsanitize=address,undefined','-fno-omit-frame-pointer','-Isrc']

def run(args,**kwargs):
    print(shlex.join(map(str,args)),flush=True)
    subprocess.run(list(map(str,args)),check=True,**kwargs)

def libs(package,fallback):
    result=subprocess.run(['pkg-config','--libs',package],capture_output=True,text=True)
    return shlex.split(result.stdout) if result.returncode==0 else fallback

changed=['ln_write','ln_dtype_transfer','lua_module']
for name in changed:
    run(cc+flags+['-c',f'src/{name}.c','-o',BUILD/f'{name}.o'])
normal=sorted(p for p in (ROOT/'build').glob('ln_*.o') if p.stem not in changed and not p.stem.endswith('_san'))
assert normal,'build normal native objects before running this tool'
core_objects=normal+[BUILD/'ln_write.o',BUILD/'ln_dtype_transfer.o']
link=['-fsanitize=address,undefined']
native_libs=['-lm']+libs('cblas',['-lblas'])+libs('lapack',['-llapack'])
run(cxx+link+['-shared']+core_objects+[BUILD/'lua_module.o']+
    libs('lua5.4',['-llua5.4'])+native_libs+['-o',BUILD/'luaray_core.so'])
run(cc+flags+['-c','tests/test_write98_core.c','-o',BUILD/'test_write98.o'])
run(cxx+link+[BUILD/'test_write98.o']+core_objects+native_libs+['-o',BUILD/'test_write98'])
env=os.environ.copy();env['ASAN_OPTIONS']='detect_leaks=0:halt_on_error=1'
env['UBSAN_OPTIONS']='halt_on_error=1:print_stacktrace=1'
run([BUILD/'test_write98'],env=env)
asan=subprocess.check_output(cc+['-print-file-name=libasan.so'],text=True).strip()
env['LD_PRELOAD']=asan;env['LUA_CPATH']=str(BUILD/'?.so')+';;'
for test in ['write98_regression','put98_differential_generated','place98_differential_generated',
             'write98_blocked','memory97_regression','memory97_differential_generated',
             'overlap97_differential_generated']:
    run(['lua5.4',f'tests/{test}.lua'],env=env)
print('PASS: changed ln_write, ln_dtype_transfer and lua_module instrumented; other dependencies uninstrumented; leak detection disabled')
