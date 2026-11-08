#!/usr/bin/env python3
"""Regenerate the checked-in dtype94 differential fixture with NumPy 2.x.
Python is used to generate verification data only; LuaRay runs without it.
"""
from pathlib import Path
import numpy as np

ROOT = Path(__file__).resolve().parents[1]
KIND_NAMES = ['generic','number','integer','signedinteger','unsignedinteger',
              'inexact','floating','complexfloating','flexible','character',
              'bytes_','str_','datetime64','timedelta64','bool_','object_','void']
TYPES = ['bool','int8','uint8','int16','uint16','int32','uint32','int64','uint64',
         'float16','float32','float64','longdouble','complex64','complex128',
         'complex256','S0','S1','S8','U0','U2','U15','datetime64[ns]',
         'datetime64[us]','timedelta64[ns]','timedelta64[s]']

def cls(name):
    return getattr(np, name) if name in KIND_NAMES else np.dtype(name).type

def q(s):
    return '"' + ''.join(chr(b) if 32 <= b < 127 and b not in (34,92)
                         else '\\%03d' % b for b in s.encode('utf-8')) + '"'

out = ["local np=require('luaray_core')", 'local n=0',
       'local function check(a,b,expected)',
       '  local got=np.issubdtype(a,b)',
       '  assert(got==expected,a.." <: "..b.." expected "..tostring(expected).." got "..tostring(got))',
       '  n=n+1', 'end']
for a in TYPES + KIND_NAMES:
    for b in TYPES + KIND_NAMES:
        expected = np.issubdtype(cls(a),cls(b))
        out.append(f'check({q(a)},{q(b)},{str(bool(expected)).lower()})')
out.extend(['local function scalar(x,expected)',
            '  local got=np.min_scalar_type(x)',
            '  assert(got==expected,"string scalar "..tostring(got).." expected "..expected)',
            '  n=n+1', 'end'])
strings=['','a','hello','ñ','áá','你好','🙂','🙂mañana','abc\x00d','\\','\"', '𝄞𝄞','🚀'*31,'a'*128]
strings += [ ('🐈' if i%3==0 else 'ñ' if i%3==1 else 'x')*i for i in range(1, 81) ]
for text in strings:
    expected=str(np.min_scalar_type(text))
    out.append(f'scalar({q(text)},{q(expected)})')
out.extend([
 'assert(not pcall(np.issubdtype,"madeup","generic"))',
 'assert(not pcall(np.issubdtype,"float32","madeup"))',
 'assert(not pcall(np.issubdtype,"int8"))',
 'assert(not pcall(np.issubdtype,"int8","number","extra"))',
 'assert(not pcall(np.min_scalar_type,"\\255"))',
 'print("dtype94 differential: "..n.." cases ok")'])
path=ROOT/'tests/dtype94_differential_generated.lua'
path.write_text('\n'.join(out)+'\n')
print(len(TYPES+KIND_NAMES)**2, 'subtypes;', len(strings),'UTF-8 strings; version:',np.__version__)
