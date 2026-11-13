---
docs_examples: true
---
# Arrays sobre buffers existentes

`lr.frombuffer(storage, dtype, count, offset)` crea una vista unidimensional de
bytes existentes. No interpreta texto ni copia el contenido. El almacenamiento
puede ser una cadena binaria Lua o un ndarray LuaRay contiguo en C. Por defecto,
el dtype es float64, count incluye todos los elementos restantes y el offset es
cero bytes.

## Leer datos binarios

```lua
local lr = require("luaray")
local bytes = string.pack("i4i4", 123, -456)
local values = lr.frombuffer(bytes, "int32")
assert(values.shape[1] == 2 and values.strides[1] == 4)
assert(values[1] == 123 and values[2] == -456)
assert(lr.frombuffer(bytes, "int32", 1, 4)[1] == -456)
```

Los offsets cuentan bytes desde cero, según la convención de buffers binarios.
Los índices del array siguen empezando en uno. Cualquier count negativo incluye
todos los elementos completos restantes. Al inferir count, la longitud restante
debe ser múltiplo del tamaño de elemento. Un count explícito no negativo permite
bytes sobrantes. El offset al final admite un resultado vacío. Los offsets
negativos o excesivos, la memoria insuficiente y los dtypes de ancho cero fallan.

## Compartir memoria mutable

```lua
local source = lr.array({1, 2, 3}, "int32")
local tail = lr.frombuffer(source, "int32", 2, 4)
tail[1] = 77
assert(source[2] == 77 and lr.shares_memory(source, tail))
source = nil
collectgarbage("collect")
assert(tail[2] == 3)
```

Un buffer de array conserva el propietario del almacenamiento. El dtype del
resultado reinterpreta bytes; no convierte los valores originales. La escritura
sigue los permisos de la fuente. Se rechazan arrays no contiguos y aquellos
contiguos únicamente en Fortran. Se admiten offsets no alineados; el array nativo
registra la alineación real.

## Cadenas inmutables y vida útil

```lua
assert(not pcall(function() values:fill(0) end))
assert(not pcall(function() values[1] = 0 end))
local independent = lr.copy(values)
independent[1] = 9
assert(values[1] == 123 and not lr.shares_memory(values, independent))
```

Las cadenas Lua son inmutables: los arrays que las comparten y sus vistas son de
solo lectura, incluso vacíos. Una copia explícita permite escribir. El motor
retiene la cadena hasta liberar la última vista nativa, aunque la corrutina que
la creó ya haya sido recolectada. Liberar una vista no invalida las demás. Las
copias poseen memoria independiente y escribible.

```lua
local other = lr.frombuffer(bytes, "uint8", 4, 2)
assert(lr.shares_memory(values, other))
local left = lr.frombuffer(bytes, "uint8", 2)
local right = lr.frombuffer(bytes, "uint8", 2, 4)
assert(not lr.shares_memory(left, right))
```

Las consultas inspeccionan rangos físicos de bytes: dos propietarios distintos
pueden compartir memoria. Se conservan los límites de trabajo de consultas exactas.

## Frontera nativa y compatibilidad

La API C ofrece `ln_array_from_buffer` con callback y contexto de liberación
opcionales. La propiedad se transfiere solo si la construcción tiene éxito; el
callback se ejecuta una vez, al liberar la última vista. Un callback nulo deja la
vida útil a cargo del llamador. El puntero debe ser no nulo incluso con cero
bytes. La construcción desde otro array comparte su propietario. La memoria
adquirida mediante Lua no debe sobrevivir a su estado Lua.

La compatibilidad con NumPy 2.5.3 es parcial. Sus protocolos arbitrarios de
buffers, `like` y subclases Python no son interfaces Lua. Siguen sin admitirse
objetos, estructuras, StringDType de ancho variable y descriptores numéricos con
endianness no nativo. Texto y Unicode de ancho fijo conservan sus reglas
existentes. `frombuffer` conserva los bytes, incluidos booleanos no canónicos y
precisión extendida; no valida contenido Unicode arbitrario ni añade protocolos
de decodificación.

Las referencias comprueban bytes exactos, dtype, forma, strides, rangos, errores,
memoria compartida y estado tras escribir. Las pruebas Lua/C mantenidas también
comprueban GC, recolección de la corrutina creadora, liberación final, lectura no
alineada, protección de escritura y propietarios externos solapados.

Para formas multidimensionales, buffers contiguos F o strides explícitos, usa el [constructor ndarray](./ndarray.md).
