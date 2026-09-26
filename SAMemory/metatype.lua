local module = {}

function module.has_metatable(_) return false end
function module.clear_metatable(_) end
function module.has_handler(_, _) return false end
function module.get_handler(_, _) return nil end
function module.set_handler(_, _, _) end
function module.provide_access(_, _, _, _) end
function module.hook_handler(_, _, _) end

return module
