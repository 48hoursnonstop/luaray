# Real and imaginary components

LuaRay 0.111.0-dev provides `np.real(a)`, `np.imag(a)`, `a.real` and `a.imag`
through independently compiled native and Lua modules. Python is not required.

```lua
local np = require('luaray')
local z = np.array({np.complex(1,2), np.complex(3,4)}, 'complex64')
local real, imag = z.real, np.imag(z) -- float32 views, stride 8 bytes
np.copyto(real, 7, 'unsafe') -- z becomes {7+2j,7+4j}
np.copyto(imag, -3, 'unsafe') -- z becomes {7-3j,7-3j}
assert(np.shares_memory(real, z))
assert(not np.shares_memory(real, imag)) -- disjoint interleaved components
assert(np.may_share_memory(real, imag)) -- overlapping address bounds
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
Use `np.copy(a.imag)` if writable independent storage is needed.

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
reference in [NUMPY_2_5_3_COMPONENTS111_FILE_HASHES.sha256](../../compatibility/upstream/NUMPY_2_5_3_COMPONENTS111_FILE_HASHES.sha256).

```sh
make components111-test CXXFLAGS='-O0 -g -std=c++11 -Wall -Wextra -Wpedantic'
make full-test CXXFLAGS='-O0 -g -std=c++11 -Wall -Wextra -Wpedantic'
make sanitize-components111
```

See [layout](layout.md), [creation](creation.md) and the
[availability inventory](api_inventory.md). The inventory excludes noncallable
properties and does not measure overall compatibility.
