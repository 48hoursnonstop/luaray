# Current checkpoint — choose 0.102 release gate

Active /mnt/datos/luaray/.dev/choose102 branch choose102, VERSION0.102. Native
choose, shared date/delta casts and binary-safe output guard implemented.
Final original NumPy2.5.3 corpus3481cases/101519checks, C suite and69Lua checks
passed. Final full-test all120 frozen files passed. Nine-unit ASan/UBSan passed
five native/21Lua suites (dependencies uninstrumented, leaks off). Fixture
regenerated exactly, public choose example passed. English/Spanish docs and
compatibility record updated. Earlier checkpoint text below is historical.

Next: review, clean source extraction/rebuild/full tests/five examples, commit,
integrate, publish0.102, verify actual Ubuntu CI. Then continue compress/extract;
user requests sustained dependency completion. No overall percentage justified.
Two unsafe-span variants stay outside parity, unsafe source calls not executed;
three earlier take hang variants and40 blocked endian states remain separate.
Keep all verified old archives immutable. luanimath goal remains unfinished.

# Current checkpoint — choose 0.102 differential audit

Active worktree /mnt/datos/luaray/.dev/choose102, branch choose102. Runtime VERSION
still0.101 until the full feature gates finish. Native ln_choose.{c,h}, np.choose
and ndarray:choose compile; actual public example passed. First original NumPy
2.5.3 corpus:1530 cases passed; read artifacts/choose102-differential.log for
actual check count. Need expand dtype/broadcast/out/alias/readonly/empty/index
cases, native/Lua regression, ASan, full regression, bilingual docs and release.

Native output preserves upstream direct linear writes for safe in-owner spans,
but guards against owner overrun for reversed/zero-stride insufficient-tail out.
Unsafe upstream memory-corrupting spans have NOT been executed. Retain explicit
non-parity records/tests for the guard. Original in-bounds strided/transposed/
negative out states are frozen and passed. choose negative indices reject in
raise, wrap modulo and clip first; positive Lua positions are one-based.

Corpus caught shared datetime->Unicode too-short formatting: ln_dtype_transfer
now rejects instead of silently truncating. Direct S failed-prefix and Linux
fixed-year equal-capacity behavior follow inspected source/probes; need freeze
expanded width/unit/NaT cases and rerun all previous suites before completion.

0.101 is published at5dbdaa9 with source SHA
8e720711efd20963d485ab98f2ec3f6ee5044c1d95ca33871f27dd9213e815a4.
664files/663manifest, clean119 suites/four examples, eight-unit ASan4native19Lua
passed. Exact Ubuntu CI42531596071 SUCCESS. Downloads/source public hash verified.
Older checkpoint sections below are historical. User requests continuing past
release milestones until complete or usage exhausted; luanimath goal unfinished.

# Current checkpoint — 0.101 along-axis release gate

Active worktree /mnt/datos/luaray/.dev/along101, branch along101. VERSION0.101.
Native ln_along.{c,h}, np.take_along_axis / np.put_along_axis and shared ln_mapping
fixes are implemented. Actual original references: take2061/109722 checks,
put3599/430929 checks, 85 Lua checks and new C suite passed. All119 frozen fixture
files passed. Eight-unit ASan/UBSan: four native / nineteen Lua suites passed;
expanded final fixtures replayed successfully. Both fixture files reproduced.
Public module example passed. English/Spanish docs at docs/{en,es}/along_axis.md.

Next: review diff, clean source packaging/rebuild/full tests/four public examples,
commit/integrate, publish0.101 and verify actual Ubuntu CI. Then continue coherent
selection/advanced indexing work. Do not stop at this development release.
Numeric endian/object/structured/variable strings and general mixed-subspace
buffering remain incomplete. No overall completion percentage is justified.

0.100 is published at tag406aba8, source SHA
cc1497f316aea2cdfaa0d5ca787b00be352beb51910730ecad5e473c9e69cc80;
652 source files/651 manifest entries, clean117 suites/three examples, directed
six-unit ASan passed. Exact Ubuntu CI42530255799 on406aba8 passed. Downloads
source/checksum and public asset hash verified. Older checkpoints below are
historical and do not supersede this one. Keep release archives immutable.

# Current checkpoint — 0.100 native take release gate

0.99.1 is published (d6b7778); exact versioned Ubuntu CI 42527745200 passed.
Active worktree .dev/take100 branch take100 has VERSION 0.100.0-dev, native
np.take/ndarray:take, six-unit sanitizer audit and bilingual API reference.
All 117 frozen fixture files passed; new take 6,704 cases/324,615 checks,
63 Lua checks, C tests, reproducibility and public example passed. ASan/UBSan:
three native and fourteen Lua suites, linked dependencies uninstrumented,
leaks disabled. Older checkpoint sections below are historical.

Next gate: inspect diff, commit, clean source packaging/rebuild/full tests,
merge into main, public tag/release/Downloads artifact and actual Ubuntu CI.
Do not claim 0.100 published until those actions finish. Keep immutable older
archives. Then continue take_along_axis/put_along_axis and dependency parity;
user explicitly requested sustained work. luanimath remains unfinished at
/mnt/datos/luanimath. No overall completion percentage is justified.

# Active dependency work

## Current — 0.99.1 portability correction

Ubuntu native CI initially failed inverse-exponential float32 rounding; direct
loading of official Ubuntu libm 2.39 reproduced three one-ULP differences.
80-digit Decimal calculations confirm the frozen expected values. Corrected
ln_random's inverse float32 path to evaluate log1p in double then round to float.
No fixture or tolerance weakened; next-PCG64 word is preserved. Corrected-code
CI run 42526947924 on commit 965203b passed all 116 suites and both examples.

Current VERSION=0.99.1-dev. Local full-test passed after version metadata updates.
Directed ASan/UBSan passed four modified C units including ln_random, two native
tests and twelve Lua suites; dependencies uninstrumented, leaks off. Read
PROGRESS_0_99_1.md and docs/{en,es}/portability.md. Clean source packaging and
0.99.1 publication are the next gate; do not claim that release exists yet.

Next take work is ISOLATED in git worktree /mnt/datos/luaray/.dev/take100, branch
take100, based on 965203b. It has new ln_take.{c,h}, Makefile links, np.take and
ndarray:take (axis/options/out/modes/scalars). Native compilation and basic actual
Lua take/out examples passed; NO NumPy differential take corpus or sanitizer
has run yet. Do not mark take complete. Merge current main into that branch
after the patch release to inherit 0.99.1/version/docs/packaging changes before
advancing to 0.100. .dev symlinks its oracle venv/source to the parent repo.

Take implementation retains source-derived out preconversion, raise-mode temp,
C-order source normalization, live compatible out/indices and chunk-at-once
index loads. Next: build actual NumPy corpus; arrays of indices use SAME_KIND,
positive Lua coordinates shift by one and negative values are unchanged. For
live out/index alias tests use negative source values so dynamically overwritten
index encodings remain identical in both languages. Read prior source facts below.

No source empty-axis wrap hang has been executed/confirmed yet; use bounded
subprocess investigation before including that potentially hanging oracle case.

Docker command exists but access to daemon is denied. Do not change permissions
or system config; actual Ubuntu CI is available and passed the correction.
Old-libc extraction cannot run the full Arch binary due to ABI requirements;
only the direct log1pf diagnostic was executed locally with that older library.

## Latest checkpoint — 0.99 published

0.99 is published at https://github.com/48hoursnonstop/luaray/releases/tag/v0.99.0-dev
(commit 1953e26). SHA-256:
a556554d0fbdf9a231951bd9be409d6efbcce39baf2adff8bf1de5fdf396c6df.
635 source files/634 manifest entries. Clean extraction, rebuild, all 116 frozen
fixture files and both dynamic-module examples passed. Three changed C units
passed ASan/UBSan: two native and ten Lua suites; dependencies uninstrumented,
leaks off. Downloads copy plus checksum are present. Preserve immutable archives.

0.99 copyto: 4914 original cases/138217 checks; putmask: 1481/36893;
77 Lua regressions. Core now follows destination-stride raw iteration, mask-run
scanning/live aliasing, source overlap direction, weak scalars and alignment-
dependent 128-element text cast buffers. Fix memcpy overlap detected by ASan,
identity string self-copy and complex temporal conversion. Read PROGRESS_0_99.md,
docs/{en,es}/masked_writes.md, compatibility/current.json. Historical .98/.97
fixtures remain; the .98 generator was refactored under main() and reproduced
original fixtures byte-for-byte. No full NumPy parity is claimed.

GitHub native CI run 42526293798 was started on 1953e26; check its actual result
before claiming remote success. Workflow runs Ubuntu native/frozen tests, no
Python/NumPy runtime. 0.99 original source/test hashes have a dedicated manifest.

Continue 0.100 indexing: upstream take/take_along_axis/put_along_axis inspected,
but NO take code has been written yet. Start with genuine take (axis, shape,
raise/wrap/clip, dtype/strides, scalar results and real out aliases). Important
source facts: take casts indices using SAME_KIND (put uses SAFE); source is made
C-contiguous; raise-mode out always uses a temporary; wrap/clip out may read
aliased indices live. Different-dtype out is preconverted to source dtype before
taking and unsafe-cast back. Scalar output should use existing push_scalar_at.
Along-axis helpers require integer indices and matching rank with non-axis
broadcasting. Lua positive indices/axes are one-based, zero rejected; document
and translate the oracle consistently. Proposed Lua take interface:
np.take(a,indices,axis_or_options), options={axis=...,mode=...,out=...}, nil/false
axis flattens; ndarray:take shares it. Resolve ordinary API details autonomously.

Check the edge empty source axis plus zero trailing chunk before testing wrap:
upstream fasttake has while loops with max_item==0 that may hang (inference only,
NOT executed/confirmed). Use a subprocess timeout to investigate if needed;
never launch an unbounded reference call or claim this inference as proven.

User asked to continue dependency work rather than stop at a release; keep
working until actual completion or available usage exhaustion. Latest telemetry
49 percent weekly used/51 remaining (old 50-percent restriction revoked).

## Earlier checkpoint — 0.98

Workspace: /mnt/datos/luaray. Imported verified 0.97 source from Downloads;
the original tarball remains unchanged. Git baseline e6239fd preserves it.
User explicitly requested continuing LuaRay 0.98 put/place first, before more
luanimath features. Do not resume the animation port prematurely.

0.98 implementation is verified in the working tree. Read PROGRESS_0_98.md,
docs/en/writing.md and docs/es/writing.md. Full test: 114 fixture files, 1735 new
original cases/42754 checks, 94 new Lua checks, native C tests, public Lua example.
Directed ASan/UBSan instruments all three changed C units, dependencies excluded,
leaks disabled. Forty original numeric-endian states are explicitly blocked,
retained and diagnosed, never counted as parity.

0.98 is now clean-verified and publicly published at
https://github.com/48hoursnonstop/luaray/releases/tag/v0.98.0-dev (tag commit 3e9e2d9).
Archive SHA-256: add9ff27c360878b3a86d346bdcc1ccba58d88ff8ec85f130c9c50874be2c9c8.
GitHub asset digest matches, and the Downloads copy is
/home/yhwh/Downloads/LuaRay-0.98.0-dev-source-20261108.tar.gz with its checksum.
623 source files, 622 manifest entries, actual clean full-test and example passed.
Immutable archive/reports/logs are preserved under releases/.

Continue the next dependency subsystem; do not stop just at a release.
Current 0.99 technical audit: copyto/putmask conversion and empty values/masks, followed
by more indexing/assignment and numeric descriptor prerequisites.

Development oracle: .dev/venv has NumPy 2.5.3; pinned source .dev/numpy-2.5.3.
Reference source hashes are NUMPY_2_5_3_WRITE98_FILE_HASHES.sha256. Build C at -O2
and PocketFFT at -O0 using documented CXXFLAGS. CBLAS/libblas and LAPACK are
already installed; the updated Makefile discovers libcblas on Arch.

luanimath stays at /mnt/datos/luanimath, commit 91032c5, with tested but unreleased
0.15 arrow families. Its release packaging and final migration-link rebuild are
pending. Portable TeX Live scheme-basic finished in /mnt/datos/Tools/texlive-2026;
no Lua TeX adapter was added. Do not change global config.

The user's old 50-percent usage limit was revoked; continuous engineering until
actual completion or available usage exhaustion remains authorized. Latest
weekly telemetry: 46 percent used/54 remaining at 2026-11-08T21:08:46Z.
