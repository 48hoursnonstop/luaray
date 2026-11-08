# LuaRay 0.61.0-dev — progress checkpoint

LuaRay continues as a Lua-native port of NumPy. `random.Generator.poisson`
was added in 0.61; the previous underlying Poisson samplers already existed
in 0.60. The main numerical core, linalg, FFT, reductions, and random remain
partially covered rather than equivalent to the whole NumPy API.

Validation: 74/74 checked-in differential fixtures, 8,492 exact new
comparisons, native test and directed memory sanitizers. The new public
method makes 28 registered Generator method names (some are controls/aliases).
No numerical percentage is inferred from the version or number of tests.

Next priorities: other discrete distributions, vectorized/broadcasted
parameters for `Generator`, comprehensive `SeedSequence`, ndarray I/O and
broader dtype compatibility. Full-coverage parity and stress fuzzing remain
pending.
