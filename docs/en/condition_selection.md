# Nonzero coordinates and condition-based extraction

LuaRay 0.103.0-dev adds native `nonzero`, `flatnonzero`, `compress` and `extract`.
The condition subsystem owns coordinate storage; compress/extract reuse the
verified native take engine. Runtime is Lua/native C/C++, without Python.

```lua
local np = require('luaray')
local a = np.array({{0,2,0},{3,0,4}}, 'int32')
local coordinates = a:nonzero()
-- coordinates[1]: {1,2,2}; coordinates[2]: {2,1,3}
local selected = a:get(table.unpack(coordinates)) -- {2,3,4}
local flat_positions = np.flatnonzero(a)         -- {2,4,6}
local columns = a:compress({true,false,true}, {axis=2})
-- {{0,0},{3,4}}
```

## nonzero and flatnonzero

`np.nonzero(input)` and `input:nonzero()` return a Lua **table of ndarrays**,
one coordinate array per input axis. Use `table.unpack` to pass those arrays as
separate advanced indices. Positions start at **1** and are listed in C order,
even for transposed or reversed sources. The original NumPy tuple becomes a
Lua table; coordinate values are adapted to Lua indexing.

Regular nonzero rejects zero-dimensional input. `np.flatnonzero(input)` first
uses C-flat positions and returns one integer ndarray, including for a scalar.
A nonzero scalar yields `{1}`; zero yields an empty array.

Coordinate arrays are views into a new interleaved native coordinate buffer.
For a 64-bit build, a two-axis input produces coordinate strides of **16 bytes**,
even when no positions are selected. The arrays do not share element bytes,
although their enclosing memory spans can overlap: `shares_memory` can be false
while `may_share_memory` is true. They do not alias the source. The tests check
values, dtype, shape and these observable strides through rank 64.

## compress

`np.compress(condition, input [, axis_or_options])` and
`input:compress(condition [, axis_or_options])` select slices along an axis.
The third argument is an axis, or `{axis=...,out=...}`. Omitted/nil/false axis
flattens the source in C order. Positive axes start at 1, negative axes count
from the end and axis zero is invalid.

The condition must be one-dimensional. Numeric, complex and supported fixed
string/temporal conditions use their nonzero truth values; Lua scalar/table
conditions are packed into bool as in upstream compress. A shorter condition
selects only its available positions. Extra false positions beyond the source
are allowed; extra true positions raise an index error. No artificial exact
condition-length check is imposed.

Out must be writable and have the exact selected shape. It retains its object
identity and follows [take](take.md)'s staged raise-mode behavior, including
preconversion of old output values and dtype/cast-back error boundaries.
Conditions are resolved into independent index arrays before output is written,
so shared condition/source/output views use the original selection positions.

## extract

`np.extract(condition, input)` flattens both operands in C order, resolves
nonzero condition positions and returns a one-dimensional copy of source values.
Conditions may have any supported rank, including zero. There is no axis/out
argument. Selection uses actual true positions: an overlong false tail is
permitted; a selected position beyond the source raises an error. Scalar
conditions work on scalar sources; a false scalar produces an empty ndarray.

## Truth, verification and limits

NaN counts as nonzero. Complex conditions are true if either component is
nonzero. Nonempty fixed strings, including the text `"0"`, are true; empty
strings are false. Temporal zero counts as false and NaT counts as true.
Readonly, reversed, transposed, sparse and zero-stride inputs are covered.

`make condition103-test` runs a native C suite, **95 Lua checks** and four
original NumPy 2.5.3 corpora:

| API | Cases | Value and metadata checks |
| --- | ---: | ---: |
| nonzero | 168 | 10,188 |
| flatnonzero | 168 | 7,126 |
| compress | 2,061 | 83,059 |
| extract | 692 | 21,331 |
| Total | 3,089 | 121,704 |

`make full-test` includes **124 frozen fixture files** and native/Lua regressions.
`make sanitize-condition103` instruments ten C units and runs six native / 26 Lua
suites. Other linked dependencies are not instrumented; leak detection is off.
All four generated files reproduce exactly using NumPy 2.5.3 and
`tools/generate_condition103_differential.py`; frozen execution needs no Python.

Object/structured/variable-width string arrays, non-native numeric byte order,
Python subclasses and full exception/warning fidelity remain unsupported or
incomplete. These tests establish the tested behavior, not overall NumPy parity.
Previous blocked states and deliberate take/choose differences remain separate.
