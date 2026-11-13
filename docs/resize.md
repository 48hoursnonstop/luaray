---
docs_examples: true
---
# Resizing arrays

`lr.resize(a, shape)` returns independent storage. `a:resize(shape, options)`
changes the existing array. Both accept an integer for rank one or a dense Lua
table of dimensions; `{}` means rank zero. Dimensions must be nonnegative and
rank cannot exceed 64. A negative dimension does not infer a missing extent.

## Repeat values into a new array

```lua
local lr = require("luaray")
local original = lr.array({{1, 2}, {3, 4}}, "int32")
local repeated = lr.resize(original, {2, 3})
assert(repeated:tolist()[2][3] == 2)
assert(not lr.shares_memory(original, repeated))
repeated[1] = 99
assert(original:tolist()[1][1] == 1)
```

The function reads the input in logical C order, repeats that sequence and
truncates it to the requested count. It does not interpolate or resample values.
Transposed and negative-stride arrays are read in their logical order. Ordinary
Lua values first pass through the existing array constructor.

```lua
local columns = lr.resize(lr.transpose(original), {6})
assert(columns:tolist()[2] == 3 and columns:tolist()[5] == 1)
local empty = lr.resize(lr.array({}, "int16"), {2, 2})
assert(empty:tolist()[2][2] == 0)
```

Empty input supplies zeros. Nonempty output normally views a new concatenation
buffer, so `flags.owndata` can be false despite complete independence from the
input. Empty-input and zero-count branches allocate directly. Default Unicode
concatenation normalizes byte order; explicit unsized dtype controls retain
NumPy's separate descriptor-resolution rules. Zero-width S0/U0 arrays preserve
width in the nonempty branch, but the empty branch uses the minimum width of a
like constructor. This follows the tested upstream implementation.

## Change the existing array

```lua
local values = lr.array({1, 2, 3}, "int64")
local alias = values
assert(values:resize({2, 2}) == nil)
assert(rawequal(alias, values))
assert(alias:tolist()[2][1] == 3 and alias:tolist()[2][2] == 0)
values:resize({2})
assert(alias:tolist()[2] == 2)
```

The method returns nil. It retains the existing physical sequence, shrinking it
or appending zeros to writable storage. Fortran-only contiguous arrays keep
Fortran layout. A noncontiguous array is rejected. A byte-count change requires
owned native storage with no live native views; a shape-only change may also
work on a contiguous view or external buffer. Zero-width dtypes can change
element count without reallocating bytes. Calling the method without a shape,
or with nil, does nothing.

## Shared storage and Lua references

```lua
local owner = lr.array({10, 20})
local view = owner:reshape({1, 2})
assert(not pcall(function() owner:resize({3}, {refcheck=false}) end))
owner:resize({2, 1}) -- Same bytes; the view retains its own shape.
assert(view.shape[1] == 1 and owner.shape[1] == 2)
view = nil
collectgarbage("collect")
owner:resize({3})
assert(owner:tolist()[3] == 0)
```

`{refcheck=true}` and `{refcheck=false}` are accepted. Lua aliases to the same
userdata always follow its updated header. CPython reference counts are not
reproduced: both settings reject reallocation while another native view retains
the allocation, preventing dangling pointers. A temporary view can remain live
until Lua collects it. Release such views before resizing their owner.

## Read-only arrays and validation

```lua
local text = lr.array({"λ", "x"}, "U2")
text:setflags(false)
text:resize({4})
assert(not text.flags.writeable and text:tolist()[4] == "")
assert(not pcall(function() lr.resize({1}, {0, -1}) end))
```

Read-only status is preserved. As in the source, the new numeric tail of a
read-only grown array is unspecified; initialize it after making the array
writable before reading it. LuaRay additionally initializes newly allocated
Unicode code points even when read-only, so arbitrary memory cannot become
invalid text. This safety difference is deliberate. All dimensions and
nonzero-axis stride products are validated even after an empty axis; source
states that bypass negative/overflow checks after zero are rejected.

## Verification and limits

NumPy 2.5.3 references passed **18,248 cases / 313,948 exact checks**:
7,776 independent resizes, 7,128 in-place cases and 3,344 layout/Unicode
concatenation regressions. They compare initialized bytes, dtypes, shapes,
strides, flags and input/base states across 18 dtypes and C/F, transposed,
reversed, stepped and read-only arrays. Longdouble comparisons omit ABI padding.
Read-only growth references read only the initialized prefix; undefined source
tails and malformed source shapes are never used as expected values.

The permanent Lua regression adds 156 checks; a native harness tests ownership,
reallocation, released external buffers, live views and checked bounds. Both
APIs remain partial: object/structured/variable-width string dtypes, foreign
protocols, Python refcount behavior and variadic shape signatures are not covered.
