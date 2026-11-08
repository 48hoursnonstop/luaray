#!/usr/bin/env python3
from pathlib import Path
import math
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'eigen_svd_differential_generated.lua'
rng=np.random.default_rng(0xE1675D)

lines=[
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
'local function insert_before_last(shape)',
'  local r={}; for i=1,#shape-1 do r[#r+1]=shape[i] end; r[#r+1]=1; r[#r+1]=shape[#shape]; return r',
'end',
'local function eigset_close(actual,expected,tol)',
'  if #actual~=#expected then return false end',
'  local used={}',
'  for i=1,#actual do',
'    local found=false',
'    for j=1,#expected do if not used[j] and scalar_close(actual[i],expected[j],tol) then used[j]=true; found=true; break end end',
'    if not found then return false end',
'  end',
'  return true',
'end',
'local function eigsets_close(actual,expected,tol)',
'  if #actual==0 then return #expected==0 end',
'  if type(actual[1])=="table" then',
'    if #actual~=#expected then return false end; for i=1,#actual do if not eigsets_close(actual[i],expected[i],tol) then return false end end; return true',
'  end',
'  return eigset_close(actual,expected,tol)',
'end',
f'-- Numeric oracle: installed NumPy {np.__version__}; API/dtype semantics below are pinned to uploaded NumPy main 2.6.0.dev0 source.',
]

def float_lua(v):
    v=float(v)
    if math.isnan(v): return '0/0'
    if math.isinf(v): return 'math.huge' if v>0 else '-math.huge'
    if v==0.0 and math.copysign(1.0,v)<0:return '-0.0'
    return repr(v)

def scalar_lua(x):
    if isinstance(x,np.generic):x=x.item()
    if isinstance(x,complex):return f'np.complex({float_lua(x.real)},{float_lua(x.imag)})'
    if isinstance(x,(float,np.floating)):return float_lua(x)
    if isinstance(x,(bool,np.bool_)):return 'true' if x else 'false'
    return str(int(x))

def table_lua(x):
    if isinstance(x,np.ndarray):x=x.tolist()
    if isinstance(x,(list,tuple)):return '{'+','.join(table_lua(v) for v in x)+'}'
    return scalar_lua(x)

def arr_expr(a):
    a=np.asarray(a);dt=a.dtype.name
    if a.size==0:return f'np.zeros({table_lua(list(a.shape))},np.{dt})'
    return f'np.array({table_lua(a)},np.{dt})'

def common_result_dtype(dt):
    dt=np.dtype(dt)
    if dt==np.dtype('float32'):return np.dtype('float32')
    if dt==np.dtype('complex64'):return np.dtype('complex64')
    if dt==np.dtype('complex128'):return np.dtype('complex128')
    return np.dtype('float64')

def complex_result_dtype(dt):
    r=common_result_dtype(dt)
    return np.dtype('complex64') if r in (np.dtype('float32'),np.dtype('complex64')) else np.dtype('complex128')

def real_result_dtype(dt):
    r=common_result_dtype(dt)
    return np.dtype('float32') if r in (np.dtype('float32'),np.dtype('complex64')) else np.dtype('float64')

def tol(dt,mul=1):
    return (1.5e-4 if np.dtype(dt) in (np.dtype('float32'),np.dtype('complex64')) else 2e-10)*mul

count=0
# General eig/eigvals. Real-valued main now always returns complex dtype.
for case in range(72):
    dt=('float32','float64','complex64','complex128','int32')[case%5]
    n=int(rng.integers(1,5));batch=() if case%3==0 else ((2,) if case%3==1 else (2,2))
    if np.issubdtype(np.dtype(dt),np.integer):
        A=rng.integers(-4,5,size=batch+(n,n)).astype(dt)
    else:
        A=rng.normal(size=batch+(n,n))
        if 'complex' in dt:A=A+1j*rng.normal(size=A.shape)
        A=A.astype(dt)
    # Keep most cases well separated from pathological defective matrices.
    if n>0 and not np.issubdtype(np.dtype(dt),np.integer):
        A=A.copy();A[...,np.arange(n),np.arange(n)] += np.arange(1,n+1)*0.37
    w,v=np.linalg.eig(A)
    wc=np.asarray(w,dtype=complex_result_dtype(A.dtype));ev=np.asarray(np.linalg.eigvals(A),dtype=complex_result_dtype(A.dtype))
    cdt=complex_result_dtype(A.dtype).name
    lines += [f'do -- eig {case}',f'  local a={arr_expr(A)}','  local w,v=np.linalg.eig(a)',
              f'  assert(w.dtype=="{cdt}" and v.dtype=="{cdt}","eig {case} dtype")',
              f'  assert(close(w.shape,{table_lua(list(wc.shape))}) and close(v.shape,{table_lua(list(A.shape))}),"eig {case} shape")',
              f'  assert(eigsets_close(w:tolist(),{table_lua(wc)},{tol(cdt,8)!r}),"eig {case} eigenvalues")',
              '  local wr=np.reshape(w,insert_before_last(w.shape))',
              '  local lhs=np.matmul(a,v); local rhs=np.multiply(v,wr)',
              f'  assert(close(lhs:tolist(),rhs:tolist(),{tol(cdt,80)!r}),"eig {case} residual")',
              '  local e=np.linalg.eigvals(a)',
              f'  assert(e.dtype=="{cdt}" and close(e.shape,w.shape),"eigvals {case} dtype/shape")',
              f'  assert(eigsets_close(e:tolist(),{table_lua(ev)},{tol(cdt,8)!r}),"eigvals {case} values")','end']
    count+=2

# Strided real/complex inputs.
for case,dt in enumerate(('float32','float64','complex64','complex128')):
    n=4;B=rng.normal(size=(n,n))
    if 'complex' in dt:B=B+1j*rng.normal(size=B.shape)
    B=B.astype(dt);A=B.T
    w=np.asarray(np.linalg.eigvals(A),dtype=complex_result_dtype(A.dtype));cdt=complex_result_dtype(A.dtype).name
    lines += [f'do -- eig strided {case}',f'  local base={arr_expr(B)}','  local a=base.T','  local w=np.linalg.eigvals(a)',
              f'  assert(w.dtype=="{cdt}" and eigset_close(w:tolist(),{table_lua(w)},{tol(cdt,10)!r}),"eig strided {case}")','end']
    count+=1

# Hermitian/symmetric eigenproblems.
for case in range(64):
    dt=('float32','float64','complex64','complex128','int32')[case%5]
    n=int(rng.integers(1,5));batch=() if case%2==0 else (2,)
    X=rng.normal(size=batch+(n,n))
    if 'complex' in dt:X=X+1j*rng.normal(size=X.shape)
    H=X+np.swapaxes(X.conj(),-1,-2)
    if np.issubdtype(np.dtype(dt),np.integer):H=np.rint(H*2).astype(dt)
    else:H=H.astype(dt)
    uplo='U' if case%3==0 else 'L'
    w,v=np.linalg.eigh(H,UPLO=uplo); w=np.asarray(w,dtype=real_result_dtype(H.dtype));v=np.asarray(v,dtype=common_result_dtype(H.dtype))
    rdt=real_result_dtype(H.dtype).name;vdt=common_result_dtype(H.dtype).name
    lines += [f'do -- eigh {case}',f'  local a={arr_expr(H)}',f'  local w,v=np.linalg.eigh(a,"{uplo}")',
              f'  assert(w.dtype=="{rdt}" and v.dtype=="{vdt}","eigh {case} dtype")',
              f'  assert(close(w.shape,{table_lua(list(w.shape))}) and close(v.shape,{table_lua(list(v.shape))}),"eigh {case} shape")',
              f'  assert(close(w:tolist(),{table_lua(w)},{tol(rdt,8)!r}),"eigh {case} eigenvalues")',
              '  local wr=np.reshape(w,insert_before_last(w.shape)); local lhs=np.matmul(a,v); local rhs=np.multiply(v,wr)',
              f'  assert(close(lhs:tolist(),rhs:tolist(),{tol(vdt,120)!r}),"eigh {case} residual")',
              f'  local e=np.linalg.eigvalsh(a,"{uplo}")',
              f'  assert(e.dtype=="{rdt}" and close(e:tolist(),{table_lua(w)},{tol(rdt,8)!r}),"eigvalsh {case}")','end']
    count+=2

# UPLO and imaginary diagonal semantics copied from upstream tests.
lines += [
'do local a=np.array({{0.0,0.0},{1.0,0.0}}); assert(close(np.linalg.eigvalsh(a):tolist(),{-1.0,1.0},1e-12),"eigvalsh default L") end',
'do local a=np.array({{0.0,1.0},{0.0,0.0}}); assert(close(np.linalg.eigvalsh(a,"u"):tolist(),{-1.0,1.0},1e-12),"eigvalsh lowercase U") end',
'do local a=np.array({{np.complex(5,2),np.complex(9,-2)},{np.complex(0,2),np.complex(2,-1)}},np.complex128); assert(close(np.linalg.eigvalsh(a,"L"):tolist(),{1.0,6.0},1e-12),"eigvalsh imag diagonal ignored") end',
'do local a=np.array({{1.0,0.5},{0.5,1.0}},np.float32); local ok,e=pcall(function() return np.linalg.eigh(a,"lower") end); assert(not ok and tostring(e):find("UPLO argument",1,true),"eigh invalid UPLO") end',
]
count+=4

# SVD, reduced/full and compute_uv=False. Reconstruct reduced mode through S[...,None,:].
shapes=[(1,1),(2,3),(3,2),(4,4),(2,1),(1,4)]
for case in range(84):
    dt=('float32','float64','complex64','complex128','int32')[case%5]
    m,n=shapes[case%len(shapes)];batch=() if case%3==0 else ((2,) if case%3==1 else (2,2))
    A=rng.normal(size=batch+(m,n))
    if 'complex' in dt:A=A+1j*rng.normal(size=A.shape)
    if np.issubdtype(np.dtype(dt),np.integer):A=np.rint(A*3).astype(dt)
    else:A=A.astype(dt)
    full=(case%4==0)
    u,s,vh=np.linalg.svd(A,full_matrices=full);rdt=real_result_dtype(A.dtype);vdt=common_result_dtype(A.dtype)
    s=np.asarray(s,dtype=rdt);udt=vdt.name;sd=rdt.name
    opts='{full_matrices=' + ('true' if full else 'false') + '}'
    lines += [f'do -- svd {case}',f'  local a={arr_expr(A)}',f'  local u,s,vh=np.linalg.svd(a,{opts})',
              f'  assert(u.dtype=="{udt}" and s.dtype=="{sd}" and vh.dtype=="{udt}","svd {case} dtype")',
              f'  assert(close(u.shape,{table_lua(list(u.shape))}) and close(s.shape,{table_lua(list(s.shape))}) and close(vh.shape,{table_lua(list(vh.shape))}),"svd {case} shape")',
              f'  assert(close(s:tolist(),{table_lua(s)},{tol(sd,12)!r}),"svd {case} singular values")']
    if not full:
        lines += ['  local sr=np.reshape(s,insert_before_last(s.shape)); local r=np.matmul(np.multiply(u,sr),vh)',
                  f'  assert(close(r:tolist(),a:tolist(),{tol(udt,150)!r}),"svd {case} reconstruct")']
    lines += ['  local so=np.linalg.svd(a,{compute_uv=false})',f'  assert(so.dtype=="{sd}" and close(so:tolist(),{table_lua(s)},{tol(sd,12)!r}),"svd-only {case}")',
              '  local sv=np.linalg.svdvals(a)',f'  assert(sv.dtype=="{sd}" and close(sv:tolist(),{table_lua(s)},{tol(sd,12)!r}),"svdvals {case}")','end']
    count+=3

# Hermitian SVD follows upstream eigh/sign/reorder path.
for case in range(36):
    dt=('float32','float64','complex64','complex128')[case%4];n=int(rng.integers(1,5));batch=() if case%2==0 else (2,)
    X=rng.normal(size=batch+(n,n))
    if 'complex' in dt:X=X+1j*rng.normal(size=X.shape)
    A=(X+np.swapaxes(X.conj(),-1,-2)).astype(dt)
    u,s,vh=np.linalg.svd(A,hermitian=True);s=np.asarray(s,dtype=real_result_dtype(A.dtype));udt=common_result_dtype(A.dtype).name;sd=real_result_dtype(A.dtype).name
    lines += [f'do -- svd hermitian {case}',f'  local a={arr_expr(A)}','  local u,s,vh=np.linalg.svd(a,{hermitian=true})',
              f'  assert(u.dtype=="{udt}" and s.dtype=="{sd}" and vh.dtype=="{udt}","svd hermitian {case} dtype")',
              f'  assert(close(s:tolist(),{table_lua(s)},{tol(sd,15)!r}),"svd hermitian {case} values")',
              '  local sr=np.reshape(s,insert_before_last(s.shape)); local r=np.matmul(np.multiply(u,sr),vh)',
              f'  assert(close(r:tolist(),a:tolist(),{tol(udt,180)!r}),"svd hermitian {case} reconstruct")',
              '  local so=np.linalg.svd(a,{compute_uv=false,hermitian=true})',f'  assert(close(so:tolist(),{table_lua(s)},{tol(sd,15)!r}),"svd hermitian only {case}")','end']
    count+=2

# Empty shapes / dtype behavior / nonfinite and shape errors from upstream.
lines += [
'do local a=np.zeros({0,0},np.float32); local w,v=np.linalg.eig(a); assert(w.dtype=="complex64" and v.dtype=="complex64" and close(w.shape,{0}) and close(v.shape,{0,0}),"eig 0x0") end',
'do local a=np.zeros({2,0,0},np.int32); local w=np.linalg.eigvals(a); assert(w.dtype=="complex128" and close(w.shape,{2,0}),"eigvals stack 0x0") end',
'do local a=np.zeros({0,0},np.complex64); local w,v=np.linalg.eigh(a); assert(w.dtype=="float32" and v.dtype=="complex64" and close(w.shape,{0}) and close(v.shape,{0,0}),"eigh 0x0") end',
'do local a=np.zeros({2,0,0},np.int32); local w=np.linalg.eigvalsh(a); assert(w.dtype=="float64" and close(w.shape,{2,0}),"eigvalsh stack 0x0") end',
'do local a=np.empty({4,0},np.float64); local u,s,vh=np.linalg.svd(a); assert(close(u:tolist(),{{1,0,0,0},{0,1,0,0},{0,0,1,0},{0,0,0,1}},0) and close(s.shape,{0}) and close(vh.shape,{0,0}),"svd empty m") end',
'do local a=np.empty({0,4},np.float64); local u,s,vh=np.linalg.svd(a); assert(close(u.shape,{0,0}) and close(s.shape,{0}) and close(vh:tolist(),{{1,0,0,0},{0,1,0,0},{0,0,1,0},{0,0,0,1}},0),"svd empty n") end',
'do local a=np.array({{1.0,0.0},{0.0,1.0}},np.float16); local ok,e=pcall(function() return np.linalg.eig(a) end); assert(not ok and tostring(e):find("unsupported in linalg",1,true),"eig float16 reject") end',
'do local a=np.array({{1.0,0.0},{0.0,1.0}},np.float16); local ok,e=pcall(function() return np.linalg.svd(a) end); assert(not ok and tostring(e):find("unsupported in linalg",1,true),"svd float16 reject") end',
'do local a=np.array({{1.0,0.0},{0.0,0/0}},np.float64); local ok,e=pcall(function() return np.linalg.eig(a) end); assert(not ok and tostring(e):find("infs or NaNs",1,true),"eig finite check") end',
'do local a=np.array({{1.0,0.0},{0.0,math.huge}},np.float64); local ok,e=pcall(function() return np.linalg.svd(a) end); assert(not ok and tostring(e):find("SVD did not converge",1,true),"svd finite check") end',
'do local ok,e=pcall(function() return np.linalg.eig(np.array({1.0,2.0})) end); assert(not ok and tostring(e):find("at least two%-dimensional"),"eig ndim") end',
'do local ok,e=pcall(function() return np.linalg.eig(np.ones({2,3})) end); assert(not ok and tostring(e):find("must be square",1,true),"eig square") end',
'do local ok,e=pcall(function() return np.linalg.svd(np.array({1.0,2.0})) end); assert(not ok and tostring(e):find("at least two%-dimensional"),"svd ndim") end',
'do local ok,e=pcall(function() return np.linalg.svd(np.ones({2,3}),{hermitian=true}) end); assert(not ok and tostring(e):find("must be square",1,true),"svd hermitian square") end',
]
count+=14
lines.append(f'print("eigen/svd differential cases: {count}")')
OUT.write_text('\n'.join(lines)+'\n')
print(f'wrote {OUT} ({count} API cases)')
