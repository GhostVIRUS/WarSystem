level.screenplay = {
	sidedoor_status = 2, --Боковая дверь: 0 - закрыто, 1 - открыто, 2 - совсем закрыто, 3 - заглючило
	sidedoor_close = false,
	settlers_are_enemies = false,
	energycells = 0,
	enemyattack = false,
	was_enemyattack = false,
	angrywarriors = false,
	damagedStatue = false,
	missionboo = 0,
	missionplate = 0,
	enemy_in_settle = 0,
	settle_enemy = "",
}
level.NPC = { }
	
dofile(main.scrDir.."/dialogs/map01.lua")
for i = 1, 2 do func.Timer(1, i) end --Бранируем ячейки для таймера
func.MissionChange("main", "add", func.dialog.Read("missions", "map01", 1))
func.player.Create("player1", "ekivatorl", 1, 2, 80, 80, 0.785398)
func.NPC.Create("ourwarrior", 1, "Поселенец", "ekivator1", "ekivatorl", 1, "weap_cannon", 1, 5, 992, 160, 0.785398)
func.NPC.Create("ourwarrior", 2, "Поселенец", "ekivator1", "ekivatorl", 1, "weap_cannon", 1, 4, 1568, 64, 0.785398)
func.NPC.Create("ourwarrior", 3, "Командир поселения", "ekivator1", "ekivatorl_camo", 1, "weap_minigun", 1, 3, 2224, 64, 3.14159)
func.NPC.Create("ourwarrior", 4, "Поселенец", "ekivator1", "ekivatorl_camo", 1, "weap_autocannon", 1, 5, 1216, 352, 5.49773)
func.NPC.SetAction("ourwarrior1", 29, 12, 41, 11, true)
func.NPC.SetAction("ourwarrior2", 54, 12, 65, 20, true)
func.NPC.SetAction("ourwarrior4", 36, 18, 50, 3, true)
main.characters.ourplayer.weapons = {weap_autocannon = {damage = 5},
									 weap_minigun = {damage = 10}}
--Пока отключу, а то раздражает. Slava98.
--func.dialog.Show("welcome", "map01", 1, "", "func.dialog.Show('welcome', 'map01', 2, '', '', 'OK')", "OK")
actor("trigger", 656, 256, {name="hint_trig1", only_human=1, radius=4, active=1, on_enter="func.Message('promt','map01', 1); kill(self)"})
actor("trigger", 304, 1168, {name="hint_trig2", only_human=1, radius=1, active=1, on_enter="func.Message('promt','map01', 4); kill(self)"})
actor("trigger", 304, 975, {name="hint_trig3", only_human=1, radius=3, active=1, on_enter="func.Message('promt','map01', 5); kill(self)"})
actor("trigger", 225, 1085, {name="hint_trig4", only_human=1, radius=10, active=1, on_enter="func.Message('promt','map01', 6); kill(self)"})
actor("trigger", 2012, 2012, {name="hint_trig5", only_human=1, radius=3, active=1, on_enter="func.Message('promt','map01', 7); kill(self)"})
actor("trigger", 1534, 2200, {name="hint_trig6", only_human=1, radius=2, active=1, on_enter="func.Message('promt','map01', 8); kill(self)"})
actor("trigger", 765, 2233, {name="hint_trig7", only_human=1, radius=5, active=1, on_enter="func.Message('promt','map01', 9); kill(self)"})
actor("trigger", 848, 416, {name="d_trig", only_human=1, radius=1, active=1, on_enter="level.CallTerminal('speak')"})
actor("trigger", 880, 544, {name="sidedoor_trig", only_human=1, radius=4, active=1, only_visible=0, on_enter="level.Door('sidedoor_open')", on_leave="level.Door('sidedoor_close')"})
--actor("trigger", 912, 544, {name="sidedoor_lag_trig", only_human=1, radius=2, active=0, only_visible=1, on_enter="message('Похоже дверь заглючило. Странно. Я займусь ею, сообщите коммандиру, пожалуйста.') pset('c_trig', 'active', 1) kill('sidedoor_lag_trig')"})
--actor("trigger", 880, 544, {name="open_trig", only_human=1, radius=4, active=1, on_enter="level.Door('sidedoor_open')"})
--actor("trigger", 896, 544, {name="close_trig", only_human=1, radius=5, active=0, on_enter="level.Door('sidedoor_close')"})
--actor("trigger", 1136, 555, {name="enemyinsettle_trig", only_human=0, radius=32, radius_delta=20, active=1, only_visible=1, on_enter="if who~=nil and object(who.playername).team~=1 and level.screenplay.enemy_in_settle==0 then level.screenplay.enemy_in_settle=1;level.screenplay.settle_enemy = who.name; level.WarriorsSetActive(1); level.LetDamageOurWarrior(0) end", on_leave="if who~=nil and object(who.playername).team~=1 and level.screenplay.enemy_in_settle==1 then level.screenplay.enemy_in_settle=0;level.WarriorsSetActive(0); level.LetDamageOurWarrior(1) end"})
actor("trigger", 1550, 105, {name="is_ourwarrior_in_settle_trig", only_human=0, radius=20, active=1, only_visible=0, on_enter="for i=1,4 do if object(who.playername)=='ourwarrior'..i then func.NPC.friends.ourwarrior'..i..'.is_in_settle=1 end end", on_leave="for i=1,4 do if who~=nil and object(who.playername)=='ourwarrior'..i then func.NPC.friends.ourwarrior'..i..'.is_in_settle=0 end end"})
actor("trigger", 2140, 65, {name="c_trig", only_human=1, radius=3, active=0, on_enter="level.CommSpeak(0, 1)"})
actor("trigger", 656, 240, {name="plazma_trig", only_human=1, radius=2, active=0, on_enter="level.Door('plazmadoor_open'); kill(self)"})
actor("trigger", 560, 177, {name="plazmaexit_trig", only_human=1, radius=2, active=0, on_enter="level.Door('plazmadoor_close'); kill(self)"})
actor("trigger", 770, 1390, {name="boodoor_trig", only_human=1, radius=6, active=1, only_visible=0, on_enter="level.Door('boodoor_open')"})
actor("trigger", 734, 1384, {name="hiddenturret_trig", only_human=1, radius=1, active=1, only_visible=1, on_enter="level.HiddenTurretActivate()"})
--actor("trigger", 256, 960, {name="boo_trig1", only_human=1, radius=1, active=1, on_enter="level.GetBoo(1)"})
actor("trigger", 750, 1387, {name="boo_trig3", only_human=1, radius=1, active=1, on_enter="level.GetBoo(3)"})
actor("trigger", 1437, 2200, {name="boo_trig4", only_human=1, radius=1, active=1, on_enter="level.GetBoo(4)"})
actor("trigger", 638, 2494, {name="boo_trig5", only_human=1, radius=1, active=1, on_enter="level.GetBoo(5); object('old_turret').team = 2; func.Message('map01', 'promt', 10)"})
for i = 1, 3 do
	service ("ai", {name = "esc"..i, skin = "eskavator" } ) --Сажаем бота, чтобы сменить скин.
	pset("esc"..i, "vehname", "esc_tank"..i) --Без pset тут не обойтись
	object("esc_tank"..i).playername = "esc"..i
	object("esc_tank"..i).skin = "eskavator"
	object("esc_tank"..i).playername = ""
	pset("esc_tank"..i, "on_damage", "level.Statue('damage'); for i=1,3 do pset('esc_tank'..i, 'on_damage', '') end;pset('statue_tank','on_damage','')")
	kill("esc"..i) --"Я тебя порадил, я тебя и убью!"
	pset("esc_tank"..i, "on_damage", "level.Statue('damage'); for i=1,3 do pset('esc_tank'..i, 'on_damage', '') end;pset('statue_tank','on_damage','')")
end
local statue = service ("ai", {name = "statue", skin = "rebel_camouflage" } ) --Сажаем бота, чтобы сменить скин.
statue.vehname = "statue_tank" --Если сменять скин не с помощью бота, то игра вылетает
object("statue_tank").playername = "statue"
object("statue_tank").skin = "rebel_camouflage"
actor("weap_rockets", 0, 0, {name="statue_weap"})
equip("statue_tank", "statue_weap")
object("statue_tank").playername = ""
kill("statue") --"Я тебя порадил, я тебя и убью!"
pushcmd(function() 
					func.NPC.Action("ourwarrior1") 
					func.NPC.Action("ourwarrior2") 
					func.NPC.Action("ourwarrior4") 
--					func.NPC.SetBorderTrigger("ourwarrior3", "level.CommSpeak(0, 1)", 4, 2)
					level.LetDamageOurWarrior(1)
--					level.IsSettleEnemyDead()
--					level.IsEnemyInSettle()
					pset("ourwarrior3_tank", "on_damage", pget("ourwarrior3_tank", "on_damage").."; if who == nil then level.CrazyHalos() end")
					local tanks = {"ourwarrior1_tank", "ourwarrior2_tank"}
					for i = 1, 2 do func.animskin.Create("skin/ekivatorl", rawget(tanks, i)) end
					func.animskin.Create("skin/player", "ourplayer_tank")
					level.ShowBoo(750, 1385, 3)
					level.ShowBoo(1437, 2200, 4)
					level.ShowBoo(638, 2494, 5)
end, 2)