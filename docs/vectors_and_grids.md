# Cross products and coordinate grids

LuaRay0.116.0-dev implements native `np.cross` and `np.meshgrid`. The existing
`np.linalg.cross` now shares the cross engine, with common-dtype input casts and
source-compatible output-axis strides.

```lua
local np = require('luaray')
local z = np.cross({1,0,0}, {0,1,0})
assert(z:tolist()[3] == 1)
local x = np.array({0.,1.}, 'float32')
local y = np.array({0.,1.,2.}, 'float64')
local grids = np.meshgrid({x,y}, {indexing='xy'})
assert(grids[1].shape[1] == 3 and grids[1].shape[2] == 2)
assert(grids[1].dtype == 'float32' and grids[2].dtype == 'float64')
```

## Cross product

`np.cross(a,b,{axisa=-1,axisb=-1,axisc=-1,axis=nil})` accepts ndarrays or ordinary
Lua constructor inputs. Each vector axis must have exactly three components,
matching the pinned NumPy2.5.3 source: two-component cross was removed upstream.
The other dimensions broadcast together. A scalar input is invalid.

Axes use Lua one-based positive indices; negative indices count from the end,
and zero is invalid. Axes must be Lua integers. `axis`, when present, overrides
all three individual axes, including ignored invalid individual values. Unknown
options, embedded-NUL keys and additional arguments raise ordinary Lua errors.
`np.linalg.cross(a,b,axis)` or `{axis=...}` remains the existing ndarray-only
wrapper using one shared axis for inputs and output.

Both inputs are cast to their common dtype before any multiplication. Output is
allocated with the vector axis last, then exposed through an axis-permutation
view, so nonlast `axisc` preserves NumPy's noncontiguous result strides. Products
and subtraction follow source order with one reusable temporary. Inputs are
never written and result storage is independent of them. Boolean subtraction,
incompatible dtypes and invalid broadcasting can raise even for empty arrays.

The cross engine reuses the native ufunc backend. General complex products can
choose different baseline/SIMD FMA paths from the NumPy wheel. Fixed test budgets
are6e-7 for complex64 and2e-15 for wider complex, scaled by
`max(1,abs(component))`. Ordinary exact-reference cases, metadata, signed zero,
NaN placement and infinity signs are checked separately. These are partial
numerical guarantees, not byte-identical CPU dispatch or every dtype/FP mode.

## Meshgrid

The Lua-first signature is **`np.meshgrid({x1,x2,...}, options)`**, returning a
sequence table of ndarrays. The input list is explicit rather than Python's
variadic argument syntax. Empty input returns an empty table. Up to64 inputs
are supported, within the ndarray rank limit.

Options are `copy=true`, `sparse=false`, and `indexing='xy'` by default.
`copy` and `sparse` must be Lua booleans; indexing is exactly `xy` or `ij`.
Malformed sequence/option tables and unknown/NUL keys raise errors.

Each input is flattened in C order and reshaped into its grid axis. Scalars
become length-one vectors; multidimensional inputs flatten. Grid outputs retain
individual input dtypes, without a common-dtype cast. For `ij`, input i varies
along axis i; `xy` exchanges the first two axes when there is more than one
input. Sparse grids retain length one on the other axes; dense grids broadcast
to the full product shape. Empty axes still follow the source's inferred-reshape
strides and divisibility rules.

Copies are independent, writable C-order arrays. With `copy=false`, grids share
input storage when reshape can avoid a copy. Flattening an incompatible layout
can still require a copy. Broadcast grids can be writable overlapping views:
writing one cell can update an input and other cells in the same grid. Readonly
input views remain readonly when no intervening copy was needed. Source shape
matches preserve existing strides rather than zeroing unused singleton strides.

```lua
local shared = np.meshgrid({x,y}, {copy=false})
shared[1]:set(7.,1,1)
assert(x:tolist()[1] == 7.)
local sparse = np.meshgrid({x,y}, {sparse=true,copy=false,indexing='ij'})
assert(sparse[1].shape[2] == 1 and sparse[2].shape[1] == 1)
```

Tests compare actual grid values, dtypes, shapes/strides, shared storage,
writeability and backing inputs after constant or varying writes, including
shared inputs, negative/Fortran/permuted layouts, empty/scalar/string/time inputs
and multiple dimensions. Owner lifetimes are checked after Lua collection.

## Scope

Python subclasses/custom array dispatch, all warning/exception protocols, device
arguments and every host ABI remain outside the certified contract. Meshgrid
writes do not reproduce Python warning objects. Object/structured/subarray/void/
variable-width StringDType and non-native numeric endian remain pending. Raw
constructor limits and the linalg wrapper's earlier argument adaptation remain.
All inventory entries remain partial; see [validation results](development/validation.md) and compatibility/
for executed evidence and measured availability rather than a completion claim.
