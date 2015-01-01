---===Map===---
-- includes
objects.Init()

-- declaring
dbg.Print("| Requiring 'Map' class.", "engine")
engine.Require("container", "classes")
Map = objects.Class("Map")

-- public methods
function Map:initialize(id, fileName)

	-- conditionally private members
	self._id = id
	self._fileName = fileName -- possibly should be merged with id

	self._isBuilded = false
	self._entities = {}
	self._services = {}
	self._containers = {}
	self._entitiesSorted = {} -- for optimization and lighter work with entities -- x.y.objType.
	self._servicesSorted = {} -- objType.
	self._entitiesNamed = {}
	self._servicesNamed = {}
	
	self._containers._global = Container({x = 0, y = 0}, self._entities) -- put entities in a global container
end

function Map:build(pos)
	if self._isBuilded then 
		return false
	end

	if type(pos) == "table" and type(pos.x) == "number" and type(pos.y) == "number" then
		self._containers._global:setPosition(pos)
	end
	self._containers._global:runEntityMethod(nil, "setVisibility", true)
	self._isBuilded = true
end

function Map:destroy()
	if not self._isBuilded then
		return false
	end
	
	self._isBuilded = false
end

function Map:scan(size)
	for x = 0, size[1] do
		for y = 0, size[2] do
			local x, y = func.GetPixel(x, y)
			for objType, class in pairs(const.objectTypes) do
				local link = findobj(objType, x, y)
				if link then
					local props = {}
					local tempTable = getmetatable(link);
					local property = "name";
					while property ~= nil do
						props[property] = tempTable.__index(link, property)
						property = tempTable.__next(link, property)
					end
					dbg.Print("| Scaning '"..objType.."' on "..func.GetSquare(x)..", "..func.GetSquare(y), "map")
					table.insert(self._entities, _G[class]({x = x, y = y}, props, objType))
				end
			end
		end
	end
end

function Map:load()
	local data
	local isLoaded, errorMsg = pcall(function() data = dofile(const.mapPath..self._fileName..".wsmap") end)
	
	if type(data) == "table" then
		self:_read(data)
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

function Map:save(fileName, mapType)
	checktype({fileName, mapType}, {"string", "nil"}, funcName)
	check(type(size.x) == "number" and type(size.y) == "number", "bad argument #2 to 'Map:convert' (size.x and size.y must contain square coordinates)")
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

function Map:_read(data)
	for _,properties in pairs(data) do
		-- reading data
		local class = properties[1]
		table.remove(properties, 1)
		if type(class) ~= "string" then
			dbg.Print("| WARNING: First value of object table must be string and comprice class info", "engine")
		elseif objects.CheckAffinity(_G[class], Service) then
			local obj = _G[class](unpack(properties)) -- create this object
			if obj._props.name then
				dbg.Print("| Loading '"..class.." named '"..obj._props.name.."'", "map")
			else
				dbg.Print("| Loading '"..class.."'", "map")
			end
			if type(self._servicesSorted[class]) ~= "table" then
				self._servicesSorted[class] = {}
			end
			table.insert(self._services, obj)
			table.insert(self._servicesSorted[class], obj)
			if type(properties[1]) == "table" and properties[1].name then
				table.insert(self._servicesNamed[properties[1].name], obj)
			end
		elseif objects.CheckAffinity(_G[class], Entity) then
			local pos = properties[1]
			pos.x = pos.x or pos[1]
			pos.y = pos.y or pos[2]
			if #pos < 4 then
				local obj = _G[class](unpack(properties)) -- create this object
				if obj._props.name then
					dbg.Print("| Loading '"..class.."' named '"..obj._props.name.."' on "..pos.x..", "..pos.y, "map")
				else
					dbg.Print("| Loading '"..class.."' on "..pos.x..", "..pos.y, "map")
				end
				if type(self._entitiesSorted[pos.x]) ~= "table" then
					self._entitiesSorted[pos.x] = {}
				end
				if type(self._entitiesSorted[pos.x][pos.y]) ~= "table" then
					self._entitiesSorted[pos.x][pos.y] = {}
				end
				if type(self._entitiesSorted[pos.x][pos.y][class]) ~= "table" then
					self._entitiesSorted[pos.x][pos.y][class] = {}
				end
				table.insert(self._entities, obj)
				table.insert(self._entitiesSorted[pos.x][pos.y][class], obj)
				if type(properties[2]) == "table" and properties[2].name then
					table.insert(self._entitiesNamed[properties[2].name], obj)
				end
			elseif #pos >= 4 then
				-- loading structure
				table.remove(properties, 1)
				for x = func.GetSquare(pos[1]), func.GetSquare(pos[3]) do
					for y = func.GetSquare(pos[2]), func.GetSquare(pos[4]) do
						local obj = _G[class]({x = func.GetPixel(x), y = func.GetPixel(y)}, unpack(properties)) -- create this object
						if obj._props.name then
							dbg.Print("| Loading '"..class.."' named '"..obj._props.name.."' on "..x..", "..y, "map")
						else
							dbg.Print("| Loading '"..class.."' on "..x..", "..y, "map")
						end
						table.insert(self._entities, obj)
					end
				end
			end
		elseif objects.CheckAffinity(_G[class], Container) then
			local obj = _G[class](unpack(properties)) -- create this object
			table.insert(self._containers, obj)
		else
			dbg.Print("| WARNING: Unknown type of object: "..class, "engine")
		end
	end
	
	return nil
end

function Map:_unload()
	
end

function Map:_write(fileName, size, mapType)
	
end