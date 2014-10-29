---===Vehicle===---
-- includes
objects.Init()
engine.Require("rigidbodydynamic", "classes")

-- declaring
dbg.Print("| Requiring 'Vehicle' class.", "objects")
Vehicle = objects.Class('Vehicle', RigidBodyDynamic)

-- public methods
function Vehicle:initialize(name, pos, props)
	RigidBodyDynamic.initialize(self, name, pos, props)

	self._class = nil -- nil only for now
end