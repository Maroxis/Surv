extends Control

onready var health: Control = $"%Health"
onready var food: Control = $"%Food"
onready var water: Control = $"%Water"
onready var energy: Control = $"%Energy"

func _ready() -> void:
	Global.UI = self
	
