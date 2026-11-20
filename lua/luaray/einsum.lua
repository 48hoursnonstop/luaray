-- Parse the string form of NumPy 2.5.5 Einstein summation.
return function(lr)
  local contract=lr._einsum
  lr._einsum=nil

  local function labels(value)
    local result,named,dots={},0,false
    local i=1
    while i<=#value do
      local c=value:byte(i)
      if (c>=65 and c<=90) or (c>=97 and c<=122) then
        result[#result+1]=c
        named=named+1
        i=i+1
      elseif not dots and value:sub(i,i+2)=='...' then
        result[#result+1]=0
        dots=true
        i=i+3
      else
        error('invalid Einstein subscript',3)
      end
    end
    return result,named,dots
  end

  local function expand(parsed,count,maximum)
    local result={}
    for _,label in ipairs(parsed) do
      if label==0 then
        for i=maximum-count+1,maximum do result[#result+1]=128+i end
      else
        result[#result+1]=label
      end
    end
    return result
  end

  local function options(value)
    if value==nil then value={} end
    if type(value)~='table' then error('einsum options must be a table',3) end
    for key in pairs(value) do
      if key~='dtype' and key~='casting' and key~='order' and key~='out' and key~='optimize' then
        error('unknown einsum option',3)
      end
    end
    if value.optimize~=nil and value.optimize~=false then
      error('optimized contraction paths are not implemented',3)
    end
    local order=value.order or 'K'
    if type(order)~='string' then error('einsum order must be a string',3) end
    local casting=value.casting or 'safe'
    if type(casting)~='string' then error('einsum casting must be a string',3) end
    return value.dtype,value.out,order:upper(),casting
  end

  function lr.einsum(subscripts,...)
    if type(subscripts)~='string' then error('einsum requires a subscript string',2) end
    subscripts=subscripts:gsub(' ','')
    local arrow=subscripts:find('->',1,true)
    local input=arrow and subscripts:sub(1,arrow-1) or subscripts
    local output=arrow and subscripts:sub(arrow+2) or nil
    local terms={}
    for term in (input..','):gmatch('(.-),') do terms[#terms+1]=term end
    local n=#terms
    local argc=select('#',...)
    if n>63 or argc<n or argc>n+1 then error('einsum operand count differs from subscripts',2) end
    local dtype,out,order,casting=options((select(n+1,...)))
    local arrays,maps,gaps,counts={},{},{},{}
    local width=0
    for i,term in ipairs(terms) do
      local a=lr.asanyarray((select(i,...)))
      local ids,named,dots=labels(term)
      local gap=a.ndim-named
      if gap<0 or (gap~=0 and not dots) then error('einsum subscripts differ from operand rank',2) end
      for _,id in ipairs(ids) do
        if id~=0 then counts[id]=(counts[id] or 0)+1 end
      end
      arrays[i],maps[i],gaps[i]=a,ids,gap
      width=math.max(width,gap)
    end

    local ordered={}
    if output then
      local parsed,_,dots=labels(output)
      if width>0 and not dots then error('einsum output must include its broadcast axes',2) end
      ordered=expand(parsed,width,width)
    else
      for i=1,width do ordered[#ordered+1]=128+i end
      for label=65,122 do
        if counts[label]==1 then ordered[#ordered+1]=label end
      end
    end
    local positions={}
    for i,label in ipairs(ordered) do
      if positions[label] or (label<128 and counts[label]==nil) then
        error('einsum output labels must be distinct and present in an operand',2)
      end
      positions[label]=i
    end
    local output_rank=#ordered
    for label=65,122 do
      if counts[label] and not positions[label] then
        ordered[#ordered+1]=label
        positions[label]=#ordered
      end
    end
    if #ordered>64 then error('einsum logical rank exceeds 64',2) end
    for i,term in ipairs(maps) do
      local expanded=expand(term,gaps[i],width)
      for j,label in ipairs(expanded) do expanded[j]=positions[label] end
      maps[i]=expanded
    end
    local result=contract(arrays,maps,#ordered,output_rank,dtype,order,casting,out)
    if out==nil and result.ndim==0 then return result:item() end
    return result
  end
end
