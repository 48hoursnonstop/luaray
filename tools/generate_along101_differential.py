#!/usr/bin/env python3
"""Freeze actual NumPy 2.5.3 along-axis gather/assignment, including errors."""
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
    return array_lua(a)

header="""-- Actual NumPy 2.5.3; positive coordinates adapted to Lua.
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
    def __init__(self,op):self.op,self.count,self.lines=op,0,[header]
    def check_array(self,name,a,label):
        special=a.dtype.kind in 'Mm' or (a.dtype==np.uint64 and np.any(a>2**63-1))
        val=a.astype(np.int64) if special else a
        expr="np.astype("+name+",'int64')" if special else name
        self.lines.extend([f'eq({expr}:tolist(),{lua(val)},{lua(label)})',
                           f'eq({name}.shape,{lua(a.shape)},{lua(label+": shape")})',
                           f'eq({name}.strides,{lua(a.strides)},{lua(label+": strides")})',
                           f'eq({name}.dtype,{lua(str(a.dtype))},{lua(label+": dtype")})'])
    def case(self,label,base,view,indices,axis,values=None,indices_expr=None,values_expr=None,default_axis=False,setup=None,literal_values=False):
        self.count+=1
        if (self.count-1)%300==0:
            if self.count>1:self.lines+=['end','chunk()','end']
            self.lines+=['do','local function chunk()']
        initial=base.copy();a,expr=view(base)
        iexpr=indices_expr or construct(indices)
        vexpr=values_expr or (lua(values) if literal_values else construct(values) if values is not None else 'nil')
        kwargs={} if default_axis else {'axis':axis}
        # Native fancy indexing converts uint64 to intp before traversing.
        raw=indices.astype(np.intp) if indices.dtype.kind=='u' else indices
        translated=raw
        if raw.dtype.kind in 'iu' and np.any(raw>0):translated=np.where(raw>0,raw-1,raw)
        error=None;result=None
        try:
            with warnings.catch_warnings():
                warnings.simplefilter('ignore')
                if self.op=='take':result=np.take_along_axis(a,translated,**kwargs)
                else:result=np.put_along_axis(a,translated,values,**kwargs)
        except (ValueError,TypeError,IndexError,OverflowError) as exc:error=type(exc).__name__
        callaxis='' if default_axis else ','+('false' if axis is None else str(axis+1 if axis>=0 else axis))
        call='np.'+self.op+'_along_axis(a,indices'+(',values' if self.op=='put' else '')+callaxis+')'
        self.lines.extend([f'-- {self.count}: {label}; source error={error}','do',
                           f'local base={construct(initial)}',f'local a={expr}'])
        if setup:self.lines.append(setup)
        self.lines+=['local indices='+iexpr]
        if self.op=='put':self.lines+=['local values='+vexpr]
        self.lines.extend(['local ok,result=pcall(function() return '+call+' end)',
                           f'assert(ok=={str(error is None).lower()},{lua(label+": acceptance")}..": "..tostring(result))'])
        if error is None and self.op=='take':
            self.check_array('result',result,label+': result')
            self.lines.append(f'assert(not np.shares_memory(a,result),{lua(label+": independent result")})')
        if error is None and self.op=='put':self.lines.append(f'assert(result==nil,{lua(label+": nil result")})')
        self.check_array('base',base,label+': backing')
        self.lines.extend([f'eq(a.shape,{lua(a.shape)},{lua(label+": input shape")})',
                           f'eq(a.strides,{lua(a.strides)},{lua(label+": input strides")})'])
        self.check_array('indices',indices,label+': indices')
        self.lines+=['cases=cases+1','end']
    def finish(self):
        self.lines+=['end','chunk()','end',f'assert(cases=={self.count})',
                     "print('"+self.op+"_along101 differential: '..cases..' cases, '..checks..' checks passed')"]
        (ROOT/'tests'/f'{self.op}_along101_differential_generated.lua').write_text('\n'.join(self.lines)+'\n')
        print(self.op,self.count)

get,put=Suite('take'),Suite('put')
for dtype in DTYPES:
    for name,view in VIEWS.items():
        for axis in [None,0,1]:
            shape=view(base_array(dtype))[0].shape
            for j,full in [(0,False),(1,True),(2,False),(3,True)]:
                ishape=(j,) if axis is None else tuple(j if d==axis else (n if full else 1) for d,n in enumerate(shape))
                indices=np.full(ishape,-1,dtype=np.int64)
                if indices.size>1:indices.flat[::2]=1
                label=f'{dtype}/{name}/{axis}/{j}/{full}'
                get.case(label,base_array(dtype),view,indices,axis)
                values=np.array(7,dtype=dtype)
                put.case(label,base_array(dtype),view,indices,axis,values)
                values=np.arange(j).astype(dtype)
                if axis==0:values=values.reshape(j,1)
                put.case(label+'/broadcast-values',base_array(dtype),view,indices,axis,values)

for shape in [(),(0,),(1,),(4,),(0,3),(2,0),(2,3),(2,1,3)]:
    for axis in [None]+list(range(len(shape))):
        for ishape in [(),(0,),(2,),(1,2),(2,1),(2,1,2)]:
            for index_dtype in ['int8','uint32','int64','float64','bool','U2']:
                indices=np.full(ishape,1,dtype=index_dtype)
                label=f'shape/{shape}/{axis}/{ishape}/{index_dtype}'
                get.case(label,np.zeros(shape,dtype='int32'),VIEWS['plain'],indices,axis)
                put.case(label,np.zeros(shape,dtype='int32'),VIEWS['plain'],indices,axis,np.array(9))

for dtype in DTYPES:
    for name in ['plain','transpose','reverse_columns']:
        for v in [np.array(2.5),np.array(2+3j),np.array('bad'),np.array('7'),np.array([],dtype=float),np.array([1,2,3,4]),np.array(['a','β'])]:
            shape=VIEWS[name](base_array(dtype))[0].shape
            indices=np.full((shape[0],2),-1,dtype='int64')
            put.case(f'cast/{dtype}/{name}/{v.dtype}/{v.shape}',base_array(dtype),VIEWS[name],indices,1,v)

for axis in [0,1,None]:
    for idtype in ['int8','int16','int32','int64','uint8','uint16','uint32','uint64','float16','float32','float64','complex128','bool','U3']:
        for val in [1,-1,7]:
            if idtype.startswith('uint') and val<0:continue
            indices=np.full((2,) if axis is None else (2,2),val,dtype=idtype)
            get.case(f'index-type/{axis}/{idtype}/{val}',np.arange(6).reshape(2,3),VIEWS['plain'],indices,axis)
            put.case(f'index-type/{axis}/{idtype}/{val}',np.arange(6).reshape(2,3),VIEWS['plain'],indices,axis,np.array(8))

for axis in [0,1]:
    for kind in ['fortran','reverse','strided']:
        owner=np.array([[-1,-2,-1,-2],[-2,-1,-2,-1]],dtype='int64')
        indices=owner[:,:2]
        iexpr="index_owner:get(np.s(),np.s(1,3))"
        if kind=='fortran':indices=indices.T;iexpr='np.transpose('+iexpr+')'
        elif kind=='reverse':indices=indices[:,::-1];iexpr='np.flip('+iexpr+',2)'
        else:indices=owner[:,::2];iexpr='index_owner:get(np.s(),np.s(1,nil,2))'
        setup='local index_owner='+construct(owner)
        get.case(f'index-view/{axis}/{kind}',np.arange(6).reshape(2,3),VIEWS['plain'],indices,axis,indices_expr=iexpr,setup=setup)
        put.case(f'index-view/{axis}/{kind}',np.arange(6).reshape(2,3),VIEWS['plain'],indices,axis,np.array([[8,9],[7,6]]),indices_expr=iexpr,setup=setup)

for axis in [0,1,None]:
    for name in ['plain','transpose','reverse_columns']:
        base=np.array([[-1,-2,-1],[-2,-1,-2]],dtype='int64')
        a=VIEWS[name](base)[0]
        indices=a if axis is not None else a.reshape(-1)
        iexpr='a' if axis is not None else 'a:reshape({6})'
        put.case(f'live-indices/{axis}/{name}',base,VIEWS[name],indices,axis,np.array(-1),indices_expr=iexpr)
        base=np.arange(6).reshape(2,3)
        a=VIEWS[name](base)[0]
        indices=np.full(a.shape if axis is not None else (a.size,),-1,dtype='int64')
        values=a if axis is not None else a.reshape(-1)
        vexpr='a' if axis is not None else 'a:reshape({6})'
        put.case(f'values-alias/{axis}/{name}',base,VIEWS[name],indices,axis,values,values_expr=vexpr)

# Default axis and unsigned pointer-width reinterpretation.
for shape in [(),(3,),(2,3),(2,1,3)]:
    indices=np.full(shape if shape else (),-1,dtype='int64')
    get.case(f'default-axis/{shape}',np.zeros(shape,dtype='int32'),VIEWS['plain'],indices,-1,default_axis=True)
for value in [2**64-1,2**64-2,2**63]:
    indices=np.array([value],dtype='uint64')
    signed=int(indices.astype(np.int64)[0])
    expr="np.astype(np.array({"+str(signed)+"},'int64'),'uint64','unsafe')"
    get.case(f'uint64-full/{value}',np.arange(4),VIEWS['plain'],indices,0,indices_expr=expr)
    put.case(f'uint64-full/{value}',np.arange(4),VIEWS['plain'],indices,0,np.array(8),indices_expr=expr)

# Dtype buffering: compare actual output on each side of the 8192 boundary.
for n in [128,8192,8193,16385]:
    for failure in [0,127,8191,8192,16384]:
        if failure>=n:continue
        base=np.full((1,n),b'xxxx',dtype='S4')
        indices=np.arange(1,n+1,dtype='int64').reshape(1,n)
        values=np.full((1,n),'a',dtype='U1');values[0,failure]='β'
        put.case(f'buffer-boundary/{n}/{failure}',base,VIEWS['plain'],indices,1,values)

# Negative iteration order and duplicate targets.
for reverse_i in [False,True]:
    for reverse_v in [False,True]:
        index_owner=np.full((2,3),-1,dtype='int64')
        values_owner=np.array([[10,20,30],[40,50,60]],dtype='int32')
        indices=index_owner[:,::-1] if reverse_i else index_owner
        values=values_owner[:,::-1] if reverse_v else values_owner
        setup='local index_owner='+construct(index_owner)+'; local values_owner='+construct(values_owner)
        iexpr='np.flip(index_owner,2)' if reverse_i else 'index_owner'
        vexpr='np.flip(values_owner,2)' if reverse_v else 'values_owner'
        put.case(f'negative-iteration/{reverse_i}/{reverse_v}',np.zeros((2,3),dtype='int32'),VIEWS['plain'],indices,1,values,indices_expr=iexpr,values_expr=vexpr,setup=setup)

# Read-only and writable zero-stride destinations and sources.
for readonly in [False,True]:
    view=(lambda a:(np.broadcast_to(a[:1,:],(3,4)),"np.broadcast_to(base:get(np.s(1,2),np.s()),{3,4})")) if readonly else (lambda a:(np.broadcast_arrays(a[:1,:],np.zeros((3,4)))[0],"np.broadcast_arrays(base:get(np.s(1,2),np.s()),np.zeros({3,4}))[1]"))
    for axis in [None,0,1]:
        indices=np.full((2,) if axis is None else (3,2) if axis==1 else (2,4),-1,dtype='int64')
        get.case(f'zero-stride/{readonly}/{axis}',np.arange(12).reshape(3,4),view,indices,axis)
        put.case(f'zero-stride/{readonly}/{axis}',np.arange(12).reshape(3,4),view,indices,axis,np.array(8))

# Deterministic multidimensional broadcasting / KEEPORDER samples.
rng=np.random.default_rng(101)
for sample in range(240):
    shape=tuple(map(int,rng.integers(1,5,size=int(rng.integers(2,5)))))
    base=np.arange(np.prod(shape),dtype='float64').reshape(shape)
    name=['plain','transpose','reverse_columns'][sample%3]
    a=VIEWS[name](base)[0];axis=int(rng.integers(a.ndim))
    ishape=tuple(int(rng.integers(0,5)) if d==axis else (int(rng.integers(1,5)) if n==1 else n if rng.integers(2) else 1) for d,n in enumerate(a.shape))
    indices=rng.integers(1,a.shape[axis]+1,size=ishape,dtype='int64')
    if sample%2:indices=-indices
    if sample%4==0:indices=indices.copy(order='F')
    get.case(f'multidim/{sample}/{shape}/{name}/{axis}',base.copy(),VIEWS[name],indices,axis)
    values=np.arange(np.prod(ishape),dtype='float32').reshape(ishape)
    if sample%4==1:values=values.copy(order='F')
    put.case(f'multidim/{sample}/{shape}/{name}/{axis}',base.copy(),VIEWS[name],indices,axis,values)

for dtype in DTYPES:
    for value in [300,-1,2.5,True,2+3j,'7','bad',[],[1,2],[[1],[2]]]:
        indices=np.array([[1,2],[2,1]],dtype='int64')
        put.case(f'literal-values/{dtype}/{value}',np.zeros((2,3),dtype=dtype),VIEWS['plain'],indices,1,value,literal_values=True)

for axis in [-1,-2,-3,2]:
    indices=np.full((2,2),-1,dtype='int64')
    get.case(f'negative-invalid-axis/{axis}',np.arange(6).reshape(2,3),VIEWS['plain'],indices,axis)
    put.case(f'negative-invalid-axis/{axis}',np.arange(6).reshape(2,3),VIEWS['plain'],indices,axis,np.array(8))
for dtype in ['int8','uint8','int32','float32','complex128']:
    for value in [float('nan'),float('inf'),-float('inf'),2**31,2**63-1]:
        for literal in [False,True]:
            v=value if literal else np.array(value)
            put.case(f'cast-boundary/{dtype}/{value}/{literal}',np.zeros((1,2),dtype=dtype),VIEWS['plain'],np.array([[1,2]],dtype='int64'),1,v,literal_values=literal)

for rank in [63,64]:
    shape=(1,)*rank
    get.case(f'iterator-rank-limit/{rank}',np.zeros(shape,dtype='int32'),VIEWS['plain'],np.ones(shape,dtype='int64'),0)
    put.case(f'iterator-rank-limit/{rank}',np.zeros(shape,dtype='int32'),VIEWS['plain'],np.ones(shape,dtype='int64'),0,np.array(8))

# Upstream test_shape_base.py: broadcast non-selected dimensions both ways.
for value_order in ['C','F']:
    base=np.arange(12,dtype='int32').reshape(3,4,1)
    indices=(np.arange(10,dtype='int64').reshape(1,2,5)%4)+1
    values=np.arange(30,dtype='int32').reshape(3,2,5).copy(order=value_order)
    get.case(f'bidirectional-broadcast/{value_order}',base.copy(),VIEWS['plain'],indices,1)
    put.case(f'bidirectional-broadcast/{value_order}',base.copy(),VIEWS['plain'],indices,1,values)

for suite in [get,put]:suite.finish()
