---===Inventory===---
-- includes
objects.Init()

-- declaring
dbg.Print("| Requiring 'Inventory' class.")
Inventory = objects.Class("Inventory")

-- public methods
function Inventory:initialize(items, weapons, keys, capacity, id)

	-- conditionally private members
	self._id = id
	self._items = items or {}
	self._weapons = weapons or {}
	self._keys = keys or {}
	self._capacity = capacity or math.huge
end
