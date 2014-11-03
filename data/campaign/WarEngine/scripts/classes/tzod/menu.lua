---===Menu===---
-- includes
objects.Init()
engine.Require("service", "classes")

-- declaring
dbg.Print("| Requiring 'Menu' class.", "objects")
Menu = objects.Class('Menu', Service)

-- public methods
function Menu:initialize(name, props)
	Service.initialize(self, name, props)

	-- public members
	self.section = ""
	
	-- conditionally private members
	self._objectType = "menu"
end

