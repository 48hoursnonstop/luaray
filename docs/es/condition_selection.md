# Coordenadas no nulas y extracción por condición

LuaRay 0.103.0-dev añade `nonzero`, `flatnonzero`, `compress` y `extract` nativos.
Un módulo C administra las coordenadas y reutiliza el motor take verificado.
La ejecución utiliza Lua/C/C++, sin Python.

```lua
local np = require('luaray')
local a = np.array({{0,2,0},{3,0,4}}, 'int32')
local coordenadas = a:nonzero()
-- coordenadas[1]: {1,2,2}; coordenadas[2]: {2,1,3}
local seleccion = a:get(table.unpack(coordenadas)) -- {2,3,4}
local posiciones = np.flatnonzero(a)             -- {2,4,6}
local columnas = a:compress({true,false,true}, {axis=2})
-- {{0,0},{3,4}}
```

## nonzero y flatnonzero

`np.nonzero(input)` e `input:nonzero()` devuelven una **tabla Lua de ndarrays**,
uno por eje. Utiliza `table.unpack` para pasarlos como índices avanzados separados.
Las posiciones empiezan en **1** y se enumeran en orden C, incluso para entradas
transpuestas o invertidas. La tupla de NumPy se adapta a una tabla Lua y sus
coordenadas al modelo de índices Lua.

Nonzero rechaza entradas de cero dimensiones. `np.flatnonzero(input)` utiliza
posiciones aplanadas C y devuelve un ndarray entero, incluso para escalares.
Un escalar no nulo produce `{1}`; cero produce un array vacío.

Las coordenadas son vistas de un nuevo buffer nativo intercalado. En 64 bits,
una entrada de dos ejes produce strides de **16 bytes**, incluso si no selecciona
ninguna posición. No comparten bytes de elementos, aunque sus intervalos de
memoria pueden solaparse: shares_memory puede devolver false y may_share_memory
true. No comparten memoria con la fuente. Se verifican valores, dtype, forma y
strides observables hasta rango 64.

## compress

`np.compress(condition, input [, axis_or_options])` e
`input:compress(condition [, axis_or_options])` seleccionan secciones de un eje.
El tercer argumento admite un eje o `{axis=...,out=...}`. Sin eje, o con
nil/false, se aplana la fuente en orden C. Los ejes positivos empiezan en 1;
los negativos cuentan desde el final y cero es inválido.

La condición debe ser unidimensional. Se admiten valores no nulos de tipos
numéricos, complejos, cadenas fijas y temporales compatibles. Las condiciones
Lua escalares/tablas se empaquetan como bool, siguiendo compress. Una condición
corta selecciona solo sus posiciones disponibles. Se permiten posiciones falsas
extra; una posición verdadera fuera de la fuente produce un error de índice.
No se impone artificialmente una longitud idéntica.

Out debe ser escribible y tener la forma seleccionada exacta. Conserva identidad
y utiliza la salida temporal de raise de [take](take.md), incluida la conversión
previa de sus valores antiguos y los errores al convertir de regreso. La
condición se convierte en índices independientes antes de escribir out, por lo
que las vistas compartidas utilizan las posiciones de selección originales.

## extract

`np.extract(condition, input)` aplana ambos operandos en orden C y devuelve una
copia unidimensional de los valores seleccionados. La condición admite cualquier
rango compatible, incluido cero. No acepta eje ni out. Se permite una cola falsa
extra; una posición seleccionada fuera de la fuente produce un error. Una
condición escalar funciona con fuente escalar; false produce un ndarray vacío.

## Valores de verdad, evidencia y límites

NaN cuenta como no nulo. Un complejo es verdadero si cualquiera de sus componentes
es no nulo. Una cadena fija no vacía, incluido el texto `"0"`, es verdadera; una
cadena vacía es falsa. El cero temporal es falso y NaT es verdadero. Se prueban
entradas de solo lectura, invertidas, transpuestas, dispersas y con stride cero.

La auditoría original cubrió pruebas C, **95 comprobaciones Lua** y cuatro
baterías originales de NumPy 2.5.3:

| API | Casos | Comprobaciones de valores y metadatos |
| --- | ---: | ---: |
| nonzero | 168 | 10,188 |
| flatnonzero | 168 | 7,126 |
| compress | 2,061 | 83,059 |
| extract | 692 | 21,331 |
| Total | 3,089 | 121,704 |

Ejecuta `make full-test` para las regresiones C/Lua y `make reference-test` para
el corpus congelado externo. Ninguno requiere Python. Los generadores originales
y el alcance de las auditorías se describen en [verificación](../development/validation.md).

Object, estructuras, StringDType variable, endianness numérico no nativo,
subclases y fidelidad completa de errores/advertencias siguen incompletos. Las
pruebas verifican el comportamiento cubierto y no significan compatibilidad
total con NumPy. Los bloqueos y diferencias deliberadas anteriores permanecen
separados.
