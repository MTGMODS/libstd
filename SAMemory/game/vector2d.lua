local ffi = require 'ffi'

ffi.cdef[[
    typedef struct vector2d {
        float x;
        float y;
    } vector2d;
]]

local meta = {}
function meta.__add(a, b) return vector2d(a.x + b.x, a.y + b.y) end
function meta.__sub(a, b) return vector2d(a.x - b.x, a.y - b.y) end
function meta.__unm(a) return vector2d(-a.x, -a.y) end
function meta.__mul(a, b)
    if type(a) == 'number' then return vector2d(b.x * a, b.y * a) end
    return vector2d(a.x * b, a.y * b)
end
function meta.__div(a, b) return vector2d(a.x / b, a.y / b) end
function meta.__len(a) return math.sqrt(a.x * a.x + a.y * a.y) end
function meta.__index(a, key)
    if key == 'len' or key == 'length' or key == 'magnitude' then
        return function() return #a end
    end
    return nil
end

ffi.metatype('vector2d', meta)
return {new = vector2d}
