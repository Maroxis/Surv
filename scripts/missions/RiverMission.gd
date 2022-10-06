extends Mission
onready var water: Control = $Resources/Water

func _ready() -> void:
	missionTravelTime = 20
	updateTravelTime()
	
	gatherTime = {
		"Water": 10,
		"Clay": 35,
		"Sand": 20
	}
	gatherTimeWBonus = gatherTime.duplicate()

	gatherAmm = {
		"Water": "100%",
		"Clay": 3,
		"Sand": 5
	}
	toolReq = {
		"Water": null,
		"Clay": {
			"tool":"Shovel",
			"tier": 1
		},
		"Sand": {
			"tool":"Shovel",
			"tier": 1
		}
	}
	toolBonus = {
		"Water": null,
		"Clay": "Shovel",
		"Sand": "Shovel"
	}
	resources = $Resources
	populateInfo()

func _on_Water_Button_pressed() -> void:
	Player.pass_time(floor(gatherTimeWBonus["Water"]),false,true)
	Player.change_water(Player.maxWater, true)
	water.shake(true)
