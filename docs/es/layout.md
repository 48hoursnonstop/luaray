# Disposición de arrays, reshape, ravel y flatten

LuaRay 0.110.0-dev implementa las reglas de disposición de NumPy 2.5.3 en un
subsistema nativo independiente. Los enlaces Lua se compilan por separado
mediante el puente de propiedad existente. El reshape C interno delega al mismo
núcleo. No se necesita Python en ejecución.

```lua
local lr = require('luaray')
local a = lr.array({{0,1,2},{3,4,5}}, 'float64')
local columns = lr.ravel(a, 'F') -- {0,3,1,4,2,5}
local rows = a:ravel() -- comparte el búfer de a
local independent = a:flatten() -- siempre copia
assert(lr.shares_memory(rows, a))
assert(not lr.shares_memory(independent, a))

local transpose = lr.transpose(a)
local view = transpose:reshape(6, {order='F', copy=false})
assert(lr.shares_memory(view, a))
local copied = lr.reshape(a, {3,2}, {order='F', copy=true})
```

| Llamada Lua | Predeterminado | Contrato de almacenamiento |
| --- | --- | --- |
| `lr.reshape(a, shape, options)` | C, copia si hace falta | Reutiliza strides compatibles o copia en el orden lógico solicitado |
| `a:reshape(shape, options)` | Igual | Mismo núcleo nativo |
| `lr.ravel(a, order)` / `a:ravel(order)` | C | Vista contigua de rango uno si es posible; si no, copia |
| `a:flatten(order)` | C | Copia independiente y escribible de rango uno |

`shape` es un entero o tabla de dimensiones; una tabla vacía indica rango cero.
Una dimensión negativa infiere el tamaño faltante. Se rechazan varias dimensiones
negativas, inferencias ambiguas con tamaño cero e incompatibilidades de tamaño.
El rango máximo es 64 y se comprueba el desbordamiento de productos de tamaño y
strides. Se usa un único argumento de forma, en lugar de los argumentos
variádicos históricos del método de NumPy.

Las opciones son `{order='C', copy='if_needed'}`. `copy=false` rechaza una copia
de búfer necesaria; `copy=true` crea almacenamiento independiente incluso cuando
la forma no cambia. Una cadena de orden puede sustituir la tabla de opciones.
Reshape acepta C/F/A y rechaza K. A elige F solo si la entrada es contigua
Fortran sin ser también contigua C; en otro caso elige C. El orden determina el
recorrido de los elementos. Las entradas Lua ordinarias pasan por el constructor
antes de reshape: `copy=false` controla ese paso de reshape, no prohíbe la
conversión inicial de una tabla a array.

Ravel/flatten aceptan C/F/A/K como cadena o `{order='K'}`. C recorre primero el
último eje lógico; F el primero. K sigue el orden físico estable de strides,
manteniendo el recorrido lógico de ejes negativos. Los strides cero de
broadcast conservan el orden estable del iterador cuando son ambiguos.
La vista de ravel exige almacenamiento realmente contiguo y positivo. Por eso
un vector invertido o con saltos puede cambiar de forma sin copiar y aun así
necesitar una copia en ravel. Una permutación multidimensional contigua puede
producir una vista K aunque no tenga activadas las marcas C ni F.

## Memoria compartida, propiedad y escritura

```lua
local reversed = lr.flip(a:ravel(), 1)
local view = reversed:reshape({2,3}, {copy=false})
assert(lr.shares_memory(view, a)) -- strides {-24,-8}
assert(not lr.shares_memory(reversed:ravel('K'), a))
```

Cada resultado tiene su propia cabecera. Las vistas retienen el búfer aunque el
userdata original sea recolectado. Conservan el estado de solo lectura; las
copias nuevas permiten escritura. Escribir sobre una vista modifica el respaldo
original; escribir sobre una copia no. Un array vacío no comparte bytes aunque
retenga el mismo propietario, por lo que `shares_memory` devuelve false.
Las asignaciones vacías de flatten y las vistas vacías de reshape pueden tener
strides distintos: las pruebas comprueban exactamente esas reglas.

## Referencias ejecutadas y alcance

Las pruebas originales contra NumPy 2.5.3 cubren **25 134 casos / 1 759 008
comprobaciones**: ravel 2 664 / 185 920; flatten 2 640 / 185 128;
reshape 19 830 / 1 387 960. Se comparan exactamente valores, tipo, forma,
strides, memoria compartida, identidad nueva, escritura y estados posteriores
de entrada/respaldo. Incluyen doce tipos numéricos, S/U, Unicode con otro orden
de bytes y unidades temporales; escalares, vacíos, ejes unitarios, transpuestas,
permutaciones, vistas invertidas/con saltos y broadcasts de solo lectura.
Se ejercitan C/F/A/K, todos los modos de copia de reshape e inferencias y formas
inválidas o con desbordamiento.

Una prueba C y 61 comprobaciones Lua dirigidas cubren propiedad después de GC,
strides negativos, opciones inválidas con NUL, rango máximo, solo lectura y la
diferencia entre ravel y reshape. El generador crea entradas ndarray explícitas:
un escalar NumPy producido por aritmética de rango cero no sustituye una
referencia ndarray de rango cero al comprobar memoria compartida.

Todas las API siguen `implemented_partial`. Los protocolos completos de
subclases/dispositivos/arrays externos, tipos objeto/estructurados, todas las
variantes ABI, advertencias y firmas posicionales Python siguen pendientes o sin
certificar. Se conservan las limitaciones del constructor. Esta auditoría de
disposición no certifica compatibilidad completa con NumPy.

```sh
make -j4 full-test
make reference-test
```

Ocho hashes fijan las fuentes en [pinned source hashes](https://github.com/48hoursnonstop/luaray/blob/main/compatibility/numpy-source.sha256).
Véanse [creación](creation.md), [matemáticas binarias](binary_math.md) e
[inventario](api_inventory.md).

[Cambiar el tamaño](resize.md) explica las copias con repetición y la reasignación del array existente.
