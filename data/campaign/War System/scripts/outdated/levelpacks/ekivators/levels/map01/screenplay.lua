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
		object("esc"..num.."_tank").dir = func.GetRadians(x1, y1, x2, y2);
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
	print("| level.screenplay.SettlerNearRuins(\""..a.."\")")
	if a == "call" then
		setposition("ourwarrior5_tank", 900, 900)
		kill("settler_near_ruins_trig")
		level.screenplay.SettlerNearRuins("loop")
	elseif a == "loop" then
		local x, y = position("ourplayer_tank");
		func.NPC.SetAim("ourwarrior5", x - 64, y, false, {on_enter="level.screenplay.SettlerNearRuins('talk')"})
		pushcmd(function()
			if level.screenplay.ourwarrior5WasTalked ~= true then level.screenplay.SettlerNearRuins(a) end;
		end, 1)
	elseif a == "talk" then
		level.screenplay.ourwarrior5WasTalked = true;
		object("ourwarrior5").nick = func.Read({"map01", "nicks", 8});
		level.RanonSpeak(2)
	elseif a == "goto_settle" then
		func.object.Speak("ourwarrior5_tank", {"map01", "ranon", 21})
		func.way.Create("ranon_goto_settle", {{26, 33}, {26, 14}}, true, {onEnterFunc="level.screenplay.ranonIsNearSettle=true;"})
		func.NPC.FollowWay("ourwarrior5", "ranon_goto_settle")
		actor("trigger", 808, 741, {name="check_ranon", radius=4, on_enter="if who and who.name == 'ourplayer5_tank' then level.screenplay.ranonIsNearSettle=true; kill(self) end"})
		actor("trigger", 780, 556, {name="settler_near_ruins_goto_settle_trig", only_human=1, radius=4, active=1, only_visible=1, on_enter="if level.screenplay.ranonIsNearSettle then level.screenplay.SettlerNearRuins('near_settle_part1'); kill(self) end"})
	elseif a == "near_settle_part1" then
		func.NPC.StopWay("ourwarrior1")
		pushcmd(function() func.NPC.SetAim("ourwarrior1", 31, 17, true, {on_enter="func.NPC.SetAim('ourwarrior1', 955, 540, false, {}); pushcmd(function() level.screenplay.SettlerNearRuins('near_settle_part2') end, 1)"}, true) end, 1)
	elseif a == "near_settle_part2" then
		object("ourwarrior5").nick = func.Read({"map01", "nicks", 5});
		pushcmd(function() func.object.Speak("ourwarrior1_tank", {"map01", "settler_and_unnamed_settler_dlg", 1}, 1) end, 1)
		pushcmd(function() func.object.Speak("ourwarrior5_tank", {"map01", "settler_and_unnamed_settler_dlg", 2}, 1) end, 2.5)
		pushcmd(function() func.object.Speak("ourwarrior1_tank", {"map01", "settler_and_unnamed_settler_dlg", 3}, 1) end, 4)
		pushcmd(function() func.object.Speak("ourwarrior5_tank", {"map01", "settler_and_unnamed_settler_dlg", 4}, 2) end, 5.5)
		pushcmd(function() func.object.Speak("ourwarrior1_tank", {"map01", "settler_and_unnamed_settler_dlg", 5}, 2) end, 7)
		pushcmd(function() func.object.Speak("ourwarrior5_tank", {"map01", "settler_and_unnamed_settler_dlg", 6}, 3) end, 9.5)
		pushcmd(function()
			level.screenplay.playerMustPressPassword = true;
			object("d_trig").active = 1; -- На всякий случай.
			func.way.Create("ranon_goto_somewhere", {{28, 28}, {77, 28}}, true, {onEnterFunc="setposition('ourwarrior5_tank', 129, 1649); ai_march('ourwarrior5', 129, 1649)"})
			func.NPC.FollowWay("ourwarrior5", "ranon_goto_somewhere")
		end, 10)
	elseif a == "go_away" then
		level.screenplay.ourwarrior5WasTalked = false;
		func.way.Create("ranon_go_away", {{59, 34}, {27, 32}, {18, 18}, {3, 3}}, true, {onEnterFunc="setposition('ourwarrior5_tank', 129, 1649); ai_march('ourwarrior5', 129, 1649)"})
		func.NPC.FollowWay("ourwarrior5", "ranon_go_away")
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
		func.NPC.Create("bandit1", 2253, 1427, 2, 3, 2, {class="rebel", skin="rebel_camouflage", nick=func.Read({"map01", "nicks", 7})}, {currentWeap="weap_autocannon"}, {enemyDetectMode=false})
		func.NPC.Create("bandit2", 2153, 1527, 2, 3, 3, {class="rebel", skin="rebel", nick=func.Read({"map01", "nicks", 7})}, {currentWeap="weap_minigun"}, {enemyDetectMode=false})
		actor("trigger", 2241, 1666, {name="bandit_activate_trig", radius=20, only_human=1, only_visible=0, on_enter="kill('bandit_activate_trig'); level.screenplay.BanditsAttack('dialog1')"})
		actor("trigger", 2241, 1666, {name="bandit_attack_trig", radius=10, only_human=1, only_visible=0, on_enter="kill('bandit_attack_trig'); level.screenplay.BanditsAttack('attack')"})
		func.GiveItem("mine", "bandit2", 4)
		if func.CheckOfLuck(math.random(5, 8)) then func.GiveItem("healthpack", "bandit1") end;
		pushcmd(function()
			for i = 1, 2 do 
				object("bandit"..i.."_tank").on_damage = "if not level.screenplay.banditsAttackedPlayer then level.screenplay.BanditsAttack('attack') end; "..object("bandit"..i.."_tank").on_damage; 
				object("bandit"..i).on_die= "level.screenplay.BanditsAttack('destroy'); "..object("bandit"..i).on_die;
			end;
		end, 2.2)
	elseif event == "dialog1" then
		if level.screenplay.banditsAttackedPlayer then return; end;
		func.object.Speak("bandit1_tank", {"map01", "bandits", 1}, 2)
		pushcmd(function() if not level.screenplay.banditsAttackedPlayer then func.object.Speak("bandit1_tank", {"map01", "bandits", 2}, 2) end; end, 2.1)
		pushcmd(function() if not level.screenplay.banditsAttackedPlayer then func.object.Speak("bandit1_tank", {"map01", "bandits", 3}, 2) end; end, 10)
		func.inventory.UseMine("bandit2")
		func.NPC.SetAim("bandit2", 2035, 1591, false, {on_enter="level.screenplay.BanditsAttack('dialog2')"})
	elseif event == "dialog2" then
		if level.screenplay.banditsAttackedPlayer then return; end;
		func.inventory.UseMine("bandit2")
		func.NPC.SetAim("bandit2", 2217, 1647, false, {on_enter="level.screenplay.BanditsAttack('dialog3')"})
	elseif event == "dialog3" then
		if level.screenplay.banditsAttackedPlayer then return; end;
		func.inventory.UseMine("bandit2")
		func.object.Speak("bandit1_tank", {"map01", "bandits", 4}, 2)
		func.NPC.SetAim("bandit2", 2317, 1547, false, {on_enter="level.screenplay.BanditsAttack('dialog4')"})
	elseif event == "dialog4" then
		if level.screenplay.banditsAttackedPlayer then return; end;
		func.inventory.UseMine("bandit2")
		func.object.Speak("bandit2_tank", {"map01", "bandits", 6}, 2)
		func.way.Create("bandit1_way", {{2255, 979}, {1442, 980}, {983, 904}, {519, 1071}}, false, {})
		func.way.Create("bandit2_way", {{2213, 1174}, {1442, 1042}, {983, 1042}, {495, 908}}, false, {})
		func.NPC.FollowWay("bandit1", "bandit1_way")
		func.NPC.FollowWay("bandit2", "bandit2_way")
		pushcmd(function() func.KillIfExists("bandit_attack_trig") end, 3)
		pushcmd(function()
			actor("trigger", 1387, 946, {name="bandit_ranon_attack_trig1", radius=14, only_human=1, only_visible=0, on_enter="level.screenplay.BanditsAttack('ranon_attack'); kill(self)"})
			actor("trigger", 754, 1386, {name="bandit_ranon_attack_trig2", radius=18, only_human=1, only_visible=0, on_enter="level.screenplay.BanditsAttack('ranon_attack'); kill(self)"})
		end, 5)
	elseif event == "attack" then
		level.screenplay.banditsAttackedPlayer = true;
		if object("ourwarrior5").active ~= 1 then level.HideRanon() end;
		func.object.Speak("bandit2_tank", {"map01", "bandits", 7})
		for i = 1, 2 do object("bandit"..i).active = 1; end;
		level.screenplay.BanditsAttack("attack_loop")
	elseif event == "attack_loop" then
		if exists("bandit1") then func.object.Speak("bandit1_tank", {"map01", "bandits", math.random(8, 10)}) end
		if exists("bandit2") then func.object.Speak("bandit2_tank", {"map01", "bandits", math.random(8, 10)}) end
		if exists("bandit1") or exists("bandit2") then
			pushcmd(function() level.screenplay.BanditsAttack("attack_loop") end, 10)
		end;
	elseif event == "ranon_attack" then
		if level.screenplay.ranonAttackedBandits then return; end;
		level.screenplay.ranonAttackedBandits = true;
		object("ourwarrior5").nick = func.Read({"map01", "nicks", 1});
		func.NPC.SetAim("ourwarrior5", 389, 751, false, {on_enter="func.GiveItem('boo', 'ourwarrior5'); func.UseItem('boo', 'ourwarrior5'); object('ourwarrior5').active = 1; level.screenplay.BanditsAttack('attack'); func.Message({'map01', 'settler_battlespeak', 1})"})
	elseif event == "destroy" then
		pushcmd(function() 
			if not exists("bandit1") and not exists("bandit2") and exists("ourwarrior5") then
				if object("ourwarrior5").active == 1 then
					object("ourwarrior5").active = 0;
					func.GiveItem("healthpack", "ourwarrior5")
					func.UseItem("healthpack", "ourwarrior5")
					-- Если игрок подъедет к поселенцу, то он будет что-то говорить.
					pushcmd(function()
						func.way.Create("ranon_hide_way", {{1328, 1007}, {2185, 1017}, {2474, 1050}}, false, {onEnterFunc="level.HideRanon()"})
						func.NPC.FollowWay("ourwarrior5", "ranon_hide_way")
					end, 2)
				end;
			end;
		end)
	end;
end

function level.screenplay.DoorRepairerCall()
	level.UpLaserOpen()

	func.NPC.Create("tech", 1851, 51, 1.5708, 1, 1, {class="ekivator1", skin="eskavator", nick=func.Read({"map01", "nicks", 10})}, {faction="uew", rank=2, group="settlers"}, {})
	pushcmd(function() 
		func.NPC.SetAim("tech", 55, 18, true, {on_enter="ai_march('tech', func.Get32(30), func.Get32(18))"})
	end, 2.5)
	pushcmd(function()
		func.object.Speak("tech_tank", {"map01", "tech", 1})
	end, 3)
end

-- Атака повстанцев. Нужно переделать, ибо не работает.
function level.screenplay.Attack(n)
	--Создаём врагов
	level.screenplay.isEnemyAttack = true
	if n == nil then
		local enemy_positions = {{75, 21}, {76, 25}, {77, 29}, {73, 36}, {70, 39}, {16, 35}, {21, 36}}
		local enemy_weapons = {"rockets", "minigun", "minigun", "cannon", "cannon", "cannon", "minigun"}
		local enemy_teams = {1, 2, 3, 4, 5, 1, 2, 3}
		local enemy_dirs = {2.36442, 2.91511, 3.35157, 3.35157, 4.40842, 5.14438, 5.54086}
		local enemy_ways = {"right_invasion_way", "right_invasion_way", "right_invasion_way", "left_invasion_way", "left_invasion_way", "left_invasion_way", "left_invasion_way"}
		for i = 1, 7 do
			pushcmd(function() 
				func.NPC.Create("enemy"..i, func.Get32(enemy_positions[i][1]), func.Get32(enemy_positions[i][2]), enemy_dirs[i], 2, enemy_teams[i], {class="rebel", skin="rebel", nick=func.Read({"map01", "nicks", 8})}, {faction="rebels", rank=1, group="attackers", currentWeap="weap_"..enemy_weapons[i]}, {mainWay=enemy_ways[i]})
			end, i*1)
		end
		func.NPC.Create("boss", func.Get32(77), func.Get32(34), 4, 2, 5, {class="boss1", skin="rebel_boss", nick=func.Read({"map01", "nicks", 8})}, {faction="rebels", rank=2, group="attackers", currentWeap="weap_plazma"}, {})

		-- Потом сделаю зависимость от удачи. Slava98. 01.03.15.
		pushcmd(function() 
			for i = 1, 7 do func.GiveItem("healthpack", "enemy"..i) end
			func.GiveItem("healthpack", "boss", 2)
			func.GiveItem("boo", "boss")
			func.GiveItem("boo", "enemy7")
		end, 10)
		
		object("vil_turett1").sight = 0
		object("vil_turett2").sight = 0
		object("vil_turret3").sight = 0
		
		func.way.Create("left_invasion_way", {{24, 18}, {32, 10}, {44, 10}, {55, 6}}, true, {})
		func.way.Create("right_invasion_way", {{60, 15}, {60, 8}}, true, {})

		pushcmd(function() level.screenplay.Attack("enemies_go_to_positions") end, 10)
		pushcmd(function() level.screenplay.Attack("settler_and_commandier_dialog1") end, 20)
	elseif n == "enemies_go_to_positions" then
		ai_march("enemy1", func.Get32(73), func.Get32(22))
		ai_march("enemy2", func.Get32(64), func.Get32(27))
		ai_march("enemy3", func.Get32(58), func.Get32(28))
		func.way.Create("enemy4_way", {{56, 31}, {30, 34}, {23, 24}, {20, 18}}, true, {killAfterEnter=true})
		func.NPC.FollowWay("enemy4", "enemy4_way")
		ai_march("enemy5", func.Get32(42), func.Get32(30))
		ai_march("enemy6", func.Get32(24), func.Get32(15))
		ai_march("enemy7", func.Get32(33), func.Get32(25))
		func.way.Create("boss_way1", {{56, 31}, {30, 34}, {23, 24}, {26, 18}}, true, {onEnterFunc="level.screenplay.Attack('boss_setbomb1')", killAfterEnter=true})
		func.NPC.FollowWay("boss", "boss_way1")
	elseif n == "boss_setbomb1" then
		actor("user_sprite", func.Get32(28), func.Get32(18), {name="boss_bomb1", texture = "user/bomb", layer=11})
		func.way.Create("boss_way2", {{26, 18}, {23, 24}, {30, 34}, {56, 31}, {73, 28}, {70, 24}}, true, {onEnterFunc="level.screenplay.Attack('boss_setbomb2')", killAfterEnter=true})
		func.NPC.FollowWay("boss", "boss_way2")
		pushcmd(function()
			func.object.Speak("tech_tank", {"map01", "tech", 2}, 1.5)
		end, 1)
		pushcmd(function()
			func.object.Speak("tech_tank", {"map01", "tech", 3}, 2)
		end, 5)
		pushcmd(function()
			func.object.Speak("ourwarrior1_tank", {"map01", "tech", 4}, 2)
		end, 6)
		pushcmd(function() 
			kill("boss_bomb1")
			kill("sidedoor_part1")
			kill("sidedoor_part2")
			kill("door_wall1")
			kill("door_wall2")
			func.Destroy("tech_tank")
			func.Explosion(func.Get32(28), func.Get32(16))
			pushcmd(function() func.Explosion(func.Get32(28), func.Get32(19)) end, 0.2)
			level.screenplay.Attack("boss_cries_loop")
			level.screenplay.Attack("halos_cries_loop")
			level.screenplay.Attack("base_alert1")
		end, 10)
	elseif n == "boss_setbomb2" then
		actor("user_sprite", func.Get32(68), func.Get32(23), {name="boss_bomb2", texture = "user/bomb", layer=11})
		func.way.Create("boss_way3", {{60, 34}, {49, 32}, {48, 28}}, true, {onEnterFunc="", killAfterEnter=true})
		func.NPC.FollowWay("boss", "boss_way3")
		pushcmd(function()
			kill("boss_bomb2")
			for i = 1, 7 do kill("warehouse_wall"..i) end
			func.Explosion(func.Get32(67), func.Get32(24))
			pushcmd(function() func.Explosion(func.Get32(68), func.Get32(23)) end, 0.2)
			pushcmd(function() func.Explosion(func.Get32(69), func.Get32(22)) end, 0.4)
			level.screenplay.Attack("base_alert2")
		end, 10)
	elseif n == "base_alert1" then
		func.object.Speak("boss_tank", {"map01", "boss_cries", 4})
		func.object.Speak("ourwarrior3_tank", {"map01", "halos_cries", 4})
		object("enemy4").active = 1
		object("enemy6").active = 1
		object("ourwarrior1").active = 1
		object("ourwarrior4").active = 1
		func.UseItem("boo", "ourwarrior4")
		actor("trigger", func.Get32(59), func.Get32(7), {name="check_enemies", radius=6, only_human=0, on_enter="for i = 1, 7 do if who and (who.name == 'enemy'..i..'_tank' or who.name == 'boss_tank') then level.screenplay.Attack('call_halos') kill(self) end end"})
		level.screenplay.Attack("check_enemies_loop")
		level.screenplay.Attack("check_warriors_loop")
		pushcmd(function() 
			ai_march("enemy7", func.Get32(26), func.Get32(19)) 
		end, 25)
		pushcmd(function() 
			object("enemy7").active = 1
			func.UseItem("boo", "enemy7")
			ai_march("enemy5", func.Get32(33), func.Get32(25))			
		end, 27)
		pushcmd(function() 
			ai_march("enemy5", func.Get32(26), func.Get32(19)) 
		end, 50)
		pushcmd(function() 
			object("enemy5").active = 1			
		end, 52)
	elseif n == "base_alert2" then
		func.object.Speak("ourwarrior2_tank", {"map01", "settler_cutSceneSpeaks", 13})
		object("ourwarrior2").active = 1
		ai_march("enemy1", func.Get32(66), func.Get32(19))
		ai_march("enemy2", func.Get32(64), func.Get32(20))
		ai_march("enemy3", func.Get32(73), func.Get32(21))
		ai_march("boss", func.Get32(65), func.Get32(26))	
		pushcmd(function() 
			object("enemy1").active = 1
			object("enemy2").active = 1	
		end, 3)
		pushcmd(function() 
			ai_march("enemy3", func.Get32(63), func.Get32(17))
			ai_march("enemy3", func.Get32(63), func.Get32(19)) 
		end, 25)
		pushcmd(function() 
			object("enemy3").active = 1
			object("boss").active = 1
			func.UseItem("boo", "boss")			
		end, 30)
	elseif n == "boss_cries_loop" then
		if not exists("boss") then return; end;
		if not level.screenplay.battleLastWave then
			pushcmd(function()
				local n = math.random(1, 7)
				func.object.Speak("boss_tank", {"map01", "boss_cries", n})
				level.screenplay.Attack("boss_cries_loop")
			end, 7)
		else
			pushcmd(function()
				local n = math.random(4, 7)
				func.object.Speak("boss_tank", {"map01", "boss_cries", n})
				level.screenplay.Attack("boss_cries_loop")
			end, 6)
		end
	elseif n == "halos_cries_loop" then
		if not exists("ourwarrior3") then return; end;
		if not level.screenplay.enemiesAreTooClose then
			pushcmd(function()
				local n = math.random(2, 5)
				func.object.Speak("ourwarrior3_tank", {"map01", "halos_cries", n})
				level.screenplay.Attack("halos_cries_loop")
			end, 7)
		end
	elseif n == "call_halos" then
		level.screenplay.enemiesAreTooClose = true
		object("ourwarrior3").active = 1
		func.UseItem("boo", "ourwarrior3")
		
		local n = math.random(6, 7)
		func.object.Speak("ourwarrior3_tank", {"map01", "halos_cries", n})
	elseif n == "check_enemies_loop" then
		if not exists("enemy1") and not exists("enemy2") and not exists("enemy3") and not exists("enemy4") and not exists("enemy5") and not exists("enemy6") and not exists("enemy7") and not exists("boss") then
			for i = 1, 4 do
				if exists("ourwarrior"..i) then
					object("ourwarrior"..i).active = 0
					func.NPC.FollowWay("ourwarrior"..i, main.NPC.list["ourwarrior"..i].mainWay)
					pset("c_trig", "on_enter", "level.CommSpeak(2, 11)")
				end
			end
		end
		pushcmd(function() level.screenplay.Attack("check_enemies_loop") end, 0.1)
	elseif n == "check_warriors_loop" then
		if not level.screenplay.isEnemyAttack then return end
		if not exists("ourwarrior1") and not exists("ourwarrior4") then
			if exists("enemy4") then object("enemy4").active = 0; ai_march("enemy4", func.Get32(54), func.Get32(5)) end
			if exists("enemy5") then object("enemy5").active = 0; ai_march("enemy5", func.Get32(55), func.Get32(11)) end
			if exists("enemy6") then object("enemy6").active = 0; ai_march("enemy6", func.Get32(54), func.Get32(5)) end
			if exists("enemy7") then object("enemy7").active = 0; ai_march("enemy7", func.Get32(55), func.Get32(16)) end
		end
		if not exists("ourwarrior2") then
			if exists("enemy1") then ai_march("enemy1", func.Get32(60), func.Get32(9)) end
			if exists("enemy2") then ai_march("enemy2", func.Get32(57), func.Get32(10)) end
			if exists("enemy3") then ai_march("enemy3", func.Get32(60), func.Get32(6)) end
		end
		pushcmd(function() level.screenplay.Attack("check_warriors_loop") end, 0.1)
	elseif n == "settler_and_commandier_dialog1" then
		func.NPC.StopWay("ourwarrior2")
		func.NPC.SetAim("ourwarrior2", 63, 3, true, {on_enter="level.screenplay.Attack('settler_and_commandier_dialog2')"})
	elseif n == "settler_and_commandier_dialog2" then
		pushcmd(function() func.object.Speak("ourwarrior2_tank", {"map01", "settler_and_commandier_dlg", 1}, 1.1) end, 1)
		pushcmd(function() func.object.Speak("ourwarrior3_tank", {"map01", "settler_and_commandier_dlg", 2}, 1) end, 3)
		pushcmd(function() func.object.Speak("ourwarrior2_tank", {"map01", "settler_and_commandier_dlg", 3}, 2.5) end, 5)
		pushcmd(function() func.object.Speak("ourwarrior3_tank", {"map01", "settler_and_commandier_dlg", 4}, 1) end, 7)
		pushcmd(function() func.object.Speak("ourwarrior3_tank", {"map01", "settler_and_commandier_dlg", 5}, 2.5) end, 10)
		pushcmd(function() level.screenplay.Attack("warriors_go_to_positions") end, 11)
	elseif n == "warriors_go_to_positions" then
		func.NPC.StopWay("ourwarrior1")
		func.NPC.StopWay("ourwarrior4")
		ai_march("ourwarrior1", func.Get32(30), func.Get32(13))
		ai_march("ourwarrior2", func.Get32(58), func.Get32(18))
		ai_march("ourwarrior4", func.Get32(35), func.Get32(19))
	
--[[	if level.screenplay.missoinboo == 3 and level.screenplay.missionKey == 0 and level.screenplay.wasEnemyAttack == 0 then level.screenplay.Attack("boss_gotobomb") end
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
		end, 12)]]
	end
end