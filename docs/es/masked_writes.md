# Copias y escritura por máscara posicional

LuaRay 0.99 corrige `copyto` y `putmask`, incorporados en 0.97. Consulta también
la [guía de índices y selección](writing.md). La ejecución sigue usando Lua y
bibliotecas nativas; Python/NumPy solo son referencias de desarrollo.

## `np.copyto(destination, source, casting, where)`

El origen admite ndarray, tabla rectangular o escalar y se expande al destino.
Se retiran dimensiones unitarias iniciales sobrantes. `casting` usa `same_kind`
por defecto y admite `no`, `equiv`, `safe`, `same_kind` y `unsafe`. Pasa `nil`
para conservar el valor predeterminado al indicar `where`. `same_value` no es
un modo copyto admitido por la versión NumPy fijada. Devuelve `nil`.

```lua
local np = require('luaray')
local matrix = np.zeros({3,4}, 'float32')
np.copyto(matrix, 1.5, 'no', {1,0,1,0})
assert(matrix:get(1,1) == 1.5 and matrix:get(1,2) == 0)
```

Los literales numéricos conservan promoción de escalar débil: enteros pueden
construirse en el dtype numérico existente; flotantes siguen dtypes flotantes o
complejos existentes. Copiar 1.5 a float32 con `no` funciona; `equiv` rechaza cambiar
el descriptor predeterminado del escalar a float32. Los ndarrays explícitos usan
su propio dtype. Se comprueban límites de enteros pequeños incluso con máscara
falsa. Los escalares débiles destinados a timedelta siguen su construcción directa
y rechazan flotantes/complejos aunque una conversión insegura de arrays funcionase.

La máscara se expande por separado. Las entradas Lua se construyen como booleanas
y admiten números, cadenas y complejos. Los ndarrays explícitos requieren conversión
segura a bool: se rechazan arrays enteros/flotantes. Las vistas booleanas conservan
memoria y strides. Omitir la máscara selecciona todas las posiciones.

### Recorrido y errores

El bucle C sigue strides del destino, ordena ejes, normaliza negativos, agrupa
dimensiones, protege orígenes solapados e invierte copias 1D cuando corresponde.
Lee tramos de máscara durante la ejecución: una máscara compartida puede observar
escrituras anteriores. Hay referencias originales de vistas con stride cero.

Un error puede conservar escrituras anteriores. Las conversiones de texto que
necesitan almacenamiento temporal alineado reproducen bloques de 128 elementos:
conservan los terminados y descartan el bloque que falla. Depende del ancho,
alineación y recorrido. Se comparan estados posteriores al error para
U1/U3/U4/U8/S3 alrededor de 127, 128 y 129.

La conversión escalar puede preceder a la máscara: copiar una cadena inválida a
varios enteros falla incluso con `where=false`; con un solo elemento se omite
esa conversión no seleccionada. No se promete atomicidad universal.

Una copia no escalar con exactamente la misma memoria y distribución termina
sin escribir incluso en arrays de solo lectura, como upstream. Otras escrituras
de solo lectura fallan; dimensión cero sigue la asignación escalar. Convertir
arrays complejos a datetime/timedelta con `unsafe` usa la parte real y produce
NaT si no es finita o queda fuera de rango.

## `np.putmask(destination, mask, values)`

Todo se aplana en orden lógico C. El destino debe ser escribible y la máscara
debe tener igual número de elementos, sin exigir la misma forma. Las máscaras
arrays/Lua se fuerzan a bool. Son verdaderos números no nulos, complejos no nulos
y cadenas no vacías.

Los valores avanzan según **la posición del destino**, incluso cuando la máscara
es falsa. En `place` solo avanzan en posiciones elegidas:

```lua
local a = np.arange(4, 'int32')
np.putmask(a, {1,0,1,0}, {9,8}) -- {9,1,9,3}
```

Los valores ndarray requieren conversión segura. Las tablas/escalares Lua se
construyen directamente con comprobación de límites. Una tabla vacía no escribe
aunque haya posiciones verdaderas; un ndarray float64 vacío sigue fallando en
su conversión segura a enteros. Solapar valores/máscara o usar destinos no
contiguos activa copia protegida en orden C y retorno al destino, a diferencia
de los valores compatibles compartidos de place. Devuelve `nil`.

## Evidencia y alcance

Ejecuta `make full-test` para las regresiones C/Lua y `make reference-test` para
el corpus congelado externo. NumPy 2.5.3 generó 4,914 casos copyto y 1,481 putmask:
175,110 comparaciones, además de 77 comprobaciones Lua y pruebas C. La auditoría
original instrumentó tres unidades C modificadas; las dependencias no se
instrumentaron por completo y la detección de fugas estaba desactivada.

No se declara compatibilidad NumPy completa. Siguen pendientes descriptores
numéricos con otro orden de bytes, objetos/estructuras y todas las advertencias/
clases de excepción. Los 40 estados de orden de bytes siguen bloqueados
explícitamente y no cuentan como compatibilidad aprobada.
