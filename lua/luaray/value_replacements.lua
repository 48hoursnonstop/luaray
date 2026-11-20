-- NumPy 2.5.5 type checks, piecewise evaluation and numeric aliases.
return function(lr)
  local function finite_replacements(destination,nan,positive,negative)
    local missing=lr.isnan(destination)
    local hi=lr.isposinf(destination)
    local lo=lr.isneginf(destination)
    lr.copyto(destination,nan,'same_kind',missing)
    lr.copyto(destination,positive,'same_kind',hi)
    lr.copyto(destination,negative,'same_kind',lo)
  end

  function lr.nan_to_num(input,options)
    if options==nil then options={} end
    if type(options)~='table' then error('nan_to_num options must be a table',2) end
    for key,value in pairs(options) do
      if key=='copy' then
        if type(value)~='boolean' then error('copy must be boolean',2) end
      elseif key~='nan' and key~='posinf' and key~='neginf' then
        error('unknown nan_to_num option',2)
      end
    end
    local x=lr.array(input,{copy=options.copy~=false})
    local kind=lr.dtype(x.dtype).kind
    if kind=='f' or kind=='c' then
      local real=lr.real(x)
      local limits=lr.finfo(real.dtype)
      local nan,positive,negative=options.nan,options.posinf,options.neginf
      if nan==nil then nan=0.0 end
      if positive==nil then positive=limits.max end
      if negative==nil then negative=limits.min end
      finite_replacements(real,nan,positive,negative)
      if kind=='c' then finite_replacements(lr.imag(x),nan,positive,negative) end
    end
    if x.ndim==0 then return x:item() end
    return x
  end

  local function ndarray(value)
    return type(value)=='userdata' and value.ndim~=nil
  end

  local function condition_list(settings,rank)
    if ndarray(settings) and (settings.ndim>1 or (rank==0 and settings.ndim>0)) then
      local list={}
      for i=1,settings.shape[1] do list[i]=settings[i] end
      return list
    end
    if type(settings)=='table' then
      if #settings==0 then error('piecewise needs at least one condition',3) end
      local first=settings[1]
      if rank==0 or type(first)=='table' or ndarray(first) then return settings end
    end
    return {settings}
  end

  local function callable(value)
    if type(value)=='function' then return true end
    local mt=getmetatable(value)
    return type(mt)=='table' and type(mt.__call)=='function'
  end

  function lr.piecewise(input,conditions,functions,...)
    local x=lr.asanyarray(input)
    local list=condition_list(conditions,x.ndim)
    if type(functions)~='table' or #list==0 or (#functions~=#list and #functions~=#list+1) then
      error('piecewise needs one function per condition and optionally one default',2)
    end
    local masks,shape={}
    for i,condition in ipairs(list) do
      local mask=lr.array(condition,{dtype='bool',copy=true})
      local dims=mask.shape
      if shape then
        if #shape~=#dims then error('piecewise condition shapes differ',2) end
        for j,n in ipairs(dims) do
          if n~=shape[j] then error('piecewise condition shapes differ',2) end
        end
      end
      shape=dims
      masks[i]=mask
    end
    if #functions==#masks+1 then
      local covered=lr.copy(masks[1])
      for i=2,#masks do lr.logical_or(covered,masks[i],{out=covered}) end
      lr.logical_not(covered,{out=covered})
      masks[#masks+1]=covered
    end
    local result=lr.zeros_like(x)
    for i,mask in ipairs(masks) do
      local f=functions[i]
      if callable(f) then
        local values=x:get(mask)
        if values.size>0 then result:set(f(values,...),mask) end
      else
        result:set(f,mask)
      end
    end
    return result
  end

  function lr.fix(input,out)
    if out==nil then return lr.trunc(input) end
    return lr.trunc(input,{out=out})
  end

  lr.pow=lr.power
end
