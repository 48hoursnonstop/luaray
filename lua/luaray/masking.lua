-- High-level Lua composition of the native creation/comparison/index kernels.
return function(lr)
  local intp = string.packsize('T') == 8 and 'int64' or 'int32'
  function lr.mask_indices(n, mask_function, ...)
    if math.type(n) ~= 'integer' then error('mask_indices size must be a Lua integer', 2) end
    local argc = select('#', ...)
    if argc > 1 then error('mask_indices accepts size, callback and optional k', 2) end
    local k = 0
    if argc == 1 then k = (...) end
    local produced = mask_function(lr.ones({n, n}, intp), k)
    local values = lr.asarray(produced)
    local dtype = values.dtype
    local mask
    -- ndarray rich comparison differs from the not_equal ufunc for text/time.
    if dtype:find('datetime64', 1, true) == 1 or dtype:match('^[|<>=][SU]') then
      mask = lr.ones(values.shape, 'bool')
    elseif dtype:find('timedelta64', 1, true) == 1 then
      mask = lr.not_equal(lr.astype(values, 'int64'), 0)
    else
      mask = lr.not_equal(values, 0)
    end
    return lr.nonzero(mask)
  end
end
