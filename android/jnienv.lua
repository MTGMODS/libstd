local JNIEnv = {}
local ffi = require("ffi")
local jni = require("android.jni-raw")
local C = jni.const

function JNIEnv.checkExceptions()
    if JNIEnv.ExceptionCheck() == C.JNI_TRUE then
        local e = JNIEnv.ExceptionOccurred()
        JNIEnv.ExceptionClear()

        if e == nil then
            error("ExceptionCheck() returned JNI_TRUE but ExceptionOccurred() returned nil")
        end

        local clazz = JNIEnv.GetObjectClass(e)
        local getMessage = JNIEnv.GetMethodID(clazz, "getMessage", "()Ljava/lang/String;")
        local message = JNIEnv.CallObjectMethod(e, getMessage)
        local mstr = JNIEnv.GetStringUTFChars(message, nil)

        local msg = ffi.string(mstr)
        JNIEnv.ReleaseStringUTFChars(message, mstr)
        JNIEnv.DeleteLocalRef(message)
        JNIEnv.DeleteLocalRef(clazz)
        JNIEnv.DeleteLocalRef(e)

        error(msg)
    end
end

function JNIEnv.GetVersion()
    return jni.env[0].GetVersion(jni.env)
end

function JNIEnv.DefineClass(name, loader, buf, len)
    return jni.env[0].DefineClass(jni.env, name, loader, buf, len)
end

function JNIEnv.DefineClass_safe(name, loader, buf, len)
    local result = JNIEnv.DefineClass(name, loader, buf, len)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.FindClass(name)
    return jni.env[0].FindClass(jni.env, name)
end

function JNIEnv.FindClass_safe(name)
    local result = JNIEnv.FindClass(name)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.FromReflectedMethod(method)
    return jni.env[0].FromReflectedMethod(jni.env, method)
end

function JNIEnv.FromReflectedMethod_safe(method)
    local result = JNIEnv.FromReflectedMethod(method)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.FromReflectedField(field)
    return jni.env[0].FromReflectedField(jni.env, field)
end

function JNIEnv.FromReflectedField_safe(field)
    local result = JNIEnv.FromReflectedField(field)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.ToReflectedMethod(cls, method, isStatic)
    return jni.env[0].ToReflectedMethod(jni.env, cls, method, isStatic)
end

function JNIEnv.ToReflectedMethod_safe(cls, method, isStatic)
    local result = JNIEnv.ToReflectedMethod(cls, method, isStatic)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetSuperclass(cls)
    return jni.env[0].GetSuperclass(jni.env, cls)
end

function JNIEnv.GetSuperclass_safe(cls)
    local result = JNIEnv.GetSuperclass(cls)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.IsAssignableFrom(cls1, cls2)
    return jni.env[0].IsAssignableFrom(jni.env, cls1, cls2)
end

function JNIEnv.IsAssignableFrom_safe(cls1, cls2)
    local result = JNIEnv.IsAssignableFrom(cls1, cls2)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.ToReflectedField(cls, field, isStatic)
    return jni.env[0].ToReflectedField(jni.env, cls, field, isStatic)
end

function JNIEnv.ToReflectedField_safe(cls, field, isStatic)
    local result = JNIEnv.ToReflectedField(cls, field, isStatic)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.Throw(obj)
    return jni.env[0].Throw(jni.env, obj)
end

function JNIEnv.Throw_safe(obj)
    local result = JNIEnv.Throw(obj)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.ThrowNew(cls, msg)
    return jni.env[0].ThrowNew(jni.env, cls, msg)
end

function JNIEnv.ThrowNew_safe(cls, msg)
    local result = JNIEnv.ThrowNew(cls, msg)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.ExceptionOccurred()
    return jni.env[0].ExceptionOccurred(jni.env)
end

function JNIEnv.ExceptionDescribe()
    return jni.env[0].ExceptionDescribe(jni.env)
end

function JNIEnv.ExceptionClear()
    return jni.env[0].ExceptionClear(jni.env)
end

function JNIEnv.FatalError(msg)
    return jni.env[0].FatalError(jni.env, msg)
end

function JNIEnv.PushLocalFrame(capacity)
    return jni.env[0].PushLocalFrame(jni.env, capacity)
end

function JNIEnv.PopLocalFrame(result)
    return jni.env[0].PopLocalFrame(jni.env, result)
end

function JNIEnv.NewGlobalRef(obj)
    return jni.env[0].NewGlobalRef(jni.env, obj)
end

function JNIEnv.DeleteGlobalRef(obj)
    return jni.env[0].DeleteGlobalRef(jni.env, obj)
end

function JNIEnv.DeleteLocalRef(obj)
    return jni.env[0].DeleteLocalRef(jni.env, obj)
end

function JNIEnv.IsSameObject(obj1, obj2)
    return jni.env[0].IsSameObject(jni.env, obj1, obj2)
end

function JNIEnv.IsSameObject_safe(obj1, obj2)
    local result = JNIEnv.IsSameObject(obj1, obj2)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.NewLocalRef(obj)
    return jni.env[0].NewLocalRef(jni.env, obj)
end

function JNIEnv.EnsureLocalCapacity(capacity)
    return jni.env[0].EnsureLocalCapacity(jni.env, capacity)
end

function JNIEnv.AllocObject(cls)
    return jni.env[0].AllocObject(jni.env, cls)
end

function JNIEnv.AllocObject_safe(cls)
    local result = JNIEnv.AllocObject(cls)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.NewObject(cls, method, ...)
    return jni.env[0].NewObject(jni.env, cls, method, ...)
end

function JNIEnv.NewObject_safe(cls, method, ...)
    local result = JNIEnv.NewObject(cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.NewObjectV(cls, method, args)
    return jni.env[0].NewObjectV(jni.env, cls, method, args)
end

function JNIEnv.NewObjectV_safe(cls, method, args)
    local result = JNIEnv.NewObjectV(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.NewObjectA(cls, method, args)
    return jni.env[0].NewObjectA(jni.env, cls, method, args)
end

function JNIEnv.NewObjectA_safe(cls, method, args)
    local result = JNIEnv.NewObjectA(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetObjectClass(obj)
    return jni.env[0].GetObjectClass(jni.env, obj)
end

function JNIEnv.GetObjectClass_safe(obj)
    local result = JNIEnv.GetObjectClass(obj)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.IsInstanceOf(obj, cls)
    return jni.env[0].IsInstanceOf(jni.env, obj, cls)
end

function JNIEnv.IsInstanceOf_safe(obj, cls)
    local result = JNIEnv.IsInstanceOf(obj, cls)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetMethodID(cls, name, sig)
    return jni.env[0].GetMethodID(jni.env, cls, name, sig)
end

function JNIEnv.GetMethodID_safe(cls, name, sig)
    local result = JNIEnv.GetMethodID(cls, name, sig)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallObjectMethod(obj, method, ...)
    return jni.env[0].CallObjectMethod(jni.env, obj, method, ...)
end

function JNIEnv.CallObjectMethod_safe(obj, method, ...)
    local result = JNIEnv.CallObjectMethod(obj, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallObjectMethodV(obj, method, args)
    return jni.env[0].CallObjectMethodV(jni.env, obj, method, args)
end

function JNIEnv.CallObjectMethodV_safe(obj, method, args)
    local result = JNIEnv.CallObjectMethodV(obj, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallObjectMethodA(obj, method, args)
    return jni.env[0].CallObjectMethodA(jni.env, obj, method, args)
end

function JNIEnv.CallObjectMethodA_safe(obj, method, args)
    local result = JNIEnv.CallObjectMethodA(obj, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallBooleanMethod(obj, method, ...)
    return jni.env[0].CallBooleanMethod(jni.env, obj, method, ...)
end

function JNIEnv.CallBooleanMethod_safe(obj, method, ...)
    local result = JNIEnv.CallBooleanMethod(obj, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallBooleanMethodV(obj, method, args)
    return jni.env[0].CallBooleanMethodV(jni.env, obj, method, args)
end

function JNIEnv.CallBooleanMethodV_safe(obj, method, args)
    local result = JNIEnv.CallBooleanMethodV(obj, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallBooleanMethodA(obj, method, args)
    return jni.env[0].CallBooleanMethodA(jni.env, obj, method, args)
end

function JNIEnv.CallBooleanMethodA_safe(obj, method, args)
    local result = JNIEnv.CallBooleanMethodA(obj, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallByteMethod(obj, method, ...)
    return jni.env[0].CallByteMethod(jni.env, obj, method, ...)
end

function JNIEnv.CallByteMethod_safe(obj, method, ...)
    local result = JNIEnv.CallByteMethod(obj, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallByteMethodV(obj, method, args)
    return jni.env[0].CallByteMethodV(jni.env, obj, method, args)
end

function JNIEnv.CallByteMethodV_safe(obj, method, args)
    local result = JNIEnv.CallByteMethodV(obj, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallByteMethodA(obj, method, args)
    return jni.env[0].CallByteMethodA(jni.env, obj, method, args)
end

function JNIEnv.CallByteMethodA_safe(obj, method, args)
    local result = JNIEnv.CallByteMethodA(obj, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallCharMethod(obj, method, ...)
    return jni.env[0].CallCharMethod(jni.env, obj, method, ...)
end

function JNIEnv.CallCharMethod_safe(obj, method, ...)
    local result = JNIEnv.CallCharMethod(obj, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallCharMethodV(obj, method, args)
    return jni.env[0].CallCharMethodV(jni.env, obj, method, args)
end

function JNIEnv.CallCharMethodV_safe(obj, method, args)
    local result = JNIEnv.CallCharMethodV(obj, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallCharMethodA(obj, method, args)
    return jni.env[0].CallCharMethodA(jni.env, obj, method, args)
end

function JNIEnv.CallCharMethodA_safe(obj, method, args)
    local result = JNIEnv.CallCharMethodA(obj, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallShortMethod(obj, method, ...)
    return jni.env[0].CallShortMethod(jni.env, obj, method, ...)
end

function JNIEnv.CallShortMethod_safe(obj, method, ...)
    local result = JNIEnv.CallShortMethod(obj, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallShortMethodV(obj, method, args)
    return jni.env[0].CallShortMethodV(jni.env, obj, method, args)
end

function JNIEnv.CallShortMethodV_safe(obj, method, args)
    local result = JNIEnv.CallShortMethodV(obj, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallShortMethodA(obj, method, args)
    return jni.env[0].CallShortMethodA(jni.env, obj, method, args)
end

function JNIEnv.CallShortMethodA_safe(obj, method, args)
    local result = JNIEnv.CallShortMethodA(obj, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallIntMethod(obj, method, ...)
    return jni.env[0].CallIntMethod(jni.env, obj, method, ...)
end

function JNIEnv.CallIntMethod_safe(obj, method, ...)
    local result = JNIEnv.CallIntMethod(obj, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallIntMethodV(obj, method, args)
    return jni.env[0].CallIntMethodV(jni.env, obj, method, args)
end

function JNIEnv.CallIntMethodV_safe(obj, method, args)
    local result = JNIEnv.CallIntMethodV(obj, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallIntMethodA(obj, method, args)
    return jni.env[0].CallIntMethodA(jni.env, obj, method, args)
end

function JNIEnv.CallIntMethodA_safe(obj, method, args)
    local result = JNIEnv.CallIntMethodA(obj, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallLongMethod(obj, method, ...)
    return jni.env[0].CallLongMethod(jni.env, obj, method, ...)
end

function JNIEnv.CallLongMethod_safe(obj, method, ...)
    local result = JNIEnv.CallLongMethod(obj, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallLongMethodV(obj, method, args)
    return jni.env[0].CallLongMethodV(jni.env, obj, method, args)
end

function JNIEnv.CallLongMethodV_safe(obj, method, args)
    local result = JNIEnv.CallLongMethodV(obj, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallLongMethodA(obj, method, args)
    return jni.env[0].CallLongMethodA(jni.env, obj, method, args)
end

function JNIEnv.CallLongMethodA_safe(obj, method, args)
    local result = JNIEnv.CallLongMethodA(obj, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallFloatMethod(obj, method, ...)
    return jni.env[0].CallFloatMethod(jni.env, obj, method, ...)
end

function JNIEnv.CallFloatMethod_safe(obj, method, ...)
    local result = JNIEnv.CallFloatMethod(obj, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallFloatMethodV(obj, method, args)
    return jni.env[0].CallFloatMethodV(jni.env, obj, method, args)
end

function JNIEnv.CallFloatMethodV_safe(obj, method, args)
    local result = JNIEnv.CallFloatMethodV(obj, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallFloatMethodA(obj, method, args)
    return jni.env[0].CallFloatMethodA(jni.env, obj, method, args)
end

function JNIEnv.CallFloatMethodA_safe(obj, method, args)
    local result = JNIEnv.CallFloatMethodA(obj, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallDoubleMethod(obj, method, ...)
    return jni.env[0].CallDoubleMethod(jni.env, obj, method, ...)
end

function JNIEnv.CallDoubleMethod_safe(obj, method, ...)
    local result = JNIEnv.CallDoubleMethod(obj, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallDoubleMethodV(obj, method, args)
    return jni.env[0].CallDoubleMethodV(jni.env, obj, method, args)
end

function JNIEnv.CallDoubleMethodV_safe(obj, method, args)
    local result = JNIEnv.CallDoubleMethodV(obj, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallDoubleMethodA(obj, method, args)
    return jni.env[0].CallDoubleMethodA(jni.env, obj, method, args)
end

function JNIEnv.CallDoubleMethodA_safe(obj, method, args)
    local result = JNIEnv.CallDoubleMethodA(obj, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallVoidMethod(obj, method, ...)
    return jni.env[0].CallVoidMethod(jni.env, obj, method, ...)
end

function JNIEnv.CallVoidMethod_safe(obj, method, ...)
    local result = JNIEnv.CallVoidMethod(obj, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallVoidMethodV(obj, method, args)
    return jni.env[0].CallVoidMethodV(jni.env, obj, method, args)
end

function JNIEnv.CallVoidMethodV_safe(obj, method, args)
    local result = JNIEnv.CallVoidMethodV(obj, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallVoidMethodA(obj, method, args)
    return jni.env[0].CallVoidMethodA(jni.env, obj, method, args)
end

function JNIEnv.CallVoidMethodA_safe(obj, method, args)
    local result = JNIEnv.CallVoidMethodA(obj, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualObjectMethod(obj, cls, method, ...)
    return jni.env[0].CallNonvirtualObjectMethod(jni.env, obj, cls, method, ...)
end

function JNIEnv.CallNonvirtualObjectMethod_safe(obj, cls, method, ...)
    local result = JNIEnv.CallNonvirtualObjectMethod(obj, cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualObjectMethodV(obj, cls, method, args)
    return jni.env[0].CallNonvirtualObjectMethodV(jni.env, obj, cls, method, args)
end

function JNIEnv.CallNonvirtualObjectMethodV_safe(obj, cls, method, args)
    local result = JNIEnv.CallNonvirtualObjectMethodV(obj, cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualObjectMethodA(obj, cls, method, args)
    return jni.env[0].CallNonvirtualObjectMethodA(jni.env, obj, cls, method, args)
end

function JNIEnv.CallNonvirtualObjectMethodA_safe(obj, cls, method, args)
    local result = JNIEnv.CallNonvirtualObjectMethodA(obj, cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualBooleanMethod(obj, cls, method, ...)
    return jni.env[0].CallNonvirtualBooleanMethod(jni.env, obj, cls, method, ...)
end

function JNIEnv.CallNonvirtualBooleanMethod_safe(obj, cls, method, ...)
    local result = JNIEnv.CallNonvirtualBooleanMethod(obj, cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualBooleanMethodV(obj, cls, method, args)
    return jni.env[0].CallNonvirtualBooleanMethodV(jni.env, obj, cls, method, args)
end

function JNIEnv.CallNonvirtualBooleanMethodV_safe(obj, cls, method, args)
    local result = JNIEnv.CallNonvirtualBooleanMethodV(obj, cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualBooleanMethodA(obj, cls, method, args)
    return jni.env[0].CallNonvirtualBooleanMethodA(jni.env, obj, cls, method, args)
end

function JNIEnv.CallNonvirtualBooleanMethodA_safe(obj, cls, method, args)
    local result = JNIEnv.CallNonvirtualBooleanMethodA(obj, cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualByteMethod(obj, cls, method, ...)
    return jni.env[0].CallNonvirtualByteMethod(jni.env, obj, cls, method, ...)
end

function JNIEnv.CallNonvirtualByteMethod_safe(obj, cls, method, ...)
    local result = JNIEnv.CallNonvirtualByteMethod(obj, cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualByteMethodV(obj, cls, method, args)
    return jni.env[0].CallNonvirtualByteMethodV(jni.env, obj, cls, method, args)
end

function JNIEnv.CallNonvirtualByteMethodV_safe(obj, cls, method, args)
    local result = JNIEnv.CallNonvirtualByteMethodV(obj, cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualByteMethodA(obj, cls, method, args)
    return jni.env[0].CallNonvirtualByteMethodA(jni.env, obj, cls, method, args)
end

function JNIEnv.CallNonvirtualByteMethodA_safe(obj, cls, method, args)
    local result = JNIEnv.CallNonvirtualByteMethodA(obj, cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualCharMethod(obj, cls, method, ...)
    return jni.env[0].CallNonvirtualCharMethod(jni.env, obj, cls, method, ...)
end

function JNIEnv.CallNonvirtualCharMethod_safe(obj, cls, method, ...)
    local result = JNIEnv.CallNonvirtualCharMethod(obj, cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualCharMethodV(obj, cls, method, args)
    return jni.env[0].CallNonvirtualCharMethodV(jni.env, obj, cls, method, args)
end

function JNIEnv.CallNonvirtualCharMethodV_safe(obj, cls, method, args)
    local result = JNIEnv.CallNonvirtualCharMethodV(obj, cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualCharMethodA(obj, cls, method, args)
    return jni.env[0].CallNonvirtualCharMethodA(jni.env, obj, cls, method, args)
end

function JNIEnv.CallNonvirtualCharMethodA_safe(obj, cls, method, args)
    local result = JNIEnv.CallNonvirtualCharMethodA(obj, cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualShortMethod(obj, cls, method, ...)
    return jni.env[0].CallNonvirtualShortMethod(jni.env, obj, cls, method, ...)
end

function JNIEnv.CallNonvirtualShortMethod_safe(obj, cls, method, ...)
    local result = JNIEnv.CallNonvirtualShortMethod(obj, cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualShortMethodV(obj, cls, method, args)
    return jni.env[0].CallNonvirtualShortMethodV(jni.env, obj, cls, method, args)
end

function JNIEnv.CallNonvirtualShortMethodV_safe(obj, cls, method, args)
    local result = JNIEnv.CallNonvirtualShortMethodV(obj, cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualShortMethodA(obj, cls, method, args)
    return jni.env[0].CallNonvirtualShortMethodA(jni.env, obj, cls, method, args)
end

function JNIEnv.CallNonvirtualShortMethodA_safe(obj, cls, method, args)
    local result = JNIEnv.CallNonvirtualShortMethodA(obj, cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualIntMethod(obj, cls, method, ...)
    return jni.env[0].CallNonvirtualIntMethod(jni.env, obj, cls, method, ...)
end

function JNIEnv.CallNonvirtualIntMethod_safe(obj, cls, method, ...)
    local result = JNIEnv.CallNonvirtualIntMethod(obj, cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualIntMethodV(obj, cls, method, args)
    return jni.env[0].CallNonvirtualIntMethodV(jni.env, obj, cls, method, args)
end

function JNIEnv.CallNonvirtualIntMethodV_safe(obj, cls, method, args)
    local result = JNIEnv.CallNonvirtualIntMethodV(obj, cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualIntMethodA(obj, cls, method, args)
    return jni.env[0].CallNonvirtualIntMethodA(jni.env, obj, cls, method, args)
end

function JNIEnv.CallNonvirtualIntMethodA_safe(obj, cls, method, args)
    local result = JNIEnv.CallNonvirtualIntMethodA(obj, cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualLongMethod(obj, cls, method, ...)
    return jni.env[0].CallNonvirtualLongMethod(jni.env, obj, cls, method, ...)
end

function JNIEnv.CallNonvirtualLongMethod_safe(obj, cls, method, ...)
    local result = JNIEnv.CallNonvirtualLongMethod(obj, cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualLongMethodV(obj, cls, method, args)
    return jni.env[0].CallNonvirtualLongMethodV(jni.env, obj, cls, method, args)
end

function JNIEnv.CallNonvirtualLongMethodV_safe(obj, cls, method, args)
    local result = JNIEnv.CallNonvirtualLongMethodV(obj, cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualLongMethodA(obj, cls, method, args)
    return jni.env[0].CallNonvirtualLongMethodA(jni.env, obj, cls, method, args)
end

function JNIEnv.CallNonvirtualLongMethodA_safe(obj, cls, method, args)
    local result = JNIEnv.CallNonvirtualLongMethodA(obj, cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualFloatMethod(obj, cls, method, ...)
    return jni.env[0].CallNonvirtualFloatMethod(jni.env, obj, cls, method, ...)
end

function JNIEnv.CallNonvirtualFloatMethod_safe(obj, cls, method, ...)
    local result = JNIEnv.CallNonvirtualFloatMethod(obj, cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualFloatMethodV(obj, cls, method, args)
    return jni.env[0].CallNonvirtualFloatMethodV(jni.env, obj, cls, method, args)
end

function JNIEnv.CallNonvirtualFloatMethodV_safe(obj, cls, method, args)
    local result = JNIEnv.CallNonvirtualFloatMethodV(obj, cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualFloatMethodA(obj, cls, method, args)
    return jni.env[0].CallNonvirtualFloatMethodA(jni.env, obj, cls, method, args)
end

function JNIEnv.CallNonvirtualFloatMethodA_safe(obj, cls, method, args)
    local result = JNIEnv.CallNonvirtualFloatMethodA(obj, cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualDoubleMethod(obj, cls, method, ...)
    return jni.env[0].CallNonvirtualDoubleMethod(jni.env, obj, cls, method, ...)
end

function JNIEnv.CallNonvirtualDoubleMethod_safe(obj, cls, method, ...)
    local result = JNIEnv.CallNonvirtualDoubleMethod(obj, cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualDoubleMethodV(obj, cls, method, args)
    return jni.env[0].CallNonvirtualDoubleMethodV(jni.env, obj, cls, method, args)
end

function JNIEnv.CallNonvirtualDoubleMethodV_safe(obj, cls, method, args)
    local result = JNIEnv.CallNonvirtualDoubleMethodV(obj, cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualDoubleMethodA(obj, cls, method, args)
    return jni.env[0].CallNonvirtualDoubleMethodA(jni.env, obj, cls, method, args)
end

function JNIEnv.CallNonvirtualDoubleMethodA_safe(obj, cls, method, args)
    local result = JNIEnv.CallNonvirtualDoubleMethodA(obj, cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualVoidMethod(obj, cls, method, ...)
    return jni.env[0].CallNonvirtualVoidMethod(jni.env, obj, cls, method, ...)
end

function JNIEnv.CallNonvirtualVoidMethod_safe(obj, cls, method, ...)
    local result = JNIEnv.CallNonvirtualVoidMethod(obj, cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualVoidMethodV(obj, cls, method, args)
    return jni.env[0].CallNonvirtualVoidMethodV(jni.env, obj, cls, method, args)
end

function JNIEnv.CallNonvirtualVoidMethodV_safe(obj, cls, method, args)
    local result = JNIEnv.CallNonvirtualVoidMethodV(obj, cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallNonvirtualVoidMethodA(obj, cls, method, args)
    return jni.env[0].CallNonvirtualVoidMethodA(jni.env, obj, cls, method, args)
end

function JNIEnv.CallNonvirtualVoidMethodA_safe(obj, cls, method, args)
    local result = JNIEnv.CallNonvirtualVoidMethodA(obj, cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetFieldID(cls, name, sig)
    return jni.env[0].GetFieldID(jni.env, cls, name, sig)
end

function JNIEnv.GetFieldID_safe(cls, name, sig)
    local result = JNIEnv.GetFieldID(cls, name, sig)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetObjectField(obj, field)
    return jni.env[0].GetObjectField(jni.env, obj, field)
end

function JNIEnv.GetObjectField_safe(obj, field)
    local result = JNIEnv.GetObjectField(obj, field)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetBooleanField(obj, field)
    return jni.env[0].GetBooleanField(jni.env, obj, field)
end

function JNIEnv.GetBooleanField_safe(obj, field)
    local result = JNIEnv.GetBooleanField(obj, field)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetByteField(obj, field)
    return jni.env[0].GetByteField(jni.env, obj, field)
end

function JNIEnv.GetByteField_safe(obj, field)
    local result = JNIEnv.GetByteField(obj, field)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetCharField(obj, field)
    return jni.env[0].GetCharField(jni.env, obj, field)
end

function JNIEnv.GetCharField_safe(obj, field)
    local result = JNIEnv.GetCharField(obj, field)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetShortField(obj, field)
    return jni.env[0].GetShortField(jni.env, obj, field)
end

function JNIEnv.GetShortField_safe(obj, field)
    local result = JNIEnv.GetShortField(obj, field)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetIntField(obj, field)
    return jni.env[0].GetIntField(jni.env, obj, field)
end

function JNIEnv.GetIntField_safe(obj, field)
    local result = JNIEnv.GetIntField(obj, field)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetLongField(obj, field)
    return jni.env[0].GetLongField(jni.env, obj, field)
end

function JNIEnv.GetLongField_safe(obj, field)
    local result = JNIEnv.GetLongField(obj, field)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetFloatField(obj, field)
    return jni.env[0].GetFloatField(jni.env, obj, field)
end

function JNIEnv.GetFloatField_safe(obj, field)
    local result = JNIEnv.GetFloatField(obj, field)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetDoubleField(obj, field)
    return jni.env[0].GetDoubleField(jni.env, obj, field)
end

function JNIEnv.GetDoubleField_safe(obj, field)
    local result = JNIEnv.GetDoubleField(obj, field)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetObjectField(obj, field, val)
    return jni.env[0].SetObjectField(jni.env, obj, field, val)
end

function JNIEnv.SetObjectField_safe(obj, field, val)
    local result = JNIEnv.SetObjectField(obj, field, val)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetBooleanField(obj, field, val)
    return jni.env[0].SetBooleanField(jni.env, obj, field, val)
end

function JNIEnv.SetBooleanField_safe(obj, field, val)
    local result = JNIEnv.SetBooleanField(obj, field, val)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetByteField(obj, field, val)
    return jni.env[0].SetByteField(jni.env, obj, field, val)
end

function JNIEnv.SetByteField_safe(obj, field, val)
    local result = JNIEnv.SetByteField(obj, field, val)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetCharField(obj, field, val)
    return jni.env[0].SetCharField(jni.env, obj, field, val)
end

function JNIEnv.SetCharField_safe(obj, field, val)
    local result = JNIEnv.SetCharField(obj, field, val)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetShortField(obj, field, val)
    return jni.env[0].SetShortField(jni.env, obj, field, val)
end

function JNIEnv.SetShortField_safe(obj, field, val)
    local result = JNIEnv.SetShortField(obj, field, val)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetIntField(obj, field, val)
    return jni.env[0].SetIntField(jni.env, obj, field, val)
end

function JNIEnv.SetIntField_safe(obj, field, val)
    local result = JNIEnv.SetIntField(obj, field, val)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetLongField(obj, field, val)
    return jni.env[0].SetLongField(jni.env, obj, field, val)
end

function JNIEnv.SetLongField_safe(obj, field, val)
    local result = JNIEnv.SetLongField(obj, field, val)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetFloatField(obj, field, val)
    return jni.env[0].SetFloatField(jni.env, obj, field, val)
end

function JNIEnv.SetFloatField_safe(obj, field, val)
    local result = JNIEnv.SetFloatField(obj, field, val)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetDoubleField(obj, field, val)
    return jni.env[0].SetDoubleField(jni.env, obj, field, val)
end

function JNIEnv.SetDoubleField_safe(obj, field, val)
    local result = JNIEnv.SetDoubleField(obj, field, val)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetStaticMethodID(cls, name, sig)
    return jni.env[0].GetStaticMethodID(jni.env, cls, name, sig)
end

function JNIEnv.GetStaticMethodID_safe(cls, name, sig)
    local result = JNIEnv.GetStaticMethodID(cls, name, sig)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticObjectMethod(cls, method, ...)
    return jni.env[0].CallStaticObjectMethod(jni.env, cls, method, ...)
end

function JNIEnv.CallStaticObjectMethod_safe(cls, method, ...)
    local result = JNIEnv.CallStaticObjectMethod(cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticObjectMethodV(cls, method, args)
    return jni.env[0].CallStaticObjectMethodV(jni.env, cls, method, args)
end

function JNIEnv.CallStaticObjectMethodV_safe(cls, method, args)
    local result = JNIEnv.CallStaticObjectMethodV(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticObjectMethodA(cls, method, args)
    return jni.env[0].CallStaticObjectMethodA(jni.env, cls, method, args)
end

function JNIEnv.CallStaticObjectMethodA_safe(cls, method, args)
    local result = JNIEnv.CallStaticObjectMethodA(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticBooleanMethod(cls, method, ...)
    return jni.env[0].CallStaticBooleanMethod(jni.env, cls, method, ...)
end

function JNIEnv.CallStaticBooleanMethod_safe(cls, method, ...)
    local result = JNIEnv.CallStaticBooleanMethod(cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticBooleanMethodV(cls, method, args)
    return jni.env[0].CallStaticBooleanMethodV(jni.env, cls, method, args)
end

function JNIEnv.CallStaticBooleanMethodV_safe(cls, method, args)
    local result = JNIEnv.CallStaticBooleanMethodV(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticBooleanMethodA(cls, method, args)
    return jni.env[0].CallStaticBooleanMethodA(jni.env, cls, method, args)
end

function JNIEnv.CallStaticBooleanMethodA_safe(cls, method, args)
    local result = JNIEnv.CallStaticBooleanMethodA(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticByteMethod(cls, method, ...)
    return jni.env[0].CallStaticByteMethod(jni.env, cls, method, ...)
end

function JNIEnv.CallStaticByteMethod_safe(cls, method, ...)
    local result = JNIEnv.CallStaticByteMethod(cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticByteMethodV(cls, method, args)
    return jni.env[0].CallStaticByteMethodV(jni.env, cls, method, args)
end

function JNIEnv.CallStaticByteMethodV_safe(cls, method, args)
    local result = JNIEnv.CallStaticByteMethodV(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticByteMethodA(cls, method, args)
    return jni.env[0].CallStaticByteMethodA(jni.env, cls, method, args)
end

function JNIEnv.CallStaticByteMethodA_safe(cls, method, args)
    local result = JNIEnv.CallStaticByteMethodA(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticCharMethod(cls, method, ...)
    return jni.env[0].CallStaticCharMethod(jni.env, cls, method, ...)
end

function JNIEnv.CallStaticCharMethod_safe(cls, method, ...)
    local result = JNIEnv.CallStaticCharMethod(cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticCharMethodV(cls, method, args)
    return jni.env[0].CallStaticCharMethodV(jni.env, cls, method, args)
end

function JNIEnv.CallStaticCharMethodV_safe(cls, method, args)
    local result = JNIEnv.CallStaticCharMethodV(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticCharMethodA(cls, method, args)
    return jni.env[0].CallStaticCharMethodA(jni.env, cls, method, args)
end

function JNIEnv.CallStaticCharMethodA_safe(cls, method, args)
    local result = JNIEnv.CallStaticCharMethodA(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticShortMethod(cls, method, ...)
    return jni.env[0].CallStaticShortMethod(jni.env, cls, method, ...)
end

function JNIEnv.CallStaticShortMethod_safe(cls, method, ...)
    local result = JNIEnv.CallStaticShortMethod(cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticShortMethodV(cls, method, args)
    return jni.env[0].CallStaticShortMethodV(jni.env, cls, method, args)
end

function JNIEnv.CallStaticShortMethodV_safe(cls, method, args)
    local result = JNIEnv.CallStaticShortMethodV(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticShortMethodA(cls, method, args)
    return jni.env[0].CallStaticShortMethodA(jni.env, cls, method, args)
end

function JNIEnv.CallStaticShortMethodA_safe(cls, method, args)
    local result = JNIEnv.CallStaticShortMethodA(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticIntMethod(cls, method, ...)
    return jni.env[0].CallStaticIntMethod(jni.env, cls, method, ...)
end

function JNIEnv.CallStaticIntMethod_safe(cls, method, ...)
    local result = JNIEnv.CallStaticIntMethod(cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticIntMethodV(cls, method, args)
    return jni.env[0].CallStaticIntMethodV(jni.env, cls, method, args)
end

function JNIEnv.CallStaticIntMethodV_safe(cls, method, args)
    local result = JNIEnv.CallStaticIntMethodV(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticIntMethodA(cls, method, args)
    return jni.env[0].CallStaticIntMethodA(jni.env, cls, method, args)
end

function JNIEnv.CallStaticIntMethodA_safe(cls, method, args)
    local result = JNIEnv.CallStaticIntMethodA(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticLongMethod(cls, method, ...)
    return jni.env[0].CallStaticLongMethod(jni.env, cls, method, ...)
end

function JNIEnv.CallStaticLongMethod_safe(cls, method, ...)
    local result = JNIEnv.CallStaticLongMethod(cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticLongMethodV(cls, method, args)
    return jni.env[0].CallStaticLongMethodV(jni.env, cls, method, args)
end

function JNIEnv.CallStaticLongMethodV_safe(cls, method, args)
    local result = JNIEnv.CallStaticLongMethodV(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticLongMethodA(cls, method, args)
    return jni.env[0].CallStaticLongMethodA(jni.env, cls, method, args)
end

function JNIEnv.CallStaticLongMethodA_safe(cls, method, args)
    local result = JNIEnv.CallStaticLongMethodA(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticFloatMethod(cls, method, ...)
    return jni.env[0].CallStaticFloatMethod(jni.env, cls, method, ...)
end

function JNIEnv.CallStaticFloatMethod_safe(cls, method, ...)
    local result = JNIEnv.CallStaticFloatMethod(cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticFloatMethodV(cls, method, args)
    return jni.env[0].CallStaticFloatMethodV(jni.env, cls, method, args)
end

function JNIEnv.CallStaticFloatMethodV_safe(cls, method, args)
    local result = JNIEnv.CallStaticFloatMethodV(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticFloatMethodA(cls, method, args)
    return jni.env[0].CallStaticFloatMethodA(jni.env, cls, method, args)
end

function JNIEnv.CallStaticFloatMethodA_safe(cls, method, args)
    local result = JNIEnv.CallStaticFloatMethodA(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticDoubleMethod(cls, method, ...)
    return jni.env[0].CallStaticDoubleMethod(jni.env, cls, method, ...)
end

function JNIEnv.CallStaticDoubleMethod_safe(cls, method, ...)
    local result = JNIEnv.CallStaticDoubleMethod(cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticDoubleMethodV(cls, method, args)
    return jni.env[0].CallStaticDoubleMethodV(jni.env, cls, method, args)
end

function JNIEnv.CallStaticDoubleMethodV_safe(cls, method, args)
    local result = JNIEnv.CallStaticDoubleMethodV(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticDoubleMethodA(cls, method, args)
    return jni.env[0].CallStaticDoubleMethodA(jni.env, cls, method, args)
end

function JNIEnv.CallStaticDoubleMethodA_safe(cls, method, args)
    local result = JNIEnv.CallStaticDoubleMethodA(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticVoidMethod(cls, method, ...)
    return jni.env[0].CallStaticVoidMethod(jni.env, cls, method, ...)
end

function JNIEnv.CallStaticVoidMethod_safe(cls, method, ...)
    local result = JNIEnv.CallStaticVoidMethod(cls, method, ...)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticVoidMethodV(cls, method, args)
    return jni.env[0].CallStaticVoidMethodV(jni.env, cls, method, args)
end

function JNIEnv.CallStaticVoidMethodV_safe(cls, method, args)
    local result = JNIEnv.CallStaticVoidMethodV(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.CallStaticVoidMethodA(cls, method, args)
    return jni.env[0].CallStaticVoidMethodA(jni.env, cls, method, args)
end

function JNIEnv.CallStaticVoidMethodA_safe(cls, method, args)
    local result = JNIEnv.CallStaticVoidMethodA(cls, method, args)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetStaticFieldID(cls, name, sig)
    return jni.env[0].GetStaticFieldID(jni.env, cls, name, sig)
end

function JNIEnv.GetStaticFieldID_safe(cls, name, sig)
    local result = JNIEnv.GetStaticFieldID(cls, name, sig)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetStaticObjectField(cls, field)
    return jni.env[0].GetStaticObjectField(jni.env, cls, field)
end

function JNIEnv.GetStaticObjectField_safe(cls, field)
    local result = JNIEnv.GetStaticObjectField(cls, field)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetStaticBooleanField(cls, field)
    return jni.env[0].GetStaticBooleanField(jni.env, cls, field)
end

function JNIEnv.GetStaticBooleanField_safe(cls, field)
    local result = JNIEnv.GetStaticBooleanField(cls, field)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetStaticByteField(cls, field)
    return jni.env[0].GetStaticByteField(jni.env, cls, field)
end

function JNIEnv.GetStaticByteField_safe(cls, field)
    local result = JNIEnv.GetStaticByteField(cls, field)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetStaticCharField(cls, field)
    return jni.env[0].GetStaticCharField(jni.env, cls, field)
end

function JNIEnv.GetStaticCharField_safe(cls, field)
    local result = JNIEnv.GetStaticCharField(cls, field)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetStaticShortField(cls, field)
    return jni.env[0].GetStaticShortField(jni.env, cls, field)
end

function JNIEnv.GetStaticShortField_safe(cls, field)
    local result = JNIEnv.GetStaticShortField(cls, field)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetStaticIntField(cls, field)
    return jni.env[0].GetStaticIntField(jni.env, cls, field)
end

function JNIEnv.GetStaticIntField_safe(cls, field)
    local result = JNIEnv.GetStaticIntField(cls, field)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetStaticLongField(cls, field)
    return jni.env[0].GetStaticLongField(jni.env, cls, field)
end

function JNIEnv.GetStaticLongField_safe(cls, field)
    local result = JNIEnv.GetStaticLongField(cls, field)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetStaticFloatField(cls, field)
    return jni.env[0].GetStaticFloatField(jni.env, cls, field)
end

function JNIEnv.GetStaticFloatField_safe(cls, field)
    local result = JNIEnv.GetStaticFloatField(cls, field)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetStaticDoubleField(cls, field)
    return jni.env[0].GetStaticDoubleField(jni.env, cls, field)
end

function JNIEnv.GetStaticDoubleField_safe(cls, field)
    local result = JNIEnv.GetStaticDoubleField(cls, field)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetStaticObjectField(cls, field, val)
    return jni.env[0].SetStaticObjectField(jni.env, cls, field, val)
end

function JNIEnv.SetStaticObjectField_safe(cls, field, val)
    local result = JNIEnv.SetStaticObjectField(cls, field, val)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetStaticBooleanField(cls, field, val)
    return jni.env[0].SetStaticBooleanField(jni.env, cls, field, val)
end

function JNIEnv.SetStaticBooleanField_safe(cls, field, val)
    local result = JNIEnv.SetStaticBooleanField(cls, field, val)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetStaticByteField(cls, field, val)
    return jni.env[0].SetStaticByteField(jni.env, cls, field, val)
end

function JNIEnv.SetStaticByteField_safe(cls, field, val)
    local result = JNIEnv.SetStaticByteField(cls, field, val)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetStaticCharField(cls, field, val)
    return jni.env[0].SetStaticCharField(jni.env, cls, field, val)
end

function JNIEnv.SetStaticCharField_safe(cls, field, val)
    local result = JNIEnv.SetStaticCharField(cls, field, val)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetStaticShortField(cls, field, val)
    return jni.env[0].SetStaticShortField(jni.env, cls, field, val)
end

function JNIEnv.SetStaticShortField_safe(cls, field, val)
    local result = JNIEnv.SetStaticShortField(cls, field, val)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetStaticIntField(cls, field, val)
    return jni.env[0].SetStaticIntField(jni.env, cls, field, val)
end

function JNIEnv.SetStaticIntField_safe(cls, field, val)
    local result = JNIEnv.SetStaticIntField(cls, field, val)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetStaticLongField(cls, field, val)
    return jni.env[0].SetStaticLongField(jni.env, cls, field, val)
end

function JNIEnv.SetStaticLongField_safe(cls, field, val)
    local result = JNIEnv.SetStaticLongField(cls, field, val)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetStaticFloatField(cls, field, val)
    return jni.env[0].SetStaticFloatField(jni.env, cls, field, val)
end

function JNIEnv.SetStaticFloatField_safe(cls, field, val)
    local result = JNIEnv.SetStaticFloatField(cls, field, val)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetStaticDoubleField(cls, field, val)
    return jni.env[0].SetStaticDoubleField(jni.env, cls, field, val)
end

function JNIEnv.SetStaticDoubleField_safe(cls, field, val)
    local result = JNIEnv.SetStaticDoubleField(cls, field, val)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.NewString(unicode, len)
    return jni.env[0].NewString(jni.env, unicode, len)
end

function JNIEnv.NewString_safe(unicode, len)
    local result = JNIEnv.NewString(unicode, len)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetStringLength(str)
    return jni.env[0].GetStringLength(jni.env, str)
end

function JNIEnv.GetStringLength_safe(str)
    local result = JNIEnv.GetStringLength(str)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetStringChars(str, isCopy)
    return jni.env[0].GetStringChars(jni.env, str, isCopy)
end

function JNIEnv.GetStringChars_safe(str, isCopy)
    local result = JNIEnv.GetStringChars(str, isCopy)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.ReleaseStringChars(str, chars)
    return jni.env[0].ReleaseStringChars(jni.env, str, chars)
end

function JNIEnv.ReleaseStringChars_safe(str, chars)
    local result = JNIEnv.ReleaseStringChars(str, chars)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.NewStringUTF(utf)
    return jni.env[0].NewStringUTF(jni.env, utf)
end

function JNIEnv.NewStringUTF_safe(utf)
    local result = JNIEnv.NewStringUTF(utf)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetStringUTFLength(str)
    return jni.env[0].GetStringUTFLength(jni.env, str)
end

function JNIEnv.GetStringUTFLength_safe(str)
    local result = JNIEnv.GetStringUTFLength(str)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetStringUTFChars(str, isCopy)
    return jni.env[0].GetStringUTFChars(jni.env, str, isCopy)
end

function JNIEnv.GetStringUTFChars_safe(str, isCopy)
    local result = JNIEnv.GetStringUTFChars(str, isCopy)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.ReleaseStringUTFChars(str, utf)
    return jni.env[0].ReleaseStringUTFChars(jni.env, str, utf)
end

function JNIEnv.ReleaseStringUTFChars_safe(str, utf)
    local result = JNIEnv.ReleaseStringUTFChars(str, utf)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetArrayLength(array)
    return jni.env[0].GetArrayLength(jni.env, array)
end

function JNIEnv.GetArrayLength_safe(array)
    local result = JNIEnv.GetArrayLength(array)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.NewObjectArray(len, cls, init)
    return jni.env[0].NewObjectArray(jni.env, len, cls, init)
end

function JNIEnv.NewObjectArray_safe(len, cls, init)
    local result = JNIEnv.NewObjectArray(len, cls, init)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetObjectArrayElement(array, index)
    return jni.env[0].GetObjectArrayElement(jni.env, array, index)
end

function JNIEnv.GetObjectArrayElement_safe(array, index)
    local result = JNIEnv.GetObjectArrayElement(array, index)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetObjectArrayElement(array, index, val)
    return jni.env[0].SetObjectArrayElement(jni.env, array, index, val)
end

function JNIEnv.SetObjectArrayElement_safe(array, index, val)
    local result = JNIEnv.SetObjectArrayElement(array, index, val)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.NewBooleanArray(len)
    return jni.env[0].NewBooleanArray(jni.env, len)
end

function JNIEnv.NewBooleanArray_safe(len)
    local result = JNIEnv.NewBooleanArray(len)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.NewByteArray(len)
    return jni.env[0].NewByteArray(jni.env, len)
end

function JNIEnv.NewByteArray_safe(len)
    local result = JNIEnv.NewByteArray(len)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.NewCharArray(len)
    return jni.env[0].NewCharArray(jni.env, len)
end

function JNIEnv.NewCharArray_safe(len)
    local result = JNIEnv.NewCharArray(len)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.NewShortArray(len)
    return jni.env[0].NewShortArray(jni.env, len)
end

function JNIEnv.NewShortArray_safe(len)
    local result = JNIEnv.NewShortArray(len)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.NewIntArray(len)
    return jni.env[0].NewIntArray(jni.env, len)
end

function JNIEnv.NewIntArray_safe(len)
    local result = JNIEnv.NewIntArray(len)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.NewLongArray(len)
    return jni.env[0].NewLongArray(jni.env, len)
end

function JNIEnv.NewLongArray_safe(len)
    local result = JNIEnv.NewLongArray(len)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.NewFloatArray(len)
    return jni.env[0].NewFloatArray(jni.env, len)
end

function JNIEnv.NewFloatArray_safe(len)
    local result = JNIEnv.NewFloatArray(len)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.NewDoubleArray(len)
    return jni.env[0].NewDoubleArray(jni.env, len)
end

function JNIEnv.NewDoubleArray_safe(len)
    local result = JNIEnv.NewDoubleArray(len)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetBooleanArrayElements(array, isCopy)
    return jni.env[0].GetBooleanArrayElements(jni.env, array, isCopy)
end

function JNIEnv.GetBooleanArrayElements_safe(array, isCopy)
    local result = JNIEnv.GetBooleanArrayElements(array, isCopy)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetByteArrayElements(array, isCopy)
    return jni.env[0].GetByteArrayElements(jni.env, array, isCopy)
end

function JNIEnv.GetByteArrayElements_safe(array, isCopy)
    local result = JNIEnv.GetByteArrayElements(array, isCopy)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetCharArrayElements(array, isCopy)
    return jni.env[0].GetCharArrayElements(jni.env, array, isCopy)
end

function JNIEnv.GetCharArrayElements_safe(array, isCopy)
    local result = JNIEnv.GetCharArrayElements(array, isCopy)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetShortArrayElements(array, isCopy)
    return jni.env[0].GetShortArrayElements(jni.env, array, isCopy)
end

function JNIEnv.GetShortArrayElements_safe(array, isCopy)
    local result = JNIEnv.GetShortArrayElements(array, isCopy)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetIntArrayElements(array, isCopy)
    return jni.env[0].GetIntArrayElements(jni.env, array, isCopy)
end

function JNIEnv.GetIntArrayElements_safe(array, isCopy)
    local result = JNIEnv.GetIntArrayElements(array, isCopy)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetLongArrayElements(array, isCopy)
    return jni.env[0].GetLongArrayElements(jni.env, array, isCopy)
end

function JNIEnv.GetLongArrayElements_safe(array, isCopy)
    local result = JNIEnv.GetLongArrayElements(array, isCopy)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetFloatArrayElements(array, isCopy)
    return jni.env[0].GetFloatArrayElements(jni.env, array, isCopy)
end

function JNIEnv.GetFloatArrayElements_safe(array, isCopy)
    local result = JNIEnv.GetFloatArrayElements(array, isCopy)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetDoubleArrayElements(array, isCopy)
    return jni.env[0].GetDoubleArrayElements(jni.env, array, isCopy)
end

function JNIEnv.GetDoubleArrayElements_safe(array, isCopy)
    local result = JNIEnv.GetDoubleArrayElements(array, isCopy)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.ReleaseBooleanArrayElements(array, elems, mode)
    return jni.env[0].ReleaseBooleanArrayElements(jni.env, array, elems, mode)
end

function JNIEnv.ReleaseBooleanArrayElements_safe(array, elems, mode)
    local result = JNIEnv.ReleaseBooleanArrayElements(array, elems, mode)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.ReleaseByteArrayElements(array, elems, mode)
    return jni.env[0].ReleaseByteArrayElements(jni.env, array, elems, mode)
end

function JNIEnv.ReleaseByteArrayElements_safe(array, elems, mode)
    local result = JNIEnv.ReleaseByteArrayElements(array, elems, mode)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.ReleaseCharArrayElements(array, elems, mode)
    return jni.env[0].ReleaseCharArrayElements(jni.env, array, elems, mode)
end

function JNIEnv.ReleaseCharArrayElements_safe(array, elems, mode)
    local result = JNIEnv.ReleaseCharArrayElements(array, elems, mode)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.ReleaseShortArrayElements(array, elems, mode)
    return jni.env[0].ReleaseShortArrayElements(jni.env, array, elems, mode)
end

function JNIEnv.ReleaseShortArrayElements_safe(array, elems, mode)
    local result = JNIEnv.ReleaseShortArrayElements(array, elems, mode)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.ReleaseIntArrayElements(array, elems, mode)
    return jni.env[0].ReleaseIntArrayElements(jni.env, array, elems, mode)
end

function JNIEnv.ReleaseIntArrayElements_safe(array, elems, mode)
    local result = JNIEnv.ReleaseIntArrayElements(array, elems, mode)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.ReleaseLongArrayElements(array, elems, mode)
    return jni.env[0].ReleaseLongArrayElements(jni.env, array, elems, mode)
end

function JNIEnv.ReleaseLongArrayElements_safe(array, elems, mode)
    local result = JNIEnv.ReleaseLongArrayElements(array, elems, mode)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.ReleaseFloatArrayElements(array, elems, mode)
    return jni.env[0].ReleaseFloatArrayElements(jni.env, array, elems, mode)
end

function JNIEnv.ReleaseFloatArrayElements_safe(array, elems, mode)
    local result = JNIEnv.ReleaseFloatArrayElements(array, elems, mode)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.ReleaseDoubleArrayElements(array, elems, mode)
    return jni.env[0].ReleaseDoubleArrayElements(jni.env, array, elems, mode)
end

function JNIEnv.ReleaseDoubleArrayElements_safe(array, elems, mode)
    local result = JNIEnv.ReleaseDoubleArrayElements(array, elems, mode)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetBooleanArrayRegion(array, start, len, buf)
    return jni.env[0].GetBooleanArrayRegion(jni.env, array, start, len, buf)
end

function JNIEnv.GetBooleanArrayRegion_safe(array, start, len, buf)
    local result = JNIEnv.GetBooleanArrayRegion(array, start, len, buf)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetByteArrayRegion(array, start, len, buf)
    return jni.env[0].GetByteArrayRegion(jni.env, array, start, len, buf)
end

function JNIEnv.GetByteArrayRegion_safe(array, start, len, buf)
    local result = JNIEnv.GetByteArrayRegion(array, start, len, buf)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetCharArrayRegion(array, start, len, buf)
    return jni.env[0].GetCharArrayRegion(jni.env, array, start, len, buf)
end

function JNIEnv.GetCharArrayRegion_safe(array, start, len, buf)
    local result = JNIEnv.GetCharArrayRegion(array, start, len, buf)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetShortArrayRegion(array, start, len, buf)
    return jni.env[0].GetShortArrayRegion(jni.env, array, start, len, buf)
end

function JNIEnv.GetShortArrayRegion_safe(array, start, len, buf)
    local result = JNIEnv.GetShortArrayRegion(array, start, len, buf)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetIntArrayRegion(array, start, len, buf)
    return jni.env[0].GetIntArrayRegion(jni.env, array, start, len, buf)
end

function JNIEnv.GetIntArrayRegion_safe(array, start, len, buf)
    local result = JNIEnv.GetIntArrayRegion(array, start, len, buf)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetLongArrayRegion(array, start, len, buf)
    return jni.env[0].GetLongArrayRegion(jni.env, array, start, len, buf)
end

function JNIEnv.GetLongArrayRegion_safe(array, start, len, buf)
    local result = JNIEnv.GetLongArrayRegion(array, start, len, buf)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetFloatArrayRegion(array, start, len, buf)
    return jni.env[0].GetFloatArrayRegion(jni.env, array, start, len, buf)
end

function JNIEnv.GetFloatArrayRegion_safe(array, start, len, buf)
    local result = JNIEnv.GetFloatArrayRegion(array, start, len, buf)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetDoubleArrayRegion(array, start, len, buf)
    return jni.env[0].GetDoubleArrayRegion(jni.env, array, start, len, buf)
end

function JNIEnv.GetDoubleArrayRegion_safe(array, start, len, buf)
    local result = JNIEnv.GetDoubleArrayRegion(array, start, len, buf)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetBooleanArrayRegion(array, start, len, buf)
    return jni.env[0].SetBooleanArrayRegion(jni.env, array, start, len, buf)
end

function JNIEnv.SetBooleanArrayRegion_safe(array, start, len, buf)
    local result = JNIEnv.SetBooleanArrayRegion(array, start, len, buf)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetByteArrayRegion(array, start, len, buf)
    return jni.env[0].SetByteArrayRegion(jni.env, array, start, len, buf)
end

function JNIEnv.SetByteArrayRegion_safe(array, start, len, buf)
    local result = JNIEnv.SetByteArrayRegion(array, start, len, buf)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetCharArrayRegion(array, start, len, buf)
    return jni.env[0].SetCharArrayRegion(jni.env, array, start, len, buf)
end

function JNIEnv.SetCharArrayRegion_safe(array, start, len, buf)
    local result = JNIEnv.SetCharArrayRegion(array, start, len, buf)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetShortArrayRegion(array, start, len, buf)
    return jni.env[0].SetShortArrayRegion(jni.env, array, start, len, buf)
end

function JNIEnv.SetShortArrayRegion_safe(array, start, len, buf)
    local result = JNIEnv.SetShortArrayRegion(array, start, len, buf)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetIntArrayRegion(array, start, len, buf)
    return jni.env[0].SetIntArrayRegion(jni.env, array, start, len, buf)
end

function JNIEnv.SetIntArrayRegion_safe(array, start, len, buf)
    local result = JNIEnv.SetIntArrayRegion(array, start, len, buf)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetLongArrayRegion(array, start, len, buf)
    return jni.env[0].SetLongArrayRegion(jni.env, array, start, len, buf)
end

function JNIEnv.SetLongArrayRegion_safe(array, start, len, buf)
    local result = JNIEnv.SetLongArrayRegion(array, start, len, buf)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetFloatArrayRegion(array, start, len, buf)
    return jni.env[0].SetFloatArrayRegion(jni.env, array, start, len, buf)
end

function JNIEnv.SetFloatArrayRegion_safe(array, start, len, buf)
    local result = JNIEnv.SetFloatArrayRegion(array, start, len, buf)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.SetDoubleArrayRegion(array, start, len, buf)
    return jni.env[0].SetDoubleArrayRegion(jni.env, array, start, len, buf)
end

function JNIEnv.SetDoubleArrayRegion_safe(array, start, len, buf)
    local result = JNIEnv.SetDoubleArrayRegion(array, start, len, buf)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.RegisterNatives(cls, methods, nMethods)
    return jni.env[0].RegisterNatives(jni.env, cls, methods, nMethods)
end

function JNIEnv.RegisterNatives_safe(cls, methods, nMethods)
    local result = JNIEnv.RegisterNatives(cls, methods, nMethods)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.UnregisterNatives(cls)
    return jni.env[0].UnregisterNatives(jni.env, cls)
end

function JNIEnv.UnregisterNatives_safe(cls)
    local result = JNIEnv.UnregisterNatives(cls)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.MonitorEnter(obj)
    return jni.env[0].MonitorEnter(jni.env, obj)
end

function JNIEnv.MonitorExit(obj)
    return jni.env[0].MonitorExit(jni.env, obj)
end

function JNIEnv.GetJavaVM(vm)
    return jni.env[0].GetJavaVM(jni.env, vm)
end

function JNIEnv.GetStringRegion(str, start, len, buf)
    return jni.env[0].GetStringRegion(jni.env, str, start, len, buf)
end

function JNIEnv.GetStringRegion_safe(str, start, len, buf)
    local result = JNIEnv.GetStringRegion(str, start, len, buf)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetStringUTFRegion(str, start, len, buf)
    return jni.env[0].GetStringUTFRegion(jni.env, str, start, len, buf)
end

function JNIEnv.GetStringUTFRegion_safe(str, start, len, buf)
    local result = JNIEnv.GetStringUTFRegion(str, start, len, buf)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetPrimitiveArrayCritical(array, isCopy)
    return jni.env[0].GetPrimitiveArrayCritical(jni.env, array, isCopy)
end

function JNIEnv.GetPrimitiveArrayCritical_safe(array, isCopy)
    local result = JNIEnv.GetPrimitiveArrayCritical(array, isCopy)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.ReleasePrimitiveArrayCritical(array, carray, mode)
    return jni.env[0].ReleasePrimitiveArrayCritical(jni.env, array, carray, mode)
end

function JNIEnv.ReleasePrimitiveArrayCritical_safe(array, carray, mode)
    local result = JNIEnv.ReleasePrimitiveArrayCritical(array, carray, mode)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.GetStringCritical(string, isCopy)
    return jni.env[0].GetStringCritical(jni.env, string, isCopy)
end

function JNIEnv.GetStringCritical_safe(string, isCopy)
    local result = JNIEnv.GetStringCritical(string, isCopy)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.ReleaseStringCritical(string, cstring)
    return jni.env[0].ReleaseStringCritical(jni.env, string, cstring)
end

function JNIEnv.ReleaseStringCritical_safe(string, cstring)
    local result = JNIEnv.ReleaseStringCritical(string, cstring)
    JNIEnv.checkExceptions()
    return result
end

function JNIEnv.NewWeakGlobalRef(obj)
    return jni.env[0].NewWeakGlobalRef(jni.env, obj)
end

function JNIEnv.DeleteWeakGlobalRef(obj)
    return jni.env[0].DeleteWeakGlobalRef(jni.env, obj)
end

function JNIEnv.ExceptionCheck()
    return jni.env[0].ExceptionCheck(jni.env)
end

function JNIEnv.NewDirectByteBuffer(address, capacity)
    return jni.env[0].NewDirectByteBuffer(jni.env, address, capacity)
end

function JNIEnv.GetDirectBufferAddress(buf)
    return jni.env[0].GetDirectBufferAddress(jni.env, buf)
end

function JNIEnv.GetDirectBufferCapacity(buf)
    return jni.env[0].GetDirectBufferCapacity(jni.env, buf)
end

function JNIEnv.GetObjectRefType(obj)
    return jni.env[0].GetObjectRefType(jni.env, obj)
end

function JNIEnv.GetObjectRefType_safe(obj)
    local result = JNIEnv.GetObjectRefType(obj)
    JNIEnv.checkExceptions()
    return result
end

return JNIEnv
