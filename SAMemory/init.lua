local native = require 'NeoSAMemory'
local shared = require 'SAMemory.shared'
local ffi = shared.ffi

shared.require 'vector3d'
shared.require 'CEntity'
shared.require 'CPed'
shared.require 'CVehicle'
shared.require 'CCamera'
shared.require 'CCam'

local module = native
module._ver = 'unified-libag-client-1'
module.ffi = ffi
module.cast = ffi.cast
module.nullptr = ffi.cast('void *', 0)
module.require = function(name)
    return shared.require(name)
end

local playerPed = native.GetLocalPed()
local playerVehicle = native.GetLocalVehicle()
module.player_ped = playerPed ~= 0 and ffi.cast('CPed *', playerPed) or nil
module.player_vehicle = playerVehicle ~= 0 and ffi.cast('CVehicle *', playerVehicle) or nil

local camMgr = nil
if type(native.GetCameraManager) == 'function' then
    camMgr = native.GetCameraManager()
elseif native.camera and native.camera.manager then
    if type(native.camera.manager) == 'function' then
        camMgr = native.camera.manager()
    else
        camMgr = native.camera.manager
    end
end

if camMgr and camMgr ~= 0 then
    local cameraPtr = ffi.cast('CCamera *', camMgr)
    local cameraTable = {
        manager = camMgr,
        aCams = cameraPtr.aCams,
        m_asCams = cameraPtr.m_asCams,
    }
    setmetatable(cameraTable, {
        __index = function(_, key)
            if key == 'pRwCamera' then
                if MONET_GTASA_BASE and MONET_GTASA_BASE ~= 0 then
                    local ok, rwCamPtr = pcall(function()
                        return ffi.cast('uintptr_t*', MONET_GTASA_BASE + 0x27C8140)[0]
                    end)
                    if ok and rwCamPtr and rwCamPtr ~= 0 then
                        pcall(ffi.cdef, [[
                            typedef struct RwV2d { float x, y; } RwV2d;
                            typedef struct RwCamera {
                                uint8_t pad[56];
                                RwV2d viewWindow;
                                float nearplane;
                                float farplane;
                            } RwCamera;
                        ]])
                        local ok_c, res = pcall(ffi.cast, 'RwCamera*', rwCamPtr)
                        if ok_c then return res end
                    end
                end
                return nil
            end
            local ok, val = pcall(function() return cameraPtr[key] end)
            return ok and val or nil
        end
    })
    module.camera = cameraTable
else
    module.camera = native.camera
end

return module
