---
docs_examples: true
---
# Interpolación lineal

`lr.interp(x, xp, fp, opciones)` estima valores entre muestras de una dimensión.
`xp` contiene coordenadas y `fp` sus valores reales o complejos. Las consultas
pueden tener cualquier forma; el resultado conserva esa forma.

## Muestras y consultas

```lua
local lr = require("luaray")
local values = lr.interp({-0.5, 0.5, 1.5, 3}, {0, 1, 2}, {0, 2, 3})
assert(values[1] == 0 and values[2] == 1)
assert(values[3] == 2.5 and values[4] == 3)
local scalar = lr.interp(0.5, {0, 1}, {0, 2})
assert(scalar.ndim == 0 and scalar:tolist() == 1)
```

Las coordenadas y los valores de muestra deben tener una dimensión y la misma
longitud. Sin `period`, proporciona coordenadas crecientes. La función sigue la
búsqueda de la referencia: no valida ni ordena la malla no periódica. Una consulta
exacta devuelve directamente su muestra y evita calcular pendientes no finitas.
Una consulta escalar devuelve un ndarray tipado de rango cero.

## Límites

```lua
local filled = lr.interp({-1, 3}, {0, 1, 2}, {0, 2, 3}, {left=-7, right=9})
assert(filled[1] == -7 and filled[2] == 9)
```

| Opción | Valor predeterminado | Significado |
| --- | --- | --- |
| `left` | Primera muestra | Valor por debajo del intervalo. |
| `right` | Última muestra | Valor por encima del intervalo. |
| `period` | Omitido | Normalizar y ordenar una malla periódica. |

Solo se admiten muestras vacías cuando las consultas también están vacías. Las
consultas vacías omiten la conversión de valores de límite. Con una muestra se
usan los límites fuera de su coordenada; como en la referencia, una consulta NaN
devuelve esa muestra en el caso de un punto. Con más puntos, NaN se propaga. Si
una pendiente da un resultado no finito, se intenta calcular desde el otro extremo;
si ambos valores de muestra son iguales, se conserva su valor común.

## Coordenadas periódicas

```lua
local periodic = lr.interp({0, 90, 360, 450}, {0, 180}, {0, 1}, {period=360})
assert(periodic[1] == 0 and periodic[2] == 0.5)
assert(periodic[3] == 0 and periodic[4] == 0.5)
```

Un periodo escalar real distinto de cero normaliza las coordenadas módulo su valor
absoluto, ordena las muestras y extiende la malla a través del cierre del periodo.
Se ignoran `left` y `right`. Lua acepta números reales o periodos reales tipados
de rango cero.

El orden usa el quicksort portable derivado de NumPy. **Las coordenadas normalizadas
repetidas pueden elegir valores distintos de una distribución NumPy optimizada
para CPU, porque ninguno de los quicksort garantiza empates estables.** El nuevo
corpus contiene68 casos con sort portable;12 difieren del sort CPU predeterminado
de la referencia. Los68 se comprueban con el kernel real de interpolación NumPy
tras su quicksort genérico portable. No se certifica el orden de empates de cada CPU.

## Muestras complejas y conversiones

```lua
local samples = lr.array({lr.complex(0, 1), lr.complex(2, 3)}, "complex64")
local value = lr.interp({0.5}, {0, 1}, samples)
assert(value.dtype == "complex128")
assert(value[1].real == 1 and value[1].imag == 2)
```

Los resultados reales usan float64; las muestras complejas usan complex128. Las
pendientes real e imaginaria se calculan por separado como en la referencia. Los
resultados son escribibles e independientes de consultas, coordenadas y muestras.
Se admiten vistas de solo lectura, invertidas, con strides o broadcasting mediante
conversión tipada. La salida usa orden C.

Sin periodo, las entradas tipadas requieren conversión segura al dtype destino.
Los arrays flotantes extendidos, las consultas/coordenadas complejas y los arrays
temporales pueden fallar. La ruta periódica usa conversiones explícitas como la
referencia y puede aceptar esas entradas. Las entradas Lua ordinarias siguen las
reglas del constructor; no se reproducen todos los protocolos escalares y externos
Python.

## Compatibilidad

Disponible desde **0.133.0-dev**, basada en el dispatcher Python y los kernels
nativos de NumPy 2.5.3. Lua usa una tabla de opciones y salida escalar tipada.
Las referencias numéricas permiten tolerancia absoluta más relativa `2e-12`;
metadatos y estados de entrada/memoria son exactos. Las diferencias de sort
periódico anteriores quedan explícitas. Siguen pendientes object/estructuras,
todo el despacho CPU y la identidad de avisos/excepciones Python. La API es parcial.
