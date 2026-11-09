---
docs_examples: true
---
# Matrix traces

A trace sums a selected diagonal. With a batch of matrices, it returns one sum
for each set of remaining coordinates.

## Signatures

| Call | Defaults and result |
| --- | --- |
| `lr.trace(a, offset, axis1, axis2, dtype, out)` | Defaults to offset `0`, axes `1` and `2`. |
| `lr.trace(a, {offset=0, axis1=1, axis2=2, dtype=..., out=...})` | Options-table form. |
| `a:trace(...)` | The same options on an ndarray. |
| `lr.linalg.trace(a, {offset=0, dtype=...})` | Reduces the last two axes; requires an ndarray. |

Positive axes are one-based; negative axes count from the end. The axes must be
distinct. Positive offsets select upper diagonals and negative offsets select
lower ones. An empty diagonal reduces to the additive identity.

## Sum a diagonal

```lua
local lr = require("luaray")
local a = lr.array({{1, 2, 3}, {4, 5, 6}}, "int16")
assert(lr.trace(a) == 6)
assert(a:trace(1) == 8)
assert(lr.trace(a, -1) == 4)
```

Without `out`, a complete reduction returns a Lua numeric or LuaRay temporal
scalar. A result with remaining axes is an independent, writable ndarray.
Integer and boolean inputs use the ordinary widened sum dtype by default.
For ordinary numeric inputs, `dtype` chooses the accumulator dtype.

## Work with batches

```lua
local batch = lr.arange(24):reshape({2, 3, 4})
local first_axes = lr.trace(batch)
assert(first_axes.shape[1] == 4 and first_axes[1] == 16)

local matrices = lr.linalg.trace(batch)
assert(matrices.shape[1] == 2)
assert(matrices[1] == 15 and matrices[2] == 51)
```

`lr.trace` defaults to the first two axes. `lr.linalg.trace` treats the last
two axes as each matrix. Specify `axis1` and `axis2` when your data uses another
layout. The remaining axes retain their original order.

## Reuse an output array

```lua
local out = lr.zeros(4, "float32")
assert(lr.trace(batch, {out=out}) == out)
assert(out[1] == 16 and out[4] == 22)

local scalar_out = lr.zeros({}, "uint64")
assert(lr.trace(a, {out=scalar_out}) == scalar_out)
assert(scalar_out:tolist() == 6)
```

`out` must be a writable ndarray with the exact result shape; `{}` is the shape
of a scalar output. Strided outputs and outputs overlapping the source are
supported. The reduction is staged before writeback, protecting unread input.
Output casts follow the supported unsafe reduction rules. Supplying `out` can
influence loop resolution when `dtype` is omitted.

An ndarray output keeps native precision. Use it for `uint64` or extended floating
values outside Lua's scalar range; converting those values to an ordinary Lua
number can lose precision. The returned object is the original `out` userdata.

## Temporal and dtype behavior

Timedelta traces preserve units and propagate `NaT`. For timedelta input, a
`dtype` option does not change units; explicitly convert with `lr.asarray` before
taking the trace if you need another unit. A temporal `out` selects the final
output units. These rules follow the pinned NumPy trace behavior, including its
legacy dtype handling. Datetime and fixed-string inputs have no valid trace
reduction signature.

Like upstream, passing a timedelta dtype for ordinary numeric input does not
convert that input to a duration and can suppress default integer widening.
Choose a numeric dtype when requesting a numeric accumulator.

## Compatibility

Root and ndarray traces were introduced in **0.118.0-dev**. The existing
`linalg.trace` shares their native kernel. Exact differential tests cover values,
shape, dtype, strides, identity, aliasing, and states after accepted or rejected
operations. They also cover timedelta units, `NaT`, narrow integer overflow,
requested dtype/output combinations, and floating cancellation.

Offsets use NumPy's C `int` range for root/ndarray calls. The safe empty result
for its extreme negative value is tested locally without executing upstream's
signed-negation-overflow path. Object/structured dtypes, foreign protocols,
complete Python warnings/exceptions, and every host ABI remain outside the
verified contract. All APIs remain [partially compatible](api_inventory.md).
