-- NumPy 2.5.3 numeric.py:indices/argwhere and _index_tricks_impl.py:ix_.
-- Coordinate grids retain numerical values starting at zero; index locations
-- from nonzero/argwhere follow LuaRay's existing one-based indexing contract.
return function(lr)
  local array_mt=getmetatable(lr.empty({0},'intp'))
  local function is_array(value)
    return type(value)=='userdata' and getmetatable(value)==array_mt
  end
  local function sequence(value)
    if type(value)~='table' then error('dimensions must be a dense integer table',3) end
    local n=#value
    if n>64 then error('maximum supported dimension is 64',3) end
    for key in pairs(value) do
      if math.type(key)~='integer' or key<1 or key>n then error('dimensions must be a dense integer table',3) end
    end
    local shape={}
    for i=1,n do
      if math.type(value[i])~='integer' then error('dimensions must be Lua integers',3) end
      shape[i]=value[i]
    end
    return shape,n
  end
  function lr.indices(dimensions,dtype,options,...)
    if select('#',...)>0 then error('indices expects dimensions, dtype and options',2) end
    if type(dtype)=='table' then
      if options~=nil then error('duplicate indices options',2) end
      options=dtype;dtype=nil
    end
    if options~=nil and type(options)~='table' then error('indices options must be a table',2) end
    options=options or {}
    for key in pairs(options) do
      if key~='dtype' and key~='sparse' then error('unknown indices option',2) end
    end
    if options.dtype~=nil then
      if dtype~=nil then error('duplicate indices dtype',2) end
      dtype=options.dtype
    end
    if dtype==nil then dtype='intp' end
    local sparse=options.sparse
    if sparse~=nil and type(sparse)~='boolean' then error('sparse must be a Boolean',2) end
    local dimensions,n=sequence(dimensions)
    local result
    if sparse then result={}
    else
      local shape={n}
      for i=1,n do shape[i+1]=dimensions[i] end
      result=lr.empty(shape,dtype)
    end
    for axis=1,n do
      local shape={}
      for i=1,n do shape[i]=i==axis and dimensions[i] or 1 end
      -- The options form selects source arange rather than the historical
      -- LuaRay stop/positional-dtype conversion helper.
      local grid=lr.arange(dimensions[axis],{dtype=dtype}):reshape(shape)
      result[axis]=grid
    end
    return result
  end
  function lr.ix_(...)
    local n=select('#',...)
    if n>64 then error('index mesh exceeds maximum rank 64',2) end
    local result={}
    for axis=1,n do
      local input=select(axis,...)
      local typed=is_array(input)
      local value=typed and input or lr.asarray(input)
      if not typed and value.size==0 then value=lr.astype(value,'intp') end
      if value.ndim~=1 then error('cross index must be one-dimensional',2) end
      if lr.dtype(value.dtype).kind=='b' then value=lr.nonzero(value)[1] end
      local shape={}
      for i=1,n do shape[i]=i==axis and value.size or 1 end
      result[axis]=value:reshape(shape)
    end
    return result
  end
  function lr.argwhere(...)
    if select('#',...)~=1 then error('argwhere expects one input',2) end
    local input=...
    if input==nil then input=false end -- Lua nil / NumPy None is a false scalar.
    local a=lr.asarray(input)
    if a.ndim==0 then
      local coordinates=lr.argwhere(lr.atleast_1d(a))
      return coordinates:get(lr.s(),lr.s(1,1))
    end
    local coordinates=lr.nonzero(a)
    return lr.transpose(lr.ascontiguousarray(lr.stack(coordinates,1)))
  end
end
