-- War System. Загрузочный файл.

engine.Require("config", "classes")

optional = {
	levelpack = "ekivators",
	language = "russ",
	showPromt = true,
}

main = {
	config = Config("main_conf", const.cmpPath.."config.dat", optional),
}

conf.sv_nightmode = true;
dofile(const.corPath.."menu.lua")
loadtheme("campaign/War System//textures/map01.lua") -- temply