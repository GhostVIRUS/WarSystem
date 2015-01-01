-- WarEngine. Таблицы со значениями.

engine = func.UniteTables(func.DoTable(engine), {
	packages = {},
})

menu = func.UniteTables(func.DoTable(menu), {

})

defaults = func.UniteTables(func.DoTable(defaults), {
	levepack = "ekivators",
	language = "russ",
	showPromt = true,
})

levelpacks = func.UniteTables(func.DoTable(levelpacks), {
	list = {},
	current = defaults.levepack,
})

texts = func.UniteTables(func.DoTable(texts), {
	list = {},
	langList = {},
})

-- i hope it's temply
temp = func.UniteTables(func.DoTable(temp), {

})

language = func.UniteTables(func.DoTable(language), {
	list = {},
	current = defaults.language,
})

gameplay = func.UniteTables(func.DoTable(gameplay), {
	godMode = false,
	showPromt = defaults.showPromt,
})

objects = func.UniteTables(func.DoTable(objects), {
	list = {},
	classesLoaded = {},
})

const = func.UniteTables(func.DoTable(const), { -- Константы.
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
	objectTypes = {
		wall_concrete = "Concrete",
		wall_brick = "Brick",
--		water = "Water", -- !
--		wood = "Wood", -- !
		user_sprite = "Sprite",
		user_object = "UserObject",
--		spotlight = "Spotlight", -- !
		trigger = "Trigger",
--		respawn_point = "Respawn", -- !
		tank = "Vehicle",
		crate = "Crate",
		turret = "Turret",
		weap = "Weapon",
		pu = "Pickup",
	},
})
