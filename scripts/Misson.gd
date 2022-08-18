extends Control

onready var buttonsNode = get_node("../../Buttons")
onready var missionTravelTime = 0
onready var gatherTime = {}
onready var gatherTimeWBonus = {}

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
