level.warriors = {list={"ourwarrior1", "ourwarrior2", "ourwarrior3", "ourwarrior4"}}
level.damagespeak = {}
--func.NPC.friends.ourwarrior1.text =

for i = 1, 4 do
	rawset(level.damagespeak, rawget(level.warriors.list, i), {"Поселенец: Эй! Не стреляй по своим!!", "Поселенец: Ты что не понял?! Не стреляй по поселенцем!!!", "Поселенец: Последнее предупреждение! Хватит стрелять по своим!!!", "Командир поселенцев: Он предатель, бей его!"})
end

function level.LetDamageOurWarrior(num)
	for i = 1, 2 do
        if num == nil then
                return 0
        elseif num == 0 then
                pset("ourwarrior"..i.."_tank", "on_damage", "")
				pset("ourwarrior"..i.."_tank", "on_damage", "level.OurWarriorsAttackPlayer()")
        elseif num == 1 then
                pset("ourwarrior"..i.."_tank", "on_damage", "func.NPC.DamageOurWarrior(who, 'ourwarrior"..i.."')")
        end
	end
end

function level.OurWarriorsAttackPlayer(npc)
	object("ourplayer").team = 3
	for i = 1, 2 do
		if exists("ourwarrior"..i.."_tank") then 
			object("ourwarrior"..i).active = 1 
			object("ourwarrior"..i.."_tank").on_damage = ""
		end
--		if npc == "ourwarrior"..i then
--			object("ourwarrior"..i).active = 1
--		end
	end
end

function level.OnDie(name)
	for i = 1, 2 do
		if name == "ourwarrior"..i then kill(name) end
	end	
end
