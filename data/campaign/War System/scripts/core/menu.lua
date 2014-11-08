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

local function ShowLevelpackInfo(lpack)
	if menu.msgbox:exists() then menu.msgbox:setVisibility(false) end;
	menu.msgbox:setProperties({
		text = texts.Read("msg_options", 21, {
			title = levelpacks.list[lpack].title or lpack,
			description = levelpacks.list[lpack].descriiption or texts.Read("msg_options", 22),
			type = texts.Read("msg_options", 31), -- temply
			levelsNum = 0, -- temply
		}),
		on_select = "if n == 1 then menu.ChangeLevelpack() else levelpacks.current = '"..lpack.."'; menu.Options(); end;",
		option1 = texts.Read("other", 3),
		option2 = texts.Read("other", 10),
	})
	
	menu.msgbox:setVisibility(true)
	menu.msgbox:refresh()
end

local function GetLevelpacksTitleList()
	local titleList = {};
	
	for _,lpackTab in pairs(levelpacks.list) do
		table.insert(titleList, lpackTab.title)
	end;
	
	return titleList;
end

local function GetLevelpacksFuncList()
	local funcList = {};
	
	for lpack,_ in pairs(levelpacks.list) do
		table.insert(funcList, function()
			ShowLevelpackInfo(lpack)
		end)
	end;
	
	return funcList;	
end

function menu.ChangeLevelpack()
	if menu.listbox:exists() then menu.listbox:setVisibility(false) end;
	menu.listbox._text = texts.Read("msg_options", 20);
	menu.listbox._sectionTab = {{
			stringTab = GetLevelpacksTitleList(),
			funcTab = GetLevelpacksFuncList(),
		},
		{
			stringTab = {
				texts.Read("other", 3),
			},
			funcTab = {
				menu.Options,
			},		
		},
	};
	
	menu.listbox._chosedSectionNum = 1;
	menu.listbox:setVisibility(true)
	menu.listbox:refresh()
end

local function GetLanguagesTitleList()
	local titleList = {};
	
	for _,langTab in pairs(language.list) do
		table.insert(titleList, langTab.title)
	end;
	
	return titleList;
end

local function GetLanguagesFuncList()
	local funcList = {};
	
	for lang,_ in pairs(language.list) do
		table.insert(funcList, function()
			language.current = lang;
			-- if don't found main.lua then error
--			texts.Refresh() -- recreates msgboxes, menues, texts; changes nicks of vechiles
			menu.Options()
		end)
	end;
	
	return funcList;	
end

function menu.ChangeLanguage()
	if menu.listbox:exists() then menu.listbox:setVisibility(false) end;
	menu.listbox._text = texts.Read("msg_options", 10);
	menu.listbox._sectionTab = {{
		stringTab = GetLanguagesTitleList(),
		funcTab = GetLanguagesFuncList(),
	}};
	
	menu.listbox._chosedSectionNum = 1;
	menu.listbox:setVisibility(true)
	menu.listbox:refresh()
end

function menu.Options() -- there is controlled current language, levelpack, etc.
	if menu.listbox:exists() then menu.listbox:setVisibility(false) end;
	menu.listbox._text = texts.Read("msg_options", 1);
	menu.listbox._sectionTab = {{
		stringTab = {
			texts.Read("msg_options", 2, {language = language.list[language.current].title}),
			texts.Read("msg_options", 3, {levelpack = levelpacks.list[levelpacks.current].title}),
			texts.Read("msg_options", 4, {promt = func.Condition(gameplay.showPromt, texts.Read("other", 14), texts.Read("other", 15))}),
			texts.Read("other", 4),
		},
		funcTab = {
			menu.ChangeLanguage,
			menu.ChangeLevelpack,
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
	
	menu.listbox._chosedSectionNum = 1;
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