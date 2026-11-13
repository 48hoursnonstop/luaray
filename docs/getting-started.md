---
docs_examples: true
---
# Getting started

Build LuaRay, load it from Lua, and calculate with your first array.
The commands below run from a source checkout on Linux.

## 1. Check the dependencies

You need Lua 5.4 with its shared library, a C11 compiler, a C++11 compiler,
Make, BLAS/CBLAS, and LAPACK. `pkg-config` helps the build find installed libraries.
Python, NumPy, and Node.js are not needed to build or run the library.

On Arch Linux, the package names are `lua`, `base-devel`, `cblas`, `blas`, and
`lapack`. On Debian/Ubuntu, use `lua5.4`, `liblua5.4-dev`, `build-essential`,
`libblas-dev`, `liblapack-dev`, and `pkg-config`. Install only missing dependencies.

## 2. Build the native module

```sh
git clone --depth 1 https://github.com/48hoursnonstop/luaray.git
cd luaray
make -j4
```

This creates `build/luaray_core.so`. The public entry point is `lua/luaray.lua`.
For custom library locations and compiler flags, see the
[build guide](development/contributing.md).

## 3. Write a program

Save this as `first.lua` in the checkout:

```lua
local lr = require("luaray")

local temperatures = lr.array({18, 21, 24}, "float64")
local fahrenheit = temperatures * 1.8 + 32

assert(math.abs(fahrenheit[1] - 64.4) < 1e-12)
assert(lr.mean(temperatures) == 21)
print(fahrenheit:tolist()[1]) -- 64.4
```

Arrays keep their shape and dtype through numerical operations according to the
operation's promotion rules. `tolist()` converts values back into ordinary Lua data.

## 4. Run it

```sh
LUA_PATH='./lua/?.lua;;' LUA_CPATH='./build/?.so;;' lua5.4 first.lua
```

`LUA_PATH` locates the public Lua module. `LUA_CPATH` locates the compiled shared
module. These settings apply to this command; no system configuration is required.
Keep the `;;` entries so Lua also searches its normal module paths.

## 5. Explore

```sh
make examples
make -j4 full-test
```

The examples cover mathematics, views, FFT, random sampling, geometry, and linear
algebra. The test target runs the maintained native and Lua regressions.
The optional `make reference-test` obtains and verifies a frozen NumPy reference
corpus; see [validation](development/validation.md).

Next, learn [array shapes, indexing, and broadcasting](arrays.md).

## Troubleshooting

| Symptom | What to check |
| --- | --- |
| `module 'luaray' not found` | Run from the checkout and set `LUA_PATH` as shown above. |
| `module 'luaray_core' not found` | Run `make` and set `LUA_CPATH` to the build directory. |
| Lua symbols cannot be linked | Use Lua 5.4 and override `LUA_SO` if its library is in a custom location. |
| BLAS/LAPACK symbols cannot be linked | Check the development libraries; set `BLAS_LIBS` or `LAPACK_LIBS` if necessary. |
| PocketFFT compilation uses too much memory | Clean the build, then use the development compiler settings in the [build guide](development/contributing.md). |
