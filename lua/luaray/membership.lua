-- NumPy 2.5.5 _arraysetops_impl.py: table, direct, and stable-sort membership.
return function(lr)
  local table_membership=lr._isin_table
  lr._isin_table=nil

  local function comparisons(a,b)
    local da,db=lr.dtype(a.dtype),lr.dtype(b.dtype)
    local ka,kb=da.kind,db.kind
    if ka==kb then return a,b end
    if ka:match('[SU]') or kb:match('[SU]') or ka=='M' or kb=='M' then return end
    if ka=='m' or kb=='m' then
      local other=ka=='m' and db or da
      local kind=other.kind
      if kind~='i' and kind~='b' and not (kind=='u' and other.itemsize<8) then return end
      if ka=='m' then b=lr.astype(b,da)
      else a=lr.astype(a,db) end
    end
    return a,b
  end

  local function direct(a,b,invert)
    local result=lr.full({a.size},invert,'bool')
    a,b=comparisons(a,b)
    if not a then return result end
    local compare=invert and lr.not_equal or lr.equal
    local merge=invert and lr.logical_and or lr.logical_or
    for i=1,b.size do
      local key=lr.reshape(b:get(lr.s(i,i+1)),{})
      merge(result,compare(a,key),{out=result})
    end
    return result
  end

  local function indirect(a,b,invert,assume_unique)
    local inverse
    if not assume_unique then
      a,inverse=lr.unique(a,{return_inverse=true})
      b=lr.unique(b)
    end
    local joined=lr.concat({a,b})
    local order=lr.lexsort({joined})
    local sorted=lr.take(joined,order)
    local compare=invert and lr.not_equal or lr.equal
    local mask=compare(sorted:get(lr.s(2,nil)),sorted:get(lr.s(nil,-1)))
    mask=lr.concat({mask,lr.array({invert},'bool')})
    local result=lr.empty({joined.size},'bool')
    lr.put_along_axis(result,order,mask,1)
    if inverse then return lr.take(result,inverse) end
    return result:get(lr.s(1,a.size+1))
  end

  local function restore_shape(result,shape)
    if result.size==0 and #shape>1 then
      local strides={}
      local width=1
      for i=#shape,1,-1 do
        strides[i]=width
        local extent=math.max(1,shape[i])
        if width>math.maxinteger//extent then error('membership layout exceeds native range',3) end
        width=width*extent
      end
      return lr.ndarray(shape,{dtype='bool',buffer=result,strides=strides})
    end
    return lr.reshape(result,shape)
  end

  function lr.isin(element,test_elements,options)
    if options==nil then options={} end
    if type(options)~='table' then error('isin options must be a table',2) end
    for key,value in pairs(options) do
      if key=='invert' or key=='assume_unique' then
        if type(value)~='boolean' then error(key..' must be a boolean',2) end
      elseif key~='kind' then error('unknown isin option',2) end
    end
    local kind=options.kind
    if kind~=nil and kind~='sort' and kind~='table' then error('invalid isin kind',2) end
    local invert=options.invert==true
    local array=lr.asanyarray(element)
    local a=lr.ravel(array)
    local b=lr.ravel(lr.asanyarray(test_elements))

    local result
    if kind~='sort' then result=table_membership(a,b,invert,kind=='table') end
    if not result then
      if a.size==0 or b.size==0 or b.size<10*a.size^0.145 then
        result=direct(a,b,invert)
      else
        result=indirect(a,b,invert,options.assume_unique==true)
      end
    end
    return restore_shape(result,array.shape)
  end
end
