extends Control

func updateMissionTime(time):
	get_node("PlateBG/Label").text = Global.timeGetFullFormat(time)

func _on_Button_pressed() -> void:
	Global.Missions.get_node(self.name).travel()
	if self.name == "Home":
		Global.Sound.play(Sound.UI_CABIN, "SFX")
	else:
		Global.Sound.play(Sound.UI_TRAVEL, "SFX")
