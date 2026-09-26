local shared = require 'SAMemory.shared'
shared.require 'CEntity'

shared.ffi.cdef[[
    typedef CEntity CPlaceable;
]]

return true
