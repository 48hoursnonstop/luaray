#!/usr/bin/env python3
"""Generate development-only NumPy oracle tests for advanced indexing.

The implementation source of truth remains the pinned upstream NumPy source.
This script only snapshots expected observable behavior for the Lua port.
Positive integer indices are translated from Lua's 1-based convention to
NumPy's 0-based convention; negative indices are identical in both APIs.
"""
from __future__ import annotations

import math
import random
from dataclasses import dataclass
from pathlib import Path
from typing import Any

import numpy as np

ROOT = Path(__file__).resolve().parents[1]
OUT_GET = ROOT / "tests" / "advanced_indexing_differential_generated.lua"
OUT_SET = ROOT / "tests" / "advanced_assignment_differential_generated.lua"


def lua_scalar(x: Any) -> str:
    if x is None:
        return "nil"
    if isinstance(x, (bool, np.bool_)):
        return "true" if bool(x) else "false"
    if isinstance(x, (float, np.floating)):
        return repr(float(x))
    return str(int(x))


def lua_table(x: Any) -> str:
    if isinstance(x, np.ndarray):
        x = x.tolist()
    if isinstance(x, (list, tuple)):
        return "{" + ",".join(lua_table(v) for v in x) + "}"
    return lua_scalar(x)


def prelude() -> list[str]:
    return [
        'local np=require("luaray_core")',
        'local function eq(a,b)',
        '  if type(a)~=type(b) then return false end',
        '  if type(a)~="table" then return a==b end',
        '  if #a~=#b then return false end',
        '  for i=1,#a do if not eq(a[i],b[i]) then return false end end',
        '  return true',
        'end',
        f'-- Generated against development NumPy {np.__version__}.',
    ]


def lua_to_py_int(x: int) -> int:
    return x - 1 if x > 0 else x


def lua_to_py_array(a: np.ndarray) -> np.ndarray:
    if a.dtype == np.bool_:
        return a.copy()
    return np.vectorize(lua_to_py_int, otypes=[np.int64])(a)


@dataclass
class Spec:
    kind: str
    data: Any = None
    name: str = ""


def spec_lua_expr(spec: Spec, defs: list[str], counter: list[int]) -> str:
    if spec.kind == "int":
        return str(spec.data)
    if spec.kind == "slice":
        start, stop, step = spec.data
        return f"np.slice({lua_scalar(start)},{lua_scalar(stop)},{lua_scalar(step)})"
    if spec.kind == "newaxis":
        return "np.newaxis"
    if spec.kind == "ellipsis":
        return "np.ellipsis"
    if spec.kind in {"fancy", "bool"}:
        counter[0] += 1
        name = f"ix{counter[0]}"
        arr = np.asarray(spec.data)
        dtype = "np.bool" if spec.kind == "bool" else "np.int64"
        defs.append(f"local {name}=np.array({lua_table(arr)},{dtype})")
        return name
    if spec.kind in {"int0", "bool0"}:
        counter[0] += 1
        name = f"ix{counter[0]}"
        dtype = "np.bool" if spec.kind == "bool0" else "np.int64"
        defs.append(f"local {name}=np.reshape(np.array({{{lua_scalar(spec.data)}}},{dtype}),{{}})")
        return name
    if spec.kind == "fancyT":
        counter[0] += 1
        name = f"ix{counter[0]}"
        arr = np.asarray(spec.data)
        defs.append(f"local {name}=np.array({lua_table(arr)},np.int64).T")
        return name
    raise AssertionError(spec.kind)


def spec_py(spec: Spec):
    if spec.kind == "int":
        return lua_to_py_int(int(spec.data))
    if spec.kind == "slice":
        s, e, st = spec.data
        cv = lambda v: None if v is None else lua_to_py_int(v)
        return slice(cv(s), cv(e), st)
    if spec.kind == "newaxis":
        return None
    if spec.kind == "ellipsis":
        return Ellipsis
    if spec.kind == "fancy":
        return lua_to_py_array(np.asarray(spec.data, dtype=np.int64))
    if spec.kind == "fancyT":
        return lua_to_py_array(np.asarray(spec.data, dtype=np.int64).T)
    if spec.kind == "bool":
        return np.asarray(spec.data, dtype=np.bool_)
    if spec.kind == "int0":
        return np.asarray(lua_to_py_int(int(spec.data)), dtype=np.int64)
    if spec.kind == "bool0":
        return np.asarray(bool(spec.data), dtype=np.bool_)
    raise AssertionError(spec.kind)


def random_lua_index(rng: random.Random, dim: int, shape: tuple[int, ...]) -> np.ndarray:
    vals = []
    for _ in range(math.prod(shape)):
        pos = rng.randint(1, dim)
        if rng.random() < 0.25:
            pos = -(dim - pos + 1)
        vals.append(pos)
    return np.array(vals, dtype=np.int64).reshape(shape)


def generate_get_cases() -> int:
    rng = random.Random(0xA11CE55)
    lines = prelude()
    count = 0

    cases: list[tuple[tuple[int, ...], list[Spec]]] = []
    # Curated axis-placement and boolean cases.
    cases += [
        ((3,4), [Spec("fancy", [1,3])]),
        ((3,4), [Spec("slice", (None,None,1)), Spec("fancy", [1,3])]),
        ((3,4,5), [Spec("fancy", [1,3]), Spec("slice", (None,None,1)), Spec("fancy", [1,5])]),
        ((3,4,5), [Spec("int", 2), Spec("slice", (None,None,1)), Spec("fancy", [1,5])]),
        ((3,4,5), [Spec("slice", (None,None,1)), Spec("int", 2), Spec("fancy", [1,5])]),
        ((3,4,5), [Spec("fancy", [[1],[3]]), Spec("fancy", [[1,4,2]])]),
        ((3,4), [Spec("bool", [True,False,True]), Spec("ellipsis")]),
        ((3,4,5), [Spec("bool", [[True,False,False,True],[False,True,False,False],[True,False,True,False]]), Spec("slice", (None,None,1))]),
        ((3,4), [Spec("bool", [[True,False,True,False],[False,True,False,True],[True,False,False,False]])]),
        ((3,4), [Spec("bool0", True)]),
        ((3,4), [Spec("bool0", False)]),
        ((3,4), [Spec("int0", 2), Spec("slice", (None,None,1))]),
        ((5,), [Spec("fancy", [-1,1,3])]),
        ((4,), [Spec("fancyT", [[1,2],[4,3]])]),
        ((3,4,5), [Spec("newaxis"), Spec("slice", (None,None,1)), Spec("fancy", [1,4]), Spec("ellipsis")]),
    ]

    # Randomized valid templates exercising broadcast and placement rules.
    for _ in range(285):
        shape = (rng.randint(2,5), rng.randint(2,5), rng.randint(2,5))
        template = rng.randrange(8)
        if template == 0:
            specs=[Spec("fancy", random_lua_index(rng,shape[0],(rng.randint(1,3),)))]
        elif template == 1:
            specs=[Spec("slice",(None,None,1)), Spec("fancy",random_lua_index(rng,shape[1],(rng.randint(1,3),))), Spec("ellipsis")]
        elif template == 2:
            n=rng.randint(1,3)
            specs=[Spec("fancy",random_lua_index(rng,shape[0],(n,))), Spec("slice",(None,None,1)), Spec("fancy",random_lua_index(rng,shape[2],(n,)))]
        elif template == 3:
            r,c=rng.randint(1,3),rng.randint(1,3)
            specs=[Spec("fancy",random_lua_index(rng,shape[0],(r,1))), Spec("fancy",random_lua_index(rng,shape[1],(1,c))), Spec("slice",(None,None,1))]
        elif template == 4:
            specs=[Spec("int",rng.randint(1,shape[0])), Spec("slice",(None,None,1)), Spec("fancy",random_lua_index(rng,shape[2],(rng.randint(1,3),)))]
        elif template == 5:
            mask=np.array([rng.random()<0.55 for _ in range(shape[0])],dtype=bool)
            specs=[Spec("bool",mask), Spec("ellipsis")]
        elif template == 6:
            mask=np.array([[rng.random()<0.35 for _ in range(shape[1])] for _ in range(shape[0])],dtype=bool)
            specs=[Spec("bool",mask), Spec("slice",(None,None,1))]
        else:
            specs=[Spec("newaxis"), Spec("fancy",random_lua_index(rng,shape[0],(rng.randint(1,3),))), Spec("slice",(None,None,1)), Spec("ellipsis")]
        cases.append((shape,specs))

    for shape, specs in cases:
        arr=np.arange(math.prod(shape),dtype=np.int64).reshape(shape)
        pyidx=tuple(spec_py(s) for s in specs)
        got=arr[pyidx]
        defs=[]
        ctr=[0]
        lua_specs=[spec_lua_expr(s,defs,ctr) for s in specs]
        lines.append("do")
        lines.append(f"  local a=np.reshape(np.arange({arr.size}),{lua_table(shape)})")
        for d in defs: lines.append("  "+d)
        lines.append("  local got=a:get("+",".join(lua_specs)+")")
        if np.isscalar(got):
            lines.append(f"  assert(got=={lua_scalar(got)},'advanced get {count} scalar')")
        else:
            lines.append(f"  assert(eq(got.shape,{lua_table(got.shape)}),'advanced get {count} shape')")
            lines.append(f"  assert(eq(got.strides,{lua_table(got.strides)}),'advanced get {count} strides')")
            lines.append(f"  assert(eq(got:tolist(),{lua_table(got)}),'advanced get {count} values')")
        lines.append("end")
        count += 1

    # Error behavior: zero is invalid in Lua index arrays and OOB is checked.
    lines += [
        "do local a=np.arange(4); local i=np.array({0},np.int64); local ok,err=pcall(function() return a:get(i) end); assert(not ok and tostring(err):find('index 0'), 'advanced zero index error') end",
        "do local a=np.arange(4); local i=np.array({5},np.int64); local ok,err=pcall(function() return a:get(i) end); assert(not ok and tostring(err):find('out of bounds'), 'advanced oob error') end",
        "do local a=np.reshape(np.arange(12),{3,4}); local m=np.array({true,false},np.bool); local ok,err=pcall(function() return a:get(m) end); assert(not ok and tostring(err):find('boolean index did not match'), 'boolean mismatch error') end",
        # Scalar-array indexing makes a copy when mixed with basic slicing.
        "do local a=np.reshape(np.arange(12),{3,4}); local i=np.reshape(np.array({2},np.int64),{}); local r=a:get(i,np.slice(nil,nil,1)); r[1]=999; assert(a:get(2,1)==4,'0d integer scalar-array copy semantics') end",
    ]
    lines.append(f"print('advanced indexing differential: {count} cases ok')")
    OUT_GET.write_text("\n".join(lines)+"\n")
    return count


def generate_assignment_cases() -> int:
    rng=random.Random(0x5CA77E2)
    lines=prelude()
    count=0

    for case in range(180):
        shape=(rng.randint(2,5),rng.randint(2,5),rng.randint(2,5))
        arr=np.arange(math.prod(shape),dtype=np.int64).reshape(shape).copy()
        template=case%6
        if template==0:
            idx=random_lua_index(rng,shape[0],(rng.randint(1,3),))
            specs=[Spec("fancy",idx),Spec("slice",(None,None,1)),Spec("slice",(None,None,1))]
        elif template==1:
            n=rng.randint(1,3)
            specs=[Spec("fancy",random_lua_index(rng,shape[0],(n,))),Spec("slice",(None,None,1)),Spec("fancy",random_lua_index(rng,shape[2],(n,)))]
        elif template==2:
            r,c=rng.randint(1,3),rng.randint(1,3)
            specs=[Spec("fancy",random_lua_index(rng,shape[0],(r,1))),Spec("fancy",random_lua_index(rng,shape[1],(1,c))),Spec("slice",(None,None,1))]
        elif template==3:
            mask=np.array([rng.random()<0.55 for _ in range(shape[0])],dtype=bool)
            specs=[Spec("bool",mask),Spec("slice",(None,None,1)),Spec("slice",(None,None,1))]
        elif template==4:
            mask=np.array([[rng.random()<0.4 for _ in range(shape[1])] for _ in range(shape[0])],dtype=bool)
            specs=[Spec("bool",mask),Spec("slice",(None,None,1))]
        else:
            specs=[Spec("slice",(None,None,1)),Spec("int",rng.randint(1,shape[1])),Spec("fancy",random_lua_index(rng,shape[2],(rng.randint(1,3),)))]

        pyidx=tuple(spec_py(s) for s in specs)
        target=arr[pyidx]
        defs=[]; ctr=[0]
        lua_specs=[spec_lua_expr(s,defs,ctr) for s in specs]

        # Alternate scalar, exact-shape, and broadcast RHS. Boolean-special
        # assignment is forced to scalar or a 1-D vector as NumPy requires.
        has_exact_bool=(len(specs)==1 and specs[0].kind=="bool" and np.asarray(specs[0].data).shape==arr.shape)
        if case%3==0:
            rhs_py=700+case
            rhs_lua=str(rhs_py)
        else:
            tshape=np.shape(target)
            if any(s.kind=="bool" for s in specs) and np.ndim(target)==1:
                vals=np.arange(np.size(target),dtype=np.int64)+1000+case*10
                rhs_py=vals
            elif case%3==1:
                vals=np.arange(np.size(target),dtype=np.int64).reshape(tshape)+1000+case*10
                rhs_py=vals
            else:
                # Broadcast along the left-most result axis when possible.
                if len(tshape)>0:
                    bshape=(1,)+tuple(tshape[1:])
                    vals=np.arange(math.prod(bshape),dtype=np.int64).reshape(bshape)+2000+case*10
                else:
                    vals=np.asarray(2000+case)
                rhs_py=vals
            rhs_lua=f"np.array({lua_table(rhs_py)},np.int64)" if np.ndim(rhs_py)>0 else str(int(rhs_py))

        arr[pyidx]=rhs_py
        lines.append("do")
        lines.append(f"  local a=np.reshape(np.arange({math.prod(shape)}),{lua_table(shape)})")
        for d in defs: lines.append("  "+d)
        lines.append(f"  local v={rhs_lua}")
        lines.append("  a:set(v,"+",".join(lua_specs)+")")
        lines.append(f"  assert(eq(a:tolist(),{lua_table(arr)}),'advanced assignment {count}')")
        lines.append("end")
        count+=1

    # Repeated fancy indices: later MapIter writes win in iteration order.
    lines += [
        "do local a=np.zeros({4},np.int64); local i=np.array({2,2,2},np.int64); a:set(np.array({10,20,30},np.int64),i); assert(eq(a:tolist(),{0,30,0,0}),'repeated fancy assignment order') end",
        # Exact boolean-mask assignment with vector RHS.
        "do local a=np.arange(6); local m=np.array({true,false,true,false,true,false},np.bool); a:set(np.array({50,60,70},np.int64),m); assert(eq(a:tolist(),{50,1,60,3,70,5}),'boolean vector assignment') end",
        # Basic array-valued assignment now shares the same array_assign_array broadcasting path.
        "do local a=np.zeros({3,4},np.int64); local v=np.array({{1,2,3,4}},np.int64); a:set(v,np.slice(nil,nil,1),np.slice(nil,nil,1)); assert(eq(a:tolist(),{{1,2,3,4},{1,2,3,4},{1,2,3,4}}),'basic array assignment broadcast') end",
    ]
    lines.append(f"print('advanced assignment differential: {count} cases ok')")
    OUT_SET.write_text("\n".join(lines)+"\n")
    return count


if __name__ == "__main__":
    g=generate_get_cases()
    s=generate_assignment_cases()
    print(f"{OUT_GET} ({g} cases)")
    print(f"{OUT_SET} ({s} cases)")
