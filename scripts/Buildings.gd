extends Node

onready var Structure = {
	"House": {
		"Bed":{
			"currentTier": 0,
			"benefitsText":{
				"sleepRegenMult": "Energy recovery multiplayer during sleep"
			},
			"tier0" : {
				"benefits":{
					"sleepRegenMult": 1.1
				}
			},
			"tier1" : {
				"cost": {
					"Stick": 2,
					"Leaf": 1
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"sleepRegenMult": 1.2
				}
			},
			"tier2" : {
				"cost": {
					"Stick": 2,
					"Leaf": 1
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"sleepRegenMult": 1.3
				}
			},
		},
		"Frame":{
			"currentTier": 0,
			"benefitsText":{
				"enable": "Enables building other modules"
			},
			"tier0" : {
				"benefits":{
					"enable": null
				}
			},
			"tier1" : {
				"cost": {
					"Stick": 2,
					"Leaf": 3
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"enable": ["Wall","Roof"]
				}
			}
		},
		"Wall":{
			"currentTier": 0,
			"benefitsText":{
				"defence": "Increases defence"
			},
			"tier0" : {
				"benefits":{
					"defence": 0
				}
			},
			"tier1" : {
				"cost": {
					"Stick": 2,
					"Leaf": 3
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"defence": 1
				},
				"required":{
					"module":{
						"Frame": 1
					}
				}
			},
			"tier2" : {
				"cost": {
					"Stick": 2,
					"Leaf": 3
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"defence": 2
				},
				"required":{
					"module":{
						"Frame": 1
					}
				}
			}
		},
		"Roof":{
			"currentTier": 0,
			"benefitsText":{
				"roofed": "Keeps fire lit while raining",
				"defence": "Improves defence"
			},
			"tier0" : {
				"benefits":{
					"roofed": false,
					"defence": 0
				}
			},
			"tier1" : {
				"cost": {
					"Stick": 2,
					"Leaf": 3
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"roofed": true,
					"defence": 0
				},
				"required":{
					"module":{
						"Frame": 1
					}
				}
			},
			"tier2" : {
				"cost": {
					"Stick": 2,
					"Leaf": 3
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"roofed": true,
					"defence": 1
				},
				"required":{
					"module":{
						"Frame": 1
					}
				}
			}
		},
	},
	"Collector": {
		"waterLevel" : 0,
		"Catcher" : {
			"currentTier": 0,
			"benefitsText":{
				"collectRate": "Increases water collect rate"
			},
			"tier0" : {
				"benefits":{
					"collectRate": 0.001
				}
			},
			"tier1" : {
				"cost": {
					"Stick": 2,
					"Leaf": 3
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"collectRate": 0.003
				},
				"required":{
					"module":{
						"Tank": 1
					}
				}
			},
			"tier2" : {
				"cost": {
					"Stick": 2,
					"Leaf": 3
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"collectRate": 0.004
				},
				"required":{
					"module":{
						"Tank": 1
					}
				}
			},
			"tier3" : {
				"cost": {
					"Stick": 2,
					"Leaf": 3
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"collectRate": 0.005
				},
				"required":{
					"module":{
						"Tank": 1
					}
				}
			}
		},
		"Tank" : {
			"currentTier": 0,
			"benefitsText":{
				"tankSize": "Increases water tank size"
			},
			"tier0" : {
				"benefits":{
					"tankSize": 0
				}
			},
			"tier1" : {
				"cost": {
					"Stick": 2,
					"Leaf": 3
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"tankSize": 30
				}
			},
			"tier2" : {
				"cost": {
					"Stick": 2,
					"Leaf": 3
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"tankSize": 80
				}
			},
			"tier3" : {
				"cost": {
					"Stick": 2,
					"Leaf": 3
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"tankSize": 200
				}
			}
		},
		"Filter" : {
			"currentTier": 0,
			"benefitsText":{
				"filter": "Reduces polution, making water safer to drink"
			},
			"tier0" : {
				"benefits":{
					"filter": 0
				}
			},
			"tier1" : {
				"cost": {
					"Stick": 2,
					"Leaf": 3
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"filter": 0.2
				},
				"required":{
					"module":{
						"Tank": 1
					}
				}
			},
			"tier2" : {
				"cost": {
					"Stick": 2,
					"Leaf": 3
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"filter": 0.6
				},
				"required":{
					"module":{
						"Tank": 1
					}
				}
			},
			"tier3" : {
				"cost": {
					"Stick": 2,
					"Leaf": 3
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"filter": 1.4
				},
				"required":{
					"module":{
						"Tank": 1
					}
				}
			}
		}
	},
	"Furnace": {
		"Oven":{
			"currentTier": 0,
			"benefitsText":{
				"smeltable": "Allows smelting new metals"
			},
			"tier0" : {
				"benefits":{
					"smeltable": null
				}
			},
			"tier1" : {
				"cost": {
					"Stick": 2,
					"Leaf": 3
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"smeltable": "Copper and Bronze"
				}
			}
		},
		"Bellows":{
			"currentTier": 0,
			"benefitsText":{
				"timeMult": "Smelting time multiplayer"
			},
			"tier0" : {
				"benefits":{
					"timeMult": 1
				}
			},
			"tier1" : {
				"cost": {
					"Stick": 2,
					"Leaf": 3
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"timeMult": 0.8
				},
				"required":{
					"module":{
						"Oven": 1
					}
				}
			}
		}
	},
	"Perimeter": {
		"Fence":{
			"currentTier": 0,
			"benefitsText":{
				"defence": "Increses camp defence"
			},
			"tier0" : {
				"benefits":{
					"defence": 0
				}
			},
			"tier1" : {
				"cost": {
					"Stick": 2,
					"Leaf": 3
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"defence": 1
				}
			}
		},
		"Trench":{
			"currentTier": 0,
			"benefitsText":{
				"defence": "Increses camp defence"
			},
			"tier0" : {
				"benefits":{
					"defence": 0
				}
			},
			"tier1" : {
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"defence": 1
				},
				"required":{
					"tool":{
						"Shovel": 1
					}
				}
			}
		}
	}
}
	
func calcDefence():
	var defence = 0
	defence += getCurrentModule("Perimeter","Fence")["benefits"]["defence"]
	defence += getCurrentModule("House","Wall")["benefits"]["defence"]
	defence += getCurrentModule("House","Roof")["benefits"]["defence"]
	return defence
	

func checkCost(building,module) -> bool:
	var ntier = getTier(building,module,true)
	for mat in Structure[building][module][ntier]["cost"]:
		var amm = Structure[building][module][ntier]["cost"][mat]
		if(Inventory.resources[mat]["ammount"] < amm):
			return false
	return true

#func build(building):
#	if(building == "Collector"):
#		Global.Missions.get_node("Home").activateDrink()
#	removeResources(building)
#	Structure[building]["currentTier"] += 1

func buildModule(building,module):
	Structure[building][module]["currentTier"] += 1
	getCurrentModule(building,module)["time"]["completed"] = 0

func buyModule(building,module):
	var ntier = getTier(building,module,true)
	for res in Structure[building][module][ntier]["cost"]:
		var amm = Structure[building][module][ntier]["cost"][res]
		Inventory.add_resource(res,-amm)
		
func getTier(building,module,next = false):
	
	var tier = getTierInt(building,module,next)
	if(tier == null):
		return null
	else:
		return "tier"+str(tier)
func getTierInt(building,module,next = false):
	var tier = Structure[building][module]["currentTier"] + (1 if next else 0)
	if(next and not Structure[building][module].has("tier"+str(tier))):
		return null
	else:
		return tier

func getCurrentModule(building,module):
	var tier = getTier(building,module)
	return Structure[building][module][tier]

func demolish(building,module):
	Structure[building][module]["currentTier"] -= 1

func runCollector(time):
	var collectRate = getCurrentModule("Collector","Catcher")["benefits"]["collectRate"]
	var weatherBonus = max(Global.Weather.current-1,0) * max(Global.Weather.current-1,0)
	changeWaterLevel(time*collectRate*weatherBonus)
	
func changeWaterLevel(amm,set = false):
	if(set):
		Structure["Collector"]["waterLevel"] = amm
	else:
		Structure["Collector"]["waterLevel"] += amm
	var tankSize = getCurrentModule("Collector","Tank")["benefits"]["tankSize"]
	Structure["Collector"]["waterLevel"] = clamp(Structure["Collector"]["waterLevel"],0,tankSize)
	Global.Missions.get_node("Home").drinkNodeAmm.text = str(round(Structure["Collector"]["waterLevel"])) + "W"
