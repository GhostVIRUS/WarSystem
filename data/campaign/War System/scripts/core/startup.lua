-- War System. Загрузочный файл.

engine.Require("config", "classes")

optional = { -- default values
	levelpack = "ekivators",
	language = "russ",
	showPromt = true,
}

main = {
	config = Config("main_conf", "data/"..const.cmpPath.."config.dat", optional),
}

conf.sv_nightmode = true;
main.config:load()
dofile(const.corPath.."menu.lua")
loadtheme("campaign/War System//textures/map01.lua") -- temply