# Active dependency work

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

Next steps: finalize source release with make release, verify/extract/rebuild,
SHA-256, publish the authorized public GitHub milestone and provide a Downloads
copy. Then continue the next dependency subsystem; do not stop just at a release.
Next technical audit: copyto/putmask conversion and empty values/masks, followed
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
