-- NumPy 2.5.5 _arraysetops_impl.py, using stable typed ordering and gathers.
return function(lr)
  local allowed={
    axis=true,return_index=true,return_inverse=true,return_counts=true,
    equal_nan=true,sorted=true
  }
  local function options(value)
    if value==nil then return {} end
    if type(value)~='table' then error('unique options must be a table',3) end
    for key,option in pairs(value) do
      if not allowed[key] then error('unknown unique option',3) end
      if key~='axis' and type(option)~='boolean' then
        error(key..' must be a boolean',3)
      end
    end
    return value
  end

  local function axis_rows(a,axis)
    local moved=lr.moveaxis(a,axis,1)
    local shape=moved.shape
    local width=shape[1]==0 and 0 or moved.size//shape[1]
    return moved,lr.reshape(moved,{shape[1],width})
  end

  local function empty_shape_view(buffer,shape)
    local strides={}
    local step=buffer.itemsize
    for i=#shape,1,-1 do
      strides[i]=step
      local extent=math.max(shape[i],1)
      if step>math.maxinteger//extent then error('unique layout exceeds native range',3) end
      step=step*extent
    end
    return lr.ndarray(shape,{dtype=buffer.dtype,buffer=buffer,strides=strides})
  end

  local function mark_groups(sorted,rows,equal_nan)
    local count=sorted.shape[1]
    local flags=lr.ones({count},'bool')
    if count<2 then return flags end

    local selectors=rows and {lr.s(2,nil),lr.s()} or {lr.s(2,nil)}
    local right=sorted:get(table.unpack(selectors))
    selectors[1]=lr.s(nil,-1)
    local left=sorted:get(table.unpack(selectors))
    local different=lr.not_equal(right,left)
    if rows then
      different=lr.any(different,{axis=2})
    elseif equal_nan then
      local kind=lr.dtype(sorted.dtype).kind
      local check_missing=kind:match('[mM]') and lr.isnat
        or kind:match('[fc]') and lr.isnan
      if check_missing then
        local both=lr.logical_and(check_missing(left),check_missing(right))
        different=lr.logical_and(different,lr.logical_not(both))
      end
    end
    lr.copyto(flags:get(lr.s(2,nil)),different)
    return flags
  end

  local function row_order(keys)
    local columns=lr.unstack(lr.flip(lr.transpose(keys),1))
    if keys.dtype~='float16' then return lr.lexsort(columns) end
    -- The structured comparison used by NumPy's axis path puts half NaNs
    -- before all numbers, while ordinary float16 lexsort puts them last.
    local layered={}
    for _,column in ipairs(columns) do
      layered[#layered+1]=column
      layered[#layered+1]=lr.logical_not(lr.isnan(column))
    end
    return lr.lexsort(layered)
  end

  function lr.unique(input,config)
    config=options(config)
    local a=lr.asanyarray(input)
    local axis=config.axis
    if axis~=nil then
      if math.type(axis)~='integer' then error('unique axis must be a Lua integer',2) end
      if axis<0 then axis=a.ndim+axis+1 end
      if axis<1 or axis>a.ndim then error('axis outside one-based range',2) end
    end

    local rows=axis~=nil and a.ndim>1
    local vector=a
    local ordered_input
    if rows then
      ordered_input,vector=axis_rows(a,axis)
    else
      vector=lr.ravel(a)
      ordered_input=vector
    end

    local dtype=lr.dtype(vector.dtype)
    if dtype.itemsize==0 then
      if rows and vector.shape[1]>0 and vector.shape[2]~=1 then
        error('zero-width text cannot be reshaped into unique rows',2)
      end
      if not rows then
        vector=lr.astype(vector,dtype.kind..'1')
        ordered_input=vector
        dtype=lr.dtype(vector.dtype)
      end
    end

    local keys=vector
    if dtype.kind=='U' then
      -- NumPy sorts unique Unicode values in code-point order.
      local canonical=lr.dtype('U'..(dtype.itemsize//4))
      if dtype.byteorder~=canonical.byteorder then keys=lr.astype(vector,canonical) end
    end
    local order
    if rows and vector.shape[2]==0 then
      order=lr.arange(1,vector.shape[1]+1,1,'intp')
    elseif rows then
      -- The first element of each row is its primary key.
      order=row_order(keys)
    else
      order=lr.lexsort({keys})
    end
    local sorted=lr.take(vector,order,1)
    -- NumPy's datetime hash uses integer ticks when no auxiliary arrays
    -- are requested, so duplicate NaT collapses on that path.
    local value_only_datetime=dtype.kind=='M' and not config.return_index
      and not config.return_inverse and not config.return_counts
    local flags=mark_groups(sorted,rows,config.equal_nan~=false or value_only_datetime)
    local starts=lr.flatnonzero(flags)
    local first=lr.take(order,starts)
    local values=lr.take(ordered_input,first,1)
    if rows then
      if values.size==0 then values=empty_shape_view(values,values.shape) end
      values=lr.moveaxis(values,1,axis)
    end

    local result={values}
    if config.return_index then result[#result+1]=first end
    if config.return_inverse then
      local inverse=lr.empty({order.size},order.dtype)
      local numbers=lr.cumsum(flags,{dtype=order.dtype})
      lr.put_along_axis(inverse,order,numbers,1)
      if not rows then
        if a.ndim>1 and inverse.size==0 then
          inverse=empty_shape_view(inverse,a.shape)
        else inverse=lr.reshape(inverse,a.shape) end
      end
      result[#result+1]=inverse
    end
    if config.return_counts then
      local last=lr.array({order.size+1},order.dtype)
      result[#result+1]=lr.diff(lr.concat({starts,last}))
    end
    return table.unpack(result)
  end

  function lr.unique_all(input)
    local values,indices,inverse_indices,counts=lr.unique(input,{
      return_index=true,return_inverse=true,return_counts=true,equal_nan=false
    })
    return {values=values,indices=indices,inverse_indices=inverse_indices,counts=counts}
  end

  function lr.unique_values(input)
    return lr.unique(input,{equal_nan=false})
  end

  function lr.unique_counts(input)
    local values,counts=lr.unique(input,{return_counts=true,equal_nan=false})
    return {values=values,counts=counts}
  end

  function lr.unique_inverse(input)
    local values,inverse_indices=lr.unique(input,{return_inverse=true,equal_nan=false})
    return {values=values,inverse_indices=inverse_indices}
  end
end
