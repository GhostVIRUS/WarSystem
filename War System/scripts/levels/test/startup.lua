dofile(main.scrDir.."/dialogs/test.lua")
func.player.Create("player1", "ekivatorl", 1, 2, 670, 240, 3.14159)
func.NPC.Create("ourwarrior", 1, "Поселенец", "ekivator1", "ekivatorl", 1, "weap_autocannon", 1, 1)
func.NPC.Create("ourwarrior", 2, "Халос", "ekivator1", "ekivatorl", 1, "weap_cannon", 1, 3)
func.NPC.SetAction("ourwarrior1", 14, 3, 3, 14, true)
func.dialog.Show("slava98", "test", 1, "", "func.dialog.Show('slava98', 'test', 2, '', '', 'OK')", "OK")
pushcmd(function() 
					func.NPC.Action("ourwarrior1") 
					func.NPC.SetBorderTrigger("ourwarrior2", "level.CommSpeak(0, 1)", 4, 2)
					level.LetDamageOurWarrior(1)
					local tanks = {"ourplayer_tank", "ourwarrior1_tank", "ourwarrior2_tank"}
					for i = 1, 3 do func.animskin.Create("skin/ekivatorl", rawget(tanks, i)) end
					--
					func.Move("beton2",  11, 7,  "grid", 20) 
					func.Move("beton4",  11, 9,  "grid", 20) 
					func.Move("beton0",  13, 7,  "grid", 20) 
					func.Move("beton-2", 13, 9,  "grid", 20) 
					
end, 2)
pushcmd(function()
	message("А вот и ночь!") -- =( Slava98.
	conf.sv_nightmode = true 
	func.SetDirFollowObject("pb1", "crate4", 		 0.001)
	func.SetDirFollowObject("pb2", "crate3", 		 0.001)
	func.SetDirFollowObject("pb3", "crate2", 		 0.001)
	func.SetDirFollowObject("pb4", "crate1",         0.001)
	func.SetDirFollowObject("pt1", "ourplayer_tank", 0.001)
	func.SetDirFollowObject("pt2", "ourplayer_tank", 0.001)
	func.SetDirFollowObject("pt3", "ourplayer_tank", 0.001)
end, 15)