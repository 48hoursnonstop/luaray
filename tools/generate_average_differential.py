#!/usr/bin/env python3
"""Generate deterministic Lua average fixtures against the installed NumPy oracle.
These test values, result shapes, dtypes and expected rejects; Python is not needed at runtime.
"""
import math, random, warnings
from pathlib import Path
import numpy as np
rng=random.Random(500050)
def lua(x):
    if isinstance(x,np.ndarray):return lua(x.tolist())
    if isinstance(x,(list,tuple)):return '{'+','.join(lua(i) for i in x)+'}'
    if isinstance(x,(bool,np.bool_)):return 'true' if x else 'false'
    if isinstance(x,(complex,np.complexfloating)):return 'np.complex('+lua(float(x.real))+','+lua(float(x.imag))+')'
    if isinstance(x,(int,np.integer)):return str(int(x))
    if isinstance(x,(float,np.floating)):
        x=float(x)
        if math.isnan(x):return '(0/0)'
        if math.isinf(x):return 'math.huge' if x>0 else '-math.huge'
        return repr(x)
    raise TypeError((x,type(x)))
def expr(x):
    if x.size==0:return 'np.zeros('+lua(x.shape)+',"'+str(x.dtype)+'")'
    return 'np.array('+lua(x.tolist())+',"'+str(x.dtype)+'")'
p=Path(__file__).resolve().parents[1]/'tests/average_differential_generated.lua'
lines=['local np=require("luaray_core")', '''local function eq(actual,expected,tol)
 if type(expected)=='table' and expected.__complex then
   error('not used')
 end
 if type(actual)=='userdata' and actual.real~=nil then
   assert(type(expected)=='userdata', 'expected complex')
   eq(actual.real,expected.real,tol);eq(actual.imag,expected.imag,tol);return
 end
 if type(expected)=='userdata' and expected.real~=nil then
   assert(type(actual)=='userdata','expected complex result');
   eq(actual.real,expected.real,tol);eq(actual.imag,expected.imag,tol);return
 end
 if type(expected)=='table' then
   assert(type(actual)=='table' and #actual==#expected,'table shape mismatch')
   for i=1,#expected do eq(actual[i],expected[i],tol) end
 elseif type(expected)=='number' then
   assert(type(actual)=='number','number expected')
   if expected~=expected then assert(actual~=actual,'expected NaN')
   elseif expected==math.huge or expected==-math.huge then assert(actual==expected)
   else assert(math.abs(actual-expected)<=tol*math.max(1,math.abs(expected)),tostring(actual)..' != '..tostring(expected)) end
 else assert(actual==expected,tostring(actual)..' != '..tostring(expected)) end
end''']
types=['bool','int8','int32','int64','uint8','float16','float32','float64','complex64','complex128']
shapes=[(),(1,),(2,),(3,),(0,),(1,1),(2,3),(3,2),(1,3),(2,1),(2,0),(0,3),(2,2,3)]
count=0;valid=0;bad=0
for i in range(1500):
    shape=rng.choice(shapes);nd=len(shape);dt=rng.choice(types)
    num=math.prod(shape)
    choices=[0,0,1,2,-3,4]
    if dt.startswith('uint'):choices=[0,0,1,2,4]
    vals=[rng.choice(choices) for _ in range(num)]
    if dt.startswith('complex'):vals=[complex(v,rng.choice([0,0,2])) for v in vals]
    if dt=='bool':vals=[bool(v) for v in vals]
    a=np.array(vals,dtype=dt).reshape(shape)
    ae=expr(a)
    view=rng.choice(['normal','normal','transpose','flip'])
    if view=='transpose' and nd>1:a=a.T;ae='np.transpose('+ae+')'
    if view=='flip' and nd:a=np.flip(a,axis=-1);ae='np.flip('+ae+','+str(nd)+')'
    axes_variant=rng.choice(['none','none','axis','all','empty'])
    if axes_variant=='axis' and nd: axis=rng.randrange(nd)
    elif axes_variant=='all':axis=tuple(range(nd))
    elif axes_variant=='empty':axis=()
    else:axis=None
    kd=rng.random()<.25
    weighted=rng.random()<.8
    returned=rng.random()<.25
    wd=rng.choice(types)
    w=None;we=None
    if weighted:
        form=rng.choice(['full','full','one','bad','scalar'])
        if form=='full':wshape=a.shape
        elif form=='one' and isinstance(axis,int):wshape=(a.shape[axis],)
        elif form=='scalar':wshape=()
        elif form=='bad':wshape=(max(1,a.shape[0]+1) if nd else 2,)
        else:wshape=(rng.randrange(1,4),)
        wn=math.prod(wshape)
        wvalues=[rng.choice([-2,-1,0,1,2,3]) for _ in range(wn)]
        if wd.startswith('uint'):wvalues=[abs(v) for v in wvalues]
        if wd.startswith('complex'):wvalues=[complex(v,rng.choice([0,0,2])) for v in wvalues]
        if wd=='bool':wvalues=[bool(v) for v in wvalues]
        w=np.array(wvalues,dtype=wd).reshape(wshape)
        we=expr(w)
    opts=[]
    if axis is not None:opts.append('axis='+lua(tuple(x+1 for x in axis) if isinstance(axis,tuple) else axis+1))
    if kd:opts.append('keepdims=true')
    if returned:opts.append('returned=true')
    if weighted:opts.append('weights=w')
    call='np.average(a'+(',{'+','.join(opts)+'}' if opts else '')+')'
    with warnings.catch_warnings():
        warnings.simplefilter('ignore')
        try:expected=np.average(a,axis=axis,weights=w,returned=returned,keepdims=kd)
        except (TypeError,ValueError,ZeroDivisionError,IndexError):
            lines.append('do local a='+ae+'; '+('local w='+we+';' if weighted else '')+'assert(not pcall(function() '+call+' end)) end');bad+=1;count+=1;continue
    x,y=expected if returned else (expected,None)
    tol=.006 if getattr(x,'dtype',np.dtype('float64')).kind in 'fc' and getattr(x,'dtype',np.dtype('float64')).itemsize in (2,4,8) else 2e-6
    def assertion(res,name):
        dtype=str(getattr(res,'dtype',np.dtype('float64')))
        # If a scalar is returned, Lua has no dtype of primitive. An ndarray scalar also becomes Lua primitive.
        if isinstance(res,np.ndarray) and res.ndim>0:
            return 'assert('+name+'.dtype=="'+dtype+'")\neq('+name+':tolist(),'+lua(res)+','+str(tol)+')'
        return 'eq('+name+','+lua(res.item() if isinstance(res,np.ndarray) else res)+','+str(tol)+')'
    code='do local a='+ae+'; '+('local w='+we+';' if weighted else '')
    code+='local v'+(',sw' if returned else '')+'='+call+';'+assertion(x,'v')
    if returned:code+=';'+assertion(y,'sw')
    code+=' end'
    lines.append(code);count+=1;valid+=1
lines.append("print('average differential: "+str(count)+" cases passed')")
p.write_text('\n'.join(lines)+'\n')
print('generated',count,'cases:',valid,'valid',bad,'expected rejects; NumPy',np.__version__)
