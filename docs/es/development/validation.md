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
`compatibility/api_inventory.json` registra disponibilidad: 373 de 675 nombres
incluidos son invocables y todos siguen clasificados como parciales. No mide
el porcentaje global de compatibilidad NumPy.

## Comprobaciones del árbol actual

LuaRay **0.126.0-dev** aprobó **55 suites nativas**, **96 suites Lua**, siete ejemplos
y 86 bloques ejecutables de documentación. Las referencias de diagonales
conservan **47,886 casos / 4,571,474 comprobaciones**. Las trazas aprobaron
**20,861 casos / 853,519 comprobaciones exactas** contra NumPy 2.5.3, incluidos
metadatos, dtype/destino, solapamiento, unidades temporales y estados del original.

Las matrices triangulares aprobaron **18,142 casos / 1,754,183 comprobaciones
exactas**, incluidos orden de memoria, dtypes, ejes vacíos e índices extremos.

Vandermonde aprobó **11,584 casos / 441,741 comprobaciones**. Los metadatos y casos
ordinarios se comparan exactamente; los aleatorios flotantes/complejos usan una
tolerancia relativa fija3e-15. Los errores absolutos y relativos observados fueron cero.

Identidad/eye aprobó **13,335 casos / 261,220 comprobaciones exactas**, incluidos
orden C/F, dtypes, offsets, ejes vacíos y requisitos de unidades temporales.

Los índices diagonales y las conversiones de escalares a strings aprobaron **1,766 casos / 81,899 comprobaciones exactas**, incluidas coordenadas en base uno, identidad de vectores repetidos, escrituras avanzadas reales y formato de asignaciones y constructores.

Los helpers de índices triangulares aprobaron **9,908 casos / 487,084 comprobaciones exactas**, incluidos vectores contiguos independientes, dimensiones rectangulares/vacías, offsets extremos y lecturas/escrituras sobre vistas.

El relleno diagonal aprobó **29,960 casos / 1,292,460 comprobaciones exactas**, incluidos recorrido plano lógico, repetición/wrap, conversiones de escalares y arrays tipados, destinos de solo lectura y valores compartidos durante la escritura.

Kronecker y duraciones enteras aprobaron **13,776 casos / 1,018,781 comprobaciones**. Los productos complejos64 aleatorios usan tolerancia relativa3e-7; los tipos más anchos,3e-15. El error observado fue cero. Las duraciones cubren NaT, coeficientes, máscaras, conversión de unidades, escrituras previas al error y límites de buffer. En **176 fallos de conversión con buffer**, NumPy produjo sufijos no inicializados variables: solo se comparan el prefijo definido y los metadatos completos. Las observaciones se publican como archivo separado.

Tensordot ejecutó **22,615 casos / 2,304,132 comprobaciones**: **22,461 casos aptos para comparación** y **154 resultados object bloqueados explícitamente**. Las contracciones aleatorias usan tolerancia absoluta+relativa3e-6 para float32/complex64 y2e-12 para tipos más anchos. Los máximos observados fueron absoluto1.9073486328125e-6 y relativo1.3520483676605e-5. Se aceptan ambos signos de cero en resultados BLAS, con44 diferencias observadas; los ceros de entradas y resultados no BLAS siguen siendo exactos. Se verificaron el límite de rango nativo y las unidades/wrapping de productos de duraciones.

La auditoría dirigida ASan/UBSan instrumentó `ln_dot`, `ln_matrix`, `ln_linalg`, `lua_matrix`
`lua_module`, `ln_time_scale`, `ln_ufunc`, `ln_nditer_multi` y `ln_datetime`, además de la prueba nativa de matrices y el runner Lua. Aprobaron
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
