#!/usr/bin/env python3
"""Reproducible NumPy 2.3.5 -> LuaRay quantile/median/percentile fixture.
Public Lua axes use base 1 and are translated from NumPy zero-based axes.
The source array is never mutated; selected quantile DTypes are checked.
"""
import math,random,warnings
from pathlib import Path
import numpy as np
R=random.Random(440044)
root=Path(__file__).resolve().parents[1]
shapes=[(),(1,),(2,),(3,),(4,),(5,),(2,3),(3,2),(1,5),(2,1,3),(2,3,2),(3,1,2),(0,3),(3,0),(2,0,3)]
dtypes=['float64','float32','float16','int64','uint64','int16','bool']
methods=['linear','lower','higher','nearest','midpoint','inverted_cdf']
def fl(x):
    if math.isnan(x): return '(0/0)'
    if math.isinf(x): return 'math.huge' if x>0 else '-math.huge'
    return repr(float(x))
def ls(v):
    if isinstance(v,np.ndarray):return ls(v.tolist())
    if isinstance(v,(tuple,list)):return '{'+','.join(map(ls,v))+'}'
    if isinstance(v,(bool,np.bool_)):return 'true' if v else 'false'
    if isinstance(v,(int,np.integer)):return str(int(v))
    if isinstance(v,(float,np.floating)):return fl(float(v))
    raise ValueError(type(v))
prefix="""local n=require('luaray_core')
local function close(a,b)
 if type(a)=='table' then
   if type(b)~='table' or #a~=#b then return false end
   for i=1,#a do if not close(a[i],b[i]) then return false end end
   return true
 end
 if type(a)~='number' or type(b)~='number' then return a==b end
 if a~=a and b~=b then return true end
 if a==b then return true end
 if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return false end
 return math.abs(a-b)<=0.002*math.max(1,math.abs(b))
end
local passed=0
"""
lines=[prefix]
fail=good=0
for i in range(2700):
    shape=R.choice(shapes);dt=R.choice(dtypes)
    n=math.prod(shape)
    if dt=='bool':data=[R.choice([False,True]) for _ in range(n)]
    elif dt=='uint64' and R.random()<0.24:data=[2**50-R.randint(0,200) for _ in range(n)]
    elif dt=='int64' and R.random()<0.24:data=[2**50-R.randint(0,200) for _ in range(n)]
    else:data=[R.randint(-80,80)/R.choice([1,2,5]) for _ in range(n)]
    if dt in ('int64','uint64','int16'):data=[int(abs(x)) if dt=='uint64' else int(x) for x in data]
    if dt.startswith('float') and n and R.random()<0.09:data[R.randrange(n)]=float('nan')
    a=np.array(data,dtype=dt).reshape(shape)
    arr_expr=f"n.reshape(n.array({ls(data)},'{dt}'),{ls(shape)})"
    if len(shape)>1 and R.random()<0.2:
        a=a.T;arr_expr=f'n.transpose({arr_expr})'
    elif len(shape)>0 and R.random()<0.15:
        a=np.flip(a,axis=-1);arr_expr=f'n.flip({arr_expr},-1)'
    if a.ndim==0 or R.random()<0.3:axis=None;la='nil'
    else:
        if R.random()<0.3:
            axis=tuple(sorted(R.sample(range(a.ndim),R.randint(0,a.ndim))))
            la='{'+','.join(str(x+1) for x in axis)+'}'
        else:
            axis=R.randrange(a.ndim);la=str(axis+1)
    keepdims=R.random()<0.3
    kind=R.choice(['median','quantile','percentile'])
    method=R.choice(methods) if kind!='median' else 'linear'
    scalar=R.random()<0.65
    qvals=[R.choice([0,.05,.1,.25,.33,.5,.6,.75,.9,1]) for _ in range(1 if scalar else R.randint(1,4))]
    qval=qvals[0] if scalar else qvals
    qarg=qval if kind!='percentile' else ([v*100 for v in qvals] if not scalar else qvals[0]*100)
    opts=f"{{axis={la},keepdims={'true' if keepdims else 'false'}"+(f",method='{method}'" if kind!='median' else '')+'}'
    call=f'n.{kind}(a'+(f',{ls(qarg)}' if kind!='median' else '')+f',{opts})'
    try:
        with warnings.catch_warnings():
            warnings.simplefilter('ignore')
            output=getattr(np,kind)(a, *( [] if kind=='median' else [qarg]), axis=axis,keepdims=keepdims,**( {'method':method} if kind!='median' else {}))
        expected=ls(output)
        # Literal representation of 0-d array outputs: returned Lua scalar, otherwise ndarray.
        dtype=str(output.dtype)
        want_array=isinstance(output,np.ndarray) and output.ndim>0
        lines.append('do local a='+arr_expr+';local ok,r=pcall(function()return '+call+' end);'+
              f'assert(ok,"case {i} should succeed: "..tostring(r));'+
              ('assert(r.dtype=='+repr(dtype)+',"wrong result dtype '+str(i)+'");r=r:tolist();' if want_array else '')+
              'assert(close(r,'+expected+'),"quantile mismatch '+str(i)+'");passed=passed+1 end')
        good+=1
    except (TypeError,ValueError,IndexError) as e:
        # NumPy rejects empty reductions and bool interpolations.
        lines.append('do local a='+arr_expr+';local ok=pcall(function()return '+call+
              ' end);assert(not ok,"case '+str(i)+' should fail");passed=passed+1 end')
        fail+=1
lines.append(f'assert(passed=={good+fail});print("quantile differential: {good+fail}/{good+fail} passed ({good} values, {fail} rejected)")')
path=root/'tests/quantile_differential_generated.lua';path.write_text('\n'.join(lines)+'\n')
print(f'{path}: {good} valid + {fail} invalid = {good+fail}')
