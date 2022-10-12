extends Control

onready var health: Control = $"%Health"
onready var food: Control = $"%Food"
onready var water: Control = $"%Water"
onready var energy: Control = $"%Energy"

func _ready() -> void:
	Global.UI = self

func refresh():
	refreshWater()
	refreshFood()
	refreshEnergy()
	refreshHealth()

func refreshWater():
	water.get_node("TextureProgress").animateValue(ceil(Player.water))
	water.get_node("TextureProgress/Value").text = str(ceil(Player.water))

func refreshFood():
	food.get_node("TextureProgress").animateValue(ceil(Player.food))
	food.get_node("TextureProgress/Value").text = str(ceil(Player.food))

func refreshHealth():
	health.get_node("TextureProgress").animateValue(ceil(Player.health))
	health.get_node("TextureProgress/Value").text = str(ceil(Player.health))
	health.get_node("SickProgress").animateValue(ceil(Player.sick))
	health.get_node("SickProgress").flashBar(Player.sick > 80)
	health.setMedMaxTime(Player.medsBuff["totalTime"])
	health.setMedProgress(Player.medsBuff["time"])
	

func refreshEnergy():
	energy.get_node("TextureProgress").animateValue(ceil(Player.energy))
	energy.get_node("TextureProgress/Value").text = str(ceil(Player.energy))

func refreshMaxWater():
	water.get_node("TextureProgress").max_value = Player.maxWater

func refreshMaxFood():
	food.get_node("TextureProgress").max_value = Player.maxFood

func hardRefresh():
	refreshMaxWater()
	refreshMaxFood()
	refresh()
