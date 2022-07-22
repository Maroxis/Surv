extends "res://scripts/Misson.gd"

func _ready() -> void:
	missionTravelTime = 80
	updateTravelTime()
	
	gatherTime = {
	"Food": 150
	}

func updateGatherTime():
	return

func _on_Food_Button_pressed() -> void:
	Player.pass_time(floor(gatherTime["Food"]))
	Player.change_food(100, true)
	close()



func _on_Close_Button_pressed() -> void:
	close()
