extends Control
onready var in_g_settings: Control = $"%InGSettings"

func _ready() -> void:
	Player.refresh_status()
	Global.Weather.setWeather(Global.Weather.type.Calm)
	Global.Weather.refresh()
	if not Save.autoLoad():
		Global.refresh()
#	print(OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS))
#	print(OS.request_permissions())
	

func _on_Settings_Button_pressed() -> void:
	in_g_settings.show()
