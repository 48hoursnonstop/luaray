# Predicados real/complejo y real_if_close

LuaRay 0.112.0-dev implementa cinco funciones de NumPy 2.5.3 mediante las vistas
de componentes y el motor nativo de tipos/ufuncs. Python solo es un oráculo de
desarrollo.

```lua
local np = require('luaray')
local z = np.array({np.complex(1,0), np.complex(2,1)}, 'complex64')
local reales = np.isreal(z) -- {true,false}
local complejos = np.iscomplex(z) -- {false,true}
assert(np.iscomplexobj(z)) -- comprueba el tipo, incluso si todo imag fuera cero
assert(not np.isrealobj(z))
local near = np.array({np.complex(1,1e-6)}, 'complex64')
local r = np.real_if_close(near) -- vista float32 del componente real
np.copyto(r, 7, 'unsafe') -- cambia la parte real de near
```

`iscomplex` comprueba si cada parte imaginaria es distinta de cero; para tipos
no complejos crea false en orden C. `isreal` comprueba igualdad a cero y conserva
el orden C/F del array imaginario cero para tipos no complejos. Ambos producen
arrays bool independientes y escribibles; los escalares siguen la convención de
ndarray de rango cero. `iscomplexobj`/`isrealobj` devuelven booleanos Lua según
el dtype, independientemente de los valores.

Una parte imaginaria NaN se considera compleja; una parte real NaN con imaginaria
cero se considera real para estos predicados. Como NumPy, cadenas y datetime
producen isreal false, mientras timedelta produce true. No sustituyen isfinite.

`real_if_close(a,tol)` usa 100 de forma predeterminada. Si tol es mayor que uno,
lo multiplica por epsilon del tipo componente; en otro caso es un límite
absoluto. Se convierte primero a la precisión del componente. Todas las
magnitudes imaginarias deben ser estrictamente menores: la igualdad no convierte.
Si se cumple, devuelve una vista real; si no, conserva la identidad original.
Las entradas ya reales se devuelven antes de examinar tol. Los arrays complejos
vacíos convierten incluso con tol negativo/NaN por la reducción all vacía.
NaN imaginario impide convertir; infinito tampoco es menor que un límite infinito.

Se admiten tolerancias numéricas, enteras y booleanas Lua; nil usa el valor
predeterminado. Tolerancias ndarray, protocolos completos externos/subclases/
dispositivos, tipos objeto/estructurados, advertencias y todas las ABI siguen
pendientes o sin certificar. Las vistas retienen propiedad y estado de escritura.

## Corrección de cadenas complejas

La API astype histórica Lua permite conversiones de cadenas de ndarray.astype.
NumPy construye primero un complejo de dos double, también para clongdouble.
LuaRay ahora reproduce esa precisión, acepta desbordamiento/subdesbordamiento
numérico válido, formas `1-j` y espacios junto a paréntesis. Rechaza guiones
bajos inválidos, hexadecimal/nan-payload exclusivo de C y NUL interno en cadenas
numéricas no booleanas. Bool conserva la regla de contenido no vacío.
La gramática Unicode completa y la independencia de locale siguen pendientes;
no se declara equivalencia con la firma numérica restringida de np.astype raíz.

Las referencias x87 de precisión completa se construyen mediante ldexp, stack
y escritura de componentes nativos: las cadenas complejas perderían precisión
también en NumPy, que las redondea primero a complex128.

Referencias originales NumPy 2.5.3: predicados **2 652 casos /158 028
comprobaciones**; cercanía **4 170 /313 989**; texto **612 /6 699**. Total
**7 434 /478 716 comprobaciones exactas**, con límites nextafter, quince tipos,
disposiciones, vacíos, NaN/Inf, identidad, propiedad y escrituras reales. También
pasaron pruebas C y 53 comprobaciones Lua. Todas las API siguen parciales.

```sh
make predicates112-test CXXFLAGS='-O0 -g -std=c++11 -Wall -Wextra -Wpedantic'
make full-test CXXFLAGS='-O0 -g -std=c++11 -Wall -Wextra -Wpedantic'
make sanitize-predicates112
```

Seis hashes: `NUMPY_2_5_3_PREDICATES112_FILE_HASHES.sha256`. Véanse
[componentes](components.md), [disposición](layout.md) e
[inventario](api_inventory.md).
