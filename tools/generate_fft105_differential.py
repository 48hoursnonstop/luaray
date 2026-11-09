#!/usr/bin/env python3
"""Original NumPy2.5.3 FFT helper states, precision and actual errors."""
from pathlib import Path
import warnings
import numpy as np
from generate_write98_differential import lua as native_lua,DTYPES,VIEWS,base_array
assert np.__version__=='2.5.3'
ROOT=Path(__file__).resolve().parents[1]

def lua(v):
    if isinstance(v,np.ndarray):return lua(v.tolist())
    if isinstance(v,(tuple,list)):return '{'+','.join(map(lua,v))+'}'
    if isinstance(v,(int,np.integer)) and int(v)==-2**63:return 'math.mininteger'
    return native_lua(v)

def construct(a):
    if 0 in a.shape:return 'np.zeros('+lua(a.shape)+','+lua(str(a.dtype))+')'
    if a.ndim>1 and a.strides!=np.empty(a.shape,dtype=a.dtype,order='C').strides and a.strides==np.empty(a.shape,dtype=a.dtype,order='F').strides:
        return 'np.transpose('+construct(a.T.copy(order='C'))+')'
    values=a.astype(np.int64) if a.dtype.kind in 'Mm' else a
    return 'np.array('+lua(values)+','+lua(str(a.dtype))+')'

def operand(a):return construct(a) if isinstance(a,np.ndarray) else lua(a)

HEADER="""-- Original NumPy2.5.3 FFT helpers; Lua axes are one-based.
local np=require('luaray_core')
local cases,checks,max_error=0,0,0
local function eq(a,b,label,atol,rtol)
 checks=checks+1
 if type(b)=='table' then
  assert(type(a)=='table' and #a==#b,label..': shape')
  for i=1,#b do eq(a[i],b[i],label..'['..i..']',atol,rtol) end
 elseif type(b)=='userdata' then
  eq(a.real,b.real,label..'.real',atol,rtol);eq(a.imag,b.imag,label..'.imag',atol,rtol)
 elseif type(b)=='number' and atol then
  assert(type(a)=='number',label..': numeric value')
  if b~=b then assert(a~=a,label..': NaN')
  elseif b==math.huge or b==-math.huge then assert(a==b,label..': infinity')
  else local e=math.abs(a-b);if e>max_error then max_error=e end
   assert(e<=atol+rtol*math.abs(b),label..': '..tostring(a)..' != '..tostring(b)..' error '..e)
  end
 else assert(a==b,label..': '..tostring(a)..' != '..tostring(b)) end
end
"""

class Suite:
    def __init__(self,name):self.name,self.count,self.lines=name,0,[HEADER]
    def begin(self,label):
        label=label.replace('\n',' ');self.count+=1
        if (self.count-1)%250==0:
            if self.count>1:self.lines+=['end','chunk()','end']
            self.lines+=['do','local function chunk()']
        self.lines+=['-- '+str(self.count)+': '+label,'do'];return label
    def check(self,name,a,label,numeric=False):
        special=a.dtype.kind in 'Mm'
        value=a.astype(np.int64) if special else a
        expr="np.astype("+name+",'int64')" if special else name
        tol=',3e-6,3e-6' if numeric and a.dtype in [np.dtype('float32'),np.dtype('complex64')] else ',2e-12,2e-12' if numeric else ''
        self.lines.extend([f'eq({expr}:tolist(),{lua(value)},{lua(label)}{tol})',
                           f'eq({name}.shape,{lua(a.shape)},{lua(label+": shape")})',
                           f'eq({name}.strides,{lua(a.strides)},{lua(label+": strides")})',
                           f'eq({name}.dtype,{lua(str(a.dtype))},{lua(label+": dtype")})'])
    def result(self,label,call,error,result):
        self.lines.extend(['local ok,result=pcall(function() return '+call+' end)',
                           f'assert(ok=={str(error is None).lower()},{lua(label+": acceptance")}..": "..tostring(result))'])
        if error is None:self.check('result',result,label+': result',self.name!='fft_shift105')
    def end(self):self.lines+=['cases=cases+1','end']
    def finish(self):
        self.lines+=['end','chunk()','end',f'assert(cases=={self.count})',
                     "print('"+self.name+" differential: '..cases..' cases, '..checks..' checks passed; max absolute error '..max_error)"]
        (ROOT/'tests'/(self.name+'_differential_generated.lua')).write_text('\n'.join(self.lines)+'\n')
        print(self.name,self.count)

freq,shift,hermitian=[Suite(n) for n in ['fft_frequency105','fft_shift105','fft_hermitian105']]

def frequency_case(name,n,d=1.0,label=None):
    label=freq.begin(label or f'{name}/{n}/{repr(d)}')
    error=None;result=None
    try:
        with warnings.catch_warnings():
            warnings.simplefilter('ignore');result=getattr(np.fft,name)(n,d)
    except (ValueError,TypeError,ZeroDivisionError,OverflowError,RuntimeError) as exc:error=type(exc).__name__
    freq.lines+=['local spacing='+operand(d)]
    freq.result(label,'np.fft.'+name+'('+lua(n)+',spacing)',error,result)
    if isinstance(d,np.ndarray):freq.check('spacing',d,label+': spacing state')
    freq.end()

for name in ['fftfreq','rfftfreq']:
    for n in [-7,-2,-1,0,1,2,3,4,5,8,15,127]:
        for d in [1.0,.5,2,-.25,0,-0.0,float('inf'),float('nan'),1+2j]:frequency_case(name,n,d)
    for dtype in ['bool','int8','uint8','int32','int64','uint64','float16','float32','float64','complex64','complex128']:
        for n in [-1,0,1,3,4,15,127,128]:
            for value in [0,1,2]:frequency_case(name,n,np.array(value,dtype=dtype),f'{name}/typed/{dtype}/{n}/{value}')
    for dtype in ['float32','float64','complex64']:
        for n in [0,3,4]:
            for shape in [(1,),(3,),(2,1),(2,3)]:
                d=np.full(shape,.5,dtype=dtype)
                frequency_case(name,n,d,f'{name}/broadcast/{dtype}/{n}/{shape}')
    for n in [2.0,2.5,'4',True,False]:frequency_case(name,n)

def shift_case(name,base,view,axes):
    initial=base.copy();a,expr=view(base)
    label=shift.begin(f'{name}/{a.dtype}/{a.shape}/{axes}/{expr}')
    error=None;result=None
    try:result=getattr(np.fft,name)(a,axes=axes)
    except (TypeError,ValueError,IndexError,OverflowError) as exc:error=type(exc).__name__
    shift.lines+=['local base='+construct(initial),'local a='+expr]
    converted=None if axes is None else tuple(v+1 if v>=0 else v for v in axes) if isinstance(axes,tuple) else axes+1 if axes>=0 else axes
    call='np.fft.'+name+'(a'+('' if axes is None else ','+lua(converted))+')'
    shift.result(label,call,error,result)
    shift.check('base',base,label+': backing state');shift.end()

for name in ['fftshift','ifftshift']:
    for dtype in DTYPES:
        for view in VIEWS.values():
            for axes in [None,0,1,-1,-2,(),(0,1),(1,1),(0,0,0),3]:
                shift_case(name,base_array(dtype),view,axes)
    for shape in [(),(0,),(1,),(5,),(0,3),(2,0),(2,3,4),(1,2,1,3)]:
        for axes in [None,(),0,-1,(0,0)]:shift_case(name,np.zeros(shape,dtype='int32'),VIEWS['plain'],axes)

def hermitian_case(name,base,view,n,axis,norm,out=None,out_expr=None,positional=False,literal_input=False):
    initial=base.copy();a,expr=view(base)
    initial_out=out.copy() if out is not None else None
    label=hermitian.begin(f'{name}/{a.dtype}/{a.shape}/{expr}/n{n}/axis{axis}/{norm}/out{None if out is None else out.dtype}/{positional}')
    error=None;result=None
    try:
        with warnings.catch_warnings():
            warnings.simplefilter('ignore');result=getattr(np.fft,name)(a,n=n,axis=axis,norm=norm,out=out)
    except (TypeError,ValueError,IndexError,OverflowError,RuntimeError) as exc:error=type(exc).__name__
    hermitian.lines+=['local base='+construct(initial),'local a='+(lua(initial) if literal_input else expr)]
    if out is not None:hermitian.lines.append('local out='+(out_expr or construct(initial_out)))
    laxis=axis+1 if axis>=0 else axis
    if positional:
        call='np.fft.'+name+'(a,'+('nil' if n is None else lua(n))+','+lua(laxis)+','+('nil' if norm is None else lua(norm))+(',out' if out is not None else '')+')'
    else:
        call='np.fft.'+name+'(a,{axis='+lua(laxis)+(',n='+lua(n) if n is not None else '')+(',norm='+lua(norm) if norm is not None else '')+(',out=out' if out is not None else '')+'})'
    hermitian.result(label,call,error,result)
    if error is None and out is not None:hermitian.lines.append(f'assert(result==out,{lua(label+": output identity")})')
    hermitian.check('base',base,label+': source state')
    if out is not None:hermitian.check('out',out,label+': output state',True)
    hermitian.end()

for name in ['hfft','ihfft']:
    for dtype in ['bool','int16','int64','float16','float32','float64','complex64','complex128','U4']:
        for vname,view in VIEWS.items():
            base=base_array(dtype)
            if dtype.startswith('complex'):base=(base+1j*(np.arange(12).reshape(3,4)/4)).astype(dtype)
            for axis in [0,1,-1]:
                for n in [None,1,2,3,5,7]:
                    for norm in [None,'backward','forward','ortho']:
                        hermitian_case(name,base.copy(),view,n,axis,norm,positional=norm=='ortho')
    for shape in [(),(0,),(1,),(3,),(0,3),(2,0)]:
        for n in [None,0,-1,1,3]:
            hermitian_case(name,np.zeros(shape,dtype='float32'),VIEWS['plain'],n,-1,None,positional=True)
    for dtype in ['float32','float64','complex64','complex128']:
        for outdtype in ['float16','float32','float64','complex64','complex128']:
            base=np.arange(4).astype(dtype)
            if dtype.startswith('complex'):base=(base+1j*np.arange(4)).astype(dtype)
            n=4;out=np.full(4 if name=='hfft' else 3,9,dtype=outdtype)
            hermitian_case(name,base,VIEWS['plain'],n,0,'ortho',out=out,positional=True)
    for name_old in ['fft','ifft','rfft','irfft']:
        for norm in [None,'ortho','forward']:
            # Positional nil n must still retain the explicit axis/norm.
            hermitian_case(name_old,np.arange(12,dtype='float32').reshape(3,4),VIEWS['plain'],None,0,norm,positional=True)
    for n in [None,3,4]:
        hermitian_case(name,np.arange(4,dtype='float64'),VIEWS['plain'],n,0,None,literal_input=True)

# Zero strides and general permutations exercise constructor/ufunc order rules.
for name in ['fftshift','ifftshift']:
    for dtype in ['bool','int32','float32','complex128','U4']:
        for axis in [0,1]:
            def view(a):
                b=a[:1,:] if axis==0 else a[:,:1]
                expr='base:get(np.s(1,2),np.s())' if axis==0 else 'base:get(np.s(),np.s(1,2))'
                return np.broadcast_to(b,(3,4)),'np.broadcast_to('+expr+',{3,4})'
            for axes in [None,0,1,(0,1),(1,1)]:shift_case(name,base_array(dtype),view,axes)
    base=np.arange(24,dtype='int32').reshape(2,3,4)
    for order in [(1,2,0),(2,0,1)]:
        def view(a):return a.transpose(order),'np.transpose(base,'+lua(tuple(v+1 for v in order))+')'
        for axes in [None,0,1,2,(0,2)]:shift_case(name,base,view,axes)
for name in ['hfft','ihfft']:
    for axis in [0,1]:
        def view(a):
            b=a[:1,:] if axis==0 else a[:,:1]
            expr='base:get(np.s(1,2),np.s())' if axis==0 else 'base:get(np.s(),np.s(1,2))'
            return np.broadcast_to(b,(3,4)),'np.broadcast_to('+expr+',{3,4})'
        for transform_axis in [0,1]:
            for norm in ['backward','forward','ortho']:
                hermitian_case(name,base_array('float32'),view,4,transform_axis,norm)
    base=np.arange(24,dtype='float64').reshape(2,3,4)
    for order in [(1,2,0),(2,0,1)]:
        def view(a):return a.transpose(order),'np.transpose(base,'+lua(tuple(v+1 for v in order))+')'
        for axis in [0,1,2]:hermitian_case(name,base,view,5,axis,'ortho')

# Out layout, aliasing and cast precision are observed after real execution.
for name in ['hfft','ihfft']:
    for dtype in ['float16','float32','float64','complex64','complex128']:
        for n in [3,5,7]:
            for outdtype in ['float32','float64','complex64','complex128']:
                base=np.array([1.25,-2.5,3.75,0.125],dtype=dtype)
                if dtype.startswith('complex'):base=(base+np.array([.3,-.7,.2,1.1])*1j).astype(dtype)
                outsize=n if name=='hfft' else n//2+1
                owner=np.full(outsize*2,9,dtype=outdtype)
                out=owner[::2]
                out_expr="np.array("+lua(owner)+","+lua(str(owner.dtype))+"):get(np.s(1,nil,2))"
                hermitian_case(name,base,VIEWS['plain'],n,0,'ortho',out=out,out_expr=out_expr)
    for dtype in ['float32','float64']:
        base=np.array([1.25,-2.5,3.75,.125],dtype=dtype)
        if name=='hfft':
            hermitian_case(name,base,VIEWS['plain'],4,0,'ortho',out=base,out_expr='a')
        else:
            # Compatible complex output cannot alias this real input without
            # unsupported dtype reinterpretation; keep that unclaimed.
            pass
    for readonly in [False,True]:
        base=np.arange(4,dtype='float64')
        out=np.zeros(4 if name=='hfft' else 3,dtype='complex128')
        if readonly:
            out=np.broadcast_to(out[:1],out.shape)
            expr="np.broadcast_to(np.array({np.complex(0,0)},'complex128'),{"+str(out.size)+"})"
        else:
            out=out[:-1];expr=construct(out)
        hermitian_case(name,base,VIEWS['plain'],4,0,None,out=out,out_expr=expr)

for name in ['fft','ifft','rfft','irfft']:
    for dtype in ['float16','float32','float64','complex64','complex128','U4']:
        for outdtype in ['float32','float64','complex64','complex128']:
            base=np.array([1.25,-2.5,3.75,.125],dtype=dtype)
            for n in [3,5]:
                size=n//2+1 if name=='rfft' else n
                out=np.zeros(size,dtype=outdtype)
                hermitian_case(name,base,VIEWS['plain'],n,0,'ortho',out=out)

for suite in [freq,shift,hermitian]:suite.finish()
