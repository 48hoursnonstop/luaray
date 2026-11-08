#!/usr/bin/env python3
"""Take shape/axis/mode/out and alias behavior from actual NumPy 2.5.3."""
from pathlib import Path
import warnings
import numpy as np
from generate_write98_differential import lua,array_lua as native_array_lua,VIEWS,DTYPES,base_array

ROOT=Path(__file__).resolve().parents[1]

def construct_array(a):
    if 0 in a.shape:return 'np.zeros('+lua(a.shape)+','+lua(str(a.dtype))+')'
    return native_array_lua(a)

lines=["""-- Original NumPy 2.5.3 take results; positive indices/axes adapted to Lua.
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
"""]
count=0
differences=[]

def array_check(name,a,label):
    values=a.astype(np.int64) if a.dtype.kind in 'Mm' else a
    expr=f"np.astype({name},'int64')" if a.dtype.kind in 'Mm' else name
    lines.extend([f'eq({expr}:tolist(),{lua(values)},{lua(label)})',
                  f'eq({name}.shape,{lua(a.shape)},{lua(label+": shape")})',
                  f'eq({name}.strides,{lua(a.strides)},{lua(label+": strides")})',
                  f'eq({name}.dtype,{lua(str(a.dtype))},{lua(label+": dtype")})'])

def case(label,base,view,indices,axis=None,mode='raise',out=None,out_expr=None,
         indices_expr=None,method=False,out_base=None,out_base_expr=None):
    global count
    count+=1;label=label.replace('\n',' ')
    if (count-1)%400==0:
        if count>1:lines.extend(['end','chunk()','end'])
        lines.extend(['do','local function chunk()'])
    initial=base.copy();a,view_expr=view(base)
    initial_indices=indices.copy() if isinstance(indices,np.ndarray) else indices
    initial_out=out.copy() if out is not None else None
    initial_owner=out_base.copy() if out_base is not None else None
    error=None;result=None
    try:
        with warnings.catch_warnings():
            warnings.simplefilter('ignore')
            if isinstance(indices,np.ndarray) and not np.can_cast(indices.dtype,np.intp,casting='same_kind'):
                translated=indices
            else:
                raw=np.asarray(indices).astype(np.intp,casting='same_kind',copy=False) if isinstance(indices,np.ndarray) else np.array(indices,dtype=np.intp)
                translated=np.where(raw>0,raw-1,raw) if np.any(raw>0) else raw
            result=np.take(a,translated,axis=axis,out=out,mode=mode)
    except (TypeError,ValueError,IndexError,OverflowError) as e:error=type(e).__name__
    lines.extend([f'-- {count}: {label}; source error={error}','do',
                  f'local base={construct_array(initial)}',f'local a={view_expr}'])
    if out_base is not None:lines.append('local owner='+ (out_base_expr or construct_array(initial_owner)))
    if out is not None:lines.append('local out='+ (out_expr or construct_array(initial_out)))
    iexpr=indices_expr or (construct_array(initial_indices) if isinstance(initial_indices,np.ndarray) else lua(initial_indices))
    lines.append('local indices='+iexpr)
    axis_lua='false' if axis is None else str(axis+1 if axis>=0 else axis)
    options='{axis='+axis_lua+',mode='+lua(mode)+(',out=out' if out is not None else '')+'}'
    call=f'a:take(indices,{options})' if method else f'np.take(a,indices,{options})'
    lines.append('local ok,result=pcall(function() return '+call+' end)')
    lines.append(f'assert(ok=={str(error is None).lower()},{lua(label+": acceptance")}..": "..tostring(result))')
    if error is None:
        if isinstance(result,np.ndarray):
            if out is not None:lines.append(f'assert(result==out,{lua(label+": out identity")})')
            else:lines.append(f'assert(not np.shares_memory(result,a),{lua(label+": result copy")})')
            array_check('result',result,label+': result')
        elif result.dtype.kind in 'Mm':
            lines.append(f'eq(result.value,{lua(result.astype(np.int64).item())},{lua(label+": scalar ticks")})')
            lines.append(f'eq(result.dtype,{lua(str(result.dtype))},{lua(label+": scalar dtype")})')
        else:lines.append(f'eq(result,{lua(result.item())},{lua(label+": scalar result")})')
    array_check('base',base,label+': backing input')
    lines.extend([f'eq(a.shape,{lua(a.shape)},{lua(label+": source shape")})',
                  f'eq(a.strides,{lua(a.strides)},{lua(label+": source strides")})'])
    if out is not None:array_check('out',out,label+': out state')
    if out_base is not None:array_check('owner',out_base,label+': out backing')
    lines.extend(['cases=cases+1','end'])

for dtype in DTYPES:
    for name,view in VIEWS.items():
        shape=view(base_array(dtype))[0].shape
        for axis in [None,0,1,-1,-2]:
            size=np.prod(shape) if axis is None else shape[axis]
            for mode in ['raise','wrap','clip']:
                for indices in [1,[],[1,int(size),-1],[[1,-1],[2,1]],
                                np.array([1,int(size)+3,-int(size)-2],dtype=np.int64)]:
                    case(f'{dtype}/{name}/{axis}/{mode}/{repr(indices)}',base_array(dtype),view,
                         indices,axis,mode,method=axis==-1)

for dtype in ['int32','float32','complex128','U3','S3','datetime64[D]']:
    for mode in ['raise','wrap','clip']:
        for axis in [None,0,1]:
            base=base_array(dtype);a=base
            indices=[1,-1]
            result_shape=(2,) if axis is None else ((2,4) if axis==0 else (3,2))
            for out_dtype in [dtype,'float64','int32','U4']:
                # Avoid uninitialized input conversions: typed out buffers have
                # real known data, including deliberately invalid string cases.
                out=np.zeros(result_shape).astype(out_dtype)
                case(f'out-dtype/{dtype}/{out_dtype}/{mode}/{axis}',base.copy(),VIEWS['plain'],indices,axis,mode,out=out)
            owner=np.zeros(result_shape[::-1],dtype=dtype)
            out=owner.T
            case(f'out-transpose/{dtype}/{mode}/{axis}',base.copy(),VIEWS['plain'],indices,axis,mode,
                 out=out,out_base=owner,out_expr='np.transpose(owner)')
            out=np.zeros(result_shape,dtype=dtype)
            out=np.flip(out)
            owner=np.zeros(result_shape,dtype=dtype)
            out=np.flip(owner)
            case(f'out-reverse/{dtype}/{mode}/{axis}',base.copy(),VIEWS['plain'],indices,axis,mode,
                 out=out,out_base=owner,out_expr='np.flip(owner)')
            owner=np.zeros((1,result_shape[-1]),dtype=dtype) if len(result_shape)==2 else np.zeros(1,dtype=dtype)
            out=np.broadcast_arrays(owner,np.zeros(result_shape))[0]
            case(f'out-zero-stride/{dtype}/{mode}/{axis}',base.copy(),VIEWS['plain'],indices,axis,mode,
                 out=out,out_base=owner,out_expr='np.broadcast_arrays(owner,np.zeros('+lua(result_shape)+'))[1]')

for mode in ['raise','wrap','clip']:
    for axis in [0,1]:
        base=np.array([[-1,-2],[-3,-1],[-2,-3]],dtype=np.int64) if axis==0 else np.array([[-1,-2,-3],[-2,-3,-1]],dtype=np.int64)
        # Direct out may overwrite future indices: all dynamic values remain
        # negative, preserving identical coordinate encodings in both languages.
        owner=np.array([-1,-2,-1,-2],dtype=np.int64)
        out=owner.reshape(2,2);indices=owner[:2]
        case(f'out-index-alias/{axis}/{mode}',base,VIEWS['plain'],indices,axis,mode,out=out,
             out_base=owner,out_expr='owner:reshape({2,2})',indices_expr='owner:get(np.s(1,3))')
    base=np.arange(6,dtype=np.int64).reshape(3,2)
    out=base.reshape(-1)[:4].reshape(2,2)
    case(f'out-source-alias/{mode}',base,VIEWS['plain'],[-1,-2],0,mode,out=out,
         out_expr='base:reshape({6}):get(np.s(1,5)):reshape({2,2})')

for indices in [np.array([1],dtype=np.uint64),np.array([1.0]),[1.9],['1','-1'],
                np.array(['1']),True,np.array([True]),np.array([],dtype=float)]:
    case('index-conversion/'+repr(indices),np.arange(5),VIEWS['plain'],indices)
for mode in ['raise','wrap','clip']:
    case(f'uint64-full-width/{mode}',np.arange(5),VIEWS['plain'],
         np.array([2**64-1,2**64-2],dtype=np.uint64),mode=mode,
         indices_expr="np.astype(np.array({-1,-2},'int64'),'uint64','unsafe')")
    indices_owner=np.array([1,3,2],dtype=np.int64)
    case(f'negative-index-stride/{mode}',np.arange(5),VIEWS['plain'],indices_owner[::-1],mode=mode,
         out_base=indices_owner,out_base_expr=construct_array(indices_owner),indices_expr='np.flip(owner)')

for shape in [(),(0,),(0,3),(2,0),(3,0,0),(1,),(2,1,3)]:
    for axis in ([None,0,-1] if shape==() else [None]+list(range(len(shape)))):
        for mode in ['raise','wrap','clip']:
            for indices in [[],1,[1,-1],[7]]:
                # Confirmed upstream loop hang for a zero selected axis with
                # zero trailing chunk in wrap mode; retained separately.
                if mode=='wrap' and shape and axis is not None and shape[axis]==0 and np.prod(shape[:axis])>0 and np.prod(shape[axis+1:])==0 and np.size(indices)>0:
                    differences.append(dict(shape=list(shape),indices=indices,axis=axis+1,mode=mode,
                                            reason='upstream wrap on empty axis with zero trailing chunk hangs; representative call timed out after entry, individual variant not executed'))
                    continue
                case(f'empty-scalar/{shape}/{axis}/{mode}/{indices}',np.zeros(shape,dtype=np.int32),VIEWS['plain'],indices,axis,mode)

for mode in ['raise','wrap','clip']:
    for values in [np.array(0,dtype=np.int32),np.array(0.0),np.array('bad')]:
        case(f'scalar-out/{mode}/{values.dtype}',np.arange(4,dtype=np.int32),VIEWS['plain'],1,mode=mode,out=values)
    out=np.zeros(3,dtype=np.int32)
    case(f'bad-out-shape/{mode}',np.arange(4,dtype=np.int32),VIEWS['plain'],[1,2],mode=mode,out=out)
    out=np.broadcast_to(np.array([0],dtype=np.int32),(2,))
    case(f'readonly-out/{mode}',np.arange(4,dtype=np.int32),VIEWS['plain'],[1,2],mode=mode,
         out=out,out_expr="np.broadcast_to(np.array({0},'int32'),{2})")
    out=np.array([8,9],dtype=np.int32)
    case(f'invalid-indices-out/{mode}',np.arange(4,dtype=np.int32),VIEWS['plain'],[1,9],mode=mode,out=out)

for dtype in ['U3','U4','U8']:
    for mode in ['raise','wrap','clip']:
        for values in [['a','β','c','🐈'],['a','aaaaβ','c','猫']]:
            base=np.array(values,dtype=dtype)
            case(f'unicode/{dtype}/{mode}/{values}',base,VIEWS['plain'],[1,2,3,4],mode=mode)
            out=np.full(4,b'xxxx',dtype='S4')
            case(f'unicode-to-ascii-out/{dtype}/{mode}/{values}',base,VIEWS['plain'],[1,2,3,4],mode=mode,out=out)

lines.extend(['end','chunk()','end',f'assert(cases=={count})',"print('take100 differential: '..cases..' cases, '..checks..' checks passed')"])
(ROOT/'tests/take100_differential_generated.lua').write_text('\n'.join(lines)+'\n')
(ROOT/'tests/take100_reference_differences.lua').write_text('-- Deliberate empty-axis hang rejection, outside original parity totals.\nreturn {\n'+',\n'.join('{'+','.join(k+'='+lua(v) for k,v in row.items())+'}' for row in differences)+'\n}\n')
print('take100 original cases:',count)
print('take100 retained hang-class variants:',len(differences))
