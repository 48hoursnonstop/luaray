#!/usr/bin/env python3
"""Original NumPy2.5.3 sequence samples, layouts, step and real errors."""
from pathlib import Path
import warnings
import numpy as np
from generate_write98_differential import lua, VIEWS
assert np.__version__=='2.5.3'
ROOT=Path(__file__).resolve().parents[1]

def dtype_name(dtype):
    return 'longdouble' if str(dtype)=='float128' else str(dtype)

def construct(a):
    if not isinstance(a,np.ndarray):return lua(a)
    if 0 in a.shape:return 'np.zeros('+lua(a.shape)+','+lua(dtype_name(a.dtype))+')'
    if a.ndim>1 and a.flags.f_contiguous and not a.flags.c_contiguous:
        return 'np.transpose('+construct(a.T.copy(order='C'))+')'
    return 'np.array('+lua(a)+','+lua(dtype_name(a.dtype))+')'

HEADER="""-- Original NumPy2.5.3 sequence sampling; positive Lua axes start at1.
-- NumPy float128 is LuaRay longdouble on this ABI (same native storage/type).
local np=require('luaray_core')
local cases,checks,max_error,max_relative_error=0,0,0,0
local function eq(a,b,label,atol,rtol)
 checks=checks+1
 if type(b)=='table' then
  assert(type(a)=='table' and #a==#b,label..': shape')
  for i=1,#b do eq(a[i],b[i],label..'['..i..']',atol,rtol) end
 elseif type(b)=='userdata' then eq(a.real,b.real,label..'.real',atol,rtol);eq(a.imag,b.imag,label..'.imag',atol,rtol)
 elseif type(b)=='number' then
  assert(type(a)=='number',label..': numeric')
  if b~=b then assert(a~=a,label..': NaN')
  elseif b==math.huge or b==-math.huge then assert(a==b,label..': infinity')
  else local e=math.abs(a-b);if e>max_error then max_error=e end
   local relative=e/math.max(1,math.abs(b));if relative>max_relative_error then max_relative_error=relative end
   assert(e<=(atol or 0)+(rtol or 0)*math.abs(b),label..': '..tostring(a)..' != '..tostring(b)..' error '..e)
  end
 else assert(a==b,label..': '..tostring(a)..' != '..tostring(b)) end
end
"""
class Suite:
    def __init__(self,name):self.name,self.count,self.lines=name,0,[HEADER]
    def check(self,name,a,label,numeric=False,compute_dtype=None):
        tol=''
        if numeric and self.name!='linspace106' and np.asarray(a).dtype.kind in 'fc':
            dt=np.dtype(compute_dtype) if compute_dtype is not None else np.asarray(a).dtype
            tol=',2e-3,2e-3' if dt==np.dtype('float16') else ',3e-6,3e-6' if dt in [np.dtype('float32'),np.dtype('complex64')] else ',2e-12,2e-12'
        if isinstance(a,np.ndarray):
            self.lines += [f'eq({name}:tolist(),{lua(a)},{lua(label+": values")}{tol})',
                           f'eq({name}.shape,{lua(a.shape)},{lua(label+": shape")})',
                           f'eq({name}.strides,{lua(a.strides)},{lua(label+": strides")})',
                           f'eq({name}.dtype,{lua(dtype_name(a.dtype))},{lua(label+": dtype")})']
        else:self.lines.append(f'eq({name},{lua(a)},{lua(label)}{tol})')
    def case(self,a,b,*,num=5,endpoint=True,axis=0,dtype=None,base=10.0,view=None,label=None):
        self.count+=1
        if (self.count-1)%100==0:
            if self.count>1:self.lines+=['end','chunk()','end']
            self.lines+=['do','local function chunk()']
        name=self.name[:-3]
        pa,pb=construct(a),construct(b)
        if view:
            a,ea=view(a);b,eb=view(b)
            self.lines+=['do','local start_base='+pa,'local stop_base='+pb,
                         'local a='+ea.replace('base','start_base'),'local b='+eb.replace('base','stop_base')]
        else:self.lines+=['do','local a='+pa,'local b='+pb]
        label=(label or f'{name}/{np.asarray(a).dtype}/{np.shape(a)}/{np.asarray(b).dtype}/{np.shape(b)}/n{num}/endpoint{endpoint}/axis{axis}/dtype{dtype}/base{base}').replace('\n',' ')
        self.lines.append('-- '+str(self.count)+': '+label)
        kwargs=dict(num=num,endpoint=endpoint,axis=axis)
        if dtype is not None:kwargs['dtype']=dtype
        if name=='linspace':kwargs['retstep']=True
        if name=='logspace':kwargs['base']=base
        error=None;result=None
        try:
            with warnings.catch_warnings():
                warnings.simplefilter('ignore');result=getattr(np,name)(a,b,**kwargs)
        except (TypeError,ValueError,OverflowError,IndexError) as exc:error=type(exc).__name__
        opts='{num='+lua(num)+',endpoint='+lua(endpoint)+',axis='+lua(axis+1 if axis>=0 else axis)
        if dtype is not None:opts+=',dtype='+lua(dtype)
        if name=='linspace':opts+=',retstep=true'
        if name=='logspace':self.lines.append('local base='+construct(base));opts+=',base=base'
        opts+='}'
        self.lines+=['local ok,result,step=pcall(function() return np.'+name+'(a,b,'+opts+') end)',
                     f'assert(ok=={str(error is None).lower()},{lua(label+": acceptance")}..": "..tostring(result))']
        if error is None:
            if name=='linspace':self.check('result',result[0],label,True);self.check('step',result[1],label+': step',True)
            else:
                # Explicit output casting does not improve the precision of
                # the preceding power/log computation. Integer values stay exact.
                if name=='logspace':
                    inner=dict(kwargs);inner.pop('dtype',None)
                    with warnings.catch_warnings():
                        warnings.simplefilter('ignore');precision=np.logspace(a,b,**inner).dtype
                else:precision=np.result_type(np.asanyarray(a),np.asanyarray(b),float(num),np.zeros((),dtype))
                self.check('result',result,label,True,precision)
        self.check('a',a,label+': start state');self.check('b',b,label+': stop state')
        self.lines+=['cases=cases+1','end']
    def finish(self):
        self.lines+=['end','chunk()','end',f'assert(cases=={self.count})',"print('"+self.name+" differential: '..cases..' cases, '..checks..' checks passed; max absolute error '..max_error..'; max relative to max(1,abs(expected)) '..max_relative_error)"]
        (ROOT/'tests'/(self.name+'_differential_generated.lua')).write_text('\n'.join(self.lines)+'\n');print(self.name,self.count)

linear,logarithmic,geometric=[Suite(n) for n in ['linspace106','logspace106','geomspace106']]
dtypes=['bool','int8','uint8','int32','int64','uint64','float16','float32','float64','float128','complex64','complex128','complex256']
for dtype in dtypes:
    a=np.array(np.arange(12).reshape(3,4)%5+1,dtype=dtype)
    b=np.array(np.arange(12).reshape(3,4)%7+2,dtype=dtype)
    if dtype.startswith('complex'):
        a=(a+.25j).astype(dtype);b=(b-.5j).astype(dtype)
    for vname,view in VIEWS.items():
        for n in [0,1,2,5,9]:
            for endpoint in [False,True]:
                for axis in [0,1,-1]:
                    linear.case(a,b,num=n,endpoint=endpoint,axis=axis,view=view)
    for output in ['int8','uint8','float16','float32','float64','complex64','complex128','bool','U8']:
        for axis in [0,-1]:linear.case(a,b,num=7,dtype=output,axis=axis)
    for suite in [logarithmic,geometric]:
        for view in VIEWS.values():
            for n in [0,1,2,5]:
                for endpoint in [False,True]:
                    for axis in [0,-1]:suite.case(a,b,num=n,endpoint=endpoint,axis=axis,view=view)
        for output in ['int8','float16','float32','float64','complex64','complex128']:
            suite.case(a,b,num=7,dtype=output,axis=-1)
# Mixed strong endpoints and weak scalar paths, including subnormal and signed values.
for dtype in dtypes:
    for scalar in [1,1.25,1+.5j]:
        for order in [False,True]:
            a,b=np.array([1,2,3],dtype=dtype),scalar
            if order:a,b=b,a
            for suite in [linear,logarithmic,geometric]:suite.case(a,b,axis=-1)
for a,b in [(0,1),(1,-1),(-8,-1),(-1,-64),(1+1j,-2-2j),(1j,16j),(1,0),(0,0),(float('inf'),1),(float('nan'),3)]:
    for suite in [linear,logarithmic,geometric]:
        for n in [0,1,2,7]:
            for endpoint in [True,False]:suite.case(a,b,num=n,endpoint=endpoint)
for dtype in ['float16','float32','float64']:
    tiny=np.nextafter(np.array(0,dtype),np.array(1,dtype))
    for a,b in [(np.array(0,dtype),np.array(tiny,dtype)),(np.array([0,1],dtype),np.array([tiny,2],dtype))]:
        for n in [2,3,7]:linear.case(a,b,num=n)
for suite in [linear,logarithmic,geometric]:
    for shapes in [((2,1),(3,)),((1,3),(2,1)),((0,3),(1,3)),((2,),(3,))]:
        a=np.ones(shapes[0],'float32');b=np.full(shapes[1],4,'float32')
        for n in [0,1,5]:
            for axis in [0,1,-1,4]:suite.case(a,b,num=n,axis=axis)
    for n in [-1,2.0,2.5,True,False]:suite.case(1,4,num=n)
    for axis in [-3,2]:suite.case(1,4,axis=axis)
    suite.case(np.array(['x'],'U1'),np.array(['y'],'U1'))
# Non-scalar bases influence logspace's sample-axis interpretation.
for base in [np.array([2.,3.]),np.array([[2.],[3.]]),np.array(2,'float32'),np.array([2,3],'int16'),2,2.0,-2.,1j]:
    for a,b in [(1.,3.),(np.array([1,2],'float32'),np.array([2,3],'float32'))]:
        for axis in [0,1,-1]:
            for n in [0,1,5]:logarithmic.case(a,b,num=n,axis=axis,base=base)
# Broadcast-stride and general permutation allocation, rank and half boundaries.
for dtype in ['float32','complex64']:
    a=np.arange(12).reshape(3,4).astype(dtype)+1;b=a+2
    if dtype.startswith('complex'):a=(a+.25j).astype(dtype);b=(b-.5j).astype(dtype)
    def broadcast_view(a):return np.broadcast_to(a[:1,:],(3,4)),'np.broadcast_to(base:get(np.s(1,2),np.s()),{3,4})'
    for suite in [linear,logarithmic,geometric]:
        for count in [0,1,5]:
            for axis in [0,1,-1]:suite.case(a,b,num=count,axis=axis,view=broadcast_view)
    a=np.arange(24,dtype=dtype).reshape(2,3,4)+1;b=a+2
    for perm in [(1,2,0),(2,0,1)]:
        def permutation(a):return a.transpose(perm),'np.transpose(base,'+lua(tuple(i+1 for i in perm))+')'
        for suite in [linear,logarithmic,geometric]:
            for count in [0,1,5]:
                for axis in [0,1,-1]:suite.case(a,b,num=count,axis=axis,view=permutation)
for suite in [linear,logarithmic,geometric]:
    for rank in [63,64]:
        for count in [0,1,2]:suite.case(np.ones((1,)*rank,'float32'),np.full((1,)*rank,2,'float32'),num=count,axis=-1)
for count in [65504,65536]:
    linear.case(np.array(0,'float16'),np.array(1,'float16'),num=count)
for dtype in ['float32','float64']:
    for axis in [0,1,-1]:
        logarithmic.case(np.array([[1,2,3]],'float32'),np.array([[2,3,4]],'float32'),num=3,axis=axis,base=np.array([[2],[3]],dtype=dtype))
for suite in [linear,logarithmic,geometric]:suite.finish()
