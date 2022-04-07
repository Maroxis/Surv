extends Node

var size = 10
onready var resources = {
	"Leaf": {
		"ammount" : 0,
		"weight" : 0.6
	  },
	"Stick": {
		"ammount" : 0,
		"weight" : 1.2
	  },
	"Wood": {
		"ammount" : 0,
		"weight" : 3.2
	  },
	"Rope": {
		"ammount" : 0,
		"weight" : 1.0
	  },
	"Rock": {
		"ammount" : 0,
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

func _ready() -> void:
	pass

func add_resource(res,amm = 0, split = 1):
	if(amm == 0):
		amm = floor((size/split)/resources[res]["weight"])
	
	resources[res]["ammount"] += amm
	resPanel.update_resource(res,resources[res]["ammount"])
