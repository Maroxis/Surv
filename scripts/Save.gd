extends Node

const save_file = "user://save_file_test.save"
const auto_save_file = "user://auto_save_file.save"
const blank_save_file = "user://blank_save_file.save"
const config_save_file = "user://config_file.json"
const record_save_file = "user://record_file.json"

var tools = {}
var upgrades = {}
var bag = {
	"size": 10,
	"space": 10,
	"content":{}
}
var structures = {}

func saveConfig():
	var data = {}
	data["settings"] = Global.InGSettings.pack()
	data["tutorial"] = Global.Tutorial.pack()
	data = to_json(data)
	return saveData(config_save_file,data)

func loadConfig():
	var data = loadData(config_save_file)
	if data:
		if data.has("settings"): # save compatibility to remove later
			Global.InGSettings.unpack(data["settings"])
			Global.Tutorial.unpack(data["tutorial"])
		else:
			Global.InGSettings.unpack(data)

func saveRecord(time):
	var prevData = loadRecord()
	var data = LeaderBoard.addRecord(prevData,time)
	saveData(record_save_file,data)
	return data

func loadRecord():
	return loadData(record_save_file)

func autoSave():
	saveData(auto_save_file)

func autoLoad():
	saveData(blank_save_file)
	loadConfig()
	loadSave(auto_save_file)

func loadSave(path):
	var data = loadData(path)
	if(data == null):
		return false
	data = addKeysToData(data)
	unpackData(data)
	Global.refresh()
	return true

func addKeysToData(data):
	if not data["resources"].has("medsData"):
		data["resources"]["medsData"] = {}
	add_missing_keys(Tools.tools,data["tools"],TYPE_DICTIONARY,2,{"ctier":TYPE_INT,"durability":TYPE_INT})
	add_missing_keys(Inventory.resources,data["resources"]["resources"])
	add_missing_keys(Inventory.upgrades,data["resources"]["upgrades"],TYPE_BOOL)
	add_missing_keys(Inventory.food,data["resources"]["foodData"],TYPE_DICTIONARY,2,{"amm":TYPE_INT,"spoil":TYPE_INT_ARRAY})
	add_missing_keys(Inventory.meds,data["resources"]["medsData"])
	add_missing_keys_deep(Buildings.Structure,data["structures"],TYPE_DICTIONARY,0,{"ctier":TYPE_INT,"progress":TYPE_INT})
	return data

func newGame():
	delSave()
	if not loadSave(blank_save_file):
		return false
	Events.init()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://nodes/TitleMenu.tscn")
	return true

func delSave():
	return Save.removeData(Save.auto_save_file)
func delConfig():
	return Save.removeData(Save.config_save_file)
func delRecords():
	return Save.removeData(Save.record_save_file)
func delBlank():
	return Save.removeData(Save.blank_save_file)

func purgeData():
	print("config: ",delConfig())
	print("records: ",delRecords())
	print("blank: ",delBlank())
	print("save: ",delSave())
	return true

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
	data["drying"] = Global.Drying.pack()
	data["smelt"] = Global.Smelt.pack()
	data["buildings"] = Buildings.pack()
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
	if data.has("buildings"):
		Buildings.unpack(data["buildings"])
	if data.has("drying"):
		Global.Drying.unpack(data["drying"])

func saveData(path, data = packData()):
	if typeof(data) != TYPE_STRING:
		data = to_json(data)
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_line(data)
	file.close()
	return true
	
func loadData(path):
	var file = File.new()
	if not file.file_exists(path):
		return null
	file.open(path, File.READ)
	var data = parse_json(file.get_line())
	file.close()
	return data

func removeData(path):
	var dir = Directory.new()
	if not dir.file_exists(path):
		return false
	dir.remove(path)
	return true

func add_original_keys(dict, target):
	for res in dict:
		if(not target.has(res)):
			target[res] = dict[res]

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
		if not target.has(sub):
			target[sub] = {}
		for key in dict[sub]:
			if not target[sub].has(key):
				target[sub][key] = {}
				if(typeof(dict[sub][key]) == TYPE_DICTIONARY):
					_create_key(target[sub],key,type,size,keys)
				else:
					_create_key(target[sub],key,typeof(dict[sub][key]),size,keys)
