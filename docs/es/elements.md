---
docs_examples: true
---
# Extraer un elemento y rellenar un array

`array:item()` extrae un elemento independiente. `array:fill(valor)` convierte un
escalar y lo escribe en todo el array existente. Ambos usan el almacenamiento
nativo del ndarray y admiten vistas con strides.

## Índices planos y coordenadas

```lua
local lr = require("luaray")
local matrix = lr.arange(6):reshape({2, 3})
assert(matrix:item(4) == 3)
assert(matrix:item({2, 3}) == 5)
assert(matrix:item(-1) == 5)
assert(lr.asfortranarray(matrix):item(4) == 3)
```

Los índices planos siguen el orden lógico C, independientemente de la disposición
física. Los índices Lua positivos empiezan en uno; los negativos cuentan desde el
final. Cero es inválido. Los índices requieren enteros Lua. Una tabla con un índice
también indica una posición plana; una tabla más larga da una coordenada por
dimensión. Sin índice, o con una tabla vacía, debe existir exactamente un elemento.
Los arrays vacíos y los índices fuera de rango fallan. Una tabla de coordenadas
sustituye los argumentos variádicos de Python.

## Conservar valores fuera del rango numérico Lua

```lua
local original = lr.astype(lr.array({"18446744073709551615"}), "uint64")
local scalar = original:item()
assert(scalar.ndim == 0 and scalar.dtype == "uint64")
assert(lr.astype(scalar, "U40"):tolist() == "18446744073709551615")
scalar:set(7)
assert(lr.astype(original, "U40")[1] == "18446744073709551615")
```

Los elementos booleanos, enteros, flotantes, complejos y de texto ordinarios usan
las representaciones escalares Lua de la biblioteca. Longdouble y complex256
/clongdouble devuelven un ndarray tipado de rango cero independiente. Uint64 por
encima del máximo entero Lua con signo usa la misma representación tipada.
Conserva estos valores en aritmética nativa para mantener precisión; las conversiones
a strings permiten mostrar los enteros exactamente. El resultado conserva su valor
cuando se recolecta la entrada.

Los elementos temporales devuelven userdata temporal de LuaRay y conservan ticks,
unidad y NaT. Esto sustituye las conversiones a datetime/timedelta/None de Python.
El valor nativo seleccionado permanece intacto. Se admiten vistas de solo lectura
y no alineadas; los escalares tipados extraídos no comparten el buffer original.

## Rellenar en el mismo almacenamiento

```lua
assert(matrix:fill(7) == nil)
assert(matrix:get(2, 3) == 7 and matrix.shape[1] == 2)
local narrow = lr.zeros({2}, "int8")
assert(not pcall(function() narrow:fill(256) end))
narrow:fill(lr.array(256, "int64"))
assert(narrow[1] == 0 and narrow[2] == 0)
```

`fill` devuelve nil y conserva forma, strides y asignación de memoria. Las vistas
escriben en su almacenamiento compartido. Los destinos de solo lectura fallan,
incluso vacíos. El escalar se convierte antes de escribir y también se valida
para arrays vacíos; los valores inválidos siguen produciendo errores. Los escalares
Lua ordinarios usan los límites de asignación; un valor tipado de rango cero usa
la ruta de conversión escalar de la referencia y puede estrecharse.

Para la mayoría de dtypes, las secuencias y los arrays de rango no nulo no son
valores escalares válidos. La conversión booleana usa la condición de verdad:
una secuencia ordinaria vacía es false, una no vacía es true y un array tipado
debe tener exactamente un elemento. Un escalar complejo Lua no puede rellenar un
array real; un ndarray complejo de rango cero puede usar la conversión de la
referencia que descarta la parte imaginaria.

## Alias escalares y unidades temporales

```lua
local storage = lr.array({1, 2, 3, 4}, "int64")
local alias = storage:get(lr.s(2, 3)):reshape({})
storage:fill(alias)
assert(storage[1] == 2 and storage[4] == 2)
local dates = lr.zeros({2}, "datetime64[D]")
dates:fill(lr.datetime64(-1, "Y"))
assert(lr.astype(dates, "int64")[1] == -365)
```

El valor escalar se captura antes de escribir un destino compartido. La conversión
de calendario datetime usa años y meses reales, incluidas fechas anteriores al
epoch; las duraciones conservan sus reglas de años/meses promedio. Convertir un
escalar temporal y un array de rango cero puede seguir rutas distintas, como en
NumPy. Asignar un escalar de duración entre calendario y unidades fijas requiere
compatibilidad `same_kind`.

## Compatibilidad

Disponible desde **0.135.0-dev**, basada en los métodos ndarray, conversión escalar
y fechas de NumPy 2.5.3. Los índices Lua y los resultados item tipados para conservar
precisión son adaptaciones explícitas. Las correcciones de calendario compartidas
incluyen el comportamiento de desbordamiento entero de la referencia sin usar
operaciones C de desbordamiento con comportamiento indefinido. Las conversiones
de timedelta a strings conservan el límite de21 caracteres de referencia.

Las referencias comprueban valores seleccionados, precisión nativa, formas, strides,
escritura en memoria compartida, alias, solo lectura, vacíos, NaT y errores de
conversión escalar. Las API son parciales: no se certifican object/estructuras,
todos los protocolos externos y escalares Python, objetos de avisos ni todas las ABI.
