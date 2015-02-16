-- ������� �������� War System.
-- By Slava98, VIRUS, hmh, ����������.

-- �����. ����������� ��� ����. ����� ������������ ������, ���������� ������� � ��� ���� ��� ������. �������� �� ������� hmh.
function func.Explosion(x, y, times, spd, dangerous, dam)
-- ���������� ������.
	if type(x) ~= "number" then error("bad argument #1 to 'func.Explosion' (number expected, got "..type(x)..")", 2) end
	if type(y) ~= "number" then error("bad argument #2 to 'func.Explosion' (number expected, got "..type(y)..")", 2) end
	if type(times) ~= "number" and times ~= nil then error("bad argument #3 to 'func.Explosion' (number expected, got "..type(times)..")", 2) end
	if type(spd) ~= "number" and spd ~= nil then error("bad argument #4 to 'func.Explosion' (number expected, got "..type(spd)..")", 2) end
	if type(dangerous) ~= "boolean" and dangerous ~= nil then error("bad argument #5 to 'func.Explosion' (number expected, got "..type(dangerous)..")", 2) end
	
	local times = times or 1;
	local spd = spd or 0;
	local dangerous;
	local dam = dam or 1000;
	if dangerous == nil then dangerous = true; end;
	for i = 0, times - 1 do
		pushcmd(function() 
			actor("user_object", x, y, {name="exploder"});
			damage(100, "exploder");
			if dangerous == true then 
			actor("trigger", x, y, {name="exp_"..x.."_"..y.."_trig1", on_enter="damage("..dam..", who.name)", only_human=0, radius=2, only_visible=0}) 
			actor("trigger", x, y, {name="exp_"..x.."_"..y.."_trig2", on_enter="damage("..dam.."/2, who.name)", only_human=0, radius=3, only_visible=0})
			actor("trigger", x, y, {name="exp_"..x.."_"..y.."_trig3", on_enter="damage("..dam.."/5, who.name)", only_human=0, radius=4, only_visible=0}) 
			end;
		end, 0 + i / 100*spd)
		pushcmd(function()
			for i = 1, 3 do kill("exp_"..x.."_"..y.."_trig"..i) end;
		end, 0.1 + i / 100*spd)
	end;
end

-- �������������. �������� �� ������� hmh.
function func.Bombard(x1, y1, x2, y2, times, spd, explo, explospd)
-- ���������� ������.
	if type(x1) ~= "number" then error("bad argument #1 to 'func.Bombard' (number expected, got "..type(x1)..")", 2) end
	if type(y1) ~= "number" then error("bad argument #2 to 'func.Bombard' (number expected, got "..type(y1)..")", 2) end
	if type(x2) ~= "number" then error("bad argument #3 to 'func.Bombard' (number expected, got "..type(x2)..")", 2) end
	if type(y2) ~= "number" then error("bad argument #4 to 'func.Bombard' (number expected, got "..type(y2)..")", 2) end
	if type(times) ~= "number" and times ~= nil then error("bad argument #5 to 'func.Bombard' (number expected, got "..type(times)..")", 2) end
	if type(spd) ~= "number" and spd ~= nil then error("bad argument #6 to 'func.Bombard' (number expected, got "..type(spd)..")", 2) end
	if type(explo) ~= "number" and explo ~= nil then error("bad argument #7 to 'func.Bombard' (number expected, got "..type(explo)..")", 2) end
	if type(explospd) ~= "number" and explospd ~= nil then error("bad argument #8 to 'func.Bombard' (number expected, got "..type(expospd)..")", 2) end
	
	local times = times or 24;
	local spd = spd or 15;
	local explo = explo or 1;
	local explospd = explospd or 0;
	
	local pixx = (x2-x1)/times;
	local pixy = (y2-y1)/times;
	for i = 0, times - 1 do
		pushcmd(function() func.Explosion(x1 + pixx*i, y1 + pixy*i, explo, explospd) end, 0 + i / 100*spd)
	end;
end 

-- ������������� ��������. �������� �� ������� hmh.
function func.Dangerzone(x1, y1, x2, y2, time, spd, isLinear, linspd)
-- ���������� ������.
	if type(x1) ~= "number" then error("bad argument #1 to 'func.Dangerzone' (number expected, got "..type(x1)..")", 2) end;
	if type(y1) ~= "number" then error("bad argument #2 to 'func.Dangerzone' (number expected, got "..type(y1)..")", 2) end;
	if type(x2) ~= "number" then error("bad argument #3 to 'func.Dangerzone' (number expected, got "..type(x2)..")", 2) end;
	if type(y2) ~= "number" then error("bad argument #4 to 'func.Dangerzone' (number expected, got "..type(y2)..")", 2) end;
	if type(time) ~= "number" and time ~= nil then error("bad argument #5 to 'func.Dangerzone' (number expected, got "..type(time)..")", 2) end;
	if type(spd) ~= "number" and spd ~= nil then error("bad argument #6 to 'func.Dangerzone' (number expected, got "..type(spd)..")", 2) end;
	if type(isLinear) ~= "booleand" and isLinear ~= nil then error("bad argument #7 to 'func.Dangerzone' (boolean expected, got "..type(isLinear)..")", 2) end;
	if type(linspd) ~= "number" and linspd ~= nil then error("bad argument #8 to 'func.Dangerzone' (number expected, got "..type(linspd)..")", 2) end;

	local time = time or 500;
	local spd = spd or 500;
	local isLinear = isLinear or false;
	local linspd = linspd or math.random(5, 20);
	
	if isLinear then
		local i = time / spd;
		for q = 0, i - 1 do
			pushcmd(function()
				rx = math.random(x1*32, x2*32);
				ry = math.random(y1*32, y2*32);
				func.Explosion(rx, ry) end, spd*q/100)
		end;
	else
		local i = time / spd;
		for q = 0, i - 1 do
			pushcmd(function()
				local rx1 = math.random(x1*32, x2*32);
				local rx2 = math.random(x1*32, x2*32);
				local ry1 = math.random(y1*32, y2*32);
				local ry2 = math.random(y1*32, y2*32);
				func.Bombard(rx1, rx2, ry1, ry2, linspd, spd) end, spd*q / 100)
		end;
	end;
end

-- ������� �������������� ����� ��������� ����� � ������. �������� �� ������� �����������. *������ ��������� ������������ �������������� ���������� ����������. Slava98. 30.12.13.
function func.Get32(...)
	local args = {...};
	for i = 1, #args do
		if type(args[i]) ~= "number" then error("bad argument #"..i.." to 'func.Get32' (number expected, got "..type(num)..")", 2) end;
		args[i] = ((args[i] - 1)*32) + 16;
	end;
	
	return unpack(args);
end

function func.UnGet32(...)
	local args = {...};
	for i = 1, #args do
		if type(args[i]) ~= "number" then error("bad argument #"..i.." to 'func.UnGet32' (number expected, got "..type(num)..")", 2) end;
		args[i] =  math.floor((math.floor(args[i]) - 16)/32 + 1);
	end;
	
	return unpack(args);
end

-- ����������� ���� � �������� �� ����� ��������� � ������ (���������� ���). VIRUS.
-- ���������. Slava98.
-- ������ ������� ��� ������ �� ������, �����, ��� ����� �����. Slava98. 26.02.14.
-- �������� �������������, ������ ������� � 8 ���. VIRUS.
-- ��������� �����������. Asqwel (Fluffle Puff / �����)
function func.GetRadians(x1, y1, x2, y2)
-- ���������� ������ (��������).

	local xCathetus = x2 - x1;
	local yCathetus = y2 - y1;
	local hypotenuse = math.sqrt((xCathetus * xCathetus) + (yCathetus * yCathetus));
	local alpha = math.acos(xCathetus / hypotenuse);

	if y2 >= y1 then
		return alpha;
	else
		return math.pi*2 - alpha;
	end;
end

-- �������� �������. Slava98. 26.02.14.
-- �������� Asqwel (Fluffle Puff / �����). 27.02.14.
function func.GetCoords(x1, y1, dir, length)
-- ���������� ������ (��������).

	local x2 = x1 + length * math.cos(dir);
	local y2 = y1 + length * math.sin(dir);
	return x2, y2;
end

-- ���������� ��������� ����� ����� �������� (� ��������). Slava98.
function func.GetDistance(x1, y1, x2, y2)
-- ���������� ������ (��������).

	return math.sqrt((x1 - x2)^2 + (y1 - y2)^2);
end

-- ���������� ������� � ������������ ���� ����� ������ ������ ����� � ����������� ������� (� �������). Slava98.
function func.GetCicle(x, y, radius, isHollow, ignoreObstacles, ignoreMinus, step)
-- ���������� ������ (��������).
	
	local ignoreObstacles; -- ������������ �� �����������. ���������� false.
	local ignoreMinus; -- ������������ �� ������������� ����������. ���������� true.
	local x1, y1 = x - radius, y - radius; -- ���������� ������� ����� ����� ��������, � ������� ������ ��� ����.
	local x2, y2 = x + radius, y + radius; -- ���������� ������ ������ ����� ���� ��������.
	local sin45 = 0.5*math.sqrt(2);
	local squaresNum = math.floor(2*math.pi*radius);
	local coordsTab = {};
	if isHollow == nil then isHollow = true; end;
	if ignoreMinus == nil then ignoreMinus = true; end;
	if ignoreObstacles == nil then ignoreObstacles = true; end;
	
	while radius ~= 1 do
		radius = radius - 1;
		local step = step or 90/(2 + radius);
		for i = 0, 360, step do
			local angle = i*math.pi/180;
			local cx, cy = x*32 + radius*32*math.cos(angle), y*32 + radius*32*math.sin(angle);
			table.insert(coordsTab, {func.UnGet32(cx), func.UnGet32(cy)})
		end;
		if isHollow then break; end;
	end;

	return coordsTab;
end

-- ������� ������ � ����� �����������. VIRUS. Modified by Assassin (�����).
-- ���������� �����, �� ������� ������ ����� ���������. Slava98.
-- ��������� �������! VIRUS.
-- ��������, ������� ���������. ������� func.StartMove ������� �� �������������. Asqwel (Fluffle Puff / �����). 27.02.2014.
function func.Move(name, x, y, g32, speed)
	local x1, y1 = position(name);
	local x2 = x;
	local y2 = y;

	if g32 then
		x2 = x2*32 - 16;
		y2 = y2*32 - 16;
	end;

	local xCathetus = math.abs(x1 - x2);
	local yCathetus = math.abs(y1 - y2);
	local hypotenuse = math.sqrt((xCathetus * xCathetus) + (yCathetus * yCathetus));  

	local alpha = func.GetRadians(x1, y1, x2, y2);
	local alCos = math.cos(alpha);
	local alSin = math.sin(alpha);

	for i = 1, hypotenuse do
		pushcmd(function() setposition(name, x1+i*alCos, y1+i*alSin) end, i/speed)
	end;

	return hypotenuse/speed;
end

function func.object.GetRightDirection(dir1, dir2)
-- ���������� ������ (��������).

	local k = 1;
	local alpha = dir1 - dir2;
	
	if math.abs(alpha) > math.pi then k = k * -1; end;     
	if alpha < 0 then k = k * -1; end;
	
	return k;
end

-- ���������� ������������� ������. *����������. Slava98. 10.02.14.
-- �����? Asqwel (Fluffle Puff / �����).
-- ������� ���������� ��� ������ ������� ���������. Asqwel (Fluffle Puff / �����), Slava98. 01.03.14.
function func.object.SetDir(objName, dir, frequency)
-- ���������� ������.
	if type(objName) ~= "string" then error("bad argument #1 to 'func.object.SetDir' (string expected, got "..type(objName)..")", 2) return; end;    
	if type(dir) ~= "number" then error("bad argument #2 to 'func.object.SetDir' (number expected, got "..type(dir)..")", 2) return; end;  
	if type(frequency) ~= "number" and frequency ~= nil then error("bad argument #3 to 'func.object.SetDir' (number expected, got "..type(frequency)..")", 2) return; end;    
	if type(active) ~= "boolean" and active ~= nil then error("bad argument #4 to 'func.object.SetDir' (boolean expected, got "..type(active)..")", 2) return; end;  

	local k = func.object.GetRightDirection(dir, object(objName).dir)
	local alpha = dir - object(objName).dir;
	local delta = k*math.rad(2);
	local function GetRotateName(obj) -- �������. Slava98. 04.08.14
		if objtype(obj) == "user_sprite" or objtype(obj) == "crate" then return "rotation";
		elseif objtype(obj) == "tank" or objtype(obj) == "respawn_point" or string.sub(objtype(obj), 0, 4) == "weap" or string.sub(objtype(obj), 0, 4) == "turret" then return "dir";
		end;
	end;
	local function Loop()
		if math.floor(object(objName).dir*10) == math.floor(dir*10) then return; end;
		local tmp = object(objName).dir + delta;
		
		if tmp > math.pi*2 then tmp = tmp - math.pi*2
		elseif tmp < 0 then tmp = tmp + math.pi*2; end;
		object(objName).dir = tmp;
		
		pushcmd(Loop, 1/frequency)
	end;
		
	Loop()
	
	local beta;
	if math.abs(alpha) > math.pi then beta = math.pi*2 - math.abs(alpha);
	else beta = math.abs(alpha); end;
	return (1/frequency)*(beta/(math.pi/90)); -- ���������� �����, �� ������� ����� �������� �������. Asqwel (Fluffle Puff / �����), Slava98. 01.03.14.
end

-- ��-������������� ���������� ����� ������. Slava98.
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
		end;
	end;
end

-- ����� ������� ��� � ��������� ���������.
function func.MakeName(wsObject)
	local name = tostring(math.random(1, 10000));
	if wsObject and level.objects[wsObject] or not wsObject and exists(name) then name = func.MakeName(wsObject);
	else return name;
	end;
end;

-- �������. � ������� �� exists, �������� � �� ������.
function func.Exists(obj)
-- ���������� ������.
	if type(obj) ~= "string" and type(obj) ~= "userdata" then error("bad argument #1 to 'func.Exists' (string or userdata expected, got "..type(objName)..")", 2) return; end;    

	if type(obj) == "userdata" then
		return xpcall(function() if obj.name then end; end, 1);
--[[		
		if not xpcall(function() if obj.name then end; end, 1) then return false; end;
		if obj.name and obj.name ~= "" then
			obj = obj.name;
		else
			local n; -- �������!!!
			while n == nil do
				n = func.MakeName() -- �������� � �������� � �������! ��� ������ ������� ������ �� �����.
			end;
			obj.name = n;
			obj = obj.name;
		end;]]
	end;
	return exists(obj);
end

-- ������� ������, ���� �� �� ����������. �� ����� ������. *����������, ������� ���, ����� �� ������� ������ ������ � ������������� ���������� takeOffWarning. Slava98. 11.01.14.
function func.KillIfExists(obj)
-- ���������� ������.
	if type(obj) ~= "string" and type(obj) ~= "userdata" then error("bad argument #1 to 'func.KillIfExists' (string or userdata expected, got "..type(objName)..")", 2) return; end;    
	if func.Exists(obj) then kill(obj) end;
end

-- ���������� ������.
function func.object.Recreate(objName)
-- ���������� ������ (��������).

	local objTab = func.ObjectCopy(objName);
	kill(objName);
	func.ObjectPaste(objTab)
end

function func.object.Speak(objName, text, timer, texture)
-- ���������� ������ (��������).
	if type(objName) ~= "string" then error("bad argument #1 to 'func.object.Speak' (string expected, got "..type(objName)..")", 2) end;
	if type(text) ~= "string" and type(text) ~= "table" then error("bad argument #2 to 'func.object.Speak' (string or table expected, got "..type(text)..")", 2) end;
	if type(timer) ~= "number" and timer then error("bad argument #3 to 'func.object.Speak' (number expected, got "..type(timer)..")", 2) end;
	if type(texture) ~= "string" and texture then error("bad argument #4 to 'func.object.Speak' (string expected, got "..type(texture)..")", 2) end;
	
-- ���������� ��������� ����������.
	local timer = timer or 3;
	local texture = texture or "font_small";
	local period = 0.001;

	if func.text.Exists(objName.."_speak") then func.text.Kill(objName.."_speak"); end;
	local x, y = position(objName);
	func.text.Create(objName.."_speak", x - 32, y - 48, {text=func.Read(text), texture=texture})
	if not func.timer.Exists(objName.."_speaktimer") then
		func.timer.Create(objName.."_speaktimer", {timer=timer, period=period, funcTab={
			function()
--				func.timer.Clear(npcName.."_speaktimer")
			end, 
			function()
				local x, y = position(objName);
				func.text.SetPosition(objName.."_speak", x - 32, y - 48)
			end,
			function()
				if func.text.Exists(objName.."_speak") then
					func.text.Kill(objName.."_speak")
					func.timer.Kill(objName.."_speaktimer")
				end;
			end},})
	end;
	func.timer.Play(objName.."_speaktimer")
end

---------------------------------------------------------------------------------------------------------------------
------------------------------------------------- ������-������� ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

-- ������ �������������� ����� 'bordertrigger', ������� � ���� ������� ������ �������� ������ ������������ �������. Slava98. 02.01.14.
function func.object.borderTrigger.Create(btName, objName, trigTab, btTab)
-- ���������� ������ (��������).

-- ���������� ��������� ����������.
	local btTab = func.UniteTables({
		dir = 5,
		length = 32,
		frequency = 0.1,
	}, btTab);
	trigTab.name = objName.."_"..btName.."_bordertrig";
	local multitriggerMode = false;
	local trigName = trigTab.name;
	local x, y;
	local function CorrectTrigPosition(dir) -- ��� ������� ��������� �������� ��������� ������ ������ �����. Slava98. 02.01.14.
		if     dir == "right"  or dir == 1 then x = x + btTab.length;
		elseif dir == "bottom" or dir == 2 then y = y + btTab.length;
		elseif dir == "left"   or dir == 3 then x = x - btTab.length;
		elseif dir == "up"     or dir == 4 then y = y - btTab.length;
		elseif dir == "center" or dir == 5 then
		elseif dir == "everywhere" or dir == 6 then	multitriggerMode = true; end;
	end;
	local function Loop()
		local btTab = level.objects[btName];
		if not btTab or not exists(objName) then if func.object.borderTrigger.Exists(btName) then func.object.borderTrigger.Kill(btName) end; return; end;
		if multitriggerMode then -- ������ ������ ��������� � ����������� ����������, ��� ���������� �������������. Slava98. 02.01.14.
		btTab.objName = {}; -- � ������ ������ ������� ������� ��� ��������. ��� �� ��������, �� ����� �� ������ ��������� ���� ������. Slava98. 02.01.14.
			for i = 1, 4 do
				x, y = position(objName);
				CorrectTrigPosition(i)
				setposition(trigName..i, x, y)
				btTab.objName[i] = trigName..i;
			end;
		else
			x, y = position(objName); -- ��������� ������� �������. Slava98. 02.01.14.
			setposition(trigTab.name, x, y)
			btTab.objName = trigTab.name;
		end;
		pushcmd(Loop, btTab.frequency)
	end;
	
	CorrectTrigPosition(btTab.dir)
	if not exists(objName) then return; end;
	if multitriggerMode then
		for i = 1, 4 do
			x, y = position(objName);
			CorrectTrigPosition(i)
			trigTab.name = trigName..i;
			level.objects[btName] = btTab;
			actor("trigger", x, y, trigTab)
		end;
	else
		x, y = position(objName);
		level.objects[btName] = btTab;
		actor("trigger", x, y, trigTab)
	end;
	Loop()
end

function func.object.borderTrigger.Kill(btName)
-- ���������� ������ (��������).

	if type(level.objects[btName].objName) == "string" and exists(level.objects[btName].objName) then kill(level.objects[btName].objName)
	elseif type(level.objects[btName].objName) == "table" then for i = 1, 4 do if exists(level.objects[btName].objName[i]) then kill(level.objects[btName].objName[i]) end; end;
	end;
	level.objects[btName] = nil;
end

function func.object.borderTrigger.Exists(btName)
-- ���������� ������ (��������).
	
	if level.objects[btName] then return true;
	else return false;
	end;
end

---------------------------------------------------------------------------------------------------------------------
--------------------------------------------- �������������� ������ -------------------------------------------------
--------------------------------------------------------------------------------------------------------------------- 

-- ������ �������������� ������ �������. Slava98. 02.01.14/04.08.14
function func.extrasprite.Create(name, obj, spriteTab, esTab)
-- ���������� ������ (��������).
	
	local esName = name or func.MakeName(true);
	local esTab = func.UniteTables({
		frequency = 0.00001,
		rotateSynch = true,
		texture,
	}, esTab);
	local x, y = position(obj);
	local spriteTab = func.UniteTables({
		animate = 25,
		layer = 5,
	}, spriteTab);
	local texture;
	local function GetRotateName(obj) -- �������. Slava98. 04.08.14
		if objtype(obj) == "user_sprite" or objtype(obj) == "crate" then return "rotation";
		elseif objtype(obj) == "tank" or objtype(obj) == "respawn_point" or string.sub(objtype(obj), 0, 4) == "weap" or string.sub(objtype(obj), 0, 4) == "turret" then return "dir";
		end;
	end;
	local function Loop()
		local esTab = level.objects[esName];
		if not esTab then return; -- ���� ������� ��� �������� ���, �� ���� ������������. Slava98. 02.01.14/04.08.14
		elseif not func.Exists(obj) or not func.Exists(texture) then func.extrasprite.Kill(esName) return; end;
		texture.rotation = obj[GetRotateName(obj)] -- � ������ ������� ����. Slava98. 02.01.14/04.08.14
		x, y = position(obj); -- ������� ���������� ������ ������� �������. Slava98. 02.01.14/04.08.14
		esTab.texture = texture;
		if name and not exists(name) then spriteTab.name = name; end;
		setposition(texture, x, y)
		pushcmd(Loop, esTab.frequency)
	end;
	
	if type(obj) == "string" then obj = object(obj); end; -- ������ ����� ����, ��� �������, ��� � �������. Slava98. 04.08.14
	if esTab.rotateSynch then spriteTab.rotation = obj[GetRotateName(obj)] end; -- �������� ����� �� ���������� ������� ��������� �������. Slava98. 04.08.14

	texture = actor("user_sprite", x, y, spriteTab);
	esTab.texture = texture; -- ������ ����� ��������� � ������� �������. Slava98. 04.08.14
	level.objects[esName] = esTab;
	
	Loop()
	return esName;
end

-- ������� ������. Slava98. 02.01.14/04.08.14
function func.extrasprite.Kill(esName)
	if not level.objects[esName] then error("bad argument #1 to 'func.extrasprite.Kill' (object '"..esName.."' doesn't exists)", 2) end;
	
	func.KillIfExists(level.objects[esName].texture)
	level.objects[esName] = nil;
end

---------------------------------------------------------------------------------------------------------------------
------------------------------------------------ ������� ------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

function func.projectile.Create(projName, projTab, x, y)
-- ���������� ������ (��������).

	local projTab = func.UniteTables(
		{
			projType = projType or "", -- ��� �������. �������������� ��������, ������ ������ ��� ��������� �������.
			textureTab = nil, -- ������� � ���������������� ��������� �����. ���� ������, �� ������ �������.
			explosionTab = nil, -- ������� � ���������������� ��������� ������. ���� ������, �� ����� �������.
			trailTab = nil, -- ������� � ���������������� ��������� ����� �������. ���� ������, �� ������ ���.
			splashTab = nil, -- ������� � ���������������� ��������� ������ �� ������������ �� ������. ���� ������, �� ������ ���.
			speed = 10, -- �������� �������.
			speedResidual = 1, -- ������� ��������, ������� ������ ������ ��� ������������ � ��������.
			width = 1, -- ������ �������.
			length = 1, -- ����� �������.
			dir = 0, -- ����������� �������.
			damage = 50, -- ����������� ���� �� �������.
			damageResidual = 10, -- ������� �����, ������� ������ ������ ��� ������������ � ��������.
			numOfHits = 1, -- ���������� ������������ ��� ��������� �������.
			homingFactor = 0, -- ��������� �������������.
			target = "", -- ���� ���������������� �������. ���� ���, ��������� �������������.
			sightRange = math.pi/2, -- ���� ������ ������� ��� �������������.
			trailWidth = 1, -- ����� �������� ����� �������.
			lifeTime = 5, -- ����� ����� �������. 0 - �����.
			splashTime = 3, -- ����� ����� ��������� ������ �� ������������ �� ������.
			explosionTime = 1, -- ����� ����� ��������� ������.
			detonateOnOwner = true, -- ���������� �� ������, ���� ���������� � ��������. ������ ���� ������ �������.
			shootDown = false, -- ����� �� ����� ������.
			health = 50, -- �������� �������, ���� shootDown.
			healthResidual = 10, -- ��������, ������� ������ ������ ��� ������������ � ��������.
			pushingPower = 1000, -- ����, ������������ �������, � ������� ������ ����������.
			pushingPowerResidual = 200, -- ����, ������� ������ ������ ��� ������������ � ��������.
			explosionRadius = 0, -- ������ ������. 0 - ���� ��������� ������ ����.
			onCreate = "", -- ���������� ��� �������� �������.
			onDestroy = "", -- ���������� ��� ��������� �������.
			onHit = "", -- ���������� ��� ������������ � ��������.
			onLoop = "", -- ���������� ��� ����� �������.
			owner = nil, -- ������ �� ��������� �������.
		}, projTab)
	local function MakeName() -- ����� ������� ��� � ��������� ���������.
		local name;
		if projTab.owner and projTab.owner.name then
			name = projTab.owner.name.."_projectile"..projTab.projType..math.random(1, 10000);
		else
			name = "projectile"..projTab.projType..math.random(1, 10000);
		end;
		if exists(name) then MakeName()
		else return name;
		end;
	end;
	local projName = projName or MakeName();
	local texture; -- ������ �� ��������.
	local lifeIsOver; -- ������ �� ����� ����� �������.
	local trails = {}; -- ������ �� �������� �� �������� ������ �� ��������.
	local n = 0; -- ����� ������� ��������� � Loop.
	local x1, y1;
	local function Hit(objLink, obj)
		local projTab = level.projectiles[projName];
		local splash;
		damage(projTab.damage, objLink)
		if func.Exists(objLink) then
			if obj == "tank" then
--				func.tank.OnDamage(objLink, projTab) -- ����� ������� ��� ���.
			end;
			if obj == "crate" or obj == "tank" and projTab.pushPower and projTab.pushingPower ~= 0 then
				pushobj(objLink, projTab.dir, projTab.pushingPower)
			end;
		end;
		loadstring(projTab.onHit)()
		if projTab.splashTab then 
			splash = actor("user_sprite", x, y, projTab.splashTab);
			pushcmd(function() func.KillIfExists(splash) end, projTab.splashTime)
		end;
		-- ������ ������ ��������, ���� � ���� ����� ������������ � ��������� (���� �� ����� ��������� ������ ���).
		if projTab.numOfHits == 0 then return true; end;
		projTab.damage = projTab.damage - projTab.damageResidual;
		projTab.speed = projTab.speed - projTab.speedResidual;
		projTab.pushingPower = projTab.pushingPower - projTab.pushingPowerResidual;
		projTab.numOfHits = projTab.numOfHits - 1;
	end;
	local function Destroy()
		local projTab = level.projectiles[projName];
		local explosion; -- ������ �� �����.
		loadstring(projTab.onDestroy)()
		if projTab.explosionTab then explosion = actor("user_sprite", x, y, projTab.explosionTab); explosion.layer = 1; end;
		-- �������� ������� �������.
		func.KillIfExists(texture)
		-- �������� �������� �����.
		if projTab.explosionRadius and projTab.explosionRadius > 0 then
			-- !! ����� ������� ���, ����� ������������ �������.
		end;
		-- �������� ������ �� �������.
		for i = 1, #trails do
			func.KillIfExists(trails[i])
		end;
		-- ��������� ������� ������.
		if projTab.explosionTab then
			pushcmd(function() func.KillIfExists(explosion) end, projTab.explosionTime)
		end;
	end;
	local function Loop()
		local projTab = level.projectiles[projName];
		local x1, y1 = func.GetCoords(x, y, projTab.dir, 5);
		-- �������� �������.
		if lifeIsOver then Destroy() return; end;
		-- �������� ���������� ������� �� �����.
		if x < 0 or y < 0 then Destroy() return; end;
		-- �������� �����������.
		-- ���� ����������� ��� ������ ������ 3 �������.
		if math.fmod(n, 3) == 0 then 
			local supposedObjects = {"tank", "wall_concrete", "wall_brick", "user_object", "crate"};
			for x2 = 1, projTab.length do
				for y2 = 1, projTab.width do
					if x2 == projTab.length or y2 == projTab.width or x2 == 1 or y2 == 1 then
						for i, obj in pairs(supposedObjects) do
							local x3, y3 = x1 + math.floor(x2 - 0.5*projTab.length), y1 + math.floor(y2 - 0.5*projTab.width);
							local objLink = findobj(obj, x3, y3);
							if objLink and not (projTab.owner and (objLink == projTab.owner or objLink.name == projTab.owner.name or objLink.name == projTab.owner)) then
								if Hit(objLink, obj) then Destroy() return; end;
							end;
						end;
						-- !! �������� �� ������������ � ������ ��������.
					end;
				end;
			end;
		end;
		-- ����� ����, ���� ������� ��� ����������.
		if projTab.homingFactor ~= 0 and projTab.target ~= "" then
			-- !! ��� ���-�� ����� �������, ����� ������� ���� � ���� ������ �������.
		end;
		-- �������������.
		if projTab.homingFactor ~= 0 and projTab.target ~= "" then
			local x2, y2 = position(projTab.target); -- ������� ����������.
			local dirToTarget = func.GetRadians(x, y, x2, y2); -- ���� �������� � ����������.
			print(dirToTarget)
			local k = func.object.GetRightDirection(projTab.dir, dirToTarget); -- ���������� ����������� ����������� �������.
			tmp = projTab.dir + 0.1*k*projTab.homingFactor*math.pi/90;
			
				if tmp > math.pi*2 then tmp = tmp - math.pi*2
			elseif tmp < 0 then tmp = tmp + math.pi*2; end;
			
			projTab.dir = tmp;
		end;
		-- �������� ������ ������ �������� �� ������� �������.
		projTab.textureTab.rotation = projTab.dir;
		texture.rotation = projTab.textureTab.rotation; -- �������!!!
--[[	for property, value in pairs(func.PropertiesToTable(texture)) do -- ���� �����������, ��� �������������� func.PropertiesToTable �� ����������.
			if projTab.textureTab[property] and texture[property] ~= projTab.textureTab[property] then
				texture[property] = projTab.textureTab[property]; 
			end;
		end;]]
		-- ���������� �������� �������.
		loadstring(projTab.onLoop)()
		-- ���� �� �������.
		if n/projTab.trailWidth == math.ceil(n/projTab.trailWidth) and projTab.trailTab then
			local trail;
			trail = actor("user_sprite", x, y, projTab.trailTab);
			trail.rotation = projTab.dir;
			trail.layer = 1;
			table.insert(trails, trail)
		end;
		-- �����������.
		x, y = x1, y1;
		setposition(texture, x, y)
		n = n + 1;
		pushcmd(Loop, 0.0001/projTab.speed)
	end;
	
	-- ���� ����������� ����� ����� ������� ������� animate � ������, �� ������� ��� ��� ���������. 
	if projTab.explosionTab and type(projTab.explosionTab.animate) ~= "number" then error("bad variable 'explosionTab.animate' in argument #2 to 'func.projectile.Create' (number expected, got "..type(projTab.explosionTab.animate).."): don't forget about explosion animate", 2) return; end; 

	-- � ��������� ������� � ������ �� ���� ������������ �����. Slava98. 21.07.14.	
--[[projTab.textureTab.name = projTab.textureTab.name or projName.."_sprite";
	projTab.explosionTab.name = projTab.explosionTab.name or projName.."_explosion";
	projTab.trailTab.name = projTab.trailTab.name or projName.."_trail";]]
	
	loadstring(projTab.onCreate)()
	projTab.textureTab.layer = projTab.textureTab.layer or 5;
	if projTab.textureTab then texture = actor("user_sprite", x, y, projTab.textureTab); end;
	if projTab.lifeTime and projTab.lifeTime > 0 then pushcmd(function() lifeIsOver = true; end, projTab.lifeTime) end;
	
	level.projectiles[projName] = projTab;
	Loop()
	return projName;
end

---------------------------------------------------------------------------------------------------------------------
----------------------------------------------- �������� ------------------------------------------------------------
----------------------------------- (���������� �� ������������� ����) ---------------------------------------------


--- GENIUS :D (�������� ��� The Prodigy) --- VIRUS ---

-- ������� ����� �������
function func.CreatePoligon(poligonName)
        local poligonName = poligonName or "poligon1"
--      rawset(func.poligons, poligonName, {} )
        func.poligons[poligonName] = {numOfSquares = 0} --��������� ������� � ������� ������ � ������ ���������
end

-- ��������� ������� ���������� ��������� ���������  � �������
function func.AddSquareToPoligon(poligonName, squareName, --[[trigNum,]] figure) -- figure (0 - �������������, 1 �����������); squareName - ������� ��������, ������� ������ ������ ����������.
        local poligonName = poligonName or "poligon1" 
        local trigNum = trigNum or 4
        local squareName = squareName or "square1"
        local figure = figure or 0
        
        func.poligons[poligonName].numOfSquares = func.poligons[poligonName].numOfSquares + 1 --��������� ���������� ���������� � ��������
        func.poligons[poligonName].poligonSquares[numOfSquares] = squareName --��������� ��� ���������� � ������ ��������
        
        if figure == 0 then
                trigNum = 4
        elseif firgure == 1 then
                trigNum = 3
        end
        
--      rawset(func.poligons[poligonName], squareName, {})
        for i = 1, trigNum do
                local x, y = position(squareName..trigNum)
                func.poligons[poligonName][squareName]["trig"..trigNum]["x"] = {x} --���������� �������� �� x
                func.poligons[poligonName][squareName]["trig"..trigNum]["y"] = {y} --���������� �������� �� y
--              rawset(func.poligons[poligonName][squareName..trigNum], "x", {x})
--              rawset(func.poligons[poligonName][squareName..trigNum], "y", {y})
        end
end

function func.DeleteSquareFromPoligon(poligonName, squareName) --����� ��������� ��� ������� �������� ���������� �� ��������. ����� ������ �������� �� �����, �� ��� ��������� �����������������.
        
end

--- ������-������� (���������� :D) ---

-- �������� �����������
function func.CreateMegaTrig(poligonName, megaTrigName, on_enter, on_leave, only_human, only_bot)
        local poligonName = poligonName or "poligon1"
        local megaTrigNam = megaTrigNam or "megaTrig1"
        func.megaTrigs[megaTrigName].poligon = func.poligons[poligonName]
        func.megaTrigs[megaTrigName].on_enter = on_enter
        func.megaTrigs[megaTrigName].on_leave = on_leave
        func.megaTrigs[megaTrigName].only_human = only_human
        func.megaTrigs[megaTrigName].only_bot = only_bot
end

function func.EditMegaTrig(poligonName, megaTrigName, on_enter, on_leave, only_human, only_bot) --��� ����� � ���-�� ���������� � ���������� ��� �������?
        local poligonName = poligonName or "poligon1"
        local megaTrigNam = megaTrigNam or "megaTrig1"
        func.megaTrigs[megaTrigName].poligon = func.poligons[poligonName]
        func.megaTrigs[megaTrigName].on_enter = on_enter
        func.megaTrigs[megaTrigName].on_leave = on_leave
        func.megaTrigs[megaTrigName].only_human = only_human
        func.megaTrigs[megaTrigName].only_bot = only_bot
end

function func.MegaTrigCheck(megaTrigName) --���� ���� �������� � ���� ������-���� �� ��������� �������� ����������� �� ���������� ��� �������, ��� ���������� �������� �� �� ������ ���� � ���� ����������� ��� ���. ����� ��������� ��� ������� �� ����� �������
        --��� ����� ����� ����� ����.
end

--[[
-- ������
function func.BuildSwamp(poligonName, trigNum, figure) 
        local poligonName = poligonName or "poligon1"
        local trigNum = trigNum or 4
        local figure = figure or 1
        
        
        for i=1, trigNum do
                
        end
end
]]
--������ ����� ������ ����� ������������. ��� ����� ���-�� ��������. ����, ��� ��, ���� �������


---------------------------------------------------------------------------------------------------------------------
-------------------------------------------- ������ � ����� ---------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

-- ��� ��� � ��� ���� ������. VIRUS
-- ��� ��� ����, ����� ���� ����� � ��� ����� ������ ��� �������������� �� ��������. Sl@v@98

function getvclass(cls, weap)
	if weap then
		if cls == "player1" then
			if not main.characters[const.playerName].inventory.isSetWeap then 
				func.CharacterSetWeap(const.playerName, weap)
			else
				main.characters[const.playerName].inventory.isSetWeap = false;
			end;
		end
			local tmp = tcopy(classes[cls])
		return tmp           -- and return modified class desc
	end
	return classes[cls]
end

function func.EquipWeap(weapType, weapName, tankName)
-- ���������� ������.
	if type(weapType) ~= "string" then error("bad argument #1 to 'func.EquipWeap' (string expected, got "..type(weapType)..")", 2) end;
	if type(weapName) ~= "string" then error("bad argument #2 to 'func.EquipWeap' (string expected, got "..type(weapName)..")", 2) end;
	if type(tankName) ~= "string" then error("bad argument #3 to 'func.EquipWeap' (string expected, got "..type(tankName)..")", 2) end;
	
--	if exists(weap) then kill(weap) end
	if not exists(weapName) then actor(weapType, 0, 0, {name = weapName}) end
	equip(tankName, weapName)
--	main.characters[object(tank).playername].current_weapon = weap; -- ��� ������ ������������� ��� � ����� ���������. Slava98. 30.12.13.
end

-- ������������ �������� ������ � ���� � �����. Slava98.
function func.ConvertWeap(weap)
	if weap == "weap_autocannon" then return func.Read({"main", "weap", 1});
	elseif weap == "weap_bfg" then return func.Read({"main", "weap", 2});
	elseif weap == "weap_shotgun" then return func.Read({"main", "weap", 3});
	elseif weap == "weap_zippo" then return func.Read({"main", "weap", 4});
	elseif weap == "weap_plazma" then return func.Read({"main", "weap", 5});
	elseif weap == "weap_minigun" then return func.Read({"main", "weap", 6});
	elseif weap == "weap_gauss" then return func.Read({"main", "weap", 7});
	elseif weap == "weap_rocket" then return func.Read({"main", "weap", 8});
	elseif weap == "weap_ripper" then return func.Read({"main", "weap", 9});
	elseif weap == "weap_ram" then return func.Read({"main", "weap", 10});
	elseif weap == "weap_cannon" then return func.Read({"main", "weap", 11});
	elseif weap == "" then return "";
	end
end

---------------------------------------------------------------------------------------------------------------------
----------------------------------------------- �������� ------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

-- �������, ������������ (���������) ������� �� �����.
function func.ShowItem(item, x, y, takable, texture, name)
-- ���������� ������.
	if type(item) ~= "string" then error("bad argument #1 to 'func.ShowItem' (string expected, got "..type(item)..")", 2) end;
	if type(x) ~= "number" then error("bad argument #2 to 'func.ShowItem' (number expected, got "..type(x)..")", 2) end;
	if type(y) ~= "number" then error("bad argument #3 to 'func.ShowItem' (number expected, got "..type(y)..")", 2) end;
	if type(takable) ~= "boolean" and takable ~= nil then error("bad argument #4 to 'func.ShowItem' (boolean expected, got "..type(takable)..")", 2) end;
	if type(texture) ~= "string" and texture ~= nil then error("bad argument #5 to 'func.ShowItem' (string expected, got "..type(texture)..")", 2) end;
	if type(name) ~= "string" and name ~= nil then error("bad argument #6 to 'func.ShowItem' (string expected, got "..type(name)..")", 2) end;
--
	local texture;
	local sound;
	local animate = 0;
	local name = name or "item"..level.itemNum;
	level.itemNum = level.itemNum + 1;
--
	if item == "healthpack" then
		texture = "user/health";
		sound = "pickup";
	elseif item == "mine" then
		texture = "user/playermine";
		sound = "pickup";
	elseif item == "bomb" then
		texture = "user/bomb";
		sound = "pickup";
	elseif item == "boo" then
		texture = "pu_booster";
		sound = "pickup";
		animate = 25;
	elseif item == "battery" then
		texture = "pu_booster";
		sound = "energy";
		animate = 25;
	elseif item == "superhealthpack" then
		texture = "user/health";
		sound = "pickup";
	elseif item == "armor" then
		texture = "user/health";
		sound = "pickup";
	elseif item == "armor" then
		texture = "user/health";
		sound = "pickup";
	elseif item == "laserpack" then
		texture = "user/health";
		sound = "pickup";
	elseif item == "credit" then
		texture = "user/bonus";
		sound = "pickup";
		animate = 25;
	elseif item == "credit5" then
		texture = "user/bonus";
		sound = "pickup";
		animate = 25;
	elseif item == "credit25" then
		texture = "user/bonus";
		sound = "pickup";
		animate = 25;
	elseif item == "credit50" then
		texture = "user/bonus";
		sound = "pickup";
		animate = 25;
	elseif item == "credit100" then
		texture = "user/bonus";
		sound = "pickup";
		animate = 25;
	elseif item == "credit500" then
		texture = "user/bonus";
		sound = "pickup";
		animate = 25;
	elseif item == "credit1000" then
		texture = "user/bonus";
		sound = "pickup";
		animate = 25;
	elseif item == "credit1000000" then
		texture = "user/bonus";
		sound = "pickup";
		animate = 25;
	end;
	for i = 1, 1000 do
		if item == "key"..i then
			texture = "user/key";
			sound = "keyget";
			animate = 2;
		end;
	end;
	local sound = sound or "nil";
	if texture ~= nil then
		actor("user_sprite", x, y, {name=name, texture=texture, animate=animate, layer=1} )
		if takable ~= false then actor("trigger", x, y, {name=name.."_trig", on_enter="if who == const.playerName..'_tank' then sound = "..sound.."; end; func.GiveItem('"..item.."', who.playername, 1, "..sound..", true, '"..name.."')"} ) end;
	end;
end

-- �������, ������ ��������� �����-���� �������.
function func.GiveItem(item, character, num, sound, found, itemName)
-- ���������� ������.
	if type(item) ~= "string" then error("bad argument #1 to 'func.GiveItem' (string expected, got "..type(item)..")", 2) end;
	if type(character) ~= "string" then error("bad argument #2 to 'func.GiveItem' (string expected, got "..type(character)..")", 2) end;
	if type(num) ~= "number" and num ~= nil then error("bad argument #3 to 'func.GiveItem' (number expected, got "..type(num)..")", 2) end;
	if type(sound) ~= "string" and sound ~= nil then error("bad argument #4 to 'func.GiveItem' (string expected, got "..type(sound)..")", 2) end;
	if type(found) ~= "boolean" and found ~= nil then error("bad argument #5 to 'func.GiveItem' (boolean expected, got "..type(found)..")", 2) end;
	if not func.ExistsCharacter(character) then error("bad argument #2 to 'func.GiveItem' (character '"..character.."' does not exist)", 2) end;
	
-- ���������� ��������� ����������.
	local num = num or 1;
	local sound = sound or "pickup";
	local found = found or false; -- � ������� �������, ��� ������� ��� ��� ��� ������.
	local charTab = main.characters[character]; -- ������� ���������.
	local dlgFirstMessageNum; -- ����� ������ ��������� ("�� �����" ��� "�� �����").
	local dlgSecondMessageNum; -- ����� ����� ��������� (������� �� �������� ��������).
	local dlgItemNum = num; -- ���������� ���������.
-- ���� ������� �� ������� � ���������, �� ������������� ������.
	if charTab.height + func.ShowItemHeight(item)*num > charTab.maxHeight then
		if character == const.playerName and not main.inventory.playerKnowsAboutOverload then
			main.inventory.playerKnowsAboutOverload = true;
			pause(true)
			func.MsgBox({"main", "msg_notices", 41}, {on_select="pause(false)"})
		end;
		return;
	end;
-- ������ ����� ���������� ������� �� �������� � ��������� ������� �� ������.
	if itemName then
		kill(itemName);
		kill(itemName.."_trig") 
		level.OnPickup(itemName, item, character)
	end;
-- ��� ������ ����� �������� � �������������� ����� � ����. 
	if character == const.playerName then
		if sound ~= "none" then func.Sound(sound) end;
		pushcmd(function()
			main.menu.Refresh()
			if main.menu.section == "inventory_things" then main.menu.Show("inventory_things") end;
		end)
	end;
	if found then dlgFirstMessageNum = 1; else dlgFirstMessageNum = 2; end;
--	������ ��� ������� �������� ����� ��������� ������ ���������� ��� � ���������.
	local charTab = main.characters[character];
	local inventory = charTab.inventory;
	local items = inventory.items;
	if dlgItemNum == 1 then dlgItemNum = ""; else dlgItemNum = dlgItemNum.." " end; -- �� ����� ������, ��� �� ����� ������ 1, ��������, ����. 
	debug.Print("| "..character.." got "..dlgItemNum..item);
--	table.insert(items, item)
	if not func.Search(items, item) then items[item] = 0; end;
	items[item] = items[item] + num;
	if item == "healthpack" then
		dlgSecondMessageNum = 6;
		if character == const.playerName then func.Message(func.Read({"main", "items", dlgFirstMessageNum}, dlgItemNum, {"main", "items", dlgSecondMessageNum})) end; -- �� ����� ����.
	elseif item == "mine" then
		if num == 1 then dlgSecondMessageNum = 3; elseif num > 1 and num < 5 then dlgSecondMessageNum = 5; else dlgSecondMessageNum = 4; end;
		if character == const.playerName then func.Message(func.Read({"main", "items", dlgFirstMessageNum}, dlgItemNum, {"main", "items", dlgSecondMessageNum})) end; -- �� ����� ����.
	elseif item == "bomb" then
		if num == 1 then dlgSecondMessageNum = 7; elseif num > 1 and num < 5 then dlgSecondMessageNum = 9; else dlgSecondMessageNum = 8; end;
		if character == const.playerName then func.Message(func.Read({"main", "items", dlgFirstMessageNum}, dlgItemNum, {"main", "items", dlgSecondMessageNum})) end; -- �� ����� �����.
	elseif item == "boo" then
		if num == 1 then dlgSecondMessageNum = 10; elseif num > 1 and num < 5 then dlgSecondMessageNum = 12; else dlgSecondMessageNum = 11; end;
		if character == const.playerName then func.Message(func.Read({"main", "items", dlgFirstMessageNum}, dlgItemNum, {"main", "items", dlgSecondMessageNum})) end; -- �� ����� �������������� ���������.
	elseif item == "battery" then
		if num == 1 then dlgSecondMessageNum = 13; elseif num > 1 and num < 5 then dlgSecondMessageNum = 15; else dlgSecondMessageNum = 14; end;
		if character == const.playerName then func.Message(func.Read({"main", "items", dlgFirstMessageNum}, dlgItemNum, {"main", "items", dlgSecondMessageNum})) end; -- �� ����� ����������.
	elseif item == "superhealthpack" then
		dlgSecondMessageNum = 28;
		if character == const.playerName then func.Message(func.Read({"main", "items", dlgFirstMessageNum}, dlgItemNum, {"main", "items", dlgSecondMessageNum})) end; -- �� ����� ����-2.
	elseif item == "armor" then
		if num == 1 then dlgSecondMessageNum = 19; elseif num > 1 and num < 5 then dlgSecondMessageNum = 21;  else dlgSecondMessageNum = 20; end;
		if character == const.playerName then func.Message(func.Read({"main", "items", dlgFirstMessageNum}, dlgItemNum, {"main", "items", dlgSecondMessageNum})) end; -- �� ����� �����.
	elseif item == "armor" then
		if num == 1 then dlgSecondMessageNum = 29; elseif num > 1 and num < 5 then dlgSecondMessageNum = 31;  else dlgSecondMessageNum = 30; end;
		if character == const.playerName then func.Message(func.Read({"main", "items", dlgFirstMessageNum}, dlgItemNum, {"main", "items", dlgSecondMessageNum})) end; -- �� ����� ���.
	elseif item == "credit" then -- ���� �� ����� ������� �����, �� �� ��.
		if character == const.playerName then func.Message(func.Read({"main", "items", dlgFirstMessageNum}, "1 ", {"main", "msg_playerinfo", 3})) end;
		func.AddCredits(1, character)
	elseif item == "credits5" then
		if character == const.playerName then func.Message(func.Read({"main", "items", dlgFirstMessageNum}, "5 ", {"main", "msg_playerinfo", 2})) end;
		func.AddCredits(5, character)
	elseif item == "credits25" then
		if character == const.playerName then func.Message(func.Read({"main", "items", dlgFirstMessageNum}, "25 ", {"main", "msg_playerinfo", 2})) end;
		func.AddCredits(25, character)
	elseif item == "credits50" then
		if character == const.playerName then func.Message(func.Read({"main", "items", dlgFirstMessageNum}, "50 ", {"main", "msg_playerinfo", 2})) end;
		func.AddCredits(50, character)
	elseif item == "credits100" then
		if character == const.playerName then func.Message(func.Read({"main", "items", dlgFirstMessageNum}, "100 ", {"main", "msg_playerinfo", 2})) end;
		func.AddCredits(100, character)
	elseif item == "credits500" then
		if character == const.playerName then func.Message(func.Read({"main", "items", dlgFirstMessageNum}, "500 ", {"main", "msg_playerinfo", 2})) end;
		func.AddCredits(500, character)
	elseif item == "credits1000" then
		if character == const.playerName then func.Message(func.Read({"main", "items", dlgFirstMessageNum}, "1000 ", {"main", "msg_playerinfo", 2})) end;
		func.AddCredits(1000, character)
	elseif item == "credits1000000" then
		if character == const.playerName then func.Message(func.Read({"main", "items", dlgFirstMessageNum}, "1000000 ", {"main", "msg_playerinfo", 2})) end;
		func.AddCredits(1000000, character)
	end;
	for i = 0, 10000 do
		if item == "bomb_activated"..i then
			func.BombTimerLoop(i, character)
		end;
	end;
	for i = 1, 1000 do
		if item == "key"..i then
			if num == 1 then dlgSecondMessageNum = 16; elseif num > 1 and num < 5 then dlgSecondMessageNum = 18;  else dlgSecondMessageNum = 17; end;
			if character == const.playerName then func.Message(func.Read({"main", "items", dlgFirstMessageNum}, dlgItemNum, {"main", "items", dlgSecondMessageNum}, {"main", "keys", i}, ".")) end; -- �� ����� ������� ��������.
			table.insert(inventory.keys, i)
		end;
	end;
	func.CheckHeight(character, true) -- � ����� �������� ���������������.
end
 
function func.ConfiscateItem(item, character, num)
-- ���������� ������ (��������).

	if main.characters[character].inventory.items[item] == nil then error("bad argument #1 to 'func.ConfiscateItem' (character '"..character.."' hasn't got item '"..item.."')", 2) end;
	
	if character == const.playerName then
		pushcmd(function()
			main.inventory.playerKnowsAboutOverload = false;
			main.menu.Refresh()
			if main.menu.section == "inventory_things" then main.menu.Show("inventory_things") end;
		end)
	end;

	local num = num or 1;
	local items = main.characters[character].inventory.items;
	debug.Print("| "..num.." "..item.." was stealed from "..character.."");
	items[item] = items[item] - num;
	func.CheckHeight(character, true) -- � ����� �������� ���������������.
end
 
-- ���������� ��� ������������� ��������. �����, ����� ������� ������� �������� �� ����� �������, � �� ������ ���� ��������. Slava98.
function func.UseItem(item, character)
-- ���������� ������.
	if type(item) ~= "string" then error("bad argument #1 to 'func.UseItem' (string expected, got "..type(item)..")", 2) end;
	if type(character) ~= "string" then error("bad argument #2 to 'func.UseItem' (string expected, got "..type(character)..")", 2) end;
	if not func.ExistsCharacter(character) then error("bad argument #2 to 'func.UseItem' (character '"..character.."' isn't exist)", 2); end;

	if item == "healthpack" then func.inventory.UseHealthPack(character);
	elseif item == "superhealthpack" then func.inventory.UseSuperHealthPack(character);
	elseif item == "boo" then func.inventory.UseBoo(character);
	elseif item == "mine" then func.inventory.UseMine(character);
	elseif item == "bomb" then func.inventory.UseBomb(character);
	elseif item == "bomb_activated" then func.inventory.UseBombActivated(character);
--	elseif item == "key" then func.inventory.UseKey(character);
	elseif item == "battery" then func.inventory.UseBattery(character);
	else error("bad argument #1 to 'func.UseItem' (can't use item '"..item.."')", 2); return false;
	end;
	
	if character == const.playerName then
		main.inventory.playerKnowsAboutOverload = false;
--		main.menu.Inventory()
		if main.menu.section == "inventory_things" then main.menu.Show("inventory_things") end;
	end;
	
	if main.characters[character].inventory.items[item] ~= nil and main.characters[character].inventory.items[item] > 0 then debug.Print("| "..character.." is using "..item) end;
	func.CheckHeight(character, true) -- � ����� �������� ���������������.
	return true;
end

function func.DropItem(item, charName)
-- ���������� ������.
	if type(item) ~= "string" then error("bad argument #1 to 'func.DropItem' (string expected, got "..type(item)..")", 2) end;
	if type(charName) ~= "string" then error("bad argument #2 to 'func.DropItem' (string expected, got "..type(charName)..")", 2) end;
	if not func.ExistsCharacter(charName) then error("bad argument #2 to 'func.DropItem' (character '"..charName.."' isn't exist)", 2); end;
	
	local x, y = position(object(charName).vehname);
	local x, y = x + math.random(-16, 16), y + math.random(-16, 16);
	local inventory = main.characters[charName].inventory;

	inventory.numberOfDroppedItems = inventory.numberOfDroppedItems + 1;
	func.ConfiscateItem(item, charName)
	
	for i = 1, 10000 do
		if item == "bomb_activated"..i then
			func.inventory.DropBombActivated(charName, i)
			return;
		end;
	end;
	
	func.ShowItem(item, x, y, false, nil, charName.."_item"..inventory.numberOfDroppedItems)
	actor("trigger", x, y, {
		name=charName.."_item"..inventory.numberOfDroppedItems.."_trig", 
		on_leave="kill('"..charName.."_item"..inventory.numberOfDroppedItems.."'); kill('"..charName.."_item"..inventory.numberOfDroppedItems.."_trig'); func.ShowItem('"..item.."',"..x..", "..y..")" } )
end

-- ����������� ������ � ��������, ������� ����� �� ����� ��������. ������� ������ ��� ������.
function func.DropItemsBox(item, num)
	local itemNum = main.characters[const.playerName].inventory.items[item];
	
	if itemNum == 1 then
		func.DropItem(item, const.playerName)
		main.menu.Inventory()
		return;
	end;
	func.MsgBox(func.Read({"main", "inventory", 10}, num, " / ", itemNum), {
		on_select="local num="..num.."; if n==1 then for i = 1, num do func.DropItem('"..item.."', const.playerName); main.menu.Inventory(); end; elseif n==2 then if num>0 then func.DropItemsBox('"..item.."', num-1) else func.DropItemsBox('"..item.."', num) end; elseif n==3 then if num<"..itemNum.." then func.DropItemsBox('"..item.."', num+1) else func.DropItemsBox('"..item.."', num) end; end",
		option1 = func.Read({"main", "menu", 40}), 
		option2 = "<", 
		option3 = ">"},	"inventorybox")
end

-- ������ ������� � �������.
function func.PushItem(item, charName, num)
-- ���������� ������.
	if type(item) ~= "string" then error("bad argument #1 to 'func.PushItem' (string expected, got "..type(item)..")", 2) end;
	if type(charName) ~= "string" then error("bad argument #2 to 'func.PushItem' (string expected, got "..type(charName)..")", 2) end;
	if not func.ExistsCharacter(charName) then error("bad argument #2 to 'func.PushItem' (character '"..charName.."' isn't exist)", 2); end;
	
	local charTab = main.characters[const.playerName];
	local inventory = charTab.inventory;
	local num = num or 1;
	
	if not item == "healthpack" and not item == "superhealthpack" and not item == "boo" and not item == "battery" then return; end; -- ������� � ������� ����� ������ ��� ��������.
	if not inventory.numOfPushed[item] then inventory.numOfPushed[item] = 0; end;
	inventory.numOfPushed[item] = inventory.numOfPushed[item] + num;
	
	return inventory.numOfPushed[item];
end

-- ����������� ������ � ��������, ������� ����� �� ����� ��������� � �������. ������� ������ ��� ������.
function func.PushItemsBox(item, num)
	local inventory = main.characters[const.playerName].inventory;
	if not inventory.numOfPushed[item] then inventory.numOfPushed[item] = 0; end;
	local itemNum = inventory.items[item] - inventory.numOfPushed[item];
	local num = num or 1;
	
	if itemNum == 1 then
		func.PushItem(item, const.playerName)
		main.menu.Inventory()
		return;
	end;
	func.MsgBox(func.Read({"main", "inventory", 13}, num, " / ", itemNum), {
		on_select="local num="..num.."; if n==1 then func.PushItem('"..item.."', const.playerName, num); main.menu.Inventory(); elseif n==2 then if num>0 then func.PushItemsBox('"..item.."', num-1) else func.PushItemsBox('"..item.."', num) end; elseif n==3 then if num<"..itemNum.." then func.PushItemsBox('"..item.."', num+1) else func.PushItemsBox('"..item.."', num) end; end",
		option1 = func.Read({"main", "menu", 40}), 
		option2 = "<", 
		option3 = ">"},	"inventorybox")
end

-- ����������� ������ � ��������, ������� ����� �� ����� ������ �� �������. ������� ������ ��� ������.
function func.UnpushItemsBox(item, num)
	local inventory = main.characters[const.playerName].inventory;
	if not inventory.numOfPushed[item] then inventory.numOfPushed[item] = 0; end;
	local itemNum = inventory.numOfPushed[item];
	local num = num or 1;
	
	if itemNum == 1 then
		func.UnpushItem(item, const.playerName)
		main.menu.Inventory()
		return;
	end;
	func.MsgBox(func.Read({"main", "inventory", 18}, num, " / ", itemNum), {
		on_select="local num="..num.."; if n==1 then func.PushItem('"..item.."', const.playerName, -num); main.menu.Inventory(); elseif n==2 then if num>0 then func.UnpushItemsBox('"..item.."', num-1) else func.UnpushItemsBox('"..item.."', num) end; elseif n==3 then if num<"..itemNum.." then func.UnpushItemsBox('"..item.."', num+1) else func.UnpushItemsBox('"..item.."', num) end; end",
		option1 = func.Read({"main", "menu", 40}), 
		option2 = "<", 
		option3 = ">"},	"inventorybox")
end

function func.ShowItemHeight(item)
-- ���������� ������ (��������).	
	
	if item == "ammo" then
		return 0.5;
	elseif item == "boo" or item == "mine" or item == "battery" then
		return 1;
	elseif item == "healthpack" or item == "superhealthpack" or item == "armor" then
		return 2;
	elseif item == "bomb" or item == "laserpack" or item == "bomb_activated" then
		return 3;
	else
		return 0;
	end;
end

function func.CheckHeight(charName, withoutLooping)
	if not func.ExistsCharacter(charName) then return; end;
	
	local charTab = main.characters[charName];
	local items = charTab.inventory.items;
	local height = 0;
	
	for item, itemNum in pairs(items) do
		height = height + func.ShowItemHeight(item)*itemNum;
	end;
	
	charTab.height = height;
	if not withoutLooping then pushcmd(function() func.CheckHeight(charName) end, 0.1) end
end

-- ��������� ������� �� ���� �������.
function func.AddCredits(num, character)
	main.characters[character].credits = main.characters[character].credits + num;
	return main.characters[character].credits;
end

function func.inventory.UseHealthPack(character)
	if not func.ExistsCharacter(character) then error("bad argument #1 to 'func.UseHealthPack' (character isn't exist)", 2) end;
	if not exists(object(character).vehname) then return; end;
	
	local inventory = main.characters[character].inventory;
	if inventory.items.healthpack == nil or inventory.items.healthpack <= 0 then if character == const.playerName then func.MsgBox({"main", "msg_notices", 8}) end; return; end;	
	if inventory.isActivated["healthpack"] then 
		if character == const.playerName then pause(true); func.MsgBox({"main", "msg_notices", 26}, {on_select="pause(false); main.menu.Inventory()"}, "inventorybox") end;
	return; end;
	if character == const.playerName and object(object(character).vehname).health == object(object(character).vehname).max_health then pause(true); func.MsgBox({"main", "msg_notices", 28}, {on_select="pause(false); main.menu.Inventory()"}, "inventorybox") return; end;
	
	inventory.items.healthpack = inventory.items.healthpack - 1;
	if level.UseItem(character, "healthpack") then return; end;
	
	inventory.isActivated["healthpack"] = true;
	func.RestoreHealth(object(character).vehname, nil, nil, 25, 39, inventory.healTime)
	pushcmd(function() 
		inventory.isActivated["healthpack"] = false; 
		if inventory.numOfPushed["healthpack"] ~= nil and inventory.numOfPushed["healthpack"] > 0 then
			func.PushItem("healthpack", character, -1)
			func.inventory.UseHealthPack(character)
		end;
	end, 1/inventory.healTime*39)
	
	main.menu.Inventory()
	return main.characters[character].inventory.items.healthpack;
end

function func.inventory.UseSuperHealthPack(character)
	if not func.ExistsCharacter(character) then error("bad argument #1 to 'func.UseSuperHealthPack' (character isn't exist)", 25) end;
	if not exists(object(character).vehname) then return; end;
	
	local inventory = main.characters[character].inventory;
	if inventory.items.superhealthpack == nil or inventory.items.superhealthpack <= 0 then if character == const.playerName then func.MsgBox({"main", "msg_notices", 8}) end; return; end;	
	if inventory.isActivated["superhealthpack"] then 
		if character == const.playerName then pause(true); func.MsgBox({"main", "msg_notices", 27}, {on_select="pause(false); main.menu.Inventory()"}, "inventorybox") end;
	return; end;
	if character == const.playerName and object(object(character).vehname).health == object(object(character).vehname).max_health then pause(true); func.MsgBox({"main", "msg_notices", 28}, {on_select="pause(false); main.menu.Inventory()"}, "inventorybox") end;
	
	inventory.items.superhealthpack = inventory.items.superhealthpack - 1;
	if level.UseItem(character, "superhealthpack") then return; end;

	inventory.isActivated["superhealthpack"] = true;
	func.RestoreHealth(object(character).vehname, nil, nil, 25, 120, inventory.healTime*2)
	pushcmd(function() 
		inventory.isActivated["superhealthpack"] = false; 
		if inventory.numOfPushed["superhealthpack"] ~= nil and inventory.numOfPushed["superhealthpack"] > 0 then
			func.PushItem("superhealthpack", character, -1)
			func.inventory.UseSuperHealthPack(character)
		end;	
	end, 1/inventory.healTime*2*120)

	main.menu.Inventory()
	return main.characters[character].inventory.items.superhealthpack;
end

function func.inventory.UseBoo(character)
	if not func.ExistsCharacter(character) then error("bad argument #1 to 'func.UseBoo' (character isn't exist)", 2) end;
	if not exists(object(character).vehname) then return; end;

	local inventory = main.characters[character].inventory;
	if inventory.items.boo == nil or inventory.items.boo <= 0 then if character == const.playerName then func.MsgBox({"main", "msg_notices", 6}, nil, "noticebox") end; return; end;
	if inventory.isActivated["boo"] then 
		if character == const.playerName then pause(true); func.MsgBox({"main", "msg_notices", 5}, {on_select="pause(false); main.menu.Inventory()"}, "inventorybox") end;
	return; 
	end;
	if main.characters[character].currentWeap == nil then func.MsgBox({"main", "msg_notices", 29}, {on_select="pause(false); main.menu.Inventory()"}, "inventorybox") end;
		
--	func.AddNumEy(-1, character)
	if level.UseItem(character, "boo") then return; end;
	inventory.items.boo = inventory.items.boo - 1;
	inventory.isActivated["boo"] = true; -- �� �����������.
	
	pushcmd(function() actor("pu_booster", 0, 0, {name=character.."_boo"}) end, 0.1)
	pushcmd(function() equip(object(character).vehname, character.."_boo") end, 0.2)
	pushcmd(function() 
		if character == const.playerName then
			pause(true)
			func.MsgBox({"main", "msg_notices", 4}, {on_select="pause(false)"}, "noticebox") 
		end;
	end, 0.3)
	pushcmd(function() if character == const.playerName then func.Message({"main", "msg_notices", 14}) end; end, 20.3)
	pushcmd(function() kill(character.."_boo") end, 21)
	pushcmd(function() 
		inventory.isActivated["boo"] = false;
		if inventory.numOfPushed["boo"] ~= nil and inventory.numOfPushed["boo"] > 0 then
			func.PushItem("boo", character, -1)
			func.inventory.UseBoo(character)
		end;
	end, 22) -- ����� ��������� ��� ��������, �� ����� ����� �������� ���������.

	main.menu.Inventory()
	return main.characters[character].inventory.healthpackNum;
end

function func.inventory.UseMine(character)
	if not func.ExistsCharacter(character) then error("bad argument #1 to 'func.UseMine' (character isn't exist)", 2) end;
	if not exists(object(character).vehname) then return; end;

	local inventory = main.characters[character].inventory;
	if inventory.items.mine == nil or inventory.items.mine <= 0 then if character == const.playerName then func.MsgBox({"main", "msg_notices", 10}, nil, "noticebox") end; return; end;
	if inventory.isActivated["mine"] then 
		if character == const.playerName then pause(true); func.MsgBox({"main", "msg_notices", 9}, {on_select="pause(false); main.menu.Inventory()"}, "inventorybox") end;
	return; 
	end;
	
--	func.AddNumMine(-1, character)
	if level.UseItem(character, "mine") then return; end;
	inventory.items.mine = inventory.items.mine - 1;
	inventory.isActivated["mine"] = true;
	inventory.numberOfAcivatedMines = inventory.numberOfAcivatedMines + 1;	
	
	local x, y = position(object(character).vehname);
	actor("user_sprite", x, y, {
		name=character.."_mine"..inventory.numberOfAcivatedMines, 
		texture="item_mine", } )
	actor("trigger", x, y, {
		name=character.."_mine"..inventory.numberOfAcivatedMines.."_trig", 
		on_leave="if func.ExistsCharacter('"..character.."') then main.characters['"..character.."'].inventory.isActivated['mine'] = false; end; kill('"..character.."_mine"..inventory.numberOfAcivatedMines.."'); kill('"..character.."_mine"..inventory.numberOfAcivatedMines.."_trig'); actor('pu_mine',"..x..", "..y..", {on_pickup = 'func.MineDetonate(who)'})" } )
	
	main.menu.Inventory()
	return main.characters[character].inventory.healthpackNum;
end

function func.inventory.UseBomb(character)
	if not func.ExistsCharacter(character) then error("bad argument #1 to 'func.UseBomb' (character isn't exist)", 2) end;
	if not exists(object(character).vehname) then return; end;
	
	local charTab = main.characters[character];
	local inventory = charTab.inventory;
	if inventory.items.bomb == nil or inventory.items.bomb <= 0 then if character == const.playerName then func.MsgBox({"main", "msg_notices", 21}, nil, "noticebox") end; return; end;

	if inventory.dropBomb then
		if inventory.isActivated["bomb"] then 
			if character == const.playerName then pause(true); func.MsgBox({"main", "msg_notices", 22}, {on_select="pause(false); main.menu.Inventory()"}, "inventorybox") end;
		return;
		end;
		inventory.isActivated["bomb"] = true;
	end;

	if character == const.playerName then func.BombTimer(10) end;
	if level.UseItem(character, "bomb") then return; end;
	inventory.items.bomb = inventory.items.bomb - 1;
	
	pushcmd(function()
		inventory.isActivated["bomb"] = false;
		func.GiveItem("bomb_activated"..inventory.bombTime, character)
	end)
	pushcmd(function() debug.Print("| "..character.." activated bomb on "..inventory.bombTime.." nanocicles") end)
	
	return inventory.bombNum;
end

function func.BombTimerLoop(bombTime, charName)
	local charTab = main.characters[charName];

	if bombTime <= 0 then
		if exists(object(charName).vehname) then 
			local x, y = position(object(charName).vehname); 
			func.Explosion(x, y, nil, nil, nil, 3000)
		end;
		charTab.inventory.items["bomb_activated"..bombTime] = nil;
		return;
	end;
	
	pushcmd(function()
		if not charTab.inventory.items["bomb_activated"..bombTime] or charTab.inventory.items["bomb_activated"..bombTime] == 0 then return; end;
		charTab.inventory.items["bomb_activated"..bombTime] = nil; 
		func.GiveItem("bomb_activated"..bombTime - 1, charName) 
	end, 1)
end

function func.inventory.DropBombActivated(character, bombTime)
	if not func.ExistsCharacter(character) then error("bad argument #1 to 'func.DropBombActivated' (character isn't exist)", 2) end;
	if not exists(object(character).vehname) then return; end;
	
	local inventory = main.characters[character].inventory;
	if inventory.isActivated["bomb"] then 
		if character == const.playerName then pause(true); func.MsgBox({"main", "msg_notices", 22}, {on_select="pause(false); main.menu.Inventory()"}, "inventorybox") end;
	return;
	end;
	
	if level.UseItem(character, "bomb_activated") then return; end;
--	inventory.items["bomb_activated"..bombTime] = inventory.items.["bomb_activated"..bombTime];
	inventory.isActivated["bomb"] = true;
	inventory.numberOfAcivatedBombs = inventory.numberOfAcivatedBombs + 1;
	
	local x, y = position(object(character).vehname);
	local name = character.."_bomb"..inventory.numberOfAcivatedBombs;
	pushcmd(function() 
		actor("user_sprite", x, y, {
			name=name, 
			texture="user/bomb", } )
		actor("trigger", x, y, {
			name=name.."_trig", 
			on_leave="if func.ExistsCharacter('"..character.."') then main.characters['"..character.."'].inventory.isActivated['bomb'] = false; end; kill('"..character.."_bomb"..inventory.numberOfAcivatedBombs.."'); kill('"..character.."_bomb"..inventory.numberOfAcivatedBombs.."_trig'); func.ActorBomb('"..name.."', "..x..", "..y..")" } )
	end)
	pushcmd(function() debug.Print("| "..character.." dropped bomb activated on "..bombTime.." nanocicles") end)
	pushcmd(function() if not exists(character) and (exists("bomb"..inventory.numberOfAcivatedBombs) or exists("bomb"..inventory.numberOfAcivatedBombs.."_trig")) then func.KillIfExists("bomb"..inventory.numberOfAcivatedBombs); func.KillIfExists("bomb"..inventory.numberOfAcivatedBombs.."_trig") end; end, 1)
	pushcmd(function() pushcmd(function() if exists(name) then local x, y = position(name); func.Explosion(x, y, nil, nil, nil, 3000); func.KillIfExists(name); end; end, bombTime) end)
	
	return inventory.bombNum;
end

function func.inventory.UseBombActivated(character)
	if exists(object(charName).vehname) then 
		local x, y = position(object(charName).vehname); 
		func.Explosion(x, y, nil, nil, nil, 3000)
	end;
end

function func.inventory.UseKey(character)
	if not func.ExistsCharacter(character) then error("bad argument #1 to 'func.UseKey' (character isn't exist)", 2) end;
	if not exists(object(character).vehname) then return; end;
	
	if level.UseItem(character, "key") then return; end;
	
	if character == const.playerName then 
		pause(true)
		func.MsgBox({"main", "msg_notices", 16}, {on_select="pause(false)"}, "noticebox")
	end;
end

function func.inventory.UseBattery(character)
	if not func.ExistsCharacter(character) then error("bad argument #1 to 'func.UseBattery' (character isn't exist)", 2) end;
	if not exists(object(character).vehname) then return; end;
	
	local charTab = main.characters[character];
	local inventory = charTab.inventory;
	if inventory.isActivated["battery"] then 
		if character == const.playerName then pause(true); func.MsgBox({"main", "msg_notices", 38}, {on_select="pause(false); main.menu.Inventory()"}, "inventorybox") end;
	return; 
	end;
	if character == const.playerName then
		pause(true)
		if charTab.energy > 0.9*charTab.maxEnergy then func.MsgBox({"main", "msg_notices", 37}, {on_select="pause(false); main.menu.Inventory()"}, "inventorybox"); return; end;
	end
	
	if level.UseItem(character, "battery") then return; end;
	inventory.items.battery = inventory.items.battery - 1;
	func.CharacterRestoreEnergy(character)
	pushcmd(function()
		
		if inventory.numOfPushed["battery"] ~= nil and inventory.numOfPushed["battery"] > 0 then
			func.PushItem("battery", character, -1)
			func.inventory.UseBattery(character)
		end;
	end, 8)

	main.menu.Inventory()
	return main.characters[character].inventory.items.battery;
end


function func.inventory.DropAllItems(charName)
	local x, y = position(object(charName).vehname); 
	local charTab = main.characters[charName];
	for itemName, i in pairs(charTab.inventory.items) do
		local itemNum = charTab.inventory.items[itemName];
		if itemNum ~= 0 then debug.Print("| "..charName.." was dropped "..itemNum.." "..itemName) end;
		if itemNum > 0 then
			for j = 1, itemNum do
				func.ConfiscateItem(itemName, charName)
				func.ShowItem(itemName, x + math.random(-32, 32), y + math.random(-32, 32)) 
				itemNum = itemNum - 1;
			end;
		end;
	end;
end

---------------------------------------------------------------------------------------------------------------------
------------------------------------------------ ��������� ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

function func.CreateCharacter(charName, charTab) -- ��� ������� ���������, ��� ��� NPC, ��� � ��� ������, �, ��������, ������� ����������.
-- ���������� ������.
	if type(charName) ~= "string" then error("bad argument #1 to 'func.CreateCharacter' (string expected, got "..type(charName)..")", 2) end
	if type(charTab) ~= "table" and charTab ~= nil then error("bad argument #2 to 'func.CreateCharacter' (table expected, got "..type(charTab)..")", 2) end	
	if charTab == nil then charTab = {} end;
	
	local charTab = func.UniteTables({
		faction = "unknown", -- ������� ���������.
		rank = 0, -- ���� ���������. ������ �� ��� ����������.
		group = "", -- ������ ��������� �� ������.
		charType = "unknown", -- ��� ���������.
		vehType = "tank", -- ��� ������ ���������. 
		ruleset = {}, -- ������� �������� ���������.
		credits = 1000, -- �������.
		energy = 4500, -- ������� ���������� ������� ���������. �������� 1 ��. � ���. �� ������� �����, 3 ��. � ���. ��� ����������� �� ����������.
		maxEnergy = 4500, -- ������� ��������� � �������� ���������.
		energyConsumptionMainSystems = 1, -- ������� ������� � ������� �� ������� ������� (��������, ��������).
		
		currentWeap = "none", -- ������� ������ �����.			--\
		allowedWeapsNum = 2, -- ������������ ���������� ������.	---- �� ��� ������ ����� � ������ "����" � �������. Slava98. 30.12.13.
		inventory = {}, -- ��������� �����.						--/
		devices = {}, -- ���������� �����.
		maxHeight = 100, -- ��������������� �����.
		height = 1, -- ������ ����� � �����.
	}, charTab);

	-- ���� ���� �� ��������� ������� ������������, �� �� ���������� ������ 5.
	if type(charTab.ruleset.damage) ~= "number" or charTab.ruleset.damage > 10 or charTab.ruleset.damage < 1 then charTab.ruleset.damage = 5; end;
	if type(charTab.ruleset.eloquence) ~= "number" or charTab.ruleset.eloquence > 10 or charTab.ruleset.eloquence < 1 then charTab.ruleset.eloquence = 5; end;
	if type(charTab.ruleset.luck) ~= "number" or charTab.ruleset.luck > 10 or charTab.ruleset.luck < 1 then charTab.ruleset.luck = 5; end;
	if type(charTab.ruleset.strategy) ~= "number" or charTab.ruleset.strategy > 10 or charTab.ruleset.strategy < 1 then charTab.ruleset.strategy = 5; end;

	charTab.inventory = func.UniteTables(func.CopyTable(shape.inventory), charTab.inventory);
	shape.inventory.weapons = func.CopyTable(shape.inventory.weapons); -- ����� ������ �� ���� ������. � ��� �� ���������! Slava98.
	shape.inventory.items = func.CopyTable(shape.inventory.items); -- �������� ����.
	charTab.devices = func.UniteTables(func.CopyTable(shape.devices), charTab.devices);
	
	if charTab.currentWeap ~= "none" then table.insert(charTab.inventory.weapons, {weapType=charTab.currentWeap, equipped=true}); end; -- ������� ������ ����������� � ������ ������ ����������. Slava98. 30.12.13.
	main.characters[charName] = charTab;
	debug.Print("| "..charName.." was created")
	
	pushcmd(function() func.CharacterExpendEnergy(charName) end, 2.2)
--[[if t == "ai" or t == "player_local" then service(t, char)
	else	
-- ����� ����� ��� ���� ����������, ��������, ���������� � ������� ��������� � ���������, ������ �������� (��������, �������). Slava98. 06.06.13.
	end -- ���� ����� � ��� �� �����, ��������, ������ ��� ��������� (���� � ������� ��� ���� ����� ����, �� � ��������, �� �����).]]
	return charTab;
end

function func.CharacterSetWeap(charName, weapType, withEquip)
-- ���������� ������ (��������).

-- ���������� ��������� ����������.
	local charTab = main.characters[charName];
	local weapons = charTab.inventory.weapons;
	local weapIsAlreadyInInventory;
	local withEquip;
	if withEquip == nil then withEquip = true; end;
	
-- ���� ����� ������ ��� ���� � ��� ���� �����������, �� ����� ���� ��� �������������? Slava98. 30.12.13.
	if charTab.currentWeap == weapType then return; end; --error("bad argument #2 to 'func.CharacterEquipWeap' ('"..weapType.."' is already equipped on '"..charName.."')", 2) return; end;
	
-- ������� ������� ������ ������� ������ � �������� ��� � ���������. Slava98. 30.12.13.
	for i = 1, #weapons do
		if weapons[i].weapType == weapType then weapIsAlreadyInInventory = true; weapons[i].equipped = true; end;
		if weapons[i].equipped and weapons[i].weapType == charTab.currentWeap then weapons[i].equipped = false; end;
	end;

-- ���� ������ ��� �� ���������� � ����, �� ���������� �������, ������� ������ ��� �������� (� ������ - ������, � NPC - ��������). Slava98. 31.12.13.
	if #weapons >= charTab.allowedWeapsNum and not weapIsAlreadyInInventory then 
		if charTab.charType == "npc" then --func.NPC.ChoseWeapon(charName, weapType); return; -- �������� � ��������� � ������/NPC - ����������. ��� ������� ��� �� ��� �����������. Slava98. 30.12.13.
		elseif charTab.charType == "player" then func.player.ChoseWeap(weapType); return;
		end;
	end;
	
	func.KillIfExists(charName.."_weap")
	
-- ��������� ����� �� ����, ���� �� ����, ����. Slava98. 31.12.13.
	if charTab.charType == "npc" or "player" and withEquip then
		charTab.inventory.isSetWeap = true;
		func.EquipWeap(weapType, charName.."_weap", object(charName).vehname)
	else
		error("bad argument #1 to 'func.CharacterEquipWeap' (in WS only 'npc' and 'player' character types are allowed)", 2)
	end;
	
-- ������ ���������� � ��������� � ������������� ����� ������. Slava98. 30.12.13.
	charTab.currentWeap = weapType;
	if weapIsAlreadyInInventory then return; end; -- ������ ���� ��� ��� �� �������� � �� �����������. Slava98. 30.12.13.
	table.insert(charTab.inventory.weapons, {weapType=weapType, equipped=true})
end

function func.CharacterRestoreEnergy(charName, energyNum, frequency, maxAmount)
-- ���������� ������ (��������).	
	
	local energyNum = energyNum or 35;
	local frequency = frequency or 10;
	local maxAmount = maxAmount or 60;
	local charTab = main.characters[charName];
	local energy = charTab.energy;
	local maxEnergy = charTab.maxEnergy;
	local function Loop(amount)
		local amount = amount or 0;
		charTab.inventory.isActivated["battery"] = true;
		amount = amount + 1;
		message(amount.." "..energy)
		if amount >= maxAmount then
			if charName == const.playerName then func.Message({"main", "msg_notices", 36}) end;
			charTab.inventory.isActivated["battery"] = false;
			return;
		end;
		if energy >= maxEnergy then 
			energy = maxEnergy;
			if charName == const.playerName then func.Message({"main", "msg_notices", 39}) end;
			charTab.inventory.isActivated["battery"] = false;
			return;
		end;
		energy = energy + energyNum;
		charTab.energy = energy;
		pushcmd(function() Loop(amount) end, 1/frequency)
	end;
	
	if charName == const.playerName then func.Message({"main", "msg_notices", 35}) end;
	Loop()
end

function func.CharacterExpendEnergy(charName, energyNum, loop)
-- ���������� ������ (��������).
	
	if not func.ExistsCharacter(charName) or not exists(charName) or not exists(object(charName).vehname) then return; end;

	local charTab = main.characters[charName];
	local energyConsumption = charTab.energyConsumptionMainSystems;
	if loop == nil then loop = true; end;
	if not loop then char.energy = charTab.energy - energyNum; end;

	if charTab.energy  < 1 then func.Destroy(object(charName).vehname); end;
	if charTab.inventory.isActivated["healthpack"] or charTab.inventory.isActivated["superhealthpack"] or charTab.inventory.isActivated["boo"] then energyConsumption = energyConsumption + 1; end;
	if charTab.devices.isActivated['minedetector'] or charTab.devices.isActivated['batterydetector'] then energyConsumption = energyConsumption + 1; end;
	if charTab.devices.isActivated['arc'] and object(object(charName).vehname).health < func.GiveClassHealth(charName) then energyConsumption = energyConsumption + 1; damage(-3, object(charName).vehname) end;

	charTab.energy = charTab.energy - energyConsumption;
	charTab.energyConsumption = energyConsumption;
	if loop then pushcmd(function() func.CharacterExpendEnergy(charName, energyNum, loop) end, 1) end;
end

function func.ExistsCharacter(character)
	local charNum = 0;
	local charTab = {};
	for k, v in pairs(main.characters) do charNum = charNum + 1; charTab[charNum] = k; end;
	return func.Search(charTab, character);
end

function func.KillIfExistsCharacter(name)
	local copy = main.characters[name];
	main.characters[name] = nil;
	return copy;
end

---------------------------------------------------------------------------------------------------------------------
------------------------------------------------------ ���� ---------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------- 

function func.SpawnTank(name, brainType, properties, x, y, team, spawnTeam, dir, weap)
-- ���������� ������.
	if type(name) ~= "string" then error("bad argument #1 to 'func.SpawnTank' (string expected, got "..type(name)..")", 2) end
	if brainType ~= "ai" and brainType ~= "player_local" then error("bad argument #2 to 'func.SpawnTank' ('ai' or 'player_local' expected)", 2) end
	if type(properties) ~= "table" then error("bad argument #3 to 'func.SpawnTank' (table expected, got "..type(properties)..")", 2) end
	if type(x) ~= "number" then error("bad argument #4 to 'func.SpawnTank' (number expected, got "..type(x)..")", 2) end
	if type(y) ~= "number" then error("bad argument #5 to 'func.SpawnTank' (number expected, got "..type(y)..")", 2) end
	if type(team) ~= "number" then error("bad argument #6 to 'func.SpawnTank' (number expected, got "..type(team)..")", 2) end
	if type(spawnTeam) ~= "number" then error("bad argument #7 to 'func.SpawnTank' (number expected, got "..type(spawnTeam)..")", 2) end
	if type(dir) ~= "number" then error("bad argument #8 to 'func.SpawnTank' (number expected, got "..type(dir)..")", 2) end	
	local weapIsExisting;
	for i = 1, table.maxn(const.weapons) do if weap == const.weapons[i] then weapIsExisting = true; end; end
	if not weapIsExisting and weap ~= nil and weap ~= "none" then error("bad argument #9 to 'func.SpawnTank' (kind of weapons expected)", 2) end
	
-- ������������� ��������� ����������.
	if type(properties.class) == "table" then temp.class_name = name.."_class"; classes[temp.class_name] = tcopy(properties.class); end
	properties.on_damage = properties.on_damage or "";
	local dir = dir or 0;
	local spawnTeam = spawnTeam or 1;
	local team = team or 1;
	local properties = {
		name = name,
		vehname = name.."_tank",
		class = properties.class or temp.class_name,
		skin = properties.skin or "ekivatorl",
		team = spawnTeam,
		nick = properties.nick or "",
--		on_damage = "func.OnDamage(who, self); "..properties.on_damage,
		on_die = "level.OnDie('"..name.."'); func.inventory.DropAllItems('"..name.."'); func.KillIfExistsCharacter('"..name.."'); func.KillIfExists('"..name.."_weap'); func.KillIfExists('"..name.."')",
		active = 0,
	};
	
	service(brainType, properties)
	if x ~= nil and y ~= nil then actor("respawn_point", x, y, {name=name.."_spawn", dir=dir, team=spawnTeam}) end

-- ������� � ��������� �� �������.	
	pushcmd(function() -- ��������� �� ���� ��� ������.
		if weap ~= "none" and weap ~= nil then
			actor(weap, 0, 0, {name=name.."_weap"})
			equip(object(name).vehname, name.."_weap")
			-- main.characters.weapons = {}
		end;
		object(name).team = team; -- ������ �������.
--		if exists(properties.vehname) then object(properties.vehname).on_damage = "func.tank.OnDamage(who, '"..properties.vehname.."')"; end;
		if exists(name.."_spawn") then kill(name.."_spawn") end; -- ������� �����.
	end, 2.1)
	
	return properties;
end

-- ������ ���� ���������� �� �����. Slava98.
function func.tank.GodMode(tankName, value, timer)
-- ���������� ������.
	if type(tankName) ~= "string" then error("bad argument #1 to 'func.tank.GodMode' (string expected, got "..type(tankName)..")", 2) return; end;
	if type(value) ~= "boolean" and value ~= nil then error("bad argument #2 to 'func.tank.GodMode' (boolean expected, got "..type(value)..")", 2) return; end;
	if type(timer) ~= "number" and timer ~= nil then error("bad argument #3 to 'func.tank.GodMode' (number expected, got "..type(number)..")", 2) return; end;
	if not exists(tankName) then error("bad argument #1 to 'func.tank.GodMode' (object with name '"..tankName.."' does not exist)", 2) return; end;
	if objtype(tankName) ~= "tank" then error("bad argument #1 to 'func.tank.GodMode' (incompatible object type)", 2) return; end;
	
	local class = classes[object(object(tankName).playername).class];
	local maxHealth = object(tankName).max_health;
	local health = object(tankName).health;
	
	if value then
		class.defaultHealth = class.health;
		class.tankHealth = object(tankName).health;
		class.tankMaxHealth = object(tankName).max_health;
		classes[object(object(tankName).playername).class].health = 0;
		object(tankName).max_health = 0;
		object(tankName).health = 0;
		if timer == nil then return; end;
		pushcmd(function() 
			classes[object(object(tankName).playername).class].health=defaultHealth; 
			object(tankName).max_health=maxHealth; 
			object(tankName).health=health 
		end, timer)
	else
		classes[object(object(tankName).playername).class].health = class.defaultHealth;
		object(tankName).max_health = class.tankMaxHealth;
		object(tankName).health = class.tankHealth;
	end;
end


-- ������ ����� � �����. �������� ������ �������� ������ ������ ��� ������ ������. ���������� �������� ��� ������ ������. ��������. Slava98. 
-- ��������� ����� ������� ��� ����� ������� tank.
function func.ChangeClass(tankName, class)
-- ���������� ������.
	if type(tankName) ~= "string" then error("bad argument #1 to 'func.ChangeClass' (string expected, got "..type(tankName)..")", 2) return; end;
	if type(class) ~= "string" and type(class) ~= "table" then error("bad argument #2 to 'func.ChangeClass' (string or table expected, got "..type(class)..")", 2) return; end;

	if type(class) == "table" then local class_name = name.."_class"; classes[class_name] = tcopy(class) end;
	
	pset(tankName, "class", name.."_class")
	return class;
end

-- ���������� ���� �� �����. Slava98. *� �������� �� NPC. ��� �� ����? Slava98. 11.01.14. *��������. Slava98. 17.02.14.
function func.DropBot(serviceName)
	if exists(serviceName) and exists(object(serviceName).vehname) then
		object(object(serviceName).vehname).playername = "";
		object(serviceName).vehname = "";
		pushcmd(function() kill(serviceName) end, 0.1)
	end;
end


---------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- NPC -------------------------------------------------------------	
---------------------------------------------------------------------------------------------------------------------

-- ������ NPC. Slava98.
function func.NPC.Create(npcName, x, y, dir, team, spawnTeam, tankTab, charTab, npcTab)
-- ���������� ������.
	if type(npcName) ~= "string" then error("bad argument #1 to 'func.NPC.Create' (string expected, got "..type(npcName)..")", 2) end
	if type(x) ~= "number" then error("bad argument #2 to 'func.NPC.Create' (number expected, got "..type(x)..")", 2) end
	if type(y) ~= "number" then error("bad argument #3 to 'func.NPC.Create' (number expected, got "..type(y)..")", 2) end
	if type(dir) ~= "number" and spawnTeam ~= nil then error("bad argument #4 to 'func.NPC.Create' (number expected, got "..type(dir)..")", 2) end
	if type(team) ~= "number" and team ~= nil then error("bad argument #5 to 'func.NPC.Create' (number expected, got "..type(team)..")", 2) end
	if type(spawnTeam) ~= "number" and spawnTeam ~= nil then error("bad argument #6 to 'func.NPC.Create' (number expected, got "..type(spawnTeam)..")", 2) end
	if type(tankTab) ~= "table" and tankTab ~= nil then error("bad argument #7 to 'func.NPC.Create' (table expected, got "..type(tankTab)..")", 2) end
	if type(charTab) ~= "table" and charTab ~= nil then error("bad argument #8 to 'func.NPC.Create' (table expected, got "..type(charTab)..")", 2) end
	if type(npcTab) ~= "table" and npcTab ~= nil then error("bad argument #9 to 'func.NPC.Create' (table expected, got "..type(npcTab)..")", 2) end

-- ���������� ��������� ����������.
	local tankTab = tankTab or {};
	local charTab = func.UniteTables(charTab, {
		charType = "npc",
	});

	local npcTab = func.UniteTables({ -- ��������� NPC.
		healthToHeal = 200, -- ���������� �������� ��� �������������.
		useBattery = true, -- ������������ �� ���������. ������ ����� �� �����.
		followingObject = "", -- ������, �������������� NPC.
		-- ����.
		currentWay, -- ����, �� �������� NPC ������� � ������ ������.
		mainWay, -- ����, �� �������� NPC ����� ��������� � ���������� ����������� (��������, ����� �����).
		------ ����������� (������������ �������������).
		wayFinishPointNum; -- ����� ��������� ����� ���� (���� ��� ��������� ����� �� �� ����� ����, ��������).
		-- �����.
		attackMode = "chase", -- ������� �����.
		enemyDetectMode = true, -- ������� �� ����� ����������� ������.
		revengeToAttacker = true, -- �������� �� ����.
		pursueEnemy = true, -- ���������� �� ��������� ����, ���� ��� ������� �� ����������� ������.
		onComming = "", -- ����������� ��� ����������� � ����� (���� attackMode = 'goto_aim').
		onAttack = "", -- ����������� ��� �����.
		detectRadius = 7, -- ����������, �� ������� NPC ����� �������� �����. ���� �� ������������.
		detectRadiusDelta = 6, -- ����������, �� ������� NPC ������ ����� �� ���� ������. ���� �� ������������.
		commingRadius = 2, -- ���������� �� �����, �� ������� ����������� onComming (���� attackMode = 'goto_aim').
		callAllies = true, -- ����� �� NPC ����� ��������� ��� �����.
		callAlliesMaxDistance = 10, -- ����������, �� ������� NPC ����� ������� � ����� ���������.
		canBeCalledByAllies = true, -- ����� �� �������� ����� NPC.
		canAttackBlindfold = true, -- ����� �� NPC ��������� �������, ���� � ���� ��������.
		------ ����������� (������������ �������������).
		visibleEnemies = {}, -- ������ ���������� ������.
		currentTarget, -- ����, �������� NPC ������� � ������ ������.
		seeTarget, -- ����� �� NPC �����.
	}, npcTab);
	
	npcTab.attackSpeaks = func.UniteTables({ -- ������� ���������� ��� �����.
		onBegin, -- ��� ������ �����.
		onLoop, -- �� ����� �����.
		onStopDestroyed, -- ��� ����������� �����.
		onStopLost, -- ��� ������ ����� �� ����.
		file = main.levelpack.map, -- � ����� ����� ��� ���������.
		probability = 1, -- ����������� �������.
		loopInterval = 5, -- �������� �������� �� ����� �����.
	}, func.DoTable(npcTab.attackSpeaks))
	
	npcTab.attackBehavior = func.DoTable(npcTab.attackBehavior);
	
	npcTab.attackBehavior.attackFirst = func.UniteTables({ -- ������ ����� ������ ��������� NPC �������;
		withBiggestGun = 2.5, -- ������� ������� ����� � ����� ������ ������;
		withPoorestGun = 0.25, -- ������� ������� ����� � ����� ������ ������;
		withAverageGun = 1, -- ������� ������� ����� �� ������� ������.
		heavyArmored = 1, -- � ���������� ����������� �� (������������ ���������);
		lowArmored = 0.5, -- � ���������� ����������� �� (������������ ���������);
		mediumArmored = 0.75, -- �� ������� ����������� �� (������������ ���������);
		withHighestRank = 2, -- � ������� ������� (�������, ��������� � �.�.);
		withLowestRank = 0.5, -- � ������ ������� (����������, ���������, ���������);
		withAverageRank = 1, -- �� ������� ������� (�������, ����� � �.�.);
		withBoo = 1.5, -- � ����������;
		onShortestDistance = 2, -- ������� ������� ����� �� ������� ���������;
		onFarestDistance = 0.75, -- ������� ������� ����� �� ������� ���������;
		onAverageDistance = 1.5, -- ������� ������� ����� �� ������� ���������;
	}, func.DoTable(npcTab.attackBehavior.attackFirst)) -- ������������ ����������� - 5, ����� ��������� ��������, ���������� ������� ����� ������������;
	
	npcTab.attackBehavior.attackFirst.vehTypes = func.UniteTables({ -- ������ ����� �� ���� ������ ������ ��������� NPC �������;
		tank = 0, -- ������� ������� �����;
		excavator = 4, -- ������� ������� �����������;
		mine = 4, -- ������� ������� ����-����� (���� ����� � �� �������������, ��� ��� ���������� �� �� ��� �� ������);
		reamer = 4, -- ������� ������� �����-����������� ������������;
		fighter = 3, -- ������� ������� �����������;
	}, func.DoTable(npcTab.attackBehavior.attackFirst.vehTypes))
	
	npcTab.attackBehavior.attackFirst.charTypes = func.UniteTables({ -- ������ ����� �� ���� ��������� ������ ��������� NPC �������;
		npc = 0, -- ������� ������� NPC;
		player = 0, -- ������� ������� ������;
	}, func.DoTable(npcTab.attackBehavior.attackFirst.vehTypes))
	
	npcTab.attackBehavior.useBooProbability = func.UniteTables({ -- ����������� ������������� ���������;
		withBiggestGun = 1, -- ����������� ������������� ��������� ��� ���� ����� � ����� ������ ������;
		withPoorestGun = 0.25, -- ����������� ������������� ��������� ��� ���� ����� � ����� ������ ������;
		withAverageGun = 0.5, -- ����������� ������������� ��������� ��� ���� ����� �� ������� ������.
		heavyArmored = 2.5, -- � ���������� ����������� �� (������������ ���������);
		lowArmored = 0.25, -- � ���������� ����������� �� (������������ ���������);
		mediumArmored = 0.75, -- �� ������� ����������� �� (������������ ���������);
		withHighestRank = 2, -- � ������� ������� (�������, ��������� � �.�.);
		withLowestRank = 0.25, -- � ������ ������� (����������, ���������, ���������);
		withAverageRank = 0.75, -- �� ������� ������� (�������, ����� � �.�.);
		withBoo = 4, -- � ����������;
		onShortestDistance = 2, -- ����������� ������������� ��������� ��� ���� ����� �� ������� ���������;
		onFarestDistance = 0.75, -- ����������� ������������� ��������� ��� ���� ����� �� ������� ���������;
		onAverageDistance = 1.5, -- ����������� ������������� ��������� ��� ���� ����� �� ������� ���������;
	}, func.DoTable(npcTab.attackBehavior.useBattery)) -- ������������ ����������� - 4, ����� ��������� ��������, ���������� ������� ����� ������������;
	
	npcTab.attackBehavior.useBooProbability.vehTypes = func.UniteTables({ -- ��� ���� ������ ����� �� ���� ������ NPC ������������ ���������;
		tank = 0, -- ����������� ������������� ��������� ��� ���� ������;
		excavator = 4, -- ����������� ������������� ��������� ��� ���� ������������;
		mine = 0, -- ����������� ������������� ��������� ��� ���� ���-������ (���� ����� � �� �������������, ��� ��� ���������� �� �� ��� �� ������);
		reamer = 4, -- ����������� ������������� ��������� ��� ���� ������-������������ ������������;
		fighter = 4, -- ����������� ������������� ��������� ��� ���� ������������;
	}, func.DoTable(npcTab.attackBehavior.attackFirst.vehTypes))
	
	npcTab.attackBehavior.useBooProbability.charTypes = func.UniteTables({ -- ��� ���� ������ ����� �� ���� ��������� NPC ������������ ���������;
		npc = 0, -- ����������� ������������� ��������� ��� ���� NPC;
		player = 1; -- ����������� ������������� ��������� ��� ���� ������;
	}, func.DoTable(npcTab.attackBehavior.attackFirst.vehTypes))
	
	npcTab.attackBehavior.distance = func.UniteTables({ -- ���������, ������� �������������� NPC (����� ������������� ������� ��������������);
		withBiggestGun = 5, -- ��� ����� ����� � ����� ������ ������;
		withPoorestGun = 2, -- ��� ����� ����� � ����� ������ ������;
		withAverageGun = 4, -- ��� ����� ����� �� ������� ������.
		heavyArmored = 4, -- � ���������� ����������� �� (������������ ���������);
		lowArmored = 2, -- � ���������� ����������� �� (������������ ���������);
		mediumArmored = 3, -- �� ������� ����������� �� (������������ ���������);
		withHighestRank = 4, -- � ������� ������� (�������, ��������� � �.�.);
		withLowestRank = 2, -- � ������ ������� (����������, ���������, ���������);
		withAverageRank = 3, -- �� ������� ������� (�������, ����� � �.�.);
		withBoo = 5, -- � ����������;
	}, func.DoTable(npcTab.attackBehavior.distance))

	npcTab.attackBehavior.useBooProbability.vehTypes = func.UniteTables({ -- ��� ���� ������ ����� �� ���� ������ NPC ������������ ���������;
		tank = 0, -- ��� ����� ������;
		excavator = 16, -- ��� ����� ������������;
		mine = 16, -- ��� ����� ����-������ (���� ����� � �� �������������, ��� ��� ���������� �� �� ��� �� ������);
		reamer = 16, -- ��� ����� ������-������������ ������������;
		fighter = 6, -- ��� ����� ������������;	
	}, func.DoTable(npcTab.attackBehavior.attackFirst.vehTypes))

	npcTab.attackBehavior.useBooProbability.charTypes = func.UniteTables({ -- ��� ���� ������ ����� �� ���� ��������� NPC ������������ ���������;
		npc = 0, -- ��� ����� NPC;
		player = 4, -- ��� ����� ������;
	}, func.DoTable(npcTab.attackBehavior.attackFirst.vehTypes))
	
	local team = team or 1;
	local spawnteam = spawnteam or team;
	
	charTab = func.CreateCharacter(npcName, charTab); -- ������ ����� �������� ��� NPC.
	debug.Print("| "..charTab.currentWeap.." was equiped on "..npcName)
	func.SpawnTank(npcName, "ai", tankTab, x, y, team, spawnTeam, dir, charTab.currentWeap) -- ������ ���� ��� ���������.
	
	local tankName = object(npcName).vehname;
	main.NPC.list[npcName] = npcTab; -- ������� ������ NPC � ������ ���� NPC.
	
-- ����� ������� � ���������.
	pushcmd(function()
		if exists(tankName) then 
			local tankName = object(npcName).vehname;
			local healFunc = "if exists('"..npcName.."') and main.NPC.list."..npcName..".healthToHeal~=nil and object('"..tankName.."').health < main.NPC.list."..npcName..".healthToHeal then local inventory = main.characters['"..npcName.."'].inventory; if not inventory.isActivated['healthpack'] and not inventory.isActivated['superhealthpack'] then if not inventory.isActivated['healthpack'] then func.UseItem('superhealthpack', '"..npcName.."') end; if not inventory.isActivated['superhealthpack'] then func.UseItem('healthpack', '"..npcName.."') end; end; end; ";
			local useBatteryFunc = "if exists('"..npcName.."') and who~=nil and object(who.playername).team~=object('"..npcName.."').team and main.NPC.list."..npcName..".useBattery then func.UseItem('boo', '"..npcName.."') end; ";
			local attackFunc = "if who~=nil and exists(who.playername) and exists('"..npcName.."') and object(who.playername).team~=object('"..npcName.."').team and main.NPC.list['"..npcName.."'].revengeToAttacker then func.NPC.Attack('attack', '"..npcName.."', who, 0.2); end;";
			object(tankName).on_damage = healFunc..useBatteryFunc..attackFunc..object(tankName).on_damage;
			debug.Print("| "..tankName.." was spawned")
			
			func.object.borderTrigger.Create(tankName.."_enemydetect_leave", tankName, {on_enter="if who~=nil and exists('"..npcName.."') and exists(who.playername) and object(who.playername).team~=object('"..npcName.."').team and main.NPC.list['"..npcName.."'].pursueEnemy and main.NPC.list['"..npcName.."'].enemyDetectMode then npcTab = main.NPC.list['"..npcName.."']; if npcTab.canAttackBlindfold and not npcTab.seeTarget then return; end; func.NPC.Attack('attack', '"..npcName.."', who, 0.2); npcTab.seeTarget = false; end;"; only_human=0, radius=npcTab.detectRadius}, {dir=6, length=1})
			func.object.borderTrigger.Create(tankName.."_enemydetect", tankName, {on_enter="if who~=nil and exists('"..npcName.."') and exists(who.playername) and object(who.playername).team~=object('"..npcName.."').team then func.NPC.Attack('stop', '"..npcName.."', who); main.NPC.list['"..npcName.."'].seeTarget = true; end;"; only_human=0, radius=npcTab.detectRadiusDelta}, {dir=6, length=1})
		end;
	end, 2.2)
end

-- ��������� ������ ���� ��� NPC. ��������� ������������ �������. Slava98. 03.01.14.
function func.NPC.SetAim(npcName, x, y, g32, trigTab, killAfterEnter, killAfterLeave)
-- ���������� ������ (��������).

	if not exists(npcName) then error("bad argument #1 to 'func.NPC.SetAim' (NPC '"..npc.."' does not exist)", 2) end;

-- ���������� ��������� ����������.
	if killAfterEnter == nil then killAfterEnter = true; end;
	if killAfterLeave == nil then killAfterLeave = true; end;
	local function Kill(condition)
		if condition then return "kill('"..npcName.."_aimtrig'); "; else return ""; end
	end;
	trigTab.name = npcName.."_aimtrig";
		if type(trigTab.on_enter) == "string" then trigTab.on_enter = "if who == nil or who.name ~= '"..object(npcName).vehname.."' then return; end; "..Kill(killAfterEnter)..trigTab.on_enter; end;
		if type(trigTab.on_leave) == "string" then trigTab.on_leave = "if who == nil or who.name ~= '"..object(npcName).vehname.."' then return; end; "..Kill(killAfterLeave)..trigTab.on_leave; end;
	
	if g32 then x, y = func.Get32(x, y); end;
	func.KillIfExists(npcName.."_aimtrig")
	ai_march(npcName, x, y)
	actor("trigger", x, y, trigTab)
	debug.Print("| "..npcName.."'s aim is ("..func.UnGet32(x)..", "..func.UnGet32(y)..")")
end

function func.NPC.FollowWay(npcName, wayName, finishPointNum, onEnterFunc, onFinalFunc, wayPointNum, refresh)
--	���������� ������ (��������).

	if not wayName and (not main.NPC.list[npcName].mainWay or main.NPC.list[npcName].mainWay == "") then return; end;
	if refresh == nil then refresh = true; end;
	local wayName = wayName or main.NPC.list[npcName].currentWay or main.NPC.list[npcName].mainWay;
	local wayPointNum = wayPointNum or 1;
	local vehObj = object(object(npcName).vehname);
--	local finishPoint = finishPoint or wayName.."_waytrig"..level.ways[wayName].points; 
--	local x, y = position(wayName.."_waytrig"..wayPointNum);
	
	print(wayName)
	if refresh then func.way.Refresh(wayName); end;
	
	table.insert(level.ways[wayName].allowedNPCs, npcName)
	main.NPC.list[npcName].currentWay = wayName;
	main.NPC.list[npcName].wayFinishPointNum = finishPointNum or level.ways[wayName].points;
	
	if level.ways[wayName].shortcut then wayPointNum = func.way.Shortcut(wayName, vehObj, true); end;
	
	func.way.GotoNextTrig(wayName, vehObj, true, wayPointNum)
end

function func.NPC.StopWay(npcName)
	local wayName = main.NPC.list[npcName].currentWay;
	for i = 1, #level.ways[wayName].allowedNPCs do
		if level.ways[wayName].allowedNPCs[i] == npcName then table.remove(level.ways[wayName].allowedNPCs, func.Search(level.ways[wayName].allowedNPCs, npcName)) end;
	end;
end

function func.NPC.ClearWay(npcName)
	main.NPC.list[npcName].currentWay = nil;
end

function func.NPC.FollowObject(npcName, objName, trigTab, frequency, dir, length, correctAimPosition)
-- ���������� ������ (��������).

	local frequency = frequency or 1;
	local x, y;
	local dir = dir or 5;
	local multitriggerMode;
	local function CorrectTrigPosition(dir) -- ��� ������� ��������� �������� ��������� ������ ������ �����. Slava98. 02.01.14.
		if     dir == "right"  or dir == 1 then x = x + length;
		elseif dir == "bottom" or dir == 2 then y = y + length;
		elseif dir == "left"   or dir == 3 then x = x - length;
		elseif dir == "up"     or dir == 4 then y = y - length;
		elseif dir == "center" or dir == 5 then
		elseif dir == "everywhere" or dir == 6 then	multitriggerMode = true; end;
	end;
	local function Loop()
		if main.NPC.list[npcName].followingObject ~= objName or not exists(objName) or not exists(npcName) then return; end;
		
		x, y = position(objName);
		if correctAimPosition then CorrectTrigPosition(dir) end;
		ai_march(npcName, x, y)
		if not correctAimPosition then CorrectTrigPosition(dir) end;
		if multitriggerMode then
			for i = 1, 4 do x, y = position(objName); CorrectTrigPosition(i); setposition(npcName.."_aimtrig"..i, x, y) end;
		else
			setposition(npcName.."_aimtrig", x, y)
		end;
		pushcmd(Loop, frequency)
	end
	
	if type(trigTab.on_enter) == "string" then trigTab.on_enter = "if who == nil or who.name ~= '"..object(npcName).vehname.."' then return; end; "..trigTab.on_enter; end;
	if type(trigTab.on_leave) == "string" then trigTab.on_leave = "if who == nil or who.name ~= '"..object(npcName).vehname.."' then return; end; "..trigTab.on_leave; end;

	x, y = position(objName);
	CorrectTrigPosition(dir)
	if multitriggerMode then
		for i = 1, 4 do
			CorrectTrigPosition(i)
			trigTab.name = npcName.."_aimtrig"..i;
			func.KillIfExists(trigTab.name)
			actor("trigger", x, y, trigTab)
		end;
	else
		trigTab.name = npcName.."_aimtrig";
		func.KillIfExists(trigTab.name)
		actor("trigger", x, y, trigTab)
	end
	main.NPC.list[npcName].followingObject = objName;
	Loop()
end

-- ��������� ������� ����������� ���������. Slava98. 
function func.NPC.DamageOurWarrior(who, npc) -- ���� ����� ����������. Slava98. 29.03.13.
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

function func.NPC.FollowPosition(npcName, x, y, distance, distanceDir, frequency)
-- ���������� ������ (��������).	

-- ���������� ��������� ����������.
	local frequency = frequency or 10;
end

function func.NPC.EvaluateTarget(npcName, targetNum, atribute)
	local npcTab = main.NPC.list[npcName];
	local count = 0;
	local formatedEnemies = {weapValue = {}, healthValue = {}, rankValue = {}, distanceValue = {}};
	local npcTab = main.NPC.list[npcName];

	-- ��� ������ ����� ����� ������ � ����������� � ����������� ������������ ����������������.
	for targetNum, targetName in pairs(npcTab.visibleEnemies) do
		formatedEnemies.weapValue[targetNum] = func.EvaluateWeap(main.characters[targetName].currentWeap);
		formatedEnemies.healthValue[targetNum] = object(object(targetName).vehname).health;
		formatedEnemies.rankValue[targetNum] = main.characters[targetName].rank;
		local x1, y1 = position(object(npcName).vehname);
		local x2, y2 = position(object(targetName).vehname);
		formatedEnemies.distanceValue[targetNum] = func.GetDistance(x1, y1, x2, y2);
	end;
	-- ������ ����� ������ ��� ����������. ����� �� �������� ���������������� ����� ��������� ������� ����������.
	local maxWeap = formatedEnemies.weapValue[func.ArrayMax(formatedEnemies.weapValue)];
	local minWeap = formatedEnemies.weapValue[func.ArrayMin(formatedEnemies.weapValue)];
	local maxHealth = formatedEnemies.healthValue[func.ArrayMax(formatedEnemies.healthValue)];
	local minHealth = formatedEnemies.healthValue[func.ArrayMin(formatedEnemies.healthValue)];
	local maxRank = formatedEnemies.rankValue[func.ArrayMax(formatedEnemies.rankValue)];
	local minRank = formatedEnemies.rankValue[func.ArrayMin(formatedEnemies.rankValue)];
	local maxDistance = formatedEnemies.distanceValue[func.ArrayMax(formatedEnemies.distanceValue)];
	local minDistance = formatedEnemies.distanceValue[func.ArrayMin(formatedEnemies.distanceValue)];
	local targetName = npcTab.visibleEnemies[targetNum];
	-- ���������� ������ �����.
		if formatedEnemies.weapValue[targetNum] == maxWeap and formatedEnemies.weapValue[targetNum] > 1 then 
		 count = count + npcTab.attackBehavior[atribute].withBiggestGun; debug.Print("| "..targetName.." has biggest gun", "attack");
	elseif formatedEnemies.weapValue[targetNum] == minWeap then 
		 count = count + npcTab.attackBehavior[atribute].withPoorestGun; debug.Print("| "..targetName.." has poorest gun", "attack");
	else count = count + npcTab.attackBehavior[atribute].withAverageGun; debug.Print("| "..targetName.." has average gun", "attack");
	end;
	-- ����� ���������, ��� �� � ������ ����� ���� ����� �������������, ��� ��� �������� �� �� �����.
		if math.floor(formatedEnemies.healthValue[targetNum]/100) == math.floor(maxHealth/100) then 
		 count = count + npcTab.attackBehavior[atribute].heavyArmored; debug.Print("| "..targetName.." is heavy armored", "attack");
	elseif math.floor(formatedEnemies.healthValue[targetNum]/100) == math.floor(minHealth/100) then 
		 count = count + npcTab.attackBehavior[atribute].lowArmored; debug.Print("| "..targetName.." is low armored", "attack");
	else count = count + npcTab.attackBehavior[atribute].mediumArmored; debug.Print("| "..targetName.." is medium armored", "attack");
	end;
		if formatedEnemies.rankValue[targetNum] == maxRank and formatedEnemies.rankValue[targetNum] > 2 then 
		 count = count + npcTab.attackBehavior[atribute].withHighestRank; debug.Print("| "..targetName.." has highest rank", "attack");
	elseif formatedEnemies.rankValue[targetNum] == minRank then 
		 count = count + npcTab.attackBehavior[atribute].withLowestRank; debug.Print("| "..targetName.." has lowest rank", "attack");
	else count = count + npcTab.attackBehavior[atribute].withAverageRank; debug.Print("| "..targetName.." has average rank", "attack");
	end;
		if math.floor(formatedEnemies.distanceValue[targetNum]/32) == math.floor(maxDistance/32) then 
		 count = count + npcTab.attackBehavior[atribute].onFarestDistance; debug.Print("| "..targetName.." is on a farest distance", "attack");
	elseif math.floor(formatedEnemies.distanceValue[targetNum]/32) == math.floor(minDistance/32) then 
		 count = count + npcTab.attackBehavior[atribute].onShortestDistance; debug.Print("| "..targetName.." is on a shortest distance", "attack");
	else count = count + npcTab.attackBehavior[atribute].onAverageDistance; debug.Print("| "..targetName.." is on a average distance", "attack");
	end;
	-- ������ ����� ������� ����� �������� � �������� ����� ��������� ����� �����.
	for vehType, extraCount in pairs(npcTab.attackBehavior[atribute].vehTypes) do
		if main.characters[targetName].vehType == vehType then
			count = count + extraCount; debug.Print("| "..targetName.." has '"..vehType.."' vehchle type", "attack");
		end;
	end;
	-- ������ ��������� ����� �� ����� ���������.
	for charType, extraCount in pairs(npcTab.attackBehavior[atribute].charTypes) do
		if main.characters[targetName].charType == charType then
			count = count + extraCount; debug.Print("| "..targetName.." is character of '"..charType.."' type", "attack");
		end;
	end;
	-- ���� � ����� ������������ ���������.
	if main.characters[targetName].inventory.isActivatingBoo then 
		count = count + npcTab.attackBehavior[atribute].withBoo; debug.Print("| "..targetName.." is using boo", "attack");
	end;
	return count;
end;

function func.NPC.ChooseTarget(npcName)
	local npcTab = main.NPC.list[npcName];

	if #npcTab.visibleEnemies <= 1 then return; end;
	local countTab = {};
	local chosenTargetNum;
	for targetNum = 1, #npcTab.visibleEnemies do
		countTab[targetNum] = func.NPC.EvaluateTarget(npcName, targetNum, "attackFirst");
	end;
	if math.random(1, 5) < countTab[func.ArrayMax(countTab)] then chosenTargetNum = func.ArrayMax(countTab);
	else if math.random() > 0.7 then chosenTargetNum = #countTab else chosenTargetNum = 1; end;
	end;
	
	return chosenTargetNum;
end

function func.NPC.Attack(f, npcName, who, frequency, n, targetIsDestroyed--[[, speaks={onBeginAttack={"", ""...}, onLoopAttack={}, onStopAttack={}, }]]) -- ����� ������� ��������� �������: 1)������������ ����������; 2)�� �������� ����;
-- ���������� ������ (��������).

-- ���������� ��������� ����������.
	local frequency = frequency or 0.2;
	local targetTank;-- = who.name;
	local target;
	local npcTab = main.NPC.list[npcName];
	local attackMode = npcTab.attackMode;
	local onComming = npcTab.onComming;
	if f ~= "stop" then targetTank = who.name; end;
	if not targetIsDestroyed then target = who.playername; else target = who; end;
	if not exists(npcName) then return; end;
	
	if f == "attack" then
		if func.Search(npcTab.visibleEnemies, target) then return; end;
		
		debug.Print("| "..npcName.." is seeing "..target, "attack")
		if math.random() <= npcTab.attackSpeaks.probability and npcTab.attackSpeaks.onBegin then func.object.Speak(object(npcName).vehname, func.Read({npcTab.attackSpeaks.file, npcTab.attackSpeaks.onBegin, "random"}), nil --[[����� ������ ���� ������� ��������]]) end;
		
		table.insert(npcTab.visibleEnemies, target)
		loadstring(npcTab.onAttack)()
		-- ���� ������ ������ ������, �� ���������� ���� �� ��� ������ �� ������������ NPC.
		if #npcTab.visibleEnemies > 1 then
			target = npcTab.visibleEnemies[func.NPC.ChooseTarget(npcName)];
			targetTank = object(target).vehname;
		end;
		-- ������������ ������, ��� �� ������ �� ������������ NPC.
		local useBooProbability = func.NPC.EvaluateTarget(npcName, func.Search(npcTab.visibleEnemies, target), "useBooProbability");
		if math.random(1, 5) < useBooProbability then func.UseItem("boo", npcName) end;
		-- ������� ��������� � ������ �����.
		if target ~= npcTab.currentTarget then
			debug.Print("| "..npcName.." began attack on "..target, "attack")
		end;
		-- NPC ���� ��������� �� ������, ���� ����� ���� � ��� ��������.
--[[		�������.
		callAllies = true, -- ����� �� NPC ����� ��������� ��� �����.
		callAlliesMaxDistance = 10, -- ����������, �� ������� NPC ����� ������� � ����� ���������.
		canBeCalledByAllies = true, -- ����� �� �������� ����� NPC.]]
--		local bandmates = {};
		for charName, charTab in pairs(main.characters) do
			if charTab.group == main.characters[npcName].group and charTab.charType == "npc" and object(charName).team then
--				table.insert(bandmates, charName)
				local x1, y1 = position(object(npcName).vehname);
				local x2, y2 = position(object(charName).vehname);
				local distance = func.UnGet32(func.GetDistance(x1, y1, x2, y2));
				if npcTab.callAllies and main.NPC.list[charName].canBeCalledByAllies and distance <= npcTab.callAlliesMaxDistance and distance <= main.NPC.list[charName].callAlliesMaxDistance then
					func.NPC.Attack("attack", charName, object(targetTank))
				end;
			end;
		end;
		-- ��������� ���� ��������� � ������� ���������� NPC, ���������� ���� �����.
		npcTab.currentTarget = target;
		func.NPC.Attack("loop", npcName, object(targetTank), frequency, 0)

		if attackMode == "not_leave_position" then
			pushcmd(function() ai_attack(npcName, targetTank) end, 0.1)
		elseif attackMode == "experimental" then
			
		elseif attackMode == "chase" then
			object(npcName).active = 1;
		elseif attackMode == "goto_aim" then
			func.object.borderTrigger.Create(object(npcName).vehname.."_oncomming", object(npcName).vehname, {on_enter=onComming, only_human=0, radius=main.NPC.list[npcName].commingRadius - 1, --[[active=enemyDetectTrigActive]]}, {dir = 6, length = main.NPC.list[npcName].commingRadius*32, radius = 1})
		end;
	elseif f == "stop" then
		if not func.Search(npcTab.visibleEnemies, target) then return; end;
		
		if attackMode ~= "not_leave_position" then ai_stop(npcName) end; -- �����, �� ������� ����� ������. ��� ���� ������� ��������� NPC ���������� ��������� ������. Slava98. 06.09.13.
		if func.object.borderTrigger.Exists(object(npcName).vehname.."_oncomming") then func.object.borderTrigger.Kill(object(npcName).vehname.."_oncomming") end;
		debug.Print("| "..npcName.." stopped attack on "..target, "attack") 
		if math.random() <= npcTab.attackSpeaks.probability and (npcTab.attackSpeaks.onStopDestroyed or npcTab.attackSpeaks.onStopLost) then
			local speak; -- ���� ���� ���������, �� ��������� ���� �������, ���� �� �� ������ ����, �� ������. Slava98. 23.02.14.
			if targetIsDestroyed then speak = npcTab.attackSpeaks.onStopDestroyed; else speak = npcTab.attackSpeaks.onStopLost; end;
			func.object.Speak(object(npcName).vehname, func.Read({npcTab.attackSpeaks.file, speak, "random"}), nil --[[����� ������ ���� ������� ��������]]) 
		end;
		table.remove(npcTab.visibleEnemies, func.Search(npcTab.visibleEnemies, target))
		if #npcTab.visibleEnemies ~= 0 then return; end;
		npcTab.currentTarget = "";
		object(npcName).active = 0;
		pushcmd(function()
			func.NPC.FollowWay(npcName)
		end, 0.1)
	elseif f == "loop" then
		if not exists(npcName) or not func.Search(npcTab.visibleEnemies, target) then return; end;
		if not npcTab.attackMode then func.NPC.Attack("stop", npcName, who, nil, nil, false) return; end;
		
		pushcmd(function() 
			if targetTank and exists(targetTank) --[[and main.NPC.list[npc].letAttack]] then
				n = n + 1;
				if math.floor(frequency*n) == math.floor(npcTab.attackSpeaks.loopInterval) and math.random() <= npcTab.attackSpeaks.probability and npcTab.attackSpeaks.onLoop then n = 0; func.object.Speak(object(npcName).vehname, func.Read({npcTab.attackSpeaks.file, npcTab.attackSpeaks.onLoop, "random"}), nil --[[����� ������ ���� ������� ��������]]) end;
				func.NPC.Attack("loop", npcName, who, frequency, n)
			elseif not targetTank then
				func.NPC.Attack("stop", npcName, who, nil, nil, false)
			elseif not exists(targetTank) then
				func.NPC.Attack("stop", npcName, target, nil, nil, true)
			end
		end, frequency)
		if attackMode == "goto_aim" then
			local x, y = position(targetTank);
			ai_march(npcName, x, y)
		end;
	end;
end

---------------------------------------------------------------------------------------------------------------------
----------------------------------------------------- ���� ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

function func.way.Create(wayName, coordTab, g32, wayTab)--onEnterFunc, killAfterEnter, onLeaveFunc, killAfterLeave, actOnEveryTrig, isCicle)
--	���������� ������ (��������).

--	���������� ��������� ���������� (��������).
	local wayTab = func.UniteTables({
		onEnterFunc = "",
		killAfterEnter = false,
		onLeaveFunc = "",
		killAfterLeave = false,
		actOnEveryTrig = false,
		isCicle = false,
		active = true,
		shortcut = false, -- �����, ��� ������ ��� ������ �� �����, �.�. ���������� ��������� �������� ��� ���������. Slava98. 18.02.14.
		choseClosestPoint = false,
		points = #coordTab,
		radius = radius or 1,
		allowedNPCs = {},
	}, wayTab);
	
	for i = 1, #coordTab do
		coordTab[i].x = coordTab[i][1];
		coordTab[i].y = coordTab[i][2];
		
		if g32 then 
			coordTab[i].x = func.Get32(coordTab[i].x); 
			coordTab[i].y = func.Get32(coordTab[i].y);
		end;
		
		local onEnterFunc = wayTab.onEnterFunc;
		local nextWayPointNum = 0;
		local existsNextPoint = true;
--		local gotoNextTrigFunc = "";
--		local killFunc = "";
--		local shortcutFunc = "";

		level.ways[wayName] = wayTab;
--		main.NPC.list[npc].ways[wayName] = wayTab; -- ������ ���� �� ������ �������� �� NPC. Slava98. 30.11.13.
--		main.NPC.list[npc].currentWay = wayName;
		
		if i < #coordTab then
			nextWayPointNum = i + 1;
			if not wayTab.actOnEveryTrig then onEnterFunc = ""; end;
		else
			if wayTab.isCicle then 
				nextWayPointNum = 1;
				level.ways[wayName].shortcut = false;
			else
				existsNextPoint = false;
--				gotoNextTrigFunc = " for i = 1, #level.ways['"..wayName.."'].allowedNPCs do if who.playername == level.ways['"..wayName.."'].allowedNPCs[i] then local npc = level.ways['"..wayName.."'].allowedNPCs[i]; main.NPC.list[npcName].nextWayPoint = nil end; end; ";
			end;
		end;
--		if i ~= #coordTab or i == #coordTab and wayTab.isCicle then existsNextPoint = true; end; --gotoNextTrigFunc = "; for i = 1, #level.ways['"..wayName.."'].allowedNPCs do if who.playername == level.ways['"..wayName.."'].allowedNPCs[i] then local npcName = level.ways['"..wayName.."'].allowedNPCs[i]; nextWayPoint = nextWayPoint or '"..wayName.."_waytrig"..nextWayPointNum.."'; main.NPC.list[npcName].nextWayPoint = nextWayPoint; local x, y = position(nextWayPoint); ai_march(npcName, x, y) end; end; "; end;
--		if wayTab.shortcut then shortcutFunc = "; local trigCoordTab = {}; local tankCoordTab = {position(who.name)}; local lengthTab = {}; for i = 1, level.ways['"..wayName.."'].points do trigCoordTab[i] = {}; trigCoordTab[i].x, trigCoordTab[i].y = position('"..wayName.."_waytrig'..i); lengthTab[i] = math.sqrt((tankCoordTab[1] - trigCoordTab[i].x)^2 + (tankCoordTab[2] - trigCoordTab[i].y)^2); end; local nextWayPoint = '"..wayName.."_waytrig'..func.ArrayMin(lengthTab); a = lengthTab"; end;

		actor("trigger", coordTab[i].x, coordTab[i].y, {name = wayName.."_waytrig"..i, on_enter = "local wayTab = level.ways['"..wayName.."']; local IsAllowed = function() for i = 1, #wayTab.allowedNPCs do if who.playername == wayTab.allowedNPCs[i] then return true; end; end; end; if not who or not IsAllowed() or not wayTab.active then return; end; if wayTab.isCicle then main.NPC.list[who.playername].wayFinishPointNum = nil; end; local nextWayPoint; local currentWayPointNum = "..i.."; if wayTab.shortcut then nextWayPoint = func.way.Shortcut('"..wayName.."', who, nil, currentWayPointNum, wayTab.choseClosestPoint); end;"..onEnterFunc.." func.way.GotoNextTrig('"..wayName.."', who, "..tostring(existsNextPoint)..", "..nextWayPointNum..", nextWayPoint, currentWayPointNum); if currentWayPointNum == wayTab.points and not wayTab.isCicle then wayTab.allowedNPCs[func.Search(wayTab.allowedNPCs, who.playername)] = nil; if wayTab.killAfterEnter then func.NPC.KillWay('"..wayName.."'); end; end;", radius=wayTab.radius}) --"ourwarrior1_baseact_waytrig1"
	end;
end

function func.way.Kill(wayName)
--	���������� ������ (��������).


	for i = 1, level.ways[wayName].points do
		func.KillIfExists(wayName.."_waytrig"..i)
	end;
	level.ways[wayName] = nil;
end

-- ���� - ��� ������ �������� �������� ����� �������� ���.
-- �������, ������� �������� �� ���� ����� ���� ��������� � ����� ����� ��� �������� �����. Slava98. 11.12.13.
function func.way.Shortcut(wayName, who, returnNum, currentWayPointNum, choseClosestPoint)
	local trigCoordTab = {}; 
	local tankCoordTab = {position(who.name)}; 
	local lengthTab = {};
	local finishPointNum = main.NPC.list[who.playername].wayFinishPointNum;
--	local currentWayPointNum = currentWayPointNum or 0;
	
	for i = 1, level.ways[wayName].points do
		if i ~= currentWayPointNum then
			trigCoordTab[i] = {};
			trigCoordTab[i].x, trigCoordTab[i].y = position(wayName.."_waytrig"..i); 
			lengthTab[i] = math.sqrt((tankCoordTab[1] - trigCoordTab[i].x)^2 + (tankCoordTab[2] - trigCoordTab[i].y)^2); 
		else
			lengthTab[i] = 2^16; -- ��������� �� �����, �� ������� ����� NPC ����� 2^16. �� ���� �� �� �� ���� �� ������� ����� �������.
		end;
	end; 
	
	debug.Print("--------- shortcut NPC '"..who.name.."' ---------", "way")
	debug.Print("{", "way")
	local nextPointNum = 1;
	local function correctWayTest(pointNum)
		debug.Print(" | finishPointNum = "..finishPointNum, "way")
		debug.Print(" | currentWayPointNum = "..currentWayPointNum, "way")
		debug.Print(" | pointNum = "..pointNum, "way")
		debug.Print(" --", "way")
	end;
	local function pointIsInCorrectWay(pointNum)
		if finishPointNum < currentWayPointNum and pointNum < currentWayPointNum --[[and pointNum > finishPointNum]] then correctWayTest(pointNum) return true;
		elseif finishPointNum > currentWayPointNum and pointNum > currentWayPointNum --[[and pointNum < finishPointNum]] then correctWayTest(pointNum) return true;
		end;
	end;
	
	if currentWayPointNum --[[and choseClosestPoint]] then -- ���� ���� ����� �� �����-���� ����� ���� � ��� ���� ������� �������� ��������� �����.
		local correctLengthTab = {};
		for i = 1, #lengthTab do
			if pointIsInCorrectWay(i) then correctLengthTab[i] = lengthTab[i];
			else correctLengthTab[i] = 2^16;
			end;
		end;
		lengthTab = correctLengthTab;
	end;
	
	local minNum = lengthTab[1];
	for i = 1, #lengthTab do
		if lengthTab[i] < minNum then minNum = lengthTab[i]; nextPointNum = i; debug.Print(" | minNum = "..minNum.."; i = "..i, "way"); end;
	end;
	
	local nextWayPoint = wayName.."_waytrig"..nextPointNum;--func.ArrayMin(lengthTab);
	a, b = lengthTab, trigCoordTab;
	debug.Print(" | nextWayPoint = '"..nextWayPoint.."'", "way")
	debug.Print("}", "way")
	debug.Print("---------", "way")
	if returnNum then return --[[func.ArrayMin(lengthTab)]]nextPointNum; end;
	return nextWayPoint;
end

-- ��� ���� ������ ���� ��������.
-- �������, ������� ����������� ����� ������ �� ��������� �����. Slava98. 11.12.13.
function func.way.GotoNextTrig(wayName, who, existsNextPoint, nextWayPointNum, nextWayPoint, currentWayPointNum)  
	local npcName = who.playername;
	local npcTab = main.NPC.list[npcName];
	local finishPointNum = npcTab.wayFinishPointNum;
	local points = level.ways[wayName].points;
	
	if (not existsNextPoint and finishPointNum == points) or currentWayPointNum == finishPointNum then -- ���� ���� �������� ���� ����.
		npcTab.nextWayPoint = nil; 
		npcTab.currentWay = nil;
		return;
	end;
	
	debug.Print("--------- gotonexttrig NPC '"..who.name.."' ---------", "way")
	debug.Print("{", "way")
	if nextWayPoint then debug.Print(" |nextWayPoint = '"..nextWayPoint.."'", "way") end;
	debug.Print(" |nextWayPointNum = "..nextWayPointNum, "way")
	debug.Print("}", "way")
	debug.Print("---------", "way")
	
	local nextWayPoint = nextWayPoint or wayName.."_waytrig"..nextWayPointNum; 
	npcTab.nextWayPoint = nextWayPoint; 
	local x, y = position(nextWayPoint);
	ai_march(npcName, x, y)
	debug.Print("| next point of '"..npcName.."' is '"..nextWayPoint.."'", "way_short")
end

function func.way.Refresh(wayName)
-- ���������� ������ (��������).

	for i = 1, level.ways[wayName].points do func.object.Recreate(wayName.."_waytrig"..i); end;
end

--------------------------------------------------------------------------------------------------------------------
------------------------------------------------ ����� -------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

-- ����� ������. Slava98.
function func.player.Create(properties, team, spawnTeam, x, y, dir, charTab)
-- ���������� ������.
	if type(properties) ~= "table" then error("bad argument #1 to 'func.player.Create' (table expected, got "..type(properties)..")", 2) return; end;
	if type(team) ~= "number" then error("bad argument #2 to 'func.player.Create' (number expected, got "..type(team)..")", 2) return; end;
	if type(spawnTeam) ~= "number" then error("bad argument #3 to 'func.player.Create' (number expected, got "..type(spawnTeam)..")", 2) return; end;
	if type(x) ~= "number" then error("bad argument #4 to 'func.player.Create' (number expected, got "..type(x)..")", 2) return; end;
	if type(y) ~= "number" then error("bad argument #5 to 'func.player.Create' (number expected, got "..type(y)..")", 2) return; end;
	if type(dir) ~= "number" then error("bad argument #6 to 'func.player.Create' (number expected, got "..type(dir)..")", 2) return; end;
	if type(charTab) ~= "table" then error("bad argument #7 to 'func.player.Create' (table expected, got "..type(charTab)..")", 2) return; end;
	
	local charTab = func.UniteTables(charTab, {
		charType = "player",
	});
	
	if func.player.isExist ~= true then 
		func.player.isExist = true;
		local name = const.playerName;
		func.CreateCharacter(name, charTab)
		func.SpawnTank(name, "player_local", properties, x, y, team, spawnTeam, dir, weap)
	end;
end

-- ��������� ������� ������ ������. 
function func.player.Die() 
	func.player.isExist = false;
	kill(const.playerName)
	func.Play("lose")
	level.Lose()
--	msgbox("�� ���������!")
end

function func.player.ChoseWeap(weapType)
-- ���������� ��������� ����������.
	local charTab = main.characters[const.playerName]; 
	local weapons = charTab.inventory.weapons;
	
	charTab.inventory.isSetWeap = true;
	func.EquipWeap(charTab.currentWeap, const.playerName.."_weap", const.playerVehName)
	
	func.MsgBox(func.Read({"main", "msg_changeweap", 2, {weap = func.ConvertWeap(weapType)}}), {on_select="pause(false); local charTab = main.characters[const.playerName]; local weapons = charTab.inventory.weapons; local x, y = position(const.playerVehName); if n == 1 or n == 2 then --[[local oldWeap=func.ObjectCopy(const.playerName..'_weap'); func.KillIfExists(const.playerName..'_weap'); func.ObjectPaste(oldWeap, '');]] local droppedWeap = weapons[n].weapType; pushcmd(function() actor(droppedWeap, x, y, {on_pickup='func.player.OnGetWeapon(self)'}) end, 0.1); table.remove(weapons, n); func.CharacterSetWeap(const.playerName, '"..weapType.."', charTab.currentWeap == weapons[n]); elseif n == 3 then actor('"..weapType.."', x, y, {on_pickup='func.player.OnGetWeapon(self)'}); end;", option1=func.ConvertWeap(weapons[1].weapType), option2=func.ConvertWeap(weapons[2].weapType), option3=func.Read({"main", "menu", 27})}, "weapbox")
	pause(true)
end

---------------------------------------------------------------------------------------------------------------------
------------------------------------------------ ����� --------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

function func.text.Create(textName, x, y, textTab)
-- ���������� ������ (��������).

-- ���������� ��������� ����������.
	local textTab = func.UniteTables({
		texture = "font_small",
		text = "",
		stringLength = string.len(textTab.text),
		layer = 11,
		lettersCoordTab = {},
	}, textTab);
	local spaceBetweenLetters = 6;
	local spaceBetweenStrophes = 12;
	local function curStr(symbNum) local result = math.ceil(symbNum/textTab.stringLength) - 1; return result; end;
	
	for symbNum = 1, string.len(textTab.text) do
		local x = x + (symbNum - textTab.stringLength*curStr(symbNum))*spaceBetweenLetters;
		local y = y + curStr(symbNum)*spaceBetweenStrophes;
		actor("user_sprite", x, y, {name=textName.."_text"..symbNum, texture=textTab.texture, frame=string.byte(string.sub(textTab.text, symbNum)) - 32, layer=textTab.layer})
		textTab.lettersCoordTab[symbNum] = {x, y};
	end;
	
	level.texts[textName] = textTab;
end

function func.text.Kill(textName)
-- ���������� ������ (��������).

	for i = 1, string.len(level.texts[textName].text) do
		kill(textName.."_text"..i);
	end;
	level.texts[textName] = nil;
end

function func.text.SetPosition(textName, x, y)
-- ���������� ������ (��������).

	for i = 1, string.len(level.texts[textName].text) do
		local cTab = level.texts[textName].lettersCoordTab;
		local x = x + math.abs(cTab[1][1] - cTab[i][1]);
		local y = y + math.abs(cTab[1][2] - cTab[i][2]);
		
		setposition(textName.."_text"..i, x, y);
	end;
end

function func.text.Exists(textName)
-- ���������� ������ (��������).

	if type(level.texts[textName]) ~= "table" then return false; end;
	
	for k, v in pairs(level.texts) do
		if k == textName then return true; end;
	end;
	return false;
end

---------------------------------------------------------------------------------------------------------------------
----------------------------------------------- ������ --------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

function func.timer.Create(timerName, timerTab)
-- ���������� ������ (��������).

	if not timerTab.StartFunc and timerTab.funcTab[1] then timerTab.StartFunc = timerTab.funcTab[1]; end;
	if not timerTab.CircleFunc and timerTab.funcTab[2] then timerTab.CircleFunc = timerTab.funcTab[2]; end;
	if not timerTab.FinishFunc and timerTab.funcTab[3] then timerTab.FinishFunc = timerTab.funcTab[3]; end;
	local timerTab = func.UniteTables({
		period = 0.1,
		value = 0,
		roundedValue = 0,
		roundedPeriod = 1,
		timer = 1,
		active = true,
		activated = false,
		breakable = true,
		loop = false,
		secondsLeft = 0,
		StartFunc = function() end,
		CircleFunc = function() end,
		FinishFunc = function() end,
		funcTab = {},
		argsTab = {},
	}, timerTab)
	
	for i = 1, 3 do timerTab.argsTab[i] = func.DoTable(timerTab.argsTab[i]); end;
	
	main.timers[timerName] = timerTab;
end

function func.timer.Play(timerName)
	local timerTab = main.timers[timerName];
	local timerFinished;
	timerTab.roundedPeriod = 1;
	timerTab.active = true;
	timerTab.secondsLeft = timerTab.timer;
	timerTab.cleared = false;
--	timerTab.roundedValue = math.floor(timerTab.roundedValue) + 1;	

	local function Execute(Func, argsNum)
		if type(Func) == "function" then Func(unpack(timerTab.argsTab[argsNum]));
		elseif type(Func) == "string" then loadstring(Func)();
		end;
	end;
	local function Loop()
		timerTab = main.timers[timerName];
		timerTab.value = timerTab.value + timerTab.period;
		timerTab.secondsLeft = timerTab.timer - timerTab.value;
		pushcmd(function()
			if not timerFinished and timerTab.active then
--				if timerTab.cleared then timerTab.cleared = false; return; end;
				local command = Execute(timerTab.CircleFunc, 2); -- ��������� �������, ������������� ������ ����. Slava98. 20.01.14.
				if command ~= "stop" then Loop() end;
			end;
		end, timerTab.period)
	end;
	local function isFinishedLoop() -- �������� ������������� �������. Slava98. 03.02.14.
		local residual = timerTab.timer - timerTab.value;
		if residual < 1 then timerTab.roundedPeriod = residual; end;
		pushcmd(function()
			if timerTab.roundedValue < timerTab.timer then
--				print(timerTab.roundedValue, timerTab.roundedPeriod)
				timerTab.roundedValue = timerTab.roundedValue + 1;
				isFinishedLoop()
			else
				timerTab.activated = false;
				timerFinished = true;
				func.timer.Clear(timerName)
				Execute(timerTab.FinishFunc, 3) -- ��������� �������� �������. Slava98. 20.01.14.
				if timerTab.loop then
					timerTab.activated = true;
					isFinishedLoop()
				end;
			end;
		end, timerTab.roundedPeriod)
	end;
--[[	pushcmd(function()
		print(timerTab.cleared)
		if timerTab.cleared then timerTab.cleared = true; return; end;
		timerFinished = true;
		func.timer.Clear(timerName)
		Execute(timerTab.FinishFunc, 3) -- ��������� �������� �������. Slava98. 20.01.14.
	end, timerTab.secondsLeft)]]
	
--	if timerTab.secondsLeft ~= timerTab.timer then Execute(timerTab.StartFunc, 1) end; -- ��������� ��������� �������. Slava98. 20.01.14.
	
	if timerTab.breakable and timerTab.activated then return; end;
	Execute(timerTab.StartFunc, 1) -- ��������� ��������� �������. Slava98. 20.01.14.
	if timerTab.activated then --[[func.timer.Clear(timerName)]] return; end;
	timerTab.activated = true;
	Loop() -- ��������� ����. Slava98. 20.01.14.
	isFinishedLoop()
end

function func.timer.Pause(timerName)
	main.timers[timerName].active = false;
	main.timers[timerName].activated = false;
end

function func.timer.Clear(timerName)
--	main.timers[timerName].cleared = true;
	main.timers[timerName].roundedValue = 0;
	main.timers[timerName].value = 0;
	main.timers[timerName].secondsLeft = main.timers[timerName].timer;
end

function func.timer.Exists(timerName)
	if main.timers[timerName] then return true;
	else return false;
	end;
end

function func.timer.Kill(timerName)
	main.timers[timerName] = nil;
end

---------------------------------------------------------------------------------------------------------------------
------------------------------------------------ ������ ------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

-- ������� ��������� ����. ������ ���� ���. VIRUS.
function func.MineDetonate(who) 
	if who ~= nil then
			damage(500, who)
	else
	end;
end

-- ������� ������ � ������� ������� ��� �����. Slava98. 05.01.14.
function func.BombTimer(timer)
	local function SetPadej(num)
		numTail = tonumber(string.sub(num, string.len(num)));
		if numTail == 1 then return 32;
		elseif numTail >= 2 and numTail <= 4 then return 33;
		else return 31;
		end;
	end;
	
	pause(true)
	func.MsgBox(func.Read({"main", "msg_notices", 30}, timer, {"main", "msg_notices", SetPadej(timer)}), {
			on_select="pause(false); local t="..timer.."; local inventory = main.characters[const.playerName].inventory; if n==1 then inventory.bombTime=t; print(inventory.dropBomb) if inventory.dropBomb then pushcmd(function() func.DropItem('bomb_activated'..t, const.playerName) end, 0.1); inventory.dropBomb=false; end elseif n==2 then if t>0 and t<=10 then t=t-1; elseif t>10 then t=t-10; end; func.BombTimer(t); elseif n==3 then if t>=0 and t<10 then t=t+1; elseif t>=10 then t=t+10; end; func.BombTimer(t); end",
			option1 = func.Read({"main", "menu", 35}), 
			option2 = "<", 
			option3 = ">"},	"bombbox")
end

-- ������ �����, ��� �������. Slava98.
function func.ActorBomb(name, x, y)
	actor("tank", x, y, {name=name, class="bomb", skin="bomb", on_damage="local x, y = position('"..name.."'); func.Explosion(x, y, nil, nil, nil, 3000)"})
end

-- ������ �����, ��� ��������� ������� (���������� �� ������). Slava98.
-- �� �������: ����� ����� - ��������� ������. �������� � ���, ��� �� ��� ����. Slava98. 11.01.14.
function func.SetBomb(name, x, y, killed_objects, timer, get32)
-- ���������� ������ (��������).

	if get32 then x = func.Get32(x); y = func.Get32(y); end
	local timer = timer or 10;
	func.Sound("bomb")
	actor("user_sprite", x, y, {name=name, texture = "user/bomb", layer=3})
	pushcmd(function() 
		func.Explosion(x, y, nil, nil, nil, 3000)
		for i = 1, table.maxn(killed_objects) do if exists(killed_objects[i]) then kill(killed_objects[i]) end; end
		kill(name)
		actor("trigger", x, y, {name=name.."_trig", on_enter="func.Destroy(who.name)", only_human=0, radius=2, only_visible=0})
	end, timer)
	pushcmd(function() kill(name.."_trig") end, timer + 0.2)
end

-- ���������� ������������� �������� ������. Slava98. 02.03.14.
function func.EvaluateWeap(weapName)
	if weapName == "weap_ram" or weapName == "none" then return 0;
	elseif weapName == "weap_cannon" or weapName == "weap_minigun" or weapName == "weap_autocannon" or weapName == "weap_shotgun" then return 1;
	elseif weapName == "weap_plazma" or weapName == "weap_rockets" then return 2;
	elseif weapName == "weap_gauss" or weapName == "weap_ripper" then return 3;
	elseif weapName == "weap_zippo" or weapName == "weap_bfg" then return 4;
	end;
end

-- ������ �������, ��� � ������ 0.24. ������������ ����� ����������������� ������ �����.

function func.GiveClassHealth(whom) --������������� �������, ������� ���� � whom ��������� ��������
	if whom == nil then error("� ������� main.GiveClassHealth(whom) ���������� whom �� ������ ���� nil!", 3) end;
	if exists(whom) == false then 
		error("������ ������� �� ����������!", 3) 
	else
		if objtype(whom) ~= "player_local" and objtype(whom) ~= "ai" then 
			error("� ������� main.GiveClassHealth(whom) ���������� whom ������ ���� ������� ��� ����� (�� �� ������!)", 3)
		else
			local a = pget(whom, "class");
			local s = rawget(classes, a);
			local whomHealth = s.health;
			if whomHealth == nil then error("� ������� main.GiveClassHealth(whom) ���� ������. ���� �� ��� �������, �������� �� ���� �� ����� � ���� �������� War System.", 3) end
			return whomHealth;
		end;
	end;
end

function func.RestoreHealth(whom, num, amount, restoredHealth, maxAmount, frequency)  -- ������� ��������������� ���������� �������� � whom
	local frequency = frequency or 10;
	local restoredHealth = restoredHealth or 25;
	local maxAmount = maxAmount or 39;
	if num == nil then
		amount = 0;
		if whom == const.playerVehName then func.Message({"main", "msg_notices", 11}) end;
		func.RestoreHealth(whom, 1, amount, restoredHealth, maxAmount, frequency)
	else
		if whom == nil then error("� ������� main.RestoreHealth(whom) ���������� whom �� ������ ���� nil!", 2) end;
		if exists(whom) == false then error("������ ������� �� ����������!", 32) 
		else
			if objtype(whom) ~= "tank" then error("� ������� main.RestoreHealth(whom) ���������� whom ������ ���� ������ (�� �� ������� ��� �����!)", 2)
			else
				print(amount.." "..maxAmount)
				if amount >= maxAmount then 
					if whom == const.playerVehName then func.Message({"main", "msg_notices", 12}) else end;
					amount = 0;
				else
--					whom_name = whom;
					local whomHealth = func.GiveClassHealth(object(whom).playername)
					if pget(whom, "health") <= whomHealth then
						damage(-restoredHealth, whom)
						amount = amount + 1;
						pushcmd(function() func.RestoreHealth(whom, 1, amount, restoredHealth, maxAmount, frequency) end, 1/frequency)
					elseif pget(whom, "health") >= whomHealth then 
						damage(pget(whom, "health") - whomHealth, whom)
						if whom == "ourplayer_tank" then func.Message({"main", "msg_notices", 13}) else end;
					end;
				end;
			end;	
		end;
	end;
end

-- ������ ������. ���� ��������� ������. Slava98.
function func.Read(...)
	local args = {...};
	local outputTab = {};
	
	local function ReadText(args, i, dlg, speaker, num, patchTab)
		if type(args[i]) == "string" or type(args[i]) == "number" then return args[i]; end;
		
		local output = level.dialog[dlg][level.dialog.lang][speaker][num];
		local patchTab = func.DoTable(patchTab);
	-- ������ ����� ����� � �������� ������ ������� � ������ �������. Slava98. 04.01.14.
		output = string.gsub(output, "~(%w+)~", patchTab)
		return output;
	end;
	
	for i = 1, #args do
		local text;
		local dlg;
		local speaker;
		local num;
		local patchTab;
		
	-- ���������� ������.
		if type(args[i]) == "table" then
			text = args[i]
			dlg = text[1];
			speaker = text[2];
			num = text[3];
			patchTab = text[4];
		
			if type(dlg) ~= "string" then error("bad variable #1 in argument #"..i.." to 'func.Read' (string expected, got "..type(dlg)..")", 2) return; end;
			if type(speaker) ~= "string" then error("bad variable #2 in argument #"..i.." to 'func.Read' (string expected, got "..type(speaker)..")", 2) return; end;
			if type(num) ~= "number" and type(num) ~= "string" then error("bad variable #3 in argument #"..i.." to 'func.Read' (number or string expected, got "..type(num)..")", 2) return; end;
			if type(patchTab) ~= "table" and patchTab ~= nil then error("bad variable #4 in argument #"..i.." to 'func.Read' (table expected, got "..type(patchTab)..")", 2) return; end;
			if type(level.dialog[dlg]) ~= "table" then error("bad variable #1 in argument #"..i.."  to 'func.Read' (dialog '"..dlg.."' isn't exist)", 2) end;
			if type(level.dialog[dlg][level.dialog.lang]) ~= "table" then error("bad arguments to 'func.Read' or problems with lang") end;
			if type(level.dialog[dlg][level.dialog.lang][speaker]) ~= "table" then error("bad variable #2 in argument #"..i.." to 'func.Read' (speaker '"..speaker.."' does not exist)", 2) end;
		--	������ ����������� �������� ����� ��������. Slava98. 17.02.14.	
			if num == "random" then num = math.random(#level.dialog[dlg][level.dialog.lang][speaker]) end;
			if type(level.dialog[dlg][level.dialog.lang][speaker][num]) ~= "string" then error("bad variable #3 in argument #1 to 'func.Read' (num '"..num.."' does not exist)", 2) end;
		elseif type(args[i]) == "string" or type(args[i]) == "number" then 
		else error("bad argument #"..i.." to 'func.Read' (table or string or number expected, got "..type(args[i])..")", 2)
		end;
		outputTab[i] = ReadText(args, i, dlg, speaker, num, patchTab)
	end;
	
	return table.concat(outputTab);
end

-- ������� ���������. Slava98.
function func.Message(text, transmitToConsole)
-- ���������� ������.
	if type(text) ~= "string" and type(text) ~= "table" then error("bad argument #1 to 'func.Message' (string or table expected, got "..type(text)..")", 2) return; end;
	if type(transmitToConsole) ~= "boolean" and transmitToConsole ~= nil then error("bad argument #2 to 'func.Message' (boolean expected, got "..type(transmitToConsole)..")", 2) return; end;
	
	if transmitToConsole == nil then transmitToConsole = true; end;
	
	if type(text) == "table" then
-- ���������� ������.
		if type(text[1]) ~= "string" then error("bad variable #1 in argument #1 to 'func.Message' (string expected, got "..type(text[1])..")", 2) return; end;
		if type(text[2]) ~= "string" then error("bad variable #2 in argument #1 to 'func.Message' (string expected, got "..type(text[2])..")", 2) return; end;
		if type(text[3]) ~= "number" then error("bad variable #3 in argument #1 to 'func.Message' (number expected, got "..type(text[3])..")", 2) return; end;
		if type(text[4]) ~= "table" and text[4] ~= nil then error("bad variable #4 in argument #1 to 'func.Message' (table expected, got "..type(text[4])..")", 2) return; end;
		if type(level.dialog[text[1]]) ~= "table" then error("bad variable #1 in argument #1  to 'func.Message' (dialog '"..text[1].."' isn't exist)", 2) end;
		if type(level.dialog[text[1]][level.dialog.lang]) ~= "table" then error("bad arguments to 'func.Message' or problems with lang") end;
		if type(level.dialog[text[1]][level.dialog.lang][text[2]]) ~= "table" then error("bad variable #2 in argument #1 to 'func.Message' (speaker '"..text[2].."' does not exist)", 2) end;
		if type(level.dialog[text[1]][level.dialog.lang][text[2]][text[3]]) ~= "string" then error("bad variable #3 in argument #1 to 'func.Message' (num '"..text[3].."' does not exist)", 2) end;
		
		text = func.Read(text);
	end;
	
	message(text)
	
	if transmitToConsole then main.consoleText = main.consoleText.."\n"..text; end;
	return text;
end

-- ������� ���� � ����������. Slava98.
function func.MsgBox(text, msgTab, boxType)
	if type(text) ~= "string" and type(text) ~= "table" then error("bad argument #1 to 'func.MsgBox' (string or table expected, got "..type(text)..")", 2) return; end;
	if type(msgTab) ~= "table" and msgTab ~= nil then error("bad argument #2 to 'func.MsgBox' (table expected, got "..type(msgTab)..")", 2) return; end;
	if type(boxType) ~= "string" and boxType ~= nil then error("bad argument #3 to 'func.MsgBox' (string expected, got "..type(boxType)..")", 2) return; end;

	msgTab = msgTab or {};
	msgTab.name = boxType or msgTab.name or "msbox";
	if #msgTab ~= 0 then
		msgTab.on_select = msgTab[1]; 
		msgTab.option1 = msgTab[2]; 
		msgTab.option2 = msgTab[3];
		msgTab.option3 = msgTab[4]; 
	end;
	
	if type(text) == "table" then
-- ���������� ������.
		if type(text[1]) ~= "string" then error("bad variable #1 in argument #1 to 'func.MsgBox' (string expected, got "..type(text[1])..")", 2) return; end;
		if type(text[2]) ~= "string" then error("bad variable #2 in argument #1 to 'func.MsgBox' (string expected, got "..type(text[2])..")", 2) return; end;
		if type(text[3]) ~= "number" then error("bad variable #3 in argument #1 to 'func.MsgBox' (number expected, got "..type(text[3])..")", 2) return; end;
		if type(level.dialog[text[1]]) ~= "table" then error("bad variable #1 in argument #1  to 'func.MsgBox' (dialog '"..text[1].."' isn't exist)", 2) end;
		if type(level.dialog[text[1]][level.dialog.lang]) ~= "table" then error("bad arguments to 'func.MsgBox' or problems with lang") end;
		if type(level.dialog[text[1]][level.dialog.lang][text[2]]) ~= "table" then error("bad variable #2 in argument #1 to 'func.MsgBox' (speaker '"..text[2].."' does not exist)", 2) end;
		if type(level.dialog[text[1]][level.dialog.lang][text[2]][text[3]]) ~= "string" then error("bad variable #3 in argument #1 to 'func.MsgBox' (num '"..text[3].."' does not exist)", 2) end;

		text = func.Read(text);
	end;
	
	msgTab.text = text;
	for i = 1, #msgTab do msgTab[i] = nil; end;
	func.KillIfExists(msgTab.name)
	
--	pause(false)
--	pushcmd(function() pause(true); service("msgbox", msgTab); end, 0.01)
	service("msgbox", msgTab)
	
	return text;
end

-- ������ MsgBox, � ������� ����� ������� ��������� ��������� ������ ����������� ������� ������ "�����", "����" � "�������".
function func.ListBox(text, sectionTab, chosedSectionNum, boxType, isButtonToSwitch, pointChar)
-- ���������� ������ (��������).

	local chosedSectionNum = chosedSectionNum or 1;
	local pointChar = pointChar or ">";
	local boxType = boxType or "listbox";
	local finalText = text;
	
	for i = 1, #sectionTab do
		sectionTab[i].sectionTitle = sectionTab[i].sectionTitle or "";
		sectionTab[i].singedChar = sectionTab[i].singedChar or "*";
		sectionTab[i].stringsOnPage = sectionTab[i].stringsOnPage or 10;
		sectionTab[i].chosedStringNum = sectionTab[i].chosedStringNum or 1;
		
		local sectionTitle = sectionTab[i].sectionTitle;
		local stringTab = sectionTab[i].stringTab;
		local funcTab = sectionTab[i].funcTab;
		local singedTab = sectionTab[i].signedTab;
		local singedChar = sectionTab[i].singedChar;
		local stringsOnPage = sectionTab[i].stringsOnPage;
		local chosedStringNum = sectionTab[i].chosedStringNum;
		local showNumeration = sectionTab[i].showNumeration;
		local currentPage = math.floor(chosedStringNum/(stringsOnPage + 1))+ 1;
		local listText = "";
		
		for num, str in pairs(stringTab) do
			if num > (currentPage - 1)*stringsOnPage and num <= currentPage*stringsOnPage then
				if num ~= chosedStringNum or i ~= chosedSectionNum then
					if not showNumeration then
						listText = listText.."\n  "..str;
					else
						listText = listText.."\n  "..num..")"..str;
					end;
				else
					if not showNumeration then
						listText = listText.."\n"..pointChar.." "..str;
					else
						listText = listText.."\n"..pointChar.." "..num..")"..str;
					end;
				end;
			end;
		end;
		
		if type(finalText) == "string" then
			finalText = " "..finalText..sectionTitle..listText;
		elseif type(finalText) == "table" then
			table.insert(finalText, "\n"..sectionTitle);
			table.insert(finalText, listText);
		end;
	end;
	
	main.objects[boxType] = {text, sectionTab, chosedSectionNum, boxType, isButtonToSwitch, pointChar,
		text = text, sectionTab = sectionTab, chosedSectionNum = chosedSectionNum, boxType = boxType, isButtonToSwitch = isButtonToSwitch, pointChar = pointChar}, -- ��� ������ �����������, �� �� ����� ��� �����-������ ������ ��������. Slava98. 21.05.14.
	
	func.MsgBox(finalText, {on_select="local boxTab = main.objects['"..boxType.."']; local sectionTab = boxTab[2]; local num = boxTab[3]; if n == 1 then if #sectionTab[num].stringTab > sectionTab[num].chosedStringNum then sectionTab[num].chosedStringNum = sectionTab[num].chosedStringNum + 1; else sectionTab[num].chosedStringNum = 1; if #sectionTab > num then boxTab[3] = num + 1; sectionTab[boxTab[3]].chosedStringNum = 1; elseif #sectionTab == num then boxTab[3] = 1; sectionTab[boxTab[3]].chosedStringNum = 1; end; end; func.ListBox(unpack(boxTab)); elseif n == 2 then if 1 < sectionTab[num].chosedStringNum then sectionTab[num].chosedStringNum = sectionTab[num].chosedStringNum - 1; else sectionTab[num].chosedStringNum = #sectionTab[num].stringTab; if 1 < num then boxTab[3] = num - 1; sectionTab[boxTab[3]].chosedStringNum = #sectionTab[boxTab[3]].stringTab; elseif 1 == num then boxTab[3]=#sectionTab; sectionTab[boxTab[3]].chosedStringNum = #sectionTab[boxTab[3]].stringTab; end; end; func.ListBox(unpack(boxTab)); elseif n == 3 then if type(sectionTab[boxTab[3]].funcTab[sectionTab[num].chosedStringNum]) == 'string' then loadstring(sectionTab[boxTab[3]].funcTab[sectionTab[num].chosedStringNum])() elseif type(sectionTab[num].funcTab[sectionTab[num].chosedStringNum]) == 'function' then sectionTab[num].funcTab[sectionTab[num].chosedStringNum](sectionTab[num].chosedStringNum) end; end" , option1=func.Read({"main", "menu", 39}), option2=func.Read({"main", "menu", 38}), option3=func.Read({"main", "menu", 40})}, boxType)
	return chosedStringNum;
end

-- ����������� ����. *������� ������� ������� ������� ������, �� ������ ������ ����� ��� ����������, �.�. ��������� ������ ����������� ���� � ������, � �� �� ���������� ����� �����. ��������. ���������� ������ ��� ��� ��������. Slava98. 28.02.14.
function func.Play(musfile, smoothBeginning, smoothEnd)
-- ���������� ������ (��������).

	if smoothBeginning ~= true then smoothBeginning = false; end;
	if smoothEnd ~= false then smoothEnd = true; end;
	local primordialVolume = conf.s_musicvolume;
	local isVoluming;
	local function ChangeVolume(k)
		if isVoluming or (k == -1 and not smoothEnd) or not main.music.isVoluming then return 0; end;
--		if (k == -1 and conf.s_musicvolume <= -9970) or (k == 1 and conf.s_musicvolume >= math.floor(primordialVolume/10)*10) then main.music.isVoluming = false; return 0; end;
		conf.s_musicvolume = conf.s_musicvolume + k*10;
		print(k, conf.s_musicvolume)
		pushcmd(function() ChangeVolume(k) end, 0.001)
		return math.abs(math.floor(primordialVolume/10)*10 + 9980)/10000;
	end;
	
	main.music.currentTrack = musfile;
	if main.music.isVoluming then isVoluming = true; end;
	main.music.isVoluming = true;
	local timer = ChangeVolume(-1);
	
	pushcmd(function()
		main.music.isVoluming = false;
		if smoothBeginning then pushcmd(function() main.music.isVoluming = true; ChangeVolume(1) end, 0.1) else conf.s_musicvolume = primordialVolume; end;
		music("..\\campaign\\War System\\music\\"..main.music.currentTrack..".ogg")
	end, timer)
end

function func.Play(musfile)
-- ���������� ������ (��������).

	main.music.currentTrack = musfile;
	music("..\\campaign\\War System\\music\\"..main.music.currentTrack..".ogg")
end

-- ����������� ����.
function func.Sound(musfile, obj)
-- ���������� ������ (��������).

	if not exists(const.playerVehName) then return; end; -- ���� ��� ������, �� �����, � ���������, �� �������������.
	obj = obj or const.playerVehName;
	play_sound(obj, "campaign\\War System\\sound\\"..musfile..".ogg")
end

-- ������ ������� ������. Slava98.
function func.MissionChange(a, i, text)
	if type(text) ~= "string" and text ~= nil then func.PrintError("bad argument #1 to 'func.MissionChange' (string expected, got "..type(tab)..")") return; end;
	if a == "main" then 
		func.dialog.mission_significance = func.Read({"main", "missions", 1}) 
		if text ~= nil then main.missions.mainMission = text; end;
	elseif a == "extra" then 
		func.dialog.mission_significance = func.Read({"main", "missions", 2})
		if text ~= nil then main.missions.extraMission = text; end;
	else func.PrintError("bad argument #1 to 'func.MissionChange' ('main' or 'extra' expected)") return;
	end;
	if i == "add" then
		func.Message(func.dialog.mission_significance..func.Read({"main", "missions", 3}))
	elseif i == "plus" then
		func.Message(func.dialog.mission_significance..func.Read({"main", "missions", 4}))
	elseif i == "complete" then
		func.Message(func.dialog.mission_significance..func.Read({"main", "missions", 5}))
	elseif i == "cancel" then
		func.Message(func.dialog.mission_significance..func.Read({"main", "missions", 6}))
	elseif i == "change" then
		func.Message(func.dialog.mission_significance..func.Read({"main", "missions", 7}))
	else func.PrintError("bad argument #2 to 'func.MissionChange' ('add', 'plus', 'complete', 'cancel' or 'change' expected)") return;
	end;
	if a == "main" then main.missions.mainMission = text;
	elseif a == "extra" then main.missions.extraMission = text;
	elseif text == nil then
	end;
	func.dialog.mission_significance = nil;
end

---------------------------------------------------------------------------------------------------------------------
------------------------------------------- ��������� ������� -------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

-- ���������� ��� ������� � ����, ������� � ����������.
function func.UniteTables(tab1, tab2)
-- ���������� ������ (��������).
	if type(tab1) ~= "table" then error("bad argument #1 to 'func.UniteTables' (table expected, got "..type(tab1)..")", 2) return; end;
	if type(tab2) ~= "table" then error("bad argument #2 to 'func.UniteTables' (table expected, got "..type(tab2)..")", 2) return; end;

	for i = 1, table.maxn(tab2) do
		table.insert(tab1, tab2[i])
	end;
	for k, v in pairs(tab2) do 
		tab1[k] = tab2[k];
	end;
	return tab1;
end

function func.CopyTable(tab)
-- ���������� ������ (��������).

	local ctab = {};
	for i = 1, table.maxn(tab) do
		ctab[i] = tab[i];
	end;
	for k, v in pairs(tab) do 
		ctab[k] = v;
	end;
	return ctab;
end

-- ���� ������� � �������. ���������� true ��� ����� �������� (���� ��� ������) ��� ����� ������, � false ��� �������. 
function func.Search(tab, searched)
-- ���������� ������ (��������).

	for i = 1, table.maxn(tab) do
		if tab[i] == searched then return i; end;
		if tab[i] == table.maxn(tab) then return false; end;
	end;
	for i, k in pairs(tab) do
		if i == searched then return true; end;
	end;
	return false;
end

function func.ToBoolean(value)
	if value then return true; else return false; end;
end

-- ���������� ���������� ��������� � �������. Slava98.
function func.ValueNumber(tab)
-- ���������� ������ (��������).
	
	local num = 0;
	for n, v in pairs(tab) do
		num = num + 1;
	end;
	return num;
end

-- ���� �������� �� �������� ��������, �� ���������� ������ �������.
function func.DoTable(tab)
-- ���������� ������ (��������).

	if type(tab) ~= "table" then return {}; else return tab; end;
end

-- ���������� ����� ������ ������������� �������� � �������. Slava98. 07.12.13.
function func.ArrayMax(array)
-- ���������� ������ (��������).

	local maxNum = array[1];
	local elementNum = 1;
	for i = 1, #array do
		if maxNum < array[i] then maxNum = array[i]; elementNum = i; end;
	end;
	return elementNum;
end

-- ���������� ����� ������ ������������ �������� � �������. Slava98. 07.12.13.
function func.ArrayMin(array)
-- ���������� ������ (��������).

	local minNum = array[1];
	local elementNum = 1;
	for i = 1, #array do
		if minNum > array[i] then minNum = array[i]; elementNum = i; end;
	end;
	return elementNum;
end

-- ���������� �������. � ������� ������ ���� ������� � ������� logic.

-- ���������� true ��� false ��������� �������. Slava98.
function func.RandomBoolean()
	if math.random(0, 1) == 1 then
		return true;
	else
		return false;
	end;
end

-- ���������� ������ ��� ������ �������� ��������� �������. Slava98.
function func.OrGate(firstValue, secondValue)
-- ���������� ������ (��������).

	if math.random(0, 1) == 1 then return firstValue;
	else return secondValue;
	end;
end

-- ������������ ������� ��������. Slava98.
function func.InvertBoolean(booVal)
-- ���������� ������ (��������).

	if booVal then return false; else return true; end;
end

function func.Condition(booVal, valIfTrue, valIfFalse)
-- ���������� ������� (��������).

	if booVal then return valIfTrue; else return valIfFalse; end;
end

-- ��������� ������� �������� �� ����������� ����� � ����������� ��������, ����� ����� ������������ � �������� �������. Slava98. 27.12.13.
function func.Recmd(funcTab, argsTab, timer, frequency)
-- ���������� ������ (��������).
	
	local allowTimer = true;
	if not funcTab.StartFunc and funcTab[1] then funcTab.StartFunc = funcTab[1]; end; -- ����� ����������� ������ �������� ������� ����� ������ ��������. Slava98. 05.01.14.
	if not funcTab.CircleFunc and funcTab[2] then funcTab.CircleFunc = funcTab[2]; end;
	if not funcTab.FinishFunc and funcTab[3] then funcTab.FinishFunc = funcTab[3]; end;
	local funcTab = func.UniteTables({
		StartFunc = function() end,
		CircleFunc = function() end,
		FinishFunc = function() end,
	}, funcTab)
	local argsTab = argsTab or {};
	for i = 1, 3 do argsTab[i] = argsTab[i] or {}; end;
	local function Loop()
		pushcmd(function() if allowTimer then local command = funcTab.CircleFunc(unpack(argsTab[2])); if command ~= "stop" then Loop() end; else funcTab.FinishFunc(unpack(argsTab[3])) end; end, frequency)
	end;
	funcTab.StartFunc(unpack(argsTab[1]))
	Loop()
	pushcmd(function() allowTimer = false; end, timer)
end

-- �������� ��������� ����� �������� �����. Slava98
function func.CheckOfLuck(luck)
-- ���������� ������ (��������).
	
	if not exists(const.playerName) then return true; end;
	if luck <= main.characters[const.playerName].ruleset.luck then
		return true;
	else
		return false;
	end;
end

-- ��������� ������� �������������� ������� � ������ (��������� ������). Slava98.
function func.ObjectCopy(obj)
-- ���������� ������ (��������).

	if exists(obj) then 
		local link = object(obj);
		local tab = {};
		if objtype(obj) ~= "ai" and objtype(obj) ~= "player_local" then tab.x, tab.y = position(obj);  end;
		tab.type = objtype(obj);
		tab.link = func.PropertiesToTable(link);
		return tab;
	else
--ERROR!
	end;
end

-- ��������������� ����������� � ���������� � ������� �������, � ������� ����� �������� ���. Slava98.
function func.PropertiesToTable(metatable)
-- ���������� ������ (��������).

	local a = getmetatable(metatable);
	local propTab = {};
	local prop = "name";
	while prop ~= nil do
		rawset(propTab, prop, a.__index(metatable, prop))
		prop = a.__next(metatable, prop);
	end;
	return propTab;
end

-- ��������� �� ������������ �������, ���������� �������� func.Remember ���������� ������ (��������� ������). Slava98.
function func.ObjectPaste(tab, name, x, y) --name, x, y ���� �� ��������. Slava98. 28.05.13.
-- ���������� ������ (��������).

	tab.link.name = name or tab.link.name;
	tab.x = x or tab.x;
	tab.y = y or tab.y;
	if tab.type ~= "ai" and tab.type ~= "player_local" then 
		actor(tab.type, tab.x, tab.y, tab.link)
	else
		service(tab.type, tab.link)
	end;
end

-- ������ ���������. Slava98.
function func.SolveEquation(eqTab, minX, maxX, minY, maxY) -- {{"x+y", "5"}, {"x-y", "2"}}
-- ���������� ������ (��������).

-- ���������� ��������� ����������.
	local minX = minX or -1000;
	local maxX = maxX or  1000;
	local minY = minY or -1000;
	local maxY = maxY or  1000;
	local eqFuncTab = {};

	for i = 1, #eqTab do
		local eqFunc1;
		local eqFunc2;
		assert(loadstring("function eqFunc1() return "..eqTab[i][1].."; end"))()
		assert(loadstring("function eqFunc2() return "..eqTab[i][2].."; end"))()
		eqFuncTab[i][1] = eqFunc1();
		eqFuncTab[i][2] = eqFunc2();
	end;

	for x = minX, maxX do
		for y = minY, maxY do -- ����� ������ ������� � ��� y. ����� ������� ������������� z.
			local cStr;
			for i = 1, #eqFuncTab do
				if i == 1 then cStr = "if eqFuncTab["..i.."][1] == eqFuncTab["..i.."][2]";
				else cStr = cStr.." and eqFuncTab["..i.."][1] == eqFuncTab["..i.."][2]";
				end;
				if i == #eqFuncTab then cStr = cStr.."then print('x = '..x..'; y = '..y) end;"; end;
			end
			assert(loadstring(cStr))()
		end;
	end;
end

---------------------------------------------------------------------------------------------------------------------
-------------------------------------------- ��������� ������ -------------------------------------------------------
----------------------------------- (���������� �� ������������� ����) ---------------------------------------------

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
--				val.a[i][values[val_num]] = text; -- ������� �������. Slava98. 13.09.13.
				if val_num ~= 4 then val_num = val_num + 1 else char = "" end
				text = ""
			end
		end
	end
	return val
end

---------------------------------------------------------------------------------------------------------------------
------------------------------------------------- ���� --------------------------------------------------------------
----------------------------------- (���������� �� ������������� ����) ---------------------------------------------

function func.ZoneLoop(zone)
	for i = 1, table.maxn(main.NPC.list) do
		for x = rawget(level.zones, zone)[1][1], rawget(level.zones, zone)[2][1] do
			for y = rawget(level.zones, zone)[1][2], rawget(level.zones, zone)[2][2] do
				
			end
		end
	end
end


function func.CoordRectangleFix(coords1, coords2)
-- �������� ��������� ���������� ��� ����, ����� ������� ��������� ��������.
	coords1.x = coords1[1]; coords1.y = coords1[2];
	coords2.x = coords2[1]; coords2.y = coords2[2];
	
-- ���������� ������.
	if type(coords1) ~= "table" then error("bad argument #1 to 'func.CoordRectangleFix' (table expected, got "..type(coords1)..")") return; end
	if type(coords2) ~= "table" then error("bad argument #2 to 'func.CoordRectangleFix' (table expected, got "..type(coords2)..")") return; end
	if type(coords1.x) ~= "number" then error("bad variable #1 in argument #1 to 'func.CoordRectangleFix' (number expected, got "..type(coords1.x)..")", 2) return; end
	if type(coords1.y) ~= "number" then error("bad variable #2 in argument #1 to 'func.CoordRectangleFix' (number expected, got "..type(coords1.y)..")", 2) return; end
	if type(coords2.x) ~= "number" then error("bad variable #1 in argument #2 to 'func.CoordRectangleFix' (number expected, got "..type(coords2.x)..")", 2) return; end
	if type(coords2.y) ~= "number" then error("bad variable #2 in argument #2 to 'func.CoordRectangleFix' (number expected, got "..type(coords2.y)..")", 2) return; end
	
	if coords2.x > coords1.x and coords2.y > coords1.y then return {coords1, coords2}; -- ���������� �������.
	elseif coords2.x < coords1.x and coords2.y < coords1.y then return {coords2, coords1}; -- new-new_coords = {coords2, coords1}...
	elseif coords2.x < coords1.x and coords2.y > coords1.y then new_coords1 = {coords1.x, coords2,y}; new_coords2 = {coords2.x, coords1,y} return {new_coords1, new_coords2};
	elseif coords2.x > coords1.x and coords2.y < coords1.y then new_coords1 = {coords2.x, coords1,y}; new_coords2 = {coords1.x, coords2,y} return {new_coords1, new_coords2};
	end
end

--------------------------------------------------------------------------------------------------------------------
------------------------------------------- �������������� ���� -----------------------------------------------------
----------------------------------- (���������� �� ������������� ����) ---------------------------------------------

function func.tank.ExtraDamage(attacker, prey)
	if attacker ~= nil and objtype(attacker.name) == "tank" then
		local damageValue = rawget(
		rawget(main.characters, object(attacker.name).playername).weapons, 
		rawget(main.characters, object(attacker.name).playername).current_weapon).damage;
		if damageValue ~= nil and object(prey).health > damageValue then damage(damageValue, prey) end;
	end;
end

-------------------------------------------

-- ����� ������ �������. Slava98.
function func.Test()
	
end

function func.UnsetTempValues(mode)
	if mode ~= 1 then temp = {}, pushcmd(function() func.UnsetTempValues() end, 0.2) end
end

function debug.Print(text, textType)
		if textType == "main" or not textType and debug.showMainMessages then print(text);
	elseif textType == "way" and debug.showWayMessages then print(text);
	elseif textType == "way_short" and debug.showWayShortMessages then print(text);
	elseif textType == "attack" and debug.showAttackMessages then print(text);
	end;
end
