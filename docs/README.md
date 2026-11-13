# LuaRay documentation

Read the **[documentation website](https://48hoursnonstop.github.io/luaray/)**:
search, topic navigation, an outline on each page, and English/Spanish guides.

- [Get started](getting-started.md) · [Primeros pasos](es/getting-started.md)
- [Array fundamentals](arrays.md) · [Fundamentos de arrays](es/arrays.md)
- [Reference](creation.md) · [Referencia](es/creation.md)

The Markdown files here are the editable sources. To preview the site:

```sh
cd docs
npm ci
npm run dev
```

Node.js is needed only to work on the documentation website. The numerical
library keeps its native build dependencies. Generated site files and dependencies
are ignored by Git; GitHub Actions builds and deploys the site to Pages.

Lua examples use `local lr = require("luaray")` consistently with the project README.
