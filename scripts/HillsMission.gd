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
