--dofile(main.scrDir.."/levels/levelpacks/.lua") �� �������� ='(
dofile(main.scrDir.."/levels/levelpacks.lua")
for i = 1, table.maxn(main.levelpacks) do 
	local levelpack = main.levelpacks[i] 
	if levelpack~= nil then dofile(main.scrDir.."/levels/levelpacks/"..levelpack..".lua") end
end

main.levelpack.default = main.levelpack.default or "ekivators"

function main.levelpack.Run(lp)
	main.levelpack.default = lp or "ekivators"
	main.levelpack.loaded = rawget(main.levelpack, lp)
	main.levelpack.name = lp
	main.levelpack.level = 0
--	if rawget(main.levelpack.loaded, "level1") == nil then func.PrintError("�� �����������?") return endujm
	main.inventory.letUseInventory = 1
	main.mail.letUseMail = 1
	main.levelpack.Circle(lp)
end

function main.levelpack.Circle(lp)
	main.levelpack.level = main.levelpack.level + 1
	main.levelpack.map = rawget(main.levelpack.loaded, "level"..main.levelpack.level)
	if main.levelpack.map == nil then func.PrintError("������ ���� ���") return end
--	if exists("menu") then kill("menu") end
	loadmap(main.mapsDir.."/"..main.levelpack.map..".map")
	main.menuservice = service("menu", {title="splash", name="menu", names="����|������� �������|������", on_select="main.menu.Main(n)" } )
	main.menu.section = "menu"
	conf.sv_nightmode = main.levelpack.default.nightmode --�����, ����� ������������ �� ������
	func.Play("mus5") --��� ��� ����� ������������� �� ������ �����
	loadtheme(main.scrDir.."/textures/map01.lua") --��� ���� ����� ������������� �� ������
	dofile(main.scrDir.."/levels/"..main.levelpack.map.."/startup.lua")
	dofile(main.scrDir.."/levels/"..main.levelpack.map.."/screenplay.lua")
	dofile(main.scrDir.."/levels/"..main.levelpack.map.."/speaks.lua")
	dofile(main.scrDir.."/levels/"..main.levelpack.map.."/functions.lua")	
	pause(false)
	pushcmd(function() main.menu.OpenCloseMenu() pause(true) end, 0.2)
end