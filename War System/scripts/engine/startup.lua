-- WarEngine. Загрузочный файл.

reset()

local engineLoadingWasComplete = true;

dbg = {
	debugMode = true,
	canBePrinted = {
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
	local isError, errorMsg = pcall(function() dofile("campaign/War System/scripts/engine/"..fileName..".lua") end);
	if isError then
		dbg.Print("| Engine module '"..fileName.."' is loaded.", "engine")
	else
		local _, msgStart = string.find(errorMsg, ".lua")
		dbg.Print("| WARNING: Engine module '"..fileName.."' wasn't loaded:"..string.sub(errorMsg, msgStart + 2), "engine")
		engineLoadingWasComplete = false;
	end;
end;

local function LoadLib(fileName)
	local isError, errorMsg = pcall(function() dofile("campaign/War System/scripts/libs/"..fileName..".lua") end)
	if isError then
		dbg.Print("| Library '"..fileName.."' is loaded.", "engine")
	else
		local _, msgStart = string.find(errorMsg, ".lua")
		dbg.Print("| WARNING: Library '"..fileName.."' wasn't loaded:"..string.sub(errorMsg, msgStart + 2), "engine")
	end;
end;

dbg.Print("\n", "engine")
dbg.Print("==============================", "engine")
dbg.Print("== WarEngine initialization ==", "engine")
dbg.Print("==============================", "engine")
dbg.Print("\n", "engine")

LoadEngineModule("tables")
LoadEngineModule("functions")
LoadEngineModule("objects")
LoadEngineModule("texts")
LoadEngineModule("levelpacks")
LoadEngineModule("menu")
LoadEngineModule("stages")
LoadEngineModule("multiplayer")
LoadEngineModule("autocomplete")

if engineLoadingWasComplete then
	dbg.Print("| Engine is completely loaded.", "engine")
else
	dbg.Print("| WARNING: Engine wasn't completely loaded. Maybe there will be problems with it's working.", "engine")
end;
dbg.Print("\n", "engine")

LoadLib("")