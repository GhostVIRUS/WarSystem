function level.CallTerminal()
	func.dialog.Show("terminals", "map01", 3, "", "if n==1 then level.SettlerCall('speak') kill('d_trig') end", func.dialog.Read("terminals", "map01", 1), func.dialog.Read("terminals", "map01", 2))
end

function level.SettlerCall(action)
	if action == "speak" then
		func.NPC.StopAction("ourwarrior1", 0)
        if level.unnamed_dead==1 then level.SettlerSpeak("on_dead_unnamed")
        else
                message (func.dialog.Read("promt", "map01", 2))
--              pushcmd(function() func.NPC.Action("ourwarrior1", nil, 31, 17, true) end, 0.1)
				pushcmd(function() func.NPC.SetAim("ourwarrior1", 31, 17, "func.NPC.Action('ourwarrior1', nil, 955, 540, false); pushcmd(function() level.SettlerSpeak('hello') end, 1)", true, "", false, true) end, 0.1)
        end	
	elseif action == "open" then
		func.MissionChange("extra", "change", func.dialog.Read("missions", "map01", 3))
		pset("c_trig", "active", 1)
		func.NPC.StopAction("ourwarrior1", 1)
		level.door_boolean = true
		level.screenplay.sidedoor_status = 0
		level.Door("sidedoor_open")
--		level.Door("trig_move")
		func.NPC.Action('ourwarrior1', nil, 955, 540, false)
--		func.LetBorderTriggerFollowingObject(1)
		func.SetBorderTriggerToObject("ourwarrior2_tank", "speak", "func.NPC.SpeakToPlayer('ourwarrior2', 1)", "center", 0, 2, false, "", 1)
        pushcmd( function() func.Message("settler_dlg", "map01", 6) end, 2)
        pushcmd( function() func.NPC.Action("ourwarrior1") end, 3)
	elseif action == "angry_warrior" then
		level.settlers_are_enemies = true
--		object("statue").health = 0; object("statue").max_health = 0 --Нахннада
        func.NPC.Action("ourwarrior1") 
        pset("c_trig", "active", 0)
        func.MissionChange("extra", "add", func.dialog.Read("missions", "map01", 2))
        pushcmd(function() 
			pset("ourplayer","team", 2) 
			for i = 1, 4 do pset("ourwarrior"..i,"level", 4) end
			level.LetDamageOurWarrior(0)
		end, 2)
	end
end

function level.GetMissionBoo()
	func.MissionChange("extra", "complete", "")
	func.MissionChange("extra", "add", func.dialog.Read("missions", "map01", 4))
	level.screenplay.missionboo = 1
	pset("b1", "max_health", 150)
	pset("b2", "max_health", 150)
	pset("b1", "health", 150)
	pset("b2", "health", 150)	
	if exists("statue_tank") then pset("statue_tank", "health", 500) end
	kill("cklad")
	for i = 1, 3 do kill("w"..i) end
	pushcmd(function() pset("c_trig", "active", 1) end, 20)
end

function level.GetBoo(num)
	if level.screenplay.missionboo == 0 then return end
	func.Sound("energy")
	kill("boo_trig"..num)
	kill("boo"..num)
	level.screenplay.energycells = level.screenplay.energycells + 1
	message(func.dialog.Read("energycells", "map01", 1)..level.screenplay.energycells..func.dialog.Read("energycells", "map01", level.screenplay.energycells+1))
	if level.screenplay.missionboo == 1 and level.screenplay.energycells == 4 and num ~= 4 then
		func.MissionChange("extra", "complete", func.dialog.Read("missions", "map01", 5))
		level.CommSpeak('exit')
		level.screenplay.missionboo = 2
	elseif level.screenplay.missinboo == 2 and num == 4 then
		level.screenplay.missionboo = 3
	end
end
--[[
function level.Attack(wow, i)

		if wow == 1 then
				level.Attack(0, "PsetBrickHealth")

				ai_march("ourwarrior1", user.get32(37), user.get32(9))
        
				pushcmd(function() ai_march("ourwarrior1", user.get32(45), user.get32(10)) end, 5)
				actor("trigger", user.get32(58), user.get32(5), { 
						name="commactive",
						on_enter="if who.name==\"enemy_tank1\" or who.name==\"enemy_tank2\" or who.name==\"enemy_tank2\" or who.name==\"enemy_tank3\" or who.name==\"enemy_tank4\" or who.name==\"boss_tank\" then user.CommActive() else end", 
						radius=5 } )
						
				level.Attack(0, "EnemySpawn")
				
				pushcmd(function()
										   ai_march("enemy1", user.get32(64), user.get32(28)) 
                                           ai_march("enemy2", user.get32(68), user.get32(28)) 
                                           ai_march("enemy3", user.get32(74), user.get32(22)) 
                                           ai_march("enemy4", user.get32(74), user.get32(26)) 
                                           ai_march("enemy_boss", user.get32(70), user.get32(25)) 
				end, 5)
--				pushcmd(function() 
--										   pset("enemy1", "active", 0)
--                                         pset("enemy2", "active", 0)
--                                         pset("enemy3", "active", 0)
--                                         pset("enemy4", "active", 0)
--                                         pset("enemy_boss", "active", 0)
--				end, 3)
--				pushcmd(function() 
--										   pset("enemy1", "active", 0)
--										   pset("enemy2", "active", 0)
--										   pset("enemy3", "active", 0)
--										   pset("enemy4", "active", 0)
--										   pset("enemy_boss", "active", 0)
--				end, 7)
				pushcmd(function() actor("user_sprite", user.get32(69), user.get32(24), {name="boss_bomb", texture="user/bomb", layer=1}) 
						   pset("enemy_boss", "active", 0)
				end, 10)
				pushcmd(function() ai_march("enemy_boss", user.get32(72), user.get32(28)) end, 11)
				pushcmd(function() pset("enemy_boss", "active", 0)  end, 12)
				pushcmd(function() damage(5000, 'destr_br1')
                           damage(5000, 'destr_br2')
						   kill("boss_bomb")
				end, 16)
				pushcmd(function() 
					   user.LetDamageOurWarrior(0)
					   pset("enemy1", "active", 1)
                       pset("enemy2", "active", 1)
                       pset("enemy3", "active", 1)
                       pset("enemy4", "active", 1)
                       pset("enemy_boss", "active", 1)
				end, 16)
				pushcmd(function()
                level.enemyattack.happened=1
                pset("enemy1", "nick", "Противник")
                pset("enemy2", "nick", "Противник")
                pset("enemy3", "nick", "Противник")
                pset("enemy4", "nick", "Противник")
                pset("enemy_boss", "nick", "Главарь противников")
--              pset("ourwarrior1", "active", 1)
                pset("ourwarrior2", "active", 1)
--              pset("ourwarrior3", "active", 1)
                pset("ourwarrior4", "active", 1)
--              main.mail.letViewMessages = 3
--              main.mail.GetMail()
                play"mus9"
                main.missions.mainMission="1)Найдите энергон в этих местностях. \n2)Свяжитесь с Ороном и сообщите обстановку.\n3)Защитите боевое поселение Экиваторов от врагов!\n4)Сохраните сержанта Халоса!"
				end, 17)
				pushcmd(function()
						message("Поселенец: Это ещё что?")
						message("Комнадир поселенцев: Всем уничтожить атакующих!")
				end, 19)
				pushcmd(function()
						main.mail.letViewMessages = 3
						main.mail.GetMail()
				end, 24)

			
		elseif i == "EnemySpawn" then
			level.Attack(2,"Enemy1Spawn")
			pushcmd(function() 
                service ("ai", {
                        name="enemy2", 
                        vehname="enemy_tank2", 
                        nick="Неизвестный воин", 
                        class="rebel", 
                        skin="rebel", 
                        team=2, 
                        on_die="level.DieEnemy(2)", 
                        active=1 } ) 
			end, 2)
			pushcmd(function() actor("weap_cannon", 0, 0, {name="enemyweap2"}) end, 4.1)
			pushcmd(function() equip("enemy_tank2", "enemyweap2" ) end, 4.2)

			pushcmd(function() 
                service ("ai", {
                        name="enemy3", 
                        vehname="enemy_tank3", 
                        nick="Неизвестный воин", 
                        class="rebel", 
						skin="rebel2", 
                        team=2, 
                        on_die="level.DieEnemy(3)", 
                        active=1 } ) 
			end, 2)
			pushcmd(function() actor("weap_autocannon", 0, 0, {name="enemyweap3"}) end, 4.1)
			pushcmd(function() equip("enemy_tank3", "enemyweap3" ) end, 4.2)

			pushcmd(function() 
                service ("ai", {
                        name="enemy4", 
                        vehname="enemy_tank4", 
                        nick="Неизвестный воин", 
                        class="rebel", 
                        skin="rebel2", 
                        team=2, 
                        on_die="level.DieEnemy(4)", 
                        active=1 } ) 
			end, 2)
			pushcmd(function() actor("weap_minigun", 0, 0, {name="enemyweap4"}) end, 2.1)
			pushcmd(function() equip("enemy_tank4", "enemyweap4" ) end, 4.2)

			pushcmd(function() 
                service ("ai", {
                        name="enemy_boss", 
                        vehname="boss_tank", 
                        nick="Главарь воинов", 
                        class="boss1", 
                        skin="rebel_boss", 
                        team=2, 
                        on_die="level.DieEnemy(5)", 
                        active=1 } ) 
			end, 2)
			pushcmd(function() actor("weap_plazma", 0, 0, {name="enemyweap5"}) end, 4.1)
			pushcmd(function() equip("boss_tank", "enemyweap5" ) end, 4.2)

			pushcmd(function()
										   ai_march("enemy1", user.get32(64), user.get32(28)) 
                                           ai_march("enemy2", user.get32(68), user.get32(28)) 
                                           ai_march("enemy3", user.get32(74), user.get32(22)) 
                                           ai_march("enemy4", user.get32(74), user.get32(26)) 
                                           ai_march("enemy_boss", user.get32(70), user.get32(25)) 
			end, 5.1)
			pushcmd(function() 
										   pset("enemy1", "active", 0)
                                           pset("enemy2", "active", 0)
                                           pset("enemy3", "active", 0)
                                           pset("enemy4", "active", 0)
                                           pset("enemy_boss", "active", 0)
										   ai_stop("enemy1")
										   ai_stop("enemy2")
										   ai_stop("enemy3")
							               ai_stop("enemy4")
										   ai_stop("enemy_boss")
			end, 5)
--			end, 4.5 3)
--			pushcmd(function() 
--										   pset("enemy1", "active", 0)
--										   pset("enemy2", "active", 0)
--										   pset("enemy3", "active", 0)
--										   pset("enemy4", "active", 0)
--										   pset("enemy_boss", "active", 0)
--			end, 7)

		elseif i == "Enemy1Spawn" then
			pushcmd(function() 
                service ("ai", {
                        name="enemy1", 
                        vehname="enemy_tank1", 
                        nick="Неизвестный воин", 
                        class="rebel", 
                        skin="rebel", 
                        team=2, 	
                        on_die="level.DieEnemy(1)", 
                        active=1 } ) 
			end, 2)
			pushcmd(function() actor("weap_rockets", 0, 0, {name="enemyweap1"}) end, 4.1)
			pushcmd(function() equip("enemy_tank1", "enemyweap1" ) end, 4.2)
			pushcmd(function() 
										   pset("enemy1", "active", 0)
										   ai_stop("enemy1")
			end, 5)			
		elseif i == "PsetBrickHealth" then
				pset("destr_br1","max_health", 2500)
				pset("destr_br2","max_health", 2500)
				pset("destr_br1","health", 2500)
				pset("destr_br2","health", 2500)
				
		elseif i == "GetEnemyAttack" then		
				sound("talk1")
				message"Командир поселения: Это странно..."
				pushcmd(function() message"Командир поселения: И стационарные установки не работают!" end, 2)
				pushcmd(function() message"Командир поселения: Только пулемётная..." end, 4)
--    		    pushcmd(function() message"Командир поселения: Хорошо, что ещё защитные линии работают..." end, 6)
				pushcmd(function() level.Attack(1) end, 20)
		
				
		elseif wow == 3 then
			if i == nil then
			rioter=nil	
			level.Attack(0, "EnemySpawn")
--			level.Attack(0, "Enemy1Spawn")
			level.Attack(0, "PsetBrickHealth")
			
			pushcmd(function() 
					   ai_march("enemy1", user.get32(66), user.get32(30)) 
                       ai_march("enemy2", user.get32(70), user.get32(33)) 
                       ai_march("enemy3", user.get32(72), user.get32(22)) 
                       ai_march("enemy4", user.get32(74), user.get32(24)) 
                       ai_march("enemy_boss", user.get32(65), user.get32(26))
			end, 5.2)

			pushcmd(function() rioter=0  end, 8)
			
--			pushcmd(function() pset("enemy1", "active", 0)
--                             pset("enemy2", "active", 0)
--							   pset("enemy3", "active", 0)
--							   pset("enemy4", "active", 0)
--							   pset("enemy_boss", "active", 0)
--							   ai_stop("enemy1")
--							   ai_stop("enemy2")
--							   ai_stop("enemy3")
--							   ai_stop("enemy4")
--							   ai_stop("enemy_boss")
--			end, 5)
			
			pushcmd(function() actor("trigger", 1865, 811, {name="rioter_trig1", on_enter="level.rioterplay.SpeakEnemy(0)", only_human=1, radius=10}) end, 7)
			
			elseif i == "AttackWithPlayer" then
					pushcmd(function() 
							actor("trigger", user.get32(70), user.get32(25), { 
									name="bomb_trigger", 
									on_enter="if who.name==\"enemy_tank1\" then level.Attack(3, 'BotEnter') elseif who.name==\"ourplayer_tank\" then message'Главарь войнов: Не мешай!' else end" } ) 
					end, 7)
					pushcmd(function() ai_march("enemy1", user.get32(70), user.get32(25)) end, 7)
					level.Attack(0, "Enemy1Spawn")
					message("Задания обновлены.")
					main.missions.extraMission = "1)Убейте командира поселения!"
					main.missions.mainMission="1)Найдите энергон в этих местностях. \n2)Свяжитесь с Ороном и сообщите обстановку.\n3)Уничтожьте боевое поселение Экиваторов."
					message("Главарь: Подготовься к нападению.")
			        kill("trig15")
			elseif i == "BotEnter" then
					pushcmd(function() actor("user_sprite", user.get32(69), user.get32(24), {name="boss_bomb", texture="user/bomb", layer=1 } ) 
							pset("enemy_boss", "active", 0)
					end, 1)
					pushcmd(function() message("Войн: Двигатель заглох!") end, 3)
					pushcmd(function() 
							local tank = object("enemy_tank1") 
							tank.playername=""
							kill("enemy1") 
					end, 1)
					pushcmd(function() actor("weap_rockets", user.get32(70), user.get32(25),  {name="rocket" } )
									   damage(5000, 'destr_br1')
									   damage(5000, 'destr_br2')
									   damage(5000, 'enemy_tank1')
									   kill("boss_bomb")
									   kill("enemyweap1")
									   kill("bomb_trigger")
									   pset("ourwarrior1", "active", 1)
									   pset("ourwarrior2", "active", 1)
									   pset("ourwarrior4", "active", 1)
					end, 11)          
					pushcmd(function() message("Главарь: Подбери оружие! Все остальные - нападайте!") end, 12)
					pushcmd(function() 
					   pset("enemy2", "active", 1)
                       pset("enemy3", "active", 1)
                       pset("enemy4", "active", 1)
                       pset("enemy_boss", "active", 1)
                       play"mus9"
					   pset("ourwarrior3", "active", 1)
					end, 12)
					pushcmd(function() message("Поселенец: Чё за...") end, 13)
					pushcmd(function() message("Командир поселенцев: Всем уничтожить нападающих!!!") end, 14)
					ai_march("ourwarrior1", user.get32(65), user.get32(17))
					ai_march("ourwarrior2", user.get32(65), user.get32(20))
					ai_march("ourwarrior3", user.get32(63), user.get32(15))
					ai_march("ourwarrior4", user.get32(62), user.get32(19))
					pset("movetrig1", "active", 0)
                    pset("movetrig2", "active", 0)
                    pset("movetrig3", "active", 0)
                    pset("movetrig4", "active", 0)
                    pset("movetrig5", "active", 0)
                    pset("movetrig6", "active", 0)
			elseif i == "OnDieWarriors" then
					message("Задание выполнено.")
					main.missions.mainMission='1)Найдите энергон в этих местностях. \n2)Свяжитесь с Ороном и сообщите обстановку.\n3)Уничтожьте боевое поселение Экиваторов.';
					play"mus5"
					pset("enemy_boss", "active", 0)
					actor("trigger", user.get32(66), user.get32(2), { 
									name="commboss_trig", 
									on_enter="if level.rioterplay.bosscomm==1 then user.BossCommSpeak() end",
									only_human=1} ) 		
					pushcmd(function() ai_march("enemy_boss", user.get32(57), user.get32(9)) end, 1)
					pushcmd(function() ai_march("enemy_boss", user.get32(69), user.get32(2)) end, 7)
--      			pushcmd(function() level.rioterplay.bosscomm=1 end, 1)
					pushcmd(function() 
									  actor("trigger", user.get32(69), user.get32(2), { 
													   name="boss_trigger", 
													   on_enter="if who.name==\"boss_tank\" then pushcmd(function() pset('boss_tank', 'rotation', 3.1) end, 2); level.rioterplay.bosscomm=1;kill('boss_trigger') else end" } ) 
					end, 1)
			end
		end
end
]]

function level.Attack(n)
	--Создаём врагов
	if n == nil then
		local enemy_positions = {{75, 38}, {70, 38}, {65, 38}, {61, 36}, {67, 36}}
		local enemy_weapons = {"rockets", "minigun", "minigun", "cannon", "cannon"}
		for i = 1, 4 do
			func.NPC.Create("enemy"..i, "", "Неизвестный войн", "boss1", "rebel", 2, "weap_"..enemy_weapons[i], 0, 1, func.Get32(enemy_positions[i][1]), func.Get32(enemy_positions[i][2]), 4, true) 
		end
		func.NPC.Create("boss", "", "Неизвестный войн", "boss1", "rebel_boss", 2, "weap_plazma", 0, 2, func.Get32(77), func.Get32(34), 4, true) 
	if level.screenplay.missoinboo == 3 and level.screenplay.missionplate == 0 and level.screenplay.was_enemyattack == 0 then level.Attack("boss_gotobomb") end
	--Теперь делаем сценарий
	elseif n == "boss_gotobomb" then
		pushcmd(function()
			func.NPC.SetAim("boss", 70, 25, "level.Attack('boss_setbomb')", true, "", false, true)
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
		end, 12)
	end
end

function level.HiddenTurretActivate()
	kill("hiddenturret_trig")
	actor("turret_minigun", 923, 1529, {name = "hiddenturret1", dir = 4.71239})
	actor("turret_minigun", 460, 1529, {name = "hiddenturret2", dir = 4.71239})
end
