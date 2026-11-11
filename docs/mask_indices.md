---
docs_examples: true
---
# Select indices with a callback

`lr.mask_indices(n, mask_function, k)` creates a real `n × n` integer matrix of
ones, calls `mask_function(matrix, k)` once and returns coordinates where the
callback result compares unequal to numeric zero. `k` defaults to zero.

## Read and modify a triangular region

```lua
local lr = require("luaray")
local coordinates = lr.mask_indices(3, lr.triu, 1)
local matrix = lr.arange(9):reshape({3, 3})
local selected = matrix:get(table.unpack(coordinates))
assert(selected.size == 3 and selected[1] == 1 and selected[3] == 5)
matrix:set(-1, table.unpack(coordinates))
assert(matrix:get(1, 2) == -1 and matrix:get(3, 1) == 6)
```

Coordinates start at **one** and follow C-order traversal of the callback result.
`tril` and `triu` work as callbacks. Use the direct
[triangular-index helpers](triangles.md) when a callback is unnecessary.

## Write a Lua callback

```lua
local count = 0
local coordinates = lr.mask_indices(2, function(matrix, parameter)
  count = count + 1
  assert(parameter == "skip first")
  matrix:set(0, 1, 1)
  return matrix
end, "skip first")
assert(count == 1 and coordinates[1].size == 3)
```

The callback receives writable native storage with the platform's signed index
dtype, `int64` on the tested Linux x86-64 build. It may modify the input or return
another array. The optional `k` is forwarded unchanged, including explicit nil,
false, strings and tables. Callable tables with `__call` are also supported.
Callback errors propagate to the caller.

## Return another shape or an ordinary sequence

```lua
local coordinates = lr.mask_indices(2, function()
  return {0, 2, -1}
end)
assert(#coordinates == 1)
assert(coordinates[1][1] == 2 and coordinates[1][2] == 3)
```

The first callback return value is converted with `asarray`; additional return
values are ignored. Supporting ordinary Lua sequences is an explicit host-language
adaptation. NumPy references for this form use an ndarray-returning callback.
The number of coordinate vectors follows the returned array's rank, not the
original matrix. Scalar results are invalid because `nonzero` rejects rank zero.
An empty selected region produces empty coordinate vectors.

## Text and temporal comparison rules

```lua
local all = lr.mask_indices(2, function()
  return lr.zeros({2, 2}, "U4")
end)
assert(all[1].size == 4)
local none = lr.mask_indices(2, function()
  return lr.zeros({2, 2}, "timedelta64[h]")
end)
assert(none[1].size == 0)
```

The reference uses ndarray rich comparison against numeric zero, which differs
from its `not_equal` ufunc for some dtypes. Text and datetime values compare
unequal to numeric zero, including empty text and zero datetime ticks. Timedelta
compares its ticks to zero; NaT ticks are selected. Numeric/Boolean/complex values
use the native comparison engine. These rules are preserved explicitly in the
Lua composition.

## Compatibility

Available since **0.127.0-dev**. Sizes require nonnegative Lua integers. Extra
arguments, invalid callback results and callback failures raise errors.
Coordinate dtype, strides, values, callback input, parameter forwarding, advanced
reads/writes and unchanged returned backing storage are tested against NumPy
2.5.3. The implementation runs in Lua over native kernels, without Python.
Object dtype, foreign dispatch and exact Python warning/exception identities
remain unsupported; compatibility remains partial.
