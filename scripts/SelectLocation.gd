extends Node2D

onready var buttonsNode = get_parent()
onready var mission = get_node("../../Missions/"+self.name)

func _on_TouchScreenButton_pressed() -> void:
	if(mission):
		mission.show()
		buttonsNode.hide()
