extends Node

onready var resources = {
	"Leaf": {
		"weight" : 0.6,
		"crafted": false
	  },
	"Stick": {
		"weight" : 1.2,
		"crafted": false,
		"burining":{
			"temp": 600,
			"time": 5
		}
	  },
	"Wood": {
		"weight" : 3.2,
		"crafted": false,
		"burining":{
			"temp": 1200,
			"time": 20
		}
	  },
	"Leather": {
		"weight" : 2.4,
		"crafted": true
	  },
	"Thread": {
		"weight" : 0.2,
		"cost" : {
			"Leaf" : 3
		},
		"craftTime": 30,
		"crafted": true
	  },
	"Rope": {
		"weight" : 1.0,
		"cost" : {
			"Thread" : 3
		},
		"craftTime": 60,
		"crafted": true
	  },
	"Torch": {
		"weight" : 2.2,
		"cost" : {
			"Stick" : 1,
			"Rope" : 1
		},
		"craftTime": 10,
		"crafted": true
	  },
	"Plank": {
		"weight" : 2.0,
		"cost" : {
			"Wood" : 1
		},
		"requirement": {
			"tool" : "Saw",
			"tier" : 1
		},
		"craftTime": 40,
		"crafted": true
	  },
	"Rock": {
		"weight" : 2.8,
		"crafted": false
	  },
	"Clay": {
		"weight" : 3.6,
		"crafted": false
	  },
	"Sand": {
		"weight" : 2.6,
		"crafted": false
	  },
	"Coal": {
		"weight" : 2.6,
		"crafted": false,
		"burining":{
			"temp": 2000,
			"time": 60
		}
	  },
	"CopperOre": {
		"weight" : 1.2,
		"crafted": false,
	  },
	"TinOre": {
		"weight" : 1.2,
		"crafted": false,
	  },
	"IronOre": {
		"weight" : 1.2,
		"crafted": false,
	  },
	"CopperIngot": {
		"weight" : 10.8,
		"cost" : {
			"CopperOre" : 10
		},
		"meltingTemp" : 1000,
		"craftTime": 720,
		"furnaceTier": 1,
		"crafted": true
	  },
	"BronzeIngot": {
		"weight" : 10.8,
		"cost" : {
			"CopperOre" : 9,
			"TinOre" : 1
		},
		"meltingTemp" : 1000,
		"craftTime": 600,
		"furnaceTier": 1,
		"crafted": true
	  },
	"IronIngot": {
		"weight" : 10.8,
		"cost" : {
			"IronOre" : 10
		},
		"meltingTemp" : 1800,
		"craftTime": 1440,
		"furnaceTier": 2,
		"crafted": true
	  }
}

onready var food = {
	"RawSmallMeat": {
		"weight" : 1.2,
		"crafted": false,
		"cookable": true,
		"calories": 40,
		"sick": 10,
		"spoil":[],
		"spoilTime": 2160,
		"cookTime": 5,
		"cooksInto" : "CookedSmallMeat"
	  },
	"RawMeat": {
		"weight" : 2.8,
		"crafted": false,
		"cookable": true,
		"calories": 80,
		"sick": 30,
		"spoil":[],
		"spoilTime": 2160,
		"cookTime": 10,
		"cooksInto" : "CookedMeat"
	  },
	"WildBerry": {
		"weight" : 1.2,
		"crafted": false,
		"cookable": false,
		"calories": 8,
		"water": 2,
		"sick": 1,
		"spoil":[],
		"spoilTime": 1440
	  },
	"CookedSmallMeat": {
		"weight" : 1.0,
		"crafted": true,
		"cookable": false,
		"calories": 40,
		"spoil":[],
		"spoilTime": 4320
	  },
	"CookedMeat": {
		"weight" : 2.2,
		"crafted": true,
		"cookable": false,
		"calories": 80,
		"spoil":[],
		"spoilTime": 5760
	  },
	"SmallCarcass": {
		"weight" : 4.8,
		"crafted": false,
		"carcass": true,
		"craftTime": 40,
		"deconstruct":{
			"RawSmallMeat":3,
		},
		"cookable": false,
		"spoil":[],
		"spoilTime": 4320
	  },
	"MediumCarcass": {
		"weight" : 11.2,
		"crafted": false,
		"carcass": true,
		"craftTime": 80,
		"deconstruct":{
			"RawMeat":4,
			"Leather":2
		},
		"cookable": false,
		"spoil":[],
		"spoilTime": 4320
	  },
	"LargeCarcass": {
		"weight" : 22.2,
		"crafted": false,
		"carcass": true,
		"craftTime": 120,
		"deconstruct":{
			"RawMeat":9,
			"Leather":4
		},
		"cookable": false,
		"spoil":[],
		"spoilTime": 4320
	  }
}

onready var upgrades = {
	"Bag" : {
		"size" : 2,
		"cost" : {
			"Leaf" : 12,
			"Thread" : 4,
			"Rope" : 1
		},
		
		"craftTime": 120
	},
	"Backpack" : {
		"size" : 6,
		"cost" : {
			"Leather" : 6,
			"Thread" : 8,
			"Rope" : 2
		},
		"craftTime": 360
	},
	"Cart" : {
		"size" : 12,
		"cost" : {
			"Plank" : 16,
			"BronzeIngot" : 2,
			"Rope" : 2
		},
		"craftTime": 360
	},
	"Flask" : {
		"size" : 20,
		"cost" : {
			"Clay" : 3
		},
		"craftTime": 80
	}
}
var resourcesData = {}
var upgradesData = {}
var foodData = {}

func _ready() -> void:
	Save.add_missing_keys(resources,resourcesData)
	Save.add_missing_keys(upgrades,upgradesData,TYPE_BOOL)
	Save.add_missing_keys(food,foodData,TYPE_DICTIONARY,2,{"amm":TYPE_INT,"spoil":TYPE_INT_ARRAY})

func pack():
	var data = {}
	data["resources"] = resourcesData
	data["upgrades"] = upgradesData
	data["foodData"] = foodData
	return data

func unpack(data):
	for res in resourcesData:
		resourcesData[res] = int(data["resources"][res])
	for upgrade in upgradesData:
		upgradesData[upgrade] = bool(data["upgrades"][upgrade])
	foodData = data["foodData"]

func refresh():
	update_bag()
	var flask = 1 if get_upgrade("Flask") else 0
	Global.ToolsUI.updateTool("Water",flask)
	
func get_res_amm(res):
	return int(resourcesData[res])

func get_food_amm(res):
	return int(foodData[res]["amm"])

func get_upgrade(upgrade):
	return bool(upgradesData[upgrade])

func set_upgrade(upgrade,obt):
	 upgradesData[upgrade] = bool(obt)

func empty_bag():
	var amm
	for res in Save.bag["content"]:
		amm = int(Save.bag["content"][res])
		var isfood = Inventory.food.has(res)
		add_resource(res,amm,isfood)
	Save.bag["content"].clear()
	Save.bag["space"] = Save.bag["size"]
	update_bag()

func add_resource_to_bag(res,amm,fd = false):
	var dict = food[res] if fd else resources[res]
	if(dict["weight"] > Save.bag["space"]+0.05):
		return false
	var a
	if(dict["weight"]*amm > Save.bag["space"]):
		a = floor((Save.bag["space"]+0.05)/dict["weight"])
	else:
		a = amm
	Save.bag["space"] -= dict["weight"]*a
	Save.bag["space"] = abs(Save.bag["space"])
	if(Save.bag["content"].has(res)):
		Save.bag["content"][res] += a
	else:
		Save.bag["content"][res] = a
	update_bag()
	return true

func update_bag():
	Global.BagUI.updateBag(Save.bag["space"],Save.bag["size"])

func add_resource(res,amm:int,fd = false):
	var invAmm = foodData[res]["amm"] if fd else resourcesData[res]
	if amm < 0 and invAmm < abs(amm):
		return false
	else:
		var dictData = foodData if fd else resourcesData
		if fd:
			dictData[res]["amm"] += amm
			dictData[res]["amm"] = min(dictData[res]["amm"],999)
			Global.ResourcesUI.addRes(res,dictData[res]["amm"],fd)
			add_spoil(res,amm)
		else:
			dictData[res] += amm
			dictData[res] = min(dictData[res],999)
			Global.ResourcesUI.addRes(res,dictData[res],fd)
		return true

func add_spoil(res,amm):
	if(amm > 0):
		var sp = {
			"amm": amm,
			"time": food[res]["spoilTime"]
		}
		foodData[res]["spoil"].push_back(sp)
	else:
		var i = abs(amm)
		while i > 0:
			for n in range(foodData[res]["spoil"].size()-1,-1,-1):
				var spAmm = foodData[res]["spoil"][n]["amm"]
				if i >= spAmm:
					i -= spAmm
					foodData[res]["spoil"][n]["amm"] = 0
					foodData[res]["spoil"].remove(n)
				else:
					foodData[res]["spoil"][n]["amm"] -= i
					i = 0
				if(i == 0):
					break

func check_cost(item, amm = 1, upg = false):
	var table = upgrades[item] if upg else resources[item]
	if(not table.has("cost")):
		return
	for mat in table["cost"]:
		if get_res_amm(mat) < table["cost"][mat] * amm:
			return false
	return true

func craft_item(item, amm = 1, add = true):
	for mat in resources[item]["cost"]:
		add_resource(mat, -(resources[item]["cost"][mat] * amm))
	if(add):
		add_resource(item,amm)
		Player.pass_time(resources[item]["craftTime"])

func expand_bag(item):
	if(!buy_upgrade(item)):
		return false
	Save.bag["size"] += upgrades[item]["size"]
	Save.bag["space"] += upgrades[item]["size"]
	update_bag()
	return true

func buy_upgrade(item):
	if(get_upgrade(item) or !check_cost(item,1,true)):
		return false
	for mat in upgrades[item]["cost"]:
		add_resource(mat, -(upgrades[item]["cost"][mat]))
	set_upgrade(item,true)
	Player.pass_time(upgrades[item]["craftTime"])
	return true

func expand_water(item):
	if(!buy_upgrade(item)):
		return false
	Player.upd_max_water(upgrades[item]["size"]) 
	return true

func spoil_food(time):
	time *= Buildings.getCurrentModule("House","Cellar")["benefits"]["spoilMult"]
	for res in food:
		if not foodData[res]["spoil"].empty():
			for n in range(foodData[res]["spoil"].size()-1,-1,-1):
				foodData[res]["spoil"][n]["time"] -= time
				if(foodData[res]["spoil"][n]["time"] < 0):
					add_resource(res,-foodData[res]["spoil"][n]["amm"],true)
