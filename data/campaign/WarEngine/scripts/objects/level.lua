---===Level===---
-- includes
objects.Init()

-- declaring
dbg.Print('- Requiring \'Level\' class')
Level = objects.Class('Level')

-- public methods
function Level:initialize(id)
	
	-- conditionally private members
	self._id = id -- level folder's name
	self._maps = {} -- list of maps on this level
	self._currentMap = nil
	self._characters = {} -- list of characters on this level
	-- Note: maps, currentMap and characters are automaticly read while initializing
end

function Level:setMap(id)
	self._currentMap = id
	--maps[currentMap]:build() -- requires map class
end

function Level:run()
	dofile(path.levels..self._id..'/init.lua')
end