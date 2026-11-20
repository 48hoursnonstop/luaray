-- NumPy 2.5.5 lib/_format_impl.py, for fixed-width ndarray descriptors.
return function(lr)
  local magic=string.char(147)..'NUMPY'
  local length_formats={'<I2','<I4','<I4'}
  local header_limit=10000

  local function with_file(file,mode,append_suffix,operation)
    if type(file)~='string' then
      if io.type(file)~='file' then error('expected a path or an open file',3) end
      return operation(file)
    end
    if file:find('\0',1,true) then error('file path contains a NUL byte',3) end
    if append_suffix and file:sub(-4)~='.npy' then file=file..'.npy' end
    local handle=assert(io.open(file,mode))
    local ok,result=pcall(operation,handle)
    local closed,message=handle:close()
    if not ok then error(result,0) end
    if not closed then error(message,3) end
    return result
  end

  local function read_exact(file,count)
    local data,message=file:read(count)
    if not data or #data~=count then error(message or 'truncated NPY stream',3) end
    return data
  end

  local function read_header(header)
    local pos=1
    local function take(pattern)
      local first,last,value=header:find('^%s*'..pattern,pos)
      if not first then return nil end
      pos=last+1
      return value or true
    end
    local function invalid()
      error('invalid NPY array header',4)
    end
    local function expect(pattern)
      local value=take(pattern)
      if not value then invalid() end
      return value
    end
    local function quoted()
      local quote=expect("(['\"])")
      local closing=header:find(quote,pos,true)
      if not closing then invalid() end
      local value=header:sub(pos,closing-1)
      pos=closing+1
      return value
    end
    local function dimensions()
      expect('%(')
      local shape={}
      if take('%)') then return shape end
      while true do
        local extent=tonumber(expect('(%d+)'))
        if math.type(extent)~='integer' or #shape==64 then invalid() end
        shape[#shape+1]=extent
        if take(',') then
          if take('%)') then return shape end
        elseif #shape>1 then
          expect('%)')
          return shape
        else invalid() end
      end
    end

    local entries={}
    expect('{')
    while not take('}') do
      local key=quoted()
      if entries[key]~=nil then invalid() end
      expect(':')
      if key=='descr' then
        entries[key]=quoted()
      elseif key=='fortran_order' then
        if take('True') then entries[key]=true
        elseif take('False') then entries[key]=false
        else invalid() end
      elseif key=='shape' then
        entries[key]=dimensions()
      else invalid() end
      if not take(',') then
        expect('}')
        break
      end
    end
    if not take('$') or entries.descr==nil or entries.shape==nil or
        entries.fortran_order==nil then invalid() end
    return entries
  end

  local function option(options,name)
    if options==nil then return nil end
    if type(options)~='table' then error('expected an NPY options table',3) end
    for key in pairs(options) do
      if key~=name then error('unknown NPY option',3) end
    end
    return options[name]
  end

  local function make_header(array,version)
    local f=array.flags.f_contiguous and not array.flags.c_contiguous
    local shape=array.shape
    local shape_text=table.concat(shape,', ')
    if #shape==1 then shape_text=shape_text..',' end
    local dtype=lr.dtype(array.dtype)
    local text=("{'descr': '%s', 'fortran_order': %s, 'shape': (%s), }")
        :format(dtype.str,f and 'True' or 'False',shape_text)
    if #shape>0 then
      text=text..(' '):rep(21-#tostring(f and shape[#shape] or shape[1]))
    end
    local length_format=length_formats[version]
    local prefix_size=#magic+2+string.packsize(length_format)
    local padding=64-((prefix_size+#text+1)%64)
    local payload=text..(' '):rep(padding)..'\n'
    if version==1 and #payload>65535 then error('NPY header exceeds format 1.0',3) end
    return magic..string.char(version,0)..string.pack(length_format,#payload)..payload,f
  end

  function lr.save(file,input,options)
    local version=option(options,'version')
    if version==nil then version=1 end
    if math.type(version)~='integer' or not length_formats[version] then
      error('NPY version must be 1, 2 or 3',2)
    end
    local array=lr.asanyarray(input)
    local header,fortran=make_header(array,version)
    with_file(file,'wb',true,function(handle)
      assert(handle:write(header))
      if fortran then lr.transpose(array):tofile(handle)
      else array:tofile(handle) end
    end)
  end

  local function loaded_shape(array,shape,order)
    if array.size==0 and #shape>1 then
      local strides={}
      local width=array.itemsize
      for d=#shape,1,-1 do
        strides[d]=width
        local extent=math.max(1,shape[d])
        if width>math.maxinteger//extent then error('NPY strides exceed native range',3) end
        width=width*extent
      end
      return lr.ndarray(shape,{dtype=array.dtype,buffer=array,strides=strides})
    end
    return lr.reshape(array,shape,{order=order})
  end

  function lr.load(file,options)
    local limit=option(options,'max_header_size')
    if limit==nil then limit=header_limit end
    if math.type(limit)~='integer' or limit<0 then
      error('NPY header limit must be a nonnegative Lua integer',2)
    end
    return with_file(file,'rb',false,function(handle)
      local tag=read_exact(handle,#magic+2)
      if tag:sub(1,#magic)~=magic then error('expected an NPY array stream',3) end
      local major,minor=tag:byte(-2,-1)
      local fmt=length_formats[major]
      if not fmt or minor~=0 then error('unsupported NPY version',3) end
      local length=string.unpack(fmt,read_exact(handle,string.packsize(fmt)))
      if length>limit then error('NPY header exceeds the configured limit',3) end
      local header=read_header(read_exact(handle,length))
      local dtype=lr.dtype(header.descr)
      local shape=header.shape
      local count=1
      for _,extent in ipairs(shape) do
        if extent~=0 and count>math.maxinteger//extent then
          error('NPY array size exceeds native range',3)
        end
        count=count*extent
      end
      local flat
      if dtype.itemsize==0 then
        flat=lr.ndarray({count},dtype)
      else
        flat=lr.fromfile(handle,{dtype=dtype,count=count})
        if flat.size~=count then error('truncated NPY array payload',3) end
      end
      if header.fortran_order then
        local reversed={}
        for i=#shape,1,-1 do reversed[#reversed+1]=shape[i] end
        return lr.transpose(loaded_shape(flat,reversed,'C'))
      end
      return loaded_shape(flat,shape,'C')
    end)
  end
end
