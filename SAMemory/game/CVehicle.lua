local shared = require 'SAMemory.shared'
shared.require 'CEntity'

shared.ffi.cdef[[
    typedef struct CVehicle {
        void *vtable;                 /* +0x00 */
        RwMatrix matrix;              /* +0x08 */
        unsigned char pad44[0x1C];    /* +0x44 */
        unsigned long long flags;     /* +0x60 */
        unsigned char pad68[4];       /* +0x68 */
        short model;                  /* +0x6C */
        unsigned char pad6E[0x46];    /* +0x6E..0xB3 */
        float dirtLevel;              /* +0xB4 */
        unsigned char padB8[0x20];    /* +0xB8..0xD7 */
        float velocityX;              /* +0xD8 */
        float velocityY;              /* +0xDC */
        float velocityZ;              /* +0xE0 */
        unsigned char padE4[0xEC];    /* +0xE4..0x1CF */
        void *occupants[5];           /* +0x1D0 */
        unsigned char pad1F8[0x20];   /* +0x1F8..0x217 */
        unsigned char passengerCount; /* +0x218 */
        unsigned char pad219[3];      /* +0x219..0x21B */
        unsigned char maxOccupants;   /* +0x21C */
        unsigned char pad21D[0x38];   /* +0x21D..0x254 */
        unsigned char engineBitfield; /* +0x255 */
        unsigned char pad256[0x4A];   /* +0x256..0x29F */
        union {
            float health;
            float m_fHealth;
        };                            /* +0x2A0 */
        unsigned char pad2A4[4];      /* +0x2A4..0x2A7 */
        union {
            int lockState;
            int m_nDoorLock;
        };                            /* +0x2A8 */
        unsigned char pad2AC[0x15];   /* +0x2AC..0x2C0 */
        unsigned char sirenState;     /* +0x2C1 */
        unsigned char pad2C2[0x56];   /* +0x2C2..0x317 */
        int subtype;                  /* +0x318 */
        unsigned char pad31C[0x93C];  /* +0x31C..0xC57 */
        void *componentSlots;         /* +0xC58 */
    } CVehicle;
]]

return true
