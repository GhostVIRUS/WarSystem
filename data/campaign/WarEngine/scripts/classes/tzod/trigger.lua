---===Trigger===---
-- includes
objects.Init()
engine.Require("entity", "classes")

-- declaring
dbg.Print("| Requiring 'Trigger' class.", "objects")
Trigger = objects.Class("Trigger", Entity)

-- public methods

function Trigger:initialize(--[[name,]] pos, props)
	Entity.initialize(self, --[[name,]] pos, props)

	self._objectType = "trigger"
end
