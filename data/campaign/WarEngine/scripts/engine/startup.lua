-- WarEngine. Загрузочный файл.

reset()

local engineLoadingWasComplete = true;

dbg = {
	debugMode = true,
	canBePrinted = { -- if variable == true then labeled messages will printing
		main = true,
		engine = true,
		game = true,
		objects = true,
	},
}

function dbg.Print(text, textType)
	textType = textType or "main";
	if dbg.canBePrinted[textType] then print(text) end;
end

function dbg.Reload()

end

local function LoadEngineModule(fileName)
	local isLoaded, errorMsg = pcall(function() dofile("campaign/WarEngine/scripts/engine/"..fileName..".lua") end);
	if isLoaded then
		dbg.Print("| Engine module '"..fileName.."' is loaded.", "engine")
	else
		local _, msgStart = string.find(errorMsg, ".lua"); -- we just remove useless information of error message
		local _, fileNameStart = string.find(errorMsg, "/engine/"); -- if error was called by another engine file
		if string.sub(errorMsg, fileNameStart + 1, msgStart - 4) == fileName then 
			dbg.Print("| WARNING: Engine module '"..fileName.."' wasn't loaded:"..string.sub(errorMsg, msgStart + 2), "engine")
		else
			dbg.Print("| WARNING: Engine module '"..fileName.."' wasn't loaded: "..string.sub(errorMsg, fileNameStart + 1), "engine")	
		end;
		engineLoadingWasComplete = false;
	end;
end

local function LoadLib(fileName, path)
	local isLoaded, errorMsg = pcall(function() dofile(path..fileName..".lua") end)
	if isLoaded then
		dbg.Print("| Library '"..fileName.."' is loaded.", "engine")
	else
		local _, msgStart = string.find(errorMsg, ".lua"); -- we just remove useless information of error message
		dbg.Print("| WARNING: Library '"..fileName.."' wasn't loaded:"..string.sub(errorMsg, msgStart + 2), "engine")
	end;
end

local function LoadLibs(path)
	local libs = dirlist(path);
	for i = 1, #libs do
		if string.sub(libs[i], string.len(libs[i]) - 3) == ".lua" then -- loading only lua-files
			libs[i] = string.sub(libs[i], 1, string.len(libs[i]) - 4)
			LoadLib(libs[i], path)
		end;
	end;
end

dbg.Print("\n", "engine")
dbg.Print("==============================", "engine")
dbg.Print("== WarEngine initialization ==", "engine")
dbg.Print("==============================", "engine")
dbg.Print("\n", "engine")

-- setting of campaign directiory
if not user.campaignDirectory or type(user.campaignDirectory) ~= "string" then
	dbg.Print("| WARNING: Campaign direction not found. Please, set it to 'user.campaignDirectory' in startup-file of your campaign.", "engine")
	user.campaignDirectory = "campaign/WarEngine/";
end

-- clearing packages
if type(engine) == "table" and type(engine.packages) == "table" and engine.Unrequire then
	dbg.Print("| Clearing packages of last startup.", "engine")
	engine.Unrequire("all", "all")
end

-- loading engine modules
LoadEngineModule("functions")
LoadEngineModule("tables")
LoadEngineModule("engine")
LoadEngineModule("texts")
LoadEngineModule("levelpacks")
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
LoadLibs(const.elbPath)
LoadLibs(const.libPath)

-- clearing temp values
user.campaignDirectory = nil;