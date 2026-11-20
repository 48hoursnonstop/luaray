# Validation

## LuaRay 0.192.0-dev

| Check | Scope |
| --- | --- |
| Maintained regressions | 82 native suites and 164 Lua suites |
| Public examples | 7 Lua programs |
| Documentation | 635 Lua blocks across 196 English and Spanish pages |
| Frozen differential corpus | 161 fixture files, plus random and formatting references |
| Cumulative differential corpus | 102 fixture files, including 19 added since 0.173 |
| ASan and UBSan | 105 instrumented objects, maintained suites and the 102 cumulative fixtures |

The 19 new NumPy 2.5.5 fixtures compare **35,427 cases** and **2,442,877
checks**. The [release overview](../release_192.md) links each feature to
its tested contract. See the [API inventory](../api_inventory.md) for lookup
availability across 675 scoped names.

The sanitizer run instrumented 73 library units, 31 native harnesses and
the Lua runner. Linked dependencies received partial instrumentation.
Leak detection was disabled. The verification JSON records the exact scope
and a fingerprint of the executable source.

## Repeat the checks

From the source checkout, run:

```sh
make -j4 full-test
make examples
node docs/scripts/check-examples.mjs
make reference-test
```

The documentation example checker uses Node.js to extract Lua code and run it
with the compiled module. `reference-test` fetches the 0.116 archive, verifies
its SHA-256 and caches the fixtures. The checked-in
`compatibility/numpy254-reference.patch` updates 40 historical quantile
rejections to NumPy 2.5.4 success assertions and preserves the original
numeric assertions.

The release's optional reference archive contains the 102 cumulative Lua
fixtures and their generators. To run a fixture from an extracted reference
archive against your build, substitute its path below:

```sh
LUA_PATH='./lua/?.lua;;' LUA_CPATH='./build/?.so;;' \
  lua5.4 /path/to/references/matrix192-business-day-count.lua
```

Regenerating fixtures requires each generator's pinned NumPy version.
Historical fixtures retain their original version attribution. Their
operation-specific tolerances are documented in the corresponding guides.

## Release integrity

The release gate checks all files in a clean source extraction against
`PROJECT_SHA256SUMS`, rebuilds, and repeats the regressions, examples and
differential checks. The release assets include the archive checksums and the
verification report. Historical reports remain in their versioned releases.
[0.192 release](https://github.com/48hoursnonstop/luaray/releases/tag/v0.192.0-dev)
· [0.173 verification history](https://github.com/48hoursnonstop/luaray/blob/v0.173.0-dev/docs/development/validation.md)
· [0.116 baseline](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev)
