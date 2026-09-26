local ffi = require("ffi")
local env = require("android.jnienv")
local jni = require("android.jni-raw")
local envu = require("android.jnienv-util")

local file = getWorkingDirectory() .. "/lib/android/jar/arzapi.jar"

local activity = jni.activity
if not activity or (ffi.istype("void*", activity) and activity == nil) then
    error("Android Activity handle is not available for Arizona API")
end

local code, class, cldr = envu.InjectJar(file, "monetloader/ArizonaAPI", "init", "(Lcom/arizona/game/GTASA;)V", activity)
if not code then error(class or "Failed to inject Arizona API JAR") end
if not class or not cldr then error("Arizona API JAR injection returned incomplete handles") end

local M = {
    cldr = ffi.cast('jclass', env.NewGlobalRef(cldr))
}
env.DeleteLocalRef(cldr)

function M.closeCurrentDialog()
    envu.CallStaticVoidMethod(class, "closeCurrentDialog", "()V")
end

function M.createNotification(title, content)
    envu.CallStaticVoidMethod(class, "createNotification", "(Ljava/lang/String;Ljava/lang/String;)V", env.NewStringUTF(title), env.NewStringUTF(content))
end

function M.sampCloseCurrentDialogWith(button, listview, input)
    listview = listview or -1
    input = input or ''
    sampSendDialogResponse(sampGetCurrentDialogId(), button, listview, input)
    M.closeCurrentDialog()
end

function M.sampCloseCurrentDialogWithButton(button)
    M.sampCloseCurrentDialogWith(button)
end

return M
