#!/usr/bin/env python3
from __future__ import annotations
import math, random, warnings
from pathlib import Path
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'math_ufunc_differential_generated.lua'
rng=random.Random(0x5A17C0DE)
ops=[('sqrt',np.sqrt),('exp',np.exp),('log',np.log),('sin',np.sin),('cos',np.cos),('tan',np.tan)]
supported=[np.bool_,np.int8,np.uint8,np.int16,np.uint16,np.int32,np.uint32,np.int64,np.uint64,np.float16,np.float32,np.float64]
shapes=[(7,),(2,3),(2,3,1)]

def atom(x):
    if isinstance(x,(bool,np.bool_)):return 'true' if bool(x) else 'false'
    if isinstance(x,(np.integer,int)):return str(int(x))
    f=float(x)
    if math.isnan(f):return '(0/0)'
    if math.isinf(f):return 'math.huge' if f>0 else '-math.huge'
    if f==0.0 and math.copysign(1.0,f)<0:return '-0.0'
    return repr(f)

def nested(v):
    if isinstance(v,list):return '{'+','.join(nested(x) for x in v)+'}'
    return atom(v)

def dtype_name(dt):
    d=np.dtype(dt)
    return d.name

def arr_expr(a,transpose=False):
    base_vals=a.T.tolist() if transpose else a.tolist()
    base=f"np.array({nested(base_vals)},np.{dtype_name(a.dtype)})"
    return f"({base}).T" if transpose else base

def shape(v):return '{'+','.join(map(str,v))+'}'

def vals(sh,dt,op):
    n=math.prod(sh);d=np.dtype(dt)
    if np.issubdtype(d,np.unsignedinteger):
        choices=[0,1,2,3,4,7,16,31,64]
    elif np.issubdtype(d,np.integer):
        choices=[-16,-7,-3,-1,0,1,2,3,4,9,16]
    else:
        if op in ('sqrt','log'):
            choices=[-16.0,-4.0,-1.0,-0.0,0.0,0.125,0.5,1.0,2.0,4.0,16.0,float('inf')]
        elif op=='exp':
            choices=[-10.0,-3.0,-1.0,-0.0,0.0,0.5,1.0,2.0,5.0]
        else:
            choices=[-6.0,-3.1415926,-1.5,-1.0,-0.0,0.0,0.5,1.0,1.5707963,3.1415926,6.0]
    return np.array([rng.choice(choices) for _ in range(n)],dtype=dt).reshape(sh)

lines=["local np=require('luaray_core')",r'''
local function seqeq(a,b)
  if #a~=#b then return false end
  for i=1,#a do if a[i]~=b[i] then return false end end
  return true
end
local function veq(a,b,tol)
  tol=tol or 8e-6
  if type(a)=='table' then
    if type(b)~='table' or #a~=#b then return false end
    for i=1,#a do if not veq(a[i],b[i],tol) then return false end end
    return true
  end
  if type(a)~='number' or type(b)~='number' then return a==b end
  if a~=a and b~=b then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return a==b end
  if a==b then return true end
  local scale=math.max(1,math.abs(a),math.abs(b))
  return math.abs(a-b)<=tol*scale
end
''']
count=0

# Supported resolver paths, including KEEPORDER on transposes.
for opname,fn in ops:
    for _ in range(82):
        dt=rng.choice(supported);sh=rng.choice(shapes)
        a=vals(sh,dt,opname)
        trans=len(sh)==2 and rng.random()<.35
        if trans:a=a.T
        with warnings.catch_warnings():
            warnings.simplefilter('ignore')
            r=fn(a)
        ae=arr_expr(a,trans)
        tol='2e-3' if r.dtype==np.float16 else ('2e-5' if r.dtype==np.float32 else '8e-12')
        lines += [f"do -- {opname} supported {count}",f" local a={ae}",f" local r=np.{opname}(a)",
                  f" assert(r.dtype=='{r.dtype.name}','{opname} dtype {count} '..r.dtype)",
                  f" assert(seqeq(r.shape,{shape(r.shape)}),'{opname} shape {count}')",
                  f" assert(seqeq(r.strides,{shape(r.strides)}),'{opname} strides {count}')",
                  f" assert(veq(r:tolist(),{nested(r.tolist())},{tol}),'{opname} values {count}')","end"]
        count+=1

# float16 resolver paths are now native; bool/int8/uint8 are exercised above.

# out=/where= with same-kind floating output casts.  Initial values must remain where mask is false.
for opname,fn in ops:
    for _ in range(28):
        dt=rng.choice(supported);a=vals((2,3),dt,opname)
        m=np.array([[True,False,True],[False,True,False]],dtype=bool)
        with warnings.catch_warnings():
            warnings.simplefilter('ignore');base=fn(a)
        # alternate between native result dtype and the other common float width when NumPy permits it
        candidates=[base.dtype]
        if base.dtype==np.float16:candidates.extend([np.dtype(np.float32),np.dtype(np.float64)])
        elif base.dtype==np.float32:candidates.extend([np.dtype(np.float16),np.dtype(np.float64)])
        elif base.dtype==np.float64:candidates.extend([np.dtype(np.float16),np.dtype(np.float32)])
        odt=rng.choice(candidates)
        out=np.full(base.shape,3,dtype=odt)
        ex=out.copy()
        with warnings.catch_warnings():
            warnings.simplefilter('ignore')
            try:fn(a,out=ex,where=m)
            except TypeError:continue
        tol='2e-3' if base.dtype==np.float16 else ('2e-5' if base.dtype==np.float32 else '8e-12')
        lines += [f"do -- {opname} outwhere {count}",f" local a={arr_expr(a)}",f" local m={arr_expr(m)}",
                  f" local o=np.ones({shape(base.shape)},np.{odt.name})*3",
                  f" local r=np.{opname}(a,{{out=o,where=m}})",
                  f" assert(r==o,'{opname} out identity {count}')",
                  f" assert(o.dtype=='{odt.name}','{opname} out dtype {count}')",
                  f" assert(veq(o:tolist(),{nested(ex.tolist())},{tol}),'{opname} out values {count}')","end"]
        count+=1

# Stable special-value invariants.  We intentionally do not test warning/seterr state yet.
lines += [r'''
do
  local x=np.array({-1.0,-0.0,0.0,4.0,math.huge},np.float64)
  local r=np.sqrt(x)
  assert(r[1]~=r[1] and r[2]==0 and r[3]==0 and r[4]==2 and r[5]==math.huge,'sqrt specials')
end

do
  local x=np.array({-1.0,-0.0,0.0,1.0,math.huge},np.float64)
  local r=np.log(x)
  assert(r[1]~=r[1] and r[2]==-math.huge and r[3]==-math.huge and r[4]==0 and r[5]==math.huge,'log specials')
end

do
  local x=np.array({-0.0,0.0},np.float64)
  local s=np.sin(x)
  assert(s[1]==0 and 1/s[1]==-math.huge and s[2]==0 and 1/s[2]==math.huge,'sin signed zero')
  local t=np.tan(x)
  assert(t[1]==0 and 1/t[1]==-math.huge and t[2]==0 and 1/t[2]==math.huge,'tan signed zero')
end
''']
count+=3
lines.append(f"print('math ufunc differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
