#!/usr/bin/env python3
"""Independent NumPy oracle for LuaRay 0.59 chi-square / Fisher F samplers.

Source consulted: NumPy 2.5.3 random/src/distributions/distributions.c.
Executable comparator: local NumPy. Values and next PCG64 raw word are exact.
"""
from pathlib import Path
import numpy as np

out = Path(__file__).resolve().parents[1] / 'tests/distributions59_differential_generated.lua'
lines = [f'-- Generated from independent NumPy {np.__version__} oracle',
         "local np=require('luaray_core')", "assert(np._version=='0.59.0-dev')", 'local n=0',
         'local function eq(a,b) assert(a==b or (a~=a and b~=b), tostring(n).." :: "..tostring(a).." ~= "..tostring(b));n=n+1 end']

def lit(v):
    x = float(v)
    if np.isnan(x): return '(0/0)'
    if np.isposinf(x): return 'math.huge'
    if np.isneginf(x): return '-math.huge'
    return repr(x)

def sz(s):
    if s is None:return 'nil'
    if len(s)==1:return str(s[0])
    return '{'+','.join(map(str,s))+'}'

def vals(v,shape):
    if shape is None:lines.append('eq(v,'+lit(v)+')')
    else:
        lines.append('eq(v.dtype,"float64")')
        lines.append(f'eq(#v.shape,{len(shape)})')
        for i,d in enumerate(shape,1):lines.append(f'eq(v.shape[{i}],{d})')
        for idx in np.ndindex(*shape):
            index=','.join(str(i+1) for i in idx)
            lines.append(f'eq(v:get({index}),{lit(v[idx])})')

def raw(r):lines.append(f'eq(r:raw_hex(),"{int(r.bit_generator.random_raw()):016x}")')

seeds = [0,1,2,42,99,123456789,1099511627779,4611686018427387909]
shapes = [None,(),(0,),(1,),(2,3),(2,0,4),(3,2,3),(127,)]
dfs = [.05,.125,.5,1.,2.,2.5,3.,5.,20.,100.,1000.]
fparams = [(.1,.1),(.5,1.),(1.,.5),(1.,1.),(2.,3.),(3.,2.),(5.,8.),(10.,15.),(.125,50.),(100.,.125),(500.,700.)]
for seed in seeds:
    for name,parameters in [('chisquare',[(d,) for d in dfs]),('f',fparams)]:
        for par in parameters:
            for shape in shapes:
                r=np.random.default_rng(seed)
                v=getattr(r,name)(*par,size=shape)
                arguments=','.join([*(lit(p) for p in par),sz(shape)])
                lines.append(f'do local r=np.random.default_rng({seed}); local v=r:{name}({arguments})')
                vals(v,shape);raw(r);lines.append('end')
# Independent interleaved sequences also check state after thousands of rejections.
for seed in seeds:
    r=np.random.default_rng(seed)
    lines.append(f'do local r=np.random.default_rng({seed})')
    for i in range(480):
        j=i%8
        if j==0:v=r.chisquare(.125);call='r:chisquare(.125)'
        elif j==1:v=r.f(2.,3.);call='r:f(2,3)'
        elif j==2:v=r.standard_normal();call='r:standard_normal()'
        elif j==3:v=r.gamma(2.,3.);call='r:gamma(2,3)'
        elif j==4:v=r.f(.25,.25);call='r:f(.25,.25)'
        elif j==5:v=r.random();call='r:random()'
        elif j==6:v=r.chisquare(100);call='r:chisquare(100)'
        else:v=r.beta(.5,.5);call='r:beta(.5,.5)'
        lines.append(f'eq({call},{lit(v)})')
    raw(r);lines.append('end')
invalid=['r:chisquare(0)','r:chisquare(-1)','r:chisquare(0/0)',
         'r:chisquare(math.huge)','r:chisquare(-math.huge)',
         'r:f(0,1)','r:f(1,0)','r:f(-1,1)','r:f(1,-1)',
         'r:f(1,0/0)','r:f(math.huge,1)','r:f(1,math.huge)',
         'r:chisquare(1,{-1})','r:f(1,1,{-1})',
         'r:chisquare(1,nil,9)','r:f(1,2,nil,9)']
t=np.random.default_rng(42)
next_word=f'{int(t.bit_generator.random_raw()):016x}'
for expr in invalid:
    lines.append(f'do local r=np.random.default_rng(42);eq(pcall(function() {expr} end),false);eq(r:raw_hex(),"{next_word}") end')
lines.append("print('distributions59 differential approved: '..n..' exact checks')")
out.write_text('\n'.join(lines)+'\n')
print('generated',out, len(lines),'lines')
