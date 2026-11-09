# Fuentes de referencia y licencias

NumPy 2.5.3 es la referencia de comportamiento principal. Los fixtures anteriores
generados con NumPy 2.3.5 conservan esa atribución en sus cabeceras. La
implementación importada originalmente registra el commit NumPy
`286e698f1dcf601648b165f48485ceaeec9c6231`.

Los [hashes de fuentes NumPy](https://github.com/48hoursnonstop/luaray/blob/main/compatibility/numpy-source.sha256)
identifican los archivos inspeccionados. Los generadores son herramientas de
desarrollo: el runtime Lua no ejecuta Python ni NumPy.

## Avisos de terceros

- Los componentes derivados de NumPy conservan su
  [aviso BSD](https://github.com/48hoursnonstop/luaray/blob/main/THIRD_PARTY_NUMPY_LICENSE.txt).
- PocketFFT conserva su
  [licencia](https://github.com/48hoursnonstop/luaray/blob/main/src/third_party/pocketfft/LICENSE.md).
- BLAS/CBLAS y LAPACK son dependencias nativas externas.

Conserva estos avisos al redistribuir código o binarios. Las notas originales y
los generadores completos están en el [paquete fuente 0.116](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev).
