local ffi = require 'ffi'
local native = rawget(_G, 'SAMemory')

local module = {
    ffi = ffi,
    gta = native and native.gta or {},
    engine = native,
}

function module.require(name)
    local ok, res = pcall(require, 'SAMemory.game.' .. name)
    if ok then
        return res
    end
    return setmetatable({}, {
        __index = function(t, k)
            return nil
        end
    })
end

function module.validate_size(_, _)
    return true
end

return module
