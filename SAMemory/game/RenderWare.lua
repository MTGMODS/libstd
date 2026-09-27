local shared = require 'SAMemory.shared'

shared.ffi.cdef[[
    typedef struct RwV3d {
        float x, y, z;
    } RwV3d;
    typedef struct RwMatrix {
        RwV3d right;
        uint32_t flags;
        RwV3d up;
        uint32_t pad1;
        RwV3d at;
        uint32_t pad2;
        RwV3d pos;
        uint32_t pad3;
    } RwMatrix;
]]

return true
