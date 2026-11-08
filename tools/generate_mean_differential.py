#!/usr/bin/env python3
"""Development-only oracle for ndarray/np.mean default-dtype semantics."""
from pathlib import Path
import math, random, warnings
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'mean_differential_generated.lua'
rng=random.Random(0x4D45414E)
dtypes=['bool','int8','uint8','int16','uint16','int32','uint32','int64','uint64','float16','float32','float64']

lines=[
 'local np=require("luaray_core")',
 'local function close(a,b)',
 '  if type(a)~=type(b) then return false end',
 '  if type(a)~="table" then',
 '    if type(a)=="number" then',
 '      if a~=a and b~=b then return true end',
 '      if a==b then return true end',
 '      return math.abs(a-b)<=math.max(1e-6,math.abs(b)*3e-6)',
 '    end',
 '    return a==b',
 '  end',
 '  if #a~=#b then return false end',
 '  for i=1,#a do if not close(a[i],b[i]) then return false end end',
 '  return true',
 'end',
 f'-- Generated against development NumPy {np.__version__}.',
]

def ls(x):
    if isinstance(x,(bool,np.bool_)): return 'true' if bool(x) else 'false'
    if isinstance(x,(float,np.floating)):
        f=float(x)
        if math.isnan(f): return '0/0'
        if math.isinf(f): return 'math.huge' if f>0 else '-math.huge'
        return repr(f)
    return str(int(x))

def lt(x):
    if isinstance(x,list): return '{'+','.join(lt(v) for v in x)+'}'
    return ls(x)

def dn(dt):
    n=np.dtype(dt).name
    return 'longdouble' if n in ('float96','float128') else n

count=0
for case in range(140):
    nd=rng.randint(1,4)
    shape=[rng.randint(0,4) for _ in range(nd)]
    size=math.prod(shape)
    dt=rng.choice(dtypes)
    if dt=='bool':
        arr=(np.arange(size)%3!=0).reshape(shape)
        lua=f'np.reshape(np.arange({size},np.bool),{lt(shape)})'
        # LuaRay bool arange is False,True,True,... whereas NumPy expression above alternates differently;
        # mirror LuaRay construction exactly for the oracle.
        arr=np.array([bool(i) for i in range(size)],dtype=bool).reshape(shape)
    else:
        arr=np.arange(size,dtype=dt).reshape(shape)
        lua=f'np.reshape(np.arange({size},np.{dt}),{lt(shape)})'
    full=rng.random()<0.4
    axis=None if full else rng.randrange(nd)
    with warnings.catch_warnings():
        warnings.simplefilter('ignore')
        with np.errstate(all='ignore'):
            exp=np.mean(arr,axis=axis)
    call='np.mean(a)' if axis is None else f'np.mean(a,{axis+1})'
    lines += [f'do -- mean {case}: {dt} {shape} axis={axis}',f'  local a={lua}',f'  local r={call}']
    if isinstance(exp,np.ndarray):
        lines += [f'  assert(r.dtype=="{dn(exp.dtype)}","mean {case} dtype "..r.dtype)',
                  f'  assert(close(r:tolist(),{lt(exp.tolist())}),"mean {case} values")']
    else:
        lines += [f'  assert(close(r,{ls(exp)}),"mean {case} scalar")']
    lines += ['end']
    count+=1

# Float32 must stay float32 for an axis result and use pairwise add reduction.
a=np.arange(20000,dtype=np.float32).reshape(2,10000)
exp=a.mean(axis=1)
lines += [
 'do local a=np.reshape(np.arange(20000,np.float32),{2,10000}); local r=a:mean(2);',
 '  assert(r.dtype=="float32","mean float32 dtype");',
 f'  assert(close(r:tolist(),{lt(exp.tolist())}),"mean float32 pairwise") end',
]
lines.append(f"print('mean differential: {count+1} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(OUT)
