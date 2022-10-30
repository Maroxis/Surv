extends CanvasLayer

#onready var vx = get_viewport().size.x
#onready var cx = rect_position.x
var game = preload("res://nodes/Game.tscn")
onready var normal_save_label: Label = $CenterContainer/VBoxContainer/HBoxContainer2/Normal/DateLabel
onready var hard_save_label: Label = $CenterContainer/VBoxContainer/HBoxContainer2/Hard/DateLabel
onready var normal_bt_label: Label = $CenterContainer/VBoxContainer/HBoxContainer2/Normal/StartNormal/Label
onready var hard_bt_label: Label = $CenterContainer/VBoxContainer/HBoxContainer2/Hard/StartHard/Label
onready var leader_boards: Control = $LeaderBoards
onready var gpgs_container: GridContainer = $CenterContainer/VBoxContainer/HBoxContainer2/GPGSContainer


func _ready() -> void:
	print("debugging working")
	Global.TitleMenu = self
	var normal_save_data = Save.loadData(Save.auto_save_file)
	var hard_save_data = Save.loadData(Save.auto_hard_save_file)
	populate_save_info(normal_save_label,normal_bt_label,normal_save_data)
	populate_save_info(hard_save_label,hard_bt_label,hard_save_data)
	gpgs_autostart()
	ServiceManager.connect("signedIn",self,'toggle_gpgs',[true])
	ServiceManager.connect("signedOut",self,'toggle_gpgs',[false])

func gpgs_autostart():
	var data = Save.loadConfig()["settings"]
	if data.has("gpgs"):
		if data["gpgs"].has("autostart"):
			if ServiceManager.is_gpgs_available() and data["gpgs"]["autostart"]:
				ServiceManager.sign_in()

func toggle_gpgs(on):
	gpgs_container.toggle(on)

func populate_save_info(label,bt,data):
	if data != null:
		var date = data["date"]
		label.text = "Day " + str(date["day"]) +"\n" + Global.timeGetFullFormat(date["time"],false,true)
		bt.text = "Continue"
	else:
		label.text="New game"
		bt.text = "Start"

func _on_Quit_pressed() -> void:
	get_tree().quit()
#
#func _on_Settings_pressed() -> void:
#	settings.show()

func _on_StartNormal_pressed() -> void:
	Difficulty.current = Difficulty.Normal
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(game)

func _on_StartHard_pressed() -> void:
	Difficulty.current = Difficulty.Hard
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(game)

func _on_GPGSContainer_leaderBoardsPressed() -> void:
	leader_boards.open()
