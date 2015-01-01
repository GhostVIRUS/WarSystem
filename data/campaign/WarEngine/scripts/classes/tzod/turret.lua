---===Turret===---
-- includes
objects.Init()
engine.Require("rigidbody", "classes")

-- declaring
print("| Requiring 'Turret' class.", "objects")
Turret = objects.Class('Turret', RigidBodyStatic)

-- public methods
function Turret:initialize(--[[name,]] pos, props, turretType)
	checktype({turretType}, {"Turret:initialize"})
	RigidBodyStatic.initialize(self, --[[name,]] pos, props)

	self._objectType = turretType

	return nil
end

--[[ conditionally private methods
function Turret:_show()
	RigidBodyStatic._show(self)

	return nil
end]]