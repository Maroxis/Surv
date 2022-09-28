extends Mission

func _ready() -> void:
	missionTravelTime = 40
	updateTravelTime()
	
	gatherTime = {
		"Wood": 60,
		"Stick": 50,
		"Leaf": 40,
		"Rock": 20
	}
	gatherAmm = {
		"Wood": 3,
		"Stick": 3,
		"Leaf": 10,
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
