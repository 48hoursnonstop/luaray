---
docs_examples: true
---
# Infinitos con signo

`lr.isposinf` y `lr.isneginf` identifican infinito positivo y negativo,
respectivamente. Los valores finitos y NaN dan falso. Devuelven arrays booleanos
independientes, con la forma de entrada y disposición KEEPORDER nativa.

```lua
local lr = require("luaray")
local values = lr.array({-math.huge, 0, math.huge, 0/0}, "float64")
local positive = lr.isposinf(values)
local negative = lr.isneginf(values)
assert(positive[3] and not positive[1] and not positive[4])
assert(negative[1] and not negative[3])
```

## Escalares y secuencias

Las secuencias ordinarias Lua usan el constructor existente. Los resultados
escalares siguen la convención LuaRay de arrays tipados de rango cero. False y
cero son entradas normales; no se interpretan como valores omitidos.

```lua
assert(lr.isposinf(math.huge).ndim == 0)
assert(lr.isposinf(math.huge):tolist() == true)
assert(lr.isneginf(-math.huge):tolist() == true)
assert(lr.isposinf({1, math.huge, 2})[2])
assert(lr.isneginf(false):tolist() == false)
```

## Arrays de salida existentes

Pasa un ndarray de salida como segundo argumento. Se devuelve el mismo objeto.
La entrada debe admitir broadcasting a esa forma; puede usarse una salida mayor
compatible. El motor lógico nativo convierte los booleanos al dtype de salida,
incluidos tipos numéricos, texto fijo y duraciones.

```lua
local output = lr.full({2, 4}, 9, "int16")
local result = lr.isposinf(values, output)
assert(rawequal(result, output))
assert(output:get(1, 3) == 1 and output:get(2, 1) == 0)
local text = lr.empty({4}, "S3")
lr.isneginf(values, text)
assert(text[1] == "Tru" and text[3] == "Fal")
```

## Memoria compartida y strides

Ambas máscaras de entrada se evalúan antes de escribir la salida. Una salida
que comparte memoria con la entrada usa sus valores originales, también si está
invertida. Se aceptan entradas de solo lectura y no alineadas; los ufuncs nativos
comprueban permisos y broadcasting de la salida.

```lua
local shared = lr.array({-math.huge, 0, math.huge})
local reversed = lr.flip(shared, 1)
lr.isposinf(shared, reversed)
assert(shared[1] == 1 and shared[3] == 0)
local readonly = lr.array({math.huge})
readonly:setflags(false)
assert(lr.isposinf(readonly)[1] and not readonly.flags.writeable)
```

## Entradas y controles inválidos

Se rechazan entradas complejas aunque su parte imaginaria sea cero o el array
esté vacío: el signo del infinito es ambiguo. Las entradas de texto y otros
dtypes sin signbit compatible también se rechazan antes de escribir. Solo se
admite el ndarray de salida opcional; no hay argumento where ni tabla de opciones.

```lua
local output = lr.full({1}, 9, "float64")
assert(not pcall(lr.isposinf, lr.array({lr.complex(1, 0)}), output))
assert(output[1] == 9)
assert(not pcall(lr.isneginf, lr.empty({0}, "complex128")))
assert(not pcall(lr.isposinf, values, {out = output}))
```

## Implementación y límites

La capa Lua compone `isinf`, `signbit`, `logical_not` y `logical_and` nativos,
en el orden del origen. No recorre datos como números Lua, por lo que conserva
precisión extendida y comportamiento nativo con strides. La composición reserva
máscaras temporales.

```lua
local extended = lr.array({-math.huge, math.huge}, "longdouble")
assert(lr.isneginf(extended)[1] and lr.isposinf(extended)[2])
local empty = lr.empty({0, 3}, "float32")
assert(lr.isposinf(empty).size == 0)
```

No se certifican todos los protocolos Python de escalares/subclases/objetos
externos, clases de errores, avisos/estado flotante, dtypes personalizados ni
todas las ABI. Las funciones siguen clasificadas como parcialmente compatibles.

La migración a NumPy 2.5.5 aprobó **10 152 casos / 83 001 comprobaciones**. Los predicados de infinito aportaron 8 460 casos y 57 700 comprobaciones de valores, dtype, disposición, permisos, aliasing y conversión de salida. Los otros 1 692 casos prueban promoción de cuantiles con solo NaN, take en ejes vacíos, raíces complejas de valores enormes y negación con strides. Se actualizaron ocho aserciones históricas de dtype con el mismo generador y NumPy 2.5.5. Aprobaron todas las aserciones numéricas originales.
