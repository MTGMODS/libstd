local copas = require("copas")
local socket = require("socket")
local ftp = require("socket.ftp")
local ltn12 = require("ltn12")
local url = require("socket.url")

local create = function() return copas.wrap(socket.tcp()) end
local forwards = {
  PORT = true,
  TIMEOUT = true,
  PASSWORD = true,
  USER = true
}

copas.ftp = setmetatable({}, {

    __index = ftp,

    __newindex = function(self, key, value)
        if forwards[key] then ftp[key] = value return end
        return rawset(self, key, value)
      end,
    })
local _M = copas.ftp

local default = {
    path = "/",
    scheme = "ftp"
}

local function parse(u)
    local t = socket.try(url.parse(u, default))
    socket.try(t.scheme == "ftp", "wrong scheme '" .. t.scheme .. "'")
    socket.try(t.host, "missing hostname")
    local pat = "^type=(.)$"
    if t.params then
        t.type = socket.skip(2, string.find(t.params, pat))
        socket.try(t.type == "a" or t.type == "i",
            "invalid type '" .. t.type .. "'")
    end
    return t
end

_M.parseRequest = function(u, body)
  local t = parse(u)
  if body then
    t.source = ltn12.source.string(body)
  else
    t.target = {}
    t.sink = ltn12.sink.table(t.target)
  end
end

_M.put = socket.protect(function(putt, body)
    if type(putt) == "string" then
      putt = _M.parseRequest(putt, body)
      _M.put(putt)
      return table.concat(putt.target)
    else
      putt.create = putt.create or create
      return ftp.put(putt)
    end
end)

_M.get = socket.protect(function(gett)
    if type(gett) == "string" then
      gett = _M.parseRequest(gett)
      _M.get(gett)
      return table.concat(gett.target)
    else
      gett.create = gett.create or create
      return ftp.get(gett)
    end
end)

_M.command = function(cmdt)
  cmdt.create = cmdt.create or create
  return ftp.command(cmdt)
end

return _M
