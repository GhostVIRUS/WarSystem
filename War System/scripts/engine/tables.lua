-- WarEngine. ������� �� ����������.

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

const = { -- ���������.
	playerName = "ourplayer", -- ��� ������.
	playerVehName = "ourplayer_tank", -- ��� ����� ������.
	weapons = {"weap_cannon", "weap_autocannon", "weap_minigun", "weap_rockets", "weap_ripper", "weap_ram", "weap_plazma", "weap_bfg", "weap_zippo"}, -- ��������� ���� ������.
	cmpPath = "campaign/War System/",
	-- Scripts paths.
	scrPath = "campaign/War System/scripts/",
	engPath = "campaign/War System/scripts/engine/",
	libPath = "campaign/War System/scripts/libs/",
	objPath = "campaign/War System/scripts/objects/",
	lpkPath = "campaign/War System/scripts/levelpacks/",
	txtPath = "campaign/War System/scripts/texts/",
	stgPath = "campaign/War System/scripts/stages/",
	-- Other pathes.
	mapPath = "campaign/War System/maps/",
	texPath = "campaign/War System/textures/",
}