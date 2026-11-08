#!/usr/bin/env python3
"""Independent NumPy executable oracle for 0.55, with state-consumption checks."""
from pathlib import Path
import numpy as np
O=Path(__file__).resolve().parents[1]/'tests/distributions55_differential_generated.lua'
lines=[f'-- Generated with NumPy {np.__version__}; generated fixture needs no Python',
       "local np=require('luaray_core')", "assert(np._version=='0.57.0-dev')", 'local cases=0',
       "local function eq(a,b) assert(a==b, tostring(a)..' ~= '..tostring(b));cases=cases+1 end"]
seeds=[0,1,2,42,99,123456789,1099511627779,4611686018427387909]
shapes=[None,(),(0,),(1,),(3,),(2,3),(2,0,4),(3,2,3),(128,)]
params={'lognormal':[(0.0,1.0),(0.0,0.0),(-2.5,0.25),(2.25,3.0)],
        'laplace':[(0.0,1.0),(0.0,0.0),(-5.0,0.125),(7.25,2.0)]}
def s(shape):
 if shape is None:return 'nil'
 if len(shape)==1:return str(shape[0])
 return '{'+','.join(str(i) for i in shape)+'}'
def eq_results(value,shape):
 if shape is None:lines.append(f'eq(v,{float(value)!r})')
 else:
  lines.append('eq(v.dtype,"float64")')
  for i,d in enumerate(shape,1):lines.append(f'eq(v.shape[{i}],{d})')
  for ix in np.ndindex(*shape):
   loc=','.join(str(j+1) for j in ix)
   lines.append(f'eq(v:get({loc}),{float(value[ix])!r})')
def state(r):lines.append(f'eq(r:raw_hex(),"{int(r.bit_generator.random_raw()):016x}")')
for seed in seeds:
 for name in ('lognormal','laplace','standard_cauchy'):
  for params0 in params.get(name,[()] ):
   for shape in shapes:
    rng=np.random.default_rng(seed)
    if name=='standard_cauchy':
     value=rng.standard_cauchy(size=shape);call=f'r:standard_cauchy({s(shape)})'
    else:
     value=getattr(rng,name)(*params0,size=shape)
     call=f'r:{name}({params0[0]!r},{params0[1]!r},{s(shape)})'
    lines.append(f'do local r=np.random.default_rng({seed});local v={call}')
    eq_results(value,shape);state(rng);lines.append('end')
# Calls with interleaved functions must yield same PCG64 state.
for seed in seeds:
 r=np.random.default_rng(seed)
 lines.append(f'do local r=np.random.default_rng({seed})')
 for i in range(160):
  kind=i%8
  if kind==0: val=r.lognormal(0.8,1.5);call='r:lognormal(0.8,1.5)'
  elif kind==1: val=r.standard_cauchy();call='r:standard_cauchy()'
  elif kind==2: val=r.laplace(-1.5,2.25);call='r:laplace(-1.5,2.25)'
  elif kind==3: val=r.random();call='r:random()'
  elif kind==4: val=r.standard_normal();call='r:standard_normal()'
  elif kind==5: val=r.standard_exponential();call='r:standard_exponential()'
  elif kind==6: val=int(r.integers(0,2**31,dtype='int32'));call='r:integers(0,2147483648,nil,"int32")'
  else: val=f'{int(r.bit_generator.random_raw()):016x}';call='r:raw_hex()'
  lines.append(f'eq({call},{val!r})' if isinstance(val,str) else f'eq({call},{float(val)!r})')
 state(r);lines.append('end')
# Error handling must not move generator's state.
bad=['r:lognormal(0,-1)', 'r:lognormal(0,0/0)', 'r:lognormal(0,1,-2)', 'r:lognormal(0,1,2,"extra")',
     'r:laplace(0,-1)', 'r:laplace(0,0/0)', 'r:laplace(0,1,-2)', 'r:laplace(0,1,2,"extra")',
     'r:standard_cauchy(-2)', 'r:standard_cauchy(2,3)']
for code in bad:
 lines.append('do local r=np.random.default_rng(42);eq(pcall(function()'+code+' end),false);eq(r:raw_hex(),"c621fbcd16d92688") end')
lines.append("print('distributions55 differential approved: '..cases..' exact comparisons')")
O.write_text('\n'.join(lines)+'\n')
print('generated', O, 'lines',len(lines))
