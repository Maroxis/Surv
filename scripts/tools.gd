extends Node

signal toolChanged

onready var tools = {
	"Axe": {
		"currentTier": 0,
		"pinned": true,
		"tier0" : {
			"benefits":{
				"actionMult": 1
			}
		},
		"tier1" : {
			"craftTime": 60,
			"maxDurability": 1,
			"curDurability": 1,
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
			"curDurability": 2,
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
			"curDurability": 3,
			"cost": {
				"Stick": 2,
				"BronzeIngot": 2
			},
			"benefits":{
				"actionMult": 1.4
			}
		},
		"tier4" : {
			"craftTime": 120,
			"maxDurability": 3,
			"curDurability": 3,
			"cost": {
				"Stick": 2,
				"IronIngot": 2
			},
			"benefits":{
				"actionMult": 1.6
			}
		}
	},
	"Knife": {
		"currentTier": 0,
		"pinned": true,
		"tier0" : {
			"benefits":{
				"actionMult": 1
			}
		},
		"tier1" : {
			"craftTime": 40,
			"maxDurability": 1,
			"curDurability": 1,
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
			"curDurability": 2,
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
			"curDurability": 3,
			"cost": {
				"Stick": 1,
				"BronzeIngot": 1
			},
			"benefits":{
				"actionMult": 1.4
			}
		},
		"tier4" : {
			"craftTime": 100,
			"maxDurability": 5,
			"curDurability": 5,
			"cost": {
				"Stick": 1,
				"IronIngot": 1
			},
			"benefits":{
				"actionMult": 1.6
			}
		}
	},
	"Pickaxe": {
		"currentTier": 0,
		"pinned": true,
		"tier0" : {
			"benefits":{
				"actionMult": 1
			}
		},
		"tier1" : {
			"craftTime": 60,
			"maxDurability": 1,
			"curDurability": 1,
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
			"curDurability": 2,
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
			"curDurability": 3,
			"cost": {
				"Stick": 2,
				"BronzeIngot": 3
			},
			"benefits":{
				"actionMult": 1.4
			}
		},
		"tier4" : {
			"craftTime": 120,
			"maxDurability": 5,
			"curDurability": 5,
			"cost": {
				"Stick": 2,
				"IronIngot": 3
			},
			"benefits":{
				"actionMult": 1.6
			}
		}
	},
	"Shovel": {
		"currentTier": 0,
		"pinned": true,
		"tier0" : {
			"benefits":{
				"actionMult": 1
			}
		},
		"tier1" : {
			"craftTime": 80,
			"maxDurability": 1,
			"curDurability": 1,
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
			"curDurability": 2,
			"cost": {
				"Stick": 2,
				"CopperIngot": 3
			},
			"benefits":{
				"actionMult": 1.4
			}
		},
		"tier3" : {
			"craftTime": 90,
			"maxDurability": 3,
			"curDurability": 3,
			"cost": {
				"Stick": 2,
				"BronzeIngot": 3
			},
			"benefits":{
				"actionMult": 1.4
			}
		},
		"tier4" : {
			"craftTime": 160,
			"maxDurability": 5,
			"curDurability": 5,
			"cost": {
				"Stick": 2,
				"IronIngot": 3
			},
			"benefits":{
				"actionMult": 1.6
			}
		}
	},
	"Saw": {
		"currentTier": 0,
		"pinned": true,
		"tier0" : {
			"benefits":{
				"actionMult": 1
			}
		},
		"tier1" : {
			"craftTime": 180,
			"maxDurability": 2,
			"curDurability": 2,
			"cost": {
				"Stick": 2,
				"CopperIngot": 2
			},
			"benefits":{
				"actionMult": 1
			}
		},
		"tier2" : {
			"craftTime": 160,
			"maxDurability": 3,
			"curDurability": 3,
			"cost": {
				"Stick": 2,
				"BronzeIngot": 2
			},
			"benefits":{
				"actionMult": 1.2
			}
		},
		"tier3" : {
			"craftTime": 200,
			"maxDurability": 5,
			"curDurability": 5,
			"cost": {
				"Stick": 2,
				"IronIngot": 2
			},
			"benefits":{
				"actionMult": 1.4
			}
		}
	}
}


func craftTool(name):
	removeRes(name)
	var ctier = tools[name]["currentTier"]
	Player.pass_time(tools[name]["tier"+str(ctier+1)]["craftTime"])
	tools[name]["currentTier"] += 1
	updateTool(name)

func updateTool(name,downgrade = false):
	emit_signal("toolChanged",name,downgrade,tools[name]["currentTier"])
	if(tools[name]["pinned"]):
		Global.ToolsUI.updateTool(name, tools[name]["currentTier"], downgrade)
	
func checkCost(name):
	var ctier = tools[name]["currentTier"]
	for mat in tools[name]["tier"+str(ctier+1)]["cost"]:
		var amm = tools[name]["tier"+str(ctier+1)]["cost"][mat]
		if(Inventory.get_res_amm(mat) < amm):
			return false
	return true

func getBonus(tl,req = null):
	var ctier = tools[tl]["currentTier"]
	if(req != null):
		ctier = max(ctier-req,0)
	return tools[tl]["tier"+str(ctier)]["benefits"]["actionMult"]

func removeRes(name):
	var ctier = tools[name]["currentTier"]
	for mat in tools[name]["tier"+str(ctier+1)]["cost"]:
		var amm = tools[name]["tier"+str(ctier+1)]["cost"][mat]
		Inventory.add_resource(mat,-amm)
