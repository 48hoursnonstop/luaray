---
docs_examples: true
---
# LuaRay

**Arrays tipados y cómputo numérico para Lua 5.4.**

Crea arrays multidimensionales, combina formas con broadcasting y calcula con
kernels nativos C/C++. LuaRay incluye matemáticas reales y complejas, vistas,
FFT, álgebra lineal y generación de números aleatorios.

**[Primeros pasos →](getting-started.md)** · [Fundamentos de arrays](arrays.md) · [Referencia de API](creation.md)

## Un ejemplo pequeño

```lua
local lr = require("luaray")

local samples = lr.array({{1, 2, 3}, {4, 5, 6}}, "float64")
local totals = lr.sum(samples, 2)
assert(totals[1] == 6 and totals[2] == 15)

local shifted = samples + lr.array({10, 20, 30})
assert(shifted:get(2, 3) == 36)
```

Los índices y ejes positivos empiezan en **1**. Las funciones conservan nombres
numéricos familiares; la [guía de arrays](arrays.md) explica cómo se usan desde Lua.

## Continúa por aquí

- **¿Empiezas con LuaRay?** [Compila y ejecuta tu primer programa](getting-started.md).
- **¿Trabajas con datos?** Aprende [formas, índices y broadcasting](arrays.md).
- **¿Buscas una operación?** Usa la referencia del menú lateral o busca su nombre.
- **¿Vienes de NumPy?** Consulta [disponibilidad y límites de API](api_inventory.md).

::: info Versión de desarrollo · 0.157.0-dev
LuaRay usa NumPy 2.5.3 como referencia principal. La compatibilidad depende de la
operación y del dtype. El [inventario](api_inventory.md) registra nombres disponibles
y funciones pendientes; las APIs disponibles siguen clasificadas como parciales.
:::
