extends Node2D

onready var buttonsNode = get_parent()

func _on_TouchScreenButton_pressed() -> void:
	var mission = get_node("../../Missions/"+self.name)
	if(mission):
		mission.show()
		buttonsNode.hide()
