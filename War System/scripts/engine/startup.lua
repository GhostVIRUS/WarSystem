-- WarEngine. Загрузочный файл.

reset()

local engineLoadingWasComplete = true;

dbg = {
	debugMode = true,
	canBePrinted = { -- if variable == true then labeled messages will printing
		main = true,
		engine = true,
		game = true,
	},
}

function dbg.Print(text, textType)
	textType = textType or "main";
	if dbg.canBePrinted[textType] then print(text) end;
end

local function LoadEngineModule(fileName)
	local isLoaded, errorMsg = pcall(function() dofile("campaign/War System/scripts/engine/"..fileName..".lua") end);
	if isLoaded then
		dbg.Print("| Engine module '"..fileName.."' is loaded.", "engine")
	else
		local _, msgStart = string.find(errorMsg, ".lua"); -- we just remove useless information of error message
		dbg.Print("| WARNING: Engine module '"..fileName.."' wasn't loaded:"..string.sub(errorMsg, msgStart + 2), "engine")
		engineLoadingWasComplete = false;
	end;
end

local function LoadLib(fileName)
	local isLoaded, errorMsg = pcall(function() dofile("campaign/War System/scripts/libs/"..fileName..".lua") end)
	if isLoaded then
		dbg.Print("| Library '"..fileName.."' is loaded.", "engine")
	else
		local _, msgStart = string.find(errorMsg, ".lua"); -- we just remove useless information of error message
		dbg.Print("| WARNING: Library '"..fileName.."' wasn't loaded:"..string.sub(errorMsg, msgStart + 2), "engine")
	end;
end

dbg.Print("\n", "engine")
dbg.Print("==============================", "engine")
dbg.Print("== WarEngine initialization ==", "engine")
dbg.Print("==============================", "engine")
dbg.Print("\n", "engine")

LoadEngineModule("tables")
LoadEngineModule("functions")
LoadEngineModule("texts")
LoadEngineModule("levelpacks")
LoadEngineModule("stages")
LoadEngineModule("objects")
LoadEngineModule("menu")
LoadEngineModule("multiplayer")
LoadEngineModule("autocomplete")

-- inform console reader about engine loading
if engineLoadingWasComplete then
	dbg.Print("| Engine is completely loaded.", "engine")
else
	dbg.Print("| WARNING: Engine wasn't completely loaded. Maybe there will be problems with it's working.", "engine")
end

-- loading libs
local libs = dirlist(const.libPath);
for i = 1, #libs do
	if string.sub(libs[i], string.len(libs[i]) - 3) == ".lua" then -- loading only lua-files
		libs[i] = string.sub(libs[i], 1, string.len(libs[i]) - 4)
		LoadLib(libs[i])
	end;
end;

pushcmd(function()
	dbg.Print("")
	dbg.Print("| Loading stable version of War System.")
	dofile("campaign/War System/scripts/outdated/main/startup.lua")
end, 3)