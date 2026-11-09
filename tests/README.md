# Tests

Run from the repository root:

```sh
make -j4 full-test
make examples
make reference-test
```

- `native/`: maintained C tests of numerical kernels and memory behavior.
- `lua/`: public API regressions, boundary cases, invalid inputs, and small support data.
- `runner.c`: native Lua runner linked to the current engine.

`full-test` runs the native and Lua suites; `examples` exercises the shared module
through Lua 5.4. Python and NumPy are not required.

`reference-test` uses a SHA-256-pinned 0.116 release archive, downloaded on demand
or supplied with `LUARAY_REFERENCE_ARCHIVE`. It runs 161 frozen differential files,
extended random cases, and the large formatting table against the **current** build.
The cache and temporary extraction are ignored by Git. `curl`, `tar`, and
`sha256sum` are needed for this optional target.

The original generators and complete test corpus remain in the published source
package. Preserve assertions and explicit tolerances when changing behavior;
do not classify an API as compatible based on its name or one successful example.
See [validation](../docs/development/validation.md) for numerical and sanitizer scope.
