-- WarEngine. Объекты.

local function LoadClass(class)
--	objects.loaded[class];
	return engine.Require("middleclass", "classes");
end

function objects.Init()
	package.path = "data/campaign/WarEngine/scripts/objects/?.lua;data/campaign/WarEngine/scripts/objects/tzod/?.lua;data/"..const.objPath.."?.lua" -- classes folders
	objects.Class = engine.Require("middleclass", "classes");
end

engine.Unrequire("all", "classes") -- unrequiring all classes