-- NumPy 2.5.3 _shape_base_impl.py:apply_over_axes, with Lua scalar coercion.
return function(lr)
  function lr.apply_over_axes(callback,input,axes)
    local value=lr.asarray(input)
    local rank=value.ndim
    if axes==nil then error('axes are required',2) end
    if type(axes)~='table' then axes={axes} end
    local count=rawlen(axes)
    for key in pairs(axes) do
      if math.type(key)~='integer' or key<1 or key>count then
        error('axes must be a dense Lua dimension sequence',2)
      end
    end
    for i=1,count do
      local axis=axes[i]
      if math.type(axis)~='integer' or axis==0 then error('axis must be a nonzero Lua integer',2) end
      if axis<0 then
        -- Upstream normalizes once before calling the user function. A still
        -- negative value must remain negative for that function to interpret.
        local normalized=rank+axis
        axis=normalized>=0 and normalized+1 or normalized
      end
      local result=lr.asanyarray(callback(value,axis))
      if result.ndim~=value.ndim then
        result=lr.expand_dims(result,axis)
        if result.ndim~=value.ndim then error('function is not returning an array of the correct rank',2) end
      end
      value=result
    end
    return value
  end
end
