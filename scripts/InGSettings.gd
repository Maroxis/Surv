extends Control
onready var debug: VBoxContainer = $"%Debug"

onready var save_button: ToolButton = $"%SaveButton"
onready var load_button: ToolButton = $"%LoadButton"
onready var delete_save_button: TextureButton = $"%DeleteSaveButton"

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


func _on_SaveButton_pressed() -> void:
	if Save.saveData(Save.save_file):
		save_button.shake()
	else:
		save_button.shakeSide()

func _on_LoadButton_pressed() -> void:
	if Save.loadData(Save.save_file):
		load_button.shake()
	else:
		load_button.shakeSide()



func _on_DeleteSaveButton_pressed() -> void:
	if Save.removeData(Save.auto_save_file) and Save.loadData(Save.blank_save_file):
		delete_save_button.shake()
	else:
		delete_save_button.shakeSide()
