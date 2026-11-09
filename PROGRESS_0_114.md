# LuaRay0.114.0-dev — fused clipping

Native np.clip and ndarray:clip implement numeric/time uniform loops, integer
bound elision, strong/weak promotion, open bounds, output/masks and shared-memory
writes. The source-derived non-reduction buffer cost plan preserves signed-zero
semantics when bounds are converted or expanded. Existing minmax temporal
resolution now admits compatible strong integer/timedelta operands.

Executed:4,415/298,784 clipping,2,112/165,170 outputs,80/3,973,384 buffering.
Total6,607/4,437,338 exact checks,26Lua/native C passed. Full156/156 fixtures
passed. ASan33units(32C+1Cpp),18native71Lua passed; other dependencies outside
instrumentation, leaks disabled. Exact three-fixture/inventory regeneration and
public module example passed. Inventory348/675,326missing,1N/A,allpartial.
Final archive clean-build/regression/17examples is independently gated.

Eleven source pins and English/Spanish references state the remaining API,
iterator, floating environment, memory-layout and platform limits. Object,
structured/variableStringDType, non-native numeric endian, full dtype/casting/
order/signature options and foreign protocols remain pending. Historical
numerical expected states are retained; version assertions and registry count
are advanced explicitly. Continue fundamental array views/temporal math and
missing scientific operations after publishing this coherent milestone.
