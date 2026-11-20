---
docs_examples: true
---

# Elementwise membership

`lr.isin(element, test_elements, options)` returns a Boolean array with the
shape of `element`. Each entry reports whether the corresponding value is
present anywhere in `test_elements`, regardless of the latter's shape.

```lua
local lr = require("luaray")
local values = lr.array({{0, 2, 3}, {1, 5, 2}}, "uint8")
local mask = lr.isin(values, {2, 5})
assert(mask[1][2] and mask[2][2] and not mask[1][1])
local absent = lr.isin(values, {2, 5}, {invert = true})
assert(absent[1][1] and not absent[2][2])
```

The default chooses a bounded integer lookup table when the input permits.
`kind = "table"` requires Boolean or integer inputs and requests that lookup
directly. `kind = "sort"` disables the integer table. The general path
uses direct comparisons for small key sets and a stable sort for larger sets.
Set `assume_unique = true` when both inputs already contain distinct values.

```lua
local all = lr.arange(1, 40, 1)
local selected = lr.arange(20, 60, 1)
local mask = lr.isin(all, selected, {kind = "sort", assume_unique = true})
assert(not mask[19] and mask[20] and mask[39])
```

Inversion complements the membership mask. NaNs compare unequal, including
against NaNs in the key array. Integer lookup handles mixed signed and
unsigned values without a floating-point conversion.

## Validation

**3,194 cases / 53,252 checks** passed with NumPy 2.5.5. The checks exercise integer lookup and sort routes, inverted masks, mixed signed and unsigned limits, typed equality and strided inputs.
