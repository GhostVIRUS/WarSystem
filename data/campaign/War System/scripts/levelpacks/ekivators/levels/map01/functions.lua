-- Функции первого уровня кампании ВС.
-- Отличается от screenplay.lua тем, что в нём содержатся функции, не имеющие прямого отношения к персонажам и скриптовым сценам.

-- Сначала должны идти функции, которые вызываются стандартными функциями ВС, и которые должны быть на каждом уровне.

-- Обработка события поднятия предмета.
function level.OnPickup(name, item, character)
	if level.screenplay.missionBoo == 1 and item == "battery" and character == const.playerName then
		local energyCells = main.characters[const.playerName].inventory.items.battery or 0;
--		level.screenplay.energyCells = level.screenplay.energyCells + 1; Думаю, следует сделать счётчик по батареям в инвентаре.
		func.Message(func.Read({"map01", "energycells", 1}, energyCells, {"map01", "energycells", energyCells + 1}))
		if energyCells == 4 then -- Если мы собрали все 4 батареи.
			func.MissionChange("extra", "complete", func.Read("map01", "missions", 5)) -- Миссия выполнена.
			pset("c_trig", "on_enter", "level.CommSpeak(1, 2)") -- Новый диалог командира.
			level.screenplay.missionBoo = 2; -- Новый этап миссии Бу.
			level.screenplay.BanditsAttack("show") -- Но нас уже поджидают бандиты.
		end;
	elseif level.screenplay.missinboo == 3 and item == "battery" and character == const.playerName then
-- Теперь мы собрали точно все батареи. Миссия Бу окончена!
	end;
	for i = 1, 5 do 
		if level.screenplay.missionBoo == 1 and item == "battery" and character == "ourwarrior"..i then
			level.functions.ourWarriorGotBoo = i; -- Если поселенец взял батарею, он нам её отдаст.
		end;
	end;
end

-- Обработка события активирования предмета.
function level.UseItem(character, item)
	if character == const.playerName then
		if item == "bomb_activated" then -- Если игрок использует бомбу в определённых точках уровня, она будет взрывать определённые стены.
			local x, y = position(object(const.playerName).vehname);
			local x1, y1 = func.UnGet32(x), func.UnGet32(y)
			if (x1 == 69 or x1 == 70) and (y1 == 40 or y1 == 41) then -- Стена к руинам.
				pushcmd(function() func.SetBomb("ruins_bomb", 70, 42, {"ruins_wall1", "ruins_wall2"}, main.characters[const.playerName].inventory.bombTime, true) end)
				return true;
			end;
			-- Стена к бустеру (написать).
		elseif item == "key" then
			local x, y = position(object(const.playerName).vehname);
			local x1, y1 = func.UnGet32(x), func.UnGet32(y)
			-- Разговор с Ороном (написать).
		end;
--[[elseif character == "esc1" or character == "esc2" or character == "esc3" then
		if item == "bomb" then -- Экскаваторы активируют бомбу на 0 секунд.
			temp.bombTimer = 0;
			return false;
		end;]]	
	end;
end

function level.SpeakToPlayer(npc, part)
	local speak;
	
	for i = 1, 4 do
		if npc == "ourwarrior"..i then speak = "settler";
		elseif npc == "ourenemy"..i then speak = "enemy";
		end;
	end;
	
	if speak == "settler" then
		if part == 1 then
			func.Message({"map01", "settler_speaks", math.random(8)})
		elseif part == 2 then
			func.Message({"map01", "settler_speaks", func.OrGate(math.random(2, 7), math.random(9, 10))})
		elseif part == 3 then
			func.Message({"map01", "settler_speaks", math.random(2, 10)})
		elseif part == 4 then
			func.Message({"map01", "settler_speaks", func.OrGate(math.random(3, 4), math.random(11, 14))})
		elseif part == 5 and npc == "ourwarrior5" then
			
		elseif part == 6 and npc == "ourwarrior1" then
		end;
	end;     
end

function level.SpeakToPlayer(npcName)
	local speak;

	for i = 1, 5 do
		if npcName == "ourwarrior"..i then speak = "settler";
		elseif npcName == "ourenemy"..i then speak = "enemy";
		end;
	end;

	if speak == "settler" then
		if npcName == "ourwarrior5" and level.screenplay.ranonAttackedBandits then
			func.object.Speak(object(npcName).vehname, {"map01", "settler_speaks", func.OrGate(math.random(6, 8), math.random(16, 17))})
			return;
		elseif npcName == "ourwarrior1" and level.screenplay.sidedoorStatus == 4 then
			func.object.Speak(object(npcName).vehname, {"map01", "settler_speaks", math.random(18, 19)})
			return;
		end;
		if level.talk.settlerPart == 1 then
			func.object.Speak(object(npcName).vehname, {"map01", "settler_speaks", math.random(2, 8)})
		elseif level.talk.settlerPart == 2 then
			func.object.Speak(object(npcName).vehname, {"map01", "settler_speaks", math.random(1, 8)})
		elseif level.talk.settlerPart == 3 then
			func.object.Speak(object(npcName).vehname, {"map01", "settler_speaks", math.random(2, 11)})
		elseif level.talk.settlerPart == 4 then
			func.object.Speak(object(npcName).vehname, {"map01", "settler_speaks", func.OrGate(math.random(2, 8), math.random(12, 15))})
		end;
	else
	end;
	
end

-- Обработка события смерти персонажей.
function level.OnDie(name)

end

-- Дальше идут функции, которые отвечают за различные механизмы на уровне.

-- Взаимодействие с дверьми на уровне.
function level.Door(action, silent)
	if action == "sidedoor_open" then -- Если нужно открыть дверь в поселение...
--		if level.functions.sidedoorStatus ~= 0 then return 0; end; -- Нужно, чтобы поселенцы смогли нормально проехать. Slava98. 12.06.14. 
--		if level.screenplay.halosHasGotBoo then level.Door("sidedoor_lagging") return; end;
		if level.functions.sidedoorStatus == 4 then pushcmd(function() level.Door("sidedoor_open") end, 3) end;
		level.functions.sidedoorStatus = 2;
        pushcmd(function()     
			func.Move("sidedoor_part1", 29, 17, true, 50)   
			func.Move("sidedoor_part2", 29, 18, true, 50) 
			if not silent then func.Sound("door") end;
		end, 1)
        pushcmd(function() 
			func.Move("sidedoor_part1", 29, 16, true, 50)
			func.Move("sidedoor_part2", 29, 19, true, 50)
			if not silent then func.Sound("door") end;
		end, 2)
        pushcmd(function()
			level.functions.sidedoorStatus = 1;
			if level.functions.tanksNearSettleNum < 1 then
				level.Door("sidedoor_close")
			end;
		end, 2.5)
		return 2.5;
--[[	pushcmd(function() 
			if level.functions.sidedoorStatus == 1 then
			level.Door("sidedoor_close") end 
		end, 5)]]
    elseif action == "sidedoor_close" then -- Если нужно закрыть дверь в поселение...
--		if level.functions.sidedoorStatus ~= 1 then return 0; end; -- Нужно, чтобы поселенцы смогли нормально проехать. Slava98. 12.06.14. 
		if level.functions.sidedoorStatus == 3 then pushcmd(function() level.Door("sidedoor_close") end, 3) end;
		level.functions.sidedoorStatus = 3;
        pushcmd(function()     
			func.Move("sidedoor_part1", 29, 17, true, 50)   
			func.Move("sidedoor_part2", 29, 18, true, 50) 
			if not silent then func.Sound("door") end;
		end, 1)
        pushcmd(function() 
			func.Move("sidedoor_part1", 28, 17, true, 50)  
			func.Move("sidedoor_part2", 28, 18, true, 50)
			if not silent then func.Sound("door") end;
		end, 2)
        pushcmd(function() 
			level.functions.sidedoorStatus = 0;
			if level.functions.tanksNearSettleNum > 0 then
				level.Door("sidedoor_open")
			end;
		end, 2.5)
--      pushcmd(function() pset("open_trig", "active", 1) --[[level.functions.sidedoorStatus = 2]] end, 3.5)
    elseif action == "sidedoor_lagging" then -- "Лагание" главной двери поселения.
		level.functions.sidedoorStatus = 4;
		pset("sidedoor_trig", "active", 0)
		pset("c_trig", "on_enter", "level.CommSpeak(1, 6)")
		func.NPC.StopAction("ourwarrior1", 0)
		pushcmd(function() func.NPC.SetAim("ourwarrior1", 30, 12, "func.Message({'map01', 'settler_dlg', 7})", true, "", false, true) end, 1)		
--  	pset("sidedoor_lag_trig", "active", 1)
--[[	level.screenplay.player_knows_that_door_is_close = true
		pset("c_trig", "active", 1)
        pushcmd(function() ai_march("ourwarrior1", 32*32, 16*32) end, 0.1)
        pushcmd(function() message("Поселенец: Похоже, дверь заглючило. Пока подождите здесь.") end, 2)
        pushcmd(function() func.ActionWarrior(1, 2) end, 3)]]
	--[[ Плазму нужно будет переписать потом, когда дойдем. VIRUS
    elseif action == "plazmadoor_open" then
        pushcmd( function() message("Код принят!") end, 1)
        pushcmd( function() sound("dr3") end, 2)
        pushcmd( function() moveY(19,4,1,"plasmadoor_part",3,6,1) end, 2)       
    elseif action == "plazmadoor_close" then
        pset("trig6", "active", 0)
        pset("plasmadoor_part1", "name", "br_ex1")
        pset("plasmadoor_part2", "name", "br_ex2")
        pset("plasmadoor_part3", "name", "br_ex3")
        pset("plasmadoor_part4", "name", "br_ex4")
        pushcmd( function() sound("dr3") end, 0.2)
        pushcmd( function() moveY(19,4,7,"br_ex",1,4,-1) end, 0.2) ]]     
    elseif action == "boodoor_open" and level.screenplay.missionBoo == 1 then -- Дверь к бустеру.
		if not silent then func.Sound("dr2_start") end;
		func.Message({"map01", "promt", 3})
		kill("boodoor_trig")
		pushcmd(function()
			func.Move("boodoor_part1", 23, 43, true, 50)  
			func.Move("boodoor_part2", 23, 44, true, 50)
			func.Move("boodoor_part3", 23, 45, true, 50)
			func.Move("boodoor_part4", 25, 43, true, 50)  
			func.Move("boodoor_part5", 25, 44, true, 50)  
			func.Move("boodoor_part6", 25, 45, true, 50) 
		end)
		pushcmd(function()
			func.Move("boodoor_part7", 23, 39, true, 50)  
			func.Move("boodoor_part1", 23, 40, true, 50)
			func.Move("boodoor_part2", 23, 41, true, 50)
			func.Move("boodoor_part3", 23, 42, true, 50)
			func.Move("boodoor_part8", 25, 49, true, 50)  
			func.Move("boodoor_part4", 25, 46, true, 50)  
			func.Move("boodoor_part5", 25, 47, true, 50)  
			func.Move("boodoor_part6", 25, 48, true, 50) 
		end, 3)
--			level.ShowMinigunTurrels() -- Вылезают турели.
--  elseif action == "trig_move" then
--          setposition("open_trig", 832, 540)
--          pushcmd(function() setposition("open_trig", 910, 540) end, 1)
--          pushcmd(function() level.Door("trig_move") end, 2)
	elseif action == "warehouse_open" then -- Дверь на  склад поселения. *Что-то мне не очень нравится, хотелось бы что-нибудь поэпичнее. Slava98. 25.08.13.
		local time = func.Move("warehouse_door1", 63, 17, true, 50)
		pushcmd(function() 
				func.Move("warehouse_door2", 62, 17, true, 50)
				func.Move("warehouse_door3", 62, 18, true, 50)
				end, time)
		pushcmd(function() 
				func.Move("warehouse_door1", 63, 16, true, 50)
				end, 2*time)
		pushcmd(function()
				func.Move("warehouse_door2", 63, 17, true, 50)
				end, 3*time)
		pushcmd(function()
				func.Move("warehouse_door3", 62, 17, true, 50)
				end, 4*time)
		pushcmd(function() 
				func.Move("warehouse_door2", 64, 17, true, 50)
				func.Move("warehouse_door3", 63, 17, true, 50)
				end, 5*time)
		pushcmd(function() 
				func.Move("warehouse_door2", 64, 16, true, 50)
				end, 6*time)
		pushcmd(function()
				func.Move("warehouse_door3", 64, 17, true, 50)
				end, 7*time)
		pushcmd(function() 
				func.Move("warehouse_door3", 65, 17, true, 50)
				end, 8*time)
		pushcmd(function() 
				func.Move("warehouse_door3", 65, 16, true, 50)
				end, 9*time)
        end;
end

-- Обработка события уничтожения ящика в поселении.
function level.OnDestroyCrateInTheSettle()
	if func.RandomBoolean() then
		local settler;
		if func.RandomBoolean() then settler = "ourwarrior1_tank"; else settler = "ourwarrior4_tank" end;
		func.object.Speak(settler, {"map01", "settler_cutSceneSpeaks", math.random(8, 10)})
	end;
end

function level.InfolinkOnDamage(name)
	if level.functions.infolinkHealth[name] <= 0 and exists("infolink_"..name) then
		local x, y = position("infolink_"..name);
		level.functions.infolinkHealth[name] = level.functions.infolinkHealth[name] - 1;
		kill("infolink_"..name)
		kill("infolink_"..name.."_trig")
		actor("pu_mine", x, y, {name="infolink_temp_mine"})
		actor("tank", x, y, {name="infolink_temp_tank", skin="null"})
		pushcmd(function() func.KillIfExists("infolink_temp_mine"); func.KillIfExists("infolink_temp_tank") end, 0.1)
		
		if name == "settle" then
		
		elseif name == "ruins" then
			level.Door("boodoor_open")
		elseif name == "tunnels" then
			message("Вы сломали кнопку. Ай-яй-яй...")
		end;
	else
		level.functions.infolinkHealth[name] = level.functions.infolinkHealth[name] - 1;
	end;
end

function level.HideRanon() 
	kill("ourwarrior5")
--[[setposition("ourwarrior5_tank", 149, 1649) -- Хотел сделать с этим нечто другое, но это слишком заморочно, поэтому просто уберу Ранона с карты.
	object("teleport_ranon_trig1").active = 1;
	object("teleport_ranon_trig1").on_enter = object("teleport_ranon_trig1").on_enter.."object('teleport_ranon_trig2').active=1;"
	actor("trigger", 1387, 946, {name="teleport_ranon_trig2", radius=14, active=0, only_human=1, only_visible=0, on_enter="setposition('ourwarrior5_tank', 149, 1649);object('teleport_ranon_trig2').active=0; object('teleport_ranon_trig1').active=1;"})
]]
end

-- Подготавливает уровень к квесту по сбору мусора.
function level.GetMissionBoo()
	func.MissionChange("extra", "complete", "")
	func.MissionChange("extra", "add", func.Read("map01", "missions", 4))
	level.screenplay.missionBoo = 1;

	pset("b1", "max_health", 150) --Как-то тут всё не совсем правильно. Но я пока не буду с этим заморачиваться. Slava98.
	pset("b2", "max_health", 150)
	pset("b1", "health", 150)
	pset("b2", "health", 150)	

	if exists("statue_tank") then object("statue_tank").max_health = 500; object("statue_tank").health = 500; end; -- У статуи сделаем рациональное количество жизней и даём ей в рот бустер. *Не даём. Рано ещё. Slava98. 25.08.13.

	kill("weapons_obj") -- Это тоже неплохо бы изменить.
	for i = 1, 3 do kill("powersheild4_obj"..i) end;

	pushcmd(function() pset("c_trig", "active", 1) end, 20)
end

-- Вылезающие турели при взятии батареи из секретного хранилища.
function level.HiddenTurretActivate()
	actor("turret_minigun", 923, 1529, {name = "hiddenturret1", dir = 4.71239})
	actor("turret_minigun", 460, 1529, {name = "hiddenturret2", dir = 4.71239})
end

-- Обработка события уничтожения генератора, питающего турели.
function level.OnDestroyGenerator()
	level.screenplay.ruinGeneratorIsActive = false;
	func.Message({"map01", "promt", 15})
	if exists("old_turret") then object("old_turret").team = 1; end;
	if exists("old_turret2") then object("old_turret2").team = 1; end;
end

-- Обработка события повреждения ракетной турели.
function level.OnDamageTurret()
	if not level.screenplay.oldTurretIsActive and level.screenplay.ruinGeneratorIsActive then 
		object("old_turret2").team = 2;
		func.Message({"map01", "promt", 10}) 
		level.screenplay.oldTurretIsActive = true; 
	end;
end


-- Неиспользующиеся функции.

function level.LetDamageOurWarrior(num)
    for i = 1, 4 do
        if num == nil then
                return false;
        elseif num == 0 and exists("ourwarrior"..i) then
--              pset("ourwarrior"..i.."_tank", "on_damage", "func.ExtraDamage(who, self)") -- А это что за бред? Slava98. 21.08.13.
--              pset("ourwarrior"..i.."_tank", "on_damage", "level.OurWarriorsAttackPlayer()") -- Что за тупость? Slava98.
        elseif num == 1 and exists("ourwarrior"..i) then
-- 		        pset("ourwarrior"..i.."_tank", "on_damage", "func.ExtraDamage(who, self);func.NPC.DamageOurWarrior(who, 'ourwarrior"..i.."')")
				if i ~= 3 then func.NPC.Action("ourwarrior"..i) else func.NPC.Action("ourwarrior3", nil, 2224, 64) end;
        end
    end
end

-- Следует полностью переделать. Оформить как одну из концовок ВС.
function level.Lose()
    level.WarriorsSetActive(0)
	level.LetDamageOurWarrior(1)
end


function level.OurWarriorsAttack(npc)
	level.WarriorsSetActive(1)--В любом случае поселенцы становятся активными. Slava98.
	level.LetDamageOurWarrior(0)
	if npc == "ourplayer" then
		level.functions.settlersAreEnemies = true
        if exists("ourwarrior3") then
                func.Message({"map01", "damagespeak", 4})
        else
                func.Message({"map01", "settler_speaks", 8})
        end
        object("ourplayer").team = 3;
        for i = 1, 4 do
                if exists("ourwarrior"..i.."_tank") then 
                        object("ourwarrior"..i).active = 1 
                        object("ourwarrior"..i.."_tank").on_damage = ""
                end
--              if npc == "ourwarrior"..i then
--                      object("ourwarrior"..i).active = 1
--              end
        end
	elseif npc == "ourwarrior3" then
		message("Поселенец: Ах ты, тупой командир!")
	elseif object(npc).team == 2 then
		message("Поселенец: ВРАГ! Убить его!")
	end
end

function level.IsSettleEnemyDead()
	if not exists(level.screenplay.settleEnemy) then for i = 1, 4 do func.NPC.Action("ourwarrior"..i) end end
	pushcmd(function() level.IsSettleEnemyDead() end, 1)
end

function level.WarriorsSetActive(act)
        for i = 1, 4 do
                if exists("ourwarrior"..i) and i~=3 then 
                        object("ourwarrior"..i).active = act
                        func.NPC.Action("ourwarrior"..i)
                end
        end
end


function level.CrazyHalos()
        object("ourwarrior3").team = 3
		object("ourwarrior3").active = 1
		if exists("halos_boo") then kill("halos_boo") end
		actor("pu_booster", 0, 0, {name="halos_boo"})
		if exists("ourwarrior3") then equip("ourwarrior3_tank", "halos_boo") end
        message("Халос: ААААААААААААААА!!!!!!!!!!!")
--      level.WarriorsSetActive(1)
end

-- Переписать всё полностью.
--[[function level.OnDie(name)
	if name == "ourwarrior3" and not level.screenplay.wasEnemyAttack then
		if object("ourwarrior3").team == 3 then
			level.WarriorsSetActive(0)
		else
			--level.EnemyAttack()
		end
		elseif name == const.playerName then 
			func.player.Die() 
        end
        for i = 1, 4 do
			if name == "ourwarrior"..i then kill(name) end
	end;
end]]

--Спавнит батарею по указанным координатам.
function level.ShowBoo(x, y, num)
	actor("user_sprite", x, y, {name="battery"..num, layer=10, animate=25, texture="pu_booster"})
	actor("trigger", x, y, {name="battery"..num.."_trig", only_human=1, radius=1, active=1, on_enter="level.GetBoo("..num..")"})
end

function level.PlayerDetect()
	if level.playerdetect_value ~= 0 then
		func.SetBorderTriggerToObject("ourplayer_tank", "", "for i=1,4 do if who ~= nil and who.playername ~= 'ourwarrior'..i and rawget(func.NPC.friends, 'ourwarrior'..i).is_in_settle == 0 then setposition('ourwarrior'..i..'_tank', 1490, 380) rawget(func.NPC.friends, 'ourwarrior'..i).is_in_settle == 1 end end", "center", 32, 20, 0, "", 1, 19)
		pushcmd(level.PlayerDetect, 1) 
	end;
end

function level.DoorRepairerCall()
	pushcmd(function()
		kill("saron1")
		for i = 1, 3 do kill("a"..i) end
		func.NPC.Create("door_repairer", "", "Ремонтник", "ekivator1", "eskavator", 1, "none", 1, 1, 1851, 51, 1.5708)
	end, 0.1)
	pushcmd(function() 
		func.NPC.SetAim("door_repairer", 55, 17, "func.NPC.Action('door_repairer', nil, 30, 18, true)", true, "", false, true)
	end, 2.5)
	pushcmd(function() 
		func.ObjectPaste(level.objects.saron1)
		func.ObjectPaste(level.objects.a1)
		func.ObjectPaste(level.objects.a2)
		func.ObjectPaste(level.objects.a3)
	end, 4)
end

--Not used
function level.IsEnemyInSettle()
	if exists("enemyinsettle_trig") then kill("enemyinsettle_trig") end
	if level.screenplay.enemyInSettle ~= 2 and level.screenplay.enemyInSettle ~= 0 then level.screenplay.enemyInSettle = 2 end
	actor("trigger", 1454, 335, {name="enemyinsettle_trig", only_human=0, radius=32, radius_delta=0, active=1, only_visible=0, on_enter="if who~=nil and object(who.playername).team~=1 and level.screenplay.enemyInSettle==0 then level.screenplay.enemyInSettle=1;level.screenplay.settleEnemy = who.name; level.WarriorsSetActive(1); level.LetDamageOurWarrior(0) end", on_leave="if who~=nil and object(who.playername).team~=1 and level.screenplay.enemyInSettle==1 then level.screenplay.enemyInSettle=2;--[[level.WarriorsSetActive(0); level.LetDamageOurWarrior(1)]] end"})
	if level.screenplay.enemyInSettle == 2 then
		print(level.screenplay.enemyInSettle)
		level.WarriorsSetActive(0)
		level.LetDamageOurWarrior(1)
		level.screenplay.enemyInSettle = 0
		level.WarriorsSetActive(0)
	end;
	pushcmd(function() level.IsEnemyInSettle() end, 0.1)
end

-- Устарело.
function level.GetBoo(num)
	if level.screenplay.missionBoo == 0 then return end
	func.Sound("energy")
	kill("battery"..num.."_trig")
	kill("battery"..num)
	level.screenplay.energyCells = level.screenplay.energyCells + 1;
	message(func.Read("map01", "energycells", 1)..level.screenplay.energyCells..func.Read("map01", "energycells", level.screenplay.energyCells + 1))
	if level.screenplay.missionBoo == 1 and level.screenplay.energyCells == 4 and num ~= 4 then
		func.MissionChange("extra", "complete", func.Read("map01", "missions", 5))
--		level.CommSpeak('exit') А какого, извините, хрена это здесь делает? Slava98. 28.03.13.
		pset("c_trig", "on_enter", "level.CommSpeak(1, 2)")
		level.screenplay.missionBoo = 2;
	elseif level.screenplay.missinboo == 3 and num == 4 then
		level.screenplay.missionBoo = 4;
	end
end
--[[
function level.screenplay.BombActivate()
	if not exists("ourplayer_tank") then return end
	local x1, y1 = position("ourplayer_tank")
	local x, y = func.UnGet32(x1), func.UnGet32(y1)
	if (x == 69 or x == 70) and (y == 40 or y == 41) then
		func.SetBomb("ruins_bomb", 70, 42, {"ruins_wall1", "ruins_wall2"}, 10, true)
	else
		service("msgbox", {text="\nЗдесь нельзя поставить бомбу.\n"})
	end
end]]

function level.screenplay.KeyActivate()
	if a == a then
	else
		service("msgbox", {text="\nКлюч-карта здесь бесполезна.\n"})
	end
end

function level.screenplay.BatteryActivate()
	if a == a then
	else
		service("msgbox", {text="\nНевозможно здесь применить батарею.\n"})
	end
end