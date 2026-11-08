#!/usr/bin/env python3
from pathlib import Path
import math
import numpy as np

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'tests' / 'linalg_differential_generated.lua'
rng = np.random.default_rng(0x1A1A6)

lines = [
    'local np=require("luaray_core")',
    'local function scalar_close(a,b,tol)',
    '  tol=tol or 1e-10',
    '  if type(a)=="userdata" or type(b)=="userdata" then',
    '    if type(a)~="userdata" or type(b)~="userdata" then return false end',
    '    return scalar_close(a.real,b.real,tol) and scalar_close(a.imag,b.imag,tol)',
    '  end',
    '  if a~=a and b~=b then return true end',
    '  if a==b then return true end',
    '  return math.abs(a-b)<=math.max(tol,math.abs(b)*tol)',
    'end',
    'local function close(a,b,tol)',
    '  if type(a)=="table" or type(b)=="table" then',
    '    if type(a)~="table" or type(b)~="table" or #a~=#b then return false end',
    '    for i=1,#a do if not close(a[i],b[i],tol) then return false end end',
    '    return true',
    '  end',
    '  return scalar_close(a,b,tol)',
    'end',
    f'-- Generated against development NumPy {np.__version__}; Python is oracle-only, never runtime.',
]

def scalar_lua(x):
    x = np.asarray(x).item() if isinstance(x, np.generic) else x
    if isinstance(x, complex):
        return f'np.complex({float_lua(x.real)},{float_lua(x.imag)})'
    if isinstance(x, (float, np.floating)):
        return float_lua(float(x))
    if isinstance(x, (bool, np.bool_)):
        return 'true' if bool(x) else 'false'
    return str(int(x))

def float_lua(v):
    if math.isnan(v): return '0/0'
    if math.isinf(v): return 'math.huge' if v > 0 else '-math.huge'
    if v == 0.0 and math.copysign(1.0, v) < 0: return '-0.0'
    return repr(float(v))

def table_lua(x):
    if isinstance(x, np.ndarray): x=x.tolist()
    if isinstance(x, (list,tuple)):
        return '{' + ','.join(table_lua(v) for v in x) + '}'
    return scalar_lua(x)

def arr_expr(a):
    a=np.asarray(a)
    dt=a.dtype.name
    if a.size==0:
        return f'np.zeros({table_lua(list(a.shape))},np.{dt})'
    return f'np.array({table_lua(a)},np.{dt})'

def tol_for(dt):
    return 8e-5 if np.dtype(dt) in (np.dtype('float32'),np.dtype('complex64')) else 3e-11

def dtype_name(a): return np.asarray(a).dtype.name

def emit_array_result(expr, ex, tag, tol=None):
    ex=np.asarray(ex)
    tol=tol if tol is not None else tol_for(ex.dtype)
    if ex.ndim==0:
        lines.append(f'  local r={expr}')
        lines.append(f'  assert(scalar_close(r,{scalar_lua(ex.item())},{tol!r}),"{tag} value")')
        return
    lines.append(f'  local r={expr}')
    lines.append(f'  assert(r.dtype=="{dtype_name(ex)}","{tag} dtype "..r.dtype)')
    lines.append(f'  assert(close(r.shape,{table_lua(list(ex.shape))}),"{tag} shape")')
    lines.append(f'  assert(close(r:tolist(),{table_lua(ex)},{tol!r}),"{tag} values")')

count=0

# solve: vector/matrix RHS, mixed dtype, stacks, and broadcasted batch axes.
dtype_pairs=[
    ('float32','float32'),('float64','float64'),('complex64','complex64'),('complex128','complex128'),
    ('float32','int32'),('complex64','float32'),('complex64','int32'),('complex64','float64'),('int64','int32')
]
for case in range(120):
    n=int(rng.integers(1,5))
    da,db=dtype_pairs[case%len(dtype_pairs)]
    complex_a=np.issubdtype(np.dtype(da),np.complexfloating)
    batch_mode=case%4
    if batch_mode==0:
        ash=(n,n)
    elif batch_mode==1:
        ash=(2,n,n)
    elif batch_mode==2:
        ash=(2,1,n,n)
    else:
        ash=(1,3,n,n)
    raw=rng.normal(size=ash)
    if complex_a: raw=raw+1j*rng.normal(size=ash)
    # Strict row diagonal dominance gives stable nonsingular systems without changing stack shape.
    A=raw.astype(np.complex128 if complex_a else np.float64)
    diag=np.arange(n)
    A[...,diag,diag]+= (n+3.0)
    A=A.astype(da)
    vector=(case%3==0)
    if vector:
        bs=(n,)
    else:
        k=int(rng.integers(1,4))
        if batch_mode<=1: bs=(n,k)
        elif batch_mode==2: bs=(1,3,n,k)  # broadcasts with (2,1,...)->(2,3,...)
        else: bs=(2,1,n,k)                # broadcasts with (1,3,...)->(2,3,...)
    complex_b=np.issubdtype(np.dtype(db),np.complexfloating)
    if np.issubdtype(np.dtype(db),np.integer):
        B=rng.integers(-4,5,size=bs).astype(db)
    else:
        B=rng.normal(size=bs)
        if complex_b:B=B+1j*rng.normal(size=bs)
        B=B.astype(db)
    ex=np.linalg.solve(A,B)
    lines += [f'do -- solve {case}',f'  local a={arr_expr(A)}',f'  local b={arr_expr(B)}']
    emit_array_result('np.linalg.solve(a,b)',ex,f'solve {case}',tol_for(ex.dtype)*4)
    lines.append('end');count+=1

# inv and det/slogdet on stable real/complex matrices and stacks.
for case in range(90):
    dt=('float32','float64','complex64','complex128','int32')[case%5]
    n=int(rng.integers(1,5)); batch=() if case%3==0 else ((2,) if case%3==1 else (2,2))
    shape=batch+(n,n)
    iscx=np.issubdtype(np.dtype(dt),np.complexfloating)
    if np.issubdtype(np.dtype(dt),np.integer):
        raw=rng.integers(-3,4,size=shape).astype(np.float64)
        raw[...,np.arange(n),np.arange(n)] += n+4
        A=raw.astype(dt)
    else:
        raw=rng.normal(size=shape)
        if iscx:raw=raw+1j*rng.normal(size=shape)
        raw[...,np.arange(n),np.arange(n)] += n+4
        A=raw.astype(dt)
    inv=np.linalg.inv(A); det=np.linalg.det(A); sign,logv=np.linalg.slogdet(A)
    lines += [f'do -- inv/det {case}',f'  local a={arr_expr(A)}']
    emit_array_result('np.linalg.inv(a)',inv,f'inv {case}',tol_for(inv.dtype)*8)
    emit_array_result('np.linalg.det(a)',det,f'det {case}',tol_for(det.dtype)*15)
    lines.append('  local s,l=np.linalg.slogdet(a)')
    if np.ndim(sign)==0:
        lines.append(f'  assert(scalar_close(s,{scalar_lua(np.asarray(sign).item())},{tol_for(np.asarray(sign).dtype)*8!r}),"slogdet {case} sign")')
        lines.append(f'  assert(scalar_close(l,{scalar_lua(np.asarray(logv).item())},{tol_for(np.asarray(logv).dtype)*8!r}),"slogdet {case} log")')
    else:
        lines.append(f'  assert(s.dtype=="{sign.dtype.name}" and l.dtype=="{logv.dtype.name}","slogdet {case} dtype")')
        lines.append(f'  assert(close(s:tolist(),{table_lua(sign)},{tol_for(sign.dtype)*8!r}),"slogdet {case} sign")')
        lines.append(f'  assert(close(l:tolist(),{table_lua(logv)},{tol_for(logv.dtype)*8!r}),"slogdet {case} log")')
    lines.append('end');count+=3

# Cholesky: Hermitian/Symmetric positive-definite, lower and upper, stacked.
for case in range(60):
    dt=('float32','float64','complex64','complex128')[case%4]
    n=int(rng.integers(1,5)); batch=() if case%2==0 else (2,)
    X=rng.normal(size=batch+(n,n))
    if np.issubdtype(np.dtype(dt),np.complexfloating): X=X+1j*rng.normal(size=batch+(n,n))
    X=X.astype(dt)
    A=np.matmul(np.swapaxes(X.conj(),-1,-2),X)
    eye=np.eye(n,dtype=dt)*(1.25+n*0.1)
    A=(A+eye).astype(dt)
    upper=(case%3==0)
    ex=np.linalg.cholesky(A,upper=upper)
    lines += [f'do -- cholesky {case}',f'  local a={arr_expr(A)}']
    emit_array_result(f'np.linalg.cholesky(a,{{upper={str(upper).lower()}}})',ex,f'cholesky {case}',tol_for(ex.dtype)*8)
    lines.append('end');count+=1

# Non-contiguous inputs: 2-D transpose views for all implemented unary routines and solve.
for case,dt in enumerate(('float32','float64','complex64','complex128')):
    n=3
    X=rng.normal(size=(n,n))
    if 'complex' in dt:X=X+1j*rng.normal(size=(n,n))
    X[...,np.arange(n),np.arange(n)]+=6
    base=X.astype(dt)
    A=base.T
    b=(rng.normal(size=n)+(1j*rng.normal(size=n) if 'complex' in dt else 0)).astype(dt)
    ex=np.linalg.solve(A,b); inv=np.linalg.inv(A); det=np.linalg.det(A)
    lines += [f'do -- strided {case}',f'  local base={arr_expr(base)}', '  local a=base.T', f'  local b={arr_expr(b)}']
    emit_array_result('np.linalg.solve(a,b)',ex,f'strided solve {case}',tol_for(ex.dtype)*8)
    emit_array_result('np.linalg.inv(a)',inv,f'strided inv {case}',tol_for(inv.dtype)*10)
    emit_array_result('np.linalg.det(a)',det,f'strided det {case}',tol_for(det.dtype)*15)
    lines.append('end');count+=3

# Upstream edge/error invariants.
lines += [
'do local a=np.zeros({0,0},np.float32); local r=np.linalg.inv(a); assert(r.dtype=="float32" and close(r.shape,{0,0}),"inv 0x0") end',
'do local a=np.zeros({0,0},np.complex64); local d=np.linalg.det(a); local s,l=np.linalg.slogdet(a); assert(scalar_close(d,np.complex(1,0),1e-7) and scalar_close(s,np.complex(1,0),1e-7) and l==0,"det 0x0") end',
'do local a=np.zeros({2,0,0},np.float64); local r=np.linalg.cholesky(a); assert(close(r.shape,{2,0,0}) and r.dtype=="float64","chol 0x0 stack") end',
'do local a=np.zeros({2,0,0},np.float64); local b=np.zeros({0},np.float64); local r=np.linalg.solve(a,b); assert(close(r.shape,{2,0}) and r.dtype=="float64","solve 0x0 vector") end',
'do local ok,e=pcall(function() return np.linalg.inv(np.array({1,2})) end); assert(not ok and tostring(e):find("at least two%-dimensional"),"inv ndim error") end',
'do local ok,e=pcall(function() return np.linalg.inv(np.ones({2,3})) end); assert(not ok and tostring(e):find("must be square",1,true),"inv square error") end',
'do local a=np.array({{1.0,2.0},{2.0,4.0}}); local ok,e=pcall(function() return np.linalg.inv(a) end); assert(not ok and tostring(e):find("Singular matrix",1,true),"inv singular") end',
'do local a=np.array({{1.0,2.0},{2.0,4.0}}); local b=np.array({1.0,2.0}); local ok,e=pcall(function() return np.linalg.solve(a,b) end); assert(not ok and tostring(e):find("Singular matrix",1,true),"solve singular") end',
'do local a=np.array({{1.0,2.0},{2.0,1.0}}); local ok,e=pcall(function() return np.linalg.cholesky(a) end); assert(not ok and tostring(e):find("not positive definite",1,true),"chol nonpd") end',
'do local a=np.array({{1.0,0.0},{0.0,1.0}},np.float16); local ok,e=pcall(function() return np.linalg.inv(a) end); assert(not ok and tostring(e):find("unsupported in linalg",1,true),"float16 reject") end',
'do local a=np.array({{1.0,0.0},{0.0,1.0}},np.longdouble); local ok,e=pcall(function() return np.linalg.det(a) end); assert(not ok and tostring(e):find("unsupported in linalg",1,true),"longdouble reject") end',
'do local a=np.array({{1.0,0.0},{0.0,1.0}}); local b=np.array({{1.0,2.0}}); local ok,e=pcall(function() return np.linalg.solve(a,b) end); assert(not ok and tostring(e):find("mismatch in its core dimension",1,true),"solve core mismatch") end',
]
count += 12
lines.append(f"print('linalg differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
