-- War System. Меню.

---------------------------------------------------------------------------------------------------------------------
--========================================== Рабочие функции ======================================================--
---------------------------------------------------------------------------------------------------------------------

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

local function ChangeLevelpack()
	
end

local function ChangeLanguage()
	
end

function menu.Options() -- there will be controlled current language, levelpack, etc.
	if menu.listbox:exists() then menu.listbox:setVisibility(false) end;
	menu.listbox._text = texts.Read("msg_options", 1);
	menu.listbox._sectionTab = {{
		stringTab = {
			texts.Read("msg_options", 2, {language = language.list[language.current].name}),
			texts.Read("msg_options", 3, {levelpack = levelpacks.list[levelpacks.current].name}),
			texts.Read("msg_options", 4, {promt = func.Condition(gameplay.showPromt, texts.Read("other", 14), texts.Read("other", 15))}),
			texts.Read("other", 4),
		},
		funcTab = {
			ChangeLevelpack,
			ChangeLanguage,
			function() 
				gameplay.showPromt = not gameplay.showPromt;
				menu.optionsChosedString = menu.listbox._sectionTab[1].chosedStringNum; 
				menu.Options() 
			end,
			function() 
				menu.listbox:setVisibility(false) 
				menu.optionsChosedString = menu.listbox._sectionTab[1].chosedStringNum;
			end,
		},
		chosedStringNum = menu.optionsChosedString,
	}};
	menu.listbox:setVisibility(true)
	menu.listbox:refresh()
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
		menu.Set(section, {1, 2, 3, texts.Read("menu_cheats", 4, {godMode=func.Condition(gameplay.godMode, texts.Read("other", 14), texts.Read("other", 15))}), -3}, {"dbg.Reload()", "menu.InvCheat()", "menu.ScrCheat()", "gameplay.godMode = not gameplay.godMode; menu.Show('cheats')", "menu.Show('gameopt_page"..menu.gameOptPage.."')"}, "splash_game")
	end;
end;

---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

engine.Require("listbox", "classes")
menu.listbox = ListBox("menu_listbox");
menu.msgbox = MsgBox("menu_msgbox");

menu.service:setVisibility(true)
menu.Show("main");
pushcmd(function() menu.service.link.open = 1; end, 0.1)