#!/usr/bin/env python3
"""Original NumPy2.5.3 creation/conversion identity, layout and real writes."""
from pathlib import Path
import warnings
import numpy as np
from generate_write98_differential import lua,DTYPES,VIEWS,base_array
assert np.__version__=='2.5.3'
ROOT=Path(__file__).resolve().parents[1]
DEFAULT=object()
def dtype_name(dtype):return 'longdouble' if str(dtype)=='float128' else str(dtype)
def construct(a):
    if isinstance(a,(np.datetime64,np.timedelta64)):
        root='timedelta64' if isinstance(a,np.timedelta64) else 'datetime64'
        unit,multiplier=np.datetime_data(a.dtype)
        value='"NaT"' if np.isnat(a) else lua(int(a.astype(np.int64)))
        return 'np.'+root+'('+value+(','+lua((str(multiplier) if multiplier!=1 else '')+unit) if unit!='generic' else '')+')'
    if not isinstance(a,np.ndarray):return lua(a)
    if 0 in a.shape:return 'np.zeros('+lua(a.shape)+','+lua(dtype_name(a.dtype))+')'
    if a.ndim>1 and a.flags.f_contiguous and not a.flags.c_contiguous:return 'np.transpose('+construct(a.T.copy(order='C'))+')'
    values=a.astype(np.int64) if a.dtype.kind in 'Mm' else a
    return 'np.array('+lua(values)+','+lua(dtype_name(a.dtype))+')'
HEADER="""-- Original NumPy2.5.3 conversion/creation states; no Python runtime.
-- NumPy float128 is LuaRay longdouble on this tested native ABI.
local np=require('luaray_core')
local cases,checks=0,0
local function eq(a,b,label)
 checks=checks+1
 if type(b)=='table' then
  assert(type(a)=='table' and #a==#b,label..': shape')
  for i=1,#b do eq(a[i],b[i],label..'['..i..']') end
 elseif type(b)=='userdata' then eq(a.real,b.real,label..'.real');eq(a.imag,b.imag,label..'.imag')
 elseif type(b)=='number' and b~=b then assert(a~=a,label..': NaN')
 else assert(a==b,label..': '..tostring(a)..' != '..tostring(b)) end
end
"""
class Suite:
    def __init__(self,name):self.name,self.count,self.lines=name,0,[HEADER]
    def begin(self,label):
        self.count+=1
        if (self.count-1)%100==0:
            if self.count>1:self.lines+=['end','chunk()','end']
            self.lines+=['do','local function chunk()']
        label=label.replace('\n',' ');self.lines+=['-- '+str(self.count)+': '+label,'do'];return label
    def metadata(self,name,a,label):
        self.lines += [f'eq({name}.shape,{lua(a.shape)},{lua(label+": shape")})',f'eq({name}.strides,{lua(a.strides)},{lua(label+": strides")})',f'eq({name}.dtype,{lua(dtype_name(a.dtype))},{lua(label+": dtype")})']
    def check(self,name,a,label):
        if isinstance(a,(np.datetime64,np.timedelta64)):
            self.lines += [f'eq({name}.value,{lua(int(a.astype(np.int64)))},{lua(label+": temporal ticks")})',f'eq({name}.dtype,{lua(str(a.dtype))},{lua(label+": temporal dtype")})'];return
        if not isinstance(a,np.ndarray):self.lines.append(f'eq({name},{lua(a)},{lua(label)})');return
        value=a.astype(np.int64) if a.dtype.kind in 'Mm' else a
        expr="np.astype("+name+",'int64')" if a.dtype.kind in 'Mm' else name
        self.lines.append(f'eq({expr}:tolist(),{lua(value)},{lua(label+": values")})');self.metadata(name,a,label)
    def outcome(self,call,error,label):
        self.lines += ['local ok,result=pcall(function() return '+call+' end)',f'assert(ok=={str(error is None).lower()},{lua(label+": acceptance")}..": "..tostring(result))']
    def write(self,result,label):
        error=None
        try:
            with warnings.catch_warnings():warnings.simplefilter('ignore');np.copyto(result,1,casting='unsafe')
        except (ValueError,TypeError,OverflowError) as exc:error=type(exc).__name__
        self.lines += ['local write_ok=pcall(function()np.copyto(result,1,"unsafe")end)',f'eq(write_ok,{str(error is None).lower()},{lua(label+": writable scalar fill")})']
        return error is None
    def end(self):self.lines+=['cases=cases+1','end']
    def finish(self):
        self.lines+=['end','chunk()','end',f'assert(cases=={self.count})',"print('"+self.name+" differential: '..cases..' cases, '..checks..' checks passed')"]
        (ROOT/'tests'/(self.name+'_differential_generated.lua')).write_text('\n'.join(self.lines)+'\n');print(self.name,self.count)
convert,copies,like,dense=[Suite(name) for name in ['conversion107','copy107','like107','dense_creation107']]

def conversion_case(name,base,view,*,order=None,dtype=None,copy=DEFAULT,ndmin=None,literal=False):
    suite=copies if name in ['copy','method_copy'] else convert
    original=base.copy();a,expr=view(base)
    label=suite.begin(f'{name}/{a.dtype}/{a.shape}/{expr}/order{order}/dtype{dtype}/copy{copy if copy is not DEFAULT else "default"}/ndmin{ndmin}/literal{literal}')
    if literal:
        a=a.tolist();suite.lines+=['local base='+lua(a),'local a=base']
    else:suite.lines+=['local base='+construct(original),'local a='+expr]
    kwargs={};opts=[]
    if order is not None:kwargs['order']=order;opts.append('order='+lua(order))
    if dtype is not None:kwargs['dtype']=dtype;opts.append('dtype='+lua(dtype))
    if copy is not DEFAULT:kwargs['copy']=copy;opts.append("copy='if_needed'" if copy is None else 'copy='+lua(copy))
    if ndmin is not None:kwargs['ndmin']=ndmin;opts.append('ndmin='+lua(ndmin))
    error=None;result=None
    try:
        with warnings.catch_warnings():
            warnings.simplefilter('ignore');result=a.copy(**kwargs) if name=='method_copy' else getattr(np,name)(a,**kwargs)
    except (TypeError,ValueError,OverflowError) as exc:error=type(exc).__name__
    call=('a:copy' if name=='method_copy' else 'np.'+name)+'('+('' if name=='method_copy' else 'a,')+'{'+','.join(opts)+'})'
    suite.outcome(call,error,label)
    if error is None:
        suite.check('result',result,label+': result before write')
        suite.lines.append(f'eq(result==a,{str(result is a).lower()},{lua(label+": input identity")})')
        if isinstance(a,np.ndarray):
            suite.lines.append(f'eq(np.shares_memory(result,a),{str(np.shares_memory(result,a)).lower()},{lua(label+": shares memory")})')
            suite.lines.append(f'eq(np.may_share_memory(result,a),{str(np.may_share_memory(result,a)).lower()},{lua(label+": may share memory")})')
        if suite.write(result,label):suite.check('result',result,label+': result after write')
    suite.check('a',a,label+': input after write')
    suite.check('base',a if literal else base,label+': backing after write');suite.end()

for dtype in DTYPES:
    for view in VIEWS.values():
        for name in ['array','asarray','asanyarray','asarray_chkfinite','copy','method_copy','ascontiguousarray','asfortranarray']:
            orders=['C'] if name=='ascontiguousarray' else ['F'] if name=='asfortranarray' else ['C','F','A','K']
            for order in orders:
                policies=[False,True,None] if name in ['array','asarray','asanyarray'] else [DEFAULT]
                for policy in policies:conversion_case(name,base_array(dtype),view,order=None if name in ['ascontiguousarray','asfortranarray'] else order,copy=policy)
    for outdtype in ['int8','float32','complex128','S','U','datetime64','timedelta64']:
        for name in ['array','asarray','asanyarray','asarray_chkfinite','ascontiguousarray','asfortranarray']:
            conversion_case(name,base_array(dtype),VIEWS['transpose'],dtype=outdtype)
# Zero-dimensional, empty and explicit leading-one views.
for shape in [(),(0,),(1,),(0,3),(2,0),(2,3)]:
    for dtype in ['int32','float32','S4']:
        base=np.zeros(shape,dtype)
        for name in ['array','asarray','ascontiguousarray','asfortranarray','copy','method_copy']:
            conversion_case(name,base.copy(),VIEWS['plain'])
        for ndmin in [-1,0,1,3,64,65]:
            for order in ['C','F','K']:
                conversion_case('array',base.copy(),VIEWS['plain'],ndmin=ndmin,order=order,copy=None)
for name in ['array','asarray','asanyarray','asarray_chkfinite','copy']:
    for policy in ([DEFAULT,False,True,None] if name in ['array','asarray','asanyarray'] else [DEFAULT]):
        for dtype in [None,'int8','float32','U']:
            conversion_case(name,np.array([[1,2],[3,4]],'int32'),VIEWS['plain'],dtype=dtype,copy=policy,literal=True)
# Read-only, zero-stride and general K-layout views.
for dtype in ['float32','complex64','U4']:
    def broadcast_view(a):return np.broadcast_to(a[:1,:],(3,4)),'np.broadcast_to(base:get(np.s(1,2),np.s()),{3,4})'
    for name in ['array','asarray','asanyarray','ascontiguousarray','asfortranarray','copy','method_copy']:
        conversion_case(name,base_array(dtype),broadcast_view)
    base=np.arange(24,dtype='float32').reshape(2,3,4)
    for perm in [(1,2,0),(2,0,1)]:
        def permutation(a):return a.transpose(perm),'np.transpose(base,'+lua(tuple(i+1 for i in perm))+')'
        for name in ['array','asarray','copy','method_copy']:
            for order in ['C','F','A','K']:conversion_case(name,base.copy(),permutation,order=order)
for dtype in ['float16','float32','float64','complex64','complex128']:
    for value in [float('inf'),-float('inf'),float('nan')]:
        conversion_case('asarray_chkfinite',np.array([1,value],dtype),VIEWS['plain'])

def like_case(name,base,view,*,dtype=None,order='K',shape=None,fill=1):
    original=base.copy();a,expr=view(base)
    label=like.begin(f'{name}/{a.dtype}/{a.shape}/{expr}/dtype{dtype}/order{order}/shape{shape}/fill{fill}')
    like.lines+=['local base='+construct(original),'local a='+expr]
    kwargs={'order':order};opts=['order='+lua(order)]
    if dtype is not None:kwargs['dtype']=dtype;opts.append('dtype='+lua(dtype))
    if shape is not None:kwargs['shape']=shape;opts.append('shape='+lua(shape))
    error=None;result=None
    try:
        with warnings.catch_warnings():
            warnings.simplefilter('ignore');result=getattr(np,name)(a,fill,**kwargs) if name=='full_like' else getattr(np,name)(a,**kwargs)
    except (TypeError,ValueError,OverflowError) as exc:error=type(exc).__name__
    if name=='full_like':like.lines.append('local fill='+construct(fill))
    call='np.'+name+'(a,'+('fill,' if name=='full_like' else '')+'{'+','.join(opts)+'})'
    like.outcome(call,error,label)
    if error is None:
        if name=='empty_like':like.metadata('result',result,label+': uninitialized result')
        else:like.check('result',result,label+': initial result')
        like.lines.append(f'eq(np.shares_memory(result,a),false,{lua(label+": independent storage")})')
        if like.write(result,label):like.check('result',result,label+': filled result')
    like.check('a',a,label+': input state');like.check('base',base,label+': backing state');like.end()
for dtype in DTYPES:
    for view in VIEWS.values():
        for name in ['empty_like','zeros_like','ones_like','full_like']:
            for order in ['C','F','A','K']:
                for shape in [None,(2,3),(),(2,3,1)]:like_case(name,base_array(dtype),view,order=order,shape=shape)
    for output in ['int8','float32','S','U','datetime64','timedelta64']:
        for name in ['empty_like','zeros_like','ones_like','full_like']:
            like_case(name,base_array(dtype),VIEWS['transpose'],dtype=output)
for dtype in ['uint8','float32','U4','datetime64[D]']:
    for fill in [300,np.array(300,'int64'),np.array([1,2,3],'int16'),[1,2,3],'text',np.array('x','U1')]:
        for shape in [None,(0,3),(),(2,3)]:like_case('full_like',base_array(dtype),VIEWS['plain'],fill=fill,shape=shape)
for dtype in ['float32','U4']:
    def broadcast_view(a):return np.broadcast_to(a[:1,:],(3,4)),'np.broadcast_to(base:get(np.s(1,2),np.s()),{3,4})'
    for name in ['empty_like','zeros_like','ones_like','full_like']:
        for shape in [None,(2,3),(2,3,1)]:like_case(name,base_array(dtype),broadcast_view,shape=shape)

def dense_case(name,shape,*,dtype=None,order='C',fill=1):
    label=dense.begin(f'{name}/{shape}/dtype{dtype}/order{order}/fill{fill}')
    kwargs={'order':order};opts=['order='+lua(order)]
    if dtype is not None:kwargs['dtype']=dtype;opts.append('dtype='+lua(dtype))
    error=None;result=None
    try:
        with warnings.catch_warnings():
            warnings.simplefilter('ignore');result=getattr(np,name)(shape,fill,**kwargs) if name=='full' else getattr(np,name)(shape,**kwargs)
    except (TypeError,ValueError,OverflowError) as exc:error=type(exc).__name__
    dense.lines+=['local shape='+lua(shape)]
    if name=='full':dense.lines.append('local fill='+construct(fill))
    call='np.'+name+'(shape,'+('fill,' if name=='full' else '')+'{'+','.join(opts)+'})'
    dense.outcome(call,error,label)
    if error is None:
        if name=='empty':dense.metadata('result',result,label+': uninitialized result')
        else:dense.check('result',result,label+': initial result')
        if dense.write(result,label):dense.check('result',result,label+': filled result')
    dense.end()
for name in ['empty','zeros','ones','full']:
    for dtype in [None]+DTYPES+['S','U','datetime64','timedelta64']:
        for shape in [0,1,5,(),(2,3),(0,3),(2,0),(-1,)]:
            for order in ['C','F']:dense_case(name,shape,dtype=dtype,order=order)
    for order in ['A','K','bad']:dense_case(name,(2,3),order=order)
for dtype in [None,'uint8','float32','S','U']:
    for fill in [300,np.array(300,'int64'),np.array([1,2,3],'int16'),[1,2,3],'text',np.array('x','U1'),1+.5j]:
        for shape in [(2,3),(),(0,3)]:dense_case('full',shape,dtype=dtype,fill=fill)
# Native datetime/timedelta scalar userdata follows the NumPy scalar's strong
# descriptor, unlike ordinary Lua integer/string scalar packing.
for value in [np.datetime64('2000-01-01'),np.datetime64('NaT'),np.datetime64(12,'2D'),np.timedelta64(3,'h'),np.timedelta64('NaT'),np.timedelta64(3)]:
    for name in ['array','asarray','asanyarray','asarray_chkfinite','copy']:
        outputs=[None] if name=='copy' else [None,'datetime64','timedelta64','U16','U','int64','float64']
        for output in outputs:conversion_case(name,value,VIEWS['plain'],dtype=output)
for suite in [convert,copies,like,dense]:suite.finish()
