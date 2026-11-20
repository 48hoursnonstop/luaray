-- NumPy 2.5.5 lib/_arraysetops_impl.py: set operations on flat arrays.
return function(lr)
  local function options(value,index_allowed)
    if value==nil then return {} end
    if type(value)~='table' then error('set options must be a table',3) end
    for key,flag in pairs(value) do
      if key~='assume_unique' and (key~='return_indices' or not index_allowed) then
        error('unknown set option',3)
      end
      if type(flag)~='boolean' then error(key..' must be a boolean',3) end
    end
    return value
  end

  local function flatten(a)
    return lr.ravel(lr.asanyarray(a))
  end

  local function neighbors(a)
    return a:get(lr.s(nil,-1)),a:get(lr.s(2,nil))
  end

  local function sorted_join(a,b)
    local joined=lr.concat({a,b})
    local order=lr.lexsort({joined})
    return lr.take(joined,order),order
  end

  local function inputs(a,b,settings)
    if settings.assume_unique then return flatten(a),flatten(b) end
    return lr.unique(a),lr.unique(b)
  end

  function lr.union1d(a,b)
    return lr.unique(lr.concat({flatten(a),flatten(b)}))
  end

  function lr.setdiff1d(a,b,config)
    a,b=inputs(a,b,options(config,false))
    local keep=lr.isin(a,b,{invert=true,assume_unique=true})
    return a:get(keep)
  end

  function lr.setxor1d(a,b,config)
    a,b=inputs(a,b,options(config,false))
    local sorted=sorted_join(a,b)
    if sorted.size<2 then return sorted end
    local left,right=neighbors(sorted)
    local step=lr.not_equal(left,right)
    local boundary=lr.concat({{true},step,{true}})
    local before,after=neighbors(boundary)
    return sorted:get(lr.logical_and(before,after))
  end

  function lr.intersect1d(a,b,config)
    local settings=options(config,true)
    local first,second
    if settings.return_indices and not settings.assume_unique then
      a,first=lr.unique(a,{return_index=true})
      b,second=lr.unique(b,{return_index=true})
    else
      a,b=inputs(a,b,settings)
    end
    local sorted,order=sorted_join(a,b)
    local left,right=neighbors(sorted)
    local matching=lr.equal(left,right)
    local result=left:get(matching)
    if not settings.return_indices then return result end
    local left_order,right_order=neighbors(order)
    local from_a=left_order:get(matching)
    local from_b=lr.subtract(right_order:get(matching),a.size)
    if first then from_a=lr.take(first,from_a) end
    if second then from_b=lr.take(second,from_b) end
    return result,from_a,from_b
  end
end
