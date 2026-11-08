#!/usr/bin/env python3
from __future__ import annotations
import math, random, warnings
from pathlib import Path
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'numeric_ops_differential_generated.lua'
rng=random.Random(0xB17A125)
dtypes=[np.bool_,np.int8,np.uint8,np.int16,np.uint16,np.int32,np.uint32,np.int64,np.uint64,np.float16,np.float32,np.float64]
ints=[np.bool_,np.int8,np.uint8,np.int16,np.uint16,np.int32,np.uint32,np.int64,np.uint64]
pairs=[((5,),(5,)),((2,3),(3,)),((2,1),(1,3)),((2,3),(1,3))]

def atom(x):
    if isinstance(x,(bool,np.bool_)): return 'true' if bool(x) else 'false'
    if isinstance(x,(np.integer,int)): return str(int(x))
    f=float(x)
    if math.isnan(f): return '(0/0)'
    if math.isinf(f): return 'math.huge' if f>0 else '-math.huge'
    if f==0.0 and math.copysign(1.0,f)<0:return '-0.0'
    return repr(f)
def nested(v):
    if isinstance(v,list):return '{'+','.join(nested(x) for x in v)+'}'
    return atom(v)
def shape(v):return '{'+','.join(map(str,v))+'}'
def arr_expr(a):return f"np.array({nested(a.tolist())},np.{a.dtype.name})"
def vals(sh,dt,special=False,nonzero=False,power_exp=False):
    n=math.prod(sh); d=np.dtype(dt)
    if d==np.bool_: xs=[bool(rng.getrandbits(1)) for _ in range(n)]
    elif np.issubdtype(d,np.unsignedinteger):
        choices=[0,1,2,3,5,7,15,31,63,127]
        if nonzero: choices=choices[1:]
        xs=[rng.choice(choices) for _ in range(n)]
    elif np.issubdtype(d,np.integer):
        choices=[-31,-9,-3,-1,0,1,2,3,7,15,30]
        if nonzero: choices=[x for x in choices if x]
        if power_exp: choices=[0,1,2,3,4,5]
        xs=[rng.choice(choices) for _ in range(n)]
    else:
        choices=[-9.5,-3.0,-1.5,-1.0,-0.0,0.0,0.5,1.0,2.0,3.5,9.0]
        if special: choices += [float('nan'),float('inf'),float('-inf')]
        if nonzero: choices=[x for x in choices if x!=0.0 and not math.isnan(x)]
        xs=[rng.choice(choices) for _ in range(n)]
    return np.array(xs,dtype=dt).reshape(sh)

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
  if type(a)=='boolean' or type(b)=='boolean' then return a==b end
  if type(a)~='number' or type(b)~='number' then return a==b end
  if a~=a and b~=b then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return a==b end
  if a==b then return true end
  local scale=math.max(1,math.abs(a),math.abs(b))
  return math.abs(a-b)<=4e-6*scale
end
''']
count=0

# Arithmetic/modulo/power/minmax. Avoid negative integer exponents here; tested explicitly below.
ops=[('floor_divide',np.floor_divide),('remainder',np.remainder),('power',np.power),('fmax',np.fmax),('fmin',np.fmin)]
for name,fn in ops:
    for _ in range(95):
        sa,sb=rng.choice(pairs); da,db=rng.choice(dtypes),rng.choice(dtypes)
        a=vals(sa,da,special=name in ('fmax','fmin'))
        b=vals(sb,db,special=name in ('fmax','fmin'),power_exp=(name=='power' and np.issubdtype(np.dtype(db),np.signedinteger)))
        if name=='power' and np.issubdtype(np.dtype(db),np.signedinteger): b=np.abs(b).astype(db)
        with warnings.catch_warnings():
            warnings.simplefilter('ignore')
            try:r=fn(a,b)
            except (TypeError,OverflowError,ValueError):continue
        lines += [f"do -- {name} {count}",f" local a={arr_expr(a)}",f" local b={arr_expr(b)}",f" local r=np.{name}(a,b)",
                  f" assert(r.dtype=='{r.dtype.name}','{name} dtype {count} '..r.dtype)",
                  f" assert(seqeq(r.shape,{shape(r.shape)}),'{name} shape {count}')",
                  f" assert(veq(r:tolist(),{nested(r.tolist())}),'{name} values {count}')","end"]
        count+=1

# Bitwise loops: only bool/integer combinations whose resolver succeeds.
for name,fn in [('bitwise_and',np.bitwise_and),('bitwise_or',np.bitwise_or),('bitwise_xor',np.bitwise_xor)]:
    for _ in range(90):
        sa,sb=rng.choice(pairs); da,db=rng.choice(ints),rng.choice(ints)
        a=vals(sa,da); b=vals(sb,db)
        try:r=fn(a,b)
        except TypeError:
            lines += [f"do -- {name} type error {count}",f" local a={arr_expr(a)}",f" local b={arr_expr(b)}",f" local ok=pcall(function() return np.{name}(a,b) end)",f" assert(not ok,'{name} error {count}')","end"]
            count+=1;continue
        lines += [f"do -- {name} {count}",f" local a={arr_expr(a)}",f" local b={arr_expr(b)}",f" local r=np.{name}(a,b)",
                  f" assert(r.dtype=='{r.dtype.name}','{name} dtype {count}')",f" assert(veq(r:tolist(),{nested(r.tolist())}),'{name} values {count}')","end"]
        count+=1

# copysign loop selection includes float16/32/64 for the exposed numeric subset.
copypairs=[(np.int8,np.int8),(np.uint8,np.int8),(np.float16,np.int8),(np.float16,np.float16),(np.int16,np.int16),(np.uint16,np.int16),(np.int32,np.int8),(np.int64,np.uint64),(np.float32,np.int16),(np.float32,np.float32),(np.float64,np.int8),(np.float64,np.float32)]
for _ in range(90):
    da,db=rng.choice(copypairs); sh=rng.choice([(5,),(2,3)])
    a=vals(sh,da,special=True); b=vals(sh,db,special=False)
    with warnings.catch_warnings():
        warnings.simplefilter('ignore'); r=np.copysign(a,b)
    lines += [f"do -- copysign {count}",f" local a={arr_expr(a)}",f" local b={arr_expr(b)}",f" local r=np.copysign(a,b)",
              f" assert(r.dtype=='{r.dtype.name}','copysign dtype {count} '..r.dtype)",f" assert(veq(r:tolist(),{nested(r.tolist())}),'copysign values {count}')","end"]
    count+=1

# Weak integer/float/bool scalar behavior.
for name,fn in ops+[('bitwise_and',np.bitwise_and),('bitwise_or',np.bitwise_or),('bitwise_xor',np.bitwise_xor),('copysign',np.copysign)]:
    for _ in range(38):
        dt=rng.choice(dtypes); a=vals((4,),dt,special=name in ('fmax','fmin'))
        if rng.random()<.2: scalar=bool(rng.getrandbits(1))
        elif rng.random()<.65: scalar=rng.choice([-200,-3,-1,0,1,2,5,127,200])
        else: scalar=rng.choice([-2.5,-0.0,0.5,2.0,10.0])
        left=rng.random()<.5
        with warnings.catch_warnings():
            warnings.simplefilter('ignore')
            try:r=fn(scalar,a) if left else fn(a,scalar)
            except (TypeError,OverflowError,ValueError):
                expr=f"np.{name}({atom(scalar)},a)" if left else f"np.{name}(a,{atom(scalar)})"
                lines += [f"do -- scalar error {name} {count}",f" local a={arr_expr(a)}",f" local ok=pcall(function() return {expr} end)",f" assert(not ok,'{name} scalar error {count}')","end"]
                count+=1;continue
        expr=f"np.{name}({atom(scalar)},a)" if left else f"np.{name}(a,{atom(scalar)})"
        lines += [f"do -- scalar {name} {count}",f" local a={arr_expr(a)}",f" local r={expr}",f" assert(r.dtype=='{r.dtype.name}','{name} scalar dtype {count} '..r.dtype)",f" assert(veq(r:tolist(),{nested(r.tolist())}),'{name} scalar values {count}')","end"]
        count+=1

# out/where representative cases, including integer power negative masked off.
for name,fn in [('floor_divide',np.floor_divide),('remainder',np.remainder),('power',np.power),('bitwise_xor',np.bitwise_xor),('fmax',np.fmax),('copysign',np.copysign)]:
    for _ in range(30):
        if name=='copysign': da,db=rng.choice(copypairs)
        elif name=='bitwise_xor': da,db=rng.choice(ints),rng.choice(ints)
        else: da,db=rng.choice(dtypes),rng.choice(dtypes)
        a=vals((2,3),da,special=name=='fmax'); b=vals((1,3),db,special=name=='fmax',power_exp=name=='power' and np.issubdtype(np.dtype(db),np.signedinteger))
        if name=='power' and np.issubdtype(np.dtype(db),np.signedinteger):b=np.abs(b).astype(db)
        mask=np.array([[True,False,True],[False,True,False]],dtype=bool)
        with warnings.catch_warnings():
            warnings.simplefilter('ignore')
            try:
                base=fn(a,b)
                init=np.full(base.shape,3,dtype=base.dtype); ex=init.copy(); fn(a,b,out=ex,where=mask)
            except (TypeError,OverflowError,ValueError):continue
        lines += [f"do -- outwhere {name} {count}",f" local a={arr_expr(a)}",f" local b={arr_expr(b)}",f" local m={arr_expr(mask)}",(f" local o=np.ones({shape(base.shape)},np.{base.dtype.name})" if base.dtype==np.dtype(np.bool_) else f" local o=np.ones({shape(base.shape)},np.{base.dtype.name})*3"),f" local r=np.{name}(a,b,{{out=o,where=m}})",f" assert(r==o,'{name} out identity {count}')",f" assert(veq(o:tolist(),{nested(ex.tolist())}),'{name} out values {count}')","end"]
        count+=1

# Exact edge invariants from upstream integer division/modulo/power and floating divmod.
lines += [r'''
do
  local a=np.array({-7,-7,7,7},np.int8)
  local b=np.array({3,-3,3,-3},np.int8)
  assert(veq(np.floor_divide(a,b):tolist(),{-3,2,2,-3}),'signed floor divide')
  assert(veq(np.remainder(a,b):tolist(),{2,-1,1,-2}),'signed remainder')
end

do
  local a=np.array({-128},np.int8)
  local b=np.array({-1},np.int8)
  assert(np.floor_divide(a,b)[1]==-128,'signed floor overflow wrap')
  assert(np.remainder(a,b)[1]==0,'signed remainder overflow zero')
end

do
  local a=np.array({2,2},np.int8)
  local e=np.array({-1,2},np.int8)
  local o=np.zeros({2},np.int8)
  local m=np.array({false,true},np.bool)
  np.power(a,e,{out=o,where=m})
  assert(veq(o:tolist(),{0,4}),'masked negative integer power')
  local ok=pcall(function() return np.power(a,e) end)
  assert(not ok,'active negative integer power must fail')
end

do
  local b=np.array({true,false},np.bool)
  assert(np.floor_divide(b,true).dtype=='int8','bool floor bool dtype')
  assert(np.power(b,true).dtype=='int8','bool power bool dtype')
  assert(np.bitwise_or(b,true).dtype=='bool','bool bitwise dtype')
end

do
  local a=np.array({1.0,0/0,-0.0},np.float64)
  local b=np.array({0/0,2.0,0.0},np.float64)
  assert(veq(np.fmax(a,b):tolist(),{1.0,2.0,0.0}),'fmax nan ignore')
  assert(veq(np.fmin(a,b):tolist(),{1.0,2.0,0.0}),'fmin nan ignore')
end

do
  local a=np.array({7,8},np.int8)
  assert((a//3):tolist()[1]==2,'__idiv')
  assert((a%3):tolist()[2]==2,'__mod')
  assert((np.array({2,3},np.int8)^2):tolist()[2]==9,'__pow')
  assert((np.array({6},np.int8)&3)[1]==2,'__band')
  assert((np.array({4},np.int8)|3)[1]==7,'__bor')
  assert((np.array({7},np.int8)~3)[1]==4,'__bxor')
end
''']
count += 6
lines.append(f"print('numeric ops differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
