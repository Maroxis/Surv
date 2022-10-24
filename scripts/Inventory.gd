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
			"time": 8
		}
	  },
	"Wood": {
		"weight" : 2.4,
		"crafted": false,
		"burining":{
			"temp": 1200,
			"time": 30
		}
	  },
	"Herb": {
		"weight" : 0.8,
		"crafted": false
	  },
	"HerbPowder": {
		"weight" : 0.8,
		"cost" : {
			"Herb" : 6
		},
		"requirement": {
			"module" : {
				"bname":"Workbench",
				"mname":"Mortar",
				"tier" : 1
			}
		},
		"craftTime": 40,
		"crafted": true
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
	"Cloth": {
		"weight" : 1.2,
		"cost" : {
			"Thread" : 5
		},
		"craftBenefit": {
			"module":{
				"bname": "Workbench",
				"mname": "SpinningWheel"
			}
		},
		"craftTime": 60,
		"crafted": true
	  },
	"Rope": {
		"weight" : 1.0,
		"cost" : {
			"Thread" : 3
		},
		"craftBenefit": {
			"module":{
				"bname": "Workbench",
				"mname": "SpinningWheel"
			}
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
			"Wood" : 2
		},
		"requirement": {
			"tool":{
				"name" : "Saw",
				"tier" : 1
			}
		},
		"craftBenefit": {
			"module":{
				"bname": "Workbench",
				"mname": "Chisel"
			}
		},
		"craftTime": 40,
		"crafted": true
	  },
	"Rock": {
		"weight" : 2.0,
		"crafted": false
	  },
	"Clay": {
		"weight" : 3.2,
		"crafted": false
	  },
	"Brick": {
		"weight" : 2.4,
		"cost" : {
			"Clay" : 3
		},
		"meltingTemp" : 600,
		"craftTime": 120,
		"furnaceTier": 1,
		"crafted": true
	  },
	"Sand": {
		"weight" : 2.6,
		"crafted": false
	  },
	"Coal": {
		"weight" : 1.8,
		"crafted": false,
		"burining":{
			"temp": 2000,
			"time": 90
		}
	  },
	"CopperOre": {
		"weight" : 1.4,
		"crafted": false,
	  },
	"TinOre": {
		"weight" : 1.2,
		"crafted": false,
	  },
	"IronOre": {
		"weight" : 2.0,
		"crafted": false,
	  },
	"CopperIngot": {
		"weight" : 10.8,
		"cost" : {
			"CopperOre" : 8
		},
		"meltingTemp" : 1000,
		"craftTime": 720,
		"furnaceTier": 1,
		"crafted": true
	  },
	"BronzeIngot": {
		"weight" : 10.8,
		"cost" : {
			"CopperOre" : 8,
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
			"IronOre" : 8
		},
		"meltingTemp" : 1800,
		"craftTime": 1440,
		"furnaceTier": 2,
		"crafted": true
	  },
	"Nail": {
		"weight" : 0.6,
		"cost" : {
			"IronOre" : 1
		},
		"meltingTemp" : 1800,
		"craftTime": 180,
		"furnaceTier": 2,
		"crafted": true
	  }
}

onready var food = {
	"RawSmallMeat": {
		"weight" : 1.2,
		"crafted": false,
		"cookable": true,
		"dryable": true,
		"calories": 40,
		"water": 5,
		"sick": 10,
		"spoil":[],
		"spoilTime": 2160,
		"cookTime": 5,
		"dryTime": 50,
		"cooksInto" : "CookedSmallMeat",
		"driesInto" : "DriedMeat",
		"dryMult" : 1
	  },
	"RawMeat": {
		"weight" : 2.8,
		"crafted": false,
		"cookable": true,
		"dryable": true,
		"calories": 80,
		"water": 10,
		"sick": 15,
		"spoil":[],
		"spoilTime": 2160,
		"cookTime": 10,
		"dryTime": 100,
		"cooksInto" : "CookedMeat",
		"driesInto" : "DriedMeat",
		"dryMult" : 2
	  },
	"WildBerry": {
		"weight" : 1.2,
		"crafted": false,
		"cookable": false,
		"calories": 8,
		"water": 4,
		"sick": 1,
		"spoil":[],
		"spoilTime": 1440
	  },
	"CookedSmallMeat": {
		"weight" : 1.0,
		"crafted": true,
		"cookable": false,
		"calories": 40,
		"water": 4,
		"spoil":[],
		"spoilTime": 4320
	  },
	"CookedMeat": {
		"weight" : 2.2,
		"crafted": true,
		"cookable": false,
		"calories": 80,
		"water": 8,
		"spoil":[],
		"spoilTime": 5760
	  },
	"DriedMeat": {
		"weight" : 1.8,
		"crafted": true,
		"cookable": false,
		"calories": 30,
		"water": 1,
		"spoil":[],
		"spoilTime": 10080
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
		"weight" : 8.6,
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
		"weight" : 14.8,
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
			"Plank" : 12,
			"BronzeIngot" : 2,
			"Rope" : 2
		},
		"craftTime": 360
	},
	"Flask" : {
		"size" : {
			"Water":20
		},
		"cost" : {
			"Clay" : 3
		},
		"craftTime": 80
	},
	"Pouch" : {
		"size" : {
			"Water":20,
			"Food": 20
		},
		"cost" : {
			"Leather" : 2,
			"Thread" : 3,
			"Rope" : 1
		},
		"craftTime": 80
	}
}

onready var meds = {
	"Poultice":{
		"cost" : {
			"Herb" : 3,
			"Cloth": 1
		},
		"craftTime": 20,
		"buffs":{
			"time": 960,
			"sickGain": 0.8,
			"sickReduction": 2.0
		}
	},
	"HerbalTea":{
		"cost" : {
			"HerbPowder" : 1,
			"Cloth": 1
		},
		"craftTime": 10,
		"buffs":{
			"time": 1440,
			"healthRegen": 2.0,
			"sickReduction": 2.0
		}
	},
	"HerbalGranulate":{
		"cost" : {
			"HerbPowder" : 2,
			"Coal": 2
		},
		"craftTime": 80,
		"buffs":{
			"time": 2880,
			"healthRegen": 1.2,
			"sickReduction": 3.2
		},
		"requirement": {
			"module" : {
				"bname":"Workbench",
				"mname":"Mortar",
				"tier" : 1
			}
		}
	}
}

var resourcesData = {}
var upgradesData = {}
var foodData = {}
var medsData = {}

func _ready() -> void:
	Save.add_missing_keys(resources,resourcesData)
	Save.add_missing_keys(upgrades,upgradesData,TYPE_BOOL)
	Save.add_missing_keys(food,foodData,TYPE_DICTIONARY,2,{"amm":TYPE_INT,"spoil":TYPE_INT_ARRAY})
	Save.add_missing_keys(meds,medsData)

func pack():
	var data = {}
	data["resources"] = resourcesData
	data["upgrades"] = upgradesData
	data["foodData"] = foodData
	data["medsData"] = medsData
	return data

func unpack(data):
	for res in resourcesData:
		resourcesData[res] = int(data["resources"][res])
	for upgrade in upgradesData:
		upgradesData[upgrade] = bool(data["upgrades"][upgrade])
	foodData = data["foodData"]
	medsData = data["medsData"]

func refresh():
	update_bag()
	var flask = 1 if get_upgrade("Flask") else 0
	Global.ToolsUI.updateTool("Water",flask)
	
func get_food_total_amm():
	var amm = 0
	for fd in foodData:
		amm += foodData[fd]["amm"]
	return amm

func get_res_amm(res):
	return int(resourcesData[res])
	
func get_meds_amm(res):
	return int(medsData[res])

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
	if amm == 0:
		return false
	var invAmm = foodData[res]["amm"] if fd else resourcesData[res]
	invAmm = int(invAmm)
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

func add_meds(item,amm):
	medsData[item] += amm
	medsData[item] = min(medsData[item],999)
	Global.ResourcesUI.addRes(item,medsData[item],false,true)

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
			for n in foodData[res]["spoil"].size():
				var spAmm = foodData[res]["spoil"][n]["amm"]
				if i >= spAmm:
					i -= spAmm
					foodData[res]["spoil"][n]["amm"] = 0
				else:
					foodData[res]["spoil"][n]["amm"] -= i
					i = 0
				if(i == 0):
					break

func check_cost(item, amm = 1, table = resources):
	table = table[item]
	if(not table.has("cost")):
		return
	var reduction = get_cost_reduction(table)
	for mat in table["cost"]:
		if get_res_amm(mat) < (table["cost"][mat] - reduction) * amm:
			return false
	return true

func get_cost_reduction(item):
	var reduction = 0
	var bene =  get_craft_benefit(item)
	if bene != null and bene.has("resReduction"):
		reduction = bene["resReduction"]
	return reduction

func get_craft_benefit(item):
	if item.has("craftBenefit"):
		if item["craftBenefit"].has("module"):
			var m = item["craftBenefit"]["module"]
			var bene = Buildings.getCurrentModule(m["bname"],m["mname"])["benefits"]
			return bene
	return null

func craft_item(item, amm = 1, add = true):
	var reduction = get_cost_reduction(resources[item])
	for mat in resources[item]["cost"]:
		add_resource(mat, -((resources[item]["cost"][mat] - reduction) * amm))
	if(add):
		add_resource(item,amm)
		var time = get_item_craft_time(item)
		Player.pass_time(time)

func get_item_craft_time(item, dict = resources):
	var bonus = 1
	if dict[item].has("requirement"):
			if dict[item]["requirement"].has("tool"):
				var tl = dict[item]["requirement"]["tool"]["name"]
				var tier = dict[item]["requirement"]["tool"]["tier"]
				bonus = Tools.getBonus(tl,tier)
			if dict[item]["requirement"].has("module"):
				var bname = dict[item]["requirement"]["module"]["bname"]
				var mname = dict[item]["requirement"]["module"]["mname"]
				bonus *= Buildings.getCurrentModule(bname,mname)["benefits"]["actionMult"]
	var bene = get_craft_benefit(dict[item])
	if bene != null and bene.has("actionMult"):
		bonus *= bene["actionMult"]
	bonus = max(bonus,1)
	return dict[item]["craftTime"]/bonus

func craft_meds(item, amm = 1):
	var reduction = get_cost_reduction(meds[item])
	for mat in meds[item]["cost"]:
		add_resource(mat, -((meds[item]["cost"][mat] - reduction) * amm))
	add_meds(item,amm)
	var time = get_item_craft_time(item,meds)
	Player.pass_time(time*amm)


func expand_bag(item):
	if(!buy_upgrade(item)):
		return false
	Save.bag["size"] += upgrades[item]["size"]
	Save.bag["space"] += upgrades[item]["size"]
	update_bag()
	return true

func buy_upgrade(item):
	if(get_upgrade(item) or !check_cost(item,1,upgrades)):
		return false
	for mat in upgrades[item]["cost"]:
		add_resource(mat, -(upgrades[item]["cost"][mat]))
	set_upgrade(item,true)
	Player.pass_time(upgrades[item]["craftTime"])
	return true

func expand_water(item):
#	Global.ToolsUI.updateTool("Water", 1)
	Player.upd_max_water(upgrades[item]["size"]["Water"]) 
	return true
func expand_food(item):
	Player.upd_max_food(upgrades[item]["size"]["Food"]) 
	return true

func spoil_food(time):
	time *= Buildings.getCurrentModule("House","Cellar")["benefits"]["spoilMult"]
	for res in food:
		if not foodData[res]["spoil"].empty():
			for n in range(foodData[res]["spoil"].size()-1,-1,-1):
				foodData[res]["spoil"][n]["time"] = int(foodData[res]["spoil"][n]["time"]-time)
				if(foodData[res]["spoil"][n]["time"] < 0):
					add_resource(res,-foodData[res]["spoil"][n]["amm"],true)
					foodData[res]["spoil"].remove(n)
