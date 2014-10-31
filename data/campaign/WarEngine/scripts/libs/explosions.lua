objects.Init()
engine.Require("rigidbody", "classes")
engine.Require("trigger", "classes")

-- Взрыв. Основана на макросе hmh.
-- pos - позиция взрыва
-- period - время между взрывами
-- number - количество взрываов
-- dmg - дополнительный урон от взрыва
function func.Explosion(pos, number, period, dmg)
	checktype({pos, speed, times, dmg}, {{"number"}, "number+nil", "number+nil", "number+nil"}, "func.Explosion");

	local x, y = pos[1], pos[2];
	number = number or 1;
	period = period or 0;
	dmg = dmg or 1000;
	for expNum = 0, number - 1 do
		pushcmd(function()
			local obj = UserObject(x, y);
			obj.setVisibility(true)
			obj.damage(100)
			if dmg then
				local trig1 = Trigger(x, y, {on_enter="damage("..dam..", who.name)",
									   only_human=0,
									   radius=2,
									   only_visible=0});
				local trig2 = Trigger(x, y, {on_enter="damage("..dam.."/2, who.name)",
									   only_human=0,
									   radius=3,
									   only_visible=0});
				local trig3 = Trigger(x, y, {on_enter="damage("..dam.."/5, who.name)",
									   only_human=0,
									   radius=4,
									   only_visible=0});
				trig1.setVisibility(true)
				trig2.setVisibility(true)
				trig3.setVisibility(true)
				pushcmd(function()
					trig1.setVisibility(false)
					trig2.setVisibility(false)
					trig3.setVisibility(false)
				end, 0.1)
			end;
		end, expNum*period)
	end;
end