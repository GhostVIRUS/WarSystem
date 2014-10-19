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

function menu.Demo()
	func.MsgBox({"msg_notices", 20}, nil, "menubox")
end;

function menu.StableVersion()
	dbg.Print("")
	dbg.Print("| Loading stable version of War System.")
	dofile("campaign/War System/scripts/outdated/main/startup.lua")
end

---------------------------------------------------------------------------------------------------------------------
--========================================== Функции кнопок =======================================================--
---------------------------------------------------------------------------------------------------------------------

function menu.NewGame()
	menu.Demo()
end;

function menu.LoadGame()
	menu.Demo()
end;

function menu.Stages()
	menu.Demo()
end;

function menu.Levelpacks()
	menu.Demo()
end;

function menu.Mail()
	if not menu.letUseMain or not func.ExistsCharacter(const.playerName) then
		func.MsgBox({"msg_notices", 1}, nil, "menubox") -- Почта недоступна вне начатой игры.
		return false; 
	end;
	menu.Demo()
end;

function menu.Inventory()
	if not menu.letUseInventory or not func.ExistsCharacter(const.playerName) then
		if menu.section == "inventory_things" then menu.Show("main") return; end; -- for game unglucking after it's end
		func.MsgBox({"msg_notices", 2}, nil, "menubox") -- Инвентарь недоступен вне начатой игры.
		return false; 
	end;
	menu.Demo()
end;

function menu.Missions()
	menu.Demo()
end;

function menu.Devices()
	menu.Demo()
end;

function menu.Options() -- there will be controlled current language, levelpack, etc.
	menu.Demo()
end;

function menu.InvCheat()
	menu.Demo()
end;

function menu.ScrCheat()
	menu.Demo()
end;

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

function menu.Show(section)
	checktype({section}, {"string"}, "menu.Show");
	
--	local charTab = main.characters[const.playerName];
	if section == "main" then 
		menu.Set(section, {1, 2, 3, 4, 5}, {"menu.Show('game')", "menu.Show('gameopt_page'..menu.gameOptPage)", "menu.Show('help')", "menu.Options()", "menu.StableVersion()"}, "splash")
	elseif section == "game" then 
		menu.Set(section, {1, 2, 3, -3}, {"menu.NewGame()", "menu.LoadGame()", "menu.Stages()", "menu.Show('main')"}, "splash_game")
	elseif section == "gameopt_page1" then 
		menu.gameOptPage = 1,
		menu.Set(section, {1, 2, 3, -6, -3}, {"menu.Mail()", "menu.Inventory()", "menu.Missions()", "menu.Show('gameopt_page2')", "menu.Show('main')"}, "splash_gf")
	elseif section == "gameopt_page2" then 
		menu.gameOptPage = 2,
		menu.Set(section, {-7, 1, 2, 4, -3}, {"menu.Show('gameopt_page1')", "menu.Demo()", "menu.Devices()", "menu.Show('cheats')", "menu.Show('main')"}, "splash_gf")
	elseif section == "help" then 
		menu.Demo();
--		menu.Set(section, {1, 2, 3, 4, -3}, {"menu.Show('help_history')", "menu.Show('help_boosts')", "menu.Show('help_things')", "menu.About()", "menu.Show('main')"}, "splash_help")
	elseif section == "cheats" then 
		menu.Set(section, {1, 2, 3, texts.Read("menu_cheats", 4, {godMode=func.Condition(main.godMode, texts.Read("other", 14), texts.Read("other", 15))}), -3}, {"dbg.Reload()", "menu.InvCheat()", "menu.ScrCheat()", "main.godMode = not main.godMode; menu.Show('cheats')", "menu.Show('gameopt_page"..menu.gameOptPage.."')"}, "splash_game")
	end;
end;

---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

menu.Service = service("menu", {name="menu"});
menu.Show("main");
pushcmd(function() menu.Service.open = 1; end, 0.1)