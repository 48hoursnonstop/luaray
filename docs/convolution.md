---
docs_examples: true
---

# Convolution and cross-correlation

`lr.convolve(a, b, mode)` computes the discrete linear convolution of two
one-dimensional inputs. `lr.correlate(a, b, mode)` computes the cross-correlation,
conjugating the second input when working with complex values.

`"full"` includes every overlapping shift, including the partial overlaps at the
ends. It is the default for convolution. `"valid"` includes only fully
overlapping shifts and is the default for cross-correlation. `"same"`
returns the central segment with length equal to the longer input.

```lua
local lr = require("luaray")
local signal = lr.array({1, 2, 3, 4})
local kernel = lr.array({1, -1})
local filtered = lr.convolve(signal, kernel, "valid")
assert(lr.array_equal(filtered, {1, 1, 1}))
assert(lr.array_equal(lr.correlate(signal, kernel), {-1, -1, -1}))
```

Swapping the operands of cross-correlation reverses the shift direction and,
for complex values, conjugates the result.

```lua
local a = {lr.complex(1, 2), lr.complex(3, 4)}
local b = {lr.complex(2, -1), lr.complex(0, 1)}
local c = lr.correlate(a, b, "full")
assert(lr.array_equal(lr.real(c), {2, 4, 2}))
assert(lr.array_equal(lr.imag(c), {-1, 2, 11}))
```

Neither input may be empty. LuaRay also accepts a scalar as a length-one
input. Mixed dtypes that require NumPy's object dtype raise an error.

## Validation

**2,616 cases / 40,540 checks** passed with NumPy 2.5.5. The checks cover sliding window modes, swapped operand order, strided inputs and complex conjugation. LuaRay rejects 16 mixed-dtype cases that return object arrays in NumPy.
