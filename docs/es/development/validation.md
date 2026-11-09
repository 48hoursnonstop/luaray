# Verificación y tolerancias

## Versión publicada

[LuaRay 0.116.0-dev](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev)
aprobó la extracción y compilación limpias, **161 archivos diferenciales** y
**19 ejemplos públicos**. Su commit exacto aprobó [CI](https://github.com/48hoursnonstop/luaray/actions/runs/42567717315).

La versión añadió 8,141 casos cross/meshgrid y 787,265 comprobaciones. Las
comparaciones complejas generales usan tolerancias 6e-7 para complex64 y 2e-15
para tipos complejos más anchos, escaladas por `max(1, abs(component))`.
Metadatos, referencias exactas ordinarias y estados de mallas conservan aserciones
exactas. Consulta [vectores y mallas](../vectors_and_grids.md).

La auditoría dirigida ASan/UBSan aprobó con **38 unidades C y una C++**, 20 suites
nativas y 78 suites Lua. Las otras dependencias no estaban completamente
instrumentadas y la detección de fugas estaba desactivada. No certifica todos
los algoritmos, rutinas externas BLAS/LAPACK, ABI ni entornos de punto flotante.

## Repetir las comprobaciones

```sh
make -j4 full-test CXXFLAGS='-O0 -g -std=c++11 -Wall -Wextra -Wpedantic'
make examples
make reference-test
```

`full-test` ejecuta las regresiones mantenidas C/Lua. `reference-test` obtiene el
paquete inmutable 0.116, comprueba su SHA-256 y ejecuta 161 archivos diferenciales
y referencias adicionales de aleatoriedad y formato contra el motor actual.
Los datos se guardan fuera del árbol versionado. Ningún comando requiere Python.

Los generadores originales y herramientas de sanitización siguen en el
[paquete publicado](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev).
Usa ese entorno separado para regenerar fixtures o repetir `sanitize-vector116`.
Los generadores recientes usan NumPy 2.5.3; los anteriores conservan su atribución
NumPy 2.3.5.

El registro `compatibility/current.json` contiene evidencia de comportamiento.
`compatibility/api_inventory.json` registra disponibilidad: 352 de 675 nombres
incluidos son invocables y todos siguen clasificados como parciales. No mide
el porcentaje global de compatibilidad NumPy.

## Comprobaciones del árbol actual

LuaRay **0.118.0-dev** aprobó **55 suites nativas**, **88 suites Lua**, siete ejemplos
y 32 bloques ejecutables de documentación. Las referencias de diagonales
conservan **47,886 casos / 4,571,474 comprobaciones**. Las trazas nuevas aprobaron
**20,861 casos / 853,519 comprobaciones exactas** contra NumPy 2.5.3, incluidos
metadatos, dtype/destino, solapamiento, unidades temporales y estados del original.

La auditoría dirigida ASan/UBSan instrumentó `ln_matrix`, `ln_linalg`, `lua_matrix`
y `lua_module`, además de la prueba nativa de matrices y el runner Lua. Aprobaron
las regresiones y el corpus nuevo. Las demás dependencias no estaban completamente
instrumentadas y la detección de fugas estaba desactivada. El alcance es dirigido;
no certifica la memoria de todas las dependencias.

## Integridad de las entregas

Las entregas incluyen archivo fuente, SHA-256 y un JSON de verificación separado.
El archivo contiene `PROJECT_SHA256SUMS`, generado al empaquetar. El manifiesto
no se conserva en el árbol de trabajo porque cada edición lo volvería obsoleto.

Las herramientas originales verifican el manifiesto tras extraer el paquete,
compilan y ejecutan las pruebas desde esa fuente limpia. Los archivos y tags
publicados son inmutables.
