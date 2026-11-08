#!/usr/bin/env python3
"""Reproducible NumPy reference data for LuaRay's 0.97 memory APIs."""
from pathlib import Path
import numpy as np

root=Path(__file__).resolve().parents[1]
lines=["local np=require('luaray_core')",
"local function flat(x,t) if type(x)=='table' then for _,v in ipairs(x) do flat(v,t) end else t[#t+1]=x end end",
"local function check(a, expected, label) local v={} flat(a:tolist(),v); assert(#v==#expected,label..': count'); for i=1,#v do assert(v[i]==expected[i],label..' index '..i..' got '..tostring(v[i])..' expected '..tostring(expected[i])) end end",
"local cases=0"]
cases=0

def lit(x):
    if isinstance(x,np.ndarray):return lit(x.tolist())
    if isinstance(x,list):return '{'+','.join(lit(a) for a in x)+'}'
    if isinstance(x,(bool,np.bool_)):return 'true' if bool(x) else 'false'
    if isinstance(x,(int,np.integer)):return str(int(x))
    if isinstance(x,(float,np.floating)):
        x=float(x)
        if x!=x:return '(0/0)'
        if x==float('inf'):return 'math.huge'
        if x==float('-inf'):return '-math.huge'
        return repr(x)
    if isinstance(x,(bool,np.bool_)):return 'true' if bool(x) else 'false'
    if isinstance(x,str):return "'"+x.replace("'","\\'")+"'"
    raise TypeError(type(x))

def case(title,body,expected,base='base'):
    global cases
    cases+=1
    lines.append(f"-- case {cases}: {title}")
    lines.append("do")
    lines.extend(body)
    lines.append(f"check({base},{lit(expected.flatten().tolist())},'{cases}:{title}')")
    lines.append("cases=cases+1")
    lines.append("end")

for dtype in ['int32','int64','float32','float64','uint8']:
    for variant in ['plain','revcols','transpose','revrows']:
        for mode in ['scalar','vector','full','alias','masked','masked_scalar']:
            base=np.arange(12,dtype=dtype).reshape(3,4)
            if variant=='plain': v=base; vexp='base'
            elif variant=='revcols':v=base[:,::-1];vexp='np.flip(base,2)'
            elif variant=='transpose':v=base.T;vexp='np.transpose(base)'
            else:v=base[::-1,:];vexp='np.flip(base,1)'
            if mode=='scalar':
                src=8;sexpr='8'; mask=True;mexpr='true';policy='same_kind'
            elif mode=='vector':
                src=np.arange(v.shape[-1],dtype=np.int16)+3;sexpr=f"np.array({lit(src)},'int16')";mask=True;mexpr='true';policy='same_kind'
            elif mode=='full':
                src=np.arange(v.size,dtype=np.float64).reshape(v.shape)+0.5;sexpr=f"np.array({lit(src)},'float64')";mask=True;mexpr='true';policy='unsafe'
            elif mode=='alias':
                if v.shape==base.shape:src=base;sexpr='base'
                else:src=base.T;sexpr='np.transpose(base)'
                mask=True;mexpr='true';policy='same_kind'
            elif mode=='masked':
                src=np.arange(v.shape[-1],dtype=np.int16)+6;sexpr=f"np.array({lit(src)},'int16')";
                mask=(np.arange(v.size).reshape(v.shape)%3!=1);mexpr=f"np.array({lit(mask)},'bool')";policy='same_kind'
            else:
                src=99;sexpr='99';mask=False;mexpr='false';policy='same_kind'
            try:np.copyto(v,src,where=mask,casting=policy)
            except TypeError:continue
            case(f'copyto-{dtype}-{variant}-{mode}',[
                f"local base=np.arange(12,'{dtype}'):reshape({{3,4}})",
                f"local v={vexp}",f"local src={sexpr}",f"np.copyto(v,src,'{policy}',{mexpr})"],base)

for dtype in ['int32','float32','float64','uint8']:
    for variant in ['plain','revcols','transpose','revrows']:
        for nval in [1,2,3,7,15]:
            for every in [2,3]:
                base=np.arange(12,dtype=dtype).reshape(3,4)
                if variant=='plain':v=base;vexp='base'
                elif variant=='revcols':v=base[:,::-1];vexp='np.flip(base,2)'
                elif variant=='transpose':v=base.T;vexp='np.transpose(base)'
                else:v=base[::-1,:];vexp='np.flip(base,1)'
                mask=np.arange(v.size).reshape(v.shape)%every==0
                vals=np.arange(nval,dtype=np.uint8 if dtype=='uint8' else np.int16)+20
                np.putmask(v,mask,vals)
                case(f'putmask-{dtype}-{variant}-vals{nval}-step{every}',[
                    f"local base=np.arange(12,'{dtype}'):reshape({{3,4}})",f"local v={vexp}",
                    f"np.putmask(v,np.array({lit(mask)},'bool'),np.array({lit(vals)},'{vals.dtype.name}'))"],base)

# 1D aliasing: destination and values share the backing buffer. Validate snapshot semantics.
for op in ['copyto','putmask']:
    a=np.arange(11,dtype=np.int32); v=a[::-1]
    mask=(np.arange(11)%3!=0)
    if op=='copyto':np.copyto(v,a,where=mask)
    else:np.putmask(v,mask,a)
    call='np.copyto(v,base,\'same_kind\',mask)' if op=='copyto' else 'np.putmask(v,mask,base)'
    case(f'{op}-reverse-alias',["local base=np.arange(11,'int32')","local v=np.flip(base)",
             f"local mask=np.array({lit(mask)},'bool')",call],a)

lines.append(f"assert(cases=={cases})")
lines.append(f"print('memory97 differential: {cases} cases passed')")
out=root/'tests/memory97_differential_generated.lua'
out.write_text('\n'.join(lines)+'\n')
print(cases,out)
