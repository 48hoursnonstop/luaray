#!/usr/bin/env python3
"""Generate deterministic NumPy Ziggurat normal oracle; Python only at generation."""
from pathlib import Path
import numpy as np
O=Path(__file__).resolve().parents[1]/'tests/normal_differential_generated.lua'
lines=["-- Generated from NumPy "+np.__version__,"local np=require('luaray_core')",'local cases=0',"local function eq(a,b) assert(a==b,tostring(a)..' ~= '..tostring(b));cases=cases+1 end"]
seeds=[0,1,2,42,99,123456789,1099511627779,4611686018427387909]
for seed in seeds:
 for dtype in ('float64','float32'):
  rng=np.random.default_rng(seed)
  lines.append(f'do local r=np.random.default_rng({seed})')
  for i in range(30):
   v=rng.standard_normal(dtype=dtype)
   lines.append(f'eq(r:standard_normal(nil,"{dtype}"),{repr(float(v))})')
  raw=rng.bit_generator.random_raw()
  lines.append(f'eq(r:raw_hex(),"{int(raw):016x}") end')
  for shape in [(0,),(1,),(3,),(48,),(2,3),(2,0,4),(3,2,3)]:
   rng=np.random.default_rng(seed)
   values=rng.standard_normal(shape,dtype=dtype)
   shape_arg=str(shape[0]) if len(shape)==1 else '{'+','.join(map(str,shape))+'}'
   lines.append(f'do local r=np.random.default_rng({seed}); local a=r:standard_normal({shape_arg},"{dtype}")')
   lines.append(f'eq(a.dtype,"{dtype}")')
   for i,dim in enumerate(shape,1):lines.append(f'eq(a.shape[{i}],{dim})')
   for ix in np.ndindex(*shape):
    idx=','.join(str(int(j)+1) for j in ix)
    lines.append(f'eq(a:get({idx}),{repr(float(values[ix]))})')
   raw=rng.bit_generator.random_raw()
   lines.append(f'eq(r:raw_hex(),"{int(raw):016x}") end')
 for loc,scale in [(0.,1.),(4.,2.5),(-2.75,0.125),(5.,0.),(1e5,1e-5)]:
  for shape in [(1,), (13,), (2,3)]:
   rng=np.random.default_rng(seed)
   values=rng.normal(loc,scale,shape)
   arg=str(shape[0]) if len(shape)==1 else '{'+','.join(map(str,shape))+'}'
   lines.append(f'do local r=np.random.default_rng({seed});local a=r:normal({loc!r},{scale!r},{arg})')
   lines.append('eq(a.dtype,"float64")')
   for ix in np.ndindex(*shape):
    ixarg=','.join(str(i+1) for i in ix)
    lines.append(f'eq(a:get({ixarg}),{repr(float(values[ix]))})')
   lines.append(f'eq(r:raw_hex(),"{int(rng.bit_generator.random_raw()):016x}") end')
# Longer batches exercise Ziggurat slow paths, rejection and tail consumption.
for seed in seeds:
 for dtype in ('float64','float32'):
  rng=np.random.default_rng(seed)
  values=rng.standard_normal(512,dtype=dtype)
  lines.append(f'do local r=np.random.default_rng({seed});local a=r:standard_normal(512,"{dtype}")')
  for i,v in enumerate(values,1):
   lines.append(f'eq(a:get({i}),{repr(float(v))})')
  lines.append(f'eq(r:raw_hex(),"{int(rng.bit_generator.random_raw()):016x}") end')
  # 0D arrays still return native ndarray, while omitted size gives Lua number
  rng=np.random.default_rng(seed)
  val=float(rng.standard_normal((),dtype=dtype))
  lines.append(f'do local r=np.random.default_rng({seed}); local a=r:standard_normal({{}},"{dtype}")')
  lines.append(f'eq(a.dtype,"{dtype}");eq(a:get(),{val!r}) end')
# Composite state test for mixed float32, float64, integer and raw draws
for seed in seeds:
 rng=np.random.default_rng(seed)
 lines.append(f'do local r=np.random.default_rng({seed})')
 for i in range(45):
  k=i%5
  if k==0:
   val=float(rng.standard_normal(dtype='float64'));lua=f'r:standard_normal()'
  elif k==1:
   val=float(rng.standard_normal(dtype='float32'));lua=f'r:standard_normal(nil,"float32")'
  elif k==2:
   val=float(rng.random());lua='r:random()'
  elif k==3:
   val=int(rng.integers(0,100,dtype='int32'));lua='r:integers(0,100,nil,"int32")'
  else:
   val=f'{int(rng.bit_generator.random_raw()):016x}';lua='r:raw_hex()'
  lines.append(f'eq({lua},{repr(val) if isinstance(val,str) else repr(val)})')
 lines.append('end')
lines.append("print('normal differential approved: '..cases..' exact comparisons')")
O.write_text('\n'.join(lines)+'\n')
print('generated',O,len(lines),'lines')
