local ffi = require 'ffi'
require 'SAMemory.game.vector3d'

ffi.cdef[[
    typedef struct quaternion {
        vector3d imag;
        float real;
    } quaternion;
]]

local meta = {}
function meta.__index(a, key)
    if key == 'dot_product' then
        return function(_, b)
            return a.imag.x * b.imag.x + a.imag.y * b.imag.y +
                a.imag.z * b.imag.z + a.real * b.real
        end
    end
    return nil
end

ffi.metatype('quaternion', meta)
return {new = function(imag, real) return ffi.new('quaternion', imag, real) end}
