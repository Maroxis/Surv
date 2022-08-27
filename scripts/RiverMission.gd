extends "res://scripts/Misson.gd"

func _ready() -> void:
	missionTravelTime = 20
	updateTravelTime()
	
	gatherTime = {
		"Water": 10,
		"Clay": 35
	}
	gatherTimeWBonus = gatherTime.duplicate()
	
func updateGatherTime():
	var bonus = getToolBonus("Shovel")
	gatherTimeWBonus["Clay"] = floor(gatherTime["Clay"]/bonus)
	get_node("HBox/Clay/VBox/Time").text = Global.timeGetFullFormat(gatherTimeWBonus["Clay"])
	
	gatherTimeWBonus["Water"] = gatherTime["Water"]
	get_node("HBox/Water/VBox/Time").text = Global.timeGetFullFormat(gatherTimeWBonus["Water"])

func _on_Water_Button_pressed() -> void:
	Player.pass_time(floor(gatherTimeWBonus["Water"]),false,true)
	Player.change_water(Player.maxWater, true)
	close()

func _on_Close_Button_pressed() -> void:
	close()

func _on_Clay_Button_pressed() -> void:
	addRes("Clay",2)
