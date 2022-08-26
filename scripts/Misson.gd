extends Control

onready var buttonsNode = get_node("../../Buttons")
onready var missionTravelTime = 0
onready var gatherTime = {}
onready var gatherAmm = {}
onready var toolReq = {}
onready var toolBonus= {}
onready var gatherTimeWBonus = {}
var resources

func close(showNode = true):
	if(showNode):
		buttonsNode.show()
	self.hide()

func updateTravelTime():
	buttonsNode.get_node(self.name).updateMissionTime()

func _on_Return_Button_pressed() -> void:
	Inventory.empty_bag()
	close()

func getToolBonus(name):
	var ctier = Tools.tools[name]["currentTier"]
	var bonus = Tools.tools[name]["tier"+str(ctier)]["benefits"]["actionMult"]
	return bonus

func addRes(name,amm):
	if Inventory.add_resource_to_bag(name,amm):
		Player.pass_time(gatherTimeWBonus[name])
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
