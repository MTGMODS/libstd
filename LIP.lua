local LIP = {}

function LIP.load(fileName)
	assert(type(fileName) == 'string', 'Parameter "fileName" must be a string.')
	local file = io.open(fileName, 'r')
	if not file then return nil end

	local data = {}
	local section
	for line in file:lines() do
		local tempSection = line:match('^%[([^%]]+)%]')
		if tempSection then
			section = tonumber(tempSection) and tonumber(tempSection) or tempSection
			data[section] = data[section] or {}
		end

		local key, value = line:match('^([%w|_]+)%s-=%s-(.+)$')
		if key and value then
			if tonumber(value) then
				value = tonumber(value)
			elseif value == 'true' then
				value = true
			elseif value == 'false' then
				value = false
			end
			if section then
				data[section][key] = value
			else
				data[key] = value
			end
		end
	end
	file:close()
	return data
end

function LIP.save(fileName, data)
	assert(type(fileName) == 'string', 'Parameter "fileName" must be a string.')
	assert(type(data) == 'table', 'Parameter "data" must be a table.')
	local file = io.open(fileName, 'w')
	if not file then return false end

	local contents = ''
	for section, contentsTable in pairs(data) do
		if type(contentsTable) == 'table' then
			contents = contents .. ('[%s]\n'):format(section)
			for key, value in pairs(contentsTable) do
				contents = contents .. ('%s=%s\n'):format(key, tostring(value))
			end
			contents = contents .. '\n'
		else
			contents = contents .. ('%s=%s\n'):format(section, tostring(contentsTable))
		end
	end
	file:write(contents)
	file:close()
	return true
end

return LIP
