#!/usr/bin/env python3
from pathlib import Path
import math
import numpy as np
import warnings

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'qr_differential_generated.lua'
rng=np.random.default_rng(0x5152)
lines=[
'local np=require("luaray_core")',
'local function sc(a,b,t) t=t or 1e-10; if type(a)=="userdata" or type(b)=="userdata" then return type(a)=="userdata" and type(b)=="userdata" and sc(a.real,b.real,t) and sc(a.imag,b.imag,t) end; if a~=a and b~=b then return true end; if a==b then return true end; return math.abs(a-b)<=math.max(t,math.abs(b)*t) end',
'local function close(a,b,t) if type(a)=="table" or type(b)=="table" then if type(a)~="table" or type(b)~="table" or #a~=#b then return false end; for i=1,#a do if not close(a[i],b[i],t) then return false end end; return true end; return sc(a,b,t) end',
f'-- Generated against development NumPy {np.__version__}.',
]

def fl(v):
    v=float(v)
    if math.isnan(v):return '0/0'
    if math.isinf(v):return 'math.huge' if v>0 else '-math.huge'
    return repr(v)
def sl(x):
    if isinstance(x,np.generic):x=x.item()
    if isinstance(x,complex):return f'np.complex({fl(x.real)},{fl(x.imag)})'
    if isinstance(x,float):return fl(x)
    if isinstance(x,(bool,np.bool_)):return 'true' if x else 'false'
    return str(int(x))
def tl(x):
    if isinstance(x,np.ndarray):x=x.tolist()
    if isinstance(x,(list,tuple)):return '{'+','.join(tl(v) for v in x)+'}'
    return sl(x)
def expr(a):
    a=np.asarray(a);dt=a.dtype.name
    if a.size==0:return f'np.zeros({tl(list(a.shape))},np.{dt})'
    return f'np.array({tl(a)},np.{dt})'
def tol(dt):return 2e-4 if np.dtype(dt) in (np.float32,np.complex64) else 2e-10

def emit(name, e, ex, tag):
    ex=np.asarray(ex);t=tol(ex.dtype)
    lines.append(f'  local {name}={e}')
    lines.append(f'  assert({name}.dtype=="{ex.dtype.name}","{tag} dtype")')
    lines.append(f'  assert(close({name}.shape,{tl(list(ex.shape))}),"{tag} shape")')
    lines.append(f'  assert(close({name}:tolist(),{tl(ex)},{t!r}),"{tag} values")')

count=0
modes=['reduced','complete','r','raw','economic']
dtypes=['float32','float64','complex64','complex128','int32']
for case in range(130):
    m=int(rng.integers(0,6));n=int(rng.integers(0,6));dt=dtypes[case%len(dtypes)]
    batch=() if case%3==0 else ((2,) if case%3==1 else (2,2))
    sh=batch+(m,n)
    if np.issubdtype(np.dtype(dt),np.integer):A=rng.integers(-5,6,size=sh).astype(dt)
    else:
        A=rng.normal(size=sh)
        if np.issubdtype(np.dtype(dt),np.complexfloating):A=A+1j*rng.normal(size=sh)
        A=A.astype(dt)
    mode=modes[case%len(modes)]
    with warnings.catch_warnings():
        warnings.simplefilter('ignore')
        ex=np.linalg.qr(A,mode=mode)
    lines += [f'do -- qr {case}',f'  local a={expr(A)}']
    if mode in ('reduced','complete','raw'):
        x,y=ex
        lines.append(f'  local x,y=np.linalg.qr(a,"{mode}")')
        lines += [f'  assert(x.dtype=="{x.dtype.name}" and y.dtype=="{y.dtype.name}","qr {case} dtype")',
                  f'  assert(close(x.shape,{tl(list(x.shape))}) and close(y.shape,{tl(list(y.shape))}),"qr {case} shape")',
                  f'  assert(close(x:tolist(),{tl(x)},{tol(x.dtype)!r}),"qr {case} first")',
                  f'  assert(close(y:tolist(),{tl(y)},{tol(y.dtype)!r}),"qr {case} second")']
    else:
        emit('x',f'np.linalg.qr(a,"{mode}")',ex,f'qr {case}')
    lines.append('end');count+=1

# Non-contiguous 2-D transpose views.
for case,dt in enumerate(['float32','float64','complex64','complex128']):
    base=rng.normal(size=(3,5))
    if 'complex' in dt:base=base+1j*rng.normal(size=(3,5))
    base=base.astype(dt);A=base.T
    for mode in ('reduced','complete','r','raw'):
        ex=np.linalg.qr(A,mode=mode)
        tag=f'strided {case} {mode}'
        lines += [f'do -- {tag}',f'  local base={expr(base)}','  local a=base.T']
        if isinstance(ex,tuple):
            x,y=ex;lines.append(f'  local x,y=np.linalg.qr(a,"{mode}")')
            lines += [f'  assert(close(x:tolist(),{tl(x)},{tol(x.dtype)!r}),"{tag} first")',f'  assert(close(y:tolist(),{tl(y)},{tol(y.dtype)!r}),"{tag} second")']
        else:emit('x',f'np.linalg.qr(a,"{mode}")',ex,tag)
        lines.append('end');count+=1

lines += [
'do local ok,e=pcall(function() np.linalg.qr(np.array({1,2})) end);assert(not ok and tostring(e):find("at least two%-dimensional"),"qr ndim") end',
'do local ok,e=pcall(function() np.linalg.qr(np.ones({2,2}),"wat") end);assert(not ok and tostring(e):find("Unrecognized mode",1,true),"qr mode") end',
'do local ok,e=pcall(function() np.linalg.qr(np.ones({2,2},np.float16)) end);assert(not ok and tostring(e):find("unsupported in linalg",1,true),"qr float16") end',
]
count+=3
lines.append(f"print('qr differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
