-- NumPy 2.5.5 lib/_function_base_impl.py: covariance and correlation.
local empty_shape_view=require('luaray.layout_view')
return function(lr)
  local function options(value,correlation)
    if value==nil then return {} end
    if type(value)~='table' then error('covariance options must be a table',3) end
    for key,flag in pairs(value) do
      if key=='rowvar' or (key=='bias' and not correlation) then
        if type(flag)~='boolean' then error(key..' must be a boolean',3) end
      elseif key~='y' and key~='dtype' and
          (correlation or (key~='ddof' and key~='fweights' and key~='aweights')) then
        error('unknown covariance option',3)
      end
    end
    return value
  end

  local function observation_matrix(a,dtype,rowvar,first)
    local matrix=lr.array(a,{dtype=dtype,ndmin=2,copy=true})
    local transpose=first and a.ndim~=1 or not first and matrix.shape[1]~=1
    if rowvar==false and transpose then matrix=lr.transpose(matrix) end
    return matrix
  end

  local function real_weights(input,samples,frequency)
    if input==nil then return nil end
    local w=lr.astype(lr.asanyarray(input),'float64')
    if w.ndim~=1 or w.size~=samples then error('weights must match the observation count',3) end
    if frequency and not lr.all(lr.equal(w,lr.rint(w))) then
      error('frequency weights must be integers',3)
    end
    if lr.any(lr.less(w,0)) then error('weights must be nonnegative',3) end
    return w
  end

  local function covariance(m,settings)
    local ddof=settings.ddof
    if ddof==nil then ddof=settings.bias and 0 or 1
    else
      ddof=type(ddof)=='number' and math.tointeger(ddof) or nil
      if ddof==nil then error('ddof must be an integer',3) end
    end

    local a=lr.asanyarray(m)
    local b
    if settings.y~=nil then b=lr.asanyarray(settings.y) end
    if a.ndim>2 or (b and b.ndim>2) then
      error('covariance inputs may have at most two dimensions',3)
    end
    local dtype=settings.dtype
    if dtype==nil then
      local base=lr.dtype('float64')
      dtype=b and lr.result_type(a,b,base) or lr.result_type(a,base)
    end
    local x=observation_matrix(a,dtype,settings.rowvar,true)
    if x.shape[1]==0 then
      return empty_shape_view(lr,lr.empty({0},'float64'),{0,0})
    end
    if b then
      x=lr.concat({x,observation_matrix(b,dtype,settings.rowvar,false)},1)
    end

    local n=x.shape[2]
    local frequencies=real_weights(settings.fweights,n,true)
    local amplitudes=real_weights(settings.aweights,n,false)
    local w=frequencies and amplitudes and lr.multiply(frequencies,amplitudes)
      or frequencies or amplitudes
    local avg,total=lr.average(x,{axis=2,weights=w,returned=true})
    if type(total)~='number' then total=total[1] end
    if type(total)~='number' then total=lr.real(lr.asanyarray(total)):item() end

    local normalization
    if not w then normalization=n-ddof
    elseif ddof==0 then normalization=total
    elseif not amplitudes then normalization=total-ddof
    else normalization=total-ddof*lr.sum(lr.multiply(w,amplitudes))/total end
    if normalization<=0 then normalization=0.0 end

    lr.subtract(x,lr.expand_dims(avg,2),{out=x})
    local weighted=w and lr.multiply(x,w) or x
    local result=lr.dot(x,lr.conjugate(lr.transpose(weighted)))
    local scale=lr.true_divide(lr.array(1,'float64'),normalization)
    lr.multiply(result,scale,{out=result})
    if result.shape[1]==1 then return lr.squeeze(result) end
    return result
  end

  function lr.cov(m,config)
    return covariance(m,options(config,false))
  end

  function lr.corrcoef(m,config)
    local result=covariance(m,options(config,true))
    if result.ndim==0 then return lr.true_divide(result,result):item() end
    local standard=lr.sqrt(lr.real(lr.diag(result)))
    lr.true_divide(result,lr.expand_dims(standard,2),{out=result})
    lr.true_divide(result,lr.expand_dims(standard,1),{out=result})
    local re=lr.real(result)
    lr.clip(re,-1,1,{out=re})
    if lr.dtype(result.dtype).kind=='c' then
      local im=lr.imag(result)
      lr.clip(im,-1,1,{out=im})
    end
    return result
  end
end
