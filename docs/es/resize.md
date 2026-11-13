---
docs_examples: true
---
# Cambiar el tamaño de arrays

`lr.resize(a, shape)` devuelve almacenamiento independiente. `a:resize(shape,
options)` modifica el array existente. Ambas formas aceptan un entero para un
eje o una tabla Lua densa de dimensiones; `{}` indica rango cero. Las dimensiones
deben ser no negativas y el máximo son 64 ejes. Un número negativo no infiere
una dimensión.

## Repetir valores en un array nuevo

```lua
local lr = require("luaray")
local original = lr.array({{1, 2}, {3, 4}}, "int32")
local repeated = lr.resize(original, {2, 3})
assert(repeated:tolist()[2][3] == 2)
assert(not lr.shares_memory(original, repeated))
repeated[1] = 99
assert(original:tolist()[1][1] == 1)
```

La función lee el array en orden C lógico, repite la secuencia y la recorta al
número solicitado de elementos. No interpola ni remuestrea valores. Las vistas
transpuestas o con strides negativos se leen en su orden lógico. Los valores
Lua ordinarios pasan antes por el constructor existente.

```lua
local columns = lr.resize(lr.transpose(original), {6})
assert(columns:tolist()[2] == 3 and columns:tolist()[5] == 1)
local empty = lr.resize(lr.array({}, "int16"), {2, 2})
assert(empty:tolist()[2][2] == 0)
```

Una entrada vacía aporta ceros. La salida no vacía suele ser una vista de un
buffer nuevo de concatenación: `flags.owndata` puede ser falso aunque no comparta
almacenamiento con la entrada. Las ramas de entrada vacía o tamaño cero asignan
memoria directamente. La concatenación Unicode por defecto normaliza el orden
de bytes; un dtype explícito sin ancho conserva las reglas separadas de
resolución de descriptores de NumPy. S0/U0 conservan ancho cero en la rama no
vacía; la rama vacía usa el ancho mínimo del constructor like. Estas diferencias
proceden de la implementación upstream comprobada.

## Modificar el array existente

```lua
local values = lr.array({1, 2, 3}, "int64")
local alias = values
assert(values:resize({2, 2}) == nil)
assert(rawequal(alias, values))
assert(alias:tolist()[2][1] == 3 and alias:tolist()[2][2] == 0)
values:resize({2})
assert(alias:tolist()[2] == 2)
```

El método devuelve nil. Conserva la secuencia física, recortándola o añadiendo
ceros al almacenamiento escribible. Un array contiguo solo en orden Fortran
mantiene esa disposición. Los arrays no contiguos se rechazan. Cambiar el número
de bytes exige almacenamiento nativo propio sin vistas nativas vivas. Cambiar
solo la forma también puede funcionar sobre una vista contigua o un buffer
externo. Los dtypes de ancho cero pueden cambiar de cantidad sin reasignar
bytes. Omitir la forma o pasar nil no hace nada.

## Memoria compartida y referencias Lua

```lua
local owner = lr.array({10, 20})
local view = owner:reshape({1, 2})
assert(not pcall(function() owner:resize({3}, {refcheck=false}) end))
owner:resize({2, 1}) -- Mismos bytes; la vista conserva su propia forma.
assert(view.shape[1] == 1 and owner.shape[1] == 2)
view = nil
collectgarbage("collect")
owner:resize({3})
assert(owner:tolist()[3] == 0)
```

Se aceptan `{refcheck=true}` y `{refcheck=false}`. Los alias Lua al mismo userdata
siguen su cabecera actualizada. No se reproducen los contadores de CPython:
ambas opciones bloquean la reasignación si otra vista nativa conserva el buffer,
evitan punteros inválidos. Una vista temporal puede seguir viva hasta que Lua
la recolecta; libera esas vistas antes de ampliar el propietario.

## Solo lectura y validación

```lua
local text = lr.array({"λ", "x"}, "U2")
text:setflags(false)
text:resize({4})
assert(not text.flags.writeable and text:tolist()[4] == "")
assert(not pcall(function() lr.resize({1}, {0, -1}) end))
```

Se conserva el estado de solo lectura. Como en el código original, la nueva cola
numérica de un array de solo lectura tiene contenido no especificado: hazlo
escribible e inicialízala antes de leerla. LuaRay inicializa además los nuevos
puntos de código Unicode incluso en solo lectura para impedir texto inválido
procedente de memoria arbitraria. Es una diferencia de seguridad deliberada.
Se validan todas las dimensiones y productos de strides de ejes no vacíos,
incluso después de un eje cero; se rechazan los estados donde upstream omite
controles de negativos o desbordamiento después de cero.

## Verificación y límites

Las referencias NumPy 2.5.3 aprobaron **18 248 casos / 313 948 comprobaciones
exactas**: 7 776 resize independientes, 7 128 casos del método y 3 344 regresiones
de disposición/concatenación Unicode. Comparan bytes inicializados, dtype,
forma, strides, flags y estados de entrada/base en 18 dtypes y arrays C/F,
transpuestos, invertidos, con saltos y de solo lectura. Longdouble omite el
padding de la ABI. Las referencias de crecimiento en solo lectura comprueban
solo el prefijo inicializado; no usan colas indefinidas ni formas inválidas del
código original como resultados esperados.

La regresión Lua permanente añade 156 comprobaciones; una prueba nativa cubre
propiedad, reasignación, liberación de buffers externos, vistas vivas y límites.
Ambas APIs siguen siendo parciales: no cubren dtypes de objetos, estructurados
o strings de ancho variable, protocolos externos, contadores de referencias
Python ni firmas variádicas de forma.
