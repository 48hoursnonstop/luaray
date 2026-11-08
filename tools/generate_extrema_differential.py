#!/usr/bin/env python3
"""Deterministic 0.42 NumPy -> LuaRay min/max differential tests.
Inputs and reference outputs are generated in Python; Lua execution is native.
"""
import math
import random
import warnings
from pathlib import Path
import numpy as np

rng=random.Random(420042)
root=Path(__file__).resolve().parents[1]
path=root/'tests'/'extrema_differential_generated.lua'

def lua(v):
    if isinstance(v, (np.ndarray,)): return lua(v.tolist())
    if isinstance(v,(list,tuple)): return '{'+','.join(map(lua,v))+'}'
    if isinstance(v,(bool,np.bool_)): return 'true' if v else 'false'
    if isinstance(v,(complex,np.complexfloating)):
        return 'np.complex('+lua(float(v.real))+','+lua(float(v.imag))+')'
    if isinstance(v,(int,np.integer)): return str(int(v))
    if isinstance(v,(float,np.floating)):
        x=float(v)
        if math.isnan(x): return '(0/0)'
        if math.isinf(x): return 'math.huge' if x>0 else '-math.huge'
        return repr(x)
    if isinstance(v,str):return repr(v).replace("'",'"')
    raise ValueError(v)

lines=["local np=require('luaray_core')",'''local function eq(a,b)
 if type(a)=='table' then
   if type(b)~='table' or #a~=#b then return false end
   for i=1,#a do if not eq(a[i],b[i]) then return false end end
   return true
 end
 if type(a)=='number' and type(b)=='number' then
   if a~=a and b~=b then return true end
   return a==b
 end
 if type(a)=='userdata' and type(b)=='userdata' then
   return eq(a.real,b.real) and eq(a.imag,b.imag)
 end
 return a==b
end''']
shapes=[(),(0,),(1,),(2,),(3,),(4,),(2,3),(3,2),(1,4),(0,3),(2,0),(2,1,3),(2,3,2),(1,2,3),(2,0,3)]
dtypes=['bool','int8','int16','int32','int64','uint8','uint64','float16','float32','float64','complex64','complex128']
passed=0; rejected=0
for k in range(2400):
    shape=rng.choice(shapes)
    n=math.prod(shape)
    dtype=rng.choice(dtypes)
    op=rng.choice(['min','max','amin','amax'])
    if dtype=='bool': data=[rng.random()<0.5 for _ in range(n)]
    elif dtype.startswith('complex'):data=[complex(rng.randint(-7,7),rng.randint(-7,7)) for _ in range(n)]
    elif dtype.startswith('float'):data=[rng.choice([float('nan'),float('inf'),float('-inf'),rng.randint(-12,12)/2]) if k%11==0 else rng.randint(-12,12)/2 for _ in range(n)]
    else:data=[rng.randint(-12,12) for _ in range(n)]
    if dtype.startswith('uint'): data=[abs(int(x)) for x in data]
    arr=np.array(data,dtype=dtype).reshape(shape)
    axis=None
    if arr.ndim and rng.random()<0.77:
        if rng.random()<0.3:axis=tuple(sorted(rng.sample(range(arr.ndim),rng.randrange(arr.ndim+1))))
        else:axis=rng.randrange(arr.ndim)
    keepdims=rng.random()<0.27
    where_mode=rng.choice(['none','none','none','mask','false','true'])
    where=None
    if where_mode=='mask':where=np.array([rng.random()<0.7 for _ in range(n)],dtype='bool').reshape(shape)
    elif where_mode=='false':where=False
    elif where_mode=='true':where=True
    initial=rng.choice([None,None,None,None,-7,0,2,11])
    kws={'axis':axis,'keepdims':keepdims}
    if where is not None:kws['where']=where
    if initial is not None:kws['initial']=initial
    with warnings.catch_warnings():
        warnings.simplefilter('ignore')
        try:
            res=getattr(np,op)(arr,**kws)
            valid=True
        except (ValueError,TypeError,OverflowError):valid=False
    opts=[]
    if axis is not None:opts.append('axis='+lua([int(a+1) for a in axis] if isinstance(axis,tuple) else axis+1))
    if keepdims:opts.append('keepdims=true')
    if where is not None:opts.append('where='+('mask' if where_mode=='mask' else lua(where)))
    if initial is not None:opts.append('initial='+lua(initial))
    values=arr.ravel(order='C').tolist()
    lines.append('do -- '+str(k)+' '+op+' '+dtype+' '+str(shape))
    lines.append(' local a=np.reshape(np.array('+lua(values)+',np.'+dtype+'),'+lua(shape)+')')
    if where_mode=='mask':lines.append(' local mask=np.reshape(np.array('+lua(where.ravel().tolist())+',np.bool),'+lua(shape)+')')
    args='a'+(','+'{'+','.join(opts)+'}' if opts else '')
    if not valid:
        lines.append(' assert(not pcall(function() np.'+op+'('+args+') end),"extrema reject '+str(k)+'")')
        rejected+=1
    else:
        expected=np.asarray(res)
        result=lua(expected.item() if expected.ndim==0 else expected.tolist())
        if expected.ndim:
            lines.append(' local r=np.'+op+'('+args+')')
            lines.append(' assert(r.dtype=='+lua(expected.dtype.name)+',"extrema dtype '+str(k)+' "..r.dtype)')
            lines.append(' assert(eq(r:tolist(),'+result+'),"extrema '+str(k)+'")')
        else:
            lines.append(' assert(eq(np.'+op+'('+args+'),'+result+'),"extrema '+str(k)+'")')
        passed+=1
    lines.append('end')
lines.append(f"print('extrema differential: {passed} values, {rejected} errors passed')")
path.write_text('\n'.join(lines)+'\n')
print(path,passed,rejected)
