#!/usr/bin/env python3
"""Generate reproducible NumPy 2.x fixture for nan-aware C reductions."""
import math, random, warnings
from pathlib import Path
import numpy as np

rng=random.Random(460046)
root=Path(__file__).resolve().parents[1]
outfile=root/'tests'/'nanreductions_differential_generated.lua'

def num(x):
    x=float(x)
    if math.isnan(x):return '(0/0)'
    if math.isinf(x):return 'math.huge' if x>0 else '-math.huge'
    return repr(x)

def lua(x):
    if isinstance(x,np.ndarray):return lua(x.tolist())
    if isinstance(x,(tuple,list)):return '{'+','.join(map(lua,x))+'}'
    if isinstance(x,(complex,np.complexfloating)):return 'np.complex('+num(x.real)+','+num(x.imag)+')'
    if isinstance(x,(bool,np.bool_)):return 'true' if x else 'false'
    if isinstance(x,(int,np.integer)):return str(int(x))
    return num(x)

out=["local np=require('luaray_core')",'''local function near(a,b,tol)
  if type(a)=='table' then
    if type(b)~='table' or #a~=#b then return false end
    for i=1,#a do if not near(a[i],b[i],tol) then return false end end
    return true
  end
  if type(a)=='number' and type(b)=='number' then
    if a==b or (a~=a and b~=b) then return true end
    if a==math.huge or a==-math.huge or b==math.huge or b==-math.huge then return false end
    return math.abs(a-b)<=tol*math.max(1,math.abs(b))
  end
  if type(a)=='userdata' and type(b)=='userdata' then
    return near(a.real,b.real,tol) and near(a.imag,b.imag,tol)
  end
  return a==b
end''']
ops=['nansum','nanprod','nanmean','nanvar','nanstd']
shapes=[(),(0,),(1,),(2,),(4,),(2,3),(3,2),(1,4),(0,3),(2,0),(2,1,3),(2,3,2)]
dtypes=['bool','int8','int32','int64','uint16','float16','float32','float64','complex64','complex128']
count=0; good=0; bad=0
for k in range(2400):
    shape=rng.choice(shapes); n=math.prod(shape)
    dtype=rng.choice(dtypes); op=rng.choice(ops)
    if dtype.startswith('complex'):
        data=[complex(rng.randint(-8,8)/2,rng.randint(-8,8)/2) for _ in range(n)]
        data=[complex(float('nan'),x.imag) if rng.random()<0.16 else (complex(x.real,float('nan')) if rng.random()<0.10 else x) for x in data]
    elif dtype.startswith('float'):
        data=[rng.randint(-10,10)/2 for _ in range(n)]
        data=[float('nan') if rng.random()<0.26 else x for x in data]
    elif dtype=='bool':data=[rng.random()<.5 for _ in range(n)]
    else:data=[rng.randint(-8,8) for _ in range(n)]
    if dtype=='uint16':data=[abs(int(x)) for x in data]
    arr=np.array(data,dtype=dtype).reshape(shape)
    trans=False;flipped=False
    if arr.ndim>=2 and all(x>0 for x in shape) and k%11==0:
        arr=arr.transpose(tuple(reversed(range(arr.ndim))));trans=True
    if arr.ndim and all(x>0 for x in arr.shape) and k%13==0:
        arr=np.flip(arr,axis=-1);flipped=True
    axis=None
    if arr.ndim and rng.random()<0.7:
        if rng.random()<0.22:axis=tuple(sorted(rng.sample(range(arr.ndim),rng.randrange(arr.ndim+1))))
        else:axis=rng.randrange(arr.ndim)
    keepdims=rng.random()<0.3
    kwargs={'axis':axis,'keepdims':keepdims}
    ddof=None
    if op in ('nanvar','nanstd'):
        ddof=rng.choice([0,0,0,1,1,2,-1,0.5]);kwargs['ddof']=ddof
    # for explicit dtype, limit to standard supported combinations
    selected_dtype=None
    if k%8==0:
        selected_dtype=rng.choice(['float32','float64'] if op in ('nanvar','nanstd') else ['float32','float64','complex128'])
        kwargs['dtype']=selected_dtype
    w=None
    if rng.random()<0.25:
        w=np.array([rng.random()>.36 for _ in range(n)],dtype=np.bool_).reshape(arr.shape)
        kwargs['where']=w
    initial=None
    if op in ('nansum','nanprod') and k%7==0:
        initial=rng.choice([-2,0,1,3]);kwargs['initial']=initial
    with warnings.catch_warnings():
        warnings.simplefilter('ignore')
        try: expected=getattr(np,op)(arr,**kwargs)
        except (TypeError,ValueError,OverflowError,RuntimeError,NotImplementedError):expected=None
    # expected None -> rejection (avoid relying on implementation-specific warnings)
    raw=np.array(data,dtype=dtype).reshape(shape)
    # lua literal for flat allocation; transpose and flip in Lua
    create=f"np.reshape(np.array({lua(raw.flatten().tolist())},'{dtype}'),{lua(list(shape))})"
    if trans:create='np.transpose('+create+')'
    if flipped:create='np.flip('+create+',-1)'
    opt=[]
    if axis is not None:
        if isinstance(axis,tuple):opt.append('axis='+lua([x+1 for x in axis]))
        else:opt.append('axis='+str(axis+1))
    opt.append('keepdims='+('true' if keepdims else 'false'))
    if ddof is not None:opt.append('ddof='+lua(ddof))
    if selected_dtype:opt.append("dtype='"+selected_dtype+"'")
    if initial is not None:opt.append('initial='+lua(initial))
    if w is not None:opt.append("where=np.reshape(np.array("+lua(w.reshape(-1).tolist())+",'bool'),"+lua(list(arr.shape))+")")
    call=f'np.{op}(a,{{'+','.join(opt)+'})'
    head=f'do local a={create};local ok,r=pcall(function()return {call} end);'
    if expected is None:
        stmt=head+f'assert(not ok,"nan case {k} should reject");passed=passed+1 end';bad+=1
    else:
        exp=np.asarray(expected)
        exp_val=lua(exp.item()) if exp.ndim==0 else lua(exp.tolist())
        tol=0.025 if dtype=='float16' or selected_dtype=='float32' else (1e-4 if dtype in ('float32','complex64') else 2e-7)
        stmt=head+f'assert(ok,"nan case {k} error: "..tostring(r));'
        if exp.ndim:
            stmt+=f'assert(r.dtype=="{exp.dtype}","nan case {k} dtype "..tostring(r.dtype));r=r:tolist();'
        stmt+=f'assert(near(r,{exp_val},{tol}),"nan case {k} mismatch");passed=passed+1 end';good+=1
    out.append(stmt);count+=1
out.insert(2,'local passed=0')
out.append('print("nanreductions differential: "..passed.." cases passed")')
outfile.write_text('\n'.join(out)+'\n')
print('generated',count,'valid',good,'rejected',bad,'NumPy',np.__version__)
