---
docs_examples: true
---

# Contar días hábiles

`lr.busday_count(first, last, options)` cuenta los días hábiles entre
la fecha inicial y la final. Incluye la inicial y excluye la final.
Los intervalos invertidos devuelven un conteo negativo y también
excluyen la fecha final en el sentido del recorrido.

```lua
local lr = require("luaray")
assert(lr.busday_count("1970-01-01", "1970-01-08") == 5)
assert(lr.busday_count("1970-01-01", "1970-01-04") == 2)
assert(lr.busday_count("1970-01-04", "1970-01-01") == -1)
```

Usa cadenas de fecha ISO o arreglos tipados de días. Dos arreglos
se combinan mediante broadcasting. Pasa `calendar` o indica `weekmask`
y `holidays` directamente. El calendario reutiliza su lista normalizada
de festivos en varias consultas.

```lua
local calendar = lr.busdaycalendar{holidays = {"1970-01-02"}}
local starts = lr.array({"1970-01-01", "1970-01-02"}, "datetime64[D]")
local counts = lr.busday_count(starts, "1970-01-08", {calendar = calendar})
assert(lr.array_equal(counts, {4, 3}))
```

Una consulta escalar devuelve un entero de Lua. Una consulta de arreglos
devuelve un arreglo `intp` salvo que pases un arreglo `out`. Los
extremos NaT y los conteos fuera del rango entero nativo generan un
error. El cálculo nativo omite semanas completas y localiza los
festivos del intervalo mediante búsquedas binarias.
