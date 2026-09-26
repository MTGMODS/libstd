local mimgui = require("mimgui")

local compat = {}
local process = false
local onDrawFrame = nil
local frameToken = nil

setmetatable(compat, {
    __index = function(t, k)
        if k == "Process" then
            return process
        elseif k == "OnDrawFrame" then
            return onDrawFrame
        end
        return mimgui[k]
    end,
    __newindex = function(t, k, v)
        if k == "Link" then
            return
        elseif k == "Process" then
            process = (v == true)
        elseif k == "OnDrawFrame" then
            onDrawFrame = v
            if not frameToken and v then
                frameToken = mimgui.OnFrame(
                    function() return process end,
                    function(sub)
                        sub.HideCursor = not compat.ShowCursor
                        sub.LockPlayer = compat.LockPlayer
                    end,
                    function()
                        if onDrawFrame then
                            onDrawFrame()
                        end
                    end
                )
            end
        else
            rawset(t, k, v)
        end
    end
})

compat.ShowCursor = false
compat.LockPlayer = false
compat.RenderInMenu = false

compat.Begin = function(name, p_open, flags)
    if type(p_open) == "boolean" then
        local b = mimgui.new.bool(p_open)
        local visible = mimgui.Begin(name, b, flags)
        return visible, b[0]
    end
    return mimgui.Begin(name, p_open, flags)
end

compat.BeginTabItem = function(label, p_open, flags)
    if type(p_open) == "boolean" then
        local b = mimgui.new.bool(p_open)
        local visible = mimgui.BeginTabItem(label, b, flags)
        return visible, b[0]
    end
    return mimgui.BeginTabItem(label, p_open, flags)
end

return compat
