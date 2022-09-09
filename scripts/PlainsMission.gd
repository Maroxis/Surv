extends "res://scripts/Misson.gd"

func _ready() -> void:
	missionTravelTime = 80
	updateTravelTime()
	
	gatherTime = {
		"Food": 150,
		"RawMeat": 150,
		"WildBerry": 30
	}
	gatherAmm = {
		"Food": "100%",
		"RawMeat": 6,
		"WildBerry": 4
	}
	toolReq = {
		"Food": null,
		"RawMeat": {
			"tool":"Knife",
			"tier": 1
		},
		"WildBerry": null
	}
	toolBonus = {
		"Food": "Knife",
		"RawMeat": "Knife",
		"WildBerry": "Knife"
	}
	gatherTimeWBonus = gatherTime.duplicate()
	resources = $Resources
	populateInfo()

func _on_Food_Button_pressed() -> void:
	Player.pass_time(gatherTimeWBonus["Food"],false,true)
	Player.change_food(100, true)
	close()

func _on_Meat_Button_pressed() -> void:
	addRes("RawMeat",6)


func _on_Berries_Button_pressed() -> void:
	var amm = 4
	amm = Player.eat("WildBerry",amm)
	addRes("WildBerry",amm)
