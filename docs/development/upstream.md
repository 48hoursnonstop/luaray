# Upstream provenance and third-party code

NumPy 2.5.4 is LuaRay's primary behavioral reference. The earlier 2.5.3 source
pins are retained in `compatibility/numpy-2.5.3-source.sha256`; historical
fixtures keep their original interpreter attribution. Earlier differential
fixtures generated with NumPy 2.3.5 retain that version in their headers.
The original imported implementation also records NumPy source commit
`286e698f1dcf601648b165f48485ceaeec9c6231`.

Pinned source-file checksums live in
[`compatibility/numpy-source.sha256`](https://github.com/48hoursnonstop/luaray/blob/main/compatibility/numpy-source.sha256).
They identify the source files inspected for individual subsystems and releases.
Reference generators are development tools; the running Lua library does not
execute Python or upstream NumPy.

## Notices

- NumPy-derived components retain the
  [NumPy BSD notice](https://github.com/48hoursnonstop/luaray/blob/main/THIRD_PARTY_NUMPY_LICENSE.txt).
- Vendored PocketFFT retains its
  [license](https://github.com/48hoursnonstop/luaray/blob/main/src/third_party/pocketfft/LICENSE.md).
- BLAS/CBLAS and LAPACK are external native dependencies.

Preserve these notices when redistributing source or binaries. Detailed original
source notes and oracle generators remain in the
[0.116 source package](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev).
