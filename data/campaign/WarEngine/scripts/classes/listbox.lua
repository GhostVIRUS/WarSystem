---===ListBox===---
-- includes
objects.Init()
engine.Require("msgbox", "classes")

-- declaring
dbg.Print("| Requiring 'ListBox' class.")
ListBox = objects.Class("ListBox", MsgBox)

-- public methods
function ListBox:initialize(name, props)
	MsgBox:initialize(self, name, props)

	-- there will be listbox properties
	
	self.props["text"] = self:_makeList()
end

-- conditionally private methods
local function ListBox:_makeList()

end