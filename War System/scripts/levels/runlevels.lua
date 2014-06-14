--dofile(const.scrDir.."/levels/levelpacks/.lua") �� �������� ='(
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
--	if rawget(main.levelpack.loaded, "level1") == nil then func.PrintError("�� �����������?") return endujm
	main.inventory.letUseInventory = true; -- �� ������, ��� ��� ���������, �� �����. Slava98. 06.06.13.
	main.mail.letUseMail = true;
	main.levelpack.Circle(lp)
end

function main.levelpack.Circle(lp)
	main.levelpack.level = main.levelpack.level + 1
	main.levelpack.map = main.levelpack.loaded["level"..main.levelpack.level];
	if main.levelpack.map == nil then func.PrintError("������ ���� ���") return end
--	if exists("menu") then kill("menu") end
	loadmap(const.mapsDir.."/"..main.levelpack.map..".map")
--	main.menuservice = service("menu", {title="splash", name="menu", names="����|������� �������|������", on_select="main.menu.Main(n)" } )
--	main.menu.section = "menu"
	main.menuservice = service("menu", {name="menu"})
	main.menu.Show("main")
	conf.sv_nightmode = main.levelpack.default.nightmode --�����, ����� ������������ �� ������
	func.Play("mus5") --��� ��� ����� ������������� �� ������ �����
	loadtheme(const.scrDir.."/textures/map01.lua") --��� ���� ����� ������������� �� ������
	dofile(const.scrDir.."/levels/"..main.levelpack.map.."/startup.lua")
	dofile(const.scrDir.."/levels/"..main.levelpack.map.."/screenplay.lua")
	dofile(const.scrDir.."/levels/"..main.levelpack.map.."/speaks.lua")
	dofile(const.scrDir.."/levels/"..main.levelpack.map.."/functions.lua")	
	pause(false)
	pushcmd(function() main.menu.OpenCloseMenu() pause(true) end, 0.2)
end

-- ���������� ����� �������� ���������. Slava98.
function main.levelpack.GetNum()
	for i = 1, table.maxn(main.levelpacks) do
		if main.levelpacks[i] == main.levelpack.default then return i end
	end
end
