#!/usr/bin/env python3
"""Development-only differential oracle for add/multiply accumulate."""
from pathlib import Path
import math, random
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'accumulate_differential_generated.lua'
rng=random.Random(0xACC0126)
dtypes=['bool','int8','uint8','int16','uint16','int32','uint32','int64','uint64','float16','float32','float64']
request_dtypes=['bool','int8','uint8','int16','uint16','int32','uint32','int64','uint64','float16','float32','float64']
out_dtypes=['bool','int8','uint8','int16','uint16','int32','uint32','int64','float16','float32','float64']

lines=[
 'local np=require("luaray_core")',
 'local function close(a,b)',
 '  if type(a)~=type(b) then return false end',
 '  if type(a)~="table" then',
 '    if type(a)=="number" then',
 '      if a~=a and b~=b then return true end',
 '      if a==b then return true end',
 '      return math.abs(a-b)<=math.max(2e-5,math.abs(b)*8e-6)',
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
    if isinstance(x,(bool,np.bool_)):return 'true' if bool(x) else 'false'
    if isinstance(x,(float,np.floating)):
        f=float(x)
        if math.isnan(f):return '0/0'
        if math.isinf(f):return 'math.huge' if f>0 else '-math.huge'
        return repr(f)
    return str(int(x))

def lt(x):
    if isinstance(x,(list,tuple)):return '{'+','.join(lt(v) for v in x)+'}'
    return ls(x)

def nested(flat,shape):
    if len(shape)==1:return list(flat)
    step=math.prod(shape[1:])
    return [nested(flat[i*step:(i+1)*step],shape[1:]) for i in range(shape[0])]

def dn(dt):return np.dtype(dt).name

def values(shape,dt,case,op):
    n=math.prod(shape)
    if dt=='bool':return [((i+case)%3)!=0 for i in range(n)]
    if dt.startswith('float'):
        if op=='multiply':return [((i+case)%5-2)*0.25+1 for i in range(n)]
        return [((i+case)%7-3)*0.4 for i in range(n)]
    if dt.startswith('uint'):
        return [((i+case)%4)+1 if op=='multiply' else (i*3+case)%9 for i in range(n)]
    return [((i+case)%5)-2 if op=='multiply' else ((i*3+case)%11)-5 for i in range(n)]

count=0
for case in range(260):
    nd=rng.randint(1,4)
    shape=[rng.randint(0,4) for _ in range(nd)]
    dt=rng.choice(dtypes)
    op=rng.choice(['add','multiply'])
    vals=values(shape,dt,case,op)
    if math.prod(shape)==0:
        base=np.zeros(shape,dtype=dt)
        expr=f'np.zeros({lt(shape)},np.{dt})'
    else:
        base=np.array(vals,dtype=dt).reshape(shape)
        expr=f'np.array({lt(nested(vals,shape))},np.{dt})'
    if nd>1 and all(x>0 for x in shape) and rng.random()<0.15:
        a=base.T; expr=f'({expr}).T'
    else:a=base
    axis=rng.randrange(a.ndim)
    dtype_override=rng.choice(request_dtypes) if rng.random()<0.3 else None
    out_dtype=rng.choice(out_dtypes) if rng.random()<0.28 else None
    kw={'axis':axis}
    if dtype_override is not None:kw['dtype']=np.dtype(dtype_override)
    if out_dtype is not None:
        o=np.zeros(a.shape,dtype=out_dtype);kw['out']=o
    with np.errstate(all='ignore'):
        expected=getattr(np,op).accumulate(a,**kw)

    fields=[f'axis={axis+1}']
    if dtype_override is not None:fields.append(f'dtype=np.{dtype_override}')
    lines += [f'do -- accumulate {case}: {op} {dt} {list(a.shape)} axis={axis}',f'  local a={expr}']
    if out_dtype is not None:
        lines.append(f'  local o=np.zeros({lt(list(a.shape))},np.{out_dtype})');fields.append('out=o')
    lines.append(f'  local r=np.{op}_accumulate(a,{{{",".join(fields)}}})')
    if out_dtype is not None:lines.append(f'  assert(r==o,"acc {case} out identity")')
    lines += [f'  assert(r.dtype=="{dn(expected.dtype)}","acc {case} dtype "..r.dtype)',
              f'  assert(close(r.shape,{lt(list(expected.shape))}),"acc {case} shape")',
              f'  assert(close(r.strides,{lt(list(expected.strides))}),"acc {case} strides")',
              f'  assert(close(r:tolist(),{lt(expected.tolist())}),"acc {case} values")','end']
    count+=1

# Explicit dtype/output resolution discriminators.
lines += [
 'do local a=np.array({100,100,100},np.int8); local r=np.add_accumulate(a); assert(r.dtype=="int64" and close(r:tolist(),{100,200,300}),"acc int widening") end',
 'do local a=np.array({100,100,100},np.int8); local o=np.zeros({3},np.int8); np.add_accumulate(a,{out=o}); assert(close(o:tolist(),{100,-56,44}),"acc out suppresses widening") end',
 'do local a=np.array({1.6,1.6,1.6},np.float32); local o=np.zeros({3},np.int8); np.add_accumulate(a,{out=o}); assert(close(o:tolist(),{1,3,4}),"acc cast prefixes not accumulator") end',
 'do local a=np.array({1.6,1.6,1.6},np.float32); local o=np.zeros({3},np.float32); np.add_accumulate(a,{dtype=np.int16,out=o}); assert(close(o:tolist(),{1,2,3}),"acc dtype override") end',
]
count+=4
lines.append(f"print('accumulate differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
