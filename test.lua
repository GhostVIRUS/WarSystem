-- Функции кампании War System
-- By Sl@v@98 and VIRUS

---------------------------Глобальные переменные--------------------------
local door = 0 -- 0 - первый раз открыть, 1 - открыть, 2 - закрыть
local timesOfDamages = 0
--local playertank=object("ourplayer_tank")
---
--------------------------------------------------------------------------
--------------------- Первый уровень -------------------------------------
--------------------------------------------------------------------------
--*Функция, переведённая из Old-версии.
function user.move1()
        sound("dr2_start")
        moveX(27,43,25,"b1",1,1,-1)
        moveX(27,44,25,"b2",1,1,-1)
        moveX(27,45,25,"b3",1,1,-1)
        moveX(21,45,23,"b4",1,1,1)
        moveX(21,44,23,"b5",1,1,1)
        moveX(21,43,23,"b6",1,1,1)
        pushcmd(function() sound("dr2_end") end, 4)
        pushcmd(function() pset("b11", "name", "g4") end, 3.9999)
        pushcmd(function() pset("b21", "name", "g3") end, 3.9999)
        pushcmd(function() pset("b31", "name", "g2") end, 3.9999)
        pushcmd(function() pset("b41", "name", "j2") end, 3.9999)
        pushcmd(function() pset("b51", "name", "j3") end, 3.9999)
        pushcmd(function() pset("b61", "name", "j4") end, 3.9999)
        pushcmd(function() moveY(23,42,38,"j",1,5,1) end, 4)
        pushcmd(function() moveY(25,46,50,"g",1,5,-1) end, 4)
end

function user.GivePlazma()
        pushcmd( function() message("Код принят!") end, 1)
        pushcmd( function() sound("dr3") end, 2)
        pushcmd( function() moveY(19,4,1,"br",3,6,1) end, 2)
end 

function user.GivePlasmaExit()
		pset("trig6", "active", 0)
        pset("br3", "name", "br_ex1")
        pset("br4", "name", "br_ex2")
        pset("br5", "name", "br_ex3")
        pset("br6", "name", "br_ex4")
        pushcmd( function() sound("dr3") end, 0.2)
        pushcmd(function() moveY(19,4,7,"br_ex",1,4,-1) end, 0.2)
end

---------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------Дверь-----------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------

--*Недописанная (верне, вообще ненаписанная =) VIRUS'ом функция открывания двери. (31.10.10, Sl@v@98)
--*Начинаю писать функцию. (9.11.11, Sl@v@98)
function user.SpeakDoor()
        if level1.unnamedestroy==1 then user.RioterKill()
        else
                pset("ourwarrior1", "active", 0) 
                message ("Подсказка: Похоже, это микрофон. Скоро должны Вам ответить.")
                pushcmd(function() ai_march("ourwarrior1", 31*32, 17*32) end, 0.1)
                pushcmd(function() ai_march("ourwarrior1", 30*32, 17*32) end, 4.5)
                pushcmd(function() 
                        service("msgbox", {
                                name="msbox", 
                                text="Поселенец:\n Говорите. Кто это?\n 1)Я разведчик из ЭВЭ.\n 2)Я собираюсь уничтожить это место!\n 3)Привет!", 
                                on_select="if n==1 then user.OpenDoor() elseif n==2 then user.OpenDoorAndPredatel() elseif n==3 then user.OpenDoorWhat() end", 
                                option1="1", 
                                option2="2", 
                                option3="3" } ) 
                end, 5)
        end
end 

function user.OpenDoor()
        if  level1.commspeak.door_close==1 then
                level1.commspeak.door_close=2
                pushcmd(function() ai_march("ourwarrior1", 32*32, 16*32) end, 0.1)
                pushcmd(function() message("Поселенец: Похоже дверь заглючило. Пока подождите здесь.") end, 2)
                pushcmd(function() func.ActionWarrior(1, 2) end, 3)
--              pset("commenger1", "active", 1)
        elseif  level1.commspeak.door_close==0 then
                if door == 0 then
                        main.missions.extraMission = "1)Поговорите с командиром поселения."
                        message("Задания обновлены.")
                        pushcmd( function() pset("trig1", "active", 0) end, 0.5)
                        pushcmd( function() message("Поселенец: Проезжай и доложи нашему командиру о своём присутствии.") end, 1)
                        pushcmd( function() sound("door") end, 1)
                        pushcmd( function() moveX(28,17,29,"brick",1,1,1)  
                                                                moveX(28,18,29,"brick",2,2,1) end, 1)
                        pushcmd( function() moveY(29,17,16,"brick",2,2,-1) 
                                                                moveY(29,18,19,"brick",1,1,1) end, 2)
                        pushcmd( function() sound("door") end, 2)
--pset("ourwarrior1", "active", 1)
                        pushcmd(function() func.ActionWarrior(1, 2) end, 3)
                        pushcmd(function()
                                pset("trig2", "active", 1)
                                door = 2
                        end, 3.5)
                        pushcmd(function() pset("trig2", "active",1) end, 3)
                else
                        if door == 1 then
                                pushcmd( function() pset("trig1", "active", 0) end, 0.5)
                                pushcmd( function() moveX(28,17,29,"brick",1,1,1)  
                                                                        moveX(28,18,29,"brick",2,2,1) end, 1)
                                pushcmd( function() sound("door") end, 1)
                                pushcmd( function() moveY(29,17,16,"brick",2,2,-1) 
                                                                        moveY(29,18,19,"brick",1,1,1) end, 2)
                                pushcmd( function() sound("door") end, 2)
                                pushcmd(function()
                                        pset("trig2", "active", 1)
                                        door = 2
                                end, 3.5)
                        else
                                pushcmd(function() user.OpenDoor() end, 1)
                        end
                end
        end
end

function user.CloseDoor()
        if door == 2 then
                pushcmd( function() pset("trig2", "active", 0) end, 0.5)
                pushcmd( function() moveY(29,16,17,"brick",2,2,1) 
                                                        moveY(29,19,18,"brick",1,1,1) end, 1)
                pushcmd( function() sound("door") end, 1)
                pushcmd( function() moveX(29,17,28,"brick",1,1,1)  
                                                        moveX(29,18,28,"brick",2,2,-1) end, 2)
                pushcmd( function() sound("door") end, 2)
                pushcmd(function()
                        pset("trig1", "active", 1)
                        door = 1
                end, 3.5)
        else
                pushcmd( function() user.CloseDoor() end, 1)
        end
end

function user.OpenDoorAndPredatel()
-- Скоро прийдется это сделать
        level1.rioterplay.verity=1
        pset("statue", "max_health", 0)
        pset("statue", "health", 0)
        func.ActionWarrior(1, 2)
        pset("c_trig1", "active", 0)
        message("Добавлена дополнительная миссия.")
        message("Поселенец: Вали отсюда пока жив!")
        main.missions.extraMission = "1)Держаться подальше от поселения."
        pushcmd(function() 
		pset("ourplayer","team", 2) 
		pset("ourwarrior1","level", 4) 
		pset("ourwarrior2","level", 4) 
		pset("ourwarrior3","level", 4) 
		pset("ourwarrior4","level", 4) 
		user.LetDamageOurWarrior(0)
		end, 2)
--user.GetEnemyAttack()
        user.RioterAttack()
end

function user.OpenDoorWhat()
		if exists("msbox") then kill("msbox") end
        service("msgbox", {
                name="msbox",
                text="Поселенец:\n Хватит шутить! Кто это?\n 1)Да ладно! Я из разведки ЭВЭ по приказу генерала Орона.\n 2)Открой! А то взорву тут все!!!\n 3)Привет, говорю!",
                on_select="if n==1 then user.OpenDoor() elseif n==2 then user.OpenDoorAndPredatel() elseif n==3 then user.OpenDoorWhat2() end",  
                option1="1", 
                option2="2", 
                option3="3" } )
end

function user.OpenDoorWhat2()
		if exists("msbox") then kill("msbox") end
        service("msgbox", {
                name="msbox",
                text="Поселенец:\n Я в последний раз спрашиваю, кто вы?!\n 1)Ну хорошо! Я из разведки ЭВЭ.\n 2)Короче, хана Вам ребятушки!\n 3)Ну привет!!!",
                on_select="if n==1 then user.OpenDoor() elseif n==2 then user.OpenDoorAndPredatel() elseif n==3 then user.OpenDoorWhat3() end",  
                option1="1", 
                option2="2", 
                option3="3" } ) -- "Я сегодня сам не свой!" XD
end

function user.OpenDoorWhat3()
        message("Поселенец: Всё! Надоел!")
        pushcmd(function() user.OpenDoorAndPredatel() end, 2)
end

---------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------Уничтожение ботов-----------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------

function user.ConversionEnemy()
        if level1.enemyattack.units==4 then
                message("Одна единица неизвестного врага была уничтожена. ")
        elseif level1.enemyattack.units==3 then
                message("Две единицы неизвестного врага были уничтожены.")
        elseif level1.enemyattack.units==2 then
                message("Три единицы неизвестного врага были уничтожены.")
        elseif level1.enemyattack.units==1 then
                message("Четыре единицы неизвестного врага были уничтожены.")
        elseif level1.enemyattack.units==0 then
                user.KillAllEnemyL1()
        end
end

function user.DieEnemy1()
        kill("enemy1")
        kill("enemyweap1")
        level1.enemyattack.units=level1.enemyattack.units-1
        user.ConversionEnemy()
end

function user.DieEnemy2()
        kill("enemy2")
        kill("enemyweap2")
        level1.enemyattack.units=level1.enemyattack.units-1
        user.ConversionEnemy()
end

function user.DieEnemy3()
        kill("enemy3")
        kill("enemyweap3")
        level1.enemyattack.units=level1.enemyattack.units-1
        user.ConversionEnemy()
end

function user.DieEnemy4()
        kill("enemy4")
        kill("enemyweap4")
        level1.enemyattack.units=level1.enemyattack.units-1
        user.ConversionEnemy()
end

function user.DieEnemy5()
        x1, y1 = position("boss_tank")
        kill("enemy_boss")
        kill("enemyweap5")
--level1.enemyattack.boss=0
        level1.enemyattack.units=level1.enemyattack.units-1
        message("Босс врагов убит.")
        if level1.sputnik.verity == 0 then
                actor("user_sprite", x1, y1, { name="shocker1", texture="user/bomb", layer=1 } )
--actor("trigger", x1, y1, { name="shocktrig2", on_enter="user.shockin()", only_human=1 })
        else
        end
	user.ConversionEnemy()
end

function user.KillAllEnemyL1()
        level1.enemyattack.happened=0
        enemyattack1=1
        if level1.sputnik.verity == 0 then
				if exists("msbox") then kill("msbox") end
                service("msgbox", {
                        name="msbox", 
                        text="\nВсе единицы врага были уничтоженны. \nОни использовали взрывчатку. \nОсмотрите обломки их главаря. \nТам может быть то что вам нужно\n" } ) 
                actor("trigger", x1, y1, { name="shocktrig2", on_enter="user.shockin()", only_human=1 } )      
        else
        end
        message("Основное задание выполнено.")
        main.missions.mainMission="1)Найдите энергон в этих местностях. \n2)Свяжитесь с Ороном и сообщите обстановку.\n3)Защитите боевое поселение Экиваторов от врагов! (Выполнено)\n4)Сохраните сержанта Халоса! (Выполено)"
        play"mus5"
        pset("c_trig3", "active", 1)
--		pset("trig10", "active", 1)
        if net==1 then
                pset("c_trig2", "active", 1)
        else
        end
        if exists ("ourwarrior_tank1") == true then
                pset("ourwarrior1", "active", 0)
                func.ActionWarrior(1, 2)
		end
        if exists ("ourwarrior_tank2") == true then
                pset("ourwarrior2", "active", 0)
                func.ActionWarrior(2, 2)
		end
		if exists ("ourwarrior_tank4") == true then
                pset("ourwarrior4", "active", 0)
				ai_march("ourwarrior1", 50*32, 3*32)
        end
	if level1.commWasActive==1 then
		pset("ourwarrior3", "active", 0)
		ai_march("ourwarrior3", user.get32(69), user.get32(3))
		pushcmd(function() ai_march("ourwarrior3", user.get32(69), user.get32(3)) end, 6)
	end
end

-------------------------------------------

function user.ConversionRioter()
        if level1.enemyattack.units==4 then
                message("Один неизвестный воин была уничтожен. ")
        elseif level1.enemyattack.units==3 then
                message("Две неизвестного воина были уничтожено.")
        elseif level1.enemyattack.units==2 then
                message("Три неизвестных воина были уничтожено.")
        elseif level1.enemyattack.units==1 then
                message("Четыре неизвестных воинов были уничтожено.")
        elseif level1.enemyattack.units==0 then
                user.IfRioterWasKilling()
        end
end

function user.DieRioter1()
        kill("enemy1")
        kill("enemyweap1")
        level1.enemyattack.units=level1.enemyattack.units-1
        user.ConversionRioter()
end

function user.DieRioter2()
        kill("enemy2")
        kill("enemyweap2")
        level1.enemyattack.units=level1.enemyattack.units-1
        user.ConversionRioter()
end

function user.DieRioter3()
        kill("enemy3")
        kill("enemyweap3")
        level1.enemyattack.units=level1.enemyattack.units-1
        user.ConversionRioter()
end

function user.DieRioter4()
        kill("enemy4")
        kill("enemyweap4")
        level1.enemyattack.units=level1.enemyattack.units-1
        user.ConversionRioter()
end

function user.DieRioter5()
        x1, y1 = position("p_boss")
        kill("enemy_boss")
        kill("enemyweap5")
----    level1.enemyattack.boss=0
--      level1.enemyattack.units=level1.enemyattack.units-1
--      user.ConversionRioter()
		message("Главарь уничтожен, вы проиграли!")
		main.missions.extraMission = "1)Найти пасхалку (Выполнено)"
        user.Lose()
end
--end

function user.IfRioterWasKilling()
        if level1.rioter.enemy == 1 then
                main.missions.mainMission="1)Найдите энергон в этих местностях. \n2)Свяжитесь с Ороном и сообщите обстановку.\n3)Защитите боевое поселение Экиваторов от врагов! (Выполнено)\n4)Сохраните сержанта Халоса! (Выполено)"
        else
                message("Все войны уничтожены, вы проиграли!")
                main.missions.extraMission = "1)Найти пасхалку (Выполнено)"
                user.Lose()
        end
end

function user.DamageRioter(who)
        local attacker = who.name
        if attacker == ("ourplayer_tank") then 
                timesOfDamages = timesOfDamages + 1
                if  timesOfDamages == 1 then
                        message("Воин: Эй! Не стреляй по своим!!")
                elseif timesOfDamages == 2 then
                        message("Воин: Ты что не понял?! Не стреляй по поселенцам!!!")
                elseif timesOfDamages == 3 then
                        message("Воин: Последнее предупреждение! Хватит стрелять по своим!!!")
                elseif timesOfDamages > 3 then
                         if exists ("boss_tank") == true then
                          message("Главарь войнов: Он предатель, бей его!")
                          if exists("enemy_tank1") == true or exists("enemy_tank2") == true or exists("enemy_tank3") == true or exists("enemy_tank4") == true then
                           message("Войн: Я всегда не доверял ЭВЭ.")
                          end
                         else
                          message("Войн: Он предатель, бей его!")
                         end
--                      pset("ourplayer", "team", 2)
--                      pset("ourwarrior3", "active", 1)
--                      pset("ourwarrior4", "active", 1)
--                      pset("ourwarrior2", "active", 1)
--                      pset("ourwarrior1", "active", 1)
--                      level1.enemyattack.unitsAttack()
                end
        end
end

-------------------------------------------

function user.DamageOurWarrior(who)
        local attacker = who.name
        if attacker == ("ourplayer_tank") then 
                timesOfDamages = timesOfDamages + 1
                if  timesOfDamages == 1 then
                        message("Поселенец: Эй! Не стреляй по своим!!")
--                       user.LetDamageOurWarrior(0)
--                      pushcmd (function()  user.LetDamageOurWarrior(1) end, 3)
--          pushcmd (function() timesOfDamages =0 end, 5)
                elseif timesOfDamages == 2 then
                        message("Поселенец: Ты что не понял?! Не стреляй по поселенцем!!!")
--                       user.LetDamageOurWarrior(0)
--                      pushcmd (function()  user.LetDamageOurWarrior(1) end, 2)
--            pushcmd (function() timesOfDamages =0 end, 10)
                elseif timesOfDamages == 3 then
                        message("Поселенец: Последнее предупреждение! Хватит стрелять по своим!!!")
--                       user.LetDamageOurWarrior(0)
--                      pushcmd (function()  user.LetDamageOurWarrior(1) end, 1)
--            pushcmd (function() timesOfDamages =0 end, 15)
                elseif timesOfDamages > 3 then
                        message("Командир поселенцев: Он предатель, бей его!")
						user.LetDamageOurWarrior(0)
                        pset("ourplayer", "team", 2)
                        pset("ourwarrior3", "active", 1)
                        pset("ourwarrior4", "active", 1)
                        pset("ourwarrior2", "active", 1)
                        pset("ourwarrior1", "active", 1)
                        user.RioterAttack()
                end
        end
end

function user.LetDamageOurWarrior(num)
        if num == nil then
                return 0
        elseif num == 0 then
                pset("ourwarrior_tank1", "on_damage", "")
                pset("ourwarrior_tank2", "on_damage", "")
                pset("ourwarrior_tank3", "on_damage", "")
                pset("ourwarrior_tank4", "on_damage", "")
        elseif num == 1 then
                pset("ourwarrior_tank1", "on_damage", "user.DamageOurWarrior(who)")
                pset("ourwarrior_tank2", "on_damage", "user.DamageOurWarrior(who)")
                pset("ourwarrior_tank3", "on_damage", "user.DamageOurWarrior(who)")
                pset("ourwarrior_tank4", "on_damage", "user.DamageOurWarrior(who)")
        end
end

function user.ConversionWarriors()
        if level1.warriors==3 then
                message("Один воин поселения Экиваторов погиб.")
        elseif level1.warriors==2 then
                message("Два война поселения Экиваторов погибло.")
        elseif level1.warriors==1 then
                message("Три война поселения Экиваторов погибли.")
        elseif level1.warriors==0 then
                message("Все войны поселения Экиваторов погибли.")
                if level1.rioterplay.verity == 1 then
                        user.IfEkivatorsWasKilling()
                else
                        user.Lose()
                end
        end
end

function user.M1OnDieBot1()
        kill("ourwarrior1")
        kill("nyshka1")
        level1.warriors=level1.warriors-1
-- message("Один наш войн погиб.")
        user.ConversionWarriors()
end

function user.M1OnDieBot2()
        kill("ourwarrior2")
        kill("nyshka2")
        level1.warriors=level1.warriors-1
-- message("Один наш войн погиб.")
        user.ConversionWarriors()
end

function user.M1OnDieBot3()
        kill("ourwarrior3")
        kill("nyshka3")
        if level1.rioterplay.verity==0 then 
                user.Lose()
        else
                level1.warriors=level1.warriors-1
--              message("Один наш войн погиб.")
                user.ConversionWarriors()
        end
end

function user.M1OnDieBot4()
        kill("ourwarrior4")
        kill("nyshka4")
        level1.warriors=level1.warriors-1
-- message("Один наш войн погиб.")
        user.ConversionWarriors()
end

---------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------Активность ботов------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------

function user.M1ActionBot1_1()
        if exists ("ourwarrior_tank1") == true then
                ai_march("ourwarrior1", 29*32, 12*32)
        end
end

function user.M1ActionBot1_2()
        if exists ("ourwarrior_tank1") == true then
                ai_march("ourwarrior1", 41*32, 11*32)
        end
end

function user.M1ActionBot2_1()
        if exists ("ourwarrior_tank2") == true then
                ai_march("ourwarrior2", 54*32, 12*32)
 end
end

function user.M1ActionBot2_2()
        if exists ("ourwarrior_tank2") == true then
                ai_march("ourwarrior2", 65*32, 20*32)
        end
end

function user.M1ActionBot4_1()
	if level1.enemyattack.units==0 then
	else
        if exists ("ourwarrior_tank4") == true then
                ai_march("ourwarrior4", 36*32, 18*32)
        end
	end
end

function user.M1ActionBot4_2()
	if level1.enemyattack.units==0 then
	else
        if exists ("ourwarrior_tank4") == true then
                ai_march("ourwarrior4", 50*32, 3*32)
        end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------Разговор с ботами-----------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------

function user.hiwarrior1()
--      ustop=0
--		histop=1
--        user.hi1=0
        x,y=position("ourwarrior_tank1")
        actor("trigger", x+32, y, { name="hi11", on_enter="user.hiwarriorout1()", only_human=1 } )
        actor("trigger", x, y+32, { name="hi12", on_enter="user.hiwarriorout1()", only_human=1 } )
        actor("trigger", x-32, y, { name="hi13", on_enter="user.hiwarriorout1()", only_human=1 } )
        actor("trigger", x, y-32, { name="hi14", on_enter="user.hiwarriorout1()", only_human=1 } )
                if user.hi1==0 then
                    pushcmd(function() 
					kill("hi11") 
					kill("hi12") 
					kill("hi13") 
					kill("hi14") 
					user.hiwarrior1() end, 0.1)
				else
				end
end

function user.hiwarriorout1()
        if level1.rioterplay.verity==1 or level1.enemyattack.happened==1 then--or histop==0 then
        else
                user.hi1=1
--				histop=0
                ai_stop("ourwarrior1")
                if level1.energycells.missionboo==0 then
                        if math.random() > 0.5 then
                                message("Поселенец: Не мешай контролировать территорию.")
                        else
                                message("Поселенец: Доложи нашему командиру о своём присутствии.")
                        end
                elseif level1.energycells.missionboo==1 or level1.enemyattack.units==0 then
                        if math.random() > 0.5 then
                                message("Поселенец: Не мешайте контролировать территорию.")
                        else
                                message("Поселенец: Займитесь своей миссией.")
                        end
                elseif level1.energycells.missionboo==2 then
                        if math.random() > 0.5 then
                                message("Поселенец: Командир ждёт Вас.")
                        else
                                message("Поселенец: Вы собрали энергетические батареи?")
                        end
--                elseif level1.enemyattack.units==0 then
-----                      ustop=1
----              elseif ustop==1 then
--                        if math.random() > 0.5 then
--                                message("Поселенец: Не мешайте контролировать территорию.")
--                        else
--                                message("Поселенец: Займитесь своей миссией.")
--                        end
                end
                kill("hi11") 
                kill("hi12") 
                kill("hi13") 
                kill("hi14") 
--                if ustop==1 then
--                        service("msgbox", {
--                                on_select="if n==1 then user.uyes() elseif n==2 then user.uno() end", 
--                                text="Поселенец: Нужен усилитель?",  
--                                option1="Да", 
--                                option2="Нет" } )
--                end
        end
        pushcmd(function() user.hi1=0 ai_march("ourwarrior2", 65*32, 20*32) end, 1)
		pushcmd(function() user.hiwarrior1() end, 4)
end

function user.uyes()
        message("Получено: Усилитель оружия.")
		main.menu.Refresh()
        main.inventory.AddNumBoo(1)
        message("Поселенец: Пожалуйста, он Вам нужнее, чем мне.")
        pushcmd(function() user.hi=0 ai_march("ourwarrior1", user.get32(41), user.get32(11)) end, 1)
end

function user.uno()
        message("Поселенец: Не хотите, так умрите! =)")
        pushcmd(function() user.hi=0 ai_march("ourwarrior1", user.get32(41), user.get32(11)) end, 1)
end

function user.hiwarrior2()
        user.hi2=0
        x,y=position("ourwarrior_tank2")
        actor("trigger", x+32, y, { name="hi21", on_enter="user.hiwarriorout2()", only_human=1 } )
        actor("trigger", x, y+32, { name="hi22", on_enter="user.hiwarriorout2()", only_human=1 } )
        actor("trigger", x-32, y, { name="hi23", on_enter="user.hiwarriorout2()", only_human=1 } )
        actor("trigger", x, y-32, { name="hi24", on_enter="user.hiwarriorout2()", only_human=1 } )
        if user.hi2==0 then
                pushcmd(function() 
--              if exists("hi21") then kill("hi21") end
--              if exists("hi22") then kill("hi22") end
--              if exists("hi23") then kill("hi23") end
--              if exists("hi24") then kill("hi24") end
                kill("hi21") 
                kill("hi22") 
                kill("hi23") 
                kill("hi24") 
                user.hiwarrior2() end, 0.1)
        else
        end
end

function user.hiwarriorout2()
        if level1.rioterplay.verity==1 or level1.enemyattack.happened==1 then
        else
                user.hi2=1
                ai_stop("ourwarrior2")
                if level1.energycells.missionboo==0 or level1.energycells.missionboo==1 then
                        if math.random() > 0.5 then
                                message("Поселенец: Вы из ЭВЭ?")
                        else
                                message("Поселенец: У нас работы много.")
                        end
                end
                if level1.energycells.missionboo==2 then
                        if math.random() > 0.5 then
                                message("Поселенец: Командир ждёт Вас.")
                        else
                                message("Поселенец: Вы собрали энергетические батареи?")
                        end
                end
                if level1.enemyattack.units==0 then
                        if math.random() > 0.5 then
                                message("Поселенец: Кто это был?")
                        else
                                message("Поселенец: Спасибо, что помогли нам!")
                        end
                end
                kill("hi21") 
                kill("hi22") 
                kill("hi23") 
                kill("hi24") 
                pushcmd(function() user.hi=0 ai_march("ourwarrior2", 65*32, 20*32) end, 1)
                pushcmd(function() user.hiwarrior2() end, 4)
--end
        end
end

-------------------------------------------------------------------------Замена класса-------------------------------------------------------------------

function user.SpeakChange(scnum)
        if scnum==0 then
                playertank.class="player1"
        elseif scnum==1 then
                playertank.class="speak"
        end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------Ящики-----------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------

func={}

function func.GiveHP(hpnum)
        message("Вы нашли ПЭРК")
		main.menu.Refresh()
        main.inventory.AddNumHealthPack(1)	
        sound("pickup")		
        kill("bonus_healthpack"..hpnum)
        kill("bonushealthpack_trig"..hpnum)
end

function func.ShowHP(cratenum)
		func.hpnum=cratenum
        actor("user_sprite", x, y, {name="bonus_healthpack"..cratenum, texture="user/health", only_human=1 } )
        actor("trigger", x, y, {name="bonushealthpack_trig"..cratenum, on_enter="func.GiveHP(func.hpnum)", only_human=1 } )
end

function func.GiveMine(minenum)
        message("Вы нашли мину")
		main.menu.Refresh()
        main.inventory.AddNumMine(1)	
        sound("pickup")		
        kill("bonus_mine"..minenum)
        kill("bonusmine_trig"..minenum)
end

function func.ShowMine(cratenum)
		func.minenum=cratenum
        actor("user_sprite", x, y, {name="bonus_mine"..cratenum, texture="user/playermine", only_human=1 } )
        actor("trigger", x, y, {name="bonusmine_trig"..cratenum, on_enter="func.GiveMine(func.minenum)", only_human=1 } )
end

function func.CrateDestroyed(cratenum)
	x,y=position("crate"..cratenum)
	if cratenum == 2 or cratenum == 3 then
		func.ShowHP(cratenum)
	elseif cratenum == 4 or cratenum == 5 then
		func.ShowMine(cratenum)
	elseif cratenum == 1 then
	    if level1.energycells.missionboo == 0 then
		else
                actor("user_sprite", x, y, {name="boo2", texture="pu_booster", animate=25, only_human=1 } )
                actor("trigger", x, y, {
                       name="gb2", 
                       on_enter=" if level1.energycells.missionboo == 1 then level1.energycells.num=level1.energycells.num+1; kill('gb2');kill('boo2');message('Вы собрали '..level1.energycells.num..' батарей.');user.booexit() else end", 
                       only_human=1 } )
		end	
	end
end

function func.CrateExplosioned(boomcratenum)
	x,y=position("cratetnt"..boomcratenum)
	actor("user_object", x, y, { name="exp_tnt"..boomcratenum, health=1000 } )
	damage(1000,"exp_tnt"..boomcratenum)
end

function user.bonusout1()
        if level1.energycells.missionboo == 0 then
        else
                actor("user_sprite", x, y, {name="boo2", texture="pu_booster", animate=25, only_human=1 } )
                actor("trigger", x, y, {
                        name="gb2", 
                        on_enter=" if level1.energycells.missionboo == 1 then level1.energycells.num=level1.energycells.num+1; kill('gb2');kill('boo2');message('Вы собрали '..level1.energycells.num..' батарей.');user.booexit() else end", 
                        only_human=1 } )
        end
end

function user.givebonus1()
        bonus=bonus+1
        message("Бонус.")
        kill("powerup1")
        kill("bonus_trig1")
end

function user.bonusout2()
--actor("pu_health", x, y, {name="powerup2"})
        actor("user_sprite", x, y, {name="powerup2", texture="user/health", only_human=1 } )
        actor("trigger", x, y, {name="bonus_trig2", on_enter="user.givebonus2()", only_human=1 } )
end

function user.givebonus2()
        message("Вы нашли ПЭРК")
        main.inventory.AddNumHealthPack(1)
        sound("pickup")
        kill("powerup2")
        kill("bonus_trig2")
end

function user.bonusout3()
--actor("pu_health", x, y, {name="powerup3"})
        actor("user_sprite", x, y, {name="powerup3", texture="user/health", only_human=1 } )
        actor("trigger", x, y, {name="bonus_trig3", on_enter="user.givebonus3()", only_human=1 } )
end

function user.givebonus3()
        message("Вы нашли ПЭРК")
        main.inventory.AddNumHealthPack(1)
        sound("pickup")
        kill("powerup3")
        kill("bonus_trig3")
end

function user.bonusout4()
--actor("pu_health", x, y, {name="powerup4"})
        actor("user_sprite", x, y, {name="powerup4", texture="user/health", only_human=1 } )
        actor("trigger", x, y, {name="bonus_trig4", on_enter="user.givebonus4()", only_human=1 } )
end

function user.givebonus4()
        message("Вы нашли ПЭРК")
        main.inventory.AddNumHealthPack(1)
        sound("pickup")
        kill("powerup4")
        kill("bonus_trig4")
end

function user.bonusout5()
--actor("pu_health", x, y, {name="powerup5"}) --Зачем это???
        actor("user_sprite", x, y, {name="powerup5", texture="user/health", only_human=1 } )
        actor("trigger", x, y, {name="bonus_trig5", on_enter="user.givebonus5()", only_human=1 } )
end

function user.tnt1()
        actor("user_object", x, y, { name="exp_tnt1", health=1000 } )
        damage(1000,"exp_tnt1")
end

function user.tnt2()
        actor("user_object", x, y, { name="exp_tnt2", health=1000 } )
        damage(1000,"exp_tnt2")
end

function user.tnt3()
        actor("user_object", x, y, { name="exp_tnt3", health=1000 } )
        damage(1000,"exp_tnt3")
end

function user.givebonus5()
        message("Вы нашли ПЭРК")
        main.inventory.AddNumHealthPack(1)
        sound("pickup")
        kill("powerup5")
        kill("bonus_trig5")
end

---------------------- Второй уровень.------------------------------------
--*Он пока вообще отсутствует. Но по записям на форуме около 10 процентов готово. (31.10.10, Sl@v@98)

-----------------------Другие функции.------------------------------------

--*Это функция для вызывания уровня by Sl@v@98. 
function beginlevel(number)
        dofile(user.campFscr.."level"..number..".lua")
--		require("level"..number)
        main.save.level=number
--      savehealth=playerhealth
        message("Уровень №"..number) -- Для теста. (31.10.10, Sl@v@98)
        loadtheme(user.campFscr.."textures.lua")
end

function user.Lose()
--user.end01()
        play"lose"
        if exists("ourplayer") then kill"ourplayer" else end
        service("msgbox", {text="              Вы проиграли!                  \nСпасибо, что запустили кампанию War System!"})
end

function camspawn(camx, camy) --3 следующих скрипта - неработающая камера.
        service("player_local", camx, camy {name="camera", nick="", team=1, vehname="cam", class="camera", skin="empty"})  
end

function timecmd(plustime) 
        pushcmd(function()
                time = time + plustime
        end, time)
end

function cameratest(cameramus, camspeed)
--play(cameramus)
        if exists("ourplayer")==true then
                local time = 1
                pushcmd(function() camspawn(5,5) end, time)
                timecmd(3)
                pushcmd(function()  kill("camera") end, time)
                pushcmd(function() camspawn(8,37) end, time)
                timecmd(1)
                pushcmd(function()  kill("camera") end, time)
                pushcmd(function() camspawn(18,31) end, time)
                timecmd(1)
                pushcmd(function()  kill("camera") end, time)
                pushcmd(function() camspawn(32,16) end, time)
                timecmd(2)
                kill("camera")
        else
        end
end



function func.OnDieTank(tank) --Тоже прототип функции. Работоспособность не проверял...
	on_die_tank=""
	lang.msg_player_x_killed_him_self = on_die_tank
	lang.msg_player_x_killed_his_friend_x = on_die_tank
	lang.msg_player_x_killed_his_enemy_x = on_die_tank
	lang.msg_player_x_died = on_die_tank
--	local tank = who.name
--	if tank~=nil then 
		if tank == ("ourplayer_tank") then
			lang.msg_player_x_killed_him_self="Совет: В следующий раз играйте аккуратней..."
			lang.msg_player_x_killed_his_friend_x="Подсказка: Не убивайте своих войнов! Они вам ещё пригодятся."
			lang.msg_player_x_killed_his_enemy_x="Отлично, вы уничтожили вражеский танк!"
			lang.msg_player_x_died="Совет: В следующий раз играйте аккуратней..."
		elseif tank == ("ourwarrior_tank1") or tank == ("ourwarrior_tank2") or tank == ("ourwarrior_tank3") or tank == ("ourwarrior_tank4") then
			lang.msg_player_x_killed_him_self="Один из поселенцев самоуничтожился."
			lang.msg_player_x_killed_his_friend_x="Совет: Один из поселенцев не попадает по врагу! Будьте аккуратней."
			lang.msg_player_x_killed_his_enemy_x="Ваши союзники уничтожили вражиский танк."
			lang.msg_player_x_died="Один из поселенцев не умеет ездить..."
		elseif tank == ("enemy_tank1") or tank == ("enemy_tank2") or tank == ("enemy_tank3") or tank == ("enemy_tank4") then
			lang.msg_player_x_killed_him_self="Отлично!"
		else
		end
--	else
--	end
end

function animskin() --Прототип функции "анимирования скина"
if exists("animtank") then kill("animtank") end
--animrot=ourplayer_tank.rotation
x,y=position("ourplayer_tank")
actor("user_sprite", x,y, {name="animtank", rotation=ourplayer_tank.rotation, texture="user/ekivator_anim", animate=25})
pushcmd(function() animskin() end, 1/1000)
end

function health() --Старая версия функции
if h==4000 then message("Энергозапас ПЭРК исчерпан")
else
if pget("ourplayer_tank", "health")<=2000 then
i=2000-pget("ourplayer_tank", "health")
damage(-25, "ourplayer_tank")
h=h+1
pushcmd(function() health() end, 0.1)
elseif pget("ourplayer_tank", "health")>=2000 then
pset("ourplayer_tank", "health", 2000)
message("Генерирование частиц завершено.")
end
end
end

function main.GiveClassHealth(whom) --Замечательная функция, которая берёт у whom начальное здоровье
		if whom==nil then print_error("В функции main.GiveClassHealth(whom) переменная whom не должна быть nil!") end
		if exists(whom)==false then print_error("Такого объекта не существует!") else
				if objtype(whom)~="player_local" and objtype(whom)~="ai" then print_error("В функции main.GiveClassHealth(whom) переменная whom должна быть игроком или ботом (но не танком!)")
				else
						local a=pget(whom, "class")
						local s=rawget(classes, a)
						whom_health=s.health
						if whom_health==nil then print_error("В функции main.GiveClassHealth(whom) есть ошибка. Если вы это читаете, сообщите об этом на форум в тему кампании War System.") end
		end
		end
end

function main.RestoreHealth(whom, num)  --Функция восстанавливает постепенно здоровье у whom
		if num==nil then
				h = 0
				if whom == "ourplayer_tank" then message("Запущено генерирование частиц.") else end
				main.RestoreHealth(whom, 1)
		else
				if whom==nil then print_error("В функции main.RestoreHealth(whom) переменная whom не должна быть nil!") end
				if exists(whom)==false then print_error("Такого объекта не существует!") else
						if objtype(whom)~="tank" then print_error("В функции main.RestoreHealth(whom) переменная whom должна быть танком (но не игроком или ботом!)")
				else
						if h>=120 then if whom == "ourplayer_tank" then message("Энергозапас ПЭРК исчерпан") else end h=0
						else
								whom_name=whom
								main.GiveClassHealth(object(whom_name).playername)
								if pget(whom, "health")<=whom_health then
									   damage(-25, whom)
									   h=h+1
									   pushcmd(function() main.RestoreHealth(whom, 1) end, 0.1)
								elseif pget(whom, "health")>=whom_health then damage(pget(whom, "health")-whom_health, whom)
									   if whom == "ourplayer_tank" then message("Генерирование частиц завершено.") else end
								end
						end
				end		
		end
end
end



function func.ActionWarrior(bot, num) --Новая версия M1ActionBot. Т.к. теперь есть макросы, М1 отброшено. Пока не работает.
		 if exists ("ourwarrior_tank"..bot) == true then
				if bot==1 and num==1 then ai_march("ourwarrior1", 29*32, 12*32) else end
				if bot==1 and num==2 then ai_march("ourwarrior1", 41*32, 11*32) else end
				if bot==2 and num==1 then ai_march("ourwarrior2", 54*32, 12*32) else end
				if bot==2 and num==2 then ai_march("ourwarrior2", 65*32, 20*32) else end
				if level1.enemyattack.units~=0 then
						if bot==4 and num==1 then ai_march("ourwarrior4", 36*32, 18*32) else end
						if bot==4 and num==2 then ai_march("ourwarrior4", 50*32, 3*32) else end
				end
		end
end

function level1.ConversionEnemy()
        if level1.enemyattack.units==4 then
                message("Одна единица неизвестного врага была уничтожена. ")
        elseif level1.enemyattack.units==3 then
                message("Две единицы неизвестного врага были уничтожены.")
        elseif level1.enemyattack.units==2 then
                message("Три единицы неизвестного врага были уничтожены.")
        elseif level1.enemyattack.units==1 then
                message("Четыре единицы неизвестного врага были уничтожены.")
        elseif level1.enemyattack.units==0 then
               level1.OnDieAllEnemies()
        end
end


function level1.DieEnemy(unit)
		if unit==1 or unit==2 or unit==3 or unit==4 then
				kill("enemy"..unit)
				kill("enemyweap"..unit)
				level1.enemyattack.units=level1.enemyattack.units-1
				level1.ConversionEnemy()	
		else
				x1, y1 = position("boss_tank")
				kill("enemy_boss")
				kill("enemyweap"..unit)
				level1.enemyattack.units=level1.enemyattack.units-1
				message("Босс врагов убит.")
				if level1.sputnik.verity == 0 then
						actor("user_sprite", x1, y1, { name="shocker1", texture="user/bomb", layer=1 } )
						actor("user_sprite", x1, y1, { name="boss_wreck", texture="user/wreck_boss", layer=1 } )
				else
				end
				level1.ConversionEnemy()
		end
end

function level1.OnDieAllEnemies()
        level1.enemyattack.happened=0
        if level1.sputnik.verity == 0 then
				if exists("msbox") then kill("msbox") end
                service("msgbox", {
                        name="msbox", 
                        text="\nВсе единицы врага были уничтоженны. \nОни использовали взрывчатку. \nОсмотрите обломки их главаря. \nТам может быть то что вам нужно\n" } ) 
                actor("trigger", x1, y1, { name="shocktrig2", on_enter="level1.energycells.ShockIn()", only_human=1 } )      
        else
        end
        message("Основное задание выполнено.")
        main.missions.mainMission="1)Найдите энергон в этих местностях. \n2)Свяжитесь с Ороном и сообщите обстановку.\n3)Защитите боевое поселение Экиваторов от врагов! (Выполнено)\n4)Сохраните сержанта Халоса! (Выполено)"
        play"mus5"
--      pset("c_trig3", "active", 1)
--      if net==1 then
--              pset("c_trig2", "active", 1)
--      else
--      end
		pset("c_trig", "active", 1)
        if exists ("ourwarrior_tank1") == true then
                pset("ourwarrior1", "active", 0)
                func.ActionWarrior(1, 2)
		end
        if exists ("ourwarrior_tank2") == true then
                pset("ourwarrior2", "active", 0)
                func.ActionWarrior(2, 2)
		end
		if exists ("ourwarrior_tank4") == true then
                pset("ourwarrior4", "active", 0)
				main.RestoreHealth("ourwarrior_tank4")
				ai_march("ourwarrior4", 50*32, 3*32)
        end
	if level1.commWasActive==1 then
		pset("ourwarrior3", "active", 0)
		ai_march("ourwarrior3", user.get32(69), user.get32(3))
		pushcmd(function() ai_march("ourwarrior3", user.get32(69), user.get32(3)) end, 6)
	end
end

-----------------------------------------------
