extends "res://scripts/Misson.gd"

func _ready() -> void:
	missionTravelTime = 160
	updateTravelTime()
	
	gatherTime = {
		"Rock": 30,
		"CopperOre": 50
	}
	gatherTimeWBonus = gatherTime.duplicate()
	
func updateGatherTime():
	var bonus = getToolBonus("Pickaxe")
	gatherTimeWBonus["Rock"] = floor(gatherTime["Rock"]/bonus)
	gatherTimeWBonus["CopperOre"] = floor(gatherTime["CopperOre"]/bonus)
	
	get_node("HBox/Rocks/VBox/Time").text = Global.timeGetFullFormat(gatherTimeWBonus["Rock"])
	get_node("HBox/CopperOre/VBox/Time").text = Global.timeGetFullFormat(gatherTimeWBonus["CopperOre"])

func _on_Rocks_Button_pressed() -> void:
	addRes("Rock",10)

func _on_CopperOre_Button_pressed() -> void:
	addRes("CopperOre",3)
