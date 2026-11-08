#!/usr/bin/env python3
"""Development oracle for LuaRay's generic 1->2 / 2->2 ufunc engine.

The loop signatures are pinned from NumPy main generate_umath.py and the scalar
kernels from loops.c.src / loops_modulo.dispatch.c.src.  Python NumPy is used
only to materialize values/dtypes for differential cases.
"""
from pathlib import Path
import math, random, warnings
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'multiout_ufunc_differential_generated.lua'
rng=random.Random(0x20F00D)
lines=["local np=require('luaray_core')",r'''
local function fsame(a,b,tol)
  if a~=a and b~=b then return true end
  if a==b then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return false end
  return math.abs(a-b)<=tol*math.max(1,math.abs(a),math.abs(b))
end
local function list_same(a,b,tol)
  if #a~=#b then return false end
  for i=1,#a do if not fsame(a[i],b[i],tol) then return false end end
  return true
end
local function bool_list_same(a,b)
  if #a~=#b then return false end
  for i=1,#a do if a[i]~=b[i] then return false end end
  return true
end
local function zero_sign_same(arr,expected,signs)
  local got=arr:tolist(); local gs=np.signbit(arr):tolist()
  for i=1,#got do
    if expected[i]==0 and gs[i]~=signs[i] then return false end
  end
  return true
end''',f"-- Development oracle NumPy {np.__version__}; source signatures pinned to uploaded NumPy main."]

def fatom(x):
    if isinstance(x,(bool,np.bool_)): return 'true' if bool(x) else 'false'
    if isinstance(x,(np.integer,int)): return str(int(x))
    x=float(x)
    if math.isnan(x): return '(0/0)'
    if math.isinf(x): return 'math.huge' if x>0 else '-math.huge'
    if x==0 and math.copysign(1,x)<0: return '-0.0'
    return repr(x)

def table(vals): return '{'+','.join(fatom(x) for x in vals)+'}'
def btable(vals): return '{'+','.join('true' if bool(x) else 'false' for x in vals)+'}'
def dname(dt):
    n=np.dtype(dt).name
    if n in ('longdouble','float128'): return 'longdouble'
    return n
def tol(dt):
    dt=np.dtype(dt)
    if dt==np.dtype('float16'): return 4e-3
    if dt==np.dtype('float32'): return 5e-6
    return 5e-12

def zero_signs(a):
    a=np.asarray(a)
    return np.signbit(a).ravel().tolist()

count=0
real_dtypes=[np.bool_,np.int8,np.uint8,np.int16,np.uint16,np.int32,np.uint32,np.int64,np.uint64,
             np.float16,np.float32,np.float64,np.longdouble]

# frexp/modf dtype resolution + values, including upstream Linux NAN/INF behavior.
base=[-math.inf,-8.0,-2.5,-1.0,-0.0,0.0,0.125,0.75,1.0,5.7,math.inf,math.nan]
for dt in real_dtypes:
    kind=np.dtype(dt).kind
    if kind=='b': vals=[False,True]
    elif kind=='u': vals=[0,1,2,5,17,127]
    elif kind=='i': vals=[-127,-17,-2,-1,0,1,2,17,127]
    else: vals=base
    a=np.array(vals,dtype=dt)
    with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore')
        mant,exp=np.frexp(a); frac,integ=np.modf(a)
    lines += ["do",f" local a=np.array({table(a.tolist())},np.{dname(dt)})",
              " local m,e=np.frexp(a)",
              f" assert(m.dtype=='{dname(mant.dtype)}' and e.dtype=='{dname(exp.dtype)}','frexp dtype {count}')",
              f" assert(list_same(m:tolist(),{table(mant.tolist())},{tol(mant.dtype)}),'frexp mant {count}')",
              f" assert(list_same(e:tolist(),{table(exp.tolist())},0),'frexp exp {count}')",
              f" assert(zero_sign_same(m,{table(mant.tolist())},{btable(zero_signs(mant))}),'frexp signs {count}')",
              " local f,i=np.modf(a)",
              f" assert(f.dtype=='{dname(frac.dtype)}' and i.dtype=='{dname(integ.dtype)}','modf dtype {count}')",
              f" assert(list_same(f:tolist(),{table(frac.tolist())},{tol(frac.dtype)}),'modf frac {count}')",
              f" assert(list_same(i:tolist(),{table(integ.tolist())},{tol(integ.dtype)}),'modf int {count}')",
              f" assert(zero_sign_same(f,{table(frac.tolist())},{btable(zero_signs(frac))}),'modf frac signs {count}')",
              f" assert(zero_sign_same(i,{table(integ.tolist())},{btable(zero_signs(integ))}),'modf int signs {count}')","end"]
    count+=2

# divmod promotion and NumPy floor/remainder convention across representative dtype pairs.
div_dtypes=[np.bool_,np.int8,np.uint8,np.int16,np.uint16,np.int32,np.uint32,np.int64,np.uint64,
            np.float16,np.float32,np.float64,np.longdouble]
for d1 in div_dtypes:
  for d2 in div_dtypes:
    k1=np.dtype(d1).kind; k2=np.dtype(d2).kind
    av=[0,1,5,17] if k1 in 'bu' else [-17,-5,-1,0,1,5,17]
    bv=[1,2,7] if k2 in 'bu' else [-7,-2,-1,1,2,7]
    aa=np.array([rng.choice(av) for _ in range(7)],dtype=d1)
    bb=np.array([rng.choice(bv) for _ in range(7)],dtype=d2)
    with warnings.catch_warnings(),np.errstate(all='ignore'):
      warnings.simplefilter('ignore'); q,r=np.divmod(aa,bb)
    lines += ["do",f" local a=np.array({table(aa.tolist())},np.{dname(d1)})",f" local b=np.array({table(bb.tolist())},np.{dname(d2)})",
              " local q,r=np.divmod(a,b)",f" assert(q.dtype=='{dname(q.dtype)}' and r.dtype=='{dname(r.dtype)}','divmod dtype {count}')",
              f" assert(list_same(q:tolist(),{table(q.tolist())},{tol(q.dtype) if q.dtype.kind=='f' else 0}),'divmod q {count}')",
              f" assert(list_same(r:tolist(),{table(r.tolist())},{tol(r.dtype) if r.dtype.kind=='f' else 0}),'divmod r {count}')",
              f" assert(zero_sign_same(q,{table(q.tolist())},{btable(zero_signs(q))}),'divmod q signs {count}')",
              f" assert(zero_sign_same(r,{table(r.tolist())},{btable(zero_signs(r))}),'divmod r signs {count}')","end"]
    count+=1


# ldexp is a 2->1 heterogeneous-signature ufunc in the same new engine.
exp_dtypes=[np.bool_,np.int8,np.uint8,np.int16,np.uint16,np.int32,np.uint32,np.int64,np.uint64]
for dx in real_dtypes:
  if np.dtype(dx).kind == 'b': xv=[False,True]
  elif np.dtype(dx).kind == 'u': xv=[0,1,2,5]
  elif np.dtype(dx).kind == 'i': xv=[-5,-1,0,1,5]
  else: xv=[-1.5,-0.5,-0.0,0.0,0.5,1.5]
  for de in exp_dtypes:
    ev=[0,1,2,3] if np.dtype(de).kind in 'bu' else [-3,-1,0,1,3]
    n=min(len(xv),len(ev)); aa=np.array(xv[:n],dtype=dx); ee=np.array(ev[:n],dtype=de)
    try:
      with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore'); rr=np.ldexp(aa,ee)
    except TypeError:
      lines += ["do",f" local a=np.array({table(aa.tolist())},np.{dname(dx)})",f" local e=np.array({table(ee.tolist())},np.{dname(de)})",
                f" assert(not pcall(function() np.ldexp(a,e) end),'ldexp reject {count}')","end"]
    else:
      lines += ["do",f" local a=np.array({table(aa.tolist())},np.{dname(dx)})",f" local e=np.array({table(ee.tolist())},np.{dname(de)})",
                " local r=np.ldexp(a,e)",f" assert(r.dtype=='{dname(rr.dtype)}','ldexp dtype {count}')",
                f" assert(list_same(r:tolist(),{table(rr.tolist())},{tol(rr.dtype)}),'ldexp values {count}')","end"]
    count+=1

# Scalar exponent and masked out= exercise the 2->1 path without LN_OP_*.
aa=np.array([0.5,-0.5,1.0,2.0],dtype=np.float32)
rr=np.ldexp(aa,2)
lines += ["do",f" local a=np.array({table(aa.tolist())},np.float32)"," local r=np.ldexp(a,2)",
          f" assert(r.dtype=='float32' and list_same(r:tolist(),{table(rr.tolist())},1e-6),'ldexp scalar {count}')","end"]
count+=1
mask2=np.array([True,False,True,False]); ex=np.array([1,2,-1,4],dtype=np.int64); oo=np.array([9.,8.,7.,6.],dtype=np.float64)
np.ldexp(aa,ex,out=oo,where=mask2)
lines += ["do",f" local a=np.array({table(aa.tolist())},np.float32)",f" local e=np.array({table(ex.tolist())},np.int64)",f" local m=np.array({btable(mask2.tolist())},np.bool)",
          " local o=np.array({9,8,7,6},np.float64); local r=np.ldexp(a,e,{out=o,where=m})"," assert(r==o,'ldexp out identity')",
          f" assert(list_same(o:tolist(),{table(oo.tolist())},1e-6),'ldexp out where {count}')","end"]
count+=1

# Broadcasting 2->2.
a=np.array([[71.0],[-71.0]],dtype=np.float32)
b=np.array([[19.0,-19.0,6.0]],dtype=np.float64)
q,r=np.divmod(a,b)
for row in range(2):
    lines += ["do",f" local a=np.array({{{{71.0}},{{-71.0}}}},np.float32)",f" local b=np.array({{{{19.0,-19.0,6.0}}}},np.float64)",
              " local q,r=np.divmod(a,b)",f" assert(q.dtype=='float64' and r.dtype=='float64','broadcast dtype {count}')",
              f" assert(list_same(q:tolist()[{row+1}],{table(q.tolist()[row])},1e-12),'broadcast q {count}')",
              f" assert(list_same(r:tolist()[{row+1}],{table(r.tolist()[row])},1e-12),'broadcast r {count}')","end"]
    count+=1

# Strided negative input from upstream frexp tests.
arr=np.array([np.nan,np.nan,np.inf,-np.inf,0.0,-0.0,1.0,-1.0],dtype=np.float64)
for step in [-4,-2,-1,1,2,4]:
    v=arr[::step]; m,e=np.frexp(v); f,i=np.modf(v)
    # Lua negative slices are applied to the original array via np.slice.
    start='nil'; stop='nil'
    lines += ["do",f" local base=np.array({table(arr.tolist())},np.float64)",f" local a=base[np.slice({start},{stop},{step})]",
              " local m,e=np.frexp(a)",f" assert(list_same(m:tolist(),{table(m.tolist())},1e-12),'strided frexp m {count}')",
              f" assert(list_same(e:tolist(),{table(e.tolist())},0),'strided frexp e {count}')",
              " local f,i=np.modf(a)",f" assert(list_same(f:tolist(),{table(f.tolist())},1e-12),'strided modf f {count}')",
              f" assert(list_same(i:tolist(),{table(i.tolist())},1e-12),'strided modf i {count}')","end"]
    count+=1

# out=, partial out, dtype casting, where preservation, and noncontiguous outputs.
a=np.array([5.7,-2.5,0.0,-0.0],dtype=np.float32)
mask=np.array([True,False,True,False])
# frexp both provided, exponent cast to int64
om=np.array([9.,8.,7.,6.],dtype=np.float64); oe=np.array([9,8,7,6],dtype=np.int64)
np.frexp(a,out=(om,oe),where=mask)
lines += ["do",f" local a=np.array({table(a.tolist())},np.float32)",f" local m=np.array({btable(mask.tolist())},np.bool)",
          " local o1=np.array({9,8,7,6},np.float64); local o2=np.array({9,8,7,6},np.int64)",
          " local r1,r2=np.frexp(a,{out={o1,o2},where=m})"," assert(r1==o1 and r2==o2,'frexp out identity')",
          f" assert(list_same(o1:tolist(),{table(om.tolist())},1e-6),'frexp out mant')",f" assert(list_same(o2:tolist(),{table(oe.tolist())},0),'frexp out exp')","end"]
count+=1
# partial output: second allocated
of=np.array([3.,3.,3.,3.],dtype=np.float64); expected_f=np.array(of,copy=True); expected_i=np.empty(4,dtype=np.float32)
expected_f, expected_i=np.modf(a,out=(expected_f,None))
lines += ["do",f" local a=np.array({table(a.tolist())},np.float32)"," local o=np.array({3,3,3,3},np.float64)",
          " local f,i=np.modf(a,{out={[1]=o}})"," assert(f==o and i.dtype=='float32','modf partial out')",
          f" assert(list_same(f:tolist(),{table(expected_f.tolist())},1e-6),'modf partial first')",f" assert(list_same(i:tolist(),{table(expected_i.tolist())},1e-6),'modf partial second')","end"]
count+=1
# divmod partial first allocated, second provided + where
x=np.array([71.,-71.,5.,1.],dtype=np.float32); y=np.array([19.,19.,-2.,2.],dtype=np.float32)
or_=np.array([99.,98.,97.,96.],dtype=np.float64)
q,r=np.divmod(x,y,out=(None,or_),where=mask)
lines += ["do",f" local a=np.array({table(x.tolist())},np.float32)",f" local b=np.array({table(y.tolist())},np.float32)",f" local m=np.array({btable(mask.tolist())},np.bool)",
          " local o=np.array({99,98,97,96},np.float64)"," local q,r=np.divmod(a,b,{out={[2]=o},where=m})"," assert(r==o and q.dtype=='float32','divmod partial out')",
          f" assert(list_same(r:tolist(),{table(r.tolist())},1e-6),'divmod partial rem')","end"]
count+=1

# Invalid complex loops and invalid output cast.
lines += [r'''do
 local z=np.array({np.complex(1,2)},np.complex128)
 assert(not pcall(function() np.frexp(z) end),'complex frexp must reject')
 assert(not pcall(function() np.modf(z) end),'complex modf must reject')
 assert(not pcall(function() np.divmod(z,z) end),'complex divmod must reject')
 local a=np.array({1.5},np.float64)
 local oi=np.zeros({1},np.int32)
 assert(not pcall(function() np.modf(a,{out={oi,oi}}) end),'unsafe output cast must reject')
end''']
count+=4

lines.append(f"print('generic multi-output ufunc differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
