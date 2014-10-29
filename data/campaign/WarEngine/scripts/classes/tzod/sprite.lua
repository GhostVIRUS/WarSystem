---===Sprite===---
-- includes
objects.Init()
engine.Require("entity", "classes")

-- declaring
dbg.Print("| Requiring 'Sprite' class.")
Sprite = objects.Class("Sprite", Entity)

-- public methods
function Sprite:initialize(name, pos, props)
	Entity:initialize(self, name, pos, props)


	self._objectType = "user_sprite"
	-- this is important -> self._texture 
end