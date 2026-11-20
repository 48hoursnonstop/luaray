-- NumPy 2.5.5 datetime_busday.c and datetime_busdaycal.c.
return function(lr)
  local calendars=setmetatable({},{__mode='k'})
  local names={Mon=1,Tue=2,Wed=3,Thu=4,Fri=5,Sat=6,Sun=7}

  local calendar_methods={
    __name='luaray.busdaycalendar',
    __metatable=false,
    __newindex=function() error('business day calendars are immutable',2) end,
    __index=function(calendar,key)
      local state=calendars[calendar]
      if key=='weekmask' or key=='holidays' then return lr.copy(state[key]) end
    end,
  }

  local function parse_weekmask(input)
    if input==nil then input='1111100' end
    local mask
    if type(input)=='string' then
      local days={false,false,false,false,false,false,false}
      if #input==7 and input:match('^[01]+$') then
        for i=1,7 do days[i]=input:sub(i,i)=='1' end
      else
        local i=1
        while i<=#input do
          local c=input:sub(i,i)
          if c:match('%s') then i=i+1
          else
            local day=names[input:sub(i,i+2)]
            if not day then error('invalid business day weekmask string',3) end
            days[day]=true
            i=i+3
          end
        end
      end
      mask=lr.array(days,'bool')
    else
      mask=lr.array(input,{dtype='bool',copy=true})
      if mask.ndim~=1 or mask.size~=7 then error('weekmask requires seven values',3) end
    end
    if not lr.any(mask) then error('weekmask must include a business day',3) end
    return mask
  end

  local function days(input,casting)
    if type(input)=='userdata' and input.ndim~=nil then
      if not lr.can_cast(input.dtype,'datetime64[D]',casting) then
        error('dates cannot be cast to datetime64[D]',3)
      end
      return lr.asanyarray(input,{dtype='datetime64[D]'})
    end
    return lr.array(input,'datetime64[D]')
  end

  local function weekdays(dates,weekmask)
    local ticks=dates:view('int64')
    local weekday=lr.remainder(lr.add(lr.remainder(ticks,7),3),7)
    local active=lr.take(weekmask,lr.add(weekday,1))
    return lr.asanyarray(lr.logical_and(active,lr.logical_not(lr.isnat(dates))))
  end

  local function settings(cfg,query)
    if cfg==nil then return {} end
    if type(cfg)~='table' then error('business day options must be a table',3) end
    for key in pairs(cfg) do
      if key~='weekmask' and key~='holidays' and
          (not query or (key~='calendar' and key~='out')) then
        error('unknown business day option',3)
      end
    end
    return cfg
  end

  local function calendar_data(config)
    local weekmask=parse_weekmask(config.weekmask)
    local holidays=lr.empty({0},'datetime64[D]')
    if config.holidays~=nil then
      local dates=days(config.holidays,'safe')
      if dates.ndim~=1 then error('holidays must be a one-dimensional sequence',3) end
      holidays=lr.unique(dates:get(weekdays(dates,weekmask)))
    end
    return {weekmask=weekmask,holidays=holidays}
  end

  function lr.busdaycalendar(options)
    local calendar=setmetatable({},calendar_methods)
    calendars[calendar]=calendar_data(settings(options,false))
    return calendar
  end

  function lr.is_busday(input,options)
    local config=settings(options,true)
    local calendar=config.calendar
    local state
    if calendar~=nil then
      state=calendars[calendar]
      if not state then error('calendar must be a business day calendar',2) end
      if config.weekmask~=nil or config.holidays~=nil then
        error('calendar already defines the weekmask and holidays',2)
      end
    else
      state=calendar_data(config)
    end
    local dates=days(input,'safe')
    local result=weekdays(dates,state.weekmask)
    if state.holidays.size>0 then
      local is_holiday=lr.isin(dates,state.holidays)
      result=lr.asanyarray(lr.logical_and(result,lr.logical_not(is_holiday)))
    end
    if config.out~=nil then
      local out=config.out
      if type(out)~='userdata' or out.ndim==nil then error('out must be an ndarray',2) end
      lr.copyto(out,result,'safe')
      return out
    end
    if result.ndim==0 then return result:item() end
    local ordered=lr.empty_like(dates,{dtype='bool',order='K'})
    lr.copyto(ordered,result,'no')
    return ordered
  end
end
