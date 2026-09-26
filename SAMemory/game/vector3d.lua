local ffi = require 'ffi'

ffi.cdef[[
    typedef struct vector3d {
        float x;
        float y;
        float z;
    } vector3d;
]]

local meta = {}
function meta.__add(a, b) return vector3d(a.x + b.x, a.y + b.y, a.z + b.z) end
function meta.__sub(a, b) return vector3d(a.x - b.x, a.y - b.y, a.z - b.z) end
function meta.__unm(a) return vector3d(-a.x, -a.y, -a.z) end
function meta.__mul(a, b)
    if type(a) == 'number' then return vector3d(b.x * a, b.y * a, b.z * a) end
    return vector3d(a.x * b, a.y * b, a.z * b)
end
function meta.__len(a) return math.sqrt(a.x * a.x + a.y * a.y + a.z * a.z) end
function meta.__index(a, key)
    if key == 'len' or key == 'length' then
        return function() return #a end
    end
    return nil
end

ffi.metatype('vector3d', meta)
return vector3d
