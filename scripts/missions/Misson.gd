extends MissionBasic
class_name Mission

onready var missionTravelTime = 0
onready var gatherTime = {}
onready var gatherAmm = {}
onready var toolReq = {}
onready var toolBonus= {}
onready var gatherTimeWBonus = {}
onready var inOpen = true

var resources
signal missionOpened

func _ready() -> void:
	Global.Weather.connect("weatherChanged",self,"updateTravelTime")
# warning-ignore:return_value_discarded
	Tools.connect("toolChanged",self,"checkTools")

func refresh():
	updateTravelTime()
	updateGatherTime()

func updateTravelTime():
	Global.MissionButtons.updateMissionTime(self.name,getTravelTime())
	
func updateGatherTime():
	for res in resources.get_children():
		var nm = res.name
		if(toolBonus[nm] != null):
			var bonus = getToolBonus(nm)
			gatherTimeWBonus[nm] = floor(gatherTime[nm]/bonus)
		else:
			gatherTimeWBonus[nm] = gatherTime[nm]
		res.updateGatherTime(gatherTimeWBonus[nm])
		
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
	self.rect_position.y = pos.y + self.rect_size.y
	show()
	var tween = create_tween().set_ease(Tween.EASE_IN)
	tween.tween_property(self, "rect_position:y", pos.y, 0.4)
	emit_signal("missionOpened")

func _on_Return_Button_pressed() -> void:
	Inventory.empty_bag()
	close()

func getToolBonus(nm):
	if(toolReq[nm]):
		return Tools.getBonus(toolBonus[nm],toolReq[nm]["tier"])
	else:
		return Tools.getBonus(toolBonus[nm])

func addRes(name,amm, food = false):
	if Inventory.add_resource_to_bag(name,amm,food):
		Player.pass_time(gatherTimeWBonus[name],false,inOpen)
		return true
	else:
		Global.BagUI.shake()
		return false

func populateInfo():
	for res in resources.get_children():
		var nm = res.name
		var amm = gatherAmm[nm]
		var time = gatherTimeWBonus[nm]
		var tlReq = toolReq[nm]
		res.populate(res.name,amm,time,tlReq)
		if res.connectMission:
			res.connect("missionSelected",self,"missionSelected")

func checkTools(tl,dn,lv):
	for res in resources.get_children():
		if(toolReq[res.name] and toolReq[res.name]["tool"] == tl):
			if(lv < toolReq[res.name]["tier"] and dn):
				res.disable()
			elif(lv >= toolReq[res.name]["tier"] and not dn):
				res.enable()
	updateGatherTime()

func missionSelected(mission,food,node):
	var sucess = addRes(mission,gatherAmm[mission],food)
	node.shake(sucess)

func pack():
	var data = {}
	data["missionTravelTime"] = missionTravelTime
	data["gatherTime"] = gatherTime
	return data

func unpack(data):
	Save.add_original_keys(gatherTime,data["gatherTime"])
	if data.has("missionTravelTime"):
		missionTravelTime = data["missionTravelTime"]
	if data.has("gatherTime"):
		gatherTime = data["gatherTime"]
	return
