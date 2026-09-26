local ffi = require 'ffi'
local native = rawget(_G, 'SAMemory')

local module = {
    ffi = ffi,
    gta = native and native.gta or {},
    engine = native,
}

function module.require(name)
    return require('SAMemory.game.' .. name)
end

function module.validate_size(_, _)
    return true
end

return module
