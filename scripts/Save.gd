extends Node

const save_file = "user://save_file_test.save"

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
	data["resources"] = Inventory.pack()
	data["player"] = Player.pack()
	data["tools"] = tools
	data["upgrades"] = upgrades
	data["bag"] = bag
	data["weather"] = Global.Weather.pack()
	data["structures"] = structures
	data["events"] = Events.pack()
	data["missions"] = Global.Missions.pack()
	data["date"] = Global.Date.pack()
	data["cook"] = Global.Cook.pack()
	data["smelt"] = Global.Smelt.pack()
	return to_json(data)

func unpackData(data):
	Inventory.unpack(data["resources"])
	tools = data["tools"]
	upgrades = data["upgrades"]
	bag = data["bag"]
	Global.Weather.unpack(data["weather"])
	structures = data["structures"]
	Player.unpack(data["player"])
	Events.unpack(data["events"])
	Global.Missions.unpack(data["missions"])
	Global.Date.unpack(data["date"])
	Global.Cook.unpack(data["cook"])
	Global.Smelt.unpack(data["smelt"])

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

func add_missing_keys(dict, target, type = TYPE_INT, size = 0, customKeys = null):
	for res in dict:
		if(not target.has(res)):
			_create_key(target,res,type,size,customKeys)

func _create_key(dict,key,type,size,customKeys):
	dict[key] = get_single_key(type)
	match type:
		TYPE_INT_ARRAY:
			for i in size:
				dict[key].push_back(0)
		TYPE_DICTIONARY:
			for customKey in customKeys:
				dict[key][customKey] = get_single_key(customKeys[customKey])

func get_single_key(type):
	var key
	match type:
		TYPE_INT:
			key = 0
		TYPE_BOOL:
			key = false
		TYPE_INT_ARRAY:
			key = []
		TYPE_DICTIONARY:
			key = {}
	return key
	
func add_missing_keys_deep(dict, target, type = TYPE_INT, size = 0, keys = null):
	for sub in dict:
		target[sub] = {}
		for key in dict[sub]:
			target[sub][key] = {}
			if(typeof(dict[sub][key]) == TYPE_DICTIONARY):
				_create_key(target[sub],key,type,size,keys)
			else:
				_create_key(target[sub],key,typeof(dict[sub][key]),size,keys)
