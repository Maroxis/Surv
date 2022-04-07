extends "res://scripts/Misson.gd"

func _on_Water_Button_pressed() -> void:
	Player.pass_time(20)
	Player.change_water(100, true)
	close()


func _on_Close_Button_pressed() -> void:
	close()
