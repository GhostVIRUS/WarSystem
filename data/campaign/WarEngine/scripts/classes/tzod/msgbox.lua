---===MsgBox===---
-- includes
objects.Init()
engine.Require("service", "classes")

-- declaring
dbg.Print("| Requiring 'MsgBox' class.", "objects")
MsgBox = objects.Class('MsgBox', Service)

-- public methods
function MsgBox:initialize(name, props)
	Service.initialize(self, name, props)

	self._objectType = "msgbox"
end

