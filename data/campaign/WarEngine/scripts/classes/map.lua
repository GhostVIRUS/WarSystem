---===Map===---
-- includes
objects.Init()

-- declaring
dbg.Print("| Requiring 'Map' class.", "engine")
engine.Require("container", "classes")
Map = objects.Class("Map")

-- public methods
function Map:initialize(id, fileName, comment)

	-- conditionally private members
	self._id = id
	self._fileName = fileName -- possibly should be merged with id
	self._comment = comment -- author's comment at the beginning of map

	self._isBuilded = false
	self._sections = {}
	
	self:_addSection("_global")
end

function Map:build(section, pos)
	if self._isBuilded then
		error("maybe excess 'Map:build'; map '"..self._id.."' have built yet", 2)
	end

	section = section or "_global"
	if type(pos) == "table" and type(pos.x) == "number" and type(pos.y) == "number" then
		self._sections[section]._globalContainer:setPosition(pos)
	end
	self._sections[section]._globalContainer:runEntityMethod(nil, "setVisibility", true)
	self._isBuilded = true
end

function Map:destroy()
	if not self._isBuilded then
		error("maybe excess 'Map:destroy'; map '"..self._id.."' have not built yet", 2)
	end
	
	self._sections._global._globalContainer:runEntityMethod(nil, "setVisibility", false)
	for container,_ in pairs(self._sections._global.containers.list) do
		container:runEntityMethod(nil, "setVisibility", false)
	end
	
	self:initialize(self._id, self._fileName)
end

function Map:scan(size, sectionName)
	sectionName = sectionName or "scanned"
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
					if props.name == "" then -- non-named objects has got name ""
						props.name = nil -- we must fix it
					end
					if not self._sections[sectionName] then
						self:_addSection(sectionName)
					end
					dbg.Print("| Scaning '"..objType.."' on "..func.GetSquare(x)..", "..func.GetSquare(y), "map")
					self:_addObj(sectionName, class, {{x, y}, props, objType})
				end
			end
		end
	end
end

function Map:load()
	check(self._fileName, "at first you must set file name now (use 'Map:setFile')")

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

function Map:save()
	check(self._fileName, "at first you must set file name (use 'Map:setFile')")

	dbg.Print("| Saving map '"..self._fileName.."'", "engine")
	local file = io.open(self._fileName, "w")
	local output = xpcall(function() return "-- "..self._comment.."\n" end) or ""
	
	output = self._write(output)

	file:write(output)
	file:close()
	
	return nil
end

function Map:getGlobalContainer(section)
	section = section or "_global"

	return self._sections[section]._globalContainer
end

function Map:getObj(name, sectionName)
	sectionName = sectionName or "_global"
	
	return self._sections[sectionName].namedObjects[name]
end

function Map:findEntity(x, y, objType, sectionName)
	sectionName = sectionName or "_global"
	local entities = self._sections[sectionName].entities.sorted[x][y][objType]
	
	if type(entities) == "table" and #entities == 1 then
		return entities[1]
	else
		return entities
	end
end

function Map:findService(objType, sectionName)
	sectionName = sectionName or "_global"
	local services = self._sections[sectionName].services.sorted[objType]
	
	if type(services) == "table" and #services == 1 then
		return services[1]
	else
		return services
	end	
end

function Map:exists(name)
	if self._sections._global.namedObjects[name] then
		return true
	else
		return false
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

function Map:_addSection(sectionName)
	self._sections[sectionName] = {
		services = {sorted = {}, list = {}}, -- for optimization and lighter work with entities
		entities = {sorted = {}, list = {}},
		containers = {sorted = {}, list = {}},
		namedObjects = {},
	}
	self._sections[sectionName]._globalContainer = Container({x = 0, y = 0}, self._sections[sectionName].entities.list) -- put entities in a global container
end

function Map:_addObj(sectionName, class, properties)
	if objects.CheckAffinity(_G[class], Service) then -- if class is service
		local obj = _G[class](unpack(properties)) -- create this object
		if obj._props.name then
			dbg.Print("| Loading '"..class.." named '"..obj._props.name.."'", "map")
		else
			dbg.Print("| Loading '"..class.."'", "map")
		end
		if type(properties[1]) == "table" and properties[1].name then -- if object has name
			if self._sections._global.services.namedObjects[properties[1].name] or self._sections[sectionName].namedObjects[properties[1].name] then
				error("error in section '"..sectionName.."' of map '"..self.id.."' object with name '"..properties[1].name.."' already exists", 4)
			end
			self._sections[sectionName].namedObjects[properties[1].name] = obj -- add this object to list of objects sorted by name
			self._sections._global.services.namedObjects[properties[1].name] = obj -- and to global table too
		end
		if type(self._sections[sectionName].services.sorted[class]) ~= "table" then -- if objects of this class haven't loaded early
			self._sections[sectionName].services.sorted[class] = {} -- create class table in list of objects sorted by coords and type
		end
		if type(self._sections._global.services.sorted[class]) ~= "table" then -- the same with global section
			self._sections._global.services.sorted[class] = {}
		end
		table.insert(self._sections[sectionName].services.list, obj) -- fill tables with our object
		table.insert(self._sections[sectionName].services.sorted[class], obj)
		table.insert(self._sections._global.services.list, obj)
		table.insert(self._sections._global.services.sorted[class], obj)
	elseif objects.CheckAffinity(_G[class], Entity) then -- if class is entity
		local pos = properties[1]
		pos.x = pos.x or pos[1] -- for lighter way to enter coords
		pos.y = pos.y or pos[2]
		if #pos < 4 then -- if it isn' structure
			local obj = _G[class](unpack(properties)) -- create this object
			if obj._props.name then
				dbg.Print("| Loading '"..class.."' named '"..obj._props.name.."' on "..pos.x..", "..pos.y, "map")
			else
				dbg.Print("| Loading '"..class.."' on "..pos.x..", "..pos.y, "map")
			end
			if type(properties[2]) == "table" and properties[2].name then
				if self._sections[sectionName].namedObjects[properties[2].name] or self._sections._global.namedObjects[properties[2].name] then
					error("error in section '"..sectionName.."' of map '"..self._id.."' object with name: '"..properties[2].name.."' already exists", 4)	
				end
				self._sections[sectionName].namedObjects[properties[2].name] = obj -- add this object to list of objects sorted by name
				self._sections._global.namedObjects[properties[2].name] = obj -- and to global table too
			end
			if type(self._sections[sectionName].entities.sorted[pos.x]) ~= "table" then -- entities have got more properties
				self._sections[sectionName].entities.sorted[pos.x] = {} -- so we have to do more checks
			end
			if type(self._sections[sectionName].entities.sorted[pos.x][pos.y]) ~= "table" then
				self._sections[sectionName].entities.sorted[pos.x][pos.y] = {}
			end
			if type(self._sections[sectionName].entities.sorted[pos.x][pos.y][class]) ~= "table" then
				self._sections[sectionName].entities.sorted[pos.x][pos.y][class] = {}
			end
			if type(self._sections._global.entities.sorted[pos.x]) ~= "table" then
				self._sections._global.entities.sorted[pos.x] = {}
			end
			if type(self._sections._global.entities.sorted[pos.x][pos.y]) ~= "table" then
				self._sections._global.entities.sorted[pos.x][pos.y] = {}
			end
			if type(self._sections._global.entities.sorted[pos.x][pos.y][class]) ~= "table" then
				self._sections._global.entities.sorted[pos.x][pos.y][class] = {}
			end
			table.insert(self._sections[sectionName].entities.list, obj) -- fill tables with our object
			table.insert(self._sections[sectionName].entities.sorted[pos.x][pos.y][class], obj)
			table.insert(self._sections._global.entities.list, obj)
			table.insert(self._sections._global.entities.sorted[pos.x][pos.y][class], obj)
		elseif #pos >= 4 then -- if it's structure
			-- loading structure
			table.remove(properties, 1) -- remove pos from prop table
			local i = 0 -- object number, if it has got name
			for x = func.GetSquare(pos[1]), func.GetSquare(pos[3]) do
				for y = func.GetSquare(pos[2]), func.GetSquare(pos[4]) do
					if properties.name then -- if structure has got name then objects has got it name with number
						i = i + 1
						properties.name = properties.name..i
					end
					properties = {{x = func.GetPixel(x), y = func.GetPixel(y)}, unpack(properties)} -- replace coords
					self:_addObj(sectionName, class, properties)
				end
			end
		end
	else
		dbg.Print("| WARNING: Unknown type of object: '"..class.."' on map '"..self._id.."'", "engine")
	end
end

function Map:_read(data)
	for sectionName, sectionData in pairs(data) do
		self:_addSection(sectionName)
		for _,properties in pairs(sectionData) do
			-- reading data
			local class = properties[1]
			table.remove(properties, 1) -- remove class info from prop table
			if type(class) ~= "string" then -- if mapper's hands grows from his back
				dbg.Print("| WARNING: First value of object table must be string and comprice class info", "engine")
			else
				self:_addObj(sectionName, class, properties)
			end
		end
	end
	
	return nil
end

function Map:_unload()
	
end

function Map:_write(output)
	
end