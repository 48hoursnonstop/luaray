# LuaRay0.108.0-dev — native unary mathematics

Ten numeric operations and three aliases now execute through an independent
native registry with the shared descriptor and iterator engine. The existing
unary Lua entry point also accepts ordinary scalars and rectangular tables;
returns remain typed ndarrays, including rank-zero scalars.

## Executed evidence

- Rounding2,135 cases /176,894 checks; algebra1,746 /186,658;
  angles1,708 /137,512. Total5,589 /501,064, observed error0.
- Native C tests and358 directed Lua checks passed.
- Full139/139 frozen fixture files passed after the shared iterator correction.
- ASan/UBSan24units(23C+1Cpp),12native/48Lua passed. Other dependencies
  uninstrumented; leaks disabled. Integer loops-fwrapv; new math contraction off
  with explicit complex FMA selection. No old numerical assertion was weakened.
- Exact source/inventory regeneration and clean packaging are independently
  gated. The versioned verification JSON/log records the definitive archive.
- Inventory331/675 callable names,343missing,1N/A; allpartial,0complete.

## Source-derived behavior

Floor/ceil/trunc retain integer/bool dtypes. Numeric loops use safe signature
resolution, modular integer square, precision-specific float/half calculations,
complex conjugation/reciprocal and typed angle constants. Zero integer reciprocal
matches audited x86 NumPy without undefined C casts. Errors, actual writes,
readonly/overlap/masks, memory order and extreme values have original references.

Complex square required FMA product ordering and correct physical iteration.
The shared iterator now traverses its KEEPORDER axis permutation; Fortran arrays
use their contiguous axis. Thirty-eight strict additional FMA cases check all
layouts, inplace/masked and reversed overlap states. Source exact equal ranges
are vector-eligible. General complex square/reciprocal retains documented
relative tolerances; all observed new errors were zero.

## Remaining work

No full NumPy compatibility claim. Complete ufunc objects/methods and all keyword,
warning, device, subclass, endian, ABI and rounding-mode variants remain pending.
Ordinary constructors retain documented input conversion limitations. Next useful
work: missing binary math (fmod/float_power), broader scalar binary calls, array
coercion/view operations, then continue the dependency inventory. English/Spanish
API references describe actual behavior and tests, not just available names.
