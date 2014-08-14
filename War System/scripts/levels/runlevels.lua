dofile(const.scrDir.."/levels/levelpacks.lua")
for i = 1, table.maxn(main.levelpacks) do 
	local levelpack = main.levelpacks[i] 
	if levelpack~= nil then dofile(const.scrDir.."/levels/"..levelpack.."/info.lua") end
end

main.levelpack.default = main.levelpack.default or "ekivators"

function main.levelpack.Run(lp)
	main.levelpack.default = lp or "ekivators";
	main.levelpack.loaded = main.levelpack[lp];
	main.levelpack.name = lp;
	main.levelpack.level = 0;
	main.inventory.letUseInventory = true; -- Не уверен, что это правильно, но ладно. Slava98. 06.06.13.
	main.mail.letUseMail = true;
	main.levelpack.Circle(lp)
end

function main.levelpack.Circle(lp)
	main.levelpack.level = main.levelpack.level + 1
	main.levelpack.map = main.levelpack.loaded["level"..main.levelpack.level];
	if main.levelpack.map == nil then func.PrintError("Больше карт нет") return end
	loadmap(const.mapsDir.."/"..main.levelpack.name.."/"..main.levelpack.map..".map")
	main.menuservice = service("menu", {name="menu"})
	main.menu.Show("main")
	dofile(const.scrDir.."/levels/"..main.levelpack.name.."/"..main.levelpack.map.."/startup.lua")
	dofile(const.scrDir.."/levels/"..main.levelpack.name.."/"..main.levelpack.map.."/screenplay.lua")
	dofile(const.scrDir.."/levels/"..main.levelpack.name.."/"..main.levelpack.map.."/speaks.lua")
	dofile(const.scrDir.."/levels/"..main.levelpack.name.."/"..main.levelpack.map.."/functions.lua")	
	pause(false)
	pushcmd(function() main.menu.OpenCloseMenu() pause(true) end, 0.2)
end

-- Возвращает номер текцщего левелпака. Slava98.
function main.levelpack.GetNum()
	for i = 1, table.maxn(main.levelpacks) do
		if main.levelpacks[i] == main.levelpack.default then return i end
	end
end
