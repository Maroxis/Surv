extends Node

var rng = RandomNumberGenerator.new()

onready var damageToolMlt = 0.8

onready var plannedEvent = {
	"event0":{
		"title":"Event 0",
		"desc": "event description",
		"function": "damageTool"
	}
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
	}
}
onready var defaultEvent = {
	"title":"Sunny Day",
	"desc": "Nothing happened"
}
onready var eventDates = [2,3,4,5,6,8]
onready var eventIndex = 0

func _ready() -> void:
	rng.randomize()

func check_event(day):
	if(eventDates[eventIndex] == day):
		var ev
		if(plannedEvent.size() > eventIndex):
			ev = plannedEvent["event"+str(eventIndex)]
		else:
			var r = rng.randi_range(0, randomEvent.size()-1)
			ev = randomEvent["event"+str(r)]
		
		var res
		if(ev.has("params")):
			res = call(ev["function"],ev["params"])
		else:
			res = call(ev["function"])
			
		showPopup(ev,res)
		
		eventIndex += 1

func showPopup(ev,res):
	if res["error"]:
		print(res["error"])
		Global.EventPopup.populate(defaultEvent["title"],defaultEvent["desc"],"")
	else:
		var title = res["title"] if res.has("title")else ev["title"]
		var desc = res["desc"] if res.has("desc") else ev["desc"]
		var txRes = res["res"] if res.has("res") else ""
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
		return {"error":null,"desc":"Your "+str(chTl)+"got damaged and...","res":"broke"}
	return {"error":null,"desc":"Your "+str(chTl)+"got damaged and...","res":"held"}

func hardenNature():
	damageToolMlt += 0.4
	return {"error":null}
