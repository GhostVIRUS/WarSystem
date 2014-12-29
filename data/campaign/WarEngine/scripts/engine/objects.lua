-- WarEngine. Объекты.

function objects.Init()
	package.path = "data/campaign/WarEngine/scripts/classes/?.lua;data/campaign/WarEngine/scripts/classes/tzod/?.lua;data/"..const.clsPath.."?.lua" -- classes folders
	objects.Class = engine.Require("middleclass", "classes");
end

function objects.CheckAffinity(expChildClass, expSuperClass)
	checktype({expChildClass}, {"table"}, "objects.CheckAffinity")
	while expChildClass.super ~= nil do
		expChildClass = expChildClass.super;
		if expChildClass == expSuperClass then
			return true;
		end;
	end;
	return false;
end

-- engine.Unrequire("all", "classes") -- unrequiring all classes