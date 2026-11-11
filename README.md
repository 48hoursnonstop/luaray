# LuaRay

**NumPy-style numerical computing for Lua.**

[![Native Lua regression](https://github.com/48hoursnonstop/luaray/actions/workflows/native.yml/badge.svg?branch=main)](https://github.com/48hoursnonstop/luaray/actions/workflows/native.yml)

[Documentation](https://48hoursnonstop.github.io/luaray/) · [Español](https://48hoursnonstop.github.io/luaray/es/) · [Releases](https://github.com/48hoursnonstop/luaray/releases) · [Changelog](CHANGELOG.md)

LuaRay provides typed multidimensional arrays, broadcasting, shared memory views,
mathematical and statistical operations, FFTs, linear algebra, and random number
generation. The public API uses Lua 5.4; numerical kernels run in C and C++.
Building and running LuaRay requires no Python interpreter.

```lua
local lr = require("luaray")

local values = lr.array({1, 2, 3}, "float64")
local squared = lr.square(values)
assert(lr.sum(squared) == 14)

local normal = lr.cross({1, 0, 0}, {0, 1, 0})
assert(normal:tolist()[3] == 1)
```

## Build and run

Linux is the primary supported platform. You need Lua 5.4 and its shared library,
a C11 compiler, a C++11 compiler, Make, BLAS/CBLAS, and LAPACK. `pkg-config` helps
the build locate installed libraries.

```sh
git clone --depth 1 https://github.com/48hoursnonstop/luaray.git
cd luaray
make -j4 build/luaray_core.so
```

Run the quickstart from the checkout:

```sh
LUA_PATH='./lua/?.lua;;' LUA_CPATH='./build/?.so;;' lua5.4 examples/quickstart.lua
```

[Build options and development setup](CONTRIBUTING.md) cover library overrides,
reference tests, and release verification. Source archives are available under
[GitHub Releases](https://github.com/48hoursnonstop/luaray/releases).

## Working with arrays

- Create and combine arrays with explicit dtypes, shapes, and broadcasting.
- Slice, reshape, transpose, and reinterpret shared storage with views.
- Compute with real and complex numbers, reductions, FFTs, and linear algebra.
- Generate random samples, coordinate grids, and batched vector products.

Positive indices and axes start at **1**. Negative indices count from the end.
The [reference guides](docs/README.md) explain Lua argument conventions, supported
options, copying, and memory ownership.

## Compatibility

**Current release: [0.126.0-dev](https://github.com/48hoursnonstop/luaray/releases/tag/v0.126.0-dev).**
LuaRay is under development. NumPy 2.5.3 is the primary behavioral reference;
compatibility varies by operation, dtype, and option.

The [API inventory](docs/api_inventory.md) records available names and known
gaps. Available APIs remain classified as partial. Object and structured arrays,
variable-width strings, and non-native numeric byte order are among the remaining
limitations. Read the relevant reference before adapting NumPy code.

## Validation

```sh
make -j4 full-test
```

The default suite runs the maintained native and Lua regressions. Run the examples
with `make examples`. Neither command requires Python or NumPy.

For the full frozen NumPy reference corpus, run `make reference-test`. It obtains
a checksum-verified release archive and checks the current engine against **161
differential fixture files** and additional random/formatting references. Generated
corpora and oracle generators are kept outside the main source tree.

[Validation details](docs/development/validation.md) document executed checks,
numerical tolerances, and sanitizer scope. [Upstream provenance](docs/development/upstream.md)
records source references and third-party notices.
