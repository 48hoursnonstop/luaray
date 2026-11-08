#!/usr/bin/env python3
"""Generate Lua can_cast/astype policy cases from NumPy.

The uploaded NumPy main tree is the implementation specification.  The local
NumPy installation is used only as a value oracle for the stable legacy
casting table; source-derived edge cases are emitted explicitly below.
"""
from pathlib import Path
import numpy as np

DTYPES = [
    'bool','int8','uint8','int16','uint16','int32','uint32','int64','uint64',
    'float16','float32','float64','longdouble','complex64','complex128','clongdouble',
    'S0','S1','S4','S21','U0','U1','U4','U21',
    'datetime64','datetime64[D]','datetime64[h]',
    'timedelta64','timedelta64[D]','timedelta64[h]',
]
RULES = ['no','equiv','safe','same_kind','unsafe']

def q(s):
    return '"' + s.replace('\\','\\\\').replace('"','\\"') + '"'

lines = [
    "local np=require('luaray_core')",
    "local n=0",
    "local function c(from,to,casting,expected,label)",
    "  n=n+1; local got=np.can_cast(from,to,casting); assert(got==expected,(label or ('case '..n))..' got='..tostring(got)..' expected='..tostring(expected))",
    "end",
]

for a in DTYPES:
    for b in DTYPES:
        for rule in RULES:
            expected = bool(np.can_cast(np.dtype(a), np.dtype(b), casting=rule))
            lines.append(f"c({q(a)},{q(b)},{q(rule)},{str(expected).lower()},{q(a+'->'+b+' '+rule)})")

# Exact upstream/source-derived boundary assertions from test_numeric.py and
# time_to_time_resolve_descriptors in datetime.c.
extra = [
    ('bool','S5','safe',True), ('bool','S4','safe',False),
    ('int8','S4','safe',True), ('int8','S3','safe',False),
    ('uint64','U20','safe',True), ('uint64','U19','safe',False),
    ('S4','S1','safe',False), ('S4','S1','same_kind',True),
    ('S1','U1','safe',True), ('U1','S1','same_kind',False),
    ('datetime64[D]','datetime64[h]','safe',True),
    ('datetime64[h]','datetime64[D]','safe',False),
    ('datetime64[h]','datetime64[D]','same_kind',True),
    ('timedelta64[Y]','timedelta64[D]','same_kind',False),
    ('int64','timedelta64[D]','safe',True),
    ('uint64','timedelta64[D]','safe',False),
    ('uint64','timedelta64[D]','same_kind',True),
    ('int64','datetime64[D]','same_kind',False),
    ('int64','datetime64[D]','unsafe',True),
]
for a,b,r,e in extra:
    lines.append(f"c({q(a)},{q(b)},{q(r)},{str(e).lower()},{q('source '+a+'->'+b+' '+r)})")

lines += [
    "-- ndarray sources use their concrete descriptor.",
    "local ai=np.array({1,2,3},'int32')",
    "c(ai,'int64','safe',true,'array source safe')",
    "c(ai,'int16','safe',false,'array source narrowing')",
    "",
    "-- astype defaults to unsafe, while an explicit policy is enforced.",
    "local r=ai:astype('int16'); assert(r.dtype=='int16'); n=n+1",
    "r=ai:astype('int64',{casting='safe'}); assert(r.dtype=='int64'); n=n+1",
    "r=np.astype(ai,'int16','same_kind'); assert(r.dtype=='int16'); n=n+1",
    "local ok,err=pcall(function() return ai:astype('int16',{casting='safe'}) end)",
    "assert(not ok and tostring(err):match(\"Cannot cast array data\")); n=n+1",
    "",
    "local s=np.array({'abc'},'S3')",
    "assert(s:astype('S',{casting='no'}).dtype=='|S3'); n=n+1",
    "assert(s:astype('S5',{casting='safe'}).dtype=='|S5'); n=n+1",
    "ok=pcall(function() return s:astype('S2',{casting='safe'}) end); assert(not ok); n=n+1",
    "assert(s:astype('S2',{casting='same_kind'}).dtype=='|S2'); n=n+1",
    "",
    "local d=np.array({'2026-10-07'},'datetime64[D]')",
    "assert(d:astype('datetime64[h]',{casting='safe'}).dtype=='datetime64[h]'); n=n+1",
    "ok=pcall(function() return d:astype('datetime64[Y]',{casting='safe'}) end); assert(not ok); n=n+1",
    "assert(d:astype('datetime64[Y]',{casting='same_kind'}).dtype=='datetime64[Y]'); n=n+1",
    "",

    "-- same_value is ndarray.astype-only in NumPy main; it is value-dependent, not a can_cast rule.",
    "local function sv_ok(arr,to) local ok,res=pcall(function() return arr:astype(to,{casting='same_value'}) end); assert(ok,tostring(res)); n=n+1; return res end",
    "local function sv_bad(arr,to) local ok=pcall(function() return arr:astype(to,{casting='same_value'}) end); assert(not ok); n=n+1 end",
    "sv_ok(np.array({0,1,2,10},'int64'),'int8')",
    "sv_bad(np.array({300},'int64'),'int8')",
    "sv_ok(np.array({9007199254740992},'int64'),'float64')",
    "sv_bad(np.array({9007199254740993},'int64'),'float64')",
    "sv_ok(np.array({0.0,1.0,9.0},'float64'),'int64')",
    "sv_bad(np.array({1.666},'float64'),'int64')",
    "sv_ok(np.array({1.5},'float64'),'float32')",
    "sv_bad(np.array({1.1},'float64'),'float32')",
    "sv_ok(np.array({0/0,math.huge,-math.huge},'float32'),'float16')",
    "sv_bad(np.array({0/0},'float32'),'int64')",
    "sv_ok(np.array({np.complex(1,1)},'complex128'),'complex64')",
    "sv_ok(np.array({np.complex(1,0)},'complex128'),'float32')",
    "sv_bad(np.array({np.complex(1,1)},'complex128'),'float32')",
    "sv_ok(np.array({true,false},'bool'),'int8')",
    "sv_bad(np.array({2},'int8'),'bool')",
    "sv_ok(np.array({'2026-10-07'},'datetime64[D]'),'datetime64[h]')",
    "sv_bad(np.array({'2026-10-07T01:00'},'datetime64[h]'),'datetime64[D]')",
    "sv_bad(np.array({'abc'},'S3'),'S3')",
    "ok=pcall(function() return np.can_cast('int64','int8','same_value') end); assert(not ok); n=n+1",

    "-- Host-language scalars are weak/untyped and NumPy 2 rejects Python scalars in can_cast.",
    "ok=pcall(function() return np.can_cast(4,'int8','unsafe') end); assert(not ok); n=n+1",
    "ok=pcall(function() return np.can_cast('int8','int16','bogus') end); assert(not ok); n=n+1",
    "print('casting policy differential '..n..'/'..n)",
]

out = Path(__file__).resolve().parents[1] / 'tests' / 'casting_policy_differential_generated.lua'
out.write_text('\n'.join(lines) + '\n')
print(f'wrote {out} with {sum(1 for line in lines if line.startswith("c("))} matrix/source can_cast assertions')
