-- NumPy 2.5.5 lib/_arraypad_impl.py: axis-by-axis region padding.
local option_for={
  constant='constant_values',linear_ramp='end_values',
  maximum='stat_length',minimum='stat_length',mean='stat_length',median='stat_length',
  reflect='reflect_type',symmetric='reflect_type',
  empty=false,edge=false,wrap=false,
}

return function(lr)
  local function pairs_for(value,rank,index)
    local array=lr.asanyarray(value)
    if index then
      if index=='width' and lr.dtype(array.dtype).kind~='i' then
        error('pad widths must be signed integers',3)
      end
      if index~='width' then
        local kind=lr.dtype(array.dtype).kind
        if not kind:match('[biu]') then array=lr.rint(array) end
        array=lr.astype(array,'intp')
      end
      if lr.any(lr.less(array,0)) then error('pad widths and lengths must be nonnegative',3) end
    end
    local output={}
    local shape=array.shape
    if array.ndim<3 and (array.size==1 or (array.size==2 and shape[2]~=1)) then
      local flat=lr.ravel(array)
      local first,last=flat[1],flat[array.size]
      if not index then
        first=flat:get(lr.s(1,2)):reshape({})
        last=flat:get(lr.s(array.size,array.size+1)):reshape({})
      end
      for i=1,rank do output[i]={first,last} end
      return output
    end
    local view=lr.broadcast_to(array,{rank,2})
    for i=1,rank do
      if index then output[i]={view:get(i,1),view:get(i,2)}
      else
        local row=lr.s(i,i+1)
        output[i]={view:get(row,lr.s(1,2)):reshape({}),view:get(row,lr.s(2,3)):reshape({})}
      end
    end
    return output
  end

  local function widths_for(value,rank)
    if type(value)~='table' or value.axes==nil then return pairs_for(value,rank,'width') end
    if type(value.axes)~='table' then error('axes must be a table',3) end
    for key in pairs(value) do
      if key~='axes' then error('axis padding accepts only an axes table',3) end
    end
    local widths,seen={},{}
    for i=1,rank do widths[i]={0,0} end
    for a,pair in pairs(value.axes) do
      if math.type(a)~='integer' then error('padding axis must be an integer',3) end
      local i=a<0 and a+rank+1 or a
      if i<1 or i>rank then error('padding axis is out of range',3) end
      if seen[i] then error('duplicate padding axis',3) end
      seen[i]=true
      widths[i]=pairs_for(pair,1,'width')[1]
    end
    return widths
  end

  local function slice(first,after,size)
    if after==size then return lr.s(first+1,nil) end
    return lr.s(first+1,after+1)
  end

  local function strip(array,axis,first,after)
    local index={}
    for i=1,axis-1 do index[i]=lr.s() end
    index[axis]=slice(first,after,array.shape[axis])
    return array:get(table.unpack(index))
  end

  local function put(array,axis,first,after,value)
    lr.copyto(strip(array,axis,first,after),value,'unsafe')
  end

  local function edges(array,axis,left,right)
    local size=array.shape[axis]
    return strip(array,axis,left,left+1),strip(array,axis,size-right-1,size-right)
  end

  local function reflect(array,axis,left,right,original,symmetric,odd)
    local size=array.shape[axis]
    local period=symmetric and original or original-1
    local shift=symmetric and 1 or 0
    while left>0 or right>0 do
      local available=(size-right-left-1+shift)//period*period
      local before,after=math.min(available,left),math.min(available,right)
      if before>0 then
        local first=left+1-shift
        local chunk=lr.flip(strip(array,axis,first,first+before),axis)
        if odd then
          chunk=lr.subtract(lr.multiply(2,strip(array,axis,left,left+1)),chunk)
        end
        put(array,axis,left-before,left,chunk)
      end
      if after>0 then
        local last=size-right+shift-1
        local chunk=lr.flip(strip(array,axis,last-after,last),axis)
        if odd then
          chunk=lr.subtract(lr.multiply(2,strip(array,axis,size-right-1,size-right)),chunk)
        end
        put(array,axis,size-right,size-right+after,chunk)
      end
      left,right=left-before,right-after
    end
  end

  local function wrap(array,axis,left,right,original)
    local size=array.shape[axis]
    while left>0 or right>0 do
      local period=(size-left-right)//original*original
      local before,after=math.min(period,left),math.min(period,right)
      if before>0 then
        local last=left+period
        put(array,axis,left-before,left,strip(array,axis,last-before,last))
      end
      if after>0 then
        local first=size-right-period
        put(array,axis,size-right,size-right+after,strip(array,axis,first,first+after))
      end
      left,right=left-before,right-after
    end
  end

  local function callback_pad(padded,widths,fn,options)
    for axis=1,padded.ndim do
      local view=lr.moveaxis(padded,axis,-1)
      local shape=view.shape
      shape[#shape]=nil
      for index in lr.ndindex(shape) do
        index[#index+1]=lr.s()
        local pair=widths[axis]
        fn(view:get(table.unpack(index)),{pair[1],pair[2]},axis,options)
      end
    end
  end

  local function stat_pair(array,axis,left,right,length,reducer,round)
    local size=array.shape[axis]
    local count=size-left-right
    local a,b=math.min(length[1] or count,count),math.min(length[2] or count,count)
    local config={axis=axis,keepdims=true}
    local start=reducer(strip(array,axis,left,left+a),config)
    local finish=start
    if a~=count or b~=count then finish=reducer(strip(array,axis,size-right-b,size-right),config) end
    if round then start,finish=lr.rint(start),lr.rint(finish) end
    return start,finish
  end

  local function extrema(array,config,maximum)
    if lr.dtype(array.dtype).kind~='M' then
      return (maximum and lr.max or lr.min)(array,config)
    end
    local byteorder=lr.dtype(array.dtype).byteorder
    local ticks=array:view(byteorder=='>' and '>i8' or 'int64')
    local first=lr.min(ticks,config)
    if not maximum then return first:view(array.dtype) end
    local last=lr.max(ticks,config)
    lr.copyto(last,first,'no',lr.equal(first,math.mininteger))
    return last:view(array.dtype)
  end

  local function median(array,config)
    if lr.dtype(array.dtype).kind~='c' then return lr.median(array,config) end
    local axis=config.axis
    local count=array.shape[axis]
    if count==0 then return lr.mean(array,config) end
    local sorted=lr.sort(array,{axis=axis})
    local middle=strip(sorted,axis,(count-1)//2,count//2+1)
    local result=lr.mean(middle,config)
    local last=strip(sorted,axis,count-1,count)
    lr.copyto(result,last,'no',lr.isnan(last))
    return result
  end

  local statistics={
    maximum=function(a,c) return extrema(a,c,true) end,
    minimum=function(a,c) return extrema(a,c,false) end,
    mean=lr.mean,median=median,
  }

  function lr.pad(input,pad_width,mode,options)
    if mode==nil then mode='constant' end
    if options==nil then options={} end
    if type(options)~='table' then error('pad options must be a table',2) end
    local callback=type(mode)=='function'
    local option=option_for[mode]
    if not callback then
      if option==nil then error('unknown padding mode',2) end
      for key in pairs(options) do
        if key~=option then error('unsupported option for padding mode',2) end
      end
    end
    local a=lr.asanyarray(input)
    local rank=a.ndim
    local widths=widths_for(pad_width,rank)
    local shape,area={},{}
    for i,n in ipairs(a.shape) do
      local left,right=widths[i][1],widths[i][2]
      if left>math.maxinteger-n-right then error('padded axis is too large',2) end
      if n==0 and (left>0 or right>0) and mode~='constant' and mode~='empty' and not callback then
        error('selected padding mode cannot extend an empty axis',2)
      end
      shape[i]=left+n+right
      area[i]=slice(left,left+n,shape[i])
    end
    local order=a.flags.f_contiguous and not a.flags.c_contiguous and 'F' or 'C'
    local padded=lr.empty(shape,{dtype=a.dtype,order=order})
    if callback then padded:fill(0) end
    if rank==0 then lr.copyto(padded,a,'no')
    else lr.copyto(padded:get(table.unpack(area)),a,'no') end
    if callback then
      callback_pad(padded,widths,mode,options)
      return padded
    end
    if mode=='empty' or (a.size==0 and mode~='constant') then return padded end
    local values,stat,odd
    if mode=='constant' or mode=='linear_ramp' then
      local value=options[option]
      if value==nil then value=0 end
      values=pairs_for(value,rank)
    elseif statistics[mode] then
      stat=options.stat_length~=nil and pairs_for(options.stat_length,rank,'length')
      local kind=lr.dtype(a.dtype).kind
      if rank>0 and kind=='m' then error('duration padding statistics do not support rounding',2) end
      stat=stat or {}
      odd=(mode=='mean' or mode=='median') and (kind=='i' or kind=='u')
    elseif mode=='reflect' or mode=='symmetric' then
      local method=options.reflect_type
      odd=method=='odd'
    end
    for axis,n in ipairs(a.shape) do
      local left,right=widths[axis][1],widths[axis][2]
      local roi_indexes={}
      for i=1,rank do roi_indexes[i]=i<=axis and lr.s() or area[i] end
      local region=padded:get(table.unpack(roi_indexes))
      if mode=='wrap' then wrap(region,axis,left,right,n)
      elseif (mode=='reflect' or mode=='symmetric') and n>1 then
        reflect(region,axis,left,right,n,mode=='symmetric',odd)
      else
        local lo,hi
        if mode=='constant' then lo,hi=table.unpack(values[axis])
        elseif statistics[mode] then
          lo,hi=stat_pair(region,axis,left,right,stat[axis] or {},statistics[mode],odd)
        else
          lo,hi=edges(region,axis,left,right)
          if mode=='linear_ramp' then
            local config={num=left,endpoint=false,dtype=a.dtype,axis=axis}
            lo=lr.linspace(values[axis][1],lr.squeeze(lo,axis),config)
            config.num=right
            hi=lr.flip(lr.linspace(values[axis][2],lr.squeeze(hi,axis),config),axis)
          end
        end
        local size=region.shape[axis]
        put(region,axis,0,left,lo)
        put(region,axis,size-right,size,hi)
      end
    end
    return padded
  end
end
