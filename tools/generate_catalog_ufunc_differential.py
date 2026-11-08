#!/usr/bin/env python3
from __future__ import annotations
import math, random
from pathlib import Path
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'catalog_ufunc_differential_generated.lua'
rng=random.Random(0xCADA10)
dtypes=[np.bool_,np.int8,np.uint8,np.int16,np.uint16,np.int32,np.uint32,np.int64,np.uint64,np.float16,np.float32,np.float64]
pairs=[((5,),(5,)),((2,3),(3,)),((2,1),(1,3)),((2,3),(1,3)),((2,3,1),(1,3,4))]


def atom(x):
    if isinstance(x,(bool,np.bool_)): return 'true' if bool(x) else 'false'
    if isinstance(x,(np.integer,int)): return str(int(x))
    f=float(x)
    if math.isnan(f): return '(0/0)'
    if math.isinf(f): return 'math.huge' if f>0 else '-math.huge'
    # retain -0.0
    if f==0.0 and math.copysign(1.0,f)<0: return '-0.0'
    return repr(f)

def nested(v):
    if isinstance(v,list): return '{'+','.join(nested(x) for x in v)+'}'
    return atom(v)

def arr_expr(a, transpose=False):
    base=f"np.array({nested(a.T.tolist() if transpose else a.tolist())},np.{a.dtype.name})"
    return f"({base}).T" if transpose else base

def shape(v): return '{'+','.join(map(str,v))+'}'

def vals(shape_,dt,allow_special=False):
    n=math.prod(shape_)
    if np.dtype(dt)==np.bool_:
        xs=[bool(rng.getrandbits(1)) for _ in range(n)]
    elif np.issubdtype(dt,np.unsignedinteger):
        xs=[rng.choice([0,1,2,5,17,63,127,251]) for _ in range(n)]
    elif np.issubdtype(dt,np.integer):
        xs=[rng.choice([-127,-31,-7,-1,0,1,2,9,63,126]) for _ in range(n)]
    else:
        choices=[-9.5,-2.25,-1.0,-0.0,0.0,0.5,1.0,3.75,11.0]
        if allow_special: choices += [float('nan'),float('inf'),float('-inf')]
        xs=[rng.choice(choices) for _ in range(n)]
    return np.array(xs,dtype=dt).reshape(shape_)

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
  return math.abs(a-b)<=3e-6*scale
end
''']
count=0
binary=[
 ('equal',np.equal),('not_equal',np.not_equal),('less',np.less),('less_equal',np.less_equal),
 ('greater',np.greater),('greater_equal',np.greater_equal),
 ('logical_and',np.logical_and),('logical_or',np.logical_or),('logical_xor',np.logical_xor),
 ('maximum',np.maximum),('minimum',np.minimum),
]
for opname,fn in binary:
    reps=55 if opname in ('maximum','minimum') else 45
    for j in range(reps):
        sa,sb=rng.choice(pairs); da,db=rng.choice(dtypes),rng.choice(dtypes)
        a=vals(sa,da,allow_special=True); b=vals(sb,db,allow_special=True)
        # transpose some 2-D equal-shape cases to exercise KEEPORDER output
        trans=(len(sa)==2 and sa==sb and rng.random()<.25)
        if trans: a=a.T; b=b.T
        try: r=fn(a,b)
        except (TypeError,OverflowError,FloatingPointError): continue
        ae=arr_expr(a,trans); be=arr_expr(b,trans)
        lines += [f"do -- {opname} array {count}",f"  local a={ae}",f"  local b={be}",f"  local r=np.{opname}(a,b)",
                  f"  assert(r.dtype=='{r.dtype.name}','{opname} {count} dtype '..r.dtype)",
                  f"  assert(seqeq(r.shape,{shape(r.shape)}),'{opname} {count} shape')",
                  f"  assert(seqeq(r.strides,{shape(r.strides)}),'{opname} {count} strides')",
                  f"  assert(veq(r:tolist(),{nested(r.tolist())}),'{opname} {count} values')","end"]
        count+=1

# Weak scalar rules: comparisons/logicals permit out-of-range integer comparisons;
# maximum/minimum follow uniform-operation NEP50 bounds checks.
scalar_count=0
for opname,fn in binary:
    for j in range(26):
        dt=rng.choice(dtypes); a=vals((5,),dt,allow_special=True)
        if rng.random()<.55: s=rng.choice([-300,-129,-1,0,1,127,128,200,300])
        else: s=rng.choice([-3.5,-0.0,0.5,2.25,1e10])
        left=rng.random()<.5
        try:r=fn(s,a) if left else fn(a,s)
        except (TypeError,OverflowError):
            # Verify the same Lua call errors for min/max bound failures.
            if opname in ('maximum','minimum'):
                expr=f"np.{opname}({atom(s)},a)" if left else f"np.{opname}(a,{atom(s)})"
                lines += [f"do -- {opname} scalar error {scalar_count}",f"  local a={arr_expr(a)}",f"  local ok=pcall(function() return {expr} end)",f"  assert(not ok,'{opname} scalar error {scalar_count}')","end"]
                scalar_count+=1
            continue
        expr=f"np.{opname}({atom(s)},a)" if left else f"np.{opname}(a,{atom(s)})"
        lines += [f"do -- {opname} scalar {scalar_count}",f"  local a={arr_expr(a)}",f"  local r={expr}",
                  f"  assert(r.dtype=='{r.dtype.name}','scalar {scalar_count} dtype '..r.dtype)",
                  f"  assert(veq(r:tolist(),{nested(r.tolist())}),'scalar {scalar_count} values')","end"]
        scalar_count+=1

# Weak boolean scalars are distinct from integer 0/1 under NEP 50.
bool_scalar_count=0
for opname,fn in binary:
    for truth in (False,True):
        for left in (False,True):
            dt=rng.choice(dtypes); a=vals((4,),dt,allow_special=True)
            try: r=fn(truth,a) if left else fn(a,truth)
            except (TypeError,OverflowError): continue
            expr=f"np.{opname}({atom(truth)},a)" if left else f"np.{opname}(a,{atom(truth)})"
            lines += [f"do -- {opname} bool scalar {bool_scalar_count}",f"  local a={arr_expr(a)}",f"  local r={expr}",
                      f"  assert(r.dtype=='{r.dtype.name}','bool scalar {bool_scalar_count} dtype '..r.dtype)",
                      f"  assert(veq(r:tolist(),{nested(r.tolist())}),'bool scalar {bool_scalar_count} values')","end"]
            bool_scalar_count+=1

# out/where on representative bool-output and value-output ufuncs.
out_count=0
for opname,fn in [('equal',np.equal),('logical_or',np.logical_or),('maximum',np.maximum),('minimum',np.minimum)]:
    for j in range(35):
        a=vals((2,3),rng.choice(dtypes),allow_special=True); b=vals((1,3),rng.choice(dtypes),allow_special=True)
        mask=np.array([[True,False,True],[False,True,False]],dtype=np.bool_)
        try:
            base=fn(a,b)
            odt=np.int8 if base.dtype==np.bool_ and rng.random()<.5 else base.dtype
            init=np.full(base.shape,7,dtype=odt)
            ex=init.copy(); fn(a,b,out=ex,where=mask)
        except (TypeError,OverflowError): continue
        lines += [f"do -- {opname} out/where {out_count}",f"  local a={arr_expr(a)}",f"  local b={arr_expr(b)}",f"  local m={arr_expr(mask)}",f"  local o=np.ones({shape(base.shape)},np.{np.dtype(odt).name})" if np.dtype(odt)==np.dtype(np.bool_) else f"  local o=np.ones({shape(base.shape)},np.{np.dtype(odt).name})*7",f"  local r=np.{opname}(a,b,{{out=o,where=m}})",f"  assert(r==o,'{opname} out identity {out_count}')",f"  assert(o.dtype=='{np.dtype(odt).name}','{opname} out dtype {out_count}')",f"  assert(veq(o:tolist(),{nested(ex.tolist())}),'{opname} out values {out_count}')","end"]
        out_count+=1

unary=[('negative',np.negative),('absolute',np.absolute),('positive',np.positive),('sign',np.sign),
       ('logical_not',np.logical_not),('isnan',np.isnan),('isinf',np.isinf),('isfinite',np.isfinite),('signbit',np.signbit)]
unary_count=0
for opname,fn in unary:
    for j in range(35):
        dt=rng.choice(dtypes); sh=rng.choice([(5,),(2,3)])
        a=vals(sh,dt,allow_special=True)
        # NaN sign is payload/producer-dependent: Python's float('nan') and
        # Lua's (0/0) need not have the same sign bit.  Do not make that an
        # invariant for signbit; infinities and signed zero remain covered.
        if opname=='signbit' and np.issubdtype(np.dtype(dt),np.floating):
            a=np.where(np.isnan(a), np.array(0.0,dtype=dt), a).astype(dt,copy=False)
        trans=(len(sh)==2 and rng.random()<.35)
        if trans:a=a.T
        try:r=fn(a)
        except TypeError:
            lines += [f"do -- {opname} bool/error {unary_count}",f"  local a={arr_expr(a,trans)}",f"  local ok=pcall(function() return np.{opname}(a) end)",f"  assert(not ok,'{opname} expected error {unary_count}')","end"]
            unary_count+=1; continue
        lines += [f"do -- {opname} unary {unary_count}",f"  local a={arr_expr(a,trans)}",f"  local r=np.{opname}(a)",f"  assert(r.dtype=='{r.dtype.name}','{opname} unary dtype {unary_count}')",f"  assert(seqeq(r.shape,{shape(r.shape)}),'{opname} unary shape {unary_count}')",f"  assert(seqeq(r.strides,{shape(r.strides)}),'{opname} unary strides {unary_count}')",f"  assert(veq(r:tolist(),{nested(r.tolist())}),'{opname} unary values {unary_count}')","end"]
        unary_count+=1

# Unary out+where coverage.
unary_out=0
for opname,fn in [('absolute',np.absolute),('logical_not',np.logical_not),('isfinite',np.isfinite),('negative',np.negative)]:
    for j in range(20):
        dt=rng.choice(dtypes)
        if opname=='negative' and dt==np.bool_: dt=np.int8
        a=vals((2,3),dt,allow_special=True); mask=np.array([[True,False,True],[False,True,False]],dtype=np.bool_)
        try:
            base=fn(a); odt=base.dtype; init=np.full(base.shape,3,dtype=odt); ex=init.copy();fn(a,out=ex,where=mask)
        except TypeError:continue
        lines += [f"do -- {opname} unary out {unary_out}",f"  local a={arr_expr(a)}",f"  local m={arr_expr(mask)}",f"  local o=np.ones({shape(base.shape)},np.{odt.name})" if odt==np.dtype(np.bool_) else f"  local o=np.ones({shape(base.shape)},np.{odt.name})*3",f"  local r=np.{opname}(a,{{out=o,where=m}})",f"  assert(r==o,'{opname} unary out identity {unary_out}')",f"  assert(veq(o:tolist(),{nested(ex.tolist())}),'{opname} unary out values {unary_out}')","end"]
        unary_out+=1

# qQ/Qq exact-comparison invariant: float64 promotion would incorrectly claim equality.
lines += [r'''
do
  local a=np.array({9007199254740993},np.int64)
  local b=np.array({9007199254740992},np.uint64)
  assert(np.equal(a,b)[1]==false,'int64/uint64 comparison must not lose precision')
  assert(np.greater(a,b)[1]==true,'int64/uint64 exact ordering')
end

do
  local b=np.array({false,true},np.bool)
  local ok,e=pcall(function() return np.negative(b) end)
  assert(not ok and tostring(e):find('boolean negative',1,true),'bool negative error')
  assert(veq(np.absolute(b):tolist(),{false,true}),'bool absolute identity')
  assert(veq(np.logical_not(b):tolist(),{true,false}),'bool logical_not')
end
''']
count += scalar_count+bool_scalar_count+out_count+unary_count+unary_out+2
lines.append(f"print('catalog ufunc differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
