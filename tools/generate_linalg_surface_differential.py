#!/usr/bin/env python3
from pathlib import Path
import math
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'linalg_surface_differential_generated.lua'
rng=np.random.default_rng(0x1A190)
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
f'-- Numeric oracle: installed NumPy {np.__version__}; source semantics inspected in uploaded NumPy main 2.6.0.dev0.',
]

def fl(v):
    v=float(v)
    if math.isnan(v):return '0/0'
    if math.isinf(v):return 'math.huge' if v>0 else '-math.huge'
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
def tol(dt,mul=1):return (3e-4 if np.dtype(dt) in (np.dtype('float32'),np.dtype('complex64')) else 3e-10)*mul
def emit_result(expr,r,label,t=None):
    global count
    a=np.asarray(r);t=t or tol(a.dtype if a.dtype.kind in 'fc' else np.float64,20)
    lines.append(f'do local r={expr}')
    if a.ndim==0:
        lines.append(f' assert(scalar_close(r,{scalar(a.item())},{t!r}),"{label}")')
    else:
        lines.append(f' assert(r.dtype=="{a.dtype.name}" and close(r.shape,{tbl(list(a.shape))}) and close(r:tolist(),{tbl(a)},{t!r}),"{label}")')
    lines.append('end');count+=1

count=0
# matrix_power: stacked and scalar exponent paths, including dtype preservation.
for case in range(84):
    dt=('int8','int32','float32','float64','complex64','complex128')[case%6]
    n=2+(case%2);batch=() if case%3==0 else (2,)
    A=rng.integers(-2,3,size=batch+(n,n)).astype(dt)
    if 'float' in dt:A=A.astype(dt)+np.eye(n,dtype=dt)*2
    if 'complex' in dt:A=(A+1j*rng.integers(-2,3,size=A.shape)).astype(dt)+np.eye(n,dtype=dt)*2
    exp=(0,1,2,3,5)[case%5]
    R=np.linalg.matrix_power(A,exp)
    lines += [f'do local a={arr(A)}; local r=np.linalg.matrix_power(a,{exp})']
    if exp==1: lines += [f' assert(r==a,"matrix_power identity {case}")']
    lines += [f' assert(r.dtype=="{R.dtype.name}" and close(r.shape,{tbl(list(R.shape))}) and close(r:tolist(),{tbl(R)},{tol(R.dtype,40)!r}),"matrix_power {case}")','end'];count+=1
for case in range(30):
    dt=('int32','float32','float64','complex64','complex128')[case%5];n=2+(case%2)
    A=rng.normal(size=(n,n));A=A+np.eye(n)*3
    if 'complex' in dt:A=A+1j*rng.normal(size=A.shape)
    if np.issubdtype(np.dtype(dt),np.integer):A=np.rint(A*2).astype(dt);A+=np.eye(n,dtype=dt)*5
    else:A=A.astype(dt)
    exp=-1 if case%2==0 else -2;R=np.linalg.matrix_power(A,exp)
    emit_result(f'np.linalg.matrix_power({arr(A)},{exp})',R,f'matrix_power neg {case}',tol(R.dtype,120))
lines += [
'do local ok=pcall(function() np.linalg.matrix_power(np.array({1,2}),2) end); assert(not ok,"matrix_power 1d error") end',
'do local ok=pcall(function() np.linalg.matrix_power(np.ones({2,3}),2) end); assert(not ok,"matrix_power square error") end',
'do local ok=pcall(function() np.linalg.matrix_power(np.ones({2,2}),1.5) end); assert(not ok,"matrix_power integer exponent") end',
];count+=3

# tensorinv / tensorsolve source examples and permutations.
for shape,ind in [((4,6,8,3),2),((24,8,3),1),((2,2,2,2),2)]:
    total=int(np.prod(shape));side=int(round(math.sqrt(total)));A=np.eye(side,dtype=np.float64).reshape(shape)
    R=np.linalg.tensorinv(A,ind=ind);emit_result(f'np.linalg.tensorinv({arr(A)},{ind})',R,f'tensorinv {shape} {ind}',1e-12)
for shape in [(2,3,6),(3,4,4,3),(0,3,3,0)]:
    A=rng.normal(size=shape);b=np.ones(A.shape[:2]);R=np.linalg.tensorsolve(A,b)
    emit_result(f'np.linalg.tensorsolve({arr(A)},{arr(b)})',R,f'tensorsolve {shape}',1e-8)
# nontrivial axes case: construct square after moving axes.
base=np.eye(6).reshape(2,3,2,3);b=np.array([[1.,2.,3.],[4.,5.,6.]])
# axes=(0,1) moves first pair to end -> shape remains (2,3,2,3), valid.
R=np.linalg.tensorsolve(base,b,axes=(0,1))
emit_result(f'np.linalg.tensorsolve({arr(base)},{arr(b)},{{axes={{1,2}}}})',R,'tensorsolve axes',1e-12)
lines += [
'do local ok=pcall(function() np.linalg.tensorinv(np.ones({4,6,8,2}),2) end); assert(not ok,"tensorinv nonsquare") end',
'do local ok=pcall(function() np.linalg.tensorinv(np.ones({2,2}),0) end); assert(not ok,"tensorinv ind") end',
'do local ok=pcall(function() np.linalg.tensorsolve(np.ones({4,6,8,2}),np.ones({4,6})) end); assert(not ok,"tensorsolve nonsquare") end',
];count+=3

# multi_dot with optimal-parenthesization shapes, vector endpoints, mixed numeric dtypes.
chains=[[(6,2),(2,6),(6,2)],[(6,2),(2,6),(6,2),(2,1)],[(3,5),(5,2),(2,7),(7,4),(4,2)]]
for case in range(48):
    shapes=chains[case%len(chains)];dt=('float32','float64','complex64','complex128','int32')[case%5]
    xs=[]
    for s in shapes:
        x=rng.normal(size=s)
        if 'complex' in dt:x=x+1j*rng.normal(size=s)
        if np.issubdtype(np.dtype(dt),np.integer):x=np.rint(x*2).astype(dt)
        else:x=x.astype(dt)
        xs.append(x)
    if case%4==1:xs[0]=xs[0][0]
    if case%4==2:xs[-1]=xs[-1][:,0]
    if case%4==3:xs[0]=xs[0][0];xs[-1]=xs[-1][:,0]
    R=np.linalg.multi_dot(xs)
    expr='np.linalg.multi_dot({'+','.join(arr(x) for x in xs)+'})'
    emit_result(expr,R,f'multi_dot {case}',tol(R.dtype,80))
# out path
A=np.arange(12,dtype=np.float64).reshape(3,4);B=np.arange(20,dtype=np.float64).reshape(4,5);C=np.arange(10,dtype=np.float64).reshape(5,2);R=np.linalg.multi_dot([A,B,C])
lines += [f'do local out=np.zeros({tbl(list(R.shape))},np.float64); local r=np.linalg.multi_dot({{{arr(A)},{arr(B)},{arr(C)}}},{{out=out}}); assert(r==out and close(out:tolist(),{tbl(R)},1e-10),"multi_dot out") end'];count+=1
lines += ['do local ok=pcall(function() np.linalg.multi_dot({}) end); assert(not ok,"multi_dot zero") end','do local ok=pcall(function() np.linalg.multi_dot({np.ones({2,2})}) end); assert(not ok,"multi_dot one") end'];count+=2

# outer strict 1-D.
for case in range(24):
    dt=('int16','float32','float64','complex64','complex128')[case%5];a=rng.normal(size=case%4+1);b=rng.normal(size=case%5+1)
    if 'complex' in dt:a=a+1j*rng.normal(size=a.shape);b=b+1j*rng.normal(size=b.shape)
    if np.issubdtype(np.dtype(dt),np.integer):a=np.rint(a*3).astype(dt);b=np.rint(b*3).astype(dt)
    else:a=a.astype(dt);b=b.astype(dt)
    R=np.linalg.outer(a,b);emit_result(f'np.linalg.outer({arr(a)},{arr(b)})',R,f'outer {case}',tol(R.dtype,10))
lines += ['do local ok=pcall(function() np.linalg.outer(np.ones({2,1}),np.ones({2})) end); assert(not ok,"outer strict 1d") end'];count+=1

# diagonal / trace on the last two axes, offsets including empties and dtype override.
for case in range(54):
    shape=((3,4),(2,3,4),(2,2,3,4))[case%3];dt=('int32','float32','float64','complex64','complex128')[case%5]
    A=np.arange(np.prod(shape),dtype=np.float64).reshape(shape)
    if 'complex' in dt:A=A+1j*(A+1)
    A=A.astype(dt);off=(-5,-2,-1,0,1,2,5)[case%7]
    D=np.linalg.diagonal(A,offset=off);T=np.linalg.trace(A,offset=off)
    emit_result(f'np.linalg.diagonal({arr(A)},{{offset={off}}})',D,f'diagonal {case}',0)
    emit_result(f'np.linalg.trace({arr(A)},{{offset={off}}})',T,f'trace {case}',tol(T.dtype,5))
# trace explicit dtype
A=np.arange(12,dtype=np.int8).reshape(3,4);R=np.linalg.trace(A,dtype=np.float64)
emit_result(f'np.linalg.trace({arr(A)},{{dtype=np.float64}})',R,'trace dtype',0)
lines += ['do local d=np.linalg.diagonal(np.reshape(np.arange(9),{3,3})); local ok=pcall(function() d:set(99,1) end); assert(not ok,"diagonal readonly") end'];count+=1

# cross product: default/first axis and broadcast batches.
for case in range(42):
    dt=('int16','int32','float32','float64','complex64','complex128')[case%6]
    if case%3==0:shapea=shapeb=(3,)
    elif case%3==1:shapea=shapeb=(4,3)
    else:shapea=(2,1,3);shapeb=(1,4,3)
    a=rng.normal(size=shapea);b=rng.normal(size=shapeb)
    if 'complex' in dt:a=a+1j*rng.normal(size=shapea);b=b+1j*rng.normal(size=shapeb)
    if np.issubdtype(np.dtype(dt),np.integer):a=np.rint(a*3).astype(dt);b=np.rint(b*3).astype(dt)
    else:a=a.astype(dt);b=b.astype(dt)
    R=np.linalg.cross(a,b);emit_result(f'np.linalg.cross({arr(a)},{arr(b)})',R,f'cross {case}',tol(R.dtype,10))
for case in range(12):
    a=rng.integers(-3,4,size=(3,5),dtype=np.int32);b=rng.integers(-3,4,size=(3,5),dtype=np.int32);R=np.linalg.cross(a,b,axis=0)
    emit_result(f'np.linalg.cross({arr(a)},{arr(b)},{{axis=1}})',R,f'cross axis {case}',0)
lines += ['do local ok=pcall(function() np.linalg.cross(np.ones({2}),np.ones({2})) end); assert(not ok,"cross core dim") end'];count+=1

# tensordot: count axes and explicit axis lists.
for case in range(54):
    dt=('int32','float32','float64','complex64','complex128')[case%5]
    mode=case%3
    if mode==0:ash,bsh,nax=(2,3),(4,5),0
    elif mode==1:ash,bsh,nax=(2,3,4),(4,5),1
    else:ash,bsh,nax=(2,3,4),(3,4,5),2
    a=rng.normal(size=ash);b=rng.normal(size=bsh)
    if 'complex' in dt:a=a+1j*rng.normal(size=ash);b=b+1j*rng.normal(size=bsh)
    if np.issubdtype(np.dtype(dt),np.integer):a=np.rint(a*2).astype(dt);b=np.rint(b*2).astype(dt)
    else:a=a.astype(dt);b=b.astype(dt)
    R=np.linalg.tensordot(a,b,axes=nax)
    emit_result(f'np.linalg.tensordot({arr(a)},{arr(b)},{nax})',R,f'tensordot count {case}',tol(R.dtype,30))
for case in range(20):
    a=rng.normal(size=(2,3,4));b=rng.normal(size=(4,5,3));axes=([1,2],[2,0]);R=np.linalg.tensordot(a,b,axes=axes)
    emit_result(f'np.linalg.tensordot({arr(a)},{arr(b)},{{{{2,3}},{{3,1}}}})',R,f'tensordot axes {case}',1e-9)
# default axes=2 from upstream public test.
x=np.arange(6).reshape(2,3);emit_result(f'np.linalg.tensordot({arr(x)},{arr(x)})',np.linalg.tensordot(x,x),'tensordot default',0)

# linalg.matmul alias and matrix_transpose.
for case in range(24):
    a=rng.normal(size=(2,3));b=rng.normal(size=(3,4));dt=('float32','float64','complex64','complex128')[case%4]
    if 'complex' in dt:a=a+1j*rng.normal(size=a.shape);b=b+1j*rng.normal(size=b.shape)
    a=a.astype(dt);b=b.astype(dt);R=np.linalg.matmul(a,b);emit_result(f'np.linalg.matmul({arr(a)},{arr(b)})',R,f'linalg matmul {case}',tol(R.dtype,20))
for case,shape in enumerate([(2,3),(4,2,3),(2,3,4,5)]*6):
    a=np.arange(np.prod(shape),dtype=np.int32).reshape(shape);R=np.linalg.matrix_transpose(a);emit_result(f'np.linalg.matrix_transpose({arr(a)})',R,f'matrix_transpose {case}',0)
lines += ['do local ok=pcall(function() np.linalg.matrix_transpose(np.arange(3)) end); assert(not ok,"matrix_transpose 1d") end'];count+=1

# matrix_norm exact wrapper over the last two axes, including empty matrices.
mords=['fro','nuc',1,-1,2,-2,np.inf,-np.inf]
for case in range(64):
    shape=(3,4) if case%2==0 else (2,3,4);dt=('float32','float64','complex64','complex128','int32')[case%5];a=rng.normal(size=shape)
    if 'complex' in dt:a=a+1j*rng.normal(size=shape)
    if np.issubdtype(np.dtype(dt),np.integer):a=np.rint(a*3).astype(dt)
    else:a=a.astype(dt)
    o=mords[case%len(mords)];keep=bool(case%3==0);R=np.linalg.matrix_norm(a,ord=o,keepdims=keep)
    olua=f'"{o}"' if isinstance(o,str) else ('math.huge' if o==np.inf else '-math.huge' if o==-np.inf else repr(o))
    emit_result(f'np.linalg.matrix_norm({arr(a)},{{ord={olua},keepdims={str(keep).lower()}}})',R,f'matrix_norm {case}',tol(R.dtype,80))
for shape in [(0,2),(2,0),(0,0)]:
    for o in ['fro','nuc',1,2,np.inf]:
        a=np.zeros(shape,dtype=np.float64);R=np.linalg.matrix_norm(a,ord=o);olua=f'"{o}"' if isinstance(o,str) else ('math.huge' if o==np.inf else repr(o));emit_result(f'np.linalg.matrix_norm({arr(a)},{{ord={olua}}})',R,f'matrix_norm empty {shape} {o}',1e-12)

# vector_norm: flatten default, individual axes, arbitrary axis tuples, keepdims.
vords=[0,1,2,3,-1,np.inf,-np.inf]
for case in range(72):
    shape=(2,3,4);dt=('float32','float64','complex64','complex128','int32')[case%5];a=rng.normal(size=shape)
    if 'complex' in dt:a=a+1j*rng.normal(size=shape)
    if np.issubdtype(np.dtype(dt),np.integer):a=np.rint(a*2).astype(dt)
    else:a=a.astype(dt)
    o=vords[case%len(vords)];keep=bool(case%2)
    mode=case%4
    if mode==0: axis=None; opt=f'{{ord={"math.huge" if o==np.inf else "-math.huge" if o==-np.inf else repr(o)},keepdims={str(keep).lower()}}}'
    elif mode==1: axis=0; opt=f'{{ord={"math.huge" if o==np.inf else "-math.huge" if o==-np.inf else repr(o)},axis=1,keepdims={str(keep).lower()}}}'
    elif mode==2: axis=(0,2); opt=f'{{ord={"math.huge" if o==np.inf else "-math.huge" if o==-np.inf else repr(o)},axis={{1,3}},keepdims={str(keep).lower()}}}'
    else: axis=(2,0,1); opt=f'{{ord={"math.huge" if o==np.inf else "-math.huge" if o==-np.inf else repr(o)},axis={{3,1,2}},keepdims={str(keep).lower()}}}'
    R=np.linalg.vector_norm(a,axis=axis,ord=o,keepdims=keep);emit_result(f'np.linalg.vector_norm({arr(a)},{opt})',R,f'vector_norm {case}',tol(R.dtype,40))
# empty tuple means elementwise vector norm over a length-1 synthetic axis.
a=np.array([[3.,4.],[0.,-2.]]);R=np.linalg.vector_norm(a,axis=(),ord=2)
emit_result(f'np.linalg.vector_norm({arr(a)},{{axis={{}},ord=2}})',R,'vector_norm empty axis tuple',1e-12)
for dt in ('float64','float32','int32'):
    a=np.zeros(0,dtype=dt)
    for o in (1,2,np.inf):
        R=np.linalg.vector_norm(a,ord=o);olua='math.huge' if o==np.inf else repr(o);emit_result(f'np.linalg.vector_norm({arr(a)},{{ord={olua}}})',R,f'vector_norm empty {dt} {o}',1e-12)

# vecdot: real/complex conjugation, batch broadcasting and non-last axis.
for case in range(60):
    dt=('int32','float32','float64','complex64','complex128')[case%5]
    if case%3==0:ash=bsh=(4,)
    elif case%3==1:ash=bsh=(3,4)
    else:ash=(2,1,4);bsh=(1,3,4)
    a=rng.normal(size=ash);b=rng.normal(size=bsh)
    if 'complex' in dt:a=a+1j*rng.normal(size=ash);b=b+1j*rng.normal(size=bsh)
    if np.issubdtype(np.dtype(dt),np.integer):a=np.rint(a*2).astype(dt);b=np.rint(b*2).astype(dt)
    else:a=a.astype(dt);b=b.astype(dt)
    R=np.linalg.vecdot(a,b);emit_result(f'np.linalg.vecdot({arr(a)},{arr(b)})',R,f'vecdot {case}',tol(R.dtype,30))
for case in range(16):
    a=(rng.normal(size=(4,3))+1j*rng.normal(size=(4,3))).astype(np.complex128);b=(rng.normal(size=(4,3))+1j*rng.normal(size=(4,3))).astype(np.complex128);R=np.linalg.vecdot(a,b,axis=0)
    emit_result(f'np.linalg.vecdot({arr(a)},{arr(b)},{{axis=1}})',R,f'vecdot axis {case}',1e-9)

lines += [f'print("linalg surface differential: {count} cases ok")']
OUT.write_text('\n'.join(lines)+'\n')
print(count, OUT)
