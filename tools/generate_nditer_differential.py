#!/usr/bin/env python3
from __future__ import annotations
import math, random
from pathlib import Path
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'nditer_differential_generated.lua'
rng=random.Random(20261008)

dtypes=[np.bool_,np.int8,np.uint8,np.int16,np.uint16,np.int32,np.uint32,np.int64,np.uint64,np.float16,np.float32,np.float64]
ops=[('add',np.add),('subtract',np.subtract),('multiply',np.multiply),('true_divide',np.true_divide)]
pairs=[((5,),(5,)),((2,3),(3,)),((2,1),(1,3)),((2,3),(1,3)),((2,3,1),(1,3,4))]

def atom(x):
    if isinstance(x,(bool,np.bool_)): return 'true' if bool(x) else 'false'
    if isinstance(x,(int,np.integer)): return str(int(x))
    x=float(x)
    if math.isnan(x): return '(0/0)'
    if math.isinf(x): return 'math.huge' if x>0 else '-math.huge'
    return repr(x)

def nested(v):
    if isinstance(v,list): return '{'+','.join(nested(x) for x in v)+'}'
    return atom(v)

def arr_expr(a: np.ndarray):
    if a.ndim==0:
        return f"np.reshape(np.array({{{atom(a.item())}}},np.{a.dtype.name}),{{}})"
    return f"np.array({nested(a.tolist())},np.{a.dtype.name})"

def shape_lit(x): return '{'+','.join(str(int(v)) for v in x)+'}'
def strides_lit(x): return '{'+','.join(str(int(v)) for v in x)+'}'

def vals(shape,dt,denom=False):
    n=math.prod(shape)
    if np.dtype(dt)==np.bool_:
        v=[bool(rng.getrandbits(1)) for _ in range(n)]
        if denom: v=[True if not x else x for x in v]
    elif np.issubdtype(dt,np.unsignedinteger):
        v=[rng.randint(1 if denom else 0,20) for _ in range(n)]
    elif np.issubdtype(dt,np.integer):
        pool=[-9,-4,-2,-1,1,2,4,9] if denom else [-9,-4,-2,-1,0,1,2,4,9]
        v=[rng.choice(pool) for _ in range(n)]
    else:
        pool=[-5.5,-2.25,-0.5,0.25,1.5,3.75]
        if denom: pool=[x for x in pool if x]
        v=[rng.choice(pool) for _ in range(n)]
    return np.array(v,dtype=dt).reshape(shape)

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
  local scale=math.max(1,math.abs(a),math.abs(b))
  return math.abs(a-b)<=3e-6*scale
end
''']

# 1) Automatic output layout: keep-order must follow NpyIter, not force C order.
auto=0
for _ in range(80):
    shape=rng.choice([(2,3),(3,4),(2,3,4)])
    da,db=rng.choice(dtypes),rng.choice(dtypes)
    opname,op=rng.choice(ops)
    if opname=='subtract' and np.dtype(da)==np.bool_ and np.dtype(db)==np.bool_: db=np.int8
    a=vals(shape,da,False); b=vals(shape,db,opname=='true_divide')
    trans_a=rng.random()<0.55; trans_b=rng.random()<0.55
    if trans_a: a=a.T
    if trans_b: b=b.T
    if a.shape!=b.shape: b=np.array(b.T if trans_b else b,copy=False)
    # keep same logical shape by choosing matching transpose state if needed
    if a.shape!=b.shape:
        trans_b=trans_a
        b=vals(shape,db,opname=='true_divide')
        if trans_b:b=b.T
    try:
        with np.errstate(all='ignore'): r=op(a,b)
    except TypeError: continue
    ba=vals(shape,da,False); bb=vals(shape,db,opname=='true_divide')
    # Recreate exactly the values used above via literals, preserving layout using reshape/T.
    # Literal arrays are C-order; transpose expression creates the same layout and values.
    ea=arr_expr(a.T if trans_a else a)
    eb=arr_expr(b.T if trans_b else b)
    if trans_a: ea=f"({ea}).T"
    if trans_b: eb=f"({eb}).T"
    lines += [f"do -- auto-layout {auto}",f"  local a={ea}",f"  local b={eb}",f"  local r=np.{opname}(a,b)",
              f"  assert(r.dtype=='{r.dtype.name}','auto {auto} dtype '..r.dtype)",
              f"  assert(seqeq(r.shape,{shape_lit(r.shape)}),'auto {auto} shape')",
              f"  assert(seqeq(r.strides,{strides_lit(r.strides)}),'auto {auto} strides')",
              f"  assert(veq(r:tolist(),{nested(r.tolist())}),'auto {auto} values')","end"]
    auto+=1

# 2) out + where + output dtype casting and broadcasting.
out_cases=0
for _ in range(180):
    sha,shb=rng.choice(pairs)
    da,db=rng.choice(dtypes),rng.choice(dtypes)
    opname,op=rng.choice(ops)
    if opname=='subtract' and np.dtype(da)==np.bool_ and np.dtype(db)==np.bool_: db=np.int16
    a=vals(sha,da,False); b=vals(shb,db,opname=='true_divide')
    # Some masks add leading dimensions, exactly as NpyIter's ARRAYMASK does.
    base_shape=np.broadcast_shapes(a.shape,b.shape)
    if rng.random()<0.30:
        mshape=(2,)+(1,)*len(base_shape)
    else:
        mshape=rng.choice([base_shape, (1,)*max(1,len(base_shape)), base_shape[-1:] if base_shape else ()])
    mask=np.ones(mshape,dtype=np.bool_)
    if mask.size and rng.random()<0.8:
        flat=mask.reshape(-1); flat[::max(1,rng.randint(2,4))]=False
    final_shape=np.broadcast_shapes(a.shape,b.shape,mask.shape)
    # Pick an output dtype allowed by default same_kind casting.
    try:
        with np.errstate(all='ignore'): tmp=op(a,b,where=np.ones(final_shape,dtype=bool))
    except TypeError: continue
    allowed=[dt for dt in dtypes if np.can_cast(tmp.dtype,np.dtype(dt),casting='same_kind')]
    if not allowed: continue
    odt=rng.choice(allowed)
    n=math.prod(final_shape)
    raw=np.arange(n,dtype=np.int64).reshape(final_shape)
    out=(raw%17).astype(odt)
    out_lua=arr_expr(out)
    # Some 2D/3D outputs are actual transposed writable views.
    use_t=len(final_shape)>=2 and final_shape==tuple(reversed(final_shape)) and rng.random()<0.2
    # General transpose-view creation without arbitrary axis API: reverse all axes.
    if len(final_shape)>=2 and rng.random()<0.25:
        revshape=tuple(reversed(final_shape))
        base=np.arange(n,dtype=np.int64).reshape(revshape)
        out=(base.T%17).astype(odt,copy=False)
        # astype may copy C-order; construct destination view after dtype allocation instead.
        base=(np.arange(n,dtype=np.int64)%17).astype(odt).reshape(revshape)
        out=base.T
        out_lua=f"np.reshape(np.array({nested(base.reshape(-1).tolist())},np.{np.dtype(odt).name}),{shape_lit(revshape)}).T"
    expected=out.copy(order='K')
    try:
        with np.errstate(all='ignore'): op(a,b,out=expected,where=mask)
    except (TypeError,ValueError,OverflowError): continue
    lines += [f"do -- out-where {out_cases}",f"  local a={arr_expr(a)}",f"  local b={arr_expr(b)}",f"  local m={arr_expr(mask)}",f"  local o={out_lua}",
              f"  local r=np.{opname}(a,b,{{out=o,where=m}})",
              f"  assert(r==o,'out {out_cases} identity')",
              f"  assert(o.dtype=='{expected.dtype.name}','out {out_cases} dtype '..o.dtype)",
              f"  assert(seqeq(o.shape,{shape_lit(expected.shape)}),'out {out_cases} shape')",
              f"  assert(seqeq(o.strides,{strides_lit(expected.strides)}),'out {out_cases} strides')",
              f"  assert(veq(o:tolist(),{nested(expected.tolist())}),'out {out_cases} values')","end"]
    out_cases+=1

# 3) Weak scalar + out + where.
scalar=0
for _ in range(90):
    shape=rng.choice([(5,),(2,3)])
    dt=rng.choice(dtypes)
    opname,op=rng.choice(ops)
    a=vals(shape,dt,opname=='true_divide' and rng.random()<0.5)
    if rng.random()<0.2: sv=bool(rng.getrandbits(1))
    elif rng.random()<0.35: sv=rng.choice([-2.5,-0.5,0.5,2.5])
    else: sv=rng.choice([-4,-2,-1,1,2,4])
    left=rng.random()<0.5
    if opname=='true_divide' and not left and sv in (0,False): sv=2
    if opname=='true_divide' and left: a=vals(shape,dt,True)
    try:
        with np.errstate(all='ignore'): rr=op(sv,a) if left else op(a,sv)
    except (TypeError,OverflowError): continue
    allowed=[od for od in dtypes if np.can_cast(rr.dtype,np.dtype(od),casting='same_kind')]
    if not allowed: continue
    odt=rng.choice(allowed)
    out=(np.arange(math.prod(shape)).reshape(shape)%11).astype(odt)
    mask=np.array([(i%3)!=1 for i in range(math.prod(shape))],dtype=bool).reshape(shape)
    exp=out.copy()
    try:
        with np.errstate(all='ignore'):
            if left: op(sv,a,out=exp,where=mask)
            else: op(a,sv,out=exp,where=mask)
    except (TypeError,ValueError,OverflowError): continue
    call=f"np.{opname}({atom(sv)},a,{{out=o,where=m}})" if left else f"np.{opname}(a,{atom(sv)},{{out=o,where=m}})"
    lines += [f"do -- scalar-out {scalar}",f"  local a={arr_expr(a)}",f"  local o={arr_expr(out)}",f"  local m={arr_expr(mask)}",f"  local r={call}",
              f"  assert(r==o,'scalar out {scalar} identity')",f"  assert(veq(o:tolist(),{nested(exp.tolist())}),'scalar out {scalar} values')","end"]
    scalar+=1

# 4) Mask expansion with automatic output. Use all-true masks so every output byte is defined.
expand=0
for shape in [(3,),(2,3),(1,4)]:
    for lead in [2,3]:
        a=np.arange(math.prod(shape),dtype=np.int16).reshape(shape)
        b=np.ones(shape,dtype=np.float32)
        m=np.ones((lead,)+(1,)*len(shape),dtype=bool)
        r=np.add(a,b,where=m)
        lines += [f"do -- where-expand {expand}",f"  local a={arr_expr(a)}",f"  local b={arr_expr(b)}",f"  local m={arr_expr(m)}",f"  local r=np.add(a,b,{{where=m}})",
                  f"  assert(seqeq(r.shape,{shape_lit(r.shape)}),'expand {expand} shape')",f"  assert(seqeq(r.strides,{strides_lit(r.strides)}),'expand {expand} strides')",f"  assert(veq(r:tolist(),{nested(r.tolist())}),'expand {expand} values')","end"]
        expand+=1

# 5) COPY_IF_OVERLAP/writeback cases. Expected arrays from NumPy.
overlap_specs=[
    ('forward','np.arange(8)', 'x:get(np.slice(1,8))','x:get(np.slice(2,9))',10,False),
    ('backward','np.arange(8)', 'x:get(np.slice(2,9))','x:get(np.slice(1,8))',10,False),
    ('reverse','np.arange(8)', 'x:get(np.slice(nil,nil,-1))','x',3,False),
]
for name,xexpr,srcexpr,dstexpr,c,masked in overlap_specs:
    x=np.arange(8,dtype=np.int64)
    if name=='forward': np.add(x[:-1],c,out=x[1:])
    elif name=='backward': np.add(x[1:],c,out=x[:-1])
    else: np.add(x[::-1],c,out=x)
    lines += [f"do -- overlap {name}",f"  local x={xexpr}",f"  local src={srcexpr}",f"  local dst={dstexpr}",f"  np.add(src,{c},{{out=dst}})",f"  assert(veq(x:tolist(),{nested(x.tolist())}),'overlap {name}')","end"]

# Masked overlap must copy old output into the writeback temporary first.
x=np.arange(8,dtype=np.int64); mask=np.array([True,False,True,False,True,False,True],dtype=bool)
np.add(x[:-1],10,out=x[1:],where=mask)
lines += ["do -- masked overlap", "  local x=np.arange(8)", "  local src=x:get(np.slice(1,8))", "  local dst=x:get(np.slice(2,9))", f"  local m={arr_expr(mask)}", "  np.add(src,10,{out=dst,where=m})", f"  assert(veq(x:tolist(),{nested(x.tolist())}),'masked overlap')", "end"]

# 6) same_kind rejection and false scalar where preservation.
lines += [r'''
do
  local a=np.array({1.5,2.5},np.float64)
  local o=np.array({10,20},np.int64)
  local ok,err=pcall(function() np.add(a,a,{out=o}) end)
  assert(not ok and tostring(err):find("same_kind",1,true),'same_kind output rejection')
end

do
  local a=np.array({1,2,3},np.int8)
  local o=np.array({9,8,7},np.int16)
  np.add(a,2,{out=o,where=false})
  assert(veq(o:tolist(),{9,8,7}),'scalar where false preserves out')
end
''']

count=auto+out_cases+scalar+expand+4+2
lines.append(f"print('nditer/out/where differential: {count} cases ok ({auto} layout, {out_cases} out/where, {scalar} scalar, {expand} mask-expand)')")
OUT.write_text('\n'.join(lines)+'\n')
print(f"{OUT} ({count} cases)")
