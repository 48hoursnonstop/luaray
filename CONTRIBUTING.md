# Contributing to LuaRay

Keep the public API natural to Lua and verify numerical behavior against the
pinned NumPy implementation. Runtime code must remain independent of Python.

## Build

Dependencies are listed in the [README](README.md). The Makefile discovers an
existing Lua 5.4 shared library and CBLAS through `pkg-config` where available.
You can override `LUA_SO`, `BLAS_LIBS`, `LAPACK_LIBS`, `CC`, and `CXX`.

```sh
make -j4 build/luaray_core.so
```

For a faster development build of the PocketFFT translation unit:

```sh
make -j4 full-test CXXFLAGS='-O0 -g -std=c++11 -Wall -Wextra -Wpedantic'
```

Use `make clean` when changing compiler settings or native interfaces.

## Tests and references

`make full-test` executes the checked-in native and Lua regression suites.
The fixture launcher requires Python 3, but not NumPy. Oracle generators under
`tools/` require the version stated in each generator; most recent references
use NumPy 2.5.3, while older fixtures retain their recorded provenance.

Run affected feature tests while developing, then the full suite before merging.
For changes to native memory handling, use the appropriate directed sanitizer
target; the current target is `make sanitize-vector116`. Its scope and limitations
are documented in [validation](docs/development/validation.md).

Preserve existing numerical assertions. Record unsupported behavior and explicit
tolerances in the compatibility inventory and the corresponding reference page.
A matching function name is not evidence of full compatibility.

## Repository layout

| Directory | Contents |
| --- | --- |
| `lua/` | Public Lua entry points |
| `src/` | Native kernels and Lua bindings |
| `tests/` | Native tests, Lua regressions, and frozen differential fixtures |
| `examples/` | Executable examples |
| `docs/` | English/Spanish reference and development documentation |
| `compatibility/` | Machine-readable coverage and pinned upstream checksums |
| `tools/` | Reference generation, validation, and release tooling |

Local oracle environments, build products, release assets, and local development notes are
ignored by Git. Keep temporary work out of the published source tree.

## Releases

Keep `VERSION`, the native module version, exact runtime-version assertions, and
compatibility records consistent. Generate the availability inventory from the
compiled module before packaging.

```sh
python3 tools/release.py
```

The release tool writes source-only assets under `releases/`, embeds an integrity
manifest in the archive, extracts it into a clean directory, rebuilds, and runs
the full suite and public examples. A verified release is immutable: the tool
refuses to replace an existing verification report. Do not retag an old release
to publish documentation changes.
