extends Mission
onready var wild_berry: Control = $Resources/WildBerry

func _ready() -> void:
	missionTravelTime = 80
	updateTravelTime()
	
	gatherTime = {
		"Food": 150,
		"RawMeat": 150,
		"SmallCarcass": 120,
		"MediumCarcass": 140,
		"LargeCarcass": 160,
		"WildBerry": 30
	}
	gatherAmm = {
		"Food": "100%",
		"RawMeat": 6,
		"SmallCarcass": 1,
		"MediumCarcass": 1,
		"LargeCarcass": 1,
		"WildBerry": 4
	}
	toolReq = {
		"Food": null,
		"RawMeat": {
			"tool":"Knife",
			"tier": 1
		},
		"SmallCarcass": {
			"tool":"Knife",
			"tier": 1
		},
		"MediumCarcass": {
			"tool":"Knife",
			"tier": 2
		},
		"LargeCarcass": {
			"tool":"Knife",
			"tier": 2
		},
		"WildBerry": null
	}
	toolBonus = {
		"Food": "Knife",
		"RawMeat": "Knife",
		"SmallCarcass": "Knife",
		"MediumCarcass": "Knife",
		"LargeCarcass": "Knife",
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
	var rest = Player.eat("WildBerry", amm, false, false)
	var added = addRes("WildBerry",rest,true)
	wild_berry.shake( added or rest != amm )
