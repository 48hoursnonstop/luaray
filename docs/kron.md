---
docs_examples: true
---
# Kronecker product

`lr.kron(a, b)` replaces each element of `a` with a scaled block of `b`.
It accepts two ndarrays, rectangular Lua sequences or scalars and returns an
independent, writable ndarray.

## Build a block matrix

```lua
local lr = require("luaray")
local weights = lr.array({{1, 2}, {3, 4}}, "int32")
local blocks = lr.kron(weights, lr.eye(2))
assert(blocks.shape[1] == 4 and blocks.shape[2] == 4)
assert(blocks:get(1, 1) == 1 and blocks:get(1, 3) == 2)
assert(blocks:get(3, 1) == 3 and blocks:get(3, 3) == 4)
assert(blocks:get(1, 2) == 0)
```

Each 2×2 block is the identity multiplied by its corresponding weight.
This differs from ordinary matrix multiplication: the dimensions are multiplied,
rather than contracted.

## Combine different ranks

```lua
local tensor = lr.kron(lr.ones({2, 1, 2}, "int16"),
                       lr.ones({2, 3}, "int16"))
assert(tensor.shape[1] == 2 and tensor.shape[2] == 2)
assert(tensor.shape[3] == 6)
```

The smaller rank is padded on the left with singleton axes. Output axis `d` has
length `a.shape[d] * b.shape[d]` after padding. Empty axes remain empty.
The ordering follows the block rule for every dimension.

## Dtype and scalar behavior

```lua
local vector = lr.array({1, 2}, "int8")
local scaled = lr.kron(vector, 2)
assert(scaled.dtype == "int64" and scaled[2] == 4)
local narrow = lr.kron(vector, lr.array(2, "int8"))
assert(narrow.dtype == "int8")
```

Both inputs become strong typed arrays before multiplication. An ordinary Lua
integer therefore contributes int64, rather than following weak-scalar arithmetic.
Explicit typed scalars retain their descriptors. Boolean products use logical
multiplication; complex products use complex arithmetic. Unsupported multiply
signatures, including fixed-width strings and datetime products, raise errors.
[Durations can be scaled by integers or floats](temporal_scaling.md).

## Views, copies and rank limits

Reversed, transposed, broadcast and Fortran inputs retain their logical values.
The result shares no storage with either operand. Its strides follow native
multiplication followed by C-order reshape; do not infer a physical layout from
shape alone.

The implementation follows the reference's interleaved-axis construction, which
needs twice the expanded rank. The usual rank limit is therefore 32 on a
64-dimension build. A scalar **right** operand takes an earlier multiplication
path and can accept higher-rank left arrays. A scalar left operand is padded
before that test, matching the reference's asymmetric limit. These limits raise
errors rather than silently changing the algorithm.

Scalar results use LuaRay's typed rank-zero ndarray convention. Unknown extra
arguments and malformed rectangular sequences raise errors.

## Compatibility

Available since **0.125.0-dev**. References against NumPy 2.5.3 cover dtype
promotion, block ordering, shape, strides, empty dimensions, views, ownership,
writable results, temporal signatures and rank boundaries. Ordinary exact cases
compare exactly. General complex64 products use relative tolerance `3e-7`;
wider floating/complex products use `3e-15`. Observed errors were zero in the
new random corpus. Subclasses and foreign array/scalar protocols remain unsupported;
the API is [partially compatible](api_inventory.md).
