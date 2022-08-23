extends Node

var rng = RandomNumberGenerator.new()

onready var forceEvent = null

onready var damageToolMlt = 0.8
onready var waterDryAddTime = 15

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
		"title":"Hot Weather",
		"desc": "Nearby stream dried out. Now it takes more time to search for water",
		"function": "driedStream"
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
	}
}
onready var defaultEvent = {
	"title":"Calm Day",
	"desc": "Nothing happened"
}
#onready var eventDates = [2,3,4,5,6,7,8,9]
onready var eventDates = [5]
onready var eventIndex = 0

func _ready() -> void:
	rng.randomize()

func check_event(day):
	if(eventIndex+1 > eventDates.size()):
		return
	if(eventDates[eventIndex] == day):
		var ev
		if(plannedEvent.size() > eventIndex):
			ev = plannedEvent["event"+str(eventIndex)]
		else:
			var r = forceEvent if forceEvent else rng.randi_range(0, randomEvent.size()-1)
			ev = randomEvent["event"+str(r)]
		
		var res
		if(ev.has("params")):
			res = call(ev["function"],ev["params"])
		else:
			res = call(ev["function"])
			
		showPopup(ev,res)
		
		eventIndex += 1

func showPopup(ev,res):
	var title = ev["title"] if ev.has("title") else ""
	var desc =  ev["desc"] if ev.has("desc") else ""
	var txRes = ""
	if res:
		if res["error"]:
			print(res["error"])
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
	
func test(a = ["error no args"]):
	for item in a:
		print(item)
	return {"error":null}

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
		if Tools.tools[tl]["currentTier"] != 0:
			ownedTools.push_back(tl)
	if(ownedTools.size() == 0):
		return {"error":"no owned tool"}
	var r = rng.randi_range(0, ownedTools.size()-1)
	var chTl = ownedTools[r]
	var damage = floor(damageToolMlt)
	var rf = rng.randf_range(0.0, 1.0)
	damage = damage + 1 if fmod(damageToolMlt,1.0) > rf else damage
	if(damage == 0):
		return {"error":null,"desc":"Your "+str(chTl)+" holds strong"}
	var ctier = Tools.tools[chTl]["currentTier"]
	Tools.tools[chTl]["tier"+str(ctier)]["curDurability"] -= damage
	if(Tools.tools[chTl]["tier"+str(ctier)]["curDurability"]) < 1:
		Tools.tools[chTl]["currentTier"] -= 1
		Tools.updateTool(chTl,true)
		return {"error":null,"desc":"Your "+str(chTl)+" got damaged and...","res":"broke"}
	return {"error":null,"desc":"Your "+str(chTl)+" got damaged and...","res":"held"}

func hardenNature():
	damageToolMlt += 0.4
	return {"error":null}

func driedStream():
	Global.Missions.river.gatherTime["Water"] += waterDryAddTime
	Global.Missions.river.updateGatherTime()
	var time = Global.timeGetFullFormat(Global.Missions.river.gatherTimeWBonus["Water"])
	return {"error":null,"res":"It now takes "+time+" to search for water"}

func forestOvergrown():
	Global.Missions.woods.missionTravelTime += 20
	Global.Missions.woods.updateTravelTime()
	var time = Global.timeGetFullFormat(Global.Missions.woods.missionTravelTime,false,true)
	return {"error":null,"res":"It now takes "+time+" to travel"}

func playerIll():
	var sickMlt = clamp(Global.Date.day/10,1.0,5.0)
	var sick = rng.randi_range(5, 20)*sickMlt
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

func animalAttack():
	var level = floor(clamp(Global.Date.day/10,1.0,5.0))
	var damage = level-Buildings.Structure["Wall"]["currentTier"]
	if(damage <= 0):
		return {"error":null,"res":"Your wall has stopped the attack"}
	else:
		var buildings = []
		for b in Buildings.Structure:
			if Buildings.Structure[b]["currentTier"] > 0:
				buildings.push_back(b)
		var rs
		if(buildings.size() == 0):
			rs = "There were no buildings to destroy"
		else:
			rs = "Following buildings were damaged: \n"
		for n in damage:
			if(buildings.size() < 1):
				break
			var r = rng.randi_range(0, buildings.size()-1)
			var nm = buildings[r]
			Buildings.demolish(nm)
			rs += nm + "\n"
			buildings.remove(r)
		return {"error":null,"res": rs}
