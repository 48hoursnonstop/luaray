-- Source contract: NumPy 2.5.3 _core/_asarray.py:require.
return function(lr)
  local names={F='F',F_CONTIGUOUS='F',C='C',C_CONTIGUOUS='C',CONTIGUOUS='C',FORTRAN='F',A='A',ALIGNED='A',
    W='W',WRITEABLE='W',O='O',OWNDATA='O',E='E',ENSUREARRAY='E'}
  function lr.require(input,dtype,requirements,...)
    if select('#',...)>0 then error('require accepts input, dtype and requirements',2) end
    if requirements==nil or requirements==false or requirements=='' then
      return lr.asanyarray(input,dtype)
    end
    local requested={}
    local function add(name)
      if type(name)~='string' then error('requirements must contain strings',2) end
      local flag=names[name:upper()]
      if not flag then error('unknown array requirement',2) end
      requested[flag]=true
    end
    if type(requirements)=='string' then
      for i=1,#requirements do add(requirements:sub(i,i)) end
    elseif type(requirements)=='table' then
      local n=#requirements
      for key in pairs(requirements) do
        if math.type(key)~='integer' or key<1 or key>n then error('requirements must be a dense sequence',2) end
      end
      if n==0 then return lr.asanyarray(input,dtype) end
      for i=1,n do add(requirements[i]) end
    else error('requirements must be a string or sequence',2) end
    if requested.C and requested.F then error('cannot request both C and F order',2) end
    local order=requested.F and 'F' or requested.C and 'C' or 'A'
    local result=lr.array(input,dtype,{order=order,copy='if_needed',subok=not requested.E})
    local flags=result.flags
    if (requested.A and not flags.aligned) or (requested.O and not flags.owndata)
       or (requested.W and not flags.writeable) then return result:copy(order) end
    return result
  end
end
