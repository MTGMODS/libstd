local copas = require("copas")
local gettime = require("socket").gettime

local DEFAULT_TIMEOUT = 10

local lock = {}
lock.__index = lock

local registry = setmetatable({}, { __mode="kv" })

function lock.new(seconds, not_reentrant)
  local timeout = tonumber(seconds or DEFAULT_TIMEOUT) or -1
  if timeout < 0 then
    error("expected timeout (1st argument) to be a number greater than or equal to 0, got: " .. tostring(seconds), 2)
  end
  return setmetatable({
            timeout = timeout,
            not_reentrant = not_reentrant,
            queue = {},
            q_tip = 0,
            q_tail = 0,
            owner = nil,
            call_count = nil,
            errors = setmetatable({}, { __mode = "k" }),
          }, lock)
end

do
  local destroyed_func = function()
    return nil, "destroyed"
  end

  local destroyed_lock_mt = {
    __index = function()
      return destroyed_func
    end
  }

  function lock:destroy()

    for i = self.q_tip, self.q_tail do
      local co = self.queue[i]
      self.queue[i] = nil

      if co then
        self.errors[co] = "destroyed"

        copas.wakeup(co)
      end
    end

    if self.owner then
      self.errors[self.owner] = "destroyed"

    end
    self.queue = {}
    self.q_tip = 0
    self.q_tail = 0
    self.destroyed = true

    setmetatable(self, destroyed_lock_mt)
    return true
  end
end

local function timeout_handler(co)
  local self = registry[co]
  if not self then
    return
  end

  for i = self.q_tip, self.q_tail do
    if co == self.queue[i] then
      self.queue[i] = nil
      self.errors[co] = "timeout"

      copas.wakeup(co)
      return
    end
  end

end

function lock:get(timeout)
  local co = coroutine.running()
  local start_time

  if self.owner then

    if co == self.owner and not self.not_reentrant then
      self.call_count = self.call_count + 1
      return 0
    end

    self.queue[self.q_tail] = co
    self.q_tail = self.q_tail + 1
    timeout = timeout or self.timeout
    if timeout == 0 then
      return nil, "timeout", 0
    end

    registry[co] = self
    copas.timeout(timeout, timeout_handler)

    start_time = gettime()
    copas.pauseforever()

    local err = self.errors[co]
    self.errors[co] = nil
    registry[co] = nil

    if err ~= "timeout" then
      copas.timeout(0)
    end
    if err then
      return nil, err, gettime() - start_time
    end
  end

  self.owner = co
  self.call_count = 1
  return start_time and (gettime() - start_time) or 0
end

function lock:release()
  local co = coroutine.running()

  if co ~= self.owner then
    return nil, "cannot release a lock not owned"
  end

  self.call_count = self.call_count - 1
  if self.call_count > 0 then

    return true
  end

  while self.q_tip < self.q_tail do
    local next_up = self.queue[self.q_tip]
    if next_up then
      self.owner = next_up
      self.queue[self.q_tip] = nil
      self.q_tip = self.q_tip + 1
      copas.wakeup(next_up)
      return true
    end
    self.q_tip = self.q_tip + 1
  end

  self.owner = nil
  self.q_tip = 0
  self.q_tail = 0
  return true
end

return lock
