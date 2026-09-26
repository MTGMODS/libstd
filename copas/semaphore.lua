local copas = require("copas")

local DEFAULT_TIMEOUT = 10

local semaphore = {}
semaphore.__index = semaphore

local registry = setmetatable({}, { __mode="kv" })

function semaphore.new(max, start, seconds)
  local timeout = tonumber(seconds or DEFAULT_TIMEOUT) or -1
  if timeout < 0 then
    error("expected timeout (2nd argument) to be a number greater than or equal to 0, got: " .. tostring(seconds), 2)
  end
  if type(max) ~= "number" or max < 1 then
    error("expected max resources (1st argument) to be a number greater than 0, got: " .. tostring(max), 2)
  end

  local self = setmetatable({
      count = start or 0,
      max = max,
      timeout = timeout,
      q_tip = 1,
      q_tail = 1,
      queue = {},
      to_flags = setmetatable({}, { __mode = "k" }),
    }, semaphore)

  return self
end

do
  local destroyed_func = function()
    return nil, "destroyed"
  end

  local destroyed_semaphore_mt = {
    __index = function()
      return destroyed_func
    end
  }

  function semaphore:destroy()
    self:give(math.huge)
    self.destroyed = true
    setmetatable(self, destroyed_semaphore_mt)
    return true
  end
end

function semaphore:give(given)
  local err
  given = given or 1
  local count = self.count + given

  if count > self.max then
    count = self.max
    err = "too many"
  end

  while self.q_tip < self.q_tail do
    local i = self.q_tip
    local nxt = self.queue[i]
    if not nxt then
      self.q_tip = i + 1
    else
      if count >= nxt.requested then

        self.queue[i] = nil
        self.to_flags[nxt.co] = nil
        count = count - nxt.requested
        self.q_tip = i + 1
        copas.wakeup(nxt.co)
        nxt.co = nil
      else
        break
      end
    end
  end

  if self.q_tip == self.q_tail then
    self.queue = {}
    self.q_tip = 1
    self.q_tail = 1
  end

  self.count = count
  if err then
    return nil, err
  end
  return true
end

local function timeout_handler(co)
  local self = registry[co]

  if not self then
    return
  end

  for i = self.q_tip, self.q_tail do
    local item = self.queue[i]
    if item and co == item.co then
      self.queue[i] = nil
      self.to_flags[co] = true

      copas.wakeup(co)
      return
    end
  end

end

function semaphore:take(requested, timeout)
  requested = requested or 1
  if self.q_tail == 1 and self.count >= requested then

    self.count = self.count - requested
    return true
  end

  if requested > self.max then
    return nil, "too many"
  end

  local to = timeout or self.timeout
  if to == 0 then
    return nil, "timeout"
  end

  local co = coroutine.running()
  self.to_flags[co] = nil
  registry[co] = self
  copas.timeout(to, timeout_handler)

  self.queue[self.q_tail] = {
    co = co,
    requested = requested,

  }
  self.q_tail = self.q_tail + 1

  copas.pauseforever()
  registry[co] = nil

  if self.to_flags[co] then

    self.to_flags[co] = nil
    return nil, "timeout"
  end

  copas.timeout(0)

  if self.destroyed then
    return nil, "destroyed"
  end

  return true
end

function semaphore:get_count()
  return self.count
end

function semaphore:get_wait()
  local wait = 0
  for i = self.q_tip, self.q_tail - 1 do
    wait = wait + ((self.queue[i] or {}).requested or 0)
  end
  return wait - self.count
end

return semaphore
