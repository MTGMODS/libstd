local shared = require 'SAMemory.shared'
shared.require 'CCam'

shared.ffi.cdef[[
    typedef struct CCamera {
        float right[3];               /* +0x00 */
        unsigned int pad0;            /* +0x0C */
        float up[3];                  /* +0x10 */
        unsigned int pad1;            /* +0x1C */
        float forward[3];             /* +0x20 */
        unsigned int pad2;            /* +0x2C */
        float pos[3];                 /* +0x30 */
        unsigned int pad3;            /* +0x3C */
        unsigned char pad40[0x148];   /* +0x40..0x187 */
        union {
            CCam aCams[3];
            CCam m_asCams[3];
        };                            /* +0x188 */
    } CCamera;
]]

return true
