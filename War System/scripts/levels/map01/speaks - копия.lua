-- Диалоги первого уровня кампании ВС.

function level.SpeakToPlayer(npc, part)
	local speak;
	
	for i = 1, 4 do
		if npc == "ourwarrior"..i then speak = "settler";
		elseif npc == "ourenemy"..i then speak = "enemy";
		end;
	end;
	
	if speak == "settler" then
		if part == 1 then
			func.Message("map01", "settler_speaks", math.random(8))
		elseif part == 2 then
			func.Message("map01", "settler_speaks", func.OrGate(math.random(2, 7), math.random(9, 10)))
		elseif part == 3 then
			func.Message("map01", "settler_speaks", math.random(2, 10))
		elseif part == 4 then
			func.Message("map01", "settler_speaks", func.OrGate(math.random(3, 4), math.random(11, 14)))
		end;
	end;     
end

function level.CommSpeak(part, a)
	pset('c_trig', 'active', 0)
	if part == 0 then
		if a == 1 then func.dialog.Show("halos1", "map01", a, "", "if n==1 then level.CommSpeak(0, 2) elseif n==2 then level.CommSpeak(0, 15) elseif n==3 then level.CommSpeak(0, 7) end; object('ourwarrior3').nick = func.dialog.Read('map01', 'nicks', 2)", "1", "2", "3")
		elseif a == 2 then func.dialog.Show("halos1", "map01", a, "", "if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 14) elseif n==3 then level.CommSpeak(0, 6) end", "1", "2", "3")
		elseif a == 3 then func.dialog.Show("halos1", "map01", a, "", "if n==1 then level.CommSpeak(0, 13) elseif n==2 then level.CommSpeak(0, 5) end", "1", "2")
		elseif a == 4 then func.dialog.Show("halos1", "map01", a, "", "level.screenplay.missionKey=1;level.CommSpeak('exit')")
		elseif a == 5 then func.dialog.Show("halos1", "map01", a, "", "level.screenplay.missionKey=1;level.CommSpeak('exit')")
		elseif a == 6 then func.dialog.Show("halos1", "map01", a, "", "if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 14) elseif n==3 then level.CommSpeak(0, 7) end", "1", "2", "3")
		elseif a == 7 then func.dialog.Show("halos1", "map01", a, "", "if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 14) elseif n==3 then level.CommSpeak(0, 8) end", "1", "2", "3")
		elseif a == 8 then func.dialog.Show("halos1", "map01", a, "", "if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 14) elseif n==3 then level.CommSpeak(0, 9) end", "1", "2", "3")
		elseif a == 9 then func.dialog.Show("halos1", "map01", a, "", "if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 14) elseif n==3 then level.CommSpeak(0, 10) end", "1", "2", "3")
		elseif a == 10 then func.dialog.Show("halos1", "map01", a, "", "level.CommSpeak(0, 11)", "1")
		elseif a == 11 then func.dialog.Show("halos1", "map01", a, "", "if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 12) elseif n==3 then level.OurWarriorsAttackPlayer('ourplayer_tank') end", "1", "2", "3")
		elseif a == 12 then func.dialog.Show("halos1", "map01", a, "", "level.CommSpeak('exit')")
		elseif a == 13 then func.dialog.Show("halos1", "map01", a, "", "level.GetMissionBoo(); level.CommSpeak('exit')")
		elseif a == 14 then func.dialog.Show("halos1", "map01", a, "", "if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 4) elseif n==3 then level.CommSpeak(0, 16) end", "1", "2", "3")
		elseif a == 15 then func.dialog.Show("halos1", "map01", a, "", "if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 14) elseif n==3 then level.CommSpeak(0, 6) end", "1", "2", "3") 
		elseif a == 16 then func.dialog.Show("halos1", "map01", a, "", "level.CommSpeak(0, 4)")
		end;
	elseif part == 1 then
		if a == 1 then func.dialog.Show("halos2", "map01", a, main.characters[const.playerName].inventory.items.boo..".", "level.CommSpeak('exit')", "1")
		elseif a == 2 then func.dialog.Show("halos2", "map01", a, "", "func.ConfiscateItem('boo', const.playerName, 4); level.CommSpeak(1, 3)", "1")
		elseif a == 3 then func.dialog.Show("halos2", "map01", a, "", "if n==2 then level.CommSpeak(1, 4) else level.CommSpeak('exit') end", "1", "2")
		elseif a == 4 then func.dialog.Show("halos2", "map01", a, "", "if n==1 then level.CommSpeak('exit') elseif n==2 then level.CommSpeak('exit') end")
		elseif a == 5 then func.dialog.Show("halos2", "map01", a, "", "level.CommSpeak('exit')")
		elseif a == 6 then func.dialog.Show("halos2", "map01", a, "", "if n==1 then level.CommSpeak('exit') elseif n==2 then level.CommSpeak(1, 7) end", "1", "2")
		elseif a == 7 then func.dialog.Show("halos2", "map01", a, "", "level.CommSpeak(1, 8)", "1")
		elseif a == 8 then func.dialog.Show("halos2", "map01", a, "", "level.CommSpeak(1, 9)", "1")
		elseif a == 9 then func.dialog.Show("halos2", "map01", a, "", "level.CommSpeak(1, 10)", "1")
		elseif a == 10 then func.dialog.Show("halos2", "map01", a, "", "level.CommSpeak('exit')")
		elseif a == 11 then func.dialog.Show("halos2", "map01", a, "", "if n==1 then level.CommSpeak(1, 13) elseif n==2 then level.CommSpeak(1, 12) end")
		elseif a == 12 then func.dialog.Show("halos2", "map01", a, "", "if n==1 then level.CommSpeak('exit') elseif n==2 then level.CommSpeak(1, 14) end")
		elseif a == 13 then func.dialog.Show("halos2", "map01", a, "", "level.CommSpeak('exit')")
		elseif a == 14 then func.dialog.Show("halos2", "map01", a, "", "level.CommSpeak('exit')")
		elseif a == 15 then func.dialog.Show("halos2", "map01", a, "", "level.CommSpeak('exit')")
		elseif a == 16 then func.dialog.Show("halos2", "map01", a, "", "level.CommSpeak('exit')")
		end;
	elseif part == "exit" then 
		pushcmd(function() 
			pset('c_trig', 'active', 1)
--			if level.screenplay.missionBoo == 0 then --Не думаю, что это нужно. Slava98.
--          pset("c_trig", "on_enter", "level.CommSpeak(1, 1)") --Здесь потом другое будет. Slava98.
			if level.screenplay.missionBoo == 1 then
				pset("c_trig", "on_enter", "level.CommSpeak(1, 1)")
			elseif level.screenplay.missionBoo == 2 then
				pset("c_trig", "on_enter", "level.CommSpeak(1, 2)")
				level.screenplay.halosHasGotBoo = true;
				level.screenplay.missionBoo = 3;
				message("Конец играбельной части.")
			elseif level.screenplay.halosHasGotBoo then
				if level.functions.sidedoorStatus ~= 3 then
					pset("c_trig", "on_enter", "level.CommSpeak(1, 5)")
				else
					level.DoorRepairerCall()
				end;
			elseif level.screenplay.missionKey == 1 then
--				pset("c_trig", "on_enter", "level.CommSpeak(1, 5)")
				pset("c_trig", "active", 0)
				kill("cklad") -- Надо переименовать. Определённо. Завтра займусь этим, если не пойду гулять с девушкой. Slava98. 25.08.13.
				for i = 1, 3 do kill("w"..i) end;
			end;
		end, 5)
	end;
end

function level.SettlerSpeak(a)
        if a == "hello" then
                func.dialog.Show("settler_dlg", "map01", 1, "", "if n==1 then level.screenplay.SettlerCall('open') elseif n==2 then level.SettlerSpeak('angry_warrior') elseif n==3 then level.SettlerSpeak('what1') end", "1", "2", "3")
        elseif a == "angry_warrior" then
                func.Message("map01", "settler_dlg", 5)
                level.screenplay.SettlerCall(a)
--              level.RioterAttack(3)                   
        elseif a == "what1" then
                func.dialog.Show("settler_dlg", "map01", 2, "", "if n==1 then level.screenplay.SettlerCall('open') elseif n==2 then level.SettlerSpeak('angry_warrior') elseif n==3 then level.SettlerSpeak('what2') end", "1", "2", "3")
        elseif a == "what2" then
                func.dialog.Show("settler_dlg", "map01", 3, "", "if n==1 then level.screenplay.SettlerCall('open') elseif n==2 then level.SettlerSpeak('angry_warrior') elseif n==3 then level.SettlerSpeak('what3') end", "1", "2", "3")
        elseif a == "what3" then
        func.Message("map01", "settler_dlg", 4)
        pushcmd(function() level.SettlerSpeak('angry_warrior') end, 2)                  
                
        end
end

function level.SettlerSpeak(a)
	if a == 1 then func.dialog.Show("settler_dlg", "map01", a, "", "if n==1 then level.SettlerSpeak(8) elseif n==2 then level.SettlerSpeak('angry') elseif n==3 then level.SettlerSpeak(2) end", "1", "2", "3")                
	elseif a == 2 then func.dialog.Show("settler_dlg", "map01", a, "", "if n==1 then level.SettlerSpeak(8) elseif n==2 then level.SettlerSpeak('angry') elseif n==3 then level.SettlerSpeak(3) end", "1", "2", "3")
	elseif a == 3 then func.dialog.Show("settler_dlg", "map01", a, "", "if n==1 then level.SettlerSpeak(8) elseif n==2 then level.SettlerSpeak('angry') elseif n==3 then level.SettlerSpeak(4) end", "1", "2", "3")
	elseif a == 4 then func.Message("map01", "settler_dlg", 4) pushcmd(function() level.SettlerSpeak('angry') end, 2)                  
	elseif a == "angry" then func.Message("map01", "settler_dlg", 5); level.screenplay.SettlerCall(a); --level.RioterAttack(3)   
	elseif a == 8 then func.dialog.Show("settler_dlg", "map01", a, "", "level.TerminalSpeak('settle', 4)", "1")
	end
end

function level.TerminalSpeak(terminal, a)
	if terminal == "settle" then
		if a == "call" then
			if level.screenplay.playerKnowsAboutTerminal then message(func.dialog.Read("map01", "promt", 2)); level.screenplay.playerKnowsAboutTerminal = true; end;
			if not level.screenplay.ourwarrior5WasTalked then level.TerminalSpeak("settle", 3) 
			elseif level.screenplay.playerMustPressPassword and not level.screenplay.playerCanRideToSettle then level.TerminalSpeak("settle", 4)
			end;
		elseif a == 3 then func.dialog.Show("terminals", "map01", a, "", "if n==1 then level.screenplay.SettlerCall('speak'); object('d_trig').active=0; end", func.dialog.Read("map01", "terminals", 1), func.dialog.Read("map01", "terminals", 2))
		elseif a == 4 then func.dialog.Show("terminals", "map01", a, "", "if n==1 then level.screenplay.SettlerCall('open') elseif n==2 then level.TerminalSpeak('settle', 5) elseif n==3 then --[[level.RioterAttack(3)]] end", "1", "2", "3")
		elseif a == 5 then func.dialog.Show("terminals", "map01", a, "", "if n==1 then level.screenplay.SettlerCall('open') elseif n==2 then level.TerminalSpeak('settle', 5) elseif n==3 then --[[level.RioterAttack(3)]] end", "1", "2", "3")
		end;
	end;
end

function level.RanonSpeak(a)
	if a == 2 then func.dialog.Show("ranon", "map01", a, "", "if n==1 then level.RanonSpeak(3) elseif n==2 then level.RanonSpeak(8) end", "1", "2")
	elseif a == 3 then func.dialog.Show("ranon", "map01", a, "", "if n==1 then level.RanonSpeak(4) elseif n==2 then level.RanonSpeak(5) elseif n==3 then level.RanonSpeak(7) end", "1", "2", "3")
	elseif a == 4 then func.dialog.Show("ranon", "map01", a, "", "if n==1 then level.screenplay.SettlerNearRuins('goto_settle') else level.RanonSpeak(6) end", "1", "2")
	elseif a == 5 then func.dialog.Show("ranon", "map01", a, "", "if n==1 then level.screenplay.SettlerNearRuins('goto_settle') else level.screenplay.SettlerNearRuins('go_away') end", "1", "2")
	elseif a == 6 then func.dialog.Show("ranon", "map01", a, "", "if n==1 then level.screenplay.SettlerNearRuins('goto_settle') else level.screenplay.SettlerNearRuins('go_away') end", "1", "2")
	elseif a == 7 then func.dialog.Show("ranon", "map01", a, "", "if n==1 then level.screenplay.SettlerNearRuins('goto_settle') else level.screenplay.SettlerNearRuins('go_away') end", "1", "2")
	elseif a == 8 then func.dialog.Show("ranon", "map01", a, "", "if n==1 then level.screenplay.SettlerNearRuins('go_away') elseif n==2 then level.RanonSpeak(20) elseif n==3 then level.RanonSpeak(9) end", "1", "2", "3")
	elseif a == 9 then func.dialog.Show("ranon", "map01", a, "", "if n==1 then level.RanonSpeak(20) elseif n==2 then level.RanonSpeak(10) elseif n==3 then level.RanonSpeak(11) end", "1", "2", "3")
	elseif a == 10 then func.dialog.Show("ranon", "map01", a, "", "if n==1 then level.screenplay.SettlerNearRuins('go_away') elseif n==2 then level.RanonSpeak(20) elseif n==3 then level.screenplay.SettlerNearRuins('attack_player') end", "1", "2", "3")
	elseif a == 11 then func.dialog.Show("ranon", "map01", a, "", "if n==1 then level.RanonSpeak(12) elseif n==2 then level.RanonSpeak(19) elseif n==3 then level.RanonSpeak(20) end", "1", "2", "3")
	elseif a == 12 then func.dialog.Show("ranon", "map01", a, "", "level.RanonSpeak(13)", "1")
	elseif a == 13 then func.dialog.Show("ranon", "map01", a, "", "if n==1 then level.RanonSpeak(14) elseif n==2 then level.RanonSpeak(15) elseif n==3 then level.RanonSpeak(16) end", "1", "2", "3")
	elseif a == 14 then func.dialog.Show("ranon", "map01", a, "", "if n==1 then level.screenplay.SettlerNearRuins('attack_player') elseif n==2 then level.RanonSpeak(16) elseif n==3 then level.RanonSpeak(17) end", "1", "2", "3")
	elseif a == 15 then func.dialog.Show("ranon", "map01", a, "", "if n==1 then level.screenplay.SettlerNearRuins('go_away') elseif n==2 then level.RanonSpeak(16) end", "1", "2")
	elseif a == 16 then func.dialog.Show("ranon", "map01", a, "", "if n==1 then level.RanonSpeak(17) elseif n==2 then level.screenplay.SettlerNearRuins('go_away') elseif n==3 then level.RanonSpeak(18) end", "1", "2", "3")
	elseif a == 17 then func.dialog.Show("ranon", "map01", a, "", "level.screenplay.SettlerNearRuins('attack_player')", "1", "2", "3")
	elseif a == 18 then func.dialog.Show("ranon", "map01", a, "", "level.screenplay.SettlerNearRuins('show_boss')")
	elseif a == 19 then func.dialog.Show("ranon", "map01", a, "", "if n==1 then level.screenplay.SettlerNearRuins('go_away') elseif n==2 then level.RanonSpeak(20) elseif n==3 then level.screenplay.SettlerNearRuins('attack_player') end", "1", "2", "3")
	elseif a == 20 then func.dialog.Show("ranon", "map01", a, "", "if n==1 then level.RanonSpeak(5) elseif n==2 then level.RanonSpeak(4) elseif n==3 then level.RanonSpeak(7) end", "1", "2", "3")
	end;
end
