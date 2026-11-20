---
docs_examples: true
---

# Floating-point neighbors and stable sums

`lr.nextafter(x, toward)` returns the floating-point value adjacent to each
element of `x` in the direction of `toward`. `lr.spacing(x)` measures the
spacing according to NumPy's rules for the selected floating dtype. For
negative values, float16 steps toward positive infinity, while float32,
float64 and longdouble measure outward and return a negative gap.
Both signs of zero give a positive smallest subnormal for `spacing`.

```lua
local lr = require("luaray")
local x = lr.array({1, -1, 0}, "float32")
assert(lr.nextafter(x, 2.0)[1] == 1 + 2^-23)
assert(lr.spacing(x)[2] == -2^-23)
assert(lr.spacing(x)[3] == 2^-149)
```

`lr.heaviside(x, at_zero)` returns 0 for negative inputs, 1 for positive
inputs, and `at_zero` for either sign of zero. NaN inputs return NaN.
`lr.logaddexp(x, y)` evaluates the natural logarithm of `exp(x) + exp(y)`
without directly exponentiating the largest operand. `lr.logaddexp2` uses base 2.

```lua
local steps = lr.heaviside({-2, 0, 3}, 0.5)
assert(steps[1] == 0 and steps[2] == 0.5 and steps[3] == 1)
assert(lr.logaddexp({1000}, -1000)[1] == 1000)
assert(lr.logaddexp2({12}, 12)[1] == 13)
```

These real ufuncs broadcast their inputs and accept the usual `out` and
`where` options. The dtype follows input precision and the native promotion
rules. `spacing(±infinity)` produces NaN. On the tested x87 longdouble
platform, the largest finite magnitude also produces NaN as in NumPy 2.5.5.

## Validation

**1,532 cases / 41,016 checks** passed with NumPy 2.5.5. The checks exhaust every float16 bit pattern for spacing and nextafter, including signed zero and NaN encodings. Additional cases cover floating dtype and weak-scalar promotion, real extreme values, masked output and overlapping views. Wider NaNs are compared by classification.
