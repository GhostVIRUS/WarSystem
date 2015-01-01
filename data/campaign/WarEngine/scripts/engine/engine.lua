function engine.Require(module, group)
	checktype({module, group}, {"string", "string+nil"}, "engine.Require");
	group = group or "ungroupped";
	
	local returnVal;
	local isLoaded, errorMsg = pcall(function() returnVal = require(module) end);
	
	-- replace error message to own
	if not isLoaded then
		local _, msgStart = string.find(errorMsg, ".lua"); -- we just remove useless information of error message
		local level = 2;
		if string.find(errorMsg, "not found:") or string.find(errorMsg, "loop or previous error loading module") then
			msgStart = msgStart + 5; -- it's just a strings magic, even don't try to understand it
		else
			msgStart = 1;
			level = math.huge; -- it's very huge level
		end;
		error(string.sub(errorMsg, msgStart), level);
	end;

	-- saving module or module existing in given package group
	if not engine.packages[group] then engine.packages[group] = {}; end;
	engine.packages[group][module] = returnVal or true;
	
	return returnVal;
end

function engine.Unrequire(module, group, removeFromGlobal)
	checktype({module, group, removeFromGlobal}, {"string", "string+nil", "boolean+nil"}, "engine.Unrequire");
	group = group or "ungroupped";
	local searchWasSuccessful;
--	check(engine.packages[group] or group == "all", "bad argument #2 to 'engine.Unrequire' (group '"..group.."' does't exist)");
	if not engine.packages[group] and group ~= "all" then return; end;
	
	if group == "all" then
		for key,_ in pairs(engine.packages) do
			engine.Unrequire(module, key, removeFromGlobal);
			searchWasSuccessful = true;
		end;
	end;
	
	if searchWasSuccessful then return true; end;
	
	for key,_ in pairs(engine.packages[group]) do
		if module == "all" then
			engine.Unrequire(key, group, removeFromGlobal);
			searchWasSuccessful = true;
		else
			if key == module then
				package.loaded[module] = nil;
				engine.packages[group][module] = nil;
				if removeFromGlobal then _G[module] = nil; end;
				return true;
			end;
		end;
	end;

	if searchWasSuccessful or module == "all" then return true; end;
	
	-- if there is no such module in the group
	error("bad argument #2 to 'engine.Unrequire' (module '"..module.."' isn't loaded in group '"..group.."')", 2)
end

function engine.Reload()
	user.campaignDirectory = const.cmpPath;
	dofile("campaign/WarEngine/scripts/engine/startup.lua")
end
