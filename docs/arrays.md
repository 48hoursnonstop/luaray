---
docs_examples: true
---
# Array fundamentals

An ndarray stores values with a shared dtype and a shape. Use it when you want
to calculate over whole collections rather than loop over Lua tables yourself.

## Create an array

```lua
local np = require("luaray")
local a = np.array({{1, 2, 3}, {4, 5, 6}}, "float64")

assert(a.ndim == 2)            -- number of axes
assert(a.shape[1] == 2)        -- two rows
assert(a.shape[2] == 3)        -- three columns
assert(a.size == 6)            -- total number of elements
assert(a.dtype == "float64")
```

A shape is a Lua table of dimensions. `{2, 3}` describes two rows and three
columns. Specify a dtype when precision, storage size, or integer range matters.
[Creation and copying](creation.md) covers constructors and conversion options.

## Read and write values

Positive indices start at **1**. Negative indices count backward from the end;
zero is invalid. Use `get()` to address multiple axes and `set()` to assign.
The value comes **first** in `set(value, index, ...)`.

```lua
assert(a:get(2, 3) == 6)
assert(a:get(-1, -1) == 6)
a:set(60, 2, 3)
assert(a:get(2, 3) == 60)

local row = a[1]              -- a view of the first row
row[2] = 20
assert(a:get(1, 2) == 20)
```

For a multidimensional array, indexing its first axis returns a view of the
remaining axes. For a one-dimensional array, numeric indexing returns a value.
`a:tolist()` converts the array into nested Lua data.

## Slice an array

`np.slice(start, stop, step)` uses an **exclusive stop**. Omit a bound with `nil`.
A negative step reverses traversal. Basic slices share storage with their source.

```lua
local values = np.array({10, 20, 30, 40, 50}, "int32")
local middle = values[np.slice(2, 5)] -- {20, 30, 40}
assert(middle.size == 3 and middle[3] == 40)

local reversed = values[np.slice(nil, nil, -1)]
assert(reversed[1] == 50)
reversed[1] = 99
assert(values[5] == 99)
```

Use `a:get(spec1, spec2, ...)` for slices on several axes. `np.ellipsis` stands
for the remaining axes; `np.newaxis` inserts a dimension of length one.

## Calculate elementwise

Arithmetic operators work element by element. Named functions handle common
mathematics such as square roots, powers, clipping, and trigonometry.

```lua
local x = np.array({1, 4, 9}, "float64")
local y = np.sqrt(x) * 2
assert(y[1] == 2 and y[2] == 4 and y[3] == 6)
```

See [unary operations](unary_math.md), [binary operations](binary_math.md), and
[clipping](clip.md) for signatures and supported options.

## Broadcast compatible shapes

Broadcasting matches dimensions from the right. Each pair must have equal
lengths or include a length-one dimension. A one-dimensional array can therefore
be combined with every row of a matrix:

```lua
local matrix = np.array({{1, 2, 3}, {4, 5, 6}}, "float64")
local offsets = np.array({10, 20, 30}, "float64")
local shifted = matrix + offsets
assert(shifted:get(1, 1) == 11)
assert(shifted:get(2, 3) == 36)
```

Shapes `{2, 3}` and `{3}` broadcast to `{2, 3}`. Shapes `{2, 3}` and `{2}`
are incompatible because the last dimensions have lengths 3 and 2.

## Reduce an axis

Omitting the axis reduces the entire array. Positive axes are one-based:
axis 1 combines rows; axis 2 combines columns in this matrix.

```lua
assert(np.sum(matrix) == 21)
local row_totals = np.sum(matrix, 2)
assert(row_totals[1] == 6 and row_totals[2] == 15)
local column_totals = np.sum(matrix, 1)
assert(column_totals[1] == 5 and column_totals[3] == 9)
```

Full reductions can return a Lua scalar. Reductions that retain axes return an
ndarray. Return types and supported options depend on the operation.

## Choose between a view and a copy

Views share storage. A copy owns independent storage. Use `copy()` before editing
when you need to preserve the original array.

```lua
local view = matrix[1]
local independent = matrix:copy()
assert(np.shares_memory(matrix, view))
assert(not np.shares_memory(matrix, independent))
independent:set(100, 1, 1)
assert(matrix:get(1, 1) == 1)
```

Reshaping and transposing can return views. [Shape and layout](layout.md) explains
copy policies, strides, flattening, and contiguity. [Masked writes](masked_writes.md)
explains how shared storage affects assignment.
