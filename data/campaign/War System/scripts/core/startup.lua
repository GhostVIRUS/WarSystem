-- War System. Загрузочный файл.

engine.Require("config", "classes")

defaults = { -- default values
	allowCheats = true,
	showPromt = true,
	levelpack = "ekivators",
	language = "russ",
}

optional = func.DoTable(defaults);

main = {
	config = Config("main_conf", "data/"..const.cmpPath.."config.dat", optional, "// War System configuration file. Config was generated automatically."),
}

menu = func.UniteTables(func.DoTable(menu), {
	letUseInventory = false,
	gameOptPage = 1,
	optionsChosedString = 1,
})

conf.sv_nightmode = true;
main.config:load()
dofile(const.corPath.."menu.lua")
loadtheme("campaign/War System//textures/map01.lua") -- temply