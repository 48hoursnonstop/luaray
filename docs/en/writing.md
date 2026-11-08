# Indexed and selected writes

LuaRay 0.98 provides native C `put` and `place`, modeled on NumPy 2.5.3. Scenes
and applications need Lua 5.4 and the native module; Python/NumPy are used only
to generate development references. Arrays keep their shape, strides and dtype.

```lua
local np = require('luaray')
local a = np.arange(6, 'int32')
np.put(a, {1, 3, -1}, {9, 8})
-- a = {9, 1, 8, 3, 4, 9}
np.place(a, {true, false, true, false, false, true}, {5, 6})
-- a = {5, 1, 6, 3, 4, 5}
```

## `np.put(a, indices, values, mode)` and `a:put(indices, values, mode)`

The destination must be a writable ndarray. Indices and values accept ndarrays,
rectangular Lua tables or scalars. Both are flattened in logical C order;
indices select positions in the destination's logical C-order flattening.
Values repeat cyclically, and repeated indices are processed in input order.
The result is `nil`.

Positive indices start at **1**, as elsewhere in LuaRay. Negative indices count
from the end in the default `raise` mode. **Zero is invalid in every mode**;
this is a documented Lua adaptation. The supported mode strings are:

| Mode | Behavior |
| --- | --- |
| `raise` (default) | Reject an index outside the array, allowing negative indices from the end. |
| `wrap` | Reduce indices modulo the length after converting positive Lua coordinates to zero-based coordinates. |
| `clip` | Clamp to the first/last position. Negative indices select the first position, following NumPy's clip semantics. |

An ndarray of indices must cast safely to the native signed pointer-width
integer dtype; floating arrays and `uint64` arrays on a 64-bit host are rejected.
Lua scalar/table floating indices truncate toward zero before index conversion;
numeric strings are parsed. No rounding is applied.

Ndarray values use NumPy's unsafe conversion policy: for example an `int64`
array containing 300 converts to 44 in `uint8`. Lua integers and tables are
packed directly into the destination dtype, so the Lua integer 300 is rejected
for `uint8`, matching Python scalar/sequence construction. Empty values cause
no writes and skip index bounds checking; a nonempty index into an empty
destination is still rejected. Read-only destinations always fail.

### Shared storage and errors

When the destination is noncontiguous or overlaps prepared values or indices,
`put` writes a C-order destination copy and writes back only on success. A bounds
error discards that copy. On a contiguous, non-overlapping destination, earlier
writes remain if a later index is invalid. This distinction follows the real
upstream implementation; the API does not promise atomic writes in every case.

## `np.place(a, mask, values)`

The destination must be a writable ndarray. The mask accepts arrays, rectangular
Lua tables or a scalar and is converted to boolean. It must contain exactly as
many elements as the destination; matching shapes are not required. Numeric
nonzero values (including NaN), nonzero complex values and nonempty strings are
true. All operands traverse logical C order.

Values repeat cyclically, advancing **only when a mask element is true**. This
differs from `putmask`, whose value index advances at every destination position.
Ndarray values must cast safely to the destination dtype, even if the mask is
entirely false. Lua scalar/table values are packed directly into that dtype.
Empty values are accepted only when the mask selects no positions. Returns `nil`.

Noncontiguous destinations use a C-order copy and writeback. On a contiguous
destination, same-dtype contiguous values may share its storage and are read
live during writing, following upstream. This can repeat newly written values;
`place` does not provide a universal source snapshot. Negative, transposed and
shared zero-stride views have explicit reference cases.

## Conversion fixes and boundaries

Empty strings and strings containing only whitespace now fail numeric casts;
the existing boolean rule still treats only an empty string as false. An empty
string converts to `NaT` for `timedelta64`, matching NumPy.

Numeric descriptors with non-native byte order remain unavailable in LuaRay's
dtype core. Forty original write states are retained separately as **blocked**,
with their NumPy outputs and an executed constructor-rejection check; they are
excluded from passing compatibility totals. Object/structured dtypes, Python
subclass dispatch, exception-class identity and complete warning fidelity are
not implemented. This release does not claim complete NumPy compatibility.

## Reproduce the evidence

```sh
make -j4 full-test CXXFLAGS='-O0 -g -std=c++11 -Wall -Wextra -Wpedantic'
LUA_PATH='./lua/?.lua;;' LUA_CPATH='./build/?.so;;' lua5.4 examples/writing98.lua
python3 tools/sanitize_write98.py
```

`full-test` runs frozen fixtures without Python or NumPy. Regeneration requires
an isolated Python environment with **NumPy 2.5.3**:

```sh
.dev/venv/bin/python tools/generate_write98_differential.py
make write98-test
```

The sanitizer tool instruments the three C translation units changed in this
version, reusing other native objects. Leak detection is disabled; this is not
an all-dependency memory-safety audit.
