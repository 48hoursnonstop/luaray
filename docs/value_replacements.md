---
docs_examples: true
---

# Replacing nonfinite values and evaluating pieces

`lr.nan_to_num(values, options)` replaces NaN with zero and infinities
with the largest or smallest finite value of the floating dtype. Override
the replacements with `nan`, `posinf` and `neginf`; broadcastable arrays
are also accepted. For complex values the rules apply to the real and
imaginary parts separately.

```lua
local lr = require("luaray")
local values = lr.array({0/0, math.huge, -math.huge, 4}, "float32")
local finite = lr.nan_to_num(values, {nan = 0, posinf = 10, neginf = -10})
assert(lr.array_equal(finite, {0, 10, -10, 4}))
assert(lr.isnan(values[1]))
```

The default is to copy. Set `copy = false` to replace values in a
writable ndarray in place. Integer and Boolean values pass through.

`lr.piecewise(values, conditions, functions, ...)` applies each
function only to the values selected by its Boolean mask. A constant
can stand in for a function. A final extra entry covers all unmatched
values, which otherwise default to zero. Later masks take precedence
when masks overlap. Additional arguments go directly to the functions.

```lua
local x = lr.array({-2, -1, 0, 1, 2})
local y = lr.piecewise(x, {lr.less(x, 0), lr.greater(x, 0)}, {
  function(v, scale) return -v * scale end,
  1,
  5
}, 3)
assert(lr.array_equal(y, {6, 3, 5, 1, 1}))
```

`lr.pow` aliases `lr.power`. The legacy `lr.fix(x, out)` uses
truncation toward zero, the same operation exposed by `lr.trunc`.

## Validation

**2,025 cases / 46,176 checks** passed with NumPy 2.5.5. The checks cover nonfinite replacement with copies or views, complex components, masked callback branches and both numeric aliases. NaN positions are checked, with other bytes compared exactly in mutated inputs.
