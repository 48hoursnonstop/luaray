# Inventario de disponibilidad de API

`compatibility/api_inventory.json` registra búsquedas reales de nombres invocables
Lua frente a la API pública de NumPy 2.5.3. Se generó con el intérprete de
referencia y el módulo Lua compilado. Leer este registro de desarrollo no
requiere Python ni NumPy.

El alcance contiene **675 nombres**, incluidos alias y tipos Python invocables:
`__all__` de NumPy/FFT/linalg/random y métodos públicos de ndarray, Generator y
ufunc. Excluye constantes, propiedades, otros submódulos, combinaciones de bucles
por dtype y cobertura de firmas/casos límite.

| Grupo | Nombres | Invocables Lua | Bindings ausentes | Adaptación Lua |
| --- | ---: | ---: | ---: | ---: |
| numpy | 462 | 253 | 209 | 0 |
| numpy.fft | 18 | 18 | 0 | 0 |
| numpy.linalg | 32 | 31 | 0 | 1 |
| numpy.ndarray | 53 | 42 | 11 | 0 |
| numpy.random | 60 | 1 | 59 | 0 |
| numpy.random.Generator | 44 | 43 | 1 | 0 |
| numpy.ufunc | 6 | 0 | 6 | 0 |
| Total | 675 | 388 | 286 | 1 |

**388 nombres invocables no significan 356 APIs totalmente compatibles.** Los
nombres disponibles se clasifican `implemented_partial`. El comportamiento se
verifica por separado mediante referencias originales y contratos de cada
versión. Este inventario declara cero APIs completamente compatibles. Los nombres
ausentes quedan como `not_implemented` hasta revisión; puede haber una API Lua
alternativa, como `np.add_accumulate` para una operación que NumPy expone dentro
de un objeto ufunc. La tabla mide nombres directos en ese alcance y no todas
las capacidades matemáticas ni el avance global de NumPy.

`numpy.linalg.LinAlgError` se clasifica expresamente `not_applicable_to_lua`:
es una clase de excepción Python; la biblioteca nativa produce errores Lua y
no reproduce esa jerarquía. El registro incluye la justificación. No se exime
automáticamente a otros tipos invocables ni se declara fidelidad completa de
advertencias, subclases o clases de excepciones Python.

El generador se conserva en el
[paquete fuente 0.116](https://github.com/48hoursnonstop/luaray/releases/tag/v0.116.0-dev)
para un entorno de referencia NumPy separado. Consulta campos del módulo y
prototipos reales de ndarray, Generator y ufunc, incluidos userdata invocables.
No ejecuta todas las operaciones descubiertas. Las regresiones y suites
diferenciales aportan la evidencia separada de comportamiento.
