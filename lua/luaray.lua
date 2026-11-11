-- Public LuaRay entry point. Runtime is entirely Lua + native luaray_core; no Python.
local lr = require("luaray_core")
require("luaray.masking")(lr)
require("luaray.calculus")(lr)
require("luaray.gradient")(lr)
require("luaray.integration")(lr)
return lr
