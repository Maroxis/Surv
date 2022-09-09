extends MissionBasic
class_name Mission

onready var missionTravelTime = 0
onready var gatherTime = {}
onready var gatherAmm = {}
onready var toolReq = {}
onready var toolBonus= {}
onready var gatherTimeWBonus = {}

var resources

func _ready() -> void:
	Global.Weather.connect("weatherChanged",self,"updateTravelTime")
	Tools.connect("toolChanged",self,"checkTools")

func updateTravelTime():
	Global.MissionButtons.updateMissionTime(self.name,getTravelTime())
	
func updateGatherTime():
	for res in resources.get_children():
		var nm = res.name
		if(toolBonus[nm] != null):
			var bonus = getToolBonus(nm)
			gatherTimeWBonus[nm] = floor(gatherTime[nm]/bonus)
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

func _on_Return_Button_pressed() -> void:
	Inventory.empty_bag()
	close()

func getToolBonus(nm):
	var name = toolBonus[nm]
	var ctier = Tools.tools[name]["currentTier"]
	if(toolReq[nm] != null):
		ctier = max(ctier-toolReq[nm]["tier"],0)
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

func missionSelected(mission):
	addRes(mission,gatherAmm[mission])
