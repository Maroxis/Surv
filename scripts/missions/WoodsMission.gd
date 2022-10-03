extends Mission

onready var herb: Control = $Resources/Herb

func _ready() -> void:
	missionTravelTime = 40
	gatherTime = {
		"Wood": 60,
		"Stick": 50,
		"Leaf": 40,
		"Rock": 20,
		"Herb": 50
	}
	gatherAmm = {
		"Wood": 3,
		"Stick": 3,
		"Leaf": 10,
		"Rock": 2,
		"Herb": 3
	}
	toolReq = {
		"Wood": {
			"tool":"Axe",
			"tier": 1
		},
		"Stick": null,
		"Leaf": null,
		"Rock": null,
		"Herb": {
			"tool":"Knife",
			"tier": 1
		}
	}
	toolBonus = {
		"Wood": "Axe",
		"Stick": "Axe",
		"Leaf": "Knife",
		"Rock": null,
		"Herb": "Knife"
	}
	gatherTimeWBonus = gatherTime.duplicate()
	resources = $Resources
	updateTravelTime()
	populateInfo()

func toggleHerb():
	var time = Global.Date.getTime()
	time = floor(time / 60)
	if time >= 22 or time <= 6:
		herb.show()
	else:
		herb.hide()

func _on_Woods_visibility_changed() -> void:
	if visible:
		toggleHerb()
