#!/usr/bin/env python3
"""Legacy fixed-width S/U differential for LuaRay 0.27.

Source truth: uploaded NumPy main legacy string/unicode implementation and tests.
The installed NumPy is only used to serialize expectations for behavior that is
unchanged in the pinned upstream snapshot.
"""
from pathlib import Path
import numpy as np

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'tests' / 'string_differential_generated.lua'


def q(s: str) -> str:
    s = str(s)
    return "'" + s.replace('\\', '\\\\').replace("'", "\\'").replace('\n', '\\n').replace('\r','\\r').replace('\t','\\t') + "'"


def lua_list(vals):
    out=[]
    for v in vals:
        if isinstance(v, (bool, np.bool_)):
            out.append('true' if bool(v) else 'false')
        elif isinstance(v, bytes):
            # Cases here are ASCII-only unless explicitly hand-written below.
            out.append(q(v.decode('ascii')))
        else:
            out.append(q(str(v)))
    return '{' + ','.join(out) + '}'


def flat_list(a):
    return list(np.asarray(a).ravel(order='C'))

lines = ["local np=require('luaray_core')", r'''
local function check1(a, dtype, expected, label)
  assert(a.dtype==dtype,label..' dtype '..tostring(a.dtype)..' ~= '..dtype)
  assert(a.ndim==1 and a.size==#expected,label..' shape')
  for i=1,#expected do
    assert(a[i]==expected[i],label..' value '..i..' '..tostring(a[i])..' ~= '..tostring(expected[i]))
  end
end
local function check_bool(a, expected, label)
  assert(a.dtype=='bool',label..' dtype')
  for i=1,#expected do assert(a[i]==expected[i],label..' value '..i) end
end
''', f"-- Development oracle NumPy {np.__version__}; exact source truth is uploaded NumPy main."]
count=0

# Unicode discovery: width is Unicode codepoints, not UTF-8 bytes.
discovery = [
    ['a','bb','é','😊'],
    ['','x','xyz'],
    ['éé','😊x','abc'],
    ['α','βγ','日本'],
    ['a\u0301','é','😊😊'],  # codepoints, not grapheme clusters
]
for vals in discovery:
    a=np.array(vals)
    dtype=str(a.dtype)
    expected=[str(x) for x in a.tolist()]
    lines += ['do', f" local a=np.array({lua_list(vals)})", f" local e={lua_list(expected)}",
              f" check1(a,{q(dtype)},e,{q('discover '+str(count))})", 'end']
    count+=1

# Explicit U width/truncation and endian descriptors.
u_cases = [
    ('U1',['abcdef','é','😊','日本']),
    ('U2',['abcdef','é😊x','日本語','']),
    ('U3',['abcdef','é😊x','日本語文','xy']),
    ('<U4',['hello','αβγδε','😊😊😊😊😊']),
    ('>U1',['é','😊','日']),
    ('>U3',['abc','é😊x','日本語']),
]
for dtype,vals in u_cases:
    a=np.array(vals,dtype=dtype)
    expected=[str(x) for x in a.tolist()]
    lines += ['do', f" local a=np.array({lua_list(vals)},{q(dtype)})", f" local e={lua_list(expected)}",
              f" check1(a,{q(str(a.dtype))},e,{q('unicode '+str(count))})", 'end']
    count+=1

# Fixed byte strings.  Lua strings are byte strings at this explicit S boundary.
s_cases = [
    ('S1',[b'a',b'b',b'']),
    ('S2',[b'abc',b'x',b'zz']),
    ('S4',[b'abc',b'x',b'hello',b'']),
    ('|S6',[b'abcdefg',b'xy',b'123456']),
]
for dtype,vals in s_cases:
    a=np.array(vals,dtype=dtype)
    expected=list(a.tolist())
    lines += ['do', f" local a=np.array({lua_list(vals)},{q(dtype)})", f" local e={lua_list(expected)}",
              f" check1(a,{q(str(a.dtype))},e,{q('bytes '+str(count))})", 'end']
    count+=1

# Multidimensional storage, tolist and transposed views preserve string descriptors.
for dtype,vals in [
    ('U3',[['a','bb'],['ccc','d']]),
    ('S3',[[b'a',b'bb'],[b'ccc',b'd']]),
    ('>U2',[['é','😊'],['日本','x']]),
]:
    a=np.array(vals,dtype=dtype)
    expected=[[x.decode('ascii') if isinstance(x,bytes) else str(x) for x in row] for row in a.tolist()]
    e='{' + ','.join(lua_list(row) for row in expected) + '}'
    src='{' + ','.join(lua_list(row) for row in vals) + '}'
    lines += ['do',f" local a=np.array({src},{q(dtype)})",f" local e={e}",
              f" assert(a.dtype=={q(str(a.dtype))},{q('2d dtype '+str(count))})",
              " local t=a:tolist(); for i=1,#e do for j=1,#e[i] do assert(t[i][j]==e[i][j],'2d value') end end",
              " local tr=a.T; assert(tr:get(2,1)==e[1][2] and tr:get(1,2)==e[2][1],'transpose values')",'end']
    count+=1

# Six comparison ufuncs, same-kind only, varying widths.
ops = [('equal','equal'),('not_equal','not_equal'),('less','less'),('less_equal','less_equal'),('greater','greater'),('greater_equal','greater_equal')]
comp_inputs = [
    ('U3','U1',['a','bb','é','😊'],['a','c','é','x']),
    ('U1','U4',['z','a','日','😊'],['aa','a','日本','😊']),
    ('>U2','<U3',['é','日本','😊'],['é','日','😊x']),
    ('S3','S1',[b'a',b'bb',b'z',b''],[b'a',b'c',b'y',b'']),
    ('S1','S4',[b'z',b'a',b'x'],[b'aa',b'a',b'xy']),
]
for d1,d2,v1,v2 in comp_inputs:
    a=np.array(v1,dtype=d1); b=np.array(v2,dtype=d2)
    for lname,pname in ops:
        expected=getattr(np,pname)(a,b).tolist()
        lines += ['do',f" local a=np.array({lua_list(v1)},{q(d1)})",f" local b=np.array({lua_list(v2)},{q(d2)})",
                  f" local r=np.{lname}(a,b)",f" local e={lua_list(expected)}",f" check_bool(r,e,{q('cmp '+str(count))})",'end']
        count+=1

# Descriptor-width matrix: every legacy width pair must resolve against the
# concrete descriptors, not only the DType class.  Six comparisons for both U/S.
for kind in ['U','S']:
    for w1 in range(1,5):
        for w2 in range(1,5):
            if kind == 'U':
                v1=['a','bb','é😊','日本語']
                v2=['a','bc','éx','日本']
                py1=v1; py2=v2
            else:
                v1=['a','bb','cc','zzzz']
                v2=['a','bc','cd','zzz']
                py1=[x.encode('ascii') for x in v1]; py2=[x.encode('ascii') for x in v2]
            d1=f'{kind}{w1}'; d2=f'{kind}{w2}'
            a=np.array(py1,dtype=d1); b=np.array(py2,dtype=d2)
            for lname,pname in ops:
                expected=getattr(np,pname)(a,b).tolist()
                lines += ['do',f" local a=np.array({lua_list(v1)},{q(d1)})",f" local b=np.array({lua_list(v2)},{q(d2)})",
                          f" local r=np.{lname}(a,b)",f" local e={lua_list(expected)}",f" check_bool(r,e,{q('width matrix '+str(count))})",'end']
                count+=1

# Weak Lua string scalar resolves to the strong legacy class/descriptor family.
for dtype,vals,scalar,py_scalar in [
    ('U3',['a','bb','ccc'],'bb','bb'),
    ('>U2',['é','日本','😊'],'日本','日本'),
    ('S3',[b'a',b'bb',b'ccc'],'bb',b'bb'),
]:
    a=np.array(vals,dtype=dtype)
    for lname,pname in ops:
        expected=getattr(np,pname)(a,py_scalar).tolist()
        lines += ['do',f" local a=np.array({lua_list(vals)},{q(dtype)})",f" local r=np.{lname}(a,{q(scalar)})",
                  f" local e={lua_list(expected)}",f" check_bool(r,e,{q('scalar cmp '+str(count))})",'end']
        count+=1

# Broadcasting, out= and where= for descriptor-aware string comparison loops.
for dtype,a_vals,b_vals,mask,initial in [
    ('U2',['a','bb','c'],['a'],[True,False,True],[False,True,False]),
    ('S2',[b'a',b'bb',b'c'],[b'b'],[False,True,True],[True,False,True]),
]:
    aa=np.array(a_vals,dtype=dtype); bb=np.array(b_vals,dtype=dtype)
    m=np.array(mask,dtype=bool); out=np.array(initial,dtype=bool)
    np.equal(aa,bb,out=out,where=m)
    expected=out.tolist()
    lines += ['do',f" local a=np.array({lua_list(a_vals)},{q(dtype)})",f" local b=np.array({lua_list(b_vals)},{q(dtype)})",
              f" local m=np.array({lua_list(mask)},np.bool)",f" local o=np.array({lua_list(initial)},np.bool)",
              " local r=np.equal(a,b,{out=o,where=m}); assert(r==o,'out identity')",
              f" local e={lua_list(expected)}",f" check_bool(o,e,{q('out where '+str(count))})",'end']
    count+=1

# Assignment/casting within legacy string families.
# U narrowing/truncation.
lines += ['do'," local d=np.zeros({3},'U2'); local s=np.array({'abc','é😊x','日本語'},'U3'); d:set(s)",
          " local e={'ab','é😊','日本'}; check1(d,'<U2',e,'assign U narrow')",'end']; count+=1
# Unicode endian transfer.
lines += ['do'," local d=np.zeros({3},'>U2'); local s=np.array({'é','😊','日本'},'<U2'); d:set(s)",
          " local e={'é','😊','日本'}; check1(d,'>U2',e,'assign U endian')",'end']; count+=1
# S widening/narrowing.
lines += ['do'," local d=np.zeros({3},'S2'); local s=np.array({'abc','x','zz'},'S3'); d:set(s)",
          " local e={'ab','x','zz'}; check1(d,'|S2',e,'assign S')",'end']; count+=1
# Safe legacy S -> U transfer treats bytes as ASCII codepoints.
lines += ['do'," local d=np.zeros({3},'U3'); local s=np.array({'abc','x','zz'},'S3'); d:set(s)",
          " local e={'abc','x','zz'}; check1(d,'<U3',e,'assign S to U')",'end']; count+=1

# Raw-byte S truncation is by byte, not UTF-8 codepoint.
lines += ['do'," local raw=string.char(0xC3,0xA9); local a=np.array({raw},'S1')",
          " assert(a.dtype=='|S1' and #a[1]==1 and string.byte(a[1],1)==0xC3,'S raw byte truncation')",'end']; count+=1
# U boundary is strict UTF-8.
lines += ['do'," local bad=string.char(0xFF); assert(not pcall(function() return np.array({bad},'U1') end),'U invalid UTF-8 reject')",'end']; count+=1

# Mixed legacy S/U comparison has no default loop in current NumPy main.
for opname in ['equal','less','greater_equal']:
    lines += ['do',f" local s=np.array({{'a'}},'S1'); local u=np.array({{'a'}},'U1')",
              f" assert(not pcall(function() return np.{opname}(s,u) end),{q('mixed S/U '+opname)})",'end']; count+=1

# datetime_as_string(array) now returns a fixed-width U ndarray, exactly the
# legacy Unicode path that motivated this tranche.
dt_vals=['2026-10-07','2026-10-08','NaT']
dt=np.array(dt_vals,dtype='datetime64[D]')
for mode,kwargs in [
    ('default',{}),('auto',{'unit':'auto'}),('D',{'unit':'D'}),('s',{'unit':'s'}),('UTC',{'timezone':'UTC'})
]:
    r=np.datetime_as_string(dt,**kwargs)
    expected=[str(x) for x in r.tolist()]
    opt=''
    if kwargs:
        fields=[]
        for k,v in kwargs.items(): fields.append(f"{k}={q(v)}")
        opt=',{' + ','.join(fields) + '}'
    lines += ['do',f" local d=np.array({lua_list(dt_vals)},'datetime64[D]')",f" local r=np.datetime_as_string(d{opt})",
              f" local e={lua_list(expected)}",f" check1(r,{q(str(r.dtype))},e,{q('datetime string array '+mode)})",'end']
    count+=1

# Transposed datetime inputs preserve KEEPORDER in the Unicode output while values match NumPy.
arr=np.array([['2026-10-07','2026-10-08'],['2026-10-09','2026-10-10']],dtype='datetime64[D]').T
r=np.datetime_as_string(arr,unit='D')
exp=r.tolist()
e='{' + ','.join(lua_list(row) for row in exp) + '}'
lines += ['do'," local d=np.array({{'2026-10-07','2026-10-08'},{'2026-10-09','2026-10-10'}},'datetime64[D]').T",
          " local r=np.datetime_as_string(d,{unit='D'})",f" local e={e}",f" assert(r.dtype=={q(str(r.dtype))},'datetime transposed dtype')",
          " local t=r:tolist(); for i=1,#e do for j=1,#e[i] do assert(t[i][j]==e[i][j],'datetime transposed values') end end",
          " assert(r.strides[1] < r.strides[2],'datetime output keeporder F')",'end']; count+=1

lines.append(f"print('string/unicode differential: {count} cases ok')")
OUT.write_text('\n'.join(lines)+'\n')
print(f'{OUT} ({count} cases)')
