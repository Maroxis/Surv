extends Control
onready var in_g_settings: Control = $"%InGSettings"

func _ready() -> void:
	Player.refresh_status()
	Global.Weather.setWeather(Global.Weather.type.Calm)
	Global.Weather.refresh()
	Save.autoLoad()

func _on_Settings_Button_pressed() -> void:
	in_g_settings.show()
