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

  function lr.ndenumerate(input)
    local array=lr.asanyarray(input)
    local coordinates=lr.ndindex(array.shape)
    return function()
      local coordinate=coordinates()
      if coordinate then return coordinate,array:item(coordinate) end
    end
  end

  function lr.broadcast(...)
    local args=table.pack(...)
    local views=lr.broadcast_arrays(table.unpack(args,1,args.n))
    local first=views[1]
    local shape,size={},1
    if first then shape,size=first.shape,first.size end
    local coordinates,count=lr.ndindex(shape),0
    local function reset()
      coordinates,count=lr.ndindex(shape),0
    end
    local function advance()
      local coordinate=coordinates()
      if not coordinate then return nil end
      local operands={}
      for i,array in ipairs(views) do operands[i]=array:item(coordinate) end
      count=count+1
      return operands
    end
    local properties={size=size,nd=#shape,ndim=#shape,numiter=#views,
                      reset=reset,next=advance}
    return setmetatable({},{
      __call=advance,
      __index=function(_,key)
        if key=='index' then return count end
        if key=='shape' then return {table.unpack(shape)} end
        return properties[key]
      end,
      __newindex=function() error('broadcast properties are read-only',2) end,
    })
  end
end
