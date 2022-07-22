extends Node

var bagSize = 10
var bagSpaceLeft = 10
onready var resources = {
	"Leaf": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 0.6
	  },
	"Stick": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 1.2
	  },
	"Wood": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 3.2
	  },
	"Rope": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 1.0
	  },
	"Rock": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 4.8
	  },
	"Clay": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 3.6
	  },
	"CopperOre": {
		"ammount" : 0,
		"bagAmmount":0,
		"weight" : 5.2
	  }
}
func _ready() -> void:
	pass

func empty_bag():
	for res in resources:
		resources[res]["ammount"] += resources[res]["bagAmmount"]
		if resources[res]["ammount"] > 99:
			resources[res]["ammount"] = 99
		resources[res]["bagAmmount"] = 0
		Global.ResourcesUI.update_resource(res,resources[res]["ammount"])
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
		return true
