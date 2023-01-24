extends NodeAnimated

func _on_Food_Button_pressed() -> void:
	Global.FoodEat.open()
	Global.Sound.play(Sound.UI_DEFAULT_SHORT, "SFX")
