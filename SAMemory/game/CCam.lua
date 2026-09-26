local shared = require 'SAMemory.shared'

shared.ffi.cdef[[
    typedef struct CCam {
        void *vtable;                 /* +0x00 */
        unsigned char pad08[6];       /* +0x08 */
        union {
            unsigned short nMode;
            unsigned short m_nMode;
        };                            /* +0x0E */
        unsigned char pad10[0x1E8];   /* +0x10..0x1F7 */
    } CCam;
]]

return true
