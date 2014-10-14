-- WarEngine. Функции движка.

-- checks truth of condition; if false prints error
function check(condition, msg)
	if not condition then
		error(msg, 3);
	end;
end;

-- checks type of function arguments
function checktype(argTab, typeTab, funcName)
	check(type(argTab) == "table", "bad argument #1 to 'checktype' (table expected, got "..type(argTab)..")");
	check(type(typeTab) == "table", "bad argument #2 to 'checktype' (table expected, got "..type(typeTab)..")");
	check(type(funcName) == "string", "bad argument #3 to 'checktype' (string expected, got "..type(funcName)..")");
	
	for argNum = 1, #argTab do
		if not typeTab[argNum] then -- fill nil ending of table, if it is
			typeTab[argNum] = typeTab[argNum - 1];
		end;
		local argTp = type(argTab[argNum]); -- type of argument
		local expTp = typeTab[argNum]; -- expected type
		local argTp2;
		local expTp2;
		local typesTab = {};
		local isError = true;
		local numberOfArguments = 1;
		if type(expTp) == "table" and argTp == "table" then numberOfArguments = #argTp; end;
		for varNum = 1, numberOfArguments do
			if type(expTp) == "table" and argTp == "table" then
				if not typeTab[argNum][varNum] then -- fill nil ending of table, if it is
					typeTab[argNum][varNum] = typeTab[argNum][varNum - 1];
				end;
				argTp2 = type(argTab[argNum][varNum]);
				expTp2 = typeTab[argNum][varNum];
			else
				argTp2 = argTp;
				expTp2 = expTp;				
			end;
--			local isExtraArg = string.sub(expTp2, string.len(expTp2)) == "+"; -- types with "+" ending mean that argument can be nil
--			if isExtraArg then expTp2 = string.sub(expTp2, 1, string.len(expTp2) - 1) end; -- we must delete this "+"
			table.insert(typesTab, string.sub(expTp2, 1, string.find(expTp2, "+"))); -- checking on some expected types
			if string.find(typesTab[1], "+") then typesTab[1] = string.sub(expTp2, 1, string.find(expTp2, "+") - 1); end
			for valType,_ in string.gmatch(expTp2, "+(%w+)") do
				table.insert(typesTab, valType);
			end;
			for _,valType in pairs(typesTab) do
				if argTp2 == valType then isError = false; end;
			end;
			if isError then -- message error
				break;
			end;
		end;
		if isError then
			if type(expTp) ~= "table" and argTp ~= "table" then
				if not isExtraArg or (argTp ~= "nil" and isExtraArg) then
					local expTp = string.gsub(expTp, "+", " or ");
					error("bad argument #"..argNum.." to '"..funcName.."' ("..expTp.." expected, got "..argTp..")", 3);
				end;
			elseif type(expTp) == "table" and argTp == "table" then -- we can check also table variables in arguments
				for varNum = 1, #argTp do
					if not isExtraArg or (argTp ~= "nil" and isExtraArg) then
						local expTp2 = string.gsub(expTp2, "+", " or ");
						error("bad variable #"..varNum.." in argument #"..argNum.." to '"..funcName.."' ("..expTp2.." expected, got "..argTp2..")", 3);
					end;
				end;
			end;
		end;
	end;
	
	return unpack(argTab);
end;

--[[ clean loaded packages table
function _CLEANPACKAGES()
	for key,_ in pairs(package.loaded) do 
		package.loaded[key] = nil;
	end;
end;]]

-- returns array with files in given directory
function dirlist(address, searchType)
	checktype({address, searchType}, {"string", "string+nil"}, "dirlist");
	address = string.gsub(address, "/", [[\]]); -- replaces standart lua slashes to cmd slashes
	searchType = searchType or "files";
	
	local list = {};
	local typeString;
-- sets arguments to cmd function accordinng to given type of searching
	if searchType == "files" then
		typeString = "/a-d";
	elseif searchType == "directories" then
		typeString = "/ad";
	else
		typeString = "";
	end;
-- loads cmd and fills our array of results
	for file in io.popen([[dir "data\]]..address..[[" /b ]]..typeString):lines() do 
		table.insert(list, file);
	end;
	
	return list;
end;

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
			msgStart = msgStart + 6; -- it's just a strings magic, even don't try to understand it
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
end;

function engine.Unrequire(module, group, removeFromGlobal)
	checktype({module, group, removeFromGlobal}, {"string", "string+nil", "boolean+nil"}, "engine.Unrequire");
	group = group or "ungroupped";
	check(engine.packages[group] or group == "all", "bad argument #2 to 'engine.Unrequire' (group '"..group.."' does't exist)");
	
	if group == "all" then
		for key,_ in pairs(engine.packages) do
			engine.Unrequire(module, key, removeFromGlobal);
			return true;
		end;
	end;
	
	for key,_ in pairs(engine.packages[group]) do
		if module == "all" then
			engine.Unrequire(key, group, removeFromGlobal);
			return true;
		else
			if key == module then
				package.loaded[module] = nil;
				engine.packages[group][module] = nil;
				if removeFromGlobal then _G[module] = nil; end;
				return true;
			end;
		end;
	end;

	-- if there is no such module in the group
	error("bad argument #2 to 'engine.Unrequire' (module '"..module.."' isn't loaded in group '"..group.."')", 2)
end;

-- Объединяет две таблицы в одну, которую и возвращает.
function func.UniteTables(tab1, tab2)
	checktype({tab1, tab2}, {"table", "table"}, "func.UniteTables");

	for key, value in pairs(tab2) do 
		tab1[key] = value;
	end;
	return tab1;
end

-- Читает диалог. Пока последняя версия. Slava98.
function func.Read(...)
	local args = {...};
	local outputTab = {};
	
	local function ReadText(args, i, dlg, speaker, num, patchTab)
		if type(args[i]) == "string" or type(args[i]) == "number" then return args[i]; end;
		
		local output = level.dialog[dlg][level.dialog.lang][speaker][num];
		local patchTab = func.DoTable(patchTab);
	-- Теперь нужно найти и заменить нужные области в строке патчами. Slava98. 04.01.14.
		output = string.gsub(output, "~(%w+)~", patchTab)
		return output;
	end;
	
	for i = 1, #args do
		local text;
		local dlg;
		local speaker;
		local num;
		local patchTab;
		
	-- Обработчик ошибок.
		if type(args[i]) == "table" then
			text = args[i]
			dlg = text[1];
			speaker = text[2];
			num = text[3];
			patchTab = text[4];
		
			if type(dlg) ~= "string" then error("bad variable #1 in argument #"..i.." to 'func.Read' (string expected, got "..type(dlg)..")", 2) return; end;
			if type(speaker) ~= "string" then error("bad variable #2 in argument #"..i.." to 'func.Read' (string expected, got "..type(speaker)..")", 2) return; end;
			if type(num) ~= "number" and type(num) ~= "string" then error("bad variable #3 in argument #"..i.." to 'func.Read' (number or string expected, got "..type(num)..")", 2) return; end;
			if type(patchTab) ~= "table" and patchTab ~= nil then error("bad variable #4 in argument #"..i.." to 'func.Read' (table expected, got "..type(patchTab)..")", 2) return; end;
			if type(level.dialog[dlg]) ~= "table" then error("bad variable #1 in argument #"..i.."  to 'func.Read' (dialog '"..dlg.."' isn't exist)", 2) end;
			if type(level.dialog[dlg][level.dialog.lang]) ~= "table" then error("bad arguments to 'func.Read' or problems with lang") end;
			if type(level.dialog[dlg][level.dialog.lang][speaker]) ~= "table" then error("bad variable #2 in argument #"..i.." to 'func.Read' (speaker '"..speaker.."' does not exist)", 2) end;
		--	Делаем возможность задавать номер рандомно. Slava98. 17.02.14.	
			if num == "random" then num = math.random(#level.dialog[dlg][level.dialog.lang][speaker]) end;
			if type(level.dialog[dlg][level.dialog.lang][speaker][num]) ~= "string" then error("bad variable #3 in argument #1 to 'func.Read' (num '"..num.."' does not exist)", 2) end;
		elseif type(args[i]) == "string" or type(args[i]) == "number" then 
		else error("bad argument #"..i.." to 'func.Read' (table or string or number expected, got "..type(args[i])..")", 2)
		end;
		outputTab[i] = ReadText(args, i, dlg, speaker, num, patchTab)
	end;
	
	return table.concat(outputTab);
end

-- Выводит сообщение. Slava98.
function func.Message(text, transmitToConsole)
-- Обработчик ошибок.
	if type(text) ~= "string" and type(text) ~= "table" then error("bad argument #1 to 'func.Message' (string or table expected, got "..type(text)..")", 2) return; end;
	if type(transmitToConsole) ~= "boolean" and transmitToConsole ~= nil then error("bad argument #2 to 'func.Message' (boolean expected, got "..type(transmitToConsole)..")", 2) return; end;
	
	if transmitToConsole == nil then transmitToConsole = true; end;
	
	if type(text) == "table" then
-- Обработчик ошибок.
		if type(text[1]) ~= "string" then error("bad variable #1 in argument #1 to 'func.Message' (string expected, got "..type(text[1])..")", 2) return; end;
		if type(text[2]) ~= "string" then error("bad variable #2 in argument #1 to 'func.Message' (string expected, got "..type(text[2])..")", 2) return; end;
		if type(text[3]) ~= "number" then error("bad variable #3 in argument #1 to 'func.Message' (number expected, got "..type(text[3])..")", 2) return; end;
		if type(text[4]) ~= "table" and text[4] ~= nil then error("bad variable #4 in argument #1 to 'func.Message' (table expected, got "..type(text[4])..")", 2) return; end;
		if type(level.dialog[text[1]]) ~= "table" then error("bad variable #1 in argument #1  to 'func.Message' (dialog '"..text[1].."' isn't exist)", 2) end;
		if type(level.dialog[text[1]][level.dialog.lang]) ~= "table" then error("bad arguments to 'func.Message' or problems with lang") end;
		if type(level.dialog[text[1]][level.dialog.lang][text[2]]) ~= "table" then error("bad variable #2 in argument #1 to 'func.Message' (speaker '"..text[2].."' does not exist)", 2) end;
		if type(level.dialog[text[1]][level.dialog.lang][text[2]][text[3]]) ~= "string" then error("bad variable #3 in argument #1 to 'func.Message' (num '"..text[3].."' does not exist)", 2) end;
		
		text = func.Read(text);
	end;
	
	message(text)
	
	if transmitToConsole then main.consoleText = main.consoleText.."\n"..text; end;
	return text;
end

-- Выводит окно с сообщением. Slava98.
function func.MsgBox(text, msgTab, boxType)
	if type(text) ~= "string" and type(text) ~= "table" then error("bad argument #1 to 'func.MsgBox' (string or table expected, got "..type(text)..")", 2) return; end;
	if type(msgTab) ~= "table" and msgTab ~= nil then error("bad argument #2 to 'func.MsgBox' (table expected, got "..type(msgTab)..")", 2) return; end;
	if type(boxType) ~= "string" and boxType ~= nil then error("bad argument #3 to 'func.MsgBox' (string expected, got "..type(boxType)..")", 2) return; end;

	msgTab = msgTab or {};
	msgTab.name = boxType or msgTab.name or "msbox";
	if #msgTab ~= 0 then
		msgTab.on_select = msgTab[1]; 
		msgTab.option1 = msgTab[2]; 
		msgTab.option2 = msgTab[3];
		msgTab.option3 = msgTab[4]; 
	end;
	
	if type(text) == "table" then
-- Обработчик ошибок.
		if type(text[1]) ~= "string" then error("bad variable #1 in argument #1 to 'func.MsgBox' (string expected, got "..type(text[1])..")", 2) return; end;
		if type(text[2]) ~= "string" then error("bad variable #2 in argument #1 to 'func.MsgBox' (string expected, got "..type(text[2])..")", 2) return; end;
		if type(text[3]) ~= "number" then error("bad variable #3 in argument #1 to 'func.MsgBox' (number expected, got "..type(text[3])..")", 2) return; end;
		if type(level.dialog[text[1]]) ~= "table" then error("bad variable #1 in argument #1  to 'func.MsgBox' (dialog '"..text[1].."' isn't exist)", 2) end;
		if type(level.dialog[text[1]][level.dialog.lang]) ~= "table" then error("bad arguments to 'func.MsgBox' or problems with lang") end;
		if type(level.dialog[text[1]][level.dialog.lang][text[2]]) ~= "table" then error("bad variable #2 in argument #1 to 'func.MsgBox' (speaker '"..text[2].."' does not exist)", 2) end;
		if type(level.dialog[text[1]][level.dialog.lang][text[2]][text[3]]) ~= "string" then error("bad variable #3 in argument #1 to 'func.MsgBox' (num '"..text[3].."' does not exist)", 2) end;

		text = func.Read(text);
	end;
	
	msgTab.text = text;
	for i = 1, #msgTab do msgTab[i] = nil; end;
	func.KillIfExists(msgTab.name)
	
--	pause(false)
--	pushcmd(function() pause(true); service("msgbox", msgTab); end, 0.01)
	service("msgbox", msgTab)
	
	return text;
end

-- Создаёт MsgBox, в котором можно выбрать множество вариантов ответа посредством надатия кнопок "Вверх", "Вниз" и "Выбрать".
function func.ListBox(text, sectionTab, chosedSectionNum, boxType, isButtonToSwitch, pointChar)
-- Обработчик ошибок (написать).

	local chosedSectionNum = chosedSectionNum or 1;
	local pointChar = pointChar or ">";
	local boxType = boxType or "listbox";
	local finalText = text;
	
	for i = 1, #sectionTab do
		sectionTab[i].sectionTitle = sectionTab[i].sectionTitle or "";
		sectionTab[i].singedChar = sectionTab[i].singedChar or "*";
		sectionTab[i].stringsOnPage = sectionTab[i].stringsOnPage or 10;
		sectionTab[i].chosedStringNum = sectionTab[i].chosedStringNum or 1;
		
		local sectionTitle = sectionTab[i].sectionTitle;
		local stringTab = sectionTab[i].stringTab;
		local funcTab = sectionTab[i].funcTab;
		local singedTab = sectionTab[i].signedTab;
		local singedChar = sectionTab[i].singedChar;
		local stringsOnPage = sectionTab[i].stringsOnPage;
		local chosedStringNum = sectionTab[i].chosedStringNum;
		local showNumeration = sectionTab[i].showNumeration;
		local currentPage = math.floor(chosedStringNum/(stringsOnPage + 1))+ 1;
		local listText = "";
		
		for num, str in pairs(stringTab) do
			if num > (currentPage - 1)*stringsOnPage and num <= currentPage*stringsOnPage then
				if num ~= chosedStringNum or i ~= chosedSectionNum then
					if not showNumeration then
						listText = listText.."\n  "..str;
					else
						listText = listText.."\n  "..num..")"..str;
					end;
				else
					if not showNumeration then
						listText = listText.."\n"..pointChar.." "..str;
					else
						listText = listText.."\n"..pointChar.." "..num..")"..str;
					end;
				end;
			end;
		end;
		
		if type(finalText) == "string" then
			finalText = " "..finalText..sectionTitle..listText;
		elseif type(finalText) == "table" then
			table.insert(finalText, "\n"..sectionTitle);
			table.insert(finalText, listText);
		end;
	end;
	
	main.objects[boxType] = {text, sectionTab, chosedSectionNum, boxType, isButtonToSwitch, pointChar,
		text = text, sectionTab = sectionTab, chosedSectionNum = chosedSectionNum, boxType = boxType, isButtonToSwitch = isButtonToSwitch, pointChar = pointChar}, -- Это совсем неправильно, но всё равно это когда-нибудь станет объектом. Slava98. 21.05.14.
	
	func.MsgBox(finalText, {on_select="local boxTab = main.objects['"..boxType.."']; local sectionTab = boxTab[2]; local num = boxTab[3]; if n == 1 then if #sectionTab[num].stringTab > sectionTab[num].chosedStringNum then sectionTab[num].chosedStringNum = sectionTab[num].chosedStringNum + 1; else sectionTab[num].chosedStringNum = 1; if #sectionTab > num then boxTab[3] = num + 1; sectionTab[boxTab[3]].chosedStringNum = 1; elseif #sectionTab == num then boxTab[3] = 1; sectionTab[boxTab[3]].chosedStringNum = 1; end; end; func.ListBox(unpack(boxTab)); elseif n == 2 then if 1 < sectionTab[num].chosedStringNum then sectionTab[num].chosedStringNum = sectionTab[num].chosedStringNum - 1; else sectionTab[num].chosedStringNum = #sectionTab[num].stringTab; if 1 < num then boxTab[3] = num - 1; sectionTab[boxTab[3]].chosedStringNum = #sectionTab[boxTab[3]].stringTab; elseif 1 == num then boxTab[3]=#sectionTab; sectionTab[boxTab[3]].chosedStringNum = #sectionTab[boxTab[3]].stringTab; end; end; func.ListBox(unpack(boxTab)); elseif n == 3 then if type(sectionTab[boxTab[3]].funcTab[sectionTab[num].chosedStringNum]) == 'string' then loadstring(sectionTab[boxTab[3]].funcTab[sectionTab[num].chosedStringNum])() elseif type(sectionTab[num].funcTab[sectionTab[num].chosedStringNum]) == 'function' then sectionTab[num].funcTab[sectionTab[num].chosedStringNum](sectionTab[num].chosedStringNum) end; end" , option1=func.Read({"main", "menu", 39}), option2=func.Read({"main", "menu", 38}), option3=func.Read({"main", "menu", 40})}, boxType)
	return chosedStringNum;
end