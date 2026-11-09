# LuaRay 0.110.0-dev — layout and shape operations

Independent native layout and Lua binding modules implement C/F/A reshape with
copy modes, C/F/A/K ravel and flatten. Existing core C reshape delegates to the
same implementation. Views retain owner lifetime and read-only flags; copies
are independent and writable. Negative strides, KEEPORDER zero-stride ambiguity,
Fortran no-copy grouping, empty strides and size overflow are source-derived.

Executed: ravel2,664 /185,920 checks; flatten2,640 /185,128; reshape19,830 /
1,387,960. Total25,134 /1,759,008 exact checks,61 Lua checks and native C tests.
Full146/146 fixture files passed. Runtime inventory336/675,338missing,1N/A;
all partial and zero complete APIs declared. ASan/UBSan27units(26C+1Cpp),14native/57Lua passed; other dependencies
uninstrumented and leaks off. Final clean archive results are recorded separately in TEST_RESULTS.md and release JSON/log.

No old numerical assertion was weakened. Fixture construction uses explicit
ndarrays for zero rank and the actual expand_dims singleton stride, preserving
correct comparisons of sharing and metadata. Source pins and EN/ES references
are included. Full Python signatures, devices/subclasses/foreign array protocols,
object/structured types and all ABI/rounding modes remain uncertified.

After release: continue the dependency inventory, including real/imag component
views, clip/round, dtype views and multidimensional index conversion. User asks
continued work until completion or actual usage exhaustion. No subagents.
