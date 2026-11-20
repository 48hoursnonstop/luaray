---
docs_examples: true
---

# Calendarios de días hábiles

`lr.busdaycalendar(options)` describe los días de la semana y festivos
que se usan en los cálculos de días hábiles. De lunes a viernes son
hábiles por defecto. `weekmask` acepta siete booleanos, una cadena de
siete ceros y unos o abreviaturas de días en inglés desde `Mon`
para el lunes. `holidays` acepta un vector de fechas en días.

```lua
local lr = require("luaray")
local calendar = lr.busdaycalendar{
  weekmask = "Mon Tue Wed Thu Fri",
  holidays = {"2026-11-16", "2026-11-16", "2026-11-14"}
}
assert(calendar.holidays.size == 1)
assert(calendar.weekmask[1] and not calendar.weekmask[6])
```

Los calendarios son inmutables. Sus propiedades `weekmask` y `holidays`
devuelven copias. Los festivos se ordenan, se eliminan los duplicados
y se quitan NaT y los días de la semana que ya estaban excluidos.

```lua
local dates = lr.array({"2026-11-14", "2026-11-16", "2026-11-17"}, "datetime64[D]")
local valid = lr.is_busday(dates, {calendar = calendar})
assert(lr.array_equal(valid, {false, false, true}))
assert(not lr.is_busday("NaT"))
```

`lr.is_busday(dates, options)` acepta arreglos de días, cadenas Lua
con fechas y números de día. Pasa un calendario o indica
`weekmask` y `holidays` directamente. Las consultas escalares
devuelven un booleano. Un arreglo modificable `out` puede recibir
los resultados de broadcasting.
