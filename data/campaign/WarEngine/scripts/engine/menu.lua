-- WarEngine. Меню.

---------------------------------------------------------------------------------------------------------------------
--========================================== Рабочие функции ======================================================--
---------------------------------------------------------------------------------------------------------------------

function menu.Refresh() -- Local?
    if exists(menu.Service.name) == true then
		menu.Service.names = menu.Service.names;
        menu.Service.open = 1;
        menu.Service.open = 1;
    end;
end

---------------------------------------------------------------------------------------------------------------------
--======================================= Переключение разделов ===================================================--
---------------------------------------------------------------------------------------------------------------------

function menu.Set(section, namesTab, funcTab, title)
	checktype({section, namesTab, funcTab, title}, {"string", {"number+string+table"}, {"string"}, "string+nil"}, "menu.Show");

	local title = title or "splash";
	local names = "";
	local onSelect = "";

	for nameNum = 1, #namesTab do
		if type(namesTab[nameNum]) == "string" then
			names = names..namesTab[nameNum];
		elseif type(namesTab[nameNum]) == "number" then
			if namesTab[nameNum] < 0 then -- for global buttons
				names = names..texts.Read("other", -namesTab[nameNum]);
			else
				names = names..texts.Read("menu_"..section, namesTab[nameNum]);
			end;
		elseif type(namesTab[nameNum]) == "table" then
			names = names..texts.Read("menu_"..section, namesTab[nameNum][1], namesTab[nameNum][2]);
		end;
		if nameNum ~= #namesTab then 
			names = names.."|";
		end;
	end;
	
	for funcNum = 1, #funcTab do
		if funcTab[funcNum] ~= "" then
			if funcNum == 1 then onSelect = "if n == "..funcNum.." then "..funcTab[funcNum].."; ";
			else onSelect = onSelect.."elseif n == "..funcNum.." then "..funcTab[funcNum].."; ";
			end;
		end;
		if funcNum == #funcTab then 
			onSelect = onSelect.."end;"; 
		end;
	end;

	menu.Service.title = title;
	menu.Service.names = names;
	menu.Service.on_select = onSelect;
	menu.section = section; -- 'Menu.section' in the future
	menu.Refresh();
end;