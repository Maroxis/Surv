extends "res://scripts/Misson.gd"

onready var buildScreen = get_node("../../BaseActivities/Build")

func _on_Close_Button_pressed() -> void:
	close()

func _on_Sleep_Button_pressed() -> void:
	Player.sleep()
	close()

func _on_Build_Button_pressed() -> void:
	buildScreen.show()
	buildScreen.refresh()
	close()

func _on_Craft_Button_pressed() -> void:
	close()

func _on_Status_Button_pressed() -> void:
	close()

func _on_Drink_Button_pressed() -> void:
	close()
