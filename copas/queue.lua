local copas = require "copas"
local Sema = copas.semaphore
local Lock = copas.lock

local Queue = {}
Queue.__index = Queue

local new_name do
  local count = 0

  function new_name()
    count = count + 1
    return "copas_queue_" .. count
  end
end

function Queue.new(opts)
  opts = opts or {}
  local self = {}
  setmetatable(self, Queue)
  self.name = opts.name or new_name()
  self.sema = Sema.new(10^9)
  self.head = 1
  self.tail = 1
  self.list = {}
  self.workers = setmetatable({}, { __mode = "k" })
  self.stopping = false
  self.worker_id = 0
  return self
end

function Queue:push(item)
  if self.stopping then
    return nil, "stopping"
  end
  self.list[self.head] = item
  self.head = self.head + 1
  self.sema:give()
  return true
end

function Queue:pop(timeout)
  local ok, err = self.sema:take(1, timeout)
  if not ok then
    return ok, err
  end

  local item = self.list[self.tail]
  self.list[self.tail] = nil
  self.tail = self.tail + 1

  if self.tail == self.head then

    self.list = {}
    self.tail = 1
    self.head = 1
    if self.stopping then

      self:destroy()
    end
  end
  return item
end

function Queue:get_size()
  return self.head - self.tail
end

function Queue:stop()
  if not self.stopping then
    self.stopping = true
    self.lock = Lock.new(nil, true)
    self.lock:get()
    if self:get_size() == 0 then

      self:destroy()
    end
  end
  return true
end

function Queue:finish(timeout, no_destroy_on_timeout)
  self:stop()
  local _, err = self.lock:get(timeout)

  if err == "timeout" then
    if not no_destroy_on_timeout then
      self:destroy()
    end
    return nil, err
  end
  return true
end

do
  local destroyed_func = function()
    return nil, "destroyed"
  end

  local destroyed_queue_mt = {
    __index = function()
      return destroyed_func
    end
  }

  function Queue:destroy()
    if self.lock then
      self.lock:destroy()
    end
    self.sema:destroy()
    setmetatable(self, destroyed_queue_mt)

    for key in pairs(self.list) do
      self.list[key] = nil
    end

    return true
  end
end

function Queue:add_worker(worker)
  assert(type(worker) == "function", "expected worker to be a function")
  local coro

  self.worker_id = self.worker_id + 1
  local worker_name = self.name .. ":worker_" .. self.worker_id

  coro = copas.addnamedthread(worker_name, function()
    while true do
      local item, err = self:pop(math.huge)
      if err then
        break
      end
      worker(item)
    end
    self.workers[coro] = nil
  end)

  self.workers[coro] = true
  return coro
end

function Queue:get_workers()
  local lst = {}
  for coro in pairs(self.workers) do
    if coroutine.status(coro) ~= "dead" then
      lst[#lst+1] = coro
    end
  end
  return lst
end

return Queue
