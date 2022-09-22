extends Node

var DebugUI
onready var on = true

func _ready() -> void:
	return

func add_resources():
	for res in Inventory.resources:
		Inventory.add_resource(res,99)
	for food in Inventory.food:
		Inventory.add_resource(food,99,true)
