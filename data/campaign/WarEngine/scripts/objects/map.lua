---===Map===---
-- includes
objects.Init()

-- declaring
dbg.Print("| Requiring 'Map' class.", "objects")
Map = objects.Class("Map")

-- public methods
function Map:initialize(id, fileName)

	-- conditionally private members
	self._id = id
	self._fileName = fileName -- possibly should be merged with id

	self._objects = {}
	self._structures = {}
end

function Map:build()
	self:_read()
	-- here comes building
end

-- conditionally private methods
local function Map:_read()
	-- reading map data from lua file
end
