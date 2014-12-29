-- WarEngine. Левелпаки.

local function Load(lpName)
--	package.path = "data/"..const.lpkPath..lpName.."/?.lua";
	
	local isLoaded, errorMsg = pcall(function() info = dofile(const.lpkPath..lpName.."/info.lua") end);
--[[local isLoaded, errorMsg = pcall(function() info = engine.Require("info") end);
	if engine.packages.ungroupped["info"] then engine.Unrequire("info") end;]]
	
	if type(info) == "table" then
		levelpacks.list[lpName] = info;
	elseif not info and not errorMsg then -- if file loaded without errors, but returns nothing
		dbg.Print("| WARNING: Levelpack '"..lpName.."' wasn't loaded: file must return a table with texts", "engine");
		return;
	end;	
	
	if isLoaded then
		dbg.Print("| Levelpack '"..lpName.."' is loaded.", "engine")
	else
		dbg.Print("| WARNING: Levelpack '"..lpName.."' wasn't loaded: "..errorMsg, "engine")
	end;
end

local lps = dirlist(const.lpkPath, "directories");
for _, dir in pairs(lps) do
	Load(dir)
end
