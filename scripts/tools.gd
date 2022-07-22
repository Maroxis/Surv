extends Node

onready var tools = {
	"Axe": {
		"currentTier": 0,
		"tier0" : {
			"benefits":{
				"actionMult": 1
			}
		},
		"tier1" : {
			"cost": {
				"Stick": 1,
				"Rock": 2
			},
			"benefits":{
				"actionMult": 1.2
			}
		}
	},
	"Knife": {
		"currentTier": 0,
		"tier0" : {
			"benefits":{
				"actionMult": 1
			}
		},
		"tier1" : {
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
		"tier0" : {
			"benefits":{
				"actionMult": 1
			}
		},
		"tier1" : {
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
		"tier0" : {
			"benefits":{
				"actionMult": 1
			}
		},
		"tier1" : {
			"cost": {
				"Stick": 1,
				"Rock": 2
			},
			"benefits":{
				"actionMult": 1.2
			}
		}
	}
}


func craftTool(name):
	tools[name]["currentTier"] += 1
	if(name == "Axe" && tools[name]["currentTier"] == 1):
		Global.Missions.get_node("Woods").active_wood()
	for mission in Global.Missions.get_children():
		mission.updateGatherTime()
	

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
