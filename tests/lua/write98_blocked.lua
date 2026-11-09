local np=require('luaray_core')
local data=dofile('tests/lua/write98_blocked_reference.lua')
for _,case in ipairs(data) do
  local ok,err=pcall(function() return np.array(case.initial,case.dtype) end)
  assert(not ok and tostring(err):find('unsupported dtype',1,true),
    case.label..': byte-order prerequisite changed; review original reference and classification')
end
print(('write98: %d original states remain BLOCKED by numeric byte-order descriptors; excluded from parity'):format(#data))
