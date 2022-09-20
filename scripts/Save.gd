extends Node

const save_file = "user://save_file_test.save"

var resources = {}
var tools = {}

func packData():
	var data = {}
	data["resources"] = resources
	data["player"] = Player.pack()
	data["tools"] = tools
	return to_json(data)

func unpackData(data):
	resources = data["resources"]
	tools = data["tools"]
	Player.unpack(data["player"])

func saveData():
	var file = File.new()
	file.open(save_file, File.WRITE)
	file.store_line(packData())
	file.close()
	return true
	
func loadData():
	var file = File.new()
	if not file.file_exists(save_file):
		return false
	file.open(save_file, File.READ)
	unpackData(parse_json(file.get_line()))
	file.close()
	Global.refresh()
	return true

func removeData():
	var dir = Directory.new()
	if not dir.file_exists(save_file):
		return false
	dir.remove(save_file)
	return true

func add_missing_keys(dict,target):
	for res in dict:
		if(not target.has(res)):
			target[res] = 0

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
