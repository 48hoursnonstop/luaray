import { readdirSync, readFileSync, mkdtempSync, writeFileSync, rmSync } from 'node:fs'
import { resolve, dirname } from 'node:path'
import { fileURLToPath } from 'node:url'
import { tmpdir } from 'node:os'
import { spawnSync } from 'node:child_process'

const root = resolve(dirname(fileURLToPath(import.meta.url)), '../..')
const temp = mkdtempSync(resolve(tmpdir(), 'luaray-docs-'))
let pages = 0
let blocks = 0
try {
  for (const folder of ['docs', 'docs/es']) {
    for (const name of readdirSync(resolve(root, folder)).filter(name => name.endsWith('.md'))) {
      const source = readFileSync(resolve(root, folder, name), 'utf8')
      if (!/^docs_examples: true$/m.test(source)) continue
      const snippets = [...source.matchAll(/^```lua\s*\n([\s\S]*?)^```/gm)]
      if (!snippets.length) throw new Error(`No Lua examples in ${folder}/${name}`)
      const program = resolve(temp, 'example.lua')
      writeFileSync(program, snippets.map(match => match[1]).join('\n'))
      const result = spawnSync('lua5.4', [program], {
        cwd: root, encoding: 'utf8',
        env: { ...process.env, LUA_PATH: './lua/?.lua;;', LUA_CPATH: './build/?.so;;' },
      })
      if (result.error) throw result.error
      if (result.status !== 0) throw new Error(`${folder}/${name}: ${result.stderr}`)
      console.log(`Passed ${folder}/${name}: ${snippets.length} Lua blocks`)
      pages++
      blocks += snippets.length
    }
  }
  if (!pages) throw new Error('No executable documentation pages found')
  console.log(`Passed ${blocks} Lua blocks across ${pages} documentation pages`)
} finally {
  rmSync(temp, { recursive: true, force: true })
}
