---===Water===---
-- includes
objects.Init()
engine.Require("rigidbody", "classes")

-- declaring
dbg.Print("| Requiring 'Water' class.", "objects")
Water = objects.Class('Water', RigidBodyStatic)

-- public methods
function Water:initialize(--[[name,]] pos, props)
	RigidBodyStatic.initialize(self, --[[name,]] pos, props)

	self._objectType = "water"

	return nil
end