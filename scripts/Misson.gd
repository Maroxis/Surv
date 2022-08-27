extends Control

onready var missionTravelTime = 0
onready var gatherTime = {}
onready var gatherAmm = {}
onready var toolReq = {}
onready var toolBonus= {}
onready var gatherTimeWBonus = {}
var resources

func _ready() -> void:
	Global.Weather.connect("weatherChanged",self,"updateTravelTime")

func close(showNode = true):
	if(showNode):
		Global.MissionButtons.show()
	self.hide()

func updateTravelTime():
	Global.MissionButtons.updateMissionTime(self.name,getTravelTime())

func getTravelTime():
	var travelTime = missionTravelTime
	var weatherDifficulty
	match(Global.Weather.current):
		Global.Weather.type.HeavyRain:
			weatherDifficulty = 1.4
		Global.Weather.type.Storm:
			weatherDifficulty = 2.0
		_:
			weatherDifficulty = 1.0
	travelTime = floor(travelTime*weatherDifficulty)
	return travelTime

func travel():
	var travelTime = getTravelTime()
	Player.pass_time(travelTime,false,true)
	show()
	Global.MissionButtons.hide()

func _on_Return_Button_pressed() -> void:
	Inventory.empty_bag()
	close()

func getToolBonus(name):
	var ctier = Tools.tools[name]["currentTier"]
	var bonus = Tools.tools[name]["tier"+str(ctier)]["benefits"]["actionMult"]
	return bonus

func addRes(name,amm):
	if Inventory.add_resource_to_bag(name,amm):
		Player.pass_time(gatherTimeWBonus[name],false,true)
	else:
		Global.BagUI.shake()
		
func populateInfo():
	for res in resources.get_children():
		var nm = res.name
		var amm = gatherAmm[nm]
		var time = gatherTimeWBonus[nm]
		var tlReq = toolReq[nm]
		res.populate(res.name,amm,time,tlReq)

func checkTools(tl,dn,lv):
	for res in resources.get_children():
		if(toolReq[res.name] and toolReq[res.name]["tool"] == tl):
			if(lv < toolReq[res.name]["tier"] and dn):
				res.disable()
			elif(lv >= toolReq[res.name]["tier"] and not dn):
				res.enable()
