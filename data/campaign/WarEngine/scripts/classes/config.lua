---===Config===---
-- includes
objects.Init()

-- declaring
dbg.Print("| Requiring 'Config' class.", "objects")
Config = objects.Class("Config")

-- public methods
function Config:initialize(name, fileName, values, comment)

	-- conditionally private members
	self._name = name
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
	else
		self:save()
	end
	file:close()
	
	return nil
end

function Config:save()
	dbg.Print("| Saving config '"..self._fileName.."'", "engine")
	local file = io.open(self._fileName, "w")
	local output = self._comment.."\n" or ""
	
	for key, value in pairs(self._values) do
		output = output..key.."="..tostring(value).."\n"
	end
	file:write(output)
	file:close()
	
	return nil
end

-- conditionally private methods
