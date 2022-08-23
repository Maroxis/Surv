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
		"crafted": false
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
	"Rock": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 4.8,
		"crafted": false
	  },
	"Clay": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 3.6,
		"crafted": false
	  },
	"CopperOre": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 5.2,
		"crafted": false
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

func add_resource(res,amm):
	if amm < 0 and resources[res]["ammount"] < abs(amm):
		return false
	else:
		resources[res]["ammount"] += amm
		if resources[res]["ammount"] > 99:
			resources[res]["ammount"] = 99
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
