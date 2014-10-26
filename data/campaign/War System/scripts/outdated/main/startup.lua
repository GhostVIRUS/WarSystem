reset()
music ""
conf.sv_timelimit = 0;
conf.sv_fraglimit = 0;
conf.sv_nightmode = true;

main = { -- ������� ���������� ���������� (�� ������� �� �������).
	consoleText = "", -- ��� func.Message.
	gameOptPage = 1,
	mail = { -- �����.
		letUseMail = false, -- �������� �� ������������ �����.
		message = " ������, ��� �����. \n��� ���� � ������� ���� ����� ��������� ���������. \n���������� �� ����������� �� � ������� �����������. \n�������� ����. \n\n��� ��������� �� ����� ��������� � ����������...", -- ������� ���������.
		letViewMessage = 2, -- ����� �������� ���������.
		maxValue = 2, -- ���������� ���������.
		playerSawPromtMessage = false, -- ����� �� ����� ������� ��������� �����.
		},
	missions = { -- �������.
		mainMission = "� ��� ��� �������� �����.", -- ����� ����� ������� ����� dialog. Slava98.
		extraMission = "� ��� ��� �������������� �����.",
		},
	inventory = { -- ���������.
		letUseInventory = false, -- �������� �� ������������ ���������. *������� ����� boolean! Slava98. 30.05.13.
		botreduce = 1,
		playerKnowsAboutOverload = false, -- ����� �� �����, ��� � ���� ���������� ���������.
--[[	numberBoo = 0, -- ���������� ��������. *�� ��� ������ �� ������������. Slava98. 24.08.13.
		numberHealthPack = 0, -- ���������� ������.
		numberMine = 0, -- ���������� ���.
		isActivatedBoo = false, -- ����������� �� ������.
		isActivatedMine = false, -- ������������ �� ����.
		mineNum = 0, -- ���������� ���, ������������� ������� �� ������.
		items = {}, -- �� ����.]]
		},
	cheats = {}, -- ��������� �������. *��������. Slava98. 24.08.13.
	player = { -- ���������� � �������, ����������� � ����� ������. *�����, ����� �� ��� ������� � characters. Slava98. 30.05.13. ���, �� ����. Slava98. 18.08.13.
		isExist = false, -- ���������� �� �����.
		godMode = false, -- ������� �� ����� ����.
		}, 	
	menuservice = {}, -- 
	save = {}, -- ���������� � �������, ����������� � ���������� ����.
	menu = {
		devicesChosedString = 1, -- ��������� ������� � ������ ���������.
		inventoryChosedString = 4, -- ��������� ������� � ������ ���������.
		inventorySectionString = 2, -- ��������� ������ � ������ ���������.
		}, -- 
	lang = {},
	levelpack = {}, -- ���������� � �������, ����������� � ����������.
	characters = {}, -- ������ � �����������.
	temp = {}, -- ��������� ���������� � �������.
	NPC = {list={}}, -- ���������� � �������, ����������� � NPC.
	objects = {}, -- ������������������ �������, ����� ��� ����, �������.
	timers = {},
	music = { -- ����������, ��������� �� ������ � �������.
		currentTrack = "", -- ������� ����. �� ������������.
	},
}

level = { -- ���������� ����������, ����������� � ������.
	itemNum = 0, -- ���������� ��������� �� ������.
	bordertriggers = {},
	ways = {}, -- ���� ��� NPC.
	texts = {}, -- ������, ������������� �� ������.
	projectiles = {}, -- �������, ������������� �� ������.
	dialog = { -- ����������, ����������� � �������� � ������������.
		lang = "russ", -- ������� ���� (�������).
	},
}

func = { -- ����������, ������� ��������� � ��������.
	letDirFollowingObject = 0,
	letBorderTriggerFollowingObject = 0,
	timer = {}, -- *�� ����, ����� �� �������� ������� ����� ������. ���� ����������. Slava98. 24.08.13.
	extrasprite = {},
	dialog = {}, -- ������� ��� ��������.
	player = {}, -- ������� ��� ������.
	tank = {}, -- ������� ��� ������.
	projectile = {}, -- ������� ��� ��������.
	object = {borderTrigger = {}}, -- ������� ��� ��������.
	inventory = {}, -- ������� ���������.
	logic = {}, -- ���������� �������. ��������.
    poligons = {}, -- ��������. ����������.
    megaTrigs = {}, -- �����������. ����������.
	gen = {}, -- ������� ��������� ������. ����������.
	NPC = { -- ������� � ����������, ���������� �� NPC.
		actNum = 0, -- *�� ����.
		num = 0, -- *���������� NPC?
		timesOfDamages = 0, -- *��������. Slava98. 30.05.13.
		},
	way = {},
	text = {},
}
	
const = { -- ���������.
	playerName = "ourplayer", -- ��� ������.
	playerVehName = "ourplayer_tank", -- ��� ����� ������.
	weapons = {"weap_cannon", "weap_autocannon", "weap_minigun", "weap_rockets", "weap_ripper", "weap_ram", "weap_plazma", "weap_bfg", "weap_zippo"}, -- ��������� ���� ������.
	campDir = "campaign//War System", -- ����� ����� ��������. �� ������������.
	scrDir  = "campaign//War System//scripts//outdated", -- ����� ����� ��������.
	mapsDir = "campaign//War System//maps", -- ����� ����� ����.
} 

shape = { -- �������.
	inventory = { -- ����������� ��������� ������ ���������. *���������� ���������� ��� NPC, �� � ������ � ������, ��� ����� ��������� ������ ���� � ���� ����������, ������� ������. Slava98. 06.06.13.
		isSetWeap = false, -- ����������� �� ��� ������. Slava98. 31.12.13.
		isActivated = {}, -- ����������� �� �����-���� �������. Slava98. 29.05.14.
		numOfPushed = {}, -- ���������� ������������ � ������� ���������. Slava98. 29.05.14.
		healTime = 5, -- ����� ������������� �����. ��� ����� ����, ��� ��������� �� ��������.
		bombTime = 10, -- ����������� ������ �����.
		dropBomb = false, -- ������� �� ����� ��� �������������.
		activatedBombName = "", -- ��� ������� �����. ��������� ����������.
		numberOfAcivatedMines = 0, -- ����� �������������� ����������� ��� �� �����.
		numberOfAcivatedBombs = 0, -- ����� �������������� ����������� ���� �� �����.
		numberOfDroppedItems = 0, -- ����� ��������� ���������.
		weapons = {}, -- ������ ���������.
		items = {}, -- �������� ���������.
		keys = {}, -- ����� ���������.
	},
	devices = {
		isActivated = {}, -- ������������ �� �����-���� ����������. Slava98. 29.05.14.
		autofireEfficiency = 0, -- ���������� ����.
	},
}

debug = {
	showMainMessages = true,
	showWayMessages = false,
	showWayShortMessages = false,
	showAttackMessages = true,
},

dofile(const.scrDir.."/main/menu.lua")
dofile(const.scrDir.."/main/functions.lua")
dofile(const.scrDir.."/main/classes.lua")
dofile(const.scrDir.."/levelpacks/runlevels.lua")
dofile(const.scrDir.."/dialogs/main.lua")
loadtheme(const.campDir.."/textures/map01.lua")
func.UnsetTempValues()

main.menuservice = service("menu", {name="menu"})
main.menu.Show("main")
func.Play("menu")
pushcmd(function() main.menuservice.open = 1 end, 0.1)