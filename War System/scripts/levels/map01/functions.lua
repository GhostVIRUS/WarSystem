level.warriors = {list={"ourwarrior1", "ourwarrior2", "ourwarrior3", "ourwarrior4"}}
level.damagespeak = {}
--func.NPC.friends.ourwarrior1.text =

for i = 1, 4 do
        rawset(level.damagespeak, rawget(level.warriors.list, i), level.dialog.map01.russ.damagespeak)
end

for i = 1, table.maxn(level.warriors.list) do
        rawset(level.warriors, rawget(level.warriors.list, i), {})
end     

function level.LetDamageOurWarrior(num)
    for i = 1, 4 do
        if num == nil then
                return 0
        elseif num == 0 and exists("ourwarrior"..i) then
                pset("ourwarrior"..i.."_tank", "on_damage", "func.ExtraDamage(who, self)")
--              pset("ourwarrior"..i.."_tank", "on_damage", "level.OurWarriorsAttackPlayer()") --Что за тупость? Slava98.
        elseif num == 1 and exists("ourwarrior"..i) then
                pset("ourwarrior"..i.."_tank", "on_damage", "func.ExtraDamage(who, self);func.NPC.DamageOurWarrior(who, 'ourwarrior"..i.."')")
				if i~=3 then func.NPC.Action("ourwarrior"..i) else func.NPC.Action("ourwarrior3", 0, 2224, 64) end
        end
    end
end

function level.Pickup(num, x, y)
	if level.screenplay.missionboo == 1 then
        level.ShowBoo(x, y, num)
        actor("trigger", x, y, {name="boo_trig"..num, only_human=1, radius=1, active=1, on_enter="level.GetBoo("..num..")"})
	end
end

function level.SpeakToPlayer(npc, part)
        for i = 1, 4 do
                if npc == "ourwarrior"..i then speak = "settler"
                elseif npc == "ourenemy"..i then speak = "enemy"
                end
        end
        if speak == "settler" then
                if part == 1 then
                        message(func.dialog.Read("speak_to_player", "map01", math.random(8)))
                elseif part == 2 then
                        message(func.dialog.Read("speak_to_player", "map01", func.OrGate(math.random(2, 7), math.random(9, 10))))
                elseif part == 3 then
                        message(func.dialog.Read("speak_to_player", "map01", math.random(2, 10)))
                elseif part == 4 then
                        message(func.dialog.Read("speak_to_player", "map01", func.OrGate(math.random(3, 4), math.random(11, 14))))
                end
        end     
end

function level.Lose()
    level.WarriorsSetActive(0)
	level.LetDamageOurWarrior(1)
end

function level.OurWarriorsAttack(npc)
	level.WarriorsSetActive(1)--В любом случае поселенцы становятся активными. Slava98.
	level.LetDamageOurWarrior(0)
	if npc == "ourplayer" then
        level.screenplay.angrywarriors = true
        if exists("ourwarrior3") then
                func.Message("damagespeak", "map01", 4)
        else
                func.Message("speak_to_player", "map01", 8)
        end
        object("ourplayer").team = 3
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
	if not exists(level.screenplay.settle_enemy) then for i = 1, 4 do func.NPC.Action("ourwarrior"..i) end end
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

function level.OnDie(name)
        if name == "ourwarrior3" and not level.screenplay.was_enemyattack then
                if object("ourwarrior3").team == 3 then
                        level.WarriorsSetActive(0)
                else
                        --level.EnemyAttack()
                end
        end
        for i = 1, 4 do
                if name == "ourwarrior"..i then kill(name) end
        end     
end

function level.Door(action)
        if action == "sidedoor_open" and level.screenplay.sidedoor_status == 0 then
        if level.screenplay.sidedoor_close then level.Door("sidedoor_closed") return end
--              if not level.screenplay.sidedoor_status == 1 then pushcmd(function() level.Door("sidedoor_open") end, 1) return end
--              pset("open_trig", "active", 0)
        pushcmd( function()     
                        func.Move("sidedoor_part1", 29, 17, true, 50)   
                        func.Move("sidedoor_part2", 29, 18, true, 50) 
                        func.Sound("door") end, 1)
        pushcmd( function() 
                        func.Move("sidedoor_part1", 29, 16, true, 50)  
            func.Move("sidedoor_part2", 29, 19, true, 50)
                        func.Sound("door") end, 2)
                pushcmd( function() 
                        level.screenplay.sidedoor_status = 1 end, 2)
--        pushcmd(function() pset("close_trig", "active", 1) --[[level.screenplay.sidedoor_status = 1]] end, 3.5)
        elseif action == "sidedoor_close" and level.screenplay.sidedoor_status == 1 then
--              if not level.screenplay.sidedoor_status == 2 then pushcmd(function() level.Door("sidedoor_close") end, 1) return end
--              pset("close_trig", "active", 0)
        pushcmd( function()     
                        func.Move("sidedoor_part1", 29, 17, true, 50)   
                        func.Move("sidedoor_part2", 29, 18, true, 50) 
                        func.Sound("door") end, 1)
        pushcmd( function() 
                        func.Move("sidedoor_part1", 28, 17, true, 50)  
            func.Move("sidedoor_part2", 28, 18, true, 50)
                        func.Sound("door") end, 2)
                pushcmd( function() 
                        level.screenplay.sidedoor_status = 0 end, 2)
--        pushcmd(function() pset("open_trig", "active", 1) --[[level.screenplay.sidedoor_status = 2]] end, 3.5)
        elseif action == "sidedoor_lagging" then
				level.screenplay.sidedoor_status = 3
                pset("sidedoor_trig", "active", 0)
				pset("c_trig", "on_enter", "level.CommSpeak(1, 5)")
				func.Message("settler_dlg", "map01", 7)
--              pset("sidedoor_lag_trig", "active", 1)
        --[[
                level.screenplay.player_knows_that_door_is_close = true
                pset("c_trig", "active", 1)
        pushcmd(function() ai_march("ourwarrior1", 32*32, 16*32) end, 0.1)
        pushcmd(function() message("Поселенец: Похоже, дверь заглючило. Пока подождите здесь.") end, 2)
        pushcmd(function() func.ActionWarrior(1, 2) end, 3)]]
                
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
        pushcmd( function() moveY(19,4,7,"br_ex",1,4,-1) end, 0.2)      
        elseif action == "boodoor_open" and level.screenplay.missionboo == 1 then
                func.Sound("dr2_start")
                func.Message("promt", "map01", 3)
                kill("boodoor_trig")
                func.Move("boodoor_part1", 23, 43, true, 50)  
                func.Move("boodoor_part2", 23, 44, true, 50)
                func.Move("boodoor_part3", 23, 45, true, 50)
                func.Move("boodoor_part4", 25, 43, true, 50)  
                func.Move("boodoor_part5", 25, 44, true, 50)  
                func.Move("boodoor_part6", 25, 45, true, 50)  
                pushcmd( function()
                        func.Move("boodoor_part7", 23, 39, true, 50)  
                        func.Move("boodoor_part1", 23, 40, true, 50)
                        func.Move("boodoor_part2", 23, 41, true, 50)
                        func.Move("boodoor_part3", 23, 42, true, 50)
                        func.Move("boodoor_part8", 25, 49, true, 50)  
                        func.Move("boodoor_part4", 25, 46, true, 50)  
                        func.Move("boodoor_part5", 25, 47, true, 50)  
                        func.Move("boodoor_part6", 25, 48, true, 50) 
                end, 3)
--				level.ShowMinigunTurrels() --Вылезают турели.
--      elseif action == "trig_move" then
--              setposition("open_trig", 832, 540)
--              pushcmd(function() setposition("open_trig", 910, 540) end, 1)
--              pushcmd(function() level.Door("trig_move") end, 2)
        end
end

function level.ShowBoo(x, y, num)
        actor("user_sprite", x, y, {name="boo"..num, layer=10, animate=25, texture="pu_booster"})
end

function level.Statue(event, num)
	if event == "damage" then
		if level.screenplay.damagedStatue == true then return end
		level.screenplay.damagedStatue = true
		for i = 1, 3 do
			local esc = service ("ai", {name = "esc"..i, team = 2, active = 0, skin = "eskavator", nick = "", on_die = "func.SetBorderTriggerToObject('esc_tank"..i.."');kill('esc"..i.."') " } )
			esc.vehname = "esc_tank"..i
			object("esc_tank"..i).playername = "esc"..i
		end
		local statue = service ("ai", {name = "statue", team = 2, active = 1, skin = "rebel_camouflage", nick = "", on_die = "kill('statue'); kill('statue_weap') level.Statue('destroy')" } )
		statue.vehname = "esc_tank"
		object("statue_tank").playername = "statue"	
		level.Statue("creeper_loop")
	elseif event == "creeper_loop" and exists("ourplayer_tank") then
		for i = 1, 3 do
			if exists("esc"..i) then
				local x, y = position("ourplayer_tank")
				func.NPC.Action("esc"..i, 0, x, y, false) 
				func.SetBorderTriggerToObject("esc_tank"..i, "","level.Statue('creeper_boom', "..i..")", "center", 0, 2) 
			end
		end
		pushcmd(function() level.Statue("creeper_loop") end, 0.1)
	elseif event == "creeper_boom" then
		func.Destroy("esc"..num)
		damage(math.random(1, 3000), "ourplayer_tank")
	elseif event == "destroy" then
		x, y = position("statue_tank")
		level.Pickup(2, x, y)
	end
end

function level.PlayerDetect()
	if level.playerdetect_value ~= 0 then
		func.SetBorderTriggerToObject("ourplayer_tank", "", "for i=1,4 do if who ~= nil and who.playername ~= 'ourwarrior'..i and rawget(func.NPC.friends, 'ourwarrior'..i).is_in_settle == 0 then setposition('ourwarrior'..i..'_tank', 1490, 380) rawget(func.NPC.friends, 'ourwarrior'..i).is_in_settle == 1 end end", "center", 32, 20, 0, "", 1, 19)
		pushcmd(level.PlayerDetect, 1) 
	end
end

--Not used
function level.IsEnemyInSettle()
	if exists("enemyinsettle_trig") then kill("enemyinsettle_trig") end
	if level.screenplay.enemy_in_settle ~= 2 and level.screenplay.enemy_in_settle ~= 0 then level.screenplay.enemy_in_settle = 2 end
	actor("trigger", 1454, 335, {name="enemyinsettle_trig", only_human=0, radius=32, radius_delta=0, active=1, only_visible=0, on_enter="if who~=nil and object(who.playername).team~=1 and level.screenplay.enemy_in_settle==0 then level.screenplay.enemy_in_settle=1;level.screenplay.settle_enemy = who.name; level.WarriorsSetActive(1); level.LetDamageOurWarrior(0) end", on_leave="if who~=nil and object(who.playername).team~=1 and level.screenplay.enemy_in_settle==1 then level.screenplay.enemy_in_settle=2;--[[level.WarriorsSetActive(0); level.LetDamageOurWarrior(1)]] end"})
	if level.screenplay.enemy_in_settle == 2 then
		print(level.screenplay.enemy_in_settle)
		level.WarriorsSetActive(0)
		level.LetDamageOurWarrior(1)
		level.screenplay.enemy_in_settle = 0
		level.WarriorsSetActive(0)
	end
	pushcmd(function() level.IsEnemyInSettle() end, 0.1)
end
