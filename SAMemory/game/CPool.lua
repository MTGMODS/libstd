local shared = require 'SAMemory.shared'

shared.ffi.cdef[[
    typedef struct CPool {
        void* m_pObjects;
        uint8_t* m_pFlags;
        int32_t m_nSize;
        int32_t m_nFirstFree;
        bool m_bOwnsAllocations;
        bool m_bFieldA;
    } CPool;
]]

return true
