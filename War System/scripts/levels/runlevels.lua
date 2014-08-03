--dofile(const.scrDir.."/levels/levelpacks/.lua") Не работает ='(
dofile(const.scrDir.."/levels/levelpacks.lua")
for i = 1, table.maxn(main.levelpacks) do 
	local levelpack = main.levelpacks[i] 
	if levelpack~= nil then dofile(const.scrDir.."/levels/levelpacks/"..levelpack..".lua") end
end

main.levelpack.default = main.levelpack.default or "ekivators"

function main.levelpack.Run(lp)
	main.levelpack.default = lp or "ekivators";
	main.levelpack.loaded = main.levelpack[lp];
	main.levelpack.name = lp;
	main.levelpack.level = 0;
--	if rawget(main.levelpack.loaded, "level1") == nil then func.PrintError("ТЫ ИЗДЕВАЕШЬСЯ?") return endujm
	main.inventory.letUseInventory = true; -- Не уверен, что это правильно, но ладно. Slava98. 06.06.13.
	main.mail.letUseMail = true;
	main.levelpack.Circle(lp)
end

function main.levelpack.Circle(lp)
	main.levelpack.level = main.levelpack.level + 1
	main.levelpack.map = main.levelpack.loaded["level"..main.levelpack.level];
	if main.levelpack.map == nil then func.PrintError("Больше карт нет") return end
--	if exists("menu") then kill("menu") end
	loadmap(const.mapsDir.."/"..main.levelpack.map..".map")
--	main.menuservice = service("menu", {title="splash", name="menu", names="Игра|Игровые функции|Помощь", on_select="main.menu.Main(n)" } )
--	main.menu.section = "menu"
	main.menuservice = service("menu", {name="menu"})
	main.menu.Show("main")
	conf.sv_nightmode = main.levelpack.default.nightmode --Думаю, будет настраиватся на уровне
	func.Play("mus5") --Это тем более настраиваться на уровне будет
	loadtheme(const.scrDir.."/textures/map01.lua") --Это тоже будет настраиваться на уровне
	dofile(const.scrDir.."/levels/"..main.levelpack.map.."/startup.lua")
	dofile(const.scrDir.."/levels/"..main.levelpack.map.."/screenplay.lua")
	dofile(const.scrDir.."/levels/"..main.levelpack.map.."/speaks.lua")
	dofile(const.scrDir.."/levels/"..main.levelpack.map.."/functions.lua")	
	pause(false)
	pushcmd(function() main.menu.OpenCloseMenu() pause(true) end, 0.2)
end

-- Возвращает номер текцщего левелпака. Slava98.
function main.levelpack.GetNum()
	for i = 1, table.maxn(main.levelpacks) do
		if main.levelpacks[i] == main.levelpack.default then return i end
	end
end
