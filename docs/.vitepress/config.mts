import { defineConfig } from 'vitepress'

const repo = 'https://github.com/48hoursnonstop/luaray'
const pages = [
  ['Start here', 'Empieza aquí', [
    ['Overview', 'Introducción', ''],
    ['Getting started', 'Primeros pasos', 'getting-started'],
    ['Array fundamentals', 'Fundamentos de arrays', 'arrays'],
    ['Dtype descriptors', 'Descriptores dtype', 'dtypes'],
    ['Shape and size queries', 'Consultas de forma y tamaño', 'metadata'],
  ]],
  ['Arrays and memory', 'Arrays y memoria', [
    ['Creation and copying', 'Creación y copias', 'creation'],
    ['Array constructor', 'Constructor de arrays', 'ndarray'],
    ['Shape and layout', 'Forma y disposición', 'layout'],
    ['Resizing arrays', 'Cambiar tamaño de arrays', 'resize'],
    ['Indexing and assignment', 'Índices y asignación', 'writing'],
    ['Coordinate grids and locations', 'Rejillas y posiciones', 'index_grids'],
    ['Arrays from a callback', 'Arrays desde callbacks', 'fromfunction'],
    ['Masked writes', 'Escrituras con máscara', 'masked_writes'],
    ['Gathering values', 'Extracción por índices', 'take'],
    ['Along an axis', 'Operaciones por eje', 'along_axis'],
    ['Choosing values', 'Selección con choose', 'choose'],
    ['Conditions and extraction', 'Condiciones y extracción', 'condition_selection'],
    ['Selection and broadcasting', 'Selección y broadcasting', 'selection'],
    ['Typed views and bytes', 'Vistas tipadas y bytes', 'byte_views'],
    ['Swapping bytes', 'Intercambiar bytes', 'byteswap'],
    ['Per-item byte fields', 'Campos de bytes por elemento', 'fields'],
    ['Elements and filling', 'Elementos y relleno', 'elements'],
    ['Existing buffers', 'Buffers existentes', 'buffers'],
    ['Memory flags', 'Flags de memoria', 'flags'],
    ['Memory requirements', 'Requisitos de memoria', 'requirements'],
  ]],
  ['Mathematics', 'Matemáticas', [
    ['Unary operations', 'Operaciones unarias', 'unary_math'],
    ['Binary operations', 'Operaciones binarias', 'binary_math'],
    ['Real and imaginary parts', 'Partes real e imaginaria', 'components'],
    ['Comparing values', 'Comparación de valores', 'reality'],
    ['Equality and tolerances', 'Igualdad y tolerancias', 'comparison'],
    ['Rounding', 'Redondeo', 'rounding'],
    ['Clipping', 'Recorte de valores', 'clip'],
    ['Sequences and sampling', 'Secuencias y muestreo', 'sampling'],
    ['Numeric ranges', 'Rangos numéricos', 'arange'],
    ['Date and duration ranges', 'Rangos de fechas y duraciones', 'temporal_ranges'],
    ['Finite differences', 'Diferencias finitas', 'differences'],
    ['Numerical gradients', 'Gradientes numéricos', 'gradient'],
    ['Trapezoidal integration', 'Integración trapezoidal', 'integration'],
    ['Linear interpolation', 'Interpolación lineal', 'interpolation'],
    ['Phases and angles', 'Fases y ángulos', 'phase'],
    ['FFT helpers', 'Funciones FFT', 'fft_helpers'],
    ['Vectors and grids', 'Vectores y mallas', 'vectors_and_grids'],
    ['Diagonals and matrices', 'Diagonales y matrices', 'matrices'],
    ['Matrix traces', 'Trazas de matrices', 'trace'],
    ['Triangular matrices', 'Matrices triangulares', 'triangles'],
    ['Vandermonde matrices', 'Matrices de Vandermonde', 'vander'],
    ['Identity matrices', 'Matrices identidad', 'eye'],
    ['Diagonal indices', 'Índices diagonales', 'diag_indices'],
    ['Callback masks', 'Máscaras con callbacks', 'mask_indices'],
    ['Fill a diagonal', 'Rellenar una diagonal', 'fill_diagonal'],
    ['Kronecker product', 'Producto de Kronecker', 'kron'],
    ['Tensor contractions', 'Contracciones tensoriales', 'tensordot'],
    ['Scale durations', 'Escalar duraciones', 'temporal_scaling'],
  ]],
  ['Compatibility', 'Compatibilidad', [
    ['API availability', 'Disponibilidad de APIs', 'api_inventory'],
    ['Numerical portability', 'Portabilidad numérica', 'portability'],
  ]],
] as const

function sidebar(spanish = false) {
  const prefix = spanish ? '/es/' : '/'
  return [
    ...pages.map(([en, es, items], group) => ({
      text: spanish ? es : en,
      ...(group > 0 ? { collapsed: group > 1 } : {}),
      items: items.map(([en, es, path]) => ({ text: spanish ? es : en, link: prefix + path })),
    })),
    {
      text: spanish ? 'Desarrollo' : 'Development', collapsed: true,
      items: [
        { text: spanish ? 'Compilación y contribuciones' : 'Build and contribute', link: prefix + 'development/contributing' },
        { text: spanish ? 'Verificación' : 'Validation', link: prefix + 'development/validation' },
        { text: spanish ? 'Referencias y licencias' : 'Upstream and licenses', link: prefix + 'development/upstream' },
      ],
    },
  ]
}

export default defineConfig({
  title: 'LuaRay',
  description: 'Typed arrays and numerical computing for Lua 5.4.',
  base: '/luaray/',
  cleanUrls: true,
  srcExclude: ['README.md'],
  head: [['link', { rel: 'icon', type: 'image/svg+xml', href: '/luaray/logo.svg' }]],
  sitemap: { hostname: 'https://48hoursnonstop.github.io/luaray/' },
  markdown: { lineNumbers: true },
  locales: {
    root: {
      label: 'English', lang: 'en',
      themeConfig: {
        nav: [
          { text: 'Guide', link: '/getting-started' },
          { text: 'Reference', link: '/creation' },
          { text: '0.150.0-dev', link: `${repo}/releases/tag/v0.150.0-dev` },
        ],
        sidebar: sidebar(),
      },
    },
    es: {
      label: 'Español', lang: 'es', description: 'Arrays tipados y cómputo numérico para Lua 5.4.',
      themeConfig: {
        nav: [
          { text: 'Guía', link: '/es/getting-started' },
          { text: 'Referencia', link: '/es/creation' },
          { text: '0.150.0-dev', link: `${repo}/releases/tag/v0.150.0-dev` },
        ],
        sidebar: sidebar(true),
        outline: { label: 'En esta página', level: [2, 3] },
        docFooter: { prev: 'Anterior', next: 'Siguiente' },
        sidebarMenuLabel: 'Contenido', returnToTopLabel: 'Volver arriba',
        darkModeSwitchLabel: 'Apariencia', lightModeSwitchTitle: 'Usar tema claro',
        darkModeSwitchTitle: 'Usar tema oscuro', langMenuLabel: 'Cambiar idioma',
        skipToContentLabel: 'Ir al contenido',
        editLink: { pattern: `${repo}/edit/main/docs/:path`, text: 'Editar esta página en GitHub' },
      },
    },
  },
  themeConfig: {
    logo: '/logo.svg',
    outline: { level: [2, 3] },
    socialLinks: [{ icon: 'github', link: repo }],
    editLink: { pattern: `${repo}/edit/main/docs/:path`, text: 'Edit this page on GitHub' },
    search: {
      provider: 'local',
      options: {
        locales: {
          es: { translations: {
            button: { buttonText: 'Buscar', buttonAriaLabel: 'Buscar en la documentación' },
            modal: {
              displayDetails: 'Mostrar detalles', resetButtonTitle: 'Limpiar búsqueda',
              backButtonTitle: 'Cerrar búsqueda', noResultsText: 'Sin resultados para',
              footer: { selectText: 'seleccionar', navigateText: 'navegar', closeText: 'cerrar' },
            },
          } },
        },
      },
    },
  },
})
