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
					"Stick": 16,
					"Thread": 14,
					"Rope": 4
				},
				"time":{
					"sections": 6,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"sleepRegenMult": 1.6
				},
				"required":{
					"tool":{
						"Hammer": 1,
					}
				}
			},
			"tier3" : {
				"cost": {
					"Leather": 12,
					"Thread": 16,
					"Cloth": 6
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 60
				},
				"benefits":{
					"sleepRegenMult": 2.0
				}
			},
			"tier4" : {
				"cost": {
					"Plank": 12
				},
				"time":{
					"sections": 5,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"sleepRegenMult": 2.4
				},
				"required":{
					"tool":{
						"Hammer": 2,
					}
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
				},
				"required":{
					"tool":{
						"Hammer": 1,
					}
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
					"enable": "Wall, Roof v2"
				},
				"required":{
					"tool":{
						"Hammer": 1,
					}
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
					},
					"tool":{
						"Hammer": 1,
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
					"tool":{
						"Hammer": 1,
						"Axe": 1
					}
				}
			},
			"tier3" : {
				"cost": {
					"Brick": 42
				},
				"time":{
					"sections": 12,
					"completed": 0,
					"ammount": 90
				},
				"benefits":{
					"defence": 12
				},
				"required":{
					"tool":{
						"Hammer": 2,
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
					},
					"tool":{
						"Hammer": 1,
					}
				}
			},
			"tier2" : {
				"cost": {
					"Plank": 24
				},
				"time":{
					"sections": 5,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"roofed": true,
					"defence": 3
				},
				"required":{
					"module":{
						"Frame": 2
					},
					"tool":{
						"Hammer": 2,
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
					"sections": 5,
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
					"Clay": 22
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
					"Plank": 14
				},
				"time":{
					"sections": 5,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"spoilMult": 0.5
				},
				"required":{
					"tool":{
						"Hammer": 2,
					}
				}
			}
		}
	},
	"Collector": {
		"waterLevel": 0,
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
					"sections": 2,
					"completed": 0,
					"ammount": 30
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
					"sections": 4,
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
					"ammount": 80
				},
				"benefits":{
					"tankSize": 200
				},
				"required":{
					"tool":{
						"Hammer": 2,
					}
				}
			}
		},
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
				}
			},
			"tier4" : {
				"cost": {
					"Coal": 6
				},
				"time":{
					"sections": 1,
					"completed": 0,
					"ammount": 40
				},
				"benefits":{
					"filter": 2.2
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
					"ammount": 90
				},
				"benefits":{
					"smeltable": "Copper and Bronze",
					"multiSmelt": 4,
					"fuelEff": 1.2
				}
			},
			"tier3" : {
				"cost": {
					"Brick": 22
				},
				"time":{
					"sections": 6,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"smeltable": "Iron",
					"multiSmelt": 8,
					"fuelEff": 1.4
				},
				"required":{
					"tool":{
						"Hammer": 2,
					}
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
					"Plank": 5
				},
				"time":{
					"sections": 3,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"enable": "Mortar and Chisel"
				},
				"required":{
					"tool":{
						"Hammer": 2,
					}
				}
			}
		},
		"Mortar":{
			"benefitsText":{
				"enableCraft": "Enables grinding powders",
				"actionMult": "Grinding speed"
			},
			"tier0" : {
				"benefits":{
					"enableCraft": null,
					"actionMult": 0
				}
			},
			"tier1" : {
				"cost": {
					"BronzeIngot": 2,
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"enableCraft": "Grinded Herbs",
					"actionMult": 1
				},
				"required":{
					"module":{
						"Table": 1
					}
				}
			},
			"tier2" : {
				"cost": {
					"IronIngot": 2,
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"enableCraft": "Grinded Herbs",
					"actionMult": 1.2
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
					"Plank": 1
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
				},
				"required":{
					"tool":{
						"Hammer": 2,
					}
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
					"actionMult": 1.4,
					"resReduction": 1
				},
				"required":{
					"tool":{
						"Hammer": 2,
					}
				}
			},
			"tier3" : {
				"cost": {
					"IronIngot": 2,
					"Leather": 3,
					"Thread": 6
				},
				"time":{
					"sections": 4,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"actionMult": 2.0,
					"resReduction": 1
				},
				"required":{
					"tool":{
						"Hammer": 2,
					}
				}
			}
		},
		"DryingRack":{
			"benefitsText":{
				"enableCraft": "Enables drying meat"
			},
			"tier0" : {
				"benefits":{
					"enableCraft": false
				}
			},
			"tier1" : {
				"cost": {
					"Stick": 16,
					"Thread": 6
				},
				"time":{
					"sections": 3,
					"completed": 0,
					"ammount": 60
				},
				"benefits":{
					"enableCraft": true
				},
				"required":{
					"tool":{
						"Hammer": 1,
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
					"Thread": 8
				},
				"time":{
					"sections": 8,
					"completed": 0,
					"ammount": 40
				},
				"benefits":{
					"defence": 2
				},
				"required":{
					"tool":{
						"Hammer": 1,
					}
				}
			},
			"tier2" : {
				"cost": {
					"Wood": 40
				},
				"time":{
					"sections": 8,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"defence": 7
				},
				"required":{
					"tool":{
						"Hammer": 1,
						"Axe": 1
					}
				}
			},
			"tier3" : {
				"cost": {
					"Brick": 62
				},
				"time":{
					"sections": 14,
					"completed": 0,
					"ammount": 120
				},
				"benefits":{
					"defence": 16
				},
				"required":{
					"tool":{
						"Hammer": 2,
					}
				}
			}
		},
		"Gate":{
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
					"Stick": 12,
					"Thread": 3
				},
				"time":{
					"sections": 2,
					"completed": 0,
					"ammount": 40
				},
				"benefits":{
					"defence": 1
				},
				"required":{
					"module":{
						"Fence": 1
					},
					"tool":{
						"Hammer": 1,
					}
				}
			},
			"tier2" : {
				"cost": {
					"Wood": 12
				},
				"time":{
					"sections": 4,
					"completed": 0,
					"ammount": 40
				},
				"benefits":{
					"defence": 3
				},
				"required":{
					"tool":{
						"Hammer": 1,
					}
				}
			},
			"tier3" : {
				"cost": {
					"Plank": 12
				},
				"time":{
					"sections": 4,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"defence": 5
				},
				"required":{
					"tool":{
						"Hammer": 2,
					}
				}
			},
			"tier4" : {
				"cost": {
					"Plank": 4,
					"Nail": 6,
					"IronIngot": 2
				},
				"time":{
					"sections": 5,
					"completed": 0,
					"ammount": 90
				},
				"benefits":{
					"defence": 9
				},
				"required":{
					"tool":{
						"Hammer": 3,
					}
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
					"Stick": 120
				},
				"time":{
					"sections": 8,
					"completed": 0,
					"ammount": 40
				},
				"benefits":{
					"defence": 7
				},
				"required":{
					"tool":{
						"Hammer": 1,
						"Knife": 1
					}
				}
			},
			"tier3" : {
				"cost": {
					"Wood": 48,
					"Nail": 24
				},
				"time":{
					"sections": 14,
					"completed": 0,
					"ammount": 90
				},
				"benefits":{
					"defence": 14
				},
				"required":{
					"tool":{
						"Hammer": 3,
					}
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
					"Leaf": 24,
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
					"Stick": 48
				},
				"time":{
					"sections": 4,
					"completed": 0,
					"ammount": 30
				},
				"benefits":{
					"defence": 3
				},
				"required":{
					"tool":{
						"Hammer": 1,
						"Knife": 1
					}
				}
			},
			"tier4" : {
				"cost": {
					"Wood": 12,
					"Nail": 8
				},
				"time":{
					"sections": 4,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"defence": 6
				},
				"required":{
					"tool":{
						"Hammer": 3,
					}
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
				},
				"required":{
					"tool":{
						"Hammer": 1,
					}
				}
			},
			"tier2" : {
				"cost": {
					"Rock": 8,
					"Thread": 4
				},
				"time":{
					"sections": 4,
					"completed": 0,
					"ammount": 40
				},
				"benefits":{
					"defence": 1,
					"intel": 2
				},
				"required":{
					"tool":{
						"Hammer": 1,
					}
				}
			},
			"tier3" : {
				"cost": {
					"Nail": 14,
					"Thread": 6
				},
				"time":{
					"sections": 4,
					"completed": 0,
					"ammount": 60
				},
				"benefits":{
					"defence": 4,
					"intel": 2
				},
				"required":{
					"tool":{
						"Hammer": 3,
					}
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
					"Wood": 24
				},
				"time":{
					"sections": 3,
					"completed": 0,
					"ammount": 80
				},
				"benefits":{
					"defence": 2,
					"intel": 2
				},
				"required":{
					"tool":{
						"Hammer": 1,
						"Axe": 1
					}
				}
			},
			"tier2" : {
				"cost": {
					"Plank": 16,
					"Nail": 16
				},
				"time":{
					"sections": 6,
					"completed": 0,
					"ammount": 90
				},
				"benefits":{
					"defence": 7,
					"intel": 2
				},
				"required":{
					"tool":{
						"Hammer": 3,
					}
				}
			}
		}
	}
}
signal moduleBuilt

onready var save_data = {
	"destroyed" : []
}

func _ready() -> void:
	Save.add_missing_keys_deep(Structure,Save.structures,TYPE_DICTIONARY,0,{"ctier":TYPE_INT,"progress":TYPE_INT})

func pack():
	return save_data

func unpack(data):
	for key in data:
		save_data[key] = data[key]
	return
	
func checkIfReqFullfiled(building,mod,tier):
	tier = "tier"+str(tier)
	if(Structure[building][mod][tier].has("required")):
		for reqCat in Buildings.Structure[building][mod][tier]["required"]:
			for req in Buildings.Structure[building][mod][tier]["required"][reqCat]:
				var rtier
				var ctier
				if(reqCat == "tool"):
					rtier = Buildings.Structure[building][mod][tier]["required"][reqCat][req]
					ctier = Tools.getTier(req)
					if(ctier < rtier):
						return false
				elif(reqCat == "module"):
					rtier = Buildings.Structure[building][mod][tier]["required"][reqCat][req]
					ctier = Buildings.getTierInt(building,req)
					if(ctier < rtier):
						return false
	return true

func getRequiredTool(building,mod,tier):
	tier = "tier"+str(tier)
	if Buildings.Structure[building][mod][tier].has("required"):
		if Buildings.Structure[building][mod][tier]["required"].has("tool"):
			return Buildings.Structure[building][mod][tier]["required"]["tool"]
	return null

func addRecDestroyed(building,module):
	if not save_data.has("destroyed") or typeof(save_data["destroyed"]) == TYPE_DICTIONARY:
		save_data["destroyed"] = []
	for n in range(0,save_data["destroyed"].size()):
		if save_data["destroyed"][n]["mname"] == module:
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

func getSpoilMlt():
	return getCurrentModule("House","Cellar")["benefits"]["spoilMult"]

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
	Achivements.module_built(building,module)
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

func getMaxTierInt(building,module):
	var i :int = 1
	while Structure[building][module].has("tier"+str(i+1)):
		i += 1
	return i

func isMaxTier(building,module = null):
	if module != null:
		return getTierInt(building,module) == getMaxTierInt(building,module)
	else:
		for module in Structure[building]:
			if not isMaxTier(building,module):
				return false
		return true

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

func getWaterLevel():
	return round(Structure["Collector"]["waterLevel"])

func changeWaterLevel(amm,set = false):
	if(set):
		Structure["Collector"]["waterLevel"] = amm
	else:
		Structure["Collector"]["waterLevel"] += amm
	var tankSize = getCurrentModule("Collector","Tank")["benefits"]["tankSize"]
	Structure["Collector"]["waterLevel"] = clamp(Structure["Collector"]["waterLevel"],0,tankSize)
	Global.Missions.get_node("Home").drinkNodeAmm.text = str(getWaterLevel()) + "W"
