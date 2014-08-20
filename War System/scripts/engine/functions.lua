-- WarEngine. Функции движка.

function assert(condition, msg)
	if condition then
		error(msg, 3)
	end;
end

-- checks type of function arguments
function checktype(argTab, typeTab, funcName)
	assert(type(argTab) ~= "table", "bad argument #1 to 'checktype' (table expected, got "..type(argTab)..")")
	assert(type(typeTab) ~= "table", "bad argument #2 to 'checktype' (table expected, got "..type(typeTab)..")")
	assert(type(funcName) ~= "string", "bad argument #3 to 'checktype' (string expected, got "..type(funcName)..")")
	
	for argNum = 1, #typeTab do
		if type(argTab[argNum]) ~= typeTab[argNum] then
			if type(typeTab[argNum]) ~= "table" and type(argTab[argNum]) ~= "table" then
				local isExtraArg = string.sub(typeTab[argNum], string.len(typeTab[argNum])) == "+"; -- types with "+" end means that argument can be nil
				if typeTab[argNum] and not isExtraArg then
					error("bad argument #"..argNum.." to '"..funcName.."' ("..typeTab[argNum].." expected, got "..type(argTab[argNum])..")", 3)
				end;
			elseif type(typeTab[argNum]) == "table" and type(argTab[argNum]) == "table" then -- we can check also table variables in arguments
				for varNum = 1, #typeTab[argNum] do
					local isExtraArg = string.sub(typeTab[argNum][varNum], string.len(typeTab[argNum][varNum])) == "+";
					if type(argTab[argNum][varNum]) ~= typeTab[argNum][varNum] and typeTab[argNum][varNum] and not isExtraArg then
						error("bad variable #"..varNum.." in argument #"..argNum.." to '"..funcName.."' ("..typeTab[argNum][varNum].." expected, got "..type(argTab[argNum][varNum])..")", 3)
					end;
				end;
			end;
		end;
	end;
	
	return unpack(argTab);
end

-- returns array with files in given directory
function dirlist(...)
	local address, searchType = checktype({...}, {"string", "string+"}, "dirlist");

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
		table.insert(list, file)
	end;
	
	return list;
end
