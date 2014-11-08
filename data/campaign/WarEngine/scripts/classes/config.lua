---===Config===---
-- includes
objects.Init()

-- declaring
dbg.Print("| Requiring 'Config' class.", "objects")
Config = objects.Class("Config")

-- public methods
function Config:initialize(name, file, values)

	-- conditionally private members
	self._name = name
	self._file = file
	self._values = values
end

function Config:load()
	
end

function Config:save()
	
end

-- conditionally private methods

function Config:_refresh()
	
end