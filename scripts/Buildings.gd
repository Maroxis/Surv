extends Node

onready var Structure = {
	"House": {
		"Bed":{
			"benefitsText":{
				"sleepRegenMult": "Energy recovery and sickness reduction multiplayer during sleep"
			},
			"tier0" : {
				"benefits":{
					"sleepRegenMult": 1.2
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
					"sleepRegenMult": 1.6
				}
			},
			"tier3" : {
				"cost": {
					"Cloth": 6,
					"Thread": 4
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 60
				},
				"benefits":{
					"sleepRegenMult": 1.8
				}
			},
			"tier4" : {
				"cost": {
					"Leather": 10,
					"Thread": 12
				},
				"time":{
					"sections": 3,
					"completed": 0,
					"ammount": 60
				},
				"benefits":{
					"sleepRegenMult": 2.0
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
					"defence": 6
				},
				"required":{
					"module":{
						"Frame": 2
					}
				}
			},
			"tier3" : {
				"cost": {
					"Brick": 24
				},
				"time":{
					"sections": 12,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"defence": 10
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
					"Leaf": 36
				},
				"time":{
					"sections": 2,
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
					"Plank": 24
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
		"Cellar":{
			"benefitsText":{
				"spoilMult": "Spoil time multiplayer",
			},
			"tier0" : {
				"benefits":{
					"spoilMult": 1.0
				}
			},
			"tier1" : {
				"time":{
					"sections": 3,
					"completed": 0,
					"ammount": 60
				},
				"benefits":{
					"spoilMult": 0.8
				},
				"required":{
					"tool":{
						"Shovel": 1
					}
				}
			},
			"tier2" : {
				"cost": {
					"Clay": 18
				},
				"time":{
					"sections": 3,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"spoilMult": 0.6
				}
			},
			"tier3" : {
				"cost": {
					"Plank": 12
				},
				"time":{
					"sections": 3,
					"completed": 0,
					"ammount": 60
				},
				"benefits":{
					"spoilMult": 0.5
				}
			}
		}
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
					"Plank": 12
				},
				"time":{
					"sections": 6,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"tankSize": 200
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
					"Cloth": 3
				},
				"time":{
					"sections": 3,
					"completed": 0,
					"ammount": 40
				},
				"benefits":{
					"filter": 0.8
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
					"Cloth": 3,
					"Sand": 8,
					"Clay": 2
				},
				"time":{
					"sections": 4,
					"completed": 0,
					"ammount": 40
				},
				"benefits":{
					"filter": 1.6
				},
				"required":{
					"module":{
						"Tank": 1
					}
				}
			},
			"tier4" : {
				"cost": {
					"Coal": 6
				},
				"time":{
					"sections": 1,
					"completed": 0,
					"ammount": 30
				},
				"benefits":{
					"filter": 2.2
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
				"smeltable": "Allows smelting new metals",
				"multiSmelt": "Allows smelting multiple items at a time",
				"fuelEff": "Better fuel efficency"
			},
			"tier0" : {
				"benefits":{
					"smeltable": null,
					"multiSmelt": 1,
					"fuelEff": 1
				}
			},
			"tier1" : {
				"cost": {
					"Clay": 12,
				},
				"time":{
					"sections": 3,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"smeltable": "Copper and Bronze",
					"multiSmelt": 1,
					"fuelEff": 1
				}
			},
			"tier2" : {
				"cost": {
					"Rock": 24,
					"Clay": 8
				},
				"time":{
					"sections": 6,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"smeltable": "Copper and Bronze",
					"multiSmelt": 4,
					"fuelEff": 1.2
				},
				"required":{
					"tool":{
						"Shovel": 1,
					}
				}
			},
			"tier3" : {
				"cost": {
					"Brick": 12
				},
				"time":{
					"sections": 4,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"smeltable": "Iron",
					"multiSmelt": 4,
					"fuelEff": 1.2
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
	"Workbench":{
		"Table":{
			"benefitsText":{
				"enable": "Enables placing other tools"
			},
			"tier0" : {
				"benefits":{
					"enable": null
				}
			},
			"tier1" : {
				"cost": {
					"Wood": 5
				},
				"time":{
					"sections": 3,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"enable": "Mortar and Chisel"
				}
			}
		},
		"Mortar":{
			"benefitsText":{
				"enable": "Enables grinding powders",
				"actionMult": "Grinding speed"
			},
			"tier0" : {
				"benefits":{
					"enable": null,
					"actionMult": 0
				}
			},
			"tier1" : {
				"cost": {
					"Rock": 5,
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"enable": "Grinded Herbs",
					"actionMult": 1
				},
				"required":{
					"module":{
						"Table": 1
					},
					"tool":{
						"Pickaxe": 1,
					}
				}
			},
			"tier2" : {
				"cost": {
					"BronzeIngot": 2,
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"enable": "Grinded Herbs",
					"actionMult": 1.2
				},
				"required":{
					"module":{
						"Table": 1
					}
				}
			}
		},
		"Chisel":{
			"benefitsText":{
				"resReduction": "Plank reduced resource cost"
			},
			"tier0" : {
				"benefits":{
					"resReduction": 0
				}
			},
			"tier1" : {
				"cost": {
					"BronzeIngot": 1,
				},
				"time":{
					"sections": 1,
					"completed": 0,
					"ammount": 60
				},
				"benefits":{
					"resReduction": 1
				},
				"required":{
					"module":{
						"Table": 1
					}
				}
			}
		},
		"SpinningWheel":{
			"benefitsText":{
				"actionMult": "Cloth and Rope weaving speed",
				"resReduction": "Cloth and Rope reduced resource cost"
			},
			"tier0" : {
				"benefits":{
					"actionMult": 1,
					"resReduction": 0
				}
			},
			"tier1" : {
				"cost": {
					"Plank": 3,
					"Stick": 12
				},
				"time":{
					"sections": 3,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"actionMult": 1.4,
					"resReduction": 0
				}
			},
			"tier2" : {
				"cost": {
					"BronzeIngot": 2,
					"Leather": 3
				},
				"time":{
					"sections": 4,
					"completed": 0,
					"ammount": 60
				},
				"benefits":{
					"actionMult": 1.6,
					"resReduction": 1
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
					"Thread": 8
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
					"sections": 16,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"defence": 4
				},
				"required":{
					"tool":{
						"Shovel": 1
					}
				}
			},
			"tier2" : {
				"cost": {
					"Stick": 160
				},
				"time":{
					"sections": 8,
					"completed": 0,
					"ammount": 40
				},
				"benefits":{
					"defence": 6
				}
			}
		},
		"Pits":{
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
					"sections": 8,
					"completed": 0,
					"ammount": 40
				},
				"benefits":{
					"defence": 1
				},
				"required":{
					"tool":{
						"Shovel": 1
					}
				}
			},
			"tier2" : {
				"cost": {
					"Leaf": 32,
					"Stick": 8,
					"Thread": 4
				},
				"time":{
					"sections": 4,
					"completed": 0,
					"ammount": 30
				},
				"benefits":{
					"defence": 2
				}
			},
			"tier3" : {
				"cost": {
					"Stick": 64
				},
				"time":{
					"sections": 4,
					"completed": 0,
					"ammount": 30
				},
				"benefits":{
					"defence": 3
				}
			}
		},
		"WarningSystem":{
			"benefitsText":{
				"defence": "Increses camp defence",
				"intel": "Increases information accuracy on intel screen"
			},
			"tier0" : {
				"benefits":{
					"defence": 0,
					"intel": 0
				}
			},
			"tier1" : {
				"cost": {
					"Stick": 8,
					"Thread": 5
				},
				"time":{
					"sections": 4,
					"completed": 0,
					"ammount": 20
				},
				"benefits":{
					"defence": 1,
					"intel": 1
				}
			},
			"tier2" : {
				"cost": {
					"Rock": 6,
					"Thread": 12
				},
				"time":{
					"sections": 4,
					"completed": 0,
					"ammount": 40
				},
				"benefits":{
					"defence": 1,
					"intel": 2
				}
			}
		},
		"WatchTower":{
			"benefitsText":{
				"defence": "Increses camp defence",
				"intel": "Increases information accuracy on intel screen"
			},
			"tier0" : {
				"benefits":{
					"defence": 0,
					"intel": 0
				}
			},
			"tier1" : {
				"cost": {
					"Wood": 24,
					"Plank": 6
				},
				"time":{
					"sections": 3,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"defence": 3,
					"intel": 2
				}
			}
		}
	}
}
signal moduleBuilt

onready var save_data = {}

func _ready() -> void:
	Save.add_missing_keys_deep(Structure,Save.structures,TYPE_DICTIONARY,0,{"ctier":TYPE_INT,"progress":TYPE_INT})

func pack():
	return save_data

func unpack(data):
	for key in data:
		save_data[key] = data[key]
	return

func addRecDestroyed(building,module):
	if not save_data.has("destroyed"):
		save_data["destroyed"] = []
	for dest in save_data["destroyed"]:
		if dest["mname"] == module:
			return false
	var data = {
		"bname" : building,
		"mname" : module
	}
	save_data["destroyed"].push_back(data)
	return true

func removeRecDestroyed(module):
	for n in save_data["destroyed"].size():
		if save_data["destroyed"][n]["mname"] == module:
			save_data["destroyed"].remove(n)
			return

func getRecDestroyed():
	if save_data.has("destroyed"):
		return save_data["destroyed"]
	else:
		return null

func getIntelLv():
	var intel = 0
	intel += getCurrentModule("Perimeter","WarningSystem")["benefits"]["intel"]
	intel += getCurrentModule("Perimeter","WatchTower")["benefits"]["intel"]
	return intel

func calcDefence():
	var defence = 0
	var modules = getDefenceModules()
	for mod in modules:
		defence += mod["def"]
	return defence

func getDefenceModules():
	var list = []
	for building in Structure:
		for module in Structure[building]:
			if typeof(Structure[building][module]) == TYPE_DICTIONARY and Structure[building][module]["benefitsText"].has("defence"):
				var item = {
					"bname": building,
					"mname": module,
					"def" : getCurrentModule(building,module)["benefits"]["defence"]
				}
				list.push_back(item)
	return list

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
	removeRecDestroyed(module)
	emit_signal("moduleBuilt",module)
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
	addRecDestroyed(building,module)

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
