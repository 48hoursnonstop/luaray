-- NumPy 2.5.3 _shape_base_impl.py:apply_along_axis.
return function(lr)
  function lr.apply_along_axis(callback,axis,input,...)
    local a=lr.asanyarray(input)
    if math.type(axis)~='integer' then error('axis must be a Lua integer',2) end
    local nd=a.ndim
    if axis<0 then axis=nd+axis+1 end
    if axis<1 or axis>nd then error('axis is out of bounds for input rank',2) end
    local view=lr.moveaxis(a,axis,-1)
    local shape=view.shape
    local iteration_shape={}
    for i=1,nd-1 do iteration_shape[i]=shape[i] end
    local iterator=lr.ndindex(iteration_shape)
    local first_position=iterator()
    if first_position==nil then error('cannot apply along an axis with empty iteration dimensions',2) end
    local parameters=table.pack(...)
    local function evaluate(position)
      local indices={}
      for i=1,nd-1 do indices[i]=position[i] end
      indices[nd]=lr.s()
      local slice=view:get(table.unpack(indices,1,nd))
      local result=callback(slice,table.unpack(parameters,1,parameters.n))
      return lr.asanyarray(result)
    end
    local first=evaluate(first_position)
    local buffer_shape={}
    for i=1,nd-1 do buffer_shape[i]=iteration_shape[i] end
    local result_shape=first.shape
    for i=1,first.ndim do buffer_shape[nd-1+i]=result_shape[i] end
    local buffer=lr.zeros_like(first,{shape=buffer_shape})
    buffer:set(first,table.unpack(first_position,1,nd-1))
    for position in iterator do
      buffer:set(evaluate(position),table.unpack(position,1,nd-1))
    end
    local permutation={}
    local iteration_rank=nd-1
    for i=1,axis-1 do permutation[#permutation+1]=i end
    for i=iteration_rank+1,buffer.ndim do permutation[#permutation+1]=i end
    for i=axis,iteration_rank do permutation[#permutation+1]=i end
    return lr.transpose(buffer,permutation)
  end
end
