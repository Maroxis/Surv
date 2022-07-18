extends Node2D

onready var buttonsNode = get_parent()
onready var mission = get_node("../../Missions/"+self.name)

func updateMissionTime():
	get_node("PlateBG/Label").text = Global.timeGetFullFormat(mission.missionTravelTime)

func _on_TouchScreenButton_pressed() -> void:
	if(mission):
		Player.pass_time(mission.missionTravelTime)
		mission.show()
		buttonsNode.hide()
