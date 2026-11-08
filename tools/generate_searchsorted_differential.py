#!/usr/bin/env python3
"""Generate numeric searchsorted differentials from development NumPy.

LuaRay exposes insertion positions and sorter indices in Lua's 1-based model,
so expected NumPy positions/indices are shifted by one at the API boundary.
"""
from pathlib import Path
import math, random
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'searchsorted_differential_generated.lua'
rng=random.Random(0x5EA2C4)
dtypes=['bool','int8','uint8','int16','uint16','int32','uint32','int64','float32','float64']
lines=[
 'local np=require("luaray_core")',
 'local function eq(a,b)',
 '  if type(a)~=type(b) then return false end',
 '  if type(a)~="table" then if type(a)=="number" and a~=a and b~=b then return true end; return a==b end',
 '  if #a~=#b then return false end; for i=1,#a do if not eq(a[i],b[i]) then return false end end; return true',
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
    if isinstance(x,np.ndarray): x=x.tolist()
    if isinstance(x,(list,tuple)): return '{'+','.join(lt(v) for v in x)+'}'
    return ls(x)

def dtype_name(dt): return np.dtype(dt).name

def make_sorted(dt,n,seed,with_nan=False):
    if dt=='bool': vals=[False]*(n//2)+[True]*(n-n//2)
    elif dt.startswith('uint'): vals=sorted(((i*29+seed*7)%211) for i in range(n))
    elif dt.startswith('int'): vals=sorted((((i*29+seed*7)%211)-105) for i in range(n))
    else:
        vals=sorted((((i*29+seed*7)%211)-105)*0.25 for i in range(n))
        if with_nan and n>=2: vals[-1]=float('nan')
    return np.array(vals,dtype=dt), vals

count=0
# Scalar and shaped needles over numeric dtype combinations.
for case in range(260):
    adt=rng.choice(dtypes); kdt=rng.choice(dtypes)
    n=rng.randint(0,18)
    a,av=make_sorted(adt,n,case+3,adt.startswith('float') and rng.random()<.18)
    side=rng.choice(['left','right'])
    scalar=rng.random()<.35
    kn=1 if scalar else rng.randint(0,12)
    if kdt=='bool': kvals=[bool(rng.randrange(2)) for _ in range(kn)]
    elif kdt.startswith('uint'): kvals=[rng.randrange(0,220) for _ in range(kn)]
    elif kdt.startswith('int'): kvals=[rng.randrange(-120,121) for _ in range(kn)]
    else:
        kvals=[rng.randrange(-120,121)*0.25 for _ in range(kn)]
        if kn and rng.random()<.12: kvals[-1]=float('nan')
    if scalar:
        key=np.array(kvals[0],dtype=kdt)
        ex=int(np.searchsorted(a,key,side=side))+1
        kexpr=ls(key.item())
        lines += [f'do -- searchscalar {case}',f'  local a=np.array({lt(av)},np.{adt})',f'  local r=np.searchsorted(a,{kexpr},"{side}")',f'  assert(r=={ex},"searchsorted scalar {case} got "..tostring(r))','end']
    else:
        # Sometimes use 2-D needles to ensure output shape preservation.
        if kn>=2 and kn%2==0 and rng.random()<.45:
            shape=(2,kn//2); key=np.array(kvals,dtype=kdt).reshape(shape)
        else: key=np.array(kvals,dtype=kdt)
        ex=np.searchsorted(a,key,side=side)+1
        kexpr=f'np.array({lt(key.tolist())},np.{kdt})'
        lines += [f'do -- searcharray {case}',f'  local a=np.array({lt(av)},np.{adt})',f'  local k={kexpr}',f'  local r=np.searchsorted(a,k,"{side}")',f'  assert(r.dtype=="int64","searchsorted {case} dtype")',f'  assert(eq(r.shape,{lt(list(ex.shape))}),"searchsorted {case} shape")',f'  assert(eq(r.strides,{lt(list(ex.strides))}),"searchsorted {case} strides")',f'  assert(eq(r:tolist(),{lt(ex.tolist())}),"searchsorted {case} values")','end']
    count+=1

# sorter path: haystack intentionally unsorted, sorter comes from argsort.
for case in range(100):
    dt=rng.choice([d for d in dtypes if d!='bool'])
    n=rng.randint(1,16)
    if dt.startswith('uint'): vals=[(i*47+case*13)%223 for i in range(n)]
    elif dt.startswith('int'): vals=[((i*47+case*13)%223)-111 for i in range(n)]
    else: vals=[(((i*47+case*13)%223)-111)*0.125 for i in range(n)]
    a=np.array(vals,dtype=dt)
    sorter=np.argsort(a,kind='quicksort')
    side=rng.choice(['left','right'])
    keys=np.array([vals[rng.randrange(n)], 0, vals[rng.randrange(n)]],dtype=dt)
    ex=np.searchsorted(a,keys,side=side,sorter=sorter)+1
    sorter_lua=(sorter+1).tolist()
    lines += [f'do -- sorter {case}',f'  local a=np.array({lt(vals)},np.{dt})',f'  local k=np.array({lt(keys.tolist())},np.{dt})',f'  local sorter=np.array({lt(sorter_lua)},np.int64)',f'  local r=np.searchsorted(a,k,{{side="{side}",sorter=sorter}})',f'  assert(eq(r:tolist(),{lt(ex.tolist())}),"searchsorted sorter {case}")','end']
    count+=1

# Strided sorted haystack, exact NaN boundary, method form, and error semantics.
lines += [
 "do local a=np.array({-5,99,-2,99,0,99,4,99},np.int64):get(np.slice(1,nil,2)); local r=np.searchsorted(a,{-3,0,9}); assert(eq(r:tolist(),{2,3,5}),'strided haystack') end",
 "do local a=np.array({-1,0,2,0/0,0/0},np.float64); assert(a:searchsorted(0/0)==4 and a:searchsorted(0/0,'right')==6,'NaN boundary') end",
 "do local a=np.array({3,1,2},np.int64); local s=np.argsort(a); assert(a:searchsorted(2,{sorter=s})==2,'method sorter') end",
 "do local a=np.array({1,2,3},np.int64); local ok,e=pcall(function() return np.searchsorted(a,2,{sorter={5,5,5}}) end); assert(not ok and tostring(e):find('Sorter index out of range.',1,true),'sorter range error') end",
 "do local a=np.array({1,2,3},np.int64); local ok,e=pcall(function() return np.searchsorted(a,2,{sorter={1,0,3}}) end); assert(not ok and tostring(e):find('sorter index 0 is invalid',1,true),'sorter zero error') end",
 "do local a=np.reshape(np.arange(4),{2,2}); local ok,e=pcall(function() return np.searchsorted(a,2) end); assert(not ok and tostring(e):find('object too deep',1,true),'1d haystack error') end",
]
count+=6
lines.append(f"print('searchsorted differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
