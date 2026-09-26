local shared = require 'SAMemory.shared'
shared.require 'CEntity'

shared.ffi.cdef[[
    typedef struct CPhysical {
        void *vtable;                 /* +0x00 */
        RwMatrix matrix;              /* +0x08 */
        unsigned char pad44[0x78];    /* +0x44..0xBB */
        float gravity;                /* +0xBC */
        unsigned char padC0[0x18];    /* +0xC0..0xD7 */
        float velocityX;              /* +0xD8 */
        float velocityY;              /* +0xDC */
        float velocityZ;              /* +0xE0 */
        unsigned char padE4[0x3C];    /* +0xE4..0x11F */
        float mass;                   /* +0x120 */
        unsigned char pad124[0x0C];   /* +0x124..0x12F */
        float restitution;            /* +0x130 */
        unsigned char pad134[0x04];   /* +0x134..0x137 */
    } CPhysical;
]]

return true
