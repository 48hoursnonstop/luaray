from pathlib import Path
import numpy as np, random, math
r=random.Random(485641)
base=Path(__file__).resolve().parent.parent
target=base/'tests/cumulative_differential_generated.lua'
DTypes=['bool','int8','int16','int32','int64','uint8','uint32','float16','float32','float64','complex64','complex128']
shapes=[(),(0,),(1,),(3,),(6,),(1,0),(0,3),(2,3),(3,2),(1,2,3),(2,1,4),(2,2,2)]
methods=['cumsum','cumprod','nancumsum','nancumprod']
def num(x):
 if isinstance(x,(bool,np.bool_)): return 'true' if x else 'false'
 if isinstance(x,(complex,np.complexfloating)):
  return f'n.complex({num(x.real)},{num(x.imag)})'
 f=float(x)
 if math.isnan(f): return '(0/0)'
 if math.isinf(f): return '(1/0)' if f>0 else '(-1/0)'
 if isinstance(x,(int,np.integer)):
  return str(int(x))
 if float(x).is_integer() and abs(f)<1e12: return str(int(f))
 return repr(f)
def table(x):
 if isinstance(x,(list,tuple)):
  return '{'+','.join(table(y) for y in x)+'}'
 return num(x)
lines=['''-- Generated independently with NumPy 2.3.5; reference is not required at runtime.
local n=require('luaray_core')
assert(n._version=='0.50.0-dev')
local passed=0
local function close(x,y,tol)
 if type(x)=='table' then
  if type(y)~='table' or #x~=#y then return false end
  for i=1,#x do if not close(x[i],y[i],tol) then return false end end
  return true
 end
 if type(x)=='userdata' or type(y)=='userdata' then
  if type(x)~='userdata' or type(y)~='userdata' then return false end
  return close(x.real,y.real,tol) and close(x.imag,y.imag,tol)
 end
 if type(x)=='boolean' or type(y)=='boolean' then return x==y end
 if x~=x and y~=y then return true end
 return math.abs(x-y)<=tol*(1+math.abs(y))
end
local function run(id,f,expected,shape,dtype,tol)
 local ok,result=pcall(f)
 assert(ok,'case '..id..' exception '..tostring(result))
 assert(result.dtype==dtype,'case '..id..' dtype '..tostring(result.dtype)..' expected '..dtype)
 assert(close(result.shape,shape,0),'case '..id..' shape mismatch')
 assert(close(result:tolist(),expected,tol),'case '..id..' value mismatch')
 passed=passed+1
end
local function reject(id,f)
 local ok=pcall(f)
 assert(not ok,'case '..id..' expected error')
 passed=passed+1
end''']
n=0; counts={m:0 for m in methods}; ignored=[]
for method in methods:
 for i in range(280):
  shape=r.choice(shapes); dname=r.choice(DTypes)
  kind=np.dtype(dname).kind
  size=int(np.prod(shape)) if shape else 1
  vals=[]
  for z in range(size):
   if kind=='b': v=r.choice([True,False]);
   elif kind=='c':
    v=complex(r.choice([-2,-1,0,1,2,3]), r.choice([-3,-1,0,1,2,3]));
    if r.random()<0.1: v=complex(float('nan'),v.imag)
    if r.random()<0.06: v=complex(v.real,float('nan'))
   elif kind=='f':
    v=r.choice([-3.,-2.,-.5,0.,.25,1.,2.,3.,4.])
    if r.random()<0.16: v=float('nan')
   elif kind=='u': v=r.randrange(0,5)
   else: v=r.randrange(-3,5)
   vals.append(v)
  x=np.array(vals,dtype=dname).reshape(shape)
  op=r.choice(['plain','transpose','flip']) if len(shape)>=2 else r.choice(['plain','flip']) if len(shape)==1 else 'plain'
  xv=x
  if op=='transpose':xv=x.T
  if op=='flip':xv=np.flip(x,axis=-1)
  axchoice=r.choice(['none','explicit','negative'])
  if axchoice=='none':axis=None; arg=''
  elif len(shape)==0:axis=r.choice([0,-1]);arg=('{axis=1}' if axis==0 else '{axis=-1}')
  else:
   axis=r.randrange(xv.ndim)
   if axchoice=='negative':axis-=xv.ndim
   la=axis+1 if axis>=0 else axis
   arg=f'{{axis={la}}}'
  dtype_opt=r.choice([None,None,None,'float64','float32','int64'])
  # complex -> integer casts are not a supported NumPy path, reject separately
  if dtype_opt is not None:
   if kind=='c' and dtype_opt!='float64': dtype_opt=None
   if kind=='c' and dtype_opt=='float64': dtype_opt=None
  if dtype_opt:
   arg=(f'{{axis={axis+1 if axis>=0 else axis},dtype="{dtype_opt}"}}' if axis is not None else f'{{dtype="{dtype_opt}"}}')
  try:
   with np.errstate(all='ignore'):
    result=getattr(np,method)(xv,axis=axis,dtype=dtype_opt)
  except Exception:
   ignored.append((method,dname,str(shape)));continue
  # format data: expression for initial 1D then reshape exact shape
  source=f'n.reshape(n.array({table(vals)},"{dname}"),{table(shape)})'
  if op=='transpose': source=f'n.transpose({source})'
  if op=='flip': source=f'n.flip({source},-1)'
  q=f'n.{method}({source}'+(','+arg if arg else '')+')'
  expected=table(result.tolist())
  tolerance=0.001 if np.issubdtype(result.dtype,np.inexact) else 0
  if result.dtype.name in ('float16','complex64','float32'): tolerance=0.005
  n+=1;counts[method]+=1
  lines.append(f'run({n},function()return {q} end,{expected},{table(result.shape)},"{result.dtype.name}",{tolerance})')
# errors axis 0 (Lua convention) for positive rank, out mismatch, non-numeric type, invalid dtype
for method in methods:
 for i in range(15):
  n+=1
  lines.append(f'reject({n},function() return n.{method}(n.array({{1,2,3}},"float64"),{{axis=0}}) end)')
  # note axis zero invalid
lines.append("print('cumulative differential passed '..passed..' cases')")
target.write_text('\n'.join(lines)+'\n')
print('generated',n,counts,'ignored',len(ignored))
