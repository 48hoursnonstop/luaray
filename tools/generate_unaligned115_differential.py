#!/usr/bin/env python3
"""Original NumPy2.5.3 arithmetic and reductions on byte-offset views."""
import warnings
import numpy as np
from generate_layout110_differential import Suite,views
from generate_time_scale113_differential import array
from generate_binary109_differential import lua,dtype
assert np.__version__=='2.5.3'
class Unaligned(Suite):
    def __init__(self,name):
        super().__init__(name)
        self.lines[0]=self.lines[0].replace('generate_layout110_differential.py','generate_unaligned115_differential.py')
    def case(self,original,view,op,offset,output=False):
        self.count+=1
        if (self.count-1)%60==0:
            if self.count>1:self.lines+=['end','chunk()','end']
            self.lines+=['do','local function chunk()']
        raw=np.zeros(original.nbytes+offset,'uint8');base=raw[offset:].view(original.dtype).reshape(original.shape);np.copyto(base,original)
        _,a,expr=next(v for v in views(base) if v[0]==view)
        self.lines+=['do','local raw=np.zeros({'+str(original.nbytes+offset)+'},"uint8")',
                     'local base=raw:get(np.s('+str(offset+1)+')):view('+lua(dtype(original.dtype))+'):reshape('+lua(original.shape)+')',
                     'np.copyto(base,'+array(original)+')','local a='+expr]
        out=None;kwargs={};binary=op in ['add','multiply','minimum','maximum','equal','logical_and']
        if op in ['sum','prod','mean']:kwargs['keepdims']=True;tail='{keepdims=true}'
        elif op in ['cumsum','cumprod','add_accumulate','add_reduceat']:tail=''
        else:tail=''
        if output:
            out_raw=np.zeros(a.nbytes+1,'uint8');out=out_raw[1:].view(a.dtype).reshape(a.shape)
            self.lines+=['local out_raw=np.zeros({a.nbytes+1},"uint8")',
                         'local out=out_raw:get(np.s(2)):view(a.dtype):reshape(a.shape)']
            kwargs['out']=out
        if op=='add_reduceat':call='np.add_reduceat(a,np.array({1,2},"int64"),{axis=1})'
        elif op=='add_accumulate':call='np.add_accumulate(a,1)'
        else:
            call='np.'+op+'(a'+(',a' if binary else '')
            if output:call+=',{out=out}'
            elif tail:call+=','+tail
            call+=')'
        label=f'unaligned/{dtype(a.dtype)}{a.shape}/{view}/{op}/offset{offset}/out{output}'
        try:
            with warnings.catch_warnings(),np.errstate(all='ignore'):
                warnings.simplefilter('ignore')
                if op=='add_reduceat':result=np.add.reduceat(a,[0,1],axis=0)
                elif op=='add_accumulate':result=np.add.accumulate(a,axis=0)
                else:result=getattr(np,op)(a,a,**kwargs) if binary else getattr(np,op)(a,**kwargs)
            ok=True
        except (TypeError,ValueError,OverflowError,IndexError):ok=False
        self.lines+=['local ok,result=pcall(function()return '+call+'end)',
                     'assert(ok=='+lua(ok)+','+lua(label+': acceptance')+'..": "..tostring(result))']
        if ok:
            self.check('result',np.asarray(result),label+': result')
            if out is not None:self.lines+=['eq(rawequal(result,out),true,'+lua(label+': output identity')+')']
        if out is not None:self.check('out',out,label+': output state')
        self.check('a',a,label+': input state');self.check('base',base,label+': base state')
        self.lines+=['cases=cases+1','end']

def main():
    s=Unaligned('unaligned115')
    for dt in ['int8','uint8','int16','uint16','int32','uint32','int64','uint64','float16','float32','float64','longdouble','complex64','complex128','clongdouble']:
        a=np.arange(1,7).reshape(2,3).astype(dt)
        if a.dtype.kind in 'fc':a=a/4
        # Reassert original dtype (NumPy0d/float division rules are independent).
        a=a.astype(dt)
        for offset in [1,3]:
            for name,_,_ in views(a):
                for op in ['positive','negative','absolute','conjugate','square','rint','add','multiply','minimum','maximum','equal','logical_and','sum','prod','mean','cumsum','cumprod','add_accumulate','add_reduceat']:
                    s.case(a,name,op,offset)
            for op in ['square','rint','add','multiply','minimum']:
                s.case(a,'base',op,offset,True)
    s.write()
if __name__=='__main__':main()
