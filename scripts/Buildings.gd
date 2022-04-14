extends Node

onready var Structure = {
	"House": {
		"currentTier": 0,
		"tier1" : {
			"cost": {
				"Stick": 5,
				"Leaf": 7
			},
			"benefits":{
				"sleepMult": 0.7,
				"sleepRegenMult": 1.3
			}
		},
		"tier2" : {
			"cost": {
				"Stick": 4,
				"Leaf": 16
			},
			"benefits":{
				"sleepMult": 0.6,
				"sleepRegenMult": 1.5
			}
		},
		"tier3" : {
			"cost": {
				"Wood": 6,
				"Stick": 12,
				"Leaf": 24
			},
			"benefits":{
				"sleepMult": 0.5,
				"sleepRegenMult": 1.8
			}
		}
	},
	"Collector": {
		"currentTier": 0,
		"tier1" : {
			"cost": {
				"Stick": 6,
				"Leaf": 24
			},
			"benefits":{
				"collectRate": 0.00015,
				"tankSize": 30
			}
		},
		"tier2" : {
			"cost": {
				"Stick": 12,
				"Leaf": 32
			},
			"benefits":{
				"collectRate": 0.0002,
				"tankSize": 50
			}
		},
		"tier3" : {
			"cost": {
				"Wood": 6,
				"Stick": 12,
				"Leaf": 24
			},
			"benefits":{
				"collectRate": 0.0003,
				"tankSize": 100
			}
		}
	},
	"Furnace": {
		"currentTier": 0,
		"tier1" : {
			"cost": {
				"Stone": 6
			},
			"benefits":{
				"smeltable": "Copper"
			}
		},
		"tier2" : {
			"cost": {
				"Stone": 36
			},
			"benefits":{
				"smeltable": "Iron"
			}
		}
	},
	"Wall": {
		"currentTier": 0,
		"tier1" : {
			"cost": {
				"Wood": 12
			},
			"benefits":{
			}
		}
	}
	
}
