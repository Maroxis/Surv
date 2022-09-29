extends Control

onready var wild_berry: HBoxContainer = $VBoxContainer/WildBerry
onready var cooked_small_meat: HBoxContainer = $VBoxContainer/CookedSmallMeat
onready var cooked_meat: HBoxContainer = $VBoxContainer/CookedMeat


func _ready() -> void:
	Global.FoodLookup = self

func refresh():
	wild_berry.changeCount(Inventory.get_food_amm("WildBerry"))
	cooked_small_meat.changeCount(Inventory.get_food_amm("CookedSmallMeat"))
	cooked_meat.changeCount(Inventory.get_food_amm("CookedMeat"))
