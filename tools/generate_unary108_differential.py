#!/usr/bin/env python3
"""Original NumPy 2.5.3 numeric loops, masks, output casts and shared views."""
from pathlib import Path
import warnings
import numpy as np
from generate_write98_differential import lua
assert np.__version__=='2.5.3'
ROOT=Path(__file__).resolve().parents[1]

def dtype(dt):
    return {'float128':'longdouble'}.get(str(dt),str(dt))

def array(a):
    a=np.asarray(a)
    if 0 in a.shape:return 'np.empty('+lua(a.shape)+','+lua(dtype(a.dtype))+')'
    if a.dtype.kind in 'iu' and a.dtype.itemsize==8:
        return 'np.astype(np.array('+lua(a.astype('U40'))+'),'+lua(dtype(a.dtype))+')'
    return 'np.array('+lua(a)+','+lua(dtype(a.dtype))+')'

HEADER='''-- Original NumPy 2.5.3 oracle. Lua scalar results are typed 0-D arrays.
local np=require('luaray_core')
local cases,checks,max_error,max_relative_error=0,0,0,0
local function eq(a,b,label,rtol)
 checks=checks+1
 if type(b)=='table' then
  assert(type(a)=='table' and #a==#b,label..': shape')
  for i=1,#b do eq(a[i],b[i],label..'['..i..']',rtol) end
 elseif type(b)=='userdata' then eq(a.real,b.real,label..'.real',rtol);eq(a.imag,b.imag,label..'.imag',rtol)
 elseif type(b)=='number' then
  assert(type(a)=='number',label..': numeric')
  if b~=b then assert(a~=a,label..': NaN')
  elseif b==math.huge or b==-math.huge then assert(a==b,label..': infinity')
  elseif b==0 then assert(a==0 and 1/a==1/b,label..': signed zero')
  else
   local e=math.abs(a-b);max_error=math.max(max_error,e)
   max_relative_error=math.max(max_relative_error,e/math.abs(b))
   assert(e<=(rtol or 0)*math.abs(b),label..': '..tostring(a)..' != '..tostring(b))
  end
 else assert(a==b,label..': '..tostring(a)..' != '..tostring(b)) end
end
'''

class Suite:
    def __init__(self,name):self.name,self.lines,self.count=name,[HEADER],0
    def check(self,name,a,label,rtol=0):
        a=np.asarray(a)
        if a.dtype.kind in 'iu' and a.dtype.itemsize==8:
            self.lines.append(f'eq(np.astype({name},"U40"):tolist(),{lua(a.astype("U40"))},{lua(label+": integer strings")})')
        else:self.lines.append(f'eq({name}:tolist(),{lua(a)},{lua(label+": values")},{rtol})')
        for attr,value in [('shape',a.shape),('strides',a.strides),('dtype',dtype(a.dtype))]:
            self.lines.append(f'eq({name}.{attr},{lua(value)},{lua(label+": "+attr)})')
    def case(self,name,base,layout='C',mode='new',out_dtype=None,mask=False,raw=None,exact=False):
        self.count+=1
        if (self.count-1)%80==0:
            if self.count>1:self.lines+=['end','chunk()','end']
            self.lines+=['do','local function chunk()']
        base=np.array(base,copy=True)
        self.lines+=['do','local base='+array(base)]
        if layout=='F':a=np.asfortranarray(base);expr='np.asfortranarray(base)'
        elif layout=='T':a=base.T;expr='np.transpose(base)'
        elif layout=='reverse':a=base[::-1];expr='np.flip(base,1)'
        elif layout=='step':a=base[::2];expr='base:get(np.s(1,nil,2))'
        elif layout=='broadcast':a=np.broadcast_to(base[0],base.shape);expr='np.broadcast_to(base[1],base.shape)'
        else:a=base;expr='base'
        self.lines+=['local a='+expr]
        out=None;out_expr=None;opts=[];kwargs={}
        if mode=='inplace':out=a;out_expr='a'
        elif mode=='overlap':
            # Source and destination share backing bytes with reversed order.
            out=base[::-1];out_expr='np.flip(base,1)'
        elif mode=='readonly':
            out=np.broadcast_to(np.array(7,dtype=out_dtype),a.shape)
            out_expr='np.broadcast_to(np.array(7,'+lua(dtype(np.dtype(out_dtype)))+'),a.shape)'
        elif mode=='out':
            out=np.full(a.shape,7,dtype=out_dtype);out_expr='np.full(a.shape,7,'+lua(dtype(out.dtype))+')'
        if out is not None:
            self.lines+=['local out='+out_expr];opts+=['out=out'];kwargs['out']=out
        if mask:
            m=(np.arange(a.size).reshape(a.shape)%3)!=1
            self.lines+=['local where='+array(m)];opts+=['where=where'];kwargs['where']=m
        operand=a if raw is None else raw
        input_expr='a' if raw is None else lua(raw)
        label=f'{name}/{dtype(base.dtype)}/{base.shape}/{layout}/{mode}/{out_dtype}/mask{mask}/raw{raw is not None}'
        try:
            with warnings.catch_warnings(),np.errstate(all='ignore'):
                warnings.simplefilter('ignore');result=getattr(np,name)(operand,**kwargs)
            ok=True
        except (TypeError,ValueError,OverflowError):ok=False
        options=',{'+','.join(opts)+'}' if opts else ''
        self.lines+=['-- '+str(self.count)+': '+label,
                     'local ok,result=pcall(function()return np.'+name+'('+input_expr+options+')end)',
                     'assert(ok=='+str(ok).lower()+','+lua(label+': acceptance')+'..": "..tostring(result))']
        # SIMD complex square may use FMA while the native scalar path uses
        # separate products. Only these two operations use a relative budget.
        rtol=0
        if not exact and name in ['square','reciprocal'] and np.asarray(operand).dtype.kind=='c':
            rtol=6e-7 if np.asarray(operand).dtype.itemsize==8 else 2e-15
        if ok:
            self.check('result',np.asarray(result),label+': result',rtol)
            if out is not None:self.lines+=['eq(rawequal(result,out),true,'+lua(label+': output identity')+')']
        if out is not None:self.check('out',out,label+': output state',rtol)
        self.check('a',a,label+': source state',rtol)
        self.check('base',base,label+': backing state',rtol)
        self.lines+=['cases=cases+1','end']
    def write(self):
        self.lines+=['end','chunk()','end',f'assert(cases=={self.count})',
                     'print("'+self.name+': "..cases.." cases; "..checks.." checks; max_error="..max_error.." max_relative_error="..max_relative_error)']
        (ROOT/'tests'/f'{self.name}_differential_generated.lua').write_text('\n'.join(self.lines)+'\n')
        print(self.name,self.count)

def main():
    rng=np.random.default_rng(108)
    groups={'rounding108':['floor','ceil','trunc','rint','fabs'],
            'algebra108':['conjugate','square','reciprocal','conj'],
            'angles108':['degrees','radians','rad2deg','deg2rad']}
    dtypes=['bool','int8','uint8','int16','uint16','int32','uint32','int64','uint64',
            'float16','float32','float64','longdouble','complex64','complex128','clongdouble','U4','S4']
    for group,names in groups.items():
        s=Suite(group)
        for name in names:
            for t in dtypes:
                dt=np.dtype(t)
                if dt.kind=='c':base=np.array([[-2.5+1.25j,-1-0j,0j],[.5-.75j,2+3j,7-2j]],dt)
                elif dt.kind=='f':base=np.array([[-2.5,-.5,-0.0],[0,.5,2.5]],dt)
                elif dt.kind=='i':base=np.array([[-3,-1,0],[1,2,7]],dt)
                else:base=np.array([[0,1,2],[3,4,7]],dt)
                for layout in ['C','F','T','reverse','step','broadcast']:
                    s.case(name,base,layout)
                for out_dt in ['int8','float32','float64','complex128','bool']:
                    for mask in [False,True]:s.case(name,base,mode='out',out_dtype=out_dt,mask=mask)
                s.case(name,base,mode='inplace')
                s.case(name,base,mode='inplace',mask=True)
                s.case(name,base,mode='overlap')
                s.case(name,base,mode='readonly',out_dtype='float64')
                # Preserve zero-dimensional and zero-size allocation semantics.
                s.case(name,np.array(base.flat[0],dt))
                s.case(name,np.empty((2,0,3),dt))
                if dt.kind in 'iu':
                    ii=np.iinfo(dt);extreme=np.array([ii.min,ii.min+1,ii.max-1,ii.max,0,1],dt)
                    s.case(name,extreme)
                elif dt.kind in 'fc':
                    special=np.array([0.0,-0.0,np.inf,-np.inf,np.nan,1e-6,-1e-6],dt)
                    s.case(name,special)
            for raw in [True,False,0,1,-1,2.5,-.5,[1,2,3],[[1.5,-.5],[0.,2.5]],1+2j]:
                s.case(name,np.asarray(raw),raw=raw)
            for dt in ['float16','float32','float64','complex64','complex128']:
                data=rng.normal(size=257)
                if np.dtype(dt).kind=='c':data=data+1j*rng.normal(size=257)
                s.case(name,data.astype(dt))
            if name=='square':
                # Near-cancelling real components expose a fused-vs-unfused
                # result. Require exact agreement for both dispatch paths.
                for dt in ['complex64','complex128']:
                    data=(rng.normal(size=(17,5))+1j*rng.normal(size=(17,5))).astype(dt)
                    for layout in ['C','F','T','reverse','step','broadcast']:
                        s.case(name,data,layout,exact=True)
                        s.case(name,data,layout,mode='inplace',exact=True)
                        s.case(name,data,layout,mode='inplace',mask=True,exact=True)
                    s.case(name,data,mode='overlap',exact=True)
            bits=np.unique(np.concatenate([np.arange(0,65536,29,dtype=np.uint16),
                np.array([1,0x3ff,0x400,0x7bff,0x7c00,0x7fff,0x8000,0xfbff,0xfc00],np.uint16)]))
            s.case(name,bits.view(np.float16))
        s.write()

if __name__=='__main__':main()
