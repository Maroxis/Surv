extends Node

var rng = RandomNumberGenerator.new()

onready var forceEvent = 15

onready var damageToolMlt : float = Difficulty.get_starting_tool_dmg_mlt()
onready var waterAddTime : int = Difficulty.get_starting_water_add_time()
onready var showEvent : bool = false
onready var animalTimer : int = 0
onready var seasonTimer : int = 0

onready var plannedEvent = []
onready var randomEvent = [
	"damageTool", #0
	"hardenNature", #1
	"poisonedStream", #2
	"forestOvergrown", #3
	"playerIll", #4
	"animalAttack", #5
	"unstableWeather", #6
	"flashStorm", #7
	"toxicRain", #8
	"spookedAnimals", #9
	"caveIn", #10
	"rats", #11
	"drought", #12
	"storm", #13
	"animalBloodlustAttack", #14
	"snake" #15
]
onready var eventDates = [3,6]
onready var eventIndex = 0

signal toxicRain

func _ready() -> void:
	init()
	if forceEvent != null:
		eventDates = [2,3,4,5,6,7]

func init():
	rng.randomize()

func pack():
	var data = {}
	data["eventIndex"] = eventIndex
	data["damageToolMlt"] = damageToolMlt
	data["waterAddTime"] = waterAddTime
	data["animalTimer"] = animalTimer
	data["seasonTimer"] = seasonTimer
	data["showEvent"] = showEvent
	data["rngSeed"] = rng.seed
	data["rngState"] = rng.state
	return data

func unpack(data):
	if data.has("eventIndex"):
		eventIndex = data["eventIndex"]
	if data.has("damageToolMlt"):
		damageToolMlt = data["damageToolMlt"]
	if data.has("waterAddTime"):
		waterAddTime = data["waterAddTime"]
	if data.has("animalTimer"):
		animalTimer = data["animalTimer"]
	if data.has("seasonTimer"):
		seasonTimer = data["seasonTimer"]
	if data.has("showEvent"):
		showEvent = data["showEvent"]
	if data.has("rngSeed"):
		rng.seed = data["rngSeed"]
	if data.has("rngState"):
		rng.state = data["rngState"]
	Global.Date.connect("timePassed",self,"returnAnimals")
	Global.Date.connect("timePassed",self,"seasonEnd")

func startEvent():
	if showEvent:
		var ev = null
		var ind
		if(plannedEvent.size() > eventIndex):
			ind = eventIndex
		else:
			ind = forceEvent if forceEvent != null else rng.randi_range(2, randomEvent.size()-1)
		ev = randomEvent[ind]
		if ev == null:
			return
		var res = call(ev)
		
		showPopup(ind,res)
		eventIndex += 1
		showEvent = false

func check_event(day):
	if((eventIndex >= eventDates.size() and day % 2 == 0) or (eventIndex < eventDates.size() and  eventDates[eventIndex] == day)):
		showEvent = true

func showPopup(ind,res):
	ind = str(ind)
	var title = tr("event"+ind+"_title")
	var desc =  tr("event"+ind+"_desc")
	var txRes = ""
	if res:
		if res["error"]:
			print(res["error"]) #dont remove
			Global.EventPopup.populate(tr("event_default_title"),tr("event_default_desc"),"")
			Global.EventPopup.show()
			return
		else:
			title = res["title"] if res.has("title") else title
			desc = res["desc"] if res.has("desc") else desc
			txRes = res["res"] if res.has("res") else txRes
	Global.EventPopup.populate(title,desc,txRes)
	Global.EventPopup.show()
	return

func testTimed(time, eDay = null):
	if(eDay):
		if(eDay == time):
			return {"error":null}
	else:
		var endDay = Global.Date.day + time
		Global.Date.connect("newDay",self,"testTimed",[endDay])
		return {"error":null}
	

func damageTool():
	var ownedTools = []
	for tl in Tools.tools:
		if Tools.getTier(tl) != 0:
			ownedTools.push_back(tl)
	if(ownedTools.size() == 0):
		return {"error":"no owned tool"}
	var r = rng.randi_range(0, ownedTools.size()-1)
	var chTl = ownedTools[r]
	var damage = floor(damageToolMlt)
	var rf = rng.randf_range(0.0, 1.0)
	damage = damage + 1 if fmod(damageToolMlt,1.0) > rf else damage
	if(damage == 0):
		damageToolMlt += Difficulty.get_scaling_tool_dmg()
		return {"error":null,"desc":tr("Your") + " " +tr(str(chTl)) + " " + tr("holds strong")}
	Save.tools[chTl]["durability"] -= damage
	if(Save.tools[chTl]["durability"]) < 1:
		Tools.setTier(chTl,Tools.getTier(chTl)-1)
		Tools.updateTool(chTl,true)
		return {"error":null,"desc": tr("Your") + " " + tr(str(chTl)) + " " + tr("got damaged and..."),"res":tr("broke")}
	return {"error":null,"desc": tr("Your") + " " + tr(str(chTl)) + " " + tr("got damaged and..."),"res":tr("held")}

func hardenNature():
	damageToolMlt += Difficulty.get_scaling_tool_dmg()*2
	return {"error":null}

func poisonedStream():
	Global.Missions.river.gatherTime["Water"] += waterAddTime
	waterAddTime += Difficulty.get_scaling_water_add_time()
	Global.Missions.river.updateGatherTime()
	var time = Global.timeGetFullFormat(Global.Missions.river.gatherTimeWBonus["Water"],false,true)
	return {"error":null,"res":tr("It now takes")+" "+time+" "+ tr("to search for water")}

func forestOvergrown():
	Global.Missions.woods.missionTravelTime += Difficulty.get_woods_travel_add_time()
	Global.Missions.woods.updateTravelTime()
	var time = Global.timeGetFullFormat(Global.Missions.woods.missionTravelTime,false,true)
	return {"error":null,"res":tr("It now takes")+" "+time+ " "+tr("to travel")}

func playerIll():
	var sickMlt = Difficulty.get_sick_mlt()
	var sick = rng.randi_range(6, 10)*sickMlt
	Player.change_sick(sick)
	var descLv = Player.sick_verbose()
	return {"error":null,"res":tr("You are")+" "+tr(descLv)+" "+tr("sick")}

func calcAttack(absolute = false):
	return Difficulty.get_attack_val(absolute)

func animalAttack():
	var level = calcAttack()
	var damage = level-Buildings.calcDefence()
	if(damage <= 0):
		return {"error":null,"res":tr("Your defence was enough to stop the attack")+"\n"+tr("Animal strength:")+" "+str(level)+"\n"+tr("Defence level:")+" "+str(Buildings.calcDefence())}
	else:
		var buildings = []
		for b in Buildings.Structure:
			for m in Buildings.Structure[b]:
				if typeof(Buildings.Structure[b][m]) == TYPE_DICTIONARY and Buildings.getTierInt(b,m) > 0:
					buildings.push_back([b,m])
		var rs
		if(buildings.size() == 0):
			rs = tr("There were no buildings to destroy")
		else:
			rs = tr("Following buildings were damaged:")+"\n"
		for n in damage:
			if(buildings.size() < 1):
				break
			var r = rng.randi_range(0, buildings.size()-1)
			if Save.structures[buildings[r][0]][buildings[r][1]]["progress"] > 0:
				Save.structures[buildings[r][0]][buildings[r][1]]["progress"] = 0
			else:
				Buildings.demolish(buildings[r][0],buildings[r][1])
			rs += tr(buildings[r][0]) + " " + tr(buildings[r][1]) + "\n"
			buildings.remove(r)
		return {"error":null,"res": rs}

func animalBloodlustAttack():
	var level = calcAttack()
	var damage = level-Buildings.calcDefence()
	if(damage <= 0):
		return {"error":null,"res":tr("Your defence was enough to stop the attack")+"\n"+tr("Animal strength:")+" "+str(level)+"\n"+tr("Defence level:")+" "+str(Buildings.calcDefence())}
	else:
		Player.change_health(-damage * Difficulty.get_animal_attack_damage_mlt(), GameOver.reasons.Combat)
		var rs = tr("You were injured by animal attack, due to lack of base defence") + "\n" +tr("You are") + " " + tr(Player.health_verbose()) + " " + tr("injured")
		return {"error":null,"res": rs}

func unstableWeather():
	Global.Weather.weatherChangeRate += 0.015
	Global.Weather.calmSustain += 1
func flashStorm():
	Global.Weather.setWeather(Global.Weather.type.Storm)
	Global.Weather.weatherChangeRate += 0.005
func toxicRain():
	Global.Weather.rainToxic += 0.3
	emit_signal("toxicRain")

func spookedAnimals():
	if(Global.Date.connect("timePassed",self,"returnAnimals") == OK):
		animalTimer += rng.randi_range(1440,2880) * Difficulty.get_spooked_animals_mlt() #24h-48h * mlt
		get_tree().call_group("Animals", "hide")
		return {"error":null}
	else:
		return {"error":"already hidden"}
func returnAnimals(time):
	animalTimer -= time
	if animalTimer <= 0:
		animalTimer = 0
		Global.Date.disconnect("timePassed",self,"returnAnimals")
		get_tree().call_group("Animals", "show")
	return

func caveIn():
	Global.Missions.hills.enableCaveIn(Difficulty.get_cave_in_amm())

func rats():
	var amm = Difficulty.get_rats_amm()
	var famm = Inventory.get_food_total_amm()
	amm = amm if famm >= amm else famm
	Achivements.rats_eat(amm)
	var foodAvaliable = []
	var ate = {}
	for food in Inventory.foodData:
		if Inventory.get_food_amm(food) > 0:
			foodAvaliable.push_back({"name":food,"amm":Inventory.get_food_amm(food)})
			ate[food] = 0
	
	for n in amm:
		var r = rng.randi_range(0, foodAvaliable.size()-1)
		Inventory.add_resource(foodAvaliable[r]["name"],-1,true)
		ate[foodAvaliable[r]["name"]] += 1
		foodAvaliable[r]["amm"] -= 1
		if foodAvaliable[r]["amm"] == 0:
			foodAvaliable.remove(r)
	if ate.size() == 0:
		return {"error":null,"res": tr("There was nothing to eat")}
	var rs = tr("They ate:")+"\n"
	for food in ate:
		if ate[food] > 0:
			print(food)
			rs += Global.tr_split(str(food)) + ": " + str(ate[food]) + "\n"
	return {"error":null,"res": rs}

func drought():
	return startSeason(3)

func storm():
	return startSeason(-3)

func startSeason(bias):
	if Global.Date.is_connected("timePassed", self, "seasonEnd"):
		return {"error":"already in season"}
	Global.Date.connect("timePassed",self,"seasonEnd")
	seasonTimer += rng.randi_range(2160,3600) * Difficulty.get_spooked_animals_mlt() #36h-60h * mlt
	Global.Weather.seasonBias = bias
	return {"error":null}

func seasonEnd(time):
	seasonTimer -= time
	if seasonTimer <= 0:
		seasonTimer = 0
		Global.Date.disconnect("timePassed",self,"seasonEnd")
		Global.Weather.seasonBias = 0
	return

func snake():
	Player.change_health(-Difficulty.get_snake_damage()/2, GameOver.reasons.Combat)
	Player.change_sick(Difficulty.get_snake_damage())
	return {"error":null,"res":tr("You are")+" "+tr(Player.sick_verbose())+" "+tr("sick") + "\n" + tr("and") + " " + tr(Player.health_verbose()) + " " + tr("injured")}
