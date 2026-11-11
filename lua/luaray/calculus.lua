-- Finite differences composed from native typed indexing and arithmetic.
return function(lr)
  local function options(value, allowed)
    for key in pairs(value) do
      if not allowed[key] then error('unknown difference option', 3) end
    end
  end
  local function integer(value, name)
    if math.type(value) ~= 'integer' then error(name .. ' must be a Lua integer', 3) end
    return value
  end
  local function slices(nd, axis)
    local right, left = {}, {}
    for d=1,nd do right[d],left[d]=lr.s(),lr.s() end
    right[axis],left[axis]=lr.s(2,nil),lr.s(nil,-1)
    return right,left
  end
  function lr.diff(input, ...)
    local argc=select('#', ...)
    if argc>2 then error('diff accepts input, n and axis, or one options table',2) end
    local n,axis,settings=1,-1,{}
    if argc>0 then
      local first,second=...
      if type(first)=='table' then
        if argc~=1 then error('diff options cannot be combined with positional arguments',2) end
        options(first,{n=true,axis=true,prepend=true,append=true})
        settings=first;n=first.n;axis=first.axis
      else n,axis=first,second end
    end
    if n==nil then n=1 end
    if axis==nil then axis=-1 end
    integer(n,'difference order')
    if n<0 then error('difference order must be nonnegative',2) end
    if n==0 then return input end
    local a=lr.asanyarray(input)
    local nd=a.ndim
    if nd==0 then error('diff requires at least one dimension',2) end
    integer(axis,'axis')
    if axis<0 then axis=nd+axis+1 end
    if axis<1 or axis>nd then error('axis outside one-based range',2) end
    local parts={}
    local function padding(value)
      local array=lr.asanyarray(value)
      if array.ndim==0 then
        local shape=a.shape;shape[axis]=1
        array=lr.broadcast_to(array,shape)
      end
      return array
    end
    if settings.prepend~=nil then parts[#parts+1]=padding(settings.prepend) end
    parts[#parts+1]=a
    if settings.append~=nil then parts[#parts+1]=padding(settings.append) end
    if #parts>1 then a=lr.concatenate(parts,axis) end
    local right,left=slices(nd,axis)
    local operation=a.dtype=='bool' and lr.not_equal or lr.subtract
    for _=1,n do
      a=operation(a:get(table.unpack(right)),a:get(table.unpack(left)))
      -- The empty result's dtype/layout is stable under subsequent differences.
      if a.shape[axis]==0 then return a end
    end
    return a
  end
  function lr.ediff1d(input, ...)
    local argc=select('#', ...)
    if argc>1 then error('ediff1d accepts input and one options table',2) end
    local settings=(...)
    if settings==nil then settings={} end
    if type(settings)~='table' then error('ediff1d options must be a table',2) end
    options(settings,{to_begin=true,to_end=true})
    local a=lr.ravel(lr.asanyarray(input))
    local right,left=a:get(lr.s(2,nil)),a:get(lr.s(nil,-1))
    if settings.to_begin==nil and settings.to_end==nil then return lr.subtract(right,left) end
    local function padding(value)
      if value==nil then return nil,0 end
      local array=lr.ravel(lr.asanyarray(value))
      if not lr.can_cast(array.dtype,a.dtype,'same_kind') then
        error('ediff1d padding dtype is not compatible under same_kind casting',3)
      end
      return array,array.size
    end
    local before,nb=padding(settings.to_begin)
    local after,ne=padding(settings.to_end)
    local count=math.max(a.size-1,0)
    local out=lr.empty_like(a,{shape={nb+count+ne}})
    if nb>0 then out:set(before,lr.s(1,nb+1)) end
    if ne>0 then out:set(after,lr.s(nb+count+1,nil)) end
    lr.subtract(right,left,{out=out:get(lr.s(nb+1,nb+count+1))})
    return out
  end
end
