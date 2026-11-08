#!/usr/bin/env python3
"""Freeze original NumPy 2.5.3 choose; never execute unsafe raw output spans."""
from pathlib import Path
import warnings
import numpy as np
from generate_write98_differential import lua,array_lua,DTYPES
assert np.__version__=='2.5.3'
ROOT=Path(__file__).resolve().parents[1]

def construct(a):
    if 0 in a.shape:return 'np.zeros('+lua(a.shape)+','+lua(str(a.dtype))+')'
    if a.ndim>1 and a.strides!=np.empty(a.shape,dtype=a.dtype,order='C').strides and a.strides==np.empty(a.shape,dtype=a.dtype,order='F').strides:
        return 'np.transpose('+array_lua(a.T)+')'
    expr=array_lua(a)
    return expr.replace('-9223372036854775808','math.mininteger') if a.dtype.kind in 'Mmiu' else expr

lines=["""-- Actual NumPy 2.5.3 choose; positive positions translated to Lua.
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

def check_array(name,a,label):
    special=a.dtype.kind in 'Mm'
    v=a.astype(np.int64) if special else a
    expr="np.astype("+name+",'int64')" if special else name
    lines.extend([f'eq({expr}:tolist(),{lua(v)},{lua(label)})',
                  f'eq({name}.shape,{lua(a.shape)},{lua(label+": shape")})',
                  f'eq({name}.strides,{lua(a.strides)},{lua(label+": strides")})',
                  f'eq({name}.dtype,{lua(str(a.dtype))},{lua(label+": dtype")})'])

def case(label,indices,choices,mode='raise',out=None,owner=None,setup=None,indices_expr=None,choices_expr=None,out_expr=None,literal_indices=False,method=False):
    global count
    count+=1
    if (count-1)%300==0:
        if count>1:lines.extend(['end','chunk()','end'])
        lines.extend(['do','local function chunk()'])
    iexpr=indices_expr or (lua(indices) if literal_indices else construct(indices))
    if choices_expr:cexpr=choices_expr
    elif isinstance(choices,np.ndarray):cexpr=construct(choices)
    else:cexpr='{'+','.join(construct(c) if isinstance(c,np.ndarray) else lua(c) for c in choices)+'}'
    oexpr=out_expr or (construct(out) if out is not None else '')
    initial_owner=owner.copy() if owner is not None else None
    # Preserve live shared negative index arrays. Ordinary positive translation
    # creates a separate oracle operand, as documented Lua coordinate adaptation.
    raw=np.asarray(indices)
    translated=raw
    if raw.dtype.kind in 'ib' and np.any(raw>0):translated=np.where(raw>0,raw.astype(np.int64)-1,raw)
    elif raw.dtype.kind=='u' and raw.dtype.itemsize<8 and np.any(raw>0):translated=np.where(raw>0,raw-1,raw)
    error=None;result=None
    try:
        with warnings.catch_warnings():
            warnings.simplefilter('ignore')
            result=np.choose(translated,choices,out=out,mode=mode)
    except (ValueError,TypeError,IndexError,OverflowError,RuntimeError) as exc:error=type(exc).__name__
    options='{mode='+lua(mode)+(',out=out' if out is not None else '')+'}'
    call='indices:choose(choices,'+options+')' if method else 'np.choose(indices,choices,'+options+')'
    lines.extend([f'-- {count}: {label}; source error={error}','do'])
    if owner is not None:lines.append('local owner='+construct(initial_owner))
    if setup:lines.append(setup)
    lines.extend(['local indices='+iexpr,'local choices='+cexpr])
    if out is not None:lines.append('local out='+oexpr)
    lines.extend(['local ok,result=pcall(function() return '+call+' end)',
                  f'assert(ok=={str(error is None).lower()},{lua(label+": acceptance")}..": "..tostring(result))'])
    if error is None:
        if isinstance(result,np.ndarray):
            check_array('result',result,label+': result')
            if out is not None:lines.append(f'assert(result==out,{lua(label+": output identity")})')
        elif result.dtype.kind in 'Mm':
            lines.extend([f'eq(result.value,{lua(result.astype(np.int64).item())},{lua(label+": ticks")})',
                          f'eq(result.dtype,{lua(str(result.dtype))},{lua(label+": scalar dtype")})'])
        else:lines.append(f'eq(result,{lua(result.item())},{lua(label+": scalar")})')
    if isinstance(indices,np.ndarray):check_array('indices',indices,label+': indices')
    if out is not None:check_array('out',out,label+': output state')
    if owner is not None:check_array('owner',owner,label+': output backing')
    lines.extend(['cases=cases+1','end'])

for dtype in DTYPES:
    for shape in [(),(3,),(2,3),(2,1,3)]:
        for mode in ['raise','wrap','clip']:
            for pattern in [[1,2,-1],[1,4,-3]]:
                indices=np.resize(pattern,np.prod(shape,dtype=int)).reshape(shape)
                choices=[np.full(shape,j+10).astype(dtype) for j in range(2)]
                case(f'basic/{dtype}/{shape}/{mode}/{pattern}',indices,choices,mode,method=shape!=( ))
                out=np.zeros(shape,dtype=dtype)
                case(f'out/{dtype}/{shape}/{mode}/{pattern}',indices,choices,mode,out=out)

for dtype in DTYPES:
    for other in ['int32','float32','complex128','U4','S4','datetime64[D]','timedelta64[h]']:
        for mode in ['raise','wrap','clip']:
            choices=[np.array([1,2,3]).astype(dtype),np.array(8).astype(other)]
            case(f'promotion/{dtype}/{other}/{mode}',np.array([1,2,1]),choices,mode)
            out=np.full(3,'bad',dtype='U4')
            case(f'promotion-out/{dtype}/{other}/{mode}',np.array([1,2,1]),choices,mode,out=out)

for choice in [[1,2],[True,False],[1,np.array([2],dtype='float32')],[True,np.array('x',dtype='S1')],['a',np.array([1],dtype='int8')],[1,np.array('x',dtype='U1')],[np.array(1,dtype='int8'),np.array(2,dtype='float16')]]:
    for mode in ['raise','wrap','clip']:
        case(f'weak/{repr(choice)}/{mode}',np.array([1,2]),choice,mode)

for idtype in ['int8','uint8','int32','int64','uint64','float64','bool','U2']:
    for shape in [(),(0,),(3,),(2,1)]:
        indices=np.ones(shape,dtype=idtype)
        case(f'index-type/{idtype}/{shape}',indices,[np.array(10),np.array(20)])
for indices in [1,2,-1,[1,2],[1.9],[],True]:
    case(f'literal-index/{indices}',indices,[10,20],literal_indices=True)

for shapes in [[(2,1),(1,3)],[(0,1),(1,3)],[(2,3),(4,)],[(2,1,3),(1,4,1)]]:
    for mode in ['raise','wrap','clip']:
        choices=[np.full(s,j+10,dtype='int32') for j,s in enumerate(shapes)]
        indices=np.array(1,dtype='int64')
        case(f'broadcast/{shapes}/{mode}',indices,choices,mode)

for mode in ['raise','wrap','clip']:
    # These noncontiguous raw-write spans are entirely inside the actual owner.
    for kind in ['strided','transpose','negative-safe']:
        owner=np.full(12,-9,dtype='int64')
        if kind=='strided':out=owner[1:7:2];expr='owner:get(np.s(2,8,2))';indices=np.array([1,2,1])
        elif kind=='transpose':out=owner[:6].reshape(2,3).T;expr='np.transpose(owner:get(np.s(1,7)):reshape({2,3}))';indices=np.ones((3,2),dtype='int64')
        else:out=owner[3:0:-1];expr='owner:get(np.s(4,1,-1))';indices=np.array([1,2,1])
        case(f'raw-out/{mode}/{kind}',indices,[np.array(10),np.array(20)],mode,out=out,owner=owner,out_expr=expr)
    owner=np.array([-1,-2,-1,-2],dtype='int64');indices=owner;out=owner
    case(f'live-indices/{mode}',indices,[np.array(-2),np.array(-1)],mode,out=out,owner=owner,indices_expr='owner',out_expr='owner')
    owner=np.arange(6,dtype='int64');out=owner[:3];choices=[owner[:3],owner[3:]]
    case(f'choice-overlap/{mode}',np.array([2,1,2]),choices,mode,out=out,owner=owner,out_expr='owner:get(np.s(1,4))',choices_expr='{owner:get(np.s(1,4)),owner:get(np.s(4,7))}')
    out=np.array(0,dtype='int64')
    case(f'scalar-out/{mode}',np.array(1),[np.array(10),np.array(20)],mode,out=out)

# Freeze ISO formatting widths, including partial S cells and unchanged U cells.
for unit in ['Y','M','D','h','m','s','ms','us','ns','ps','fs','as']:
    for v in [0,1,'NaT']:
        source=np.array([v,v],dtype='datetime64['+unit+']')
        for width in [1,2,3,4,5,7,9,10,13,19,23,26,29,38]:
            for kind in ['S','U']:
                out=np.full(2,'xxxx',dtype=kind+str(width))
                case(f'iso-width/{unit}/{v}/{kind}{width}',np.array([1,1]),[source],out=out)

# A successful NaT cell before an undersized date exposes 128-element Unicode
# staging versus direct ASCII partial writes. Test the actual boundary too.
for n in [3,128,129,257]:
    for failure in [1,127,128,256]:
        if failure>=n:continue
        source=np.full(n,'NaT',dtype='datetime64[D]');source[failure]=np.datetime64('2000-01-01')
        for kind in ['S','U']:
            for width in [3,4,5]:
                out=np.full(n,'xxxx',dtype=kind+str(width))
                case(f'iso-buffer/{n}/{failure}/{kind}{width}',np.ones(n,dtype='int64'),[source],out=out)

# Noncontiguous inputs and ndarray choices containers.
for mode in ['raise','wrap','clip']:
    choices=np.arange(24,dtype='float32').reshape(2,3,4)
    case(f'choices-container/{mode}',np.ones((3,4),dtype='int64'),choices,mode)
    choices=choices.transpose(0,2,1)
    setup="local choices_owner=np.arange(24,'float32'):reshape({2,3,4})"
    case(f'choices-container-transpose/{mode}',np.ones((4,3),dtype='int64'),choices,mode,setup=setup,choices_expr='np.transpose(choices_owner,{1,3,2})')
    owner=np.array([[-1,-2,-1],[-2,-1,-2]],dtype='int64')
    indices=owner.T
    case(f'indices-transpose/{mode}',indices,[np.array(-2),np.array(-1)],mode,setup='local index_owner='+construct(owner),indices_expr='np.transpose(index_owner)')
    owner=np.array([-1,-2,-1,-2,-1,-2],dtype='int64');indices=owner[1:5];out=owner[2:6]
    case(f'indices-shifted-alias/{mode}',indices,[np.array(-2),np.array(-1)],mode,out=out,owner=owner,indices_expr='owner:get(np.s(2,6))',out_expr='owner:get(np.s(3,7))')
    for width in [3,4,5]:
        choices=[np.array(['a','β','c'],dtype='U4'),np.array(['b','d','e'],dtype='U4')]
        out=np.full(3,b'xxxx',dtype='S'+str(width))
        case(f'unicode-out/{mode}/{width}',np.array([1,1,2]),choices,mode,out=out)

# Invalid output rank/shape and read-only output.
for mode in ['raise','wrap','clip']:
    case(f'bad-out-shape/{mode}',np.array([1,2]),[10,20],mode,out=np.zeros(3,dtype='int64'))
    owner=np.array([8],dtype='int64');out=np.broadcast_to(owner,(2,))
    case(f'readonly-out/{mode}',np.array([1,2]),[10,20],mode,out=out,owner=owner,out_expr='np.broadcast_to(owner,{2})')

for dtype in DTYPES:
    for value in [300,-1,1e100,float('nan'),2+3j]:
        case(f'weak-boundary/{dtype}/{value}',np.array([1,2]),[np.array(1,dtype=dtype),value])
for dtype in DTYPES:
    for output_dtype in DTYPES:
        for mode in ['raise','wrap','clip']:
            choices=[np.array([1,2,3]).astype(dtype),np.array(8).astype(dtype)]
            out=np.zeros(3,dtype=output_dtype)
            case(f'output-cast/{dtype}/{output_dtype}/{mode}',np.array([1,2,1]),choices,mode,out=out)
for n in [1,2,3,63,64]:
    choices=[np.array(j+10,dtype='int32') for j in range(n)]
    case(f'choice-count/{n}',np.array([1,n]),choices)
for mode in ['raise','wrap','clip']:
    source=np.array([10,11,12],dtype='int64');source.flags.writeable=False
    case(f'readonly-choice/{mode}',np.array([1,2,1]),[source,np.array(20)],mode,
         setup='local source=np.broadcast_to(np.array({10,11,12},"int64"),{3})',choices_expr='{source,np.array(20)}')

lines.extend(['end','chunk()','end',f'assert(cases=={count})',"print('choose102 differential: '..cases..' cases, '..checks..' checks passed')"])
(ROOT/'tests/choose102_differential_generated.lua').write_text('\n'.join(lines)+'\n')
print('choose102 original cases:',count)
