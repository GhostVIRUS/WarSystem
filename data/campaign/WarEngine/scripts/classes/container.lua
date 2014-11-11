---===Сontainer===---
-- includes
objects.Init()
engine.Require("Entity", "classes")

-- declaring
dbg.Print("| Requiring 'Container' class.")
Container = objects.Class("Сontainer")

-- public methods
function Container:initialize(name, pos, entities) -- entities = objects that controlled by container
	
	-- conditionally private members
	self._name = name
	self._pos = pos
	self._entities = entities or {}
	self._incontainerPos = self:_calcuateIncontainerPos()
end

function Container:getPosition()
	return self._pos
end

function Container:getVector(pos) -- maybe should be renamed in getLine() or smth like that
--	print(self._name..':getVector()')
	local xCathetus = pos.x - self._pos.x
	local yCathetus = pos.y - self._pos.y
	local hypotenuse = math.sqrt((xCathetus * xCathetus) + (yCathetus * yCathetus))
	local alpha = math.acos(xCathetus / hypotenuse)
	if pos.y < self._pos.y then
		alpha = math.pi*2 - alpha
	end

	return hypotenuse, alpha
end

function Container:move(pos, parameters) -- parameters.time in seconds; if time = 0 works as setposition
	dbg.Print(self._name..":move()"..tostring(self._allowMoving), "objects")

	self._isMoving = true

	local distance, angle = self:getVector(pos)
	local currentTime = 0
	local currentSpeed = 0
	if parameters.time ~= nil then
		currentSpeed = distance/(parameters.time*50)
	else
		currentSpeed = parameters.speed/50
	end
	if parameters.time == 0 then
		currentSpeed = distance
	end
	for i = 1, distance, currentSpeed do
--		if self._allowMoving == true then
			pushcmd( 
				function()
					self._pos.x = math.min(self._pos.x + math.cos(angle)*currentSpeed, pos.x)
					self._pos.y = math.min(self._pos.y + math.sin(angle)*currentSpeed, pos.y)
					self:_updatePos() -- instead of setposition
				end, currentTime)
			currentTime = currentTime + (1/50)
--		end
	end

	self._isMoving = false
	return nil
end

function Container:follow(whoName, speed, iteration) -- speed here and above in px/sec
	if iteration == 0 then
		dbg.Print(self._name.."follow()", "objects")
		self._allowMoving = true
	end
	self._isMoving = true

	pushcmd( function()
		local whoX, whoY = position(whoName)
		local distance, angle = self:getVector({ x = whoX, y = whoY }) -- rework access to position (maybe)
		if distance > 8*32 then
			self._pos.x = self._pos.x + math.cos(angle)*speed/100
			self._pos.y = self._pos.y + math.sin(angle)*speed/100
			self:_updatePos()
		end

		self._isMoving = false

		if self._allowMoving then
			self:follow(whoName, speed, 1) -- recursion
		end

	end, 1/100)

	return nil
end

function Container:stopMoving() -- doesn't work at move()
	self._allowMoving = false
end

function Container:runEntityMethod(entity, method, ...)
	if entity then
		local object = self._entities[entity]
		Entity[method](object, ...)
	else
		for entity, object in pairs(self._entities) do
			self:runEntityMethod(entity, method, ...)
		end
	end
	self:_calcuateIncontainerPos()
	
	return nil
end

function Container:_updatePos()
	for entity, object in pairs(self._entities) do
		object._pos.x = self._pos.x + self._incontainerPos[entity].x
		object._pos.y = self._pos.y + self._incontainerPos[entity].y
		object:_updatePos()
		self:_calcuateIncontainerPos()
	end
end

function Container:_calcuateIncontainerPos()
	local incontainerPos = {}
	for entity, object in pairs(self._entities) do
		incontainerPos[entity] = {}
		incontainerPos[entity].x = object._pos.x - self._pos.x
		incontainerPos[entity].y = object._pos.y - self._pos.y 
	end

	return incontainerPos
end