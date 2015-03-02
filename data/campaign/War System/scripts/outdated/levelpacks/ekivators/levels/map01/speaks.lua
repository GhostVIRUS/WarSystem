-- Диалоги первого уровня кампании ВС.

function level.CommSpeak(part, a)
	pset('c_trig', 'active', 0)
	if part == 0 then
		if a == 1 then func.MsgBox({"map01", "halos1", a}, {"if n==1 then level.CommSpeak(0, 2) elseif n==2 then level.CommSpeak(0, 15) elseif n==3 then level.CommSpeak(0, 7) end", "1", "2", "3"}, "dlgbox"); object("ourwarrior3").nick = func.Read({"map01", "nicks", 2})
		elseif a == 2 then func.MsgBox({"map01", "halos1", a}, {"if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 14) elseif n==3 then level.CommSpeak(0, 6) end", "1", "2", "3"}, "dlgbox")
		elseif a == 3 then func.MsgBox({"map01", "halos1", a}, {"if n==1 then level.CommSpeak(0, 13) elseif n==2 then level.CommSpeak(0, 14) end", "1", "2"}, "dlgbox")
		elseif a == 4 then func.MsgBox({"map01", "halos1", a}, {"level.GetMissionKey(); level.screenplay.missionKey=1;level.CommSpeak('exit')"}, "dlgbox")
		elseif a == 5 then func.MsgBox({"map01", "halos1", a}, {"level.GetMissionKey(); level.screenplay.missionKey=1;level.CommSpeak('exit')"}, "dlgbox")
		elseif a == 6 then func.MsgBox({"map01", "halos1", a}, {"if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 14) elseif n==3 then level.CommSpeak(0, 7) end", "1", "2", "3"}, "dlgbox")
		elseif a == 7 then func.MsgBox({"map01", "halos1", a}, {"if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 14) elseif n==3 then level.CommSpeak(0, 8) end", "1", "2", "3"}, "dlgbox")
		elseif a == 8 then func.MsgBox({"map01", "halos1", a}, {"if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 14) elseif n==3 then level.CommSpeak(0, 9) end", "1", "2", "3"}, "dlgbox")
		elseif a == 9 then func.MsgBox({"map01", "halos1", a}, {"if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 14) elseif n==3 then level.CommSpeak(0, 10) end", "1", "2", "3"}, "dlgbox")
		elseif a == 10 then func.MsgBox({"map01", "halos1", a}, {"level.CommSpeak(0, 11)", "1"}, "dlgbox")
		elseif a == 11 then func.MsgBox({"map01", "halos1", a}, {"if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 14) end", "1", "2"}, "dlgbox")
		elseif a == 12 then func.MsgBox({"map01", "halos1", a}, {"level.CommSpeak('exit')"}, "dlgbox")
		elseif a == 13 then func.MsgBox({"map01", "halos1", a}, {"level.GetMissionBoo(); level.CommSpeak('exit')"}, "dlgbox")
		elseif a == 14 then func.MsgBox({"map01", "halos1", a}, {"if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 4) elseif n==3 then level.CommSpeak(0, 16) end", "1", "2", "3"}, "dlgbox")
		elseif a == 15 then func.MsgBox({"map01", "halos1", a}, {"if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 14) elseif n==3 then level.CommSpeak(0, 6) end", "1", "2", "3"}, "dlgbox") 
		elseif a == 16 then func.MsgBox({"map01", "halos1", a}, {"level.CommSpeak(0, 4)"}, "dlgbox")
		end;
	elseif part == 1 then
--		if a == 1 then func.MsgBox(func.Read("map01", "halos2", a)..main.characters[const.playerName].inventory.items.battery..".", {"level.CommSpeak('exit')", "1"}, "dlgbox")
		if a == 1 then local n = math.random(1, 6); func.object.Speak("ourwarrior3_tank", {"map01", "halos_settler_speaks", n}); pushcmd(function() level.CommSpeak("exit") end, 3)
		elseif a == 2 then func.MsgBox({"map01", "halos2", a}, {"func.ConfiscateItem('battery', const.playerName, 4); func.GiveItem('boo', const.playerName, 2); level.CommSpeak(1, 3)", "1"}, "dlgbox")
		elseif a == 3 then func.MsgBox({"map01", "halos2", a}, {"if n==2 then level.CommSpeak(1, 4) else level.CommSpeak(1, 20) end", "1", "2"}, "dlgbox")
		elseif a == 4 then func.MsgBox({"map01", "halos2", a}, {"level.CommSpeak(1, 20)", "1"}, "dlgbox")
		elseif a == 5 then func.MsgBox({"map01", "halos2", a}, {"level.CommSpeak('exit')"}, "dlgbox")
		elseif a == 6 then func.MsgBox({"map01", "halos2", a}, {"if level.screenplay.ranonAttackedBandits then level.CommSpeak(1, 7) else level.CommSpeak(1, 21) end", "1"}, "dlgbox")
		elseif a == 7 then func.MsgBox({"map01", "halos2", a}, {"if n==2 then level.CommSpeak(1, 8) else level.CommSpeak('exit') end", "1", "2"}, "dlgbox")
		elseif a == 8 then func.MsgBox({"map01", "halos2", a}, {"level.CommSpeak(1, 9)", "1"}, "dlgbox")
		elseif a == 9 then func.MsgBox({"map01", "halos2", a}, {"level.CommSpeak(1, 10)", "1"}, "dlgbox")
		elseif a == 10 then func.MsgBox({"map01", "halos2", a}, {"level.CommSpeak('exit')"}, "dlgbox")
		elseif a == 11 then func.MsgBox({"map01", "halos2", a}, {"if n==1 then level.CommSpeak(1, 13) elseif n==2 then level.CommSpeak(1, 12) end"}, "dlgbox")
		elseif a == 12 then func.MsgBox({"map01", "halos2", a}, {"if n==1 then level.CommSpeak('exit') elseif n==2 then level.CommSpeak(1, 14) end"}, "dlgbox")
		elseif a == 13 then func.MsgBox({"map01", "halos2", a}, {"level.CommSpeak('exit')"}, "dlgbox")
		elseif a == 14 then func.MsgBox({"map01", "halos2", a}, {"level.CommSpeak('exit')"}, "dlgbox")
		elseif a == 15 then func.MsgBox({"map01", "halos2", a}, {"level.CommSpeak('exit')"}, "dlgbox")
		elseif a == 16 then func.MsgBox({"map01", "halos2", a}, {"level.CommSpeak('exit')"}, "dlgbox")
		elseif a == 20 then func.MsgBox({"map01", "halos2", a}, {"func.GiveItem('bomb', const.playerName); level.CommSpeak('exit')"}, "dlgbox")
		elseif a == 21 then func.MsgBox({"map01", "halos2", a}, {"level.CommSpeak('exit')", "1"}, "dlgbox")
		end;
	elseif part == "exit" then 
		pushcmd(function() 
			pset('c_trig', 'active', 1)
--			if level.screenplay.missionBoo == 0 then --Не думаю, что это нужно. Slava98.
--          pset("c_trig", "on_enter", "level.CommSpeak(1, 1)") --Здесь потом другое будет. Slava98.
			if level.screenplay.missionBoo == 1 then
				pset("c_trig", "on_enter", "level.CommSpeak(1, 1)")
			elseif level.screenplay.missionBoo == 2 or level.screenplay.missionKey == 1 then
--				kill("cklad") -- Надо переименовать. Определённо. Завтра займусь этим, если не пойду гулять с девушкой. Slava98. 25.08.13.
				if not level.screenplay.halosHasGotBoos then
					pset("c_trig", "on_enter", "level.CommSpeak(1, 5)")
					level.screenplay.halosHasGotBoos = true;
--					level.screenplay.missionBoo = 3;
					level.Door("warehouse_open")
				else
					if level.functions.sidedoorStatus ~= 4 then
						pset("c_trig", "on_enter", "level.CommSpeak(1, 5)")
					else
						level.screenplay.DoorRepairerCall()
						pushcmd(level.screenplay.Attack, 3)
					end;
				end
			end;
		end, 5)
	end;
end

function level.SettlerSpeak(a)
        if a == "hello" then
                func.dialog.Show("settler_dlg", "map01", 1, "", "if n==1 then level.screenplay.SettlerCall('open') elseif n==2 then level.SettlerSpeak('angry_warrior') elseif n==3 then level.SettlerSpeak('what1') end", "1", "2", "3")
        elseif a == "angry_warrior" then
                func.Message({"map01", "settler_dlg", 5})
                level.screenplay.SettlerCall(a)
--              level.RioterAttack(3)                   
        elseif a == "what1" then
                func.dialog.Show("settler_dlg", "map01", 2, "", "if n==1 then level.screenplay.SettlerCall('open') elseif n==2 then level.SettlerSpeak('angry_warrior') elseif n==3 then level.SettlerSpeak('what2') end", "1", "2", "3")
        elseif a == "what2" then
                func.dialog.Show("settler_dlg", "map01", 3, "", "if n==1 then level.screenplay.SettlerCall('open') elseif n==2 then level.SettlerSpeak('angry_warrior') elseif n==3 then level.SettlerSpeak('what3') end", "1", "2", "3")
        elseif a == "what3" then
        func.Message({"map01", "settler_dlg", 4})
        pushcmd(function() level.SettlerSpeak('angry_warrior') end, 2)                  
                
        end
end

function level.SettlerSpeak(a)
	if a == 1 then func.MsgBox({"map01", "settler_dlg", a}, {"if n==1 then level.SettlerSpeak(4) elseif n==2 then level.SettlerSpeak('angry') elseif n==3 then level.SettlerSpeak(2) end", "1", "2", "3"}, "dlgbox")                
	elseif a == 2 then func.MsgBox({"map01", "settler_dlg", a}, {"if n==1 then level.SettlerSpeak(4) elseif n==2 then level.SettlerSpeak('angry') elseif n==3 then level.SettlerSpeak(3) end", "1", "2", "3"}, "dlgbox")
	elseif a == 3 then func.MsgBox({"map01", "settler_dlg", a}, {"if n==1 then level.SettlerSpeak(4) elseif n==2 then level.SettlerSpeak('angry') elseif n==3 then level.SettlerSpeak('tired') end", "1", "2", "3"}, "dlgbox")
	elseif a == 4 then func.MsgBox({"map01", "settler_dlg", a}, {"level.TerminalSpeak('settle', 4)", "1"}, "dlgbox")
	elseif a == "tired" then func.object.Speak("ourwarrior1_tank", "map01", "settler_cutSceneSpeaks", 1, nil, 2); pushcmd(function() level.SettlerSpeak('angry') end, 2)                  
	elseif a == "angry" then func.object.Speak("ourwarrior1_tank", "map01", "settler_cutSceneSpeaks", 2); level.screenplay.SettlerCall(a); --level.RioterAttack(3)   
	elseif a == 5 then func.MsgBox({"map01", "settler_dlg", a}, {"level.TerminalSpeak('settle', 4)", "1"}, "dlgbox")
	elseif a == "door_lagging" then
		func.object.Speak("ourwarrior1_tank", {"map01", "settler_cutSceneSpeaks", 4}, 1)
		pushcmd(function()
			func.object.Speak("ourwarrior1_tank", {"map01", "settler_cutSceneSpeaks", 5})
		end, 4)
		pushcmd(function()
			func.object.Speak("ourwarrior1_tank", {"map01", "settler_cutSceneSpeaks", 6})
			func.NPC.FollowWay("ourwarrior1", "base_patrol1")
		end, 20)
	end;
end

function level.TerminalSpeak(terminal, a)
	if terminal == "settle" then
		if a == "call" then
			if level.screenplay.playerKnowsAboutTerminal then func.Message({"map01", "promt", 2}); level.screenplay.playerKnowsAboutTerminal = true; end;
			if not level.screenplay.ourwarrior5WasTalked then level.TerminalSpeak("settle", 3)
			elseif level.screenplay.playerMustPressPassword and not level.screenplay.playerCanRideToSettle then level.TerminalSpeak("settle", 4)
			end;
		elseif a == 3 then func.MsgBox({"map01", "terminals", a}, {"if n==1 then level.screenplay.SettlerCall('speak'); object('d_trig').active=0; end", func.Read({"map01", "terminals", 1}), func.Read({"map01", "terminals", 2})}, "dlgbox")
		elseif a == 4 then func.MsgBox({"map01", "terminals", a}, {"if n==1 then level.screenplay.SettlerCall('open') elseif n==2 then level.TerminalSpeak('settle', 5) elseif n==3 then --[[level.RioterAttack(3)]] end", "1", "2", "3"}, "dlgbox")
		elseif a == 5 then func.MsgBox({"map01", "terminals", a}, {"if n==1 then level.screenplay.SettlerCall('open') elseif n==2 then level.TerminalSpeak('settle', 5) elseif n==3 then --[[level.RioterAttack(3)]] end", "1", "2", "3"}, "dlgbox")
		end;
	end;
end

function level.RanonSpeak(a)
	if a == 2 then func.MsgBox({"map01", "ranon", a}, {"if n==1 then level.RanonSpeak(3) elseif n==2 then level.RanonSpeak(8) end", "1", "2"}, "dlgbox")
	elseif a == 3 then func.MsgBox({"map01", "ranon", a}, {"if n==1 then level.RanonSpeak(4) elseif n==2 then level.RanonSpeak(5) elseif n==3 then level.RanonSpeak(7) end", "1", "2", "3"}, "dlgbox")
	elseif a == 4 then func.MsgBox({"map01", "ranon", a}, {"if n==1 then level.screenplay.SettlerNearRuins('goto_settle') else level.RanonSpeak(6) end", "1", "2"}, "dlgbox")
	elseif a == 5 then func.MsgBox({"map01", "ranon", a}, {"if n==1 then level.screenplay.SettlerNearRuins('goto_settle') else level.screenplay.SettlerNearRuins('go_away') end", "1", "2"}, "dlgbox")
	elseif a == 6 then func.MsgBox({"map01", "ranon", a}, {"if n==1 then level.screenplay.SettlerNearRuins('goto_settle') else level.screenplay.SettlerNearRuins('go_away') end", "1", "2"}, "dlgbox")
	elseif a == 7 then func.MsgBox({"map01", "ranon", a}, {"if n==1 then level.screenplay.SettlerNearRuins('goto_settle') else level.screenplay.SettlerNearRuins('go_away') end", "1", "2"}, "dlgbox")
	elseif a == 8 then func.MsgBox({"map01", "ranon", a}, {"if n==1 then level.screenplay.SettlerNearRuins('go_away') elseif n==2 then level.RanonSpeak(20) elseif n==3 then level.RanonSpeak(9) end", "1", "2", "3"}, "dlgbox")
	elseif a == 9 then func.MsgBox({"map01", "ranon", a}, {"if n==1 then level.RanonSpeak(20) elseif n==2 then level.RanonSpeak(10) elseif n==3 then level.RanonSpeak(11) end", "1", "2", "3"}, "dlgbox")
	elseif a == 10 then func.MsgBox({"map01", "ranon", a}, {"if n==1 then level.screenplay.SettlerNearRuins('go_away') elseif n==2 then level.RanonSpeak(20) elseif n==3 then level.screenplay.SettlerNearRuins('attack_player') end", "1", "2", "3"}, "dlgbox")
	elseif a == 11 then func.MsgBox({"map01", "ranon", a}, {"if n==1 then level.RanonSpeak(12) elseif n==2 then level.RanonSpeak(19) elseif n==3 then level.RanonSpeak(20) end", "1", "2", "3"}, "dlgbox")
	elseif a == 12 then func.MsgBox({"map01", "ranon", a}, {"level.RanonSpeak(13)", "1"}, "dlgbox")
	elseif a == 13 then func.MsgBox({"map01", "ranon", a}, {"if n==1 then level.RanonSpeak(14) elseif n==2 then level.RanonSpeak(15) elseif n==3 then level.RanonSpeak(16) end", "1", "2", "3"}, "dlgbox")
	elseif a == 14 then func.MsgBox({"map01", "ranon", a}, {"if n==1 then level.screenplay.SettlerNearRuins('attack_player') elseif n==2 then level.RanonSpeak(16) elseif n==3 then level.RanonSpeak(17) end", "1", "2", "3"}, "dlgbox")
	elseif a == 15 then func.MsgBox({"map01", "ranon", a}, {"if n==1 then level.screenplay.SettlerNearRuins('go_away') elseif n==2 then level.RanonSpeak(16) end", "1", "2"}, "dlgbox")
	elseif a == 16 then func.MsgBox({"map01", "ranon", a}, {"if n==1 then level.RanonSpeak(17) elseif n==2 then level.screenplay.SettlerNearRuins('go_away') elseif n==3 then level.RanonSpeak(18) end", "1", "2", "3"}, "dlgbox")
	elseif a == 17 then func.MsgBox({"map01", "ranon", a}, {"level.screenplay.SettlerNearRuins('attack_player')", "1", "2", "3"}, "dlgbox")
	elseif a == 18 then func.MsgBox({"map01", "ranon", a}, {"level.screenplay.SettlerNearRuins('show_boss')"}, "dlgbox")
	elseif a == 19 then func.MsgBox({"map01", "ranon", a}, {"if n==1 then level.screenplay.SettlerNearRuins('go_away') elseif n==2 then level.RanonSpeak(20) elseif n==3 then level.screenplay.SettlerNearRuins('attack_player') end", "1", "2", "3"}, "dlgbox")
	elseif a == 20 then func.MsgBox({"map01", "ranon", a}, {"if n==1 then level.RanonSpeak(5) elseif n==2 then level.RanonSpeak(4) elseif n==3 then level.RanonSpeak(7) end", "1", "2", "3"}, "dlgbox")
	end;
end
