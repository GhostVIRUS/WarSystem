---===RigidBody===---
-- includes
objects.Init()
engine.Require("entity", "classes")

-- declaring
dbg.Print("| Requiring 'RigidBodyStatic' class.")
RigidBodyStatic = objects.Class("RigidBodyStatic", Entity)

-- public methods
function RigidBodyStatic:initialize(name, pos, props)
	Entity.initialize(self, name, pos, props)

end

function RigidBodyStatic:damage(health)
	checktype({health}, {"number"}, "RigidBodyStatic:damage")

	damage(health, self.link)
end

-- TODO: Add on_damage, on_destroy auto-handlers

---===UserObject===---
-- declaring
dbg.Print("| Requiring 'UserObject' class.", "objects")
UserObject = objects.Class("UserObject", RigidBodyStatic)

-- public methods
function UserObject:initialize(name, pos, props)
	RigidBodyStatic.initialize(self, name, pos, props)

end
