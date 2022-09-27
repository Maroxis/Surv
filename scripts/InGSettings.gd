extends Control
onready var debug: VBoxContainer = $"%Debug"

onready var save_button: ToolButton = $"%SaveButton"
onready var load_button: ToolButton = $"%LoadButton"
onready var delete_save_button: TextureButton = $"%DeleteSaveButton"
onready var sound: VBoxContainer = $"%Sound"

func _ready() -> void:
	debug.visible = DevMode.on
	Global.InGSettings = self

func pack():
	var data = {}
	for ch in AudioServer.bus_count:
		data[ch] = AudioServer.get_bus_volume_db(ch)
	return data

func unpack(data):
	for ch in AudioServer.bus_count:
		change_volume(ch, data[str(ch)])
	refresh(data)
	return

func refresh(data):
	var sound_container = sound.get_children()
	var ch = 0
	for i in sound_container.size():
		if sound_container[i] is ProgressSlider:
			sound_container[i].set_val(data[str(ch)])
			ch += 1

func _on_Debug_Button_toggled(on) -> void:
	DevMode.DebugUI.switch(on)


func _on_Exit_Button_pressed() -> void:
	hide()


func change_volume(id, db):
	AudioServer.set_bus_volume_db(id, db)
	
func _on_MasterProgressSlider_value_changed(value: float) -> void:
	var sfx_index= AudioServer.get_bus_index("Master")
	value = -80.0 if value < -39 else value
	change_volume(sfx_index, value)

func _on_MusicProgressSlider_value_changed(value: float) -> void:
	var sfx_index= AudioServer.get_bus_index("Music")
	value = -80.0 if value < -39 else value
	change_volume(sfx_index, value)

func _on_SFXProgressSlider_value_changed(value: float) -> void:
	var sfx_index= AudioServer.get_bus_index("SFX")
	value = -80.0 if value < -39 else value
	change_volume(sfx_index, value)


func _on_WeatherProgressSlider_value_changed(value: float) -> void:
	var sfx_index= AudioServer.get_bus_index("Weather")
	value = -80.0 if value < -19 else value
	change_volume(sfx_index, value)


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
	if Save.delSave():
		delete_save_button.shake()
	elif Save.newGame():
		delete_save_button.shake()
	else:
		delete_save_button.shakeSide()
