local default_now
if ngx then
  default_now = ngx.now
else
  local ok, socket = pcall(require, "socket")
  if ok then
    default_now = socket.gettime
  else
    default_now = nil
  end
end

local ok, new_tab = pcall(require, "table.new")
if not ok then
  new_tab = function(narr, nrec) return {} end
end

local default_err_handler = function(err)
  io.stderr:write(debug.traceback("TimerWheel callback failed with: " .. tostring(err)).."\n")
end

local math_floor = math.floor
local math_huge = math.huge
local EMPTY = {}

local _M = {}

function _M.new(opts)
  assert(opts ~= _M, "new should not be called with colon ':' notation")

  opts = opts or EMPTY
  assert(type(opts) == "table", "expected options to be a table")

  local precision = opts.precision or 0.050
  local ringsize  = opts.ringsize or 72000
  local now       = opts.now or default_now
  local err_handler = opts.err_handler or default_err_handler
  opts = nil

  assert(type(precision) == "number" and precision > 0,
    "expected 'precision' to be number > 0")
  assert(type(ringsize) == "number" and ringsize > 0 and math_floor(ringsize) == ringsize,
    "expected 'ringsize' to be an integer number > 0")
  assert(type(now) == "function",
    "expected 'now' to be a function, got: " .. type(now))
  assert(type(err_handler) == "function",
    "expected 'err_handler' to be a function, got: " .. type(err_handler))

  local start     = now()
  local position  = 1
  local id_count  = 0
  local id_list   = {}
  local rings     = {}
  local rings_n   = 0
  local count     = 0
  local wheel     = {}

  local tables    = {}
  local tables_n  = 0

  function wheel:step()
    local new_position = math_floor((now() - start) / precision) + 1
    local ring = rings[1] or EMPTY

    while position < new_position do

      local slot = ring[position]
      ring[position] = nil

      position = position + 1
      if position > ringsize then

        for i = 1, rings_n do

          rings[i] = rings[i + 1]
        end
        rings_n = rings_n - 1

        ring = rings[1] or EMPTY
        start = start + ringsize * precision
        position = 1
        new_position = new_position - ringsize
      end

      if slot then

        local ids = slot.ids
        local args = slot.arg
        for i = 1, slot.n do
          local id  = slot[i];  slot[i]  = nil; slot[id] = nil
          local cb  = ids[id];  ids[id]  = nil
          local arg = args[id]; args[id] = nil
          id_list[id] = nil
          count = count - 1
          xpcall(cb, err_handler, arg)
        end

        slot.n = 0

        tables_n = tables_n + 1
        tables[tables_n] = slot
      end

    end
    return true
  end

  function wheel:count()
    return count
  end

  function wheel:set(expire_in, cb, arg)
    local time_expire = now() + expire_in
    local pos = math_floor((time_expire - start) / precision) + 1
    if pos < position then

      pos = position
    end
    local ring_idx = math_floor((pos - 1) / ringsize) + 1
    local slot_idx = pos - (ring_idx - 1) * ringsize

    local ring = rings[ring_idx]
    if not ring then
      ring = new_tab(ringsize, 0)
      rings[ring_idx] = ring
      if ring_idx > rings_n then
        rings_n = ring_idx
      end
    end

    local slot = ring[slot_idx]
    if not slot then
      if tables_n == 0 then
        slot = { n = 0, ids = {}, arg = {} }
      else
        slot = tables[tables_n]
        tables_n = tables_n - 1
      end
      ring[slot_idx] = slot
    end

    local id = id_count - 1
    id_count = id

    slot.ids[id] = cb or error("the callback parameter is required", 2)
    slot.arg[id] = arg
    local idx = slot.n + 1
    slot.n = idx
    slot[idx] = id
    slot[id] = idx
    id_list[id] = slot
    count = count + 1

    return id
  end

  function wheel:cancel(id)
    local slot = id_list[id]
    if slot then
      local idx = slot[id]
      slot[id] = nil
      slot.ids[id] = nil
      slot.arg[id] = nil
      local n = slot.n
      if idx ~= n then
        local moved_id = slot[n]
        slot[idx] = moved_id
        slot[moved_id] = idx
      end
      slot[n] = nil
      slot.n = n - 1
      id_list[id] = nil
      count = count - 1
      return true
    end
    return false
  end

  function wheel:peek(max_ahead)
    if count == 0 then
      return nil
    end
    local time_now = now()

    if max_ahead then
      max_ahead = math_floor((time_now + max_ahead - start) / precision)
    else
      max_ahead = math_huge
    end

    local position_idx = position
    local ring_idx = 1
    local ring = rings[ring_idx] or EMPTY
    local ahead_count = 0
    while ahead_count < max_ahead do

      local slot = ring[position_idx]
      if slot then
        if slot[1] then

          return ((ring_idx - 1) * ringsize + position_idx) * precision +
                 start - time_now
        end
      end

      position_idx = position_idx + 1
      ahead_count = ahead_count + 1
      if position_idx > ringsize then
        position_idx = 1
        ring_idx = ring_idx + 1
        ring = rings[ring_idx] or EMPTY
      end
    end

    return nil
  end

  if _G._TEST then

    wheel._tables = tables
  end

  return wheel
end

return _M
