extends Node2D

onready var debug: Control = $"%Debug"
onready var dev = true
onready var status: Control = $"%Status"

func _ready() -> void:
	Player.refresh_status()
	Global.Weather.setWeather(Global.Weather.type.Calm)
	debug.visible = dev
	status.visible = dev

func _on_TestButton_pressed() -> void:
	if(Global.Weather.current < Global.Weather.type.size() -1):
		Global.Weather.setWeather(Global.Weather.current+1)
	else:
		Global.Weather.setWeather(0)
