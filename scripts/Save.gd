extends Node

const save_file = "user://save_file_test.save"

var resources = {}
var player = {}

func saveData():
	var file = File.new()
	file.open(save_file, File.WRITE)
	file.store_line(to_json(resources))
	file.close()
	return true
	
func loadData():
	var file = File.new()
	if not file.file_exists(save_file):
		return false
	file.open(save_file, File.READ)
	resources = parse_json(file.get_line())
	file.close()
	refreshUI()
	return true

func removeData():
	var dir = Directory.new()
	if not dir.file_exists(save_file):
		return false
	dir.remove(save_file)
	return true

func refreshUI():
	Global.ChestResources.refresh()

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
