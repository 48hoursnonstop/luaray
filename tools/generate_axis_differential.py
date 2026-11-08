#!/usr/bin/env python3
"""Freeze NumPy 2.3.5 oracle outputs for LuaRay 0.32 axis/view APIs.
The implementation was audited against NumPy 2.5.3 sources; no Python
participates in LuaRay runtime. Indices/axes are 1-based on the Lua side.
"""
from pathlib import Path
import math
import numpy as np

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'tests/axis_differential_generated.lua'
lines=["local np=require('luaray_core')",'local n=0',r'''
local function eq(a,b)
 if type(b)=='table' then
  assert(type(a)=='table','expected a table, got '..type(a))
  assert(#a==#b,'length '..#a..' ~= '..#b)
  for i=1,#b do eq(a[i],b[i]) end
 elseif type(b)=='number' then
  assert(type(a)=='number' and (a==b or (a~=a and b~=b) or
      math.abs(a-b)<1e-6*math.max(1,math.abs(b))),
      tostring(a)..' ~= '..tostring(b))
 else assert(a==b,tostring(a)..' ~= '..tostring(b)) end
end
local function check(a,shape,data,dtype,strides)
 assert(a.ndim==#shape,'rank '..a.ndim..' ~= '..#shape)
 assert(a.dtype==dtype,'case '..n..' dtype '..tostring(a.dtype)..' ~= '..dtype)
 for i=1,#shape do assert(a.shape[i]==shape[i],'shape mismatch axis '..i) end
 if strides then for i=1,#strides do assert(a.strides[i]==strides[i],
    'case '..n..' stride mismatch axis '..i..': '..a.strides[i]..' ~= '..strides[i]) end end
 eq(a:tolist(),data)
end
''']

def lit(v):
    if isinstance(v,np.ndarray):return lit(v.tolist())
    if isinstance(v,(tuple,list)):return '{'+','.join(lit(x) for x in v)+'}'
    if isinstance(v,(np.bool_,bool)):return 'true' if bool(v) else 'false'
    if isinstance(v,(np.integer,int)):return str(int(v))
    if isinstance(v,(np.floating,float)):
        if math.isnan(v):return '(0/0)'
        return repr(float(v))
    if isinstance(v,str):return '"'+v.replace('\\','\\\\').replace('"','\\"')+'"'
    raise TypeError(type(v))

def ax(v):
    if isinstance(v,(tuple,list)):return '{'+','.join(ax(i) for i in v)+'}'
    return str(v+1 if v>=0 else v)

def dtname(a):
    d=a.dtype
    if d.kind=='U':return f'<U{d.itemsize//4}'
    if d.kind=='S':return f'|S{d.itemsize}'
    return d.name

count=0;good=0;bad=0

def emit(expr,func,a,expected_failure=False):
    global count,good,bad
    count+=1
    try:
        result=func(a)
        scalar=not isinstance(result,np.ndarray)
        result=np.asarray(result)
    except (TypeError,ValueError,IndexError,np.exceptions.AxisError):
        bad+=1
        lines.append(f'assert(not pcall(function()return {expr} end), "expected failure {count}")')
    else:
        good+=1
        if scalar:
            lines.append(f'eq({expr},{lit(result.item())})')
        else:
            lines.append(f'check({expr},{lit(result.shape)},{lit(result.tolist())},{lit(dtname(result))}'+
                (f',{lit(result.strides)}' if a.size>0 else '')+')')
    lines.append('n=n+1')

shapes=[(),(0,),(1,),(5,),(2,3),(0,3),(3,0),(1,3,1),(2,3,4),(0,2,3),(2,1,3,4),(1,2,1,2)]
for dtype in ('int32','float64','bool','U2'):
 for shape in shapes:
    size=math.prod(shape)
    if dtype=='bool': vals=[i%3==0 for i in range(size)]
    elif dtype=='U2':vals=(['é','界','A','ß','東','µ','b']*((size//7)+1))[:size]
    elif dtype=='float64':vals=[i*1.25-3.5 for i in range(size)]
    else:vals=[i*3-7 for i in range(size)]
    base=np.array(vals,dtype=dtype).reshape(shape)
    root=f'np.reshape(np.array({lit(vals)},{lit(dtype)}),{lit(shape)})'
    variants=[(base,root)]
    if base.ndim>=2:
        variants.append((base.T,root+'.T'))
    if base.ndim>=1:
        variants.append((base[::-1],root+':get(np.slice(nil,nil,-1))'))
    for a,src in variants:
        d=a.ndim
        emit(f'np.transpose({src})',lambda z:np.transpose(z),a)
        if d:
            perm=tuple(reversed(range(d)))
            emit(f'np.transpose({src},{ax(perm)})',lambda z,p=perm:np.transpose(z,p),a)
            emit(f'np.transpose({src},{ax(tuple(range(d)))})',lambda z:np.transpose(z,tuple(range(d))),a)
            for axes in [None,0,-1,(),tuple(range(d)),(0,-1) if d>1 else (0,)]:
                call=f'np.flip({src}'+('' if axes is None else f',{ax(axes)}')+')'
                emit(call,lambda z,axes=axes:np.flip(z,axis=axes),a)
            emit(f'np.flipud({src})',lambda z:np.flipud(z),a)
            emit(f'np.fliplr({src})',lambda z:np.fliplr(z),a)
            emit(f'np.swapaxes({src},1,-1)',lambda z:np.swapaxes(z,0,-1),a)
            emit(f'np.moveaxis({src},1,-1)',lambda z:np.moveaxis(z,0,-1),a)
            emit(f'np.moveaxis({src},{{}},{{}})',lambda z:np.moveaxis(z,(),()),a)
            if d>=2:
                emit(f'np.moveaxis({src},{{1,-1}},{{-1,1}})',lambda z:np.moveaxis(z,(0,-1),(-1,0)),a)
                emit(f'np.swapaxes({src},-1,-2)',lambda z:np.swapaxes(z,-1,-2),a)
                for k in (-3,-1,0,1,2,3,4,5):
                    emit(f'np.rot90({src},{k})',lambda z,k=k:np.rot90(z,k),a)
                    emit(f'np.rot90({src},{k},{{-1,1}})',lambda z,k=k:np.rot90(z,k,axes=(-1,0)),a)
        else:
            emit(f'np.flip({src})',lambda z:np.flip(z),a)
            emit(f'np.flip({src},{{}})',lambda z:np.flip(z,axis=()),a)
            emit(f'np.moveaxis({src},{{}},{{}})',lambda z:np.moveaxis(z,(),()),a)
        emit(f'np.squeeze({src})',lambda z:np.squeeze(z),a)
        emit(f'np.squeeze({src},{{}})',lambda z:np.squeeze(z,axis=()),a)
        for axis in ([0,-1] if d else [0]):
            emit(f'np.squeeze({src},{ax(axis)})',lambda z,axis=axis:np.squeeze(z,axis=axis),a)
        for axes in [0,-1,(),(0,-1)]:
            emit(f'np.expand_dims({src},{ax(axes)})',lambda z,axes=axes:np.expand_dims(z,axis=axes),a)
        for axes in ([(-1,0)] if d else []):
            emit(f'np.expand_dims({src},{ax(axes)})',lambda z,axes=axes:np.expand_dims(z,axis=axes),a)

# Boundary and invalid axes (Python zero-index mapped to Lua one-index).
a=np.arange(6).reshape(2,3)
src='np.reshape(np.arange(6),{2,3})'
for expr, fn in [
 (f'np.transpose({src},{{1,1}})',lambda x:np.transpose(x,(0,0))),
 (f'np.transpose({src},{{1}})',lambda x:np.transpose(x,(0,))),
 (f'np.flip({src},{{1,1}})',lambda x:np.flip(x,(0,0))),
 (f'np.flip({src},3)',lambda x:np.flip(x,2)),
 (f'np.swapaxes({src},1,3)',lambda x:np.swapaxes(x,0,2)),
 (f'np.moveaxis({src},{{1,2}},{{1,1}})',lambda x:np.moveaxis(x,(0,1),(0,0))),
 (f'np.moveaxis({src},{{1,2}},{{1}})',lambda x:np.moveaxis(x,(0,1),(0,))),
 (f'np.expand_dims({src},{{1,1}})',lambda x:np.expand_dims(x,(0,0))),
 (f'np.expand_dims({src},4)',lambda x:np.expand_dims(x,3)),
 (f'np.squeeze({src},1)',lambda x:np.squeeze(x,axis=0)),
 (f'np.rot90({src},1,{{1,1}})',lambda x:np.rot90(x,1,(0,0))),
 (f'np.rot90({src},1,{{1,3}})',lambda x:np.rot90(x,1,(0,2))),
 ]:emit(expr,fn,a)

lines.append(f'assert(n=={count});print("axis differential: {good}/{good} matches, {bad}/{bad} rejected (total {count})")')
OUT.write_text('\n'.join(lines)+'\n')
print(f'wrote {OUT.name}: {count} cases ({good} successful, {bad} rejected)')
