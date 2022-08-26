extends "res://scripts/Misson.gd"

func _ready() -> void:
	missionTravelTime = 160
	updateTravelTime()
	gatherTime = {
		"Rock": 30,
		"CopperOre": 50,
		"TinOre": 30,
		"Coal": 20
	}
	gatherAmm = {
		"Rock": 10,
		"CopperOre": 3,
		"TinOre": 6,
		"Coal": 5
	}
	toolReq = {
		"Rock": null,
		"CopperOre": {
			"tool":"Pickaxe",
			"tier": 1
		},
		"TinOre": {
			"tool":"Pickaxe",
			"tier": 2
		},
		"Coal": {
			"tool":"Pickaxe",
			"tier": 1
		}
	}
	toolBonus = {
		"Rock": "Pickaxe",
		"CopperOre": "Pickaxe",
		"TinOre": "Pickaxe",
		"Coal": "Pickaxe"
	}
	gatherTimeWBonus = gatherTime.duplicate()
	resources = $Resources
	populateInfo()
	Tools.connect("toolChanged",self,"checkTools")

func updateGatherTime():
	for res in resources.get_children():
		var nm = res.name
		var bonus = getToolBonus(toolBonus[nm])
		gatherTimeWBonus[nm] = floor(gatherTime[nm]/bonus)
		res.updateGatherTime(gatherTimeWBonus[nm])
#	gatherTimeWBonus["Rock"] = floor(gatherTime["Rock"]/bonus)
#	gatherTimeWBonus["CopperOre"] = floor(gatherTime["CopperOre"]/bonus)
#	gatherTimeWBonus["Coal"] = floor(gatherTime["Coal"]/bonus)
	
#	get_node("HBox/Rocks/VBox/Time").text = Global.timeGetFullFormat(gatherTimeWBonus["Rock"])
#	get_node("HBox/CopperOre/VBox/Time").text = Global.timeGetFullFormat(gatherTimeWBonus["CopperOre"])
#	get_node("HBox/Coal/VBox/Time").text = Global.timeGetFullFormat(gatherTimeWBonus["Coal"])

func _on_Rocks_Button_pressed() -> void:
	addRes("Rock",gatherAmm["Rock"])

func _on_CopperOre_Button_pressed() -> void:
	addRes("CopperOre",gatherAmm["CopperOre"])


func _on_Coal_Button_pressed() -> void:
	addRes("Coal",gatherAmm["Coal"])


func _on_TinOre_Button_pressed() -> void:
	addRes("TinOre",gatherAmm["TinOre"])
