# Extracción y escritura a lo largo de un eje

LuaRay 0.101.0-dev implementa `np.take_along_axis` y `np.put_along_axis` con
su motor C de ndarray e indexación avanzada. No utiliza Python en ejecución.

```lua
local np = require('luaray')
local a = np.array({{10,30,20},{60,40,50}}, 'int32')
local orden = np.argsort(a, {axis=2})
local ordenado = np.take_along_axis(a, orden, 2)
-- {{10,20,30},{40,50,60}}
np.put_along_axis(a, {{2},{1}}, 99, 2)
-- a: {{10,99,20},{99,40,50}}
```

## Firmas

`np.take_along_axis(input, indices [, axis])` devuelve un ndarray independiente.
El eje predeterminado es el último, como en NumPy desde 2.3. Un nil o false
explícito selecciona el recorrido aplanado. `np.put_along_axis(input, indices,
values, axis)` exige el cuarto argumento, modifica la entrada y devuelve nil.
Son funciones del módulo, siguiendo la API pública de NumPy.

Ejes e índices positivos empiezan en **1**; los negativos cuentan desde el
final. Cero es inválido al recorrerlo. Se comprueban los límites; estas
funciones no tienen modos wrap/clip. [take](take.md) permite aplicar una lista
común de índices a todas las secciones de un eje.

Con eje explícito, entrada e índices deben tener el mismo rango. Las otras
dimensiones admiten broadcasting **en ambas direcciones**; el tamaño del eje
seleccionado sale de los índices. Una entrada `{3,4,1}` e índices `{1,2,5}`
producen `{3,2,5}` en el eje 2. Internamente se construyen índices enteros
ortogonales y se utiliza MapIter.

Los índices deben tener dtype entero. Se rechazan booleanos, flotantes,
complejos y cadenas aunque parezcan enteros. Las tablas Lua se infieren con
el constructor nativo. Para índices vacíos utiliza un ndarray de enteros
explícito: una tabla vacía conserva su dtype inferido habitual. Los enteros
sin signo del ancho de un puntero se convierten a intp antes de normalizar las
coordenadas. Para valores fuera del rango escalar Lua usa conversiones nativas.

## Valores, orden de memoria y solapamiento

Los valores de put se expanden por broadcasting a la forma indexada. Un ndarray
conserva su dtype y el iterador lo convierte; los valores Lua se empaquetan
antes en el dtype de destino. Un entero Lua fuera de rango falla; un ndarray
entero fuerte puede convertirse mediante las reglas unsafe. Las cadenas Lua
siguen los contratos S/U existentes; no se declara fidelidad total de los
tipos escalares ni las advertencias de Python.

El resultado conserva el orden elegido por el iterador. Índices Fortran pueden
producir una salida Fortran; el orden C resuelve conflictos entre operandos.
Se comparan valores, forma, dtype **y strides** con NumPy. La escritura respeta
ese orden, incluidos strides negativos y destinos repetidos.

Si los índices o valores comparten memoria con el destino, se protegen mediante
copias. Esto difiere del caso de take con out compatible y wrap/clip. Los índices
repetidos son válidos. Al convertir dtype, la ruta de indexación totalmente
avanzada utiliza buffers de hasta **8,192 elementos**: un fallo descarta el
buffer actual, pero mantiene los bloques ya escritos. Las pruebas cubren ambos
lados de ese límite.

## Aplanado y permisos de escritura

Un eje nil/false explícito sigue a `np.array(input.flat)` de NumPy 2.5.3. Una
entrada contigua C produce una vista plana compartida que conserva sus permisos.
Una entrada no contigua produce una **copia de solo lectura**. La extracción
funciona con ambas; put rechaza la segunda, incluidas vistas transpuestas o
invertidas no contiguas. También rechaza entradas contiguas de solo lectura.
Los índices del recorrido aplanado deben ser unidimensionales. Una entrada
escalar funciona con aplanado explícito; un eje ordinario no es válido.

## Verificación y límites

`make along101-test`: pruebas C, **85 comprobaciones Lua**, **2,061 casos de
extracción de NumPy 2.5.3 / 109,722 comprobaciones** y **3,599 casos de escritura /
430,929 comprobaciones**. Incluyen errores reales y estado posterior, broadcasting
multidimensional en ambas direcciones, memoria compartida, vacíos, escalares,
tablas y límites enteros. Se verifica el límite de 63/64 índices con NumPy.

`make full-test` incluye **119 archivos diferenciales** y las regresiones C/Lua.
`make sanitize-along101` instrumenta ocho módulos C y ejecuta cuatro pruebas
nativas y 19 suites Lua. Las otras dependencias no están instrumentadas y la
detección de fugas está desactivada. Las pruebas congeladas no requieren Python;
regenerarlas requiere NumPy 2.5.3 y `tools/generate_along101_differential.py`.

La combinación general de slices e índices avanzados sigue siendo un área de
compatibilidad separada; el buffering nuevo cubre la ruta completamente
avanzada. Endianness numérico no nativo, object/estructuras, StringDType variable,
subclases Python y compatibilidad completa de API/errores/advertencias siguen
incompletos. Los bloqueos anteriores y el rechazo deliberado del cuelgue de take
siguen separados. Estas cifras no representan un porcentaje de avance global.
