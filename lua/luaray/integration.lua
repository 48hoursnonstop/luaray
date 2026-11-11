-- NumPy2.5.3 _function_base_impl.py:trapezoid; native typed composition.
return function(lr)
  function lr.trapezoid(input,...)
    if select('#',...)>1 then error('trapezoid accepts input and one options table',2) end
    local options=(...);if options==nil then options={} end
    if type(options)~='table' then error('trapezoid options must be a table',2) end
    for key in pairs(options)do
      if key~='x' and key~='dx' and key~='axis' then error('unknown trapezoid option',2) end
    end
    local y=lr.asanyarray(input);local nd=y.ndim
    local axis=options.axis;if axis==nil then axis=-1 end
    if math.type(axis)~='integer' then error('trapezoid axis must be a Lua integer',2) end
    local requested_axis=axis
    if axis<0 then axis=nd+axis+1 end
    if axis<1 or axis>nd then error('invalid trapezoid axis',2) end
    local d=options.dx;if d==nil then d=1.0 end
    if options.x~=nil then
      local x=lr.asanyarray(options.x)
      if x.ndim==1 then
        d=lr.diff(x)
        local shape={};for i=1,nd do shape[i]=i==axis and d.shape[1] or 1 end
        d=d:reshape(shape)
      else d=lr.diff(x,{axis=requested_axis}) end
    end
    local first,last={},{}
    for i=1,nd do first[i],last[i]=lr.s(),lr.s() end
    first[axis]=lr.s(2,nil);last[axis]=lr.s(nil,-1)
    local pairs=lr.add(y:get(table.unpack(first)),y:get(table.unpack(last)))
    local areas=lr.true_divide(lr.multiply(d,pairs),2.0)
    -- Keep rank-zero results as arrays, preserving dtype/temporal raw ticks.
    local out;local keep=areas.ndim==1
    if areas.dtype:find('timedelta64',1,true)==1 then
      local ticks=areas:view('int64')
      out=lr.sum(ticks,{axis=requested_axis,keepdims=keep})
      local missing=lr.any(lr.isnat(areas),{axis=requested_axis,keepdims=keep})
      lr.copyto(out,lr.array(math.mininteger,'int64'),'no',missing)
      out=out:view(areas.dtype)
    else out=lr.sum(areas,{axis=requested_axis,keepdims=keep}) end
    if keep then return out:reshape({}) end
    return out
  end
end
