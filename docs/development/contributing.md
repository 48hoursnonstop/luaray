# Contributing

LuaRay targets Lua 5.4 on Linux. Keep the public API natural to Lua and preserve
numerical assertions, dtype rules, aliasing behavior, and documented tolerances.
Record unsupported behavior explicitly; API availability is not full compatibility.

## Build and test

Install the dependencies listed in the [getting started guide](../getting-started.md), then run:

```sh
make -j4 full-test
make examples
make reference-test
```

The first two commands use the maintained C/Lua tests and examples in this checkout.
The last command obtains a checksum-verified reference corpus from the immutable
0.116 release and tests the current engine against it. It needs `curl`, `tar`, and
`sha256sum`. None of these commands requires Python or NumPy.

Override `CC`, `CXX`, `LUA_SO`, `BLAS_LIBS`, and `LAPACK_LIBS` as needed. For faster
development compilation of PocketFFT, use
`CXXFLAGS='-O0 -g -std=c++11 -Wall -Wextra -Wpedantic'`.
Run `make clean` when changing compiler flags or native interfaces.

## Layout

- `lua/`: public Lua modules.
- `src/`: native kernels, Lua bindings, and licensed third-party code.
- `tests/`: maintained native and Lua regressions.
- `examples/`: runnable examples grouped by subject.
- `docs/`: English and Spanish reference guides.
- `compatibility/`: API inventory, behavioral limits, and upstream source hashes.
- `tools/`: opt-in external reference test runner.

## Reference development and releases

Large generated fixtures, Python oracle generators, historical reports, and release
automation are preserved in the [0.116 source package](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev).
Use a separate development workspace when regenerating references with pinned NumPy.
They are not required to build or use this checkout.

Keep `VERSION`, the runtime version, assertions, and compatibility records consistent.
Before publishing a new release, rebuild and test a clean source extraction, verify
real examples and the external references, and record the archive SHA-256. Run
sanitizers for changes to native memory handling and document their actual scope.
Existing release tags and assets are immutable. See [validation](validation.md).

## Documentation website

The documentation uses VitePress. Its Node.js dependencies are separate from the
native library and are needed only to develop or build the site.

```sh
cd docs
npm ci
npm run dev
npm run build
```

Keep English pages in `docs/` and their translations in `docs/es/` with matching
filenames. Update the topic navigation in `.vitepress/config.mts` when adding a
page. Use relative Markdown links between source pages. GitHub Actions builds
the site and publishes the generated artifact to GitHub Pages; output and
`node_modules` are never tracked.

## Implementation order

Work follows NumPy's dependencies from the core outward. First complete the
ndarray/DType model, scalar precision, memory ownership, views and writes,
creation, indexing and casting rules. Then expand axis iteration, reductions and
ufunc methods, numerical operations and statistics. Specialized linear algebra,
FFT, random functionality and file formats build on those verified foundations.

API presence does not establish complete compatibility. Each block must preserve
its observable states and pass execution checks before broadening the surface.
The needs of an external application do not replace this core dependency order.
