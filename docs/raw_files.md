---
docs_examples: true
---
# Binary array files

`lr.fromfile(file, {dtype = "float64"})` reads native binary elements into an
owned one-dimensional ndarray. `array:tofile(file)` writes the array in
logical C order. Each function accepts a file path or an open Lua file handle.

```lua
local lr = require("luaray")
local source = lr.array({{1, 2}, {3, 4}}, "int16")
local file = assert(io.tmpfile())
lr.transpose(source):tofile(file)
assert(file:seek("set", 0) == 0)
local values = lr.fromfile(file, {dtype = "int16"})
assert(values.size == 4 and values[2] == 3)
assert(file:close())
```

Read controls are `dtype` (default float64), `count` and `offset`. The byte
offset is relative to the current position. A negative count reads all
complete items from the current position of a seekable file. A positive count
reads up to that many items, and the result contains only full items.

```lua
local file = assert(io.tmpfile())
assert(file:write("xx" .. string.pack("<i2i2", 7, 9)))
assert(file:seek("set", 0) == 0)
local first = lr.fromfile(file, {dtype = "int16", offset = 2, count = 1})
assert(first[1] == 7 and file:seek() == 4)
assert(file:close())
```

The examples use the native little-endian byte order on the tested platform.
The file format stores only element bytes. Keep the dtype, byte order and
shape separately when sharing files. Opening an output by path replaces the
file. Passing an open handle writes at its current position and leaves it open.
This API currently handles binary data. For an in-memory string of numeric text,
see [Reading numeric text](fromstring.md).
