-- WarEngine. Левелпаки.

local function Load(lpName)
	package.path = "data/"..const.lpkPath..lpName.."/?.lua";
	
	local isLoaded, errorMsg = pcall(function() levelpacks.list[lpName] = require("info") end);
	if isLoaded then
		dbg.Print("| Levelpack '"..lpName.."' is loaded.", "engine")
	else
		local _, msgStart = string.find(errorMsg, "info.lua:"); -- we just remove useless information of error message
		if string.find(errorMsg, "module 'info' not found") then -- if mapper forgot about 'info.lua'
			msgStart = 8;
			errorMsg = "can't find 'info.lua' in levelpack folder";
		end;
		dbg.Print("| WARNING: Levelpack '"..lpName.."' wasn't loaded: "..string.sub(errorMsg, msgStart - 8), "engine")
	end;
end

local lps = dirlist(const.lpkPath, "directories");

for _, dir in pairs(lps) do
	Load(dir)
end
