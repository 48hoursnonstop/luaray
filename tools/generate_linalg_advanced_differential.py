#!/usr/bin/env python3
from pathlib import Path
import math
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'linalg_advanced_differential_generated.lua'
rng=np.random.default_rng(0x1A180)
np.seterr(all='ignore')

lines=[
'local np=require("luaray_core")',
'local function scalar_close(a,b,tol)',
' tol=tol or 1e-9',
' if type(a)=="userdata" or type(b)=="userdata" then if type(a)~="userdata" or type(b)~="userdata" then return false end return scalar_close(a.real,b.real,tol) and scalar_close(a.imag,b.imag,tol) end',
' if a~=a and b~=b then return true end',
' if a==b then return true end',
' return math.abs(a-b)<=math.max(tol,math.abs(b)*tol)',
'end',
'local function close(a,b,tol)',
' if type(a)=="table" or type(b)=="table" then if type(a)~="table" or type(b)~="table" or #a~=#b then return false end for i=1,#a do if not close(a[i],b[i],tol) then return false end end return true end',
' return scalar_close(a,b,tol)',
'end',
f'-- Numeric oracle: installed NumPy {np.__version__}; semantics inspected in uploaded NumPy main 2.6.0.dev0.',
]

def fl(v):
    v=float(v)
    if math.isnan(v): return '0/0'
    if math.isinf(v): return 'math.huge' if v>0 else '-math.huge'
    if v==0.0 and math.copysign(1.0,v)<0:return '-0.0'
    return repr(v)
def scalar(x):
    if isinstance(x,np.generic):x=x.item()
    if isinstance(x,complex):return f'np.complex({fl(x.real)},{fl(x.imag)})'
    if isinstance(x,(float,np.floating)):return fl(x)
    if isinstance(x,(bool,np.bool_)):return 'true' if x else 'false'
    return str(int(x))
def tbl(x):
    if isinstance(x,np.ndarray):x=x.tolist()
    if isinstance(x,(list,tuple)):return '{'+','.join(tbl(v) for v in x)+'}'
    return scalar(x)
def arr(a):
    a=np.asarray(a);dt=a.dtype.name
    if a.size==0:return f'np.zeros({tbl(list(a.shape))},np.{dt})'
    return f'np.array({tbl(a)},np.{dt})'
def rdt(dt):
    dt=np.dtype(dt)
    if dt in (np.dtype('float32'),np.dtype('complex64')): return np.dtype('float32')
    return np.dtype('float64')
def ldt(dt):
    dt=np.dtype(dt)
    if dt==np.dtype('float32'):return np.dtype('float32')
    if dt==np.dtype('complex64'):return np.dtype('complex64')
    if dt==np.dtype('complex128'):return np.dtype('complex128')
    return np.dtype('float64')
def tol(dt,mul=1): return (2e-4 if np.dtype(dt) in (np.dtype('float32'),np.dtype('complex64')) else 2e-10)*mul

count=0
# lstsq: real/complex, vector/matrix RHS, over/under/square and rcond variants.
shapes=[(5,3,1),(5,3,2),(3,5,1),(3,5,2),(4,4,1),(6,2,3)]
for case in range(72):
    m,n,nrhs=shapes[case%len(shapes)];dt=('float32','float64','complex64','complex128','int32')[case%5]
    A=rng.normal(size=(m,n)); B=rng.normal(size=(m,nrhs))
    if 'complex' in dt:
        A=A+1j*rng.normal(size=A.shape);B=B+1j*rng.normal(size=B.shape)
    if np.issubdtype(np.dtype(dt),np.integer):A=np.rint(A*3).astype(dt);B=np.rint(B*2).astype(dt)
    else:A=A.astype(dt);B=B.astype(dt)
    b=B[:,0] if case%2==0 else B
    rc=None if case%3 else -1.0
    x,res,rank,s=np.linalg.lstsq(A,b,rcond=rc)
    odt=ldt(np.result_type(A.dtype,b.dtype)); real=rdt(odt)
    opt='' if rc is None else f',{rc}'
    lines += [f'do -- lstsq {case}',f' local a={arr(A)}; local b={arr(b)}',f' local x,r,rank,s=np.linalg.lstsq(a,b{opt})',
              f' assert(x.dtype=="{odt.name}" and r.dtype=="{real.name}" and s.dtype=="{real.name}","lstsq {case} dtype")',
              f' assert(close(x.shape,{tbl(list(x.shape))}) and close(r.shape,{tbl(list(res.shape))}) and close(s.shape,{tbl(list(s.shape))}),"lstsq {case} shape")',
              f' assert(close(x:tolist(),{tbl(np.asarray(x,dtype=odt))},{tol(odt,40)!r}),"lstsq {case} x")',
              f' assert(close(r:tolist(),{tbl(np.asarray(res,dtype=real))},{tol(real,80)!r}) and rank=={int(rank)},"lstsq {case} residual/rank")',
              f' assert(close(s:tolist(),{tbl(np.asarray(s,dtype=real))},{tol(real,30)!r}),"lstsq {case} s")','end']
    count+=1
# Empty lstsq edge cases copied from upstream test matrix.
for ci,(m,n,nrhs) in enumerate([(4,2,2),(0,4,1),(0,4,2),(4,0,1),(4,0,2),(4,2,0),(0,0,0)]):
    A=np.arange(m*n,dtype=np.float64).reshape(m,n);B=np.ones((m,nrhs));x,res,rank,s=np.linalg.lstsq(A,B,rcond=None)
    lines += [f'do -- lstsq empty {ci}',f' local a={arr(A)}; local b={arr(B)}',' local x,r,rank,s=np.linalg.lstsq(a,b)',
              f' assert(close(x.shape,{tbl(list(x.shape))}) and close(r.shape,{tbl(list(res.shape))}) and rank=={int(rank)} and close(s.shape,{tbl(list(s.shape))}),"lstsq empty {ci} shape/rank")',
              f' assert(close(x:tolist(),{tbl(x)},1e-10) and close(r:tolist(),{tbl(res)},1e-10) and close(s:tolist(),{tbl(s)},1e-10),"lstsq empty {ci} values")','end']
    count+=1

# pinv scalar rcond + stacks + hermitian.
for case in range(72):
    dt=('float32','float64','complex64','complex128','int32')[case%5];m,n=[(2,3),(3,2),(3,3),(4,2)][case%4];batch=() if case%3==0 else (2,)
    A=rng.normal(size=batch+(m,n))
    if 'complex' in dt:A=A+1j*rng.normal(size=A.shape)
    if np.issubdtype(np.dtype(dt),np.integer):A=np.rint(A*3).astype(dt)
    else:A=A.astype(dt)
    rc=1e-15 if case%2==0 else 1e-5
    P=np.linalg.pinv(A,rcond=rc);odt=ldt(A.dtype)
    lines += [f'do -- pinv {case}',f' local a={arr(A)}',f' local p=np.linalg.pinv(a,{rc!r})',f' assert(p.dtype=="{odt.name}" and close(p.shape,{tbl(list(P.shape))}),"pinv {case} dtype/shape")',f' assert(close(p:tolist(),{tbl(np.asarray(P,dtype=odt))},{tol(odt,100)!r}),"pinv {case}")','end']
    count+=1
for case in range(20):
    dt=('float32','float64','complex64','complex128')[case%4];n=3;X=rng.normal(size=(n,n))
    if 'complex' in dt:X=X+1j*rng.normal(size=X.shape)
    A=(X+X.T.conj()).astype(dt);P=np.linalg.pinv(A,hermitian=True);odt=ldt(A.dtype)
    lines += [f'do -- pinv hermitian {case}',f' local a={arr(A)}',' local p=np.linalg.pinv(a,{hermitian=true})',f' assert(p.dtype=="{odt.name}" and close(p:tolist(),{tbl(np.asarray(P,dtype=odt))},{tol(odt,120)!r}),"pinv hermitian {case}")','end'];count+=1

# pinv broadcast rcond/rtol arrays and conflict errors.
for case in range(12):
    dt=('float32','float64','complex64','complex128')[case%4]
    A=rng.normal(size=(2,3,3))
    if 'complex' in dt:A=A+1j*rng.normal(size=A.shape)
    A=A.astype(dt); A[...,np.arange(3),np.arange(3)]+=np.array([1.0,0.2,0.02])
    rc=np.array([1e-4,5e-2],dtype=np.float64)
    P=np.linalg.pinv(A,rcond=rc);odt=ldt(A.dtype)
    lines += [f'do -- pinv broadcast tol {case}',f' local a={arr(A)}; local rc={arr(rc)}',
              ' local p=np.linalg.pinv(a,{rcond=rc})',
              f' assert(p.dtype=="{odt.name}" and close(p.shape,{tbl(list(P.shape))}),"pinv broadcast {case} dtype/shape")',
              f' assert(close(p:tolist(),{tbl(np.asarray(P,dtype=odt))},{tol(odt,120)!r}),"pinv broadcast {case}")','end'];count+=1
lines += [
'do local a=np.array({{1.0,0},{0,1}}); local ok,e=pcall(function() np.linalg.pinv(a,{rcond=0.1,rtol=0.1}) end); assert(not ok and e:match("both set"),"pinv rcond rtol conflict") end',
'do local a=np.array({{{1.0,0},{0,1}},{{1,0},{0,1}}}); local bad=np.array({0.1,0.2,0.3}); local ok=pcall(function() np.linalg.pinv(a,{rcond=bad}) end); assert(not ok,"pinv bad rcond broadcast") end',
]
count+=2

# matrix_rank: ordinary, hermitian, tolerances, scalar/vector.
for case in range(70):
    dt=('float32','float64','complex64','complex128','int32')[case%5];m,n=(4,3) if case%2==0 else (3,4);batch=() if case%3==0 else (2,)
    A=rng.normal(size=batch+(m,n));
    if 'complex' in dt:A=A+1j*rng.normal(size=A.shape)
    if case%4==0:A[..., -1, :]=A[...,0,:]+A[...,1,:]
    if np.issubdtype(np.dtype(dt),np.integer):A=np.rint(A*4).astype(dt)
    else:A=A.astype(dt)
    if case%3==0: R=np.linalg.matrix_rank(A); opt=''
    elif case%3==1: R=np.linalg.matrix_rank(A,tol=1e-5);opt=',{tol=1e-5}'
    else: R=np.linalg.matrix_rank(A,rtol=1e-5);opt=',{rtol=1e-5}'
    rex=np.asarray(R)
    lines += [f'do -- rank {case}',f' local a={arr(A)}',f' local r=np.linalg.matrix_rank(a{opt})']
    if rex.ndim==0: lines += [f' assert(r=={int(rex)},"rank {case}")']
    else: lines += [f' assert(r.dtype=="int64" and close(r:tolist(),{tbl(rex.astype(np.int64))},0),"rank {case}")']
    lines += ['end'];count+=1
for case in range(16):
    dt=('float32','float64','complex64','complex128')[case%4];X=rng.normal(size=(4,4));
    if 'complex' in dt:X=X+1j*rng.normal(size=X.shape)
    A=(X+X.T.conj()).astype(dt);R=np.linalg.matrix_rank(A,hermitian=True)
    lines += [f'do local a={arr(A)}; assert(np.linalg.matrix_rank(a,{{hermitian=true}})=={int(R)},"rank hermitian {case}") end'];count+=1
lines += ['do assert(np.linalg.matrix_rank(np.array({0,0,0}))==0,"rank vector zero") end','do assert(np.linalg.matrix_rank(np.array({0,2,0}))==1,"rank vector") end','do assert(np.linalg.matrix_rank(np.array(3))==1,"rank scalar") end'];count+=3

# matrix_rank tolerances are full broadcast inputs and may expand the output batch shape.
for case in range(12):
    dt=('float32','float64','complex64','complex128')[case%4]
    A=np.diag(np.array([1.0,0.1,0.01],dtype=np.float64)).astype(dt)
    if 'complex' in dt:A=A*(1+0.1j)
    tv=np.array([0.005,0.05,0.5],dtype=np.float64)
    if case%2==0:
        R=np.linalg.matrix_rank(A,tol=tv); opt='tol'
    else:
        R=np.linalg.matrix_rank(A,rtol=tv); opt='rtol'
    lines += [f'do -- rank broadcast tol {case}',f' local a={arr(A)}; local t={arr(tv)}',
              f' local r=np.linalg.matrix_rank(a,{{{opt}=t}})',
              f' assert(r.dtype=="int64" and close(r.shape,{tbl(list(np.asarray(R).shape))}) and close(r:tolist(),{tbl(np.asarray(R,dtype=np.int64))},0),"rank broadcast {case}")','end'];count+=1
lines += [
'do local a=np.array({{1.0,0},{0,1}}); local ok,e=pcall(function() np.linalg.matrix_rank(a,{tol=0.1,rtol=0.1}) end); assert(not ok and e:match("both set"),"rank tol rtol conflict") end',
'do local a=np.array({{1.0,0},{0,1}}); local ok,e=pcall(function() np.linalg.norm(a,{axis=0}) end); assert(not ok and e:match("axis 0 is invalid"),"norm strict 1 based axis") end',
]
count+=2

# norm: vectors along axes and matrix norms on arbitrary axis pairs.
vector_ords=[None,0,1,2,3,-1,np.inf,-np.inf]
for case in range(88):
    dt=('float32','float64','complex64','complex128','int32')[case%5];shape=(2,3,4);A=rng.normal(size=shape)
    if 'complex' in dt:A=A+1j*rng.normal(size=shape)
    if np.issubdtype(np.dtype(dt),np.integer):A=np.rint(A*3).astype(dt)
    else:A=A.astype(dt)
    axis=case%3;order=vector_ords[case%len(vector_ords)];keep=bool(case%2)
    R=np.linalg.norm(A,ord=order,axis=axis,keepdims=keep); real=rdt(A.dtype)
    ordlua='nil' if order is None else ('math.huge' if order==np.inf else '-math.huge' if order==-np.inf else repr(order))
    lines += [f'do -- norm vector {case}',f' local a={arr(A)}',f' local r=np.linalg.norm(a,{{ord={ordlua},axis={axis+1},keepdims={str(keep).lower()}}})',f' assert(r.dtype=="{real.name}" and close(r.shape,{tbl(list(np.asarray(R).shape))}),"norm vector {case} dtype/shape")',f' assert(close(r:tolist(),{tbl(np.asarray(R,dtype=real))},{tol(real,30)!r}),"norm vector {case}")','end'];count+=1
matrix_ords=[None,'fro','nuc',1,-1,2,-2,np.inf,-np.inf]
for case in range(90):
    dt=('float32','float64','complex64','complex128','int32')[case%5];A=rng.normal(size=(2,3,4))
    if 'complex' in dt:A=A+1j*rng.normal(size=A.shape)
    if np.issubdtype(np.dtype(dt),np.integer):A=np.rint(A*2).astype(dt)
    else:A=A.astype(dt)
    axes=[(1,2),(0,2),(2,0)][case%3];order=matrix_ords[case%len(matrix_ords)];keep=bool(case%2)
    R=np.linalg.norm(A,ord=order,axis=axes,keepdims=keep);real=rdt(A.dtype)
    if order is None:ordlua='nil'
    elif isinstance(order,str):ordlua=f'"{order}"'
    elif order==np.inf:ordlua='math.huge'
    elif order==-np.inf:ordlua='-math.huge'
    else:ordlua=repr(order)
    lines += [f'do -- norm matrix {case}',f' local a={arr(A)}',f' local r=np.linalg.norm(a,{{ord={ordlua},axis={{{axes[0]+1},{axes[1]+1}}},keepdims={str(keep).lower()}}})']
    if np.asarray(R).ndim==0: lines += [f' assert(scalar_close(r,{scalar(np.asarray(R).item())},{tol(real,40)!r}),"norm matrix {case}")']
    else: lines += [f' assert(r.dtype=="{real.name}" and close(r.shape,{tbl(list(np.asarray(R).shape))}) and close(r:tolist(),{tbl(np.asarray(R,dtype=real))},{tol(real,40)!r}),"norm matrix {case}")']
    lines += ['end'];count+=1
# default flatten and 2-D conventional cases.
for case in range(25):
    dt=('float32','float64','complex64','complex128','int32')[case%5];A=rng.normal(size=(2,3,4))
    if 'complex' in dt:A=A+1j*rng.normal(size=A.shape)
    if np.issubdtype(np.dtype(dt),np.integer):A=np.rint(A*2).astype(dt)
    else:A=A.astype(dt)
    R=np.linalg.norm(A);lines += [f'do local a={arr(A)}; assert(scalar_close(np.linalg.norm(a),{scalar(R)},{tol(rdt(A.dtype),40)!r}),"norm flatten {case}") end'];count+=1

# pinv empty-dtype regressions from upstream test_linalg.py.
for shape in [(0,3),(3,0),(0,0),(2,0,3)]:
    for dt in ('int64','float32','complex64'):
        A=np.empty(shape,dtype=dt);P=np.linalg.pinv(A)
        # NumPy main gh-18527/gh-30917: integer/bool empty pinv uses the
        # computation result dtype (float64), overriding older oracle builds.
        odt=ldt(A.dtype); pshape=shape[:-2]+shape[-2:][::-1]
        lines += [f'do local a={arr(A)}; local p=np.linalg.pinv(a); assert(p.dtype=="{odt.name}" and close(p.shape,{tbl(list(pshape))}),"pinv empty {shape} {dt}") end'];count+=1
# NumPy's empty shortcut returns before rcond broadcasting.
lines += ['do local a=np.zeros({2,0,3},np.float64); local p=np.linalg.pinv(a,{rcond=np.ones({7},np.float64)}); assert(close(p.shape,{2,3,0}),"pinv empty skips rcond broadcast") end']
count+=1

# Source-level norm/error regressions.
lines += [
'do local x=np.array({-2147483648},np.int32); assert(scalar_close(np.linalg.norm(x,3),2147483648.0,1e-12),"norm intmin") end',
'do local a=np.array({{1.0,2,3},{4,5,6}}); local ok=pcall(function() np.linalg.norm(a,{ord=3,axis={1,2}}) end); assert(not ok,"matrix norm bad ord") end',
'do local a=np.array({3.0,4.0}); local ok=pcall(function() np.linalg.norm(a,"fro") end); assert(not ok,"vector fro rejected") end',
'do local a=np.ones({2,3,4}); local ok=pcall(function() np.linalg.norm(a,{axis={2,2}}) end); assert(not ok,"norm duplicate axes") end',
'do local a=np.ones({2,3,4}); local ok=pcall(function() np.linalg.norm(a,{axis=4}) end); assert(not ok,"norm bad axis") end',
'do local a=np.zeros({0,0}); local ok=pcall(function() np.linalg.cond(a) end); assert(not ok,"cond empty rejected") end',
]
count+=6

# Exact upstream longdouble/clongdouble norm regressions (test_linalg.py).
lines += [
'do local x=np.arange(10,np.longdouble); assert(scalar_close(np.linalg.norm(x,3),12.651489979526238,1e-11),"longdouble pnorm") end',
'do local d=np.array({np.complex(6,7),np.complex(-6,7)},np.complex256); assert(scalar_close(np.linalg.norm(d,3),11.615898132184,1e-10),"clongdouble pnorm") end',
'do local x=np.reshape(np.arange(10,np.longdouble),{2,5}); local r=np.linalg.norm(x,{ord="fro",axis={1,2},keepdims=true}); assert(r.dtype=="longdouble" and close(r.shape,{1,1}) and scalar_close(r:get(1,1),16.881943016134134,1e-11),"longdouble fro") end',
'do local x=np.reshape(np.arange(6,np.longdouble),{2,3}); local ok=pcall(function() np.linalg.norm(x,{ord=2,axis={1,2}}) end); assert(not ok,"longdouble SVD norm unsupported like NumPy") end',
]
count+=4

# cond: square stacks for every supported p, rectangular ±2.
conds=[None,1,-1,2,-2,'fro','nuc',np.inf,-np.inf]
for case in range(72):
    dt=('float32','float64','complex64','complex128')[case%4];batch=() if case%3==0 else (2,);n=3;A=rng.normal(size=batch+(n,n))
    if 'complex' in dt:A=A+1j*rng.normal(size=A.shape)
    A=A.astype(dt);A[...,np.arange(n),np.arange(n)]+=np.arange(1,n+1)
    p=conds[case%len(conds)];R=np.linalg.cond(A,p);real=rdt(A.dtype)
    if p is None:pexpr=''
    elif isinstance(p,str):pexpr=f',"{p}"'
    elif p==np.inf:pexpr=',math.huge'
    elif p==-np.inf:pexpr=',-math.huge'
    else:pexpr=f',{p}'
    lines += [f'do -- cond {case}',f' local a={arr(A)}',f' local r=np.linalg.cond(a{pexpr})']
    if np.asarray(R).ndim==0:lines += [f' assert(scalar_close(r,{scalar(R)},{tol(real,100)!r}),"cond {case}")']
    else:lines += [f' assert(r.dtype=="{real.name}" and close(r:tolist(),{tbl(np.asarray(R,dtype=real))},{tol(real,100)!r}),"cond {case}")']
    lines += ['end'];count+=1
for case in range(20):
    dt=('float32','float64','complex64','complex128')[case%4];A=rng.normal(size=(3,5));
    if 'complex' in dt:A=A+1j*rng.normal(size=A.shape)
    A=A.astype(dt);p=2 if case%2==0 else -2;R=np.linalg.cond(A,p);real=rdt(A.dtype)
    lines += [f'do local a={arr(A)}; assert(scalar_close(np.linalg.cond(a,{p}),{scalar(R)},{tol(real,100)!r}),"cond rectangular {case}") end'];count+=1
# main-specific non-finite behavior from uploaded test_linalg.py / _cond_svdvals.
lines += [
'do local a=np.array({{1.0,0/0},{1,1}}); for _,p in ipairs({2,-2,1,-1,math.huge,-math.huge}) do local r=np.linalg.cond(a,p); assert(r~=r,"cond nan") end; assert(np.linalg.cond(a)~=np.linalg.cond(a),"cond nan default") end',
'do local a=np.array({{1.0,math.huge},{1,1}}); for _,p in ipairs({2,1,math.huge}) do assert(np.linalg.cond(a,p)==math.huge,"cond inf") end; assert(np.linalg.cond(a)==math.huge,"cond inf default") end',
'do local a=np.zeros({2,2}); assert(np.linalg.cond(a)==math.huge and np.linalg.cond(a,-2)==math.huge and np.linalg.cond(a,1)==math.huge,"cond zero singular") end',
]
count+=3

lines.append(f'print("advanced linalg differential cases: {count}")')
OUT.write_text('\n'.join(lines)+'\n')
print(f'wrote {OUT} ({count} cases)')
