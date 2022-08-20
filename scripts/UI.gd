extends Control

onready var health: Control = $Status/TextureRect/Health
onready var food: Control = $Status/TextureRect/Food
onready var water: Control = $Status/TextureRect/Water
onready var energy: Control = $Status/TextureRect/Energy

func _ready() -> void:
	Global.UI = self
	
