extends Node

var DebugUI
var on
var godMode = false

func _ready() -> void:
	on = OS.is_debug_build()

func add_resources():
	for res in Inventory.resources:
		Inventory.add_resource(res,99)
	for food in Inventory.food:
		Inventory.add_resource(food,99,true)

func keep_status_full():
	Player.change_water(Player.maxWater,true)
	Player.change_food(Player.maxFood,true)
	Player.change_energy(Player.maxEnergy,true)
	Player.change_health(Player.maxHealth,true)
