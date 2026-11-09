---
docs_examples: true
---
# Fill a diagonal in place

`fill_diagonal` writes the main diagonal without constructing coordinate arrays.
It modifies the destination and returns no value.

| Signature | Meaning |
| --- | --- |
| `lr.fill_diagonal(a, values, wrap)` | `wrap` defaults to false. |
| `lr.fill_diagonal(a, values, {wrap=...})` | Options-table form. |

The destination must be a writable ndarray with at least two dimensions. Matrices
can be rectangular. Higher-dimensional arrays require every axis to have the same
length. `wrap` must be a Lua Boolean and affects only tall matrices.

## Repeat a value sequence

```lua
local lr = require("luaray")
local matrix = lr.zeros({3, 4}, "int64")
assert(lr.fill_diagonal(matrix, {2, 7}) == nil)
assert(matrix:get(1, 1) == 2 and matrix:get(2, 2) == 7)
assert(matrix:get(3, 3) == 2 and matrix:get(1, 2) == 0)
```

A scalar fills every selected element. Arrays and nested sequences are traversed
in logical C order, cycling when the diagonal is longer than the values. Empty
values leave the destination unchanged. They are still validated and converted,
even when the destination has no diagonal elements. A read-only destination raises.

## Wrap a tall matrix

```lua
local tall = lr.zeros({5, 3}, "int16")
lr.fill_diagonal(tall, {1, 2}, true)
assert(tall:get(1, 1) == 1 and tall:get(2, 2) == 2)
assert(tall:get(3, 3) == 1 and tall:get(5, 1) == 2)
```

With `wrap=false`, filling stops at the end of the main diagonal. With `wrap=true`,
flat positions continue at intervals of `columns+1`, so a later row can receive
another element in its first column. This is the historical NumPy wrap convention.

## Write through views and handle overlap

```lua
local base = lr.zeros({3, 3}, "float64")
lr.fill_diagonal(lr.flip(base, 1), {3, 4, 5})
assert(base:get(3, 1) == 3 and base:get(2, 2) == 4)
assert(base:get(1, 3) == 5)
```

Fortran, transposed and reversed layouts are traversed logically while writes
reach the original storage. Matching-dtype value arrays are read **live**. When
values overlap the destination, an earlier write can change a later read. This
matches upstream's flat-iterator assignment. Pass an explicit copy of values
when you want a snapshot. A required dtype conversion creates separate storage.

## Scalar and array conversions

```lua
local small = lr.zeros({2, 2}, "int8")
lr.fill_diagonal(small, lr.array({256}, "int64"))
assert(small:get(1, 1) == 0)
assert(not pcall(function() lr.fill_diagonal(small, 256) end))
```

Typed arrays use unsafe dtype conversion, so int64 `256` wraps to int8 zero.
An ordinary Lua integer is checked against the destination bounds and raises
instead. Strings, complex and temporal values follow the shared assignment
conversion path; fixed-width text is truncated to fit.

## Compatibility

Available since **0.124.0-dev**. Exact NumPy 2.5.3 references cover values, dtype,
shape, strides, backing storage, read-only errors, empty selections, repetition,
wrap behavior, conversion failures and progressive overlap. Python subclass,
foreign scalar and warning/exception protocols remain incomplete. The API is
[partially compatible](api_inventory.md).
