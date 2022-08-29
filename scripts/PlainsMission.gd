extends "res://scripts/Misson.gd"

func _ready() -> void:
	missionTravelTime = 80
	updateTravelTime()
	
	gatherTime = {
		"Food": 150,
		"RawMeat": 150
	}
	gatherTimeWBonus = gatherTime.duplicate()
	
func updateGatherTime():
	var bonus = getToolBonus("Knife")
	gatherTimeWBonus["Food"] = floor(gatherTime["Food"]/bonus)

func _on_Food_Button_pressed() -> void:
	Player.pass_time(gatherTimeWBonus["Food"],false,true)
	Player.change_food(100, true)
	close()

func _on_Close_Button_pressed() -> void:
	close()


func _on_Meat_Button_pressed() -> void:
	addRes("RawMeat",6)
