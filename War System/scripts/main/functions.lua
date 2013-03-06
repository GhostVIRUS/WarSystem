-- Взрыв

function func.Explosion(x, y, times, spd)
        local times = times or 1
        local spd = spd or 0
        for i=0, times-1 do
                pushcmd(function() actor("user_object", x, y, {name="exploder"});
                damage(100, "exploder") end, 0+i/100*spd)
        end
end 

-- Бомбардировка

function func.Bombard(x1, y1, x2, y2, times, spd, explo, explospd)
        times = times or 24
        spd = spd or 15
        explo = explo or 1
        explospd = explospd or 0
        local pixx = (x2-x1)/times
        local pixy = (y2-y1)/times
        for i=0, times-1 do
                pushcmd(function() func.Explosion(x1+pixx*i, y1+pixy*i, explo, explospd) end, 0+i/100*spd)
        end
end 

-- Бомбардировка полигона

function func.Dangerzone(x1, y1, x2, y2, time, spd, islinear, linspd)
        time = time or 500
        spd = spd or 500
        islinear = islinear or 0
        linspd = linspd or math.random(5, 20)
        if islinear==0 then
                local i=time/spd
                for q=0, i-1 do
                        pushcmd(function()
                        rx = math.random(x1*32, x2*32)
                        ry = math.random(y1*32, y2*32)
                        func.Explosion(rx, ry) end, spd*q/100)
                end
        end
        if islinear==1 then
                local i=time/spd
                for q=0, i-1 do
                        pushcmd(function()
                        local rx1 = math.random(x1*32, x2*32)
                        local rx2 = math.random(x1*32, x2*32)
                        local ry1 = math.random(y1*32, y2*32)
                        local ry2 = math.random(y1*32, y2*32)
                        bombard(rx1, rx2, ry1, ry2, linspd, spd) end, spd*q/100)
                end
        end
        end
--      end
--end

-- Получить координаты сеедины клетки
-- (для получения верхнего левого угла - достаточно помножить на 32). Antikiller.

function func.Get32(num)
        return ((num-1) * 32) + 16;
end

-- Двигает объект в люом направлении. VIRUS
--[[function func.Move(name, x, y, valueType, speed) 
        x1, y1 = position(name) 
        x2 = x 
        y2 = y 
        if valueType == 'grid' then 
                x2 = x2*32-16 
                y2 = y2*32-16 
        end 
        xCathetus = math.abs(x1 - x2) 
        yCathetus = math.abs(y1 - y2) 
        hypotenuse = math.sqrt((xCathetus * xCathetus) + (yCathetus * yCathetus))  
        if x1 < x2 and y1 < y2 then 
                for i=1, hypotenuse do 
                        pushcmd( function() setposition(name, x1+i*(xCathetus/hypotenuse), y1+i*(yCathetus/hypotenuse)) end, i/speed) 
                end 
        end 
        if x1 > x2 and y1 > y2 then 
                for i=1, hypotenuse do 
                        pushcmd( function() setposition(name, x1-i*(xCathetus/hypotenuse), y1-i*(yCathetus/hypotenuse)) end, i/speed) 
                end 
        end 
        if x1 > x2 and y1 < y2 then 
                for i=1, hypotenuse do 
                        pushcmd( function() setposition(name, x1-i*(xCathetus/hypotenuse), y1+i*(yCathetus/hypotenuse)) end, i/speed) 
                end 
        end 
        if x1 < x2 and y1 > y2 then 
                for i=1, hypotenuse do 
                        pushcmd( function() setposition(name, x1+i*(xCathetus/hypotenuse), y1-i*(yCathetus/hypotenuse)) end, i/speed) 
                end 
        end 
end--]]

-- Двигает объект в любом направлении. VIRUS. Modified by Assassin (Артур).
function func.Move(name, x, y, g32, speed) 
    x1, y1 = position(name) 
    x2 = x 
    y2 = y 
    if g32 == true then 
        x2 = x2*32-16 
        y2 = y2*32-16 
    end 
    xCathetus = math.abs(x1 - x2) 
    yCathetus = math.abs(y1 - y2) 
    hypotenuse = math.sqrt((xCathetus * xCathetus) + (yCathetus * yCathetus))  
    if x1 < x2 then
        if y1 < y2 then 
            func.StartMove(name, x1, y1, hypotenuse, 1, xCathetus, yCathetus, hypotenuse, speed)
                        --for i=1, hypotenuse do 
                        --      pushcmd( function() setposition(name, x1+i*(xCathetus/hypotenuse), y1+i*(yCathetus/hypotenuse)) end, i/speed) 
                        --end
        end
        if y1 > y2 then
            func.StartMove(name, x1, y1, hypotenuse, 2, xCathetus, yCathetus, hypotenuse, speed)
                        --for i=1, hypotenuse do 
                        --      pushcmd( function() setposition(name, x1+i*(xCathetus/hypotenuse), y1-i*(yCathetus/hypotenuse)) end, i/speed) 
                        --end
        end
        if y1 == y2 then
            func.StartMove(name, x1, y1, xCathetus, 3, 0, 0, 0, speed)
                        --for i=1, xCathetus do
                        --      pushcmd( function() setposition(name, x1+i, y1) end, i/speed)
                        --end
        end
    end 
    if x1 > x2 then
        if y1 < y2 then 
            func.StartMove(name, x1, y1, hypotenuse, 4, xCathetus, yCathetus, hypotenuse, speed)
                        --for i=1, hypotenuse do 
                        --      pushcmd( function() setposition(name, x1-i*(xCathetus/hypotenuse), y1+i*(yCathetus/hypotenuse)) end, i/speed) 
                        --end 
        end 
        if y1 > y2 then 
            func.StartMove(name, x1, y1, hypotenuse, 5, xCathetus, yCathetus, hypotenuse, speed)
                        --for i=1, hypotenuse do 
                        --      pushcmd( function() setposition(name, x1-i*(xCathetus/hypotenuse), y1-i*(yCathetus/hypotenuse)) end, i/speed) 
                        --end
        end
        if y1 == y2 then
            func.StartMove(name, x1, y1, xCathetus, 6, 0, 0, 0, speed)
                        --for i=1, xCathetus do
                        --      pushcmd( function() setposition(name, x1-i, y1) end, i/speed)
                        --end
        end
    end 
    if x1 == x2 then 
        if y1 < y2 then 
            func.StartMove(name, x1, y1, yCathetus, 7, 0, 0, 0, speed)
                        --for i=1, yCathetus do 
                        --      pushcmd( function() setposition(name, x1, y1+i) end, i/speed) 
                        --end 
        end 
        if y1 > y2 then 
                        func.StartMove(name, x1, y1, yCathetus, 8, 0, 0, 0, speed)
                        --for i=1, yCathetus do 
                        --      pushcmd( function() setposition(name, x1, y1-i) end, i/speed) 
                        --end
        end
    end
end

function func.StartMove(name, x, y, length, case, xCathetus, yCathetus, hypotenuse, speed)
    if     case == 1 then
        for i=1, length do
            pushcmd( function() setposition(name, x+i*(xCathetus/hypotenuse), y+i*(yCathetus/hypotenuse)) end, i/speed) 
        end
    elseif case == 2 then
        for i=1, length do
            pushcmd( function() setposition(name, x+i*(xCathetus/hypotenuse), y-i*(yCathetus/hypotenuse)) end, i/speed) 
        end
    elseif case == 3 then
        for i=1, length do
            pushcmd( function() setposition(name, x+i, y) end, i/speed) 
        end
    elseif case == 4 then
        for i=1, length do
            pushcmd( function() setposition(name, x-i*(xCathetus/hypotenuse), y+i*(yCathetus/hypotenuse)) end, i/speed) 
        end
    elseif case == 5 then
        for i=1, length do
            pushcmd( function() setposition(name, x-i*(xCathetus/hypotenuse), y-i*(yCathetus/hypotenuse)) end, i/speed) 
        end
    elseif case == 6 then
        for i=1, length do
            pushcmd( function() setposition(name, x-i, y) end, i/speed) 
        end
    elseif case == 7 then
        for i=1, length do
            pushcmd( function() setposition(name, x, y+i) end, i/speed) 
        end
    elseif case == 8 then
        for i=1, length do
            pushcmd( function() setposition(name, x, y-i) end, i/speed) 
        end
    end
end

-- Разворачивает объект по напралению к другому. VIRUS
function func.SetDirToObject(rotateObjectName, movingObjectName)
    x1, y1 = position(rotateObjectName)
    x2, y2 = position(movingObjectName)
    xCathetus = math.abs(x1 - x2)
    yCathetus = math.abs(y1 - y2)
    hypotenuse = math.sqrt((xCathetus * xCathetus) + (yCathetus * yCathetus))
    alpha = math.acos(math.max(xCathetus, yCathetus) / hypotenuse)
    if x2 > x1 and y2 > y1 then
        if xCathetus > yCathetus then
            object(rotateObjectName).dir = alpha
        else
            object(rotateObjectName).dir = (math.pi/2) - alpha
        end
    elseif x2 < x1 and y2 > y1 then
        if yCathetus > xCathetus then
            object(rotateObjectName).dir = alpha + (math.pi/2)
        else
            object(rotateObjectName).dir = math.pi - alpha 
        end
    elseif x2 < x1 and y2 < y1 then
        if xCathetus > yCathetus then
            object(rotateObjectName).dir = alpha + math.pi
        else
            object(rotateObjectName).dir = (math.pi*1.5) - alpha
        end
    elseif x2 > x1 and y2 < y1 then
        if yCathetus > xCathetus then
            object(rotateObjectName).dir = alpha + (math.pi*1.5)    
        else
            object(rotateObjectName).dir = (math.pi*2) - alpha
        end
    end
end

function func.SetDirFollowingObject(rotateObjectName, movingObjectName, frequency)
        local frequency = frequency or 0.001    
    func.SetDirToObject(rotateObjectName, movingObjectName)
    if func.letDirFollowingObject == 0 then
        
    else
        pushcmd( function() func.SetDirFollowingObject(rotateObjectName, movingObjectName, frequency) end, frequency)
    end
end

function func.LetDirFollowingObject(num)
        local num = num or 0
    func.letDirFollowingObject = num
end

--- GENIUS :D (писалось под The Prodigy) --- VIRUS ---
--- Полигоны ---

-- Создает новый полигон
function func.CreatePoligon(poligonName)
        local poligonName = poligonName or "poligon1"
--      rawset(func.poligons, poligonName, {} )
        func.poligons[poligonName] = {numOfSquares = 0} --Добавляем полигон с заданым именем в массив полигонов
end

-- Добавляет область выделенную тригерами територию  в полигон
function func.AddSquareToPoligon(poligonName, squareName, --[[trigNum,]] figure) -- figure (0 - прямоугольник, 1 треугольник); squareName - префикс тригеров, которые задают данную территорию.
        local poligonName = poligonName or "poligon1" 
        local trigNum = trigNum or 4
        local squareName = squareName or "square1"
        local figure = figure or 0
        
        func.poligons[poligonName].numOfSquares = func.poligons[poligonName].numOfSquares + 1 --Обновляет количество территорий в полигоне
        func.poligons[poligonName].poligonSquares[numOfSquares] = squareName --Добавляем имя территории в массив полигона
        
        if figure == 0 then
                trigNum = 4
        elseif firgure == 1 then
                trigNum = 3
        end
        
--      rawset(func.poligons[poligonName], squareName, {})
        for i = 1, trigNum do
                local x, y = position(squareName..trigNum)
                func.poligons[poligonName][squareName]["trig"..trigNum]["x"] = {x} --Координаты тригеров по x
                func.poligons[poligonName][squareName]["trig"..trigNum]["y"] = {y} --Координаты тригеров по y
--              rawset(func.poligons[poligonName][squareName..trigNum], "x", {x})
--              rawset(func.poligons[poligonName][squareName..trigNum], "y", {y})
        end
end

function func.DeleteSquareFromPoligon(poligonName, squareName) --Нужно придумать как удалять ненужные территории из полигона. Можно просто обнулять их имена, но они останутся зарезервироваными.
        
end

--- Тригер-полигон (мегатригер :D) ---

-- Создание мегатригера
function func.CreateMegaTrig(poligonName, megaTrigName, on_enter, on_leave, only_human, only_bot)
        local poligonName = poligonName or "poligon1"
        local megaTrigNam = megaTrigNam or "megaTrig1"
        func.megaTrigs[megaTrigName].poligon = func.poligons[poligonName]
        func.megaTrigs[megaTrigName].on_enter = on_enter
        func.megaTrigs[megaTrigName].on_leave = on_leave
        func.megaTrigs[megaTrigName].only_human = only_human
        func.megaTrigs[megaTrigName].only_bot = only_bot
end

function func.EditMegaTrig(poligonName, megaTrigName, on_enter, on_leave, only_human, only_bot) --Вот может её как-то объеденить с предедущей или удалить?
        local poligonName = poligonName or "poligon1"
        local megaTrigNam = megaTrigNam or "megaTrig1"
        func.megaTrigs[megaTrigName].poligon = func.poligons[poligonName]
        func.megaTrigs[megaTrigName].on_enter = on_enter
        func.megaTrigs[megaTrigName].on_leave = on_leave
        func.megaTrigs[megaTrigName].only_human = only_human
        func.megaTrigs[megaTrigName].only_bot = only_bot
end

function func.MegaTrigCheck(megaTrigName) --Если танк попадает в зону какого-либо из граничных тригеров мегатригера то вызывается эта функция, где происходит проверка на то въехал танк в зону мегатригера или нет. Нужно придумать как сделать на выезд событие
        --Тут будет очень много кода.
end

--[[
-- Болото
function func.BuildSwamp(poligonName, trigNum, figure) 
        local poligonName = poligonName or "poligon1"
        local trigNum = trigNum or 4
        local figure = figure or 1
        
        
        for i=1, trigNum do
                
        end
end
]]
--Болото будем делать после мегатригеров. Там будет что-то подобное. Хотя, все же, чуть сложнее


-- Что это и для чего незнаю. VIRUS
-- Это для того, чтобы танк ездил и при смене оружия его характеристики не менялись. Sl@v@98

function getvclass(cls, weap)
	if weap then
		if cls == "player1" then
--			main.player.weap=weap
----		main.inventory.PickupWeap(weap) --Короче, потом пригодится
			func.player.PickupWeap(weap)
			main.characters.ourplayer.current_weapon = weap
		end
			local tmp = tcopy(classes[cls])
		return tmp           -- and return modified class desc
	end
	return classes[cls]
end

--Тестовая версия функции добавления оружия в инвентарь. Slava98.

function func.PickupWeap(weap)
	local weap1 = main.player.weapon1
	local weap2 = main.player.weapon2
	print ("weap1 = "..weap1)
	print ("weap2 = "..weap2)
	if not a then
		if weap == "weap_autocannon" then message("Автоматическая пушка добавлена в инвертарь") end
		if weap == "weap_cannon" then message("Тяжёлая пушка добавлена в инвертарь") end
		if weap == "weap_minigun" then message("Пулемёт добавлен в инвертарь") end
		if weap == "weap_rocket" then message("Ракетница добавлена в инвертарь") end
		a=false
	end
	
--	if weap1~=weap or weap2~=weap then
--		if weap1~=weap then weap1=weap
--		elseif weap2~=weap then wheap2=weap
--		end
--	end
	if weap1~=weap and weap2~=weap then
		weap1=weap
	else
		print (weap1, weap2)
		print ("weap1 nil")
	end
	if weap2~=weap and weap1~=weap then
		weap2=weap
	else
		print (weap1, weap2)
		print ("weap2 nil")
	end
	
	print (weap1, weap2)
	
	if weap1==weap2 then message("Weap error!") end
	
	a=true
--	main={}
	main.player_weapon=weap
	main.player_weapon1=weap1
	main.player_weapon2=weap2
end

function func.player.PickupWeap(weap)
--	main.player.weapon = weap
	if main.player.weapon1 == nil then main.player.weapon1 = weap; main.player.weapon = weap
	elseif main.player.weapon1 ~= weap and main.player.weapon1 ~= nil and main.player.weapon2 == nil then main.player.weapon2 = weap; main.player.weapon = weap
	elseif main.player.weapon1 ~= weap and main.player.weapon2 ~= weap and main.player.weapon1 ~= nil and main.player.weapon2 ~= nil then 
		if exists("weapbox") then kill("weapbox") end
--		main.player.weapon = ""
		if exists("player_weap") then kill("player_weap") end
		func.EquipWeap(main.player.weapon, 'player_weap', const.playername..'_tank')
		service("msgbox", {name="weapbox", text=func.dialog.Read("msg_changeweap", "main", 5).." "..func.ConvertWeap(weap), on_select="if n == 1 then if exists('player_weap') then kill('player_weap') end local x, y = position('"..const.playername.."_tank') actor('"..main.player.weapon1.."', x, y, {on_pickup='func.player.OnGetWeapon(self)'}) main.player.weapon1='"..weap.."' main.player.weapon='"..weap.."' func.EquipWeap('"..weap.."', 'player_weap', '"..const.playername.."_tank') elseif n == 2 then if exists('player_weap') then kill('player_weap') end local x, y = position('"..const.playername.."_tank') actor('"..main.player.weapon2.."', x, y, {on_pickup='func.player.OnGetWeapon(self)'}); main.player.weapon2='"..weap.."' main.player.weapon='"..weap.."' func.EquipWeap('"..weap.."', 'player_weap', '"..const.playername.."_tank') elseif n == 3 then local x, y = position('"..const.playername.."_tank') actor('"..weap.."', x, y, {on_pickup='func.player.OnGetWeapon(self)'}) func.EquipWeap('"..main.player.weapon1.."', 'player_weap', '"..const.playername.."_tank') end", option1=func.ConvertWeap(main.player.weapon1), option2=func.ConvertWeap(main.player.weapon2), option3="Отмена"})
	end
--	func.EquipWeap(main.player.weapon, 'player_weap', const.playername..'_tank')
end

function func.player.KillWeap(weap_object)
	if main.player.weapon == nil or object(weap_object).name == main.player.weapon1 or object(weap_object).name == main.player.weapon2 then
	elseif main.player.weapon1 ~= nil and main.player.weapon2 == nil or main.player.weapon1 ~= nil and main.player.weapon2 ~= nil then kill(weap_object)
	end
end

function func.player.OnGetWeapon(weap)
--	if main.player.weapon1 ~= nil and main.player.weapon2 ~= nil or main.player.weapon1 ~= nil then
	if exists("player_weap") then kill("player_weap") end 
	weap.name = "player_weap"
--	else
--		kill(weap)
--	end
	if objtype(weap) ~= main.player.weapon1 and objtype(weap) ~= main.player.weapon2 then kill(weap) func.EquipWeap(main.player.weapon, "player_weap", const.playername.."_tank") end
end

function func.EquipWeap(weap, name, tank)
--	if exists(weap) then kill(weap) end
	if not exists(weap) then actor(weap, 0, 0, {name = name}) end
	equip(tank, name)
	rawget(main.characters, object(tank).playername).current_weapon = weap
end

function func.ConvertWeap(weap)
	if weap == "weap_autocannon" then return func.dialog.Read("weap", "main", 1)
	elseif weap == "weap_bfg" then return func.dialog.Read("weap", "main", 2)
	elseif weap == "weap_shotgun" then return func.dialog.Read("weap", "main", 3)
	elseif weap == "weap_zippo" then return func.dialog.Read("weap", "main", 4)
	elseif weap == "weap_plazma" then return func.dialog.Read("weap", "main", 5)
	elseif weap == "weap_minigun" then return func.dialog.Read("weap", "main", 6)
	elseif weap == "weap_gauss" then return func.dialog.Read("weap", "main", 7)
	elseif weap == "weap_rocket" then return func.dialog.Read("weap", "main", 8)
	elseif weap == "weap_ripper" then return func.dialog.Read("weap", "main", 9)
	elseif weap == "weap_ram" then return func.dialog.Read("weap", "main", 10)
	elseif weap == "weap_cannon" then return func.dialog.Read("weap", "main", 11)
	end
end

--------------------------------------

function func.Play(musfile) --Проигрывает трек.
	music ("..\\campaign\\War System\\music\\"..musfile..".ogg")
end

function func.Sound(musfile, obj) --Проигрывает звук.
	obj = obj or "ourplayer_tank"
	play_sound(obj, "campaign/War System/sound/"..musfile..".ogg")
end

function func.PrintError(er_mes) --Выводит сообщение об ошибке. Slava98.
--	assert(nil,er_mes) 
	error(er_mes, 2)
end

--function func.loadscript(scr)
--	dofile(user.campF.."scripts/"..scr..".lua")
--end

--Функция детонации мины. Должна быть тут VIRUS.
function func.MineDetonate(who) 
        if who~=nil then
                damage(500, who)
        else
        end
end
--По-дассоваторски уничтожает любой объект. Slava98.

function func.Destroy(obj) 
	if exists(obj) then
		if objtype(obj)=="wall_concrete" then
			func.Explosion(position(obj))
			kill(obj)
		elseif objtype(obj)=="ai" or objtype(obj)=="player_local" then
			damage(object(object(obj).vehname).health, object(obj).vehname)
			if exists(obj) then kill(obj) end
		else
			damage(object(obj). health, obj)
		end
	end
end

---------------------------Анимированный скин----------------------------

--Создаёт анимированный скин. Slava98.
function func.animskin.Create(texture, tank, animate)
	if exists("animskin_"..tank) then func.animskin.Kill(tank) end
	animate = animate or 25
	tank1 = object(tank)
	tank1.skin = "null"
	local x, y = position(tank)
	actor("user_sprite", x, y, {name="animskin_"..tank, rotation=tank1.rotation, texture=texture, layer=5, animate=animate})
--	object(tank1.playername).on_die = object(tank1.playername).on_die..";func.animskin.Kill('"..tank.."')"
	func.animskin.Loop(texture, tank, animate)
end

--Двигает скин вместе с танком. Slava98.
function func.animskin.Loop(texture, tank, animate)
	if not exists(tank) then func.animskin.Kill(tank) return end
	animate = animate or 25
	setposition("animskin_"..tank,  position(tank))
	object("animskin_"..tank).rotation = object(tank).rotation
	pushcmd(function() func.animskin.Loop(texture, tank, animate) end, 0.00001)
end

--Убирает скин. Slava98.
function func.animskin.Kill(tank)
	kill("animskin_"..tank)
end

----------------------------------Ящики----------------------------------

function func.GiveHP(hpnum)
        message("Вы нашли ПЭРК")
		main.menu.Refresh()
		if main.menu.section == "inv_boosts" then main.menu.InventoryBoosts() end
        main.inventory.AddNumHealthPack(1)	
		func.Sound("pickup")		
        kill("bonus_healthpack"..hpnum)
        kill("bonushealthpack_trig"..hpnum)
end

function func.ShowHP(cratenum, x, y) 
		func.hpNum = func.hpNum + 1--cratenum
        actor("user_sprite", x, y, {name="bonus_healthpack"..func.hpNum--[[cratenum]], texture="user/health", only_human=1 } )
        actor("trigger", x, y, {name="bonushealthpack_trig"..func.hpNum--[[cratenum]], on_enter="func.GiveHP("..func.hpNum..")", only_human=1 } )
end

function func.GiveMine(minenum)
        message("Вы нашли мину")
		main.menu.Refresh()
		if main.menu.section == "inv_boosts" then main.menu.InventoryBoosts() end
        main.inventory.AddNumMine(1)	
		func.Sound("pickup")		
        kill("bonus_mine"..minenum)
        kill("bonusmine_trig"..minenum)
end

function func.ShowMine(cratenum, x, y)
		func.mineNum = func.mineNum + 1--cratenum
        actor("user_sprite", x, y, {name="bonus_mine"..func.mineNum--[[cratenum]], texture="user/playermine", only_human=1 } )
        actor("trigger", x, y, {name="bonusmine_trig"..func.mineNum--[[cratenum]], on_enter="func.GiveMine("..func.mineNum..")", only_human=1 } )
end

function func.CrateDestroy(cratenum, drop)
	local x,y = position("crate"..cratenum)
	if drop == "hp" then
		func.ShowHP(cratenum, x, y)
	elseif drop == "mine" then
		func.ShowMine(cratenum, x, y)
	elseif drop == "tnt" then
--		func.CrateExplosioned(cratenum)
		func.Explosion(x,y)
	elseif drop == "level_pickup" then
		level.Pickup(cratenum, x, y)
	end	
end

----------------------------------NPC----------------------------------	
	
--Создаёт NPC в определённом месте. Slava98.
function func.NPC.Create(name, num, nick, class, skin, team, weap, atype, spawnteam, x, y, dir, enemy_detect_mode) 
--	func.NPC.num = func.NPC.num + 1 --Эта идея совсем ненужная и забаженная
	if type(class) == "table" then temp.class_name = name.."_class"; rawset(classes, temp.class_name, tcopy(class)) end
	local name = name..num or "npc"..func.NPC.num
	local num = num or ""
	local vehname = name.."_tank"
	local nick = nick or ""
	local class = class or temp.class_name
	local skin = skin or "ekivatorl"
	local team = team or 1
	local weap = weap or "weap_cannon"
	local weapname = name.."_gun"..num
	local spawnteam = spawnteam or 1
	local enemy_detect_mode = enemy_detect_mode or true
	service ("ai", {
        name = name, 
        vehname = vehname, 
        nick = nick, 
        class = class, 
        skin = skin, 
        team = spawnteam, 
		on_damage = "func.ExtraDamage(who, self)",
        on_die = "level.OnDie('"..name.."');kill('"..name.."_gun"..num.."'); rawset (main.characters, '"..name.."', nil)", 
        active = 0 } )
	if weap ~= "none" then
		pushcmd(function() 
			actor(weap, 0, 0, {name=weapname})
			equip(vehname, weapname )
		end, 2)
	end
	if x~=nil and y~=nil then
		local dir = dir or 0
		actor("respawn_point", x, y, {name=name.."_spawn",dir=dir, team=spawnteam})
	end
	pushcmd(function() 
						object(name).team = team 
						if exists(name.."_spawn") then kill(name.."_spawn") end
						if enemy_detect_mode == true then func.SetBorderTriggerToObject(vehname, "", "if who ~= nil and object(who.playername).team ~= object('"..name.."').team then pset('"..name.."', 'active', 1) end", 6, 32, 15, 1, "if who ~= nil and object(who.playername).team ~= object('"..name.."').team then pset('"..name.."', 'active', 0) end", 1) end
	end, 2) 	
	    if atype == 0 then rawset (func.NPC.enemies, name, {})
	elseif atype == 1 then rawset (func.NPC.friends, name, {}) 
	elseif atype == 2 then rawset (func.NPC.neutrals, name, {}) 
	else                   rawset (func.NPC.enemies, name, {})
	end
	rawset (main.characters, name, {weapons = {}, current_weapon = ""})
end

--Задаёт позицию, по которой нужно будет двигаться. Slava98.
function func.NPC.SetAction(npc, x1, y1, x2, y2, g32) --npc - сервис, g32 - нужно ли вычислять координаты, boolean
	g32 = false or g32
	if g32 then
		x1 = func.Get32(x1); y1 = func.Get32(y1)
		x2 = func.Get32(x2); y2 = func.Get32(y2)
	end
	actor("trigger", x1, y1, { name=npc.."_act_trig1", on_enter="func.NPC.Action('"..npc.."', 2)"})
	actor("trigger", x2, y2, { name=npc.."_act_trig2", on_enter="func.NPC.Action('"..npc.."', 1)"})
end

--Даёт приказ NPC двигаться по координатам. Slava98.
function func.NPC.Action(npc, trig_num, x, y, g32) 
	local g32 = false or g32
	if exists (npc) == true and exists (object(npc).vehname) then
		if x == nil or y == nil then
			if trig_num == nil then
				if math.random() > 0.5 then
					ai_march(npc, position(npc.."_act_trig2"))
				else
					ai_march(npc, position(npc.."_act_trig1"))
				end
			else
				ai_march(npc, position(npc.."_act_trig"..trig_num))
			end
		else
			if g32 then
				ai_march(npc, func.Get32(x), func.Get32(y))
			else
				ai_march(npc, x, y)
			end
		end
	end	
end

--Делает так, чтобы NPC не контролировали территорию. Slava98.
function func.NPC.StopAction(npc, active)
	for i = 1, 2 do
		pset(npc.."_act_trig"..i, "active", active)
	end
end

--Создаёт триггеры вокруг NPC. Slava98. Modified by VIRUS.
function func.SetBorderTriggerToObject(npc, trig_name, on_enter, dir, lenght, radius, only_visible, on_leave, frequency, radius_delta, only_human) 
--	local trig_name = trig_name or "speak"  --Пока закоментил, т.к. есть ошибка. Slava98.
	if trig_name == nil or trig_name == "" then trig_name = "trig" end
	if exists(npc.."_"..trig_name) then kill(npc.."_"..trig_name) --[[return Зачем здесь это?]] end --Для облегчения другой функции и уменьшения ошибок. Slava98.
	if not exists(npc) then return end
	local x, y = position(object(npc).--[[veh]]name) --name лучше, говорил почему в history
	local t_name = npc.."_"..trig_name
	local radius = radius or 1 -- Xe-xe забыл ты его дописать туда -------------------------------------------------------------| VIRUS
	local lenght = lenght or 32  --                                                                                             |
	local dir = dir or 5 --                                                                                                     | Да, вот сюда
	local only_visible = only_visible or 0
	local only_human = only_human or 1
	local radius_delta = radius_delta or 0
--	if frequency ~= nil then local frequency = frequency / 1000	end
	if     dir == "right"  or dir == 1 then x = x + lenght
	elseif dir == "bottom" or dir == 2 then y = y + lenght
	elseif dir == "left"   or dir == 3 then x = x - lenght
	elseif dir == "up"     or dir == 4 then y = y - lenght
	elseif dir == "center" or dir == 5 then
	elseif dir == "everywhere" or dir == 6 then for i = 1, 4 do func.SetBorderTriggerToObject(npc, trig_name..i,on_enter, i, lenght, radius, only_visible, on_leave, frequency, radius_delta, only_human) end --Думаю в данном случае в центре не нужно ставить еще тригер. VIRUS.
	end
	actor("trigger", x, y, {name=t_name, only_human=only_human, on_enter=on_enter, radius=radius, only_visible=only_visible, on_leave=on_leave, radius_delta=radius_delta})
	if frequency ~= nil then
		pushcmd(function() func.SetBorderTriggerToObject(npc, trig_name, on_enter, dir, lenght, radius, only_visible, on_leave, frequency, radius_delta, only_human) end, frequency)
	end
end

--Для того чтобы тригеры следовали за объектом. VIRUS. Бесполезная функция. Slava98.
function func.SetBorderTriggerFollowingObject(npc, trig_name, on_enter, dir, lenght, radius, frequency)
	local frequency = frequency or 0.001	
    func.SetBorderTriggerToObject(npc, on_enter, dir, lenght, radius)
--    if func.letBorderTriggerFollowingObject == 0 then
-- Не понял смысла цикла. Slava.        
--    else
        pushcmd( function() --[[kill(npc.."_speak")]] func.SetBorderTriggerFollowingObject(npc, trig_name, on_enter, dir, lenght, radius, frequency) end, frequency)
--    end
end

function func.LetBorderTriggerFollowingObject(num)
	local num = num or 0
    func.letBorderTriggerFollowingObject = num
end

--Задаёт цель для NPC, к которой он едет и запускает скрипт. Также реализовано событие on_leave. Slava98.
function func.NPC.SetAim(npc, x, y, f1, kill_after_enter, f2, kill_after_leave, g32)
	if g32 then x = func.Get32(x); y = func.Get32(y) end
	if exists(npc.."_aim_trig") then kill(npc.."_aim_trig") end
	if kill_after_enter then kill_f1 = "kill('"..npc.."_aim_trig'); " else kill_f1 = "" end
	if kill_after_leave then kill_f2 = "kill('"..npc.."_aim_trig'); " else kill_f2 = "" end
	func.NPC.Action(npc, nil, x, y, false) 
	actor("trigger", x, y, {name=npc.."_aim_trig", radius=1, on_enter="rawset(level.NPC, '"..npc.."_aim_trig', who.name); if who.name == '"..object(npc).vehname.."' then "..kill_f1..f1.." end", on_leave="if rawget(level.NPC, '"..npc.."_aim_trig') == '"..object(npc).vehname.."' then "..kill_f2..f2.." end"})
end

--Функция не работает.
function func.NPC.SetRotation(tank, rotation, speed)
	if speed ~= nil then local speed = 1/speed else local speed = 0.01 end
	if object(tank).rotation ~= rotation then 
		if object(tank).rotation < rotation then object(tank).rotation = object(tank).rotation + speed
		elseif object(tank).rotation > rotation then object(tank).rotation = object(tank).rotation - speed end
		pushcmd(function() func.NPC.SetRotation(tank, rotation) end, speed)
	end
end

--Для сюжета. Боты говорят и с игроком. Альфа версия. VIRUS.
function func.NPC.SpeakToPlayer(npc, part)
--	local npc = npc or "settler"
	local part = part or 1
--	local speak = level.SetSpeaks(npc)
	if func.timer[1] == 1 then
--		func.NPC.Action(npc)
--		func.NPC.StopAction(npc, 1)
--		func.Timer(1, 2)
--		message(speak) --FOR TEST
		level.SpeakToPlayer(npc, part)
--		if speak == "settler" then
--			if part == 1 then
--				message(func.dialog.Read("speak_to_player", "map01", math.random(8)))
--			elseif part == 2 then
--				message(func.dialog.Read("speak_to_player", "map01", func.OrGate(math.random(2, 7), math.random(9, 10))))
--			elseif part == 3 then
--				message(func.dialog.Read("speak_to_player", "map01", math.random(2, 10)))
--			elseif part == 4 then
--				message(func.dialog.Read("speak_to_player", "map01", func.OrGate(math.random(3, 4), math.random(11, 14))))
--			end
--		end
--		if func.timer[2] == 1 then
--			func.NPC.StopAction(npc, 0)
--			ai_stop(npc)
--			func.Timer(1, 2)
--		end
		func.Timer(2, 1)
	end
end

--Обработка события повреждения союзников. Slava98.
function func.NPC.DamageOurWarrior(who, npc)
	if who ~= nil then
        local attacker = who.name
		local a = rawget(level.damagespeak, npc)
		if attacker == ("ourplayer_tank") then 
            func.NPC.timesOfDamages = func.NPC.timesOfDamages + 1
            if     func.NPC.timesOfDamages == 1 then
                    message(rawget(a, 1)) --message(level.damageSpeak(npc, 1))
					pushcmd(function() if func.NPC.timesOfDamages == 1 then func.NPC.timesOfDamages = func.NPC.timesOfDamages - 1 end end, 10)						
            elseif func.NPC.timesOfDamages == 2 then
                    message(rawget(a, 2)) --message(level.damageSpeak2)
					pushcmd(function() if func.NPC.timesOfDamages == 2 then func.NPC.timesOfDamages = func.NPC.timesOfDamages - 2 end end, 10)
            elseif func.NPC.timesOfDamages == 3 then
                    message(rawget(a, 3)) --message(level.damageSpeak3)
					pushcmd(function() if func.NPC.timesOfDamages == 3 then func.NPC.timesOfDamages = func.NPC.timesOfDamages - 3 end end, 10)
            elseif func.NPC.timesOfDamages > 3 then
--                  message(rawget(a, 4)) --message(level.damageSpeak4)
					level.OurWarriorsAttack(attacker)
                    pset("ourplayer", "team", 2)
            end
		else
			level.OurWarriorsAttack(npc)
				
        end
	end
end

----------------------------------Игрок----------------------------------

--Создаёт игрока в определённом месте. Slava98.
function func.player.Create(class, skin, team, spawnteam, x, y, dir) 
	if func.player.exist ~= true then
		func.player.exist = true
		if type(class) == "table" then temp.class_name = "ourplayer_class"; rawset(classes, temp.class_name, tcopy(class)); class = nilx end
		local skin = skin or "player"
		local team = team or 1
		local spawnteam = spawnteam or 1
		local class = class or temp.class_name
		service( "player_local", { 
			name="ourplayer", 
			skin=skin, 
			team=spawnteam, 
			on_die="func.player.Die(); rawset (main.characters, 'ourplayer', nil)", 
			class=class, 
			vehname="ourplayer_tank",
			nick="Тестер" } )
		if x~=nil and y~=nil then
			local dir = dir or 0
			actor("respawn_point", x, y, {name="player_spawn",dir=dir, team=spawnteam})
		end
		pushcmd(function() 
							object("ourplayer").team = team 
							kill("player_spawn")
		end, 2) 		
		rawset (main.characters, "ourplayer", {weapons = {}, current_weapon = ""})
	end
end

--Обработка события гибели игрока. 
function func.player.Die() 
	func.player.exist = false
	if exists("ourplayer") then kill("ourplayer") end
	func.Play("lose")
	level.Lose()
--	msgbox("Вы проиграли!")
end

----------------------------------Другие----------------------------------

--Создаёт и прикрепляет танку оружие. Slava98.
function func.SetWeap(tank, weap, name)
	local weap = weap or "weap_cannon"
	local name = name or tank.."_weap"
	actor(weap, 0, 0, {name=name})
	equip(tank, tank.."_weap" )
end

function func.ChangeClass(tank, class)
	if type(class) == "table" then local class_name = name.."_class"; classes[class_name] = tcopy(class) end
	pset(tank, "class", name.."_class")
end

--Читает диалог. Пока последняя версия. Slava98.
function func.dialog.Read(speaker, dlg, num) 
	return rawget(
		   rawget(
		   rawget(
		   rawget(level.dialog, dlg), level.dialog.lang), speaker), num)
	--a=rawget(level.dialog, dlg)
	--b=rawget(a, level.dialog.lang)
	--s=rawget(b, num)
	--level.dialog.output = s
end

--Ранняя версия. Должна была читать диалог типа Fallout. Заброшена из-за сложности и лени. Slava98.
function func.ReadDialog(dialog)
	local strings = {}
	local num = 0
	local rnum = 0
	local language = "" 
	local langbool = false
	local char = ""
	for line in io.lines("data/campaign/War System/dialogs/"..dialog..".dlg") do num = num + 1; strings[num] = line end
	for i = 1, num do
		rnum = rnum + 1
		char=(string.char(string.byte(strings[rnum],i) ))
		if char == "[" then launguage = ""; langbool = true
		elseif langbool == true then language = language..char
		elseif char == "]" then langbool = false end
	end
	print(num, rnum, language, char)
--  char=(string.char(string.byte(content,i) ))
--	if file==nil then 
--                return(nil) 
--    end
--    local content = file:read("*a")
--    file:close() 
end

function func.dialog.Show(speaker, dlg, num, text, on_select, option1, option2, option3)
	if exists("dlgbox") then kill("dlgbox") end
	if not type(text) == "string" then text = "" end
	service("msgbox", {
						name="dlgbox",
						on_select=on_select, 
						text=func.dialog.Read(speaker, dlg, num)..text,  
						option1=option1,
						option2=option2,
						option3=option3} )
end

--Выводит сообщение. Сделал для красоты. Slava98.
function func.Message(speaker, dlg, num) 
	message(func.dialog.Read(speaker, dlg, num))
end

--Аномалия. Не, не из Сталкера, a из SaC TC =). Slava98.
function func.GraviCenter(x, y, radius, power)
	actor("trigger", func.Get32(x), func.Get32(y), {name="gc", radius=radius, on_enter="func.GraviLoop("..x..", "..y..", "..power..", who, 1)", on_leave="func.GraviLoop("..x..", "..y..", "..power..", who, 2)"})
end

function func.GraviLoop(x, y, power, tank, f)
	if f~=0 or f~=nil then
		local xt, yt = position(object(tank))
		func.Move(tank, x, y, true, power) 
		--setposition(object(tank), xt-x, yt-y)
		pushcmd(function() func.GraviLoop(x, y, power, tank, f) end, 0.1)
	end
end

--Возвращает номер текцщего левелпака. Slava98.
function main.levelpack.GetNum()
	for i = 1, table.maxn(main.levelpacks) do
		if main.levelpacks[i] == main.levelpack.default then return i end
	end
end

function func.MissionChange(a, i, text)
	if a == "main" then 
		func.dialog.mission_significance = func.dialog.Read("missions", "main", 1) 
		if text ~= nil then main.missions.mainMission = text end
	elseif a == "extra" then 
		func.dialog.mission_significance = func.dialog.Read("missions", "main", 2)
		if text ~= nil then main.missions.extraMission = text end
	end
	if i == "add" then
		message(func.dialog.mission_significance..func.dialog.Read("missions", "main", 3))
	elseif i == "plus" then
		message(func.dialog.mission_significance..func.dialog.Read("missions", "main", 4))
	elseif i == "complete" then
		message(func.dialog.mission_significance..func.dialog.Read("missions", "main", 5))
	elseif i == "cancel" then
		message(func.dialog.mission_significance..func.dialog.Read("missions", "main", 6))
	elseif i == "change" then
		message(func.dialog.mission_significance..func.dialog.Read("missions", "main", 7))
	end	
	if a == "main" then main.missions.mainMission = text
	elseif a == "extra" then  main.missions.extraMission = text
	elseif text == nil then
	end
	func.dialog.mission_significance = nil
end

function func.UniteTables(tab1, tab2)
	for i = 1, table.maxn(tab2) do
		table.insert(tab1, tab2)
	end
end

--Таймер. Делал для SpeakToPlayer, но может пригодиться и в других целях. VIRUS. (Нельзя запустить больше 1 таймера одновременно) Modfiled by Slava98. Теперь можно.
function func.Timer(t, num)
	func.timer[num] = 0
	pushcmd( function() print("TIMER! "..num) func.timer[num] = 1 end, t)
	return func.timer
end

--Возвращает true или false случайным образом. Slava98.
function func.RandomBoolean()
	if math.random(0,1)==1 then
		return true
	else
		return false
	end
end

--Возвращает первое или второе число случайным образом. Slava98.
function func.OrGate(firstNum, secondNum)
	if math.random(0,1) == 1 then return firstNum
	else return secondNum
	end
end

--Позволяет занести характеристики объекта в массив (запомнить объект). Slava98.
function func.ObjectCopy(obj)
	if exists(obj) then 
		local link = object(obj)
		local tab = {}
		tab.x, tab.y = position(obj)
		tab.type = objtype(obj)
		tab.link = func.PropertiesToTable(link)
		return tab
	else
--ERROR!
	end
end

--Преобразовывает метатаблицу с пропертами в обычную таблицу, с которой может работать Луа. Slava98.
function func.PropertiesToTable(metatable)
		local a = getmetatable(metatable)
		local proptab = {}
		local prop = "name"
		while prop ~= nil do
			rawset(proptab, prop, a.__index(metatable, prop))
			prop = a.__next(metatable, prop)
		end
		return proptab
end

--Позволяет из специального массива, созданного функцией func.Remember воссоздать объект (вспомнить объект). Slava98.
function func.ObjectPaste(tab, name, x, y)
	if type(tab)=="table" then
		tab.link.name = name or tab.link.name
		tab.x = x or tab.x
		tab.y = y or tab.y
		actor(tab.type, tab.x, tab.y, tab.link)
	else
--ERROR!
	end
end


-------------------------------------Генерация уровня------------------------------------------------------------

function func.gen.DrawLine(x1, x2, block, features)
	
end

function func.gen.Draw--[[...]]()

end

function func.gen.LmpRead(lmp)
	--[[local]] text = ""
    --[[local]] char = ""
    --[[local]] num = 1
	--[[local]] strings = {}
	--[[local]] values = {"type", "x", "y", "props"}
	--[[local]] val = {lenght = {}, a ={}}
	--[[local]] val_num = 1
    if not lmp then print(1) return(nil) end
    local file = io.open(lmp,"r") 
	for line in io.lines(lmp) do num = num + 1; strings[num] = line end
    file:close() 
	for i = 2, 3 do val.lenght[i-1] = strings[i] end
--[[	for i = 2, 3 do
		for j = 1, string.len(strings[i]) do
			char = string.char(string.byte(strings[i]))
			if char ~= " " then
				text = text..char
			else
				val.lenght[i] = text
				text = ""
			end
		end
	end]]
	for i = 4, num do
		val.a[i] = {}
		text = ""
		val_num = 1
		for j = 1, string.len(strings[i]) do
			char = string.char(string.byte(strings[i], j))
			if char ~= " " or char ~= ";" then
				text = text..char
			else
				rawset(val.a[i], rawget(values, val_num), text)
				if val_num ~= 4 then val_num = val_num + 1 else char = "" end
				text = ""
			end
		end
	end
	return val
end

--------------------------------------------Дополнительный урон------------------------------------------------------

function func.ExtraDamage(attacker, prey)
--	print("Ich tu Dir weh...")
	if attacker ~= nil and objtype(attacker.name) == "tank" then
		damage(rawget(
		rawget(main.characters, object(attacker.name).playername).weapons, 
		rawget(main.characters, object(attacker.name).playername).current_weapon).damage, prey)
	end
end

-------------------------------------------

function func.UnsetTempValues(mode)
	if mode ~= 1 then temp = {}, pushcmd(function() func.UnsetTempValues() end, 0.1) end
end

function func.RepeatCmd(f, t)
	
end
