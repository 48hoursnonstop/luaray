-- NumPy2.5.3 gradient: vectorized typed differences and endpoint stencils.
return function(lr)
  local function weak(value)
    local kind=type(value)
    return kind=='number' or kind=='boolean' or
      (kind=='userdata' and value.ndim==nil and value.real~=nil and value.imag~=nil)
  end
  local function binary(name,a,b)
    if weak(a) and weak(b) then
      if type(a)=='boolean' then a=a and 1 or 0 end
      if type(b)=='boolean' then b=b and 1 or 0 end
      if name=='add' then return a+b end
      if name=='subtract' then return a-b end
      if name=='multiply' then return a*b end
      if (type(b)=='number' and b==0) or
         (type(b)=='userdata' and b.real==0 and b.imag==0) then error('division by zero spacing',3) end
      return a/b
    end
    return lr[name](a,b)
  end
  local function add(a,b)return binary('add',a,b)end
  local function sub(a,b)return binary('subtract',a,b)end
  local function mul(a,b)return binary('multiply',a,b)end
  local function div(a,b)return binary('true_divide',a,b)end
  local function neg(a)
    if weak(a) then if type(a)=='boolean' then a=a and 1 or 0 end;return -a end
    return lr.negative(a)
  end
  local function point(a,index)
    local stop;if index~=-1 then stop=index+1 end
    return a:get(lr.s(index,stop)):reshape({})
  end
  local function read(a,selection,axis)
    if type(selection[axis])~='number' then return a:get(table.unpack(selection)) end
    local indices={table.unpack(selection)};local i=indices[axis]
    local stop;if i~=-1 then stop=i+1 end
    indices[axis]=lr.s(i,stop)
    return lr.squeeze(a:get(table.unpack(indices)),axis)
  end
  local function weighted(a,b,c,f,s2,s3,s4,axis)
    return add(add(mul(a,read(f,s2,axis)),mul(b,read(f,s3,axis))),mul(c,read(f,s4,axis)))
  end
  function lr.gradient(input,...)
    if select('#',...)>1 then error('gradient accepts input and one options table',2) end
    local settings=(...);if settings==nil then settings={} end
    if type(settings)~='table' then error('gradient options must be a table',2) end
    for key in pairs(settings)do
      if key~='axis' and key~='spacing' and key~='edge_order' then error('unknown gradient option',2) end
    end
    local f=lr.asanyarray(input);local nd=f.ndim
    local axes={}
    if settings.axis==nil then for d=1,nd do axes[#axes+1]=d end
    else
      local requested=type(settings.axis)=='table' and settings.axis or {settings.axis}
      local seen={}
      for _,a in ipairs(requested)do
        if math.type(a)~='integer' then error('gradient axes must be Lua integers',2) end
        if a<0 then a=nd+a+1 end
        if a<1 or a>nd or seen[a] then error('invalid or duplicate gradient axis',2) end
        seen[a]=true;axes[#axes+1]=a
      end
    end
    local dx={};local spacing=settings.spacing
    if spacing==nil then for i=1,#axes do dx[i]=1.0 end
    else
      local single=type(spacing)~='table' and (weak(spacing) or lr.asanyarray(spacing).ndim==0)
      if single then for i=1,#axes do dx[i]=spacing end
      else
        local supplied=type(spacing)=='table' and spacing or {spacing}
        if #supplied~=#axes then error('spacing count must match selected axes',2) end
        for i,distance in ipairs(supplied)do
          local array=lr.asanyarray(distance)
          if array.ndim==0 then dx[i]=distance
          else
            if array.ndim~=1 or array.size~=f.shape[axes[i]] then error('coordinate spacing must match its axis',2) end
            if lr.issubdtype(array.dtype,'integer') then array=lr.astype(array,'float64') end
            local differences=lr.diff(array);local first=point(differences,1)
            dx[i]=lr.all(lr.equal(differences,first)) and first or differences
          end
        end
      end
    end
    local edge=settings.edge_order;if edge==nil then edge=1 end
    if math.type(edge)~='integer' or edge>2 then error('edge_order must be a Lua integer no greater than two',2) end
    local dtype=f.dtype
    if dtype:find('datetime64',1,true)==1 then dtype=dtype:gsub('^datetime','timedelta');f=f:view(dtype)
    elseif dtype:find('timedelta64',1,true)==1 then
    elseif lr.issubdtype(dtype,'inexact') then
    else
      if lr.issubdtype(dtype,'integer') then f=lr.astype(f,'float64') end
      dtype='float64'
    end
    local s1,s2,s3,s4={},{},{},{}
    for d=1,nd do s1[d],s2[d],s3[d],s4[d]=lr.s(),lr.s(),lr.s(),lr.s() end
    local results={}
    for i,axis in ipairs(axes)do
      if f.shape[axis]<edge+1 then error('array axis is too small for edge_order',2) end
      local out=lr.empty_like(f,{dtype=dtype});local step=dx[i]
      local uniform=weak(step) or step.ndim==0
      s1[axis],s2[axis],s3[axis],s4[axis]=lr.s(2,-1),lr.s(nil,-2),lr.s(2,-1),lr.s(3,nil)
      if uniform then out:set(div(sub(read(f,s4,axis),read(f,s2,axis)),mul(2.0,step)),table.unpack(s1))
      else
        local dx1,dx2=step:get(lr.s(nil,-1)),step:get(lr.s(2,nil))
        local a=div(neg(dx2),mul(dx1,add(dx1,dx2)))
        local b=div(sub(dx2,dx1),mul(dx1,dx2))
        local c=div(dx1,mul(dx2,add(dx1,dx2)))
        local shape={};for d=1,nd do shape[d]=d==axis and -1 or 1 end
        a,b,c=lr.reshape(a,shape),lr.reshape(b,shape),lr.reshape(c,shape)
        out:set(weighted(a,b,c,f,s2,s3,s4,axis),table.unpack(s1))
      end
      if edge==1 then
        s1[axis],s2[axis],s3[axis]=1,2,1
        local boundary_step=step;if not uniform then boundary_step=point(step,1) end
        out:set(div(sub(read(f,s2,axis),read(f,s3,axis)),boundary_step),table.unpack(s1))
        s1[axis],s2[axis],s3[axis]=-1,-1,-2
        boundary_step=step;if not uniform then boundary_step=point(step,-1) end
        out:set(div(sub(read(f,s2,axis),read(f,s3,axis)),boundary_step),table.unpack(s1))
      else
        -- In one dimension NumPy indexes scalars at the endpoints. Its
        -- float64 scalar inherits Python float, so a weak complex coefficient
        -- produces a Python complex which cannot be assigned to real storage.
        -- Typed complex spacings keep the array/scalar casting path instead.
        if nd==1 and dtype=='float64' and uniform and type(step)=='userdata'
           and weak(step) then error('complex endpoint cannot be assigned to float64',2) end
        local a,b,c
        s1[axis],s2[axis],s3[axis],s4[axis]=1,1,2,3
        if uniform then a,b,c=div(-1.5,step),div(2.0,step),div(-0.5,step)
        else
          local dx1,dx2=point(step,1),point(step,2)
          a=div(neg(add(mul(2.0,dx1),dx2)),mul(dx1,add(dx1,dx2)))
          b=div(add(dx1,dx2),mul(dx1,dx2));c=div(neg(dx1),mul(dx2,add(dx1,dx2)))
        end
        out:set(weighted(a,b,c,f,s2,s3,s4,axis),table.unpack(s1))
        s1[axis],s2[axis],s3[axis],s4[axis]=-1,-3,-2,-1
        if uniform then a,b,c=div(0.5,step),div(-2.0,step),div(1.5,step)
        else
          local dx1,dx2=point(step,-2),point(step,-1)
          a=div(dx2,mul(dx1,add(dx1,dx2)))
          b=div(neg(add(dx2,dx1)),mul(dx1,dx2));c=div(add(mul(2.0,dx2),dx1),mul(dx2,add(dx1,dx2)))
        end
        out:set(weighted(a,b,c,f,s2,s3,s4,axis),table.unpack(s1))
      end
      results[#results+1]=out
      s1[axis],s2[axis],s3[axis],s4[axis]=lr.s(),lr.s(),lr.s(),lr.s()
    end
    if #axes==1 then return results[1] end
    return results
  end
end
