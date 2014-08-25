-- WarEngine. ������� ������.

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
	
	for argNum = 1, #typeTab do
		local argTp = type(argTab[argNum]); -- type of argument
		local expTp = typeTab[argNum]; -- expected type
		local isExtraArg = string.sub(expTp, string.len(expTp)) == "+"; -- types with "+" ending mean that argument can be nil
		if isExtraArg then expTp = string.sub(expTp, 1, string.len(expTp) - 1) end; -- we must delete this "+"
		if argTp ~= expTp then
			if type(expTp) ~= "table" and type(argTp) ~= "table" then
				if not isExtraArg or (argTp ~= "nil" and isExtraArg) then
					error("bad argument #"..argNum.." to '"..funcName.."' ("..expTp.." expected, got "..argTp..")", 3);
				end;
			elseif type(expTp) == "table" and type(argTp) == "table" then -- we can check also table variables in arguments
				for varNum = 1, #expTp do
					local argTp = type(argTab[argNum][varNum]);
					local expTp = type(expTab[argNum][varNum]);
					local isExtraArg = string.sub(expTp, string.len(expTp)) == "+";
					if isExtraArg then expTp = string.sub(expTp, 1, string.len(expTp) - 1) end;
					if argTp ~= expTp and (not isExtraArg or (argTp ~= "nil" and isExtraArg)) then
						error("bad variable #"..varNum.." in argument #"..argNum.." to '"..funcName.."' ("..expTp.." expected, got "..argTp..")", 3);
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
	checktype({address, searchType}, {"string", "string+"}, "dirlist");
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
	checktype({module, group}, {"string", "string+"}, "engine.Require");
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
	checktype({module, group, removeFromGlobal}, {"string", "string+", "boolean+"}, "engine.Unrequire");
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

-- ���������� ��� ������� � ����, ������� � ����������.
function func.UniteTables(tab1, tab2)
	checktype({tab1, tab2}, {"table", "table"}, "func.UniteTables");

	for key, value in pairs(tab2) do 
		tab1[key] = value;
	end;
	return tab1;
end