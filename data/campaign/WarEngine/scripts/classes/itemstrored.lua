---===ItemStored===---
-- includes
objects.Init()

-- declaring
dbg.Print("| Requiring 'ItemStored' class.")
ItemStored = objects.Class("ItemStored") -- item, that is located in the inventory

-- public methods
function ItemStored:initialize(title, owner) -- title (table) - it's shown in inventory; owner - inventory containing item 
	
end
