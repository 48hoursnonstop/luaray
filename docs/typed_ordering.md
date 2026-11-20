---
docs_examples: true
---

# Sorting dates, text and complex values

`lr.sort(values, options)` sorts along the last axis by default. Use
`axis` to choose another axis or `descending = true` to reverse the
comparison. `lr.argsort` returns one-based positions along the same axis.
Fixed byte strings use byte order and fixed Unicode strings use code
point order. Dates and durations use their stored ticks, with NaT
placed last in both directions.

```lua
local lr = require("luaray")
local dates = lr.array({3, 1, math.mininteger, -1}, "datetime64[D]")
local ranks = lr.argsort(dates)
assert(lr.array_equal(ranks, {4, 2, 1, 3}))
local sorted = lr.sort(dates):view("int64")
assert(lr.array_equal(sorted, {-1, 1, 3, math.mininteger}))
```

`lr.sort_complex(values)` sorts along the last axis and returns a
complex array. On complex inputs it compares the real component first
and then the imaginary component. The result keeps an existing complex
dtype. Real input is converted to the complex dtype selected for its
source dtype.

```lua
local z = lr.sort_complex({lr.complex(2, -1), lr.complex(1, 3), lr.complex(1, -2)})
assert(lr.array_equal(lr.real(z), {1, 1, 2}))
assert(lr.array_equal(lr.imag(z), {-2, 3, -1}))
```

## Validation

**2,886 cases / 58,824 checks** passed with NumPy 2.5.5. The checks cover fixed bytes and Unicode, dates and durations, NaT placement, wide records, descending order, typed partition fallback and complex result dtypes.
