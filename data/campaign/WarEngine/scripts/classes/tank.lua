---===Tank===---
-- includes
objects.Init()
engine.Require("vehicle", "classes")

-- declaring
dbg.Print("| Requiring 'Tank' class.")
Tank = objects.Class("Tank", Vehicle)

-- public methods
function Tank:initialize(name, pos, props)
	Vehicle:initialize(self, name, pos, props)

	-- there will be character properties
end