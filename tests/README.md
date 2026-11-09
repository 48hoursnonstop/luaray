# Tests

Run `make full-test` from the repository root. The suite includes native C/C++
tests, Lua regression tests, and every checked-in `*_differential_generated.lua`
fixture.

Generated fixtures contain frozen expected behavior from the NumPy version
recorded in their headers. They run through the native Lua public API without
NumPy installed. Versioned filenames identify the subsystem or development
milestone that introduced the regression; they are not duplicate releases.

Oracle scripts live in `tools/`. Regeneration requires the pinned NumPy version.
Keep expected values unchanged unless a verified upstream behavior or a
reproduced generator defect justifies the change.

See [validation](../docs/development/validation.md) for executed results,
numerical tolerances, and sanitizer scope.
