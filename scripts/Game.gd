extends Node2D

func _ready() -> void:
	Player.refresh_status()
	Global.Weather.setWeather(Global.Weather.type.Calm)

func _on_TestButton_pressed() -> void:
	if(Global.Weather.current < Global.Weather.type.size() -1):
		Global.Weather.setWeather(Global.Weather.current+1)
	else:
		Global.Weather.setWeather(0)
