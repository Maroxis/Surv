extends Node

var rng = RandomNumberGenerator.new()

onready var forceEvent = null

onready var damageToolMlt : float = 0.8
onready var waterAddTime : int = 25
onready var showEvent : bool = false
onready var animalTimer : int = 0

onready var plannedEvent = {
}
onready var randomEvent = {
	"event0":{
		"title":"Tool damage",
		"function": "damageTool"
	},
	"event1":{
		"title":"Nature Hardens",
		"desc": "Your tools will be easier to brake from now on",
		"function": "hardenNature"
	},
	"event2":{
		"title":"Toxic stream",
		"desc": "Nearby stream got poisoned. Now it takes more time to search for water",
		"function": "poisonedStream"
	},
	"event3":{
		"title":"Forest has overgrown",
		"desc": "It will take more time to travel to the forest",
		"function": "forestOvergrown"
	},
	"event4":{
		"title":"Illness",
		"desc": "Illness will decrease your bonus energy from sleeping, make you loose food and water faster and in worst case will reduce your health",
		"function": "playerIll"
	},
	"event5":{
		"title":"Animal Attack",
		"desc": "Pack of animals attacked your camp",
		"function": "animalAttack"
	},
	"event6":{
		"title":"Unstable Weather",
		"desc": "Weather changes more frequently",
		"function": "unstableWeather"
	},
	"event7":{
		"title":"Flash Storm",
		"desc": "Sudden storm",
		"function": "flashStorm"
	},
	"event8":{
		"title":"Toxic Rain",
		"desc": "Rain becomes more toxic, causes illnes when drinking without filtering",
		"function": "toxicRain"
	},
	"event9":{
		"title":"Spooked Animals",
		"desc": "Animals over plains are nowhere to be found",
		"function": "spookedAnimals"
	},
	"event10":{
		"title":"Cave in",
		"desc": "Cave wall collapsed blocking entry",
		"function": "caveIn"
	},
	"event11":{
		"title":"Rats",
		"desc": "Rats got into your food supply",
		"function": "rats"
	}
}
onready var defaultEvent = {
	"title":"Calm Day",
	"desc": "Nothing happened"
}
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
	if data.has("showEvent"):
		showEvent = data["showEvent"]
	if data.has("rngSeed"):
		rng.seed = data["rngSeed"]
	if data.has("rngState"):
		rng.state = data["rngState"]

func startEvent():
	if showEvent:
		var ev
		if(plannedEvent.size() > eventIndex):
			ev = plannedEvent["event"+str(eventIndex)]
		else:
			var r = forceEvent if forceEvent != null else rng.randi_range(0, randomEvent.size()-1)
			ev = randomEvent["event"+str(r)]
		var res
		if(ev.has("params")):
			res = call(ev["function"],ev["params"])
		else:
			res = call(ev["function"])
			
		showPopup(ev,res)
		eventIndex += 1
		showEvent = false

func check_event(day):
	if((eventIndex >= eventDates.size() and day % 2 == 0) or (eventIndex < eventDates.size() and  eventDates[eventIndex] == day)):
		showEvent = true

func showPopup(ev,res):
	var title = ev["title"] if ev.has("title") else ""
	var desc =  ev["desc"] if ev.has("desc") else ""
	var txRes = ""
	if res:
		if res["error"]:
			print(res["error"]) #dont remove
			Global.EventPopup.populate(defaultEvent["title"],defaultEvent["desc"],"")
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
		damageToolMlt += 0.2
		return {"error":null,"desc":"Your "+str(chTl)+" holds strong"}
	Save.tools[chTl]["durability"] -= damage
	if(Save.tools[chTl]["durability"]) < 1:
		Tools.setTier(chTl,Tools.getTier(chTl)-1)
		Tools.updateTool(chTl,true)
		return {"error":null,"desc":"Your "+str(chTl)+" got damaged and...","res":"broke"}
	return {"error":null,"desc":"Your "+str(chTl)+" got damaged and...","res":"held"}

func hardenNature():
	damageToolMlt += 0.4
	return {"error":null}

func poisonedStream():
	Global.Missions.river.gatherTime["Water"] += waterAddTime
	waterAddTime += 10
	Global.Missions.river.updateGatherTime()
	var time = Global.timeGetFullFormat(Global.Missions.river.gatherTimeWBonus["Water"])
	return {"error":null,"res":"It now takes "+time+" to search for water"}

func forestOvergrown():
	Global.Missions.woods.missionTravelTime += 30
	Global.Missions.woods.updateTravelTime()
	var time = Global.timeGetFullFormat(Global.Missions.woods.missionTravelTime,false,true)
	return {"error":null,"res":"It now takes "+time+" to travel"}

func playerIll():
	var sickMlt = clamp(Global.Date.day/8,1.0,6.0)
	var sick = rng.randi_range(6, 10)*sickMlt
	var descLv
	Player.change_sick(sick)
	if(Player.sick < 20):
		descLv = "slightly" #reduces energy gain from sleep (maxEnergy - sick)
	elif(Player.sick < 50):
		descLv = "moderatly" #increases water and food consumption, reduces healing rate
	elif(Player.sick < 80):
		descLv = "very" #stops natural healing
	else:
		descLv = "dangerously" #drains health
	return {"error":null,"res":"You are "+descLv+" sick"}

func calcAttack():
	var rl = rand_range(0.9,1.1)
	return floor(clamp((float(Global.Date.day)/5)*rl,1.0,30.0))

func animalAttack():
	var level = calcAttack()
	var damage = level-Buildings.calcDefence()
	if(damage <= 0):
		return {"error":null,"res":"Your defence was enough to stop the attack \n Animal strength: "+str(level)+"\n"+" Defence level: "+str(Buildings.calcDefence())}
	else:
		var buildings = []
		for b in Buildings.Structure:
			for m in Buildings.Structure[b]:
				if typeof(Buildings.Structure[b][m]) == TYPE_DICTIONARY and Buildings.getTierInt(b,m) > 0:
					buildings.push_back([b,m])
		var rs
		if(buildings.size() == 0):
			rs = "There were no buildings to destroy"
		else:
			rs = "Following buildings were damaged: \n"
		for n in damage:
			if(buildings.size() < 1):
				break
			var r = rng.randi_range(0, buildings.size()-1)
			if Save.structures[buildings[r][0]][buildings[r][1]]["progress"] > 0:
				Save.structures[buildings[r][0]][buildings[r][1]]["progress"] = 0
			else:
				Buildings.demolish(buildings[r][0],buildings[r][1])
			rs += buildings[r][0] + " " + buildings[r][1] + "\n"
			buildings.remove(r)
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
		animalTimer += rng.randi_range(1440,2880) * ceil(float(Global.Date.getDay()) / 20) #24h-48h * day/20
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
	var amm = ceil(float(Global.Date.getDay()) / 10)
	Global.Missions.hills.enableCaveIn(amm)

func rats():
	var amm = floor(clamp(float(Global.Date.day)/8,1.0,12.0))
	var famm = Inventory.get_food_total_amm()
	amm = amm if famm >= amm else famm
	
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
		return {"error":null,"res": "There was nothing to eat"}
	var rs = "They ate: \n"
	for food in ate:
		if ate[food] > 0:
			rs += " " + str(food) + ": " + str(ate[food]) + "\n"
	return {"error":null,"res": rs}
