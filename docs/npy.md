---
docs_examples: true
---

# Saving and loading NPY arrays

`lr.save(file, array)` and `lr.load(file)` exchange individual arrays in
NumPy's NPY format. Each record stores its dtype, shape, storage order and
element bytes. Supply a path or an open Lua file handle.

```lua
local lr = require("luaray")
local source = lr.asfortranarray(lr.array({{1, 2, 3}, {5, 7, 11}}, "int16"))
local file = assert(io.tmpfile())
lr.save(file, source)
assert(file:seek("set", 0) == 0)
local values = lr.load(file)
assert(lr.array_equal(source, values))
assert(values.dtype == "int16" and values.flags.f_contiguous)
assert(file:close())
```

Saving to a path appends `.npy` if the path lacks the suffix. Loading takes the
path exactly as written. An open handle stays open and advances by one record.

```lua
local file = assert(io.tmpfile())
lr.save(file, lr.array(7, "uint8"), {version = 2})
lr.save(file, lr.array(11, "uint8"), {version = 3})
assert(file:seek("set", 0) == 0)
assert(lr.load(file):item() == 7)
assert(lr.load(file):item() == 11)
assert(file:close())
```

Output defaults to version 1.0. The `version` option selects 1.0, 2.0 or 3.0
using integers 1, 2 or 3. Loading accepts all three and checks the header
length before reading it. Use `max_header_size` to set the byte limit, which
defaults to 10,000.

The supported descriptors cover native numeric and temporal types and
fixed-width byte strings and Unicode. Use [binary array files](raw_files.md)
for raw values whose dtype and shape are stored separately.

## Validation

**1,588 cases / 34,411 checks** passed with NumPy 2.5.5. The checks read and write NPY 1.0, 2.0 and 3.0 arrays, preserve C and Fortran storage, validate stream offsets and compare bytes for supported descriptors.
