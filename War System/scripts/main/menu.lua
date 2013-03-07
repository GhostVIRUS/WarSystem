--���� �������� War System
--By VIRUS

------------------------------------------------------------------------------------------
------------------------------------��������----------------------------------------------
------------------------------------------------------------------------------------------

function main.menu.Main(n)
    if n == 1 then main.menu.Game() 
    elseif n == 2 then main.menu.GameOpt()
    elseif n == 3 then main.menu.Help()
    end
end

function main.menu.Game(n)
    main.menuservice.names="����� ����|���������|������|���������|�����"
    main.menuservice.on_select="main.menu.Game(n)"
    main.menuservice.title="splash_game"
    main.menu.section = "game"
    main.menu.Refresh()
    if n == nil then return end
        if n == 1 then main.menu.NewGame() 
        elseif n == 2 then main.menu.Demo()
        elseif n == 3 then main.menu.Demo()
		elseif n == 4 then main.menu.LevelPacks()
        else main.menu.BackStart()
    end
end

function main.menu.Stages(n)
    main.menuservice.names="��|������|���������|�����"
    main.menuservice.on_select="main.menu.Stages(n)"
    main.menuservice.title="splash_game"
    main.menu.section = "game"
    main.menu.Refresh()
    if n == nil then return end
        if n == 1 then main.menu.DM() 
        elseif n == 2 then main.menu.StageMissions()
        elseif n == 3 then main.menu.LevelPacks()
        else main.menu.BackStart()
    end
end

function main.menu.BackStart()
        main.menuservice.names = "����|������� �������|������"
        main.menuservice.on_select = "main.menu.Main(n)"
        main.menuservice.title = "splash"
        main.menu.section = "menu"
        main.menu.Refresh()
end

function main.menu.NewGame()
        local lp = main.levelpack.default
		dofile("campaign/War System.lua")
        main.levelpack.Run(lp)
        pushcmd(function() main.menu.OpenCloseMenu() end, 0.2)
end

function main.menu.GameOpt(n)
    main.menuservice.names="�����|���������|�������|����|�����"
    main.menuservice.on_select="main.menu.GameOpt(n)"
    main.menuservice.title="splash_gf"
    main.menu.section = "gameopt"
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
    main.menuservice.names="����������|��������|��������|Godmode|�����"
    main.menuservice.on_select="main.menu.Cheats(n)"
    main.menuservice.title="splash_gf"
    main.menu.section = "cheats"
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
		local item = rawget(main.inventory.items, main.cheats.ibotreduce)
	end
		service("msgbox", {
                	name="cheatbox", 
                	text=item,
                	on_select="if n ~= 3 then main.menu.CheatsItems(n) else main.levelpack.default = rawget(main.levelpacks, main.levelpack.botreduce) end",
                	option1="�����",
                	option2="�����",
                	option3="�������" } )
end

function main.menu.ReloadScripts()
	dofile(main.scrDir.."/levels/"..main.levelpack.map.."/screenplay.lua")
	dofile(main.scrDir.."/levels/"..main.levelpack.map.."/speaks.lua")
	dofile(main.scrDir.."/levels/"..main.levelpack.map.."/functions.lua")	
	dofile(main.scrDir.."/main/menu.lua")
	dofile(main.scrDir.."/main/functions.lua")
	dofile(main.scrDir.."/main/classes.lua")
	dofile(main.scrDir.."/levels/runlevels.lua")
	dofile(main.scrDir.."/dialogs/main.lua")
	loadtheme(main.scrDir.."/textures/map01.lua")
--	dofile(main.scrDir.."/levels/"..main.levelpack.map.."/startup.lua")
end

function main.menu.Help(n)
    main.menuservice.names="��������|������|��������|� ��������|�����"
    main.menuservice.on_select="main.menu.Help(n)"
    main.menuservice.title="splash_help"
    main.menu.section = "help"
    main.menu.Refresh()
    if n == nil then return end
        if n == 1 then main.menu.History() 
        elseif n == 2 then main.menu.Boosts()
        elseif n == 3 then main.menu.Things()
        elseif n == 4 then main.menu.About()
        else main.menu.BackStart()
    end
end

function main.menu.Missions()
        service("msgbox", {text="\n �������� ������:\n" ..main.missions.mainMission.."\n �������������� ������: \n"..main.missions.extraMission.."\n"})
end

------------------------------------------------------------------------------------------
------------------------------------������------------------------------------------------
------------------------------------------------------------------------------------------

function main.menu.History(n)
        main.menuservice.names="����|���������|�����������|��������|�����"
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
        else main.menuservice.names="��������|������|��������|� ��������|�����"
                 main.menuservice.on_select="main.menu.Help(n)"
                 main.menuservice.title="splash_help"
                 main.menu.Refresh()
        end
end



function main.menu.Boosts(n)
    main.menuservice.names="����|���������|Lam|�����|�����"
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
--service("msgbox", {text=" ���� - ����������� ����������� �������������� ��������, \n����������� ��������, ����������� ����������� ��������� ����� ����� �������, \n����� ������������� ��������� ����������� � ������� �� �����. \n �������������� ��������� - �������� ����� ��� ������, \n����� ��� ������������ ��� ������ ���� �����. \n������ ���������� �������� 20 ������ � ������� �� ����� ����� �������������. \n� ��������� ������������ ������� ���������� �� ��������� ���������. \n LAM - ����� ����������� ����������, ����� ����� ������ � ���. \n������-�������������� ����� �������� �������� ������ � ������� ��������. \n���� ���������� ��������������."})
end


function main.menu.Things(n)
    main.menuservice.names="�������|����-�����|�����"
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

function main.menu.About()
--user.menuservice.names="�����"
--user.menuservice.on_select="user.About()"
--user.menuservice.title="splash_about"
--user.Refresh()
--if n == nil then return end
--else user.menuservice.names="��������|������|��������|� ��������|�����"
--     user.menuservice.on_select="user.Help(n)"
--     user.menuservice.title="splash_help"
--       user.Refresh()
--end
--end
    service("msgbox", {
                text=" �������� War System ����������� ��� ���������� � ������������� ������ TZOD by Anti_Killer. \n� �� �������� �������������� ����� ��������� ������� � �������, \n��� ������� ���������� ����������� ������. \n������ ��� ��� ������ ����� ����� � �� �������� ��� ��� ��� �����������. \n��� ���������� ���������� �� ����������� ������ ���� (zod.borda.ru) � ���� ��������. \n\n     War System: Ekivator Campaign                     Version 1 alpha \n                                   By Sl@v@98 and VIRUS" } )
end

function main.menu.BackHelp()
        main.menuservice.names="��������|������|��������|� ��������|�����"
        main.menuservice.on_select="main.menu.Help(n)"
        main.menuservice.title="splash_help"
		main.menu.section="help"
        main.menu.Refresh()
end
------------------------------------------------------------------------------------------
---------------------------------------�����----------------------------------------------
------------------------------------------------------------------------------------------

--*��� ���� -  ������������ PDA. ������������ �������� ����� ���������. ���� ����� ����� ���� �� �����. (31.10.10, Sl@v@98)
--*� ���� ����� ������� ������� ������� �����. ��� ��������� ����������� 1-�� ���������. (02.10.10, Sl@v@98)
--*����� ������! ������� ������� �����������! �������� ������ �������, ����� ������ ��������� �, ������� ���� ������ =) (08.10.10, Sl@v@98)
function main.menu.MailBox(n)
    if main.mail.letUseMail == 0 then
        service("msgbox", {text="\n����� �� �������� ��� ������� ����.\n" } )
    else
        if exists("mail_messagebox") == true then
            kill("mail_messagebox")
        end
        main.mail.botreduce = main.mail.botreduce or 1
        local mailNum
        if n~=nil then
            if n==1 then main.mail.botreduce=main.mail.botreduce-1
			elseif n==2 then main.mail.botreduce=main.mail.botreduce+1
            end
         end
        if main.mail.botreduce==0 then main.mail.botreduce=main.mail.botreduce+1
--      elseif main.mail.botreduce==1 then mailNum=1
--		elseif main.mail.botreduce==2 then mailNum=2
--		elseif main.mail.botreduce==3 then mailNum=3
--      elseif main.mail.botreduce==4 then mailNum=4
----    elseif main.mail.botreduce~=0 or main.mail.botreduce~=5 or main.mail.botreduce~=nil then mailNum=main.mail.botreduce
        elseif main.mail.botreduce==main.mail.maxValue + 1 then main.mail.botreduce=main.mail.botreduce-1
		else mailNum=main.mail.botreduce
        end
        main.mail.Message(mailNum)
        service("msgbox", {
                name="mail_messagebox", 
                text=main.mail.message,
                on_select="if n ~= 3 then main.menu.MailBox(n) end",
                option1="�����",
                option2="�����",
                option3="�������" } )
    end
end

function main.mail.Message(messageNum)
        print(messageNum)
        if messageNum == nil then return
        elseif messageNum > main.mail.letViewMessage then main.mail.message = "������ ���������"
        else
                if messageNum == 1 then main.mail.message="\n                              ��������� �1\n                        �� ����: ����� �� ������������ ����� \n                         ����: ���� ���-451 \n �����������, ������� ���� ����������!\n ��� ��� �� ���������� ����������� ���� ��� ������ ��������� �������.\n ���� ���-5 �������� ����� ����� ��������� ������������ ��� ������ �������.\n �� ����� ������������� ������ AI780, �������� ��������� ZIP-200,\n ������� ��� ����� TROO v6, ��������� �������� ��������� �������� QDM1,\n ����-5 (���������� ���������������� �������� ������),\n ���������� ��� ������ ������������ ������� � ���,\n � ����� ����� ����� ��� ��������� ������� ���������� ������� � �� ������.\n ������ ��� ���� �� �������� ��� �����������. \n ���� ��� � �����, �� ��������� � �������� ��������!"
                elseif messageNum == 2 then main.mail.message = "\n                              ��������� �2\n                        �� ����: ������� ���� \n                         ����: ���� ������� \n �����������, ������ ���. � ������� ����, ���� ��������� ����� ����������.\n � �����, �� ������ � �������������� ������� � � ����� �������� ����� ����. \n ��� ������� ��� �������� ������� �� ����� �������. \n ��� ������ �� ������ ������� ��� ��� ���-������ ����������, \n �������� � ���� �������������� ������ ��� ���. \n � ������ ������� ��������� ���������� ���������� ������� ����� ���������� \n � ��������� �� ���� ��� ����� �������. \n ��� ��������� �������� � ������� � ������� ����������.  \n ��� ����������� ������� ��������� ����� (����������� �������, ��������). " --����� ��� �� ������ ��� =D
                elseif messageNum == 3 then main.mail.message = "\n                              ��������� �3\n                        �� ����: �������, �������� ������� ���������, ����� \n                         ����: ���������\n �������� ���� ������! ���� �������� ��������� � ���� ������� �������� �����!\n � ����������� ������ ������������ � ���������! ��� �� ������� �������!\n ���� �������� ������������� � ���! ���� ���� ����������,\n �� ������ �������� ���������!"
--              elseif messageNum == 4 then main.mail.message = "\n                              ��������� �4\n                        �� ����: ������� ���� \n                         ����: ���������\n �����������, ���� ����������.\n ������ �����, �������, ��� ������� �������� ��������� � �������� ���.\n ����� ��������� ��������� �� ������ � ���!\n ����� � ����, � ������� 396, ���� ��������� ��������� �� ��� � �������\n � ����������� �������� �������. ���������, ��������� ��������� - ���������.\n ��� ��������� ��� ���������� � ����� ����� ������, ����� �� ���� ���������.\n ����� � ��� ������ �� ������ �������!\n �������� ���������� � ����������!"
                elseif messageNum == 4 then main.mail.message = "\n                                        ��������� �4\n                                  �� ����: Sl@v@98 � VIRUS \n                                   ����: �����������  \n�������, ��� ������ ����-������ �������� War System. \n �� � ����� ���������, � �� ��������, ��� �� ������ WS ��� ���������� � ������ � ����� ��������. \n � ����� ��������� � ���� �������� http://zod.borda.ru/?1-8-0-00000017-000-0-0-1288602334 \n �������: \n- Insert'� - �� ���� \n- Morse - �� ������ � �������� \n- AntiKiller'� - �� ����� ������ ���� � ������ � �������� \n ����� ������ ������ �������� �� ����������! \n                          VIRUS (����� ����, ��������, �����) � Sl@v@98 (��������, ��������, �����)."       
                end
        end
end

function main.mail.GetMail()
        pause(true)
        main.mail.letViewMessages = main.mail.letViewMessages + 1
		main.mail.maxValue = main.mail.maxValue + 1
        service("msgbox", {text="��� �� ����� ������ ���������. ������� esc ��� ���������.", on_select="pause(false)"})
end

------------------------------------------------------------------------------------------
---------------------------------------���������------------------------------------------
------------------------------------------------------------------------------------------

function main.menu.Inventory(n)
    main.menuservice.names = "��������|������|�����"
    main.menuservice.on_select = "main.menu.Inventory(n)"
    main.menuservice.title = "splash_gf"
    main.menu.section = "inventory"
    main.menu.Refresh()
    if n == nil then return end
        if n == 1 then main.menu.InventoryBoosts()
        elseif n == 2 then main.menu.InventoryWeapons()
        else main.menu.GameOpt()
    end
end

function main.menu.InventoryWeapons(n)
	local weap1 = main.player.weapon1 or ""
	local weap2 = main.player.weapon2 or ""
    service("msgbox", {
		name="msbox", 
		text="\n� ��� � ��������� �� ������ ������. \n\n�������������� ���������� ������: "..func.ConvertWeap(weap1).." \n����: "..func.ConvertWeap(weap2).." \n\n��� ������ ������������?", 
		on_select="if exists('player_weap') then kill('player_weap') end; if n==2 then func.EquipWeap('"..weap1.."', 'player_weap', '"..const.playername.."_tank'); main.player.weapon = '"..weap1.."' elseif n==1 then func.EquipWeap('"..main.player.weapon.."', 'player_weap', '"..const.playername.."_tank') elseif n==3 then func.EquipWeap('"..weap2.."', 'player_weap', '"..const.playername.."_tank'); main.player.weapon = '"..weap2.."' end",  
		option1 = "�����", 
		option2 = func.ConvertWeap(weap1), 
		option3 = func.ConvertWeap(weap2)})
end

function main.menu.InventoryBoosts(n)
	if main.inventory.letUseInventory == 1 then
		main.menuservice.names="���������(x"..main.inventory.numberBoo..")|����(x"..main.inventory.numberHealthPack..")|����(x"..main.inventory.numberMine..")|������|�����"
		main.menuservice.on_select="main.menu.InventoryBoosts(n)"
		main.menuservice.title="splash_inventory"
		main.menu.section="inv_boosts"
        main.menu.Refresh()
		if n == nil then return end
			if n == 1 then 
				main.inventory.UseBoo()
				main.menuservice.names="���������(x"..main.inventory.numberBoo..")|����(x"..main.inventory.numberHealthPack..")|����(x"..main.inventory.numberMine..")||������|�����"
				main.menu.Refresh()
			elseif n == 2 then 
				main.inventory.UseHealthPack()
				main.menuservice.names="���������(x"..main.inventory.numberBoo..")|����(x"..main.inventory.numberHealthPack..")|����(x"..main.inventory.numberMine..")||������|�����"
				main.menu.Refresh()
			elseif n == 3 then 
				main.inventory.UseMine()
				main.menuservice.names="���������(x"..main.inventory.numberBoo..")|����(x"..main.inventory.numberHealthPack..")|����(x"..main.inventory.numberMine..")||������|�����"
				main.menu.Refresh()
			else 
				main.menu.Inventory()
--				main.menuservice.names="�����|���������|�������|�����"
--				main.menuservice.on_select="main.menu.GameOpt(n)"
--				main.menuservice.title="splash_gf"
--				main.menu.Refresh()
		end
--            service("msgbox", {name="msbox", text="\n� ��� � ��������� �� ������ ������. \n\n�������������� ���������� ������: "..numberBoo.." \n����: "..numberHealthPack.." \n\n��� ������ ������������?", on_select="if n==1 then user.UseBoo() elseif n==2 then user.UseHealthPack() end",  option2="����", option3="�����", option1="���������"})
    elseif main.inventory.letUseInventory == 0 then   
        service("msgbox", {text="\n��������� �� �������� ��� ������� ����.\n"})
    end
end

function main.inventory.UseBoo()
    if main.inventory.numberBoo > 0 and main.inventory.activateBoo == 0 then --���� � ��� ���� �� � � ��� ��� ��������������, ��..
        main.inventory.activateBoo = 1 --..�� �����������.
                main.inventory.numberBoo = main.inventory.numberBoo - 1
        pushcmd( function() actor("pu_booster", 0, 0, {name="bonus_boo"}) end, 0.1)
        pushcmd( function() if exists("ourplayer_tank") then equip("ourplayer_tank", "bonus_boo") else if exists("bonus_boo") then kill("bonus_boo") main.inventory.activateBoo = 0  message("� ���� ������� �� ������ =)") end end end, 0.2)
        pushcmd( function() pause(true) service("msgbox", {text="\n�������������� ��������� �����������.\n", on_select="pause(false)"}) end, 0.3)
                pushcmd( function() message("����� ��������� ��������") end, 20.3)
        pushcmd( function() kill("bonus_boo") end, 21)
                pushcmd( function() main.inventory.activateBoo = 0 end, 22) --����� ��������� ��� ��������, �� ����� ����� �������� ���������.
        elseif main.inventory.activateBoo == 1 then --���� �� � ��� ��� �����������, ��..
                service("msgbox", {text="\n�������������� ��������� � ��� ��� �����������\n"}) --..�� ����������� =)
        else
        service("msgbox", {text="\n� ��� ��� ����������\n"})
        return main.inventory.numberBoo
    end
end


function main.inventory.UseHealthPack()
    if main.inventory.numberHealthPack > 0 then
        main.inventory.numberHealthPack = main.inventory.numberHealthPack - 1
        if exists("ourplayer_tank") then x, y = position("ourplayer_tank") end
            pushcmd( function() if exists("health")== false then actor("pu_health", x, y, { name="health" }) else end end, 0.1)
--          pushcmd( function() pause(true) end, 0.2)
            pushcmd( function() pause(true) service("msgbox", {text="\n���� �����������, ���� �������.\n", on_select="pause(false)"}) end, 1)
            pushcmd( function() if exists("health")== true  then kill("health") end end, 3)
        else
            service("msgbox", {text="\n� ��� ��� ����\n" } )
            return main.inventory.numberHealthPack
--          user.Refresh()
    end
end

function main.inventory.UseMine()
    if main.inventory.numberMine > 0 and main.inventory.activateMine == 0 then --���� � ��� ���� ���� � � ��� ��� ��������������, ��..
                main.inventory.numberMine = main.inventory.numberMine - 1
                main.inventory.activateMine = 1
                if exists("ourplayer_tank") then  x, y = position("ourplayer_tank") end
                        main.inventory.mineNum = main.inventory.mineNum + 1
                        actor("user_sprite", x, y, {
                                name="mine"..main.inventory.mineNum, 
                                texture="item_mine", } )
                        actor("trigger", x, y, {
                                name="mine_trig"..main.inventory.mineNum, 
                                only_human=1, 
                                on_leave="main.inventory.activateMine = 0; kill('mine'..main.inventory.mineNum); kill('mine_trig'..main.inventory.mineNum); actor('pu_mine',"..x..", "..y..", {on_pickup = 'func.MineDetonate(who)'})" } )
        elseif main.inventory.activateMine == 1 then --���� ��� � ��� ��� ������������, ��..
                service("msgbox", {text="\n�� ��� ��������� ����� ����\n" } ) --..�� ������������ =)
        else
                service("msgbox", {text="\n� ��� ��� ���\n" } )
        return main.inventory.numberMine
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

--������ ������ ����� ����� ��� ������?)). Slava98.
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
		local lp = rawget(main.levelpack, rawget(main.levelpacks, main.levelpack.botreduce))
		if type(lp) == "table" then 
			if lp.name~=nil then main.levelpack.text=lp.name else main.levelpack.text = "����������" end
			if lp.description~=nil then main.levelpack.text = main.levelpack.text.."\n��������: "..lp.description else main.levelpack.text = main.levelpack.text.."\n��� ��������" end
			if lp.type=="race" then main.levelpack.text = main.levelpack.text.."\n���: ������� ��������"
--			elseif lp.type==
			else main.levelpack.text = main.levelpack.text.."\n���: ��������� �������" 
			end
		end
	end
		service("msgbox", {
                	name="lp_messagebox", 
                	text=main.levelpack.text,
                	on_select="if n ~= 3 then main.menu.LevelPacks(n) else main.levelpack.default = rawget(main.levelpacks, main.levelpack.botreduce) end",
                	option1="�����",
                	option2="�����",
                	option3="�������" } )
end
------------------------------------------------------------------------------------------
-----------------------------------����������� �������------------------------------------
------------------------------------------------------------------------------------------

function main.menu.Refresh()
    if exists(main.menuservice.name) == true then
                main.menuservice.names=main.menuservice.names
        main.menuservice.open=1
        main.menuservice.open=1
    end
end

function main.menu.OpenCloseMenu()
    if exists(main.menuservice.name) == true then
        main.menuservice.open=1
    end
end

function main.menu.Demo()
        service("msgbox", {
                                text="��� ������� �� �������������.\n��������, ��� �������� \n� �������� ������."})
end