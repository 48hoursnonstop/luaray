#!/usr/bin/env python3
"""Original NumPy 2.5.3 binary numeric and Lua input-coercion references."""
from pathlib import Path
import warnings
import re
import numpy as np
from generate_write98_differential import lua as numeric_lua
from generate_unary108_differential import HEADER,array as numeric_array,dtype
assert np.__version__=='2.5.3'
ROOT=Path(__file__).resolve().parents[1]

def lua(x):
    if isinstance(x,np.ndarray):return lua(x.tolist())
    if isinstance(x,(list,tuple)):return '{'+','.join(lua(v) for v in x)+'}'
    if isinstance(x,bytes):
        return '"'+''.join(chr(v) if 32<=v<127 and v not in [34,92] else '\\'+f'{v:03d}' for v in x)+'"'
    value=numeric_lua(x)
    return re.sub(r'\\u([0-9a-fA-F]{4})',lambda m:'\\'+f'{int(m[1],16):03d}',value)

def array(a):
    a=np.asarray(a)
    if a.size and a.dtype.kind in 'SU':
        return 'np.array('+lua(a)+','+lua(dtype(a.dtype))+')'
    return numeric_array(a)

class Suite:
    def __init__(self,name):
        self.name,self.count,self.lines=name,0,[HEADER.replace('numeric loops','binary loops')]
    def check(self,name,a,label,rtol=0):
        a=np.asarray(a)
        if a.dtype.kind in 'iu' and a.dtype.itemsize==8:
            self.lines.append(f'eq(np.astype({name},"U40"):tolist(),{lua(a.astype("U40"))},{lua(label+": integer strings")})')
        else:self.lines.append(f'eq({name}:tolist(),{lua(a)},{lua(label+": values")},{rtol})')
        for attr,value in [('shape',a.shape),('strides',a.strides),('dtype',dtype(a.dtype))]:
            self.lines.append(f'eq({name}.{attr},{lua(value)},{lua(label+": "+attr)})')
    def case(self,op,a,b,*,raw_a=False,raw_b=False,layout='C',mode='new',out_dtype='float64',mask=False):
        self.count+=1
        if (self.count-1)%80==0:
            if self.count>1:self.lines+=['end','chunk()','end']
            self.lines+=['do','local function chunk()']
        aa,bb=np.array(a,copy=True),np.array(b,copy=True)
        self.lines+=['do','local abase='+array(aa),'local bbase='+array(bb)]
        operands=[];exprs=[]
        for original,base,raw,var in [(a,aa,raw_a,'a'),(b,bb,raw_b,'b')]:
            if raw:operands.append(original);exprs.append(lua(original));continue
            name=var+'base'
            if layout=='F':value=np.asfortranarray(base);expr='np.asfortranarray('+name+')'
            elif layout=='T':value=base.T;expr='np.transpose('+name+')'
            elif layout=='reverse' and base.ndim:value=base[::-1];expr='np.flip('+name+',1)'
            elif layout=='step' and base.ndim:value=base[::2];expr=name+':get(np.s(1,nil,2))'
            else:value=base;expr=name
            self.lines+=['local '+var+'='+expr];operands.append(value);exprs.append(var)
        av,bv=operands
        try:shape=np.broadcast_shapes(np.shape(av),np.shape(bv))
        except ValueError:shape=(2,3)
        out=None;kwargs={};opts=[]
        if mode=='inplace':out=av;out_expr=exprs[0]
        elif mode=='overlap':out=aa[::-1];out_expr='np.flip(abase,1)'
        elif mode=='readonly':
            out=np.broadcast_to(np.array(7,dtype=out_dtype),shape)
            out_expr='np.broadcast_to(np.array(7,'+lua(dtype(np.dtype(out_dtype)))+'),'+lua(shape)+')'
        elif mode=='out':
            out=np.full(shape,7,dtype=out_dtype)
            out_expr='np.full('+lua(shape)+',7,'+lua(dtype(out.dtype))+')'
        if out is not None:
            self.lines+=['local out='+out_expr];opts+=['out=out'];kwargs['out']=out
        if mask:
            m=(np.arange(np.prod(shape,dtype=int)).reshape(shape)%3)!=1
            self.lines+=['local where='+array(m)];opts+=['where=where'];kwargs['where']=m
        label=f'{op}/{dtype(aa.dtype)}{aa.shape}/{dtype(bb.dtype)}{bb.shape}/{layout}/{mode}/{out_dtype}/mask{mask}/raw{raw_a},{raw_b}'
        try:
            with warnings.catch_warnings(),np.errstate(all='ignore'):
                warnings.simplefilter('ignore');result=getattr(np,op)(av,bv,**kwargs)
            ok=True
        except (TypeError,ValueError,OverflowError):ok=False
        tail=',{'+','.join(opts)+'}' if opts else ''
        self.lines+=['-- '+str(self.count)+': '+label,
            'local ok,result=pcall(function()return np.'+op+'('+','.join(exprs)+tail+')end)',
            'assert(ok=='+str(ok).lower()+','+lua(label+': acceptance')+'..": "..tostring(result))']
        rtol=2e-12 if op in ['float_power','power','arctan2','hypot'] else 0
        if ok:
            self.check('result',np.asarray(result),label+': result',rtol)
            if out is not None:self.lines+=['eq(rawequal(result,out),true,'+lua(label+': identity')+')']
        if out is not None:self.check('out',out,label+': output',rtol)
        if not raw_a:self.check('a',av,label+': input a',rtol)
        if not raw_b:self.check('b',bv,label+': input b',rtol)
        self.check('abase',aa,label+': a backing',rtol)
        self.check('bbase',bb,label+': b backing',rtol)
        self.lines+=['cases=cases+1','end']
    def write(self):
        self.lines+=['end','chunk()','end',f'assert(cases=={self.count})',
                    'print("'+self.name+': "..cases.." cases; "..checks.." checks; max_error="..max_error.." max_relative_error="..max_relative_error)']
        (ROOT/'tests'/f'{self.name}_differential_generated.lua').write_text('\n'.join(self.lines)+'\n')
        print(self.name,self.count)

DTYPES=['bool','int8','uint8','int16','uint16','int32','uint32','int64','uint64',
        'float16','float32','float64','longdouble','complex64','complex128','clongdouble','S4','U4']
def values(t):
    dt=np.dtype(t)
    if dt.kind=='c':return np.array([[-2+1j,-1-2j,0j],[1+.5j,2-1j,3+2j]],dt)
    if dt.kind=='f':return np.array([[-2.5,-1.,-0.0],[.5,2.,3.5]],dt)
    if dt.kind=='i':return np.array([[-3,-1,0],[1,2,3]],dt)
    return np.array([[0,1,2],[1,2,3]],dt)

def main():
    rng=np.random.default_rng(109)
    for op in ['fmod','float_power']:
        s=Suite(op+'109')
        for ta in DTYPES:
            for tb in DTYPES:s.case(op,values(ta),values(tb))
            a=values(ta);b=values(ta)
            for layout in ['C','F','T','reverse','step']:
                s.case(op,a,b,layout=layout)
                s.case(op,a,b,layout=layout,mode='inplace')
                s.case(op,a,b,layout=layout,mode='inplace',mask=True)
            s.case(op,a,b,mode='overlap')
            s.case(op,a,b,mode='readonly')
            for dt in ['int8','float16','float32','float64','complex128','bool']:
                for mask in [False,True]:s.case(op,a,b,mode='out',out_dtype=dt,mask=mask)
            for v in [False,True,-1,0,2,300,65536,.5,1e40,1+2j]:
                s.case(op,a,v,raw_b=True)
                s.case(op,v,a,raw_a=True)
            s.case(op,np.asarray(a.flat[0]),np.asarray(b.flat[1]))
            s.case(op,np.empty((2,0,3),ta),np.empty((1,0,1),ta))
            s.case(op,a,np.ones((3,2),ta))
            if np.dtype(ta).kind in 'iu':
                ii=np.iinfo(ta);extreme=np.array([ii.min,ii.min+1,ii.max-1,ii.max,0,1],ta)
                for v in [-1,0,1,2,3]:
                    s.case(op,extreme,v,raw_b=True)
                    s.case(op,v,extreme,raw_a=True)
            elif np.dtype(ta).kind in 'fc':
                special=np.array([0.,-0.,np.inf,-np.inf,np.nan,1e-6,-1e-6],ta)
                for v in [-1.,0.,.5,2.]:s.case(op,special,v,raw_b=True)
        for ta in ['float16','float32','float64','longdouble','complex64','complex128']:
            a=rng.normal(size=(3,129));b=rng.normal(size=(3,129))
            if np.dtype(ta).kind=='c':a=a+1j*rng.normal(size=a.shape);b=b+1j*rng.normal(size=b.shape)
            for layout in ['C','F','T','reverse','step']:s.case(op,a.astype(ta),b.astype(ta),layout=layout)
        # Explicit broadcasting rather than only matching input shapes.
        for ta in ['int8','float16','float32','float64','complex64']:
            for tb in ['int16','float32','float64']:
                s.case(op,np.array([[1],[2]],ta),np.array([[1,2,3]],tb))
                s.case(op,np.array([[1],[2]],ta),np.array([[1,2,3]],tb),mode='out',mask=True)
        s.write()
    s=Suite('binary_coercion109')
    names=['add','subtract','multiply','true_divide','equal','not_equal','less','less_equal','greater','greater_equal',
           'logical_and','logical_or','logical_xor','maximum','minimum','floor_divide','remainder','power',
           'bitwise_and','bitwise_or','bitwise_xor','fmax','fmin','copysign','arctan2','hypot','fmod','float_power']
    pairs=[(1,2),(True,False),(.5,2.),(-1,3),(1+2j,2),(1,2+1j),([1,2,3],2),
           (2,[1,2,3]),([[1.5,-.5],[0.,2.5]],[[1],[2]]),([True,False],True),
           ([],1),('2',3),('a','b')]
    for name in names:
        for a,b in pairs:
            s.case(name,a,b,raw_a=True,raw_b=True)
            s.case(name,a,b,raw_a=True,raw_b=True,mode='out',out_dtype='complex128',mask=True)
        s.case(name,[1,2,3],np.array([1,2,3],'int8'),raw_a=True)
        s.case(name,np.array([1,2,3],'float32'),[1,2,3],raw_b=True)
    s.write()
    s=Suite('string_add109')
    for ta in ['S1','S4','S9','U1','U4','U9','>U4']:
        for tb in ['S1','S4','U1','U4','>U4']:
            va=[['a','b\x00x',''],['A\x00','0','false']]
            vb=[['B','\x00c','z'],['','E','N\x00']]
            a=np.array(va,ta);b=np.array(vb,tb)
            if a.dtype.kind=='U':a[1,0]='λ';a[1,1]='🙂'
            for layout in ['C','F','T','reverse','step']:
                s.case('add',a,b,layout=layout)
                s.case('add',a,b,layout=layout,mode='inplace')
                s.case('add',a,b,layout=layout,mode='inplace',mask=True)
            s.case('add',a,b,mode='overlap')
            for out_dt in ['S2','S16','U2','U16','>U8','float64']:
                for mask in [False,True]:s.case('add',a,b,mode='out',out_dtype=out_dt,mask=mask)
            # Lua raw strings defer to an existing S/U array's class.
            scalar=b'!' if a.dtype.kind=='S' else '!'
            s.case('add',a,scalar,raw_b=True)
            s.case('add',scalar,a,raw_a=True)
    for dt in ['S1073741824','U536870911']:
        s.case('add',np.empty((0,),dt),np.empty((0,),dt))
    for name in ['logical_and','logical_or','logical_xor']:
        for dt in ['float16','float32','float64','complex64','int8','U4','S4']:
            for v in [1e-100,-1e-100,1e100,1e-100j,'','0','False']:
                s.case(name,values(dt),v,raw_b=True)
                s.case(name,v,values(dt),raw_a=True)
    s.write()

if __name__=='__main__':main()
