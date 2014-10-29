---===Crate===---
-- includes
objects.Init()
engine.Require("rigidbodydynamic", "classes")

-- declaring
dbg.Print("| Requiring 'Crate' class.", "objects")
Crate = objects.Class('Crate', RigidBodyDynamic)

-- public methods
function Crate:initialize(name, pos, props)
	RigidBodyDynamic.initialize(self, name, pos, props)

	
end