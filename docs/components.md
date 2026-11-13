---
docs_examples: true
---
# Real and imaginary components

LuaRay 0.111.0-dev provides `lr.real(a)`, `lr.imag(a)`, `a.real` and `a.imag`
through independently compiled native and Lua modules. Python is not required.

```lua
local lr = require('luaray')
local z = lr.array({lr.complex(1,2), lr.complex(3,4)}, 'complex64')
local real, imag = z.real, lr.imag(z) -- float32 views, stride 8 bytes
lr.copyto(real, 7, 'unsafe') -- z becomes {7+2j,7+4j}
lr.copyto(imag, -3, 'unsafe') -- z becomes {7-3j,7-3j}
assert(lr.shares_memory(real, z))
assert(not lr.shares_memory(real, imag)) -- disjoint interleaved components
assert(lr.may_share_memory(real, imag)) -- overlapping address bounds
```

Complex64, complex128 and clongdouble yield float32, float64 and longdouble
component views, respectively. Shape and byte strides remain unchanged; the
imaginary pointer advances one real component. Contiguity flags are recomputed
for the smaller dtype. Views retain the original buffer's lifetime and read-only
status, including transposed, reversed, strided and broadcast inputs.

For a noncomplex ndarray, real returns the identical Lua userdata. Imaginary
returns an independent zero-filled array with the same shape/dtype, preserving
Fortran order when appropriate, and is read-only. This also follows NumPy for
fixed S/U and temporal arrays: zeros mean empty strings or zero temporal ticks.
Use `lr.copy(a.imag)` if writable independent storage is needed.

Ordinary Lua scalars and rectangular tables use the existing constructor.
Scalar results follow LuaRay's typed rank-zero ndarray convention. Direct
property replacement (`a.real = values`) remains unsupported; write through
the returned component view with normal indexing or `copyto` instead. Complete
NumPy setter/subclass/device/foreign-array behavior is not claimed.

The original NumPy 2.5.3 fixture executes **3,300 cases / 273,192 exact checks**
over fifteen dtypes and scalar/empty/multidimensional inputs, C/F/permuted/
negative/strided/broadcast layouts, both call forms, identity, component sharing,
writeability and actual post-write backing values. A native C suite and 33 Lua
checks verify offsets, owner lifetime after collection, interleaving and errors.
All APIs remain partial. Five source/test hashes pin the getset/type-check
reference in [pinned source hashes](https://github.com/48hoursnonstop/luaray/blob/main/compatibility/numpy-source.sha256).

```sh
make -j4 full-test
make reference-test
```

See [layout](layout.md), [creation](creation.md) and the
[availability inventory](api_inventory.md). The inventory excludes noncallable
properties and does not measure overall compatibility.

## Conjugation methods

`a:conj()` and `a:conjugate()` share a native method binding. A real-valued
numeric array, including Boolean input, returns the identical userdata. Complex
input produces independent conjugated values. The method differs from the
root `lr.conjugate(a)` ufunc's allocation/type-resolution path.

```lua
local values = lr.array({1, 2, 3}, "float64")
assert(rawequal(values:conj(), values))
local truth = lr.array({true, false}, "bool")
assert(rawequal(truth:conjugate(), truth) and truth:conj().dtype == "bool")
```

```lua
local source = lr.array({lr.complex(1, 2), lr.complex(3, -4)}, "complex64")
local conjugated = source:conjugate()
assert(lr.imag(conjugated):tolist()[1] == -2)
assert(lr.imag(source):tolist()[1] == 2)
assert(not lr.shares_memory(source, conjugated))
```

Pass an output array directly or as `{out=array}`. The returned userdata is that
output. Real inputs use same-kind array assignment; complex inputs use the
existing conjugate ufunc executor. Broadcasting, negative strides and aliased
outputs follow those engines. String and temporal inputs are rejected. Unknown
options, extra arguments and non-array outputs are errors; the method accepts
only the optional output control.

```lua
local output = lr.zeros({2}, "complex64")
assert(rawequal(source:conj({out=output}), output))
source:setflags(false)
assert(rawequal(source:conjugate(output), output))
assert(not pcall(function() source:conj(source) end))
```

Read-only source data can produce independent writable conjugates or write to
a separate writable output. Real identity paths preserve the input flags.
Complex output aliases must be writable. Complex rank-zero results without an
output follow LuaRay's existing unary convention: an owned writable rank-zero
ndarray. NumPy returns a scalar in that case. Its numerical bytes and dtype are
preserved; return representation, writeability and post-write checks explicitly
use the declared Lua adaptation rather than claiming scalar-object parity.

```lua
local point = lr.array(lr.complex(1, 2), "complex64")
local result = point:conj()
assert(result.ndim == 0 and result.flags.owndata and result.flags.writeable)
assert(lr.imag(result):tolist() == -2)
```

The method reference passed **28,140 cases / 340,632 checks** against NumPy
2.5.3, including explicit outputs, dtype/casting errors, broadcast/F layouts,
read-only and aliased arrays, NaN, infinity, signed zeros and actual post-write
backing states. All numerical/metadata comparisons are exact within the stated
return adaptation; longdouble omits ABI padding. **24 scalar reference results**
were normalized to the Lua rank-zero array convention. The corpus regenerates
exactly; the permanent regression adds 82 Lua checks. Both methods remain
partial; foreign protocols, subclasses, all host ABIs and complete ufunc keyword
behavior are not certified.
