-- NumPy 2.5.4 lib/_ufunclike_impl.py: signed infinity predicates.
-- High-level composition uses the native ufunc engine for every array loop.
return function(lr)
  local function signed_infinity(input,out,positive,...)
    if select('#',...)>0 then error('infinity predicates accept input and optional output array',3) end
    local infinite=lr.isinf(input)
    local sign=lr.signbit(input)
    if positive then sign=lr.logical_not(sign) end
    if out~=nil and type(out)~='userdata' then error('out must be an ndarray or nil',3) end
    return lr.logical_and(infinite,sign,out)
  end
  function lr.isposinf(input,out,...)
    return signed_infinity(input,out,true,...)
  end
  function lr.isneginf(input,out,...)
    return signed_infinity(input,out,false,...)
  end
end
