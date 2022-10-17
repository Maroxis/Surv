extends Control

onready var wild_berry = $VBoxContainer/WildBerry
onready var cooked_small_meat = $VBoxContainer/CookedSmallMeat
onready var cooked_meat = $VBoxContainer/CookedMeat


func _ready() -> void:
	Global.FoodLookup = self
	refresh()

func refresh():
	wild_berry.changeCount(Inventory.get_food_amm("WildBerry"))
	cooked_small_meat.changeCount(Inventory.get_food_amm("CookedSmallMeat"))
	cooked_meat.changeCount(Inventory.get_food_amm("CookedMeat"))
