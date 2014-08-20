-- WarEngine. Левелпаки.

local function Load(lpName)
	package.path = "data/"..const.lpkPath..lpName.."/?.lua";
	
	local isError, errorMsg = pcall(function() levelpacks.list[lpName] = require("info") end);
	if isError then
		dbg.Print("| Levelpack '"..lpName.."' is loaded.", "engine")
	else
		local _, msgStart = string.find(errorMsg, ".lua") -- we just remove useless information of error message
		dbg.Print("| WARNING: Levelpack '"..lpName.."' wasn't loaded: info.lua:"..string.sub(errorMsg, msgStart + 2), "engine")
	end;
end

local lps = dirlist(const.lpkPath, "directories");

for _, dir in pairs(lps) do
	Load(dir)
end
