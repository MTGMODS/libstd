local shared = require 'SAMemory.shared'
shared.require 'CEntity'

shared.ffi.cdef[[
    typedef struct CPed {
        void *vtable;                 /* +0x00 */
        RwMatrix matrix;              /* +0x08 */
        unsigned char pad44[0x1C];    /* +0x44 */
        unsigned long long flags;     /* +0x60 */
        unsigned char pad68[4];       /* +0x68 */
        short model;                  /* +0x6C */
        unsigned char pad6E[0xE6];    /* +0x6E..0x153 */
        union {
            float health;
            float m_fHealth;
        };                            /* +0x154 */
        union {
            float maxHealth;
            float m_fMaxHealth;
        };                            /* +0x158 */
        union {
            float armour;
            float m_fArmour;
        };                            /* +0x15C */
        unsigned char pad160[0x250];  /* +0x160..0x3AF */
        union {
            float facingAngle;
            float m_fCurrentRotation;
        };                            /* +0x3B0 */
        float facingAngle2;           /* +0x3B4 */
        unsigned char pad3B8[0xA8];   /* +0x3B8..0x45F */
        union {
            void *vehicle;
            void *m_pVehicle;
        };                            /* +0x460 */
        unsigned char inVehicle;      /* +0x468 */
    } CPed;
]]

return true
