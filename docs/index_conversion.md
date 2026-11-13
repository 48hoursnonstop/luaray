---
docs_examples: true
---
# Flat indices and coordinate positions

`lr.ravel_multi_index(coordinates, shape, options)` turns coordinates into flat
positions. `lr.unravel_index(indices, shape, options)` performs the reverse
conversion. Locations start at **one**, including the flat result. Shape can be
a nonnegative Lua integer for one axis or a dense table of integer dimensions.
The target array is not allocated.

```lua
local lr = require("luaray")
local flat = lr.ravel_multi_index({4, 5}, {7, 6})
assert(flat == 23)
local point = lr.unravel_index(flat, {7, 6})
assert(point[1] == 4 and point[2] == 5)
```

## Coordinate operands and broadcasting

Supply one operand per target axis. Each operand can be a scalar, Lua sequence
or integer ndarray. The operands broadcast together; the flat output has their
broadcast shape. A coordinate ndarray can also supply its first axis as the
sequence of coordinate operands. Scalar flat results are Lua integers.

`lr.indices` produces numerical data with zero origin. Add one before using
those grids as Lua locations.

```lua
local coordinates = lr.indices({2, 3}) + 1
local positions = lr.ravel_multi_index(coordinates, {2, 3})
assert(positions:get(1, 1) == 1 and positions:get(2, 3) == 6)
local broadcast = lr.ravel_multi_index({
  lr.array({{1}, {2}}, "int32"), lr.array({1, 2, 3}, "int32")
}, {2, 3})
assert(broadcast:get(2, 2) == 5)
```

## Logical C and F order

The default order is C: the last target axis changes fastest. F order makes the
first axis change fastest. This selects the logical flat-position calculation;
the result's physical strides follow the iterator's KEEPORDER layout. Only C/F
orders are accepted, including their lowercase spellings.

```lua
assert(lr.ravel_multi_index({2, 1}, {2, 3}) == 4)
assert(lr.ravel_multi_index({2, 1}, {2, 3}, {order = "F"}) == 2)
local point = lr.unravel_index(4, {2, 3}, {order = "F"})
assert(point[1] == 2 and point[2] == 2)
```

## Bounds modes

Ravel accepts `mode = "raise"` (default), `"wrap"` or `"clip"`, either once for
all axes or as a table with one mode per axis. The corresponding numeric codes
are 2, 1 and 0. Positive locations are converted by subtracting one; negative
values retain their sign. Raise mode requires in-range nonnegative converted
coordinates. Wrap uses modulo; clip clamps converted negative values to the
first element. **Zero is invalid whenever traversed**, including wrap/clip.

```lua
assert(lr.ravel_multi_index({-1, 99}, {2, 3}, {
  mode = {"wrap", "clip"}
}) == 6)
assert(lr.ravel_multi_index({-1, -1}, {2, 3}, {mode = "clip"}) == 1)
assert(not pcall(lr.ravel_multi_index, {0, 1}, {2, 3}, {mode = "wrap"}))
```

Unravel requires valid flat locations and has no bounds mode. Supported typed
indices use same-kind conversion to the native pointer-width signed integer;
full-width unsigned values can wrap during that conversion before bounds checks.
Floating, complex, string and temporal index arrays are rejected.

## Coordinate views and ownership

Unravel returns a table containing one result per target axis. Scalar indices
produce Lua integer coordinates. Array indices produce writable ndarray views
into a new interleaved coordinate buffer, with the same logical shape as the
indices. Those views do not own storage and do not share input data. Distinct
coordinate fields can have overlapping address bounds while sharing no bytes.

```lua
local input = lr.array({1, 6}, "int64")
local coordinates = lr.unravel_index(input, {2, 3})
assert(coordinates[1].strides[1] == 16)
assert(not coordinates[1].flags.owndata)
assert(not lr.shares_memory(coordinates[1], coordinates[2]))
assert(lr.may_share_memory(coordinates[1], coordinates[2]))
coordinates[1]:fill(2)
assert(coordinates[2][2] == 3 and input[2] == 6)
```

Retaining a single view keeps its buffer alive. Outputs remain writable when
the input is read-only. Empty views retain their compatible interleaved strides.

## Empty and scalar targets

A target with a zero dimension cannot contain any location, but typed empty
index arrays can produce empty outputs. An empty shape denotes a scalar target:
its sole flat position is one, with no coordinate axes. Unravel accepts only a
scalar index for that target; an index array, including an empty one, is rejected.
An ordinary empty Lua sequence cannot infer an integer index dtype.

```lua
local empty = lr.unravel_index(lr.array({}, "int64"), {0, 3})
assert(#empty == 2 and empty[1].size == 0)
assert(empty[2].strides[1] == 16)
assert(lr.ravel_multi_index({}, {}) == 1)
assert(#lr.unravel_index(1, {}) == 0)
assert(not pcall(lr.unravel_index, lr.array({}, "int64"), {}))
```

## Integer and rank limits

Target products and compatible strides are checked against native `intp` limits.
Negative dimensions are rejected even after a zero dimension. Ravel supports at
most 63 target axes; unravel supports up to 64 target axes and index-array rank
up to 63. Coordinate operand arrays and flat ravel results can have rank 64.

```lua
local shape = {math.maxinteger}
assert(lr.ravel_multi_index({math.maxinteger}, shape) == math.maxinteger)
assert(lr.unravel_index(math.maxinteger, shape)[1] == math.maxinteger)
assert(not pcall(lr.ravel_multi_index, {1, 1}, {math.maxinteger, 2}))
assert(not pcall(lr.unravel_index, 1, {math.maxinteger, 2}))
```

These functions use the existing Lua index convention after integer conversion.
A Boolean true is location one; false converts to invalid zero. Use explicit
integer coordinates when translating Boolean numerical data from NumPy.
Unknown options and embedded-NUL mode names are rejected.

```lua
assert(lr.ravel_multi_index({true}, 3) == 1)
assert(not pcall(lr.unravel_index, false, 3))
assert(not pcall(lr.unravel_index, 1.0, 3))
assert(not pcall(lr.ravel_multi_index, {1}, 3, {dtype = "int64"}))
```

Index conversion passed **40,822 cases /391,028 checks**: 32,128 ravel and 8,694 unravel cases, with 168 permanent Lua checks, a native harness and C++ header/link execution. Checks cover positions, dtype, shape, strides, flags, C/F and KEEPORDER, bounds modes, broadcasting, shared views, writes and input independence. The corpus regenerated exactly. Another 105,704 input values were rebased to Lua locations, 11,312 narrow/Boolean arrays were upcast and 4,932 scalar returns were normalized. Another 1,472 cases (3,136 operands) cannot represent the maximum intp location after adding one and were excluded, along with unsafe upstream inputs; they are not counted as passes.

The APIs remain partial. Lua tables and integer shapes replace Python shape and
sequence protocols. NumPy scalar classes, foreign dispatch and non-native numeric
endian are not implemented. All host ABIs, malformed foreign layouts, resource
limits and every input combination are not certified.
