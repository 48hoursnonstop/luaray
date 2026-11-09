# LuaRay0.116.0-dev — cross and meshgrid

Native np.cross and np.meshgrid implement source-ordered common-dtype vector
products and typed coordinate grids. The existing linalg cross shares the engine,
including source nonlast output-axis strides. Cross uses three components per
NumPy2.5.3. Meshgrid uses an explicit Lua input list, preserves each dtype,
xy/ij axes, sparse/dense shapes, copies and writable/readonly shared storage.
Inferred -1 reshape retains source empty/singleton strides.

Executed:6,239cross /408,057checks;1,902grid /379,208checks. Total8,141 /
787,265checks,27Lua/native C passed. Meshgrid/ordinary reference cases are
exact; general complex budgets are6e-7 complex64 /2e-15 wider, scaled by
max(1,abs(component)), selected before comparisons. Observed scaled errors
2.3841857910156e-7 C64 /3.806396165811e-16 C128 /0CLD.
Full161/161 fixtures passed. ASan39units(38C+1Cpp),20native78Lua passed;
other dependencies uninstrumented, leaks off. Exact two-fixture/inventory
regeneration and public example passed. Inventory352/675,322missing,1N/A,
allpartial. Final source clean-build/regression/19examples is independently gated.

English/Spanish documentation and eight source pins record public interfaces
and remaining dtype, scalar, warnings, dispatch, ABI and floating limits.
Historical numerical expected states are unchanged; runtime assertions advance.
This is the user's requested stopping version. Complete publication/CI gates,
report actual progress, and pause; do not start0.117 without a new user request.
