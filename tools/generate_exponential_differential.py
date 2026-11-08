#!/usr/bin/env python3
"""NumPy 2.3.5 differential oracle for exponential RNG (Python generation only)."""
from pathlib import Path
import numpy as np

O=Path(__file__).resolve().parents[1]/'tests/exponential_differential_generated.lua'
lines=["-- Generated from NumPy "+np.__version__,"local np=require('luaray_core')", "local cases=0", "local function eq(a,b) assert(a==b, tostring(a)..' ~= '..tostring(b));cases=cases+1 end"]
seeds=[0,1,2,42,99,123456789,1099511627779,4611686018427387909]
def lua_shape(shape):
    if shape is None:return 'nil'
    if len(shape)==1:return str(shape[0])
    return '{'+','.join(str(i) for i in shape)+'}'
def checks(a,shape):
    if shape is None:
        lines.append(f'eq(v,{float(a)!r})')
    else:
        lines.append('eq(v.dtype,"'+str(a.dtype)+'")')
        for i,d in enumerate(shape,1):lines.append(f'eq(v.shape[{i}],{d})')
        for ix in np.ndindex(*shape):
            loc=','.join(str(j+1) for j in ix)
            lines.append(f'eq(v:get({loc}),{float(a[ix])!r})')

def state(r):
    lines.append(f'eq(r:raw_hex(),"{int(r.bit_generator.random_raw()):016x}")')

for seed in seeds:
 for method in ('zig','inv'):
  for dtype in ('float64','float32'):
   for shape in (None,(),(0,),(1,),(3,),(2,3),(2,0,4),(3,2,3),(256,)):
    r=np.random.default_rng(seed)
    val=r.standard_exponential(size=shape,dtype=dtype,method=method)
    lines.append(f'do local r=np.random.default_rng({seed});local v=r:standard_exponential({lua_shape(shape)},"{dtype}","{method}")')
    checks(val,shape)
    state(r)
    lines.append('end')
 # Exponential with scale parameter, including degenerate and large values.
 for scale in (0.,0.125,1.,2.5,1000.):
  for shape in (None,(),(0,),(1,),(4,),(3,2),(128,)):
   r=np.random.default_rng(seed)
   val=r.exponential(scale,size=shape)
   lines.append(f'do local r=np.random.default_rng({seed});local v=r:exponential({scale!r},{lua_shape(shape)})')
   checks(val,shape)
   state(r)
   lines.append('end')
# Mixing tests validate the exact internal PCG64 consumption across samplers.
for seed in seeds:
 r=np.random.default_rng(seed)
 lines.append(f'do local r=np.random.default_rng({seed})')
 for i in range(110):
  kind=i%9
  if kind==0:
   value=r.standard_exponential();call='r:standard_exponential()'
  elif kind==1:
   value=r.standard_exponential(dtype='float32');call='r:standard_exponential(nil,"float32")'
  elif kind==2:
   value=r.standard_exponential(method='inv');call='r:standard_exponential(nil,nil,"inv")'
  elif kind==3:
   value=r.standard_exponential(dtype='float32',method='inv');call='r:standard_exponential(nil,"float32","inv")'
  elif kind==4:
   value=r.exponential(3.5);call='r:exponential(3.5)'
  elif kind==5:
   value=r.standard_normal();call='r:standard_normal()'
  elif kind==6:
   value=r.random();call='r:random()'
  elif kind==7:
   value=int(r.integers(0,100,dtype='int32'));call='r:integers(0,100,nil,"int32")'
  else:
   value=f'{int(r.bit_generator.random_raw()):016x}';call='r:raw_hex()'
  lines.append(f'eq({call},{str(value)!r})' if isinstance(value,str) else f'eq({call},{float(value)!r})')
 lines.append('end')
# Reject invalid parameters before consuming generator state
bad=[ 'r:standard_exponential(-1)', 'r:standard_exponential(4,"int64")', 'r:standard_exponential(4,"float64","abc")', 'r:standard_exponential(2,nil,nil,"extra")', 'r:exponential(-0.5)', 'r:exponential(0/0)', 'r:exponential(2,-1)', 'r:exponential(1,2,"extra")']
for code in bad:
 lines.append('do local r=np.random.default_rng(42);local ok=pcall(function()'+code+' end);eq(ok,false);')
 lines.append('eq(r:raw_hex(),"c621fbcd16d92688") end')
lines.append("print('exponential differential approved: '..cases..' exact comparisons')")
O.write_text('\n'.join(lines)+'\n')
print('generated',O,'lines',len(lines))
