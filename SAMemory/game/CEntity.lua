local shared = require 'SAMemory.shared'
shared.require 'vector3d'

shared.ffi.cdef[[
    typedef struct RwMatrix {
        vector3d right;               /* +0x00 */
        unsigned int padRight;        /* +0x0C */
        vector3d up;                  /* +0x10 */
        unsigned int padUp;           /* +0x1C */
        vector3d at;                  /* +0x20 */
        unsigned int padAt;            /* +0x2C */
        vector3d pos;                 /* +0x30 */
        unsigned int padPos;           /* +0x3C */
    } RwMatrix;

    typedef struct CEntity {
        void *vtable;                 /* +0x00 */
        RwMatrix matrix;              /* +0x08 */
        unsigned char pad44[0x1C];    /* +0x44 */
        unsigned long long flags;     /* +0x60 */
        unsigned char pad68[4];       /* +0x68 */
        short model;                  /* +0x6C */
        unsigned char pad6E[2];       /* +0x6E */
    } CEntity;
]]

return true
