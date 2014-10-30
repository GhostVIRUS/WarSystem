---===Character===---
-- includes
objects.Init()
engine.Require("service", "classes")

-- declaring
dbg.Print("| Requiring 'Character' class.")
Character = objects.Class("Character", Service)

-- public methods
function Character:initialize(name, props)
	Service:initialize(self, name, props)
	
	-- there will be character properties
end

function Character:_show() end

function Character:_hide() end