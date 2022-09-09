extends Mission

func _ready() -> void:
	missionTravelTime = 40
	updateTravelTime()
	
	gatherTime = {
		"Wood": 50,
		"Stick": 40,
		"Leaf": 20,
		"Rock": 40
	}
	gatherAmm = {
		"Wood": 2,
		"Stick": 3,
		"Leaf": 5,
		"Rock": 2
	}
	toolReq = {
		"Wood": {
			"tool":"Axe",
			"tier": 1
		},
		"Stick": null,
		"Leaf": null,
		"Rock": null
	}
	toolBonus = {
		"Wood": "Axe",
		"Stick": "Axe",
		"Leaf": "Knife",
		"Rock": null
	}
	gatherTimeWBonus = gatherTime.duplicate()
	resources = $Resources
	populateInfo()
