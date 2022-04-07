extends "res://scripts/Misson.gd"



func _on_Close_Button_pressed() -> void:
	close()


func _on_Sleep_Button_pressed() -> void:
	Player.sleep()
	close()
