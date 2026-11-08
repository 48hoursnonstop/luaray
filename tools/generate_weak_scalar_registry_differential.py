#!/usr/bin/env python3
"""Differential tests for Lua weak scalars resolved by the generic ufunc engine.

The uploaded NumPy main tree is the source of truth.  Installed NumPy is used
only to materialize expected values for behavior shared by that tree.  The
cases deliberately mirror NEP 50 scalar/array promotion paths from
numpy/_core/tests/test_nep50_promotions.py.
"""
from pathlib import Path
import math, warnings
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'weak_scalar_registry_differential_generated.lua'
lines=["local np=require('luaray_core')",r'''
local function fsame(a,b,tol)
  if type(a)=='userdata' or type(b)=='userdata' then
    if type(a)~='userdata' or type(b)~='userdata' then return false end
    return fsame(a.real,b.real,tol) and fsame(a.imag,b.imag,tol)
  end
  if a~=a and b~=b then return true end
  if a==b then return true end
  if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return false end
  return math.abs(a-b)<=tol*math.max(1,math.abs(a),math.abs(b))
end
local function same(a,b,tol)
  if type(a)~='table' or type(b)~='table' then return fsame(a,b,tol) end
  if #a~=#b then return false end
  for i=1,#a do if not same(a[i],b[i],tol) then return false end end
  return true
end
''',f"-- Development oracle NumPy {np.__version__}; semantics pinned to uploaded NumPy main."]

def atom(x):
    if isinstance(x,(bool,np.bool_)): return 'true' if bool(x) else 'false'
    if isinstance(x,(complex,np.complexfloating)):
        return f"np.complex({atom(float(np.real(x)))},{atom(float(np.imag(x)))})"
    if isinstance(x,(np.integer,int)): return str(int(x))
    x=float(x)
    if math.isnan(x): return '(0/0)'
    if math.isinf(x): return 'math.huge' if x>0 else '-math.huge'
    if x==0 and math.copysign(1,x)<0:return '-0.0'
    return repr(x)

def table_obj(x):
    if isinstance(x,np.ndarray):x=x.tolist()
    if isinstance(x,(list,tuple)):return '{'+','.join(table_obj(v) for v in x)+'}'
    return atom(x)

def dname(dt):
    n=np.dtype(dt).name
    if n in ('float128','longdouble'):return 'longdouble'
    if n in ('complex256','clongdouble'):return 'complex256'
    return n

def tol(dt):
    dt=np.dtype(dt)
    if dt.kind in 'biu':return 0.0
    if dt==np.dtype('float16'):return 6e-3
    if dt in (np.dtype('float32'),np.dtype('complex64')):return 1e-5
    return 3e-12

def arrvals(dt, opname):
    dt=np.dtype(dt);k=dt.kind
    if k=='b': vals=[False,True,True,False]
    elif k=='u': vals=[0,1,5,17]
    elif k=='i': vals=[-7,-1,2,11]
    elif k=='f': vals=[-2.5,-0.0,1.25,7.0]
    elif k=='c': vals=[-2.5+1j,-0.0-2j,1.25+.5j,7-3j]
    else: raise AssertionError(dt)
    # keep bases tame for integer power
    if opname=='power' and k in 'biu': vals=[0,1,2,3]
    return np.array(vals,dtype=dt)

ops=['add','subtract','multiply','true_divide','equal','not_equal','less','less_equal','greater','greater_equal',
     'logical_and','logical_or','logical_xor','maximum','minimum','floor_divide','remainder','power',
     'bitwise_and','bitwise_or','bitwise_xor','fmax','fmin','copysign','arctan2','hypot']
# Each tuple is (array dtype, weak host scalar).  These target NEP-50 category
# interactions rather than doing a redundant Cartesian product.
scalar_cases=[
    (np.bool_, True),(np.bool_, 2),
    (np.int8, 2),(np.int8, -3),(np.uint8, 2),(np.uint8, 300),(np.uint8,-1),
    (np.int16, 127),(np.int64, 5),(np.uint64, 5),(np.uint64,-1),
    (np.float16, 2),(np.float16, 2.0),(np.float32, 2),(np.float32,2.0),(np.float32,2j),
    (np.float64, 2.0),(np.complex64,2),(np.complex64,2.0),(np.complex64,1+2j),
]

count=0
for opname in ops:
    f=getattr(np,opname)
    for dt,scalar in scalar_cases:
        a=arrvals(dt,opname)
        # avoid zero denominator in division families when scalar is divisor
        right_scalar=scalar
        if opname in ('true_divide','floor_divide','remainder') and right_scalar in (0,0.0,0j,False): right_scalar=2
        # For each side.  Comparisons/noncommutative arithmetic need both.
        for left in (False,True):
            args=(right_scalar,a) if left else (a,right_scalar)
            try:
                with warnings.catch_warnings(),np.errstate(all='ignore'):
                    warnings.simplefilter('ignore'); r=f(*args)
            except Exception:
                lines += ["do",f" local a=np.array({table_obj(a)},np.{dname(dt)})",
                          f" local ok=pcall(function() return np.{opname}({atom(right_scalar) if left else 'a'},{'a' if left else atom(right_scalar)}) end)",
                          f" assert(not ok,'weak reject {opname} {count}')","end"]
                count+=1;continue
            lines += ["do",f" local a=np.array({table_obj(a)},np.{dname(dt)})",
                      f" local r=np.{opname}({atom(right_scalar) if left else 'a'},{'a' if left else atom(right_scalar)})",
                      f" assert(r.dtype=='{dname(r.dtype)}','weak dtype {opname} {count} '..r.dtype)",
                      f" assert(same(r:tolist(),{table_obj(r)},{tol(r.dtype)}),'weak values {opname} {count}')","end"]
            count+=1

# Explicit upstream NEP-50 edge cases where value-based fitting matters.
explicit=[
    ('add',np.uint8,[1,2],2,False),
    ('add',np.uint8,[1,2],300,True),
    ('add',np.uint8,[1,2],-1,True),
    ('equal',np.uint8,[1,2],300,False),
    ('less',np.uint8,[1,2],300,False),
    ('greater',np.uint64,[0,2**63],-1,False),
    ('add',np.float32,[1.0],3e100,False),
    ('add',np.float32,[1.0],1+2j,False),
]
for opname,dt,vals,scalar,expect_error in explicit:
    a=np.array(vals,dtype=dt);f=getattr(np,opname)
    if expect_error:
        lines += ["do",f" local a=np.array({table_obj(a)},np.{dname(dt)})",
                  f" assert(not pcall(function() return np.{opname}(a,{atom(scalar)}) end),'explicit reject {count}')","end"]
    else:
        with warnings.catch_warnings(),np.errstate(all='ignore'):
            warnings.simplefilter('ignore');r=f(a,scalar)
        lines += ["do",f" local a=np.array({table_obj(a)},np.{dname(dt)})",f" local r=np.{opname}(a,{atom(scalar)})",
                  f" assert(r.dtype=='{dname(r.dtype)}','explicit dtype {count}')",
                  f" assert(same(r:tolist(),{table_obj(r)},{tol(r.dtype)}),'explicit values {count}')","end"]
    count+=1

# where/out must work identically for weak scalars; only active elements are written.
mask=np.array([True,False,True,False])
for opname,dt,scalar in [('add',np.float32,2.0),('maximum',np.float32,2.0),('equal',np.int16,2),
                         ('floor_divide',np.int16,2),('power',np.int16,2),('bitwise_xor',np.int16,3),
                         ('copysign',np.float32,-1.0)]:
    a=arrvals(dt,opname);f=getattr(np,opname)
    with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore');base=f(a,scalar)
    odt=np.bool_ if base.dtype.kind=='b' else np.float64 if base.dtype.kind in 'fc' else base.dtype
    if np.dtype(odt).kind=='b': o0=np.array([True,False,False,True],dtype=odt)
    else:o0=np.array([90,80,70,60],dtype=odt)
    o=o0.copy()
    with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore');f(a,scalar,out=o,where=mask)
    lines += ["do",f" local a=np.array({table_obj(a)},np.{dname(dt)})",f" local m=np.array({table_obj(mask)},np.bool)",
              f" local o=np.array({table_obj(o0)},np.{dname(odt)})",f" local r=np.{opname}(a,{atom(scalar)},{{out=o,where=m}})",
              " assert(r==o,'weak out identity')",f" assert(same(o:tolist(),{table_obj(o)},{tol(o.dtype)}),'weak out values {count}')","end"]
    count+=1

# Operator paths must use the same weak resolver for registered operators.
operator_cases=[
    ('+','add',np.uint8,[1,2],2),('-','subtract',np.int16,[2,5],1),('*','multiply',np.float32,[1,2],2.0),
    ('/','true_divide',np.float32,[1,2],2.0),('//','floor_divide',np.int16,[5,7],2),('%','remainder',np.int16,[5,7],2),
    ('^','power',np.int16,[2,3],2),('&','bitwise_and',np.int16,[3,7],1),('|','bitwise_or',np.int16,[2,4],1),
    ('~','bitwise_xor',np.int16,[2,4],1),
]
for symbol,opname,dt,vals,scalar in operator_cases:
    a=np.array(vals,dtype=dt);r=getattr(np,opname)(a,scalar)
    lines += ["do",f" local a=np.array({table_obj(a)},np.{dname(dt)})",f" local r=a {symbol} {atom(scalar)}",
              f" assert(r.dtype=='{dname(r.dtype)}','weak operator dtype {count}')",
              f" assert(same(r:tolist(),{table_obj(r)},{tol(r.dtype)}),'weak operator values {count}')","end"]
    count+=1

lines.append(f"print('weak scalar registry differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
