---===Walls===---
-- includes
objects.Init()
engine.Require("rigidbody", "classes")

---===Wall===---
-- declaring
dbg.Print("| Requiring \'Wall\' class.", "objects")
Wall = objects.Class('Wall', RigidBodyStatic)

-- public methods
function Wall:initialize(--[[name,]] pos, props)
	RigidBodyStatic.initialize(self, --[[name,]] pos, props)

	return nil
end

--[[function Wall:_show()
	RigidBodyStatic._show(self)

	return nil
end]]

function Wall:_updatePos()
	local corner = self._props.corner
	if corner ~= 0 then
		self._props.corner = 0
		self:_updateProps()
		RigidBodyStatic._updatePos(self)
		self._props.corner = corner
		self:_updateProps()
	else
		RigidBodyStatic._updatePos(self)
	end
end


---===Concrete===---
-- declaring
dbg.Print("| Requiring 'Concrete' class.", "objects")
Concrete = objects.Class('Concrete', Wall)

-- public methods
function Concrete:initialize(--[[name,]] pos, props)
	Wall.initialize(self,--[[ name,]] pos, props)

	self._objectType = "wall_concrete"
	
	return nil
end

--[[ conditionally private methods
function Concrete:_show()
	self._link = actor('wall_concrete', self._pos.x, self._pos.y, self._props)
	Wall._show(self)
end]]


---===Brick===---
-- declaring
dbg.Print("| Requiring 'Brick' class.")
Brick = objects.Class('Brick', Wall)

-- public methods
function Brick:initialize(--[[name,]] pos, props)
	Wall.initialize(self,--[[ name,]] pos, props)

	self._objectType = "wall_brick"
	
	return nil
end

--[[ conditionally private methods
function Brick:_show()
	self._link = actor('wall_brick', self._pos.x, self._pos.y, self._props)
	Wall._show(self)
end]]