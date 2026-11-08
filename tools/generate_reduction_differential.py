#!/usr/bin/env python3
"""Development-only differential oracle for add/multiply reductions."""
from pathlib import Path
import math, random
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'reduction_differential_generated.lua'
rng=random.Random(0x5A77)
dtypes=['bool','int8','uint8','int16','uint16','int32','uint32','int64','uint64','float16','float32','float64']

lines=[
 'local np=require("luaray_core")',
 'local function close(a,b)',
 '  if type(a)~=type(b) then return false end',
 '  if type(a)~="table" then',
 '    if type(a)=="number" then',
 '      if a~=a and b~=b then return true end',
 '      if a==b then return true end',
 '      return math.abs(a-b)<=math.max(1e-5,math.abs(b)*3e-6)',
 '    end',
 '    return a==b',
 '  end',
 '  if #a~=#b then return false end',
 '  for i=1,#a do if not close(a[i],b[i]) then return false end end',
 '  return true',
 'end',
 f'-- Generated against development NumPy {np.__version__}.',
]

def lua_scalar(x):
    if isinstance(x,(bool,np.bool_)): return 'true' if bool(x) else 'false'
    if isinstance(x,(float,np.floating)):
        f=float(x)
        if math.isnan(f): return '0/0'
        if math.isinf(f): return 'math.huge' if f>0 else '-math.huge'
        return repr(f)
    return str(int(x))

def lua_table(x):
    if isinstance(x,list): return '{'+','.join(lua_table(v) for v in x)+'}'
    return lua_scalar(x)

def dname(dt):
    n=np.dtype(dt).name
    return 'longdouble' if n in ('float96','float128') else n

count=0
for case in range(180):
    nd=rng.randint(1,4)
    shape=[rng.randint(0,4) for _ in range(nd)]
    # Keep zero shapes reshapeable and otherwise avoid all-zero product by +1.
    size=math.prod(shape)
    dt=rng.choice(dtypes)
    op=rng.choice(['sum','prod'])
    if dt=='bool':
        arr=np.ones(shape,dtype=np.bool_) if op=='prod' else (np.arange(size)!=0).reshape(shape)
        lua_expr=f'np.ones({lua_table(shape)},np.bool)' if op=='prod' else f'np.reshape(np.arange({size},np.bool),{lua_table(shape)})'
    else:
        base=np.arange(size,dtype=dt).reshape(shape)
        if op=='prod' and size:
            arr=base+np.array(1,dtype=dt)
            lua_expr=f'(np.reshape(np.arange({size},np.{dt}),{lua_table(shape)})+1)'
        else:
            arr=base
            lua_expr=f'np.reshape(np.arange({size},np.{dt}),{lua_table(shape)})'
    full = rng.random()<0.35
    if full:
        axis=None
        axis_lua='nil'
    else:
        axis=rng.randrange(nd)
        axis_lua=str(axis+1)
    with np.errstate(all='ignore'):
        expected=getattr(np,op)(arr,axis=axis)
    call=f'np.{op}(a,{axis_lua})' if axis_lua!='nil' else f'np.{op}(a)'
    lines.append(f'do -- reduction {case}: {op} {dt} {shape} axis={axis}')
    lines.append(f'  local a={lua_expr}')
    lines.append(f'  local r={call}')
    if isinstance(expected,np.ndarray):
        lines.append(f'  assert(r.dtype=="{dname(expected.dtype)}","reduction {case} dtype "..r.dtype)')
        lines.append(f'  assert(close(r:tolist(),{lua_table(expected.tolist())}),"reduction {case} values")')
    else:
        lines.append(f'  assert(close(r,{lua_scalar(expected)}),"reduction {case} scalar")')
    lines.append('end')
    count+=1

# Pairwise-summation discriminator: linear float32 accumulation is 2104 lower.
a=np.arange(10000,dtype=np.float32)
expected=np.sum(a)
linear=np.float32(0)
for x in a: linear=np.float32(linear+x)
assert expected != linear
lines += [
 'do -- explicit pairwise summation discriminator',
 '  local a=np.arange(10000,np.float32)',
 f'  local r=np.sum(a); assert(r=={float(expected)!r},"pairwise float32 sum")',
 f'  assert(r~={float(linear)!r},"pairwise path accidentally became linear")',
 'end',
]

# 0-D axis behavior: Lua axis 1 maps to NumPy axis 0.
lines += [
 'do local a=np.array({5},np.int32):get(1,np.ellipsis); assert(a.ndim==0); assert(np.sum(a,1)==5); assert(np.prod(a,-1)==5) end',
 f"print('reduction differential: {count+2} cases ok')",
]
OUT.write_text('\n'.join(lines)+'\n')
print(OUT)
