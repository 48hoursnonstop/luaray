# Escritura por índices y selección

LuaRay 0.98 incorpora `put` y `place` en C nativo, tomando NumPy 2.5.3 como
referencia de código y ejecución. La aplicación usa Lua 5.4 y el módulo nativo;
Python y NumPy solo generan las referencias de desarrollo. Se conservan forma,
strides y dtype del destino.

```lua
local np = require('luaray')
local a = np.arange(6, 'int32')
np.put(a, {1, 3, -1}, {9, 8})
-- a = {9, 1, 8, 3, 4, 9}
np.place(a, {true, false, true, false, false, true}, {5, 6})
-- a = {5, 1, 6, 3, 4, 5}
```

## `np.put(a, indices, values, mode)` y `a:put(indices, values, mode)`

El destino debe ser un ndarray escribible. Los índices y valores admiten
ndarrays, tablas Lua rectangulares o escalares. Se aplanan en orden lógico C;
los índices seleccionan posiciones del destino aplanado en ese mismo orden.
Los valores se repiten cíclicamente; los índices repetidos se escriben según
el orden de entrada. Devuelve `nil`.

Los índices positivos empiezan en **1**, como en el resto de LuaRay. Los
negativos cuentan desde el final en el modo predeterminado `raise`. **Cero
es inválido en todos los modos**: es una adaptación explícita a Lua.

| Modo | Comportamiento |
| --- | --- |
| `raise` (predeterminado) | Rechaza índices fuera de límites; admite negativos desde el final. |
| `wrap` | Aplica módulo de la longitud tras convertir las coordenadas Lua positivas a base cero. |
| `clip` | Limita al primer/último elemento. Los negativos eligen el primero, como en NumPy. |

Un ndarray de índices debe convertirse de forma segura al entero con signo del
ancho de puntero nativo; se rechazan arrays flotantes y arrays `uint64` en un
sistema de 64 bits. Los índices flotantes en escalares/tablas Lua se truncan
hacia cero antes de aplicar la convención de índices; se analizan cadenas
numéricas. No se redondea.

Los valores ndarray usan conversión insegura: por ejemplo, un array `int64`
con 300 produce 44 en `uint8`. Los enteros y tablas Lua se construyen directamente
con el dtype destino y rechazan 300 para `uint8`, como los escalares/secuencias
Python. Los valores vacíos no escriben y omiten comprobar límites; se sigue
rechazando un índice no vacío sobre un destino vacío. Un destino de solo lectura
siempre falla.

### Memoria compartida y errores

Si el destino no es contiguo o se solapa con valores/índices preparados, `put`
escribe una copia en orden C y la devuelve al destino solo al terminar sin
errores. Un índice inválido descarta esa copia. En un destino contiguo sin
solapamiento, se conservan las escrituras anteriores al índice inválido. Es
el comportamiento real de upstream; la API no promete escrituras atómicas
en todos los casos.

## `np.place(a, mask, values)`

El destino debe ser un ndarray escribible. La máscara admite arrays, tablas
rectangulares o escalares y se convierte a booleano. Debe tener exactamente
tantos elementos como el destino; no exige la misma forma. Son verdaderos los
números distintos de cero (incluido NaN), complejos no nulos y cadenas no vacías.
Se recorre en orden lógico C.

Los valores se repiten cíclicamente y avanzan **solo en las posiciones elegidas**.
En `putmask` avanzan en cada posición del destino. Los valores ndarray requieren
conversión segura incluso cuando toda la máscara es falsa. Los valores
escalares/tablas Lua se construyen directamente con el dtype destino. Solo se
admiten valores vacíos si la máscara no selecciona posiciones. Devuelve `nil`.

Los destinos no contiguos usan una copia en orden C y escritura de retorno.
Con un destino contiguo, los valores contiguos del mismo dtype pueden compartir
memoria y se leen mientras se escribe, como upstream: pueden repetirse valores
recién escritos. `place` no siempre toma una instantánea del origen. Hay casos
de referencia para vistas negativas, transpuestas y compartidas con stride cero.

## Conversiones corregidas y límites

Las cadenas vacías o formadas solo por espacios ahora fallan al convertirse
a números; en booleanos solo la cadena vacía es falsa. Una cadena vacía se
convierte a `NaT` en `timedelta64`, como en NumPy.

El núcleo de dtype todavía no admite descriptores numéricos con otro orden de
bytes. Se conservan por separado **40 estados originales bloqueados**, junto con
sus resultados NumPy y una comprobación ejecutada del rechazo del constructor;
no cuentan como compatibilidad aprobada. No están implementados los dtypes
de objetos/estructuras, despacho de subclases Python, identidad de clases de
excepción ni todas las advertencias. No se declara compatibilidad NumPy completa.

## Reproducir las comprobaciones

Ejecuta las regresiones mantenidas y las referencias NumPy congeladas externas:

```sh
make -j4 full-test
make reference-test
```

Ningún comando requiere Python ni NumPy. Los generadores originales y las
herramientas de sanitización se conservan en el [paquete publicado](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev).
La auditoría original instrumentó tres unidades C modificadas; las demás
dependencias no se instrumentaron por completo y la detección de fugas estaba desactivada.
