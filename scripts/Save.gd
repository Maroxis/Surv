extends Node

const save_file = "user://save_file_test.save"

var resources = {}
var tools = {}
var upgrades = {}
var bag = {
	"size": 10,
	"space": 10,
	"content":{}
}
var structures = {}

func packData():
	var data = {}
	data["resources"] = resources
	data["player"] = Player.pack()
	data["tools"] = tools
	data["upgrades"] = upgrades
	data["bag"] = bag
	data["weather"] = Global.Weather.pack()
	data["structures"] = structures
	return to_json(data)

func unpackData(data):
	resources = Dictionary(data["resources"])
	tools = data["tools"]
	upgrades = data["upgrades"]
	bag = data["bag"]
	Global.Weather.unpack(data["weather"])
	structures = data["structures"]
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

func add_missing_keys(dict, target, type = TYPE_INT, size = 0, keys = null):
	for res in dict:
		if(not target.has(res)):
			_create_key(target,res,type,size,keys)

func _create_key(dict,key,type,size,keys):
	match type:
		TYPE_INT:
			dict[key] = 0
		TYPE_BOOL:
			dict[key] = false
		TYPE_INT_ARRAY:
			dict[key] = []
			for i in size:
				dict[key].push_back(0)
		TYPE_DICTIONARY:
			dict[key] = {}
			for i in size:
				dict[key][keys[i]] = 0

func add_missing_keys_deep(dict, target, type = TYPE_INT, size = 0, keys = null):
	for sub in dict:
		target[sub] = {}
		for key in dict[sub]:
			target[sub][key] = {}
			if(typeof(dict[sub][key]) == TYPE_DICTIONARY):
				_create_key(target[sub],key,type,size,keys)
			else:
				_create_key(target[sub],key,typeof(dict[sub][key]),size,keys)

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
