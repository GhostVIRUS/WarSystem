-- WarEngine. Таблицы со значениями.

engine = func.UniteTables({
	packages = {},
}, func.DoTable(engine))

menu = func.UniteTables({
	letUseInventory = false,
	gameOptPage = 1,
	optionsChosedString = 1,
}, func.DoTable(menu))

defaults = func.UniteTables({
	levepack = "ekivators",
	language = "russ",
	showPromt = true,
}, func.DoTable(defaults))

levelpacks = func.UniteTables({
	list = {},
	current = defaults.levepack,
}, func.DoTable(levelpacks))

texts = func.UniteTables({
	list = {},
	langList = {},
}, func.DoTable(texts))

-- i hope it's temply
temp = func.UniteTables({

}, func.DoTable(temp))

language = func.UniteTables({
	list = {},
	current = defaults.language,
}, func.DoTable(language))

gameplay = func.UniteTables({
	godMode = false,
	showPromt = defaults.showPromt,
}, func.DoTable(gameplay))

objects = func.UniteTables({
	list = {},
	classesLoaded = {},
}, func.DoTable(objects))

const = func.UniteTables({ -- Константы.
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
