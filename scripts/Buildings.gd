extends Node

onready var Structure = {
	"House": {
		"Bed":{
			"benefitsText":{
				"sleepRegenMult": "Energy recovery and sickness reduction multiplayer during sleep"
			},
			"tier0" : {
				"benefits":{
					"sleepRegenMult": 1.1
				}
			},
			"tier1" : {
				"cost": {
					"Leaf": 24
				},
				"time":{
					"sections": 3,
					"completed": 0,
					"ammount": 60
				},
				"benefits":{
					"sleepRegenMult": 1.4
				}
			},
			"tier2" : {
				"cost": {
					"Stick": 8,
					"Thread": 12,
					"Rope": 4
				},
				"time":{
					"sections": 6,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"sleepRegenMult": 1.8
				}
			},
			"tier3" : {
				"cost": {
					"Leaf": 48
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 60
				},
				"benefits":{
					"sleepRegenMult": 2.2
				}
			}
		},
		"Frame":{
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
					"Stick": 6,
					"Thread": 3
				},
				"time":{
					"sections": 3,
					"completed": 0,
					"ammount": 20
				},
				"benefits":{
					"enable": "Roof"
				}
			},
			"tier2" : {
				"cost": {
					"Wood": 8,
					"Stick": 5,
					"Rope": 6
				},
				"time":{
					"sections": 5,
					"completed": 0,
					"ammount": 50
				},
				"benefits":{
					"enable": "Wall"
				}
			}
		},
		"Wall":{
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
					"Wood": 8,
					"Stick": 64
				},
				"time":{
					"sections": 4,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"defence": 3
				},
				"required":{
					"module":{
						"Frame": 2
					}
				}
			},
			"tier2" : {
				"cost": {
					"Wood": 32
				},
				"time":{
					"sections": 8,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"defence": 8
				},
				"required":{
					"module":{
						"Frame": 2
					}
				}
			}
		},
		"Roof":{
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
					"Stick": 12,
					"Leaf": 40
				},
				"time":{
					"sections": 4,
					"completed": 0,
					"ammount": 60
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
					"Plank": 32
				},
				"time":{
					"sections": 4,
					"completed": 0,
					"ammount": 40
				},
				"benefits":{
					"roofed": true,
					"defence": 3
				},
				"required":{
					"module":{
						"Frame": 2
					}
				}
			}
		},
	},
	"Collector": {
		"waterLevel": 0,
		"Catcher" : {
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
					"Stick": 3,
					"Thread": 3,
					"Leaf": 9
				},
				"time":{
					"sections": 3,
					"completed": 0,
					"ammount": 20
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
					"Stick": 9,
					"Thread": 9,
					"Leaf": 27
				},
				"time":{
					"sections": 4,
					"completed": 0,
					"ammount": 40
				},
				"benefits":{
					"collectRate": 0.006
				},
				"required":{
					"module":{
						"Tank": 1
					}
				}
			},
			"tier3" : {
				"cost": {
					"Stick": 27,
					"Thread": 27,
					"Leaf": 81
				},
				"time":{
					"sections": 4,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"collectRate": 0.012
				},
				"required":{
					"module":{
						"Tank": 1
					}
				}
			}
		},
		"Tank" : {
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
					"Clay": 5
				},
				"time":{
					"sections": 1,
					"completed": 0,
					"ammount": 40
				},
				"benefits":{
					"tankSize": 30
				}
			},
			"tier2" : {
				"cost": {
					"Clay": 25
				},
				"time":{
					"sections": 3,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"tankSize": 80
				}
			},
			"tier3" : {
				"cost": {
					"Plank": 16
				},
				"time":{
					"sections": 6,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"tankSize": 80
				}
			}
		},
		"Filter" : {
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
					"Stick": 4,
					"Leaf": 12
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 40
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
					"Stick": 6,
					"Thread": 32
				},
				"time":{
					"sections": 3,
					"completed": 0,
					"ammount": 40
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
					"Stick": 6,
					"Thread": 32,
					"Sand": 8,
					"Clay": 2
				},
				"time":{
					"sections": 4,
					"completed": 0,
					"ammount": 40
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
					"Clay": 20,
				},
				"time":{
					"sections": 3,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"smeltable": "Copper and Bronze"
				}
			},
			"tier2" : {
				"cost": {
					"Rock": 30,
					"Clay": 10
				},
				"time":{
					"sections": 5,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"smeltable": "Iron"
				}
			}
		},
		"Bellows":{
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
					"Leather": 3,
					"Thread": 6
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
					"Stick": 40,
					"Thread": 10
				},
				"time":{
					"sections": 8,
					"completed": 0,
					"ammount": 40
				},
				"benefits":{
					"defence": 2
				}
			},
			"tier2" : {
				"cost": {
					"Wood": 40
				},
				"time":{
					"sections": 8,
					"completed": 0,
					"ammount": 40
				},
				"benefits":{
					"defence": 7
				}
			}
		},
		"Trench":{
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
					"sections": 12,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"defence": 3
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

func _ready() -> void:
	Save.add_missing_keys_deep(Structure,Save.structures,TYPE_DICTIONARY,0,{"ctier":TYPE_INT,"progress":TYPE_INT})

func calcDefence():
	var defence = 0
	defence += getCurrentModule("Perimeter","Fence")["benefits"]["defence"]
	defence += getCurrentModule("Perimeter","Trench")["benefits"]["defence"]
	defence += getCurrentModule("House","Wall")["benefits"]["defence"]
	defence += getCurrentModule("House","Roof")["benefits"]["defence"]
	return defence
	

func checkCost(building,module) -> bool:
	var ntier = getTier(building,module,true)
	for mat in Structure[building][module][ntier]["cost"]:
		var amm = Structure[building][module][ntier]["cost"][mat]
		if(Inventory.get_res_amm(mat) < amm):
			return false
	return true

func buildModule(building,module):
	Save.structures[building][module]["ctier"] += 1
	Save.structures[building][module]["progress"] = 0
#	getCurrentModule(building,module)["time"]["completed"] = 0

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
	var tier = int(Save.structures[building][module]["ctier"] + (1 if next else 0))
	if(next and not Structure[building][module].has("tier"+str(tier))):
		return null
	else:
		return tier

func getCurrentModule(building,module):
	var tier = getTier(building,module)
	return Structure[building][module][tier]

func demolish(building,module):
	Save.structures[building][module]["ctier"] -= 1

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
