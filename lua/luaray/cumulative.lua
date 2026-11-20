-- NumPy 2.5.5 _core/fromnumeric.py: Array API cumulative operations.
return function(lr)
  local function cumulative(accumulate, identity, input, options)
    if options==nil then options={} end
    if type(options)~='table' then error('expected a cumulative options table',3) end
    for key in pairs(options) do
      if key~='axis' and key~='dtype' and key~='out' and key~='include_initial' then
        error('unknown cumulative option',3)
      end
    end
    local initial=options.include_initial
    if initial~=nil and type(initial)~='boolean' then
      error('include_initial must be a boolean',3)
    end

    local array=lr.atleast_1d(lr.asanyarray(input))
    local axis=options.axis
    if axis==nil then
      if array.ndim>1 then error('multidimensional input requires an axis',3) end
      axis=1
    end
    if math.type(axis)~='integer' then error('axis must be a Lua integer',3) end
    if axis<0 then axis=array.ndim+axis+1 end
    if axis<1 or axis>array.ndim then error('axis outside one-based range',3) end

    local out=options.out
    local settings={axis=axis,dtype=options.dtype,out=out}
    if not initial then return accumulate(array,settings) end
    if out~=nil then
      if type(out)~='userdata' or not out.shape then error('out must be an ndarray',3) end
      local shape=array.shape
      shape[axis]=shape[axis]+1
      local dest=out.shape
      if #shape~=#dest then error('out has the wrong rank',3) end
      for d=1,#shape do
        if shape[d]~=dest[d] then error('out has the wrong shape',3) end
      end
      local indices={}
      for d=1,#shape do indices[d]=lr.s() end
      indices[axis]=lr.s(2,nil)
      settings.out=out:get(table.unpack(indices))
      accumulate(array,settings)
      indices[axis]=1
      out:set(identity,table.unpack(indices))
      return out
    end

    local result=accumulate(array,settings)
    local shape=result.shape
    shape[axis]=1
    local prefix=lr.full_like(result,identity,{shape=shape})
    return lr.concatenate({prefix,result},axis)
  end

  function lr.cumulative_sum(input,options)
    return cumulative(lr.add_accumulate,0,input,options)
  end

  function lr.cumulative_prod(input,options)
    return cumulative(lr.multiply_accumulate,1,input,options)
  end
end
