-- WarEngine. Тексты.

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
	local lang = language.current;
	local isLoaded, errorMsg = pcall(function() textsList = engine.Require(file) end);
	if engine.packages.ungroupped[file] then engine.Unrequire(file) end;
	
	if type(textsList) == "table" then -- only if file returns table, it fills textlist
		if type(texts.list[lang]) ~= "table" then texts.list[lang] = {}; end; -- if other files didn't load yet
		texts.list[lang] = func.UniteTables(texts.list[lang], textsList);
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

local function ReadText(args, argNum, text, num, patchTab)
	local output = texts.list[language.current][text][num];
	local patchTab = func.DoTable(patchTab);
	-- Теперь нужно найти и заменить нужные области в строке патчами. Slava98. 04.01.14.
	output = string.gsub(output, "~(%w+)~", patchTab)
	return output;
end;

function texts.Read(text, num, patchTab)
	checktype(text, num, patchTab, {"string", "number", "table+nil"}, "texts.Read")
	local outputTab = {};
	
	for argNum = 1, #args do
		local text = args[argNum][1];
		local num = args[argNum][2];
		local patchTab = args[argNum][3];
		check(type(texts.list[language.current]) == "table", "bad arguments to 'texts.Read' or problems with lang");
		check(type(texts.list[language.current][text]) == "table", "bad variable #1 in argument #"..argNum.."  to 'texts.Read' (text '"..text.."' does not exist)");
		if num == "random" then num = math.random(#texts.langList[language.current][text]) end; -- Делаем возможность задавать номер рандомно. Slava98. 17.02.14.
		check(type(texts.list[language.current][text][num]) == "string", "bad variable #3 in argument #"..argNum.." to 'texts.Read' (number '"..num.."' in text '"..text.."' does not exist)")
		outputTab[argNum] = ReadText(args, argNum, text, num, patchTab);
	end;
	
	return table.concat(outputTab);
end;

local langs = dirlist(const.txtPath, "directories");
for _, dir in pairs(langs) do
	LoadLang(dir);
end;
language.Set(defaults.language); -- TODO: later it must load from config.dat
