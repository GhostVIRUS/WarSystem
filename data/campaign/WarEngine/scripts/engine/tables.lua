-- WarEngine. Таблицы со значениями.

engine = func.UniteTable({
	packages = {},
}, func.DoTable(engine))

menu = func.UniteTable({
	letUseInventory = false,
	gameOptPage = 1,
	optionsChosedString = 1,
}, func.DoTable(menu))

defaults = func.UniteTable({
	levepack = "ekivators",
	language = "russ",
}, func.DoTable(defaults))

levelpacks = func.UniteTable({
	list = {},
	current = defaults.levepack,
}, func.DoTable(levelpacks))

texts = func.UniteTable({
	list = {},
	langList = {},
}, func.DoTable(texts))

-- i hope it's temply
temp = func.UniteTable({

}, func.DoTable(temp))

language = func.UniteTable({
	list = {},
	current = defaults.language,
}, func.DoTable(language))

func = func.UniteTable({
	
}, func.DoTable(func))

gameplay = func.UniteTable({
	godMode = false,
	showPromt = true,
}, func.DoTable(gameplay))

objects = func.UniteTable({
	list = {},
	classesLoaded = {},
}, func.DoTable(objects))

const = func.UniteTable({ -- Константы.
	playerName = "ourplayer", -- Имя игрока.
	playerVehName = "ourplayer_tank", -- Имя танка игрока.
	weapons = {"weap_cannon", "weap_autocannon", "weap_minigun", "weap_rockets", "weap_ripper", "weap_ram", "weap_plazma", "weap_bfg", "weap_zippo"}, -- Возможные виды оружия.
	cmpPath = user.campaignDirectory,
	-- Scripts paths.
	engPath = "campaign/WarEngine/scripts/engine/",
	elbPath = "campaign/WarEngine/scripts/libs/",
	scrPath = user.campaignDirectory.."scripts/",
	corPath = user.campaignDirectory.."scripts/core/",
	libPath = user.campaignDirectory.."scripts/libs/",
	clsPath = user.campaignDirectory.."scripts/classes/",
	lpkPath = user.campaignDirectory.."scripts/levelpacks/",
	txtPath = user.campaignDirectory.."scripts/texts/",
	-- Other pathes.
	mapPath = user.campaignDirectory.."maps/",
	texPath = user.campaignDirectory.."textures/",
}, func.DoTable(const))
