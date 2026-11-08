#!/usr/bin/env python3
"""Deterministic NumPy 2.x -> LuaRay native var/std differential fixtures."""
import math
import random
import warnings
from pathlib import Path
import numpy as np

rng = random.Random(410041)
root = Path(__file__).resolve().parents[1]
res = root/'tests'/'stats_differential_generated.lua'

def esc_float(x):
    x = float(x)
    if math.isnan(x): return '(0/0)'
    if math.isinf(x): return 'math.huge' if x > 0 else '-math.huge'
    return repr(x)

def lua(v):
    if isinstance(v, str): return "\"" + v + "\""
    if isinstance(v, (np.ndarray,)):
        return lua(v.tolist())
    if isinstance(v, (list,tuple)):
        return '{'+','.join(map(lua,v))+'}'
    if isinstance(v, (complex,np.complexfloating)):
        return 'np.complex('+esc_float(v.real)+','+esc_float(v.imag)+')'
    if isinstance(v,(bool,np.bool_)):
        return 'true' if v else 'false'
    if isinstance(v,(int,np.integer)):
        return str(int(v))
    return esc_float(v)

out=["local np=require('luaray_core')",'''local function close(a,b,tol)
  if type(a)=='table' then
    if type(b)~='table' or #a~=#b then return false end
    for i=1,#a do if not close(a[i],b[i],tol) then return false end end
    return true
  end
  if type(a)=='number' and type(b)=='number' then
    if a~=a and b~=b then return true end
    if a==b then return true end
    if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return false end
    return math.abs(a-b)<=tol*math.max(1,math.abs(b))
  end
  if type(a)=='userdata' and type(b)=='userdata' then
    return close(a.real,b.real,tol) and close(a.imag,b.imag,tol)
  end
  return a==b
end''']
shapes=[(),(0,),(1,),(2,),(3,),(4,),(2,3),(3,2),(1,4),(0,3),(2,0),(2,1,3),(2,3,2),(1,2,3),(2,0,3)]
dtypes=['bool','int8','int32','uint64','float16','float32','float64','complex64','complex128']
casecount=0
for k in range(1600):
    shape=rng.choice(shapes)
    n=math.prod(shape)
    dtype=rng.choice(dtypes)
    op=rng.choice(('var','std'))
    if dtype == 'bool':
        data=[rng.choice((0,1)) for _ in range(n)]
    elif dtype.startswith('complex'):
        data=[complex(rng.randint(-5,5)/2,rng.randint(-4,4)/2) for _ in range(n)]
    else:
        data=[rng.randint(-9,9)/rng.choice((1,2,4)) for _ in range(n)]
    if dtype in ('int8','int32','uint64'):
        data=[abs(int(x)) if dtype=='uint64' else int(x) for x in data]
    dtype_obj=np.dtype(dtype)
    arr=np.array(data,dtype=dtype_obj).reshape(shape)
    if k%13==0 and len(shape)>1 and all(s>0 for s in shape):
        arr=arr.transpose(tuple(reversed(range(arr.ndim))))
        shape=arr.shape
    axis=None
    if arr.ndim and rng.random()<0.67:
        if rng.random()<0.25:
            axis=tuple(sorted(rng.sample(range(arr.ndim),rng.randrange(arr.ndim+1))))
        else: axis=rng.randrange(arr.ndim)
    keepdims=rng.random()<0.3
    ddof=rng.choice((0,0,0,1,2,-1,0.5))
    has_where=rng.random()<0.20
    where=np.array([rng.random()>0.32 for _ in range(n)],dtype=np.bool_).reshape(shape) if has_where else True
    chosen_dtype=None
    if rng.random()<0.14:
        chosen_dtype=rng.choice(['float32','float64','complex128'])
    kws={'axis':axis,'keepdims':keepdims,'ddof':ddof,'where':where}
    if chosen_dtype: kws['dtype']=chosen_dtype
    with warnings.catch_warnings():
        warnings.simplefilter('ignore',RuntimeWarning)
        warnings.simplefilter('ignore',np.exceptions.ComplexWarning)
        result=getattr(np,op)(arr,**kws)
    opts=[]
    if axis is not None:
        opts.append('axis='+lua([int(i+1) for i in axis] if isinstance(axis,tuple) else axis+1))
    if ddof: opts.append('ddof='+lua(ddof))
    if keepdims: opts.append('keepdims=true')
    if chosen_dtype: opts.append('dtype='+lua(chosen_dtype))
    if has_where: opts.append('where=mask')
    # Recreate the logical input with ordinary flat C-order values. A stride
    # test is generated separately to exercise views correctly.
    vals=arr.ravel(order='C').tolist()
    make='np.reshape(np.array('+lua(vals)+',np.'+dtype+'),'+lua(shape)+')'
    expected_dtype=np.asarray(result).dtype.name
    resultval=lua(np.asarray(result).item() if np.asarray(result).ndim==0 else np.asarray(result).tolist())
    tol='5e-3' if dtype=='float16' else '5e-4'
    output_non_scalar=np.asarray(result).ndim>0
    out.append('do -- stats '+str(k)+' '+dtype+' '+str(shape))
    out.append(' local a='+make)
    if has_where: out.append(' local mask=np.reshape(np.array('+lua(where.ravel().tolist())+',np.bool),'+lua(shape)+')')
    out.append(' local r=np.'+op+'(a'+(',' if opts else '')+('{'+','.join(opts)+'}' if opts else '')+')')
    if output_non_scalar:
        out.append(' assert(r.dtype=='+lua(expected_dtype)+',"stats dtype '+str(k)+' "..r.dtype)')
        out.append(' assert(close(r:tolist(),'+resultval+','+tol+'),"stats val '+str(k)+'")')
    else:
        out.append(' assert(close(r,'+resultval+','+tol+'),"stats scalar '+str(k)+'")')
    out.append('end')
    casecount+=1
out.append("print('stats differential: "+str(casecount)+" cases passed')")
res.write_text('\n'.join(out)+'\n',encoding='utf-8')
print(res,casecount)
