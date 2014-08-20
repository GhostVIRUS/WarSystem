-- WarEngine. Функции движка.

-- returns array with files in given directory
function dirlist(address, searchType)
	address = address or "";
	address = string.gsub(address, "/", [[\]]); -- replaces standart lua slashes to cmd slashes
	searchType = searchType or "files";
	
	local list = {}
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
