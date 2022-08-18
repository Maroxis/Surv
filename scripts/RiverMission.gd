extends "res://scripts/Misson.gd"

func _ready() -> void:
	missionTravelTime = 20
	updateTravelTime()
	
	gatherTime = {
		"Water": 10,
		"Clay": 35
	}
	gatherTimeWBonus = gatherTime
	
func updateGatherTime():
	var bonus = getToolBonus("Shovel")
	gatherTimeWBonus["Clay"] = floor(gatherTime["Clay"]/bonus)
	get_node("HBox/Clay/VBox/Time").text = Global.timeGetFullFormat(gatherTimeWBonus["Clay"])

func _on_Water_Button_pressed() -> void:
	Player.change_water(Player.maxWater, true)
	Player.pass_time(floor(gatherTime["Water"]))
	close()

func _on_Close_Button_pressed() -> void:
	close()

func _on_Clay_Button_pressed() -> void:
	addRes("Clay",2)
