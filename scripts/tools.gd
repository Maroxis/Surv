extends Node

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
			"craftTime": 20,
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
			"craftTime": 30,
			"maxDurability": 2,
			"curDurability": 2,
			"cost": {
				"Stick": 4,
				"Rock": 2
			},
			"benefits":{
				"actionMult": 1.4
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
			"craftTime": 30,
			"maxDurability": 1,
			"curDurability": 1,
			"cost": {
				"Stick": 1,
				"Rock": 2
			},
			"benefits":{
				"actionMult": 1.2
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
			"craftTime": 30,
			"maxDurability": 1,
			"curDurability": 1,
			"cost": {
				"Stick": 1,
				"Rock": 2
			},
			"benefits":{
				"actionMult": 1.2
			}
		}
	},
	"Shovel": {
		"currentTier": 0,
		"pinned": true,
		"tier0" : {
			"maxDurability": 1,
			"curDurability": 1,
			"benefits":{
				"actionMult": 1
			}
		},
		"tier1" : {
			"craftTime": 30,
			"maxDurability": 1,
			"curDurability": 1,
			"cost": {
				"Stick": 1,
				"Rock": 2
			},
			"benefits":{
				"actionMult": 1.2
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
			"craftTime": 30,
			"maxDurability": 1,
			"curDurability": 1,
			"cost": {
				"Stick": 1,
				"Rock": 2
			},
			"benefits":{
				"actionMult": 1
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
	if(name == "Axe"):
		if(tools[name]["currentTier"] == 1):
			Global.Missions.get_node("Woods").active_wood()
		elif(tools[name]["currentTier"] == 0):
			Global.Missions.get_node("Woods").deactive_wood()
	for mission in Global.Missions.get_children():
		mission.updateGatherTime()
	if(tools[name]["pinned"]):
		Global.ToolsUI.updateTool(name, tools[name]["currentTier"], downgrade)
	
func checkCost(name):
	var ctier = tools[name]["currentTier"]
	for mat in tools[name]["tier"+str(ctier+1)]["cost"]:
		var amm = tools[name]["tier"+str(ctier+1)]["cost"][mat]
		if(Inventory.resources[mat]["ammount"] < amm):
			return false
	return true

func removeRes(name):
	var ctier = tools[name]["currentTier"]
	for mat in tools[name]["tier"+str(ctier+1)]["cost"]:
		var amm = tools[name]["tier"+str(ctier+1)]["cost"][mat]
		Inventory.add_resource(mat,-amm)
