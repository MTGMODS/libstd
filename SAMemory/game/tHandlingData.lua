local shared = require 'SAMemory.shared'
shared.require 'vector3d'

shared.ffi.cdef[[
    typedef struct cTransmissionData {
        unsigned char m_nDriveType;
        unsigned char m_nEngineType;
        unsigned char m_nNumberOfGears;
        unsigned char m_nHandlingFlags;
        float m_fEngineAcceleration;
        float m_fEngineInertia;
        float m_fMaxGearVelocity;
        float m_fMinGearVelocity;
        float m_fCurrentVelocity;
    } cTransmissionData;

    typedef struct tHandlingData {
        int m_nVehicleId;
        float m_fMass;
        float m_fTurnMass;
        float m_fDragMult;
        vector3d m_vecCentreOfMass;
        unsigned char m_nPercentSubmerged;
        unsigned char pad1D[3];
        float m_fBuoyancyConstant;
        float m_fTractionMultiplier;
        cTransmissionData m_transmissionData;
        float m_fBrakeDeceleration;
        float m_fBrakeBias;
        char m_bSteeringLock;
        unsigned char pad4D[3];
        float m_fTractionLoss;
        float m_fTractionBias;
        float m_fSuspensionForceLevel;
        float m_fSuspensionDampingLevel;
        float m_fSuspensionHighSpdComDamp;
        float m_fSuspensionUpperLimit;
        float m_fSuspensionLowerLimit;
        float m_fSuspensionBiasBetweenFrontAndRear;
        float m_fSuspensionAntiDiveMultiplier;
        float m_fCollisionDamageMultiplier;
        unsigned int m_nModelFlags;
        unsigned int m_nHandlingFlags;
        float m_fSeatOffsetDistance;
        unsigned int m_nMonetaryValue;
        unsigned char m_nFrontLights;
        unsigned char m_nRearLights;
        unsigned char m_nAnimGroup;
        unsigned char pad83[1];
    } tHandlingData;
]]

return true
