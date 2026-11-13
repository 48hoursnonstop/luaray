---
docs_examples: true
---
# Reusable dtype descriptors

`lr.dtype(specification)` creates an immutable native descriptor. It describes
storage and casting; it does not contain array values. Omit the specification or
pass nil for float64. Passing an existing descriptor returns the same userdata.

```lua
local lr = require("luaray")
local dtype = lr.dtype("float64")
assert(dtype.name == "float64" and dtype.kind == "f" and dtype.char == "d")
assert(dtype.itemsize == 8 and dtype.isnative and not dtype.hasobject)
assert(rawequal(lr.dtype(dtype), dtype))
assert(lr.dtype(dtype.str) == dtype)
```

## Properties

| Property | Meaning for supported scalar descriptors |
| --- | --- |
| name | NumPy canonical name, such as float64, bytes24 or str96 |
| str | Storage format, including byte order, width and temporal unit |
| kind, char, num | General kind, legacy character code and native type number |
| itemsize, alignment | Element width and required alignment in bytes |
| byteorder | `=`, `\|`, `<` or `>`; native endian normalizes to `=` |
| flags | Descriptor flags; Unicode includes NEEDS_INIT (8) |
| isnative, hasobject | Native storage order and contained-object classification |
| ndim, shape, base | Zero, an empty sequence and this descriptor itself |
| fields, names, subdtype, metadata | Nil for the supported scalar kinds |
| isalignedstruct | False; structured descriptors are not implemented |
| descr | Fresh sequence containing the empty field name and storage format |

Fixed Unicode width counts UCS-4 code points; U3 occupies 12 bytes and has the
canonical name str96. Fixed bytes S3 occupies three bytes and is named bytes24.
These names are distinct from their storage formats. Longdouble reports the
NumPy name determined by its storage width, such as float128 on the tested ABI.
It retains that ABI's actual precision rather than becoming a new floating type.

Equality compares concrete descriptor equivalence, including width, endian and
time metadata. Equivalent integer aliases can have different character codes or
legacy type numbers. Compare descriptors with descriptors; Lua does not invoke
userdata equality against a string. `tostring(dtype)` follows the supported
NumPy scalar dtype display.

## Use descriptors with arrays

```lua
local values = lr.array({1, 2, 3}, dtype)
local integers = lr.astype(values, lr.dtype("int32"))
assert(integers.dtype == "int32")
assert(lr.frombuffer(values, lr.dtype("uint8")).shape[1] == 24)
assert(lr.can_cast(lr.dtype("int32"), dtype))
assert(lr.dtype(lr.promote_types(lr.dtype("int8"), dtype)) == dtype)
```

The shared descriptor reader is used by creation/conversion/like constructors,
`arange`, `astype`, `view`, `frombuffer`, matrix dtype controls, joining, reduction
and cumulative dtype controls, and sequence sampling. `require` delegates to
those creation paths. `can_cast`, `issubdtype`, `promote_types` and `result_type`
accept descriptors. Promotion functions retain their existing Lua string results.

An array's `dtype` property also remains its existing Lua storage-name string.
Use `lr.dtype(array.dtype)` to inspect it. Legacy Lua names such as longdouble
and longlong remain valid even when the descriptor's NumPy `name` differs.
Other legacy readers, including some random-generator controls, still require
strings; descriptor arguments are not certified across every public API.

## Resolve widths without mutating a descriptor

```lua
local unicode = lr.empty({3}, lr.dtype("U4"))
assert(unicode[1] == "" and unicode[3] == "")
local unsized = lr.dtype("S0")
local joined = lr.concatenate({lr.array({1}, "int32"), lr.array({2}, "int32")},
  {dtype = unsized, casting = "unsafe"})
assert(joined.itemsize == 11 and joined[1] == "1" and joined[2] == "2")
assert(unsized.itemsize == 0)
```

Unicode allocations honor NEEDS_INIT, including `empty` and `empty_like`; newly
allocated code points are zero. Numeric `empty` values remain uninitialized.
A zero-width descriptor stays zero-width. Creation, casting, sampling and joining
resolve an output descriptor according to their own contracts.

An unsized join resolves widths from input descriptors without inspecting
values. One same-class Unicode input retains its endian descriptor; combining
instances normalizes through the class common-instance operation. Sampling's
final string cast uses the calculation dtype's legacy formatting width.

## Aliases and errors

```lua
assert(lr.dtype("float") == lr.dtype("float64"))
assert(lr.dtype("f") == lr.dtype("float32"))
assert(lr.dtype("longlong") == lr.dtype("int64"))
assert(lr.dtype("longlong").itemsize == lr.dtype("int64").itemsize)
assert(not pcall(function() dtype.itemsize = 1 end))
```

`float` now correctly means float64. Use float32 or character code `f` for single
precision. Supported numeric character/width codes and native endian prefixes
are accepted. Non-native numeric and temporal descriptors remain unsupported;
non-native fixed Unicode is supported. Invalid or embedded-NUL specifications
raise rather than selecting a fallback type.

This API is partially compatible with NumPy 2.5.3. Python scalar classes, ctypes,
foreign dtype protocols, structured/subarray/object/void/StringDType descriptors,
constructor align/copy/metadata options, `type`, `isbuiltin`, `newbyteorder` and
other unlisted properties are not implemented. Unsupported properties raise.
No claim of complete dtype-class or Python protocol compatibility follows from
these scalar descriptors. See [temporal operations](temporal_scaling.md) for
reduction dtype rules and [validation](development/validation.md) for evidence.

The native boundary exposes descriptor formatting/equivalence through
`ln_dtype_info.h`; callers supply output buffers. Lua binding readers borrow
immutable descriptors through `ln_lua_check_dtype`. High-level use needs no Python.
