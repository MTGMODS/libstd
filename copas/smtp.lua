local copas = require("copas")
local smtp = require("socket.smtp")
local socket = require("socket")

local create = function() return copas.wrap(socket.tcp()) end
local forwards = {
  PORT = true,
  SERVER = true,
  TIMEOUT = true,
  DOMAIN = true,
  TIMEZONE = true
}

copas.smtp = setmetatable({}, {

    __index = smtp,

    __newindex = function(self, key, value)
        if forwards[key] then smtp[key] = value return end
        return rawset(self, key, value)
      end,
    })
local _M = copas.smtp

_M.send = function(mailt)
  mailt.create = mailt.create or create
  return smtp.send(mailt)
end

return _M
