---
docs_examples: true
---
# Contract tensor axes

`lr.tensordot(a, b, axes)` multiplies two arrays and sums over selected pairs of
axes. The remaining axes of `a` come first in the result, followed by those of `b`.
Inputs can be ndarrays, rectangular Lua sequences or scalars.

## Matrix multiplication and a complete contraction

```lua
local lr = require("luaray")
local a = lr.arange(6):reshape({2, 3})
local b = lr.arange(12):reshape({3, 4})
local matrix = lr.tensordot(a, b, 1)
assert(matrix.shape[1] == 2 and matrix.shape[2] == 4)
assert(matrix:get(1, 1) == 20 and matrix:get(2, 4) == 92)
local dot = lr.tensordot({1, 2}, {3, 4}, 1)
assert(dot.ndim == 0 and dot:tolist() == 11)
```

An integer `axes=n` contracts the last `n` axes of `a` against the first `n` axes
of `b`. Corresponding lengths must match. The default is two; a negative count
acts as zero, following the pinned reference. Counts must be Lua integers.

## Choose individual axes

```lua
local tensor = lr.arange(12):reshape({2, 3, 2})
local result = lr.tensordot(tensor, tensor, {axes={{3, 1}, {3, 1}}})
assert(result.shape[1] == 3 and result.shape[2] == 3)
assert(result:get(1, 1) == 86)
local same = lr.tensordot(a, b, {-1, 1})
assert(same:get(1, 1) == 20)
```

Positive axis numbers start at **one**; negative axes count from the end.
Use `{axes_a, axes_b}` directly or `{axes={axes_a, axes_b}}`. Each member can be
one integer or a sequence. Both lists must have equal length, with no duplicate
normalized axes. An empty options table uses the default two-axis contraction.

## Form a tensor product

```lua
local product = lr.tensordot({1, 2}, {3, 4}, {axes=0})
assert(product.shape[1] == 2 and product.shape[2] == 2)
assert(product:get(2, 2) == 8)
local explicit = lr.tensordot({1, 2}, {3, 4}, {{}, {}})
assert(explicit:get(1, 2) == 4)
```

Zero paired axes multiply without summing. All input axes remain in the result.
This differs from [Kronecker products](kron.md), which combine corresponding
axis lengths into blocks.

## Empty dimensions, dtypes and ownership

```lua
local empty_sum = lr.tensordot(lr.zeros({2, 0}, "int8"),
                              lr.zeros({0, 3}, "int8"), 1)
assert(empty_sum.shape[1] == 2 and empty_sum.shape[2] == 3)
assert(empty_sum.dtype == "int8" and empty_sum:get(2, 3) == 0)
assert(not lr.shares_memory(matrix, a))
```

The result is an independent, writable ndarray, including typed rank-zero results.
Empty contracted axes produce typed zeros; empty remaining axes stay empty.
Strong dtype promotion and the shared `dot` engine determine computation precision.
Complex values are multiplied **without conjugation**. Boolean products use the
reference's logical contraction. Reversed, transposed, broadcast and Fortran views
are accepted.

Legacy timedelta dot products operate on raw integer ticks after conversion to a
common unit. They wrap at native integer width and do not propagate NaT like
ordinary duration multiplication. Mixed duration/floating products that require
NumPy object storage remain blocked by the unavailable object dtype.

## Compatibility

Available since **0.126.0-dev**. Source-derived permutation, reshape and dot
semantics are tested against NumPy 2.5.3. Axis conventions are adapted to Lua.
Results exceeding the build's 64-axis limit raise before writing native shape
buffers. Full object/structured dtype, foreign scalar and subclass protocols
remain unsupported. Availability is [partial compatibility](api_inventory.md),
not a claim of complete tensor API parity. See [validation](development/validation.md)
for exact and numerical comparison scope. BLAS zero-valued result components may
have either sign across vendors; observed differences are counted explicitly.
