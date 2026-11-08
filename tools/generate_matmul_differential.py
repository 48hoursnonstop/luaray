#!/usr/bin/env python3
"""Development-only differential oracle for the native matmul gufunc subset."""
from pathlib import Path
import math, random, warnings
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'matmul_differential_generated.lua'
rng=random.Random(0x6D61746D756C)
dtypes=['bool','int8','uint8','int16','uint16','int32','uint32','int64','uint64','float16','float32','float64']

lines=[
 'local np=require("luaray_core")',
 'local function close(a,b)',
 '  if type(a)~=type(b) then return false end',
 '  if type(a)~="table" then',
 '    if type(a)=="number" then',
 '      if a~=a and b~=b then return true end',
 '      if a==b then return true end',
 '      return math.abs(a-b)<=math.max(5e-5,math.abs(b)*2e-5)',
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
    if not shape:return flat[0]
    if len(shape)==1:return list(flat)
    step=math.prod(shape[1:])
    return [nested(flat[i*step:(i+1)*step],shape[1:]) for i in range(shape[0])]

def vals(shape,dt,seed):
    n=math.prod(shape)
    if dt=='bool':return [((i+seed)%3)!=0 for i in range(n)]
    if dt.startswith('float'):return [((i*3+seed)%9-4)*0.25 for i in range(n)]
    if dt.startswith('uint'):return [(i*3+seed)%5 for i in range(n)]
    return [((i*5+seed)%9)-4 for i in range(n)]

def make_array(shape,dt,seed,transposed):
    if transposed and len(shape)>1:
        base_shape=list(reversed(shape));v=vals(base_shape,dt,seed)
        if math.prod(base_shape)==0:
            base=np.zeros(base_shape,dtype=dt);expr=f'np.zeros({lt(base_shape)},np.{dt})'
        else:
            base=np.array(v,dtype=dt).reshape(base_shape);expr=f'np.array({lt(nested(v,base_shape))},np.{dt})'
        return base.T,f'({expr}).T'
    v=vals(shape,dt,seed)
    if math.prod(shape)==0:return np.zeros(shape,dtype=dt),f'np.zeros({lt(shape)},np.{dt})'
    return np.array(v,dtype=dt).reshape(shape),f'np.array({lt(nested(v,shape))},np.{dt})'

def operand_batch(global_batch):
    if not global_batch:return []
    drop=rng.randrange(len(global_batch)+1)
    tail=global_batch[drop:]
    return [1 if rng.random()<0.30 else x for x in tail]

def dn(dt):return np.dtype(dt).name

count=0
for case in range(300):
    bd=rng.randint(0,3)
    batch=[rng.randint(0,3) for _ in range(bd)]
    n=rng.randint(0,4);m=rng.randint(0,4);p=rng.randint(0,4)
    avec=rng.random()<0.20;bvec=rng.random()<0.20
    ab=[] if avec else operand_batch(batch)
    bb=[] if bvec else operand_batch(batch)
    ash=[n] if avec else ab+[m,n]
    bsh=[n] if bvec else bb+[n,p]
    adt=rng.choice(dtypes);bdt=rng.choice(dtypes)
    atr=(rng.random()<0.15 and len(ash)>1)
    btr=(rng.random()<0.15 and len(bsh)>1)
    a,aexpr=make_array(ash,adt,case*2+1,atr)
    b,bexpr=make_array(bsh,bdt,case*2+2,btr)
    # make_array preserves the requested logical shapes even when using .T.
    with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore'); expected=np.matmul(a,b)
    out_mode=rng.random()<0.24
    out_trans=False
    outdt=dn(expected.dtype)
    if out_mode and rng.random()<0.20:
        # Exercise a safe widening output cast where available.
        if expected.dtype==np.dtype('float32'):outdt='float64'
        elif expected.dtype==np.dtype('int8'):outdt='int16'
        elif expected.dtype==np.dtype('int16'):outdt='int32'
        elif expected.dtype==np.dtype('uint8'):outdt='uint16'
    lines += [f'do -- matmul {case}: {adt}{list(a.shape)} @ {bdt}{list(b.shape)}',f'  local a={aexpr}',f'  local b={bexpr}']
    if out_mode:
        osh=list(expected.shape)
        if len(osh)>1 and rng.random()<0.22:
            base_shape=list(reversed(osh));lines.append(f'  local ob=np.zeros({lt(base_shape)},np.{outdt})');lines.append('  local o=ob.T');out_trans=True
        else:lines.append(f'  local o=np.zeros({lt(osh)},np.{outdt})')
        lines.append('  local r=np.matmul(a,b,{out=o})')
        lines.append(f'  assert(r==o,"matmul {case} out identity")')
        expout=np.empty(expected.shape,dtype=outdt);np.copyto(expout,expected,casting='same_kind')
        # A transposed out has strides of the transposed backing allocation.
        if out_trans:
            testout=np.zeros(list(reversed(expected.shape)),dtype=outdt).T
        else:testout=np.zeros(expected.shape,dtype=outdt)
        lines += [f'  assert(r.dtype=="{dn(expout.dtype)}","matmul {case} dtype "..r.dtype)',
                  f'  assert(close(r.shape,{lt(list(expected.shape))}),"matmul {case} shape")',
                  f'  assert(close(r.strides,{lt(list(testout.strides))}),"matmul {case} out strides")',
                  f'  assert(close(r:tolist(),{lt(expout.tolist())}),"matmul {case} values")']
    elif expected.ndim==0:
        lines.append('  local r=np.matmul(a,b)')
        lines.append(f'  assert(close(r,{lt(expected.item())}),"matmul {case} scalar value")')
    else:
        lines.append('  local r=np.matmul(a,b)')
        lines += [f'  assert(r.dtype=="{dn(expected.dtype)}","matmul {case} dtype "..r.dtype)',
                  f'  assert(close(r.shape,{lt(list(expected.shape))}),"matmul {case} shape")',
                  f'  assert(close(r.strides,{lt(list(expected.strides))}),"matmul {case} strides")',
                  f'  assert(close(r:tolist(),{lt(expected.tolist())}),"matmul {case} values")']
    lines.append('end');count+=1

lines += [
 'do local a=np.array({{1,2},{3,4}},np.int64); local r=np.matmul(a,a); assert(close(r:tolist(),{{7,10},{15,22}}),"matmul matrix values") end',
 'do local v=np.array({1,2},np.int64); assert(np.matmul(v,v)==5,"matmul vector scalar") end',
 'do local v=np.array({true,false},np.bool); local m=np.array({{true,false},{false,true}},np.bool); local r=np.matmul(v,m); assert(close(r:tolist(),{true,false}),"matmul bool") end',
 'do local a=np.array({{1,2},{3,4}},np.int64); np.matmul(a,a,{out=a}); assert(close(a:tolist(),{{7,10},{15,22}}),"matmul overlap out") end',
 'do local ok,err=pcall(function() return np.matmul(np.ones({2,3}),np.ones({4,2})) end); assert(not ok and tostring(err):find("core dimension mismatch",1,true),"matmul mismatch error") end',
 'do local o=np.zeros({2,2},np.int32); local ok,err=pcall(function() return np.matmul(np.ones({2,2},np.float64),np.ones({2,2},np.float64),{out=o}) end); assert(not ok and tostring(err):find("same_kind",1,true),"matmul out cast error") end',
]
count+=6
lines.append(f"print('matmul differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
