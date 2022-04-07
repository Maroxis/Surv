extends "res://scripts/Misson.gd"



func _on_Food_Button_pressed() -> void:
	Player.pass_time(150)
	Player.change_food(100, true)
	close()



func _on_Close_Button_pressed() -> void:
	close()
