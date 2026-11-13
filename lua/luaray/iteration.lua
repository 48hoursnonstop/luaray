-- NumPy 2.5.3 _index_tricks_impl.py:ndindex, expressed as a lazy Lua iterator.
-- Coordinates are one-based Lua positions. Every yield is an independent table.
return function(lr)
  function lr.ndindex(...)
    local argc=select('#',...)
    local first=...
    local from_table=argc==1 and type(first)=='table'
    local n=from_table and #first or argc
    if from_table then
      for key in pairs(first) do
        if math.type(key)~='integer' or key<1 or key>n then
          error('ndindex shape must be a dense dimension table',2)
        end
      end
    end
    local shape,coordinate={},{}
    local finished=false
    for axis=1,n do
      local value
      if from_table then value=first[axis] else value=select(axis,...) end
      if type(value)=='boolean' then value=value and 1 or 0 end
      if math.type(value)~='integer' then error('ndindex dimensions must be Lua integers or Booleans',2) end
      if value<0 then error('negative dimensions are not allowed',2) end
      shape[axis]=value;coordinate[axis]=1
      if value==0 then finished=true end
    end
    return function()
      if finished then return nil end
      local result={}
      for axis=1,n do result[axis]=coordinate[axis] end
      local axis=n
      while axis>0 and coordinate[axis]==shape[axis] do
        coordinate[axis]=1;axis=axis-1
      end
      if axis==0 then finished=true else coordinate[axis]=coordinate[axis]+1 end
      return result
    end
  end
end
