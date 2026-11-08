#!/usr/bin/env python3
"""Differential coverage for ufunc families migrated to the 0.21 registry.

The uploaded NumPy main tree remains the implementation source of truth. The
installed NumPy is used only as a development oracle to materialize expected
values/dtypes for behavior shared by the pinned upstream revision.
"""
from pathlib import Path
import math, warnings
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests'/'registry_migration_differential_generated.lua'

lines=["local np=require('luaray_core')", r'''
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
local function seqeq(a,b)
  if #a~=#b then return false end
  for i=1,#a do if a[i]~=b[i] then return false end end
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
    if isinstance(x,np.ndarray): x=x.tolist()
    if isinstance(x,(list,tuple)): return '{'+','.join(table_obj(v) for v in x)+'}'
    return atom(x)

def dname(dt):
    n=np.dtype(dt).name
    if n in ('float128','longdouble'): return 'longdouble'
    if n in ('complex256','clongdouble'): return 'complex256'
    return n

def tolerance(dt):
    dt=np.dtype(dt)
    if dt.kind in 'biu': return 0.0
    if dt==np.dtype('float16'): return 6e-3
    if dt==np.dtype('float32') or dt==np.dtype('complex64'): return 8e-6
    return 2e-12

def vals(dt,second=False):
    dt=np.dtype(dt); k=dt.kind
    if k=='b': return np.array([False,True,True,False],dtype=dt)
    if k=='u': return np.array([0,1,5,17] if not second else [1,2,7,3],dtype=dt)
    if k=='i': return np.array([-7,-1,2,11] if not second else [1,-3,5,2],dtype=dt)
    if k=='f': return np.array([-2.5,-0.0,1.25,7.0] if not second else [1.0,-2.0,0.5,4.0],dtype=dt)
    if k=='c': return np.array([-2.5+1j,-0.0-2j,1.25+0.5j,7-3j] if not second else [1+0.5j,-2+1j,0.5-1j,4+2j],dtype=dt)
    raise AssertionError(dt)

count=0
binary=['add','subtract','multiply','true_divide','equal','not_equal','less','less_equal','greater','greater_equal']
pairs=[
    (np.bool_,np.bool_), (np.int8,np.int8), (np.uint8,np.int16),
    (np.int64,np.uint64), (np.uint64,np.int64), (np.float16,np.int8),
    (np.float32,np.float64), (np.float64,np.uint64),
    (np.complex64,np.float32), (np.complex128,np.complex64),
]
for opname in binary:
  f=getattr(np,opname)
  for da,db in pairs:
    a=vals(da); b=vals(db,True)
    # Keep true_divide denominators nonzero after casting.
    if opname=='true_divide':
      if np.dtype(db).kind=='b': b=np.array([True,True,True,True],dtype=db)
      elif np.dtype(db).kind in 'iu': b=np.array([1,2,5,2],dtype=db)
      elif np.dtype(db).kind=='f': b=np.array([1.,-2.,.5,4.],dtype=db)
      else: b=np.array([1+.5j,-2+1j,.5-1j,4+2j],dtype=db)
    try:
      with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore'); r=f(a,b)
    except Exception:
      lines += ["do",f" local a=np.array({table_obj(a)},np.{dname(da)})",f" local b=np.array({table_obj(b)},np.{dname(db)})",
                f" assert(not pcall(function() np.{opname}(a,b) end),'reject {opname} {count}')","end"]
      count+=1; continue
    lines += ["do",f" local a=np.array({table_obj(a)},np.{dname(da)})",f" local b=np.array({table_obj(b)},np.{dname(db)})",
              f" local r=np.{opname}(a,b)",f" assert(r.dtype=='{dname(r.dtype)}','dtype {opname} {count}')",
              f" assert(same(r:tolist(),{table_obj(r)},{tolerance(r.dtype)}),'values {opname} {count}')","end"]
    count+=1

unary=['negative','absolute','positive','sign','logical_not','isnan','isinf','isfinite','signbit']
udtypes=[np.bool_,np.int8,np.uint8,np.int64,np.uint64,np.float16,np.float32,np.float64,np.complex64,np.complex128]
for opname in unary:
  f=getattr(np,opname)
  for dt in udtypes:
    a=vals(dt)
    try:
      with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore'); r=f(a)
    except Exception:
      lines += ["do",f" local a=np.array({table_obj(a)},np.{dname(dt)})",f" assert(not pcall(function() np.{opname}(a) end),'unary reject {opname} {count}')","end"]
      count+=1; continue
    lines += ["do",f" local a=np.array({table_obj(a)},np.{dname(dt)})",f" local r=np.{opname}(a)",
              f" assert(r.dtype=='{dname(r.dtype)}','unary dtype {opname} {count}')",
              f" assert(same(r:tolist(),{table_obj(r)},{tolerance(r.dtype)}),'unary values {opname} {count}')","end"]
    count+=1

# out=/where= for every migrated family, using float32 where legal.
mask=np.array([True,False,True,False])
for opname in binary:
    f=getattr(np,opname); a=np.array([-2.5,-1.,1.25,7.],np.float32); b=np.array([1.,-2.,.5,4.],np.float32)
    rr=f(a,b)
    odt=np.bool_ if rr.dtype.kind=='b' else np.float64
    o=np.array([True,False,False,True],dtype=odt) if np.dtype(odt).kind=='b' else np.array([90.,80.,70.,60.],dtype=odt)
    with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore'); f(a,b,out=o,where=mask)
    lines += ["do",f" local a=np.array({table_obj(a)},np.float32)",f" local b=np.array({table_obj(b)},np.float32)",f" local m=np.array({table_obj(mask)},np.bool)",
              f" local o=np.array({table_obj(np.array([True,False,False,True],dtype=odt) if np.dtype(odt).kind=='b' else np.array([90.,80.,70.,60.],dtype=odt))},np.{dname(odt)})",
              f" local r=np.{opname}(a,b,{{out=o,where=m}})"," assert(r==o,'binary out identity')",
              f" assert(same(o:tolist(),{table_obj(o)},{tolerance(o.dtype)}),'binary out where {opname} {count}')","end"]
    count+=1

for opname in unary:
    f=getattr(np,opname); a=np.array([-2.5,-0.,1.25,7.],np.float32); rr=f(a)
    odt=np.bool_ if rr.dtype.kind=='b' else np.float64
    o0=np.array([True,False,False,True],dtype=odt) if np.dtype(odt).kind=='b' else np.array([90.,80.,70.,60.],dtype=odt)
    o=o0.copy()
    with warnings.catch_warnings(),np.errstate(all='ignore'):
        warnings.simplefilter('ignore'); f(a,out=o,where=mask)
    lines += ["do",f" local a=np.array({table_obj(a)},np.float32)",f" local m=np.array({table_obj(mask)},np.bool)",f" local o=np.array({table_obj(o0)},np.{dname(odt)})",
              f" local r=np.{opname}(a,{{out=o,where=m}})"," assert(r==o,'unary out identity')",
              f" assert(same(o:tolist(),{table_obj(o)},{tolerance(o.dtype)}),'unary out where {opname} {count}')","end"]
    count+=1

# KEEPORDER layout: transpose and mixed negative/positive stride views.
a=np.arange(24,dtype=np.float64).reshape(2,3,4)
t=a.transpose()
r=np.add(t,t); u=np.negative(t)
lines += ["do"," local v={} for i=1,24 do v[i]=i-1 end"," local a=np.reshape(np.array(v,np.float64),{2,3,4}); local t=a:transpose()",
          " local r=np.add(t,t); local u=np.negative(t)",f" assert(seqeq(r.strides,{table_obj(r.strides)}) and seqeq(u.strides,{table_obj(u.strides)}),'KEEPORDER transpose {count}')","end"]
count+=1
v=a[:,::-1,::2]; r=np.add(v,v); p=np.isfinite(v)
lines += ["do"," local v={} for i=1,24 do v[i]=i-1 end"," local a=np.reshape(np.array(v,np.float64),{2,3,4})",
          " local x=a:get(np.slice(nil,nil,1),np.slice(nil,nil,-1),np.slice(nil,nil,2))"," local r=np.add(x,x); local p=np.isfinite(x)",
          f" assert(seqeq(r.strides,{table_obj(r.strides)}) and seqeq(p.strides,{table_obj(p.strides)}),'KEEPORDER strided {count}')","end"]
count+=1

# ndarray operator paths are registry-backed for the four core arithmetic ops.
a=np.array([2.,4.,8.],np.float64); b=np.array([1.,2.,4.],np.float64)
for symbol,opname in [('+','add'),('-','subtract'),('*','multiply'),('/','true_divide')]:
    r=getattr(np,opname)(a,b)
    lines += ["do"," local a=np.array({2,4,8},np.float64); local b=np.array({1,2,4},np.float64)",f" local r=a {symbol} b",f" assert(same(r:tolist(),{table_obj(r)},1e-12),'operator {opname} {count}')","end"]
    count+=1

lines.append(f"print('registry migration differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
