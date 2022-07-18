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
	  }
}
onready var tools = {
	"Pickaxe": {
		"tier" : 0,
	  },
	"Axe": {
		"tier" : 0,
	  },
	"Knife": {
		"tier" : 0,
	  }
}
onready var resPanel = get_node("/root/Game/Canvas/UI/Resources")
onready var bagNode = get_node("/root/Game/Canvas/UI/Status/TopBar/HBoxContainer/Bag")
onready var bagNodeTex = bagNode.get_node("TextureProgress")

func _ready() -> void:
	pass

func empty_bag():
	for res in resources:
		resources[res]["ammount"] += resources[res]["bagAmmount"]
		resources[res]["bagAmmount"] = 0
		resPanel.update_resource(res,resources[res]["ammount"])
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
	bagNode.get_node("TextureProgress").value = (1 - bagSpaceLeft / bagSize)*100
	bagNode.get_node("TextureProgress/Value").text = str(bagSpaceLeft)
