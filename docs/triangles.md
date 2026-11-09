---
docs_examples: true
---
# Triangular matrices

Create a lower-triangle mask or keep the upper/lower triangle of existing data.
All three operations return independent, writable ndarrays.

## Signatures

| Function | Behavior |
| --- | --- |
| `lr.tri(n, m, k, dtype)` | Creates a mask; defaults: `m=n`, `k=0`, `dtype="float64"`. |
| `lr.tri(n, {m=..., k=..., dtype=...})` | Options-table form. |
| `lr.tril(a, k)` | Keeps elements on or below diagonal `k`. |
| `lr.triu(a, k)` | Keeps elements on or above diagonal `k`. |

`tril` and `triu` also accept `{k=...}`. Positive offsets move the boundary above
the main diagonal; negative offsets move it below. Dimensions and offsets must
be Lua integers. Deprecated Python float-to-index conversions are not reproduced.

## Create a mask

```lua
local lr = require("luaray")
local mask = lr.tri(2, {m=3})
assert(mask.shape[1] == 2 and mask.shape[2] == 3)
assert(mask:get(1, 1) == 1 and mask:get(1, 2) == 0)
assert(mask:get(2, 2) == 1)

local strict = lr.tri(3, {k=-1, dtype="int8"})
assert(strict:get(1, 1) == 0 and strict:get(2, 1) == 1)
```

Negative dimensions yield empty axes, matching the reference's range construction.
A boolean dtype returns a boolean mask. Other dtypes convert that mask: fixed
strings therefore contain `"True"` and `"False"`, truncated to the requested
width. Unsized `S`/`U` infer width five. Temporal dtypes contain ticks zero or one.

## Keep one triangle

```lua
local a = lr.array({{1, 2, 3}, {4, 5, 6}}, "float64")
local lower = lr.tril(a)
local upper = lr.triu(a, 1)
assert(lower:get(1, 2) == 0 and lower:get(2, 2) == 5)
assert(upper:get(2, 2) == 0 and upper:get(2, 3) == 6)
assert(not lr.shares_memory(a, lower))
```

Discarded values become typed zeros. For fixed-string input, that zero is the
empty string, unlike `tri`'s boolean-to-string conversion. `tril` and `triu` follow
selection promotion, including canonical native byte order for Unicode results.
A scalar input is invalid. A vector of length `n` broadcasts over an `n × n`
mask, returning a matrix.

## Mask a batch of matrices

```lua
local batch = lr.asfortranarray(lr.arange(24):reshape({2, 3, 4}))
local lower_batch = lr.tril(batch)
assert(lower_batch:get(2, 3, 1) == 20)
assert(lower_batch:get(2, 1, 2) == 0)
assert(batch:get(2, 1, 2) == 13)
```

The last two axes form each matrix; leading axes identify batches. Negative,
transposed, broadcast and Fortran layouts are accepted. Selection uses NumPy-style
KEEPORDER iteration, so a batch result can have a layout other than ordinary
C order. Shape and element values follow the same masking rule for each matrix.

## Compatibility

Available since **0.119.0-dev**. Exact NumPy 2.5.3 references cover values, dtypes,
strides, empty/negative dimensions, batch layouts, copies, typed zeros and actual
writes. Extreme offsets preserve the pinned reference's fixed-width index rules,
including its conversion errors and wrapped masks near the signed integer limit.
The native implementation uses defined unsigned arithmetic for that wrapping.

Unknown options and extra arguments raise Lua errors. Object/structured dtypes,
foreign array protocols and complete Python warning/exception fidelity remain
unsupported. All functions remain [partially compatible](api_inventory.md).
