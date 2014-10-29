---===RigidBodyDynamic===---
-- includes
objects.Init()
engine.Require("rigidbody", "classes")

-- declaring
dbg.Print("| Requiring 'RigidBodyDynamic' class.", "objects")
RigidBodyDynamic = objects.Class('RigidBodyDynamic', RigidBodyStatic)

-- public methods
function RigidBodyDynamic:initialize(name, pos, props)
	RigidBodyStatic.initialize(self, name, pos, props)

	
end