# LuaRay0.112.0-dev — reality and component precision

Five native root functions distinguish real/complex values and dtype, and
real_if_close preserves identity or returns a real component view. Tolerance
conversion, epsilon scaling and strict comparison preserve source precision.
Shared string parsing now matches two-double complex construction and valid
numeric range results; malformed text/NUL handling has regression coverage.

Executed: predicates2,652cases/158,028checks; closeness4,170/313,989;
complex text612/6,699. Combined7,434/478,716 exact checks. Native C and53Lua
checks passed. Full150/150 fixtures passed. Inventory343/675,331missing,1N/A,
allpartial. Exact x87 boundary data is constructed using actual native
ldexp/stack and component writes, avoiding lossy complex decimal initialization.

The directed29-unit ASan/UBSan audit passed16native/63Lua; other dependencies
uninstrumented and leaks off. Final source archive extraction/full suite and
fifteen public examples are recorded separately in TEST_RESULTS.md and
release JSON/log. Full Unicode grammar/locale parsing, array tolerances,
foreign/subclass/device protocols and every ABI remain incomplete. Existing
numerical fixtures were preserved apart from release version assertions.
Continue with clip/round, dtype views and the missing dependency inventory.
