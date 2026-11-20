---
docs_examples: true
---
# Reading numeric text

Use `lr.fromstring(text, {sep = ",", dtype = "float64"})` to read delimited
values into an owned one-dimensional array. The separator is required.
The default dtype is float64.

```lua
local lr = require("luaray")
local values = lr.fromstring("1, 2, -3", {sep = ",", dtype = "int16"})
assert(values[1] == 1 and values[3] == -3)
assert(values.flags.owndata)
```

A separator can contain multiple characters. Whitespace in the separator
matches runs of ASCII whitespace. A separator containing only whitespace
splits successive values separated by whitespace.

```lua
local xy = lr.fromstring("3.5\t -2.0", {sep = " "})
assert(xy[1] == 3.5 and xy[2] == -2)
local pair = lr.fromstring("1 :: 2", {sep = "::"})
assert(pair.size == 2)
```

Use `count` to read a prefix. A negative count reads to the end. A count of
zero returns an empty array. A positive count requires that many parsed values.
This last rule avoids the uninitialized tail that NumPy 2.5.5 can return
when the input ends early.

```lua
local prefix = lr.fromstring("1,2,skip", {sep = ",", count = 2})
assert(prefix.size == 2 and prefix[2] == 2)
assert(not pcall(lr.fromstring, "1", {sep = ",", count = 2}))
```

Supported formats include integers, Boolean, real floating point, complex64,
complex128 and integer ticks for temporal dtypes. Integer text uses the native
scanner's casting rules. Fixed-width strings and clongdouble do not have a
source text loop. Use `frombuffer` for binary data.
