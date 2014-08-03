-- Скриптовые сцены первого уровня.

-- Функции разговора с поселенцем, открывающим дверь.
function level.screenplay.SettlerCall(action)
	if action == "speak" then
		func.NPC.StopWay("ourwarrior1")
		func.object.Speak("ourwarrior1_tank", {"map01", "settler_cutSceneSpeaks", 7})
		func.NPC.FollowWay("ourwarrior1", "settler_call")
	elseif action == "open" then
		func.MissionChange("extra", "change", func.Read({"map01", "missions", 3}))
		pset("c_trig", "active", 1)
		level.screenplay.playerCanRideToSettle = true;
		level.talk.settlerPart = 2;
		level.Door("sidedoor_open")
		for i = 1, 4 do object("ourwarrior"..i).nick = func.Read({"map01", "nicks", 1}); end;
        pushcmd(function() func.object.Speak("ourwarrior1_tank", {"map01", "settler_cutSceneSpeaks", 3}) end, 2)
        pushcmd(function() func.NPC.FollowWay("ourwarrior1", "base_patrol1") end, 3)
	elseif action == "angry_warrior" then
		func.MissionChange("extra", "add", func.Read({"map01", "missions", 2}))
		level.settlersAreEnemies = true;
        pushcmd(function() 
--			pset(const.playerName, "team", 2) -- Пока что следует замазать сие.
			for i = 1, 4 do pset("ourwarrior"..i, "level", 4) end
--			level.LetDamageOurWarrior(0)
		end, 2)
	end;
end

-- Экскаваторы и танк-робот.
function level.screenplay.Statue(event, num)
	if event == "damage" then
		if level.screenplay.statueIsDamaged then return; end;
		level.screenplay.statueIsDamaged = true;
		level.screenplay.excavatorsCanStare = false;
		kill("excstare_trig")
		for i = 1, 3 do
			func.ObjectPaste(level.objects["esc"..i])
			object("esc"..i.."_tank").playername = "esc"..i;
		end;
		func.ObjectPaste(level.objects.statue)
		object("statue_tank").playername = "statue";
		object("statue").on_die = "level.screenplay.Statue('destroy')"..object("statue").on_die;
		
		func.NPC.Attack("attack", "statue", object(const.playerVehName), 0.2)
		for i = 1, 3 do
			func.NPC.Attack("attack", "esc"..i, object(const.playerVehName), 0.2) -- Не нравится мне это. Slava98. 11.09.13.
--[[	for j = 1, 4 do
				print("esc"..i.."_tank_enemydetect_trig"..j..".link")
--				level.objects["esc"..i.."_tank_enemydetect_trig"..j].link.active = 1;
--				level.objects["esc"..i.."_tank_enemydetect_leavetrig"..j].link.active = 1;
				level.objects["esc"..i.."_tank_enemydetect_trig"..j].link.radius = 10; -- Увеличиваем радиус триггеров. Он очень большой.
				level.objects["esc"..i.."_tank_enemydetect_leavetrig"..j].link.radius = 15;
			end;]]
		end;
	elseif event == "creeper_boom" then
		level.functions["esc"..num.."BlewUp"] = true;
		func.GiveItem("bomb", "esc"..num)
		if exists("esc"..num) then message("boom!"); func.inventory.UseBomb("esc"..num); end;
	elseif event == "stare_on_player" then
		if not level.screenplay.excavatorsCanStare or level.screenplay.statueIsDamaged then return; end;
		local x1, y1 = position("esc"..num.."_tank");
		local x2, y2 = position(const.playerVehName);
		object("esc"..num.."_tank").rotation = func.GetRadians(x1, y1, x2, y2);
		pushcmd(function() level.screenplay.Statue("stare_on_player", num) end, 0.01)
	elseif event == "destroy" then
		if level.screenplay.missionBoo == 1 then if func.CheckOfLuck(math.random(5, 7)) then func.GiveItem("healthpack", "statue") end; end;
	end;
end

-- Скрипт взятия поселенцем ключ-карты.
function level.screenplay.SettlerGetKey(a)
	if a == "call" and level.screenplay.statueIsDamaged and level.screenplay.missionBoo == 1 and not level.screenplay.keyIsGot then
		main.NPC.list["ourwarrior1"].attackMode = "not_leave_position";
		main.NPC.list["ourwarrior1"].enemyDetectMode = false;
		object("ourwarrior1").team = 2;
		actor("trigger", 970, 909, {name="hidekeysettler_trig", on_enter="level.screenplay.SettlerGetKey('hide_settler')", radius=8, only_human=1})
		func.NPC.StopWay("ourwarrior1")
		setposition("ourwarrior1_tank", 800, 576)
		func.NPC.SetAim("ourwarrior1", 6, 34, true, {on_enter="level.screenplay.SettlerGetKey('return')"})
		kill("settlerkey_trig")
		if not exists("key1") then
			pushcmd(function() func.object.Speak("ourwarrior1_tank", {"map01", "settler_cutSceneSpeaks", 11}) end, 4)
			pushcmd(function() func.object.Speak("ourwarrior1_tank", {"map01", "settler_cutSceneSpeaks", 12}) end, 7)
		end;
	elseif a == "return" then
		func.NPC.SetAim("ourwarrior1", 26, 17, true, {on_enter="level.screenplay.SettlerGetKey('hide_settler')"})
	elseif a == "hide_settler" then
		-- Поселенец и ключ телепортируются туда, где они должны быть.
		if #main.NPC.list["ourwarrior1"].visibleEnemies ~= 0 then main.NPC.list["ourwarrior1"].visibleEnemies = {}; end;
		main.NPC.list["ourwarrior1"].attackMode = "chase";
		main.NPC.list["ourwarrior1"].enemyDetectMode = true;
		object("ourwarrior1").team = 1;
		setposition("ourwarrior1_tank", 1312, 352)
		level.screenplay.keyWasGot = true;
		func.NPC.FollowWay("ourwarrior1")
		kill("hidekeysettler_trig")
	end;
end

-- Речь поселенца около руин при условии, что Тестер ещё не был в поселении.
function level.screenplay.SettlerNearRuins(a)
	if a == "call" then
		setposition("ourwarrior5_tank", 900, 900)
		kill("settler_near_ruins_trig")
		level.screenplay.SettlerNearRuins("loop")
	elseif a == "loop" then
		local x, y = position("ourplayer_tank");
		func.NPC.SetAim("ourwarrior5", x - 64, y, "level.screenplay.SettlerNearRuins('talk')")
		pushcmd(function()
			if level.screenplay.ourwarrior5WasTalked ~= true then level.screenplay.SettlerNearRuins(a) end;
		end, 1)
	elseif a == "talk" then
		level.screenplay.ourwarrior5WasTalked = true;
		object("ourwarrior5").nick = func.Read("map01", "nicks", 8);
		level.RanonSpeak(2)
	elseif a == "goto_settle" then
		func.Message({"map01", "ranon", 21})
		func.NPC.SetWay("ourwarrior5", {{26, 33}, {26, 14}}, "level.screenplay.ranonIsNearSettle=true;", nil, nil, nil, true)
		actor("trigger", 780, 556 , {name="settler_near_ruins_goto_settle_trig", only_human=1, radius=4, active=1, only_visible=1, on_enter="if level.screenplay.ranonIsNearSettle then level.screenplay.SettlerNearRuins('near_settle_part1'); kill(self) end"})
	elseif a == "near_settle_part1" then
		kill("settler_near_ruins_goto_settle_trig")
		func.NPC.StopAction("ourwarrior1", 0)
		pushcmd(function() func.NPC.SetAim("ourwarrior1", 31, 17, "func.NPC.Action('ourwarrior1', nil, 955, 540, false); pushcmd(function() level.screenplay.SettlerNearRuins('near_settle_part2') end, 1)", true, "", false, true) end, 1)
	elseif a == "near_settle_part2" then
		object("ourwarrior5").nick = func.Read("map01", "nicks", 5);
		for i = 1, 6 do pushcmd(function() func.Message({"map01", "settler_and_unnamed_settler_dlg", i}) end, i*2-1) end
		pushcmd(function() 
			level.screenplay.playerMustPressPassword = true;
			object("d_trig").active = 1; -- На всякий случай.
			func.NPC.SetWay("ourwarrior5", {{28, 28}, {77, 28}}, "setposition('ourwarrior5_tank', 129, 1649); ai_march('ourwarrior5', 129, 1649)", nil, nil, nil, true) 
		end, 12)
	elseif a == "go_away" then
		func.NPC.SetWay("ourwarrior5", {{59, 34}, {27, 32}, {18, 18}, {3, 3}}, "setposition('ourwarrior5_tank', 129, 1649); ai_march('ourwarrior5', 129, 1649)", nil, nil, nil, true)
	elseif a == "attack_player" then
		func.GiveItem("boo", "ourwarrior5")
		func.UseItem("boo", "ourwarrior5")
		object("ourwarrior5").active = 1;
		object("ourwarrior5").team = 2;
		func.Message({"map01", "ranon", 27})
	elseif a == "show_boss" then
		func.NPC.Create("boss", func.Get32(77), func.Get32(34), 4, 2, 2, {skin="rebel_boss", class="boss1", nick=func.Read("map01", "nicks", 8)}, {currentWeap="weap_plazma"}, 2)
		func.NPC.SetAim("ourwarrior5", 74, 33, "level.screenplay.SettlerNearRuins('talk_with_boss')", nil, nil, nil, true)
	elseif a == "talk_with_boss" then
		object("ourwarrior5").nick = func.Read("map01", "nicks", 5);
		for i = 1, 11 do pushcmd(function() func.Message({"map01", "boss_and_ranon_dlg", i}) end, i*2-1) end;
		pushcmd(function() 
			level.screenplay.ourwarrior5WasTalked = false; -- Да-да, использую одну переменную для разных целей.
			func.NPC.SetAim("boss", 62, 28, "", nil, nil, nil, true)
			level.screenplay.SettlerNearRuins("loop_after_talking_with_boss")
		end, 22)
	elseif a == "loop_after_talking_with_boss" then
		local x, y = position("ourplayer_tank");
		func.NPC.SetAim("ourwarrior5", x + 64, y + 64, "level.screenplay.SettlerNearRuins('give_rocket')")
		pushcmd(function()
			if level.screenplay.ourwarrior5WasTalked ~= true then level.screenplay.SettlerNearRuins(a) end;
		end, 1)
	elseif a == "give_rocket" then
		level.screenplay.ourwarrior5WasTalked = true;
		func.Message({"map01", "boss_and_ranon_dlg", 12})
		func.EquipWeap("weap_rockets", const.playerName.."_weap", const.playerVehName)
		level.screenplay.SettlerNearRuins("go_away")
		message("Здесь приезжает отряд и он с игроком атакует базу.")
	end;
end

function level.screenplay.BanditsAttack(event)
	if event == "show" then
		func.NPC.Create("bandit1", 2253, 1427, 2, 3, 2, {class="rebel", skin="rebel_camouflage", nick=func.Read("map01", "nicks", 7)}, {currentWeap="weap_autocannon"}, {enemyDetectMode=false})
		func.NPC.Create("bandit2", 2153, 1527, 2, 3, 3, {class="rebel", skin="rebel", nick=func.Read("map01", "nicks", 7)}, {currentWeap="weap_minigun"}, {enemyDetectMode=false})
--		actor("trigger", 2241, 1666, {name="bandit_activate_trig", radius=20, only_human=1, only_visible=0, on_enter="kill('bandit_activate_trig'); level.screenplay.BanditsAttack('dialog1')"})
--		actor("trigger", 2241, 1666, {name="bandit_attack_trig", radius=10, only_human=1, only_visible=0, on_enter="kill('bandit_attack_trig'); level.screenplay.BanditsAttack('attack')"})
		func.GiveItem("mine", "bandit2", 4)
		if func.CheckOfLuck(math.random(5, 8)) then func.GiveItem("healthpack", "bandit1") end;
		pushcmd(function()
			for i = 1, 2 do 
			object("bandit"..i.."_tank").on_damage = "if not level.screenplay.banditsAttackedPlayer then level.screenplay.BanditsAttack('attack') end; "..object("bandit"..i.."_tank").on_damage; 
			object("bandit"..i).on_die= "level.screenplay.BanditsAttack('destroy'); "..object("bandit"..i).on_die;
			end;
		end, 2.1)
	elseif event == "dialog1" then
		if level.screenplay.banditsAttackedPlayer then return; end;
		func.Message({"map01", "bandits", 1})
		pushcmd(function() if not level.screenplay.banditsAttackedPlayer then func.Message({"map01", "bandits", 2}) end; end, 2)
		pushcmd(function() if not level.screenplay.banditsAttackedPlayer then func.Message({"map01", "bandits", 3}) end; end, 8)
		func.inventory.UseMine("bandit2")
		func.NPC.SetAim("bandit2", 2035, 1591, "level.screenplay.BanditsAttack('dialog2')")
	elseif event == "dialog2" then
		if level.screenplay.banditsAttackedPlayer then return; end;
		func.inventory.UseMine("bandit2")
		func.NPC.SetAim("bandit2", 2217, 1647, "level.screenplay.BanditsAttack('dialog3')")
	elseif event == "dialog3" then
		if level.screenplay.banditsAttackedPlayer then return; end;
		func.inventory.UseMine("bandit2")
		func.Message({"map01", "bandits", 4})
		func.NPC.SetAim("bandit2", 2317, 1547, "level.screenplay.BanditsAttack('dialog4')")
	elseif event == "dialog4" then
		if level.screenplay.banditsAttackedPlayer then return; end;
		func.inventory.UseMine("bandit2")
		func.Message({"map01", "bandits", 6})
		func.NPC.SetWay("bandit1", {{2255, 979}, {1442, 980}, {983, 904}, {519, 1071}})
		func.NPC.SetWay("bandit2", {{2213, 1174}, {1442, 1042}, {983, 1042}, {495, 908}})
		pushcmd(function() func.KillIfExists("bandit_attack_trig") end, 3)
		pushcmd(function()
			actor("trigger", 1387, 946, {name="bandit_ranon_attack_trig1", radius=14, only_human=1, only_visible=0, on_enter="level.screenplay.BanditsAttack('ranon_attack'); kill(self)"})
			actor("trigger", 754, 1386, {name="bandit_ranon_attack_trig2", radius=18, only_human=1, only_visible=0, on_enter="level.screenplay.BanditsAttack('ranon_attack'); kill(self)"})
		end, 5)
	elseif event == "attack" then
		level.screenplay.banditsAttackedPlayer = true;
		if object("ourwarrior5").active ~= 1 then level.HideRanon() end;
		func.Message({"map01", "bandits", 7})
		for i = 1, 2 do object("bandit"..i).active = 1; end;
		level.screenplay.BanditsAttack("attack_loop")
	elseif event == "attack_loop" then
		if exists("bandit1") or exists("bandit2") then
			func.Message({"map01", "bandits", math.random(8, 10)})
			pushcmd(function() level.screenplay.BanditsAttack("attack_loop") end, 10)
		end;
	elseif event == "ranon_attack" then
		if level.screenplay.ranonAttackedBandits then return; end;
		level.screenplay.ranonAttackedBandits = true;
		object("ourwarrior5").nick = func.Read("map01", "nicks", 1);
		func.NPC.SetAim("ourwarrior5", 389, 751, "func.GiveItem('boo', 'ourwarrior5'); func.UseItem('boo', 'ourwarrior5'); object('ourwarrior5').active = 1; level.screenplay.BanditsAttack('attack'); func.Message({'map01', 'settler_battlespeak', 1})")
	elseif event == "destroy" then
		pushcmd(function() 
			if not exists("bandit1") and not exists("bandit2") and exists("ourwarrior5") then
				if object("ourwarrior5").active == 1 then
					object("ourwarrior5").active = 0;
					func.GiveItem("healthpack", "ourwarrior5")
					func.UseItem("healthpack", "ourwarrior5")
					-- Если игрок подъедет к поселенцу, то он будет что-то говорить.
					pushcmd(function() func.NPC.SetWay("ourwarrior5", {{1328, 1007}, {2185, 1017}, {2474, 1050}}, "level.HideRanon()") end, 2)
				end;
			end;
		end)
	end;
end


-- Атака повстанцев. Нужно переделать, ибо не работает.
function level.screenplay.Attack(n)
	--Создаём врагов
	if n == nil then
		local enemy_positions = {{75, 38}, {70, 38}, {65, 38}, {61, 36}, {67, 36}}
		local enemy_weapons = {"rockets", "minigun", "minigun", "cannon", "cannon"}
		for i = 1, 4 do
			func.NPC.Create("enemy"..i, "", "Неизвестный войн", "boss1", "rebel", 2, "weap_"..enemy_weapons[i], 0, 1, func.Get32(enemy_positions[i][1]), func.Get32(enemy_positions[i][2]), 4--[[, true работает некоректно, лагает]]) 
		end
		func.NPC.Create("boss", "", "Неизвестный войн", "boss1", "rebel_boss", 2, "weap_plazma", 0, 2, func.Get32(77), func.Get32(34), 4--[[, true аналогично]]) 
	if level.screenplay.missoinboo == 3 and level.screenplay.missionKey == 0 and level.screenplay.wasEnemyAttack == 0 then level.screenplay.Attack("boss_gotobomb") end
	--Теперь делаем сценарий
	elseif n == "boss_gotobomb" then
		pushcmd(function()
			func.NPC.SetAim("boss", 70, 25, "level.screenplay.Attack('boss_setbomb')", true, "", false, true)
		end, 2)
		
	elseif n == "boss_setbomb" then
		actor("user_sprite", func.Get32(69), func.Get32(24), {name="boss_bomb", texture = "user/bomb"})
		pushcmd(function() func.NPC.Action("boss", "", 77, 33, true) end, 2)
		pushcmd(function() 
			local enemy_positions = {{73, 29}, {73, 22}, {64, 27}, {74, 25}}
			for i = 1, 4 do func.NPC.Action("enemy"..i, "", enemy_positions[i][1], enemy_positions[i][2], true) end
		end, 4)
		pushcmd(function() 
			kill("boss_bomb") 
			for i = 1, 2 do pset("destr_br"..i, "max_health", 1); func.Destroy("destr_br"..i) end
			level.screenplay.Attack("base_alert")
		end, 12)
	end
end

-- Не используется и не будет.
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