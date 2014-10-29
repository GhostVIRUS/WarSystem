---===Entity===---
-- includes
objects.Init()

-- declaring
dbg.Print("| Requiring 'Entity' class.", "objects")
Entity = objects.Class("Entity")

-- public methods
function Entity:initialize(name, pos, props)
	props = props or {};
	props["name"] = props["name"] or name;

	-- conditionally private members
	self._name = name
	self._pos = pos
	self._link = link
	self._isVisible = false
	self._props = props

	self._objectType = nil -- maybe this will not be needed

	self._allowMoving = false -- just for fun... for now! heheh
	self._isMoving = false

	self._texture = 'classic' -- for future

	return nil
end

function Entity:getPosition()
	return self._pos
end

function Entity:setProperties(props) -- requires table property-value
	for key, value in pairs(props) do
		self._props[key] = value
	end

	if self._isVisible == true then
		self:_updateProps()
	end

	return nil
end

function Entity:setVisibility(value)
	dbg.Print(self._name..":setVisibility()", "objects")
	if value == true then
		self:_show()
	elseif value == false then
		self:_hide()
	end

	return nil
end

function Entity:getVector(pos) -- maybe should be renamed in getLine() or smth like that
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

function Entity:move(pos, parameters) -- parameters.time in seconds; if time = 0 works as setposition
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

function Entity:follow(whoName, speed, iteration) -- speed here and above in px/sec
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

function Entity:stopMoving() -- doesn't work at move()
	self._allowMoving = false
end

-- conditionally private methods
function Entity:_saveProps()
	dbg.Print(self._name..":_saveProps()", "objects")
	local tempTable = getmetatable(self._link);
	local property = "name";

	while property ~= nil do
		self._props[property] = tempTable.__index(self._link, property)
		property = tempTable.__next(self._link, property)
	end

	return nil
end

function Entity:_show()
	dbg.Print(self._name..":_show()", "objects")
	self._link = actor(self._objectType, self._pos.x, self._pos.y, self._props)
	self._isVisible = true
	self:_saveProps()

	return nil
end

function Entity:_hide()
	dbg.Print(self._name..":_hide()", "objects")
	self._isVisible = false
	self:_saveProps()
	kill(self._link)
	self._link = nil

	return nil
end

function Entity:_updatePos() -- updating real Entity's coords from props
--	dbg.Print(self._name..":_updatePos()", "objects") -- Floods a lot
	if self._isVisible == true then
		setposition(self._link, self._pos.x, self._pos.y)
	end

	return nil
end

function Entity:_updateProps() -- updating real Entity's properties from props
	if self._isVisible == true then
		for key, value in pairs(self._props) do
			self._link[key] = value
		end
	end

	return nil
end