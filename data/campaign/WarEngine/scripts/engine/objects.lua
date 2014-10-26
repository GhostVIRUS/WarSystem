-- WarEngine. Объекты.

function objects.Init()
	package.path = "data/campaign/WarEngine/scripts/objects/?.lua;data/"..const.objPath.."?.lua" -- classes folders
	objects.Class = engine.Require("middleclass", "classes");
end

engine.Unrequire("all", "classes") -- unrequiring all classes