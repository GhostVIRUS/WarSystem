-- WarEngine. ������.

local function LoadLang(lang)
	-- loading info-file of language
	package.path = "data/"..const.txtPath..lang.."/info.lua";
	
	local info;
	local isLoaded, errorMsg = pcall(function() info = engine.Require("info") end);
	if engine.packages.ungroupped["info"] then engine.Unrequire("info") end;
	
	if type(info) == "table" then
		language.list[lang] = info;
	elseif info == true then -- info == true only if file loaded without errors, but returns nothing
		dbg.Print("| WARNING: Language '"..lang.."' wasn't loaded: file must return a table with texts", "engine");
		return;
	end;
	
	if isLoaded then
		dbg.Print("| Language '"..lang.."' is loaded.", "engine");
	else
		local _, msgStart = string.find(errorMsg, "info.lua:"); -- we just remove useless information of error message
		if not msgStart then -- it's a engine bug
			_, msgStart = string.find(errorMsg, "/engine/");
			msgStart = msgStart + 2;
		end;
		if string.find(errorMsg, "module 'info' not found") then -- if mapper forgot about 'info.lua'
			msgStart = 8;
			errorMsg = "can't find 'info.lua' in language folder";
		end;
		dbg.Print("| WARNING: Language '"..lang.."' wasn't loaded: "..string.sub(errorMsg, msgStart - 8), "engine");
	end;
end;

local function LoadFile(file)
	if not string.find(file, ".txt") then return; end; -- loading only txt-files
	
	file = string.sub(file, 1, string.len(file) - 4) -- cut ending of file
	local textsList;
	local isLoaded, errorMsg = pcall(function() textsList = engine.Require(file) end);
	if engine.packages.ungroupped[file] then engine.Unrequire(file) end;
	
	if type(textsList) == "table" then -- only if file returns table, it fills textlist
		texts.list[lang] = func.UniteTables(texts.list[lang], textsList[lang]);
	elseif textsList == true then -- textsList == true only if file loaded without errors, but returns nothing
		dbg.Print("| WARNING: Text file '"..file.."' wasn't loaded: file must return a table with texts", "engine");
		return;
	end;
	
	if isLoaded then
		dbg.Print("| Text file '"..file.."' is loaded.", "engine");
	else
		local _, msgStart = string.find(errorMsg, ".txt:"); -- we just remove useless information of error message
		if not msgStart then 
			dbg.Print("| WARNING: Text file '"..file.."' wasn't loaded: hmmm, it's strange", "engine"); 
			return; 
		end;
		dbg.Print("| WARNING: Text file '"..file.."' wasn't loaded: "..string.sub(errorMsg, msgStart - 8), "engine");
	end;
end;

function language.Set(lang)
	package.path = "data/"..const.txtPath..lang.."/?.txt";
	
	-- loading of all text-files
	local files = dirlist(const.txtPath..lang.."/");
	for _, file in pairs(files) do
		LoadFile(file);
	end;
end;

function texts.Refresh()

end;

function texts.Read()

end;

local langs = dirlist(const.txtPath, "directories");
for _, dir in pairs(langs) do
	LoadLang(dir)
end
language.Set(defaults.language) -- TODO: later it must load from config.dat