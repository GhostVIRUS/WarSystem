-- WarEngine. ������� �� ����������.

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

const = func.UniteTables(func.DoTable(const), { -- ���������.
	playerName = "ourplayer", -- ��� ������.
	playerVehName = "ourplayer_tank", -- ��� ����� ������.
	weapons = {"weap_cannon", "weap_autocannon", "weap_minigun", "weap_rockets", "weap_ripper", "weap_ram", "weap_plazma", "weap_bfg", "weap_zippo"}, -- ��������� ���� ������.
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
		turret_cannon = "Turret",
		turret_gauss = "Turret",
		turret_minigun = "Turret",
		turret_rocket = "Turret",
		turret_zippo = "Turret",
		weap_autocannon = "Weapon",
		weap_bfg = "Weapon",
		weap_cannon = "Weapon",
		weap_gauss = "Weapon",
		weap_minigun = "Weapon",
		weap_plazma = "Weapon",
		weap_ram = "Weapon",
		weap_ripper = "Weapon",
		weap_rockets = "Weapon",
		weap_shotgun = "Weapon",
		weap_scriptgun = "Weapon",
		pu_booster = "Powerup",
		pu_health = "Powerup",
		pu_mine = "Powerup",
		pu_shield = "Powerup",
		pu_shock = "Powerup",
	},
})
