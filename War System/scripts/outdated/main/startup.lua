reset()
music ""
conf.sv_timelimit = 0;
conf.sv_fraglimit = 0;
conf.sv_nightmode = true;

main = { -- Главные глобальные переменные (не зависят от уровней).
	consoleText = "", -- Лог func.Message.
	gameOptPage = 1,
	mail = { -- Почта.
		letUseMail = false, -- Возможно ли использовать почту.
		message = " Привет, это почта. \nВам сюда в течении игры будут приходить сообщения. \nПожалуйста не пропускайте их и читайте внимательно. \nПриятной игры. \n\nЭто сообщение не будет выводится в дальнейшем...", -- Текущее сообщение.
		letViewMessage = 2, -- Номер текущего сообщения.
		maxValue = 2, -- Количество сообщений.
		playerSawPromtMessage = false, -- Видел ли игрок вводное сообщение почты.
		},
	missions = { -- Задания.
		mainMission = "У вас нет основных задач.", -- Нужно будет сделать через dialog. Slava98.
		extraMission = "У вас нет дополнительных задач.",
		},
	inventory = { -- Инвентарь.
		letUseInventory = false, -- Возможно ли использовать инвентарь. *Сделать через boolean! Slava98. 30.05.13.
		botreduce = 1,
		playerKnowsAboutOverload = false, -- Знает ли игрок, что у него перегружен инвентарь.
--[[	numberBoo = 0, -- Количество бустеров. *Всё это больше не используется. Slava98. 24.08.13.
		numberHealthPack = 0, -- Количество ПЭРКов.
		numberMine = 0, -- Количество мин.
		isActivatedBoo = false, -- Активирован ли бустер.
		isActivatedMine = false, -- Активирована ли мина.
		mineNum = 0, -- Количество мин, расположенных игроком на уровне.
		items = {}, -- Не знаю.]]
		},
	cheats = {}, -- Читерские функции. *Доделать. Slava98. 24.08.13.
	player = { -- Переменные и функции, относящиеся к танку игрока. *Думаю, лучше бы это отнести к characters. Slava98. 30.05.13. Нет, не надо. Slava98. 18.08.13.
		isExist = false, -- Существует ли плеер.
		godMode = false, -- Включен ли режим бога.
		}, 	
	menuservice = {}, -- 
	save = {}, -- Переменные и функции, относящиеся к сохранению игры.
	menu = {
		devicesChosedString = 1, -- Выбранный вариант в окошке устройств.
		inventoryChosedString = 4, -- Выбранный вариант в окошке инвентаря.
		inventorySectionString = 2, -- Выбранная секция в окошке инвентаря.
		}, -- 
	lang = {},
	levelpack = {}, -- Переменные и функции, относящиеся к левелпакам.
	characters = {}, -- Массив с персонажами.
	temp = {}, -- Временные переменные и функции.
	NPC = {list={}}, -- Переменные и фукнции, относящиеся к NPC.
	objects = {}, -- Законсервированные объекты, такие как меню, диалоги.
	timers = {},
	music = { -- Переменные, связанные со звуком и музыкой.
		currentTrack = "", -- Текущий трек. Не используется.
	},
}

level = { -- Глобальные переменные, относящиеся к уровню.
	itemNum = 0, -- Количество предметов на уровне.
	bordertriggers = {},
	ways = {}, -- Пути для NPC.
	texts = {}, -- Тексты, расположенные на уровне.
	projectiles = {}, -- Снаряды, расположенные на уровне.
	dialog = { -- Переменные, относящиеся к диалогам и локализациям.
		lang = "russ", -- Текущий язык (русский).
	},
}

func = { -- Переменные, которые относятся к функциям.
	letDirFollowingObject = 0,
	letBorderTriggerFollowingObject = 0,
	timer = {}, -- *Не знаю, стоит ли выделять таймеру целый массив. Надо посмотреть. Slava98. 24.08.13.
	extrasprite = {},
	dialog = {}, -- Функции для диалогов.
	player = {}, -- Функции для игрока.
	tank = {}, -- Функции для танков.
	projectile = {}, -- Функции для снарядов.
	object = {borderTrigger = {}}, -- Функции для объектов.
	inventory = {}, -- Функции инвентаря.
	logic = {}, -- Логические функции. Написать.
    poligons = {}, -- Полигоны. Заморожено.
    megaTrigs = {}, -- Мегатриггер. Заморожено.
	gen = {}, -- Функции генерации уровня. Заморожено.
	NPC = { -- Функции и переменные, отвечающие за NPC.
		actNum = 0, -- *Не знаю.
		num = 0, -- *Количество NPC?
		timesOfDamages = 0, -- *Изменить. Slava98. 30.05.13.
		},
	way = {},
	text = {},
}
	
const = { -- Константы.
	playerName = "ourplayer", -- Имя игрока.
	playerVehName = "ourplayer_tank", -- Имя танка игрока.
	weapons = {"weap_cannon", "weap_autocannon", "weap_minigun", "weap_rockets", "weap_ripper", "weap_ram", "weap_plazma", "weap_bfg", "weap_zippo"}, -- Возможные виды оружия.
	campDir = "campaign//War System", -- Адрес папки кампании. Не используется.
	scrDir  = "campaign//War System//scripts//outdated", -- Адрес папки скриптов.
	mapsDir = "campaign//War System//maps", -- Адрес папки карт.
} 

shape = { -- Шаблоны.
	inventory = { -- Изначальный инвентарь любого характера. *Изначально создавался для NPC, но я пришёл к выводу, что такой инвентарь должен быть у всех характеров, включая игрока. Slava98. 06.06.13.
		isSetWeap = false, -- Установлено ли уже оружие. Slava98. 31.12.13.
		isActivated = {}, -- Активирован ли какой-либо предмет. Slava98. 29.05.14.
		numOfPushed = {}, -- Количество поставленных в очередь предметов. Slava98. 29.05.14.
		healTime = 5, -- Время использования ПЭРКа. Чем круче танк, тем медленнее он хиллится.
		bombTime = 10, -- Стандартный таймер бомбы.
		dropBomb = false, -- Бросить ли бомбу при использовании.
		activatedBombName = "", -- Имя текущей бомбы. Временная переменная.
		numberOfAcivatedMines = 0, -- Число активированных персонажами мин на карте.
		numberOfAcivatedBombs = 0, -- Число активированных персонажами бомб на карте.
		numberOfDroppedItems = 0, -- Число выкинутых предметов.
		weapons = {}, -- Оружие персонажа.
		items = {}, -- Предметы персонажа.
		keys = {}, -- Ключи персонажа.
	},
	devices = {
		isActivated = {}, -- Активировано ли какое-либо устройство. Slava98. 29.05.14.
		autofireEfficiency = 0, -- Готовность САПС.
	},
}

debug = {
	showMainMessages = true,
	showWayMessages = false,
	showWayShortMessages = false,
	showAttackMessages = true,
},

dofile(const.scrDir.."/main/menu.lua")
dofile(const.scrDir.."/main/functions.lua")
dofile(const.scrDir.."/main/classes.lua")
dofile(const.scrDir.."/levelpacks/runlevels.lua")
dofile(const.scrDir.."/dialogs/main.lua")
loadtheme(const.campDir.."/textures/map01.lua")
func.UnsetTempValues()

main.menuservice = service("menu", {name="menu"})
main.menu.Show("main")
func.Play("menu")
pushcmd(function() main.menuservice.open = 1 end, 0.1)