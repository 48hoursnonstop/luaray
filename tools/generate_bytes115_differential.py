#!/usr/bin/env python3
"""Original NumPy2.5.3 bit views, byte traversal and real shared writes.

All backing bytes originate as deterministic uint8 arrays. No floating padding
or invalid Unicode value is converted to text to decide compatibility.
"""
from pathlib import Path
import warnings
import numpy as np
from generate_layout110_differential import Suite,views
from generate_binary109_differential import lua,dtype,array
from generate_write98_differential import HEADER
assert np.__version__=='2.5.3'
ROOT=Path(__file__).resolve().parents[1]
class Bytes(Suite):
    def __init__(self,name):
        super().__init__(name)
        self.lines=[HEADER.replace('tools/generate_write98_differential.py','tools/generate_bytes115_differential.py')]
    def check(self,name,a,label):
        for attr,value in [('shape',a.shape),('strides',a.strides),('dtype',dtype(a.dtype)),('itemsize',a.itemsize),('nbytes',a.nbytes)]:
            self.lines+=['eq('+name+'.'+attr+','+lua(value)+','+lua(label+': '+attr)+')']
        for order in ['C','F','A','K']:
            self.lines+=['eq('+name+':tobytes('+lua(order)+'),'+lua(a.tobytes(order))+','+lua(label+': bytes '+order)+')']
    def case(self,old,target,shape,view,*,offset=0):
        self.count+=1
        if (self.count-1)%40==0:
            if self.count>1:self.lines+=['end','chunk()','end']
            self.lines+=['do','local function chunk()']
        old=np.dtype(old);count=int(np.prod(shape,dtype=int))
        raw=(np.arange(count*old.itemsize+offset,dtype=np.uint64)%251).astype('uint8')
        base=raw[offset:].view(old).reshape(shape)
        _,a,expr=next(v for v in views(base) if v[0]==view)
        self.lines+=['do','local backing='+array(raw)]
        raw_expr='backing:get(np.s('+str(offset+1)+'))' if offset else 'backing'
        self.lines+=['local base='+raw_expr+':view('+lua(dtype(old))+'):reshape('+lua(shape)+')','local a='+expr]
        label=f'view/{dtype(old)}{shape}/{view}/{target}/offset{offset}'
        self.check('a',a,label+': initial input')
        try:result=a.view() if target is None else a.view(target);ok=True
        except (TypeError,ValueError,OverflowError):ok=False
        self.lines+=['local ok,result=pcall(function()return a:view('+('' if target is None else lua(dtype(np.dtype(target))))+')end)',
                     'assert(ok=='+lua(ok)+','+lua(label+': acceptance')+'..": "..tostring(result))']
        if ok:
            self.check('result',result,label+': initial result')
            self.lines+=['eq(rawequal(result,a),false,'+lua(label+': new header')+')',
                         'eq(np.shares_memory(result,a),'+lua(np.shares_memory(result,a))+','+lua(label+': sharing')+')']
            fill_raw=np.full(result.nbytes,17,'uint8')
            fill=fill_raw.view(result.dtype).reshape(result.shape)
            try:np.copyto(result,fill);writable=True
            except (TypeError,ValueError):writable=False
            fill_expr='np.full({'+str(result.nbytes)+'},17,"uint8"):view('+lua(dtype(result.dtype))+'):reshape('+lua(result.shape)+')'
            self.lines+=['local fill='+fill_expr,
                         'local write_ok=pcall(function()np.copyto(result,fill)end)',
                         'eq(write_ok,'+lua(writable)+','+lua(label+': writable')+')']
            self.check('result',result,label+': after write')
        self.check('a',a,label+': input state');self.check('base',base,label+': base state')
        self.lines+=['eq(backing:tobytes(),'+lua(raw.tobytes())+','+lua(label+': backing bytes')+')','cases=cases+1','end']

def main():
    s,b=Bytes('view115'),Bytes('bytes115')
    olds=['bool','int8','uint8','int16','uint16','int32','uint32','int64','uint64','float16','float32','float64','longdouble','complex64','complex128','clongdouble','S1','S3','S8','U1','U3','>U3','datetime64[ms]','timedelta64[D]']
    targets=olds+['S0','U0',None]
    for old in olds:
        for name,_,_ in views(np.empty((2,3),old)):
            for target in targets:s.case(old,target,(2,3),name)
        for shape in [(),(1,),(0,),(2,0,8),(2,1,3),(2,3,4)]:
            for target in targets:b.case(old,target,shape,'base')
        for target in ['uint8','int32','float64',None]:
            for name in ['base','F','reverse_first','reverse_last','step_first','transpose']:
                b.case(old,target,(2,4),name,offset=1)
    s.write();b.write()
if __name__=='__main__':main()
