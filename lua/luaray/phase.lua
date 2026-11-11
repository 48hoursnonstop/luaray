-- NumPy2.5.3 _function_base_impl.py:unwrap, using native array kernels.
return function(lr)
  local function number(v)if type(v)=='boolean' then return v and 1 or 0 end;return v end
  local function divide(a,b)
    if type(a)=='number' or type(a)=='boolean' then return number(a)/b end
    return lr.true_divide(a,b)
  end
  local function negative(v)
    if type(v)=='number' or type(v)=='boolean' then return -number(v) end
    return lr.negative(v)
  end
  function lr.unwrap(input,...)
    if select('#',...)>1 then error('unwrap accepts input and one options table',2) end
    local options=(...);if options==nil then options={} end
    if type(options)~='table' then error('unwrap options must be a table',2) end
    for key in pairs(options)do
      if key~='period' and key~='discont' and key~='axis' then error('unknown unwrap option',2) end
    end
    local p=lr.asarray(input);local axis=options.axis;if axis==nil then axis=-1 end
    local dd=lr.diff(p,{axis=axis})
    local period=options.period;if period==nil then period=2*math.pi end
    local discont=options.discont;if discont==nil then discont=divide(period,2) end
    local dtype=lr.result_type(dd,period)
    local high,ambiguous
    if lr.issubdtype(dtype,'integer') then
      if type(period)=='number' or type(period)=='boolean' then
        period=number(period)
        high=period//2;ambiguous=period%2==0
      else
        local rem;high,rem=lr.divmod(period,lr.array(2,period.dtype))
        if rem.size~=1 then error('integer period truth value is ambiguous',2) end
        ambiguous=lr.all(lr.equal(rem,0))
      end
    else high=divide(period,2);ambiguous=true end
    local low=negative(high)
    local wrapped=lr.add(lr.remainder(lr.subtract(dd,low),period),low)
    if ambiguous then
      lr.copyto(wrapped,high,'same_kind',lr.logical_and(lr.equal(wrapped,low),lr.greater(dd,0)))
    end
    local correction=lr.subtract(wrapped,dd)
    lr.copyto(correction,0,'same_kind',lr.less(lr.absolute(dd),discont))
    local out=lr.array(p,{dtype=dtype,copy=true})
    local selected={};for i=1,p.ndim do selected[i]=lr.s() end
    local normalized=axis;if axis<0 then normalized=p.ndim+axis+1 end
    selected[normalized]=lr.s(2,nil)
    out:set(lr.add(p:get(table.unpack(selected)),lr.cumsum(correction,axis)),table.unpack(selected))
    return out
  end
end
