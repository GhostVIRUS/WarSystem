---===Wood===---
-- includes
objects.Init()
engine.Require("entity", "classes")

-- declaring
dbg.Print("| Requiring 'Wood' class.")
Wood = objects.Class("Wood", Entity)

-- public methods
function Wood:initialize(--[[name,]] pos, props)
	Entity:initialize(self, --[[name,]] pos, props)

	self._objectType = "wood"
end