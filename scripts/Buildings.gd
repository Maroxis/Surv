extends Node

onready var Structure = {
	"House": {
		"currentTier": 0,
		"tier0" : {
			"benefits":{
				"sleepMult": 0.8,
				"sleepRegenMult": 1.2
			}
		},
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
		"waterLevel" : 0,
		"currentTier": 0,
		"tier0" : {
			"benefits":{
				"collectRate": 0,
				"tankSize": 0
			}
		},
		"tier1" : {
			"cost": {
				"Stick": 6,
				"Leaf": 24
			},
			"benefits":{
				"collectRate": 0.003,
				"tankSize": 30
			}
		},
		"tier2" : {
			"cost": {
				"Stick": 12,
				"Leaf": 32
			},
			"benefits":{
				"collectRate": 0.004,
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
				"collectRate": 0.005,
				"tankSize": 100
			}
		}
	},
	"Furnace": {
		"currentTier": 0,
		"tier0" : {
			"benefits":{
				"smeltable": "None"
			}
		},
		"tier1" : {
			"cost": {
				"Rock": 2
			},
			"benefits":{
				"smeltable": "Copper &\n Bronze"
			}
		},
		"tier2" : {
			"cost": {
				"Rock": 8
			},
			"benefits":{
				"smeltable": "Iron"
			}
		}
	},
	"Wall": {
		"currentTier": 0,
		"tier0" : {
			"benefits":{
				"Protection" : "none"
			}
		},
		"tier1" : {
			"cost": {
				"Stick": 12
			},
			"benefits":{
				"Protection" : "small"
			}
		},
		"tier2" : {
			"cost": {
				"Wood": 12
			},
			"benefits":{
				"Protection" : "medium"
			}
		}
	}
	
}
func checkCost(building) -> bool:
	var ctier = Structure[building]["currentTier"]
	for mat in Structure[building]["tier"+str(ctier+1)]["cost"]:
		var amm = Structure[building]["tier"+str(ctier+1)]["cost"][mat]
		if(Inventory.resources[mat]["ammount"] < amm):
			return false
	return true

func build(building):
	if(building == "Collector"):
		Global.Missions.get_node("Home").activateDrink()
	removeResources(building)
	Structure[building]["currentTier"] += 1

func demolish(building):
	if(building == "Collector"):
		Global.Missions.get_node("Home").activateDrink()
	Structure[building]["currentTier"] -= 1
	
func removeResources(building):
	var ctier = Structure[building]["currentTier"]
	for mat in Structure[building]["tier"+str(ctier+1)]["cost"]:
		var amm = Structure[building]["tier"+str(ctier+1)]["cost"][mat]
		Inventory.add_resource(mat,-amm)

func runCollector(time):
	var ctier = Structure["Collector"]["currentTier"]
	var collectRate = Structure["Collector"]["tier"+str(ctier)]["benefits"]["collectRate"]
	var weatherBonus = clamp(Global.Weather.current * 2 - 2,0,8)
	changeWaterLevel(time*collectRate*weatherBonus)
	
func changeWaterLevel(amm,set = false):
	if(set):
		Structure["Collector"]["waterLevel"] = amm
	else:
		Structure["Collector"]["waterLevel"] += amm
	var ctier = Structure["Collector"]["currentTier"]
	var tankSize = Structure["Collector"]["tier"+str(ctier)]["benefits"]["tankSize"]
	Structure["Collector"]["waterLevel"] = clamp(Structure["Collector"]["waterLevel"],0,tankSize)
	Global.Missions.get_node("Home").drinkNodeAmm.text = str(round(Structure["Collector"]["waterLevel"])) + "W"
