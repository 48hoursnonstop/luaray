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
parser.add_argument('--choose102',action='store_true',help='instrument native choose and execute its suites')
parser.add_argument('--condition103',action='store_true',help='instrument nonzero and conditional extraction')
parser.add_argument('--select104',action='store_true',help='instrument selection, generic iterator and temporal promotion')
parser.add_argument('--fft105',action='store_true',help='instrument FFT helpers, shifts and C++ PocketFFT integration')
parser.add_argument('--sampling106',action='store_true',help='instrument sampling, Dragon4 and shared ufunc/complex conversion changes')
parser.add_argument('--creation107',action='store_true',help='instrument conversion/creation bindings and scalar temporal packing')
parser.add_argument('--unary108',action='store_true',help='instrument native numeric unary registry and coercing entry point')
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
if options.choose102:changed.append('ln_choose')
if options.condition103:changed.append('ln_condition')
if options.select104:changed+=['ln_select','ln_nditer_multi','ln_datetime']
if options.fft105:changed+=['ln_fft_helpers','ln_roll']
if options.sampling106:changed+=['ln_sampling','ln_creation','ln_float_format','ln_ufunc','ln_ufunc_loops']
if options.creation107:
    changed+=['ln_core','lua_creation']
    if not options.sampling106:changed.append('ln_creation')
if options.unary108:changed.append('ln_unary_math')
for name in changed:
    run(cc+flags+(['-fwrapv'] if name=='ln_ufunc_loops' else ['-ffp-contract=off'] if name=='ln_unary_math' else [])+['-c',f'src/{name}.c','-o',BUILD/f'{name}.o'])
if options.fft105:
    run(cxx+['-O0','-g','-std=c++11','-Wall','-Wextra','-Wpedantic','-fPIC',
             '-fsanitize=address,undefined','-fno-omit-frame-pointer','-Isrc',
             '-c','src/ln_fft.cpp','-o',BUILD/'ln_fft.o'])
    changed.append('ln_fft')
normal=sorted(p for p in (ROOT/'build').glob('ln_*.o') if p.stem not in changed and not p.stem.endswith('_san'))
assert normal,'build normal native objects before running this tool'
core_objects=normal+[BUILD/'ln_write.o',BUILD/'ln_dtype_transfer.o']
if options.libm_fix:core_objects.append(BUILD/'ln_random.o')
if options.take100:core_objects+=[BUILD/'ln_take.o',BUILD/'ln_string.o']
if options.along101:core_objects+=[BUILD/'ln_along.o',BUILD/'ln_mapping.o']
if options.choose102:core_objects.append(BUILD/'ln_choose.o')
if options.condition103:core_objects.append(BUILD/'ln_condition.o')
if options.select104:core_objects+=[BUILD/'ln_select.o',BUILD/'ln_nditer_multi.o',BUILD/'ln_datetime.o']
if options.fft105:core_objects+=[BUILD/'ln_fft_helpers.o',BUILD/'ln_roll.o',BUILD/'ln_fft.o']
if options.sampling106:core_objects+=[BUILD/(n+'.o') for n in ['ln_sampling','ln_creation','ln_float_format','ln_ufunc','ln_ufunc_loops']]
if options.creation107:
    core_objects.append(BUILD/'ln_core.o')
    if not options.sampling106:core_objects.append(BUILD/'ln_creation.o')
if options.unary108:core_objects.append(BUILD/'ln_unary_math.o')
bindings=[BUILD/'lua_module.o']
if (ROOT/'src/lua_creation.c').exists():bindings.append((BUILD if options.creation107 else ROOT/'build')/'lua_creation.o')
link=['-fsanitize=address,undefined']
native_libs=['-lm']+libs('cblas',['-lblas'])+libs('lapack',['-llapack'])
run(cxx+link+['-shared']+core_objects+bindings+
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
if options.choose102:
    run(cc+flags+['-c','tests/test_choose102_core.c','-o',BUILD/'test_choose102.o'])
    run(cxx+link+[BUILD/'test_choose102.o']+core_objects+native_libs+['-o',BUILD/'test_choose102'])
    run([BUILD/'test_choose102'],env=env)
if options.condition103:
    run(cc+flags+['-c','tests/test_condition103_core.c','-o',BUILD/'test_condition103.o'])
    run(cxx+link+[BUILD/'test_condition103.o']+core_objects+native_libs+['-o',BUILD/'test_condition103'])
    run([BUILD/'test_condition103'],env=env)
if options.select104:
    run(cc+flags+['-c','tests/test_select104_core.c','-o',BUILD/'test_select104.o'])
    run(cxx+link+[BUILD/'test_select104.o']+core_objects+native_libs+['-o',BUILD/'test_select104'])
    run([BUILD/'test_select104'],env=env)
if options.fft105:
    run(cc+flags+['-c','tests/test_fft105_core.c','-o',BUILD/'test_fft105.o'])
    run(cxx+link+[BUILD/'test_fft105.o']+core_objects+native_libs+['-o',BUILD/'test_fft105'])
    run([BUILD/'test_fft105'],env=env)
if options.sampling106:
    for name in ['sampling106','format106']:
        run(cc+flags+['-c',f'tests/test_{name}_core.c','-o',BUILD/f'test_{name}.o'])
        run(cxx+link+[BUILD/f'test_{name}.o']+core_objects+native_libs+['-o',BUILD/f'test_{name}'])
        run([BUILD/f'test_{name}'],env=env)
if options.creation107:
    run(cc+flags+['-c','tests/test_creation107_core.c','-o',BUILD/'test_creation107.o'])
    run(cxx+link+[BUILD/'test_creation107.o']+core_objects+native_libs+['-o',BUILD/'test_creation107'])
    run([BUILD/'test_creation107'],env=env)
if options.unary108:
    run(cc+flags+['-c','tests/test_unary108_core.c','-o',BUILD/'test_unary108.o'])
    run(cxx+link+[BUILD/'test_unary108.o']+core_objects+native_libs+['-o',BUILD/'test_unary108'])
    run([BUILD/'test_unary108'],env=env)
asan=subprocess.check_output(cc+['-print-file-name=libasan.so'],text=True).strip()
env['LD_PRELOAD']=asan;env['LUA_CPATH']=str(BUILD/'?.so')+';;'
tests=['write98_regression','put98_differential_generated','place98_differential_generated',
             'write98_blocked','memory97_regression','memory97_differential_generated',
             'overlap97_differential_generated']
if options.memory99:tests+=['memory99_regression','copyto99_differential_generated','putmask99_differential_generated']
if options.libm_fix:tests+=['exponential_regression','exponential_differential_generated']
if options.take100:tests+=['take100_regression','take100_differential_generated']
if options.along101:tests+=['along101_regression','take_along101_differential_generated','put_along101_differential_generated','advanced_indexing_differential_generated','advanced_assignment_differential_generated']
if options.choose102:tests+=['choose102_regression','choose102_differential_generated']
if options.condition103:tests+=['condition103_regression','nonzero103_differential_generated','flatnonzero103_differential_generated','compress103_differential_generated','extract103_differential_generated']
if options.select104:tests+=['select104_regression','where104_differential_generated','select104_differential_generated']
if options.fft105:tests+=['fft105_regression','fft_frequency105_differential_generated','fft_shift105_differential_generated','fft_hermitian105_differential_generated']
if options.sampling106:tests+=['sampling106_regression','linspace106_differential_generated','logspace106_differential_generated','geomspace106_differential_generated']
if options.creation107:tests+=['creation107_stack','string_cast_differential_generated','creation107_regression','conversion107_differential_generated','copy107_differential_generated','like107_differential_generated','dense_creation107_differential_generated']
if options.unary108:tests+=['unary108_regression','rounding108_differential_generated','algebra108_differential_generated','angles108_differential_generated']
for test in tests:
    run(['lua5.4',f'tests/{test}.lua'],env=env)
print('PASS: changed '+', '.join(changed)+' instrumented; other dependencies uninstrumented; leak detection disabled')
