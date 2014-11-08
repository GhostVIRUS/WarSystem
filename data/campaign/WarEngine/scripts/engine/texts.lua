-- WarEngine. Тексты.

local function LoadFile(file, lang)
	if not string.find(file, ".txt") then return; end; -- loading only txt-files
	
	file = string.sub(file, 1, string.len(file) - 4) -- cut ending of file
	local textsList;
	local isLoaded, errorMsg = pcall(function() textsList = engine.Require(file) end);
	if engine.packages.ungroupped[file] then engine.Unrequire(file) end;
	
	if type(textsList) == "table" then -- only if file returns table, it fills textlist
		if type(texts.list[lang]) ~= "table" then texts.list[lang] = {}; end; -- if other files didn't load yet
		texts.list[lang] = func.UniteTables(texts.list[lang], textsList);
	elseif textsList == true then -- textsList == true only if file loaded without errors, but returns nothing
		dbg.Print("| WARNING: Text file '"..file.."' of language '"..lang.."' wasn't loaded: file must return a table with texts", "engine");
		return false;
	end;
	
	if isLoaded then
		dbg.Print("| Text file '"..file.."' is loaded.", "engine");
	else
		local _, msgStart = string.find(errorMsg, ".txt:"); -- we just remove useless information of error message
		if not msgStart then 
			dbg.Print("| WARNING: Text file '"..file.."' of language '"..lang.."' wasn't loaded: hmmm, it's strange", "engine"); 
			return false; 
		end;
		dbg.Print("| WARNING: Text file '"..file.."' of language '"..lang.."' wasn't loaded: "..string.sub(errorMsg, msgStart - 8), "engine");
		return false;
	end;
end;

local function LoadLang(lang)
	-- loading info-file of language
	package.path = "data/"..const.txtPath..lang.."/info.lua";
	
	local info;
	local loadingWasComplete = true;
	local isLoaded, errorMsg = pcall(function() info = engine.Require("info") end);
	if engine.packages.ungroupped["info"] then engine.Unrequire("info") end;
	
	if type(info) == "table" then
		language.list[lang] = {};
		language.list[lang].title = info[1];
	elseif info == true then -- info == true only if file loaded without errors, but returns nothing
		dbg.Print("| WARNING: Language '"..lang.."' wasn't loaded: file must return a table with texts.", "engine");
		return false;
	end;
	
	-- loading of all text-files
	package.path = "data/"..const.txtPath..lang.."/?.txt";
	local files = dirlist(const.txtPath..lang.."/");
	for _, file in pairs(files) do
		if LoadFile(file, lang) == false then
			loadingWasComplete = false;
		end;
	end;
	
	if isLoaded then
		if loadingWasComplete == false then
			dbg.Print("| WARNING: Language '"..lang.."' wasn't loaded completely.", "engine");
		else
			dbg.Print("| Language '"..lang.."' is loaded.", "engine");
		end
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
		return false;
	end;
end;

--[[function language.Set(lang)
	package.path = "data/"..const.txtPath..lang.."/?.txt";
	
	-- loading of all text-files
	local files = dirlist(const.txtPath..lang.."/");
	for _, file in pairs(files) do
		LoadFile(file);
	end;
end;]]

-- recreates msgboxes, menues, texts; changes nicks of vechiles
function texts.Refresh()
	
end;

local function ReadText(args, argNum, sectionsList, section, num, patchTab)
	local output = sectionsList[section][num];
	local patchTab = patchTab or {};
	-- Теперь нужно найти и заменить нужные области в строке патчами. Slava98. 04.01.14.
	output = string.gsub(output, "~(%w+)~", patchTab)
	-- А также пробелами. Slava98. 08.11.14.
	output = string.gsub (output, "#(%w+)#", 
		function(spaces) 
			spaces = tonumber(spaces);
			if type(spaces) == "number" then
				return string.rep(" ", spaces) 
			end; 
		end)

	return output;
end;

function texts.Read(section, num, patchTab)
	checktype({section, num, patchTab}, {"string", "number", "table+nil"}, "texts.Read")

	local output = "";
	check(type(optional) == "table", "you must set 'optional' table to use texts")
	check(type(optional.language) == "string", "you must set 'optional.language' string to use texts")
	local sectionsList = func.DoTable(texts.list[optional.language]);
	if num == "random" then num = math.random(#texts.langList[language.current][section]) end; -- Делаем возможность задавать номер рандомно. Slava98. 17.02.14.
	check(type(sectionsList) == "table", "bad arguments to 'texts.Read' or problems with lang");
	-- if current language haven't got this section or line, but it is in russian localization, we find it there
	if (type(sectionsList[section]) ~= "table" and type(texts.list["russ"]) == "table") or ((type(sectionsList[section]) ~= "table" and type(texts.list["russ"]) == "table") and (type(sectionsList[section][num]) ~= "string" and type(texts.list["russ"][section][num]) == "string")) then
		sectionsList = texts.list["russ"];
	end;
	check(type(sectionsList[section]) == "table", "bad argument #1  to 'texts.Read' (section '"..section.."' does not exist)");
	check(type(sectionsList[section][num]) == "string", "bad argument #2 to 'texts.Read' (text number "..num.." in section '"..section.."' does not exist)")
	output = ReadText(args, argNum, sectionsList, section, num, patchTab);
	
	return output;
end;

local langs = dirlist(const.txtPath, "directories");
for _, dir in pairs(langs) do
	LoadLang(dir);
end;
-- language.Set(defaults.language); -- TODO: later it must load from config.dat
