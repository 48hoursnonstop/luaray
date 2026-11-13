-- NumPy2.5.3 numeric.py equality and closeness; native typed composition.
return function(lr)
  local function settings(value,allowed,name)
    if value==nil then value={} end
    if type(value)~='table' then error(name..' options must be a table',3) end
    for key in pairs(value)do if not allowed[key] then error('unknown '..name..' option',3) end end
    if value.equal_nan~=nil and type(value.equal_nan)~='boolean' then error('equal_nan must be Boolean',3) end
    return value
  end
  local function family(array)
    local dtype=array.dtype
    if dtype:find('datetime64',1,true)==1 then return 'M' end
    if dtype:find('timedelta64',1,true)==1 then return 'm' end
    return dtype:match('^[|<>=]([SU])') or 'number'
  end
  local function rich_equal(a,b)
    -- arrayobject.c handles a missing comparison loop separately from errors
    -- during execution. Known incomparable dtype families return all False;
    -- native promotion, unit conversion, allocation and execution errors propagate.
    local af,bf=family(a),family(b)
    local numeric=af=='m' and b or bf=='m' and a
    local integer_duration=numeric and (numeric.dtype=='bool' or
      lr.issubdtype(numeric.dtype,'signedinteger') or
      (lr.issubdtype(numeric.dtype,'unsignedinteger') and numeric.dtype~='uint64'))
    if af~=bf and not integer_duration then
      return lr.zeros(lr.broadcast_shapes(a.shape,b.shape),'bool')
    end
    return lr.equal(a,b)
  end
  function lr.array_equal(a,b,...)
    if select('#',...)>1 then error('array_equal accepts two inputs and one options table',2) end
    local options=settings((...),{equal_nan=true},'array_equal')
    local ok,x,y=pcall(function()return lr.asarray(a),lr.asarray(b)end)
    if not ok then return false end
    if x.ndim~=y.ndim then return false end
    for d=1,x.ndim do if x.shape[d]~=y.shape[d] then return false end end
    if not options.equal_nan then return lr.all(rich_equal(x,y)) end
    if rawequal(x,y) then return true end
    local function no_nan(z)
      return z.dtype=='bool' or (family(z)=='number' and lr.issubdtype(z.dtype,'signedinteger'))
    end
    if no_nan(x) and no_nan(y) then return lr.all(rich_equal(x,y)) end
    local nan=lr.isnan(x)
    if lr.all(nan) then return lr.all(lr.isnan(y)) end
    return lr.all(lr.logical_or(rich_equal(x,y),lr.logical_and(nan,lr.isnan(y))))
  end
  function lr.array_equiv(a,b,...)
    if select('#',...)~=0 then error('array_equiv accepts exactly two inputs',2) end
    local ok,x,y=pcall(function()return lr.asarray(a),lr.asarray(b)end)
    if not ok then return false end
    if not pcall(lr.broadcast_shapes,x.shape,y.shape) then return false end
    return lr.all(rich_equal(x,y))
  end
  local function weak(v)
    local kind=type(v)
    return kind=='number' or kind=='boolean' or
      (kind=='userdata' and v.ndim==nil and v.real~=nil and v.imag~=nil)
  end
  local function coerce(v)if weak(v) then return v end;return lr.asanyarray(v)end
  local function binary(name,a,b)
    if weak(a) and weak(b) then
      if type(a)=='boolean' then a=a and 1 or 0 end
      if type(b)=='boolean' then b=b and 1 or 0 end
      if name=='add' then return a+b end
      if name=='subtract' then return a-b end
      return a*b
    end
    return lr[name](a,b)
  end
  local function absolute(v)
    if type(v)=='number' then return math.abs(v) end
    if type(v)=='boolean' then return v and 1 or 0 end
    local out=lr.absolute(v)
    if weak(v) then return out:tolist() end
    return out
  end
  function lr.isclose(a,b,...)
    if select('#',...)>1 then error('isclose accepts two inputs and one options table',2) end
    local options=settings((...),{rtol=true,atol=true,equal_nan=true},'isclose')
    local x,y=coerce(a),coerce(b)
    local atol=options.atol;if atol==nil then atol=1e-8 end
    local rtol=options.rtol;if rtol==nil then rtol=1e-5 end
    atol,rtol=coerce(atol),coerce(rtol)
    if not weak(y) then
      if family(y)~='m' then y=lr.asanyarray(y,{dtype=lr.result_type(y,1.0)}) end
    elseif type(y)=='boolean' then y=y and 1.0 or 0.0
    elseif math.type(y)=='integer' then y=y+0.0 end
    -- Evaluate validity as the source does. Floating warning/error-state objects
    -- are not emulated; default nonfinite tolerance arithmetic still executes.
    lr.all(lr.isfinite(atol));lr.all(lr.isfinite(rtol))
    local difference=absolute(binary('subtract',x,y))
    local tolerance=binary('add',atol,binary('multiply',rtol,absolute(y)))
    local result=lr.logical_or(lr.logical_and(lr.less_equal(difference,tolerance),lr.isfinite(y)),lr.equal(x,y))
    if options.equal_nan then result=lr.logical_or(result,lr.logical_and(lr.isnan(x),lr.isnan(y))) end
    return result
  end
  function lr.allclose(a,b,...)
    return lr.all(lr.isclose(a,b,...))
  end
end
