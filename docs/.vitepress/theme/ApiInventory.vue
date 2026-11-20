<script setup>
import { computed, ref, watch } from 'vue'
import { useData } from 'vitepress'
import inventory from '../../../compatibility/api_inventory.json'

const { lang } = useData()
const labels = computed(() => lang.value === 'es'
  ? {
      search: 'Buscar una función o método', status: 'Disponibilidad',
      all: 'Todos los nombres', partial: 'Disponible (parcial)', missing: 'Sin binding',
      adapted: 'Adaptación Lua', previous: 'Anterior', next: 'Siguiente',
      count: (first, last, total) => total ? `${first}–${last} de ${total} nombres` : 'Sin resultados',
    }
  : {
      search: 'Find a function or method', status: 'Availability',
      all: 'All names', partial: 'Available (partial)', missing: 'No binding',
      adapted: 'Lua adaptation', previous: 'Previous', next: 'Next',
      count: (first, last, total) => total ? `${first}–${last} of ${total} names` : 'No results',
    })
const statuses = {
  implemented_partial: 'partial',
  not_implemented: 'missing',
  not_applicable_to_lua: 'adapted',
}
const entries = inventory.entries.map(entry => {
  const prefix = { module: 'lr.', array: 'array:', generator: 'rng:' }[entry.prototype]
  const lua = entry.lua_callable_available ? prefix + entry.path.join('.') : ''
  return { ...entry, lua, search: `${entry.api} ${lua}`.toLowerCase() }
})

const query = ref('')
const status = ref('')
const page = ref(0)
const pageSize = 24
const matches = computed(() => entries.filter(entry =>
  (!status.value || entry.status === status.value) &&
  entry.search.includes(query.value.trim().toLowerCase()),
))
const start = computed(() => page.value * pageSize)
const end = computed(() => Math.min(start.value + pageSize, matches.value.length))
watch([query, status], () => { page.value = 0 })
</script>

<template>
  <div class="inventory">
    <div class="inventory-controls">
      <label>
        {{ labels.search }}
        <input v-model="query" type="search" placeholder="lr.busday_count">
      </label>
      <label>
        {{ labels.status }}
        <select v-model="status">
          <option value="">{{ labels.all }}</option>
          <option v-for="(label, value) in statuses" :key="value" :value="value">
            {{ labels[label] }}
          </option>
        </select>
      </label>
    </div>
    <div class="inventory-controls">
      <span aria-live="polite">{{ labels.count(start + 1, end, matches.length) }}</span>
      <button type="button" :disabled="!page" @click="page--">{{ labels.previous }}</button>
      <button type="button" :disabled="end === matches.length" @click="page++">{{ labels.next }}</button>
    </div>
    <table v-if="matches.length">
      <thead>
        <tr><th scope="col">NumPy</th><th scope="col">LuaRay</th><th scope="col">{{ labels.status }}</th></tr>
      </thead>
      <tbody>
        <tr v-for="entry in matches.slice(start, end)" :key="entry.api">
          <td><code>{{ entry.api }}</code></td>
          <td><code v-if="entry.lua">{{ entry.lua }}</code><span v-else>—</span></td>
          <td>{{ labels[statuses[entry.status]] }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<style scoped>
.inventory-controls {
  display: flex;
  flex-wrap: wrap;
  align-items: end;
  gap: 8px 16px;
  margin: 12px 0;
}
.inventory-controls label {
  display: grid;
  gap: 4px;
}
.inventory-controls input,
.inventory-controls select,
.inventory-controls button {
  border: 1px solid var(--vp-c-divider);
  border-radius: 6px;
  background: var(--vp-c-bg-soft);
  padding: 6px 10px;
}
.inventory-controls button:disabled {
  color: var(--vp-c-text-3);
  cursor: default;
}
</style>
