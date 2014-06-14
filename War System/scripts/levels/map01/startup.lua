
--Присваиваем значения переменным.
level.screenplay = {
--	energyCells = 0, -- Количество батарей. Устаревшая переменная.
	isEnemyAttack = false, -- Происходит ли в данный момент ли атака врагов. Не используется.
	wasEnemyAttack = false, -- Произошла ли атака врагов.
	statueIsDamaged = false, -- Повреждена ли статуя или её эскаваторы.
	missionBoo = 0, -- Этап задания про батареи: 0 - не дано, 1 - дано, 2 - выполнено, 3 - остался ещё один бустер, 4 - всё достато.
	missionKey = 0, -- Этап задания про спутниковую тарелку: 0 - не дано, 1 - дано, 2 - взята карта, 3 - выполнено.
	enemyInSettle = 0, -- Есть ли враг в поселении. Не используется.
	keyIsGot = false, -- Взят ли ключ поселенцем. *Не думаю, что сейчас это актуально. Slava98. 04.01.14.
	oldTurretIsActive = false, -- Будет ли старая ракетница активизироваться при дамаге.
	ruinGeneratorIsActive = true; -- Работает ли старый генератор энергии.
	eskavatorDropedBomb = false, -- Выпала ли бомба с одного из эскаваторов.
	halosWasSpoke = false, -- Поговорил ли игрок с Халосом.
	halosKnowsAboutDoor = false, -- Знает ли Халос о том, что дверь заглючило.
	halosHasGotBoo = false, -- Отдали ли мы Халосу 4 батареи.
	playerKnowsAboutTerminal = false, -- Видел ли игрок описание терминала.
	playerCanRideToSettle = false, -- Может ли игрок заехать в поселение.
	ourwarrior5WasTalked = false, -- Поговорил ли игрок с Раноном.
	ranonIsNearSettle = false, -- Находится ли Ранон около поселения.
	playerMustPressPassword = false, -- Должен ли игрок ввести пароль (после диалога Ранона с поселенцем).
	banditsAttackedPlayer = false, -- Атаковали ли бандиты игрока.
	ranonAttackedBandits = false, -- Атаковал ли Ранон бандитов.
};
level.functions = {
	sidedoorStatus = 4, -- Боковая дверь: 0 - закрыто, 1 - открыто, 2 - открывается, 3 - закрывается, 4 - опечатано.
	tanksNearSettleNum = 0, -- Количество танков первой команды у поселения.
	silentSidedoor = false, -- Бесшумная ли дверь в поселение.
	esc1BlewUp = false; -- Взорвался ли первый экскаватор.
	esc2BlewUp = false; -- Взорвался ли второй экскаватор.
	esc3BlewUp = false; -- Взорвался ли третий экскаватор.
	settleEnemy = "", -- Имя врага поселения. Не используется и вообще лучше использовать надо было массив, наверное.
	settlersAreEnemies = false, -- Враждебно ли относятся к игроку поселенцы.
	settlersNearSettleNum = 0, -- Число поселенцев у входа в поселение.
};
level.objects = {};
level.zones = {
	settle = {{1, 1}, {5, 5}}, -- Координаты зоны. Не используются. Заморожено.
};
level.talk = {
	settlersTalkPart = 0,
};

-- Slava98.

level.attackSpeaks = {
	ourwarriorsBeforeCommSpeak = {
		onBeginAttack = {},
		onLoopAttack = {},
		onStopAttack = {},
	},
	ourwarriorsBeforeFinishOfMissonBoo = {},
	ourwarriorsAfterAttack = {},
	halos = {},
	bandits = {},
};

-- Запоминаем объекты, которые потом будем убирать и возвращать обратно. Slava98. 28.05.13.
level.objects.saron1 = func.ObjectCopy("saron1");
level.objects.a1 = func.ObjectCopy("a1");
level.objects.a2 = func.ObjectCopy("a2");
level.objects.a3 = func.ObjectCopy("a3");
	
dofile(const.scrDir.."/dialogs/map01.lua")
func.MissionChange("main", "add", func.Read({"map01", "missions", 1}))

local settlersAttackSpeaks = {onBegin="settler_onBeginAttack", onLoop="settler_onLoopAttack", onStopDestroyed="settler_onStopAttackDestroyed", onStopLost="settler_onStopAttackLost", file="map01", loopInterval=10}
func.NPC.Create("ourwarrior1", 992, 160, 0.785398, 1, 5, {class="ekivator1"}, {faction="uew", rank=2, group="settlers", currentWeap="weap_cannon"}, {mainWay="base_patrol1", attackSpeaks=settlersAttackSpeaks})
func.NPC.Create("ourwarrior2", 2016, 107, 0.785398, 1, 4, {class="ekivator1"}, {faction="uew", rank=2, group="settlers", currentWeap="weap_cannon"}, {mainWay="base_patrol2", attackSpeaks=settlersAttackSpeaks})
func.NPC.Create("ourwarrior3", 2224, 64, 3.14159, 1, 3, {class="ekivator1"}, {faction="uew", rank=4, group="settlers", currentWeap="weap_minigun"}, {mainWay="halos", attackSpeaks=settlersAttackSpeaks})
func.NPC.Create("ourwarrior4", 1216, 352, 5.49773, 1, 5, {class="ekivator1"}, {faction="uew", rank=3, group="settlers", currentWeap="weap_autocannon"}, {mainWay="base_patrol4", attackSpeaks=settlersAttackSpeaks})
func.NPC.Create("ourwarrior5", 149, 1649, 1.5708, 1, 1, {class="ekivator1"}, {faction="uew", rank=3, currentWeap="weap_autocannon"}, {attackSpeaks=settlersAttackSpeaks})
func.way.Create("base_patrol1", {{29, 12}, {41, 11}}, true, {isCicle=true})
func.way.Create("base_patrol2", {{55, 3}, {59, 18}}, true, {isCicle=true})
func.way.Create("base_patrol4", {{36, 18}, {53, 3}}, true, {isCicle=true})
func.way.Create("settler_call", {{976, 528}, {955, 540}}, false, {onEnterFunc="level.SettlerSpeak(1); level.ways['settler_call'].active = false"})
func.way.Create("settler_return", {{74, 23}, {58, 32}, {43, 32}, {29, 31}, {26, 18}}, true, {onEnterFunc="local function RideToSettle() func.NPC.SetAim(who.playername, 31, 18, true, {on_enter='local npcTab = main.NPC.list[who.playername]; func.NPC.FollowWay(who.playername, main.NPC.list[who.playername].mainWay)'}) end; if level.functions.sidedoorStatus == 0 then level.Door('sidedoor_open', level.functions.silentSidedoor); pushcmd(function() RideToSettle() end, 3); elseif level.functions.sidedoorStatus == 1 then RideToSettle() elseif level.functions.sidedoorStatus == 2 then pushcmd(function() RideToSettle() end, 3) elseif level.functions.sidedoorStatus == 3 then pushcmd(function() level.Door('sidedoor_open', level.functions.silentSidedoor); pushcmd(function() RideToSettle() end, 3); end, 3) end", shortcut=true})
func.way.Create("halos", {{976, 560}, {1328, 560}, {1808, 528}, {1904, 144}, {1136, 272}, {1328, 272}, {2160, 60}, --[[{2224, 64}]]}, false, {})
main.NPC.list["ourwarrior1"].mainWay = "base_patrol1"; 
main.NPC.list["ourwarrior2"].mainWay = "base_patrol2"; 
main.NPC.list["ourwarrior3"].mainWay = "halos"; 
main.NPC.list["ourwarrior4"].mainWay = "base_patrol4"; 
func.GiveItem("healthpack", "ourwarrior1")
func.GiveItem("healthpack", "ourwarrior2")
func.GiveItem("superhealthpack", "ourwarrior3")
func.GiveItem("healthpack", "ourwarrior4", 2)
func.GiveItem("healthpack", "ourwarrior5", 3)
func.GiveItem("boo", "ourwarrior3", 2)
func.GiveItem("boo", "ourwarrior4")

func.NPC.Create("statue", 240, 944, 0, 2, 2, {skin="rebel_camouflage", class="default"}, {faction="cypher", rank=2,  group="statue", currentWeap="weap_rockets"}, {enemyDetectMode=false, revengeToAttacker=false, pursueEnemy=false})
func.GiveItem("battery", "statue")

--Пока отключу, а то раздражает. Slava98.
--func.dialog.Show("welcome", "map01", 1, "", "func.dialog.Show('welcome', 'map01', 2, '', '', 'OK')", "OK")

--Далее создаём различные триггеры.
actor("trigger", 656, 256, {name="hint_trig1", only_human=1, radius=4, active=1, on_enter="func.Message({'map01', 'promt', 1}); kill(self)"})
actor("trigger", 304, 1168, {name="hint_trig2", only_human=1, radius=1, active=1, on_enter="func.Message({'map01', 'promt', 4}); kill(self)"})
actor("trigger", 304, 975, {name="hint_trig3", only_human=1, radius=3, active=1, on_enter="func.Message({'map01', 'promt', 5}); kill(self)"})
actor("trigger", 225, 1085, {name="hint_trig4", only_human=1, radius=10, active=1, on_enter="if exists('statue_tank') then func.Message({'map01', 'promt', 6}); end; kill(self)"})
actor("trigger", 2012, 2012, {name="hint_trig5", only_human=1, radius=10, active=1, on_enter="if not exists('bandit1') and not exists('bandit2') then func.Message({'map01', 'promt', 7}); end; kill(self)"})
actor("trigger", 1534, 2200, {name="hint_trig6", only_human=1, radius=2, active=1, on_enter="func.Message({'map01', 'promt', 8}); kill(self)"})
actor("trigger", 765, 2233, {name="hint_trig7", only_human=1, radius=5, active=1, on_enter="func.Message({'map01', 'promt', 9}); kill(self)"})
actor("trigger", 530, 400, {name="hint_trig8", only_human=1, radius=5, active=1, on_enter="func.Message({'map01', 'promt', 11}); kill(self)"})
actor("trigger", 2186, 1069, {name="hint_trig9", only_human=1, radius=5, active=1, on_enter="func.Message({'map01', 'promt', 12}); kill(self)"})
actor("trigger", 325, 2139, {name="hint_trig10", only_human=1, radius=5, active=1, on_enter="func.Message({'map01', 'promt', 14}); kill(self)"})
actor("trigger", 848, 416, {name="d_trig", only_human=1, radius=1, active=1, on_enter="level.TerminalSpeak('settle', 'call')"})
actor("trigger", 880, 544, {name="sidedoor_trig", radius=4, active=1, only_visible=0, on_enter="if object(who.playername).team == 1 then level.functions.tanksNearSettleNum = level.functions.tanksNearSettleNum + 1; if level.functions.sidedoorStatus ~= 2 and level.functions.sidedoorStatus ~= 3 and level.functions.sidedoorStatus ~= 4 then level.Door('sidedoor_open', level.functions.silentSidedoor); end; end", on_leave="if object(who.playername).team == 1 then level.functions.tanksNearSettleNum = level.functions.tanksNearSettleNum - 1; if level.functions.tanksNearSettleNum < 1 and level.functions.sidedoorStatus ~= 2 and level.functions.sidedoorStatus ~= 3 and level.functions.sidedoorStatus ~= 4 then level.Door('sidedoor_close', level.functions.silentSidedoor); end; end"})
--actor("trigger", 912, 544, {name="sidedoor_lag_trig", only_human=1, radius=2, active=0, only_visible=1, on_enter="message('Похоже дверь заглючило. Странно. Я займусь ею, сообщите коммандиру, пожалуйста.') pset('c_trig', 'active', 1) kill('sidedoor_lag_trig')"})
--actor("trigger", 880, 544, {name="open_trig", only_human=1, radius=4, active=1, on_enter="level.Door('sidedoor_open')"})
--actor("trigger", 896, 544, {name="close_trig", only_human=1, radius=5, active=0, on_enter="level.Door('sidedoor_close')"})
--actor("trigger", 1136, 555, {name="enemyinsettle_trig", only_human=0, radius=32, radius_delta=20, active=1, only_visible=1, on_enter="if who~=nil and object(who.playername).team~=1 and level.screenplay.enemyInSettle==0 then level.screenplay.enemyInSettle=1;level.screenplay.settleEnemy = who.name; level.WarriorsSetActive(1); level.LetDamageOurWarrior(0) end", on_leave="if who~=nil and object(who.playername).team~=1 and level.screenplay.enemyInSettle==1 then level.screenplay.enemyInSettle=0;level.WarriorsSetActive(0); level.LetDamageOurWarrior(1) end"})
--actor("trigger", 1550, 105, {name="is_ourwarrior_in_settle_trig", only_human=0, radius=20, active=1, only_visible=0, on_enter="for i=1,4 do if object(who.playername)=='ourwarrior'..i then func.NPC.friends.ourwarrior'..i..'.is_in_settle=1 end end", on_leave="for i=1,4 do if who~=nil and object(who.playername)=='ourwarrior'..i then func.NPC.friends.ourwarrior'..i..'.is_in_settle=0 end end"})
actor("trigger", 2140, 65, {name="c_trig", only_human=1, radius=3, active=0, on_enter="level.CommSpeak(0, 1)"})
actor("trigger", 656, 240, {name="plazma_trig", only_human=1, radius=2, active=0, on_enter="level.Door('plazmadoor_open'); kill(self)"})
actor("trigger", 560, 177, {name="plazmaexit_trig", only_human=1, radius=2, active=0, on_enter="level.Door('plazmadoor_close'); kill(self)"})
actor("trigger", 770, 1390, {name="boodoor_trig", only_human=1, radius=6, active=1, only_visible=0, on_enter="level.Door('boodoor_open')"})
actor("trigger", 256, 900, {name="excstare_trig", only_human=1, only_visible=0; radius=10, active=1, on_enter="for i = 1, 3 do local x1, y1 = position('esc'..i..'_tank'); local x2, y2 = position(const.playerVehName); local timer = func.object.SetRotation('esc'..i..'_tank', func.GetRadians(x1, y1, x2, y2), 100); pushcmd(function() level.screenplay.excavatorsCanStare = true; level.screenplay.Statue('stare_on_player', i) end, timer + 0.1); end", on_leave="level.screenplay.excavatorsCanStare = false"})
actor("trigger", 734, 1384, {name="hiddenturret_trig", only_human=1, radius=1, active=1, only_visible=1, on_enter="level.HiddenTurretActivate(); kill(self)"})
actor("trigger", 624, 1688, {name="settlerkey_trig", only_human=1, radius=10, active=1, on_enter="level.screenplay.SettlerGetKey('call')"})
actor("trigger", 2200, 1000, {name="settler_near_ruins_trig", only_human=1, radius=10, active=1, on_enter="if not level.screenplay.playerCanRideToSettle then level.screenplay.SettlerNearRuins('call') end"})
actor("trigger", 2098, 69, {name="change_halos_name_trig", only_human=1, radius=2, active=1, on_enter="object('ourwarrior3').nick = func.Read({'map01', 'nicks', 2}); kill(self)"})
actor("trigger", 1998, 1703, {name="teleport_ranon_trig1", only_human=1, radius=10, active=1, on_enter="setposition('ourwarrior5_tank', 72, 586); object(self).active=0;"})
actor("trigger", 799, 544, {name="settler_is_out_settle_trig", radius=3, active=1, on_enter="for i = 1, 4 do if object(who).playername == 'ourwarrior'..i then local npcTab = main.NPC.list[object(who).playername]; npcTab.currentWay = 'settler_return'; end; end"})

pushcmd(function() 
	func.player.Create({class="player1", skin="ekivatorl", nick=func.Read({"map01", "nicks", 6})}, 1, 3, 80, 80, 0.785398, {faction="uew", rank=3}) --Только теперь создаём игрока.
	func.NPC.Create("esc1", 160, 992, 6, 2, 2, {skin="eskavator", class="default"}, {faction="cypher", rank=1, group="statue", vehType="excavator"}, {detectRadius=15, detectRadiusDelta=16, enemyDetectMode=false, pursueEnemy=false, onComming="if who~=nil and not level.functions['esc1BlewUp'] and object(who.playername).team~=object('esc1').team then level.screenplay.Statue('creeper_boom', 1) end;", attackMode="goto_aim", healthToHeal=-1})
	func.NPC.Create("esc2", 224, 1152, 5, 2, 2, {skin="eskavator", class="default"}, {faction="cypher", rank=1, group="statue", vehType="excavator"}, {detectRadius=15, detectRadiusDelta=16, enemyDetectMode=false, pursueEnemy=false, onComming="if who~=nil and not level.functions['esc2BlewUp'] and object(who.playername).team~=object('esc2').team then level.screenplay.Statue('creeper_boom', 2) end;", attackMode="goto_aim", healthToHeal=-1})
	func.NPC.Create("esc3", 240, 832, 2, 2, 2, {skin="eskavator", class="default"}, {faction="cypher", rank=1, group="statue", vehType="excavator"}, {detectRadius=15, detectRadiusDelta=16, enemyDetectMode=false, pursueEnemy=false, onComming="if who~=nil and not level.functions['esc3BlewUp'] and object(who.playername).team~=object('esc3').team then level.screenplay.Statue('creeper_boom', 3) end;", attackMode="goto_aim", healthToHeal=-1})
	func.NPC.FollowWay("ourwarrior1", "base_patrol1")
	func.NPC.FollowWay("ourwarrior2", "base_patrol2")
	func.NPC.FollowWay("ourwarrior4", "base_patrol4")
--	level.LetDamageOurWarrior(1) -- Теперь, когда мы будем стрелять по поселенцам, они после нескольких предупреждений будут отстреливаться. *Не будут. Slava98. 24.08.13.
	object("ourwarrior3_tank").on_damage = object("ourwarrior3_tank").on_damage.."; if who == nil then level.CrazyHalos() end" --Так лучше и понятнее. Slava98.
	func.spriteskin.Create("", {texture = "skin/ekivatorl"}, {tankName = "ourwarrior1_tank"})
	func.spriteskin.Create("", {texture = "skin/ekivatorl"}, {tankName = "ourwarrior2_tank"})
	func.spriteskin.Create("", {texture = "skin/ekivatorl_camouflage"}, {tankName = "ourwarrior3_tank"})
	func.spriteskin.Create("", {texture = "skin/ekivatorl_camouflage"}, {tankName = "ourwarrior4_tank"})
	func.spriteskin.Create("", {texture = "skin/ekivatorl_camouflage"}, {tankName = "ourwarrior5_tank"})
	
	func.ShowItem("key1", 175, 1080, true, nil, "key1")
	func.ShowItem("battery", 750, 1385, true, nil, "boo3")
	func.ShowItem("battery", 1437, 2200, true, nil, "boo4")
	func.ShowItem("battery", 638, 2494, true, nil, "boo5")
	object("boo5_trig").on_enter = object("boo5_trig").on_enter.."; if exists('old_turret') and level.screenplay.ruinGeneratorIsActive then object('old_turret').team = 2; func.Message({'map01', 'promt', 10}) end;"
	
	level.objects.statue = func.ObjectCopy("statue");
	func.DropBot("statue")
	object("statue_tank").max_health = 10000;
	object("statue_tank").health = 10000;
	object("statue_tank").on_damage = "level.screenplay.Statue('damage')"..object("statue_tank").on_damage;
end, 2.4)

pushcmd(function()
	func.spriteskin.Create("", {texture = "skin/player"}, {tankName = "ourplayer_tank"}) -- Анимируем скин и игроку тоже.
	for i = 1, 5 do
		if i ~= 3 then
			func.timer.Create("ourwarrior"..i.."_talk", {timer = 3, breakable = true, funcTab = {"level.ways[main.NPC.list['ourwarrior"..i.."'].mainWay].active = false; ai_stop('ourwarrior"..i.."'); level.SpeakToPlayer('ourwarrior"..i.."'); pushcmd(function() local x1, y1 = position('ourwarrior"..i.."_tank'); local x2, y2 = position(const.playerVehName); func.object.SetRotation('ourwarrior"..i.."_tank', func.GetRadians(x1, y1, x2, y2), 100) end, 0.5)", nil, "level.ways[main.NPC.list['ourwarrior"..i.."'].mainWay].active = true; func.NPC.FollowWay('ourwarrior"..i.."')"}})
			func.object.borderTrigger.Create("ourwarrior"..i.."_talk", "ourwarrior"..i.."_tank", {radius = 2, only_human = 1, on_enter = "if not main.NPC.list['ourwarrior"..i.."'].isAttacking then func.timer.Play('ourwarrior"..i.."_talk') end"}, {dir = 6})
		end;
	end;
	for i = 1, 3 do 
		object("esc"..i.."_tank").max_health = 500; 
		object("esc"..i.."_tank").health = 200; 
		object("esc"..i.."_tank").on_damage = "level.screenplay.Statue('damage'); "..object("esc"..i.."_tank").on_damage;
		object("esc"..i).on_die = "if level.functions.esc"..i.."BlewUp ~= true and level.screenplay.eskavatorDropedBomb == false then func.GiveItem('bomb', 'esc"..i.."'); level.screenplay.eskavatorDropedBomb = true; elseif level.screenplay.eskavatorDroppedBomb and func.CheckOfLuck(math.random(5, 7)) then func.GiveItem('healthpack', 'esc"..i.."'); end;"..object("esc"..i).on_die;
		main.characters["esc"..i].inventory.bombTime = 0;
		level.objects["esc"..i] = func.ObjectCopy("esc"..i);
		func.DropBot("esc"..i)
	end;
--	object("statue_tank").on_destroy = "if level.screenplay.missionBoo == 1 then local x, y = position('statue_tank'); level.ShowBoo(x, y, 2) end"
end, 4.8)