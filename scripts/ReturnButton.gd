extends Control

func _on_Button_pressed() -> void:
	if Global.Sound:
		Global.Sound.play(Sound.UI_DEFAULT_SHORT, "SFX")
