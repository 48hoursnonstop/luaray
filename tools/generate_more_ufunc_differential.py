#!/usr/bin/env python3
from __future__ import annotations
import math
import random
from pathlib import Path
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'more_ufunc_differential_generated.lua'
rng=random.Random(20261007)

dtypes=[np.bool_,np.int8,np.uint8,np.int16,np.uint16,np.int32,np.uint32,np.int64,np.uint64,np.float16,np.float32,np.float64]
dtype_name={np.dtype(x).type:np.dtype(x).name for x in dtypes}
shapes=[(5,), (2,3), (2,1), (1,3), (2,3,1), (1,3,4)]
pairs=[((5,),(5,)),((2,3),(3,)),((2,1),(1,3)),((2,3),(1,3)),((2,3,1),(1,3,4))]

def make_values(shape,dt,denom=False):
    n=math.prod(shape)
    vals=[]
    for _ in range(n):
        if np.dtype(dt)==np.bool_:
            v=bool(rng.getrandbits(1))
            if denom and not v: v=True
        elif np.issubdtype(dt,np.unsignedinteger):
            v=rng.randint(1 if denom else 0,25)
        elif np.issubdtype(dt,np.integer):
            choices=[-17,-7,-3,-1,1,2,5,11,23] if denom else [-23,-17,-7,-3,-1,0,1,2,5,11,23]
            v=rng.choice(choices)
        else:
            choices=[-7.5,-3.25,-1.5,-0.5,0.25,1.25,2.5,7.75]
            if denom: choices=[x for x in choices if x != 0]
            v=rng.choice(choices)
        vals.append(v)
    return np.array(vals,dtype=dt).reshape(shape)

def lua_atom(x):
    if isinstance(x,(np.bool_,bool)): return 'true' if bool(x) else 'false'
    if isinstance(x,(np.integer,int)): return str(int(x))
    x=float(x)
    if math.isnan(x): return '(0/0)'
    if math.isinf(x): return 'math.huge' if x>0 else '-math.huge'
    return repr(x)

def lua_nested(v):
    if isinstance(v,list): return '{'+','.join(lua_nested(x) for x in v)+'}'
    return lua_atom(v)

def lua_array(a):
    if a.ndim==0:
        return f"np.reshape(np.array({{{lua_atom(a.item())}}},np.{a.dtype.name}),{{}})"
    return f"np.array({lua_nested(a.tolist())},np.{a.dtype.name})"

def shape_lit(shape): return '{'+','.join(map(str,shape))+'}'
def strides_lit(st): return '{'+','.join(map(str,st))+'}'

lines=["local np=require('luaray_core')",r'''
local function seqeq(a,b)
  if #a~=#b then return false end
  for i=1,#a do if a[i]~=b[i] then return false end end
  return true
end
local function veq(a,b)
  if type(a)=='table' then
    if type(b)~='table' or #a~=#b then return false end
    for i=1,#a do if not veq(a[i],b[i]) then return false end end
    return true
  end
  if type(b)~='number' and type(a)~='number' then return a==b end
  if type(a)~='number' or type(b)~='number' then return false end
  if a~=a and b~=b then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return a==b end
  local scale=math.max(1,math.abs(a),math.abs(b))
  return math.abs(a-b) <= 2e-6*scale
end
''']
case=0
for opname,op in [('subtract',np.subtract),('true_divide',np.true_divide)]:
    for _ in range(120):
        sha,shb=rng.choice(pairs)
        da,db=rng.choice(dtypes),rng.choice(dtypes)
        if opname=='subtract' and np.dtype(da)==np.bool_ and np.dtype(db)==np.bool_:
            db=np.int8
        a=make_values(sha,da,False)
        b=make_values(shb,db,opname=='true_divide')
        try:r=op(a,b)
        except TypeError:continue
        lines += [f"-- {opname} array case {case}","do",f"  local a={lua_array(a)}",f"  local b={lua_array(b)}",f"  local r=np.{opname}(a,b)",f"  assert(r.dtype=='{r.dtype.name}','{opname} {case} dtype '..r.dtype)",f"  assert(seqeq(r.shape,{shape_lit(r.shape)}),'{opname} {case} shape')",f"  assert(seqeq(r.strides,{strides_lit(r.strides)}),'{opname} {case} strides')",f"  assert(veq(r:tolist(),{lua_nested(r.tolist())}),'{opname} {case} values')","end"]
        case+=1

scalar_cases=0
for opname,op in [('subtract',np.subtract),('true_divide',np.true_divide)]:
    for _ in range(80):
        sh=rng.choice(shapes[:4])
        dt=rng.choice(dtypes)
        a=make_values(sh,dt,opname=='true_divide' and rng.random()<0.5)
        scalar_is_float=rng.random()<0.35
        scalar=rng.choice([-5.5,-2.0,0.5,2.5,7.0]) if scalar_is_float else rng.choice([-7,-2,-1,1,2,5,11])
        left=rng.random()<0.5
        # Keep denominators nonzero for ordinary cases.
        if opname=='true_divide' and not left and scalar==0: scalar=2
        if opname=='true_divide' and left:
            a=make_values(sh,dt,True)
        try:r=op(scalar,a) if left else op(a,scalar)
        except (TypeError,OverflowError):continue
        arr_expr=lua_array(a)
        scalar_expr=lua_atom(scalar)
        expr=f"np.{opname}({scalar_expr},a)" if left else f"np.{opname}(a,{scalar_expr})"
        lines += [f"-- {opname} weak-scalar case {scalar_cases}","do",f"  local a={arr_expr}",f"  local r={expr}",f"  assert(r.dtype=='{r.dtype.name}','scalar {scalar_cases} dtype '..r.dtype)",f"  assert(seqeq(r.shape,{shape_lit(r.shape)}),'scalar {scalar_cases} shape')",f"  assert(veq(r:tolist(),{lua_nested(r.tolist())}),'scalar {scalar_cases} values')","end"]
        scalar_cases+=1

# Error and IEEE edge cases sourced from the same ufunc resolvers/loops.
lines += [r'''
do
  local a=np.array({true,false},np.bool)
  local b=np.array({true,true},np.bool)
  local ok,err=pcall(function() return np.subtract(a,b) end)
  assert(not ok and tostring(err):find('boolean subtract',1,true),'bool subtract error')
end

do
  local a=np.array({1.0,0.0},np.float64)
  local b=np.array({0.0,0.0},np.float64)
  local r=np.true_divide(a,b)
  assert(r[1]==math.huge,'divide by zero -> inf')
  assert(r[2]~=r[2],'zero by zero -> nan')
end

do
  local b=np.array({true,false},np.bool)
  local bor=b+true
  assert(bor.dtype=='bool' and bor[1] and bor[2],'weak bool add')
  local band=true*b
  assert(band.dtype=='bool' and band[1] and not band[2],'weak bool multiply')
  local bd=b/true
  assert(bd.dtype=='float64' and bd[1]==1 and bd[2]==0,'weak bool true_divide')
  local i=np.array({1,2},np.int8)
  assert((i+true).dtype=='int8' and (true-i)[2]==-1,'weak bool with int8')
  local f=np.array({1.0,2.0},np.float32)
  assert((true/f).dtype=='float32','weak bool with float32')
end
''']
lines.append(f"print('subtract/true_divide differential: {case} array cases + {scalar_cases} scalar cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f"{OUT} ({case} array + {scalar_cases} scalar cases)")
