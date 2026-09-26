local ffi = require 'ffi'
local utils = {}

function utils.decompress_health_and_armor(hpAp)
	local hp = math.min(bit.rshift(hpAp, 4) * 7, 100)
	local armor = math.min(bit.band(hpAp, 0x0F) * 7, 100)
	return hp, armor
end

function utils.compress_health_and_armor(health, armor)
	local hp = health >= 100 and 0xF0 or bit.lshift(health / 7, 4)
	local ap = armor >= 100 and 0x0F or bit.band(armor / 7, 0x0F)
	return bit.bor(hp, ap)
end

function utils.create_sync_data(st)
	require 'samp.synchronization'
	return ffi.new(st)
end

function utils.read_sync_data(bs, st)
	local dataStruct = utils.create_sync_data(st)
	local ptr = tonumber(ffi.cast('uintptr_t', ffi.cast('void*', dataStruct)))
	raknetBitStreamReadBuffer(bs, ptr, ffi.sizeof(dataStruct))
	return dataStruct
end

function utils.write_sync_data(bs, st, ffiobj)
	require 'samp.synchronization'
	local ptr = tonumber(ffi.cast('uintptr_t', ffi.cast('void*', ffiobj)))
	raknetBitStreamWriteBuffer(bs, ptr, ffi.sizeof(st))
end

function utils.process_outcoming_sync_data(bs, st)
	local raw_ptr = raknetBitStreamGetDataPtr(bs)
	if not raw_ptr or raw_ptr <= 0 then
		return {utils.create_sync_data(st)}
	end
	require 'samp.synchronization'
	local ok, ptr = pcall(function()
		local base = ffi.cast('char*', ffi.cast('uintptr_t', raw_ptr))
		return ffi.cast(st .. '*', base + 1)
	end)
	if ok and ptr then
		return {ptr}
	end
	return {utils.create_sync_data(st)}
end

return utils
