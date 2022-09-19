extends Node

var resources = {}

func add_missing_keys(dict):
	for res in dict:
		if(not resources.has(res)):
			resources[res] = 0

func get_res_amm(res):
	return resources[res]

func add_resource(res,amm):
	if amm < 0 and resources[res] < abs(amm):
		return false
	else:
		resources[res] += amm
		resources[res] = min(resources[res],999)
		Global.ResourcesUI.addRes(res,resources[res],Inventory.resources[res]["crafted"])
		return true
