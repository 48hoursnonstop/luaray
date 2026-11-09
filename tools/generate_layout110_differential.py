#!/usr/bin/env python3
"""Original NumPy 2.5.3 layout, sharing, copy rules and actual writes."""
from pathlib import Path
import warnings
import numpy as np
from generate_binary109_differential import lua,array as plain_array,dtype
from generate_write98_differential import HEADER
assert np.__version__=='2.5.3'
ROOT=Path(__file__).resolve().parents[1]

def array(a):
    a=np.asarray(a)
    if a.dtype.kind in 'Mm':
        if not a.size:return 'np.empty('+lua(a.shape)+','+lua(str(a.dtype))+')'
        return 'np.array('+lua(a.astype('int64'))+','+lua(str(a.dtype))+')'
    return plain_array(a)

def views(base):
    yield 'base',base,'base'
    yield 'F',np.asfortranarray(base),'np.asfortranarray(base)'
    yield 'transpose',base.T,'np.transpose(base)'
    if base.ndim:
        yield 'reverse_first',base[::-1],'np.flip(base,1)'
        yield 'reverse_last',np.flip(base,-1),'np.flip(base,-1)'
        yield 'step_first',base[::2],'base:get(np.s(1,nil,2))'
        sel=(slice(None),)*(base.ndim-1)+(slice(None,None,2),)
        yield 'step_last',base[sel],'base:get('+','.join(['np.s()']*(base.ndim-1)+['np.s(1,nil,2)'])+')'
        if base.size:
            yield 'broadcast',np.broadcast_to(base[:1],base.shape),'np.broadcast_to(base:get(np.s(1,2)),base.shape)'
            one=base[(slice(0,1),)*base.ndim]
            yield 'constant',np.broadcast_to(one,base.shape),'np.broadcast_to(base:get('+','.join(['np.s(1,2)']*base.ndim)+'),base.shape)'
    yield 'newaxis',np.expand_dims(base,0),'np.expand_dims(base,1)'
    if base.ndim==3:
        yield 'permuted',base.transpose(1,2,0),'np.transpose(base,{2,3,1})'

class Suite:
    def __init__(self,name):self.name,self.count,self.lines=name,0,[HEADER.replace('tools/generate_write98_differential.py','tools/generate_layout110_differential.py')]
    def check(self,name,a,label):
        a=np.asarray(a)
        if a.dtype.kind in 'Mm':
            self.lines.append(f'eq(np.astype({name},"int64"):tolist(),{lua(a.astype("int64"))},{lua(label+": ticks")})')
        elif a.dtype.kind in 'iu' and a.dtype.itemsize==8:
            self.lines.append(f'eq(np.astype({name},"U40"):tolist(),{lua(a.astype("U40"))},{lua(label+": integer strings")})')
        else:self.lines.append(f'eq({name}:tolist(),{lua(a)},{lua(label+": values")})')
        for attr,value in [('shape',a.shape),('strides',a.strides),('dtype',dtype(a.dtype))]:
            self.lines.append(f'eq({name}.{attr},{lua(value)},{lua(label+": "+attr)})')
    def case(self,base,view,op,order,shape=None,copy=None,method=False,raw=None):
        self.count+=1
        if (self.count-1)%60==0:
            if self.count>1:self.lines+=['end','chunk()','end']
            self.lines+=['do','local function chunk()']
        base=np.array(base,copy=True);vname=view
        name,a,expr=next(v for v in views(base) if v[0]==vname)
        operand=a if raw is None else raw
        self.lines+=['do','local base='+array(base),'local a='+expr]
        label=f'{op}/{dtype(base.dtype)}{base.shape}/{name}/{order}/{shape}/copy{copy}/method{method}/raw{raw is not None}'
        try:
            with warnings.catch_warnings():
                warnings.simplefilter('ignore')
                if op=='reshape':result=np.reshape(operand,shape,order=order,copy=copy)
                elif op=='ravel':result=np.ravel(operand,order=order)
                else:result=a.flatten(order=order)
            ok=True
        except (ValueError,TypeError,OverflowError):ok=False
        if method:call='a:'+op+'('
        else:call='np.'+op+'('+('a' if raw is None else lua(raw))+','
        opts=['order='+lua(order)]
        if op=='reshape':
            call+=lua(shape)+','
            if copy is not None:opts+=['copy='+lua(copy)]
        call+='{'+','.join(opts)+'})'
        self.lines+=['-- '+str(self.count)+': '+label,
                     'local ok,result=pcall(function()return '+call+'end)',
                     'assert(ok=='+str(ok).lower()+','+lua(label+': acceptance')+'..": "..tostring(result))']
        if ok:
            self.check('result',result,label+': initial')
            for var,other in [('a',a),('base',base)]:
                self.lines+=['eq(np.shares_memory(result,'+var+'),'+lua(np.shares_memory(result,other))+','+lua(label+': shares '+var)+')']
            self.lines+=['eq(rawequal(result,a),false,'+lua(label+': new userdata')+')']
            if result.dtype.kind in 'SU':fill=np.array('Z',dtype=result.dtype)
            elif result.dtype.kind=='c':fill=np.array(7-2j,dtype=result.dtype)
            else:fill=np.array(7,dtype=result.dtype)
            try:np.copyto(result,fill,casting='unsafe');writable=True
            except (TypeError,ValueError):writable=False
            self.lines+=['local write_ok=pcall(function()np.copyto(result,'+array(fill)+',"unsafe")end)',
                         'eq(write_ok,'+lua(writable)+','+lua(label+': writeability')+')']
            self.check('result',result,label+': after write')
        self.check('a',a,label+': input state')
        self.check('base',base,label+': backing state')
        self.lines+=['cases=cases+1','end']
    def write(self):
        self.lines+=['end','chunk()','end',f'assert(cases=={self.count})',
                     'print("'+self.name+': "..cases.." cases; "..checks.." checks passed")']
        (ROOT/'tests'/f'{self.name}_differential_generated.lua').write_text('\n'.join(self.lines)+'\n')
        print(self.name,self.count)

def base_array(shape,dt):
    a=np.arange(np.prod(shape,dtype=int)).reshape(shape)
    kind=np.dtype(dt).kind
    if kind=='b':a=a%2
    elif kind=='f':a=a+.25
    elif kind=='c':a=a+1j*(a-2)
    return a.astype(dt)

def main():
    flat,ravel,reshape=Suite('flatten110'),Suite('ravel110'),Suite('reshape110')
    dtypes=['bool','int8','uint64','float16','float32','float64','complex64','S4','U4','>U4','datetime64[ms]','timedelta64[h]']
    for dt in dtypes:
        for original_shape in [(2,3,4),(2,1,3),(2,0,3),(),(1,),(6,)]:
            base=base_array(original_shape,dt)
            for name,a,_ in views(base):
                for order in ['C','F','A','K']:
                    flat.case(base,name,'flatten',order,method=True)
                    ravel.case(base,name,'ravel',order,method=(order in ['F','K']))
                # Broad reshape views are dtype-independent; exercise every
                # dtype once per shape/layout and all copy modes in two types.
                shapes=[(a.size,),(-1,),(1,a.size),(a.size,1),a.shape]
                if a.size and a.size%2==0:shapes+=[(2,a.size//2)]
                if dt in ['int8','float64']:
                    shapes+=[(-2,),(1,-1,1),(),(-1,-1),(0,-1),(5,),
                             (0,2**62,4) if a.size==0 else (2**62,4)]
                for newshape in dict.fromkeys(shapes):
                    for order in ['C','F','A']:
                        for copy in [None,False,True] if dt in ['int8','float64'] else [None]:
                            reshape.case(base,name,'reshape',order,shape=newshape,copy=copy,method=(copy is not True))
    for raw in [1,True,2.5,[1,2,3],[[1,2],[3,4]],[]]:
        base=np.asarray(raw)
        for order in ['C','F','A','K']:
            ravel.case(base,'base','ravel',order,raw=raw)
        for order in ['C','F','A','K']:
            for copy in [None,False,True]:reshape.case(base,'base','reshape',order,shape=(-1,),copy=copy,raw=raw)
    for s in [flat,ravel,reshape]:s.write()

if __name__=='__main__':main()
