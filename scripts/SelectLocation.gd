extends Control

func updateMissionTime(time):
	get_node("PlateBG/Label").text = Global.timeGetFullFormat(time)

func _on_Button_pressed() -> void:
	Global.Missions.get_node(self.name).travel()
	Global.Sound.play(Sound.UI_DEFAULT, "SFX")
