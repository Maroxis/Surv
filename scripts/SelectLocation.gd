extends Node2D

func updateMissionTime(time):
	get_node("PlateBG/Label").text = Global.timeGetFullFormat(time)

func _on_TouchScreenButton_pressed() -> void:
	Global.Missions.get_node(self.name).travel()
