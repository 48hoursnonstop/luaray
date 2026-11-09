# Matemáticas unarias

LuaRay 0.108.0-dev implementa estas operaciones de NumPy 2.5.3 mediante un
registro nativo independiente y el motor compartido de tipos, broadcasting e
iteración. No necesita Python durante su ejecución.

| Operación | Comportamiento | Familias de bucles numéricos |
| --- | --- | --- |
| `floor(x)` | Redondeo hacia menos infinito | Booleanos, enteros y flotantes reales |
| `ceil(x)` | Redondeo hacia más infinito | Booleanos, enteros y flotantes reales |
| `trunc(x)` | Elimina la parte fraccionaria | Booleanos, enteros y flotantes reales |
| `rint(x)` | Redondeo al entero cercano; empates al par con el modo predeterminado | Flotantes reales y complejos |
| `fabs(x)` | Valor absoluto real | Flotantes reales |
| `conjugate(x)`, `conj(x)` | Invierte el signo de la parte imaginaria | Enteros y flotantes reales/complejos |
| `square(x)` | Cuadrado | Enteros y flotantes reales/complejos |
| `reciprocal(x)` | Uno dividido entre el valor | Enteros y flotantes reales/complejos |
| `degrees(x)`, `rad2deg(x)` | Radianes a grados | Flotantes reales |
| `radians(x)`, `deg2rad(x)` | Grados a radianes | Flotantes reales |

Si no existe un bucle exacto, se elige el primero que permite una conversión
segura. `conjugate(bool)` y `square(bool)` producen int8; `rint(int8)` usa
float16 y `rint(int64)` usa float64. Floor, ceil y trunc conservan los tipos
enteros y booleanos incluso fuera de la precisión de los flotantes.
Se rechaza un complejo cuando la operación carece de bucle complejo. Aquí no
hay bucles para cadenas, datetime/timedelta, objetos ni tipos estructurados.

## Uso desde Lua

```lua
local np = require('luaray')
local values = np.array({-2.5, -0.5, 0.5, 2.5}, 'float32')
local rounded = np.rint(values) -- {-2, -0, 0, 2}, float32
local angles = np.deg2rad({0, 90, 180})
local scalar = np.square(3) -- ndarray de rango cero, int64 con valor 9
print(scalar:tolist())

local out = np.full({4}, 99, 'float64')
local same = np.ceil(values, {
  out = out,
  where = np.array({true, false, true, false}, 'bool'),
})
assert(rawequal(same, out)) -- {-2, 99, 1, 99}
```

La firma es `operation(input, {out=..., where=...})`; también se admite
`operation(input, output_array, where)`. La salida debe tener la forma exacta
del resultado, permitir escritura y aceptar la conversión `same_kind`.
La máscara debe ser booleana y compatible mediante broadcasting. Las posiciones
no seleccionadas conservan el valor anterior de `out`. Si no se proporciona
`out`, esas posiciones quedan sin inicializar. Las vistas solapadas usan salida
temporal y escritura posterior; las pruebas comprueban cambios reales y respaldo.

El punto de entrada unario compartido también acepta números, booleanos,
complejos y tablas rectangulares en operaciones existentes como sin, sqrt e
isnan. La conversión sigue `np.array` y conserva sus limitaciones. Las opciones
se analizan antes de que la conversión añada temporales a la pila Lua.
Los resultados siempre son ndarrays con tipo explícito, incluso para escalares;
esta es una adaptación de los objetos escalares devueltos por NumPy.

## Precisión y límites

Float16 calcula en float32 y redondea una vez al tipo half. Los demás flotantes
conservan su precisión de cálculo. Las constantes angulares se redondean a esa
precisión antes de multiplicar. El cuadrado entero usa aritmética modular sin
desbordamiento con signo indefinido de C. El recíproco entero de ±1 conserva el
valor; para otros valores no nulos produce cero. En los bucles x86 auditados,
el recíproco de cero produce el mínimo de int32/int64 con signo, y cero para
enteros menores o sin signo. LuaRay reproduce esos resultados explícitamente,
sin convertir infinito a entero con comportamiento indefinido. Otras ABI
requieren comprobación independiente.

El cuadrado complejo conserva el orden de productos FMA de NumPy cuando el
host y el recorrido lo permiten. La iteración usa la permutación física
KEEPORDER, incluido el eje contiguo de arrays Fortran. El recíproco complejo
usa la fórmula escalada del código fuente. Se comprueban ceros con signo,
NaN e infinitos. No están certificados todos los modos de redondeo del proceso,
despachos de CPU, ordenamientos de bytes ni ABI longdouble. Las advertencias y
las API errstate/estado flotante de NumPy siguen incompletas.

## Comprobaciones y alcance

Tres archivos originales contra NumPy 2.5.3 cubren **5 589 casos / 501 064
comprobaciones**: redondeo 2 135 / 176 894; álgebra 1 746 / 186 658;
ángulos 1 708 / 137 512. Comprueban valores, tipos, formas, strides, identidad
de salida, aceptación y escrituras reales en entrada/respaldo. Incluyen vistas
C/F/transpuestas/invertidas/con saltos/broadcast, rango cero, arrays vacíos,
máscaras, solapamiento, salidas de solo lectura, extremos enteros y patrones
half muestreados. El error numérico observado fue cero.

Las comparaciones son exactas salvo casos generales de cuadrado/recíproco
complejo: tolerancia relativa de 6e-7 en complex64 y 2e-15 en tipos mayores.
Los 38 casos adicionales de FMA, disposición y escritura exigen igualdad exacta.
Las pruebas C y 358 comprobaciones Lua dirigidas cubren límites y conversiones
de las operaciones unarias existentes. Todas las funciones siguen clasificadas
`implemented_partial`: faltan objetos/métodos ufunc completos, todas las firmas
de NumPy, protocolos de dispositivos/subclases y combinaciones de tipos.
Los alias ofrecen llamadas equivalentes, no identidad de objetos ufunc.

```sh
make -j4 full-test
make reference-test
```

Hashes: [pinned source hashes](https://github.com/48hoursnonstop/luaray/blob/main/compatibility/numpy-source.sha256). Véanse el
[inventario](api_inventory.md), la [creación](creation.md) y el
[muestreo](sampling.md).
