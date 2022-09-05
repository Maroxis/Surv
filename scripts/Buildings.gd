extends Node

onready var Structure = {
	"House": {
		"Bed":{
			"currentTier": 0,
			"benefitsText":{
				"sleepMult": "Food/Water consumption multiplayer during sleep",
				"sleepRegenMult": "Energy recovery multiplayer during sleep"
			},
			"tier0" : {
				"benefits":{
					"sleepConsumeMult": 0.9,
					"sleepRegenMult": 1.1
				}
			},
			"tier1" : {
				"cost": {
					"Stick": 5,
					"Leaf": 7
				},
				"benefits":{
					"sleepConsumeMult": 0.8,
					"sleepRegenMult": 1.2
				}
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
			},
			"benefitsText":{
				"collectRate": "Water collection rate per minute",
				"tankSize": "Water storage tank"
			}
		},
		"tier1" : {
			"cost": {
				"Stick": 1,
				"Leaf": 2
			},
			"benefits":{
				"collectRate": 0.003,
				"tankSize": 30
			}
		},
		"tier2" : {
			"cost": {
				"Stick": 2,
				"Leaf": 3
			},
			"benefits":{
				"collectRate": 0.004,
				"tankSize": 50
			}
		},
		"tier3" : {
			"cost": {
				"Wood": 1,
				"Stick": 3,
				"Leaf": 4
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
				"smeltable": ""
			},
			"benefitsText":{
				"smeltable": "Allows to smelt more metals"
			}
		},
		"tier1" : {
			"cost": {
				"Rock": 2
			},
			"benefits":{
				"smeltable": "Copper and Bronze"
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
				"Protection" : 0
			},
			"benefitsText":{
				"Protection": "Increases protection"
			}
		},
		"tier1" : {
			"cost": {
				"Stick": 12
			},
			"benefits":{
				"Protection" : 1
			}
		},
		"tier2" : {
			"cost": {
				"Wood": 12
			},
			"benefits":{
				"Protection" : 2
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
	var weatherBonus = max(Global.Weather.current-1,0) * max(Global.Weather.current-1,0)
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
