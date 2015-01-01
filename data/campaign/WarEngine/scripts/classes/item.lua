---===Item===---
-- includes
objects.Init()
engine.Require("Trigger", "classes")
engine.Require("Sprite", "classes")
engine.Require("Container", "classes")

-- declaring
dbg.Print("| Requiring 'Item' class.")
Item = objects.Class("Item", "Container") -- item, that is located in the map

-- public methods
function Item:initialize(--[[name,]] pos, props, storedItem)
	Container:initialize(--[[name,]] pos)

	local trigName
	local sprtName
	if type(name) == "string" then
		trigName = name.."_trig"
		sprtName = name.."_sprite"
	end
	
	-- conditionally private members
	self._props = func.UniteTables({
		texture = "pu_booster",
		sound = nil,
		animate = 20,
		takable = true,
		only_human = 0,
		owner = nil, -- tank dropping the item
		}, props)
	-- temply, i hope
	local num = math.random(1, 10000)
	temp[num] = self
	self._entities = {
		trigger = Trigger(trigName, self._pos, {only_human = self._props.only_human,
									  on_enter = "temp["..num.."]:pickup()", on_leave = "temp["..num.."]:drop()"}),
		sprite = Sprite(sprtName, self._pos, {texture = self._props.texture, animate = self._props.animate}),
	}
	self._storedItem = storedItem -- after pickuping it writes to invetory of tank
end

function Item:pickup()

end

function Item:drop()

end
