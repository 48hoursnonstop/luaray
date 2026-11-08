#!/usr/bin/env python3
from pathlib import Path
import math, random, warnings
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'dot_differential_generated.lua'
rng=random.Random(0xD071A110)
dtypes=['bool','int8','uint8','int16','uint16','int32','uint32','int64','uint64','float16','float32','float64']
lines=[
 'local np=require("luaray_core")',
 'local function close(a,b)',
 '  if type(a)~=type(b) then return false end',
 '  if type(a)~="table" then',
 '    if type(a)=="number" then if a~=a and b~=b then return true end; if a==b then return true end; return math.abs(a-b)<=math.max(1e-4,math.abs(b)*4e-5) end',
 '    return a==b',
 '  end',
 '  if #a~=#b then return false end; for i=1,#a do if not close(a[i],b[i]) then return false end end; return true',
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
    if not shape: return flat[0]
    if len(shape)==1:return list(flat)
    step=math.prod(shape[1:]); return [nested(flat[i*step:(i+1)*step],shape[1:]) for i in range(shape[0])]
def vals(shape,dt,seed):
    n=math.prod(shape) if shape else 1
    if dt=='bool': return [((i+seed)%3)!=0 for i in range(n)]
    if dt.startswith('float'): return [((i*7+seed)%17-8)*0.125 for i in range(n)]
    if dt.startswith('uint'): return [(i*5+seed)%7 for i in range(n)]
    return [((i*5+seed)%13)-6 for i in range(n)]
def make(shape,dt,seed,trans=False):
    if trans and len(shape)>=2:
        bshape=list(shape); bshape[-1],bshape[-2]=bshape[-2],bshape[-1]
        v=vals(bshape,dt,seed)
        if math.prod(bshape)==0: base=np.zeros(bshape,dtype=dt); ex=f'np.zeros({lt(bshape)},np.{dt})'
        else: base=np.array(v,dtype=dt).reshape(bshape); ex=f'np.array({lt(nested(v,bshape))},np.{dt})'
        axes=list(range(len(shape))); axes[-1],axes[-2]=axes[-2],axes[-1]
        # Lua .T reverses all axes, so only use transpose generation for 2-D.
        if len(shape)==2:return base.T,f'({ex}).T'
    v=vals(shape,dt,seed)
    if not shape:
        # No scalar constructor surface other than reshaping a 1-element array.
        return np.array(v[0],dtype=dt),f'np.reshape(np.array({{{lt(v[0])}}},np.{dt}),{{}})'
    if math.prod(shape)==0:return np.zeros(shape,dtype=dt),f'np.zeros({lt(shape)},np.{dt})'
    return np.array(v,dtype=dt).reshape(shape),f'np.array({lt(nested(v,shape))},np.{dt})'
def dn(x):return np.dtype(x).name

def emit_result(tag,expr,expected,case):
    global lines
    lines.append(f'  local r={expr}')
    if np.ndim(expected)==0:
        lines.append(f'  assert(close(r,{lt(np.asarray(expected).item())}),"{tag} {case} scalar")')
    else:
        lines += [f'  assert(r.dtype=="{dn(expected.dtype)}","{tag} {case} dtype "..r.dtype)',
                  f'  assert(close(r.shape,{lt(list(expected.shape))}),"{tag} {case} shape")',
                  f'  assert(close(r.strides,{lt(list(expected.strides))}),"{tag} {case} strides")',
                  f'  assert(close(r:tolist(),{lt(expected.tolist())}),"{tag} {case} values")']

count=0
# dot: include scalars, vectors, matrices, >2D and transposed 2D inputs.
for case in range(260):
    mode=rng.randrange(5)
    if mode==0:
        ash=[]; bsh=[rng.randint(0,4),rng.randint(0,4)] if rng.random()<.6 else [rng.randint(0,5)]
    elif mode==1:
        ash=[rng.randint(0,5)]; bsh=[]
    else:
        k=rng.randint(0,4)
        ad=rng.randint(1,4); bd=rng.randint(1,4)
        ash=[rng.randint(0,3) for _ in range(ad-1)]+[k]
        if bd==1:bsh=[k]
        else:bsh=[rng.randint(0,3) for _ in range(bd-2)]+[k,rng.randint(0,4)]
    adt=rng.choice(dtypes); bdt=rng.choice(dtypes)
    atr=(len(ash)==2 and rng.random()<.22); btr=(len(bsh)==2 and rng.random()<.22)
    a,ae=make(ash,adt,case*2+1,atr); b,be=make(bsh,bdt,case*2+2,btr)
    with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore'); ex=np.dot(a,b)
    lines += [f'do -- dot {case}',f'  local a={ae}',f'  local b={be}']
    # out testing: scalar-operand path permits ufunc-style dtype/strides; contraction path is strict.
    if rng.random()<.28 and np.ndim(ex)>0:
        if a.ndim==0 or b.ndim==0:
            cblas_scalar = dn(np.asarray(ex).dtype) in ('float32','float64') and a.ndim<=2 and b.ndim<=2
            outdt=dn(np.asarray(ex).dtype) if cblas_scalar else ('float64' if dn(np.asarray(ex).dtype)!='float64' and rng.random()<.5 else dn(np.asarray(ex).dtype))
            osh=list(np.shape(ex)); trans=(len(osh)==2 and rng.random()<.3 and not cblas_scalar)
            if trans:
                base=list(reversed(osh)); lines.append(f'  local ob=np.zeros({lt(base)},np.{outdt})');lines.append('  local o=ob.T')
                testout=np.zeros(base,dtype=outdt).T
            else:
                lines.append(f'  local o=np.zeros({lt(osh)},np.{outdt})');testout=np.zeros(osh,dtype=outdt)
            lines.append('  local r=np.dot(a,b,{out=o})');lines.append(f'  assert(r==o,"dot {case} out identity")')
            exout=np.empty(np.shape(ex),dtype=outdt);np.copyto(exout,ex,casting='same_kind')
            lines += [f'  assert(r.dtype=="{dn(exout.dtype)}","dot {case} out dtype")',f'  assert(close(r.strides,{lt(list(testout.strides))}),"dot {case} out strides")',f'  assert(close(r:tolist(),{lt(exout.tolist())}),"dot {case} out values")']
        else:
            osh=list(np.shape(ex)); odt=dn(np.asarray(ex).dtype);lines.append(f'  local o=np.zeros({lt(osh)},np.{odt})');lines.append('  local r=np.dot(a,b,{out=o})')
            if np.ndim(ex)==0: pass
            else:
                lines += [f'  assert(r==o,"dot {case} out identity")',f'  assert(close(r:tolist(),{lt(np.asarray(ex).tolist())}),"dot {case} out values")']
    else: emit_result('dot','np.dot(a,b)',np.asarray(ex),case)
    lines.append('end');count+=1

# inner: contraction over both final axes.
for case in range(130):
    if rng.random()<.15:
        ash=[]; bsh=[rng.randint(0,3) for _ in range(rng.randint(0,3))]
    else:
        k=rng.randint(0,4); ad=rng.randint(1,4);bd=rng.randint(1,4)
        ash=[rng.randint(0,3) for _ in range(ad-1)]+[k]
        bsh=[rng.randint(0,3) for _ in range(bd-1)]+[k]
    adt=rng.choice(dtypes);bdt=rng.choice(dtypes)
    a,ae=make(ash,adt,5000+case*2, len(ash)==2 and rng.random()<.2)
    b,be=make(bsh,bdt,5001+case*2, len(bsh)==2 and rng.random()<.2)
    with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore');ex=np.inner(a,b)
    lines += [f'do -- inner {case}',f'  local a={ae}',f'  local b={be}'];emit_result('inner','np.inner(a,b)',np.asarray(ex),case);lines.append('end');count+=1

# outer: flattened C-order semantics and ufunc-style out.
for case in range(90):
    ash=[rng.randint(0,3) for _ in range(rng.randint(0,3))];bsh=[rng.randint(0,3) for _ in range(rng.randint(0,3))]
    adt=rng.choice(dtypes);bdt=rng.choice(dtypes)
    a,ae=make(ash,adt,9000+case*2, len(ash)==2 and rng.random()<.25)
    b,be=make(bsh,bdt,9001+case*2, len(bsh)==2 and rng.random()<.25)
    with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore');ex=np.outer(a,b)
    lines += [f'do -- outer {case}',f'  local a={ae}',f'  local b={be}']
    if rng.random()<.3:
        odt=dn(ex.dtype)
        if odt=='float32' and rng.random()<.5:odt='float64'
        osh=list(ex.shape)
        if rng.random()<.25:
            base=list(reversed(osh));lines.append(f'  local ob=np.zeros({lt(base)},np.{odt})');lines.append('  local o=ob.T');testout=np.zeros(base,dtype=odt).T
        else:
            lines.append(f'  local o=np.zeros({lt(osh)},np.{odt})');testout=np.zeros(osh,dtype=odt)
        lines.append('  local r=np.outer(a,b,{out=o})');lines.append(f'  assert(r==o,"outer {case} out identity")')
        exout=np.empty(ex.shape,dtype=odt);np.copyto(exout,ex,casting='same_kind')
        lines += [f'  assert(close(r.strides,{lt(list(testout.strides))}),"outer {case} out strides")',f'  assert(close(r:tolist(),{lt(exout.tolist())}),"outer {case} out values")']
    else: emit_result('outer','np.outer(a,b)',ex,case)
    lines.append('end');count+=1

# Explicit invariants/errors.
lines += [
 'do local a=np.reshape(np.arange(24,np.float64),{2,3,4}); local b=np.reshape(np.arange(40,np.float64),{2,4,5}); local r=np.dot(a,b); assert(close(r.shape,{2,3,2,5}),"dot >2d shape") end',
 'do local a=np.array({1,2,3},np.int64); assert(a:dot(a)==14,"ndarray dot method") end',
 'do local a=np.array({1,2},np.int64); local b=np.array({3,4},np.int64); local r=np.outer(a,b); assert(close(r:tolist(),{{3,4},{6,8}}),"outer basic") end',
 'do local a=np.ones({2,3},np.float64);local b=np.ones({3,2},np.float64);local o=np.zeros({2,2},np.float32);local ok,e=pcall(function() np.dot(a,b,{out=o}) end);assert(not ok and tostring(e):find("output array is not acceptable",1,true),"dot strict out dtype") end',
 'do local a=np.ones({2,3},np.float64);local b=np.ones({3,2},np.float64);local ob=np.zeros({2,2},np.float64);local o=ob.T;local ok,e=pcall(function() np.dot(a,b,{out=o}) end);assert(not ok and tostring(e):find("output array is not acceptable",1,true),"dot strict out contiguous") end',
 'do local s=np.reshape(np.array({2},np.int8),{});local a=np.reshape(np.arange(6,np.int8),{2,3});local ob=np.zeros({3,2},np.float64);local o=ob.T;local r=np.dot(s,a,{out=o});assert(r==o and close(r:tolist(),{{0,2,4},{6,8,10}}),"dot scalar ufunc out") end',
]
count+=6
lines.append(f"print('dot/inner/outer differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
