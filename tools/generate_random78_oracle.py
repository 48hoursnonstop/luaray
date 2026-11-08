#!/usr/bin/env python3
"""Regenerate the LuaRay 0.78 PCG64 differential oracle with NumPy 2.3.5.

No LuaRay code is executed while generating expected values; both the
sample and the next raw PCG64 word originate from independent NumPy.
"""
import math
from pathlib import Path
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
R=np.random.default_rng(770078)
NAMES=('lognormal','laplace','gumbel','logistic','rayleigh','weibull','pareto','power')
TWOPARAM=set(NAMES[:4])
SEEDS=(0,1,42,77,1234,32768,981239)
TARGETS=((),(1,),(3,),(2,3),(2,1,3))

def luaval(v):
    if isinstance(v,np.ndarray):return luaval(v.tolist())
    if isinstance(v,(tuple,list)):return '{'+','.join(map(luaval,v))+'}'
    if v is None:return 'nil'
    if isinstance(v,(np.integer,int)):return str(int(v))
    if isinstance(v,(np.floating,float)):
        x=float(v)
        if math.isnan(x):return '(0/0)'
        if math.isinf(x):return '(1/0)' if x>0 else '(-1/0)'
        return repr(x)
    raise TypeError(type(v))

def param(k,target):
    if not target or R.random()<0.12:return round(float(R.uniform(.25,2.0)),3)
    sh=tuple(1 if R.random()<0.45 else d for d in target)
    vals=np.arange(math.prod(sh),dtype=np.float64).reshape(sh)*0.125+0.3+R.random()
    return vals

def expr(v):
    if isinstance(v,np.ndarray):
        x=luaval(v)
        if R.random()<0.55:return 'np.array('+x+',"float64")'
        return x
    return luaval(v)

HEAD='''-- Generated independently using NumPy 2.3.5 by tools/generate_random78_oracle.py
local np=require('luaray_core')
local cases=0
local function same(a,b)
  if type(a)~=type(b) then return false end
  if type(b)=='table' then
    if #a~=#b then return false end
    for i=1,#b do if not same(a[i],b[i]) then return false end end
    return true
  end
  if type(b)=='number' then
    if a~=a then return b~=b end
    if a==b then return true end
    return math.abs(a-b)<=8e-13*math.max(1,math.abs(b))
  end
  return a==b
end
local function check(v,why) assert(v,('random78 case %d: %s'):format(cases,why)) end
'''
lines=[HEAD]
count=0

def append(name,seed,npargs,luargs,size):
    global count
    ref=np.random.default_rng(seed)
    expected=getattr(ref,name)(*npargs,size=size)
    next_hex=f'{int(ref.bit_generator.random_raw()):016x}'
    call=', '.join(luargs+[luaval(list(size) if size is not None else None)])
    lines.append(f'do local r=np.random.default_rng({seed});local x=r:{name}({call});cases=cases+1\n')
    if isinstance(expected,np.ndarray):
        lines.append(f'  check(type(x)=="userdata","type");check(same(x.shape,{luaval(expected.shape)}),"shape");check(same(x:tolist(),{luaval(expected)}),"values")\n')
    else:
        lines.append(f'  check(same(x,{luaval(expected)}),"scalar")\n')
    lines.append(f'  check(r:raw_hex()=="{next_hex}","PCG64 continuation")\nend\n')
    count+=1

for kind,name in enumerate(NAMES):
    for i in range(175):
        target=TARGETS[int(R.integers(len(TARGETS)))]; seed=SEEDS[(kind+i)%len(SEEDS)]
        a=param(kind,target)
        if name in TWOPARAM:
            b=param(kind,target)
            npargs=[a,b]
        else:npargs=[a]
        size=(None if i%5==0 else target if i%3 else (1,)+target)
        try: append(name,seed,npargs,[expr(a) for a in npargs],size)
        except ValueError as exc:
            # Explicit shape incompatibility in random test design, not a feature failure.
            if 'size' not in str(exc):raise
    # Deliberately noncontiguous ndarray operands in every distribution.
    for i in range(75):
        seed=SEEDS[(i+kind)%len(SEEDS)]
        dtype=('float64','float32','int64')[i%3]
        orig=np.array([[1.,2.,3.],[4.,5.,6.]],dtype=dtype)
        if i%3==0:
            a=orig.T; ax='np.transpose(np.array('+luaval(orig)+',"'+dtype+'"))'
        elif i%3==1:
            a=np.flip(orig,0); ax='np.flip(np.array('+luaval(orig)+',"'+dtype+'"),1)'
        else:
            a=np.flip(orig,1);ax='np.flip(np.array('+luaval(orig)+',"'+dtype+'"),2)'
        if name in TWOPARAM:
            b=0.75
            args=[a,b];luaargs=[ax,luaval(b)]
        else:args=[a];luaargs=[ax]
        size=None if i%2 else ((2,)+a.shape)
        append(name,seed,args,luaargs,size)

lines.append(f'print("random78 differential passed: {count} cases")\n')
dest=ROOT/'tests/random78_differential_generated.lua'
dest.write_text(''.join(lines))
print(f'NumPy {np.__version__}; {count} cases; wrote {dest} ({dest.stat().st_size} bytes)')
