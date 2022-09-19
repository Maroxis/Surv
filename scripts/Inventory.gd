extends Node

var bagSize = 10
var bagSpaceLeft = 10
var bag = {}
onready var resources = {
	"Leaf": {
		"ammount" : 0,
		"weight" : 0.6,
		"crafted": false
	  },
	"Stick": {
		"ammount" : 0,
		"weight" : 1.2,
		"crafted": false,
		"burining":{
			"temp": 600,
			"time": 5
		}
	  },
	"Wood": {
		"ammount" : 0,
		"weight" : 3.2,
		"crafted": false,
		"burining":{
			"temp": 1200,
			"time": 20
		}
	  },
	"Leather": {
		"ammount" : 0,
		"weight" : 2.4,
		"crafted": true
	  },
	"Thread": {
		"ammount" : 0,
		"weight" : 0.2,
		"cost" : {
			"Leaf" : 3
		},
		"craftTime": 30,
		"crafted": true
	  },
	"Rope": {
		"ammount" : 0,
		"weight" : 1.0,
		"cost" : {
			"Thread" : 3
		},
		"craftTime": 60,
		"crafted": true
	  },
	"Torch": {
		"ammount" : 0,
		"weight" : 2.2,
		"cost" : {
			"Stick" : 1,
			"Rope" : 1
		},
		"craftTime": 10,
		"crafted": true
	  },
	"Plank": {
		"ammount" : 0,
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
		"ammount" : 0,
		"weight" : 2.8,
		"crafted": false
	  },
	"Clay": {
		"ammount" : 0,
		"weight" : 3.6,
		"crafted": false
	  },
	"Sand": {
		"ammount" : 0,
		"weight" : 2.6,
		"crafted": false
	  },
	"Coal": {
		"ammount" : 0,
		"weight" : 2.6,
		"crafted": false,
		"burining":{
			"temp": 2000,
			"time": 60
		}
	  },
	"CopperOre": {
		"ammount" : 0,
		"weight" : 1.2,
		"crafted": false,
	  },
	"TinOre": {
		"ammount" : 0,
		"weight" : 1.2,
		"crafted": false,
	  },
	"IronOre": {
		"ammount" : 0,
		"weight" : 1.2,
		"crafted": false,
	  },
	"CopperIngot": {
		"ammount" : 0,
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
		"ammount" : 0,
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
		"ammount" : 0,
		"weight" : 10.8,
		"cost" : {
			"IronOre" : 10
		},
		"meltingTemp" : 1800,
		"craftTime": 1440,
		"furnaceTier": 2,
		"crafted": true
	  },
	"RawSmallMeat": {
		"ammount" : 0,
		"weight" : 1.2,
		"crafted": false,
		"food": true,
		"cookable": true,
		"calories": 40,
		"sick": 10,
		"spoil":[],
		"spoilTime": 2160,
		"cookTime": 5,
		"cooksInto" : "CookedSmallMeat"
	  },
	"RawMeat": {
		"ammount" : 0,
		"weight" : 2.8,
		"crafted": false,
		"food": true,
		"cookable": true,
		"calories": 80,
		"sick": 30,
		"spoil":[],
		"spoilTime": 2160,
		"cookTime": 10,
		"cooksInto" : "CookedMeat"
	  },
	"WildBerry": {
		"ammount" : 0,
		"weight" : 1.2,
		"crafted": false,
		"food": true,
		"cookable": false,
		"calories": 10,
		"water": 3,
		"sick": 5,
		"spoil":[],
		"spoilTime": 1440
	  },
	"CookedSmallMeat": {
		"ammount" : 0,
		"weight" : 1.0,
		"crafted": true,
		"food": true,
		"cookable": false,
		"calories": 40,
		"spoil":[],
		"spoilTime": 4320
	  },
	"CookedMeat": {
		"ammount" : 0,
		"weight" : 2.2,
		"crafted": true,
		"food": true,
		"cookable": false,
		"calories": 80,
		"spoil":[],
		"spoilTime": 4320
	  },
	"SmallCarcass": {
		"ammount" : 0,
		"weight" : 4.8,
		"crafted": false,
		"carcass": true,
		"craftTime": 40,
		"deconstruct":{
			"RawSmallMeat":3,
		},
		"food": true,
		"cookable": false,
		"spoil":[],
		"spoilTime": 4320
	  },
	"MediumCarcass": {
		"ammount" : 0,
		"weight" : 11.2,
		"crafted": false,
		"carcass": true,
		"craftTime": 80,
		"deconstruct":{
			"RawMeat":4,
			"Leather":2
		},
		"food": true,
		"cookable": false,
		"spoil":[],
		"spoilTime": 4320
	  },
	"largeCarcass": {
		"ammount" : 0,
		"weight" : 22.2,
		"crafted": false,
		"carcass": true,
		"craftTime": 120,
		"deconstruct":{
			"RawMeat":9,
			"Leather":4
		},
		"food": true,
		"cookable": false,
		"spoil":[],
		"spoilTime": 4320
	  }
}
onready var upgrades = {
	"Bag" : {
		"obtained" : false,
		"size" : 2,
		"cost" : {
			"Leaf" : 12,
			"Thread" : 4,
			"Rope" : 1
		},
		
		"craftTime": 120
	},
	"Backpack" : {
		"obtained" : false,
		"size" : 6,
		"cost" : {
			"Leaf" : 3,
			"Rope" : 2
		},
		"craftTime": 360
	},
	"Flask" : {
		"obtained" : false,
		"size" : 20,
		"cost" : {
			"Clay" : 3
		},
		"craftTime": 80
	}
}


func _ready() -> void:
	pass

func empty_bag():
	var amm
	for res in bag:
		amm = bag[res]
		add_resource(res,amm)
	bag.clear()
	bagSpaceLeft = bagSize
	update_bag()

func add_resource_to_bag(res,amm):
	if(resources[res]["weight"] > bagSpaceLeft+0.05):
		return false
	var a
	if(resources[res]["weight"]*amm > bagSpaceLeft):
		a = floor((bagSpaceLeft+0.05)/resources[res]["weight"])
	else:
		a = amm
	bagSpaceLeft -= resources[res]["weight"]*a
	bagSpaceLeft = abs(bagSpaceLeft)
	if(bag.has(res)):
		bag[res] += a
	else:
		bag[res] = a
	update_bag()
	return true

func update_bag():
	Global.BagUI.updateBag(bagSpaceLeft,bagSize)

func add_resource(res,amm):
	if amm < 0 and resources[res]["ammount"] < abs(amm):
		return false
	else:
		if Inventory.resources[res].has("food"):
			add_spoil(res,amm)
		resources[res]["ammount"] += amm
		if resources[res]["ammount"] > 999:
			resources[res]["ammount"] = 999
		Global.ResourcesUI.addRes(res,resources[res]["ammount"],resources[res]["crafted"])
		return true

func add_spoil(res,amm):
	if(amm > 0):
		var sp = {
			"amm": amm,
			"time": resources[res]["spoilTime"]
		}
		resources[res]["spoil"].push_back(sp)
	else:
		var i = abs(amm)
		while i > 0:
			for n in range(resources[res]["spoil"].size()-1,-1,-1):
				var spAmm = resources[res]["spoil"][n]["amm"]
				if i >= spAmm:
					i -= spAmm
					resources[res]["spoil"][n]["amm"] = 0
					resources[res]["spoil"].remove(n)
				else:
					resources[res]["spoil"][n]["amm"] -= i
					i = 0
				if(i == 0):
					break

func check_cost(item, amm = 1, upg = false):
	var table = upgrades[item] if upg else resources[item]
	if(not table.has("cost")):
		return
	for mat in table["cost"]:
		if resources[mat]["ammount"] < table["cost"][mat] * amm:
			return false
	return true

func craft_item(item, amm = 1, add = true):
	for mat in resources[item]["cost"]:
		add_resource(mat, -(resources[item]["cost"][mat] * amm))
	if(add):
		add_resource(item,amm)
		Player.pass_time(resources[item]["craftTime"])

func expand_bag(item):
	if(upgrades[item]["obtained"] or !check_cost(item,1,true)):
		return false
	for mat in upgrades[item]["cost"]:
		add_resource(mat, -(upgrades[item]["cost"][mat]))
	upgrades[item]["obtained"] = true
	bagSize += upgrades[item]["size"]
	bagSpaceLeft += upgrades[item]["size"]
	update_bag()
	Player.pass_time(upgrades[item]["craftTime"])
	return true
	
func expand_water(item):
	if(upgrades[item]["obtained"] or !check_cost(item,1,true)):
		return false
	for mat in upgrades[item]["cost"]:
		add_resource(mat, -(upgrades[item]["cost"][mat]))
	upgrades[item]["obtained"] = true
	Player.upd_max_water(upgrades[item]["size"]) 
	Player.pass_time(upgrades[item]["craftTime"])
	return true

func spoil_food(time):
	for res in resources:
		if resources[res].has("food") and not resources[res]["spoil"].empty():
			for n in range(resources[res]["spoil"].size()-1,-1,-1):
				resources[res]["spoil"][n]["time"] -= time
				if(resources[res]["spoil"][n]["time"] < 0):
					add_resource(res,-resources[res]["spoil"][n]["amm"])
#					resources[res]["spoil"].remove(n)

