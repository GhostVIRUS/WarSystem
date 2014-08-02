-- Меню кампании War System.
-- By VIRUS.

------------------------------------------------------------------------------------------
------------------------------------ОСНОВНОЕ----------------------------------------------
------------------------------------------------------------------------------------------

-- Внизу расположены устаревшие функции. Они больше в ВС не используются.

function main.menu.Main(n) -- Думаю, надо бы объединить с main.menu.BackStart. Slava98. 13.09.13.
    if n == 1 then main.menu.Game() 
    elseif n == 2 then main.menu.GameOpt()
    elseif n == 3 then main.menu.Help()
    end;
end

function main.menu.Game(n)
	main.menu.SetNames({4, 5, 6, 7, 29}) --Новая игра|Загрузить|Режимы|Левелпаки|Назад	
	main.menuservice.on_select = "main.menu.Game(n)";
    main.menuservice.title = "splash_game";
    main.menu.section = "game";
    main.menu.Refresh()
    if n == nil then return end
        if n == 1 then main.menu.NewGame() 
        elseif n == 2 then main.menu.Demo()
        elseif n == 3 then main.menu.Demo()
		elseif n == 4 then main.menu.LevelPacks()
        else main.menu.BackStart()
    end;
end

function main.menu.Stages(n)
    main.menu.SetNames({18, 19, 7, 29}) --"ДМ|Миссии|Левелпаки|Назад"
    main.menuservice.on_select = "main.menu.Stages(n)";
    main.menuservice.title = "splash_game";
    main.menu.section = "game";
    main.menu.Refresh()
    if n == nil then return end
        if n == 1 then main.menu.DM() 
        elseif n == 2 then main.menu.StageMissions()
        elseif n == 3 then main.menu.LevelPacks()
        else main.menu.BackStart()
    end
end

function main.menu.BackStart()
	main.menuservice.names = "Игра|Игровые функции|Помощь"
	main.menuservice.on_select = "main.menu.Main(n)";
	main.menuservice.title = "splash";
	main.menu.section = "menu";
	main.menu.Refresh()
end

function main.menu.NewGame()
	local lp = main.levelpack.default;
	dofile("campaign/War System.lua")
	main.levelpack.Run(lp)
	pushcmd(function() main.menu.OpenCloseMenu() end, 0.2)
end

function main.menu.GameOpt(n)
    main.menu.SetNames({8, 9, 10, 11, 29}) -- Почта|Инвентарь|Задания|Читы|Назад
    main.menuservice.on_select = "main.menu.GameOpt(n)";
    main.menuservice.title = "splash_gf";
    main.menu.section = "gameopt";
    main.menu.Refresh()
    if n == nil then return end
        if n == 1 then main.menu.MailBox()
        elseif n == 2 then main.menu.Inventory()
        elseif n == 3 then main.menu.Missions()
		elseif n == 4 then main.menu.Cheats()
        else main.menu.BackStart()
    end
end

function main.menu.Cheats(n)
    main.menu.SetNames({20, 14, 21, 22, 29}) -- Перезапуск|Предметы|Сюжетные|Godmode|Назад
    main.menuservice.on_select = "main.menu.Cheats(n)";
    main.menuservice.title = "splash_gf";
    main.menu.section = "cheats";
    main.menu.Refresh()
    if n == nil then return end
        if n == 1 then main.menu.ReloadScripts()
        elseif n == 2 then main.menu.CheatsItems()
        elseif n == 3 then main.menu.CheatsScreenplay()
		elseif n == 4 then main.menu.Godmode()
        else main.menu.BackStart()
    end
end

function main.menu.CheatsItems(n)
	if exists("cheatbox") then kill("cheatbox") end
	main.cheats.ibotreduce = main.cheats.ibotreduce or 1
	if n~=nil then
        if n==1 then main.cheats.ibotreduce=main.cheats.ibotreduce-1
		elseif n==2 then main.cheats.ibotreduce=main.cheats.ibotreduce+1
        end
    end
	if main.cheats.ibotreduce <= 0 then main.cheats.ibotreduce = main.cheats.ibotreduce + 1
	elseif main.cheats.ibotreduce >= table.maxn(main.inventory.items) + 1 then main.cheats.ibotreduce = main.cheats.ibotreduce - 1
	else 
		local item = main.inventory.items[main.cheats.ibotreduce];
	end
		service("msgbox", {
                	name="cheatbox", 
                	text=item,
                	on_select="if n ~= 3 then main.menu.CheatsItems(n) else main.levelpack.default = main.levelpacks[main.levelpack.botreduce]; end",
                	option1="Назад",
                	option2="Вперёд",
                	option3="Выбрать" } )
end

function main.menu.Help(n)
    main.menu.SetNames({12, 13, 14, 15, 29})-- Описание|Бонусы|Предметы|О кампании|Назад
    main.menuservice.on_select = "main.menu.Help(n)";
    main.menuservice.title = "splash_help";
    main.menu.section = "help";
    main.menu.Refresh()
    if n == nil then return end
        if n == 1 then main.menu.History() 
        elseif n == 2 then main.menu.Boosts()
        elseif n == 3 then main.menu.Things()
        elseif n == 4 then main.menu.About()
        else main.menu.BackStart()
    end
end

------------------------------------------------------------------------------------------
------------------------------------ПОМОЩЬ------------------------------------------------
------------------------------------------------------------------------------------------

function main.menu.History(n)
	main.menuservice.names="Люди|Экиваторы|Дассоваторы|Лораторы|Назад"
	main.menuservice.on_select="main.menu.History(n)"
	main.menuservice.title="splash_history"
	main.menu.Refresh()
	if n == nil then return end
		main.menu.Refresh()
	if n == 1 then main.menuservice.title="splash_people"
		main.menu.Refresh()
	elseif n == 2 then main.menuservice.title="splash_ekivator"
		main.menu.Refresh()
	elseif n == 3 then main.menuservice.title="splash_dassovator"
		main.menu.Refresh()
	elseif n == 4 then main.menuservice.title="splash_lorator"
		main.menu.Refresh()
	else main.menuservice.names="Описание|Бонусы|Предметы|О кампании|Назад"
		main.menuservice.on_select="main.menu.Help(n)"
		main.menuservice.title="splash_help"
		main.menu.Refresh()
	end;
end

function main.menu.Boosts(n)
    main.menuservice.names="ПЭРК|Усилитель|Lam|Броня|Назад"
    main.menuservice.on_select="main.menu.Boosts(n)"
    main.menuservice.title="splash_boosts"
    main.menu.Refresh()
    if n == nil then return end
        main.menu.Refresh()
        if n == 1 then 
                        main.menuservice.title="splash_perk"
            main.menu.Refresh()
        elseif n == 2 then 
                        main.menuservice.title="splash_ey"
            main.menu.Refresh()
        elseif n == 3 then 
                        main.menuservice.title="splash_lam"
            main.menu.Refresh()
                elseif n == 4 then 
                        main.menuservice.title="splash_armor"
                        main.menu.Refresh()
        else 
                        main.menu.BackHelp()
    end
--service("msgbox", {text=" ПЭРК - Портативный Электронный Регенерирующий Комплекс, \nсовременный механизм, практически моментально полностью чинит любую технику, \nпосле использования полностью разряжается и выходит их строя. \n Энергетический усилитель - улучшает любой тип оружия, \nделая его смертоносным для любого вида брони. \nСтарая разработка работает 20 секунд и выходит из строя после использования. \nВ секретных лабораториях ведутся разработки по улучшению усилителя. \n LAM - лёгкая портативная взрывчатка, имеет малый размер и вес. \nПлазмо-энергетический поток способен взрывать твёрдые и прочные предметы. \nЕсть возмоность разминирования."})
end


function main.menu.Things(n)
    main.menuservice.names="Батарея|Ключ-карта|Назад"
    main.menuservice.on_select="main.menu.Things(n)"
    main.menuservice.title="splash_things"
    main.menu.Refresh()
    if n == nil then return end
    main.menu.Refresh()
    if n == 1 then 
                main.menuservice.title="splash_booster"
        main.menu.Refresh()
--elseif n == 2 then user.menuservice.title="splashekivator"
--user.Refresh()
    else 
                main.menu.BackHelp()
    end
end

function main.menu.BackHelp()
        main.menuservice.names="Описание|Бонусы|Предметы|О кампании|Назад"
        main.menuservice.on_select="main.menu.Help(n)"
        main.menuservice.title="splash_help"
		main.menu.section="help"
        main.menu.Refresh()
end

------------------------------------------------------------------------------------------
---------------------------------------ИНВЕНТАРЬ------------------------------------------
------------------------------------------------------------------------------------------

function main.menu.Inventory(n)
    if not main.inventory.letUseInventory then func.MsgBox("main", "msg_notices", 1) return; end
	main.menuservice.names = "Поверапы|Оружие|Предметы|Кредиты|Назад"
	main.menuservice.on_select = "main.menu.Inventory(n)"
	main.menuservice.title = "splash_gf"
	main.menu.section = "inventory"
	main.menu.Refresh()
	if n == nil then return end
		if n == 1 then main.menu.InventoryBoosts()
		elseif n == 2 then main.menu.InventoryWeapons()
		elseif n == 3 then main.menu.InventoryThings()
		elseif n == 4 then main.menu.InventoryPlayerInfo()
		else main.menu.GameOpt()
	end
end

function main.menu.InventoryWeapons(n)
	local weap1 = main.player.weapon1 or ""
	local weap2 = main.player.weapon2 or ""
	
    service("msgbox", {
		name="msbox", 
		--text="\nУ Вас в инвентаре на данный момент. \n\nЭнергетических усилителей оружия: "..func.ConvertWeap(weap1).." \nПЭРК: "..func.ConvertWeap(weap2).." \n\nЧто будете использовать?", 
		text="\n"..func.Read("main", "msg_changeweap", 1).." \n\n"..func.Read("main", "msg_changeweap", 2).." "..func.ConvertWeap(weap1).." \n"..func.Read("main", "msg_changeweap", 3).." "..func.ConvertWeap(weap2).." \n\n"..func.Read("main", "msg_changeweap", 4), 
		on_select="if exists('player_weap') then kill('player_weap') end; if n==2 then func.EquipWeap('"..weap1.."', 'player_weap', '"..const.playerName.."_tank'); main.player.weapon = '"..weap1.."' elseif n==1 then func.EquipWeap('"..main.player.weapon.."', 'player_weap', '"..const.playerName.."_tank') elseif n==3 then func.EquipWeap('"..weap2.."', 'player_weap', '"..const.playerName.."_tank'); main.player.weapon = '"..weap2.."' end",  
		option1 = "Выйти", 
		option2 = func.ConvertWeap(weap1), 
		option3 = func.ConvertWeap(weap2)})
end

function main.menu.InventoryBoosts(n)
	if main.inventory.letUseInventory == true then
		if not func.ExistsCharacter(const.playerName) then main.menu.Inventory() end;
		local items = main.characters[const.playerName].inventory.items;
		items.ey = items.ey or 0;
		items.healthpack = items.healthpack or 0;
		items.mine = items.mine or 0;
		main.menuservice.names="Усилитель(x"..items.ey..")|ПЭРК(x"..items.healthpack..")|Мина(x"..items.mine..")|Вперед|Назад"
		main.menuservice.on_select="main.menu.InventoryBoosts(n)"
		main.menuservice.title="splash_inventory"
		main.menu.section="inv_boosts"
        main.menu.Refresh()
		if n == nil then return end
			if n == 1 then 
				func.UseItem("boo", const.playerName)
				main.menuservice.names="Усилитель(x"..items.ey..")|ПЭРК(x"..items.healthpack..")|Мина(x"..items.mine..")|Вперед|Назад"
				main.menu.Refresh()
			elseif n == 2 then 
				func.UseItem("healthpack", const.playerName)
				main.menuservice.names="Усилитель(x"..items.ey..")|ПЭРК(x"..items.healthpack..")|Мина(x"..items.mine..")|Вперед|Назад"
				main.menu.Refresh()
			elseif n == 3 then 
				func.UseItem("mine", const.playerName)
				main.menuservice.names="Усилитель(x"..items.ey..")|ПЭРК(x"..items.healthpack..")|Мина(x"..items.mine..")|Вперед|Назад"
				main.menu.Refresh()
			else 
				main.menu.Inventory()
--				main.menuservice.names="Почта|Инвентарь|Задания|Назад"
--				main.menuservice.on_select="main.menu.GameOpt(n)"
--				main.menuservice.title="splash_gf"
--				main.menu.Refresh()
		end
--            service("msgbox", {name="msbox", text="\nУ Вас в инвентаре на данный момент. \n\nЭнергетических усилителей оружия: "..numberBoo.." \nПЭРК: "..numberHealthPack.." \n\nЧто будете использовать?", on_select="if n==1 then user.UseBattery() elseif n==2 then user.UseHealthPack() end",  option2="ПЭРК", option3="Выйти", option1="Усилитель"})
--[[    elseif main.inventory.letUseInventory == false then   
        service("msgbox", {text="\nИнвентарь не доступен вне начатой игры.\n"})]]
    end
end

function main.menu.InventoryThings(n)
	if not func.ExistsCharacter(const.playerName) then main.menu.Inventory() end;
	local items = main.characters[const.playerName].inventory.items;
	items.bomb = items.bomb or 0;
	items.key = items.key or 0;
	items.boo = items.boo or 0;
	main.menuservice.names="ЛАМ(x"..items.bomb..")|Ключ-карта(x"..items.key..")|Батарея(x"..items.boo..")|Вперед|Назад"
	main.menuservice.on_select="main.menu.InventoryThings(n)"
	main.menuservice.title="splash_inventory"
	main.menu.section="inv_things"
	main.menu.Refresh()
	if n == nil then return end
		if n == 1 then 
			func.UseItem("bomb", const.playerName)
			main.menuservice.names="ЛАМ(x"..items.bomb..")|Ключ-карта(x"..items.key..")|Батарея(x"..items.boo..")||Вперед|Назад"
			main.menu.Refresh()
		elseif n == 2 then 
			func.UseItem("key", const.playerName)
			main.menuservice.names="ЛАМ(x"..items.bomb..")|Ключ-карта(x"..items.key..")|Батарея(x"..items.boo..")||Вперед|Назад"
			main.menu.Refresh()
		elseif n == 3 then 
			func.UseItem("battery", const.playerName)
			main.menuservice.names="ЛАМ(x"..items.bomb..")|Ключ-карта(x"..items.key..")|Батарея(x"..items.boo..")||Вперед|Назад"
			main.menu.Refresh()
		else 
			main.menu.Inventory()
		end
end

-- Первая попытка переделать инвентарь. Была заброшена мною. Slava98. 30.09.13.
function main.inventory.TableToInventory(item)
	if item == "boo" then return func.Read({"main", "inventory_item_names", 3});
	elseif item == "healthpack" then return func.Read({"main", "inventory_item_names", 4});
	elseif item == "mine" then return func.Read({"main", "inventory_item_names", 5});
	elseif item == "armor" then return func.Read({"main", "inventory_item_names", 6});
	elseif item == "bomb" then return func.Read({"main", "inventory_item_names", 7});
	elseif item == "key" then return func.Read({"main", "inventory_item_names", 8});
	elseif item == "battery" then return func.Read({"main", "inventory_item_names", 9});
	elseif item == "superhealthpack" then return func.Read({"main", "inventory_item_names", 10});
	elseif item == "laserpack" then return func.Read({"main", "inventory_item_names", 11});
	elseif item == "bomb_activated" then return func.Read({"main", "inventory_item_names", 12});
	end;
end

function main.menu.TestInventory(n)
	for itemName, j in pairs(main.characters[const.playerName].inventory.items) do
		
	end;
	main.menuservice.names=""
	main.menuservice.on_select="main.menu.InventoryThings(n)"
	main.menuservice.title="splash_inventory"
	main.menu.section="inv_boosts"
	main.menu.Refresh()
	if n == nil then return end
		if n == 1 then 
			level.screenplay.BombActivate()
			main.menuservice.names="ЛАМ(x"..main.inventory.numberBoo..")|Ключ-карта(x"..main.inventory.numberHealthPack..")|Батарея(x"..main.inventory.numberMine..")||Вперед|Назад"
			main.menu.Refresh()
		elseif n == 2 then 
			level.screenplay.KeyActivate()
			main.menuservice.names="ЛАМ(x"..main.inventory.numberBoo..")|Ключ-карта(x"..main.inventory.numberHealthPack..")|Батарея(x"..main.inventory.numberMine..")||Вперед|Назад"
			main.menu.Refresh()
		elseif n == 3 then 
			level.screenplay.BatteryActivate()
			main.menuservice.names="ЛАМ(x"..main.inventory.numberBoo..")|Ключ-карта(x"..main.inventory.numberHealthPack..")|Батарея(x"..main.inventory.numberMine..")||Вперед|Назад"
			main.menu.Refresh()
		else 
			main.menu.Inventory()
		end
end

function main.inventory.ShowItem(item)
	if item == "mine" then main.inventory.items[table.maxn(main.inventory.items) + 1] = "mine";
	elseif item == "hp" then main.inventory.items[table.maxn(main.inventory.items) + 1] = "hp";
	elseif item == "battery" then main.inventory.items[table.maxn(main.inventory.items) + 1] = "battery";
	elseif item == "bomb" then main.inventory.items[table.maxn(main.inventory.items) + 1] = "bomb";
	elseif item == "key" then main.inventory.items[table.maxn(main.inventory.items) + 1] = "key";
	elseif item == "battery" then main.inventory.items[table.maxn(main.inventory.items) + 1] = "battery";
	else func.Error("item isn't exist")
	end
end

function main.inventory.HideItem(item)
	local itemNum = 0;
	for i = 0, table.maxn(main.inventory.items) do if main.inventory.items[i] == item then itemNum = i; end; end;
	if itemNum ~= 0 then table.remove(main.inventory.items, itemNum) else func.Error("item isn't exist") end;
end

function main.inventory.ChangeItemNum(item, value)
	local itemNum = 0;
	if item == "mine" then itemNum = main.inventory.numberMine; if value <= main.inventory.numberMine then main.inventory.numberMine = main.inventory.numberMine + value; end;
	elseif item == "hp" then itemNum = main.inventory.numberHealthPack; if value <= main.inventory.numberHealthPack then main.inventory.numberHealthPack = main.inventory.numberHealthPack + value; end;
	elseif item == "battery" then itemNum = main.inventory.numberBoo; if value <= main.inventory.numberBoo then main.inventory.numberBoo = main.inventory.numberBoo + value; end;
	elseif item == "bomb" then itemNum = main.inventory.numberBomb; if value <= main.inventory.numberBomb then main.inventory.numberBomb = main.inventory.numberBomb + value; end;
	elseif item == "key" then itemNum = main.inventory.numberKey; if value <= main.inventory.numberKey then main.inventory.numberKey = main.inventory.numberKey + value; end;
	elseif item == "battery" then itemNum = main.inventory.numberBattery; if value <= main.inventory.numberBattery then main.inventory.numberBattery = main.inventory.numberBattery + value; end;
	else func.Error("item isn't exist"); return
	end;
	if itemNum > 0 then main.inventory.ShowItem(item)
	elseif itemNum == 0 then main.inventory.HideItem(item)
	end;
	return itemNum;
end

function main.inventory.SetItemNum(item, value)
	if item == "mine" then main.inventory.numberMine = value;
	elseif item == "hp" then main.inventory.numberHealthPack = value;
	elseif item == "battery" then main.inventory.numberBoo = value;
	elseif item == "bomb" then main.inventory.numberBomb = value;
	elseif item == "key" then main.inventory.numberKey = value;
	elseif item == "battery" then main.inventory.numberBattery = value;
	else func.Error("item isn't exist"); return
	end;
	if value > 0 then main.inventory.ShowItem(item)
	elseif value <= 0 then main.inventory.HideItem(item)
	end;
end

---------------------------------------------------------------------------------------------------------------------

-- Внизу устаревшие функции. Slava98. 15.08.13.

function main.inventory.UseBattery()
    if main.inventory.numberBoo > 0 and main.inventory.isActivatedBoo == false then --Если у нас есть ЭУ и у нас они деактивированы, то..
        main.inventory.isActivatedBoo = true; --..ЭУ активирован.
		main.inventory.numberBoo = main.inventory.numberBoo - 1;
        pushcmd( function() actor("pu_booster", 0, 0, {name="bonus_boo"}) end, 0.1)
        pushcmd( function() if exists("ourplayer_tank") then equip("ourplayer_tank", "bonus_boo") else if exists("bonus_boo") then kill("bonus_boo") main.inventory.isActivatedBoo = false;  message("А быть читером не хорошо =)") end end end, 0.2)
        pushcmd( function() pause(true) service("msgbox", {text="\nЭнергетический усилитель активирован.\n", on_select="pause(false)"}) end, 0.3)
                pushcmd( function() message("Заряд усилителя исчерпан") end, 20.3)
        pushcmd( function() kill("bonus_boo") end, 21)
                pushcmd( function() main.inventory.isActivatedBoo = false end, 22) --После окончания его действия, мы можем вновь включить усилитель.
        elseif main.inventory.isActivatedBoo == true then --Если он у нас уже активирован, то..
                service("msgbox", {text="\nЭнергетический усилитель у Вас уже активирован\n"}) --..он активирован =)
        else
        service("msgbox", {text="\nУ Вас нет усилителей\n"})
        return main.inventory.numberBoo;
    end
end


function main.inventory.UseHealthPack()
    if main.inventory.numberHealthPack > 0 then
        main.inventory.numberHealthPack = main.inventory.numberHealthPack - 1;
        if exists("ourplayer_tank") then x, y = position("ourplayer_tank") end
            pushcmd( function() if exists("health")== false then actor("pu_health", x, y, { name="health" }) else end end, 0.1)
--          pushcmd( function() pause(true) end, 0.2)
            pushcmd( function() pause(true) service("msgbox", {text="\nПЭРК использован, танк починен.\n", on_select="pause(false)"}) end, 1)
            pushcmd( function() if exists("health")== true  then kill("health") end end, 3)
        else
            service("msgbox", {text="\nУ Вас нет ПЭРК\n" } )
            return main.inventory.numberHealthPack;
--          user.Refresh()
    end
end

function main.inventory.UseMine()
    if main.inventory.numberMine > 0 and main.inventory.isActivatedMine == false then --Если у нас есть мина и у нас они деактивированы, то..
                main.inventory.numberMine = main.inventory.numberMine - 1;
                main.inventory.isActivatedMine = true;
                if exists("ourplayer_tank") then x, y = position("ourplayer_tank") end
                        main.inventory.mineNum = main.inventory.mineNum + 1
                        actor("user_sprite", x, y, {
                                name="mine"..main.inventory.mineNum, 
                                texture="item_mine", } )
                        actor("trigger", x, y, {
                                name="mine_trig"..main.inventory.mineNum, 
                                only_human=1, 
                                on_leave="main.inventory.isActivatedMine = false; kill('mine'..main.inventory.mineNum); kill('mine_trig'..main.inventory.mineNum); actor('pu_mine',"..x..", "..y..", {on_pickup = 'func.MineDetonate(who)'})" } )
        elseif main.inventory.isActivatedMine == true then --Если она у нас уже активирована, то..
                service("msgbox", {text="\nВы уже поставили здесь мину\n" } ) --..он активирована =)
        else
                service("msgbox", {text="\nУ Вас нет мин\n" } )
        return main.inventory.numberMine;
        end
end

function main.inventory.AddNumBoo(num)
    main.inventory.numberBoo = main.inventory.numberBoo + num
    return main.inventory.numberBoo
end

function main.inventory.AddNumHealthPack(num)
    main.inventory.numberHealthPack = main.inventory.numberHealthPack + num
    return main.inventory.numberHealthPack
end

function main.inventory.AddNumMine(num)
    main.inventory.numberMine = main.inventory.numberMine + num
    return main.inventory.numberMine
end

function main.inventory.SetNumBoo(num)

    main.inventory.numberBoo = num
    return main.inventory.numberBoo
end

function main.inventory.SetNumHealthPack(num)

    main.inventory.numberHealthPack = num
    return main.inventory.numberHealthPack
end

function main.inventory.SetNumMine(num)
    main.inventory.numberMine = 0
    main.inventory.numberMine = num
    return main.inventory.numberMine
end

-- Конец устаревших функций.


function main.menu.Show(section)
-- Обработчик ошибок (написать).
	if type(section) ~= "string" then error("bad argument #1 to 'main.menu.Show' (string expected, got "..type(section)..")", 2) end;

	local charTab = main.characters[const.playerName];
	if section == "main" then 
		local funcTab = {"game", "gameopt_page"..main.gameOptPage, "help"};
		for i = 1, #funcTab do funcTab[i] = "main.menu.Show('"..funcTab[i].."')"; end;
		main.menu.Set(section, nil, {1, 2, 3}, funcTab, "splash")
	elseif section == "game" then 
		main.menu.Set(section, nil, {4, 5, 6, 7, 29}, {"main.menu.NewGame()", "main.menu.Demo()", "main.menu.Demo()", "main.menu.LevelPacks()", "main.menu.Show('main')"}, "splash_game")
	elseif section == "gameopt_page1" then 
		main.gameOptPage = 1,
		main.menu.Set(section, nil, {8, 9, 10, 36, 29}, {"main.menu.MailBox()", "main.menu.Inventory()", "main.menu.Missions()", "main.menu.Show('gameopt_page2')", "main.menu.Show('main')"}, "splash_gf")
	elseif section == "gameopt_page2" then 
		main.gameOptPage = 2,
		main.menu.Set(section, nil, {37, 25, 26, 11, 29}, {"main.menu.Show('gameopt_page1')", "main.menu.Show('companions')", "main.menu.Devices()", "main.menu.Show('cheats')", "main.menu.Show('main')"}, "splash_gf")
	elseif section == "help" then 
		main.menu.Set(section, nil, {12, 13, 14, 15, 29}, {"main.menu.Show('help_history')", "main.menu.Show('help_boosts')", "main.menu.Show('help_things')", "main.menu.About()", "main.menu.Show('main')"}, "splash_help")
	elseif section == "help_history" then 
		main.menu.Set(section, nil, {31, 32, 33, 34, 29}, {"main.menuservice.title='splash_people'; main.menu.Refresh()", "main.menuservice.title='splash_ekivator'; main.menu.Refresh()", "main.menuservice.title='splash_dassovator'; main.menu.Refresh()", "main.menuservice.title='splash_lorator'; main.menu.Refresh()", "main.menu.Show('help')"}, "splash_boosts")
	elseif section == "help_boosts" then 
		main.menu.Set(section, nil, {func.Read({"main", "inventory_item_names", 3}), func.Read({"main", "inventory_item_names", 4}), func.Read({"main", "inventory_item_names", 5}), 28, 29}, {"main.menuservice.title='splash_ey'; main.menu.Refresh()", "main.menuservice.title='splash_perk'; main.menu.Refresh()", "main.menuservice.title='splash_armor'; main.menu.Refresh()", "", "main.menu.Show('help')"}, "splash_boosts")
	elseif section == "help_things" then 
		main.menu.Set(section, nil, {func.Read({"main", "inventory_item_names", 7}), func.Read({"main", "inventory_item_names", 8}), func.Read({"main", "inventory_item_names", 9}), 28, 29}, {"main.menuservice.title='splash_lam'; main.menu.Refresh()", "main.menuservice.title='splash_armor'; main.menu.Refresh()", "main.menuservice.title='splash_booster'; main.menu.Refresh()", "", "main.menu.Show('help')"}, "splash_things")		
	elseif section == "inventory" then 
		if not main.inventory.letUseInventory or not func.ExistsCharacter(const.playerName) then
			if main.menu.section == "inventory_things" then main.menu.Show("main") return; end;
			func.MsgBox({"main", "msg_notices", 2}, nil, "menubox") 
			return; 
		end;
		main.menu.Set(section, nil, {14, 17, 24, 29}, {"main.menu.Inventory()", "main.menu.InventoryWeapons()", "main.menu.InventoryPlayerInfo()", "main.menu.Show('gameopt_page"..main.gameOptPage.."')"}, "splash_inventory")
	elseif section == "inventory_boosts" then 
		if not func.ExistsCharacter(const.playerName) then main.menu.Inventory() end;
		
		local items = main.characters[const.playerName].inventory.items;
		items.ey = items.ey or 0;
		items.healthpack = items.healthpack or 0;
		items.mine = items.mine or 0;
		
		main.menu.Set(section, nil, {func.Read({"main", "inventory_item_names", 3}), func.Read({"main", "inventory_item_names", 4}), func.Read({"main", "inventory_item_names", 5}), 28, 29}, {"main.menu.Show('inventory_boosts'); func.UseItem('boo', const.playerName)", "main.menu.Show('inventory_boosts'); func.UseItem('healthpack', const.playerName)", "main.menu.Show('inventory_boosts'); func.UseItem('mine', const.playerName)", "", "main.menu.Show('inventory')"}, "splash_boosts", {"(x"..items.ey..")", "(x"..items.healthpack..")", "(x"..items.mine..")"})
	elseif section == "inventory_things_old" then
		if not func.ExistsCharacter(const.playerName) then func.MsgBox("msg_notices", "main", 1) end;
		
		local items = main.characters[const.playerName].inventory.items;
		items.bomb = items.bomb or 0;
		items.key = items.key or 0;
		items.boo = items.boo or 0;
		
		main.menu.Set(section, nil, {func.Read({"main", "inventory_item_names", 7}), func.Read({"main", "inventory_item_names", 8}), func.Read({"main", "inventory_item_names", 9}), 28, 29}, {"main.menu.Show('inventory_things'); func.UseItem('bomb', const.playerName)", "main.menu.Show('inventory_things'); func.UseItem('key', const.playerName)", "main.menu.Show('inventory_things'); func.UseItem('battery', const.playerName)", "", "main.menu.Show('inventory')"}, "splash_things", {"(x"..items.bomb..")", "(x"..items.key..")", "(x"..items.boo..")"})	
	elseif section == "inventory_things" then
		if not func.ExistsCharacter(const.playerName) then func.MsgBox({"main", "msg_notices", 1}, nil, "menubox") end;
		
		local items = main.characters[const.playerName].inventory.items;
		local itemNamesTab = {};
		local funcTab = {};
		local itemsNum = 1;
		local itemsNumOnPage = 1;
		
		for item, itemValue in pairs(items) do
			if itemValue ~= 0 and main.inventory.ConvertItemToString(item) ~= false then
				itemsNum = itemsNum + 1;
				if main.inventory.botreduce == math.ceil((itemsNum - 1) / 3) then
					itemsNumOnPage = itemsNumOnPage + 1;
					table.insert(itemNamesTab, main.inventory.ConvertItemToString(item).."(x"..itemValue..")")
					table.insert(funcTab, "func.UseItem('"..item.."', const.playerName)")
				end;
			end;
		end;
--		local pageNum = math.ceil(func.ValueNumber(itemNamesTab) / 3);
		
		if main.inventory.botreduce ~= 1 or itemsNum > 4--[[math.ceil(itemsNumOnPage / 3) > 1]] then
			table.insert(itemNamesTab, ">" --[[func.Read({"main", "menu", 28})]]) -- Кнопка "Вперёд".
			table.insert(funcTab, "if main.inventory.botreduce < "..math.ceil(itemsNum / 3).." then main.inventory.botreduce = main.inventory.botreduce + 1; else main.inventory.botreduce = 1; end; main.menu.Show('inventory_things')")		
		end;
		
		table.insert(itemNamesTab, func.Read({"main", "menu", 29})) -- Кнопка "Назад".
		table.insert(funcTab, "main.menu.Show('inventory')")
		main.menu.Set(section, nil, itemNamesTab, funcTab, "splash_inventory")
	elseif section == "cheats" then 
		main.menu.Set(section, nil, {20, 14, 21, func.Read({"main", "menu", 22}, {"main", "menu", 41}, func.Condition(main.player.godMode, func.Read({"main", "menu", 44}), func.Read{"main", "menu", 45}), {"main", "menu", 42}), 29}, {"main.menu.ReloadScripts()", "main.menu.Show('get_things_page1')", "main.menu.Demo()", "main.player.godMode = not main.player.godMode; func.tank.GodMode(const.playerVehName, main.player.godMode); main.menu.Show('cheats')", "main.menu.Show('gameopt_page"..main.gameOptPage.."')"}, "splash_game")
	elseif section == "devices" then	
		local function getLineName(deviceNameNum, deviceType, isActivated)
			if deviceType == "activating" then
				return func.Read({"main", "devices", deviceNameNum}, {"main", "devices", 1}, func.Condition(isActivated, func.Read({"main", "devices", 4}), func.Read({"main", "devices", 5})), {"main", "devices", 2});
			elseif deviceType == "preparing" then
				return func.Read({"main", "devices", deviceNameNum}, {"main", "devices", 1}, charTab.devices.autofireEfficiency, {"main", "devices", 3}, {"main", "devices", 2});				
			end;
		end;
		main.menu.Set(section, nil, {getLineName(6, "activating", charTab.devices.isActivated['minedetector']), getLineName(7, "activating", charTab.devices.isActivated['energydetector']), getLineName(8, "activating", charTab.devices.isActivated['arc']), getLineName(9, "preparing"), 29}, {"main.characters[const.playerName].devices.isActivated['minedetector'] = not main.characters[const.playerName].devices.isActivated['minedetector']; main.menu.Show('devices')", "main.characters[const.playerName].devices.isActivated['energydetector'] = not main.characters[const.playerName].devices.isActivated['energydetector']; main.menu.Show('devices')", "main.characters[const.playerName].devices.isActivated['arc'] = not main.characters[const.playerName].devices.isActivated['arc']; main.menu.Show('devices')", "if autofireEfficiency < 100 then func.MsgBox({'main', 'msg_notices', 30}, 'noticebox') else menu.main.Demo() end; main.menu.Show('devices')", "main.menu.Show('gameopt_page"..main.gameOptPage.."')"}, "splash_game")
	elseif section == "get_things_page1" then
		main.menu.Set(section, nil, {func.Read({"main", "inventory_item_names", 3}), func.Read({"main", "inventory_item_names", 4}), func.Read({"main", "inventory_item_names", 5}), 36, 29}, {"func.GiveItem('boo', const.playerName)", "func.GiveItem('healthpack', const.playerName)", "func.GiveItem('mine', const.playerName)", "main.menu.Show('get_things_page2')", "main.menu.Show('cheats')"}, "splash_things", {})	
	elseif section == "get_things_page2" then
		main.menu.Set(section, nil, {37, func.Read({"main", "inventory_item_names", 7}), func.Read({"main", "inventory_item_names", 8}), func.Read({"main", "inventory_item_names", 9}), 29}, {"main.menu.Show('get_things_page1')", "func.GiveItem('bomb', const.playerName)", "func.GiveItem('key', const.playerName)", "func.GiveItem('battery', const.playerName)", "main.menu.Show('cheats')"}, "splash_things", {})	
	end;
end

------------------------------------------------------------------------------------------
----------------------------------- ИНВЕНТАРЬ v.3 ----------------------------------------
------------------------------------------------------------------------------------------

function main.menu.Inventory()
	if not func.ExistsCharacter(const.playerName) then func.MsgBox({"main", "msg_notices", 1}, nil, "menubox") end;
		
	local charTab = main.characters[const.playerName];
	local items = charTab.inventory.items;
	local itemsNum = 0;
	local itemNamesTab = {};
	local funcTab = {};
	
	for item, itemValue in pairs(items) do
		if itemValue ~= 0 and main.inventory.ConvertItemToString(item) ~= false then
			itemsNum = itemsNum + 1;
			if itemValue ~= 1 then
				table.insert(itemNamesTab, main.inventory.ConvertItemToString(item)..func.Read({"main", "inventory_item_names", 1}, itemValue, {"main", "inventory_item_names", 2}))
			else
				table.insert(itemNamesTab, main.inventory.ConvertItemToString(item))
			end;
			table.insert(funcTab, "main.menu.ItemInfo('"..item.."'); main.menu.inventoryChosedSection = 1; main.menu.inventoryChosedString = "..itemsNum)
		end;
	end;

	if itemsNum > 0 then	
		func.ListBox(func.Read({"main", "inventory", 2, {height=charTab.height, maxHeight=charTab.maxHeight}}), {{stringTab=itemNamesTab, funcTab=funcTab}, {stringTab={func.Read({"main", "inventory", 5}), func.Read({"main", "menu", 17}), func.Read({"main", "menu", 24}), func.Read({"main", "menu", 30})}, funcTab={"main.menu.InventoryKeys(); main.menu.inventoryChosedSection = 2; main.menu.inventoryChosedString = 1", "main.menu.InventoryWeapons(); main.menu.inventoryChosedSection = 2; main.menu.inventoryChosedString = 2", "main.menu.InventoryPlayerInfo(); main.menu.inventoryChosedSection = 2; main.menu.inventoryChosedString = 3", "main.menu.inventoryChosedSection = 2; main.menu.inventoryChosedString = 4"}, chosedStringNum=main.menu.inventoryChosedString, sectionTitle="\n"}}, main.menu.inventoryChosedSection, "inventorybox")
	else
		func.ListBox(func.Read({"main", "inventory", 2, {height=charTab.height, maxHeight=charTab.maxHeight}}), {{stringTab={func.Read({"main", "inventory", 5}), func.Read({"main", "menu", 17}), func.Read({"main", "menu", 24}), func.Read({"main", "menu", 30})}, funcTab={"main.menu.InventoryKeys(); main.menu.inventoryChosedString = 1", "main.menu.InventoryWeapons(); main.menu.inventoryChosedString = 2", "main.menu.InventoryPlayerInfo(); main.menu.inventoryChosedString = 3", "main.menu.inventoryChosedString = 4"}, chosedStringNum=main.menu.inventoryChosedString}}, nil, "inventorybox")	
	end;
	
	pushcmd(function() func.KillIfExists("inventorybox") end, 0.001)
end

function main.menu.ItemInfo(item)
	local charTab = main.characters[const.playerName];
	local stringTab = {};
	local funcTab = {};
	local text = {};

	if item == "bomb" then
		table.insert(stringTab, func.Read({"main", "inventory", 9}));
		table.insert(funcTab, function() main.characters[const.playerName].inventory.dropBomb = true; func.UseItem(item, const.playerName) end);
	end;
	if not charTab.inventory.isActivated[item] then
		table.insert(stringTab, func.Read({"main", "inventory", 6}))
		table.insert(funcTab, function() func.UseItem(item, const.playerName); end) 
	else
		if charTab.inventory.numOfPushed[item] or (not charTab.inventory.numOfPushed[item] or charTab.inventory.numOfPushed[item] < charTab.inventory.items[item] and (item == "healthpack" or item == "superhealthpack" or item == "boo" or item == "battery")) then
			table.insert(stringTab, func.Read({"main", "inventory", 11}))
			table.insert(funcTab, function() func.PushItemsBox(item) end)
		end;
		if charTab.inventory.numOfPushed[item] and charTab.inventory.numOfPushed[item] > 0 then
			table.insert(stringTab, func.Read({"main", "inventory", 12}))
			table.insert(funcTab, function() func.UnpushItemsBox(item) end)
		end;
	end;
	table.insert(funcTab, function() func.DropItemsBox(item, 1); end)
	table.insert(stringTab, func.Read({"main", "inventory", 7}))
	table.insert(funcTab, function() main.menu.TransmitItem(item); main.menu.Inventory() end)
	table.insert(stringTab, func.Read({"main", "inventory", 8}))
	if not charTab.inventory.isActivated[item] and (not charTab.inventory.numOfPushed[item] or charTab.inventory.numOfPushed[item] and (charTab.inventory.numOfPushed[item] < charTab.inventory.items[item] and (item == "healthpack" or item == "superhealthpack" or item == "boo" or item == "battery"))) then
		table.insert(stringTab, func.Read({"main", "inventory", 11}))
		table.insert(funcTab, function() func.PushItemsBox(item) end)
	end;
	if not charTab.inventory.isActivated[item] and charTab.inventory.numOfPushed[item] and charTab.inventory.numOfPushed[item] > 0 then
			table.insert(stringTab, func.Read({"main", "inventory", 12}))
			table.insert(funcTab, function() func.UnpushItemsBox(item) end)
	end;
	table.insert(funcTab, function() main.menu.Inventory() end)
	table.insert(stringTab, func.Read({"main", "menu", 29}))
	
	text = {main.inventory.ShowItemInformation(item), "\n", func.Read({"main", "inventory", 15, {num=charTab.inventory.items[item]}}, {"main", "inventory", 3, {thingHeight=func.ShowItemHeight(item)}}, {"main", "inventory", 4})};
	
	if charTab.inventory.items[item] > 1 then
		if func.ShowItemHeight(item) ~= 0 then
			table.insert(text, func.Read({"main", "inventory", 16, {sumThingHeight=func.ShowItemHeight(item)*charTab.inventory.items[item]}}))
		end;
--		if func.ShowItemPrice(item) ~= 0 then
			table.insert(text, func.Read({"main", "inventory", 17}))
--		end
	end;
	
	
	if charTab.inventory.numOfPushed[item] ~= nil and charTab.inventory.numOfPushed[item] > 0 then
		table.insert(text, func.Read({"main", "inventory", 14, {setToPush=charTab.inventory.numOfPushed[item]}}))
	end;
	
	func.ListBox(table.concat(text), {{stringTab=stringTab, funcTab=funcTab}}, nil, "inventorybox")
	
	pushcmd(function() func.KillIfExists("inventorybox") end, 0.001)
end

function main.menu.InventoryKeys()
	local charTab = main.characters[const.playerName];
	local inventory = charTab.inventory;
	local keyTab = {};
	local funcTab = {};
	
	if #inventory.keys == 0 then
		func.MsgBox({"main", "msg_notices", 23}, {on_select="main.menu.Inventory()"}, "inventorybox")
		return;
	end;
	
	for keyNum = 1, #inventory.keys do
		table.insert(keyTab, func.Read({"main", "inventory_item_names", 8}).." "..func.Read({"main", "keys", keyNum}))
		table.insert(funcTab, "main.menu.InventoryKeys()")
	end;

	func.ListBox("", {{stringTab=keyTab, funcTab=funcTab}, {funcTab={function() main.menu.Inventory() end}, stringTab={func.Read({"main", "menu", 29})}, sectionTitle="\n"}})
end

function main.inventory.ShowItemInformation(item)
	if item == "boo" then
		return func.Read({"main", "inventory_item_information", 1});
	elseif item == "healthpack" then
		return func.Read({"main", "inventory_item_information", 2});
	elseif item == "mine" then
		return func.Read({"main", "inventory_item_information", 3});
	elseif item == "armor" then
		return func.Read({"main", "inventory_item_information", 4});
	elseif item == "bomb" then
		return func.Read({"main", "inventory_item_information", 5});
	elseif item == "battery" then
		return func.Read({"main", "inventory_item_information", 6});
	elseif item == "superhealthpack" then
		return func.Read({"main", "inventory_item_information", 7});
	elseif item == "laserpack" then
		return func.Read({"main", "inventory_item_information", 8});
	elseif item == "bomb_activated" then
		return func.Read({"main", "inventory_item_information", 9});
	else
		return "";
	end;
end

function main.menu.Devices()
	if not func.ExistsCharacter(const.playerName) then func.MsgBox({"main", "msg_notices", 1}, nil, "menubox") end;
	
	local charTab = main.characters[const.playerName];
	local function getLineName(deviceNameNum, deviceType, isActivated)
		if deviceType == "activating" then
			return func.Read({"main", "devices", deviceNameNum}, {"main", "devices", 1}, func.Condition(isActivated, func.Read({"main", "devices", 4}), func.Read({"main", "devices", 5})), {"main", "devices", 2});
		elseif deviceType == "preparing" then
			return func.Read({"main", "devices", deviceNameNum}, {"main", "devices", 1}, charTab.devices.autofireEfficiency, {"main", "devices", 3}, {"main", "devices", 2});				
		end;
	end;
	func.ListBox(func.Read({"main", "devices", 10}, {"main", "devices", 11, {energyConsumption = charTab.energyConsumption}}), {{stringTab={getLineName(6, "activating", charTab.devices.isActivated['minedetector']), getLineName(7, "activating", charTab.devices.isActivated['energydetector']), getLineName(8, "activating", charTab.devices.isActivated['arc']), getLineName(9, "preparing"), func.Read({"main", "menu", 30})}, funcTab={function(n) main.menu.devicesChosedString = n; main.characters[const.playerName].devices.isActivated['minedetector'] = not main.characters[const.playerName].devices.isActivated['minedetector']; main.menu.Devices() end, function(n) main.menu.devicesChosedString = n; main.characters[const.playerName].devices.isActivated['energydetector'] = not main.characters[const.playerName].devices.isActivated['energydetector']; main.menu.Devices() end, function(n) main.menu.devicesChosedString = n; main.characters[const.playerName].devices.isActivated['arc'] = not main.characters[const.playerName].devices.isActivated['arc']; main.menu.Devices() end, function(n) main.menu.devicesChosedString = n; if autofireEfficiency < 100 then func.MsgBox({'main', 'msg_notices', 30}, 'noticebox') else menu.main.Demo() end; main.menu.Devices() end, function(n) main.menu.devicesChosedString = n; --[[main.menu.Show('gameopt_page"..main.gameOptPage.."')]] end}, chosedStringNum=main.menu.devicesChosedString, "inventorybox"}});

	pushcmd(function() func.KillIfExists("listbox") end, 0.001)
end

------------------------------------------------------------------------------------------
---------------------------------------ПОЧТА----------------------------------------------
------------------------------------------------------------------------------------------

--*Эта муть -  недоделанный PDA. Впоследствии возможно будет переделан. Пока пусть будет хотя бы такой. (31.10.10, Sl@v@98)
--*У меня вышла удачная попытка сделать почту. Она нормально высвечивает 1-ое сообщение. (02.10.10, Sl@v@98)
--*Почта готова! Большое спасибо Антикиллеру! Осталось только сделать, чтобы письма приходили и, конечно сами письма =) (08.10.10, Sl@v@98)

-- Почта. Множество раз переделывалась, в последний раз масштабное изменение произошло 06.06.13. by Slava98.
function main.menu.MailBox(n)
    if not main.mail.letUseMail then func.MsgBox({"main", "msg_notices", 1}, nil, "menubox") return; end;

	main.mail.botreduce = main.mail.botreduce or 1;
	local mailNum;
	
	if n ~= nil then
		if n == 1 then main.mail.botreduce = main.mail.botreduce - 1;
		elseif n == 2 then main.mail.botreduce = main.mail.botreduce + 1;
		end;
	end;
	
	if main.mail.botreduce == 0 then main.mail.botreduce = main.mail.botreduce + 1; 
	elseif main.mail.botreduce == main.mail.maxValue + 1 then main.mail.botreduce = main.mail.botreduce - 1;
	else
	end;
	mailNum = main.mail.botreduce;
	
	if not main.mail.playerSawPromtMessage then
		func.MsgBox({"map01", "mail", mailNum}, {
			name = "mail_messagebox",
			on_select = "if n ~= 3 then main.menu.MailBox(n) end",
			option1 = func.Read({"main", "menu", 29}),
			option2 = func.Read({"main", "menu", 28}),
			option3 = func.Read({"main", "menu", 30})}, "menubox")
	else
		func.MsgBox({"main", "msg_promt", 1}, {on_select="main.menu.MailBox()"}, "menubox")
		main.mail.playerSawPromtMessage = true;
	end;
end;
--[[
function main.mail.Message(messageNum)
        print(messageNum)
        if messageNum == nil then return
        elseif messageNum > main.mail.letViewMessage then main.mail.message = "Пустое сообщение"
        else
                if messageNum == 1 then main.mail.message="\n                              Сообщение №1\n                        От кого: Завод по изготовлению машин \n                         Тема: Танк ЭКО-451 \n Здраствуйте, элитный боец Экиваторов!\n Для Вас мы изготовили специальный танк для поиска отстатков энергии.\n Танк ЭКО-5 обладает почти всеми новейшими технологиями для поиска энергии.\n Он имеет фиксированный прицел AI780, неоновый двигатель ZIP-200,\n антенну для почты TROO v6, новейшими боковыми защитными экранами QDM1,\n ГПКЗ-5 (Глобальную Противоснарядную Кормовую Защиту),\n индикаторы для поиска энергетичких батарей и мин,\n а также много места для перевозки большое количество батарей и не только.\n Пушкой Ваш танк не оснащаем для экономности. \n Если Вам её дадут, не забывайте о правилах стрельбы!"
                elseif messageNum == 2 then main.mail.message = "\n                              Сообщение №2\n                        От кого: Генерал Орон \n                         Тема: Ваши функции \n Здраствуйте, солдат ЭВЭ. Я Генерал Орон, меня назначили вашим командиром.\n Я думаю, вы знаете о энергитическом кризисе и о наших временах после него. \n ЭВЭ послала вас добывать энергию на нашей планете. \n Как только вы найдёте энергию или ещё что-нибудь интересное, \n сообщите в нашу энергетическую службу или мне. \n В случае военных дейвствий слушайтесь ближайшего высшего бойца Экиваторов \n и свяжитесь со мной как можно быстрей. \n Вам разрешено вступать в контакт с местным населением.  \n При возможности найдите источники связи (спутниковая тарелка, например). " --почти как на уроках ОБЖ =D
                elseif messageNum == 3 then main.mail.message = "\n                              Сообщение №3\n                        От кого: Сержант, командир боевого поселения, Халос \n                         Тема: Нападение\n Внимание всем бойцам! Было замечено нападение в виде подрыва защитной стены!\n И неизвестные войска продвигаются в поселение! Это не учебная тревога!\n Всем бригадам приготовиться к бою! Враг пока неизвестен,\n но сейчас защитить поселение!"
--              elseif messageNum == 4 then main.mail.message = "\n                              Сообщение №4\n                        От кого: Генерал Орон \n                         Тема: Нападение\n Здраствуйте, боец Экиваторов.\n Прежде всего, спасибо, что помогли сдержать нападение и сообщили мне.\n Такое нападение произошло не только у вас!\n Рядом с вами, в области 396, было совершено нападение на ЦЛГ и таможню\n и передвинута лазерная граница. Противник, насколько известено - повстанцы.\n Они захватили наш энергоблок и потом пошли дальше, напав на ваше поселение.\n Скоро у нас совсем не хватит энергии!\n Отберите энергоблок у повстанцев!"
                elseif messageNum == 4 then main.mail.message = "\n                                        Сообщение №4\n                                  От кого: Sl@v@98 и VIRUS \n                                   Тема: Прохождение  \nСпасибо, что прошли демо-версию кампании War System. \n Мы её долго создавали, и мы надеемся, что вы прошли WS без дополнений к картам и своих скриптов. \n О багах сообщайте в тему кампании http://zod.borda.ru/?1-8-0-00000017-000-0-0-1288602334 \n Спасибо: \n- Insert'у - за игру \n- Morse - за помощь в скриптах \n- AntiKiller'у - за новую версию игры и помощь в скриптах \n Ждите полную версию кампании за Экиваторов! \n                          VIRUS (автор идеи, скриптер, мапер) и Sl@v@98 (скриптер, художник, мапер)."       
                end
        end
end
]]
function main.mail.GetMail()
	pause(true)
	main.mail.letViewMessages = main.mail.letViewMessages + 1;
	main.mail.maxValue = main.mail.maxValue + 1;
	func.MsgBox({"main", "msg_notices", 3}, {on_select="pause(false)"}, "menubox")
-- 	service("msgbox", {text="Вам на почту пришло сообщение. Нажмите esc для просмотра.", on_select="pause(false)"})
end



function main.menu.LevelPacks(n)
	if exists("lp_messagebox") then kill("lp_messagebox") end
	main.levelpack.botreduce = main.levelpack.botreduce or main.levelpack.GetNum()
	if n~=nil then
        if n==1 then main.levelpack.botreduce=main.levelpack.botreduce-1
		elseif n==2 then main.levelpack.botreduce=main.levelpack.botreduce+1
        end
    end
	if main.levelpack.botreduce == 0 then main.levelpack.botreduce = main.levelpack.botreduce + 1
	elseif main.levelpack.botreduce == table.maxn(main.levelpacks) + 1 then main.levelpack.botreduce = main.levelpack.botreduce - 1
	else 
		local lp = main.levelpack[main.levelpacks[main.levelpack.botreduce]];
		if type(lp) == "table" then 
			if lp.name~=nil then main.levelpack.text=lp.name else main.levelpack.text = "Безымянный" end
			if lp.description~=nil then main.levelpack.text = main.levelpack.text.."\nОписание: "..lp.description else main.levelpack.text = main.levelpack.text.."\nНет описания" end
			if lp.type=="race" then main.levelpack.text = main.levelpack.text.."\nТип: Расовая кампания"
--			elseif lp.type==
			else main.levelpack.text = main.levelpack.text.."\nТип: Одиночный уровень" 
			end
		end
	end
		service("msgbox", {
                	name="lp_messagebox", 
                	text=main.levelpack.text,
                	on_select="if n ~= 3 then main.menu.LevelPacks(n) else main.levelpack.default = main.levelpacks[main.levelpack.botreduce]; end",
                	option1="Назад",
                	option2="Вперёд",
                	option3="Выбрать" } )
end

function main.menu.Missions()
        service("msgbox", {text="\n Основные задачи:\n" ..main.missions.mainMission.."\n Дополнительные задачи: \n"..main.missions.extraMission.."\n"})
end

function main.menu.InventoryWeapons(n)
	if #main.characters[const.playerName].inventory.weapons < 2 then func.MsgBox(func.Read({"main", "msg_changeweap", 3}), {on_select="main.menu.Inventory()"}, "inventorybox") return; end;
	
	local weap1 = main.characters[const.playerName].inventory.weapons[1].weapType or "";
	local weap2 = main.characters[const.playerName].inventory.weapons[2].weapType or "";
	
	func.MsgBox(func.Read({"main", "msg_changeweap", 1, {weap1 = func.ConvertWeap(weap1), weap2 = func.ConvertWeap(weap2)}}), {
		on_select="if n == 2 then func.CharacterSetWeap(const.playerName, '"..weap1.."'); elseif n == 3 then func.CharacterSetWeap(const.playerName, '"..weap2.."'); end; main.menu.Inventory()",
		option1 = func.Read({"main", "menu", 29}),
		option2 = func.ConvertWeap(weap1), 
		option3 = func.ConvertWeap(weap2)}, "menubox")
end

function main.menu.InventoryPlayerInfo()
	local charTab = main.characters[const.playerName];
	local ruleset = charTab.ruleset;
	
	local function SetPadej(num)
		numTail = tonumber(string.sub(num, string.len(num)));
		if numTail == 1 then return 3;
		elseif numTail >= 2 and numTail <= 4 then return 4;
		else return 2;
		end;
	end;

	func.MsgBox(func.Read({"main", "msg_playerinfo", 1, {credits=charTab.credits, energy=main.characters[const.playerName].energy, damage=charTab.ruleset.damage, eloquence=charTab.ruleset.eloquence, luck=charTab.ruleset.luck, strategy=charTab.ruleset.strategy}}, {"main", "msg_playerinfo",  SetPadej(charTab.credits)}), {option1=func.Read({"main", "menu", 29}), on_select="main.menu.Inventory()"}, "inventorybox")
end

function main.menu.About() -- Переделать. Slava98. 30.09.13.
--user.menuservice.names="Назад"
--user.menuservice.on_select="user.About()"
--user.menuservice.title="splash_about"
--user.Refresh()
--if n == nil then return end
--else user.menuservice.names="Описание|Бонусы|Предметы|О кампании|Назад"
--     user.menuservice.on_select="user.Help(n)"
--     user.menuservice.title="splash_help"
--       user.Refresh()
--end
--end
    service("msgbox", {
                text=" Кампания War System создавалась как дополнение к неофициалоной версии TZOD by Anti_Killer. \nВ ёе создании использовались самые необычные скрипты и решения, \nдля содания красочного нелинейного сюжета. \nРабота над ней велась очень долго и мы надеемся что она вам понравилась. \nВсе коментарии оставляйте на официальном форуме игры (zod.borda.ru) в теме кампании. \n\n     War System: Ekivator Campaign                     Version 1 alpha \n                                   By Sl@v@98 and VIRUS" } )
end

------------------------------------------------------------------------------------------
-----------------------------------ТЕХНИЧЕСКИЕ ФУНКЦИИ------------------------------------
------------------------------------------------------------------------------------------

function main.menu.Refresh()
    if exists(main.menuservice.name) == true then
		main.menuservice.names = main.menuservice.names;
        main.menuservice.open = 1;
        main.menuservice.open = 1;
    end
end

function main.menu.OpenCloseMenu()
    if exists(main.menuservice.name) == true then
        main.menuservice.open = 1;
    end;
end

function main.menu.ReloadScripts()
	if main.levelpack.map ~= nil then
		dofile(const.scrDir.."/levels/"..main.levelpack.map.."/screenplay.lua")
		dofile(const.scrDir.."/levels/"..main.levelpack.map.."/speaks.lua")
		dofile(const.scrDir.."/levels/"..main.levelpack.map.."/functions.lua")
	end;
	dofile(const.scrDir.."/main/menu.lua")
	dofile(const.scrDir.."/main/functions.lua")
	dofile(const.scrDir.."/main/classes.lua")
	dofile(const.scrDir.."/levels/runlevels.lua")
	dofile(const.scrDir.."/dialogs/main.lua")
	loadtheme(const.scrDir.."/textures/map01.lua")
--	dofile(const.scrDir.."/levels/"..main.levelpack.map.."/startup.lua")
end

function main.menu.Demo()
        service("msgbox", {
                                text="Эта функция на реконструкции.\nВозможно, она появится \nв следущей версии."})
end

function main.menu.SetNames(tab)
-- Обработчик ошибок (написать).

-- Обьявление локальных переменных.
	local names = "";
	
	for i = 1, #tab do
-- Обработчик ошибок.
		if type(tab[i]) ~= "number" then error("bad variable #"..i.." in argument #1 to 'main.menu.SetNames' (number expected, got "..type(tab[i])..")", 2) end;
		
		names = names.."|"..func.Read({"main", "menu", tab[i]});
	end;
	
	main.menuservice.names = names;
end

function main.menu.Set(section, n, namesTab, funcTab, title, extraNamesTab)
-- Обработчик ошибок (написать).
	if type(section) ~= "string" then error("bad argument #1 to 'main.menu.Set' (string expected, got "..type(section)..")", 2) end;
	if type(n) ~= "number" and n ~= nil then error("bad argument #2 to 'main.menu.Set' (number expected, got "..type(n)..")", 2) end;
	if type(namesTab) ~= "table" then error("bad argument #3 to 'main.menu.Set' (table expected, got "..type(namesTab)..")", 2) end;
	if type(funcTab) ~= "table" then error("bad argument #4 to 'main.menu.Set' (table expected, got "..type(funcTab)..")", 2) end;
	if type(title) ~= "string" and title ~= nil then error("bad argument #5 to 'main.menu.Set' (string expected, got "..type(title)..")", 2) end;
	if type(extraNamesTab) ~= "table" and extraNamesTab ~= nil then error("bad argument #6 to 'main.menu.Set' (table expected, got "..type(extraNamesTab)..")", 2) end;

-- Обьявление локальных переменных.
	local title = title or "splash";
	local names = "";
	local on_select = "";
	local extraNamesTab = extraNamesTab or {};
	
	extraNamesTab = func.UniteTables({"", "", "", "", "", "", "", "", "", ""}, extraNamesTab)
	
	for i = 1, #namesTab do
-- Обработчик ошибок.
		if type(namesTab[i]) ~= "number" and type(namesTab[i]) ~= "string" then error("bad variable #"..i.." in argument #2 to 'main.menu.Set' (number or string expected, got "..type(namesTab[i])..")", 2) end;
		
		if i == 1 then 
			if type(namesTab[i]) == "string" then 
				names = namesTab[i]..extraNamesTab[i];
			else
				names = func.Read({"main", "menu", namesTab[i]})..extraNamesTab[i];
			end;
		else 
			if type(namesTab[i]) == "string" then 
				names = names.."|"..namesTab[i]..extraNamesTab[i]; 
			else
				names = names.."|"..func.Read({"main", "menu", namesTab[i]})..extraNamesTab[i];
			end;
		end;
	end;
	
	for i = 1, #funcTab do
-- Обработчик ошибок (написать).
		if type(funcTab[i]) ~= "string" then error("bad variable #"..i.." in argument #3 to 'main.menu.Set' (string expected, got "..type(funcTab[i])..")", 2) end;
		
		if funcTab[i] ~= "" then
			if i == 1 then on_select = "if n == "..i.." then "..funcTab[i].."; ";
			else on_select = on_select.."elseif n == "..i.." then "..funcTab[i].."; ";
			end;
		end;
		
		if i == #funcTab then on_select = on_select.."end;"; end;
	end;

    main.menuservice.title = title;
    main.menu.section = section;
	main.menuservice.names = names;
	main.menuservice.on_select = on_select;
    main.menu.Refresh()
	
end

function main.inventory.ConvertItemToString(item)
	for i = 1, 1000 do
		if item == "bomb_activated"..i then
			return func.Read({"main", "inventory_item_names", 12}, " ", item);
		end;
	end;
	
	if item == "boo" then return func.Read({"main", "inventory_item_names", 3});
	elseif item == "healthpack" then return func.Read({"main", "inventory_item_names", 4});
	elseif item == "mine" then return func.Read({"main", "inventory_item_names", 5});
	elseif item == "armor" then return func.Read({"main", "inventory_item_names", 6});
	elseif item == "bomb" then return func.Read({"main", "inventory_item_names", 7});
	elseif item == "key" then return func.Read({"main", "inventory_item_names", 8});
	elseif item == "battery" then return func.Read({"main", "inventory_item_names", 9});
	elseif item == "superhealthpack" then return func.Read({"main", "inventory_item_names", 10});
	elseif item == "laserpack" then return func.Read({"main", "inventory_item_names", 11});
	else return false;
	end;
end

function main.inventory.ItemBox(item)
	
end