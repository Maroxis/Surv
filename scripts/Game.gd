extends Control
onready var in_g_settings: Control = $"%InGSettings"

func _ready() -> void:
	Player.refresh_status()
	Global.Weather.setWeather(Global.Weather.type.Calm)
	Global.Weather.refresh()
	if not Save.autoLoad():
		Global.refresh()

func _on_Settings_Button_pressed() -> void:
	Global.Sound.play(Sound.UI_DEFAULT, "SFX")
	in_g_settings.show()

func _notification(what):   
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST: 
		Global.to_title_menu()
