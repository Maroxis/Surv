extends Control
onready var debug: VBoxContainer = $"%Debug"

onready var save_button: ToolButton = $"%SaveButton"
onready var load_button: ToolButton = $"%LoadButton"
onready var delete_save_button: TextureButton = $"%DeleteSaveButton"
onready var sound: VBoxContainer = $"%Sound"
onready var sfx_bg: NinePatchRect = $TextureRect/ScrollContainer/VBoxContainer/Sound/SFX/BG
onready var music_bg: NinePatchRect = $TextureRect/ScrollContainer/VBoxContainer/Sound/Music/BG
onready var weather_bg: NinePatchRect = $TextureRect/ScrollContainer/VBoxContainer/Sound/Weather/BG
onready var reset_tutorial_button: TextureButton = $TextureRect/ScrollContainer/VBoxContainer/TutorialData/HBoxContainer/ResetTutorialButton
onready var skip_tutorial_button: TextureButton = $TextureRect/ScrollContainer/VBoxContainer/TutorialData/HBoxContainer/SkipTutorialButton
onready var screen_button: CheckButton = $TextureRect/ScrollContainer/VBoxContainer/Display/ScreenButton

func _ready() -> void:
	debug.visible = DevMode.on
	Global.InGSettings = self
	muteAll()

func muteAll():
	setMute(1,true)
	setMute(2,true)
	setMute(3,true)
	setButton(sfx_bg,true)
	setButton(music_bg,true)
	setButton(weather_bg,true)

func pack():
	var data = {}
	for ch in AudioServer.bus_count:
		data[ch] = {}
		data[ch]["volume"] = AudioServer.get_bus_volume_db(ch)
		data[ch]["mute"] = AudioServer.is_bus_mute(ch)
	data["display"] = {}
	data["display"]["fullscreen"] = screen_button.pressed
	return data

func unpack(data):
	for ch in AudioServer.bus_count:
		change_volume(ch, data[str(ch)]["volume"])
		setMute(ch, data[str(ch)]["mute"])
	if data.has("display"):
		screen_button.pressed = data["display"]["fullscreen"]
	refresh(data)
	return

func refresh(data):
	var sound_container = sound.get_children()
	var ch = 1
	for i in sound_container.size():
		if sound_container[i] is HBoxContainer:
			sound_container[i].get_node("ProgressSlider").value = data[str(ch)]["volume"]
			ch += 1
	setButton(sfx_bg,data["1"]["mute"])
	setButton(music_bg,data["2"]["mute"])
	setButton(weather_bg,data["3"]["mute"])
	toggle_fullscreen(screen_button.pressed)

func _on_Debug_Button_toggled(on) -> void:
	DevMode.DebugUI.switch(on)

func _on_Exit_Button_pressed() -> void:
	Save.saveConfig()
	hide()

func change_volume(id, db):
	AudioServer.set_bus_volume_db(id, db)
	
func _on_MasterProgressSlider_value_changed(value: float) -> void:
	var sfx_index= AudioServer.get_bus_index("Master")
	change_volume(sfx_index, value)

func _on_MusicProgressSlider_value_changed(value: float) -> void:
	var sfx_index= AudioServer.get_bus_index("Music")
	change_volume(sfx_index, value)

func _on_SFXProgressSlider_value_changed(value: float) -> void:
	var sfx_index= AudioServer.get_bus_index("SFX")
	change_volume(sfx_index, value)


func _on_WeatherProgressSlider_value_changed(value: float) -> void:
	var sfx_index= AudioServer.get_bus_index("Weather")
	change_volume(sfx_index, value)


func _on_SaveButton_pressed() -> void:
	if Save.saveData(Save.save_file):
		save_button.shake()
	else:
		save_button.shakeSide()

func _on_LoadButton_pressed() -> void:
	if Save.loadSave(Save.save_file):
		load_button.shake()
	else:
		load_button.shakeSide()


func _on_DeleteSaveButton_pressed() -> void:
	if Save.delSave() and Save.delConfig():
		delete_save_button.shake()
	elif Save.newGame():
		delete_save_button.shake()
	else:
		delete_save_button.shakeSide()

func toggleMute(sfx_index,button):
	var muted = AudioServer.is_bus_mute(sfx_index)
	setButton(button,not muted)
	AudioServer.set_bus_mute(sfx_index, not muted)

func setButton(button,muted:bool):
	if muted:
		button.modulate = Color(1,0,0)
	else:
		button.modulate = Color8(8,255,0)

func setMute(ch,mute):
	AudioServer.set_bus_mute(ch, mute)

func _on_SFXButton_pressed() -> void:
	var sfx_index= AudioServer.get_bus_index("SFX")
	toggleMute(sfx_index,sfx_bg)

func _on_MusicButton_pressed() -> void:
	var sfx_index= AudioServer.get_bus_index("Music")
	toggleMute(sfx_index,music_bg)

func _on_WeatherButton_pressed() -> void:
	var sfx_index= AudioServer.get_bus_index("Weather")
	toggleMute(sfx_index,weather_bg)


func _on_ResetTutorialButton_pressed() -> void:
	reset_tutorial_button.shake()
	Global.Tutorial.reset()


func _on_SkipTutorialButton_pressed() -> void:
	skip_tutorial_button.shake()
	Global.Tutorial.skip_all()

func toggle_fullscreen(on, reload = false):
	if on:
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D,  SceneTree.STRETCH_ASPECT_EXPAND, Vector2(1280,720))
	else:
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D,  SceneTree.STRETCH_ASPECT_KEEP, Vector2(1280,720))
	Global.ResourcesUI.resizeQuickBar()
	if reload:
		Save.saveConfig()
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()

func _on_ScreenButton_pressed() -> void:
	toggle_fullscreen(screen_button.pressed, true)
