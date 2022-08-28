extends Control

onready var current = 1
onready var icons = get_children()

func _ready() -> void:
	Global.Weather.connect("weatherChanged",self,"updateIcon")
	
func updateIcon():
	icons[current].visible = false
	current = Global.Weather.current
	icons[current].visible = true
