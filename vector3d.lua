local EPSILON = 0.0001
local function isNearZero(f)
	return math.abs(f) < EPSILON
end

local mt = {}
mt.__index = mt

function mt:get()
	return self.x, self.y, self.z
end

function mt:length()
	return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
end

function mt:normalize()
	local len = self:length()
	if len < EPSILON then return 0 end
	self.x = self.x / len
	self.y = self.y / len
	self.z = self.z / len
	return len
end

function mt:zeroNearZero()
	if isNearZero(self.x) then self.x = 0 end
	if isNearZero(self.y) then self.y = 0 end
	if isNearZero(self.z) then self.z = 0 end
end
mt.zero_near_zero = mt.zeroNearZero

function mt:dotProduct(v)
	local vx = type(v) == "table" and (v.x or v[1] or 0) or tonumber(v) or 0
	local vy = type(v) == "table" and (v.y or v[2] or 0) or tonumber(v) or 0
	local vz = type(v) == "table" and (v.z or v[3] or 0) or tonumber(v) or 0
	return self.x * vx + self.y * vy + self.z * vz
end
mt.dot_product = mt.dotProduct

function mt:crossProduct(v)
	local vx = type(v) == "table" and (v.x or v[1] or 0) or tonumber(v) or 0
	local vy = type(v) == "table" and (v.y or v[2] or 0) or tonumber(v) or 0
	local vz = type(v) == "table" and (v.z or v[3] or 0) or tonumber(v) or 0
	local x, y, z = self.x, self.y, self.z
	self.x = y * vz - vy * z
	self.y = z * vx - vz * x
	self.z = x * vy - vx * y
end
mt.cross_product = mt.crossProduct

local function get_xyz(val)
	if type(val) == "number" then
		return val, val, val
	end
	if type(val) == "table" then
		local vx = val.x or val[0] or val[1] or 0
		local vy = val.y or val[1] or val[2] or 0
		local vz = val.z or val[2] or val[3] or 0
		return tonumber(vx) or 0, tonumber(vy) or 0, tonumber(vz) or 0
	end
	return 0, 0, 0
end

function mt:__add(v)
	local vx, vy, vz = get_xyz(v)
	return Vector3D(self.x + vx, self.y + vy, self.z + vz)
end

function mt:__mul(v)
	if type(v) == "number" then
		return Vector3D(self.x * v, self.y * v, self.z * v)
	end
	local vx, vy, vz = get_xyz(v)
	return Vector3D(self.x * vx, self.y * vy, self.z * vz)
end

function mt:__sub(v)
	local vx, vy, vz = get_xyz(v)
	return Vector3D(self.x - vx, self.y - vy, self.z - vz)
end

function mt:__tostring()
	return string.format("Vector3D(%.3f, %.3f, %.3f)", self.x, self.y, self.z)
end

Vector3D = function(x, y, z)
	local obj = {
		x = tonumber(x) or 0,
		y = tonumber(y) or 0,
		z = tonumber(z) or 0
	}
	return setmetatable(obj, mt)
end

return Vector3D
