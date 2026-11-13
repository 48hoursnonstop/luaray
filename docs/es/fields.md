---
docs_examples: true
---
# Campos de bytes por elemento

`a:getfield(dtype, offset)` devuelve una vista de una región de bytes dentro de
cada elemento. `a:setfield(value, dtype, offset)` escribe en esa región y devuelve
nil. El desplazamiento de bytes empieza en **cero** por defecto. Reinterpreta
almacenamiento: no convierte el dtype del padre ni añade un eje.

```lua
local lr = require("luaray")
local records = lr.zeros({3}, "uint64")
local channel = records:getfield(lr.dtype("uint8"), 1)
assert(channel.shape[1] == 3 and channel.strides[1] == 8)
assert(not channel.flags.owndata)
assert(lr.shares_memory(records, channel))
records:setfield({10, 20, 30}, "uint8", 1)
assert(channel:tolist()[2] == 20)
```

Solo cambian los bytes seleccionados de cada elemento. Forma y strides se
conservan; cambian dtype y dirección de datos. El campo puede ser no contiguo o
desalineado. Sus flags describen esa representación. La vista conserva la
asignación aunque Lua recolecte el userdata original.

| Array | Forma | Stride por elemento | Bytes expuestos por elemento |
| --- | --- | --- | --- |
| `records` | `{3}` | 8 | 8 |
| `records:getfield("uint8", 1)` | `{3}` | 8 | 1 en el desplazamiento 1 |

## Límites y descriptores

```lua
assert(not pcall(function() records:getfield("uint16", 7) end))
assert(not pcall(function() records:getfield("uint8", -1) end))
local empty_field = records:getfield("S0", 8)
assert(empty_field.size == 3 and empty_field.itemsize == 0)
local empty = lr.zeros({0}, "uint64"):getfield("uint8", 7)
assert(empty.size == 0)
```

El ancho solicitado más el desplazamiento debe caber en el elemento original,
incluso en arrays vacíos. Los desplazamientos son enteros Lua dentro del rango
C-int original. Se exige un descriptor o string de dtype admitido; nil explícito
selecciona float64. S0/U0 conservan el ancho cero. Una entrada de solo lectura
produce una vista de solo lectura. Siguen vigentes las restricciones existentes
de dtypes y orden numérico de bytes. No implementa dtypes de registros estructurados.

## Broadcasting y entradas tipadas

```lua
local matrix = lr.zeros({2, 3}, "uint64")
matrix:setfield({1, 2, 3}, "uint8")
assert(matrix:getfield("uint8"):tolist()[2][3] == 3)
local scalar = lr.zeros({}, "uint64")
assert(not pcall(function() scalar:setfield({1}, "uint8") end))
scalar:setfield(lr.array({1}, "int32"), "uint8")
assert(scalar:getfield("uint8"):tolist() == 1)
```

Las secuencias Lua ordinarias se descubren con el rango máximo del destino.
Los ndarrays conservan las reglas originales de asignación de arrays, incluidos
los ejes iniciales de tamaño uno y las conversiones unsafe. Por ejemplo, un
array int32 con 257 se convierte en 1 al escribirlo en uint8; un entero Lua 257
queda fuera de rango. El broadcasting conserva los bytes ajenos al campo. Los
destinos de solo lectura siempre rechazan la asignación.

## Estado después de un error

```lua
local destination = lr.zeros({3}, "uint64")
assert(not pcall(function()
  destination:setfield({1, 257, 2}, "uint8")
end))
assert(destination:getfield("uint8"):tolist()[1] == 1)
assert(destination:getfield("uint8"):tolist()[2] == 0)
```

Una secuencia con la misma forma del destino se empaqueta directamente en orden
lógico. Si falla un elemento posterior, puede quedar escrito un prefijo, como
en CopyObject de NumPy. Primero se descubre la forma. Una secuencia que necesita
broadcasting se empaqueta en un temporal antes de asignar; un error durante ese
empaquetado deja el destino intacto. Los valores ndarray usan el tratamiento de
solapamiento del motor nativo de asignación.

## Escalares temporales

```lua
scalar:setfield(lr.datetime64(3, "D"), "U1")
assert(scalar:getfield("U1"):tolist() == "1") -- Texto de fecha escalar truncado.
assert(not pcall(function()
  scalar:setfield(lr.datetime64(3, "D"), "int32")
end))
scalar:setfield(lr.array(lr.datetime64(3, "D")), "int32")
assert(scalar:getfield("int32"):tolist() == 3) -- Cast tipado de ticks.
```

Los userdata temporales y los ndarrays temporales conservan rutas distintas de
conversión. Un campo entero con signo exige que la representación item del
escalar sea entera y comprueba sus límites. Las fechas escalares escriben su
texto mostrado en campos de strings; timedelta conserva el límite original de
21 caracteres incluso con salidas más anchas. Las duraciones mostradas incluyen
el multiplicador de unidad y su envoltura definida de enteros con signo. Estas
reglas no cambian el `tostring` global.

## Vida útil de una vista

```lua
local retained
 do
  local owner = lr.zeros({2}, "uint64")
  retained = owner:getfield("uint8", 2)
 end
collectgarbage("collect")
retained:fill(7)
assert(retained:tolist()[2] == 7)
```

Una vista viva también impide un `resize` del propietario que cambie su número
de bytes, pues conserva el mismo buffer. Consulta [cambiar tamaño](resize.md).
Los campos pueden exponer cualquier patrón de bits: decodifica valores numéricos
o Unicode solo cuando esos bytes sean válidos para el dtype seleccionado.

## Verificación y límites

Las referencias NumPy 2.5.3 aprobaron **233 460 casos / 2 680 078 comprobaciones
exactas**: 79 632 getfield y 153 828 setfield. Comparan datos brutos, padding
inicializado, forma, strides, descriptores, flags, memoria compartida, buffers
base completos, aceptación y estado después de errores. Cubren solo lectura,
transposición, inversión, C/F, entradas vacías y escalares, diferencias entre
escalares y arrays, broadcasting, errores parciales de secuencias y unidades,
multiplicadores y NaT temporales. Ambos corpus se regeneran exactamente. La
regresión Lua permanente añade 104 comprobaciones; la prueba nativa verifica
límites, vida útil, desplazamientos vacíos y formato temporal.

Ambos métodos siguen siendo parciales. Objetos/dtypes estructurados/StringDType,
protocolos externos, arrays tipados o userdata temporales anidados en secuencias
Lua generales, todos los casos de conversión Unicode/numérica y todas las ABI
siguen sin soporte o sin certificar. También se aplican los límites existentes
de trabajo de las consultas de memoria.
