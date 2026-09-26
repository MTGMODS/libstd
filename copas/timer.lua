local copas = require("copas")

local xpcall = xpcall
local coroutine_running = coroutine.running

if _VERSION=="Lua 5.1" and not jit then
  xpcall = require("coxpcall").xpcall
  coroutine_running = require("coxpcall").running
end

local timer = {}
timer.__index = timer

local new_name do
  local count = 0

  function new_name()
    count = count + 1
    return "copas_timer_" .. count
  end
end

do
  local function expire_func(self, initial_delay)
    if self.errorhandler then
      copas.seterrorhandler(self.errorhandler)
    end
    copas.pause(initial_delay)
    while true do
      if not self.cancelled then
        if not self.recurring then

          self.cancelled = true
          self.co = nil

          self:callback(self.params)
          return

        else

          self:callback(self.params)
        end
      end

      if self.cancelled then

        self.co = nil
        self.cancelled = true
        return
      end

      copas.pause(self.delay)
    end
  end

  function timer:arm(initial_delay)
    assert(initial_delay == nil or initial_delay >= 0, "delay must be greater than or equal to 0")
    if self.co then
      return nil, "already armed"
    end

    self.cancelled = false
    self.co = copas.addnamedthread(self.name, expire_func, self, initial_delay or self.delay)
    return self
  end
end

function timer:cancel()
  if not self.co then
    return nil, "not armed"
  end

  if self.cancelled then
    return nil, "already cancelled"
  end

  self.cancelled = true
  copas.wakeup(self.co)
  copas.removethread(self.co)
  self.co = nil
  return self
end

do

  local ehandler = function(err_obj)
    return copas.geterrorhandler()(err_obj, coroutine_running(), nil)
  end

  function timer.new(opts)
    assert(opts.delay or -1 >= 0, "delay must be greater than or equal to 0")
    assert(type(opts.callback) == "function", "expected callback to be a function")

    local callback = function(timer_obj, params)
      xpcall(opts.callback, ehandler, timer_obj, params)
    end

    return setmetatable({
      name = opts.name or new_name(),
      delay = opts.delay,
      callback = callback,
      recurring = not not opts.recurring,
      params = opts.params,
      cancelled = false,
      errorhandler = opts.errorhandler,
    }, timer):arm(opts.initial_delay)
  end
end

return timer
