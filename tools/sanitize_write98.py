#!/usr/bin/env python3
"""Instrument every C file changed in 0.98; reuse other native objects explicitly."""
from pathlib import Path
import os
import shlex
import subprocess
import argparse

ROOT=Path(__file__).resolve().parents[1]
os.chdir(ROOT)
BUILD=ROOT/'build-sanitize';BUILD.mkdir(exist_ok=True)
cc=shlex.split(os.environ.get('CC','cc'))
cxx=shlex.split(os.environ.get('CXX','c++'))
flags=['-O1','-g','-std=c11','-Wall','-Wextra','-Wpedantic','-fPIC',
       '-fsanitize=address,undefined','-fno-omit-frame-pointer','-Isrc']
parser=argparse.ArgumentParser()
parser.add_argument('--memory99',action='store_true',help='also execute 0.99 native and Lua suites')
parser.add_argument('--libm-fix',action='store_true',help='also instrument the changed random sampler and run exponential suites')
parser.add_argument('--take100',action='store_true',help='also instrument and execute native take')
parser.add_argument('--along101',action='store_true',help='instrument along-axis operations and MapIter')
options=parser.parse_args()

def run(args,**kwargs):
    print(shlex.join(map(str,args)),flush=True)
    subprocess.run(list(map(str,args)),check=True,**kwargs)

def libs(package,fallback):
    result=subprocess.run(['pkg-config','--libs',package],capture_output=True,text=True)
    return shlex.split(result.stdout) if result.returncode==0 else fallback

changed=['ln_write','ln_dtype_transfer','lua_module']
if options.libm_fix:changed.append('ln_random')
if options.take100:changed+=['ln_take','ln_string']
if options.along101:changed+=['ln_along','ln_mapping']
for name in changed:
    run(cc+flags+['-c',f'src/{name}.c','-o',BUILD/f'{name}.o'])
normal=sorted(p for p in (ROOT/'build').glob('ln_*.o') if p.stem not in changed and not p.stem.endswith('_san'))
assert normal,'build normal native objects before running this tool'
core_objects=normal+[BUILD/'ln_write.o',BUILD/'ln_dtype_transfer.o']
if options.libm_fix:core_objects.append(BUILD/'ln_random.o')
if options.take100:core_objects+=[BUILD/'ln_take.o',BUILD/'ln_string.o']
if options.along101:core_objects+=[BUILD/'ln_along.o',BUILD/'ln_mapping.o']
link=['-fsanitize=address,undefined']
native_libs=['-lm']+libs('cblas',['-lblas'])+libs('lapack',['-llapack'])
run(cxx+link+['-shared']+core_objects+[BUILD/'lua_module.o']+
    libs('lua5.4',['-llua5.4'])+native_libs+['-o',BUILD/'luaray_core.so'])
run(cc+flags+['-c','tests/test_write98_core.c','-o',BUILD/'test_write98.o'])
run(cxx+link+[BUILD/'test_write98.o']+core_objects+native_libs+['-o',BUILD/'test_write98'])
env=os.environ.copy();env['ASAN_OPTIONS']='detect_leaks=0:halt_on_error=1'
env['UBSAN_OPTIONS']='halt_on_error=1:print_stacktrace=1'
run([BUILD/'test_write98'],env=env)
if options.memory99:
    run(cc+flags+['-c','tests/test_memory99_core.c','-o',BUILD/'test_memory99.o'])
    run(cxx+link+[BUILD/'test_memory99.o']+core_objects+native_libs+['-o',BUILD/'test_memory99'])
    run([BUILD/'test_memory99'],env=env)
if options.take100:
    run(cc+flags+['-c','tests/test_take100_core.c','-o',BUILD/'test_take100.o'])
    run(cxx+link+[BUILD/'test_take100.o']+core_objects+native_libs+['-o',BUILD/'test_take100'])
    run([BUILD/'test_take100'],env=env)
if options.along101:
    run(cc+flags+['-c','tests/test_along101_core.c','-o',BUILD/'test_along101.o'])
    run(cxx+link+[BUILD/'test_along101.o']+core_objects+native_libs+['-o',BUILD/'test_along101'])
    run([BUILD/'test_along101'],env=env)
asan=subprocess.check_output(cc+['-print-file-name=libasan.so'],text=True).strip()
env['LD_PRELOAD']=asan;env['LUA_CPATH']=str(BUILD/'?.so')+';;'
tests=['write98_regression','put98_differential_generated','place98_differential_generated',
             'write98_blocked','memory97_regression','memory97_differential_generated',
             'overlap97_differential_generated']
if options.memory99:tests+=['memory99_regression','copyto99_differential_generated','putmask99_differential_generated']
if options.libm_fix:tests+=['exponential_regression','exponential_differential_generated']
if options.take100:tests+=['take100_regression','take100_differential_generated']
if options.along101:tests+=['along101_regression','take_along101_differential_generated','put_along101_differential_generated','advanced_indexing_differential_generated','advanced_assignment_differential_generated']
for test in tests:
    run(['lua5.4',f'tests/{test}.lua'],env=env)
print('PASS: changed '+', '.join(changed)+' instrumented; other dependencies uninstrumented; leak detection disabled')
