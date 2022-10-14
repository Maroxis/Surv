extends Node

signal toolChanged

onready var tools = {
	"Axe": {
		"pinned": true,
		"tier0" : {
			"benefits":{
				"actionMult": 1
			}
		},
		"tier1" : {
			"craftTime": 60,
			"maxDurability": 1,
			"cost": {
				"Stick": 2,
				"Rock": 2
			},
			"benefits":{
				"actionMult": 1.2
			}
		},
		"tier2" : {
			"craftTime": 100,
			"maxDurability": 2,
			"cost": {
				"Stick": 2,
				"CopperIngot": 2
			},
			"benefits":{
				"actionMult": 1.4
			}
		},
		"tier3" : {
			"craftTime": 80,
			"maxDurability": 3,
			"cost": {
				"Stick": 2,
				"BronzeIngot": 2
			},
			"benefits":{
				"actionMult": 1.6
			}
		},
		"tier4" : {
			"craftTime": 120,
			"maxDurability": 5,
			"cost": {
				"Plank": 1,
				"IronIngot": 2
			},
			"benefits":{
				"actionMult": 1.8
			}
		}
	},
	"Knife": {
		"pinned": true,
		"tier0" : {
			"benefits":{
				"actionMult": 1
			}
		},
		"tier1" : {
			"craftTime": 40,
			"maxDurability": 1,
			"cost": {
				"Stick": 1,
				"Rock": 2
			},
			"benefits":{
				"actionMult": 1.2
			}
		},
		"tier2" : {
			"craftTime": 80,
			"maxDurability": 2,
			"cost": {
				"Stick": 1,
				"CopperIngot": 1
			},
			"benefits":{
				"actionMult": 1.4
			}
		},
		"tier3" : {
			"craftTime": 60,
			"maxDurability": 3,
			"cost": {
				"Stick": 1,
				"BronzeIngot": 1
			},
			"benefits":{
				"actionMult": 1.6
			}
		},
		"tier4" : {
			"craftTime": 100,
			"maxDurability": 5,
			"cost": {
				"Plank": 1,
				"IronIngot": 1
			},
			"benefits":{
				"actionMult": 1.8
			}
		}
	},
	"Pickaxe": {
		"pinned": true,
		"tier0" : {
			"benefits":{
				"actionMult": 1
			}
		},
		"tier1" : {
			"craftTime": 60,
			"maxDurability": 1,
			"cost": {
				"Stick": 2,
				"Rock": 2
			},
			"benefits":{
				"actionMult": 1.2
			}
		},
		"tier2" : {
			"craftTime": 100,
			"maxDurability": 2,
			"cost": {
				"Stick": 2,
				"CopperIngot": 3
			},
			"benefits":{
				"actionMult": 1.4
			}
		},
		"tier3" : {
			"craftTime": 80,
			"maxDurability": 3,
			"cost": {
				"Stick": 2,
				"BronzeIngot": 3
			},
			"benefits":{
				"actionMult": 1.6
			}
		},
		"tier4" : {
			"craftTime": 120,
			"maxDurability": 5,
			"cost": {
				"Plank": 2,
				"IronIngot": 3
			},
			"benefits":{
				"actionMult": 1.8
			}
		}
	},
	"Shovel": {
		"pinned": true,
		"tier0" : {
			"benefits":{
				"actionMult": 1
			}
		},
		"tier1" : {
			"craftTime": 80,
			"maxDurability": 1,
			"cost": {
				"Stick": 2,
				"Rock": 2
			},
			"benefits":{
				"actionMult": 1.2
			}
		},
		"tier2" : {
			"craftTime": 120,
			"maxDurability": 2,
			"cost": {
				"Stick": 2,
				"CopperIngot": 2
			},
			"benefits":{
				"actionMult": 1.4
			}
		},
		"tier3" : {
			"craftTime": 90,
			"maxDurability": 3,
			"cost": {
				"Stick": 2,
				"BronzeIngot": 2
			},
			"benefits":{
				"actionMult": 1.6
			}
		},
		"tier4" : {
			"craftTime": 160,
			"maxDurability": 5,
			"cost": {
				"Plank": 2,
				"IronIngot": 2
			},
			"benefits":{
				"actionMult": 1.8
			}
		}
	},
	"Saw": {
		"pinned": true,
		"baseTier": 1,
		"tier0" : {
			"benefits":{
				"actionMult": 1
			}
		},
		"tier1" : {
			"craftTime": 160,
			"maxDurability": 3,
			"cost": {
				"Stick": 2,
				"BronzeIngot": 2
			},
			"benefits":{
				"actionMult": 1.2
			}
		},
		"tier2" : {
			"craftTime": 200,
			"maxDurability": 5,
			"cost": {
				"Plank": 1,
				"IronIngot": 2
			},
			"benefits":{
				"actionMult": 1.4
			}
		}
	}
}

func _ready() -> void:
	Save.add_missing_keys(tools,Save.tools,TYPE_DICTIONARY,2,{"ctier":TYPE_INT,"durability":TYPE_INT})
	
func refresh():
	for tl in tools:
		updateTool(tl)

func getTier(tl,next = false):
	return int(Save.tools[tl]["ctier"] + (1 if next else 0))

func setTier(tl,tier):
	Save.tools[tl]["ctier"] = int(tier)
	if tools[tl]["tier"+str(tier)].has("maxDurability"):
		Save.tools[tl]["durability"] = tools[tl]["tier"+str(tier)]["maxDurability"]
	else:
		Save.tools[tl]["durability"] = 0
	

func craftTool(name):
	removeRes(name)
	var ctier = getTier(name)
	Player.pass_time(tools[name]["tier"+str(ctier+1)]["craftTime"])
	setTier(name,ctier+1)
	updateTool(name)

func updateTool(name,downgrade = false):
	var tier = getTier(name)
	emit_signal("toolChanged",name,downgrade,tier)
	if(tools[name]["pinned"]):
		if tier != 0 and tools[name].has("baseTier"):
			tier += tools[name]["baseTier"]
		Global.ToolsUI.updateTool(name, tier, downgrade)
	
func checkCost(name):
	var ctier = getTier(name)
	for mat in tools[name]["tier"+str(ctier+1)]["cost"]:
		var amm = tools[name]["tier"+str(ctier+1)]["cost"][mat]
		if(Inventory.get_res_amm(mat) < amm):
			return false
	return true

func getBonus(tl,req = null):
	var ctier = getTier(tl)
	if(req != null):
		ctier = max(ctier-req,0)
	return tools[tl]["tier"+str(ctier)]["benefits"]["actionMult"]

func removeRes(name):
	var ctier = getTier(name)
	for mat in tools[name]["tier"+str(ctier+1)]["cost"]:
		var amm = tools[name]["tier"+str(ctier+1)]["cost"][mat]
		Inventory.add_resource(mat,-amm)
