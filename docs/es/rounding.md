# Redondeo decimal

LuaRay 0.113.0-dev implementa `np.round`, `np.around` y `a:round` siguiendo
calculation.c de NumPy 2.5.3. Conserva la composición real multiply/rint/divide
y su precisión por tipo, sin sustituirla por redondeo escalar del lenguaje.

```lua
local np = require('luaray')
local a = np.array({1.25, 2.5}, 'float32')
local r = a:round(1)
local out = np.empty({2}, 'float64')
assert(rawequal(np.round(a, {decimals=1, out=out}), out))
assert(np.round({15,25}, -1):tolist()[2] == 20)
```

Se admiten `np.round(input, decimals, out)`,
`np.round(input, {decimals=...,out=...})` y el método equivalente. Decimals usa
cero por defecto y debe ser entero Lua dentro del rango int de C; también se
aceptan booleanos como 0/1. Las entradas ordinarias usan el constructor existente
y los escalares devuelven ndarrays de rango cero. Opciones desconocidas, claves
con NUL y salidas duplicadas se rechazan.

Para decimales no negativos, los enteros se copian sin aritmética y conservan
todos sus bits. Con salida se usa asignación same-kind. Un entero de solo lectura
puede ser su propia salida idéntica porque no necesita escritura. Las salidas
nuevas son independientes y escribibles. Con decimales negativos, los enteros
usan trabajo float64 y conversión final, como NumPy; no es aritmética entera exacta.

Cero decimales usa rint para flotantes, con empates al par en el modo habitual.
Bool no es un entero en esta ruta: sin salida, su redondeo a cero decimales
produce float16; otros decimales pueden fallar por las reglas de conversión.

En los demás casos, la primera operación calcula a la precisión de entrada y
escribe en out; rint y la última operación usan después el tipo de esa salida.
Una salida más ancha puede cambiar la precisión intermedia. Los complejos
redondean cada componente por separado a la precisión de entrada y luego lo
asignan al componente de salida. El factor de diez conserva el orden de
multiplicación double del código fuente. Desde exponente 309 se estabiliza en
infinito: LuaRay evita repetir un bucle lineal enorme para INT_MIN/MAX. Las
llamadas upstream de miles de millones de iteraciones no se ejecutaron;
factores acotados y extremos nativos se comprobaron por separado.

## Errores y escrituras parciales

La salida debe tener inicialmente el mismo número de elementos; después siguen
las reglas de forma y conversión de cada operación. Un error posterior puede
dejar cambios reales. Al redondear complejos hacia una salida no compleja,
la parte real puede escribirse antes del fallo de la parte imaginaria.

Las funciones raíz conservan el reintento de fromnumeric.py: un TypeError del
método ndarray provoca un intento adicional. El método no reintenta:

```lua
local td = np.array({1}, 'timedelta64[h]')
assert(not pcall(np.round, td, 1, td))
assert(np.astype(td, 'int64'):tolist()[1] == 100) -- dos multiplicaciones parciales
local once = np.array({1}, 'timedelta64[h]')
assert(not pcall(function() once:round(1, once) end))
assert(np.astype(once, 'int64'):tolist()[1] == 10)
```

Las categorías internas distinguen los errores relevantes para ese reintento;
Lua sigue recibiendo errores Lua, no objetos de excepción Python. `ln_error`
añade un campo interno: recompila todos los objetos nativos al actualizar el
código. Los paquetes se verifican mediante compilaciones limpias.

## Escalado flotante de timedelta

Round necesitaba multiplicar/dividir timedelta por flotantes. Las firmas nativas
m*d, d*m y m/d ahora calculan en double, conservan unidades, truncan ticks
finitos, propagan NaT y respetan máscaras y conversiones de salida. Los factores
float16/32/64/longdouble siguen el bucle double upstream. El escalado por enteros,
las razones timedelta/timedelta y la aritmética temporal completa siguen
pendientes, sin aproximarlos mediante firmas flotantes. Los resultados NaT
fuera de rango se auditaron en x86; faltan certificaciones de otras ABI.

## Alcance ejecutado

Referencias NumPy 2.5.3: redondeo **2 780 casos /141 112 comprobaciones**;
salidas **2 346 /189 964**; escalado temporal flotante **3 100 /150 416**.
Total **8 226 /481 492 comprobaciones exactas**, incluidos ceros con signo,
disposiciones C/F/con saltos/invertidas/broadcast, precisiones numéricas,
unidades temporales, NaN/Inf, identidad, alias y estados reales tras errores.
También pasaron pruebas C y 42 comprobaciones Lua dirigidas.

Los protocolos completos externos/subclases/dispositivos, todas las firmas,
advertencias, modos de redondeo, ABI y aritmética temporal siguen incompletos.
La presencia de una función no certifica compatibilidad total.

```sh
make -j4 full-test
make reference-test
```

Nueve hashes: [pinned source hashes](https://github.com/48hoursnonstop/luaray/blob/main/compatibility/numpy-source.sha256). Véanse
[matemáticas unarias](unary_math.md), [componentes](components.md),
[creación](creation.md) e [inventario](api_inventory.md).
