#!/usr/bin/env python3
"""Development-only differential oracle for add/multiply reduceat."""
from pathlib import Path
import math, random, warnings
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'reduceat_differential_generated.lua'
rng=random.Random(0xAED0CE)
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
 '      return math.abs(a-b)<=math.max(3e-5,math.abs(b)*1e-5)',
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
    if isinstance(x,(list,tuple)): return '{'+','.join(lt(v) for v in x)+'}'
    return ls(x)

def nested(flat,shape):
    if len(shape)==1:return list(flat)
    step=math.prod(shape[1:])
    return [nested(flat[i*step:(i+1)*step],shape[1:]) for i in range(shape[0])]

def dn(dt):return np.dtype(dt).name

def values(shape,dt,case,op):
    n=math.prod(shape)
    if dt=='bool': return [((i+2*case)%3)!=0 for i in range(n)]
    if dt.startswith('float'):
        if op=='multiply': return [((i+case)%5-2)*0.2+1.0 for i in range(n)]
        return [((i*3+case)%9-4)*0.375 for i in range(n)]
    if dt.startswith('uint'):
        return [((i+case)%4)+1 if op=='multiply' else (i*3+case)%8 for i in range(n)]
    return [((i+case)%5)-2 if op=='multiply' else ((i*3+case)%11)-5 for i in range(n)]

def lua_index_for(pos,n):
    # Same element as Python's zero-based pos, expressed in the port's public
    # 1-based model; occasionally exercise Lua-style negative-from-end.
    if n and rng.random()<0.28:
        return pos-n
    return pos+1

count=0
for case in range(280):
    nd=rng.randint(1,4)
    shape=[rng.randint(0,4) for _ in range(nd)]
    dt=rng.choice(dtypes); op=rng.choice(['add','multiply'])
    vals=values(shape,dt,case,op)
    if math.prod(shape)==0:
        base=np.zeros(shape,dtype=dt); expr=f'np.zeros({lt(shape)},np.{dt})'
    else:
        base=np.array(vals,dtype=dt).reshape(shape)
        expr=f'np.array({lt(nested(vals,shape))},np.{dt})'
    if nd>1 and all(x>0 for x in shape) and rng.random()<0.18:
        a=base.T; expr=f'({expr}).T'
    else:a=base
    axis=rng.randrange(a.ndim); axis_len=a.shape[axis]
    if axis_len==0:
        indices=[]
    else:
        ni=rng.randint(0,min(6,axis_len+3))
        indices=[rng.randrange(axis_len) for _ in range(ni)]
        # Force descending/repeated segments regularly.
        if ni>=3 and case%4==0:
            indices[1]=axis_len-1; indices[2]=0
        if ni>=2 and case%5==0:
            indices[1]=indices[0]
    dtype_override=rng.choice(request_dtypes) if rng.random()<0.30 else None
    out_dtype=rng.choice(out_dtypes) if rng.random()<0.27 else None
    kw={'axis':axis}
    if dtype_override is not None:kw['dtype']=np.dtype(dtype_override)
    out_shape=list(a.shape);out_shape[axis]=len(indices)
    if out_dtype is not None:
        o=np.zeros(out_shape,dtype=out_dtype);kw['out']=o
    with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore')
        expected=getattr(np,op).reduceat(a,indices,**kw)

    lidx=[lua_index_for(p,axis_len) for p in indices]
    fields=[f'axis={axis+1}']
    if dtype_override is not None:fields.append(f'dtype=np.{dtype_override}')
    lines += [f'do -- reduceat {case}: {op} {dt} {list(a.shape)} axis={axis} indices={indices}',f'  local a={expr}']
    if out_dtype is not None:
        lines.append(f'  local o=np.zeros({lt(out_shape)},np.{out_dtype})');fields.append('out=o')
    lines.append(f'  local r=np.{op}_reduceat(a,{lt(lidx)},{{{",".join(fields)}}})')
    if out_dtype is not None: lines.append(f'  assert(r==o,"reduceat {case} out identity")')
    lines += [f'  assert(r.dtype=="{dn(expected.dtype)}","reduceat {case} dtype "..r.dtype)',
              f'  assert(close(r.shape,{lt(list(expected.shape))}),"reduceat {case} shape")',
              f'  assert(close(r.strides,{lt(list(expected.strides))}),"reduceat {case} strides")',
              f'  assert(close(r:tolist(),{lt(expected.tolist())}),"reduceat {case} values")','end']
    count+=1

# Explicit source-level invariants and binding adaptations.
lines += [
 'do local a=np.arange(5); local r=np.add_reduceat(a,{1,4,2}); assert(close(r:tolist(),{3,3,10}),"reduceat descending first-element rule") end',
 'do local a=np.array({100,100,100},np.int8); local r=np.add_reduceat(a,{1}); assert(r.dtype=="int64" and close(r:tolist(),{300}),"reduceat small-int widening") end',
 'do local a=np.array({1.6,1.6,1.6},np.float32); local o=np.zeros({1},np.int8); np.add_reduceat(a,{1},{out=o}); assert(close(o:tolist(),{4}),"reduceat output cast after full accumulator") end',
 'do local a=np.arange(5); local r=np.add_reduceat(a,{-5,-2,-4}); assert(close(r:tolist(),{3,3,10}),"reduceat Lua negative indices") end',
 'do local a=np.arange(5); local idx=np.array({1,4,2},np.int16); local r=np.add_reduceat(a,idx); assert(close(r:tolist(),{3,3,10}),"reduceat ndarray indices") end',
 'do local a=np.reshape(np.arange(6),{2,3}); local r=np.add_reduceat(a,{},2); assert(close(r.shape,{2,0}),"reduceat empty indices") end',
]
count+=6
lines.append(f"print('reduceat differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
