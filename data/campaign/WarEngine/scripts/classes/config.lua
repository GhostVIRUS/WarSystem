---===Config===---
-- includes
objects.Init()

-- declaring
dbg.Print("| Requiring 'Config' class.", "objects")
Config = objects.Class("Config")

-- public methods
function Config:initialize(id, fileName, values, comment)

	-- conditionally private members
	self._id = id
	self._fileName = fileName
	self._values = values or {}
	
	self._comment = comment
end

function Config:load()
	local file = io.open(self._fileName)
	
	if file then
		dbg.Print("| Loading config '"..self._fileName.."'", "engine")
		local text = file:read("*a")
		for key, value in string.gmatch(text, "(%w+)=(%w+)") do
			if value == "true" then 
				value = true
			elseif value == "false" then
				value = false
			end
			self._values[key] = value
		end
		file:close()
	else
		self:save()
	end
	
	return nil
end

function Config:save()
	dbg.Print("| Saving config '"..self._fileName.."'", "engine")
	local file = io.open(self._fileName, "w")
	local _, output = xpcall(function() return self._comment.."\n" end, false) or nil, ""
	print(output)
	
	for key, value in pairs(self._values) do
		output = output..key.."="..tostring(value).."\n"
	end
	file:write(output)
	file:close()
	
	return nil
end

-- conditionally private methods
