#!/usr/bin/env python3
"""Development-only differential oracle for LuaRay complex dtype/core behavior."""
from pathlib import Path
import math, random, warnings
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'complex_differential_generated.lua'
rng=random.Random(0xC0A1E52026)
lines=[
"local np=require('luaray_core')",
r'''local function fclose(a,b,tol)
  tol=tol or 2e-5
  if a~=a and b~=b then return true end
  if a==b then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return false end
  return math.abs(a-b)<=tol*math.max(1,math.abs(a),math.abs(b))
end
local function close(a,b,tol)
  tol=tol or 2e-5
  if type(a)=='userdata' and a.real~=nil and a.imag~=nil then
    return type(b)=='userdata' and b.real~=nil and fclose(a.real,b.real,tol) and fclose(a.imag,b.imag,tol)
  end
  if type(a)~=type(b) then return false end
  if type(a)=='table' then
    if #a~=#b then return false end
    for i=1,#a do if not close(a[i],b[i],tol) then return false end end
    return true
  end
  if type(a)=='number' then return fclose(a,b,tol) end
  return a==b
end
local function exact(a,b)
  if type(a)=='userdata' and a.real~=nil and a.imag~=nil then
    return type(b)=='userdata' and b.real~=nil and ((a.real==b.real) or (a.real~=a.real and b.real~=b.real)) and ((a.imag==b.imag) or (a.imag~=a.imag and b.imag~=b.imag))
  end
  if type(a)~=type(b) then return false end
  if type(a)=='table' then if #a~=#b then return false end; for i=1,#a do if not exact(a[i],b[i]) then return false end end; return true end
  if type(a)=='number' and a~=a and b~=b then return true end
  return a==b
end''',
f"-- Generated against development NumPy {np.__version__}."
]

def f_atom(x):
    f=float(x)
    if math.isnan(f): return '(0/0)'
    if math.isinf(f): return 'math.huge' if f>0 else '-math.huge'
    if f==0 and math.copysign(1,f)<0: return '-0.0'
    return repr(f)
def atom(x):
    if isinstance(x,(bool,np.bool_)): return 'true' if bool(x) else 'false'
    if isinstance(x,(np.integer,int)): return str(int(x))
    if isinstance(x,(complex,np.complexfloating)):
        z=complex(x); return f"np.complex({f_atom(z.real)},{f_atom(z.imag)})"
    return f_atom(x)
def lt(x):
    if isinstance(x,np.ndarray): x=x.tolist()
    if isinstance(x,(list,tuple)): return '{'+','.join(lt(v) for v in x)+'}'
    return atom(x)
def expr(a): return f"np.array({lt(a.tolist())},np.{dtype_name(a.dtype)})"
def dtype_name(dt):
    d=np.dtype(dt).name
    if d in ('clongdouble','complex256'): return 'complex256'
    if d in ('longdouble','float128'): return 'longdouble'
    return d
def tol_for(dt): return 3e-5 if np.dtype(dt).itemsize<=8 else 2e-12

def randz(): return complex(rng.choice([-3,-2,-1,-0.0,0,0.25,1,2,4]),rng.choice([-3,-1,-0.0,0,0.5,1,3]))

count=0
# Constructors, inference and packing.
vals=[1+2j,-3+0.5j,complex(-0.0,0.0),complex(0,-0.0),4-5j]
for dt in [np.complex64,np.complex128,np.clongdouble]:
    e=np.array(vals,dtype=dt)
    lines += ["do",f" local a=np.array({lt(vals)},np.{dtype_name(dt)})",f" assert(a.dtype=='{dtype_name(dt)}','complex ctor dtype {count}')",f" assert(close(a:tolist(),{lt(e.tolist())},{tol_for(dt)}),'complex ctor {count}')","end"]
    count+=1
lines += ["do local a=np.array({np.complex(1,2),3}); assert(a.dtype=='complex128','complex inference'); assert(close(a:tolist(),{np.complex(1,2),np.complex(3,0)}),'complex inference values') end"]
count+=1
# Explicit complex target accepts real sources.
for src in ['bool','int8','uint16','int64','float16','float32','float64']:
    v=np.array([0,1,-2 if not src.startswith('uint') and src!='bool' else 2,3],dtype=src)
    for dst in [np.complex64,np.complex128]:
        e=v.astype(dst)
        lines += [f"do local a=np.array({lt(v.tolist())},np.{dtype_name(dst)}); assert(close(a:tolist(),{lt(e.tolist())},{tol_for(dst)}),'real->complex {count}') end"]
        count+=1
# Direct complex -> real constructor must reject.
lines += ["do local ok=pcall(function() np.array({np.complex(1,2)},np.float64) end); assert(not ok,'complex->real constructor must reject') end"]
count+=1

# Binary arithmetic/comparison/logical/minmax across complex64/128 and real mixes.
binops=[('add',np.add),('subtract',np.subtract),('multiply',np.multiply),('true_divide',np.true_divide),
        ('equal',np.equal),('not_equal',np.not_equal),('less',np.less),('less_equal',np.less_equal),('greater',np.greater),('greater_equal',np.greater_equal),
        ('logical_and',np.logical_and),('logical_or',np.logical_or),('logical_xor',np.logical_xor),
        ('maximum',np.maximum),('minimum',np.minimum),('fmax',np.fmax),('fmin',np.fmin)]
mix=['float16','float32','float64','complex64','complex128']
for opname,fn in binops:
    for case in range(24):
        adt=rng.choice(['complex64','complex128']); bdt=rng.choice(mix)
        av=np.array([randz() for _ in range(6)],dtype=adt)
        if bdt.startswith('complex'): bv=np.array([randz() for _ in range(6)],dtype=bdt)
        else: bv=np.array([rng.choice([-3,-1,-0.0,0,0.5,1,2,4]) for _ in range(6)],dtype=bdt)
        if opname=='true_divide':
            if np.issubdtype(bv.dtype,np.complexfloating): bv=np.where(bv==0,np.array(1+0j,dtype=bv.dtype),bv)
            else: bv=np.where(bv==0,np.array(1,dtype=bv.dtype),bv)
        with warnings.catch_warnings(),np.errstate(all='ignore'):
            warnings.simplefilter('ignore'); e=fn(av,bv)
        cmp='exact' if e.dtype==np.bool_ else 'close'
        tail='' if cmp=='exact' else f",{tol_for(e.dtype)}"
        lines += [f"do -- {opname} {count}",f" local a={expr(av)}",f" local b={expr(bv)}",f" local r=np.{opname}(a,b)",f" assert(r.dtype=='{dtype_name(e.dtype)}','complex {opname} dtype {count} '..r.dtype)",f" assert({cmp}(r:tolist(),{lt(e.tolist())}{tail}),'complex {opname} values {count}')","end"]
        count+=1

# Weak host-complex scalar resolution and both operand orders.
for dt in ['bool','int8','int32','int64','float16','float32','float64','longdouble','complex64','complex128','complex256']:
    npdt = np.clongdouble if dt=='complex256' else (np.longdouble if dt=='longdouble' else np.dtype(dt))
    base=np.array([1,2,-3 if dt not in ('bool',) else 1],dtype=npdt)
    z=1.25-2j
    for left in [False,True]:
        with np.errstate(all='ignore'):
            e=np.add(z,base) if left else np.add(base,z)
        call="np.add(np.complex(1.25,-2),a)" if left else "np.add(a,np.complex(1.25,-2))"
        lines += [f"do local a={expr(base)}; local r={call}; assert(r.dtype=='{dtype_name(e.dtype)}','weak complex dtype {count} '..r.dtype); assert(close(r:tolist(),{lt(e.tolist())},{tol_for(e.dtype)}),'weak complex {count}') end"]
        count+=1

# out/where for complex loops and bool-output loops.
for opname,fn in [('add',np.add),('multiply',np.multiply),('maximum',np.maximum),('equal',np.equal)]:
    av=np.array([1+2j,2-1j,-3+0.5j,4+0j],dtype=np.complex64)
    bv=np.array([2-1j,-1+3j,1+0j,0.5-2j],dtype=np.complex64)
    mask=np.array([True,False,True,False])
    outdt=np.bool_ if opname=='equal' else np.complex64
    out=np.full(4,True if opname=='equal' else 7+8j,dtype=outdt)
    with np.errstate(all='ignore'): fn(av,bv,out=out,where=mask)
    init='np.ones({4},np.bool)' if opname=='equal' else 'np.ones({4},np.complex64)*np.complex(7,8)'
    cmp='exact' if opname=='equal' else 'close'
    tail='' if cmp=='exact' else ',3e-5'
    lines += ["do",f" local a={expr(av)}",f" local b={expr(bv)}"," local m=np.array({true,false,true,false},np.bool)",f" local o={init}",f" local r=np.{opname}(a,b,{{out=o,where=m}})"," assert(r==o,'complex out identity')",f" assert({cmp}(o:tolist(),{lt(out.tolist())}{tail}),'complex outwhere {opname}')","end"]
    count+=1

# Unary operations/predicates.
uv=np.array([1+2j,-3+4j,-0.0+0j,0-0.0j,complex(np.inf,1),complex(1,np.inf),complex(np.nan,2)],dtype=np.complex128)
for opname,fn in [('negative',np.negative),('absolute',np.absolute),('positive',np.positive),('sign',np.sign),('logical_not',np.logical_not),('isnan',np.isnan),('isinf',np.isinf),('isfinite',np.isfinite)]:
    with np.errstate(all='ignore'): e=fn(uv)
    cmp='exact' if e.dtype==np.bool_ else 'close'; tail='' if cmp=='exact' else ',2e-12'
    lines += [f"do local a={expr(uv)}; local r=np.{opname}(a); assert(r.dtype=='{dtype_name(e.dtype)}','complex unary dtype {opname}'); assert({cmp}(r:tolist(),{lt(e.tolist())}{tail}),'complex unary {opname}') end"]
    count+=1
lines += ["do local a=np.array({np.complex(1,2)},np.complex128); local ok=pcall(function() np.signbit(a) end); assert(not ok,'signbit complex reject') end"]
count+=1

# Reductions and accumulates.
for case in range(70):
    shape=rng.choice([(7,),(2,5),(2,3,4)]); dt=rng.choice([np.complex64,np.complex128])
    av=np.array([randz() for _ in range(math.prod(shape))],dtype=dt).reshape(shape)
    axis=rng.randrange(len(shape))
    for opname,fn in [('sum',np.sum),('prod',np.prod),('mean',np.mean)]:
        with np.errstate(all='ignore'): e=fn(av,axis=axis)
        call=f"np.{opname}(a,{axis+1})"
        if np.ndim(e)==0:
            lines += [f"do local a={expr(av)}; local r={call}; assert(close(r,{atom(e.item())},{tol_for(e.dtype)}),'complex reduce scalar {count}') end"]
        else:
            lines += [f"do local a={expr(av)}; local r={call}; assert(r.dtype=='{dtype_name(e.dtype)}','complex reduce dtype {count}'); assert(close(r:tolist(),{lt(e.tolist())},{tol_for(e.dtype)}),'complex reduce {count}') end"]
        count+=1
for op,fn,lname in [('add',np.add,'add_accumulate'),('multiply',np.multiply,'multiply_accumulate')]:
    for case in range(25):
        av=np.array([randz() for _ in range(8)],dtype=rng.choice([np.complex64,np.complex128])); e=fn.accumulate(av)
        lines += [f"do local a={expr(av)}; local r=np.{lname}(a); assert(r.dtype=='{dtype_name(e.dtype)}' and close(r:tolist(),{lt(e.tolist())},{tol_for(e.dtype)}),'complex accumulate {count}') end"]
        count+=1

# Matmul/dot/inner/outer, small exact-ish values to avoid BLAS-vs-baseline noise.
for case in range(55):
    dt=rng.choice([np.complex64,np.complex128]); m,n,p=[rng.randint(1,4) for _ in range(3)]
    a=np.array([complex(rng.randint(-2,2),rng.randint(-2,2)) for _ in range(m*n)],dtype=dt).reshape(m,n)
    b=np.array([complex(rng.randint(-2,2),rng.randint(-2,2)) for _ in range(n*p)],dtype=dt).reshape(n,p)
    e=np.matmul(a,b)
    lines += [f"do local a={expr(a)}; local b={expr(b)}; local r=np.matmul(a,b); assert(r.dtype=='{dtype_name(e.dtype)}' and close(r:tolist(),{lt(e.tolist())},{tol_for(e.dtype)}),'complex matmul {count}') end"]
    count+=1
for case in range(35):
    dt=rng.choice([np.complex64,np.complex128]); n=rng.randint(1,12)
    a=np.array([complex(rng.randint(-2,2),rng.randint(-2,2)) for _ in range(n)],dtype=dt)
    b=np.array([complex(rng.randint(-2,2),rng.randint(-2,2)) for _ in range(n)],dtype=dt)
    e=np.dot(a,b)
    lines += [f"do local a={expr(a)}; local b={expr(b)}; local r=np.dot(a,b); assert(close(r,{atom(e.item())},{tol_for(e.dtype)}),'complex dot {count}') end"]
    count+=1
for case in range(20):
    dt=rng.choice([np.complex64,np.complex128]); a=np.array([randz() for _ in range(6)],dtype=dt).reshape(2,3); b=np.array([randz() for _ in range(12)],dtype=dt).reshape(4,3)
    e=np.inner(a,b)
    lines += [f"do local a={expr(a)}; local b={expr(b)}; local r=np.inner(a,b); assert(close(r:tolist(),{lt(e.tolist())},{tol_for(e.dtype)}),'complex inner {count}') end"]
    count+=1
for case in range(15):
    dt=rng.choice([np.complex64,np.complex128]); a=np.array([randz() for _ in range(4)],dtype=dt); b=np.array([randz() for _ in range(3)],dtype=dt); e=np.outer(a,b)
    lines += [f"do local a={expr(a)}; local b={expr(b)}; local r=np.outer(a,b); assert(close(r:tolist(),{lt(e.tolist())},{tol_for(e.dtype)}),'complex outer {count}') end"]
    count+=1

# Sorting/argsort/partition/searchsorted complex total order.
for case in range(45):
    dt=rng.choice([np.complex64,np.complex128])
    # Mostly unique lexicographic values; optional single NaN to exercise total order.
    vals=[complex(i-5, ((i*7)%11)-5) for i in range(11)]; rng.shuffle(vals)
    if case%5==0: vals[3]=complex(np.nan,2)
    av=np.array(vals,dtype=dt); e=np.sort(av); idx=np.argsort(av)+1
    lines += [f"do local a={expr(av)}; local r=np.sort(a); assert(close(r:tolist(),{lt(e.tolist())},{tol_for(e.dtype)}),'complex sort {count}'); local q=np.argsort(a); assert(exact(q:tolist(),{lt(idx.tolist())}),'complex argsort {count}') end"]
    count+=1
for case in range(35):
    dt=rng.choice([np.complex64,np.complex128]); vals=[complex(i-5,((i*3)%7)-3) for i in range(12)]; av=np.sort(np.array(vals,dtype=dt)); keys=np.array([complex(-6,0),complex(-1,2),complex(0,0),complex(4,5),complex(7,0)],dtype=dt); side=rng.choice(['left','right']); e=np.searchsorted(av,keys,side=side)+1
    lines += [f"do local a={expr(av)}; local k={expr(keys)}; local r=np.searchsorted(a,k,'{side}'); assert(exact(r:tolist(),{lt(e.tolist())}),'complex searchsorted {count}') end"]
    count+=1

# Basic/advanced assignment and view preservation.
lines += [r'''do
 local a=np.array({np.complex(1,1),np.complex(2,2),np.complex(3,3),np.complex(4,4)},np.complex64)
 a[np.slice(2,5,2)]=np.complex(9,-1)
 assert(close(a:tolist(),{np.complex(1,1),np.complex(9,-1),np.complex(3,3),np.complex(9,-1)},3e-5),'complex slice assignment')
 local idx=np.array({4,1,4},np.int64)
 a[idx]=np.complex(-2,5)
 assert(close(a:tolist(),{np.complex(-2,5),np.complex(9,-1),np.complex(3,3),np.complex(-2,5)},3e-5),'complex fancy assignment')
end''']
count+=2

lines.append(f"print('complex differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
