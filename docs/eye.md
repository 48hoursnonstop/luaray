---
docs_examples: true
---
# Identity and rectangular identity matrices

Use `identity` for a square identity matrix and `eye` when you need a rectangular
shape, another diagonal, or Fortran storage.

## Signatures

| Function | Defaults |
| --- | --- |
| `lr.eye(n, m, k, dtype, order)` | `m=n`, `k=0`, float64, C order. |
| `lr.eye(n, {m=..., k=..., dtype=..., order=..., device="cpu"})` | Options-table form. |
| `lr.identity(n, dtype)` | Square identity in C order; dtype defaults to float64. |
| `lr.identity(n, {dtype=...})` | Options-table form. |

Dimensions and offsets are Lua integers. Negative dimensions raise an error.
`order` accepts C/F, case-insensitively. The optional device is exactly `"cpu"`.
Unknown options, device names and additional arguments raise Lua errors.

## Start with an identity matrix

```lua
local lr = require("luaray")
local identity = lr.identity(3, "float64")
assert(identity:get(1, 1) == 1 and identity:get(1, 2) == 0)
local vector = lr.array({2., 4., 6.}, "float64")
local unchanged = lr.matmul(identity, vector)
assert(unchanged[1] == 2 and unchanged[3] == 6)
```

Identity multiplication preserves a compatible vector. The result is an ordinary,
writable ndarray; it is not a symbolic identity object.

## Select a diagonal and storage order

```lua
local upper = lr.eye(2, {m=3, k=1, dtype="int16", order="F"})
assert(upper:get(1, 2) == 1 and upper:get(2, 3) == 1)
assert(upper:get(1, 1) == 0)
assert(upper.strides[1] == 2 and upper.strides[2] == 4)
```

Positive offsets place ones above the main diagonal; negative offsets place
them below it. Offsets outside the matrix produce zeros. C and F orders describe
physical storage, while indexed values follow the same diagonal rule.

## Work with typed or empty matrices

```lua
local labels = lr.eye(2, {dtype="U4"})
assert(labels:get(1, 1) == "1" and labels:get(1, 2) == "")
local empty = lr.eye(0, 3)
assert(empty.shape[1] == 0 and empty.shape[2] == 3)
```

Strings store `"1"` on the diagonal and empty text elsewhere. Unsized S/U dtypes
use width one. Boolean matrices store true/false; concrete temporal dtypes store
ticks one/zero. A generic datetime dtype raises when the scalar-one assignment
is reached, even for an empty diagonal. Upstream's early return for `k >= m`
can still produce generic datetime zeros. Specify a datetime unit for ordinary use.

## Compatibility

Available since **0.121.0-dev**. Exact NumPy 2.5.3 references cover values, shape,
dtype, strides, writable results, zero dimensions, extreme offsets, typed
construction and C/F order. Full Python index objects, `like` dispatch,
object/structured dtypes and warning/exception identity remain unsupported.
The APIs remain [partially compatible](api_inventory.md).
