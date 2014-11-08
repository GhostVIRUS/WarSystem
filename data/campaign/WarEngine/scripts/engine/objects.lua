-- WarEngine. Объекты.

function objects.Init()
	package.path = "data/campaign/WarEngine/scripts/classes/?.lua;data/campaign/WarEngine/scripts/classes/tzod/?.lua;data/"..const.clsPath.."?.lua" -- classes folders
	objects.Class = engine.Require("middleclass", "classes");
end

engine.Unrequire("all", "classes") -- unrequiring all classes