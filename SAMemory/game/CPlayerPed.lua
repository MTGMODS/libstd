local shared = require 'SAMemory.shared'
shared.require 'CPed'

shared.ffi.cdef[[
    typedef CPed CPlayerPed;
]]

return true
