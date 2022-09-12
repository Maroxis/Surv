extends Control
onready var debug: VBoxContainer = $"%Debug"

func _ready() -> void:
	debug.visible = DevMode.on

func _on_Debug_Button_toggled(on) -> void:
	DevMode.DebugUI.switch(on)


func _on_Exit_Button_pressed() -> void:
	hide()


func _on_MasterProgressSlider_value_changed(value: float) -> void:
	var sfx_index= AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(sfx_index, value)

func _on_MusicProgressSlider_value_changed(value: float) -> void:
	var sfx_index= AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(sfx_index, value)

func _on_SFXProgressSlider_value_changed(value: float) -> void:
	var sfx_index= AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(sfx_index, value)


func _on_WeatherProgressSlider_value_changed(value: float) -> void:
	var sfx_index= AudioServer.get_bus_index("Weather")
	AudioServer.set_bus_volume_db(sfx_index, value)
