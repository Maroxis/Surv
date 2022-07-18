extends Control

onready var buttonsNode = get_node("../../Buttons")
onready var missionTravelTime = 0

func close(showNode = true):
	if(showNode):
		buttonsNode.show()
	self.hide()

func updateTravelTime():
	buttonsNode.get_node(self.name).updateMissionTime()

func _on_Return_Button_pressed() -> void:
	Inventory.empty_bag()
	#Player.pass_time(missionTravelTime)
	close()
