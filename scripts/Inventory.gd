extends Node

var bagSize = 10
var bagSpaceLeft = 10
onready var resources = {
	"Leaf": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 0.6,
		"crafted": false
	  },
	"Stick": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 1.2,
		"crafted": false
	  },
	"Wood": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 3.2,
		"crafted": false,
		"burining":{
			"temp": 1200,
			"time": 20
		}
	  },
	"Rope": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 1.0,
		"cost" : {
			"Leaf" : 3
		},
		"craftTime": 10,
		"crafted": true
	  },
	"Plank": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 4.0,
		"cost" : {
			"Wood" : 3
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
		"bagAmmount":0,
		"weight" : 2.8,
		"crafted": false
	  },
	"Clay": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 3.6,
		"crafted": false
	  },
	"Coal": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 3.2,
		"crafted": false,
		"burining":{
			"temp": 2000,
			"time": 60
		}
	  },
	"CopperOre": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 1.2,
		"crafted": false,
	  },
	"TinOre": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 1.2,
		"crafted": false,
	  },
	"IronOre": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 1.2,
		"crafted": false,
	  },
	"CopperIngot": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 10.8,
		"cost" : {
			"CopperOre" : 10
		},
		"meltingTemp" : 1000,
		"craftTime": 260,
		"furnaceTier": 1,
		"crafted": true
	  },
	"BronzeIngot": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 10.8,
		"cost" : {
			"CopperOre" : 9,
			"TinOre" : 1
		},
		"meltingTemp" : 1000,
		"craftTime": 180,
		"furnaceTier": 1,
		"crafted": true
	  },
	"IronIngot": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 10.8,
		"cost" : {
			"IronOre" : 10
		},
		"meltingTemp" : 1800,
		"craftTime": 420,
		"furnaceTier": 2,
		"crafted": true
	  },
	"RawMeat": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 2.8,
		"crafted": false,
		"food": true,
		"calories": 80,
		"sick": 40,
		"spoil":[],
		"spoilTime": 2160,
		"cookTime": 10,
		"cooksInto" : "CookedMeat"
	  },
	"WildBerry": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 1.2,
		"crafted": false,
		"food": true,
		"calories": 10,
		"water": 3,
		"sick": 5,
		"spoil":[],
		"spoilTime": 960
	  },
	"CookedMeat": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 2.2,
		"crafted": true,
		"food": true,
		"calories": 80,
		"spoil":[],
		"spoilTime": 4320
	  }
}
onready var upgrades = {
	"Bag" : {
		"obtained" : false,
		"size" : 2,
		"cost" : {
			"Leaf" : 3,
			"Rope" : 2
		},
		
		"craftTime": 40
	},
	"Backpack" : {
		"obtained" : false,
		"size" : 6,
		"cost" : {
			"Leaf" : 3,
			"Rope" : 2
		},
		"craftTime": 80
	},
	"Flask" : {
		"obtained" : false,
		"size" : 20,
		"cost" : {
			"Clay" : 2
		},
		"craftTime": 40
	}
}

func _ready() -> void:
	pass

func empty_bag():
	var amm
	for res in resources:
		amm = resources[res]["bagAmmount"]
		if(amm > 0):
			add_resource(res,amm)
			resources[res]["bagAmmount"] = 0
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
	resources[res]["bagAmmount"] += a
	update_bag()
	return true

func update_bag():
	Global.BagUI.updateBag(bagSpaceLeft,bagSize)

func add_resource(res,amm,cook = false):
	if amm < 0 and resources[res]["ammount"] < abs(amm):
		return false
	else:
		resources[res]["ammount"] += amm
		if resources[res]["ammount"] > 99:
			resources[res]["ammount"] = 99
		if(resources[res].has("food")):
			if(amm > 0):
				var sp = {
					"amm": amm,
					"time": resources[res]["spoilTime"]
				}
				resources[res]["spoil"].push_back(sp)
			elif(cook):
				var i = abs(amm)
				while i > 0:
					for n in resources[res]["spoil"].size():
						var spAmm = resources[res]["spoil"][n]["amm"]
						if i >= spAmm:
							i -= spAmm
							resources[res]["spoil"][n]["amm"] = 0
						else:
							resources[res]["spoil"][n]["amm"] -= i
							i = 0
						if(i == 0):
							break
		Global.ResourcesUI.addRes(res,resources[res]["ammount"],resources[res]["crafted"])
		return true

func check_cost(item, amm = 1, upg = false):
	var table = upgrades[item] if upg else resources[item]
	for mat in table["cost"]:
		if resources[mat]["ammount"] < table["cost"][mat] * amm:
			return false
	return true

func craft_item(item, amm = 1):
	for mat in resources[item]["cost"]:
		add_resource(mat, -(resources[item]["cost"][mat] * amm))
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
					resources[res]["spoil"].remove(n)

