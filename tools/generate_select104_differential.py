#!/usr/bin/env python3
"""Freeze actual NumPy 2.5.3 where/select, with metadata and error acceptance."""
from pathlib import Path
import warnings
import numpy as np
from generate_write98_differential import lua as simple_lua,DTYPES,VIEWS,base_array
assert np.__version__=='2.5.3'
ROOT=Path(__file__).resolve().parents[1]

def lua(value):
    if isinstance(value,np.ndarray):return lua(value.tolist())
    if isinstance(value,(list,tuple)):return '{'+','.join(map(lua,value))+'}'
    if isinstance(value,bytes):return '"'+''.join(chr(c) if 32<=c<127 and c not in (34,92) else '\\'+format(c,'03d') for c in value)+'"'
    if isinstance(value,str):return '"'+''.join('\\'+c if c in '\\"' else '\\'+format(ord(c),'03d') if ord(c)<32 or ord(c)==127 else c for c in value)+'"'
    if isinstance(value,(int,np.integer)) and int(value)==-2**63:return 'math.mininteger'
    return simple_lua(value)

def construct(a):
    if 0 in a.shape:return 'np.zeros('+lua(a.shape)+','+lua(str(a.dtype))+')'
    if a.dtype==np.uint64 and np.any(a>2**63-1):
        return "np.astype("+construct(a.astype(np.int64))+",'uint64','unsafe')"
    if a.ndim>1 and a.strides!=np.empty(a.shape,dtype=a.dtype,order='C').strides and a.strides==np.empty(a.shape,dtype=a.dtype,order='F').strides:
        return 'np.transpose('+construct(a.T.copy(order='C'))+')'
    values=a.astype(np.int64) if a.dtype.kind in 'Mm' else a
    return 'np.array('+lua(values)+','+lua(str(a.dtype))+')'

def operand(a):return construct(a) if isinstance(a,np.ndarray) else lua(a)

HEADER="""-- Original NumPy 2.5.3 where/select; scalar and layout contracts preserved.
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
    def __init__(self,name):self.name,self.count,self.lines=name,0,[HEADER]
    def check(self,name,a,label,coordinates=False):
        special=a.dtype.kind in 'Mm' or (a.dtype==np.uint64 and np.any(a>2**63-1))
        value=a.astype(np.int64) if special else a
        if coordinates:value=value+1
        expr="np.astype("+name+",'int64')" if special else name
        self.lines.extend([f'eq({expr}:tolist(),{lua(value)},{lua(label)})',
                           f'eq({name}.shape,{lua(a.shape)},{lua(label+": shape")})',
                           f'eq({name}.strides,{lua(a.strides)},{lua(label+": strides")})',
                           f'eq({name}.dtype,{lua(str(a.dtype))},{lua(label+": dtype")})'])
    def case(self,label,condition,x=None,y=None,default=0,unary=False,implicit_default=False,setup=None,condition_expr=None,x_expr=None,y_expr=None):
        label=label.replace('\n',' ')
        self.count+=1
        if (self.count-1)%250==0:
            if self.count>1:self.lines+=['end','chunk()','end']
            self.lines+=['do','local function chunk()']
        error=None;result=None
        try:
            with warnings.catch_warnings():
                warnings.simplefilter('ignore')
                if self.name=='where':result=np.where(condition) if unary else np.where(condition,x,y)
                else:result=np.select(condition,x) if implicit_default else np.select(condition,x,default)
        except (TypeError,ValueError,IndexError,OverflowError,RuntimeError) as exc:error=type(exc).__name__
        self.lines.extend([f'-- {self.count}: {label}; source error={error}','do'])
        if setup:self.lines.append(setup)
        if self.name=='where':
            self.lines.append('local condition='+ (condition_expr or operand(condition)))
            if unary:call='np.where(condition)'
            else:
                self.lines.extend(['local x='+(x_expr or operand(x)),'local y='+(y_expr or operand(y))])
                call='np.where(condition,x,y)'
        else:
            ce=condition_expr or ('{'+','.join(map(operand,condition))+'}' if isinstance(condition,list) else operand(condition))
            xe=x_expr or ('{'+','.join(map(operand,x))+'}' if isinstance(x,list) else operand(x))
            self.lines.extend(['local condition='+ce,'local choices='+xe])
            call='np.select(condition,choices'+('' if implicit_default else ','+operand(default))+')'
        self.lines.extend(['local ok,result=pcall(function() return '+call+' end)',
                           f'assert(ok=={str(error is None).lower()},{lua(label+": acceptance")}..": "..tostring(result))'])
        if error is None:
            if unary:
                self.lines.append(f'assert(type(result)=="table" and #result=={len(result)})')
                for d,arr in enumerate(result):self.check('result['+str(d+1)+']',arr,label+': coordinate/'+str(d),True)
            else:
                self.lines.append(f'assert(type(result)=="userdata",{lua(label+": ndarray result")})')
                self.check('result',result,label+': result')
        if self.name=='where':
            if isinstance(condition,np.ndarray):self.check('condition',condition,label+': condition state')
            if not unary:
                if isinstance(x,np.ndarray):self.check('x',x,label+': x state')
                if isinstance(y,np.ndarray):self.check('y',y,label+': y state')
        self.lines+=['cases=cases+1','end']
    def finish(self):
        self.lines+=['end','chunk()','end',f'assert(cases=={self.count})',"print('"+self.name+"104 differential: '..cases..' cases, '..checks..' checks passed')"]
        (ROOT/'tests'/(self.name+'104_differential_generated.lua')).write_text('\n'.join(self.lines)+'\n')
        print(self.name,self.count)

where,select=Suite('where'),Suite('select')
for left in DTYPES:
    for right in DTYPES:
        for condition in [True,False,np.array([[True,False,True],[False,True,False]])]:
            x=np.arange(6).reshape(2,3).astype(left)
            y=np.arange(10,16).reshape(2,3).astype(right)
            where.case(f'dtypes/{left}/{right}/{type(condition).__name__}/{str(condition)}',condition,x,y)
            select.case(f'dtypes/{left}/{right}/{type(condition).__name__}/{str(condition)}',[condition],[x],default=y)

for dtype in DTYPES:
    for value in [0,300,-1,2**63-1,2.5,1e100,float('nan'),2+3j,True,'a']:
        for condition in [True,False,np.array([True,False])]:
            x=np.array([1,2],dtype=dtype)
            where.case(f'weak/{dtype}/{repr(value)}/{str(condition)}',condition,x,value)
            select.case(f'weak-default/{dtype}/{repr(value)}/{str(condition)}',[condition],[x],default=value)
            select.case(f'weak-choice/{dtype}/{repr(value)}/{str(condition)}',[condition,False],[value,x],default=0)

for maskdtype in DTYPES:
    values=[0,1,0,2,0,3]
    mask=np.array(values).astype(maskdtype).reshape(2,3)
    where.case(f'mask-type/{maskdtype}',mask,np.ones((2,3),dtype='int32'),np.zeros((2,3),dtype='int32'))
    select.case(f'mask-type/{maskdtype}',[mask],[np.ones((2,3),dtype='int32')],default=0)

for name,view in VIEWS.items():
    for cname,cview in VIEWS.items():
        x,xe=view(np.arange(12).reshape(3,4))
        cond,ce=cview((np.arange(12).reshape(3,4)%2==0))
        setup="local base=np.arange(12):reshape({3,4});local maskbase=np.array({{true,false,true,false},{true,false,true,false},{true,false,true,false}},'bool')"
        ce=ce.replace('base','maskbase')
        where.case(f'layout/{name}/{cname}',cond,x,0,setup=setup,condition_expr=ce,x_expr=xe)
        select.case(f'layout/{name}/{cname}',[cond],[x],default=0,setup=setup,condition_expr='{'+ce+'}',x_expr='{'+xe+'}')
for shape in [(),(0,),(1,),(2,3),(0,3),(2,0),(2,1,3)]:
    mask=np.zeros(shape,dtype='bool')
    where.case(f'unary/{shape}',mask,unary=True)
    where.case(f'shapes/{shape}',mask,1,2)
    select.case(f'shapes/{shape}',[mask],[1],default=2)

for width in [1,2,3,4,5,8,9]:
    for condition in [False,True,np.array([False,True])]:
        where.case(f'nonascii-unselected/U{width}/{str(condition)}',condition,np.array(b'\xff',dtype='S1'),np.array('x',dtype='U'+str(width)))
        select.case(f'nonascii-choice/U{width}/{str(condition)}',[condition],[np.array(b'\xff',dtype='S1')],default=np.array('x',dtype='U'+str(width)))

for conditions,choices in [([],[]),([True],[1,2]),([True,False],[1]),([1],[10]),([False,True],[10,20]),([True,True],[10,20]),([[True,False],[False,True]],[10,20])]:
    select.case(f'list/{conditions}/{choices}',conditions,choices,implicit_default=True)
for count in [1,2,32,63,64,65]:
    conditions=[np.array(j%3==0) for j in range(count)]
    choices=[np.array(j,dtype='int32') for j in range(count)]
    select.case(f'choice-count/{count}',conditions,choices,default=-1)

# Group broadcasting and first-match precedence across batch boundaries.
for count in [31,32,33,63,64,65,127,128]:
    conditions=[np.full((2,1),j%7==0,dtype=bool) for j in range(count)]
    choices=[np.full((1,3),j,dtype='float32') for j in range(count)]
    select.case(f'many-broadcast/{count}',conditions,choices,default=-1)
for condshape in [(),(0,),(2,1),(1,3),(2,3),(2,1,3)]:
    for xshape in [(),(0,),(1,3),(2,1),(2,3)]:
        for yshape in [(),(1,),(2,3)]:
            condition=np.zeros(condshape,dtype=bool)
            x=np.ones(xshape,dtype='float32');y=np.zeros(yshape,dtype='float32')
            where.case(f'broadcast/{condshape}/{xshape}/{yshape}',condition,x,y)
            select.case(f'broadcast/{condshape}/{xshape}/{yshape}',[condition],[x],default=y)
for width in [1,2,3,4,5,8]:
    for value in [b'a\0b',b'a\0\xff',b'a\xff',b'']:
        for mask in [False,True]:
            where.case(f'binary/{width}/{value}/{mask}',mask,np.array(value,dtype='S4'),np.array('x',dtype='U'+str(width)))
            select.case(f'binary/{width}/{value}/{mask}',[mask],[np.array(value,dtype='S4')],default=np.array('x',dtype='U'+str(width)))
# Reverse views whose order influences allocation even when unselected.
for name,view in VIEWS.items():
    for dtype in ['int32','float32','complex128','U3','S3']:
        x,xe=view(base_array(dtype));y=np.array(0,dtype=dtype)
        setup='local base='+construct(base_array(dtype))
        where.case(f'layout-scalar-mask/{name}/{dtype}',False,x,y,setup=setup,x_expr=xe)
for condition,x in [(np.array([True,False]),np.array([1,2],dtype='int32')),
                    (np.array([[True,False],[False,True]]),np.array([[1,2],[3,4]],dtype='int32'))]:
    select.case(f'ndarray-lists/{condition.shape}',condition,x,implicit_default=True)

for condition,choices in [(np.array([[True,False],[False,True]]),np.array([[1,2],[3,4]],dtype='int8')),
                          (np.array([True,False]),np.array([1,2],dtype='float32')),
                          (np.zeros((2,0),dtype=bool),np.zeros((2,0),dtype='int32'))]:
    select.case(f'ndarray-scalar-items/{condition.shape}/{choices.dtype}',condition,choices,implicit_default=True)

for suite in [where,select]:suite.finish()
