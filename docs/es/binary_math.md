# Matemáticas binarias y conversión de entradas

LuaRay 0.109.0-dev añade `fmod` y `float_power` nativos, acepta entradas Lua
ordinarias en las llamadas binarias existentes e implementa concatenación de
cadenas de ancho fijo y promoción booleana. No necesita Python en ejecución.

## Residuos y potencias

```lua
local np = require('luaray')
assert(np.fmod(-5, 3):tolist() == -2)
assert(np.remainder(-5, 3):tolist() == 1)
assert(np.float_power(2, -3):tolist() == 0.125)
local huge = np.float_power(np.array({2}, 'int8'), 300)
assert(huge.dtype == 'float64') -- promueve antes de convertir el exponente
```

`fmod(a,b)` conserva el signo del dividendo. En enteros, divisor cero o mínimo
con signo módulo -1 producen cero, sin división indefinida en C. Half calcula
en float32; los demás flotantes usan fmod a su precisión. No hay firmas para
complejos, cadenas ni tipos temporales. Booleanos usan un bucle entero;
los tipos numéricos mezclados eligen la primera firma con conversión segura.

`float_power(a,b)` calcula al menos en float64 o complex128 y conserva
longdouble/clongdouble cuando corresponde. Admite exponentes enteros negativos.
Los escalares débiles Lua conservan su precisión predeterminada hasta resolver
esa firma; una entrada int8 no provoca desbordamiento prematuro del exponente
300. Una base real negativa con exponente fraccionario produce NaN; se requiere
entrada compleja explícita para resultados complejos. Reutiliza los núcleos
nativos de potencia con una resolución distinta de `power`.

## Entradas Lua ordinarias

```lua
local sum = np.add({1,2,3}, 2) -- {3,4,5}
local broadcast = np.multiply({{1},{2}}, {10,20,30}) -- forma {2,3}
local scalar = np.add(1, 2) -- ndarray int64 de rango cero
print(scalar:tolist()) -- 3

local out = np.full({3}, 99, 'float64')
assert(rawequal(np.fmod({5,6,7}, 3, {
  out=out, where=np.array({true,false,true}),
}), out)) -- {2,99,1}
```

Las llamadas existentes de aritmética, comparación, lógica, bits, extremos,
copysign, arctan2 e hypot aceptan escalares y tablas rectangulares. Dos escalares
ordinarios se materializan con sus tipos naturales. Las tablas usan el
constructor existente. Un escalar ordinario junto a tabla/ndarray conserva la
resolución débil; un ndarray de rango cero conserva su tipo fuerte. Siguen las
limitaciones del constructor, incluidas combinaciones incompletas de ndarrays
anidados, objetos externos y tablas de cadenas convertidas a tipos numéricos.

Las opciones se analizan antes de añadir temporales a la pila. Se requieren
dos operandos no nil. Las firmas `operation(a,b,{out=...,where=...})` y
`operation(a,b,out,where)` usan el mismo broadcasting y escritura. La salida
debe tener la forma exacta, admitir escritura y conversión `same_kind`.
Se devuelve el mismo objeto `out`. Las posiciones no seleccionadas conservan
sus valores; sin salida explícita quedan sin inicializar. Las vistas solapadas
se calculan mediante temporales seguros.

## Cadenas de ancho fijo

```lua
assert(np.add('λ', '🙂'):tolist() == 'λ🙂')
local a = np.array({'a\0b', 'x\0'}, 'S4')
local b = np.array({'c', 'y'}, 'S4')
local c = np.add(a, b) -- |S8: {'a\0bc', 'xy'}
```

La suma tiene firmas S+S y U+U. El ancho de salida suma los anchos declarados;
el contenido concatena después de quitar el relleno cero final de cada entrada.
Los NUL internos se conservan. Unicode normaliza el orden de bytes antes de
iterar. Las salidas explícitas más estrechas se truncan mediante las conversiones
habituales. Un ancho total superior a INT_MAX bytes se rechaza al resolver los
descriptores, incluso para arrays vacíos. Se rechazan S/U mezclados y sumas
numérico/cadena. StringDType variable no está implementado.

Una cadena Lua normalmente se convierte a Unicode; junto a un array S/U
explícito sigue su clase. No existen clases escalares separadas equivalentes a
str/bytes de Python: elige el dtype explícitamente cuando importen los bytes.
Las conversiones de salida aún pueden fallar; por ejemplo, S a U exige ASCII
si la entrada contiene un byte no ASCII.

## Promoción lógica

El promotor lógico binario de NumPy convierte las entradas compatibles a bool
antes de calcular. Redondear primero el escalar débil al tipo flotante contrario
sería incorrecto: `logical_and(float16_array, 1e-100)` debe ver un escalar
verdadero. LuaRay conserva ese valor de verdad, también para componentes
imaginarias diminutas. Las cadenas se consideran según su contenido almacenado
no vacío, sin interpretación numérica: `'0'` y `'False'` son verdaderos; la
cadena vacía es falsa. La operación unaria logical_not tiene firmas distintas.

## Pruebas y alcance pendiente

Las referencias originales de NumPy 2.5.3 cubren **4 986 casos / 514 816
comprobaciones**: fmod 1 428 / 189 111; float_power 1 428 / 205 745;
conversión binaria 784 / 18 244; cadenas/promoción booleana 1 346 / 101 716.
Se comprueban valores, metadatos, errores, identidad, cambios reales en respaldo,
disposiciones, máscaras, solapamiento, extremos, valores especiales, Unicode,
orden de bytes, relleno y desbordamiento de anchos. Fmod, conversión y cadenas
comparan exactamente. Float_power, power, arctan2 e hypot permiten error relativo
2e-12; el máximo observado fue aproximadamente 3.23e-15 en float_power
(absoluto 3.20e-14).

También pasaron las pruebas C y 303 comprobaciones Lua dirigidas. Todo sigue
`implemented_partial`: faltan firmas completas, protocolos dtype/casting/order/
device/subclases, objetos/métodos ufunc, advertencias, estado flotante y todos
los modos de redondeo. Los escalares devuelven ndarrays tipados por diseño.
Estas mediciones no representan un porcentaje global de NumPy completado.

```sh
make -j4 full-test
make reference-test
```

Véanse [matemáticas unarias](unary_math.md), [creación](creation.md) e
[inventario](api_inventory.md). Los hashes se encuentran en
[pinned source hashes](../../compatibility/numpy-source.sha256); se conserva la atribución BSD de NumPy.
