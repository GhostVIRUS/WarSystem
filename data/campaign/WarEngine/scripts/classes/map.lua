---===Map===---
-- includes
objects.Init()

-- declaring
dbg.Print("| Requiring 'Map' class.", "objects")
engine.Require("container", "classes")
Map = objects.Class("Map")

-- public methods
function Map:initialize(id, fileName)

	-- conditionally private members
	self._id = id
	self._fileName = fileName -- possibly should be merged with id

	self._size = {}
	self._entities = {}
	self._services = {}
	self._containers = {}
	self._entitiesSorted = {} -- for optimization and lighter work with entities
	self._servicesSorted = {}
end

function Map:build(pos)
	self:_read()
	self._containers._global:setPosition(pos)
	self._containers._global:runEntityMethod(nil, "SetVisibility", true)
end

function Map:convert()
	
end

function Map:getEntity(x, y, objType)
	local entities = self._entitiesSorted[x][y][objType]
	if type(entities) == "table" and #entities == 1 then
		return entities[1]
	else
		return entities
	end
end

function Map:getService(objType)
	local services = self._servicesSorted[objType]
	if type(services) == "table" and #services == 1 then
		return services[1]
	else
		return services
	end	
end

function Map:setFile(fileName)
	self._fileName = fileName
end

function Map:getFile(fileName)
	return self._fileName
end

-- conditionally private methods
--[[function Map:_load() -- temporarity frozen
	local file = io.open(self._fileName)
--	local lineNum = 0;

	for line in file:lines() do
		if string.sub(line, 0, 2) ~= "//" then -- commentaries and remarks
--			lineNum = lineNum + 1
--			if lineNum == 1 then -- first line without commentaries must include map size
--				string.gsub(line, "(%a+) (%a+)", function(x, y) 
--					self._size = {x = x, y = y} 
--				end)
--			else
				local class = string.match(line, "%a+")
				local isStructure = string.sub(class, 0, 1) == "~"
				if isStructure then -- "~" in the beginning of line means that we must build a structure
					class = string.sub(class, 2)
					line = string.sub(line, 2)
				end
				if _G[class] and string.match(tostring(_G[class]), "(%a+)") == "class" then -- if type(class) == "class"
					local properties = {}
					local pNum = 1
					local tabGetMode = false
					for i = 1, string.len(line) do
						local char = string.char(string.byte(line, i))
						if char == " " and not tabGetMode then
							pNum = pNum + 1
						elseif char == "{" then

						end
						properties[pNum] = properties[pNum]..char
					end

					local words = {}					
					line = string.gsub(line, "(%a+)", function(word)
						table.insert(words, word)
					end)
					if objects.CheckAffinity(class, Entity) and not isStructure then
						local x = words[2]
						local y = words[3]
						local properies = words;
						for i = 1, 3 do
							table.remove(properties, 1)
						end
						-- create entities
					end
				end
--			end
		end
	end
	
	file:close()
end]]

function Map:_load()
	local data
	local isLoaded, errorMsg = pcall(function() data = dofile(self._fileName.."/info.lua") end)
	
	if type(data) == "table" then
		for _,obj in pairs(data) do
			-- loading data
			local class = obj[1]
			table.remove(obj, 1)
			if objects.CheckAffinity(class, Service) then
				table.insert(self._services, _G[class](unpack(obj)))
			elseif objects.CheckAffinity(class, Entity) then
				local pos = obj[1]
				if type(pos) == "table" and #pos < 4 then
					table.insert(self._entities, _G[class](unpack(obj)))
				elseif type(pos) == "table" and #pos >= 4 then
					-- loading structure
				end
			elseif objects.CheckAffinity(class, Container) then
				table.insert(self._containers, _G[class](unpack(obj)))
			else
				
			end
		end
		self._containers._global = Container({x = 0, y = 0}, self._entities) -- put entities in a global container
	elseif not info and not errorMsg then -- if file loaded without errors, but returns nothing
		dbg.Print("| WARNING: Map '"..self._id.."' wasn't loaded: file must return a table with texts", "engine")
		return nil
	end
	
	if isLoaded then
		dbg.Print("| Map '"..self._id.."' is loaded.", "engine")
	else
		dbg.Print("| WARNING: Map '"..self._id.."' wasn't loaded: "..errorMsg, "engine")
	end
	return true
end

function Map:_unload()
	
end

function Map:_write(fileName, mapType)
	
end