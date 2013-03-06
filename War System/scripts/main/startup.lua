reset()
music ""
conf.sv_timelimit = 0
conf.sv_fraglimit = 0
conf.sv_nightmode = true

main = {
	mail = {
		letUseMail = 0,
		message = " Привет, это почта. \nВам сюда в течении игры будут приходить сообщения. \nПожалуйста не пропускайте их и читайте внимательно. \nПриятной игры. \n\nЭто сообщение не будет выводится в дальнейшем...",
		letViewMessage = 2,
		maxValue = 2,
		},
	missions = {
		mainMission = "У вас нет основных задач.",
		extraMission = "У вас нет дополнительных задач.",
		},
	inventory = {
		letUseInventory = 0,
		numberBoo = 0,
		numberHealthPack = 0,
		numberMine = 0,
		activateBoo = 0,
		activateMine = 0,
		mineNum = 0,
		items = {"boo", "healthpack", "mine"},
		},
	cheats = {},
	player = {},
	menuservice = {},
	save = {},
	menu = {},
	levelpack = {},
	characters = {},
	temp = {},
	campDir = "campaign//War System",
	scrDir  = "campaign//War System//scripts",
	mapsDir = "campaign//War System//maps",
}

level = {
	dialog = { 
		lang = "russ" 
		},
}

func = {
	mineNum = 0, 
	hpNum = 0,
	letDirFollowingObject = 0,
	letBorderTriggerFollowingObject = 0,
	timer = {},
	animskin = {},
	dialog = {},
	player = {}, 
	gen = {},
	NPC = {
		actNum = 0,
		num = 0,
		timesOfDamages = 0,
		enemies = {},
		friends = {}, 
		neutrals = {},
		},
    poligons = {},
    megaTrigs = {},
}
	
const = {playername = "ourplayer"}

dofile(main.scrDir.."/main/menu.lua")
dofile(main.scrDir.."/main/functions.lua")
dofile(main.scrDir.."/main/classes.lua")
dofile(main.scrDir.."/levels/runlevels.lua")
dofile(main.scrDir.."/dialogs/main.lua")
loadtheme(main.scrDir.."/textures/map01.lua")
func.UnsetTempValues()

main.menuservice = service("menu", {title="splash", name="menu", names="Игра|Игровые функции|Помощь", on_select="main.menu.Main(n)" } )
--main.menu.section = "menu"
func.Play("menu")
pushcmd( function() main.menuservice.open=1 end, 0.1)
