--[[function level.CommSpeak(a)
        if a == 1 then
                object("ourwarrior2_speak").active = 0 
                object("ourwarrior2_speak").on_enter = "level.CommSpeak(2)"
                func.dialog.Show("halos", "test", 1, "", "object('ourwarrior2_speak').active = 1; func.SetWeap('ourplayer_tank','weap_minigun')", "OK")
--              service("msgbox", {
--                                                      on_select="object('ourwarrior2_speak').active = 1; func.SetWeap('ourplayer_tank','weap_minigun')", 
--                                                      text="Халос: Спасибо, что спас меня от сошедшей с ума турели.\nВот, держи пулемёт и уничтожь те дураукие ящики.",  
--                                                      option1="1" } )
        elseif a == 2 then
                func.Message("halos", "test", 2)
        end
end]]


function level.CommSpeak(part, a)
        pset('c_trig', 'active', 0)
        if part == 0 then
                if a == 1 then func.dialog.Show("halos1", "map01", a, "", "if n==1 then level.CommSpeak(0, 2) elseif n==2 then level.CommSpeak(0, 2) elseif n==3 then level.CommSpeak(0, 7) end", "1", "2", "3")
                elseif a == 2 then func.dialog.Show("halos1", "map01", a, "", "if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 4) elseif n==3 then level.CommSpeak(0, 6) end", "1", "2", "3")
                elseif a == 3 then func.dialog.Show("halos1", "map01", a, "", "if n==1 then level.CommSpeak(0, 13) elseif n==2 then level.CommSpeak(0, 5) end", "1", "2")
                elseif a == 4 then func.dialog.Show("halos1", "map01", a, "", "level.screenplay.missionplate=1;level.CommSpeak('exit')")
                elseif a == 5 then func.dialog.Show("halos1", "map01", a, "", "level.screenplay.missionplate=1;level.CommSpeak('exit')")
                elseif a == 6 then func.dialog.Show("halos1", "map01", a, "", "if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 4) elseif n==3 then level.CommSpeak(0, 7) end", "1", "2", "3")
                elseif a == 7 then func.dialog.Show("halos1", "map01", a, "", "if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 4) elseif n==3 then level.CommSpeak(0, 8) end", "1", "2", "3")
                elseif a == 8 then func.dialog.Show("halos1", "map01", a, "", "if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 4) elseif n==3 then level.CommSpeak(0, 9) end", "1", "2", "3")
                elseif a == 9 then func.dialog.Show("halos1", "map01", a, "", "if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 4) elseif n==3 then level.CommSpeak(0, 10) end", "1", "2", "3")
                elseif a == 10 then func.dialog.Show("halos1", "map01", a, "", "level.CommSpeak(0, 11)", "1")
                elseif a == 11 then func.dialog.Show("halos1", "map01", a, "", "if n==1 then level.CommSpeak(0, 3) elseif n==2 then level.CommSpeak(0, 12) elseif n==3 then level.OurWarriorsAttackPlayer('ourplayer_tank') end", "1", "2", "3")
                elseif a == 12 then func.dialog.Show("halos1", "map01", a, "", "level.CommSpeak('exit')")
                elseif a == 13 then func.dialog.Show("halos1", "map01", a, "", "level.GetMissionBoo(); level.CommSpeak('exit')")
                end
        elseif part == 1 then
                if a == 1 then func.dialog.Show("halos2", "map01", a, level.screenplay.energycells, "level.CommSpeak('exit')", "1")
                elseif a == 2 then func.dialog.Show("halos2", "map01", a, "", "level.CommSpeak(1, 3)", "1")
                elseif a == 3 then func.dialog.Show("halos2", "map01", a, "", "if n==2 then level.CommSpeak(1, 4) else level.screenplay.missionboo = 3 level.Door('sidedoor_lagging') pset('c_trig','active',0) level.CommSpeak('exit') end", "1", "2")
                elseif a == 4 then func.dialog.Show("halos2", "map01", a, "", "if n==1 then level.CommSpeak('exit') elseif n==2 then level.CommSpeak('exit') end")
                elseif a == 5 then func.dialog.Show("halos2", "map01", a, "", "if n==1 then level.CommSpeak('exit') elseif n==2 then level.CommSpeak(1, 6) end", "1", "2")
                elseif a == 6 then func.dialog.Show("halos2", "map01", a, "", "level.CommSpeak(1, 7)", "1")
                elseif a == 7 then func.dialog.Show("halos2", "map01", a, "", "level.CommSpeak(1, 8)", "1")
                elseif a == 8 then func.dialog.Show("halos2", "map01", a, "", "level.CommSpeak(1, 9)", "1")
                elseif a == 9 then pushcmd( function() func.dialog.Show("halos2", "map01", a, "", "level.CommSpeak(1, 10)", "1") end, 2)
                elseif a == 10 then func.dialog.Show("halos2", "map01", a, "", "level.CommSpeak('exit')")
                elseif a == 11 then func.dialog.Show("halos2", "map01", a, "", "level.CommSpeak('exit')")
                elseif a == 12 then func.dialog.Show("halos2", "map01", a, "", "level.CommSpeak('exit')")
                elseif a == 13 then func.dialog.Show("halos2", "map01", a, "", "level.CommSpeak('exit')")
                elseif a == 14 then func.dialog.Show("halos2", "map01", a, "", "level.CommSpeak('exit')")
                elseif a == 15 then func.dialog.Show("halos2", "map01", a, "", "level.CommSpeak('exit')")
                end
        elseif part == "exit" then 
                pushcmd(function() 
                        pset('c_trig', 'active', 1)
--                      if level.screenplay.missionboo == 0 then --Не думаю, что это нужно. Slava98.
--                          pset("c_trig", "on_enter", "level.CommSpeak(1, 1)") --Здесь потом другое будет. Slava98.
                  --[[else]]if level.screenplay.missionboo == 1 then
                            pset("c_trig", "on_enter", "level.CommSpeak(1, 1)")
                        elseif level.screenplay.missionboo == 2 then
                            pset("c_trig", "on_enter", "level.CommSpeak(1, 2)")
                        elseif level.screenplay.missionboo == 3 --[[or level.screenplay.missionplate == 1]] then
--                          pset("c_trig", "on_enter", "level.CommSpeak(1, 5)")
						elseif level.screenplay.missionplate == 1 then
--							pset("c_trig", "on_enter", "level.CommSpeak(1, 5)")
							pset("c_trig", "active", 0)
							kill("cklad")
							for i = 1, 3 do kill("w"..i) end
						elseif level.screenplay.sidedoor_status == 3 then
							
						end
                end, 5)
        end
end

function level.SettlerSpeak(a)
        if a == "hello" then
                func.dialog.Show("settler_dlg", "map01", 1, "", "if n==1 then level.SettlerCall('open') elseif n==2 then level.SettlerSpeak('angry_warrior') elseif n==3 then level.SettlerSpeak('what1') end", "1", "2", "3")
        elseif a == "angry_warrior" then
                func.Message("settler_dlg", "map01", 5)
                level.SettlerCall(a)
--              level.RioterAttack(3)                   
        elseif a == "what1" then
                func.dialog.Show("settler_dlg", "map01", 2, "", "if n==1 then level.SettlerCall('open') elseif n==2 then level.SettlerSpeak('angry_warrior') elseif n==3 then level.SettlerSpeak('what2') end", "1", "2", "3")
        elseif a == "what2" then
                func.dialog.Show("settler_dlg", "map01", 3, "", "if n==1 then level.SettlerCall('open') elseif n==2 then level.SettlerSpeak('angry_warrior') elseif n==3 then level.SettlerSpeak('what3') end", "1", "2", "3")
        elseif a == "what3" then
        func.Message("settler_dlg", "map01", 4)
        pushcmd(function() level.SettlerSpeak('angry_warrior') end, 2)                  
                
        end
end