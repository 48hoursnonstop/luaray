# LuaRay0.106.0-dev — sampling and native scalar formatting

Native linspace/logspace/geomspace compose typed arithmetic, array broadcasting
and owned results. Public Lua options provide sample count, endpoints, axis,
dtype, returned step and logarithmic base. English/Spanish API contracts describe
actual weak/strong precision, scalar/array steps, integer floor versus final
truncation, complex rotation, large half counts and explicit unsupported behavior.

## Executed evidence

- linspace2,478 cases /504,645 checks; exact numeric values, maximum error0.
- logspace1,542 /154,195; geomspace1,392 /150,473. Total5,412 /809,313.
- All132 frozen fixture files and existing C/Lua regression passed.
- Two native suites and154 direct Lua checks passed, including exact proof that
  float32 logspace cast to float64 retains the same float32 computed values.
- 70,828 raw-bit formatting states passed141,656 exact ASCII/Unicode comparisons:
  all65,536 half encodings,2,063 eachfloat32/64,576 eachcomplex64/128 and14x87.
  Eight formatter threads executed16,384 additional calls; input/output guards
  and unaligned buffers passed. This does not substitute for a thread sanitizer.
- Expanded cases cover zero-stride/3-D layouts, rank63/64, subnormal steps,
  n65504/65536 half overflow, non-scalar bases, mixed weak/strong endpoints,
  output casts and actual invalid calls. Inputs remain unchanged.
- Three fixtures, C header, licensed native import and runtime inventory
  regenerate exactly on the pinned NumPy2.5.3 x86 reference environment.
- Directed ASan/UBSan passed20 C units and changed C++ FFT integration,10 native
  and37 Lua suites. Additional final Lua precision checks passed separately with
  the same instrumented module. Dependencies uninstrumented, leaks disabled.
- Final source release JSON/log records the independent clean extraction,
  manifest check, actual rebuild/full regression and all nine public examples.
  Remote CI is a separate release check; prior-version CI is not substituted.

## Defects resolved from real references

Fixed printf precision produced wrong half/float shortest strings. The actual
NumPy Dragon4 numerical core now supplies native bounded strings; no Python ABI
or interpreter is embedded. Source attribution and MIT/NumPy licenses remain.
Complex casts no longer use an unnecessary longdouble intermediate that changed
complex64 real38935.516 to int8=0 instead of23. A geometric integer output exposed
nonfused multiply8 versus NumPy FMA7.9999995: source and traced intermediate sign/
division matched, and source-ordered runtime-host FMA multiplication restores
upstream output7. Reductions/extended precision keep the baseline path.

General iterator allocation differed from NewLikeArray for singleton and zero-
stride axes. The new creation allocator centralizes constructor K-order, roll
reuses it, and sampling casts allocate correctly. Ufuncs with one exact contiguous
input and a scalar partner now use canonical C/F output. Full old regressions
were retained and passed. Source-derived weak/typed behavior and no-input-sharing
contracts are exercised through the actual Lua API.

## Numerical scope and honest availability

Linspace values, integer/bool/string outputs and metadata are exact. Power/log
comparisons use compute dtype before final storage casts:2e-3 half,3e-6 float32/
complex64,2e-12 wider absolute+relative. Initial output-based tolerance was
corrected after proving retained float32 computation and source SVML versus
native powf rounding. No integer assertion was relaxed. Max normalized error
abs(error)/max(1,abs(ref)):1.1393306865162e-7 logspace,1.9546212523884e-7 geomspace.
Logspace max absolute9.2233720368548e18 is at large powers; geomspace9.536743164e-7.

Actual inventory306 available/675 scoped callable names,368 missing and one
justified Lua adaptation. Complete APIs declared:0. Other ABI branches, full SIMD,
all warning/subclass/error/device behavior, objects/structured/variable strings,
all casts/hardware/alias combinations and non-native numeric endian remain
uncertified. The40 earlier blocked states and take/choose differences remain
separate. Continue development beyond releases; luanimath remains unfinished.
