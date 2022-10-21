extends Node

var DebugUI
var on

func _ready() -> void:
	on = OS.is_debug_build()

func add_resources():
	for res in Inventory.resources:
		Inventory.add_resource(res,99)
	for food in Inventory.food:
		Inventory.add_resource(food,99,true)
