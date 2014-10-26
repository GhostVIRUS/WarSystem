-- WarEngine. Таблицы со значениями.

engine = {
	packages = {},
}

menu = {
	letUseInventory = false,
	gameOptPage = 1,
}

defaults = {
	levepack = "ekivators",
	language = "russ",
}	

levelpacks = {
	list = {},
	loaded = "",
}

texts = {
	list = {},
	langList = {},
}

language = {
	list = {},
	current = defaults.language,
}

func = {
	
}

main = {
	godMode = false,
}

objects = {
	
}

const = { -- Константы.
	playerName = "ourplayer", -- Имя игрока.
	playerVehName = "ourplayer_tank", -- Имя танка игрока.
	weapons = {"weap_cannon", "weap_autocannon", "weap_minigun", "weap_rockets", "weap_ripper", "weap_ram", "weap_plazma", "weap_bfg", "weap_zippo"}, -- Возможные виды оружия.
	cmpPath = user.campaignDirectory,
	-- Scripts paths.
	engPath = "campaign/WarEngine/scripts/engine/",
	scrPath = user.campaignDirectory.."scripts/",
	corPath = user.campaignDirectory.."scripts/core/",
	libPath = user.campaignDirectory.."scripts/libs/",
	objPath = user.campaignDirectory.."scripts/objects/",
	lpkPath = user.campaignDirectory.."scripts/levelpacks/",
	txtPath = user.campaignDirectory.."scripts/texts/",
	-- Other pathes.
	mapPath = user.campaignDirectory.."maps/",
	texPath = user.campaignDirectory.."textures/",
}