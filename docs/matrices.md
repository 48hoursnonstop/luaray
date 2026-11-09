---
docs_examples: true
---
# Diagonals and matrix construction

Extract a diagonal as a shared, read-only view or build an independent matrix
from a sequence of values.

## Signatures

| Function | Result |
| --- | --- |
| `lr.diagonal(a, offset, axis1, axis2)` | Read-only diagonal view; defaults: `0, 1, 2`. |
| `a:diagonal(offset, axis1, axis2)` | The same operation on an ndarray. |
| `lr.diagonal(a, {offset=0, axis1=1, axis2=2})` | Options-table form. |
| `lr.diag(v, k)` | For a vector, construct a matrix; for a matrix, extract its diagonal. |
| `lr.diagflat(v, k)` | Flatten in C order and construct a matrix. |

`k` defaults to zero; `{k=...}` is also accepted. Positive offsets select a
diagonal above the main diagonal, negative offsets one below it. Axes follow
Lua's one-based convention; negative axes count from the end. Unknown options,
noninteger indices, repeated axes, and extra arguments raise Lua errors.

## Extract a diagonal

```lua
local lr = require("luaray")
local a = lr.array({{1, 2, 3}, {4, 5, 6}}, "int32")
local diagonal = lr.diagonal(a)
assert(diagonal[1] == 1 and diagonal[2] == 5)
assert(a:diagonal(1)[2] == 6) -- upper diagonal: {2, 6}
assert(lr.diag(a, -1)[1] == 4)
```

A two-dimensional input to `diag` returns the same kind of read-only shared
view as `diagonal`. An offset beyond the selected dimensions returns an empty
view, retaining the input dtype.

## Understand the shared storage

```lua
assert(lr.shares_memory(a, diagonal))
a:set(50, 2, 2)
assert(diagonal[2] == 50)
assert(not pcall(function() diagonal[1] = 99 end))

local independent = diagonal:copy()
independent[1] = 99
assert(a:get(1, 1) == 1)
```

The view keeps its owning storage alive after the original variable is collected.
Use `copy()` when you want a writable, independent result. Basic views preserve
negative and noncontiguous strides; no dense copy is needed for extraction.

## Select axes in a higher-dimensional array

```lua
local volume = lr.arange(24):reshape({2, 3, 4})
local selected = lr.diagonal(volume, {axis1=1, axis2=3})
assert(selected.shape[1] == 3 and selected.shape[2] == 2)
assert(selected:get(2, 2) == 17)
```

The selected axes are removed. All other axes keep their original order and the
diagonal axis is appended last. Its stride is the sum of the two selected strides.
`lr.diagonal` defaults to the **first two axes**; `lr.linalg.diagonal` operates on
the **last two axes**. Choose the axes explicitly when working with batches.

## Construct a new matrix

```lua
local upper = lr.diag({2, 4, 6}, 1)
assert(upper.shape[1] == 4 and upper.shape[2] == 4)
assert(upper:get(1, 2) == 2 and upper:get(3, 4) == 6)
assert(upper:get(1, 1) == 0)

local flat = lr.diagflat(a.T, -1)
assert(flat.shape[1] == 7 and flat:get(2, 1) == 1)
assert(flat:get(5, 4) == 50)
```

The square side length is `number_of_values + abs(k)`. New matrices have
independent, writable C-order storage. Their dtype matches the converted input.
Off-diagonal values are zero, including empty fixed strings and temporal tick
zero. `diag` accepts only rank-one or rank-two input; `diagflat` accepts any rank,
including a scalar and empty arrays. Negative or transposed inputs flatten in
logical C order.

## Compatibility

Introduced in **0.117.0-dev**, with exact NumPy 2.5.3 differential checks for
values, dtype, shape, strides, sharing, read-only behavior, and backing states.
The view offset follows NumPy's native C `int` range. Construction detects shape
overflow before allocation. An extreme negative offset returns a safe empty view;
upstream's signed-negation-overflow path is not used as a reference case.

The existing constructor's dtype/coercion limits still apply. Object/structured
arrays, non-native numeric byte order, Python subclass dispatch, and complete
warning/exception identity remain unsupported. These APIs remain partially
compatible. See [API availability](api_inventory.md) and
[validation](development/validation.md).
