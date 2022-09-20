extends Node2D
onready var in_g_settings: Control = $"%InGSettings"

func _ready() -> void:
	Player.refresh_status()
	Global.Weather.setWeather(Global.Weather.type.Calm)

func _on_Settings_Button_pressed() -> void:
	in_g_settings.show()
