-- WarEngine. Функции движка.

func = {};

-- checks truth of condition; if false prints error
function check(condition, msg)
	if not condition then
		error(msg, 3)
	end;
end

-- checks type of function arguments
function checktype(argTab, typeTab, funcName)
	check(type(argTab) == "table", "bad argument #1 to 'checktype' (table expected, got "..type(argTab)..")");
	check(type(typeTab) == "table", "bad argument #2 to 'checktype' (table expected, got "..type(typeTab)..")");
	check(type(funcName) == "string", "bad argument #3 to 'checktype' (string expected, got "..type(funcName)..")");
	
	for argNum = 1, #typeTab do
--[[	if not typeTab[argNum] then -- fill nil ending of table, if it is
			typeTab[argNum] = typeTab[argNum - 1];
		end;]]
		local argTp = type(argTab[argNum]); -- type of argument
		local expTp = typeTab[argNum]; -- expected type
		local argTp2;
		local expTp2;
		local typesTab = {};
		local isError = true;
		local numberOfArgs = 1;
		if type(expTp) == "table" and argTp == "table" then numberOfArgs = #argTp; end;
		for varNum = 1, numberOfArgs do
			if type(expTp) == "table" and argTp ~= "table" then
				expTp = "table";
			end;
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
			if type(argTp) ~= "table" --[[and expTp ~= "table"]] then
				if not isExtraArg or (argTp ~= "nil" and isExtraArg) then
					local expTp = string.gsub(expTp, "+", " or ");
					error("bad argument #"..argNum.." to '"..funcName.."' ("..expTp.." expected, got "..argTp..")", 3);
				end;
			elseif type(arpTp) == "table" and expTp == "table" then -- we can check also table variables in arguments
				local numberOfArgs = #argTp;
				if numberOfArgs <= 0 then
					numberOfArgs = #varTp;
				end;
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
end

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
end

function func.Condition(booVal, valIfTrue, valIfFalse)
	checktype({booVal}, {"boolean"}, "func.Condition");

	if booVal then 
		return valIfTrue; 
	else 
		return valIfFalse; 
	end;
end

-- Объединяет две таблицы в одну, которую и возвращает.
function func.UniteTables(tab1, tab2)
	checktype({tab1, tab2}, {"table", "table"}, "func.UniteTables");

	for key, value in pairs(tab2) do 
		tab1[key] = value;
	end;
	return tab1;
end

-- Если аргумент не является таблицей, то возвращает пустую таблицу.
function func.DoTable(tab)
	checktype({tab}, {"table+nil"}, "func.DoTable");

	if type(tab) ~= "table" then
		return {};
	else
		local newTab = {};
		for key, value in pairs(tab) do 
			newTab[key] = value;
		end;
		return newTab;
	end;
end

-- Функции преобразования одних координат ТЗОДа в другие. Основаны на функции Антикиллера. *Теперь позволяют обрабатывать неограниченное количество аргументов. Slava98. 30.12.13.
function func.GetPixel(...)
	local args = {...};
	for i = 1, #args do
		checktype({args[i]}, {"number"}, "func.GetPixel")
		args[i] = ((args[i] - 1)*32) + 16;
	end;
	
	return unpack(args);
end

function func.GetSquare(...)
	local args = {...};
	for i = 1, #args do
		checktype({args[i]}, {"number"}, "func.GetSquare")
		args[i] =  math.floor((math.floor(args[i]) - 16)/32 + 1);
	end;
	
	return unpack(args);
end
