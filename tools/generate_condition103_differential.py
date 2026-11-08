#!/usr/bin/env python3
"""Actual NumPy 2.5.3 nonzero, flatnonzero, compress and extract references."""
from pathlib import Path
import warnings
import numpy as np
from generate_write98_differential import lua,array_lua,DTYPES,VIEWS,base_array
assert np.__version__=='2.5.3'
ROOT=Path(__file__).resolve().parents[1]

def construct(a):
    if 0 in a.shape:return 'np.zeros('+lua(a.shape)+','+lua(str(a.dtype))+')'
    if a.ndim>1 and a.strides!=np.empty(a.shape,dtype=a.dtype,order='C').strides and a.strides==np.empty(a.shape,dtype=a.dtype,order='F').strides:
        return 'np.transpose('+array_lua(a.T)+')'
    expr=array_lua(a)
    return expr.replace('-9223372036854775808','math.mininteger') if a.dtype.kind in 'Mmiu' else expr

header="""-- Original NumPy 2.5.3; nonzero coordinates adapted to positive Lua indices.
local np=require('luaray_core')
local cases,checks=0,0
local function eq(a,b,label)
 checks=checks+1
 if type(b)=='table' then
  assert(type(a)=='table' and #a==#b,label..': shape')
  for i=1,#b do eq(a[i],b[i],label..'['..i..']') end
 elseif type(b)=='number' and b~=b then assert(a~=a,label..': NaN')
 elseif type(b)=='userdata' then eq(a.real,b.real,label..'.real');eq(a.imag,b.imag,label..'.imag')
 else assert(a==b,label..': '..tostring(a)..' != '..tostring(b)) end
end
"""

class Suite:
    def __init__(self,name):self.name,self.count,self.lines=name,0,[header]
    def check(self,name,a,label,coordinate=False):
        special=a.dtype.kind in 'Mm'
        value=a.astype(np.int64) if special else a
        if coordinate:value=value+1
        expr="np.astype("+name+",'int64')" if special else name
        self.lines.extend([f'eq({expr}:tolist(),{lua(value)},{lua(label)})',
                           f'eq({name}.shape,{lua(a.shape)},{lua(label+": shape")})',
                           f'eq({name}.strides,{lua(a.strides)},{lua(label+": strides")})',
                           f'eq({name}.dtype,{lua(str(a.dtype))},{lua(label+": dtype")})'])
    def case(self,label,base,view,condition=None,axis=None,out=None,out_expr=None,condition_expr=None,method=False,literal_condition=False):
        self.count+=1
        if (self.count-1)%300==0:
            if self.count>1:self.lines+=['end','chunk()','end']
            self.lines+=['do','local function chunk()']
        initial=base.copy();a,expr=view(base)
        cexpr=condition_expr or (lua(condition) if literal_condition else construct(condition) if condition is not None else 'nil')
        oexpr=out_expr or (construct(out) if out is not None else '')
        error=None;result=None
        try:
            with warnings.catch_warnings():
                warnings.simplefilter('ignore')
                if self.name=='nonzero':result=np.nonzero(a)
                elif self.name=='flatnonzero':result=np.flatnonzero(a)
                elif self.name=='compress':result=np.compress(condition,a,axis=axis,out=out)
                else:result=np.extract(condition,a)
        except (TypeError,ValueError,IndexError,OverflowError,RuntimeError) as exc:error=type(exc).__name__
        self.lines.extend([f'-- {self.count}: {label}; source error={error}','do',
                           'local base='+construct(initial),'local a='+expr])
        if self.name in ['compress','extract']:self.lines.append('local condition='+cexpr)
        if out is not None:self.lines.append('local out='+oexpr)
        if self.name=='compress':
            opts='{axis='+('false' if axis is None else str(axis+1 if axis>=0 else axis))+(',out=out' if out is not None else '')+'}'
            call='a:compress(condition,'+opts+')' if method else 'np.compress(condition,a,'+opts+')'
        elif self.name=='extract':call='np.extract(condition,a)'
        elif method:call='a:nonzero()'
        else:call='np.'+self.name+'(a)'
        self.lines.extend(['local ok,result=pcall(function() return '+call+' end)',
                           f'assert(ok=={str(error is None).lower()},{lua(label+": acceptance")}..": "..tostring(result))'])
        if error is None:
            if self.name=='nonzero':
                self.lines.append(f'assert(type(result)=="table" and #result=={len(result)})')
                for d,value in enumerate(result):self.check('result['+str(d+1)+']',value,label+': coordinates/'+str(d),True)
            else:
                self.check('result',result,label+': result',self.name=='flatnonzero')
                if out is not None:self.lines.append(f'assert(result==out,{lua(label+": output identity")})')
        self.check('base',base,label+': backing source')
        self.lines.extend([f'eq(a.shape,{lua(a.shape)},{lua(label+": source shape")})',
                           f'eq(a.strides,{lua(a.strides)},{lua(label+": source strides")})'])
        if out is not None:self.check('out',out,label+': output state')
        self.lines+=['cases=cases+1','end']
    def finish(self):
        self.lines+=['end','chunk()','end',f'assert(cases=={self.count})',"print('"+self.name+"103 differential: '..cases..' cases, '..checks..' checks passed')"]
        (ROOT/'tests'/(self.name+'103_differential_generated.lua')).write_text('\n'.join(self.lines)+'\n')
        print(self.name,self.count)

nz,flat,compress,extract=[Suite(name) for name in ['nonzero','flatnonzero','compress','extract']]
for dtype in DTYPES:
    for name,view in VIEWS.items():
        base=base_array(dtype)
        for suite in [nz,flat]:suite.case(f'{dtype}/{name}',base.copy(),view,method=suite is nz and name=='plain')
        shape=view(base)[0].shape
        for axis in [None,0,1,-1,-2]:
            length=int(np.prod(shape)) if axis is None else shape[axis]
            for n in [0,1,length,length+2]:
                condition=np.resize([True,False,True],n)
                compress.case(f'{dtype}/{name}/{axis}/{n}',base.copy(),view,condition,axis,method=axis==-1)
        for shape_c in [(2,3),(12,),(14,),(0,),()]:
            condition=np.resize([True,False],int(np.prod(shape_c))).reshape(shape_c)
            extract.case(f'{dtype}/{name}/condition/{shape_c}',base.copy(),view,condition)

for shape in [(),(0,),(1,),(3,),(0,3),(2,0),(2,3),(2,1,3)]:
    for dtype in ['int32','float32','complex128','U4','S4','datetime64[D]','timedelta64[h]']:
        base=np.zeros(shape,dtype=dtype)
        for suite in [nz,flat]:suite.case(f'empty-scalar/{shape}/{dtype}',base.copy(),VIEWS['plain'])
        for condition in [np.array(True),np.array([],dtype=bool),np.array([True]),np.array([False,True]),np.ones((1,2),dtype=bool)]:
            compress.case(f'empty-source/{shape}/{dtype}/{condition.shape}',base.copy(),VIEWS['plain'],condition)
            extract.case(f'empty-source/{shape}/{dtype}/{condition.shape}',base.copy(),VIEWS['plain'],condition)

for dtype in ['float64','complex128','U4','S4','datetime64[D]','timedelta64[h]']:
    values=([0,float('nan'),float('inf'),-0.0] if dtype=='float64' else
            [0,1j,complex(float('nan'),0),complex(0,float('nan'))] if dtype=='complex128' else
            ['','0',' ','a'] if dtype in ['U4','S4'] else [0,'NaT',1,-1])
    base=np.array(values,dtype=dtype).reshape(2,2)
    for suite in [nz,flat]:suite.case(f'truth-values/{dtype}',base.copy(),VIEWS['plain'])
    condition=base.reshape(-1)
    compress.case(f'truth-condition/{dtype}',np.arange(4),VIEWS['plain'],condition)
    extract.case(f'truth-condition/{dtype}',np.arange(4),VIEWS['plain'],condition)

for condition in [[],[0,1,2],['','0','a'],[1,True,0],True,[[1,0],[0,2]]]:
    compress.case(f'literal/{condition}',np.arange(6),VIEWS['plain'],condition,literal_condition=True)
    extract.case(f'literal/{condition}',np.arange(6),VIEWS['plain'],condition,literal_condition=True)

for dtype in ['int32','float32','complex128','U4','S4','datetime64[D]']:
    for output_dtype in ['int32','float64','U4','S4']:
        for name,view in VIEWS.items():
            base=base_array(dtype);a=view(base)[0];condition=np.array([True,False,True])
            out=np.zeros((2,a.shape[1]),dtype=output_dtype)
            compress.case(f'out/{dtype}/{output_dtype}/{name}',base,view,condition,0,out=out)

# Shared condition/source/output and strided output identity.
for axis in [None,0,-1]:
    base=np.array([True,False,True,False],dtype=bool)
    out=base[:2]
    compress.case(f'condition-source-output-alias/{axis}',base,VIEWS['plain'],base,axis,out=out,out_expr='a:get(np.s(1,3))',condition_expr='a')
for dtype in ['int32','float32','bool','U4','S4']:
    base=base_array(dtype)
    for name in ['broadcast','readonly-broadcast']:
        def view(a):
            b=a[:1,:]
            if name=='broadcast':return np.broadcast_arrays(b,np.zeros((3,4)))[0], 'np.broadcast_arrays(base:get(np.s(1,2),np.s()),np.zeros({3,4}))[1]'
            return np.broadcast_to(b,(3,4)), 'np.broadcast_to(base:get(np.s(1,2),np.s()),{3,4})'
        for suite in [nz,flat]:suite.case(f'zero-stride/{dtype}/{name}',base.copy(),view)
for dtype in ['bool','int32','float32','complex128']:
    for shape in [(2,3,4),(3,0,2),(1,2,1,3)]:
        base=(np.arange(np.prod(shape)).reshape(shape)%3).astype(dtype)
        for suite in [nz,flat]:suite.case(f'multidim/{dtype}/{shape}',base.copy(),VIEWS['plain'])
        for axis in range(len(shape)):
            cond=np.arange(shape[axis])%2==0
            compress.case(f'multidim/{dtype}/{shape}/{axis}',base.copy(),VIEWS['plain'],cond,axis)
for rank in [1,32,63,64]:
    shape=(1,)*rank
    for suite in [nz,flat]:suite.case(f'max-rank/{rank}',np.ones(shape,dtype='int32'),VIEWS['plain'])
for axis in [None,0,1]:
    a=np.arange(6).reshape(2,3)
    cond=np.array([True,False,True])
    target=np.zeros((2,2),dtype='float64')
    compress.case(f'bad-out-shape/{axis}',a,VIEWS['plain'],cond,axis,out=target)
    target=np.broadcast_to(np.array([0],dtype='int64'),(2,2))
    compress.case(f'readonly-out/{axis}',a,VIEWS['plain'],cond,axis,out=target,out_expr="np.broadcast_to(np.array({0},'int64'),{2,2})")

for suite in [nz,flat,compress,extract]:suite.finish()
